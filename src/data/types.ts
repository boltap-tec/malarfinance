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
  Loan_Amount: number
  Interest_Per_day_Per_Lakh?: number
  Interest_Per_Month_Per_Lakh?: number
  Interest_Type?: 'Per_Day' | 'Per_Month' | string
  Repaid_Amount?: number
  Outstand_Amount?: number
  Loan_Status?: string
  Referred_Partner?: string
  Payment_Type?: string
  Remarks?: string
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
  Deposit_No: string
  Depositer_Name: string
  Depositer_Phone_No?: number | string
  Deposit_Amount?: number
  Interest_Per_Month_Per_Lakh?: number
  Repaid_Amount?: number
  Outstand_Amount?: number
  Deposit_Status?: string
  Interest_Type?: string
}

export interface NatureTransaction {
  Nature_Transaction: string
  Type: 'Receipt' | 'Payment' | string
  Report?: string
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
  Invested_Chit: any[]
  Invested_Chit_Trans: any[]
  Chit_Creation: any[]
  Chit_Member: any[]
  Chit_Auction: any[]
  Chit_Transaction: any[]
  Other_Finance_Loan: any[]
  Given: any[]
  Borrowed: any[]
  Jewel_Loan: any[]
}
