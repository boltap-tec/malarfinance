// Domain types mirror the AppSheet sheets but are the app's own contract.
// The repository maps raw seed rows -> these types, so moving to Supabase later
// only means changing the repository, not every screen.

export type ID = string

export interface Finance {
  Finance_Name: string
  Date_Opened?: string
  No_Partners?: number
  Initial_Capital_Partner?: number
  Phone_Number?: number | string
  MD_Name?: string
}

export interface Partner {
  Partner_ID: string
  Finance_Name: string
  Partner_Name: string
  Phone_Number?: number | string
  Email_Address?: string
  Photo?: string
  Pending_Message?: string
}

export interface Customer {
  Finance_Name: string
  Customer_Name: string
  Customer_STL_NO: string
  Customer_Phone_No?: number | string
  Customer_Email?: string
  Customer_Adhar_No?: string | number
  Customer_Photo?: string
  Total_Loan_Given?: number
  Outstand_Loan?: number
  Total_Interest_Paid?: number
  Outstanding_Interest?: number
  Status?: string
}

export interface Loan {
  Finance_Name: string
  Loan_Given_Date?: string
  Loan_No: string
  Customer_STL_NO: string
  Customer_Name: string
  Customer_Phone_No?: number | string
  Customer_Email?: string
  Customer_Adhar_No?: string | number
  Loan_Amount: number
  Interest_Per_day_Per_Lakh?: number
  Interest_Per_Month_Per_Lakh?: number
  Interest_Type?: 'Per_Day' | 'Per_Month' | string
  No_Bond_Received?: number
  No_Chq_Received?: number
  Repaid_Amount?: number
  Outstand_Amount?: number
  Loan_Status?: string
  Referred_Partner?: string
  Payment_Type?: string
  Remarks?: string
  Total_Month_Days?: number
  Customer_Type?: string
  Customer_Ref?: string
  Attach1?: string
  Attach2?: string
  Photo1?: string
  Photo2?: string
}

export interface InterestRow {
  ID: string
  Finance_Name: string
  Loan_No: string
  Customer_STL_NO: string
  Customer_Name: string
  From_Date?: string
  To_Date?: string
  No_Days?: number
  Interest_Amount?: number
  Loan_Amount?: number
  Month?: string
  Description?: string
  Amount_Received?: number
  Status?: string
  Interest_Pending?: number
  Referred_Partner?: string
  Interest_Type?: string
}

export interface LedgerRow {
  Ref_ID: string
  Date_Transaction?: string
  Nature_Transaction?: string
  ID?: string
  STL_No?: string
  Loan_No?: string
  Customer_Name?: string
  Description?: string
  Receipt_Amount?: number
  Payment_Amount?: number
  Balance?: number
  Payment_Type?: string
  Finance_Name?: string
  Interest_Amount?: number
}

export interface Deposit {
  Finance_Name: string
  Deposit_Bought_Date?: string
  Deposit_No: string
  Depositer_Name: string
  Depositer_Phone_No?: number | string
  Depositer_Email?: string
  Depositer_Address?: string
  Deposit_Amount?: number
  Interest_Per_Month_Per_Lakh?: number
  Repaid_Amount?: number
  Outstand_Amount?: number
  Deposit_Status?: string
  Payment_Type?: string
  Remarks?: string
  Interest_Type?: string
  Depositer_Type?: string
  Depositer_Type_Exists?: string
}

// A loan the firm has BORROWED from another finance house (a liability).
export interface OtherFinanceLoan {
  Finance_Name: string
  Loan_Bought_Date?: string
  Loan_No: string
  Loan_bought_Finance_Name: string
  Loan_bought_Finance_Phone_No?: number | string
  Loan_bought_Finance_Email?: string
  Loan_bought_Finance_Address?: string
  Loan_Amount?: number
  Interest_Per_day_Per_Lakh?: number
  Interest_Per_Month_Per_Lakh?: number | string
  Repaid_Amount?: number
  Outstand_Amount?: number
  Loan_Status?: string
  Payment_Type?: string
  Remarks?: string
  Interest_Type?: string
  Finance_Type?: string
}

// ── Invested chit (a chit your finance JOINS at another company) ─────────────
// You pay a monthly contribution to someone else's chit; each payment is a row
// in Invested_Chit_Trans. One Invested_Chit row summarises the whole chit.
export interface InvestedChit {
  Chit_ID: string
  Chit_Invested_By?: string             // who in your finance joined (Arul / Malar …)
  Chit_Invested_Company?: string        // the company running the chit
  Chit_Invested_Company_Address?: string
  Total_Amount_Chit?: number            // the chit's full monthly pot value
  No_Months?: number
  Chit_Started_Date?: string
  No_Months_Completed?: number
  Total_Amount_Invested_Till_Now?: number
  Chit_Status?: string                  // Active | Completed
  Chit_Taken?: string                   // Yes | No — whether you've won/taken it
  Chit_Taken_Amount?: number            // amount you received when you took/won the chit
  Chit_Taken_Date?: string              // date you received the taken amount
  Chit_Name?: string
}

export interface InvestedChitTrans {
  ID: string
  Chit_ID: string
  Chit_Invested_By?: string
  Chit_Invested_Company?: string
  Chit_Invested_Company_Address?: string
  Total_Amount_Chit?: number
  No_Months?: number
  Chit_Started_Date?: string
  Month_Count?: number
  Chit_This_Month_Amount?: number       // what you paid that month
  Date?: string
  Month_Year?: string                   // label, e.g. "Nov-2024"
  Chit_Taken?: string
  Chit_Name?: string
  Paid_Date?: string
  Remarks?: string
  Chit_Status?: string
  Kind?: 'Payment' | 'Receipt'           // Payment = you paid the company; Receipt = you received the taken amount
}

// ── Chit fund (a chit your finance RUNS) ─────────────────────────────────────
// A chit is a pot: every month members contribute, one member "takes" that
// month's pot (via auction), and the firm keeps a small commission. These four
// tables mirror the AppSheet sheets. Chit money is tracked in its OWN ledger
// (ChitLedgerRow) — kept separate from the firm's Transaction_Ledger.
export interface ChitCreation {
  Chit_ID: string
  Chit_Name: string
  Chit_From_Date?: string
  Chit_To_Date?: string
  No_Members?: number
  Total_Month?: number
  Total_Amount?: number          // the full monthly pot (e.g. 5,00,000)
  Chit_Percentage?: number       // firm commission %, charged on the full pot
  Chit_Amount?: number           // pot after commission
  Total_Chit_Count?: number      // sum of member shares (a 0.5 share counts half)
  No_Month_Completed?: number
  Total_Member_Taken?: number    // shares already taken
  Finance_Name: string
  Chit_Status?: string           // Open | Closed
}

export interface ChitMember {
  Member_ID: string
  Chit_ID: string
  Chit_Name?: string
  Member_Name: string
  Member_Phone_No?: number | string
  Member_Address?: string
  Member_Photo?: string
  Date_Added?: string
  Member_Percentage?: number     // share size: 1 (full) or 0.5 (half)
  Member_Commission?: number     // this member's own commission % (used on payout when enabled in Settings)
  Recommended_Partner?: string
  Chit_Taken?: string            // Taken | Not_Taken
  Chit_Taken_Amount?: number
  Month_Taken?: string
  Total_Auction_Amount?: number
  Amount_Given?: number          // payout already given to this member
  Remaining_Amount?: number      // payout still owed to this member
  Member_Type?: string           // Member | Finance
  Finance_Name: string
  Message?: string
  Pending_Amount?: string
  Last_Receipt?: string
}

export interface ChitAuction {
  Chit_Auction_ID: string
  Chit_ID: string
  Chit_Name?: string
  Date_Auction?: string
  Month_Count?: number
  Total_Auction_Amount?: number                  // winning bid — what members pay this month
  Indivitual_Member_Amount?: number              // per full share this month
  Interest_Percentage?: number                   // auction discount vs the full pot
  Total_Auction_Amount_After_Commission?: number // payout to the taker
  Finance_Name: string
  Auction_Status?: string                        // Open | Closed
  Member_Type?: string
  Remaining?: number
}

export interface ChitTakenMember {
  Chit_Taken_ID: string
  Chit_Auction_ID: string
  Chit_ID: string
  Chit_Name?: string
  Date_Auction?: string
  Month_Count?: number
  Total_Auction_Amount?: number
  Member_ID: string
  Member_Name?: string
  Member_Type?: string
  Percentage_Need_to_Take?: number   // 1 (full pot) or 0.5 (half)
  Total_Amount_to_Member?: number    // payout owed to the taker
  Amount_Given_to_Member?: number
  Pending_Amount?: number
  Finance_Name: string
  Need_to_Take_From_Previous_Company_Chit?: string
  Amount_Taken_From_Company_Chit?: number
  Remaining_Amount_in_Company_Chit?: number
  Status?: string                    // Pending | Given
  Remarks?: string                   // optional note on the last payout
}

// One row per member per auction/month — their contribution obligation.
export interface ChitLedgerRow {
  ID: string
  Finance_Name: string
  Chit_ID: string
  Chit_Name?: string
  Chit_Auction_ID: string
  Month_Count?: number
  Date_Auction?: string
  Member_ID: string
  Member_Name?: string
  Recommended_Partner?: string
  Member_Percentage?: number
  One_Share_Amount?: number
  Due_Amount?: number
  Received_Amount?: number
  Pending_Amount?: number
  Payment_Type?: string
  Paid_Date?: string
  Status?: string                    // Paid | Partial | Pending
  Remarks?: string                   // optional note on the last collection
}

// ── Hand exchange (personal give & take — NEVER part of finance data) ────────
// A private money tracker: money you hand out or take in with people you know.
// Direction: 'out' = money left your hand, 'in' = money came to your hand.
// Net "they owe you" per person = sum(out) − sum(in).
export interface HandExchange {
  ID: string
  Date?: string
  Person: string
  Person_Phone?: number | string
  Amount: number
  Direction: 'out' | 'in'
  Type: 'Give' | 'Get' | 'Borrow' | 'Return' | string
  Mode?: string
  Note?: string
  Remarks?: string
}

export interface NatureTransaction {
  Nature_Transaction: string
  Type: 'Receipt' | 'Payment' | string
  Report?: string
}

// A staff member created by the MD, with an explicit list of menus they may use.
export interface Worker {
  Worker_ID: string
  Finance_Name: string
  Worker_Name: string
  Phone_Number: number | string
  Allowed_Menus: string[] // route paths, e.g. ['/loans','/ledger']
  Status?: string
  Created_By?: string
}

// Audit trail. Every create / update / delete / revoke is recorded here; delete
// and revoke entries keep the removed row(s) so they can be restored.
export interface LogEntry {
  id: string
  Date: string
  User: string
  Action: 'create' | 'update' | 'delete' | 'restore' | 'revoke'
  Entity: string          // dataset table key, e.g. 'Partner'
  Entity_Label?: string   // human description
  Before?: any            // snapshot(s) before the change (row, or array for revoke)
  After?: any             // snapshot after (create/update)
  Restored?: boolean      // set once a delete/revoke has been undone
}

// A message between users — a group broadcast or a direct message.
export interface Message {
  id: string
  Date: string
  From_Phone: string
  From_Name: string
  Scope: 'group' | 'direct'
  To_Phone?: string  // set for direct messages
  To_Name?: string
  Finance_Name?: string
  Body: string
}

// In-app bell notification (e.g. a new loan routed to the referred partner).
export interface AppNotification {
  id: string
  Finance_Name: string
  To_Phone: string       // recipient's phone (partner / worker / md)
  To_Party?: string      // human label of the recipient
  Title: string
  Body?: string
  Date: string
  Read?: boolean
}

export interface Dataset {
  Finance_Details: Finance[]
  Partner: Partner[]
  STL_CRM: Customer[]
  Loan_Processing: Loan[]
  Interest_Details: InterestRow[]
  Transaction_Ledger: LedgerRow[]
  Nature_Transaction: NatureTransaction[]
  Deposit_Amount: Deposit[]
  Depositer_Interest: any[]
  Invested_Chit: InvestedChit[]
  Invested_Chit_Trans: InvestedChitTrans[]
  Chit_Creation: ChitCreation[]
  Chit_Member: ChitMember[]
  Chit_Auction: ChitAuction[]
  Chit_Taken_Member: ChitTakenMember[]
  Chit_Ledger: ChitLedgerRow[]
  Other_Finance_Loan: OtherFinanceLoan[]
  Other_Finance_Interest: any[]
  Worker: Worker[]
  Notification: AppNotification[]
  Message: Message[]
  Log: LogEntry[]
  Given: any[]
  Borrowed: any[]
  Hand_Exchange: HandExchange[]
  Jewel_Loan: any[]
}
