-- Malar Finance — chit fund data (from the AppSheet Excel export).
-- Paste into Supabase → SQL Editor → Run. Safe to re-run.
-- Only the 5 chit tables are touched; all other tables are left alone.

drop table if exists "Chit_Creation" cascade;
create table "Chit_Creation" ("Chit_ID" text, "Chit_Name" text, "Chit_From_Date" text, "Chit_To_Date" text, "No_Members" numeric, "Total_Month" numeric, "Total_Amount" numeric, "Chit_Percentage" numeric, "Chit_Amount" numeric, "Total_Chit_Count" numeric, "No_Month_Completed" numeric, "Total_Member_Taken" numeric, "Finance_Name" text, "Chit_Status" text);
insert into "Chit_Creation" ("Chit_ID", "Chit_Name", "Chit_From_Date", "Chit_To_Date", "No_Members", "Total_Month", "Total_Amount", "Chit_Percentage", "Chit_Amount", "Total_Chit_Count", "No_Month_Completed", "Total_Member_Taken", "Finance_Name", "Chit_Status") values
('Chit_A1', 'A', '2026-03-10', '2026-03-10', 25, 20, 500000, 3, 485000, 22.5, 6, 5.5, 'Chit_Malar', 'Open');
alter table "Chit_Creation" enable row level security;
drop policy if exists "app_read" on "Chit_Creation";
create policy "app_read" on "Chit_Creation" for select using (true);
drop policy if exists "app_write" on "Chit_Creation";
create policy "app_write" on "Chit_Creation" for all using (true) with check (true);

drop table if exists "Chit_Member" cascade;
create table "Chit_Member" ("Chit_Name" text, "Member_ID" text, "Member_Name" text, "Member_Phone_No" numeric, "Member_Address" text, "Member_Photo" text, "Date_Added" text, "Member_Percentage" numeric, "Recommended_Partner" text, "Chit_Taken" text, "Chit_Taken_Amount" numeric, "Month_Taken" text, "Total_Auction_Amount" numeric, "Amount_Given" numeric, "Remaining_Amount" numeric, "Member_Type" text, "Chit_ID" text, "Finance_Name" text, "Message" text, "Pending_Amount" text, "Last_Receipt" text);
insert into "Chit_Member" ("Chit_Name", "Member_ID", "Member_Name", "Member_Phone_No", "Member_Address", "Member_Photo", "Date_Added", "Member_Percentage", "Recommended_Partner", "Chit_Taken", "Chit_Taken_Amount", "Month_Taken", "Total_Auction_Amount", "Amount_Given", "Remaining_Amount", "Member_Type", "Chit_ID", "Finance_Name", "Message", "Pending_Amount", "Last_Receipt") values
('A', 'Chit_A1_M1_Arul', 'Arul', 9626262427, 'Vangapalayam, Tamil Nadu 639006, India', NULL, '2026-03-10', 0.5, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Arul
ID : Chit_A1_M1_Arul

Total Pending: Rs.20612.5
Month 5 - Pending Rs. 10250
Month 6 - Pending Rs. 10362.5
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 12500 - Cash - '),
('A', 'Chit_A1_M2_Malarvizhi', 'Malarvizhi', 8300148034, 'Vangapalayam, Tamil Nadu 639006, India', NULL, '2026-03-10', 0.5, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Malarvizhi
ID : Chit_A1_M2_Malarvizhi

Total Pending: Rs.10362.5
Month 6 - Pending Rs. 10362.5
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 12500 - UPI - through gpay'),
('A', 'Chit_A1_M3_Muthusamy', 'Muthusamy', 9751712177, 'Vangapalayam, Tamil Nadu 639006, India', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Muthusamy
ID : Chit_A1_M3_Muthusamy

Total Pending: Rs.22975
Month 5 - Pending Rs. 2250
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Cash - '),
('A', 'Chit_A1_M4_Surrendar', 'Surrendar', 9043436792, 'Puthur, Tamil Nadu 621313, India', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Surrendar
ID : Chit_A1_M4_Surrendar

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Account - Icici'),
('A', 'Chit_A1_M5_Kavi_Surrendar', 'Kavi_Surrendar', 9043436792, 'Manmangalam To N Pudur Rd, Tamil Nadu, India', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Kavi_Surrendar
ID : Chit_A1_M5_Kavi_Surrendar

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Account - Icici'),
('A', 'Chit_A1_M6_Amuthavel', 'Amuthavel', 7373731825, 'Vangapalayam, Tamil Nadu 639006, India', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Amuthavel
ID : Chit_A1_M6_Amuthavel

Total Pending: Rs.0
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 6120 - UPI - '),
('A', 'Chit_A1_M7_Palanisamy', 'Palanisamy', 7010457994, 'Kuppuchipalayam, Tamil Nadu 639116, India', NULL, '2026-03-10', 1, 'Malar', 'Taken', 389000, '2026-03-10', 389000, 0, 389000, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Palanisamy
ID : Chit_A1_M7_Palanisamy

Total Pending: Rs.0
Chit Status : Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 18000 - UPI - '),
('A', 'Chit_A1_M8_Tharun', 'Tharun', 9843722055, 'Manmangalam, Tamil Nadu 639006, India', NULL, '2026-03-10', 1, 'Malar', 'Taken', 395000, '2026-03-10', 395000, 0, 395000, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Tharun
ID : Chit_A1_M8_Tharun

Total Pending: Rs.16225
Month 6 - Pending Rs. 16225
Chit Status : Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Cash - '),
('A', 'Chit_A1_M9_Dinesh_Muthusamy', 'Dinesh_Muthusamy', 9790632119, 'Vangapalayam, Tamil Nadu 639006, India', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Dinesh_Muthusamy
ID : Chit_A1_M9_Dinesh_Muthusamy

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - UPI - '),
('A', 'Chit_A1_M10_Gopal', 'Gopal', 8838723676, 'Karur, Tamil Nadu 639001, India', NULL, '2026-03-10', 0.5, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Gopal
ID : Chit_A1_M10_Gopal

Total Pending: Rs.0
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 12500 - UPI - Ippb'),
('A', 'Chit_A1_M11_Kannan', 'Kannan', 9976592192, 'Karur', NULL, '2026-03-10', 0.5, 'Malar', 'Taken', 199750, '2026-03-10', 199750, 0, 199750, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Kannan
ID : Chit_A1_M11_Kannan

Total Pending: Rs.0
Chit Status : Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 12500 - Other - adjusted to ramkumar chit amount'),
('A', 'Chit_A1_M12_Dinesh_Thangavel', 'Dinesh_Thangavel', 8973440117, 'Karur, Tamil Nadu, India', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Dinesh_Thangavel
ID : Chit_A1_M12_Dinesh_Thangavel

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - UPI - Saranya'),
('A', 'Chit_A1_M13_Arasakumar', 'Arasakumar', 9842817050, 'Kallipalayam, Tamil Nadu 637208, India', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Arasakumar
ID : Chit_A1_M13_Arasakumar

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Cash - '),
('A', 'Chit_A1_M14_Baskar', 'Baskar', 9842817050, 'Arasakumar relation, Kallipalayam, Karur', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Baskar
ID : Chit_A1_M14_Baskar

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Cash - '),
('A', 'Chit_A1_M15_Gopalsamy', 'Gopalsamy', 9842817050, 'Arasakumar relation, Kallipalayam, Karur', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Gopalsamy
ID : Chit_A1_M15_Gopalsamy

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Cash - '),
('A', 'Chit_A1_M16_Sathyadevi', 'Sathyadevi', 9894225666, 'Post office, Karur HO', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Sathyadevi
ID : Chit_A1_M16_Sathyadevi

Total Pending: Rs.0
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Cash - '),
('A', 'Chit_A1_M17_Arun Prakash', 'Arun Prakash', 9944396079, 'Manager IPPB', NULL, '2026-03-10', 1, 'Malar', 'Taken', 382000, '2026-03-10', 382000, 0, 382000, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Arun Prakash
ID : Chit_A1_M17_Arun Prakash

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - UPI - 25000 chit+4900 3rd emi due-11000 already given me. Remaining  18900 paid'),
('A', 'Chit_A1_M18_Deepak', 'Deepak', 9042751673, 'Post Office, Karur', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Deepak
ID : Chit_A1_M18_Deepak

Total Pending: Rs.0
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 10000 - Cash - '),
('A', 'Chit_A1_M19_Nagaraj', 'Nagaraj', 9943032899, 'Printer service, Servan Infotech, Karur', NULL, '2026-03-10', 1, 'Malar', 'Not_Taken', 0, '2026-03-10', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Nagaraj
ID : Chit_A1_M19_Nagaraj

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 15000 - UPI - through gpay'),
('A', 'Chit_A1_M20_Rajesh', 'Rajesh', 9994922299, 'Post Office, Mayanur, Karur', NULL, '2026-03-10', 1, 'Malar', 'Taken', 389000, '2026-03-10', 389000, 0, 389000, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Rajesh
ID : Chit_A1_M20_Rajesh

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - UPI - '),
('A', 'Chit_A1_M21_Finance_Chit', 'Finance_Chit', 8300148034, 'Malar Chit, Karur', NULL, '2026-03-10', 1, 'Malar', 'Taken', 500000, '2026-03-10', 500000, 0, 500000, 'Finance', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Finance_Chit
ID : Chit_A1_M21_Finance_Chit

Total Pending: Rs.61425
Month 4 - Pending Rs. 20200
Month 5 - Pending Rs. 20500
Month 6 - Pending Rs. 20725
Chit Status : Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Other - '),
('A', 'Chit_A1_M22_Vikas', 'Vikas', 9566251257, 'Ippb manager, chennai', NULL, '2026-03-14', 1, 'Malar', 'Not_Taken', 0, '2026-03-14', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Vikas
ID : Chit_A1_M22_Vikas

Total Pending: Rs.20725
Month 6 - Pending Rs. 20725
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Other - adjusted in chandrasekaran amount 30000'),
('A', 'Chit_A1_M23_Mohan', 'Mohan', 9976775159, 'Kumarasamy college', NULL, '2026-03-14', 0.5, 'Malar', 'Not_Taken', 0, '2026-03-14', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Mohan
ID : Chit_A1_M23_Mohan

Total Pending: Rs.0
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 12500 - UPI - through malar gpay'),
('A', 'Chit_A1_M24_Valarmathi', 'Valarmathi', 9944947304, 'PA, Karur HO, Sukkaliyur, Karur', NULL, '2026-03-17', 1, 'Malar', 'Not_Taken', 0, '2026-03-17', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Valarmathi
ID : Chit_A1_M24_Valarmathi

Total Pending: Rs.0
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - Other - Through Chandru annan'),
('A', 'Chit_A1_M25_Kaviyarasu', 'Kaviyarasu', 9629998999, 'Vangapalayam, Karur', 'Chit_Member_Images/Chit_A1_M25_Kaviyarasu.Member_Photo.141027.jpg', '2026-03-18', 1, 'Malar', 'Not_Taken', 0, '2026-03-18', 0, 0, 0, 'Member', 'Chit_A1', 'Chit_Malar', NULL, 'Chit Details:

Name : Kaviyarasu
ID : Chit_A1_M25_Kaviyarasu

Total Pending: Rs.0
Chit Status : Not_Taken
Chit Completed Month : 6


Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 25000 - UPI - ');
alter table "Chit_Member" enable row level security;
drop policy if exists "app_read" on "Chit_Member";
create policy "app_read" on "Chit_Member" for select using (true);
drop policy if exists "app_write" on "Chit_Member";
create policy "app_write" on "Chit_Member" for all using (true) with check (true);

drop table if exists "Chit_Auction" cascade;
create table "Chit_Auction" ("Chit_Auction_ID" text, "Chit_Name" text, "Date_Auction" text, "Month_Count" numeric, "Total_Auction_Amount" numeric, "Indivitual_Member_Amount" numeric, "Interest_Percentage" numeric, "Total_Auction_Amount_After_Commission" numeric, "Chit_ID" text, "Finance_Name" text, "Auction_Status" text, "Member_Type" text, "Remaining" numeric, "Update" text);
insert into "Chit_Auction" ("Chit_Auction_ID", "Chit_Name", "Date_Auction", "Month_Count", "Total_Auction_Amount", "Indivitual_Member_Amount", "Interest_Percentage", "Total_Auction_Amount_After_Commission", "Chit_ID", "Finance_Name", "Auction_Status", "Member_Type", "Remaining", "Update") values
('Chit_A1_Auction_1', 'A', '2026-03-10', 1, 500000, 25000, 0, 500000, 'Chit_A1', 'Chit_Malar', 'Closed', 'Finance', 0, NULL),
('Chit_A1_Auction_2', 'A', '2026-04-10', 2, 397000, 19850, 1, 382000, 'Chit_A1', 'Chit_Malar', 'Closed', 'Other', 0, NULL),
('Chit_A1_Auction_3', 'A', '2026-05-09', 3, 399800, 19990, 1, 384800, 'Chit_A1', 'Chit_Malar', 'Closed', 'Other', 0, NULL),
('Chit_A1_Auction_4', 'A', '2026-06-10', 4, 404000, 20200, 1, 389000, 'Chit_A1', 'Chit_Malar', 'Closed', 'Other', 0, NULL),
('Chit_A1_Auction_5', 'A', '2026-07-10', 5, 410000, 20500, 1, 395000, 'Chit_A1', 'Chit_Malar', 'Closed', 'Other', 0, NULL),
('Chit_A1_Auction_6', 'A', '2026-08-10', 6, 414500, 20725, 1, 399500, 'Chit_A1', 'Chit_Malar', 'Closed', 'Other', 0, NULL);
alter table "Chit_Auction" enable row level security;
drop policy if exists "app_read" on "Chit_Auction";
create policy "app_read" on "Chit_Auction" for select using (true);
drop policy if exists "app_write" on "Chit_Auction";
create policy "app_write" on "Chit_Auction" for all using (true) with check (true);

drop table if exists "Chit_Taken_Member" cascade;
create table "Chit_Taken_Member" ("Chit_Taken_ID" text, "Chit_Auction_ID" text, "Chit_ID" text, "Chit_Name" text, "Date_Auction" text, "Month_Count" numeric, "Total_Auction_Amount" numeric, "Member_ID" text, "Member_Name" text, "Member_Type" text, "Percentage_Need_to_Take" numeric, "Total_Amount_to_Member" numeric, "Amount_Given_to_Member" numeric, "Pending_Amount" numeric, "Finance_Name" text, "Need_to_Take_From_Previous_Company_Chit" text, "Amount_Taken_From_Company_Chit" numeric, "Remaining_Amount_in_Company_Chit" numeric, "Status" text);
insert into "Chit_Taken_Member" ("Chit_Taken_ID", "Chit_Auction_ID", "Chit_ID", "Chit_Name", "Date_Auction", "Month_Count", "Total_Auction_Amount", "Member_ID", "Member_Name", "Member_Type", "Percentage_Need_to_Take", "Total_Amount_to_Member", "Amount_Given_to_Member", "Pending_Amount", "Finance_Name", "Need_to_Take_From_Previous_Company_Chit", "Amount_Taken_From_Company_Chit", "Remaining_Amount_in_Company_Chit", "Status") values
('Chit_A1_Auction_1_M1', 'Chit_A1_Auction_1', 'Chit_A1', 'A', '2026-03-10', 1, 500000.0, 'Chit_A1_M21_Finance_Chit', 'Finance_Chit', 'Finance', 1, 500000.0, 0.0, 500000.0, 'Chit_Malar', 'No', 0.0, 0.0, 'Pending'),
('Chit_A1_Auction_2_M1', 'Chit_A1_Auction_2', 'Chit_A1', 'A', '2026-04-10', 2, 382000.0, 'Chit_A1_M17_Arun Prakash', 'Arun Prakash', 'Member', 1, 382000.0, 0.0, 382000.0, 'Chit_Malar', 'No', 0.0, 0.0, 'Pending'),
('Chit_A1_Auction_3_M1', 'Chit_A1_Auction_3', 'Chit_A1', 'A', '2026-05-09', 3, 384800.0, 'Company_Chit', 'Company Chit', 'Company_Chit', 1, 384800.0, 0.0, 384800.0, 'Chit_Malar', 'No', 0.0, 384800.0, 'Pending'),
('Chit_A1_Auction_4_M1', 'Chit_A1_Auction_4', 'Chit_A1', 'A', '2026-06-10', 4, 389000.0, 'Chit_A1_M7_Palanisamy', 'Palanisamy', 'Member', 1, 389000.0, 0.0, 389000.0, 'Chit_Malar', 'No', 0.0, 384800.0, 'Pending'),
('Chit_A1_Auction_4_M2', 'Chit_A1_Auction_4', 'Chit_A1', 'A', '2026-06-10', 4, 389000.0, 'Chit_A1_M20_Rajesh', 'Rajesh', 'Member', 1, 389000.0, 0.0, 389000.0, 'Chit_Malar', 'Yes', 384800.0, 0.0, 'Pending'),
('Chit_A1_Auction_5_M1', 'Chit_A1_Auction_5', 'Chit_A1', 'A', '2026-07-10', 5, 395000.0, 'Chit_A1_M8_Tharun', 'Tharun', 'Member', 1, 395000.0, 0.0, 395000.0, 'Chit_Malar', 'No', 0.0, 384800.0, 'Pending'),
('Chit_A1_Auction_6_M1', 'Chit_A1_Auction_6', 'Chit_A1', 'A', '2026-08-10', 6, 399500.0, 'Chit_A1_M11_Kannan', 'Kannan', 'Member', 0.5, 199750.0, 0.0, 199750.0, 'Chit_Malar', 'No', 0.0, 384800.0, 'Pending'),
('Chit_A1_Auction_6_M2', 'Chit_A1_Auction_6', 'Chit_A1', 'A', '2026-08-10', 6, 399500.0, 'Company_Chit', 'Company Chit', 'Company_Chit', 0.5, 199750.0, 0.0, 199750.0, 'Chit_Malar', 'No', 0.0, 584550.0, 'Pending');
alter table "Chit_Taken_Member" enable row level security;
drop policy if exists "app_read" on "Chit_Taken_Member";
create policy "app_read" on "Chit_Taken_Member" for select using (true);
drop policy if exists "app_write" on "Chit_Taken_Member";
create policy "app_write" on "Chit_Taken_Member" for all using (true) with check (true);

drop table if exists "Chit_Ledger" cascade;
create table "Chit_Ledger" ("ID" text, "Finance_Name" text, "Chit_ID" text, "Chit_Name" text, "Chit_Auction_ID" text, "Month_Count" numeric, "Date_Auction" text, "Member_ID" text, "Member_Name" text, "Recommended_Partner" text, "Member_Percentage" numeric, "One_Share_Amount" numeric, "Due_Amount" numeric, "Received_Amount" numeric, "Pending_Amount" numeric, "Payment_Type" text, "Paid_Date" text, "Status" text);
insert into "Chit_Ledger" ("ID", "Finance_Name", "Chit_ID", "Chit_Name", "Chit_Auction_ID", "Month_Count", "Date_Auction", "Member_ID", "Member_Name", "Recommended_Partner", "Member_Percentage", "One_Share_Amount", "Due_Amount", "Received_Amount", "Pending_Amount", "Payment_Type", "Paid_Date", "Status") values
('Chit_A1_M1_Arul_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M1_Arul', 'Arul', 'Malar', 0.5, 25000, 12500.0, 12500.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M2_Malarvizhi', 'Malarvizhi', 'Malar', 0.5, 25000, 12500.0, 12500.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M3_Muthusamy', 'Muthusamy', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M4_Surrendar_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M4_Surrendar', 'Surrendar', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M5_Kavi_Surrendar', 'Kavi_Surrendar', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M6_Amuthavel', 'Amuthavel', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M7_Palanisamy', 'Palanisamy', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M8_Tharun_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M8_Tharun', 'Tharun', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M9_Dinesh_Muthusamy', 'Dinesh_Muthusamy', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M10_Gopal', 'Gopal', 'Malar', 0.5, 25000, 12500.0, 12500.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M11_Kannan_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M11_Kannan', 'Kannan', 'Malar', 0.5, 25000, 12500.0, 12500.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M12_Dinesh_Thangavel', 'Dinesh_Thangavel', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M13_Arasakumar_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M13_Arasakumar', 'Arasakumar', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M14_Baskar_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M14_Baskar', 'Baskar', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M15_Gopalsamy', 'Gopalsamy', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M16_Sathyadevi', 'Sathyadevi', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M17_Arun Prakash_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M17_Arun Prakash', 'Arun Prakash', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M18_Deepak', 'Deepak', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M19_Nagaraj', 'Nagaraj', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M20_Rajesh', 'Rajesh', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M21_Finance_Chit_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M21_Finance_Chit', 'Finance_Chit', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M22_Vikas', 'Vikas', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M23_Mohan_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M23_Mohan', 'Mohan', 'Malar', 0.5, 25000, 12500.0, 12500.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M24_Valarmathi', 'Valarmathi', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_1', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_1', 1, '2026-03-10', 'Chit_A1_M25_Kaviyarasu', 'Kaviyarasu', 'Malar', 1, 25000, 25000.0, 25000.0, 0.0, 'Cash', '2026-03-10', 'Paid'),
('Chit_A1_M1_Arul_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M1_Arul', 'Arul', 'Malar', 0.5, 19850, 9925.0, 9925.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M2_Malarvizhi', 'Malarvizhi', 'Malar', 0.5, 19850, 9925.0, 9925.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M3_Muthusamy', 'Muthusamy', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M4_Surrendar_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M4_Surrendar', 'Surrendar', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M5_Kavi_Surrendar', 'Kavi_Surrendar', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M6_Amuthavel', 'Amuthavel', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M7_Palanisamy', 'Palanisamy', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M8_Tharun_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M8_Tharun', 'Tharun', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M9_Dinesh_Muthusamy', 'Dinesh_Muthusamy', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M10_Gopal', 'Gopal', 'Malar', 0.5, 19850, 9925.0, 9925.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M11_Kannan_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M11_Kannan', 'Kannan', 'Malar', 0.5, 19850, 9925.0, 9925.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M12_Dinesh_Thangavel', 'Dinesh_Thangavel', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M13_Arasakumar_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M13_Arasakumar', 'Arasakumar', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M14_Baskar_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M14_Baskar', 'Baskar', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M15_Gopalsamy', 'Gopalsamy', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M16_Sathyadevi', 'Sathyadevi', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M17_Arun Prakash_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M17_Arun Prakash', 'Arun Prakash', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M18_Deepak', 'Deepak', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M19_Nagaraj', 'Nagaraj', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M20_Rajesh', 'Rajesh', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M21_Finance_Chit_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M21_Finance_Chit', 'Finance_Chit', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M22_Vikas', 'Vikas', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M23_Mohan_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M23_Mohan', 'Mohan', 'Malar', 0.5, 19850, 9925.0, 9925.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M24_Valarmathi', 'Valarmathi', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_2', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_2', 2, '2026-04-10', 'Chit_A1_M25_Kaviyarasu', 'Kaviyarasu', 'Malar', 1, 19850, 19850.0, 19850.0, 0.0, 'Cash', '2026-04-10', 'Paid'),
('Chit_A1_M1_Arul_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M1_Arul', 'Arul', 'Malar', 0.5, 19990, 9995.0, 9995.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M2_Malarvizhi', 'Malarvizhi', 'Malar', 0.5, 19990, 9995.0, 9995.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M3_Muthusamy', 'Muthusamy', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M4_Surrendar_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M4_Surrendar', 'Surrendar', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M5_Kavi_Surrendar', 'Kavi_Surrendar', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M6_Amuthavel', 'Amuthavel', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M7_Palanisamy', 'Palanisamy', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M8_Tharun_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M8_Tharun', 'Tharun', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M9_Dinesh_Muthusamy', 'Dinesh_Muthusamy', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M10_Gopal', 'Gopal', 'Malar', 0.5, 19990, 9995.0, 9995.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M11_Kannan_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M11_Kannan', 'Kannan', 'Malar', 0.5, 19990, 9995.0, 9995.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M12_Dinesh_Thangavel', 'Dinesh_Thangavel', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M13_Arasakumar_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M13_Arasakumar', 'Arasakumar', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M14_Baskar_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M14_Baskar', 'Baskar', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M15_Gopalsamy', 'Gopalsamy', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M16_Sathyadevi', 'Sathyadevi', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M17_Arun Prakash_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M17_Arun Prakash', 'Arun Prakash', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M18_Deepak', 'Deepak', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M19_Nagaraj', 'Nagaraj', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M20_Rajesh', 'Rajesh', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M21_Finance_Chit_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M21_Finance_Chit', 'Finance_Chit', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M22_Vikas', 'Vikas', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M23_Mohan_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M23_Mohan', 'Mohan', 'Malar', 0.5, 19990, 9995.0, 9995.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M24_Valarmathi', 'Valarmathi', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_3', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_3', 3, '2026-05-09', 'Chit_A1_M25_Kaviyarasu', 'Kaviyarasu', 'Malar', 1, 19990, 19990.0, 19990.0, 0.0, 'Cash', '2026-05-09', 'Paid'),
('Chit_A1_M1_Arul_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M1_Arul', 'Arul', 'Malar', 0.5, 20200, 10100.0, 10100.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M2_Malarvizhi', 'Malarvizhi', 'Malar', 0.5, 20200, 10100.0, 10100.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M3_Muthusamy', 'Muthusamy', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M4_Surrendar_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M4_Surrendar', 'Surrendar', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M5_Kavi_Surrendar', 'Kavi_Surrendar', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M6_Amuthavel', 'Amuthavel', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M7_Palanisamy', 'Palanisamy', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M8_Tharun_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M8_Tharun', 'Tharun', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M9_Dinesh_Muthusamy', 'Dinesh_Muthusamy', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M10_Gopal', 'Gopal', 'Malar', 0.5, 20200, 10100.0, 10100.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M11_Kannan_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M11_Kannan', 'Kannan', 'Malar', 0.5, 20200, 10100.0, 10100.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M12_Dinesh_Thangavel', 'Dinesh_Thangavel', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M13_Arasakumar_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M13_Arasakumar', 'Arasakumar', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M14_Baskar_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M14_Baskar', 'Baskar', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M15_Gopalsamy', 'Gopalsamy', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M16_Sathyadevi', 'Sathyadevi', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M17_Arun Prakash_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M17_Arun Prakash', 'Arun Prakash', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M18_Deepak', 'Deepak', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M19_Nagaraj', 'Nagaraj', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M20_Rajesh', 'Rajesh', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M21_Finance_Chit_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M21_Finance_Chit', 'Finance_Chit', 'Malar', 1, 20200, 20200.0, 0.0, 20200.0, NULL, NULL, 'Pending'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M22_Vikas', 'Vikas', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M23_Mohan_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M23_Mohan', 'Mohan', 'Malar', 0.5, 20200, 10100.0, 10100.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M24_Valarmathi', 'Valarmathi', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid'),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_4', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_4', 4, '2026-06-10', 'Chit_A1_M25_Kaviyarasu', 'Kaviyarasu', 'Malar', 1, 20200, 20200.0, 20200.0, 0.0, 'Cash', '2026-06-10', 'Paid');
insert into "Chit_Ledger" ("ID", "Finance_Name", "Chit_ID", "Chit_Name", "Chit_Auction_ID", "Month_Count", "Date_Auction", "Member_ID", "Member_Name", "Recommended_Partner", "Member_Percentage", "One_Share_Amount", "Due_Amount", "Received_Amount", "Pending_Amount", "Payment_Type", "Paid_Date", "Status") values
('Chit_A1_M1_Arul_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M1_Arul', 'Arul', 'Malar', 0.5, 20500, 10250.0, 0.0, 10250.0, NULL, NULL, 'Pending'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M2_Malarvizhi', 'Malarvizhi', 'Malar', 0.5, 20500, 10250.0, 10250.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M3_Muthusamy', 'Muthusamy', 'Malar', 1, 20500, 20500.0, 18250.0, 2250.0, 'Cash', NULL, 'Partial'),
('Chit_A1_M4_Surrendar_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M4_Surrendar', 'Surrendar', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M5_Kavi_Surrendar', 'Kavi_Surrendar', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M6_Amuthavel', 'Amuthavel', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M7_Palanisamy', 'Palanisamy', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M8_Tharun_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M8_Tharun', 'Tharun', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M9_Dinesh_Muthusamy', 'Dinesh_Muthusamy', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M10_Gopal', 'Gopal', 'Malar', 0.5, 20500, 10250.0, 10250.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M11_Kannan_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M11_Kannan', 'Kannan', 'Malar', 0.5, 20500, 10250.0, 10250.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M12_Dinesh_Thangavel', 'Dinesh_Thangavel', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M13_Arasakumar_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M13_Arasakumar', 'Arasakumar', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M14_Baskar_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M14_Baskar', 'Baskar', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M15_Gopalsamy', 'Gopalsamy', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M16_Sathyadevi', 'Sathyadevi', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M17_Arun Prakash_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M17_Arun Prakash', 'Arun Prakash', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M18_Deepak', 'Deepak', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M19_Nagaraj', 'Nagaraj', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M20_Rajesh', 'Rajesh', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M21_Finance_Chit_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M21_Finance_Chit', 'Finance_Chit', 'Malar', 1, 20500, 20500.0, 0.0, 20500.0, NULL, NULL, 'Pending'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M22_Vikas', 'Vikas', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M23_Mohan_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M23_Mohan', 'Mohan', 'Malar', 0.5, 20500, 10250.0, 10250.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M24_Valarmathi', 'Valarmathi', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_5', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_5', 5, '2026-07-10', 'Chit_A1_M25_Kaviyarasu', 'Kaviyarasu', 'Malar', 1, 20500, 20500.0, 20500.0, 0.0, 'Cash', '2026-07-10', 'Paid'),
('Chit_A1_M1_Arul_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M1_Arul', 'Arul', 'Malar', 0.5, 20725, 10362.5, 0.0, 10362.5, NULL, NULL, 'Pending'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M2_Malarvizhi', 'Malarvizhi', 'Malar', 0.5, 20725, 10362.5, 0.0, 10362.5, NULL, NULL, 'Pending'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M3_Muthusamy', 'Muthusamy', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M4_Surrendar_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M4_Surrendar', 'Surrendar', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M5_Kavi_Surrendar', 'Kavi_Surrendar', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M6_Amuthavel', 'Amuthavel', 'Malar', 1, 20725, 20725.0, 20725.0, 0.0, 'Cash', '2026-08-10', 'Paid'),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M7_Palanisamy', 'Palanisamy', 'Malar', 1, 20725, 20725.0, 20725.0, 0.0, 'Cash', '2026-08-10', 'Paid'),
('Chit_A1_M8_Tharun_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M8_Tharun', 'Tharun', 'Malar', 1, 20725, 20725.0, 4500.0, 16225.0, 'Cash', NULL, 'Partial'),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M9_Dinesh_Muthusamy', 'Dinesh_Muthusamy', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M10_Gopal', 'Gopal', 'Malar', 0.5, 20725, 10362.5, 10362.5, 0.0, 'Cash', '2026-08-10', 'Paid'),
('Chit_A1_M11_Kannan_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M11_Kannan', 'Kannan', 'Malar', 0.5, 20725, 10362.5, 10362.5, 0.0, 'Cash', '2026-08-10', 'Paid'),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M12_Dinesh_Thangavel', 'Dinesh_Thangavel', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M13_Arasakumar_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M13_Arasakumar', 'Arasakumar', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M14_Baskar_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M14_Baskar', 'Baskar', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M15_Gopalsamy', 'Gopalsamy', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M16_Sathyadevi', 'Sathyadevi', 'Malar', 1, 20725, 20725.0, 20725.0, 0.0, 'Cash', '2026-08-10', 'Paid'),
('Chit_A1_M17_Arun Prakash_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M17_Arun Prakash', 'Arun Prakash', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M18_Deepak', 'Deepak', 'Malar', 1, 20725, 20725.0, 20725.0, 0.0, 'Cash', '2026-08-10', 'Paid'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M19_Nagaraj', 'Nagaraj', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M20_Rajesh', 'Rajesh', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M21_Finance_Chit_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M21_Finance_Chit', 'Finance_Chit', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M22_Vikas', 'Vikas', 'Malar', 1, 20725, 20725.0, 0.0, 20725.0, NULL, NULL, 'Pending'),
('Chit_A1_M23_Mohan_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M23_Mohan', 'Mohan', 'Malar', 0.5, 20725, 10362.5, 10362.5, 0.0, 'Cash', '2026-08-10', 'Paid'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M24_Valarmathi', 'Valarmathi', 'Malar', 1, 20725, 20725.0, 20725.0, 0.0, 'Cash', '2026-08-10', 'Paid'),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_6', 'Chit_Malar', 'Chit_A1', 'A', 'Chit_A1_Auction_6', 6, '2026-08-10', 'Chit_A1_M25_Kaviyarasu', 'Kaviyarasu', 'Malar', 1, 20725, 20725.0, 20725.0, 0.0, 'Cash', '2026-08-10', 'Paid');
alter table "Chit_Ledger" enable row level security;
drop policy if exists "app_read" on "Chit_Ledger";
create policy "app_read" on "Chit_Ledger" for select using (true);
drop policy if exists "app_write" on "Chit_Ledger";
create policy "app_write" on "Chit_Ledger" for all using (true) with check (true);
