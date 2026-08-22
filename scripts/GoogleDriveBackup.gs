/**
 * Arul Finance — Daily backup of Supabase → Google Drive (runs in your Google account)
 * ----------------------------------------------------------------------------
 * Produces ONE Excel file per day (.xlsx) with one tab per table, saved into
 * your Drive folder. No server needed.
 *
 * ONE-TIME SETUP  (about 3 minutes)
 *   1. Go to  https://script.google.com  →  New project.
 *   2. Delete the sample code, paste ALL of this file, click 💾 Save.
 *   3. Fill in SUPABASE_URL and SUPABASE_ANON_KEY below
 *      (Supabase → Project Settings → API → Project URL and anon public key).
 *   4. Function dropdown → pick  backupNow  →  Run.  Approve permissions (Allow).
 *      Check your Drive folder: "Arul Finance Backup YYYY-MM-DD.xlsx" appears.
 *   5. Function dropdown → pick  createDailyTrigger  →  Run (once) to schedule it.
 *
 * Tip: if authorization shows "Error 401: invalid_client", use an Incognito
 * window signed into ONLY the account that owns the Drive folder.
 *
 * To STOP the daily backup: run  removeTriggers  once.
 */

// ===== CONFIG — EDIT THE FIRST TWO ==========================================
var SUPABASE_URL      = 'https://YOUR-PROJECT-ref.supabase.co'; // VITE_SUPABASE_URL
var SUPABASE_ANON_KEY = 'YOUR-ANON-KEY';                        // VITE_SUPABASE_ANON_KEY
var DRIVE_FOLDER_ID   = '1WzovmeJLP_RxKqXuEVF4e4jAAJ3NFxJF';    // your backup folder
var KEEP_DAYS         = 30;   // delete backup files older than this (0 = keep all)
// ============================================================================

var TABLES = [
  'Finance_Details', 'Partner', 'STL_CRM', 'Loan_Processing', 'Interest_Details',
  'Transaction_Ledger', 'Nature_Transaction', 'Deposit_Amount', 'Depositer_Interest',
  'Other_Finance_Loan', 'Other_Finance_Interest', 'Invested_Chit', 'Invested_Chit_Trans',
  'Chit_Creation', 'Chit_Member', 'Chit_Auction', 'Chit_Taken_Member', 'Chit_Ledger',
  'Worker', 'Notification', 'Message', 'Log', 'Given', 'Borrowed', 'Hand_Exchange', 'Jewel_Loan'
];
var PAGE = 1000;
var MAX_CELL = 32000; // Excel's per-cell limit is ~32767

function backupNow()   { return runBackup_(); }   // run once to test
function dailyBackup() { return runBackup_(); }   // scheduled entry point

function runBackup_() {
  if (SUPABASE_URL.indexOf('YOUR-PROJECT') !== -1 || SUPABASE_ANON_KEY.indexOf('YOUR-ANON') !== -1) {
    throw new Error('Fill in SUPABASE_URL and SUPABASE_ANON_KEY at the top first.');
  }
  var parent = DriveApp.getFolderById(DRIVE_FOLDER_ID);
  var day = Utilities.formatDate(new Date(), Session.getScriptTimeZone(), 'yyyy-MM-dd');

  // Build one temporary Google Sheet with a tab per table…
  var ss = SpreadsheetApp.create('Arul Finance Backup ' + day + ' (temp)');
  var first = true, summary = [];
  for (var i = 0; i < TABLES.length; i++) {
    var t = TABLES[i];
    var sheet = first ? ss.getSheets()[0].setName(sheetName_(t)) : ss.insertSheet(sheetName_(t));
    first = false;
    try {
      var rows = fetchAll_(t);
      writeSheet_(sheet, rows);
      summary.push(t + ': ' + rows.length + ' rows');
    } catch (e) {
      sheet.getRange(1, 1).setValue('ERROR: ' + e);
      summary.push(t + ': ERROR — ' + e);
    }
  }
  SpreadsheetApp.flush();

  // …then export the whole thing as a single .xlsx into your folder.
  var id = ss.getId();
  var url = 'https://docs.google.com/spreadsheets/d/' + id + '/export?format=xlsx';
  var blob = UrlFetchApp.fetch(url, {
    headers: { 'Authorization': 'Bearer ' + ScriptApp.getOAuthToken() },
    muteHttpExceptions: true
  }).getBlob().setName('Arul Finance Backup ' + day + '.xlsx');
  parent.createFile(blob);

  DriveApp.getFileById(id).setTrashed(true); // remove the temporary Google Sheet
  if (KEEP_DAYS > 0) pruneOldFiles_(parent, KEEP_DAYS);
  Logger.log('Backup complete:\n' + summary.join('\n'));
  return summary.join('\n');
}

/** Fetch every row of a table, paging with the Range header. */
function fetchAll_(table) {
  var out = [], from = 0;
  while (true) {
    var to = from + PAGE - 1;
    var url = SUPABASE_URL.replace(/\/+$/, '') + '/rest/v1/' + encodeURIComponent(table) + '?select=*';
    var res = UrlFetchApp.fetch(url, {
      method: 'get', muteHttpExceptions: true,
      headers: { 'apikey': SUPABASE_ANON_KEY, 'Authorization': 'Bearer ' + SUPABASE_ANON_KEY,
                 'Range-Unit': 'items', 'Range': from + '-' + to }
    });
    var code = res.getResponseCode();
    if (code === 416) break;
    if (code === 404) throw new Error('table not found (404)');
    if (code >= 400) throw new Error('HTTP ' + code + ': ' + res.getContentText().slice(0, 300));
    var batch = JSON.parse(res.getContentText() || '[]');
    for (var j = 0; j < batch.length; j++) out.push(batch[j]);
    if (batch.length < PAGE) break;
    from += PAGE;
  }
  return out;
}

/** Write rows into a sheet: header row (union of keys) + one row each. */
function writeSheet_(sheet, rows) {
  if (!rows || rows.length === 0) { sheet.getRange(1, 1).setValue('(no rows)'); return; }
  var seen = {}, cols = [];
  for (var i = 0; i < rows.length; i++) for (var k in rows[i]) if (!seen[k]) { seen[k] = true; cols.push(k); }
  var data = [cols];
  for (var r = 0; r < rows.length; r++) {
    var line = [];
    for (var c = 0; c < cols.length; c++) line.push(cell_(rows[r][cols[c]]));
    data.push(line);
  }
  sheet.getRange(1, 1, data.length, cols.length).setValues(data);
  sheet.setFrozenRows(1);
}

/** A safe cell value: keep numbers/booleans, stringify objects, cap length. */
function cell_(v) {
  if (v === null || v === undefined) return '';
  if (typeof v === 'number' || typeof v === 'boolean') return v;
  if (typeof v === 'object') v = JSON.stringify(v);
  v = String(v);
  return v.length > MAX_CELL ? v.slice(0, MAX_CELL) : v;
}

/** Excel-safe, unique-ish tab name (≤100 chars, no : \ / ? * [ ]). */
function sheetName_(name) {
  return String(name).replace(/[:\\\/?*\[\]]/g, '_').slice(0, 100);
}

/** Trash backup .xlsx files older than keepDays. */
function pruneOldFiles_(parent, keepDays) {
  var cutoff = new Date(); cutoff.setDate(cutoff.getDate() - keepDays);
  var it = parent.getFiles();
  while (it.hasNext()) {
    var f = it.next();
    if (f.getName().indexOf('Arul Finance Backup ') === 0 && f.getName().indexOf('.xlsx') !== -1 && f.getDateCreated() < cutoff) {
      f.setTrashed(true);
    }
  }
}

/** Run ONCE to schedule the daily automatic backup (~1 AM). */
function createDailyTrigger() {
  removeTriggers();
  ScriptApp.newTrigger('dailyBackup').timeBased().everyDays(1).atHour(1).create();
  Logger.log('Daily backup scheduled for ~1 AM every day.');
}

/** Remove the daily trigger(s). */
function removeTriggers() {
  var t = ScriptApp.getProjectTriggers();
  for (var i = 0; i < t.length; i++) if (t[i].getHandlerFunction() === 'dailyBackup') ScriptApp.deleteTrigger(t[i]);
}
