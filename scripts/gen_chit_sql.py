"""Generate supabase/chit_data.sql — create + populate ONLY the chit tables from
src/data/seed.json (which was derived from the AppSheet Excel export), plus
read/write policies so the app can read and edit them.

Paste the output into Supabase → SQL Editor → Run. Safe to re-run (drops &
recreates only the chit tables; every other table is left untouched).
"""
import io, json, os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CHIT_TABLES = ['Chit_Creation', 'Chit_Member', 'Chit_Auction', 'Chit_Taken_Member', 'Chit_Ledger']

with io.open(os.path.join(ROOT, 'src', 'data', 'seed.json'), encoding='utf-8') as f:
    data = json.load(f)


def col_type(vals):
    seen = False
    for v in vals:
        if v is None:
            continue
        seen = True
        if isinstance(v, bool) or not isinstance(v, (int, float)):
            return 'text'
    return 'numeric' if seen else 'text'


def sql_val(v, typ):
    if v is None or v == '':
        return 'NULL'
    if typ == 'numeric':
        try:
            return str(int(v)) if isinstance(v, int) else str(float(v))
        except Exception:
            return 'NULL'
    return "'" + str(v).replace("'", "''") + "'"


out = [
    "-- Malar Finance — chit fund data (from the AppSheet Excel export).",
    "-- Paste into Supabase → SQL Editor → Run. Safe to re-run.",
    "-- Only the 5 chit tables are touched; all other tables are left alone.",
    "",
]

for table in CHIT_TABLES:
    rows = data.get(table, [])
    keys = []
    for r in rows:
        for k in r.keys():
            if k not in keys:
                keys.append(k)
    if not keys:
        keys = ['id']
    types = {k: col_type([r.get(k) for r in rows]) for k in keys}

    out.append(f'drop table if exists "{table}" cascade;')
    cols = ", ".join(f'"{k}" {types[k]}' for k in keys)
    out.append(f'create table "{table}" ({cols});')

    if rows:
        collist = ", ".join(f'"{k}"' for k in keys)
        BATCH = 100
        for i in range(0, len(rows), BATCH):
            chunk = rows[i:i + BATCH]
            vals = ["(" + ", ".join(sql_val(r.get(k), types[k]) for k in keys) + ")" for r in chunk]
            out.append(f'insert into "{table}" ({collist}) values\n' + ",\n".join(vals) + ";")

    # Read + write policies so the app can read and edit these rows.
    out.append(f'alter table "{table}" enable row level security;')
    out.append(f'drop policy if exists "app_read" on "{table}";')
    out.append(f'create policy "app_read" on "{table}" for select using (true);')
    out.append(f'drop policy if exists "app_write" on "{table}";')
    out.append(f'create policy "app_write" on "{table}" for all using (true) with check (true);')
    out.append("")

sql = "\n".join(out)
with io.open(os.path.join(ROOT, 'supabase', 'chit_data.sql'), 'w', encoding='utf-8') as f:
    f.write(sql)

print('Wrote supabase/chit_data.sql:', len(sql), 'bytes')
for t in CHIT_TABLES:
    print(f'  {t}: {len(data.get(t, []))} rows')
