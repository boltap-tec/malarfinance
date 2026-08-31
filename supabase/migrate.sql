-- Malar Finance - full migration (schema + data + read policies)
-- Paste into Supabase > SQL Editor > Run. Safe to re-run (drops & recreates).

drop table if exists "Finance_Details" cascade;
create table "Finance_Details" ("Finance_Name" text, "Date_Opened" text, "No_Partners" text, "Initial_Capital_Partner" numeric, "Phone_Number" numeric, "MD_Name" text);
insert into "Finance_Details" ("Finance_Name", "Date_Opened", "No_Partners", "Initial_Capital_Partner", "Phone_Number", "MD_Name") values
('Malar_Finance', '2024-01-01', '1', 300000, 9626262427, 'Malarvizhi'),
('Malar_Appa', '2025-01-01', '1', 1000000, NULL, NULL),
('Chit_Malar', '2026-03-10', '1', 1, 8300148034, NULL),
('Kannan_Finance', '2026-01-01', '1', 300000, NULL, NULL);
alter table "Finance_Details" enable row level security;
create policy "read_all_Finance_Details" on "Finance_Details" for select using (true);

drop table if exists "Partner" cascade;
create table "Partner" ("Partner_ID" text, "Finance_Name" text, "Partner_Name" text, "Photo" text, "Phone_Number" numeric, "Email_Address" text, "Pending_Message" text);
insert into "Partner" ("Partner_ID", "Finance_Name", "Partner_Name", "Photo", "Phone_Number", "Email_Address", "Pending_Message") values
('New-P1', 'New Finance', 'Arul Sampath', NULL, 8940864888, NULL, 'No entries found'),
('New-P2', 'New Finance', 'Arul Muthusamy', NULL, 9626262427, NULL, 'No entries found'),
('New-P3', 'New Finance', 'Kannan Jeganathan', NULL, 9976592192, NULL, 'No entries found'),
('New-P4', 'New Finance', 'Kavin Mani', NULL, 7373738363, NULL, 'No entries found'),
('New-P5', 'New Finance', 'Ponnusamy A', NULL, 9942713540, NULL, 'No entries found'),
('New-P6', 'New Finance', 'Prakash Manoharan', NULL, 9865388000, NULL, 'No entries found'),
('New-P7', 'New Finance', 'Ram Kumar PNR', NULL, 9578562182, NULL, 'No entries found'),
('New-P8', 'New Finance', 'Ravi Paramasivam', NULL, 9751277888, NULL, 'No entries found'),
('New-P9', 'New Finance', 'Vasu Devar Paramasivam', NULL, 9751519191, NULL, 'No entries found'),
('New-P10', 'New Finance', 'Vinayagam Sankaralingam', NULL, 9751707865, NULL, 'No entries found'),
('Mal-P1', 'Malar_Finance', 'Malarvizhi', NULL, 9626262427, NULL, 'Referral Total Interest Pending Rs 179224
Mal-STL10-Balu1-05-2025 - Int_Amount Rs 70 - Pending Rs -70
Mal-STL10-Balu1-06-2025 - Int_Amount Rs 1050 - Pending Rs -1050
Mal-STL15-Pradeep-06-2025 - Int_Amount Rs 2100 - Pending Rs 2100
Mal-STL10-Balu1-07-2025 - Int_Amount Rs 1085 - Pending Rs -1085
Mal-STL8-Mahesh1-07-2025 - Int_Amount Rs 5425 - Pending Rs 2275
Mal-STL15-Pradeep-07-2025 - Int_Amount Rs 2170 - Pending Rs 2170
Mal-STL10-Balu1-08-2025 - Int_Amount Rs 665 - Pending Rs -665
Mal-STL8-Mahesh1-08-2025 - Int_Amount Rs 3150 - Pending Rs 3150
Mal-STL15-Pradeep-08-2025 - Int_Amount Rs 1330 - Pending Rs 1330
Mal-STL21-Mahesh Manmangalam-08-2025 - Int_Amount Rs 2275 - Pending Rs 2275
Mal-STL21-Mahesh Manmangalam-09-2025 - Int_Amount Rs 5250 - Pending Rs 5250
Mal-STL21-Mahesh Manmangalam-10-2025 - Int_Amount Rs 5425 - Pending Rs 5425
Mal-STL12-Chandrasekar-11-2025 - Int_Amount Rs 2100 - Pending Rs 2100
Mal-STL21-Mahesh Manmangalam-11-2025 - Int_Amount Rs 5250 - Pending Rs 5250
Mal-STL21-Mahesh Manmangalam-12-2025 - Int_Amount Rs 5425 - Pending Rs 5425
Mal-STL12-Chandrasekar-01-2026 - Int_Amount Rs 2170 - Pending Rs 2170
Mal-STL21-Mahesh Manmangalam-01-2026 - Int_Amount Rs 5425 - Pending Rs 5425
Mal-STL12-Chandrasekar-02-2026 - Int_Amount Rs 1960 - Pending Rs 540
Mal-STL11-Balu-02-2026 - Int_Amount Rs 7840 - Pending Rs 8820
Mal-STL14-Ramkumar-02-2026 - Int_Amount Rs 4200 - Pending Rs 4200
Mal-STL21-Mahesh Manmangalam-02-2026 - Int_Amount Rs 4900 - Pending Rs 4900
Mal-STL12-Chandrasekar-03-2026 - Int_Amount Rs 2170 - Pending Rs 2170
Mal-STL11-Balu-03-2026 - Int_Amount Rs 8680 - Pending Rs 9765
Mal-STL14-Ramkumar-03-2026 - Int_Amount Rs 4650 - Pending Rs 4650
Mal-STL61-Test11-03-2026 - Int_Amount Rs 3 - Pending Rs 3
Mal-STL21-Mahesh Manmangalam-03-2026 - Int_Amount Rs 5425 - Pending Rs 5425
Mal-STL12-Chandrasekar-04-2026 - Int_Amount Rs 2100 - Pending Rs 2100
Mal-STL11-Balu-04-2026 - Int_Amount Rs 8400 - Pending Rs 9450
Mal-STL14-Ramkumar-04-2026 - Int_Amount Rs 4500 - Pending Rs 4500
Mal-STL61-Test11-04-2026 - Int_Amount Rs 3 - Pending Rs 3
Mal-STL21-Mahesh Manmangalam-04-2026 - Int_Amount Rs 5250 - Pending Rs 5250
Mal-STL12-Chandrasekar-05-2026 - Int_Amount Rs 2170 - Pending Rs 2170
Mal-STL11-Balu-05-2026 - Int_Amount Rs 8680 - Pending Rs 9765
Mal-STL14-Ramkumar-05-2026 - Int_Amount Rs 4650 - Pending Rs 4650
Mal-STL61-Test11-05-2026 - Int_Amount Rs 3 - Pending Rs 3
Mal-STL21-Mahesh Manmangalam-05-2026 - Int_Amount Rs 5425 - Pending Rs 5425
Mal-STL12-Chandrasekar-06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
Mal-STL11-Balu-06-2026 - Int_Amount Rs 9450 - Pending Rs 9450
Mal-STL14-Ramkumar-06-2026 - Int_Amount Rs 4500 - Pending Rs 4500
Mal-STL21-Mahesh Manmangalam-06-2026 - Int_Amount Rs 5250 - Pending Rs 5250
Mal-STL12-Chandrasekar-07-2026 - Int_Amount Rs 2170 - Pending Rs 2170
Mal-STL11-Balu-07-2026 - Int_Amount Rs 9770 - Pending Rs 9770
Mal-STL13-Orange_Tex-07-2026 - Int_Amount Rs 6700 - Pending Rs 6700
Mal-STL14-Ramkumar-07-2026 - Int_Amount Rs 9820 - Pending Rs 9820
Mal-STL21-Mahesh Manmangalam-07-2026 - Int_Amount Rs 5430 - Pending Rs 5430
Mal-STL22-Pradeep Vangapalayam-07-2026 - Int_Amount Rs 2170 - Pending Rs 2170
Mal-STL11-Balu - Old Pending Interest Rs 800'),
('Mal-P2', 'Malar_Appa', 'Malar_Appa', NULL, 8973440117, NULL, 'No entries found'),
('Chi-P1', 'Chit_Malar', 'Malar', NULL, 8300148034, NULL, 'No entries found'),
('Kan-P1', 'Kannan_Finance', 'Malarvizhi', NULL, 9626262427, NULL, 'Referral Total Interest Pending Rs 45567
Kan-STL5-Priya-05-2026 - Int_Amount Rs 560 - Pending Rs 6069
Kan-STL1-Ramasamy divya-05-2026 - Int_Amount Rs 1085 - Pending Rs 1085
Kan-STL2-Sundaravadivel-05-2026 - Int_Amount Rs 2170 - Pending Rs 2170
Kan-STL3-Suresh Balu vangap-05-2026 - Int_Amount Rs 6510 - Pending Rs 6510
Kan-STL4-Nagaraj post-05-2026 - Int_Amount Rs 651 - Pending Rs 651
Kan-STL6-Chathiram amma-05-2026 - Int_Amount Rs 651 - Pending Rs 651
Kan-STL7-Arul-05-2026 - Int_Amount Rs 543 - Pending Rs 543
Kan-STL8-Manoj-05-2026 - Int_Amount Rs 217 - Pending Rs 217
Kan-STL9-Surya vangap-05-2026 - Int_Amount Rs 3038 - Pending Rs 3038
Kan-STL5-Priya-06-2026 - Int_Amount Rs 42 - Pending Rs 7602
Kan-STL1-Ramasamy divya-06-2026 - Int_Amount Rs 1050 - Pending Rs 1050
Kan-STL2-Sundaravadivel-06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
Kan-STL3-Suresh Balu vangap-06-2026 - Int_Amount Rs 6300 - Pending Rs 6300
Kan-STL4-Nagaraj post-06-2026 - Int_Amount Rs 630 - Pending Rs 630
Kan-STL6-Chathiram amma-06-2026 - Int_Amount Rs 630 - Pending Rs 630
Kan-STL7-Arul-06-2026 - Int_Amount Rs 530 - Pending Rs 530
Kan-STL8-Manoj-06-2026 - Int_Amount Rs 210 - Pending Rs 210
Kan-STL9-Surya vangap-06-2026 - Int_Amount Rs 2940 - Pending Rs 2940
Kan-STL5-Priya-07-2026 - Int_Amount Rs 840 - Pending Rs 7790
Kan-STL1-Ramasamy divya-07-2026 - Int_Amount Rs 1090 - Pending Rs 1090
Kan-STL2-Sundaravadivel-07-2026 - Int_Amount Rs 2170 - Pending Rs 2170
Kan-STL3-Suresh Balu vangap-07-2026 - Int_Amount Rs 6510 - Pending Rs 6510
Kan-STL4-Nagaraj post-07-2026 - Int_Amount Rs 650 - Pending Rs 650
Kan-STL6-Chathiram amma-07-2026 - Int_Amount Rs 650 - Pending Rs 650
Kan-STL7-Arul-07-2026 - Int_Amount Rs 540 - Pending Rs 540
Kan-STL8-Manoj-07-2026 - Int_Amount Rs 220 - Pending Rs 220
Kan-STL9-Surya vangap-07-2026 - Int_Amount Rs 3040 - Pending Rs 3040');
alter table "Partner" enable row level security;
create policy "read_all_Partner" on "Partner" for select using (true);

drop table if exists "STL_CRM" cascade;
create table "STL_CRM" ("Finance_Name" text, "Customer_Name" text, "Customer_STL_NO" text, "Customer_Phone_No" numeric, "Customer_Email" text, "Customer_Adhar_No" text, "Customer_Photo" text, "Total_Loan_Given" numeric, "Outstand_Loan" numeric, "Total_Interest_Paid" numeric, "Outstanding_Interest" numeric, "Status" text, "Pending_Message" text, "Pending111" text);
insert into "STL_CRM" ("Finance_Name", "Customer_Name", "Customer_STL_NO", "Customer_Phone_No", "Customer_Email", "Customer_Adhar_No", "Customer_Photo", "Total_Loan_Given", "Outstand_Loan", "Total_Interest_Paid", "Outstanding_Interest", "Status", "Pending_Message", "Pending111") values
('Malar_Appa', 'Chandrasekaran1', 'Mal-STL1', 7092355445, NULL, NULL, NULL, 200000, 0, 16800, 0, 'Inactive', 'Mal-STL1-Chandrasekaran1
No entries found', 'No entries found'),
('Malar_Appa', 'Ramkumar1', 'Mal-STL2', 9578562182, NULL, NULL, NULL, 2300000, 0, 54094, 0, 'Inactive', 'Mal-STL2-Ramkumar1
No entries found', 'No entries found'),
('Malar_Appa', 'Kannan1', 'Mal-STL3', 9626262427, NULL, NULL, NULL, 500000, 0, 12258, 0, 'Inactive', 'Mal-STL3-Kannan1
No entries found', 'No entries found'),
('Malar_Appa', 'Palanisamy1', 'Mal-STL4', 7010457994, NULL, NULL, NULL, 1500000, 0, 36387, 0, 'Inactive', 'Mal-STL4-Palanisamy1
No entries found', 'No entries found'),
('Malar_Appa', 'Elango1', 'Mal-STL5', 9943831310, NULL, NULL, NULL, 600000, 0, 0, 0, 'Inactive', 'Mal-STL5-Elango1
No entries found', 'No entries found'),
('Malar_Appa', 'AshokFinance1', 'Mal-STL6', 9626262427, NULL, NULL, NULL, 1000000, 0, 33549, 0, 'Inactive', 'Mal-STL6-AshokFinance1
No entries found', 'No entries found'),
('Malar_Appa', 'Akpr1', 'Mal-STL7', 9894205641, NULL, NULL, NULL, 5850000, 0, 123794, 0, 'Inactive', 'Mal-STL7-Akpr1
No entries found', 'No entries found'),
('Malar_Appa', 'Mahesh1', 'Mal-STL8', 9003756295, NULL, NULL, NULL, 250000, 0, 10675, 5425, 'Inactive', 'Mal-STL8-Mahesh1
Total Interest Pending Rs 5425
07-2025 - Int_Amount Rs 5425 - Pending Rs 2275
08-2025 - Int_Amount Rs 3150 - Pending Rs 3150', 'Total Interest Pending Rs 5425
07-2025 - Int_Amount Rs 5425 - Pending Rs 2275
08-2025 - Int_Amount Rs 3150 - Pending Rs 3150'),
('Malar_Appa', 'Priya1', 'Mal-STL9', 9626262427, NULL, NULL, NULL, 200000, 0, 10640, 0, 'Inactive', 'Mal-STL9-Priya1
No entries found', 'No entries found'),
('Malar_Appa', 'Balu1', 'Mal-STL10', 9976592192, NULL, NULL, NULL, 50000, 0, 5740, -2870, 'Inactive', 'Mal-STL10-Balu1
Total Interest Pending Rs -2870
05-2025 - Int_Amount Rs 70 - Pending Rs -70
06-2025 - Int_Amount Rs 1050 - Pending Rs -1050
07-2025 - Int_Amount Rs 1085 - Pending Rs -1085
08-2025 - Int_Amount Rs 665 - Pending Rs -665', 'Total Interest Pending Rs -2870
05-2025 - Int_Amount Rs 70 - Pending Rs -70
06-2025 - Int_Amount Rs 1050 - Pending Rs -1050
07-2025 - Int_Amount Rs 1085 - Pending Rs -1085
08-2025 - Int_Amount Rs 665 - Pending Rs -665'),
('Malar_Finance', 'Balu', 'Mal-STL11', 9976592192, NULL, NULL, NULL, 450000, 450000, 91490, 57020, 'Active', 'Mal-STL11-Balu
Total Interest Pending Rs 57820
02-2026 - Int_Amount Rs 8820 - Pending Rs 8820
03-2026 - Int_Amount Rs 9765 - Pending Rs 9765
04-2026 - Int_Amount Rs 9450 - Pending Rs 9450
05-2026 - Int_Amount Rs 9765 - Pending Rs 9765
06-2026 - Int_Amount Rs 9450 - Pending Rs 9450
07-2026 - Int_Amount Rs 9770 - Pending Rs 9770
Mal-STL11 - Old Pending Interest Rs 800', 'Total Interest Pending Rs 57820
02-2026 - Int_Amount Rs 8820 - Pending Rs 8820
03-2026 - Int_Amount Rs 9765 - Pending Rs 9765
04-2026 - Int_Amount Rs 9450 - Pending Rs 9450
05-2026 - Int_Amount Rs 9765 - Pending Rs 9765
06-2026 - Int_Amount Rs 9450 - Pending Rs 9450
07-2026 - Int_Amount Rs 9770 - Pending Rs 9770
Mal-STL11 - Old Pending Interest Rs 800'),
('Malar_Finance', 'Chandrasekar', 'Mal-STL12', 7092355445, NULL, NULL, NULL, 100000, 100000, 18570, 15520, 'Active', 'Mal-STL12-Chandrasekar
Total Interest Pending Rs 15520
11-2025 - Int_Amount Rs 2100 - Pending Rs 2100
01-2026 - Int_Amount Rs 2170 - Pending Rs 2170
02-2026 - Int_Amount Rs 1960 - Pending Rs 540
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170
04-2026 - Int_Amount Rs 2100 - Pending Rs 2100
05-2026 - Int_Amount Rs 2170 - Pending Rs 2170
06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 15520
11-2025 - Int_Amount Rs 2100 - Pending Rs 2100
01-2026 - Int_Amount Rs 2170 - Pending Rs 2170
02-2026 - Int_Amount Rs 1960 - Pending Rs 540
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170
04-2026 - Int_Amount Rs 2100 - Pending Rs 2100
05-2026 - Int_Amount Rs 2170 - Pending Rs 2170
06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('Malar_Finance', 'Orange_Tex', 'Mal-STL13', 9578562182, NULL, NULL, NULL, 270000, 270000, 98616, 6700, 'Active', 'Mal-STL13-Orange_Tex
Total Interest Pending Rs 6700
07-2026 - Int_Amount Rs 6700 - Pending Rs 6700', 'Total Interest Pending Rs 6700
07-2026 - Int_Amount Rs 6700 - Pending Rs 6700'),
('Malar_Finance', 'Ramkumar', 'Mal-STL14', 9578562182, NULL, NULL, NULL, 850000, 750000, 57240, 32320, 'Active', 'Mal-STL14-Ramkumar
Total Interest Pending Rs 32320
02-2026 - Int_Amount Rs 4200 - Pending Rs 4200
03-2026 - Int_Amount Rs 4650 - Pending Rs 4650
04-2026 - Int_Amount Rs 4500 - Pending Rs 4500
05-2026 - Int_Amount Rs 4650 - Pending Rs 4650
06-2026 - Int_Amount Rs 4500 - Pending Rs 4500
07-2026 - Int_Amount Rs 9820 - Pending Rs 9820', 'Total Interest Pending Rs 32320
02-2026 - Int_Amount Rs 4200 - Pending Rs 4200
03-2026 - Int_Amount Rs 4650 - Pending Rs 4650
04-2026 - Int_Amount Rs 4500 - Pending Rs 4500
05-2026 - Int_Amount Rs 4650 - Pending Rs 4650
06-2026 - Int_Amount Rs 4500 - Pending Rs 4500
07-2026 - Int_Amount Rs 9820 - Pending Rs 9820'),
('Malar_Appa', 'Pradeep', 'Mal-STL15', 9994009257, NULL, NULL, NULL, 100000, 0, 6440, 5600, 'Inactive', 'Mal-STL15-Pradeep
Total Interest Pending Rs 5600
06-2025 - Int_Amount Rs 2100 - Pending Rs 2100
07-2025 - Int_Amount Rs 2170 - Pending Rs 2170
08-2025 - Int_Amount Rs 1330 - Pending Rs 1330', 'Total Interest Pending Rs 5600
06-2025 - Int_Amount Rs 2100 - Pending Rs 2100
07-2025 - Int_Amount Rs 2170 - Pending Rs 2170
08-2025 - Int_Amount Rs 1330 - Pending Rs 1330'),
('Malar_Finance', 'Amuthavel', 'Mal-STL16', 7373731825, NULL, NULL, NULL, 0, 0, 0, 0, 'Inactive', 'Mal-STL16-Amuthavel
No entries found', 'No entries found'),
('Malar_Finance', 'Test11', 'Mal-STL61', 9626262427, 'arulece05@gmail.com', NULL, NULL, 125, 125, 0, 9, 'Active', 'Mal-STL61
Total Interest Pending Rs 9
03-2026 - Int_Amount Rs 3 - Pending Rs 3
04-2026 - Int_Amount Rs 3 - Pending Rs 3
05-2026 - Int_Amount Rs 3 - Pending Rs 3', 'Total Interest Pending Rs 9
03-2026 - Int_Amount Rs 3 - Pending Rs 3
04-2026 - Int_Amount Rs 3 - Pending Rs 3
05-2026 - Int_Amount Rs 3 - Pending Rs 3'),
('Malar_Appa', 'Senthil_Vaduvatti', 'Mal-STL17', 9790556575, NULL, NULL, NULL, 300000, 0, 2400, 0, 'Inactive', 'Mal-STL17
No entries found', 'No entries found'),
('Malar_Finance', 'Priya', 'Mal-STL20', 9976592192, NULL, NULL, NULL, 200000, 0, 27160, 0, 'Inactive', 'Mal-STL20
No entries found', 'No entries found'),
('Malar_Finance', 'Mahesh Manmangalam', 'Mal-STL21', 9976592192, NULL, NULL, NULL, 250000, 250000, 0, 60730, 'Active', 'Mal-STL21
Total Interest Pending Rs 60730
08-2025 - Int_Amount Rs 2275 - Pending Rs 2275
09-2025 - Int_Amount Rs 5250 - Pending Rs 5250
10-2025 - Int_Amount Rs 5425 - Pending Rs 5425
11-2025 - Int_Amount Rs 5250 - Pending Rs 5250
12-2025 - Int_Amount Rs 5425 - Pending Rs 5425
01-2026 - Int_Amount Rs 5425 - Pending Rs 5425
02-2026 - Int_Amount Rs 4900 - Pending Rs 4900
03-2026 - Int_Amount Rs 5425 - Pending Rs 5425
04-2026 - Int_Amount Rs 5250 - Pending Rs 5250
05-2026 - Int_Amount Rs 5425 - Pending Rs 5425
06-2026 - Int_Amount Rs 5250 - Pending Rs 5250
07-2026 - Int_Amount Rs 5430 - Pending Rs 5430', 'Total Interest Pending Rs 60730
08-2025 - Int_Amount Rs 2275 - Pending Rs 2275
09-2025 - Int_Amount Rs 5250 - Pending Rs 5250
10-2025 - Int_Amount Rs 5425 - Pending Rs 5425
11-2025 - Int_Amount Rs 5250 - Pending Rs 5250
12-2025 - Int_Amount Rs 5425 - Pending Rs 5425
01-2026 - Int_Amount Rs 5425 - Pending Rs 5425
02-2026 - Int_Amount Rs 4900 - Pending Rs 4900
03-2026 - Int_Amount Rs 5425 - Pending Rs 5425
04-2026 - Int_Amount Rs 5250 - Pending Rs 5250
05-2026 - Int_Amount Rs 5425 - Pending Rs 5425
06-2026 - Int_Amount Rs 5250 - Pending Rs 5250
07-2026 - Int_Amount Rs 5430 - Pending Rs 5430'),
('Malar_Finance', 'Pradeep Vangapalayam', 'Mal-STL22', 9976592192, NULL, NULL, NULL, 100000, 100000, 22120, 2170, 'Active', 'Mal-STL22
Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('Chit_Malar', 'Pradeep', 'Chi-STL1', 9626262427, NULL, NULL, NULL, 150000, 150000, 7784, 3260, 'Active', 'Chi-STL1
Total Interest Pending Rs 3260
07-2026 - Int_Amount Rs 3260 - Pending Rs 3260', 'Total Interest Pending Rs 3260
07-2026 - Int_Amount Rs 3260 - Pending Rs 3260'),
('Chit_Malar', 'Priya', 'Chi-STL2', 9976592192, NULL, NULL, NULL, 380000, 380000, 8211, 7350, 'Active', 'Chi-STL2
Total Interest Pending Rs 7350
07-2026 - Int_Amount Rs 7350 - Pending Rs 7350', 'Total Interest Pending Rs 7350
07-2026 - Int_Amount Rs 7350 - Pending Rs 7350'),
('Chit_Malar', 'Palanisamy', 'Chi-STL3', 7010457994, NULL, NULL, NULL, 700000, 700000, 27600, 0, 'Active', 'Chi-STL3
No entries found', 'No entries found'),
('Kannan_Finance', 'Ramasamy divya', 'Kan-STL1', 9787878005, NULL, NULL, NULL, 50000, 50000, 0, 3225, 'Active', 'Kan-STL1
Total Interest Pending Rs 3225
05-2026 - Int_Amount Rs 1085 - Pending Rs 1085
06-2026 - Int_Amount Rs 1050 - Pending Rs 1050
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090', 'Total Interest Pending Rs 3225
05-2026 - Int_Amount Rs 1085 - Pending Rs 1085
06-2026 - Int_Amount Rs 1050 - Pending Rs 1050
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090'),
('Kannan_Finance', 'Sundaravadivel', 'Kan-STL2', 9626262427, NULL, NULL, NULL, 100000, 100000, 0, 6440, 'Active', 'Kan-STL2
Total Interest Pending Rs 6440
05-2026 - Int_Amount Rs 2170 - Pending Rs 2170
06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 6440
05-2026 - Int_Amount Rs 2170 - Pending Rs 2170
06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('Kannan_Finance', 'Suresh Balu vangap', 'Kan-STL3', 9626262427, NULL, NULL, NULL, 300000, 300000, 0, 19320, 'Active', 'Kan-STL3
Total Interest Pending Rs 19320
05-2026 - Int_Amount Rs 6510 - Pending Rs 6510
06-2026 - Int_Amount Rs 6300 - Pending Rs 6300
07-2026 - Int_Amount Rs 6510 - Pending Rs 6510', 'Total Interest Pending Rs 19320
05-2026 - Int_Amount Rs 6510 - Pending Rs 6510
06-2026 - Int_Amount Rs 6300 - Pending Rs 6300
07-2026 - Int_Amount Rs 6510 - Pending Rs 6510'),
('Kannan_Finance', 'Nagaraj post', 'Kan-STL4', 9626262427, NULL, NULL, NULL, 30000, 30000, 0, 1931, 'Active', 'Kan-STL4
Total Interest Pending Rs 1931
05-2026 - Int_Amount Rs 651 - Pending Rs 651
06-2026 - Int_Amount Rs 630 - Pending Rs 630
07-2026 - Int_Amount Rs 650 - Pending Rs 650', 'Total Interest Pending Rs 1931
05-2026 - Int_Amount Rs 651 - Pending Rs 651
06-2026 - Int_Amount Rs 630 - Pending Rs 630
07-2026 - Int_Amount Rs 650 - Pending Rs 650'),
('Kannan_Finance', 'Priya', 'Kan-STL5', 9626262427, NULL, NULL, NULL, 650000, 320000, 0, 21461, 'Active', 'Kan-STL5
Total Interest Pending Rs 21461
05-2026 - Int_Amount Rs 6069 - Pending Rs 6069
06-2026 - Int_Amount Rs 7602 - Pending Rs 7602
07-2026 - Int_Amount Rs 7790 - Pending Rs 7790', 'Total Interest Pending Rs 21461
05-2026 - Int_Amount Rs 6069 - Pending Rs 6069
06-2026 - Int_Amount Rs 7602 - Pending Rs 7602
07-2026 - Int_Amount Rs 7790 - Pending Rs 7790'),
('Kannan_Finance', 'Chathiram amma', 'Kan-STL6', 9944282343, NULL, NULL, NULL, 30000, 30000, 0, 1931, 'Active', 'Kan-STL6
Total Interest Pending Rs 1931
05-2026 - Int_Amount Rs 651 - Pending Rs 651
06-2026 - Int_Amount Rs 630 - Pending Rs 630
07-2026 - Int_Amount Rs 650 - Pending Rs 650', 'Total Interest Pending Rs 1931
05-2026 - Int_Amount Rs 651 - Pending Rs 651
06-2026 - Int_Amount Rs 630 - Pending Rs 630
07-2026 - Int_Amount Rs 650 - Pending Rs 650'),
('Kannan_Finance', 'Arul', 'Kan-STL7', 9626262427, NULL, NULL, NULL, 25000, 25000, 0, 1613, 'Active', 'Kan-STL7
Total Interest Pending Rs 1613
05-2026 - Int_Amount Rs 543 - Pending Rs 543
06-2026 - Int_Amount Rs 530 - Pending Rs 530
07-2026 - Int_Amount Rs 540 - Pending Rs 540', 'Total Interest Pending Rs 1613
05-2026 - Int_Amount Rs 543 - Pending Rs 543
06-2026 - Int_Amount Rs 530 - Pending Rs 530
07-2026 - Int_Amount Rs 540 - Pending Rs 540'),
('Kannan_Finance', 'Manoj', 'Kan-STL8', 9626262427, NULL, NULL, NULL, 10000, 10000, 0, 647, 'Active', 'Kan-STL8
Total Interest Pending Rs 647
05-2026 - Int_Amount Rs 217 - Pending Rs 217
06-2026 - Int_Amount Rs 210 - Pending Rs 210
07-2026 - Int_Amount Rs 220 - Pending Rs 220', 'Total Interest Pending Rs 647
05-2026 - Int_Amount Rs 217 - Pending Rs 217
06-2026 - Int_Amount Rs 210 - Pending Rs 210
07-2026 - Int_Amount Rs 220 - Pending Rs 220'),
('Kannan_Finance', 'Surya vangap', 'Kan-STL9', 9626262427, NULL, NULL, NULL, 140000, 140000, 0, 9018, 'Active', 'Kan-STL9
Total Interest Pending Rs 9018
05-2026 - Int_Amount Rs 3038 - Pending Rs 3038
06-2026 - Int_Amount Rs 2940 - Pending Rs 2940
07-2026 - Int_Amount Rs 3040 - Pending Rs 3040', 'Total Interest Pending Rs 9018
05-2026 - Int_Amount Rs 3038 - Pending Rs 3038
06-2026 - Int_Amount Rs 2940 - Pending Rs 2940
07-2026 - Int_Amount Rs 3040 - Pending Rs 3040'),
('Chit_Malar', 'Surrendar Puthur', 'Chi-STL4', 9043436792, NULL, NULL, NULL, 600000, 400000, 8400, 6200, 'Active', 'Chi-STL4
Total Interest Pending Rs 6200
07-2026 - Int_Amount Rs 6200 - Pending Rs 6200', 'Total Interest Pending Rs 6200
07-2026 - Int_Amount Rs 6200 - Pending Rs 6200'),
('Chit_Malar', 'Elango manmangalam', 'Chi-STL5', 9943831310, NULL, NULL, NULL, 100000, 100000, 0, 3250, 'Active', 'Chi-STL5
Total Interest Pending Rs 3250
05-2026 - Int_Amount Rs 200 - Pending Rs 200
06-2026 - Int_Amount Rs 1500 - Pending Rs 1500
07-2026 - Int_Amount Rs 1550 - Pending Rs 1550', 'Total Interest Pending Rs 3250
05-2026 - Int_Amount Rs 200 - Pending Rs 200
06-2026 - Int_Amount Rs 1500 - Pending Rs 1500
07-2026 - Int_Amount Rs 1550 - Pending Rs 1550'),
('Chit_Malar', 'Nagaraj refill', 'Chi-STL6', 9626262427, NULL, NULL, NULL, 50000, 50000, 1341, 0, 'Active', 'Chi-STL6
No entries found', 'No entries found'),
('Chit_Malar', 'Ramkumar', 'Chi-STL7', 9578562182, NULL, NULL, NULL, 350000, 250000, 4346, 3130, 'Active', 'Chi-STL7
Total Interest Pending Rs 3130
07-2026 - Int_Amount Rs 3130 - Pending Rs 3130', 'Total Interest Pending Rs 3130
07-2026 - Int_Amount Rs 3130 - Pending Rs 3130'),
('Chit_Malar', 'Arul Personal', 'Chi-STL8', 9626262427, NULL, NULL, NULL, 50000, 50000, 0, 1770, 'Active', 'Chi-STL8
Total Interest Pending Rs 1770
06-2026 - Int_Amount Rs 840 - Pending Rs 840
07-2026 - Int_Amount Rs 930 - Pending Rs 930', 'Total Interest Pending Rs 1770
06-2026 - Int_Amount Rs 840 - Pending Rs 840
07-2026 - Int_Amount Rs 930 - Pending Rs 930'),
('Chit_Malar', 'Tharun kannan', 'Chi-STL9', 9843722055, NULL, NULL, NULL, 200000, 200000, 6460, 0, 'Active', 'Chi-STL9
No entries found', 'No entries found'),
('Chit_Malar', 'Rajesh post office', 'Chi-STL10', 9994922299, NULL, NULL, NULL, 500000, 500000, 0, 7250, 'Active', 'Chi-STL10
Total Interest Pending Rs 7250
07-2026 - Int_Amount Rs 7250 - Pending Rs 7250', 'Total Interest Pending Rs 7250
07-2026 - Int_Amount Rs 7250 - Pending Rs 7250');
alter table "STL_CRM" enable row level security;
create policy "read_all_STL_CRM" on "STL_CRM" for select using (true);

drop table if exists "Loan_Processing" cascade;
create table "Loan_Processing" ("Finance_Name" text, "Loan_Given_Date" text, "Loan_No" text, "Customer_STL_NO" text, "Customer_Name" text, "Customer_Phone_No" numeric, "Customer_Email" text, "Customer_Adhar_No" text, "Loan_Amount" numeric, "Interest_Per_day_Per_Lakh" numeric, "No_Bond_Received" text, "No_Chq_Received" text, "Attach1" text, "Attach2" text, "Photo1" text, "Photo2" text, "Repaid_Amount" numeric, "Outstand_Amount" numeric, "Loan_Status" text, "Referred_Partner" text, "Payment_Type" text, "Remarks" text, "Interest_Type" text, "Interest_Per_Month_Per_Lakh" numeric, "Total_Month_Days" text, "Customer_Type" text, "Customer_Ref" text);
insert into "Loan_Processing" ("Finance_Name", "Loan_Given_Date", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "Customer_Email", "Customer_Adhar_No", "Loan_Amount", "Interest_Per_day_Per_Lakh", "No_Bond_Received", "No_Chq_Received", "Attach1", "Attach2", "Photo1", "Photo2", "Repaid_Amount", "Outstand_Amount", "Loan_Status", "Referred_Partner", "Payment_Type", "Remarks", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days", "Customer_Type", "Customer_Ref") values
('Malar_Appa', '2025-04-21', 'Mal-1', 'Mal-STL1', 'Chandrasekaran1', 7092355445, NULL, NULL, 200000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Day', 0, NULL, NULL, NULL),
('Malar_Finance', '2024-01-01', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, NULL, NULL, 100000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'Mal-P1', 'Cash', NULL, 'Per_Day', 0, NULL, NULL, NULL),
('Malar_Finance', '2024-04-10', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, NULL, NULL, 400000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 400000, 'Active', 'Mal-P1', 'Cash', NULL, 'Per_Day', 0, NULL, NULL, NULL),
('Malar_Appa', '2025-05-30', 'Mal-4', 'Mal-STL10', 'Balu1', 9976592192, NULL, NULL, 50000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Day', 0, NULL, NULL, NULL),
('Malar_Finance', '2025-01-01', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, NULL, NULL, 270000, 80, NULL, NULL, NULL, NULL, NULL, NULL, 0, 270000, 'Active', 'Mal-P1', 'Cash', NULL, 'Per_Day', 0, NULL, NULL, NULL),
('Malar_Finance', '2025-01-01', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, NULL, NULL, 350000, 60, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 250000, 'Active', 'Mal-P1', 'Cash', NULL, 'Per_Day', 1800, NULL, NULL, NULL),
('Malar_Appa', '2025-03-31', 'Mal-7', 'Mal-STL2', 'Ramkumar1', 9578562182, NULL, NULL, 1500000, 26.67, NULL, NULL, NULL, NULL, NULL, NULL, 1500000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 800, NULL, NULL, NULL),
('Malar_Appa', '2025-04-29', 'Mal-8', 'Mal-STL2', 'Ramkumar1', 9578562182, NULL, NULL, 300000, 26.67, NULL, NULL, NULL, NULL, NULL, NULL, 300000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 800, NULL, NULL, NULL),
('Malar_Appa', '2025-05-31', 'Mal-9', 'Mal-STL2', 'Ramkumar1', 9578562182, NULL, NULL, 500000, 26.67, NULL, NULL, NULL, NULL, NULL, NULL, 500000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 800, NULL, NULL, NULL),
('Malar_Appa', '2025-05-17', 'Mal-10', 'Mal-STL3', 'Kannan1', 9626262427, NULL, NULL, 500000, 0, NULL, NULL, NULL, NULL, NULL, NULL, 500000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 800, NULL, NULL, NULL),
('Malar_Appa', '2025-06-04', 'Mal-11', 'Mal-STL9', 'Priya1', 9626262427, NULL, NULL, 200000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Day', 0, NULL, NULL, NULL),
('Malar_Appa', '2025-04-02', 'Mal-12', 'Mal-STL5', 'Elango1', 9943831310, NULL, NULL, 600000, 0, NULL, NULL, NULL, NULL, NULL, NULL, 600000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 0, NULL, NULL, NULL),
('Malar_Appa', '2025-05-05', 'Mal-13', 'Mal-STL6', 'AshokFinance1', 9626262427, NULL, NULL, 1000000, 33.33, NULL, NULL, NULL, NULL, NULL, NULL, 1000000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 1000, NULL, NULL, NULL),
('Malar_Appa', '2025-04-15', 'Mal-14', 'Mal-STL4', 'Palanisamy1', 7010457994, NULL, NULL, 1000000, 26.67, NULL, NULL, NULL, NULL, NULL, NULL, 1000000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 800, NULL, NULL, NULL),
('Malar_Appa', '2025-05-10', 'Mal-15', 'Mal-STL4', 'Palanisamy1', 7010457994, NULL, NULL, 500000, 26.67, NULL, NULL, NULL, NULL, NULL, NULL, 500000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 800, NULL, NULL, NULL),
('Malar_Appa', '2025-05-31', 'Mal-16', 'Mal-STL7', 'Akpr1', 9894205641, NULL, NULL, 5850000, 26.67, NULL, NULL, NULL, NULL, NULL, NULL, 5850000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 800, NULL, NULL, NULL),
('Malar_Appa', '2025-05-19', 'Mal-17', 'Mal-STL8', 'Mahesh1', 9003756295, NULL, NULL, 250000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 250000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Day', 0, NULL, NULL, NULL),
('Malar_Appa', '2025-01-01', 'Mal-18', 'Mal-STL15', 'Pradeep', 9994009257, NULL, NULL, 100000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Day', 0, NULL, NULL, NULL),
('Malar_Appa', '2025-03-30', 'Mal-19', 'Mal-STL16', 'Amuthavel', 7373731825, NULL, NULL, 100000, 0, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 0, NULL, NULL, NULL),
('Malar_Appa', '2025-06-04', 'Mal-20', 'Mal-STL16', 'Amuthavel', 7373731825, NULL, NULL, 150000, 0, NULL, NULL, NULL, NULL, NULL, NULL, 150000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 0, NULL, NULL, NULL),
('Malar_Appa', '2025-05-01', 'Mal-21', 'Mal-STL16', 'Amuthavel', 7373731825, NULL, NULL, 350000, 0, NULL, NULL, NULL, NULL, NULL, NULL, 350000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Month', 0, NULL, NULL, NULL),
('Malar_Finance', '2025-07-02', 'Mal-22', 'Mal-STL61', 'Test11', 9626262427, 'arulece05@gmail.com', NULL, 125, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 125, 'Active', 'Mal-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, NULL, NULL),
('Malar_Appa', '2025-07-01', 'Mal-23', 'Mal-STL17', 'Senthil_Vaduvatti', 9790556575, NULL, NULL, 300000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 300000, 0, 'Closed', 'Mal-P2', 'Cash', 'paid during june month int rece 1780 june gpay', 'Per_Month', 800, NULL, NULL, NULL),
('Malar_Finance', '2025-08-19', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, NULL, NULL, 50000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'Mal-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, NULL, NULL),
('Malar_Finance', '2025-08-19', 'Mal-25', 'Mal-STL20', 'Priya', 9976592192, NULL, NULL, 200000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'Mal-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, NULL, NULL),
('Malar_Finance', '2025-08-19', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, NULL, NULL, 250000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 250000, 'Active', 'Mal-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, NULL, NULL),
('Malar_Finance', '2025-08-19', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, NULL, NULL, 100000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'Mal-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, NULL, NULL),
('Chit_Malar', '2026-04-16', 'Chi-28', 'Chi-STL1', 'Pradeep', 9626262427, NULL, NULL, 60000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60000, 'Active', 'Chi-P1', 'Cash', 'Given to kannan to close pradeep loan', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL1-Pradeep'),
('Chit_Malar', '2026-04-18', 'Chi-29', 'Chi-STL1', 'Pradeep', 9626262427, NULL, NULL, 40000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 40000, 'Active', 'Chi-P1', 'UPI', 'Adjusted 30k in sundaravadivel loan and 10k to kozhi', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL1-Pradeep'),
('Chit_Malar', '2026-04-20', 'Chi-30', 'Chi-STL1', 'Pradeep', 9626262427, NULL, NULL, 50000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'Chi-P1', 'Other', 'Adjusted to kannan 20k, 30k gpay', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL1-Pradeep'),
('Chit_Malar', '2026-05-11', 'Chi-31', 'Chi-STL2', 'Priya', 9976592192, NULL, NULL, 80000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 80000, 'Active', 'Chi-P1', 'UPI', '60k by cash murali to kannan, 20k by gpay to ramya thangavel', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL2-Priya'),
('Chit_Malar', '2026-04-15', 'Chi-32', 'Chi-STL3', 'Palanisamy', 7010457994, NULL, NULL, 300000, 50, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300000, 'Active', 'Chi-P1', 'Other', 'By Ramkumar', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL3-Palanisamy'),
('Chit_Malar', '2026-05-20', 'Chi-33', 'Chi-STL3', 'Palanisamy', 7010457994, NULL, NULL, 200000, 50, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200000, 'Active', 'Chi-P1', 'Cash', 'THROUGH DOLPHIN SIVA', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL3-Palanisamy'),
('Kannan_Finance', '2026-05-01', 'Kan-34', 'Kan-STL1', 'Ramasamy divya', 9787878005, NULL, NULL, 50000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL1-Ramasamy divya'),
('Kannan_Finance', '2026-05-01', 'Kan-35', 'Kan-STL2', 'Sundaravadivel', 9626262427, NULL, NULL, 100000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL2-Sundaravadivel'),
('Kannan_Finance', '2026-05-01', 'Kan-36', 'Kan-STL3', 'Suresh Balu vangap', 9626262427, NULL, NULL, 300000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL3-Suresh Balu vangap'),
('Kannan_Finance', '2026-05-01', 'Kan-37', 'Kan-STL4', 'Nagaraj post', 9626262427, NULL, NULL, 30000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL4-Nagaraj post'),
('Kannan_Finance', '2026-05-01', 'Kan-38', 'Kan-STL5', 'Priya', 9626262427, NULL, NULL, 300000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 290000, 10000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL5-Priya'),
('Kannan_Finance', '2026-05-01', 'Kan-39', 'Kan-STL6', 'Chathiram amma', 9626262427, NULL, NULL, 30000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL6-Chathiram amma'),
('Kannan_Finance', '2026-05-01', 'Kan-40', 'Kan-STL7', 'Arul', 9626262427, NULL, NULL, 25000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 25000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL7-Arul'),
('Kannan_Finance', '2026-05-01', 'Kan-41', 'Kan-STL8', 'Manoj', 9626262427, NULL, NULL, 10000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL8-Manoj'),
('Kannan_Finance', '2026-05-01', 'Kan-42', 'Kan-STL9', 'Surya vangap', 9626262427, NULL, NULL, 140000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 140000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL9-Surya vangap'),
('Kannan_Finance', '2026-05-16', 'Kan-43', 'Kan-STL5', 'Priya', 9626262427, NULL, NULL, 150000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 40000, 110000, 'Active', 'Kan-P1', 'Other', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL5-Priya'),
('Chit_Malar', '2026-05-23', 'Chi-44', 'Chi-STL2', 'Priya', 9976592192, NULL, NULL, 150000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150000, 'Active', 'Chi-P1', 'Other', 'Kannan fin', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL2-Priya'),
('Chit_Malar', '2026-05-25', 'Chi-45', 'Chi-STL4', 'Surrendar Puthur', 9043436792, NULL, NULL, 600000, 50, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 400000, 'Active', 'Chi-P1', 'Cash', 'given to surrendar mamanar', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL4-Surrendar Puthur'),
('Chit_Malar', '2026-05-28', 'Chi-46', 'Chi-STL3', 'Palanisamy', 7010457994, NULL, NULL, 200000, 50, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200000, 'Active', 'Chi-P1', 'Cash', 'Through his appa', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL3-Palanisamy'),
('Chit_Malar', '2026-05-28', 'Chi-47', 'Chi-STL5', 'Elango manmangalam', 9943831310, NULL, NULL, 100000, 50, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'Chi-P1', 'Cash', 'Though mathi', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL5-Elango manmangalam'),
('Chit_Malar', '2026-05-28', 'Chi-48', 'Chi-STL6', 'Nagaraj refill', 9626262427, NULL, NULL, 50000, 42, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'Chi-P1', 'Cash', NULL, 'Per_Month', 1250, NULL, 'Existing', 'Chi-STL6-Nagaraj refill'),
('Chit_Malar', '2026-05-28', 'Chi-49', 'Chi-STL7', 'Ramkumar', 9578562182, NULL, NULL, 150000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150000, 'Active', 'Chi-P1', 'Account', 'Thangavel 50+30+20, anand 47, gpay 3000', 'Per_Month', 1250, NULL, 'Existing', 'Chi-STL7-Ramkumar'),
('Chit_Malar', '2026-06-03', 'Chi-50', 'Chi-STL8', 'Arul Personal', 9626262427, NULL, NULL, 50000, 60, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'Chi-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL8-Arul Personal'),
('Kannan_Finance', '2026-06-01', 'Kan-51', 'Kan-STL5', 'Priya', 9626262427, NULL, NULL, 200000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL5-Priya'),
('Chit_Malar', '2026-06-03', 'Chi-51', 'Chi-STL9', 'Tharun kannan', 9843722055, NULL, NULL, 200000, 50, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200000, 'Active', 'Chi-P1', 'Cash', 'Ramkumar', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL9-Tharun kannan'),
('Chit_Malar', '2026-06-04', 'Chi-53', 'Chi-STL7', 'Ramkumar', 9578562182, NULL, NULL, 200000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 100000, 'Active', 'Chi-P1', 'Cash', '6l by surrendar mamanar, 4l to surrendar, 2l to ramkumar', 'Per_Month', 1250, NULL, 'Existing', 'Chi-STL7-Ramkumar'),
('Chit_Malar', '2026-06-01', 'Chi-54', 'Chi-STL2', 'Priya', 9976592192, NULL, NULL, 60000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60000, 'Active', 'Chi-P1', 'UPI', 'adjusted to kannan in loan of 2lakh', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL2-Priya'),
('Chit_Malar', '2026-07-03', 'Chi-55', 'Chi-STL2', 'Priya', 9976592192, NULL, NULL, 50000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'Chi-P1', 'UPI', 'Upi', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL2-Priya'),
('Chit_Malar', '2026-07-03', 'Chi-56', 'Chi-STL10', 'Rajesh post office', 9994922299, NULL, NULL, 500000, 50, NULL, NULL, NULL, NULL, NULL, NULL, 0, 500000, 'Active', 'Chi-P1', 'Cash', 'By kannan prakash', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL10-Rajesh post office'),
('Malar_Finance', '2026-07-01', 'Mal-57', 'Mal-STL14', 'Ramkumar', 9578562182, NULL, NULL, 500000, 33.33, NULL, NULL, NULL, NULL, NULL, NULL, 0, 500000, 'Active', 'Mal-P1', 'Other', 'for chit by malar', 'Per_Day', NULL, NULL, 'Existing', 'Mal-STL14-Ramkumar'),
('Chit_Malar', '2026-07-31', 'Chi-58', 'Chi-STL2', 'Priya', 9976592192, NULL, NULL, 40000, 70, NULL, NULL, NULL, NULL, NULL, NULL, 0, 40000, 'Active', 'Chi-P1', 'Other', 'adjusted with kannan finance on 30th', 'Per_Day', NULL, NULL, 'Existing', 'Chi-STL2-Priya');
alter table "Loan_Processing" enable row level security;
create policy "read_all_Loan_Processing" on "Loan_Processing" for select using (true);

drop table if exists "Interest_Details" cascade;
create table "Interest_Details" ("ID" text, "Finance_Name" text, "Loan_No" text, "Customer_STL_NO" text, "Customer_Name" text, "Customer_Phone_No" numeric, "From_Date" text, "To_Date" text, "Actual_From_Date" text, "No_Days" numeric, "Interest_Per_day_Per_Lakh" text, "Interest_Amount" numeric, "Loan_Amount" numeric, "Loan_Given_Date" text, "Month" text, "Description" text, "Amount_Received" numeric, "Status" text, "Interest_Pending" numeric, "Referred_Partner" text, "Pending_Month_Interest" numeric, "Eligible" text, "Total_Month_Interest" numeric, "Total_Loan_Amount" numeric, "Interest_Type" text, "Interest_Per_Month_Per_Lakh" numeric, "Total_Month_Days" numeric, "col27" text);
insert into "Interest_Details" ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days", "col27") values
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-04-2025', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2025-04-01', '2025-04-30', '2025-04-01', 30, '70', 2100, 100000, '2024-01-01', '04-2025', 'Interest-04-2025', 2100, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2100, 0, 'Per_Day', 0, 30, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-04-2025', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2025-04-01', '2025-04-30', '2025-04-01', 30, '70', 8400, 400000, '2024-04-10', '04-2025', 'Interest-04-2025', 8400, 'Paid', 0, 'Mal-P1', 0, 'Yes', 8400, 0, 'Per_Day', 0, 30, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-04-2025', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2025-04-01', '2025-04-30', '2025-04-01', 30, '80', 6480, 270000, '2025-01-01', '04-2025', 'Interest-04-2025', 6480, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6480, 0, 'Per_Day', 0, 30, NULL),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-04-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-04-01', '2025-04-30', '2025-04-01', 30, '60', 6300, 350000, '2025-01-01', '04-2025', 'Interest-04-2025', 6300, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6300, 0, 'Per_Day', 1800, 30, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-05-2025', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2025-05-01', '2025-05-31', '2025-05-01', 31, '70', 2170, 100000, '2024-01-01', '05-2025', 'Interest-05-2025', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-05-2025', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2025-05-01', '2025-05-31', '2025-05-01', 31, '70', 8680, 400000, '2024-04-10', '05-2025', 'Interest-05-2025', 8680, 'Paid', 0, 'Mal-P1', 0, 'Yes', 8680, 0, 'Per_Day', 0, 31, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-05-2025', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2025-05-01', '2025-05-31', '2025-05-01', 31, '80', 6696, 270000, '2025-01-01', '05-2025', 'Interest-05-2025', 6696, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6696, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-05-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-05-01', '2025-05-31', '2025-05-01', 31, '60', 6510, 350000, '2025-01-01', '05-2025', 'Interest-05-2025', 6510, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6510, 0, 'Per_Day', 1800, 31, NULL),
('Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-03-2025', 'Malar_Appa', 'Mal-7', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-03-01', '2025-03-31', '2025-03-31', 1, '26.67', 387, 1500000, '2025-03-31', '03-2025', 'Interest-03-2025', 387, 'Paid', 0, 'Mal-P1', 0, 'Yes', 387, 0, 'Per_Month', 800, 31, NULL),
('Pradeep-Mal-STL15-Mal-18-100000-Interest-03-2025', 'Malar_Appa', 'Mal-18', 'Mal-STL15', 'Pradeep', 9994009257, '2025-03-01', '2025-03-31', '2025-03-01', 31, '70', 2170, 100000, '2025-01-01', '03-2025', 'Interest-03-2025', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Amuthavel-Mal-STL16-Mal-19-100000-Interest-03-2025', 'Malar_Appa', 'Mal-19', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-03-01', '2025-03-31', '2025-03-30', 2, '0', 0, 100000, '2025-03-30', '03-2025', 'Interest-03-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 31, NULL),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-04-2025', 'Malar_Appa', 'Mal-1', 'Mal-STL1', 'Chandrasekaran1', 7092355445, '2025-04-01', '2025-04-30', '2025-04-21', 10, '70', 1400, 200000, '2025-04-21', '04-2025', 'Interest-04-2025', 1400, 'Paid', 0, 'Mal-P1', 0, 'Yes', 1400, 0, 'Per_Day', 0, 30, NULL),
('Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-04-2025', 'Malar_Appa', 'Mal-7', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-04-01', '2025-04-30', '2025-04-01', 30, '26.67', 12000, 1500000, '2025-03-31', '04-2025', 'Interest-04-2025', 12000, 'Paid', 0, 'Mal-P1', 0, 'Yes', 12160, 0, 'Per_Month', 800, 30, NULL),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-04-2025', 'Malar_Appa', 'Mal-8', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-04-01', '2025-04-30', '2025-04-29', 2, '26.67', 160, 300000, '2025-04-29', '04-2025', 'Interest-04-2025', 160, 'Paid', 0, 'Mal-P1', 0, 'No', 12160, 0, 'Per_Month', 800, 30, NULL),
('Elango1-Mal-STL5-Mal-12-600000-Interest-04-2025', 'Malar_Appa', 'Mal-12', 'Mal-STL5', 'Elango1', 9943831310, '2025-04-01', '2025-04-30', '2025-04-02', 29, '0', 0, 600000, '2025-04-02', '04-2025', 'Interest-04-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 30, NULL),
('Palanisamy1-Mal-STL4-Mal-14-1000000-Interest-04-2025', 'Malar_Appa', 'Mal-14', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-04-01', '2025-04-30', '2025-04-15', 16, '26.67', 4267, 1000000, '2025-04-15', '04-2025', 'Interest-04-2025', 4267, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4267, 0, 'Per_Month', 800, 30, NULL),
('Pradeep-Mal-STL15-Mal-18-100000-Interest-04-2025', 'Malar_Appa', 'Mal-18', 'Mal-STL15', 'Pradeep', 9994009257, '2025-04-01', '2025-04-30', '2025-04-01', 30, '70', 2100, 100000, '2025-01-01', '04-2025', 'Interest-04-2025', 2100, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2100, 0, 'Per_Day', 0, 30, NULL),
('Amuthavel-Mal-STL16-Mal-19-100000-Interest-04-2025', 'Malar_Appa', 'Mal-19', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-04-01', '2025-04-30', '2025-04-01', 30, '0', 0, 100000, '2025-03-30', '04-2025', 'Interest-04-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 30, NULL),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-05-2025', 'Malar_Appa', 'Mal-1', 'Mal-STL1', 'Chandrasekaran1', 7092355445, '2025-05-01', '2025-05-31', '2025-05-01', 31, '70', 4340, 200000, '2025-04-21', '05-2025', 'Interest-05-2025', 4340, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4340, 0, 'Per_Day', 0, 31, NULL),
('Balu1-Mal-STL10-Mal-4-50000-Interest-05-2025', 'Malar_Appa', 'Mal-4', 'Mal-STL10', 'Balu1', 9976592192, '2025-05-01', '2025-05-31', '2025-05-30', 2, '70', 70, 50000, '2025-05-30', '05-2025', 'Interest-05-2025', 140, 'Pending', -70, 'Mal-P1', -70, 'Yes', 70, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-05-2025', 'Malar_Appa', 'Mal-7', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-05-01', '2025-05-31', '2025-05-01', 31, '26.67', 12000, 1500000, '2025-03-31', '05-2025', 'Interest-05-2025', 12000, 'Paid', 0, 'Mal-P1', 0, 'Yes', 14529, 0, 'Per_Month', 800, 31, NULL),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-05-2025', 'Malar_Appa', 'Mal-8', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-05-01', '2025-05-31', '2025-05-01', 31, '26.67', 2400, 300000, '2025-04-29', '05-2025', 'Interest-05-2025', 2400, 'Paid', 0, 'Mal-P1', 0, 'No', 14529, 0, 'Per_Month', 800, 31, NULL),
('Ramkumar1-Mal-STL2-Mal-9-500000-Interest-05-2025', 'Malar_Appa', 'Mal-9', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-05-01', '2025-05-31', '2025-05-31', 1, '26.67', 129, 500000, '2025-05-31', '05-2025', 'Interest-05-2025', 129, 'Paid', 0, 'Mal-P1', 0, 'No', 14529, 0, 'Per_Month', 800, 31, NULL),
('Kannan1-Mal-STL3-Mal-10-500000-Interest-05-2025', 'Malar_Appa', 'Mal-10', 'Mal-STL3', 'Kannan1', 9626262427, '2025-05-01', '2025-05-31', '2025-05-17', 15, '0', 1935, 500000, '2025-05-17', '05-2025', 'Interest-05-2025', 1935, 'Paid', 0, 'Mal-P1', 0, 'Yes', 1935, 0, 'Per_Month', 800, 31, NULL),
('Elango1-Mal-STL5-Mal-12-600000-Interest-05-2025', 'Malar_Appa', 'Mal-12', 'Mal-STL5', 'Elango1', 9943831310, '2025-05-01', '2025-05-31', '2025-05-01', 31, '0', 0, 600000, '2025-04-02', '05-2025', 'Interest-05-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 31, NULL),
('AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-05-2025', 'Malar_Appa', 'Mal-13', 'Mal-STL6', 'AshokFinance1', 9626262427, '2025-05-01', '2025-05-31', '2025-05-05', 27, '33.33', 8710, 1000000, '2025-05-05', '05-2025', 'Interest-05-2025', 8710, 'Paid', 0, 'Mal-P1', 0, 'Yes', 8710, 0, 'Per_Month', 1000, 31, NULL),
('Palanisamy1-Mal-STL4-Mal-14-1000000-Interest-05-2025', 'Malar_Appa', 'Mal-14', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-05-01', '2025-05-31', '2025-05-01', 31, '26.67', 8000, 1000000, '2025-04-15', '05-2025', 'Interest-05-2025', 8000, 'Paid', 0, 'Mal-P1', 0, 'Yes', 10839, 0, 'Per_Month', 800, 31, NULL),
('Palanisamy1-Mal-STL4-Mal-15-500000-Interest-05-2025', 'Malar_Appa', 'Mal-15', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-05-01', '2025-05-31', '2025-05-10', 22, '26.67', 2839, 500000, '2025-05-10', '05-2025', 'Interest-05-2025', 2839, 'Paid', 0, 'Mal-P1', 0, 'No', 10839, 0, 'Per_Month', 800, 31, NULL),
('Akpr1-Mal-STL7-Mal-16-5850000-Interest-05-2025', 'Malar_Appa', 'Mal-16', 'Mal-STL7', 'Akpr1', 9894205641, '2025-05-01', '2025-05-31', '2025-05-31', 1, '26.67', 1510, 5850000, '2025-05-31', '05-2025', 'Interest-05-2025', 1510, 'Paid', 0, 'Mal-P1', 0, 'Yes', 1510, 0, 'Per_Month', 800, 31, NULL),
('Mahesh1-Mal-STL8-Mal-17-250000-Interest-05-2025', 'Malar_Appa', 'Mal-17', 'Mal-STL8', 'Mahesh1', 9003756295, '2025-05-01', '2025-05-31', '2025-05-19', 13, '70', 2275, 250000, '2025-05-19', '05-2025', 'Interest-05-2025', 2275, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2275, 0, 'Per_Day', 0, 31, NULL),
('Pradeep-Mal-STL15-Mal-18-100000-Interest-05-2025', 'Malar_Appa', 'Mal-18', 'Mal-STL15', 'Pradeep', 9994009257, '2025-05-01', '2025-05-31', '2025-05-01', 31, '70', 2170, 100000, '2025-01-01', '05-2025', 'Interest-05-2025', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Amuthavel-Mal-STL16-Mal-19-100000-Interest-05-2025', 'Malar_Appa', 'Mal-19', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-05-01', '2025-05-31', '2025-05-01', 31, '0', 0, 100000, '2025-03-30', '05-2025', 'Interest-05-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 31, NULL),
('Amuthavel-Mal-STL16-Mal-21-350000-Interest-05-2025', 'Malar_Appa', 'Mal-21', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-05-01', '2025-05-31', '2025-05-01', 31, '0', 0, 350000, '2025-05-01', '05-2025', 'Interest-05-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'No', 0, 0, 'Per_Month', 0, 31, NULL),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-06-2025', 'Malar_Appa', 'Mal-1', 'Mal-STL1', 'Chandrasekaran1', 7092355445, '2025-06-01', '2025-06-30', '2025-06-01', 30, '70', 4200, 200000, '2025-04-21', '06-2025', 'Interest-06-2025', 4200, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4200, 0, 'Per_Day', 0, 30, NULL),
('Balu1-Mal-STL10-Mal-4-50000-Interest-06-2025', 'Malar_Appa', 'Mal-4', 'Mal-STL10', 'Balu1', 9976592192, '2025-06-01', '2025-06-30', '2025-06-01', 30, '70', 1050, 50000, '2025-05-30', '06-2025', 'Interest-06-2025', 2100, 'Pending', -1050, 'Mal-P1', -1050, 'Yes', 1050, 0, 'Per_Day', 0, 30, NULL),
('Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-06-2025', 'Malar_Appa', 'Mal-7', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-06-01', '2025-06-30', '2025-06-01', 30, '26.67', 12000, 1500000, '2025-03-31', '06-2025', 'Interest-06-2025', 12000, 'Paid', 0, 'Mal-P1', 0, 'Yes', 18400, 0, 'Per_Month', 800, 30, NULL),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-06-2025', 'Malar_Appa', 'Mal-8', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-06-01', '2025-06-30', '2025-06-01', 30, '26.67', 2400, 300000, '2025-04-29', '06-2025', 'Interest-06-2025', 2400, 'Paid', 0, 'Mal-P1', 0, 'No', 18400, 0, 'Per_Month', 800, 30, NULL),
('Ramkumar1-Mal-STL2-Mal-9-500000-Interest-06-2025', 'Malar_Appa', 'Mal-9', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-06-01', '2025-06-30', '2025-06-01', 30, '26.67', 4000, 500000, '2025-05-31', '06-2025', 'Interest-06-2025', 4000, 'Paid', 0, 'Mal-P1', 0, 'No', 18400, 0, 'Per_Month', 800, 30, NULL),
('Kannan1-Mal-STL3-Mal-10-500000-Interest-06-2025', 'Malar_Appa', 'Mal-10', 'Mal-STL3', 'Kannan1', 9626262427, '2025-06-01', '2025-06-30', '2025-06-01', 30, '0', 4000, 500000, '2025-05-17', '06-2025', 'Interest-06-2025', 4000, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4000, 0, 'Per_Month', 800, 30, NULL),
('Priya1-Mal-STL9-Mal-11-200000-Interest-06-2025', 'Malar_Appa', 'Mal-11', 'Mal-STL9', 'Priya1', 9626262427, '2025-06-01', '2025-06-30', '2025-06-04', 27, '70', 3780, 200000, '2025-06-04', '06-2025', 'Interest-06-2025', 3780, 'Paid', 0, 'Mal-P1', 0, 'Yes', 3780, 0, 'Per_Day', 0, 30, NULL),
('Elango1-Mal-STL5-Mal-12-600000-Interest-06-2025', 'Malar_Appa', 'Mal-12', 'Mal-STL5', 'Elango1', 9943831310, '2025-06-01', '2025-06-30', '2025-06-01', 30, '0', 0, 600000, '2025-04-02', '06-2025', 'Interest-06-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 30, NULL),
('AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-06-2025', 'Malar_Appa', 'Mal-13', 'Mal-STL6', 'AshokFinance1', 9626262427, '2025-06-01', '2025-06-30', '2025-06-01', 30, '33.33', 10000, 1000000, '2025-05-05', '06-2025', 'Interest-06-2025', 10000, 'Paid', 0, 'Mal-P1', 0, 'Yes', 10000, 0, 'Per_Month', 1000, 30, NULL),
('Palanisamy1-Mal-STL4-Mal-14-1000000-Interest-06-2025', 'Malar_Appa', 'Mal-14', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-06-01', '2025-06-30', '2025-06-01', 30, '26.67', 8000, 1000000, '2025-04-15', '06-2025', 'Interest-06-2025', 8000, 'Paid', 0, 'Mal-P1', 0, 'Yes', 12000, 0, 'Per_Month', 800, 30, NULL),
('Palanisamy1-Mal-STL4-Mal-15-500000-Interest-06-2025', 'Malar_Appa', 'Mal-15', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-06-01', '2025-06-30', '2025-06-01', 30, '26.67', 4000, 500000, '2025-05-10', '06-2025', 'Interest-06-2025', 4000, 'Paid', 0, 'Mal-P1', 0, 'No', 12000, 0, 'Per_Month', 800, 30, NULL),
('Akpr1-Mal-STL7-Mal-16-5850000-Interest-06-2025', 'Malar_Appa', 'Mal-16', 'Mal-STL7', 'Akpr1', 9894205641, '2025-06-01', '2025-06-30', '2025-06-01', 30, '26.67', 46800, 5850000, '2025-05-31', '06-2025', 'Interest-06-2025', 46800, 'Paid', 0, 'Mal-P1', 0, 'Yes', 46800, 0, 'Per_Month', 800, 30, NULL),
('Mahesh1-Mal-STL8-Mal-17-250000-Interest-06-2025', 'Malar_Appa', 'Mal-17', 'Mal-STL8', 'Mahesh1', 9003756295, '2025-06-01', '2025-06-30', '2025-06-01', 30, '70', 5250, 250000, '2025-05-19', '06-2025', 'Interest-06-2025', 5250, 'Paid', 0, 'Mal-P1', 0, 'Yes', 5250, 0, 'Per_Day', 0, 30, NULL),
('Pradeep-Mal-STL15-Mal-18-100000-Interest-06-2025', 'Malar_Appa', 'Mal-18', 'Mal-STL15', 'Pradeep', 9994009257, '2025-06-01', '2025-06-30', '2025-06-01', 30, '70', 2100, 100000, '2025-01-01', '06-2025', 'Interest-06-2025', 0, 'Pending', 2100, 'Mal-P1', 2100, 'Yes', 2100, 0, 'Per_Day', 0, 30, NULL),
('Amuthavel-Mal-STL16-Mal-19-100000-Interest-06-2025', 'Malar_Appa', 'Mal-19', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-06-01', '2025-06-30', '2025-06-01', 30, '0', 0, 100000, '2025-03-30', '06-2025', 'Interest-06-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 30, NULL),
('Amuthavel-Mal-STL16-Mal-20-150000-Interest-06-2025', 'Malar_Appa', 'Mal-20', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-06-01', '2025-06-30', '2025-06-04', 27, '0', 0, 150000, '2025-06-04', '06-2025', 'Interest-06-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'No', 0, 0, 'Per_Month', 0, 30, NULL),
('Amuthavel-Mal-STL16-Mal-21-350000-Interest-06-2025', 'Malar_Appa', 'Mal-21', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-06-01', '2025-06-30', '2025-06-01', 30, '0', 0, 350000, '2025-05-01', '06-2025', 'Interest-06-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'No', 0, 0, 'Per_Month', 0, 30, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-06-2025', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2025-06-01', '2025-06-30', '2025-06-01', 30, '70', 2100, 100000, '2024-01-01', '06-2025', 'Interest-06-2025', 2100, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2100, 0, 'Per_Day', 0, 30, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-06-2025', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2025-06-01', '2025-06-30', '2025-06-01', 30, '70', 8400, 400000, '2024-04-10', '06-2025', 'Interest-06-2025', 8400, 'Paid', 0, 'Mal-P1', 0, 'Yes', 8400, 0, 'Per_Day', 0, 30, NULL),
('Orange_Tex-Mal-STL13-Mal-5-275000-Interest-06-2025', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2025-06-01', '2025-06-30', '2025-06-01', 30, '80', 6600, 275000, '2025-01-01', '06-2025', 'Interest-06-2025', 6600, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6600, 0, 'Per_Day', 0, 30, NULL),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-06-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-06-01', '2025-06-30', '2025-06-01', 30, '60', 6300, 350000, '2025-01-01', '06-2025', 'Interest-06-2025', 6300, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6300, 0, 'Per_Day', 1800, 30, NULL),
('Ramkumar1-Mal-STL2-Mal-7-1000000-Interest-08-2025', 'Malar_Appa', 'Mal-7', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-08-01', '2025-08-07', '2025-08-01', 7, '26.67', 1806, 1000000, '2025-03-31', '08-2025', 'Interest-08-2025', 1806, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6218, 0, 'Per_Month', 800, 31, NULL),
('Ramkumar1-Mal-STL2-Mal-7-500000-Interest-08-2025', 'Malar_Appa', 'Mal-7', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-08-01', '2025-08-12', '2025-08-01', 12, '26.67', 1548, 500000, '2025-03-31', '08-2025', 'Interest-08-2025', 1548, 'Paid', 0, 'Mal-P1', 0, 'No', 6218, 0, 'Per_Month', 800, 31, NULL),
('Ramkumar1-Mal-STL2-Mal-9-500000-Interest-08-2025', 'Malar_Appa', 'Mal-9', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-08-01', '2025-08-12', '2025-08-01', 12, '26.67', 1548, 500000, '2025-05-31', '08-2025', 'Interest-08-2025', 1548, 'Paid', 0, 'Mal-P1', 0, 'No', 6218, 0, 'Per_Month', 800, 31, NULL),
('Amuthavel-Mal-STL16-Mal-21-350000-Interest-07-2025', 'Malar_Appa', 'Mal-21', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-07-01', '2025-07-09', '2025-07-01', 9, '0', 0, 350000, '2025-05-01', '07-2025', 'Interest-07-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 31, NULL),
('Amuthavel-Mal-STL16-Mal-20-150000-Interest-07-2025', 'Malar_Appa', 'Mal-20', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-07-01', '2025-07-09', '2025-07-01', 9, '0', 0, 150000, '2025-06-04', '07-2025', 'Interest-07-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'No', 0, 0, 'Per_Month', 0, 31, NULL),
('Amuthavel-Mal-STL16-Mal-19-100000-Interest-07-2025', 'Malar_Appa', 'Mal-19', 'Mal-STL16', 'Amuthavel', 7373731825, '2025-07-01', '2025-07-09', '2025-07-01', 9, '0', 0, 100000, '2025-03-30', '07-2025', 'Interest-07-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'No', 0, 0, 'Per_Month', 0, 31, NULL),
('Palanisamy1-Mal-STL4-Mal-14-900000-Interest-07-2025', 'Malar_Appa', 'Mal-14', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-07-01', '2025-07-08', '2025-07-01', 9, '26.67', 1848, 900000, '2025-04-15', '07-2025', 'Interest-07-2025', 1848, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6648, 0, 'Per_Month', 800, 31, NULL),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-07-2025', 'Malar_Appa', 'Mal-1', 'Mal-STL1', 'Chandrasekaran1', 7092355445, '2025-07-01', '2025-07-31', '2025-07-01', 31, '70', 4340, 200000, '2025-04-21', '07-2025', 'Interest-07-2025', 4340, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4340, 0, 'Per_Day', 0, 31, NULL),
('Balu1-Mal-STL10-Mal-4-50000-Interest-07-2025', 'Malar_Appa', 'Mal-4', 'Mal-STL10', 'Balu1', 9976592192, '2025-07-01', '2025-07-31', '2025-07-01', 31, '70', 1085, 50000, '2025-05-30', '07-2025', 'Interest-07-2025', 2170, 'Pending', -1085, 'Mal-P1', -1085, 'Yes', 1085, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-07-2025', 'Malar_Appa', 'Mal-8', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-07-01', '2025-07-31', '2025-07-01', 31, '26.67', 2400, 300000, '2025-04-29', '07-2025', 'Interest-07-2025', 2400, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2400, 0, 'Per_Month', 800, 31, NULL),
('Kannan1-Mal-STL3-Mal-10-500000-Interest-07-2025', 'Malar_Appa', 'Mal-10', 'Mal-STL3', 'Kannan1', 9626262427, '2025-07-01', '2025-07-31', '2025-07-01', 31, '0', 4000, 500000, '2025-05-17', '07-2025', 'Interest-07-2025', 4000, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4000, 0, 'Per_Month', 800, 31, NULL),
('Priya1-Mal-STL9-Mal-11-200000-Interest-07-2025', 'Malar_Appa', 'Mal-11', 'Mal-STL9', 'Priya1', 9626262427, '2025-07-01', '2025-07-31', '2025-07-01', 31, '70', 4340, 200000, '2025-06-04', '07-2025', 'Interest-07-2025', 4340, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4340, 0, 'Per_Day', 0, 31, NULL),
('Elango1-Mal-STL5-Mal-12-600000-Interest-07-2025', 'Malar_Appa', 'Mal-12', 'Mal-STL5', 'Elango1', 9943831310, '2025-07-01', '2025-07-31', '2025-07-01', 31, '0', 0, 600000, '2025-04-02', '07-2025', 'Interest-07-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 31, NULL),
('AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-07-2025', 'Malar_Appa', 'Mal-13', 'Mal-STL6', 'AshokFinance1', 9626262427, '2025-07-01', '2025-07-31', '2025-07-01', 31, '33.33', 10000, 1000000, '2025-05-05', '07-2025', 'Interest-07-2025', 10000, 'Paid', 0, 'Mal-P1', 0, 'Yes', 10000, 0, 'Per_Month', 1000, 31, NULL),
('Palanisamy1-Mal-STL4-Mal-15-500000-Interest-07-2025', 'Malar_Appa', 'Mal-15', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-07-01', '2025-07-31', '2025-07-01', 31, '26.67', 4000, 500000, '2025-05-10', '07-2025', 'Interest-07-2025', 4000, 'Paid', 0, 'Mal-P1', 0, 'No', 6648, 0, 'Per_Month', 800, 31, NULL),
('Akpr1-Mal-STL7-Mal-16-5850000-Interest-07-2025', 'Malar_Appa', 'Mal-16', 'Mal-STL7', 'Akpr1', 9894205641, '2025-07-01', '2025-07-31', '2025-07-01', 31, '26.67', 46800, 5850000, '2025-05-31', '07-2025', 'Interest-07-2025', 46800, 'Paid', 0, 'Mal-P1', 0, 'Yes', 46800, 0, 'Per_Month', 800, 31, NULL),
('Mahesh1-Mal-STL8-Mal-17-250000-Interest-07-2025', 'Malar_Appa', 'Mal-17', 'Mal-STL8', 'Mahesh1', 9003756295, '2025-07-01', '2025-07-31', '2025-07-01', 31, '70', 5425, 250000, '2025-05-19', '07-2025', 'Interest-07-2025', 3150, 'Pending', 2275, 'Mal-P1', 2275, 'Yes', 5425, 0, 'Per_Day', 0, 31, NULL),
('Pradeep-Mal-STL15-Mal-18-100000-Interest-07-2025', 'Malar_Appa', 'Mal-18', 'Mal-STL15', 'Pradeep', 9994009257, '2025-07-01', '2025-07-31', '2025-07-01', 31, '70', 2170, 100000, '2025-01-01', '07-2025', 'Interest-07-2025', 0, 'Pending', 2170, 'Mal-P1', 2170, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Senthil_Vaduvatti-Mal-STL17-Mal-23-300000-Interest-07-2025', 'Malar_Appa', 'Mal-23', 'Mal-STL17', 'Senthil_Vaduvatti', 9790556575, '2025-07-01', '2025-07-31', '2025-07-01', 31, NULL, 2400, 300000, '2025-07-01', '07-2025', 'Interest-07-2025', 2400, 'Paid', 0, 'Mal-P2', 0, 'Yes', 2400, 0, 'Per_Month', 800, 31, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-07-2025', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2025-07-01', '2025-07-31', '2025-07-01', 31, '70', 2170, 100000, '2024-01-01', '07-2025', 'Interest-07-2025', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-07-2025', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2025-07-01', '2025-07-31', '2025-07-01', 31, '70', 8680, 400000, '2024-04-10', '07-2025', 'Interest-07-2025', 8680, 'Paid', 0, 'Mal-P1', 0, 'Yes', 8680, 0, 'Per_Day', 0, 31, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-07-2025', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2025-07-01', '2025-07-31', '2025-07-01', 31, '80', 6696, 270000, '2025-01-01', '07-2025', 'Interest-07-2025', 6696, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6696, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-07-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-07-01', '2025-07-31', '2025-07-01', 31, '60', 6510, 350000, '2025-01-01', '07-2025', 'Interest-07-2025', 6510, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6510, 0, 'Per_Day', 1800, 31, NULL),
('Palanisamy1-Mal-STL4-Mal-15-500000-Interest-08-2025', 'Malar_Appa', 'Mal-15', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-08-01', '2025-08-17', '2025-08-01', 17, '26.67', 2194, 500000, '2025-05-10', '08-2025', 'Interest-08-2025', 2194, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2633, 0, 'Per_Month', 800, 31, NULL),
('Palanisamy1-Mal-STL4-Mal-14-100000-Interest-07-2025', 'Malar_Appa', 'Mal-14', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-07-01', '2025-07-31', '2025-07-01', 31, '26.67', 800, 100000, '2025-04-15', '07-2025', 'Interest-07-2025', 800, 'Paid', 0, 'Mal-P1', 0, 'No', 6648, 0, 'Per_Month', 800, 31, NULL),
('Palanisamy1-Mal-STL4-Mal-14-100000-Interest-08-2025', 'Malar_Appa', 'Mal-14', 'Mal-STL4', 'Palanisamy1', 7010457994, '2025-08-01', '2025-08-17', '2025-08-01', 17, '26.67', 439, 100000, '2025-04-15', '08-2025', 'Interest-08-2025', 439, 'Paid', 0, 'Mal-P1', 0, 'No', 2633, 0, 'Per_Month', 800, 31, NULL),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-08-2025', 'Malar_Appa', 'Mal-8', 'Mal-STL2', 'Ramkumar1', 9578562182, '2025-08-01', '2025-08-17', '2025-08-01', 17, '26.67', 1316, 300000, '2025-04-29', '08-2025', 'Interest-08-2025', 1316, 'Paid', 0, 'Mal-P1', 0, 'No', 6218, 0, 'Per_Month', 800, 31, NULL),
('Akpr1-Mal-STL7-Mal-16-5850000-Interest-08-2025', 'Malar_Appa', 'Mal-16', 'Mal-STL7', 'Akpr1', 9894205641, '2025-08-01', '2025-08-19', '2025-08-01', 19, '26.67', 28684, 5850000, '2025-05-31', '08-2025', 'Interest-08-2025', 28684, 'Paid', 0, 'Mal-P1', 0, 'Yes', 28684, 0, 'Per_Month', 800, 31, NULL),
('Elango1-Mal-STL5-Mal-12-600000-Interest-08-2025', 'Malar_Appa', 'Mal-12', 'Mal-STL5', 'Elango1', 9943831310, '2025-08-01', '2025-08-19', '2025-08-01', 19, '0', 0, 600000, '2025-04-02', '08-2025', 'Interest-08-2025', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Month', 0, 31, NULL),
('Kannan1-Mal-STL3-Mal-10-500000-Interest-08-2025', 'Malar_Appa', 'Mal-10', 'Mal-STL3', 'Kannan1', 9626262427, '2025-08-01', '2025-08-18', '2025-08-01', 18, '0', 2323, 500000, '2025-05-17', '08-2025', 'Interest-08-2025', 2323, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2323, 0, 'Per_Month', 800, 31, NULL),
('AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-08-2025', 'Malar_Appa', 'Mal-13', 'Mal-STL6', 'AshokFinance1', 9626262427, '2025-08-01', '2025-08-15', '2025-08-01', 15, '33.33', 4839, 1000000, '2025-05-05', '08-2025', 'Interest-08-2025', 4839, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4839, 0, 'Per_Month', 1000, 31, NULL),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-08-2025', 'Malar_Appa', 'Mal-1', 'Mal-STL1', 'Chandrasekaran1', 7092355445, '2025-08-01', '2025-08-18', '2025-08-01', 18, '70', 2520, 200000, '2025-04-21', '08-2025', 'Interest-08-2025', 2520, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2520, 0, 'Per_Day', 0, 31, NULL),
('Balu1-Mal-STL10-Mal-4-50000-Interest-08-2025', 'Malar_Appa', 'Mal-4', 'Mal-STL10', 'Balu1', 9976592192, '2025-08-01', '2025-08-19', '2025-08-01', 19, '70', 665, 50000, '2025-05-30', '08-2025', 'Interest-08-2025', 1330, 'Pending', -665, 'Mal-P1', -665, 'Yes', 665, 0, 'Per_Day', 0, 31, NULL),
('Priya1-Mal-STL9-Mal-11-200000-Interest-08-2025', 'Malar_Appa', 'Mal-11', 'Mal-STL9', 'Priya1', 9626262427, '2025-08-01', '2025-08-18', '2025-08-01', 18, '70', 2520, 200000, '2025-06-04', '08-2025', 'Interest-08-2025', 2520, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2520, 0, 'Per_Day', 0, 31, NULL),
('Mahesh1-Mal-STL8-Mal-17-250000-Interest-08-2025', 'Malar_Appa', 'Mal-17', 'Mal-STL8', 'Mahesh1', 9003756295, '2025-08-01', '2025-08-18', '2025-08-01', 18, '70', 3150, 250000, '2025-05-19', '08-2025', 'Interest-08-2025', 0, 'Pending', 3150, 'Mal-P1', 3150, 'Yes', 3150, 0, 'Per_Day', 0, 31, NULL),
('Pradeep-Mal-STL15-Mal-18-100000-Interest-08-2025', 'Malar_Appa', 'Mal-18', 'Mal-STL15', 'Pradeep', 9994009257, '2025-08-01', '2025-08-19', '2025-08-01', 19, '70', 1330, 100000, '2025-01-01', '08-2025', 'Interest-08-2025', 0, 'Pending', 1330, 'Mal-P1', 1330, 'Yes', 1330, 0, 'Per_Day', 0, 31, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-08-2025', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2025-08-01', '2025-08-31', '2025-08-01', 31, '70', 2170, 100000, '2024-01-01', '08-2025', 'Interest-08-2025', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-08-2025', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2025-08-01', '2025-08-31', '2025-08-01', 31, '70', 8680, 400000, '2024-04-10', '08-2025', 'Interest-08-2025', 8680, 'Paid', 0, 'Mal-P1', 0, 'Yes', 9135, 0, 'Per_Day', 0, 31, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-08-2025', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2025-08-01', '2025-08-31', '2025-08-01', 31, '80', 6696, 270000, '2025-01-01', '08-2025', 'Interest-08-2025', 6696, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6696, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-08-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-08-01', '2025-08-31', '2025-08-01', 31, '60', 6510, 350000, '2025-01-01', '08-2025', 'Interest-08-2025', 6510, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6510, 0, 'Per_Day', 1800, 31, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-08-2025', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2025-08-01', '2025-08-31', '2025-08-19', 13, '70', 455, 50000, '2025-08-19', '08-2025', 'Interest-08-2025', 455, 'Paid', 0, 'Mal-P1', 0, 'No', 9135, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Mal-STL20-Mal-25-200000-Interest-08-2025', 'Malar_Finance', 'Mal-25', 'Mal-STL20', 'Priya', 9976592192, '2025-08-01', '2025-08-31', '2025-08-19', 13, '70', 1820, 200000, '2025-08-19', '08-2025', 'Interest-08-2025', 1820, 'Paid', 0, 'Mal-P1', 0, 'Yes', 1820, 0, 'Per_Day', NULL, 31, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-08-2025', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2025-08-01', '2025-08-31', '2025-08-19', 13, '70', 2275, 250000, '2025-08-19', '08-2025', 'Interest-08-2025', 0, 'Pending', 2275, 'Mal-P1', 2275, 'Yes', 2275, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-08-2025', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2025-08-01', '2025-08-31', '2025-08-19', 13, '70', 910, 100000, '2025-08-19', '08-2025', 'Interest-08-2025', 910, 'Paid', 0, 'Mal-P1', 0, 'Yes', 910, 0, 'Per_Day', NULL, 31, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-09-2025', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2025-09-01', '2025-09-30', '2025-09-01', 30, '70', 2100, 100000, '2024-01-01', '09-2025', 'Interest-09-2025', 2100, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2100, 0, 'Per_Day', 0, 30, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-09-2025', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2025-09-01', '2025-09-30', '2025-09-01', 30, '70', 8400, 400000, '2024-04-10', '09-2025', 'Interest-09-2025', 8400, 'Paid', 0, 'Mal-P1', 0, 'Yes', 9450, 0, 'Per_Day', 0, 30, NULL);
insert into "Interest_Details" ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days", "col27") values
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-09-2025', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2025-09-01', '2025-09-30', '2025-09-01', 30, '80', 6480, 270000, '2025-01-01', '09-2025', 'Interest-09-2025', 6480, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6480, 0, 'Per_Day', 0, 30, NULL),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-09-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-09-01', '2025-09-30', '2025-09-01', 30, '60', 6300, 350000, '2025-01-01', '09-2025', 'Interest-09-2025', 6300, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6660, 0, 'Per_Day', 1800, 30, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-09-2025', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2025-09-01', '2025-09-30', '2025-09-01', 30, '70', 1050, 50000, '2025-08-19', '09-2025', 'Interest-09-2025', 1050, 'Paid', 0, 'Mal-P1', 0, 'No', 9450, 0, 'Per_Day', NULL, 30, NULL),
('Priya-Mal-STL20-Mal-25-200000-Interest-09-2025', 'Malar_Finance', 'Mal-25', 'Mal-STL20', 'Priya', 9976592192, '2025-09-01', '2025-09-30', '2025-09-01', 30, '70', 4200, 200000, '2025-08-19', '09-2025', 'Interest-09-2025', 4200, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4200, 0, 'Per_Day', NULL, 30, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-09-2025', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2025-09-01', '2025-09-30', '2025-09-01', 30, '70', 5250, 250000, '2025-08-19', '09-2025', 'Interest-09-2025', 0, 'Pending', 5250, 'Mal-P1', 5250, 'Yes', 5250, 0, 'Per_Day', NULL, 30, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-09-2025', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2025-09-01', '2025-09-30', '2025-09-01', 30, '70', 2100, 100000, '2025-08-19', '09-2025', 'Interest-09-2025', 2100, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2100, 0, 'Per_Day', NULL, 30, NULL),
('Ramkumar-Mal-STL14-Mal-6-100000-Interest-09-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-09-01', '2025-09-06', '2025-09-01', 6, '60', 360, 100000, '2025-01-01', '09-2025', 'Interest-09-2025', 360, 'Paid', 0, 'Mal-P1', 0, 'No', 6660, 0, 'Per_Day', 1800, 30, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-10-2025', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2025-10-01', '2025-10-31', '2025-10-01', 31, '70', 2170, 100000, '2024-01-01', '10-2025', 'Interest-10-2025', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-10-2025', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2025-10-01', '2025-10-31', '2025-10-01', 31, '70', 8680, 400000, '2024-04-10', '10-2025', 'Interest-10-2025', 8680, 'Paid', 0, 'Mal-P1', 0, 'Yes', 9765, 0, 'Per_Day', 0, 31, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-10-2025', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2025-10-01', '2025-10-31', '2025-10-01', 31, '80', 6696, 270000, '2025-01-01', '10-2025', 'Interest-10-2025', 6696, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6696, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-10-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-10-01', '2025-10-31', '2025-10-01', 31, '60', 4650, 250000, '2025-01-01', '10-2025', 'Interest-10-2025', 4650, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4650, 0, 'Per_Day', 1800, 31, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-10-2025', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2025-10-01', '2025-10-31', '2025-10-01', 31, '70', 1085, 50000, '2025-08-19', '10-2025', 'Interest-10-2025', 1085, 'Paid', 0, 'Mal-P1', 0, 'No', 9765, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Mal-STL20-Mal-25-200000-Interest-10-2025', 'Malar_Finance', 'Mal-25', 'Mal-STL20', 'Priya', 9976592192, '2025-10-01', '2025-10-31', '2025-10-01', 31, '70', 4340, 200000, '2025-08-19', '10-2025', 'Interest-10-2025', 4340, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4340, 0, 'Per_Day', NULL, 31, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-10-2025', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2025-10-01', '2025-10-31', '2025-10-01', 31, '70', 5425, 250000, '2025-08-19', '10-2025', 'Interest-10-2025', 0, 'Pending', 5425, 'Mal-P1', 5425, 'Yes', 5425, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-10-2025', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2025-10-01', '2025-10-31', '2025-10-01', 31, '70', 2170, 100000, '2025-08-19', '10-2025', 'Interest-10-2025', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', NULL, 31, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-11-2025', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2025-11-01', '2025-11-30', '2025-11-01', 30, '70', 2100, 100000, '2024-01-01', '11-2025', 'Interest-11-2025', 0, 'Pending', 2100, 'Mal-P1', 2100, 'Yes', 2100, 0, 'Per_Day', 0, 30, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-11-2025', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2025-11-01', '2025-11-30', '2025-11-01', 30, '70', 8400, 400000, '2024-04-10', '11-2025', 'Interest-11-2025', 8400, 'Paid', 0, 'Mal-P1', 0, 'Yes', 9450, 0, 'Per_Day', 0, 30, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-11-2025', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2025-11-01', '2025-11-30', '2025-11-01', 30, '80', 6480, 270000, '2025-01-01', '11-2025', 'Interest-11-2025', 6480, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6480, 0, 'Per_Day', 0, 30, NULL),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-11-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-11-01', '2025-11-30', '2025-11-01', 30, '60', 4500, 250000, '2025-01-01', '11-2025', 'Interest-11-2025', 4500, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4500, 0, 'Per_Day', 1800, 30, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-11-2025', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2025-11-01', '2025-11-30', '2025-11-01', 30, '70', 1050, 50000, '2025-08-19', '11-2025', 'Interest-11-2025', 1050, 'Paid', 0, 'Mal-P1', 0, 'No', 9450, 0, 'Per_Day', NULL, 30, NULL),
('Priya-Mal-STL20-Mal-25-200000-Interest-11-2025', 'Malar_Finance', 'Mal-25', 'Mal-STL20', 'Priya', 9976592192, '2025-11-01', '2025-11-30', '2025-11-01', 30, '70', 4200, 200000, '2025-08-19', '11-2025', 'Interest-11-2025', 4200, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4200, 0, 'Per_Day', NULL, 30, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-11-2025', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2025-11-01', '2025-11-30', '2025-11-01', 30, '70', 5250, 250000, '2025-08-19', '11-2025', 'Interest-11-2025', 0, 'Pending', 5250, 'Mal-P1', 5250, 'Yes', 5250, 0, 'Per_Day', NULL, 30, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-11-2025', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2025-11-01', '2025-11-30', '2025-11-01', 30, '70', 2100, 100000, '2025-08-19', '11-2025', 'Interest-11-2025', 2100, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2100, 0, 'Per_Day', NULL, 30, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-12-2025', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2025-12-01', '2025-12-31', '2025-12-01', 31, '70', 2170, 100000, '2024-01-01', '12-2025', 'Interest-12-2025', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-12-2025', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2025-12-01', '2025-12-31', '2025-12-01', 31, '70', 8680, 400000, '2024-04-10', '12-2025', 'Interest-12-2025', 8680, 'Paid', 0, 'Mal-P1', 0, 'Yes', 9765, 0, 'Per_Day', 0, 31, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-12-2025', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2025-12-01', '2025-12-31', '2025-12-01', 31, '80', 6696, 270000, '2025-01-01', '12-2025', 'Interest-12-2025', 6696, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6696, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-12-2025', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2025-12-01', '2025-12-31', '2025-12-01', 31, '60', 4650, 250000, '2025-01-01', '12-2025', 'Interest-12-2025', 4650, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4650, 0, 'Per_Day', 1800, 31, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-12-2025', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2025-12-01', '2025-12-31', '2025-12-01', 31, '70', 1085, 50000, '2025-08-19', '12-2025', 'Interest-12-2025', 1085, 'Paid', 0, 'Mal-P1', 0, 'No', 9765, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Mal-STL20-Mal-25-200000-Interest-12-2025', 'Malar_Finance', 'Mal-25', 'Mal-STL20', 'Priya', 9976592192, '2025-12-01', '2025-12-31', '2025-12-01', 31, '70', 4340, 200000, '2025-08-19', '12-2025', 'Interest-12-2025', 4340, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4340, 0, 'Per_Day', NULL, 31, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-12-2025', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2025-12-01', '2025-12-31', '2025-12-01', 31, '70', 5425, 250000, '2025-08-19', '12-2025', 'Interest-12-2025', 0, 'Pending', 5425, 'Mal-P1', 5425, 'Yes', 5425, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-12-2025', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2025-12-01', '2025-12-31', '2025-12-01', 31, '70', 2170, 100000, '2025-08-19', '12-2025', 'Interest-12-2025', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', NULL, 31, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-01-2026', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2026-01-01', '2026-01-31', '2026-01-01', 31, '70', 2170, 100000, '2024-01-01', '01-2026', 'Interest-01-2026', 0, 'Pending', 2170, 'Mal-P1', 2170, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-01-2026', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2026-01-01', '2026-01-31', '2026-01-01', 31, '70', 8680, 400000, '2024-04-10', '01-2026', 'Interest-01-2026', 8680, 'Paid', 0, 'Mal-P1', 0, 'Yes', 9765, 0, 'Per_Day', 0, 31, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-01-2026', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2026-01-01', '2026-01-31', '2026-01-01', 31, '80', 6696, 270000, '2025-01-01', '01-2026', 'Interest-01-2026', 6696, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6696, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-01-2026', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2026-01-01', '2026-01-31', '2026-01-01', 31, '60', 4650, 250000, '2025-01-01', '01-2026', 'Interest-01-2026', 4650, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4650, 0, 'Per_Day', 1800, 31, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-01-2026', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2026-01-01', '2026-01-31', '2026-01-01', 31, '70', 1085, 50000, '2025-08-19', '01-2026', 'Interest-01-2026', 1085, 'Paid', 0, 'Mal-P1', 0, 'No', 9765, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Mal-STL20-Mal-25-200000-Interest-01-2026', 'Malar_Finance', 'Mal-25', 'Mal-STL20', 'Priya', 9976592192, '2026-01-01', '2026-01-31', '2026-01-01', 31, '70', 4340, 200000, '2025-08-19', '01-2026', 'Interest-01-2026', 4340, 'Paid', 0, 'Mal-P1', 0, 'Yes', 4340, 0, 'Per_Day', NULL, 31, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-01-2026', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2026-01-01', '2026-01-31', '2026-01-01', 31, '70', 5425, 250000, '2025-08-19', '01-2026', 'Interest-01-2026', 0, 'Pending', 5425, 'Mal-P1', 5425, 'Yes', 5425, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-01-2026', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2026-01-01', '2026-01-31', '2026-01-01', 31, '70', 2170, 100000, '2025-08-19', '01-2026', 'Interest-01-2026', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', NULL, 31, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-02-2026', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2026-02-01', '2026-02-28', '2026-02-01', 28, '70', 1960, 100000, '2024-01-01', '02-2026', 'Interest-02-2026', 1420, 'Pending', 540, 'Mal-P1', 540, 'Yes', 1960, 0, 'Per_Day', 0, 28, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-02-2026', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2026-02-01', '2026-02-28', '2026-02-01', 28, '70', 7840, 400000, '2024-04-10', '02-2026', 'Interest-02-2026', 0, 'Pending', 7840, 'Mal-P1', 8820, 'Yes', 8820, 0, 'Per_Day', 0, 28, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-02-2026', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2026-02-01', '2026-02-28', '2026-02-01', 28, '80', 6048, 270000, '2025-01-01', '02-2026', 'Interest-02-2026', 6048, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6048, 0, 'Per_Day', 0, 28, NULL),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-02-2026', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2026-02-01', '2026-02-28', '2026-02-01', 28, '60', 4200, 250000, '2025-01-01', '02-2026', 'Interest-02-2026', 0, 'Pending', 4200, 'Mal-P1', 4200, 'Yes', 4200, 0, 'Per_Day', 1800, 28, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-02-2026', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2026-02-01', '2026-02-28', '2026-02-01', 28, '70', 980, 50000, '2025-08-19', '02-2026', 'Interest-02-2026', 0, 'Pending', 980, 'Mal-P1', 8820, 'No', 8820, 0, 'Per_Day', NULL, 28, NULL),
('Priya-Mal-STL20-Mal-25-200000-Interest-02-2026', 'Malar_Finance', 'Mal-25', 'Mal-STL20', 'Priya', 9976592192, '2026-02-01', '2026-02-28', '2026-02-01', 28, '70', 3920, 200000, '2025-08-19', '02-2026', 'Interest-02-2026', 3920, 'Paid', 0, 'Mal-P1', 0, 'Yes', 3920, 0, 'Per_Day', NULL, 28, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-02-2026', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2026-02-01', '2026-02-28', '2026-02-01', 28, '70', 4900, 250000, '2025-08-19', '02-2026', 'Interest-02-2026', 0, 'Pending', 4900, 'Mal-P1', 4900, 'Yes', 4900, 0, 'Per_Day', NULL, 28, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-02-2026', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2026-02-01', '2026-02-28', '2026-02-01', 28, '70', 1960, 100000, '2025-08-19', '02-2026', 'Interest-02-2026', 1960, 'Paid', 0, 'Mal-P1', 0, 'Yes', 1960, 0, 'Per_Day', NULL, 28, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-03-2026', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2026-03-01', '2026-03-31', '2026-03-01', 31, '70', 2170, 100000, '2024-01-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 2170, 'Mal-P1', 2170, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-03-2026', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2026-03-01', '2026-03-31', '2026-03-01', 31, '70', 8680, 400000, '2024-04-10', '03-2026', 'Interest-03-2026', 0, 'Pending', 8680, 'Mal-P1', 9765, 'Yes', 9765, 0, 'Per_Day', 0, 31, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-03-2026', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2026-03-01', '2026-03-31', '2026-03-01', 31, '80', 6696, 270000, '2025-01-01', '03-2026', 'Interest-03-2026', 6696, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6696, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-03-2026', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2026-03-01', '2026-03-31', '2026-03-01', 31, '60', 4650, 250000, '2025-01-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 4650, 'Mal-P1', 4650, 'Yes', 4650, 0, 'Per_Day', 1800, 31, NULL),
('Test11-Mal-STL61-Mal-22-125-Interest-03-2026', 'Malar_Finance', 'Mal-22', 'Mal-STL61', 'Test11', 9626262427, '2026-03-01', '2026-03-31', '2026-03-01', 31, '70', 3, 125, '2025-07-02', '03-2026', 'Interest-03-2026', 0, 'Pending', 3, 'Mal-P1', 3, 'Yes', 3, 0, 'Per_Day', NULL, 31, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-03-2026', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2026-03-01', '2026-03-31', '2026-03-01', 31, '70', 1085, 50000, '2025-08-19', '03-2026', 'Interest-03-2026', 0, 'Pending', 1085, 'Mal-P1', 9765, 'No', 9765, 0, 'Per_Day', NULL, 31, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-205000-Interest-03-2026', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2026-03-01', '2026-03-31', '2026-03-01', 31, '70', 5425, 205000, '2025-08-19', '03-2026', 'Interest-03-2026', 0, 'Pending', 5425, 'Mal-P1', 5425, 'Yes', 5425, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-03-2026', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2026-03-01', '2026-03-31', '2026-03-01', 31, '70', 2170, 100000, '2025-08-19', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', NULL, 31, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-04-2026', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2026-04-01', '2026-04-30', '2026-04-01', 30, '70', 2100, 100000, '2024-01-01', '04-2026', 'Interest-04-2026', 0, 'Pending', 2100, 'Mal-P1', 2100, 'Yes', 2100, 0, 'Per_Day', 0, 30, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-04-2026', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2026-04-01', '2026-04-30', '2026-04-01', 30, '70', 8400, 400000, '2024-04-10', '04-2026', 'Interest-04-2026', 0, 'Pending', 8400, 'Mal-P1', 9450, 'Yes', 9450, 0, 'Per_Day', 0, 30, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-04-2026', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2026-04-01', '2026-04-30', '2026-04-01', 30, '80', 6480, 270000, '2025-01-01', '04-2026', 'Interest-04-2026', 6480, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6480, 0, 'Per_Day', 0, 30, NULL),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-04-2026', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2026-04-01', '2026-04-30', '2026-04-01', 30, '60', 4500, 250000, '2025-01-01', '04-2026', 'Interest-04-2026', 0, 'Pending', 4500, 'Mal-P1', 4500, 'Yes', 4500, 0, 'Per_Day', 1800, 30, NULL),
('Test11-Mal-STL61-Mal-22-125-Interest-04-2026', 'Malar_Finance', 'Mal-22', 'Mal-STL61', 'Test11', 9626262427, '2026-04-01', '2026-04-30', '2026-04-01', 30, '70', 3, 125, '2025-07-02', '04-2026', 'Interest-04-2026', 0, 'Pending', 3, 'Mal-P1', 3, 'Yes', 3, 0, 'Per_Day', NULL, 30, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-04-2026', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2026-04-01', '2026-04-30', '2026-04-01', 30, '70', 1050, 50000, '2025-08-19', '04-2026', 'Interest-04-2026', 0, 'Pending', 1050, 'Mal-P1', 9450, 'No', 9450, 0, 'Per_Day', NULL, 30, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-205000-Interest-04-2026', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2026-04-01', '2026-04-30', '2026-04-01', 30, '70', 5250, 205000, '2025-08-19', '04-2026', 'Interest-04-2026', 0, 'Pending', 5250, 'Mal-P1', 5250, 'Yes', 5250, 0, 'Per_Day', NULL, 30, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-04-2026', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2026-04-01', '2026-04-30', '2026-04-01', 30, '70', 2100, 100000, '2025-08-19', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2100, 0, 'Per_Day', NULL, 30, NULL),
('Pradeep-Chi-STL1-Chi-28-60000-Interest-04-2026', 'Chit_Malar', 'Chi-28', 'Chi-STL1', 'Pradeep', 9626262427, '2026-04-01', '2026-04-30', '2026-04-16', 15, '70', 630, 60000, '2026-04-16', '04-2026', 'Interest-04-2026', 630, 'Paid', 0, 'Chi-P1', 0, 'Yes', 1379, 0, 'Per_Day', NULL, 30, NULL),
('Pradeep-Chi-STL1-Chi-29-40000-Interest-04-2026', 'Chit_Malar', 'Chi-29', 'Chi-STL1', 'Pradeep', 9626262427, '2026-04-01', '2026-04-30', '2026-04-18', 13, '70', 364, 40000, '2026-04-18', '04-2026', 'Interest-04-2026', 364, 'Paid', 0, 'Chi-P1', 0, 'No', 1379, 0, 'Per_Day', NULL, 30, NULL),
('Pradeep-Chi-STL1-Chi-30-50000-Interest-04-2026', 'Chit_Malar', 'Chi-30', 'Chi-STL1', 'Pradeep', 9626262427, '2026-04-01', '2026-04-30', '2026-04-20', 11, '70', 385, 50000, '2026-04-20', '04-2026', 'Interest-04-2026', 385, 'Paid', 0, 'Chi-P1', 0, 'No', 1379, 0, 'Per_Day', NULL, 30, NULL),
('Priya-Kan-STL5-Kan-38-80000-Interest-05-2026', 'Kannan_Finance', 'Kan-38', 'Kan-STL5', 'Priya', 9626262427, '2026-05-01', '2026-05-10', '2026-05-01', 10, '70', 560, 80000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 560, 'Kan-P1', 6069, 'Yes', 6069, 0, 'Per_Day', NULL, 10, NULL),
('Priya-Kan-STL5-Kan-38-150000-Interest-05-2026', 'Kannan_Finance', 'Kan-38', 'Kan-STL5', 'Priya', 9626262427, '2026-05-01', '2026-05-22', '2026-05-01', 22, '70', 2310, 150000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 2310, 'Kan-P1', 6069, 'No', 6069, 0, 'Per_Day', NULL, 22, NULL),
('Pradeep-Chi-STL1-Chi-28-60000-Interest-05-2026', 'Chit_Malar', 'Chi-28', 'Chi-STL1', 'Pradeep', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 1302, 60000, '2026-04-16', '05-2026', 'Interest-05-2026', 1302, 'Paid', 0, 'Chi-P1', 0, 'Yes', 3255, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep-Chi-STL1-Chi-29-40000-Interest-05-2026', 'Chit_Malar', 'Chi-29', 'Chi-STL1', 'Pradeep', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 868, 40000, '2026-04-18', '05-2026', 'Interest-05-2026', 868, 'Paid', 0, 'Chi-P1', 0, 'No', 3255, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep-Chi-STL1-Chi-30-50000-Interest-05-2026', 'Chit_Malar', 'Chi-30', 'Chi-STL1', 'Pradeep', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 1085, 50000, '2026-04-20', '05-2026', 'Interest-05-2026', 1085, 'Paid', 0, 'Chi-P1', 0, 'No', 3255, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Chi-STL2-Chi-31-80000-Interest-05-2026', 'Chit_Malar', 'Chi-31', 'Chi-STL2', 'Priya', 9976592192, '2026-05-01', '2026-05-31', '2026-05-11', 21, '70', 1176, 80000, '2026-05-11', '05-2026', 'Interest-05-2026', 1176, 'Paid', 0, 'Chi-P1', 0, 'Yes', 2121, 0, 'Per_Day', NULL, 31, NULL),
('Palanisamy-Chi-STL3-Chi-32-300000-Interest-05-2026', 'Chit_Malar', 'Chi-32', 'Chi-STL3', 'Palanisamy', 7010457994, '2026-05-01', '2026-05-31', '2026-05-01', 31, '50', 4650, 300000, '2026-04-15', '05-2026', 'Interest-05-2026', 4650, 'Paid', 0, 'Chi-P1', 0, 'Yes', 6250, 0, 'Per_Day', NULL, 31, NULL),
('Palanisamy-Chi-STL3-Chi-33-200000-Interest-05-2026', 'Chit_Malar', 'Chi-33', 'Chi-STL3', 'Palanisamy', 7010457994, '2026-05-01', '2026-05-31', '2026-05-20', 12, '50', 1200, 200000, '2026-05-20', '05-2026', 'Interest-05-2026', 1200, 'Paid', 0, 'Chi-P1', 0, 'No', 6250, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Chi-STL2-Chi-44-150000-Interest-05-2026', 'Chit_Malar', 'Chi-44', 'Chi-STL2', 'Priya', 9976592192, '2026-05-01', '2026-05-31', '2026-05-23', 9, '70', 945, 150000, '2026-05-23', '05-2026', 'Interest-05-2026', 945, 'Paid', 0, 'Chi-P1', 0, 'No', 2121, 0, 'Per_Day', NULL, 31, NULL),
('Surrendar Puthur-Chi-STL4-Chi-45-600000-Interest-05-2026', 'Chit_Malar', 'Chi-45', 'Chi-STL4', 'Surrendar Puthur', 9043436792, '2026-05-01', '2026-05-31', '2026-05-25', 7, '50', 2100, 600000, '2026-05-25', '05-2026', 'Interest-05-2026', 2100, 'Paid', 0, 'Chi-P1', 0, 'Yes', 2100, 0, 'Per_Day', NULL, 31, NULL),
('Palanisamy-Chi-STL3-Chi-46-200000-Interest-05-2026', 'Chit_Malar', 'Chi-46', 'Chi-STL3', 'Palanisamy', 7010457994, '2026-05-01', '2026-05-31', '2026-05-28', 4, '50', 400, 200000, '2026-05-28', '05-2026', 'Interest-05-2026', 400, 'Paid', 0, 'Chi-P1', 0, 'No', 6250, 0, 'Per_Day', NULL, 31, NULL),
('Elango manmangalam-Chi-STL5-Chi-47-100000-Interest-05-2026', 'Chit_Malar', 'Chi-47', 'Chi-STL5', 'Elango manmangalam', 9943831310, '2026-05-01', '2026-05-31', '2026-05-28', 4, '50', 200, 100000, '2026-05-28', '05-2026', 'Interest-05-2026', 0, 'Pending', 200, 'Chi-P1', 200, 'Yes', 200, 0, 'Per_Day', NULL, 31, NULL),
('Nagaraj refill-Chi-STL6-Chi-48-50000-Interest-05-2026', 'Chit_Malar', 'Chi-48', 'Chi-STL6', 'Nagaraj refill', 9626262427, '2026-05-01', '2026-05-31', '2026-05-28', 4, '42', 81, 50000, '2026-05-28', '05-2026', 'Interest-05-2026', 81, 'Paid', 0, 'Chi-P1', 0, 'Yes', 81, 0, 'Per_Month', 1250, 31, NULL),
('Ramkumar-Chi-STL7-Chi-49-150000-Interest-05-2026', 'Chit_Malar', 'Chi-49', 'Chi-STL7', 'Ramkumar', 9578562182, '2026-05-01', '2026-05-31', '2026-05-28', 4, NULL, 242, 150000, '2026-05-28', '05-2026', 'Interest-05-2026', 242, 'Paid', 0, 'Chi-P1', 0, 'Yes', 242, 0, 'Per_Month', 1250, 31, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-05-2026', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 2170, 100000, '2024-01-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 2170, 'Mal-P1', 2170, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Balu-Mal-STL11-Mal-3-400000-Interest-05-2026', 'Malar_Finance', 'Mal-3', 'Mal-STL11', 'Balu', 9976592192, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 8680, 400000, '2024-04-10', '05-2026', 'Interest-05-2026', 0, 'Pending', 8680, 'Mal-P1', 9765, 'Yes', 9765, 0, 'Per_Day', 0, 31, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-05-2026', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2026-05-01', '2026-05-31', '2026-05-01', 31, '80', 6696, 270000, '2025-01-01', '05-2026', 'Interest-05-2026', 6696, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6696, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-05-2026', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2026-05-01', '2026-05-31', '2026-05-01', 31, '60', 4650, 250000, '2025-01-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 4650, 'Mal-P1', 4650, 'Yes', 4650, 0, 'Per_Day', 1800, 31, NULL),
('Test11-Mal-STL61-Mal-22-125-Interest-05-2026', 'Malar_Finance', 'Mal-22', 'Mal-STL61', 'Test11', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 3, 125, '2025-07-02', '05-2026', 'Interest-05-2026', 0, 'Pending', 3, 'Mal-P1', 3, 'Yes', 3, 0, 'Per_Day', NULL, 31, NULL),
('Balu-Mal-STL11-Mal-24-50000-Interest-05-2026', 'Malar_Finance', 'Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 1085, 50000, '2025-08-19', '05-2026', 'Interest-05-2026', 0, 'Pending', 1085, 'Mal-P1', 9765, 'No', 9765, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-05-2026', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 2170, 100000, '2025-08-19', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2170, 0, 'Per_Day', NULL, 31, NULL),
('Ramasamy divya-Kan-STL1-Kan-34-50000-Interest-05-2026', 'Kannan_Finance', 'Kan-34', 'Kan-STL1', 'Ramasamy divya', 9787878005, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 1085, 50000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 1085, 'Kan-P1', 1085, 'Yes', 1085, 0, 'Per_Day', NULL, 31, NULL),
('Sundaravadivel-Kan-STL2-Kan-35-100000-Interest-05-2026', 'Kannan_Finance', 'Kan-35', 'Kan-STL2', 'Sundaravadivel', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 2170, 100000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 2170, 'Kan-P1', 2170, 'Yes', 2170, 0, 'Per_Day', NULL, 31, NULL),
('Suresh Balu vangap-Kan-STL3-Kan-36-300000-Interest-05-2026', 'Kannan_Finance', 'Kan-36', 'Kan-STL3', 'Suresh Balu vangap', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 6510, 300000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 6510, 'Kan-P1', 6510, 'Yes', 6510, 0, 'Per_Day', NULL, 31, NULL),
('Nagaraj post-Kan-STL4-Kan-37-30000-Interest-05-2026', 'Kannan_Finance', 'Kan-37', 'Kan-STL4', 'Nagaraj post', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 651, 30000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 651, 'Kan-P1', 651, 'Yes', 651, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Kan-STL5-Kan-38-70000-Interest-05-2026', 'Kannan_Finance', 'Kan-38', 'Kan-STL5', 'Priya', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 1519, 70000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 1519, 'Kan-P1', 6069, 'No', 6069, 0, 'Per_Day', NULL, 31, NULL),
('Chathiram amma-Kan-STL6-Kan-39-30000-Interest-05-2026', 'Kannan_Finance', 'Kan-39', 'Kan-STL6', 'Chathiram amma', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 651, 30000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 651, 'Kan-P1', 651, 'Yes', 651, 0, 'Per_Day', NULL, 31, NULL),
('Arul-Kan-STL7-Kan-40-25000-Interest-05-2026', 'Kannan_Finance', 'Kan-40', 'Kan-STL7', 'Arul', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 543, 25000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 543, 'Kan-P1', 543, 'Yes', 543, 0, 'Per_Day', NULL, 31, NULL),
('Manoj-Kan-STL8-Kan-41-10000-Interest-05-2026', 'Kannan_Finance', 'Kan-41', 'Kan-STL8', 'Manoj', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 217, 10000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 217, 'Kan-P1', 217, 'Yes', 217, 0, 'Per_Day', NULL, 31, NULL),
('Surya vangap-Kan-STL9-Kan-42-140000-Interest-05-2026', 'Kannan_Finance', 'Kan-42', 'Kan-STL9', 'Surya vangap', 9626262427, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 3038, 140000, '2026-05-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 3038, 'Kan-P1', 3038, 'Yes', 3038, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Kan-STL5-Kan-43-150000-Interest-05-2026', 'Kannan_Finance', 'Kan-43', 'Kan-STL5', 'Priya', 9626262427, '2026-05-01', '2026-05-31', '2026-05-16', 16, '70', 1680, 150000, '2026-05-16', '05-2026', 'Interest-05-2026', 0, 'Pending', 1680, 'Kan-P1', 6069, 'No', 6069, 0, 'Per_Day', NULL, 31, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-05-2026', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 5425, 250000, '2025-08-19', '05-2026', 'Interest-05-2026', 0, 'Pending', 5425, 'Mal-P1', 5425, 'Yes', 5425, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Kan-STL5-Kan-38-60000-Interest-06-2026', 'Kannan_Finance', 'Kan-38', 'Kan-STL5', 'Priya', 9626262427, '2026-06-01', '2026-06-01', '2026-06-01', 1, '70', 42, 60000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 42, 'Kan-P1', 7602, 'Yes', 7602, 0, 'Per_Day', NULL, 1, NULL),
('Surrendar Puthur-Chi-STL4-Chi-45-200000-Interest-06-2026', 'Chit_Malar', 'Chi-45', 'Chi-STL4', 'Surrendar Puthur', 9043436792, '2026-06-01', '2026-06-03', '2026-06-01', 3, '50', 300, 200000, '2026-05-25', '06-2026', 'Interest-06-2026', 300, 'Paid', 0, 'Chi-P1', 0, 'Yes', 6300, 0, 'Per_Day', NULL, 3, NULL);
insert into "Interest_Details" ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days", "col27") values
('Ramkumar-Chi-STL7-Chi-53-100000-Interest-06-2026', 'Chit_Malar', 'Chi-53', 'Chi-STL7', 'Ramkumar', 9578562182, '2026-06-01', '2026-06-24', '2026-06-04', 21, NULL, 1094, 100000, '2026-06-04', '06-2026', 'Interest-06-2026', 1094, 'Paid', 0, 'Chi-P1', 0, 'Yes', 4104, 0, 'Per_Month', 1250, 24, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-06-2026', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 2100, 100000, '2024-01-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 2100, 'Mal-P1', 2100, 'Yes', 2100, 0, 'Per_Day', 0, 30, NULL),
('Balu-Mal-STL11-Mal-3-Mal-24-450000-Interest-06-2026', 'Malar_Finance', 'Mal-3-Mal-24', 'Mal-STL11', 'Balu', 9976592192, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 9450, 450000, '2024-04-10', '06-2026', 'Interest-06-2026', 0, 'Pending', 9450, 'Mal-P1', 9450, 'Yes', 9450, 0, 'Per_Day', 0, 30, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-06-2026', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2026-06-01', '2026-06-30', '2026-06-01', 30, '80', 6480, 270000, '2025-01-01', '06-2026', 'Interest-06-2026', 6480, 'Paid', 0, 'Mal-P1', 0, 'Yes', 6480, 0, 'Per_Day', 0, 30, NULL),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-06-2026', 'Malar_Finance', 'Mal-6', 'Mal-STL14', 'Ramkumar', 9578562182, '2026-06-01', '2026-06-30', '2026-06-01', 30, '60', 4500, 250000, '2025-01-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 4500, 'Mal-P1', 4500, 'Yes', 4500, 0, 'Per_Day', 1800, 30, NULL),
('Test11-Mal-STL61-Mal-22-125-Interest-06-2026', 'Malar_Finance', 'Mal-22', 'Mal-STL61', 'Test11', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 0, 125, '2025-07-02', '06-2026', 'Interest-06-2026', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Day', NULL, 30, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-06-2026', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 5250, 250000, '2025-08-19', '06-2026', 'Interest-06-2026', 0, 'Pending', 5250, 'Mal-P1', 5250, 'Yes', 5250, 0, 'Per_Day', NULL, 30, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-06-2026', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 2100, 100000, '2025-08-19', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'Mal-P1', 0, 'Yes', 2100, 0, 'Per_Day', NULL, 30, NULL),
('Ramasamy divya-Kan-STL1-Kan-34-50000-Interest-06-2026', 'Kannan_Finance', 'Kan-34', 'Kan-STL1', 'Ramasamy divya', 9787878005, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 1050, 50000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 1050, 'Kan-P1', 1050, 'Yes', 1050, 0, 'Per_Day', NULL, 30, NULL),
('Sundaravadivel-Kan-STL2-Kan-35-100000-Interest-06-2026', 'Kannan_Finance', 'Kan-35', 'Kan-STL2', 'Sundaravadivel', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 2100, 100000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 2100, 'Kan-P1', 2100, 'Yes', 2100, 0, 'Per_Day', NULL, 30, NULL),
('Suresh Balu vangap-Kan-STL3-Kan-36-300000-Interest-06-2026', 'Kannan_Finance', 'Kan-36', 'Kan-STL3', 'Suresh Balu vangap', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 6300, 300000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 6300, 'Kan-P1', 6300, 'Yes', 6300, 0, 'Per_Day', NULL, 30, NULL),
('Nagaraj post-Kan-STL4-Kan-37-30000-Interest-06-2026', 'Kannan_Finance', 'Kan-37', 'Kan-STL4', 'Nagaraj post', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 630, 30000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 630, 'Kan-P1', 630, 'Yes', 630, 0, 'Per_Day', NULL, 30, NULL),
('Priya-Kan-STL5-Kan-38-43-51-360000-Interest-06-2026', 'Kannan_Finance', 'Kan-38-43-51', 'Kan-STL5', 'Priya', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 7560, 360000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 7560, 'Kan-P1', 7602, 'No', 7602, 0, 'Per_Day', NULL, 30, NULL),
('Chathiram amma-Kan-STL6-Kan-39-30000-Interest-06-2026', 'Kannan_Finance', 'Kan-39', 'Kan-STL6', 'Chathiram amma', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 630, 30000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 630, 'Kan-P1', 630, 'Yes', 630, 0, 'Per_Day', NULL, 30, NULL),
('Arul-Kan-STL7-Kan-40-25000-Interest-06-2026', 'Kannan_Finance', 'Kan-40', 'Kan-STL7', 'Arul', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 530, 25000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 530, 'Kan-P1', 530, 'Yes', 530, 0, 'Per_Day', NULL, 30, NULL),
('Manoj-Kan-STL8-Kan-41-10000-Interest-06-2026', 'Kannan_Finance', 'Kan-41', 'Kan-STL8', 'Manoj', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 210, 10000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 210, 'Kan-P1', 210, 'Yes', 210, 0, 'Per_Day', NULL, 30, NULL),
('Surya vangap-Kan-STL9-Kan-42-140000-Interest-06-2026', 'Kannan_Finance', 'Kan-42', 'Kan-STL9', 'Surya vangap', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 2940, 140000, '2026-05-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 2940, 'Kan-P1', 2940, 'Yes', 2940, 0, 'Per_Day', NULL, 30, NULL),
('Pradeep-Chi-STL1-Chi-28-29-30-150000-Interest-06-2026', 'Chit_Malar', 'Chi-28-29-30', 'Chi-STL1', 'Pradeep', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 3150, 150000, '2026-04-16', '06-2026', 'Interest-06-2026', 3150, 'Paid', 0, 'Chi-P1', 0, 'Yes', 3150, 0, 'Per_Day', NULL, 30, NULL),
('Priya-Chi-STL2-Chi-31-44-54-290000-Interest-06-2026', 'Chit_Malar', 'Chi-31-44-54', 'Chi-STL2', 'Priya', 9976592192, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 6090, 290000, '2026-05-11', '06-2026', 'Interest-06-2026', 6090, 'Paid', 0, 'Chi-P1', 0, 'Yes', 6090, 0, 'Per_Day', NULL, 30, NULL),
('Palanisamy-Chi-STL3-Chi-32-33-46-700000-Interest-06-2026', 'Chit_Malar', 'Chi-32-33-46', 'Chi-STL3', 'Palanisamy', 7010457994, '2026-06-01', '2026-06-30', '2026-06-01', 30, '50', 10500, 700000, '2026-04-15', '06-2026', 'Interest-06-2026', 10500, 'Paid', 0, 'Chi-P1', 0, 'Yes', 10500, 0, 'Per_Day', NULL, 30, NULL),
('Surrendar Puthur-Chi-STL4-Chi-45-400000-Interest-06-2026', 'Chit_Malar', 'Chi-45', 'Chi-STL4', 'Surrendar Puthur', 9043436792, '2026-06-01', '2026-06-30', '2026-06-01', 30, '50', 6000, 400000, '2026-05-25', '06-2026', 'Interest-06-2026', 6000, 'Paid', 0, 'Chi-P1', 0, 'No', 6300, 0, 'Per_Day', NULL, 30, NULL),
('Elango manmangalam-Chi-STL5-Chi-47-100000-Interest-06-2026', 'Chit_Malar', 'Chi-47', 'Chi-STL5', 'Elango manmangalam', 9943831310, '2026-06-01', '2026-06-30', '2026-06-01', 30, '50', 1500, 100000, '2026-05-28', '06-2026', 'Interest-06-2026', 0, 'Pending', 1500, 'Chi-P1', 1500, 'Yes', 1500, 0, 'Per_Day', NULL, 30, NULL),
('Nagaraj refill-Chi-STL6-Chi-48-50000-Interest-06-2026', 'Chit_Malar', 'Chi-48', 'Chi-STL6', 'Nagaraj refill', 9626262427, '2026-06-01', '2026-06-30', '2026-06-01', 30, '42', 630, 50000, '2026-05-28', '06-2026', 'Interest-06-2026', 630, 'Paid', 0, 'Chi-P1', 0, 'Yes', 630, 0, 'Per_Month', 1250, 30, NULL),
('Ramkumar-Chi-STL7-Chi-49-53-250000-Interest-06-2026', 'Chit_Malar', 'Chi-49-53', 'Chi-STL7', 'Ramkumar', 9578562182, '2026-06-01', '2026-06-30', '2026-06-01', 30, NULL, 3010, 250000, '2026-05-28', '06-2026', 'Interest-06-2026', 3010, 'Paid', 0, 'Chi-P1', 0, 'No', 4104, 0, 'Per_Month', 1250, 30, NULL),
('Arul Personal-Chi-STL8-Chi-50-50000-Interest-06-2026', 'Chit_Malar', 'Chi-50', 'Chi-STL8', 'Arul Personal', 9626262427, '2026-06-01', '2026-06-30', '2026-06-03', 28, '60', 840, 50000, '2026-06-03', '06-2026', 'Interest-06-2026', 0, 'Pending', 840, 'Chi-P1', 840, 'Yes', 840, 0, 'Per_Day', NULL, 30, NULL),
('Tharun kannan-Chi-STL9-Chi-51-200000-Interest-06-2026', 'Chit_Malar', 'Chi-51', 'Chi-STL9', 'Tharun kannan', 9843722055, '2026-06-01', '2026-06-30', '2026-06-03', 28, '60', 3360, 200000, '2026-06-03', '06-2026', 'Interest-06-2026', 3360, 'Paid', 0, 'Chi-P1', 0, 'Yes', 3360, 0, 'Per_Day', NULL, 30, NULL),
('Priya-Kan-STL5-Kan-43-40000-Interest-07-2026', 'Kannan_Finance', 'Kan-43', 'Kan-STL5', 'Priya', 9626262427, '2026-07-01', '2026-07-30', '2026-07-01', 30, '70', 840, 40000, '2026-05-16', '07-2026', 'Interest-07-2026', 0, 'Pending', 840, 'Kan-P1', 7790, 'Yes', 7790, 0, 'Per_Day', NULL, 30, NULL),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-07-2026', 'Malar_Finance', 'Mal-2', 'Mal-STL12', 'Chandrasekar', 7092355445, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 2170, 100000, '2024-01-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'Mal-P1', 2170, 'Yes', 2170, 0, 'Per_Day', 0, 31, NULL),
('Balu-Mal-STL11-Mal-3-24-450000-Interest-07-2026', 'Malar_Finance', 'Mal-3-24', 'Mal-STL11', 'Balu', 9976592192, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 9770, 450000, '2024-04-10', '07-2026', 'Interest-07-2026', 0, 'Pending', 9770, 'Mal-P1', 9770, 'Yes', 9770, 0, 'Per_Day', 0, 31, NULL),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-07-2026', 'Malar_Finance', 'Mal-5', 'Mal-STL13', 'Orange_Tex', 9578562182, '2026-07-01', '2026-07-31', '2026-07-01', 31, '80', 6700, 270000, '2025-01-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 6700, 'Mal-P1', 6700, 'Yes', 6700, 0, 'Per_Day', 0, 31, NULL),
('Ramkumar-Mal-STL14-Mal-6-57-750000-Interest-07-2026', 'Malar_Finance', 'Mal-6-57', 'Mal-STL14', 'Ramkumar', 9578562182, '2026-07-01', '2026-07-31', '2026-07-01', 31, '60', 9820, 750000, '2025-01-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 9820, 'Mal-P1', 9820, 'Yes', 9820, 0, 'Per_Day', 1800, 31, NULL),
('Test11-Mal-STL61-Mal-22-125-Interest-07-2026', 'Malar_Finance', 'Mal-22', 'Mal-STL61', 'Test11', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 0, 125, '2025-07-02', '07-2026', 'Interest-07-2026', 0, 'Paid', 0, 'Mal-P1', 0, 'Yes', 0, 0, 'Per_Day', NULL, 31, NULL),
('Mahesh Manmangalam-Mal-STL21-Mal-26-250000-Interest-07-2026', 'Malar_Finance', 'Mal-26', 'Mal-STL21', 'Mahesh Manmangalam', 9976592192, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 5430, 250000, '2025-08-19', '07-2026', 'Interest-07-2026', 0, 'Pending', 5430, 'Mal-P1', 5430, 'Yes', 5430, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-07-2026', 'Malar_Finance', 'Mal-27', 'Mal-STL22', 'Pradeep Vangapalayam', 9976592192, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 2170, 100000, '2025-08-19', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'Mal-P1', 2170, 'Yes', 2170, 0, 'Per_Day', NULL, 31, NULL),
('Pradeep-Chi-STL1-Chi-28-29-30-150000-Interest-07-2026', 'Chit_Malar', 'Chi-28-29-30', 'Chi-STL1', 'Pradeep', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 3260, 150000, '2026-04-16', '07-2026', 'Interest-07-2026', 0, 'Pending', 3260, 'Chi-P1', 3260, 'Yes', 3260, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Chi-STL2-Chi-31-44-54-55-58-380000-Interest-07-2026', 'Chit_Malar', 'Chi-31-44-54-55-58', 'Chi-STL2', 'Priya', 9976592192, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 7350, 380000, '2026-05-11', '07-2026', 'Interest-07-2026', 0, 'Pending', 7350, 'Chi-P1', 7350, 'Yes', 7350, 0, 'Per_Day', NULL, 31, NULL),
('Palanisamy-Chi-STL3-Chi-32-33-46-700000-Interest-07-2026', 'Chit_Malar', 'Chi-32-33-46', 'Chi-STL3', 'Palanisamy', 7010457994, '2026-07-01', '2026-07-31', '2026-07-01', 31, '50', 10850, 700000, '2026-04-15', '07-2026', 'Interest-07-2026', 10850, 'Paid', 0, 'Chi-P1', 0, 'Yes', 10850, 0, 'Per_Day', NULL, 31, NULL),
('Surrendar Puthur-Chi-STL4-Chi-45-400000-Interest-07-2026', 'Chit_Malar', 'Chi-45', 'Chi-STL4', 'Surrendar Puthur', 9043436792, '2026-07-01', '2026-07-31', '2026-07-01', 31, '50', 6200, 400000, '2026-05-25', '07-2026', 'Interest-07-2026', 0, 'Pending', 6200, 'Chi-P1', 6200, 'Yes', 6200, 0, 'Per_Day', NULL, 31, NULL),
('Elango manmangalam-Chi-STL5-Chi-47-100000-Interest-07-2026', 'Chit_Malar', 'Chi-47', 'Chi-STL5', 'Elango manmangalam', 9943831310, '2026-07-01', '2026-07-31', '2026-07-01', 31, '50', 1550, 100000, '2026-05-28', '07-2026', 'Interest-07-2026', 0, 'Pending', 1550, 'Chi-P1', 1550, 'Yes', 1550, 0, 'Per_Day', NULL, 31, NULL),
('Nagaraj refill-Chi-STL6-Chi-48-50000-Interest-07-2026', 'Chit_Malar', 'Chi-48', 'Chi-STL6', 'Nagaraj refill', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '42', 630, 50000, '2026-05-28', '07-2026', 'Interest-07-2026', 630, 'Paid', 0, 'Chi-P1', 0, 'Yes', 630, 0, 'Per_Month', 1250, 31, NULL),
('Ramkumar-Chi-STL7-Chi-49-53-250000-Interest-07-2026', 'Chit_Malar', 'Chi-49-53', 'Chi-STL7', 'Ramkumar', 9578562182, '2026-07-01', '2026-07-31', '2026-07-01', 31, NULL, 3130, 250000, '2026-05-28', '07-2026', 'Interest-07-2026', 0, 'Pending', 3130, 'Chi-P1', 3130, 'Yes', 3130, 0, 'Per_Month', 1250, 31, NULL),
('Arul Personal-Chi-STL8-Chi-50-50000-Interest-07-2026', 'Chit_Malar', 'Chi-50', 'Chi-STL8', 'Arul Personal', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '60', 930, 50000, '2026-06-03', '07-2026', 'Interest-07-2026', 0, 'Pending', 930, 'Chi-P1', 930, 'Yes', 930, 0, 'Per_Day', NULL, 31, NULL),
('Tharun kannan-Chi-STL9-Chi-51-200000-Interest-07-2026', 'Chit_Malar', 'Chi-51', 'Chi-STL9', 'Tharun kannan', 9843722055, '2026-07-01', '2026-07-31', '2026-07-01', 31, '50', 3100, 200000, '2026-06-03', '07-2026', 'Interest-07-2026', 3100, 'Paid', 0, 'Chi-P1', 0, 'Yes', 3100, 0, 'Per_Day', NULL, 31, NULL),
('Rajesh post office-Chi-STL10-Chi-56-500000-Interest-07-2026', 'Chit_Malar', 'Chi-56', 'Chi-STL10', 'Rajesh post office', 9994922299, '2026-07-01', '2026-07-31', '2026-07-03', 29, '50', 7250, 500000, '2026-07-03', '07-2026', 'Interest-07-2026', 0, 'Pending', 7250, 'Chi-P1', 7250, 'Yes', 7250, 0, 'Per_Day', NULL, 31, NULL),
('Ramasamy divya-Kan-STL1-Kan-34-50000-Interest-07-2026', 'Kannan_Finance', 'Kan-34', 'Kan-STL1', 'Ramasamy divya', 9787878005, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 1090, 50000, '2026-05-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1090, 'Kan-P1', 1090, 'Yes', 1090, 0, 'Per_Day', NULL, 31, NULL),
('Sundaravadivel-Kan-STL2-Kan-35-100000-Interest-07-2026', 'Kannan_Finance', 'Kan-35', 'Kan-STL2', 'Sundaravadivel', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 2170, 100000, '2026-05-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'Kan-P1', 2170, 'Yes', 2170, 0, 'Per_Day', NULL, 31, NULL),
('Suresh Balu vangap-Kan-STL3-Kan-36-300000-Interest-07-2026', 'Kannan_Finance', 'Kan-36', 'Kan-STL3', 'Suresh Balu vangap', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 6510, 300000, '2026-05-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 6510, 'Kan-P1', 6510, 'Yes', 6510, 0, 'Per_Day', NULL, 31, NULL),
('Nagaraj post-Kan-STL4-Kan-37-30000-Interest-07-2026', 'Kannan_Finance', 'Kan-37', 'Kan-STL4', 'Nagaraj post', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 650, 30000, '2026-05-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 650, 'Kan-P1', 650, 'Yes', 650, 0, 'Per_Day', NULL, 31, NULL),
('Priya-Kan-STL5-Kan-38-43-51-320000-Interest-07-2026', 'Kannan_Finance', 'Kan-38-43-51', 'Kan-STL5', 'Priya', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 6950, 320000, '2026-05-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 6950, 'Kan-P1', 7790, 'No', 7790, 0, 'Per_Day', NULL, 31, NULL),
('Chathiram amma-Kan-STL6-Kan-39-30000-Interest-07-2026', 'Kannan_Finance', 'Kan-39', 'Kan-STL6', 'Chathiram amma', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 650, 30000, '2026-05-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 650, 'Kan-P1', 650, 'Yes', 650, 0, 'Per_Day', NULL, 31, NULL),
('Arul-Kan-STL7-Kan-40-25000-Interest-07-2026', 'Kannan_Finance', 'Kan-40', 'Kan-STL7', 'Arul', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 540, 25000, '2026-05-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 540, 'Kan-P1', 540, 'Yes', 540, 0, 'Per_Day', NULL, 31, NULL),
('Manoj-Kan-STL8-Kan-41-10000-Interest-07-2026', 'Kannan_Finance', 'Kan-41', 'Kan-STL8', 'Manoj', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 220, 10000, '2026-05-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 220, 'Kan-P1', 220, 'Yes', 220, 0, 'Per_Day', NULL, 31, NULL),
('Surya vangap-Kan-STL9-Kan-42-140000-Interest-07-2026', 'Kannan_Finance', 'Kan-42', 'Kan-STL9', 'Surya vangap', 9626262427, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 3040, 140000, '2026-05-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 3040, 'Kan-P1', 3040, 'Yes', 3040, 0, 'Per_Day', NULL, 31, NULL);
alter table "Interest_Details" enable row level security;
create policy "read_all_Interest_Details" on "Interest_Details" for select using (true);

drop table if exists "Transaction_Ledger" cascade;
create table "Transaction_Ledger" ("Ref_ID" text, "Date_Transaction" text, "Nature_Transaction" text, "ID" text, "STL_No" text, "Loan_No" text, "Customer_Name" text, "Description" text, "Receipt_Amount" numeric, "Payment_Amount" numeric, "Balance" numeric, "Payment_Type" text, "Remarks" text, "Finance_Name" text, "Interest_Amount" text);
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('de9f6517', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL11-Prakash SMP', 'New-STL11', 'New-1', NULL, 'New-1 -  - Loan_To_Customer', NULL, 30000, -30000, 'Cash', NULL, 'New Finance', NULL),
('1c9bc2ba', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL11-Prakash SMP', 'New-STL11', 'New-2', NULL, 'New-2 -  - Loan_To_Customer', NULL, 10000, -40000, 'Cash', NULL, 'New Finance', NULL),
('e60aa3e2', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL11-Prakash SMP', 'New-STL11', 'New-3', NULL, 'New-3 -  - Loan_To_Customer', NULL, 60000, -100000, 'Cash', NULL, 'New Finance', NULL),
('465b218a', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL35-Selvaguru', 'New-STL35', 'New-4', NULL, 'New-4 -  - Loan_To_Customer', NULL, 140000, -240000, 'Cash', 'Land document ஆலங்குகலம்', 'New Finance', NULL),
('0f756a9f', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL38-Sabarish', 'New-STL38', 'New-5', NULL, 'New-5 -  - Loan_To_Customer', NULL, 20000, -260000, 'Cash', 'Sabarish transferred the loan to his friend Ram but he''s giving interest.', 'New Finance', NULL),
('091dbdf1', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -330000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('78006c5f', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -400000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('bfd3db5c', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -470000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('1cc97743', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -540000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('ab06bca3', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -610000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('ba3bed7c', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -680000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('abeaeaa3', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -750000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('d5ce71aa', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -820000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('e681a094', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -890000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('906ac264', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'New-6 -  - Loan_To_Customer', NULL, 70000, -960000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('7437f636', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL58-Rajendran', 'New-STL58', 'New-7', NULL, 'New-7 -  - Loan_To_Customer', NULL, 15000, -975000, 'Cash', NULL, 'New Finance', NULL),
('26b78188', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL67-Pradeep', 'New-STL67', 'New-8', NULL, 'New-8 -  - Loan_To_Customer', NULL, 100000, -1075000, 'Cash', 'Bond with Arul.M', 'New Finance', NULL),
('2702a3e1', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL73-Periasamy', 'New-STL73', 'New-9', NULL, 'New-9 -  - Loan_To_Customer', NULL, 75000, -1150000, 'Cash', NULL, 'New Finance', NULL),
('83e3866e', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL78-Dinesh', 'New-STL78', 'New-10', NULL, 'New-10 -  - Loan_To_Customer', NULL, 80000, -1230000, 'Cash', NULL, 'New Finance', NULL),
('56407b87', '2025-04-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL9-Chandru post', 'New-STL9', 'New-11', NULL, 'New-11 -  - Loan_To_Customer', NULL, 200000, -1430000, 'Cash', NULL, 'New Finance', NULL),
('6d2759cc', '2025-04-27', 'Deposit_From_Customer', 'Deposit-New-D-1-Prakash-Prakash', NULL, 'New-D-1-Prakash', 'Prakash', 'Deposit From Customer-Prakash', 150000, NULL, -1280000, 'Cash', NULL, 'New Finance', NULL),
('4ef2d5b6', '2025-04-27', 'Deposit_From_Customer', 'Deposit-New-D-2-Arul-Arul', NULL, 'New-D-2-Arul', 'Arul', 'Deposit From Customer-Arul', 300000, NULL, -980000, 'Cash', NULL, 'New Finance', NULL),
('1a9d696b', '2025-04-27', 'Deposit_From_Customer', 'Deposit-New-D-1-Prakash-Prakash', NULL, 'New-D-1-Prakash', 'Prakash', 'Deposit From Customer-Prakash', 150000, NULL, -830000, 'Cash', NULL, 'New Finance', NULL),
('dfa32c7f', '2025-04-27', 'Deposit_From_Customer', 'Deposit-New-D-2-Arul-Arul', NULL, 'New-D-2-Arul', 'Arul', 'Deposit From Customer-Arul', 300000, NULL, -530000, 'Cash', NULL, 'New Finance', NULL),
('6e2aabd2', '2025-04-28', 'Loan_To_Customer', 'Loan_To_Customer-New-STL9-Chandru post', 'New-STL9', 'New-11', NULL, 'Loan_To_Customer', NULL, 200000, -730000, 'Cash', NULL, 'New Finance', NULL),
('6cc4adf5', '2025-04-28', 'Loan_To_Customer', 'Loan_To_Customer-New-STL9-Chandru post', 'New-STL9', 'New-11', NULL, 'Loan_To_Customer', NULL, 200000, -930000, 'Cash', NULL, 'New Finance', NULL),
('5d8e81f9', '2025-04-28', 'Loan_To_Customer', 'Loan_To_Customer-New-STL9-Chandru post', 'New-STL9', 'New-11', NULL, 'Loan_To_Customer', NULL, 200000, -1130000, 'Cash', NULL, 'New Finance', NULL),
('824b863c', '2025-04-28', 'Loan_To_Customer', 'Loan_To_Customer-New-STL73-Periasamy', 'New-STL73', 'New-9', NULL, 'Loan_To_Customer', NULL, 75000, -1205000, 'Cash', NULL, 'New Finance', NULL),
('6319d559', '2025-04-28', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendar', 'New-STL46', 'New-6', NULL, 'Loan_To_Customer', NULL, 70000, -1275000, 'Cash', 'Tata Indica RC & TO form  TN47 U 3397', 'New Finance', NULL),
('9829af7f', '2025-04-29', 'Loan_To_Customer', 'Loan_To_Customer-New-STL11-Prakash SMP', 'New-STL11', 'New-2', NULL, 'Loan_To_Customer', NULL, 10000, -1285000, 'Cash', NULL, 'New Finance', NULL),
('38c9b8a9', '2025-04-29', 'Loan_To_Customer', 'Loan_To_Customer-New-STL11-Prakash SMP', 'New-STL11', 'New-1', NULL, 'Loan_To_Customer', NULL, 30000, -1315000, 'Cash', NULL, 'New Finance', NULL),
('48d49f27', '2025-04-29', 'Loan_To_Customer', 'Loan_To_Customer-New-STL11-Prakash SMP', 'New-STL11', 'New-1', NULL, 'Loan_To_Customer', NULL, 30000, -1345000, 'Cash', NULL, 'New Finance', NULL),
('e20ca2f7', '2025-04-29', 'Customer_Loan_Prin_Repayment', 'New-STL11-New-3-Prakash SMP-60000', 'New-STL11', 'New-3', 'Prakash SMP', 'Customer_Loan_Prin_Repayment', 30000, NULL, -1315000, 'Cash', NULL, 'New Finance', NULL),
('c652f2f5', '2025-04-29', 'Customer_Loan_Prin_Repayment', 'New-STL38-New-5-Sabarish-20000', 'New-STL38', 'New-5', 'Sabarish', 'Customer_Loan_Prin_Repayment', 10000, NULL, -1305000, 'Cash', NULL, 'New Finance', NULL),
('0c9f55a0', '2025-04-29', 'Customer_Loan_Prin_Repayment', 'New-STL58-New-7-Rajendran-15000', 'New-STL58', 'New-7', 'Rajendran', 'Customer_Loan_Prin_Repayment', 5000, NULL, -1300000, 'UPI', NULL, 'New Finance', NULL),
('77358931', '2025-04-29', 'Customer_Loan_Prin_Repayment', 'New-STL46-New-6-Danendar-70000', 'New-STL46', 'New-6', 'Danendar', 'Customer_Loan_Prin_Repayment', 60000, NULL, -1240000, 'Cash', NULL, 'New Finance', NULL),
('c0b22304', '2025-04-29', 'Customer_Loan_Prin_Repayment', 'New-STL78-New-10-Dinesh-80000', 'New-STL78', 'New-10', 'Dinesh', 'Customer_Loan_Prin_Repayment', 50000, NULL, -1190000, 'Cash', NULL, 'New Finance', NULL),
('cd4fc5ae', '2025-04-29', 'Customer_Loan_Prin_Repayment', 'New-STL38-New-5-Sabarish-10000', 'New-STL38', 'New-5', 'Sabarish', 'Customer_Loan_Prin_Repayment', 5000, NULL, -1185000, 'Cash', NULL, 'New Finance', NULL),
('4958a5a7', '2025-04-29', 'Customer_Loan_Prin_Repayment', 'New-STL38-New-5-Sabarish-5000', 'New-STL38', 'New-5', 'Sabarish', 'Customer_Loan_Prin_Repayment', 5000, NULL, -1180000, 'Cash', NULL, 'New Finance', NULL),
('0e278db1', '2025-04-29', 'Customer_Loan_Prin_Repayment', 'New-STL73-New-9-Periasamy-75000', 'New-STL73', 'New-9', 'Periasamy', 'Customer_Loan_Prin_Repayment', 25000, NULL, -1155000, 'Cash', NULL, 'New Finance', NULL),
('78069f8a', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL73-New-9-Periasamy-50000', 'New-STL73', 'New-9', 'Periasamy', 'Customer_Loan_Prin_Repayment', 20000, NULL, -1135000, 'Cash', NULL, 'New Finance', NULL),
('2b779887', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL73-New-9-Periasamy-30000', 'New-STL73', 'New-9', 'Periasamy', 'Customer_Loan_Prin_Repayment', 10000, NULL, -1125000, 'Cash', NULL, 'New Finance', NULL),
('8ee6c315', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL35-New-4-Selvaguru-140000', 'New-STL35', 'New-4', 'Selvaguru', 'Customer_Loan_Prin_Repayment', 14000, NULL, -1111000, 'Cash', NULL, 'New Finance', NULL),
('d3d09a05', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-200000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 50000, NULL, -1061000, 'Cash', NULL, 'New Finance', NULL),
('e13662ab', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-150000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 10000, NULL, -1051000, 'Cash', NULL, 'New Finance', NULL),
('5325a81b', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-140000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 10000, NULL, -1041000, 'Cash', NULL, 'New Finance', NULL),
('2c7f4c85', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-130000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 5000, NULL, -1036000, 'Cash', NULL, 'New Finance', NULL),
('e1f6a8a5', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-125000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 10000, NULL, -1026000, 'Cash', NULL, 'New Finance', NULL),
('5f48ada4', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-115000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 10000, NULL, -1016000, 'Cash', NULL, 'New Finance', NULL),
('a13c65a9', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-105000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 5000, NULL, -1011000, 'Cash', NULL, 'New Finance', NULL),
('5b26d9dc', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-100000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 5000, NULL, -1006000, 'Cash', NULL, 'New Finance', NULL),
('75a0708f', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-95000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 5000, NULL, -1001000, 'Cash', NULL, 'New Finance', NULL),
('d8a60164', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-90000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 5000, NULL, -996000, 'Cash', NULL, 'New Finance', NULL),
('ce5f3539', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-85000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 2000, NULL, -994000, NULL, NULL, 'New Finance', NULL),
('551961ff', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-83000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 5000, NULL, -989000, 'Cash', NULL, 'New Finance', NULL),
('6133a388', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-78000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 3000, NULL, -986000, 'Cash', NULL, 'New Finance', NULL),
('68ed70bf', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-11-Chandru post-75000', 'New-STL9', 'New-11', 'Chandru post', 'Customer_Loan_Prin_Repayment', 25000, NULL, -961000, 'Cash', NULL, 'New Finance', NULL),
('4bbcafe9', '2025-04-30', 'Deposit_Prin_Refund', 'New-D-2-Arul-Arul-Rs.300000', NULL, 'New-D-2-Arul-Arul-Rs.300000', 'Arul', 'Deposit_Prin_Refund', NULL, 30000, -991000, 'Cash', NULL, 'New Finance', NULL),
('c08b97d1', '2025-04-30', 'Deposit_Prin_Refund', 'New-D-1-Prakash-Prakash-Rs.150000', NULL, 'New-D-1-Prakash-Prakash-Rs.150000', 'Prakash', 'Deposit_Prin_Refund', NULL, 30000, -1021000, 'Cash', NULL, 'New Finance', NULL),
('328616b6', '2025-04-30', 'Deposit_Prin_Refund', 'New-D-2-Arul-Arul-Rs.300000', NULL, 'New-D-2-Arul-Arul-Rs.300000', 'Arul', 'Deposit_Prin_Refund', NULL, 20000, -1041000, 'Cash', NULL, 'New Finance', NULL),
('06164cbb', '2025-04-30', 'Deposit_Prin_Refund', 'New-D-1-Prakash-Prakash-Rs.150000', NULL, 'New-D-1-Prakash', 'Prakash', 'Deposit_Prin_Refund', NULL, 5000, -1046000, 'Cash', NULL, 'New Finance', NULL),
('8579003a', '2025-04-30', 'Deposit_Prin_Refund', 'New-D-1-Prakash-Prakash-Rs.150000', NULL, 'New-D-1-Prakash', 'Prakash', 'Deposit_Prin_Refund', NULL, 5000, -1051000, 'Cash', NULL, 'New Finance', NULL),
('c807dc0e', '2025-04-30', 'Other_Finance_Loan_Refund', 'New-O-1-Prakash_Finance-Prakash_Finance-Rs.100000', 'New-O-1-Prakash_Finance-Prakash_Finance-Rs.100000', 'New-O-1-Prakash_Finance', 'Prakash_Finance', 'Other_Finance_Loan_Refund', NULL, 5000, -1056000, 'Cash', NULL, 'New Finance', NULL),
('d8e5e6dd', '2025-04-30', 'Other_Finance_Loan_Refund', 'New-O-1-Prakash_Finance-Prakash_Finance-Rs.100000', 'New-O-1-Prakash_Finance-Prakash_Finance-Rs.100000', 'New-O-1-Prakash_Finance', 'Prakash_Finance', 'Other_Finance_Loan_Refund', NULL, 20000, -1076000, 'Cash', NULL, 'New Finance', NULL),
('58ec03c4', '2025-04-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL9-Chandru post', 'New-STL9', 'New-12', NULL, 'Loan_To_Customer', NULL, 100000, -1176000, 'Cash', NULL, 'New Finance', NULL),
('5690e8bc', '2025-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL9-New-12-Chandru post-100000', 'New-STL9', 'New-12', 'Chandru post', 'Customer_Loan_Prin_Repayment', 50000, NULL, -1126000, 'Cash', NULL, 'New Finance', NULL),
('f2bfc951', '2025-05-17', 'Loan_To_Customer', 'Loan_To_Customer-New-STL297-John Pilot', 'New-STL297', 'New-13', NULL, 'Loan_To_Customer', NULL, 500000, -1626000, 'Account', NULL, 'New Finance', NULL),
('aaa5abbd', '2025-05-17', 'Loan_To_Customer', 'Loan_To_Customer-New-STL297-John Pilot', 'New-STL297', 'New-13', NULL, 'Loan_To_Customer', NULL, 500000, -2126000, 'Account', NULL, 'New Finance', NULL),
('741ede0b', '2025-05-17', 'Loan_To_Customer', 'Loan_To_Customer-New-STL297-John Pilot', 'New-STL297', 'New-13', NULL, 'Loan_To_Customer', NULL, 500000, -2626000, 'Account', NULL, 'New Finance', NULL),
('1bc9fd02', '2025-05-17', 'Loan_To_Customer', 'Loan_To_Customer-New-STL297-John Pilot', 'New-STL297', 'New-13', NULL, 'Loan_To_Customer', NULL, 500000, -3126000, 'Account', NULL, 'New Finance', NULL),
('7fb606d8', '2025-05-17', 'Loan_To_Customer', 'Loan_To_Customer-New-STL297-John Pilot', 'New-STL297', 'New-13', NULL, 'Loan_To_Customer', NULL, 500000, -3626000, 'Account', NULL, 'New Finance', NULL),
('18d333ce', '2025-05-17', 'Loan_To_Customer', 'Loan_To_Customer-New-STL297-John Pilot', 'New-STL297', 'New-13', NULL, 'Loan_To_Customer', NULL, 500000, -4126000, 'Account', NULL, 'New Finance', NULL),
('6a0a2e9c', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL1-Chandrasekaran1', 'Mal-STL1', 'Mal-1', NULL, 'Loan_To_Customer', NULL, 200000, -200000, 'Cash', NULL, 'Malar_Finance', NULL),
('5e3801b5', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL12-Chandrasekar', 'Mal-STL12', 'Mal-2', NULL, 'Loan_To_Customer', NULL, 100000, -300000, 'Cash', NULL, 'Malar_Finance', NULL),
('b0ee8c00', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL11-Balu', 'Mal-STL11', 'Mal-3', NULL, 'Loan_To_Customer', NULL, 100000, -400000, 'Cash', NULL, 'Malar_Finance', NULL),
('44ab0684', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL10-Balu1', 'Mal-STL10', 'Mal-4', NULL, 'Loan_To_Customer', NULL, 50000, -450000, 'Cash', NULL, 'Malar_Finance', NULL),
('e33981de', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL13-Orange_Tex', 'Mal-STL13', 'Mal-5', NULL, 'Loan_To_Customer', NULL, 275000, -725000, 'Cash', NULL, 'Malar_Finance', NULL),
('c0455c6e', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL14-Ramkumar', 'Mal-STL14', 'Mal-6', NULL, 'Loan_To_Customer', NULL, 350000, -1075000, 'Cash', NULL, 'Malar_Finance', NULL),
('e592f89c', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL2-Ramkumar1', 'Mal-STL2', 'Mal-7', NULL, 'Loan_To_Customer', NULL, 1500000, -2575000, 'Cash', NULL, 'Malar_Finance', NULL),
('6ca4d6d2', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL2-Ramkumar1', 'Mal-STL2', 'Mal-8', NULL, 'Loan_To_Customer', NULL, 300000, -2875000, 'Cash', NULL, 'Malar_Finance', NULL),
('ded7fd1a', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL2-Ramkumar1', 'Mal-STL2', 'Mal-9', NULL, 'Loan_To_Customer', NULL, 500000, -3375000, 'Cash', NULL, 'Malar_Finance', NULL),
('3c7b9f8d', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL3-Kannan1', 'Mal-STL3', 'Mal-10', NULL, 'Loan_To_Customer', NULL, 500000, -3875000, 'Cash', NULL, 'Malar_Finance', NULL),
('5c56828c', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL9-Priya1', 'Mal-STL9', 'Mal-11', NULL, 'Loan_To_Customer', NULL, 200000, -4075000, 'Cash', NULL, 'Malar_Finance', NULL),
('3e3cae54', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL5-Elango1', 'Mal-STL5', 'Mal-12', NULL, 'Loan_To_Customer', NULL, 600000, -4675000, 'Cash', NULL, 'Malar_Finance', NULL),
('08a0ede9', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL6-AshokFinance1', 'Mal-STL6', 'Mal-13', NULL, 'Loan_To_Customer', NULL, 1000000, -5675000, 'Cash', NULL, 'Malar_Finance', NULL),
('a179aaff', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL4-Palanisamy1', 'Mal-STL4', 'Mal-14', NULL, 'Loan_To_Customer', NULL, 1000000, -6675000, 'Cash', NULL, 'Malar_Finance', NULL),
('c0269b9a', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL4-Palanisamy1', 'Mal-STL4', 'Mal-15', NULL, 'Loan_To_Customer', NULL, 500000, -7175000, 'Cash', NULL, 'Malar_Finance', NULL),
('9abbea1a', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL7-Akpr1', 'Mal-STL7', 'Mal-16', NULL, 'Loan_To_Customer', NULL, 5850000, -13025000, 'Cash', NULL, 'Malar_Finance', NULL),
('88f06cda', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL8-Mahesh1', 'Mal-STL8', 'Mal-17', NULL, 'Loan_To_Customer', NULL, 250000, -13275000, 'Cash', NULL, 'Malar_Finance', NULL),
('920f8b0e', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL15-Pradeep', 'Mal-STL15', 'Mal-18', NULL, 'Loan_To_Customer', NULL, 100000, -13375000, 'Cash', NULL, 'Malar_Finance', NULL),
('f5fcf0e8', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL16-Amuthavel', 'Mal-STL16', 'Mal-19', NULL, 'Loan_To_Customer', NULL, 100000, -13475000, 'Cash', NULL, 'Malar_Finance', NULL),
('3d1aa879', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL16-Amuthavel', 'Mal-STL16', 'Mal-20', NULL, 'Loan_To_Customer', NULL, 150000, -13625000, 'Cash', NULL, 'Malar_Finance', NULL),
('9dc214b7', '2025-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL16-Amuthavel', 'Mal-STL16', 'Mal-21', NULL, 'Loan_To_Customer', NULL, 350000, -13975000, 'Cash', NULL, 'Malar_Finance', NULL),
('48e91b3a', '2025-06-04', 'Deposit_From_Customer', 'Deposit-Mal-D-1-Gokila_Akka-Gokila_Akka', NULL, 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', 'Deposit From Customer-Gokila_Akka', 200000, NULL, -13775000, 'Cash', NULL, 'Malar_Finance', NULL),
('1484d4d9', '2025-03-01', 'Deposit_From_Customer', 'Deposit-Mal-D-2-Malar_Appa-Malar_Appa', NULL, 'Mal-D-2-Malar_Appa', 'Malar_Appa', 'Deposit From Customer-Malar_Appa', 100000, NULL, -13675000, 'Cash', NULL, 'Malar_Finance', NULL),
('Deposit-Mal-D-3-Ravi_Mama-Ravi_Mama-6407b944', '2025-06-01', 'Deposit_From_Customer', 'Deposit-Mal-D-3-Ravi_Mama-Ravi_Mama', NULL, 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', 'Interest-Mal-D-3-Ravi_Mama', 50000, NULL, -13625000, 'Cash', NULL, 'Malar_Finance', '#NUM!'),
('Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-03-2025-9d48ec86', '2025-06-27', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-03-2025', 'Mal-STL2', 'Mal-7', 'Ramkumar1', 'Interest-Mal-7', 387, NULL, 387, 'Cash', NULL, 'Malar_Appa', '387'),
('Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-04-2025-9d48ec86', '2025-06-27', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-04-2025', 'Mal-STL2', 'Mal-7', 'Ramkumar1', 'Interest-Mal-7', 12000, NULL, 12387, 'Cash', NULL, 'Malar_Appa', '12000'),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-04-2025-9d48ec86', '2025-06-27', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-8-300000-Interest-04-2025', 'Mal-STL2', 'Mal-8', 'Ramkumar1', 'Interest-Mal-8', 160, NULL, 12547, 'Cash', NULL, 'Malar_Appa', '160'),
('Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-05-2025-9d48ec86', '2025-06-27', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-05-2025', 'Mal-STL2', 'Mal-7', 'Ramkumar1', 'Interest-Mal-7', 11453, NULL, 24000, 'Cash', NULL, 'Malar_Appa', '12000');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-05-2025-b3028a77', '2025-06-27', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-05-2025', 'Mal-STL2', 'Mal-7', 'Ramkumar1', 'Interest-Mal-7', 547, NULL, 24547, 'Cash', NULL, 'Malar_Appa', '547'),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-05-2025-b3028a77', '2025-06-27', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-8-300000-Interest-05-2025', 'Mal-STL2', 'Mal-8', 'Ramkumar1', 'Interest-Mal-8', 2400, NULL, 26947, 'Cash', NULL, 'Malar_Appa', '2400'),
('Ramkumar1-Mal-STL2-Mal-9-500000-Interest-05-2025-b3028a77', '2025-06-27', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-9-500000-Interest-05-2025', 'Mal-STL2', 'Mal-9', 'Ramkumar1', 'Interest-Mal-9', 129, NULL, 27076, 'Cash', NULL, 'Malar_Appa', '129'),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-04-2025-905a8910', '2025-06-27', 'Customer_Interest', 'Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-04-2025', 'Mal-STL1', 'Mal-1', 'Chandrasekaran1', 'Interest-Mal-1', 1400, NULL, 28476, 'Cash', NULL, 'Malar_Appa', '1400'),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-05-2025-905a8910', '2025-06-27', 'Customer_Interest', 'Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-05-2025', 'Mal-STL1', 'Mal-1', 'Chandrasekaran1', 'Interest-Mal-1', 3600, NULL, 32076, 'Cash', NULL, 'Malar_Appa', '4340'),
('e5d8ad5e', '2025-06-27', 'Customer_Interest', 'Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-04-2025,Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-05-2025', 'Mal-STL1,Mal-STL1', 'Mal-1,Mal-1', 'Chandrasekaran1', 'Interest-04-2025', 700, NULL, 32776, 'Cash', NULL, 'Malar_Appa', '5740'),
('Palanisamy1-Mal-STL4-Mal-14-1000000-Interest-04-2025-444bccd1', '2025-07-02', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-14-1000000-Interest-04-2025', 'Mal-STL4', 'Mal-14', 'Palanisamy1', 'Interest-Mal-14', 4267, NULL, 37043, 'Cash', NULL, 'Malar_Appa', '4267'),
('Palanisamy1-Mal-STL4-Mal-14-1000000-Interest-05-2025-444bccd1', '2025-07-02', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-14-1000000-Interest-05-2025', 'Mal-STL4', 'Mal-14', 'Palanisamy1', 'Interest-Mal-14', 8000, NULL, 45043, 'Cash', NULL, 'Malar_Appa', '8000'),
('Palanisamy1-Mal-STL4-Mal-15-500000-Interest-05-2025-444bccd1', '2025-07-02', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-15-500000-Interest-05-2025', 'Mal-STL4', 'Mal-15', 'Palanisamy1', 'Interest-Mal-15', 2839, NULL, 47882, 'Cash', NULL, 'Malar_Appa', '2839'),
('AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-05-2025-63ab9d8b', '2025-07-02', 'Customer_Interest', 'AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-05-2025', 'Mal-STL6', 'Mal-13', 'AshokFinance1', 'Interest-Mal-13', 8710, NULL, 56592, 'UPI', 'through gpay via kannan on 02/07/25', 'Malar_Appa', '8710'),
('AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-06-2025-63ab9d8b', '2025-07-02', 'Customer_Interest', 'AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-06-2025', 'Mal-STL6', 'Mal-13', 'AshokFinance1', 'Interest-Mal-13', 10000, NULL, 66592, 'UPI', 'through gpay via kannan on 02/07/25', 'Malar_Appa', '10000'),
('Pradeep-Mal-STL15-Mal-18-100000-Interest-03-2025-7b8dc5d3', '2025-07-03', 'Customer_Interest', 'Pradeep-Mal-STL15-Mal-18-100000-Interest-03-2025', 'Mal-STL15', 'Mal-18', 'Pradeep', 'Interest-Mal-18', 2170, NULL, 68762, 'Cash', 'gpay last month', 'Malar_Appa', '2170'),
('Pradeep-Mal-STL15-Mal-18-100000-Interest-04-2025-7b8dc5d3', '2025-07-03', 'Customer_Interest', 'Pradeep-Mal-STL15-Mal-18-100000-Interest-04-2025', 'Mal-STL15', 'Mal-18', 'Pradeep', 'Interest-Mal-18', 2100, NULL, 70862, 'Cash', 'gpay last month', 'Malar_Appa', '2100'),
('Pradeep-Mal-STL15-Mal-18-100000-Interest-05-2025-7b8dc5d3', '2025-07-03', 'Customer_Interest', 'Pradeep-Mal-STL15-Mal-18-100000-Interest-05-2025', 'Mal-STL15', 'Mal-18', 'Pradeep', 'Interest-Mal-18', 2170, NULL, 73032, 'Cash', 'gpay last month', 'Malar_Appa', '2170'),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-05-2025-af3fbf40', '2025-07-03', 'Customer_Interest', 'Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-05-2025', 'Mal-STL1', 'Mal-1', 'Chandrasekaran1', 'Interest-Mal-1', 740, NULL, 73772, 'Cash', NULL, 'Malar_Appa', '740'),
('f67d012f', '2025-07-08', 'Customer_Loan_Prin_Repayment', 'Mal-STL4-Mal-14-Palanisamy1-1000000', 'Mal-STL4', 'Mal-14', 'Palanisamy1', 'Customer_Loan_Prin_Repayment', 900000, NULL, 973772, 'Cash', NULL, 'Malar_Appa', '8000,4000'),
('300106dc', '2025-08-07', 'Customer_Loan_Prin_Repayment', 'Mal-STL2-Mal-7-Ramkumar1-1500000', 'Mal-STL2', 'Mal-7', 'Ramkumar1', 'Customer_Loan_Prin_Repayment', 1000000, NULL, 1973772, 'Cash', 'given to appa', 'Malar_Appa', '12000,2400,4000'),
('74d5ee3e', '2025-08-12', 'Customer_Loan_Prin_Repayment', 'Mal-STL2-Mal-7-Ramkumar1-500000', 'Mal-STL2', 'Mal-7', 'Ramkumar1', 'Customer_Loan_Prin_Repayment', 500000, NULL, 2473772, 'Cash', NULL, 'Malar_Appa', '12000,2400,4000'),
('999fd577', '2025-08-12', 'Customer_Loan_Prin_Repayment', 'Mal-STL2-Mal-9-Ramkumar1-500000', 'Mal-STL2', 'Mal-9', 'Ramkumar1', 'Customer_Loan_Prin_Repayment', 500000, NULL, 2973772, 'Cash', NULL, 'Malar_Appa', '12000,2400,4000,1806,1548'),
('Mal-STL16-Mal-21-Amuthavel-350000-7bcb2729', '2025-07-09', 'Customer_Loan_Prin_Repayment', 'Mal-STL16-Mal-21-Amuthavel-350000', 'Mal-STL16', 'Mal-21', 'Amuthavel', 'Interest-Mal-21', 350000, NULL, 3323772, 'Cash', 'given to dinesh namakkal', 'Malar_Appa', '#NUM!'),
('Mal-STL16-Mal-20-Amuthavel-150000-7ff4c986', '2025-07-09', 'Customer_Loan_Prin_Repayment', 'Mal-STL16-Mal-20-Amuthavel-150000', 'Mal-STL16', 'Mal-20', 'Amuthavel', 'Interest-Mal-20', 150000, NULL, 3473772, 'Cash', 'given to dinesh namakkal', 'Malar_Appa', '#NUM!'),
('Mal-STL16-Mal-19-Amuthavel-100000-9161f605', '2025-07-09', 'Customer_Loan_Prin_Repayment', 'Mal-STL16-Mal-19-Amuthavel-100000', 'Mal-STL16', 'Mal-19', 'Amuthavel', 'Interest-Mal-19', 100000, NULL, 3573772, NULL, NULL, 'Malar_Appa', '#NUM!'),
('cdfdbe45', '2025-08-17', 'Customer_Loan_Prin_Repayment', 'Mal-STL4-Mal-15-Palanisamy1-500000', 'Mal-STL4', 'Mal-15', 'Palanisamy1', 'Customer_Loan_Prin_Repayment', 500000, NULL, 4073772, 'Cash', NULL, 'Malar_Appa', '8000,4000,1858,2090,4000'),
('0a8eadfc', '2025-08-17', 'Customer_Loan_Prin_Repayment', 'Mal-STL4-Mal-14-Palanisamy1-100000', 'Mal-STL4', 'Mal-14', 'Palanisamy1', 'Customer_Loan_Prin_Repayment', 100000, NULL, 4173772, 'Cash', NULL, 'Malar_Appa', '8000,4000,1848,4000,2194,800'),
('Palanisamy1-Mal-STL4-Mal-14-1000000-Interest-06-2025-02459a81', '2025-07-10', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-14-1000000-Interest-06-2025', 'Mal-STL4', 'Mal-14', 'Palanisamy1', 'Interest-Mal-14', 8000, NULL, 4181772, 'UPI', NULL, 'Malar_Appa', '8000'),
('Palanisamy1-Mal-STL4-Mal-15-500000-Interest-06-2025-02459a81', '2025-07-10', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-15-500000-Interest-06-2025', 'Mal-STL4', 'Mal-15', 'Palanisamy1', 'Interest-Mal-15', 4000, NULL, 4185772, 'UPI', NULL, 'Malar_Appa', '4000'),
('ae7bf706', '2025-08-17', 'Customer_Loan_Prin_Repayment', 'Mal-STL2-Mal-8-Ramkumar1-300000', 'Mal-STL2', 'Mal-8', 'Ramkumar1', 'Customer_Loan_Prin_Repayment', 300000, NULL, 4485772, 'Cash', NULL, 'Malar_Appa', '12000,2400,4000,1806,1548,1548,2400'),
('74c7e881', '2025-08-19', 'Customer_Loan_Prin_Repayment', 'Mal-STL7-Mal-16-Akpr1-5850000', 'Mal-STL7', 'Mal-16', 'Akpr1', 'Customer_Loan_Prin_Repayment', 5850000, NULL, 10335772, 'Cash', NULL, 'Malar_Appa', '1510,46800,46800'),
('Senthil_Vaduvatti-Mal-STL17-Mal-23-300000-Interest-07-2025-9b8ba78a', '2025-08-18', 'Customer_Interest', 'Senthil_Vaduvatti-Mal-STL17-Mal-23-300000-Interest-07-2025', 'Mal-STL17', 'Mal-23', 'Senthil_Vaduvatti', 'Interest-Mal-23', 2400, NULL, 10338172, 'UPI', NULL, 'Malar_Appa', '2400'),
('Mal-STL5-Mal-12-Elango1-600000-962260b2', '2025-08-19', 'Customer_Loan_Prin_Repayment', 'Mal-STL5-Mal-12-Elango1-600000', 'Mal-STL5', 'Mal-12', 'Elango1', 'Interest-Mal-12', 600000, NULL, 10938172, NULL, NULL, 'Malar_Appa', '#NUM!'),
('0e8ad0b2', '2025-08-18', 'Customer_Loan_Prin_Repayment', 'Mal-STL3-Mal-10-Kannan1-500000', 'Mal-STL3', 'Mal-10', 'Kannan1', 'Customer_Loan_Prin_Repayment', 500000, NULL, 11438172, 'Cash', NULL, 'Malar_Appa', '1935,4000,4000'),
('AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-07-2025-ac572611', '2025-08-19', 'Customer_Interest', 'AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-07-2025', 'Mal-STL6', 'Mal-13', 'AshokFinance1', 'Interest-Mal-13', 10000, NULL, 11448172, 'Cash', 'RECEIVED UNDER KANNAN RS15000 COVER', 'Malar_Appa', '10000'),
('AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-08-2025-ac572611', '2025-08-19', 'Customer_Interest', 'AshokFinance1-Mal-STL6-Mal-13-1000000-Interest-08-2025', 'Mal-STL6', 'Mal-13', 'AshokFinance1', 'Interest-Mal-13', 4839, NULL, 11453011, 'Cash', 'RECEIVED UNDER KANNAN RS15000 COVER', 'Malar_Appa', '4839'),
('Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-06-2025-0995a91f', '2025-08-19', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-7-1500000-Interest-06-2025', 'Mal-STL2', 'Mal-7', 'Ramkumar1', 'Interest-Mal-7', 12000, NULL, 11465011, 'Cash', 'interest received', 'Malar_Appa', '12000'),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-06-2025-0995a91f', '2025-08-19', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-8-300000-Interest-06-2025', 'Mal-STL2', 'Mal-8', 'Ramkumar1', 'Interest-Mal-8', 2400, NULL, 11467411, 'Cash', 'interest received', 'Malar_Appa', '2400'),
('Ramkumar1-Mal-STL2-Mal-9-500000-Interest-06-2025-0995a91f', '2025-08-19', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-9-500000-Interest-06-2025', 'Mal-STL2', 'Mal-9', 'Ramkumar1', 'Interest-Mal-9', 4000, NULL, 11471411, 'Cash', 'interest received', 'Malar_Appa', '4000'),
('Ramkumar1-Mal-STL2-Mal-7-1000000-Interest-08-2025-0995a91f', '2025-08-19', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-7-1000000-Interest-08-2025', 'Mal-STL2', 'Mal-7', 'Ramkumar1', 'Interest-Mal-7', 1806, NULL, 11473217, 'Cash', 'interest received', 'Malar_Appa', '1806'),
('Ramkumar1-Mal-STL2-Mal-7-500000-Interest-08-2025-0995a91f', '2025-08-19', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-7-500000-Interest-08-2025', 'Mal-STL2', 'Mal-7', 'Ramkumar1', 'Interest-Mal-7', 1548, NULL, 11474765, 'Cash', 'interest received', 'Malar_Appa', '1548'),
('Ramkumar1-Mal-STL2-Mal-9-500000-Interest-08-2025-0995a91f', '2025-08-19', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-9-500000-Interest-08-2025', 'Mal-STL2', 'Mal-9', 'Ramkumar1', 'Interest-Mal-9', 1548, NULL, 11476313, 'Cash', 'interest received', 'Malar_Appa', '1548'),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-07-2025-0995a91f', '2025-08-19', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-8-300000-Interest-07-2025', 'Mal-STL2', 'Mal-8', 'Ramkumar1', 'Interest-Mal-8', 2400, NULL, 11478713, 'Cash', 'interest received', 'Malar_Appa', '2400'),
('Ramkumar1-Mal-STL2-Mal-8-300000-Interest-08-2025-0995a91f', '2025-08-19', 'Customer_Interest', 'Ramkumar1-Mal-STL2-Mal-8-300000-Interest-08-2025', 'Mal-STL2', 'Mal-8', 'Ramkumar1', 'Interest-Mal-8', 1316, NULL, 11480029, 'Cash', 'interest received', 'Malar_Appa', '1316'),
('Palanisamy1-Mal-STL4-Mal-14-900000-Interest-07-2025-5a454bd0', '2025-08-19', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-14-900000-Interest-07-2025', 'Mal-STL4', 'Mal-14', 'Palanisamy1', 'Interest-Mal-14', 1848, NULL, 11481877, 'Cash', NULL, 'Malar_Appa', '1848'),
('Palanisamy1-Mal-STL4-Mal-15-500000-Interest-07-2025-5a454bd0', '2025-08-19', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-15-500000-Interest-07-2025', 'Mal-STL4', 'Mal-15', 'Palanisamy1', 'Interest-Mal-15', 4000, NULL, 11485877, 'Cash', NULL, 'Malar_Appa', '4000'),
('Palanisamy1-Mal-STL4-Mal-15-500000-Interest-08-2025-5a454bd0', '2025-08-19', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-15-500000-Interest-08-2025', 'Mal-STL4', 'Mal-15', 'Palanisamy1', 'Interest-Mal-15', 2194, NULL, 11488071, 'Cash', NULL, 'Malar_Appa', '2194'),
('Palanisamy1-Mal-STL4-Mal-14-100000-Interest-07-2025-5a454bd0', '2025-08-19', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-14-100000-Interest-07-2025', 'Mal-STL4', 'Mal-14', 'Palanisamy1', 'Interest-Mal-14', 800, NULL, 11488871, 'Cash', NULL, 'Malar_Appa', '800'),
('Palanisamy1-Mal-STL4-Mal-14-100000-Interest-08-2025-5a454bd0', '2025-08-19', 'Customer_Interest', 'Palanisamy1-Mal-STL4-Mal-14-100000-Interest-08-2025', 'Mal-STL4', 'Mal-14', 'Palanisamy1', 'Interest-Mal-14', 439, NULL, 11489310, 'Cash', NULL, 'Malar_Appa', '439'),
('Mal-STL6-Mal-13-AshokFinance1-1000000-d8c8c35f', '2025-08-15', 'Customer_Loan_Prin_Repayment', 'Mal-STL6-Mal-13-AshokFinance1-1000000', 'Mal-STL6', 'Mal-13', 'AshokFinance1', 'Interest-Mal-13', 1000000, NULL, 12489310, 'Cash', NULL, 'Malar_Appa', '#NUM!'),
('ececbaf5', '2025-08-18', 'Customer_Loan_Prin_Repayment', 'Mal-STL1-Mal-1-Chandrasekaran1-200000', 'Mal-STL1', 'Mal-1', 'Chandrasekaran1', 'Customer_Loan_Prin_Repayment', 200000, NULL, 12689310, 'Cash', 'to kannan finance loan', 'Malar_Appa', '4200,4340'),
('0dc7b067', '2025-08-19', 'Customer_Loan_Prin_Repayment', 'Mal-STL10-Mal-4-Balu1-50000', 'Mal-STL10', 'Mal-4', 'Balu1', 'Customer_Loan_Prin_Repayment', 50000, NULL, 12739310, 'Cash', NULL, 'Malar_Appa', '70,1050,1085'),
('c375574d', '2025-08-18', 'Customer_Loan_Prin_Repayment', 'Mal-STL9-Mal-11-Priya1-200000', 'Mal-STL9', 'Mal-11', 'Priya1', 'Customer_Loan_Prin_Repayment', 200000, NULL, 12939310, 'Cash', NULL, 'Malar_Appa', '3780,4340'),
('6273a5fd', '2025-08-18', 'Customer_Loan_Prin_Repayment', 'Mal-STL8-Mal-17-Mahesh1-250000', 'Mal-STL8', 'Mal-17', 'Mahesh1', 'Customer_Loan_Prin_Repayment', 250000, NULL, 13189310, 'Cash', NULL, 'Malar_Appa', '2275,5250,5425'),
('cdcf3431', '2025-08-19', 'Customer_Loan_Prin_Repayment', 'Mal-STL15-Mal-18-Pradeep-100000', 'Mal-STL15', 'Mal-18', 'Pradeep', 'Customer_Loan_Prin_Repayment', 100000, NULL, 13289310, 'Cash', NULL, 'Malar_Appa', '2100,2170'),
('Mal-STL17-Mal-23-Senthil_Vaduvatti-300000-6f582dd8', '2025-08-17', 'Customer_Loan_Prin_Repayment', 'Mal-STL17-Mal-23-Senthil_Vaduvatti-300000', 'Mal-STL17', 'Mal-23', 'Senthil_Vaduvatti', 'Interest-Mal-23', 300000, NULL, 13589310, 'Cash', NULL, 'Malar_Appa', '#NUM!'),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-06-2025-968cdc31', '2025-08-30', 'Customer_Interest', 'Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-06-2025', 'Mal-STL1', 'Mal-1', 'Chandrasekaran1', 'Interest-Mal-1', 4200, NULL, 13593510, 'Cash', NULL, 'Malar_Appa', '4200'),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-07-2025-968cdc31', '2025-08-30', 'Customer_Interest', 'Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-07-2025', 'Mal-STL1', 'Mal-1', 'Chandrasekaran1', 'Interest-Mal-1', 4340, NULL, 13597850, 'Cash', NULL, 'Malar_Appa', '4340'),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-08-2025-968cdc31', '2025-08-30', 'Customer_Interest', 'Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-08-2025', 'Mal-STL1', 'Mal-1', 'Chandrasekaran1', 'Interest-Mal-1', 980, NULL, 13598830, 'Cash', NULL, 'Malar_Appa', '2520'),
('Akpr1-Mal-STL7-Mal-16-5850000-Interest-05-2025-e38fde2f', '2025-08-30', 'Customer_Interest', 'Akpr1-Mal-STL7-Mal-16-5850000-Interest-05-2025', 'Mal-STL7', 'Mal-16', 'Akpr1', 'Interest-Mal-16', 1510, NULL, 13600340, 'Cash', NULL, 'Malar_Appa', '1510'),
('Akpr1-Mal-STL7-Mal-16-5850000-Interest-06-2025-e38fde2f', '2025-08-30', 'Customer_Interest', 'Akpr1-Mal-STL7-Mal-16-5850000-Interest-06-2025', 'Mal-STL7', 'Mal-16', 'Akpr1', 'Interest-Mal-16', 46800, NULL, 13647140, 'Cash', NULL, 'Malar_Appa', '46800'),
('Akpr1-Mal-STL7-Mal-16-5850000-Interest-07-2025-e38fde2f', '2025-08-30', 'Customer_Interest', 'Akpr1-Mal-STL7-Mal-16-5850000-Interest-07-2025', 'Mal-STL7', 'Mal-16', 'Akpr1', 'Interest-Mal-16', 46800, NULL, 13693940, 'Cash', NULL, 'Malar_Appa', '46800'),
('Akpr1-Mal-STL7-Mal-16-5850000-Interest-08-2025-e38fde2f', '2025-08-30', 'Customer_Interest', 'Akpr1-Mal-STL7-Mal-16-5850000-Interest-08-2025', 'Mal-STL7', 'Mal-16', 'Akpr1', 'Interest-Mal-16', 28684, NULL, 13722624, 'Cash', NULL, 'Malar_Appa', '28684'),
('Kannan1-Mal-STL3-Mal-10-500000-Interest-05-2025-02758a5b', '2025-08-30', 'Customer_Interest', 'Kannan1-Mal-STL3-Mal-10-500000-Interest-05-2025', 'Mal-STL3', 'Mal-10', 'Kannan1', 'Interest-Mal-10', 1935, NULL, 13724559, 'Cash', 'adjusted for school fees of 10k', 'Malar_Appa', '1935'),
('Kannan1-Mal-STL3-Mal-10-500000-Interest-06-2025-02758a5b', '2025-08-30', 'Customer_Interest', 'Kannan1-Mal-STL3-Mal-10-500000-Interest-06-2025', 'Mal-STL3', 'Mal-10', 'Kannan1', 'Interest-Mal-10', 4000, NULL, 13728559, 'Cash', 'adjusted for school fees of 10k', 'Malar_Appa', '4000'),
('Kannan1-Mal-STL3-Mal-10-500000-Interest-07-2025-02758a5b', '2025-08-30', 'Customer_Interest', 'Kannan1-Mal-STL3-Mal-10-500000-Interest-07-2025', 'Mal-STL3', 'Mal-10', 'Kannan1', 'Interest-Mal-10', 4000, NULL, 13732559, 'Cash', 'adjusted for school fees of 10k', 'Malar_Appa', '4000'),
('Kannan1-Mal-STL3-Mal-10-500000-Interest-08-2025-02758a5b', '2025-08-30', 'Customer_Interest', 'Kannan1-Mal-STL3-Mal-10-500000-Interest-08-2025', 'Mal-STL3', 'Mal-10', 'Kannan1', 'Interest-Mal-10', 65, NULL, 13732624, 'Cash', 'adjusted for school fees of 10k', 'Malar_Appa', '2323'),
('Priya1-Mal-STL9-Mal-11-200000-Interest-06-2025-f47c3aa0', '2025-08-30', 'Customer_Interest', 'Priya1-Mal-STL9-Mal-11-200000-Interest-06-2025', 'Mal-STL9', 'Mal-11', 'Priya1', 'Interest-Mal-11', 3780, NULL, 13736404, 'Cash', NULL, 'Malar_Appa', '3780'),
('Priya1-Mal-STL9-Mal-11-200000-Interest-07-2025-f47c3aa0', '2025-08-30', 'Customer_Interest', 'Priya1-Mal-STL9-Mal-11-200000-Interest-07-2025', 'Mal-STL9', 'Mal-11', 'Priya1', 'Interest-Mal-11', 4340, NULL, 13740744, 'Cash', NULL, 'Malar_Appa', '4340'),
('Priya1-Mal-STL9-Mal-11-200000-Interest-08-2025-f47c3aa0', '2025-08-30', 'Customer_Interest', 'Priya1-Mal-STL9-Mal-11-200000-Interest-08-2025', 'Mal-STL9', 'Mal-11', 'Priya1', 'Interest-Mal-11', 2520, NULL, 13743264, 'Cash', NULL, 'Malar_Appa', '2520'),
('Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-08-2025-b17a6628', '2025-08-30', 'Customer_Interest', 'Chandrasekaran1-Mal-STL1-Mal-1-200000-Interest-08-2025', 'Mal-STL1', 'Mal-1', 'Chandrasekaran1', 'Interest-Mal-1', 1540, NULL, 13744804, 'Cash', NULL, 'Malar_Appa', '1540'),
('Balu1-Mal-STL10-Mal-4-50000-Interest-05-2025-0f1ca693', '2025-08-30', 'Customer_Interest', 'Balu1-Mal-STL10-Mal-4-50000-Interest-05-2025', 'Mal-STL10', 'Mal-4', 'Balu1', 'Interest-Mal-4', 70, NULL, 13744874, 'Cash', NULL, 'Malar_Appa', '70'),
('Balu1-Mal-STL10-Mal-4-50000-Interest-06-2025-0f1ca693', '2025-08-30', 'Customer_Interest', 'Balu1-Mal-STL10-Mal-4-50000-Interest-06-2025', 'Mal-STL10', 'Mal-4', 'Balu1', 'Interest-Mal-4', 1050, NULL, 13745924, 'Cash', NULL, 'Malar_Appa', '1050'),
('Balu1-Mal-STL10-Mal-4-50000-Interest-07-2025-0f1ca693', '2025-08-30', 'Customer_Interest', 'Balu1-Mal-STL10-Mal-4-50000-Interest-07-2025', 'Mal-STL10', 'Mal-4', 'Balu1', 'Interest-Mal-4', 1085, NULL, 13747009, 'Cash', NULL, 'Malar_Appa', '1085'),
('Balu1-Mal-STL10-Mal-4-50000-Interest-08-2025-0f1ca693', '2025-08-30', 'Customer_Interest', 'Balu1-Mal-STL10-Mal-4-50000-Interest-08-2025', 'Mal-STL10', 'Mal-4', 'Balu1', 'Interest-Mal-4', 665, NULL, 13747674, 'Cash', NULL, 'Malar_Appa', '665'),
('Balu1-Mal-STL10-Mal-4-50000-Interest-05-2025-50e4c11a', '2025-08-30', 'Customer_Interest', 'Balu1-Mal-STL10-Mal-4-50000-Interest-05-2025', 'Mal-STL10', 'Mal-4', 'Balu1', 'Interest-Mal-4', 70, NULL, 13747744, 'Cash', NULL, 'Malar_Appa', '70'),
('Balu1-Mal-STL10-Mal-4-50000-Interest-06-2025-50e4c11a', '2025-08-30', 'Customer_Interest', 'Balu1-Mal-STL10-Mal-4-50000-Interest-06-2025', 'Mal-STL10', 'Mal-4', 'Balu1', 'Interest-Mal-4', 1050, NULL, 13748794, 'Cash', NULL, 'Malar_Appa', '1050'),
('Balu1-Mal-STL10-Mal-4-50000-Interest-07-2025-50e4c11a', '2025-08-30', 'Customer_Interest', 'Balu1-Mal-STL10-Mal-4-50000-Interest-07-2025', 'Mal-STL10', 'Mal-4', 'Balu1', 'Interest-Mal-4', 1085, NULL, 13749879, 'Cash', NULL, 'Malar_Appa', '1085'),
('Balu1-Mal-STL10-Mal-4-50000-Interest-08-2025-50e4c11a', '2025-08-30', 'Customer_Interest', 'Balu1-Mal-STL10-Mal-4-50000-Interest-08-2025', 'Mal-STL10', 'Mal-4', 'Balu1', 'Interest-Mal-4', 665, NULL, 13750544, 'Cash', NULL, 'Malar_Appa', '665'),
('Mahesh1-Mal-STL8-Mal-17-250000-Interest-05-2025-00d91dac', '2025-08-30', 'Customer_Interest', 'Mahesh1-Mal-STL8-Mal-17-250000-Interest-05-2025', 'Mal-STL8', 'Mal-17', 'Mahesh1', 'Interest-Mal-17', 2275, NULL, 13752819, 'Cash', NULL, 'Malar_Appa', '2275'),
('Mahesh1-Mal-STL8-Mal-17-250000-Interest-06-2025-00d91dac', '2025-08-30', 'Customer_Interest', 'Mahesh1-Mal-STL8-Mal-17-250000-Interest-06-2025', 'Mal-STL8', 'Mal-17', 'Mahesh1', 'Interest-Mal-17', 5250, NULL, 13758069, 'Cash', NULL, 'Malar_Appa', '5250'),
('Mahesh1-Mal-STL8-Mal-17-250000-Interest-07-2025-00d91dac', '2025-08-30', 'Customer_Interest', 'Mahesh1-Mal-STL8-Mal-17-250000-Interest-07-2025', 'Mal-STL8', 'Mal-17', 'Mahesh1', 'Interest-Mal-17', 3150, NULL, 13761219, 'Cash', NULL, 'Malar_Appa', '5425'),
('Kannan1-Mal-STL3-Mal-10-500000-Interest-08-2025-79ac0a41', '2025-08-30', 'Customer_Interest', 'Kannan1-Mal-STL3-Mal-10-500000-Interest-08-2025', 'Mal-STL3', 'Mal-10', 'Kannan1', 'Interest-Mal-10', 2258, NULL, 13763477, 'Cash', NULL, 'Malar_Appa', '2258'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-04-2025-378aae70', '2025-08-30', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-04-2025', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-Mal-2', 2100, NULL, -13622900, 'Cash', NULL, 'Malar_Finance', '2100'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-05-2025-378aae70', '2025-08-30', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-05-2025', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-Mal-2', 2170, NULL, -13620730, 'Cash', NULL, 'Malar_Finance', '2170'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-06-2025-378aae70', '2025-08-30', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-06-2025', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-Mal-2', 2100, NULL, -13618630, 'Cash', NULL, 'Malar_Finance', '2100'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-07-2025-378aae70', '2025-08-30', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-07-2025', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-Mal-2', 630, NULL, -13618000, 'Cash', NULL, 'Malar_Finance', '2170'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-04-2025-efaf152f', '2025-08-30', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-04-2025', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-Mal-5', 6480, NULL, -13611520, 'Cash', 'ajusted to ramkumar', 'Malar_Finance', '6480'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-05-2025-efaf152f', '2025-08-30', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-05-2025', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-Mal-5', 6696, NULL, -13604824, 'Cash', 'ajusted to ramkumar', 'Malar_Finance', '6696'),
('Orange_Tex-Mal-STL13-Mal-5-275000-Interest-06-2025-efaf152f', '2025-08-30', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-275000-Interest-06-2025', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-Mal-5', 6600, NULL, -13598224, 'Cash', 'ajusted to ramkumar', 'Malar_Finance', '6600'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-07-2025-efaf152f', '2025-08-30', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-07-2025', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-Mal-5', 6696, NULL, -13591528, 'Cash', 'ajusted to ramkumar', 'Malar_Finance', '6696'),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-04-2025-f18ea841', '2025-08-30', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-350000-Interest-04-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-Mal-6', 6300, NULL, -13585228, 'Cash', 'adjusted in chit', 'Malar_Finance', '6300'),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-05-2025-f18ea841', '2025-08-30', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-350000-Interest-05-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-Mal-6', 6510, NULL, -13578718, 'Cash', 'adjusted in chit', 'Malar_Finance', '6510'),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-06-2025-f18ea841', '2025-08-30', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-350000-Interest-06-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-Mal-6', 6300, NULL, -13572418, 'Cash', 'adjusted in chit', 'Malar_Finance', '6300'),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-07-2025-f18ea841', '2025-08-30', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-350000-Interest-07-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-Mal-6', 6510, NULL, -13565908, 'Cash', 'adjusted in chit', 'Malar_Finance', '6510'),
('Balu-Mal-STL11-Mal-3-400000-Interest-04-2025-22224d3b', '2025-08-30', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-04-2025', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-Mal-3', 8400, NULL, -13557508, 'Cash', 'adjusted in chit at finance', 'Malar_Finance', '8400'),
('Balu-Mal-STL11-Mal-3-400000-Interest-05-2025-22224d3b', '2025-08-30', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-05-2025', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-Mal-3', 8680, NULL, -13548828, 'Cash', 'adjusted in chit at finance', 'Malar_Finance', '8680'),
('Balu-Mal-STL11-Mal-3-400000-Interest-06-2025-22224d3b', '2025-08-30', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-06-2025', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-Mal-3', 8400, NULL, -13540428, 'Cash', 'adjusted in chit at finance', 'Malar_Finance', '8400'),
('Balu-Mal-STL11-Mal-3-400000-Interest-07-2025-22224d3b', '2025-08-30', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-07-2025', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-Mal-3', 8680, NULL, -13531748, 'Cash', 'adjusted in chit at finance', 'Malar_Finance', '8680'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2025-bb80d5df', '2025-08-31', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2025', 'Gokila_Akka', 'Depositer-Interest-06-2025', 0, 1800, -13533548, 'Cash', 'adjusted till june 2025', 'Malar_Finance', '1800'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2025-14036c0c', '2025-08-31', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2025', 'Malar_Appa', 'Depositer-Interest-05-2025', 0, 1000, -13534548, 'Cash', 'adjusted till june-2025', 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2025-14036c0c', '2025-08-31', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2025', 'Malar_Appa', 'Depositer-Interest-06-2025', 0, 1000, -13535548, 'Cash', 'adjusted till june-2025', 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2025-14036c0c', '2025-08-31', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2025', 'Malar_Appa', 'Depositer-Interest-04-2025', 0, 1000, -13536548, 'Cash', 'adjusted till june-2025', 'Malar_Finance', '1000');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-08-2025-ea6bfab7', '2025-09-10', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-08-2025', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-08-2025', 690, 0, -13535858, 'Cash', 'amount paid 10k on 09-9 gpay, adjusted between malar appa and malar', 'Malar_Finance', '910'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-07-2025-35506b4f', '2025-09-21', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-07-2025', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-07-2025', 1540, 0, -13534318, 'Cash', 'gpay approximately on 10tjh', 'Malar_Finance', '1540'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-08-2025-35506b4f', '2025-09-21', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-08-2025', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-08-2025', 2170, 0, -13532148, 'Cash', 'gpay approximately on 10tjh', 'Malar_Finance', '2170'),
('Balu-Mal-STL11-Mal-3-400000-Interest-08-2025-9f9d012d', '2025-09-21', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-08-2025', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-08-2025', 8680, 0, -13523468, 'Cash', 'adjusted to kannan chit', 'Malar_Finance', '8680'),
('Balu-Mal-STL11-Mal-24-50000-Interest-08-2025-9f9d012d', '2025-09-21', 'Customer_Interest', 'Balu-Mal-STL11-Mal-24-50000-Interest-08-2025', 'Mal-STL11', 'Mal-24', 'Balu', 'Interest-08-2025', 455, 0, -13523013, 'Cash', 'adjusted to kannan chit', 'Malar_Finance', '455'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-08-2025-a7b5cf9f', '2025-09-21', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-08-2025', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-08-2025', 6696, 0, -13516317, 'Cash', 'adjusted to ram chit', 'Malar_Finance', '6696'),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-08-2025-02db2525', '2025-09-21', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-350000-Interest-08-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-08-2025', 6510, 0, -13509807, 'Cash', 'adjusted to ram chit', 'Malar_Finance', '6510'),
('Priya-Mal-STL20-Mal-25-200000-Interest-08-2025-3b614e06', '2025-09-21', 'Customer_Interest', 'Priya-Mal-STL20-Mal-25-200000-Interest-08-2025', 'Mal-STL20', 'Mal-25', 'Priya', 'Interest-08-2025', 1820, 0, -13507987, 'Cash', 'adjusted to ramesh annan by ramkumar', 'Malar_Finance', '1820'),
('e808477b', '2025-09-24', 'Other_Finance_Loan_Refund', 'Mal-O-5-Kannan Finance', 'Mal-O-5-Kannan Finance', 'Mal-O-5-Kannan Finance', 'Kannan Finance', NULL, NULL, 30000, -13537987, 'Cash', NULL, 'Malar_Finance', 'Mal-O-1-AKPR finance-AKPR finance-Rs.600000,Mal-O-2-Ramkumar_Appa-Ramkumar_Appa-Rs.200000,Mal-O-3-Vadivel-Vadivel-Rs.150000,Mal-O-4-Vadivel-Vadivel-Rs.350000,Mal-O-5-Kannan Finance-Kannan Finance-Rs.50000,Mal-O-6-test-test-Rs.100'),
('fb394ee1', '2025-09-06', 'Other_Finance_Loan_Refund', 'Mal-O-1-AKPR finance', 'Mal-O-1-AKPR finance', 'Mal-O-1-AKPR finance', 'AKPR finance', NULL, NULL, 600000, -14137987, 'Cash', NULL, 'Malar_Finance', 'Mal-O-1-AKPR finance-AKPR finance-Rs.600000,Mal-O-2-Ramkumar_Appa-Ramkumar_Appa-Rs.200000,Mal-O-3-Vadivel-Vadivel-Rs.150000,Mal-O-4-Vadivel-Vadivel-Rs.350000,Mal-O-5-Kannan Finance-Kannan Finance-Rs.20000,Mal-O-6-test-test-Rs.100'),
('eb72d5b3', '2025-09-06', 'Customer_Loan_Prin_Repayment', 'Mal-STL14-Mal-6-Ramkumar-350000', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Mal-6', 100000, NULL, -14037987, 'Cash', 'given to ramesh annan finance balance 1 lakh', 'Malar_Finance', '6300'),
('caa3b88e', '2025-12-09', 'Other_Finance_Loan_Refund', 'Mal-O-5-Kannan Finance', 'Mal-O-5-Kannan Finance', 'Mal-O-5-Kannan Finance', 'Kannan Finance', 'ALREADY PAID', NULL, 20000, -14057987, 'Cash', 'PAID ON OLDER DATE', 'Malar_Finance', 'Mal-O-1-AKPR finance-AKPR finance-Rs.0,Mal-O-2-Ramkumar_Appa-Ramkumar_Appa-Rs.200000,Mal-O-3-Vadivel-Vadivel-Rs.150000,Mal-O-4-Vadivel-Vadivel-Rs.350000,Mal-O-5-Kannan Finance-Kannan Finance-Rs.20000,Mal-O-6-test-test-Rs.100'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2025-aa7d81b3', '2025-12-09', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2025', 'Malar_Appa', 'Depositer-Interest-07-2025', 0, 1000, -14058987, 'Cash', 'PAID TILL OCTOBER', 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-08-2025-aa7d81b3', '2025-12-09', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-08-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-08-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-08-2025', 'Malar_Appa', 'Depositer-Interest-08-2025', 0, 1000, -14059987, 'Cash', 'PAID TILL OCTOBER', 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-09-2025-aa7d81b3', '2025-12-09', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-09-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-09-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-09-2025', 'Malar_Appa', 'Depositer-Interest-09-2025', 0, 1000, -14060987, 'Cash', 'PAID TILL OCTOBER', 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-10-2025-aa7d81b3', '2025-12-09', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-10-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-10-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-10-2025', 'Malar_Appa', 'Depositer-Interest-10-2025', 0, 1000, -14061987, 'Cash', 'PAID TILL OCTOBER', 'Malar_Finance', '1000'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-09-2025-1b3925b7', '2026-03-05', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-09-2025', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-09-2025', 2100, 0, -14059887, 'Cash', 'received at interval', 'Malar_Finance', '2100'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-10-2025-1b3925b7', '2026-03-05', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-10-2025', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-10-2025', 2170, 0, -14057717, 'Cash', 'received at interval', 'Malar_Finance', '2170'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-12-2025-1b3925b7', '2026-03-05', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-12-2025', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-12-2025', 2170, 0, -14055547, 'Cash', 'received at interval', 'Malar_Finance', '2170'),
('Chandrasekar-Mal-STL12-Mal-2-100000-Interest-02-2026-1b3925b7', '2026-03-05', 'Customer_Interest', 'Chandrasekar-Mal-STL12-Mal-2-100000-Interest-02-2026', 'Mal-STL12', 'Mal-2', 'Chandrasekar', 'Interest-02-2026', 1420, 0, -14054127, 'Cash', 'received at interval', 'Malar_Finance', '1960'),
('Balu-Mal-STL11-Mal-3-400000-Interest-09-2025-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-09-2025', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-09-2025', 8400, 0, -14045727, 'Cash', 'old interest given to kannan', 'Malar_Finance', '8400'),
('Balu-Mal-STL11-Mal-24-50000-Interest-09-2025-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-24-50000-Interest-09-2025', 'Mal-STL11', 'Mal-24', 'Balu', 'Interest-09-2025', 1050, 0, -14044677, 'Cash', 'old interest given to kannan', 'Malar_Finance', '1050'),
('Balu-Mal-STL11-Mal-3-400000-Interest-10-2025-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-10-2025', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-10-2025', 8680, 0, -14035997, 'Cash', 'old interest given to kannan', 'Malar_Finance', '8680'),
('Balu-Mal-STL11-Mal-24-50000-Interest-10-2025-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-24-50000-Interest-10-2025', 'Mal-STL11', 'Mal-24', 'Balu', 'Interest-10-2025', 1085, 0, -14034912, 'Cash', 'old interest given to kannan', 'Malar_Finance', '1085'),
('Balu-Mal-STL11-Mal-3-400000-Interest-11-2025-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-11-2025', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-11-2025', 8400, 0, -14026512, 'Cash', 'old interest given to kannan', 'Malar_Finance', '8400'),
('Balu-Mal-STL11-Mal-24-50000-Interest-11-2025-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-24-50000-Interest-11-2025', 'Mal-STL11', 'Mal-24', 'Balu', 'Interest-11-2025', 1050, 0, -14025462, 'Cash', 'old interest given to kannan', 'Malar_Finance', '1050'),
('Balu-Mal-STL11-Mal-3-400000-Interest-12-2025-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-12-2025', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-12-2025', 8680, 0, -14016782, 'Cash', 'old interest given to kannan', 'Malar_Finance', '8680'),
('Balu-Mal-STL11-Mal-24-50000-Interest-12-2025-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-24-50000-Interest-12-2025', 'Mal-STL11', 'Mal-24', 'Balu', 'Interest-12-2025', 1085, 0, -14015697, 'Cash', 'old interest given to kannan', 'Malar_Finance', '1085'),
('Balu-Mal-STL11-Mal-3-400000-Interest-01-2026-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-3-400000-Interest-01-2026', 'Mal-STL11', 'Mal-3', 'Balu', 'Interest-01-2026', 8680, 0, -14007017, 'Cash', 'old interest given to kannan', 'Malar_Finance', '8680'),
('Balu-Mal-STL11-Mal-24-50000-Interest-01-2026-09399ac2', '2026-03-05', 'Customer_Interest', 'Balu-Mal-STL11-Mal-24-50000-Interest-01-2026', 'Mal-STL11', 'Mal-24', 'Balu', 'Interest-01-2026', 1085, 0, -14005932, 'Cash', 'old interest given to kannan', 'Malar_Finance', '1085'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-09-2025-6fbec2fb', '2026-03-05', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-09-2025', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-09-2025', 6480, 0, -13999452, 'Cash', 'to ramkumar chit', 'Malar_Finance', '6480'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-10-2025-6fbec2fb', '2026-03-05', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-10-2025', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-10-2025', 6696, 0, -13992756, 'Cash', 'to ramkumar chit', 'Malar_Finance', '6696'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-11-2025-6fbec2fb', '2026-03-05', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-11-2025', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-11-2025', 6480, 0, -13986276, 'Cash', 'to ramkumar chit', 'Malar_Finance', '6480'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-12-2025-6fbec2fb', '2026-03-05', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-12-2025', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-12-2025', 6696, 0, -13979580, 'Cash', 'to ramkumar chit', 'Malar_Finance', '6696'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-01-2026-6fbec2fb', '2026-03-05', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-01-2026', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-01-2026', 6696, 0, -13972884, 'Cash', 'to ramkumar chit', 'Malar_Finance', '6696'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-08-2025-895bd4fb', '2026-03-05', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-08-2025', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-08-2025', 220, 0, -13972664, 'Cash', NULL, 'Malar_Finance', '220'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-09-2025-895bd4fb', '2026-03-05', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-09-2025', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-09-2025', 2100, 0, -13970564, 'Cash', NULL, 'Malar_Finance', '2100'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-10-2025-895bd4fb', '2026-03-05', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-10-2025', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-10-2025', 2170, 0, -13968394, 'Cash', NULL, 'Malar_Finance', '2170'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-11-2025-895bd4fb', '2026-03-05', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-11-2025', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-11-2025', 2100, 0, -13966294, 'Cash', NULL, 'Malar_Finance', '2100'),
('b794babf', '2026-03-05', 'Customer_Loan_Prin_Repayment', 'Mal-STL20-Mal-25-Priya-200000', 'Mal-STL20', 'Mal-25', 'Priya', 'Mal-25', 200000, NULL, -13766294, 'Cash', 'paid to ramkumar', 'Malar_Finance', '4200,4340,4200,4340,4340,3920'),
('Priya-Mal-STL20-Mal-25-200000-Interest-09-2025-d37327e4', '2026-03-05', 'Customer_Interest', 'Priya-Mal-STL20-Mal-25-200000-Interest-09-2025', 'Mal-STL20', 'Mal-25', 'Priya', 'Interest-09-2025', 4200, 0, -13762094, 'Cash', NULL, 'Malar_Finance', '4200'),
('Priya-Mal-STL20-Mal-25-200000-Interest-10-2025-d37327e4', '2026-03-05', 'Customer_Interest', 'Priya-Mal-STL20-Mal-25-200000-Interest-10-2025', 'Mal-STL20', 'Mal-25', 'Priya', 'Interest-10-2025', 4340, 0, -13757754, 'Cash', NULL, 'Malar_Finance', '4340'),
('Priya-Mal-STL20-Mal-25-200000-Interest-11-2025-d37327e4', '2026-03-05', 'Customer_Interest', 'Priya-Mal-STL20-Mal-25-200000-Interest-11-2025', 'Mal-STL20', 'Mal-25', 'Priya', 'Interest-11-2025', 4200, 0, -13753554, 'Cash', NULL, 'Malar_Finance', '4200'),
('Priya-Mal-STL20-Mal-25-200000-Interest-12-2025-d37327e4', '2026-03-05', 'Customer_Interest', 'Priya-Mal-STL20-Mal-25-200000-Interest-12-2025', 'Mal-STL20', 'Mal-25', 'Priya', 'Interest-12-2025', 4340, 0, -13749214, 'Cash', NULL, 'Malar_Finance', '4340'),
('Priya-Mal-STL20-Mal-25-200000-Interest-01-2026-d37327e4', '2026-03-05', 'Customer_Interest', 'Priya-Mal-STL20-Mal-25-200000-Interest-01-2026', 'Mal-STL20', 'Mal-25', 'Priya', 'Interest-01-2026', 4340, 0, -13744874, 'Cash', NULL, 'Malar_Finance', '4340'),
('Priya-Mal-STL20-Mal-25-200000-Interest-02-2026-d37327e4', '2026-03-05', 'Customer_Interest', 'Priya-Mal-STL20-Mal-25-200000-Interest-02-2026', 'Mal-STL20', 'Mal-25', 'Priya', 'Interest-02-2026', 3920, 0, -13740954, 'Cash', NULL, 'Malar_Finance', '3920'),
('Ramkumar-Mal-STL14-Mal-6-350000-Interest-09-2025-fe938740', '2026-03-05', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-350000-Interest-09-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-09-2025', 6300, 0, -13734654, 'Other', NULL, 'Malar_Finance', '6300'),
('Ramkumar-Mal-STL14-Mal-6-100000-Interest-09-2025-fe938740', '2026-03-05', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-100000-Interest-09-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-09-2025', 360, 0, -13734294, 'Other', NULL, 'Malar_Finance', '360'),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-10-2025-fe938740', '2026-03-05', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-250000-Interest-10-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-10-2025', 4650, 0, -13729644, 'Other', NULL, 'Malar_Finance', '4650'),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-11-2025-fe938740', '2026-03-05', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-250000-Interest-11-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-11-2025', 4500, 0, -13725144, 'Other', NULL, 'Malar_Finance', '4500'),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-12-2025-fe938740', '2026-03-05', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-250000-Interest-12-2025', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-12-2025', 4650, 0, -13720494, 'Other', NULL, 'Malar_Finance', '4650'),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-01-2026-fe938740', '2026-03-05', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-250000-Interest-01-2026', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-01-2026', 4650, 0, -13715844, 'Other', NULL, 'Malar_Finance', '4650'),
('2724a592', '2026-03-05', 'Deposit_From_Customer', 'Deposit-Mal-D-5-malar_appa1-malar_appa1', NULL, 'Mal-D-5-malar_appa1', 'malar_appa1', 'Deposit From Customer-malar_appa1', 100000, NULL, -13615844, 'Cash', NULL, 'Malar_Finance', NULL),
('Priya-Mal-STL20-Mal-25-200000-Interest-03-2026-6c2c11c9', '2026-03-05', 'Customer_Interest', 'Priya-Mal-STL20-Mal-25-200000-Interest-03-2026', 'Mal-STL20', 'Mal-25', 'Priya', 'Interest-03-2026', 700, 0, -13615144, 'Cash', 'loan closed', 'Malar_Finance', '700'),
('c1a621ca', '2026-03-05', 'Deposit_From_Customer', 'Deposit-Mal-D-5-malar_appa1-malar_appa1', NULL, 'Mal-D-5-malar_appa1', 'malar_appa1', 'Deposit From Customer-malar_appa1', 100000, NULL, -13515144, 'Cash', NULL, 'Malar_Finance', NULL),
('73dd7584', '2026-03-05', 'Deposit_From_Customer', 'Deposit-Mal-D-5-malar_appa1-malar_appa1', NULL, 'Mal-D-5-malar_appa1', 'malar_appa1', 'Deposit From Customer-malar_appa1', 100000, NULL, -13415144, 'Cash', NULL, 'Malar_Finance', NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-07-2025-45fc024b', '2026-03-05', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-07-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-07-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-07-2025', 'Gokila_Akka', 'Depositer-Interest-07-2025', 0, 2000, -13417144, 'Cash', 'through gpay', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-08-2025-45fc024b', '2026-03-05', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-08-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-08-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-08-2025', 'Gokila_Akka', 'Depositer-Interest-08-2025', 0, 2000, -13419144, 'Cash', 'through gpay', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-09-2025-45fc024b', '2026-03-05', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-09-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-09-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-09-2025', 'Gokila_Akka', 'Depositer-Interest-09-2025', 0, 2000, -13421144, 'Cash', 'through gpay', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-10-2025-45fc024b', '2026-03-05', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-10-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-10-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-10-2025', 'Gokila_Akka', 'Depositer-Interest-10-2025', 0, 2000, -13423144, 'Cash', 'through gpay', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-11-2025-45fc024b', '2026-03-05', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-11-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-11-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-11-2025', 'Gokila_Akka', 'Depositer-Interest-11-2025', 0, 2000, -13425144, 'Cash', 'through gpay', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-12-2025-45fc024b', '2026-03-05', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-12-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-12-2025', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-12-2025', 'Gokila_Akka', 'Depositer-Interest-12-2025', 0, 2000, -13427144, 'Cash', 'through gpay', 'Malar_Finance', '2000'),
('1d16b91e', '2026-03-13', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL12-Chandrasekar', 'Mal-STL12', 'Mal-2', 'Chandrasekar', NULL, NULL, 100000, -13527144, 'Cash', NULL, 'Malar_Finance', NULL),
('b749e196', '2026-03-10', 'Chit_Receipt', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M6_Amuthavel', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_1', 6120, NULL, 6120, 'UPI', NULL, 'Chit_Malar', '25000'),
('46ff395c', '2026-03-10', 'Chit_Receipt', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M6_Amuthavel', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_1', 18880, NULL, 25000, 'Other', 'adjusted in manager emi two months, my emi one month', 'Chit_Malar', '18880'),
('d9ceb337', '2026-03-12', 'Chit_Receipt', 'Chit_A1_M11_Kannan_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M11_Kannan', 'Chit_A1_M11_Kannan_Chit_A1_Auction_1', 12500, NULL, 37500, 'Other', 'adjusted to ramkumar chit amount', 'Chit_Malar', '12500'),
('f4229244', '2026-03-12', 'Chit_Receipt', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M20_Rajesh', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_1', 25000, NULL, 62500, 'UPI', NULL, 'Chit_Malar', '25000'),
('e47cab7b', '2026-03-10', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_1', 15000, NULL, 77500, 'UPI', 'through gpay', 'Chit_Malar', '25000'),
('0284e8eb', '2026-03-10', 'Chit_Receipt', 'Chit_A1_M8_Tharun_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M8_Tharun', 'Chit_A1_M8_Tharun_Chit_A1_Auction_1', 25000, NULL, 102500, 'Cash', NULL, 'Chit_Malar', '25000'),
('3a9ad28f', '2026-03-13', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_1', 10000, NULL, 112500, 'Cash', NULL, 'Chit_Malar', '10000'),
('e9cf5286', '2026-03-10', 'Chit_Receipt', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M2_Malarvizhi', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_1', 12500, NULL, 125000, 'UPI', 'through gpay', 'Chit_Malar', '12500'),
('7ccd46f0', '2026-03-12', 'Chit_Receipt', 'Chit_A1_M23_Mohan_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M23_Mohan', 'Chit_A1_M23_Mohan_Chit_A1_Auction_1', 12500, NULL, 137500, 'UPI', 'through malar gpay', 'Chit_Malar', '12500'),
('9fe4afbd', '2026-03-14', 'Chit_Receipt', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_1', 25000, NULL, 162500, 'UPI', '25000 chit+4900 3rd emi due-11000 already given me. Remaining  18900 paid', 'Chit_Malar', '25000'),
('a159e70a', '2026-03-14', 'Chit_Receipt', 'Chit_A1_M10_Gopal_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M10_Gopal', 'Chit_A1_M10_Gopal_Chit_A1_Auction_1', 12500, NULL, 175000, 'UPI', 'Ippb', 'Chit_Malar', '12500'),
('bdd3b9dd', '2026-03-14', 'Chit_Receipt', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M3_Muthusamy', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_1', 25000, NULL, 200000, 'Cash', NULL, 'Chit_Malar', '25000'),
('66ada67d', '2026-03-14', 'Chit_Receipt', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M12_Dinesh_Thangavel', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_1', 25000, NULL, 225000, 'UPI', 'Saranya', 'Chit_Malar', '25000'),
('9412c077', '2026-03-16', 'Chit_Receipt', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M13_Arasakumar', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_1', 25000, NULL, 250000, 'Cash', NULL, 'Chit_Malar', '25000'),
('b868e568', '2026-03-16', 'Chit_Receipt', 'Chit_A1_M14_Baskar_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M14_Baskar', 'Chit_A1_M14_Baskar_Chit_A1_Auction_1', 25000, NULL, 275000, 'Cash', NULL, 'Chit_Malar', '25000'),
('8521cc73', '2026-03-16', 'Chit_Receipt', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M15_Gopalsamy', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_1', 25000, NULL, 300000, 'Cash', NULL, 'Chit_Malar', '25000'),
('f900ffe1', '2026-03-17', 'Chit_Receipt', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M4_Surrendar', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_1', 25000, NULL, 325000, 'Account', 'Icici', 'Chit_Malar', '25000'),
('1739b20b', '2026-03-17', 'Chit_Receipt', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M5_Kavi_Surrendar', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_1', 25000, NULL, 350000, 'Account', 'Icici', 'Chit_Malar', '25000'),
('a73cfbb4', '2026-03-17', 'Chit_Receipt', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M9_Dinesh_Muthusamy', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_1', 25000, NULL, 375000, 'UPI', NULL, 'Chit_Malar', '25000'),
('e20a6f4f', '2026-03-17', 'Chit_Receipt', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M24_Valarmathi', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_1', 25000, NULL, 400000, 'Other', 'Through Chandru annan', 'Chit_Malar', '25000'),
('4a9b3b87', '2026-03-18', 'Chit_Receipt', 'Chit_A1_M18_Deepak_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M18_Deepak', 'Chit_A1_M18_Deepak_Chit_A1_Auction_1', 10000, NULL, 410000, 'Cash', NULL, 'Chit_Malar', '25000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-11-2025-88e67ef6', '2026-03-18', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-11-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-11-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-11-2025', 'Malar_Appa', 'Depositer-Interest-11-2025', 0, 1000, -13528144, 'Other', 'Adjusted for car insurance', 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-12-2025-88e67ef6', '2026-03-18', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-12-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-12-2025', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-12-2025', 'Malar_Appa', 'Depositer-Interest-12-2025', 0, 1000, -13529144, 'Other', 'Adjusted for car insurance', 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-01-2026-88e67ef6', '2026-03-18', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-01-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-01-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-01-2026', 'Malar_Appa', 'Depositer-Interest-01-2026', 0, 1000, -13530144, 'Other', 'Adjusted for car insurance', 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-02-2026-88e67ef6', '2026-03-18', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-02-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-02-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-02-2026', 'Malar_Appa', 'Depositer-Interest-02-2026', 0, 1000, -13531144, 'Other', 'Adjusted for car insurance', 'Malar_Finance', '1000'),
('89433d34', '2026-03-18', 'Chit_Receipt', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M25_Kaviyarasu', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_1', 25000, NULL, 435000, 'UPI', NULL, 'Chit_Malar', '25000'),
('59bd8fa0', '2026-03-25', 'Old Pending Interest', 'Mal-STL11-1500-Old Pending Interest', NULL, NULL, 'Balu', 'Old Pending Interest', 700, NULL, -13530444, 'Cash', NULL, 'Malar_Finance', '1500'),
('bef90ac9', '2026-03-25', 'Other_Payment', 'society loan to rajesh sir', NULL, NULL, 'society loan to rajesh sir', 'society loan to rajesh sir', NULL, 140000, 295000, 'Cash', NULL, 'Chit_Malar', NULL),
('503f1cff', '2026-03-25', 'Other_Payment', 'given to Arun prakash ippb', NULL, NULL, 'given to Arun prakash ippb', 'given to Arun prakash ippb', NULL, 100000, 195000, 'Cash', NULL, 'Chit_Malar', NULL),
('ff8f751e', '2026-03-25', 'Other_Payment', 'other payment', NULL, NULL, 'other payment', 'other payment', NULL, 46000, 149000, 'Cash', NULL, 'Chit_Malar', NULL),
('21420928', '2026-03-27', 'Chit_Receipt', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M7_Palanisamy', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_1', 18000, NULL, 167000, 'UPI', NULL, 'Chit_Malar', '25000'),
('4f9776da', '2026-03-27', 'Chit_Receipt', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M21_Finance_Chit', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_1', 25000, NULL, 192000, 'Other', NULL, 'Chit_Malar', '25000'),
('ae3c43a5', '2026-03-27', 'Chit_Receipt', 'Chit_A1_M1_Arul_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M1_Arul', 'Chit_A1_M1_Arul_Chit_A1_Auction_1', 12500, NULL, 204500, 'Cash', NULL, 'Chit_Malar', '12500'),
('26cc6682', '2026-03-30', 'Chit_Receipt', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M7_Palanisamy', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_1', 7000, NULL, 211500, 'UPI', NULL, 'Chit_Malar', '7000'),
('4891f861', '2026-04-03', 'Chit_Receipt', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M16_Sathyadevi', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_1', 25000, NULL, 236500, 'Cash', NULL, 'Chit_Malar', '25000'),
('3412db4d', '2026-04-03', 'Chit_Receipt', 'Chit_A1_M18_Deepak_Chit_A1_Auction_1', NULL, NULL, 'Chit_A1_M18_Deepak', 'Chit_A1_M18_Deepak_Chit_A1_Auction_1', 15000, NULL, 251500, 'Cash', NULL, 'Chit_Malar', '15000'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-12-2025-b81a21bc', '2026-04-08', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-12-2025', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-12-2025', 2170, 0, -13528274, 'UPI', 'Bal 175', 'Malar_Finance', '2170');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-02-2026-b81a21bc', '2026-04-08', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-02-2026', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-02-2026', 1960, 0, -13526314, 'UPI', 'Bal 175', 'Malar_Finance', '1960'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-01-2026-b81a21bc', '2026-04-08', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-01-2026', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-01-2026', 2170, 0, -13524144, 'UPI', 'Bal 175', 'Malar_Finance', '2170'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-03-2026-b81a21bc', '2026-04-08', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-03-2026', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-03-2026', 1995, 0, -13522149, 'UPI', 'Bal 175', 'Malar_Finance', '2170'),
('0f165653', '2026-04-08', 'Deposit_From_Customer', 'Deposit-Mal-D-6-Gokila_Akka-Gokila_Akka', NULL, 'Mal-D-6-Gokila_Akka', 'Gokila_Akka', 'Deposit From Customer-Gokila_Akka', 100000, NULL, -13422149, 'Cash', NULL, 'Malar_Finance', NULL),
('c2664ffe', '2026-04-11', 'Chit_Receipt', 'Chit_A1_M23_Mohan_Chit_A1_Auction_2', NULL, NULL, 'Chit_A1_M23_Mohan', 'Chit_A1_M23_Mohan_Chit_A1_Auction_2', 9925, NULL, 261425, NULL, NULL, 'Chit_Malar', '9925'),
('70741162', '2026-04-11', 'Chit_Receipt', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_2', NULL, NULL, 'Chit_A1_M16_Sathyadevi', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_2', 19850, NULL, 281275, 'UPI', NULL, 'Chit_Malar', '19850'),
('45383bea', '2026-04-11', 'Chit_Receipt', 'Chit_A1_M10_Gopal_Chit_A1_Auction_2', NULL, NULL, 'Chit_A1_M10_Gopal', 'Chit_A1_M10_Gopal_Chit_A1_Auction_2', 9925, NULL, 291200, 'UPI', NULL, 'Chit_Malar', '9925'),
('66b7afe6', '2026-04-11', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', 'By kavi gpay to Pavithra', NULL, 19850, 271350, NULL, NULL, 'Chit_Malar', NULL),
('7cf0d3a5', '2026-04-11', 'Chit_Receipt', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_2', NULL, NULL, 'Chit_A1_M4_Surrendar', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_2', 19850, NULL, 291200, NULL, NULL, 'Chit_Malar', '19850'),
('2bad9755', '2026-04-11', 'Chit_Receipt', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_2', NULL, NULL, 'Chit_A1_M5_Kavi_Surrendar', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_2', 19850, NULL, 311050, 'UPI', NULL, 'Chit_Malar', '19850'),
('356b9ddc', '2026-04-11', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', NULL, NULL, 39700, 271350, 'UPI', 'Surrender to palpandi', 'Chit_Malar', NULL),
('2076eb42', '2026-04-11', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', NULL, NULL, 55000, 216350, 'UPI', 'Arul to palpandi', 'Chit_Malar', NULL),
('b3e3a29f', '2026-04-12', 'Chit_Receipt', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_2', NULL, 'Finance', 'Chit_A1_M21_Finance_Chit', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_2', 15000, NULL, 231350, 'Other', NULL, 'Chit_Malar', '19850'),
('00fd0d28', '2026-04-14', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_2', NULL, 'Ul', 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_2', 12850, NULL, 244200, 'UPI', NULL, 'Chit_Malar', '19850'),
('e32b60e3', '2026-04-14', 'Chit_Receipt', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_2', NULL, 'Ghh', 'Chit_A1_M25_Kaviyarasu', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_2', 19850, NULL, 264050, 'UPI', 'Gpay to arun prakash', 'Chit_Malar', '19850'),
('c230f902', '2026-04-14', 'Chit_Receipt', 'Chit_A1_M8_Tharun_Chit_A1_Auction_2', NULL, 'Ghh', 'Chit_A1_M8_Tharun', 'Chit_A1_M8_Tharun_Chit_A1_Auction_2', 19850, NULL, 283900, 'Cash', 'By hand', 'Chit_Malar', '19850'),
('9e6fdb1b', '2026-04-14', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', NULL, NULL, 20000, 263900, 'Cash', 'By deepak', 'Chit_Malar', NULL),
('66da13ad', '2026-04-15', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', NULL, NULL, 26000, 237900, 'UPI', 'By kannan to Pavithra', 'Chit_Malar', NULL),
('a2a22c28', '2026-04-15', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', NULL, NULL, 40000, 197900, 'UPI', 'Kannan to pavithra', 'Chit_Malar', NULL),
('2a978d5f', '2026-04-15', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', NULL, NULL, 10000, 187900, 'UPI', 'Kannan to pavithra', 'Chit_Malar', NULL),
('38cca89c', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_2', NULL, 'dfds', 'Chit_A1_M20_Rajesh', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_2', 17350, NULL, 205250, 'Other', 'by cash to deepak 2500 yet to  give deepak gave', 'Chit_Malar', '19850'),
('ccdd7a1e', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M18_Deepak_Chit_A1_Auction_2', NULL, 'dd', 'Chit_A1_M18_Deepak', 'Chit_A1_M18_Deepak_Chit_A1_Auction_2', 19850, NULL, 225100, NULL, NULL, 'Chit_Malar', '19850'),
('d5c8426c', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_2', NULL, 'dd', 'Chit_A1_M17_Arun Prakash', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_2', 19850, NULL, 244950, 'Other', 'adjusted in chit amount', 'Chit_Malar', '19850'),
('9f1905c8', '2026-04-15', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', NULL, NULL, 19850, 225100, 'Other', 'adjusted for his chit', 'Chit_Malar', NULL),
('0f753d21', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_2', NULL, 'dd', 'Chit_A1_M13_Arasakumar', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_2', 19850, NULL, 244950, 'Cash', NULL, 'Chit_Malar', '19850'),
('2f0a492c', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M14_Baskar_Chit_A1_Auction_2', NULL, 'dd', 'Chit_A1_M14_Baskar', 'Chit_A1_M14_Baskar_Chit_A1_Auction_2', 19850, NULL, 264800, 'Cash', NULL, 'Chit_Malar', '19850'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_1-01f4e54e', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M22_Vikas_Chit_A1_Auction_1', 'Chit_A1_M22_Vikas_Chit_A1_Auction_1', 'Chit_A1_M22_Vikas_Chit_A1_Auction_1', 'Chit_A1_M22_Vikas', 'Chit_A1_M22_Vikas_Chit_A1_Auction_1', 25000, 0, 289800, 'Other', 'adjusted in chandrasekaran amount 30000', 'Chit_Malar', '25000'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_2-01f4e54e', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M22_Vikas_Chit_A1_Auction_2', 'Chit_A1_M22_Vikas_Chit_A1_Auction_2', 'Chit_A1_M22_Vikas_Chit_A1_Auction_2', 'Chit_A1_M22_Vikas', 'Chit_A1_M22_Vikas_Chit_A1_Auction_2', 5000, 0, 294800, 'Other', 'adjusted in chandrasekaran amount 30000', 'Chit_Malar', '19850'),
('Chit_A1_M11_Kannan_Chit_A1_Auction_2-557b038c', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M11_Kannan_Chit_A1_Auction_2', 'Chit_A1_M11_Kannan_Chit_A1_Auction_2', 'Chit_A1_M11_Kannan_Chit_A1_Auction_2', 'Chit_A1_M11_Kannan', 'Chit_A1_M11_Kannan_Chit_A1_Auction_2', 9925, 0, 304725, 'Other', 'cash send to arun prakash 10k parvathi', 'Chit_Malar', '9925'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_2-8aac5dfb', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_2', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_2', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_2', 'Chit_A1_M6_Amuthavel', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_2', 17586, 0, 322311, 'Other', 'ac 32886, due 4700, i have 20k, remaining balance', 'Chit_Malar', '19850'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_2-ff86b2cf', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_2', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_2', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_2', 'Chit_A1_M3_Muthusamy', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_2', 18550, 0, 340861, 'Other', 'UMA 6500, GPAY 5300, INT 6750', 'Chit_Malar', '19850'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_2-d9b39695', '2026-04-15', 'Chit_Receipt', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_2', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_2', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_2', 'Chit_A1_M24_Valarmathi', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_2', 19850, 0, 360711, 'UPI', NULL, 'Chit_Malar', '19850'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_2-8a80aad8', '2026-04-16', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_2', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_2', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_2', 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_2', 7000, 0, 367711, 'UPI', NULL, 'Chit_Malar', '7000'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_2-3a98e0c3', '2026-04-16', 'Chit_Receipt', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_2', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_2', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_2', 'Chit_A1_M6_Amuthavel', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_2', 2264, 0, 369975, 'Other', NULL, 'Chit_Malar', '2264'),
('665fc40a', '2026-04-16', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', NULL, NULL, 40000, 329975, 'UPI', 'To palpandi', 'Chit_Malar', NULL),
('532e3db2', '2026-04-16', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', NULL, NULL, 25000, 304975, 'UPI', 'To palpandi', 'Chit_Malar', NULL),
('Chit_A1_M1_Arul_Chit_A1_Auction_2-66360d08', '2026-04-16', 'Chit_Receipt', 'Chit_A1_M1_Arul_Chit_A1_Auction_2', 'Chit_A1_M1_Arul_Chit_A1_Auction_2', 'Chit_A1_M1_Arul_Chit_A1_Auction_2', 'Chit_A1_M1_Arul', 'Chit_A1_M1_Arul_Chit_A1_Auction_2', 9925, 0, 314900, NULL, NULL, 'Chit_Malar', '9925'),
('Chit_A1_M21_Finance_Chit_Chit_A1_Auction_2-36c43d18', '2026-04-16', 'Chit_Receipt', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_2', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_2', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_2', 'Chit_A1_M21_Finance_Chit', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_2', 4850, 0, 319750, 'UPI', NULL, 'Chit_Malar', '4850'),
('ca42ee9f', '2026-04-16', 'Deposit_From_Customer', 'Deposit-Chi-D-7-Deepak-Deepak', NULL, 'Chi-D-7-Deepak', 'Deepak', 'Deposit From Customer-Deepak', 60000, NULL, 379750, 'Cash', NULL, 'Chit_Malar', NULL),
('14613a5b', '2026-04-16', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL1-Pradeep', 'Chi-STL1', 'Chi-28', 'Pradeep', NULL, NULL, 60000, 319750, 'Cash', 'Given to kannan to close pradeep loan', 'Chit_Malar', NULL),
('a4af89f5', '2026-04-16', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', 'Adjusted to 1l loan 50k rem,4900 emi', NULL, 54900, 264850, 'Other', NULL, 'Chit_Malar', NULL),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_2-d121d7ab', '2026-04-17', 'Chit_Receipt', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_2', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_2', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_2', 'Chit_A1_M9_Dinesh_Muthusamy', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_2', 19850, 0, 284700, 'UPI', NULL, 'Chit_Malar', '19850'),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_2-47a2c8a4', '2026-04-18', 'Chit_Receipt', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_2', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_2', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_2', 'Chit_A1_M12_Dinesh_Thangavel', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_2', 19850, 0, 304550, NULL, NULL, 'Chit_Malar', '19850'),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_2-af30ce5e', '2026-04-18', 'Chit_Receipt', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_2', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_2', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_2', 'Chit_A1_M7_Palanisamy', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_2', 19850, 0, 324400, NULL, NULL, 'Chit_Malar', '19850'),
('baf37a14', '2026-04-20', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL1-Pradeep', 'Chi-STL1', 'Chi-29', 'Pradeep', NULL, NULL, 40000, 284400, 'UPI', 'Adjusted 30k in sundaravadivel loan and 10k to kozhi', 'Chit_Malar', NULL),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_2-c17fadce', '2026-04-20', 'Chit_Receipt', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_2', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_2', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_2', 'Chit_A1_M20_Rajesh', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_2', 2500, 0, 286900, 'Account', 'Post office acc', 'Chit_Malar', '2500'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_2-ffd28154', '2026-04-20', 'Chit_Receipt', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_2', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_2', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_2', 'Chit_A1_M15_Gopalsamy', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_2', 19850, 0, 306750, 'Cash', NULL, 'Chit_Malar', '19850'),
('49c4a2e7', '2026-04-21', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL1-Pradeep', 'Chi-STL1', 'Chi-30', 'Pradeep', NULL, NULL, 50000, 256750, 'Other', 'Adjusted to kannan 20k, 30k gpay', 'Chit_Malar', NULL),
('383b02da', '2026-04-13', 'Other_Finance_Loan_Refund', 'Mal-O-7-Kannan Finance', 'Mal-O-7-Kannan Finance', 'Mal-O-7-Kannan Finance', 'Kannan Finance', NULL, NULL, 10000, -13432149, NULL, NULL, 'Malar_Finance', 'Mal-O-1-AKPR finance-AKPR finance-Rs.0,Mal-O-2-Ramkumar_Appa-Ramkumar_Appa-Rs.200000,Mal-O-3-Vadivel-Vadivel-Rs.150000,Mal-O-4-Vadivel-Vadivel-Rs.350000,Mal-O-5-Kannan Finance-Kannan Finance-Rs.0,Mal-O-6-test-test-Rs.100,Mal-O-7-Kannan Finance-Kannan Finance-Rs.10000,Mal-O-8-AKPR finance-AKPR finance-Rs.25000'),
('5fb15a8c', '2026-04-27', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', 'to pavithra murugan', NULL, 30000, 226750, 'UPI', NULL, 'Chit_Malar', NULL),
('2ac63167', '2026-04-27', 'Chit_Payment', 'Chit_A1_Auction_2_M1', NULL, NULL, 'Chit_A1_M17_Arun Prakash', 'liquor adjustment', NULL, 1700, 225050, 'Other', NULL, 'Chit_Malar', NULL),
('Chit_A1_M23_Mohan_Chit_A1_Auction_3-16cb2fda', '2026-05-10', 'Chit_Receipt', 'Chit_A1_M23_Mohan_Chit_A1_Auction_3', 'Chit_A1_M23_Mohan_Chit_A1_Auction_3', 'Chit_A1_M23_Mohan_Chit_A1_Auction_3', 'Chit_A1_M23_Mohan', 'Chit_A1_M23_Mohan_Chit_A1_Auction_3', 9995, 0, 235045, 'UPI', NULL, 'Chit_Malar', '9995'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_3-c25fde2f', '2026-05-10', 'Chit_Receipt', 'Chit_A1_M10_Gopal_Chit_A1_Auction_3', 'Chit_A1_M10_Gopal_Chit_A1_Auction_3', 'Chit_A1_M10_Gopal_Chit_A1_Auction_3', 'Chit_A1_M10_Gopal', 'Chit_A1_M10_Gopal_Chit_A1_Auction_3', 9995, 0, 245040, 'UPI', NULL, 'Chit_Malar', '9995'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_2-32fdc334', '2026-05-11', 'Chit_Receipt', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_2', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_2', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_2', 'Chit_A1_M3_Muthusamy', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_2', 1300, 0, 246340, 'Cash', 'elango 22500, old chit bal 1300, new chit 19990, ram int 6750, rem 9260', 'Chit_Malar', '1300'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_3-32fdc334', '2026-05-11', 'Chit_Receipt', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_3', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_3', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_3', 'Chit_A1_M3_Muthusamy', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_3', 19990, 0, 266330, 'Cash', 'elango 22500, old chit bal 1300, new chit 19990, ram int 6750, rem 9260', 'Chit_Malar', '19990'),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_3-c6d98e7a', '2026-05-11', 'Chit_Receipt', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_3', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_3', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_3', 'Chit_A1_M20_Rajesh', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_3', 19990, 0, 286320, 'UPI', NULL, 'Chit_Malar', '19990'),
('Chit_A1_M4_Surrendar_Chit_A1_Auction_3-1ce8b182', '2026-05-12', 'Chit_Receipt', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_3', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_3', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_3', 'Chit_A1_M4_Surrendar', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_3', 19990, 0, 306310, 'UPI', NULL, 'Chit_Malar', '19990'),
('Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_3-4f667aaf', '2026-05-12', 'Chit_Receipt', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_3', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_3', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_3', 'Chit_A1_M5_Kavi_Surrendar', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_3', 19990, 0, 326300, NULL, NULL, 'Chit_Malar', '19990'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_3-49cbbed1', '2026-05-12', 'Chit_Receipt', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_3', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_3', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_3', 'Chit_A1_M6_Amuthavel', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_3', 19990, 0, 346290, 'UPI', 'Upi 12588, credit card 4658, old bal 2755', 'Chit_Malar', '19990'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_3-7f6522c4', '2026-05-12', 'Chit_Receipt', 'Chit_A1_M18_Deepak_Chit_A1_Auction_3', 'Chit_A1_M18_Deepak_Chit_A1_Auction_3', 'Chit_A1_M18_Deepak_Chit_A1_Auction_3', 'Chit_A1_M18_Deepak', 'Chit_A1_M18_Deepak_Chit_A1_Auction_3', 19990, 0, 366280, 'UPI', NULL, 'Chit_Malar', '19990'),
('bdd1bd73', '2026-05-13', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL2-Priya', 'Chi-STL2', 'Chi-31', 'Priya', NULL, NULL, 80000, 286280, 'UPI', '60k by cash murali to kannan, 20k by gpay to ramya thangavel', 'Chit_Malar', NULL),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_3-11a2973e', '2026-05-13', 'Chit_Receipt', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_3', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_3', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_3', 'Chit_A1_M25_Kaviyarasu', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_3', 19990, 0, 306270, 'UPI', NULL, 'Chit_Malar', '19990'),
('7ce6cc33', '2026-04-30', 'Other_Finance_Loan_Refund', 'Mal-O-8-AKPR finance', 'Mal-O-8-AKPR finance', 'Mal-O-8-AKPR finance', 'AKPR finance', NULL, NULL, 25000, -13457149, 'Cash', 'through ramkumar, date unkonwn', 'Malar_Finance', 'Mal-O-1-AKPR finance-AKPR finance-Rs.0,Mal-O-2-Ramkumar_Appa-Ramkumar_Appa-Rs.200000,Mal-O-3-Vadivel-Vadivel-Rs.150000,Mal-O-4-Vadivel-Vadivel-Rs.350000,Mal-O-5-Kannan Finance-Kannan Finance-Rs.0,Mal-O-6-test-test-Rs.100,Mal-O-7-Kannan Finance-Kannan Finance-Rs.0,Mal-O-8-AKPR finance-AKPR finance-Rs.25000'),
('Chit_A1_M13_Arasakumar_Chit_A1_Auction_3-f691ca17', '2026-05-13', 'Chit_Receipt', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_3', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_3', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_3', 'Chit_A1_M13_Arasakumar', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_3', 19990, 0, 326260, NULL, NULL, 'Chit_Malar', '19990'),
('Chit_A1_M14_Baskar_Chit_A1_Auction_3-95d34e83', '2026-05-13', 'Chit_Receipt', 'Chit_A1_M14_Baskar_Chit_A1_Auction_3', 'Chit_A1_M14_Baskar_Chit_A1_Auction_3', 'Chit_A1_M14_Baskar_Chit_A1_Auction_3', 'Chit_A1_M14_Baskar', 'Chit_A1_M14_Baskar_Chit_A1_Auction_3', 19990, 0, 346250, NULL, NULL, 'Chit_Malar', '19990'),
('49e63ef6', '2026-03-05', 'Deposit_From_Customer', 'Deposit-Mal-D-5-malar_appa1-malar_appa1', NULL, 'Mal-D-5-malar_appa1', 'malar_appa1', 'Deposit From Customer-malar_appa1', 100000, NULL, -13357149, 'Cash', NULL, 'Malar_Finance', NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-03-2026-40c3bfb6', '2026-05-15', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-03-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-03-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-03-2026', 'Malar_Appa', 'Depositer-Interest-03-2026', 0, 1000, -13358149, 'Cash', NULL, 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2026-40c3bfb6', '2026-05-15', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2026', 'Malar_Appa', 'Depositer-Interest-04-2026', 0, 1000, -13359149, 'Cash', NULL, 'Malar_Finance', '1000'),
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-03-2026-46985687', '2026-05-15', 'Depositer_Interest', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-03-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-03-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-03-2026', 'malar_appa1', 'Depositer-Interest-03-2026', 0, 900, -13360049, 'Cash', 'Given as 2000', 'Malar_Finance', '900'),
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-04-2026-46985687', '2026-05-15', 'Depositer_Interest', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-04-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-04-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-04-2026', 'malar_appa1', 'Depositer-Interest-04-2026', 0, 1000, -13361049, 'Cash', 'Given as 2000', 'Malar_Finance', '1000'),
('Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-04-2026-c7a045c7', '2026-05-15', 'Depositer_Interest', 'Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-04-2026', 'Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-04-2026', 'Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-04-2026', 'Deepak', 'Depositer-Interest-04-2026', 0, 375, 345875, 'UPI', NULL, 'Chit_Malar', '375'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_3-62ffbda2', '2026-05-15', 'Chit_Receipt', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_3', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_3', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_3', 'Chit_A1_M24_Valarmathi', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_3', 19990, 0, 365865, NULL, NULL, 'Chit_Malar', '19990'),
('1bb74b77', '2026-05-15', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL3-Palanisamy', 'Chi-STL3', 'Chi-32', 'Palanisamy', NULL, NULL, 300000, 65865, 'Other', 'By Ramkumar', 'Chit_Malar', NULL),
('Chit_A1_M22_Vikas_Chit_A1_Auction_2-16dea816', '2026-05-16', 'Chit_Receipt', 'Chit_A1_M22_Vikas_Chit_A1_Auction_2', 'Chit_A1_M22_Vikas_Chit_A1_Auction_2', 'Chit_A1_M22_Vikas_Chit_A1_Auction_2', 'Chit_A1_M22_Vikas', 'Chit_A1_M22_Vikas_Chit_A1_Auction_2', 14850, 0, 80715, 'UPI', 'By chandrasekar', 'Chit_Malar', '14850'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_3-16dea816', '2026-05-16', 'Chit_Receipt', 'Chit_A1_M22_Vikas_Chit_A1_Auction_3', 'Chit_A1_M22_Vikas_Chit_A1_Auction_3', 'Chit_A1_M22_Vikas_Chit_A1_Auction_3', 'Chit_A1_M22_Vikas', 'Chit_A1_M22_Vikas_Chit_A1_Auction_3', 15150, 0, 95865, 'UPI', 'By chandrasekar', 'Chit_Malar', '19990'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_2-75434456', '2026-05-17', 'Chit_Receipt', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_2', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_2', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_2', 'Chit_A1_M2_Malarvizhi', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_2', 9925, 0, 105790, 'UPI', NULL, 'Chit_Malar', '9925'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_3-75434456', '2026-05-17', 'Chit_Receipt', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_3', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_3', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_3', 'Chit_A1_M2_Malarvizhi', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_3', 9995, 0, 115785, 'UPI', NULL, 'Chit_Malar', '9995'),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_3-c4e28999', '2026-05-17', 'Chit_Receipt', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_3', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_3', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_3', 'Chit_A1_M9_Dinesh_Muthusamy', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_3', 19990, 0, 135775, 'UPI', NULL, 'Chit_Malar', '19990'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_3-65aadb84', '2026-05-17', 'Chit_Receipt', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_3', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_3', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_3', 'Chit_A1_M16_Sathyadevi', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_3', 19990, 0, 155765, 'UPI', NULL, 'Chit_Malar', '19990'),
('Chit_A1_M11_Kannan_Chit_A1_Auction_3-79324fbd', '2026-05-18', 'Chit_Receipt', 'Chit_A1_M11_Kannan_Chit_A1_Auction_3', 'Chit_A1_M11_Kannan_Chit_A1_Auction_3', 'Chit_A1_M11_Kannan_Chit_A1_Auction_3', 'Chit_A1_M11_Kannan', 'Chit_A1_M11_Kannan_Chit_A1_Auction_3', 9995, 0, 165760, 'Cash', 'given to kannan 240000 + 10k kannan chit to nagaraj+ 90k adj', 'Chit_Malar', '9995'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_3-a70658c7', '2026-05-19', 'Chit_Receipt', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_3', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_3', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_3', 'Chit_A1_M15_Gopalsamy', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_3', 19990, 0, 185750, 'Cash', NULL, 'Chit_Malar', '19990'),
('4d830061', '2026-05-19', 'Other_Finance_Loan_Refund', 'Chi-O-9-Ramkumar', 'Chi-O-9-Ramkumar', 'Chi-O-9-Ramkumar', 'Ramkumar', 'paid to palanisamy', NULL, 300000, -114250, 'Other', 'adjusted in palanisamy loan', 'Chit_Malar', 'Chi-O-9-Ramkumar-Ramkumar-Rs.300000'),
('Chit_A1_M8_Tharun_Chit_A1_Auction_3-f96f40e1', '2026-05-20', 'Chit_Receipt', 'Chit_A1_M8_Tharun_Chit_A1_Auction_3', 'Chit_A1_M8_Tharun_Chit_A1_Auction_3', 'Chit_A1_M8_Tharun_Chit_A1_Auction_3', 'Chit_A1_M8_Tharun', 'Chit_A1_M8_Tharun_Chit_A1_Auction_3', 19990, 0, -94260, 'Cash', 'TO KANNAN EXTRA 150+10 = 160 WITH ME', 'Chit_Malar', '19990'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_3-a9d8bdb0', '2026-05-20', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_3', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_3', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_3', 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_3', 19990, 0, -74270, 'UPI', NULL, 'Chit_Malar', '19990'),
('d0be7574', '2026-05-20', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL3-Palanisamy', 'Chi-STL3', 'Chi-33', 'Palanisamy', NULL, NULL, 200000, -274270, 'Cash', 'THROUGH DOLPHIN SIVA', 'Chit_Malar', NULL),
('9fcb0d12', '2026-05-20', 'Deposit_From_Customer', 'Deposit-Chi-D-8-Nagaraj Post Office-Nagaraj Post Office', NULL, 'Chi-D-8-Nagaraj Post Office', 'Nagaraj Post Office', 'Deposit From Customer-Nagaraj Post Office', 150000, NULL, -124270, 'Cash', NULL, 'Chit_Malar', NULL),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_3-0ce9e755', '2026-05-21', 'Chit_Receipt', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_3', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_3', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_3', 'Chit_A1_M7_Palanisamy', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_3', 19990, 0, -104280, 'UPI', NULL, 'Chit_Malar', '19990'),
('3a5409de', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL1-Ramasamy divya', 'Kan-STL1', 'Kan-34', 'Ramasamy divya', NULL, NULL, 50000, -50000, 'Other', NULL, 'Kannan_Finance', NULL),
('035d85a0', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL2-Sundaravadivel', 'Kan-STL2', 'Kan-35', 'Sundaravadivel', NULL, NULL, 100000, -150000, 'Other', NULL, 'Kannan_Finance', NULL),
('96283e1b', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL3-Suresh Balu vangap', 'Kan-STL3', 'Kan-36', 'Suresh Balu vangap', NULL, NULL, 300000, -450000, 'Other', NULL, 'Kannan_Finance', NULL),
('15798356', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL4-Nagaraj post', 'Kan-STL4', 'Kan-37', 'Nagaraj post', NULL, NULL, 30000, -480000, 'Other', NULL, 'Kannan_Finance', NULL),
('f948558d', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL5-Priya', 'Kan-STL5', 'Kan-38', 'Priya', NULL, NULL, 300000, -780000, 'Other', NULL, 'Kannan_Finance', NULL),
('a5af43df', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL6-Chathiram amma', 'Kan-STL6', 'Kan-39', 'Chathiram amma', NULL, NULL, 30000, -810000, 'Other', NULL, 'Kannan_Finance', NULL),
('84cd265a', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL7-Arul', 'Kan-STL7', 'Kan-40', 'Arul', NULL, NULL, 25000, -835000, 'Other', NULL, 'Kannan_Finance', NULL),
('7804c308', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL8-Manoj', 'Kan-STL8', 'Kan-41', 'Manoj', NULL, NULL, 10000, -845000, 'Other', NULL, 'Kannan_Finance', NULL),
('78af70e1', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL9-Surya vangap', 'Kan-STL9', 'Kan-42', 'Surya vangap', NULL, NULL, 140000, -985000, 'Other', NULL, 'Kannan_Finance', NULL),
('1d6f9118', '2026-05-10', 'Customer_Loan_Prin_Repayment', 'Kan-STL5-Kan-38-Priya-300000', 'Kan-STL5', 'Kan-38', 'Priya', 'Kan-38', 80000, NULL, -905000, 'Other', 'By arul on 11/05', 'Kannan_Finance', NULL),
('c3d0a912', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL5-Priya', 'Kan-STL5', 'Kan-43', 'Priya', NULL, NULL, 150000, -1055000, 'Other', NULL, 'Kannan_Finance', NULL),
('a7d24839', '2026-05-22', 'Customer_Loan_Prin_Repayment', 'Kan-STL5-Kan-38-Priya-300000', 'Kan-STL5', 'Kan-38', 'Priya', 'Kan-38', 150000, NULL, -905000, 'Other', 'By arul 55+25 on 22, 70 on 23', 'Kannan_Finance', NULL),
('0b8d81fd', '2026-05-23', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL2-Priya', 'Chi-STL2', 'Chi-44', 'Priya', NULL, NULL, 150000, -254280, 'Other', 'Kannan fin', 'Chit_Malar', NULL);
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('c05d69de', '2026-05-25', 'Deposit_From_Customer', 'Deposit-Chi-D-9-Nagaraj Post Office-Nagaraj Post Office', NULL, 'Chi-D-9-Nagaraj Post Office', 'Nagaraj Post Office', 'Deposit From Customer-Nagaraj Post Office', 600000, NULL, 345720, 'Cash', NULL, 'Chit_Malar', NULL),
('783d8ed0', '2026-05-25', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL4-Surrendar Puthur', 'Chi-STL4', 'Chi-45', 'Surrendar Puthur', NULL, NULL, 600000, -254280, 'Cash', 'given to surrendar mamanar', 'Chit_Malar', NULL),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_3-8ea98d77', '2026-05-25', 'Chit_Receipt', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_3', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_3', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_3', 'Chit_A1_M12_Dinesh_Thangavel', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_3', 19990, 0, -234290, 'UPI', 'By karthikeyan gpay', 'Chit_Malar', '19990'),
('07ee7676', '2026-05-28', 'Deposit_From_Customer', 'Deposit-Chi-D-10-Nagaraj Post Office-Nagaraj Post Office', NULL, 'Chi-D-10-Nagaraj Post Office', 'Nagaraj Post Office', 'Deposit From Customer-Nagaraj Post Office', 500000, NULL, 265710, 'Other', NULL, 'Chit_Malar', NULL),
('297835ce', '2026-05-28', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL3-Palanisamy', 'Chi-STL3', 'Chi-46', 'Palanisamy', NULL, NULL, 200000, 65710, 'Cash', 'Through his appa', 'Chit_Malar', NULL),
('d3597803', '2026-05-28', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL5-Elango manmangalam', 'Chi-STL5', 'Chi-47', 'Elango manmangalam', NULL, NULL, 100000, -34290, 'Cash', 'Though mathi', 'Chit_Malar', NULL),
('83891e5b', '2026-05-28', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL6-Nagaraj refill', 'Chi-STL6', 'Chi-48', 'Nagaraj refill', NULL, NULL, 50000, -84290, 'Cash', NULL, 'Chit_Malar', NULL),
('439478a8', '2026-05-28', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL7-Ramkumar', 'Chi-STL7', 'Chi-49', 'Ramkumar', NULL, NULL, 150000, -234290, 'Account', 'Thangavel 50+30+20, anand 47, gpay 3000', 'Chit_Malar', NULL),
('Chit_A1_M17_Arun Prakash_Chit_A1_Auction_3-345fa87b', '2026-05-30', 'Chit_Receipt', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_3', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_3', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_3', 'Chit_A1_M17_Arun Prakash', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_3', 19990, 0, -214300, 'UPI', 'total 25500, 19900 chit, remaining 4900 amu credit, 600 extra', 'Chit_Malar', '19990'),
('Chit_A1_M1_Arul_Chit_A1_Auction_3-36813a30', '2026-05-30', 'Chit_Receipt', 'Chit_A1_M1_Arul_Chit_A1_Auction_3', 'Chit_A1_M1_Arul_Chit_A1_Auction_3', 'Chit_A1_M1_Arul_Chit_A1_Auction_3', 'Chit_A1_M1_Arul', 'Chit_A1_M1_Arul_Chit_A1_Auction_3', 9995, 0, -204305, 'Other', 'adjusted', 'Chit_Malar', '9995'),
('Chit_A1_M21_Finance_Chit_Chit_A1_Auction_3-01c26da2', '2026-05-30', 'Chit_Receipt', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_3', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_3', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_3', 'Chit_A1_M21_Finance_Chit', 'Chit_A1_M21_Finance_Chit_Chit_A1_Auction_3', 19990, 0, -184315, 'Other', '15000 chit, remaining 4990 as extra', 'Chit_Malar', '19990'),
('774d2025', '2026-06-01', 'Customer_Loan_Prin_Repayment', 'Kan-STL5-Kan-38-Priya-70000', 'Kan-STL5', 'Kan-38', 'Priya', 'Kan-38', 60000, NULL, -845000, 'Other', '50k by kavi, 10k by arul', 'Kannan_Finance', '560,2310,1519,1680'),
('fa29c473', '2026-06-03', 'Customer_Loan_Prin_Repayment', 'Chi-STL4-Chi-45-Surrendar Puthur-600000', 'Chi-STL4', 'Chi-45', 'Surrendar Puthur', 'Chi-45', 200000, NULL, 15685, 'Cash', 'mamanar given 6l to ashok, need to transfer 4l to surrendar, rem 2l given to ram', 'Chit_Malar', '2100'),
('Palanisamy-Chi-STL3-Chi-32-300000-Interest-05-2026-9dca8bc4', '2026-06-10', 'Customer_Interest', 'Palanisamy-Chi-STL3-Chi-32-300000-Interest-05-2026', 'Chi-STL3', 'Chi-32', 'Palanisamy', 'Interest-05-2026', 4650, 0, 20335, 'UPI', NULL, 'Chit_Malar', '4650'),
('Palanisamy-Chi-STL3-Chi-33-200000-Interest-05-2026-9dca8bc4', '2026-06-10', 'Customer_Interest', 'Palanisamy-Chi-STL3-Chi-33-200000-Interest-05-2026', 'Chi-STL3', 'Chi-33', 'Palanisamy', 'Interest-05-2026', 1200, 0, 21535, 'UPI', NULL, 'Chit_Malar', '1200'),
('Palanisamy-Chi-STL3-Chi-46-200000-Interest-05-2026-9dca8bc4', '2026-06-10', 'Customer_Interest', 'Palanisamy-Chi-STL3-Chi-46-200000-Interest-05-2026', 'Chi-STL3', 'Chi-46', 'Palanisamy', 'Interest-05-2026', 400, 0, 21935, 'UPI', NULL, 'Chit_Malar', '400'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_4-990cc766', '2026-06-11', 'Chit_Receipt', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_4', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_4', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_4', 'Chit_A1_M16_Sathyadevi', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_4', 20200, 0, 42135, NULL, NULL, 'Chit_Malar', '20200'),
('Chit_A1_M23_Mohan_Chit_A1_Auction_4-b2461d67', '2026-06-11', 'Chit_Receipt', 'Chit_A1_M23_Mohan_Chit_A1_Auction_4', 'Chit_A1_M23_Mohan_Chit_A1_Auction_4', 'Chit_A1_M23_Mohan_Chit_A1_Auction_4', 'Chit_A1_M23_Mohan', 'Chit_A1_M23_Mohan_Chit_A1_Auction_4', 10100, 0, 52235, NULL, NULL, 'Chit_Malar', '10100'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_4-ba67e01c', '2026-06-11', 'Chit_Receipt', 'Chit_A1_M18_Deepak_Chit_A1_Auction_4', 'Chit_A1_M18_Deepak_Chit_A1_Auction_4', 'Chit_A1_M18_Deepak_Chit_A1_Auction_4', 'Chit_A1_M18_Deepak', 'Chit_A1_M18_Deepak_Chit_A1_Auction_4', 20200, 0, 72435, NULL, NULL, 'Chit_Malar', '20200'),
('Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-05-2026-736df9ce', '2026-06-11', 'Depositer_Interest', 'Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-05-2026', 'Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-05-2026', 'Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-05-2026', 'Deepak', 'Depositer-Interest-05-2026', 0, 750, 71685, 'Other', 'Adjusted in chit', 'Chit_Malar', '750'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_4-6c7753e0', '2026-06-11', 'Chit_Receipt', 'Chit_A1_M10_Gopal_Chit_A1_Auction_4', 'Chit_A1_M10_Gopal_Chit_A1_Auction_4', 'Chit_A1_M10_Gopal_Chit_A1_Auction_4', 'Chit_A1_M10_Gopal', 'Chit_A1_M10_Gopal_Chit_A1_Auction_4', 10100, 0, -834900, 'UPI', 'received at malar upi account', 'Kannan_Finance', '10100'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_4-297a5549', '2026-06-12', 'Chit_Receipt', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_4', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_4', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_4', 'Chit_A1_M2_Malarvizhi', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_4', 10100, 0, -824800, 'UPI', 'sent 15000, 10100 for gopal annan, remaining 5000 for malar chit.', 'Kannan_Finance', '10100'),
('43f4e57b', '2026-06-12', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', NULL, NULL, 50000, 21685, 'UPI', 'arul upi iob', 'Chit_Malar', NULL),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_4-4b7ccda2', '2026-06-12', 'Chit_Receipt', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_4', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_4', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_4', 'Chit_A1_M20_Rajesh', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_4', 20200, 0, 41885, 'Other', 'adjusted in chit payment amount', 'Chit_Malar', '20200'),
('0418ec78', '2026-06-12', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'adjusted in chit payment 20200', NULL, 20200, 21685, 'Other', 'adjusted in chit payment 20200', 'Chit_Malar', NULL),
('903e84cb', '2026-06-13', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'Ramkumar gpay', NULL, 22000, -315, 'UPI', 'by ramkumar', 'Chit_Malar', NULL),
('0f45aaa4', '2026-06-13', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'ponnusamy gpay', NULL, 20000, -20315, 'UPI', 'by ponnusamy tharun amount', 'Chit_Malar', NULL),
('82a39ee6', '2026-06-13', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'Given to ramkumar for chit', NULL, 25000, -45315, 'Cash', 'given to ramkumar chit for rajesh', 'Chit_Malar', NULL),
('Chit_A1_M8_Tharun_Chit_A1_Auction_4-92a43c96', '2026-06-13', 'Chit_Receipt', 'Chit_A1_M8_Tharun_Chit_A1_Auction_4', 'Chit_A1_M8_Tharun_Chit_A1_Auction_4', 'Chit_A1_M8_Tharun_Chit_A1_Auction_4', 'Chit_A1_M8_Tharun', 'Chit_A1_M8_Tharun_Chit_A1_Auction_4', 20200, 0, -25115, 'Cash', 'given to ponnusamy oil store', 'Chit_Malar', '20200'),
('Chit_A1_M1_Arul_Chit_A1_Auction_4-d0087574', '2026-06-13', 'Chit_Receipt', 'Chit_A1_M1_Arul_Chit_A1_Auction_4', 'Chit_A1_M1_Arul_Chit_A1_Auction_4', 'Chit_A1_M1_Arul_Chit_A1_Auction_4', 'Chit_A1_M1_Arul', 'Chit_A1_M1_Arul_Chit_A1_Auction_4', 10100, 0, -15015, 'Cash', 'given 15k to kannan for upi', 'Chit_Malar', '10100'),
('Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_4-7d56ae18', '2026-06-13', 'Chit_Receipt', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_4', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_4', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_4', 'Chit_A1_M5_Kavi_Surrendar', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_4', 20200, 0, 5185, 'Cash', 'by person of puthur near kannan department', 'Chit_Malar', '20200'),
('Chit_A1_M4_Surrendar_Chit_A1_Auction_4-1f3b9c3e', '2026-06-13', 'Chit_Receipt', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_4', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_4', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_4', 'Chit_A1_M4_Surrendar', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_4', 20200, 0, 25385, 'Cash', 'by person puthur near kannan department', 'Chit_Malar', '20200'),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_4-d61defe1', '2026-06-13', 'Chit_Receipt', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_4', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_4', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_4', 'Chit_A1_M25_Kaviyarasu', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_4', 20200, 0, 45585, 'UPI', 'Transferred to rajesh', 'Chit_Malar', '20200'),
('99d98ffd', '2026-06-13', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'By kaviyarsu 20200', NULL, 20200, 25385, 'UPI', 'By kaviyarsu', 'Chit_Malar', NULL),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_4-ac686580', '2026-06-13', 'Chit_Receipt', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_4', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_4', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_4', 'Chit_A1_M6_Amuthavel', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_4', 20200, 0, 45585, 'UPI', '20200-4675', 'Chit_Malar', '20200'),
('89648b5f', '2026-06-13', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', '45000', NULL, 45000, 585, 'UPI', 'Arul gpay', 'Chit_Malar', NULL),
('Chit_A1_M13_Arasakumar_Chit_A1_Auction_4-29939335', '2026-06-15', 'Chit_Receipt', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_4', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_4', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_4', 'Chit_A1_M13_Arasakumar', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_4', 20200, 0, 20785, NULL, NULL, 'Chit_Malar', '20200'),
('Chit_A1_M14_Baskar_Chit_A1_Auction_4-cba36a32', '2026-06-15', 'Chit_Receipt', 'Chit_A1_M14_Baskar_Chit_A1_Auction_4', 'Chit_A1_M14_Baskar_Chit_A1_Auction_4', 'Chit_A1_M14_Baskar_Chit_A1_Auction_4', 'Chit_A1_M14_Baskar', 'Chit_A1_M14_Baskar_Chit_A1_Auction_4', 20200, 0, 40985, NULL, NULL, 'Chit_Malar', '20200'),
('a47e9c0c', '2026-06-15', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'By cash nagaraj', NULL, 40000, 985, 'Cash', 'By cash nagaraj', 'Chit_Malar', NULL),
('Chit_A1_M11_Kannan_Chit_A1_Auction_4-b6c9a727', '2026-06-15', 'Chit_Receipt', 'Chit_A1_M11_Kannan_Chit_A1_Auction_4', 'Chit_A1_M11_Kannan_Chit_A1_Auction_4', 'Chit_A1_M11_Kannan_Chit_A1_Auction_4', 'Chit_A1_M11_Kannan', 'Chit_A1_M11_Kannan_Chit_A1_Auction_4', 10100, 0, 11085, 'UPI', NULL, 'Chit_Malar', '10100'),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_4-4e3f6c7d', '2026-06-17', 'Chit_Receipt', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_4', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_4', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_4', 'Chit_A1_M9_Dinesh_Muthusamy', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_4', 20200, 0, -13340849, 'UPI', NULL, 'Malar_Finance', '20200'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_4-c810c240', '2026-06-18', 'Chit_Receipt', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_4', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_4', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_4', 'Chit_A1_M24_Valarmathi', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_4', 20200, 0, -13320649, 'UPI', NULL, 'Malar_Finance', '20200'),
('1ce897de', '2026-06-19', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'By arul', NULL, 50000, -38915, 'UPI', NULL, 'Chit_Malar', NULL),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_4-e0c13add', '2026-06-19', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 9000, 0, -29915, 'Other', '5k cash, 4upi', 'Chit_Malar', '20200'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_4-0fa3d134', '2026-06-19', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 3333, 0, -26582, 'Other', 'Interest 3333', 'Chit_Malar', '11200'),
('Nagaraj Post Office-Chi-D-8-Nagaraj Post Office-150000-Depositer-Interest-05-2026-bd47652d', '2026-06-19', 'Depositer_Interest', 'Nagaraj Post Office-Chi-D-8-Nagaraj Post Office-150000-Depositer-Interest-05-2026', 'Nagaraj Post Office-Chi-D-8-Nagaraj Post Office-150000-Depositer-Interest-05-2026', 'Nagaraj Post Office-Chi-D-8-Nagaraj Post Office-150000-Depositer-Interest-05-2026', 'Nagaraj Post Office', 'Depositer-Interest-05-2026', 0, 750, -27332, 'Other', 'Chit adjusted', 'Chit_Malar', '750'),
('Nagaraj Post Office-Chi-D-9-Nagaraj Post Office-600000-Depositer-Interest-05-2026-bd47652d', '2026-06-19', 'Depositer_Interest', 'Nagaraj Post Office-Chi-D-9-Nagaraj Post Office-600000-Depositer-Interest-05-2026', 'Nagaraj Post Office-Chi-D-9-Nagaraj Post Office-600000-Depositer-Interest-05-2026', 'Nagaraj Post Office-Chi-D-9-Nagaraj Post Office-600000-Depositer-Interest-05-2026', 'Nagaraj Post Office', 'Depositer-Interest-05-2026', 0, 1750, -29082, 'Other', 'Chit adjusted', 'Chit_Malar', '1750'),
('Nagaraj Post Office-Chi-D-10-Nagaraj Post Office-500000-Depositer-Interest-05-2026-bd47652d', '2026-06-19', 'Depositer_Interest', 'Nagaraj Post Office-Chi-D-10-Nagaraj Post Office-500000-Depositer-Interest-05-2026', 'Nagaraj Post Office-Chi-D-10-Nagaraj Post Office-500000-Depositer-Interest-05-2026', 'Nagaraj Post Office-Chi-D-10-Nagaraj Post Office-500000-Depositer-Interest-05-2026', 'Nagaraj Post Office', 'Depositer-Interest-05-2026', 0, 833, -29915, 'Other', 'Chit adjusted', 'Chit_Malar', '833.333333333'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_4-9cefb151', '2026-06-19', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_4', 7867, 0, -22048, 'UPI', NULL, 'Chit_Malar', '7867'),
('9fc2adb7', '2026-06-19', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'By kaviyarsu', NULL, 20000, -42048, 'UPI', 'By kaviyarsu', 'Chit_Malar', NULL),
('Chit_A1_M22_Vikas_Chit_A1_Auction_3-33e84e79', '2026-06-20', 'Chit_Receipt', 'Chit_A1_M22_Vikas_Chit_A1_Auction_3', 'Chit_A1_M22_Vikas_Chit_A1_Auction_3', 'Chit_A1_M22_Vikas_Chit_A1_Auction_3', 'Chit_A1_M22_Vikas', 'Chit_A1_M22_Vikas_Chit_A1_Auction_3', 4840, 0, -37208, 'Cash', NULL, 'Chit_Malar', '4840'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_4-33e84e79', '2026-06-20', 'Chit_Receipt', 'Chit_A1_M22_Vikas_Chit_A1_Auction_4', 'Chit_A1_M22_Vikas_Chit_A1_Auction_4', 'Chit_A1_M22_Vikas_Chit_A1_Auction_4', 'Chit_A1_M22_Vikas', 'Chit_A1_M22_Vikas_Chit_A1_Auction_4', 20200, 0, -17008, 'Cash', NULL, 'Chit_Malar', '20200'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_4-f9284074', '2026-06-22', 'Chit_Receipt', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_4', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_4', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_4', 'Chit_A1_M15_Gopalsamy', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_4', 20200, 0, 3192, 'Cash', NULL, 'Chit_Malar', '20200'),
('5362675d', '2026-06-22', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'Upi vellaiyan', NULL, 31200, -28008, 'UPI', 'Vellaiyan', 'Chit_Malar', NULL),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_4-6e91dea0', '2026-06-22', 'Chit_Receipt', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_4', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_4', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_4', 'Chit_A1_M7_Palanisamy', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_4', 20200, 0, -7808, 'UPI', '4l by baskar, 3.89 pal chit amt, remaining 31200to rajesh', 'Chit_Malar', '20200'),
('c8cf36d6', '2026-06-22', 'Chit_Payment', 'Chit_A1_Auction_4_M1', NULL, NULL, 'Chit_A1_M7_Palanisamy', NULL, NULL, 389000, -396808, 'Cash', 'From baskar finance, 4l by ram', 'Chit_Malar', NULL),
('ddd9bebd', '2026-06-23', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'Vinayagum', NULL, 43000, -439808, 'UPI', 'Vinayagum', 'Chit_Malar', NULL),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_4-ce17a126', '2026-06-24', 'Chit_Receipt', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_4', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_4', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_4', 'Chit_A1_M3_Muthusamy', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_4', 20200, 0, -419608, 'Cash', 'Int 6750, eb 700', 'Chit_Malar', '20200'),
('58c18275', '2026-06-24', 'Deposit_Prin_Refund', 'Chi-D-8-Nagaraj Post Office', 'Chi-D-7-Deepak-Deepak-Rs.60000,Chi-D-8-Nagaraj Post Office-Nagaraj Post Office-Rs.150000,Chi-D-9-Nagaraj Post Office-Nagaraj Post Office-Rs.600000,Chi-D-10-Nagaraj Post Office-Nagaraj Post Office-Rs.500000', 'Chi-D-8-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, 100000, -519608, 'Other', 'Ramkumar land adjusted', 'Chit_Malar', 'Chi-D-7-Deepak-Deepak-Rs.60000,Chi-D-8-Nagaraj Post Office-Nagaraj Post Office-Rs.150000,Chi-D-9-Nagaraj Post Office-Nagaraj Post Office-Rs.600000,Chi-D-10-Nagaraj Post Office-Nagaraj Post Office-Rs.500000'),
('5d72fd25', '2026-06-04', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL7-Ramkumar', 'Chi-STL7', 'Chi-53', 'Ramkumar', 'Loan to Customer', NULL, 200000, -719608, 'Cash', '6l by surrendar mamanar, 4l to surrendar, 2l to ramkumar', 'Chit_Malar', NULL),
('06d2c2fd', '2026-06-24', 'Customer_Loan_Prin_Repayment', 'Chi-STL7-Chi-53-Ramkumar-200000', 'Chi-STL7', 'Chi-53', 'Ramkumar', 'Chi-53', 100000, NULL, -619608, 'Cash', 'given to nagaraj for land adjusment', 'Chit_Malar', '242'),
('Chit_A1_M17_Arun Prakash_Chit_A1_Auction_4-7b9f55c0', '2026-07-01', 'Chit_Receipt', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_4', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_4', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_4', 'Chit_A1_M17_Arun Prakash', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_4', 20200, 0, -599408, 'UPI', '25700 sent, 20200 for chit, remaining for emi', 'Chit_Malar', '20200'),
('Surrendar Puthur-Chi-STL4-Chi-45-600000-Interest-05-2026-1fe6b4f6', '2026-07-02', 'Customer_Interest', 'Surrendar Puthur-Chi-STL4-Chi-45-600000-Interest-05-2026', 'Chi-STL4', 'Chi-45', 'Surrendar Puthur', 'Interest-05-2026', 2100, 0, -597308, 'Cash', 'By his mamanar', 'Chit_Malar', '2100'),
('Surrendar Puthur-Chi-STL4-Chi-45-200000-Interest-06-2026-1fe6b4f6', '2026-07-02', 'Customer_Interest', 'Surrendar Puthur-Chi-STL4-Chi-45-200000-Interest-06-2026', 'Chi-STL4', 'Chi-45', 'Surrendar Puthur', 'Interest-06-2026', 300, 0, -597008, 'Cash', 'By his mamanar', 'Chit_Malar', '300'),
('644b76cb', '2026-07-01', 'Other_Finance_Loan_Refund', 'Chi-O-10-Baskar mama finance', 'Chi-O-10-Baskar mama finance', 'Chi-O-10-Baskar mama finance', 'Baskar mama finance', NULL, NULL, 100000, -697008, 'Cash', 'By nagaraj', 'Chit_Malar', 'Chi-O-9-Ramkumar-Ramkumar-Rs.0,Chi-O-10-Baskar mama finance-Baskar mama finance-Rs.250000,Chi-O-11-Baskar mama finance-Baskar mama finance-Rs.400000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-01-2026-14da51a3', '2026-07-03', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-01-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-01-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-01-2026', 'Gokila_Akka', 'Depositer-Interest-01-2026', 0, 2000, -13322649, 'UPI', 'Upi as 14800', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-02-2026-14da51a3', '2026-07-03', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-02-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-02-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-02-2026', 'Gokila_Akka', 'Depositer-Interest-02-2026', 0, 2000, -13324649, 'UPI', 'Upi as 14800', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-03-2026-14da51a3', '2026-07-03', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-03-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-03-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-03-2026', 'Gokila_Akka', 'Depositer-Interest-03-2026', 0, 2000, -13326649, 'UPI', 'Upi as 14800', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-04-2026-14da51a3', '2026-07-03', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-04-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-04-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-04-2026', 'Gokila_Akka', 'Depositer-Interest-04-2026', 0, 2000, -13328649, 'UPI', 'Upi as 14800', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-04-2026-14da51a3', '2026-07-03', 'Depositer_Interest', 'Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-04-2026', 'Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-04-2026', 'Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-04-2026', 'Gokila_Akka', 'Depositer-Interest-04-2026', 0, 766.666666667, -13329415.67, 'UPI', 'Upi as 14800', 'Malar_Finance', '766.666666667'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-05-2026-14da51a3', '2026-07-03', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-05-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-05-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-05-2026', 'Gokila_Akka', 'Depositer-Interest-05-2026', 0, 2000, -13331415.67, 'UPI', 'Upi as 14800', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-05-2026-14da51a3', '2026-07-03', 'Depositer_Interest', 'Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-05-2026', 'Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-05-2026', 'Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-05-2026', 'Gokila_Akka', 'Depositer-Interest-05-2026', 0, 1000, -13332415.67, 'UPI', 'Upi as 14800', 'Malar_Finance', '1000'),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2026-14da51a3', '2026-07-03', 'Depositer_Interest', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2026', 'Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2026', 'Gokila_Akka', 'Depositer-Interest-06-2026', 0, 2000, -13334415.67, 'UPI', 'Upi as 14800', 'Malar_Finance', '2000'),
('Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-06-2026-14da51a3', '2026-07-03', 'Depositer_Interest', 'Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-06-2026', 'Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-06-2026', 'Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-06-2026', 'Gokila_Akka', 'Depositer-Interest-06-2026', 0, 1000, -13335415.67, 'UPI', 'Upi as 14800', 'Malar_Finance', '1000'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-03-2026-935a8857', '2026-07-03', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-03-2026', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-03-2026', 175, 0, -13335240.67, 'UPI', 'Pradeep paid 16050 inc chit malar int', 'Malar_Finance', '175'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-04-2026-935a8857', '2026-07-03', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-04-2026', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-04-2026', 2100, 0, -13333140.67, 'UPI', 'Pradeep paid 16050 inc chit malar int', 'Malar_Finance', '2100'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-05-2026-935a8857', '2026-07-03', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-05-2026', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-05-2026', 2170, 0, -13330970.67, 'UPI', 'Pradeep paid 16050 inc chit malar int', 'Malar_Finance', '2170'),
('Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-06-2026-935a8857', '2026-07-03', 'Customer_Interest', 'Pradeep Vangapalayam-Mal-STL22-Mal-27-100000-Interest-06-2026', 'Mal-STL22', 'Mal-27', 'Pradeep Vangapalayam', 'Interest-06-2026', 2100, 0, -13328870.67, 'UPI', 'Pradeep paid 16050 inc chit malar int', 'Malar_Finance', '2100'),
('Pradeep-Chi-STL1-Chi-28-60000-Interest-04-2026-a1f9279a', '2026-07-03', 'Customer_Interest', 'Pradeep-Chi-STL1-Chi-28-60000-Interest-04-2026', 'Chi-STL1', 'Chi-28', 'Pradeep', 'Interest-04-2026', 630, 0, -696378, 'Cash', NULL, 'Chit_Malar', '630'),
('Pradeep-Chi-STL1-Chi-29-40000-Interest-04-2026-a1f9279a', '2026-07-03', 'Customer_Interest', 'Pradeep-Chi-STL1-Chi-29-40000-Interest-04-2026', 'Chi-STL1', 'Chi-29', 'Pradeep', 'Interest-04-2026', 364, 0, -696014, 'Cash', NULL, 'Chit_Malar', '364'),
('Pradeep-Chi-STL1-Chi-30-50000-Interest-04-2026-a1f9279a', '2026-07-03', 'Customer_Interest', 'Pradeep-Chi-STL1-Chi-30-50000-Interest-04-2026', 'Chi-STL1', 'Chi-30', 'Pradeep', 'Interest-04-2026', 385, 0, -695629, 'Cash', NULL, 'Chit_Malar', '385'),
('Pradeep-Chi-STL1-Chi-28-60000-Interest-05-2026-a1f9279a', '2026-07-03', 'Customer_Interest', 'Pradeep-Chi-STL1-Chi-28-60000-Interest-05-2026', 'Chi-STL1', 'Chi-28', 'Pradeep', 'Interest-05-2026', 1302, 0, -694327, 'Cash', NULL, 'Chit_Malar', '1302'),
('Pradeep-Chi-STL1-Chi-29-40000-Interest-05-2026-a1f9279a', '2026-07-03', 'Customer_Interest', 'Pradeep-Chi-STL1-Chi-29-40000-Interest-05-2026', 'Chi-STL1', 'Chi-29', 'Pradeep', 'Interest-05-2026', 868, 0, -693459, 'Cash', NULL, 'Chit_Malar', '868'),
('Pradeep-Chi-STL1-Chi-30-50000-Interest-05-2026-a1f9279a', '2026-07-03', 'Customer_Interest', 'Pradeep-Chi-STL1-Chi-30-50000-Interest-05-2026', 'Chi-STL1', 'Chi-30', 'Pradeep', 'Interest-05-2026', 1085, 0, -692374, 'Cash', NULL, 'Chit_Malar', '1085'),
('Pradeep-Chi-STL1-Chi-28-60000-Interest-06-2026-a1f9279a', '2026-07-03', 'Customer_Interest', 'Pradeep-Chi-STL1-Chi-28-29-30-150000-Interest-06-2026', 'Chi-STL1', 'Chi-28', 'Pradeep', 'Interest-06-2026', 3150, 0, -689224, 'Cash', NULL, 'Chit_Malar', '1260'),
('fd929196', '2026-06-01', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL2-Priya', 'Chi-STL2', 'Chi-54', 'Priya', 'Loan to Customer', NULL, 60000, -749224, 'UPI', 'adjusted to kannan in loan of 2lakh', 'Chit_Malar', NULL),
('934539cd', '2026-07-03', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL2-Priya', 'Chi-STL2', 'Chi-55', 'Priya', 'Loan to Customer', NULL, 50000, -799224, 'UPI', 'Upi', 'Chit_Malar', NULL),
('e716a10b', '2026-07-03', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL10-Rajesh post office', 'Chi-STL10', 'Chi-56', 'Rajesh post office', 'Loan to Customer', NULL, 500000, -1299224, 'Cash', 'By kannan prakash', 'Chit_Malar', NULL),
('Palanisamy-Chi-STL3-Chi-32-33-46-700000-Interest-06-2026-f8683953', '2026-07-09', 'Customer_Interest', 'Palanisamy-Chi-STL3-Chi-32-33-46-700000-Interest-06-2026', 'Chi-STL3', 'Chi-32-33-46', 'Palanisamy', 'Interest-06-2026', 10500, 0, -1288724, 'Cash', NULL, 'Chit_Malar', '10500'),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_4-c421c0bc', '2026-07-11', 'Chit_Receipt', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_4', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_4', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_4', 'Chit_A1_M12_Dinesh_Thangavel', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_4', 20200, 0, -1268524, 'UPI', 'Received 67000, 4th chit20200,5th 20500, upi sent 20k , remaining 6300', 'Chit_Malar', '20200'),
('Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_5-c421c0bc', '2026-07-11', 'Chit_Receipt', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_5', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_5', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_5', 'Chit_A1_M12_Dinesh_Thangavel', 'Chit_A1_M12_Dinesh_Thangavel_Chit_A1_Auction_5', 20500, 0, -1248024, 'UPI', 'Received 67000, 4th chit20200,5th 20500, upi sent 20k , remaining 6300', 'Chit_Malar', '20500'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_5-2aeb009c', '2026-07-11', 'Chit_Receipt', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_5', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_5', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_5', 'Chit_A1_M16_Sathyadevi', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_5', 20500, 0, -1227524, 'UPI', NULL, 'Chit_Malar', '20500'),
('Chit_A1_M23_Mohan_Chit_A1_Auction_5-441917bf', '2026-07-11', 'Chit_Receipt', 'Chit_A1_M23_Mohan_Chit_A1_Auction_5', 'Chit_A1_M23_Mohan_Chit_A1_Auction_5', 'Chit_A1_M23_Mohan_Chit_A1_Auction_5', 'Chit_A1_M23_Mohan', 'Chit_A1_M23_Mohan_Chit_A1_Auction_5', 10250, 0, -1217274, 'UPI', NULL, 'Chit_Malar', '10250'),
('Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_5-b64a1347', '2026-07-11', 'Chit_Receipt', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_5', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_5', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_5', 'Chit_A1_M5_Kavi_Surrendar', 'Chit_A1_M5_Kavi_Surrendar_Chit_A1_Auction_5', 20500, 0, -1196774, NULL, NULL, 'Chit_Malar', '20500'),
('Chit_A1_M4_Surrendar_Chit_A1_Auction_5-2fea86b3', '2026-07-11', 'Chit_Receipt', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_5', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_5', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_5', 'Chit_A1_M4_Surrendar', 'Chit_A1_M4_Surrendar_Chit_A1_Auction_5', 20500, 0, -1176274, NULL, NULL, 'Chit_Malar', '20500'),
('Chit_A1_M20_Rajesh_Chit_A1_Auction_5-3e43644c', '2026-07-11', 'Chit_Receipt', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_5', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_5', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_5', 'Chit_A1_M20_Rajesh', 'Chit_A1_M20_Rajesh_Chit_A1_Auction_5', 20500, 0, -1155774, 'Other', 'Ramkumar adjusted 25k rem 4500 send to rakesh', 'Chit_Malar', '20500'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_5-84dc67aa', '2026-07-12', 'Chit_Receipt', 'Chit_A1_M18_Deepak_Chit_A1_Auction_5', 'Chit_A1_M18_Deepak_Chit_A1_Auction_5', 'Chit_A1_M18_Deepak_Chit_A1_Auction_5', 'Chit_A1_M18_Deepak', 'Chit_A1_M18_Deepak_Chit_A1_Auction_5', 20500, 0, -1135274, 'UPI', '20500-750 interest', 'Chit_Malar', '20500'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2026-c99294db', '2026-07-12', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2026', 'Malar_Appa', 'Depositer-Interest-05-2026', 0, 1000, -13329870.67, 'Cash', 'Given as advance for July including', 'Malar_Finance', '1000'),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2026-c99294db', '2026-07-12', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2026', 'Malar_Appa', 'Depositer-Interest-06-2026', 0, 1000, -13330870.67, 'Cash', 'Given as advance for July including', 'Malar_Finance', '1000'),
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-05-2026-262d096f', '2026-07-12', 'Depositer_Interest', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-05-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-05-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-05-2026', 'malar_appa1', 'Depositer-Interest-05-2026', 0, 1000, -13331870.67, 'Cash', 'Given as advance for July including', 'Malar_Finance', '1000');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-06-2026-262d096f', '2026-07-12', 'Depositer_Interest', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-06-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-06-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-06-2026', 'malar_appa1', 'Depositer-Interest-06-2026', 0, 1000, -13332870.67, 'Cash', 'Given as advance for July including', 'Malar_Finance', '1000'),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_5-956ccf88', '2026-07-12', 'Chit_Receipt', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_5', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_5', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_5', 'Chit_A1_M25_Kaviyarasu', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_5', 20500, 0, -13312370.67, 'UPI', NULL, 'Malar_Finance', '20500'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_5-921b9b25', '2026-07-12', 'Chit_Receipt', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_5', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_5', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_5', 'Chit_A1_M6_Amuthavel', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_5', 20500, 0, -13291870.67, 'UPI', NULL, 'Malar_Finance', '20500'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_5-ba3b2982', '2026-07-13', 'Chit_Receipt', 'Chit_A1_M10_Gopal_Chit_A1_Auction_5', 'Chit_A1_M10_Gopal_Chit_A1_Auction_5', 'Chit_A1_M10_Gopal_Chit_A1_Auction_5', 'Chit_A1_M10_Gopal', 'Chit_A1_M10_Gopal_Chit_A1_Auction_5', 10250, 0, -13281620.67, 'UPI', NULL, 'Malar_Finance', '10250'),
('Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-06-2026-6593d3ce', '2026-07-13', 'Depositer_Interest', 'Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-06-2026', 'Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-06-2026', 'Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-06-2026', 'Deepak', 'Depositer-Interest-06-2026', 0, 750, -1136024, 'Other', 'Adjusted in chit', 'Chit_Malar', '750'),
('Chit_A1_M2_Malarvizhi_Chit_A1_Auction_5-8c6268a4', '2026-07-16', 'Chit_Receipt', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_5', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_5', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_5', 'Chit_A1_M2_Malarvizhi', 'Chit_A1_M2_Malarvizhi_Chit_A1_Auction_5', 10250, 0, -1125774, 'UPI', 'Given 30k, 25k for ramkumar chit', 'Chit_Malar', '10250'),
('692d4c8d', '2026-07-01', 'Deposit_From_Customer', 'Deposit_From_Customer-Chi-D-12-Gokila akka-Gokila akka', 'Chi-D-12-Gokila akka', 'Chi-D-12-Gokila akka', 'Gokila akka', 'Deposit_From_Customer', 300000, NULL, -825774, 'Cash', 'By appa on 16.07.26', 'Chit_Malar', NULL),
('f0f44d99', '2026-07-16', 'Other_Finance_Loan_Refund', 'Chi-O-11-Baskar mama finance', 'Chi-O-10-Baskar mama finance-Baskar mama finance-Rs.150000,Chi-O-11-Baskar mama finance-Baskar mama finance-Rs.400000,Chi-O-12-Prakash-Prakash-Rs.500000', 'Chi-O-11-Baskar mama finance', 'Baskar mama finance', NULL, NULL, 300000, -1125774, 'Cash', 'To karthi', 'Chit_Malar', 'Chi-O-10-Baskar mama finance-Baskar mama finance-Rs.150000,Chi-O-11-Baskar mama finance-Baskar mama finance-Rs.400000,Chi-O-12-Prakash-Prakash-Rs.500000'),
('15466675', '2026-07-15', 'Other_Finance_Loan', 'Other_Finance_Loan-Chi-O-13-Ramkumar-Ramkumar', 'Chi-O-13-Ramkumar', 'Chi-O-13-Ramkumar', 'Ramkumar', 'Other_Finance_Loan', 200000, NULL, -925774, NULL, 'given to tharun for chit amount', 'Chit_Malar', NULL),
('92208684', '2026-07-15', 'Chit_Payment', 'Chit_A1_Auction_5_M1', NULL, NULL, 'Chit_A1_M8_Tharun', 'given by ramkumar 2l', NULL, 200000, -1125774, 'Cash', 'given by ramkumar 2l', 'Chit_Malar', NULL),
('4cbf523d', '2026-07-16', 'Chit_Payment', 'Chit_A1_Auction_5_M1', NULL, NULL, 'Chit_A1_M8_Tharun', 'given by kannan', NULL, 100000, -1225774, 'Cash', 'given by kannan, online, 50 ashok ann to kannan, 50 to senthilnathan', 'Chit_Malar', NULL),
('65cbd931', '2026-07-17', 'Chit_Payment', 'Chit_A1_Auction_5_M1', NULL, NULL, 'Chit_A1_M8_Tharun', 'interest for june 26 2lakhs', NULL, 3360, -1229134, 'Other', 'adjusted for june interest', 'Chit_Malar', NULL),
('c2f8fc06', '2026-07-17', 'Chit_Payment', 'Chit_A1_Auction_5_M1', NULL, NULL, 'Chit_A1_M8_Tharun', 'adjusted for chit amount already given 15000 remaining 5500', NULL, 5500, -1234634, 'Other', 'adjusted for chit amount already given 15000 remaining 5500', 'Chit_Malar', NULL),
('140ffdef', '2026-07-11', 'Chit_Payment', 'Chit_A1_Auction_5_M1', NULL, NULL, 'Chit_A1_M8_Tharun', 'online payment by upi to this friend', NULL, 50000, -1284634, 'UPI', 'online payment by upi to this friend', 'Chit_Malar', NULL),
('Tharun kannan-Chi-STL9-Chi-51-200000-Interest-06-2026-80b9a99d', '2026-07-17', 'Customer_Interest', 'Tharun kannan-Chi-STL9-Chi-51-200000-Interest-06-2026', 'Chi-STL9', 'Chi-51', 'Tharun kannan', 'Interest-06-2026', 3360, 0, -1281274, 'Other', 'adjusted in chit amount', 'Chit_Malar', '3360'),
('Surrendar Puthur-Chi-STL4-Chi-45-400000-Interest-06-2026-282674b5', '2026-07-17', 'Customer_Interest', 'Surrendar Puthur-Chi-STL4-Chi-45-400000-Interest-06-2026', 'Chi-STL4', 'Chi-45', 'Surrendar Puthur', 'Interest-06-2026', 6000, 0, -1275274, 'Cash', 'adjusted in  already received', 'Chit_Malar', '6000'),
('Ramkumar-Chi-STL7-Chi-49-150000-Interest-05-2026-797a41e8', '2026-07-17', 'Customer_Interest', 'Ramkumar-Chi-STL7-Chi-49-150000-Interest-05-2026', 'Chi-STL7', 'Chi-49', 'Ramkumar', 'Interest-05-2026', 242, 0, -1275032, 'Other', 'adjusted in ramkumar chit', 'Chit_Malar', '242'),
('Ramkumar-Chi-STL7-Chi-53-100000-Interest-06-2026-797a41e8', '2026-07-17', 'Customer_Interest', 'Ramkumar-Chi-STL7-Chi-53-100000-Interest-06-2026', 'Chi-STL7', 'Chi-53', 'Ramkumar', 'Interest-06-2026', 1094, 0, -1273938, 'Other', 'adjusted in ramkumar chit', 'Chit_Malar', '1094'),
('Ramkumar-Chi-STL7-Chi-49-53-250000-Interest-06-2026-797a41e8', '2026-07-17', 'Customer_Interest', 'Ramkumar-Chi-STL7-Chi-49-53-250000-Interest-06-2026', 'Chi-STL7', 'Chi-49-53', 'Ramkumar', 'Interest-06-2026', 3010, 0, -1270928, 'Other', 'adjusted in ramkumar chit', 'Chit_Malar', '3010'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-02-2026-9b3c2059', '2026-07-17', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-02-2026', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-02-2026', 6048, 0, -13275572.67, 'Other', 'adjusted to ramkumar chit', 'Malar_Finance', '6048'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-03-2026-9b3c2059', '2026-07-17', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-03-2026', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-03-2026', 6696, 0, -13268876.67, 'Other', 'adjusted to ramkumar chit', 'Malar_Finance', '6696'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-04-2026-9b3c2059', '2026-07-17', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-04-2026', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-04-2026', 6480, 0, -13262396.67, 'Other', 'adjusted to ramkumar chit', 'Malar_Finance', '6480'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-05-2026-9b3c2059', '2026-07-17', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-05-2026', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-05-2026', 6696, 0, -13255700.67, 'Other', 'adjusted to ramkumar chit', 'Malar_Finance', '6696'),
('Orange_Tex-Mal-STL13-Mal-5-270000-Interest-06-2026-9b3c2059', '2026-07-17', 'Customer_Interest', 'Orange_Tex-Mal-STL13-Mal-5-270000-Interest-06-2026', 'Mal-STL13', 'Mal-5', 'Orange_Tex', 'Interest-06-2026', 6480, 0, -13249220.67, 'Other', 'adjusted to ramkumar chit', 'Malar_Finance', '6480'),
('Ramkumar-Mal-STL14-Mal-6-250000-Interest-02-2026-456c2594', '2026-07-17', 'Customer_Interest', 'Ramkumar-Mal-STL14-Mal-6-250000-Interest-02-2026', 'Mal-STL14', 'Mal-6', 'Ramkumar', 'Interest-02-2026', 0, 0, -13249220.67, 'Other', 'adjusted in ramkumar chit', 'Malar_Finance', '4200'),
('3ceddb3f', '2026-07-01', 'Loan_To_Customer', 'Loan_To_Customer-Mal-STL14-Ramkumar', 'Mal-STL14', 'Mal-57', 'Ramkumar', 'Loan to Customer', NULL, 500000, -13749220.67, 'Other', 'for chit by malar', 'Malar_Finance', NULL),
('Priya-Chi-STL2-Chi-31-80000-Interest-05-2026-9b60e153', '2026-07-17', 'Customer_Interest', 'Priya-Chi-STL2-Chi-31-80000-Interest-05-2026', 'Chi-STL2', 'Chi-31', 'Priya', 'Interest-05-2026', 1176, 0, -1269752, 'Other', 'Adjusted to kannan for tharun', 'Chit_Malar', '1176'),
('Priya-Chi-STL2-Chi-44-150000-Interest-05-2026-9b60e153', '2026-07-17', 'Customer_Interest', 'Priya-Chi-STL2-Chi-44-150000-Interest-05-2026', 'Chi-STL2', 'Chi-44', 'Priya', 'Interest-05-2026', 945, 0, -1268807, 'Other', 'Adjusted to kannan for tharun', 'Chit_Malar', '945'),
('Priya-Chi-STL2-Chi-31-44-54-290000-Interest-06-2026-9b60e153', '2026-07-17', 'Customer_Interest', 'Priya-Chi-STL2-Chi-31-44-54-290000-Interest-06-2026', 'Chi-STL2', 'Chi-31-44-54', 'Priya', 'Interest-06-2026', 6090, 0, -1262717, 'Other', 'Adjusted to kannan for tharun', 'Chit_Malar', '6090'),
('Chit_A1_M22_Vikas_Chit_A1_Auction_5-20a30405', '2026-07-17', 'Chit_Receipt', 'Chit_A1_M22_Vikas_Chit_A1_Auction_5', 'Chit_A1_M22_Vikas_Chit_A1_Auction_5', 'Chit_A1_M22_Vikas_Chit_A1_Auction_5', 'Chit_A1_M22_Vikas', 'Chit_A1_M22_Vikas_Chit_A1_Auction_5', 20500, 0, -1242217, 'UPI', '21190 for me and rem for kannan', 'Chit_Malar', '20500'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_5-c450554a', '2026-07-17', 'Chit_Receipt', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_5', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_5', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_5', 'Chit_A1_M24_Valarmathi', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_5', 20500, 0, -1221717, 'UPI', 'By chandrasekar', 'Chit_Malar', '20500'),
('32e04ed4', '2026-07-17', 'Chit_Payment', 'Chit_A1_Auction_5_M1', NULL, NULL, 'Chit_A1_M8_Tharun', 'For kannan chit', NULL, 19810, -1241527, 'UPI', 'By cahndru kannan upi chit', 'Chit_Malar', NULL),
('c947535d', '2026-07-18', 'Deposit_From_Customer', 'Deposit_From_Customer-Chi-D-13-Malar amma-Malar amma', 'Chi-D-13-Malar amma', 'Chi-D-13-Malar amma', 'Malar amma', 'Deposit_From_Customer', 300000, NULL, -941527, 'Cash', NULL, 'Chit_Malar', NULL),
('5c1fb6a6', '2026-07-17', 'Other_Finance_Loan_Refund', 'Chi-O-10-Baskar mama finance', 'Chi-O-10-Baskar mama finance-Baskar mama finance-Rs.150000,Chi-O-11-Baskar mama finance-Baskar mama finance-Rs.100000,Chi-O-12-Prakash-Prakash-Rs.500000,Chi-O-13-Ramkumar-Ramkumar-Rs.200000', 'Chi-O-10-Baskar mama finance', 'Baskar mama finance', NULL, NULL, 150000, -1091527, 'Cash', NULL, 'Chit_Malar', 'Chi-O-10-Baskar mama finance-Baskar mama finance-Rs.150000,Chi-O-11-Baskar mama finance-Baskar mama finance-Rs.100000,Chi-O-12-Prakash-Prakash-Rs.500000,Chi-O-13-Ramkumar-Ramkumar-Rs.200000'),
('50b018ad', '2026-07-17', 'Other_Finance_Loan_Refund', 'Chi-O-11-Baskar mama finance', 'Chi-O-11-Baskar mama finance-Baskar mama finance-Rs.100000,Chi-O-12-Prakash-Prakash-Rs.500000,Chi-O-13-Ramkumar-Ramkumar-Rs.200000', 'Chi-O-11-Baskar mama finance', 'Baskar mama finance', NULL, NULL, 100000, -1191527, 'Cash', 'To karthi vangalalayam', 'Chit_Malar', 'Chi-O-10-Baskar mama finance-Baskar mama finance-Rs.150000,Chi-O-11-Baskar mama finance-Baskar mama finance-Rs.100000,Chi-O-12-Prakash-Prakash-Rs.500000,Chi-O-13-Ramkumar-Ramkumar-Rs.200000'),
('Baskar mama finance-Chi-O-10-Baskar mama finance-250000-Other-Finance-Interest-06-2026-c122b058', '2026-07-18', 'Other_Finance_Interest', 'Baskar mama finance-Chi-O-10-Baskar mama finance-250000-Other-Finance-Interest-06-2026', 'Baskar mama finance-Chi-O-10-Baskar mama finance-250000-Other-Finance-Interest-06-2026', 'Baskar mama finance-Chi-O-10-Baskar mama finance-250000-Other-Finance-Interest-06-2026', 'Baskar mama finance', 'Other-Finance-Interest-06-2026', 0, 4200, -1195727, 'Cash', 'Given To karthi 5480+7000', 'Chit_Malar', '4200'),
('Baskar mama finance-Chi-O-11-Baskar mama finance-400000-Other-Finance-Interest-06-2026-c122b058', '2026-07-18', 'Other_Finance_Interest', 'Baskar mama finance-Chi-O-11-Baskar mama finance-400000-Other-Finance-Interest-06-2026', 'Baskar mama finance-Chi-O-11-Baskar mama finance-400000-Other-Finance-Interest-06-2026', 'Baskar mama finance-Chi-O-11-Baskar mama finance-400000-Other-Finance-Interest-06-2026', 'Baskar mama finance', 'Other-Finance-Interest-06-2026', 0, 3120, -1198847, 'Cash', 'Given To karthi 5480+7000', 'Chit_Malar', '3120'),
('Baskar mama finance-Chi-O-10-Baskar mama finance-150000-Other-Finance-Interest-07-2026-c122b058', '2026-07-18', 'Other_Finance_Interest', 'Baskar mama finance-Chi-O-10-Baskar mama finance-150000-Other-Finance-Interest-07-2026', 'Baskar mama finance-Chi-O-10-Baskar mama finance-150000-Other-Finance-Interest-07-2026', 'Baskar mama finance-Chi-O-10-Baskar mama finance-150000-Other-Finance-Interest-07-2026', 'Baskar mama finance', 'Other-Finance-Interest-07-2026', 0, 60, -1198907, 'Cash', 'Given To karthi 5480+7000', 'Chit_Malar', '60'),
('Baskar mama finance-Chi-O-11-Baskar mama finance-300000-Other-Finance-Prin_Refund_Interest-07-2026-c122b058', '2026-07-18', 'Other_Finance_Interest', 'Baskar mama finance-Chi-O-11-Baskar mama finance-300000-Other-Finance-Prin_Refund_Interest-07-2026', 'Baskar mama finance-Chi-O-11-Baskar mama finance-300000-Other-Finance-Prin_Refund_Interest-07-2026', 'Baskar mama finance-Chi-O-11-Baskar mama finance-300000-Other-Finance-Prin_Refund_Interest-07-2026', 'Baskar mama finance', 'Other-Finance-Prin_Refund_Interest-07-2026', 0, 2880, -1201787, 'Cash', 'Given To karthi 5480+7000', 'Chit_Malar', '2880'),
('Baskar mama finance-Chi-O-10-Baskar mama finance-150000-Other-Finance-Prin_Refund_Interest-07-2026-c122b058', '2026-07-18', 'Other_Finance_Interest', 'Baskar mama finance-Chi-O-10-Baskar mama finance-150000-Other-Finance-Prin_Refund_Interest-07-2026', 'Baskar mama finance-Chi-O-10-Baskar mama finance-150000-Other-Finance-Prin_Refund_Interest-07-2026', 'Baskar mama finance-Chi-O-10-Baskar mama finance-150000-Other-Finance-Prin_Refund_Interest-07-2026', 'Baskar mama finance', 'Other-Finance-Prin_Refund_Interest-07-2026', 0, 1530, -1203317, 'Cash', 'Given To karthi 5480+7000', 'Chit_Malar', '1530'),
('Baskar mama finance-Chi-O-11-Baskar mama finance-100000-Other-Finance-Prin_Refund_Interest-07-2026-c122b058', '2026-07-18', 'Other_Finance_Interest', 'Baskar mama finance-Chi-O-11-Baskar mama finance-100000-Other-Finance-Prin_Refund_Interest-07-2026', 'Baskar mama finance-Chi-O-11-Baskar mama finance-100000-Other-Finance-Prin_Refund_Interest-07-2026', 'Baskar mama finance-Chi-O-11-Baskar mama finance-100000-Other-Finance-Prin_Refund_Interest-07-2026', 'Baskar mama finance', 'Other-Finance-Prin_Refund_Interest-07-2026', 0, 1020, -1204337, 'Cash', 'Given To karthi 5480+7000', 'Chit_Malar', '1020'),
('Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_5-ea526b3f', '2026-07-18', 'Chit_Receipt', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_5', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_5', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_5', 'Chit_A1_M9_Dinesh_Muthusamy', 'Chit_A1_M9_Dinesh_Muthusamy_Chit_A1_Auction_5', 20500, 0, -1183837, 'UPI', NULL, 'Chit_Malar', '20500'),
('Chit_A1_M3_Muthusamy_Chit_A1_Auction_5-1da574fe', '2026-07-22', 'Chit_Receipt', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_5', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_5', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_5', 'Chit_A1_M3_Muthusamy', 'Chit_A1_M3_Muthusamy_Chit_A1_Auction_5', 18250, 0, -1165587, 'Other', NULL, 'Chit_Malar', '20500'),
('Chit_A1_M8_Tharun_Chit_A1_Auction_5-2ffaf840', '2026-07-22', 'Chit_Receipt', 'Chit_A1_M8_Tharun_Chit_A1_Auction_5', 'Chit_A1_M8_Tharun_Chit_A1_Auction_5', 'Chit_A1_M8_Tharun_Chit_A1_Auction_5', 'Chit_A1_M8_Tharun', 'Chit_A1_M8_Tharun_Chit_A1_Auction_5', 20500, 0, -1145087, 'Cash', 'adjusted in chit amount', 'Chit_Malar', '20500'),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_5-b59e36b3', '2026-07-11', 'Chit_Receipt', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_5', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_5', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_5', 'Chit_A1_M7_Palanisamy', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_5', 20500, 0, -1124587, 'UPI', 'by  mohankrishnan', 'Chit_Malar', '20500'),
('Chit_A1_M13_Arasakumar_Chit_A1_Auction_5-6efa1818', '2026-07-24', 'Chit_Receipt', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_5', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_5', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_5', 'Chit_A1_M13_Arasakumar', 'Chit_A1_M13_Arasakumar_Chit_A1_Auction_5', 20500, 0, -1104087, 'Cash', NULL, 'Chit_Malar', '20500'),
('Chit_A1_M14_Baskar_Chit_A1_Auction_5-e6f3b3fb', '2026-07-24', 'Chit_Receipt', 'Chit_A1_M14_Baskar_Chit_A1_Auction_5', 'Chit_A1_M14_Baskar_Chit_A1_Auction_5', 'Chit_A1_M14_Baskar_Chit_A1_Auction_5', 'Chit_A1_M14_Baskar', 'Chit_A1_M14_Baskar_Chit_A1_Auction_5', 20500, 0, -1083587, 'Cash', NULL, 'Chit_Malar', '20500'),
('Chit_A1_M15_Gopalsamy_Chit_A1_Auction_5-d8eb156d', '2026-07-24', 'Chit_Receipt', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_5', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_5', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_5', 'Chit_A1_M15_Gopalsamy', 'Chit_A1_M15_Gopalsamy_Chit_A1_Auction_5', 20500, 0, -1063087, 'Cash', NULL, 'Chit_Malar', '20500'),
('Chit_A1_M11_Kannan_Chit_A1_Auction_5-97b8c2dc', '2026-07-25', 'Chit_Receipt', 'Chit_A1_M11_Kannan_Chit_A1_Auction_5', 'Chit_A1_M11_Kannan_Chit_A1_Auction_5', 'Chit_A1_M11_Kannan_Chit_A1_Auction_5', 'Chit_A1_M11_Kannan', 'Chit_A1_M11_Kannan_Chit_A1_Auction_5', 10250, 0, -1052837, 'Other', 'Adjusted in baskar mama finance', 'Chit_Malar', '10250'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_5-45a89522', '2026-07-25', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_5', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_5', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_5', 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_5', 15375, 0, -1037462, 'Other', 'Adjusted in interest', 'Chit_Malar', '20500'),
('Chit_A1_M17_Arun Prakash_Chit_A1_Auction_5-7542a7ef', '2026-07-28', 'Chit_Receipt', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_5', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_5', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_5', 'Chit_A1_M17_Arun Prakash', 'Chit_A1_M17_Arun Prakash_Chit_A1_Auction_5', 20500, 0, -1016962, 'UPI', NULL, 'Chit_Malar', '20500'),
('fff2aada', '2026-07-30', 'Customer_Loan_Prin_Repayment', 'Kan-STL5-Kan-43-Priya-150000', 'Kan-STL5', 'Kan-43', 'Priya', 'Kan-43', 40000, NULL, -784800, 'Cash', 'through ashok kannan, ashok kannan upi transferred', 'Kannan_Finance', '560,2310,1519,1680,42,7560'),
('bb83b7db', '2026-07-31', 'Loan_To_Customer', 'Loan_To_Customer-Chi-STL2-Priya', 'Chi-STL2', 'Chi-58', 'Priya', 'Loan to Customer', NULL, 40000, -1056962, 'Other', 'adjusted with kannan finance on 30th', 'Chit_Malar', NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2026-749ad200', '2026-07-31', 'Depositer_Interest', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2026', 'Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2026', 'Malar_Appa', 'Depositer-Interest-07-2026', 0, 1000, -13750220.67, 'Cash', 'paid in advance during july middle', 'Malar_Finance', '1000'),
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-07-2026-f79cec39', '2026-07-31', 'Depositer_Interest', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-07-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-07-2026', 'malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-07-2026', 'malar_appa1', 'Depositer-Interest-07-2026', 0, 1000, -13751220.67, 'Cash', 'to malar appa paid in advance during july middle', 'Malar_Finance', '1000'),
('a217b919', '2026-07-02', 'Chit_Payment', 'Chit_A1_Auction_4_M2', NULL, NULL, 'Chit_A1_M20_Rajesh', 'through upi', NULL, 10400, -1067362, 'UPI', 'through gpay', 'Chit_Malar', NULL),
('Palanisamy-Chi-STL3-Chi-32-33-46-700000-Interest-07-2026-7c56b8b5', '2026-08-06', 'Customer_Interest', 'Palanisamy-Chi-STL3-Chi-32-33-46-700000-Interest-07-2026', 'Chi-STL3', 'Chi-32-33-46', 'Palanisamy', 'Interest-07-2026', 10850, 0, -1056512, 'UPI', NULL, 'Chit_Malar', '10850'),
('Nagaraj refill-Chi-STL6-Chi-48-50000-Interest-05-2026-90b07842', '2026-08-06', 'Customer_Interest', 'Nagaraj refill-Chi-STL6-Chi-48-50000-Interest-05-2026', 'Chi-STL6', 'Chi-48', 'Nagaraj refill', 'Interest-05-2026', 81, 0, -1056431, 'Other', 'Adjusted for cover putting', 'Chit_Malar', '81'),
('Nagaraj refill-Chi-STL6-Chi-48-50000-Interest-06-2026-90b07842', '2026-08-06', 'Customer_Interest', 'Nagaraj refill-Chi-STL6-Chi-48-50000-Interest-06-2026', 'Chi-STL6', 'Chi-48', 'Nagaraj refill', 'Interest-06-2026', 630, 0, -1055801, 'Other', 'Adjusted for cover putting', 'Chit_Malar', '630'),
('Nagaraj refill-Chi-STL6-Chi-48-50000-Interest-07-2026-90b07842', '2026-08-06', 'Customer_Interest', 'Nagaraj refill-Chi-STL6-Chi-48-50000-Interest-07-2026', 'Chi-STL6', 'Chi-48', 'Nagaraj refill', 'Interest-07-2026', 630, 0, -1055171, 'Other', 'Adjusted for cover putting', 'Chit_Malar', '630'),
('Tharun kannan-Chi-STL9-Chi-51-200000-Interest-07-2026-4971d15f', '2026-08-06', 'Customer_Interest', 'Tharun kannan-Chi-STL9-Chi-51-200000-Interest-07-2026', 'Chi-STL9', 'Chi-51', 'Tharun kannan', 'Interest-07-2026', 3100, 0, -1052071, 'Other', 'Adjusted in already given amount', 'Chit_Malar', '3100'),
('Chit_A1_M7_Palanisamy_Chit_A1_Auction_6-c8bb1411', '2026-08-11', 'Chit_Receipt', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_6', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_6', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_6', 'Chit_A1_M7_Palanisamy', 'Chit_A1_M7_Palanisamy_Chit_A1_Auction_6', 20725, 0, -1031346, 'UPI', NULL, 'Chit_Malar', '20725'),
('Chit_A1_M10_Gopal_Chit_A1_Auction_6-53c2e33e', '2026-08-12', 'Chit_Receipt', 'Chit_A1_M10_Gopal_Chit_A1_Auction_6', 'Chit_A1_M10_Gopal_Chit_A1_Auction_6', 'Chit_A1_M10_Gopal_Chit_A1_Auction_6', 'Chit_A1_M10_Gopal', 'Chit_A1_M10_Gopal_Chit_A1_Auction_6', 10362.5, 0, -1020983.5, 'Cash', NULL, 'Chit_Malar', '10362.5'),
('Chit_A1_M18_Deepak_Chit_A1_Auction_6-22965ea6', '2026-08-12', 'Chit_Receipt', 'Chit_A1_M18_Deepak_Chit_A1_Auction_6', 'Chit_A1_M18_Deepak_Chit_A1_Auction_6', 'Chit_A1_M18_Deepak_Chit_A1_Auction_6', 'Chit_A1_M18_Deepak', 'Chit_A1_M18_Deepak_Chit_A1_Auction_6', 20725, 0, -1000258.5, 'UPI', '20725-750 int', 'Chit_Malar', '20725'),
('Chit_A1_M24_Valarmathi_Chit_A1_Auction_6-99747747', '2026-08-12', 'Chit_Receipt', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_6', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_6', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_6', 'Chit_A1_M24_Valarmathi', 'Chit_A1_M24_Valarmathi_Chit_A1_Auction_6', 20725, 0, -979533.5, 'UPI', NULL, 'Chit_Malar', '20725'),
('Chit_A1_M23_Mohan_Chit_A1_Auction_6-192290aa', '2026-08-12', 'Chit_Receipt', 'Chit_A1_M23_Mohan_Chit_A1_Auction_6', 'Chit_A1_M23_Mohan_Chit_A1_Auction_6', 'Chit_A1_M23_Mohan_Chit_A1_Auction_6', 'Chit_A1_M23_Mohan', 'Chit_A1_M23_Mohan_Chit_A1_Auction_6', 10362.5, 0, -969171, 'UPI', NULL, 'Chit_Malar', '10362.5'),
('Chit_A1_M16_Sathyadevi_Chit_A1_Auction_6-c2c9a219', '2026-08-13', 'Chit_Receipt', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_6', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_6', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_6', 'Chit_A1_M16_Sathyadevi', 'Chit_A1_M16_Sathyadevi_Chit_A1_Auction_6', 20725, 0, -948446, 'UPI', NULL, 'Chit_Malar', '20725'),
('Chit_A1_M19_Nagaraj_Chit_A1_Auction_5-0030da55', '2026-08-13', 'Chit_Receipt', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_5', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_5', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_5', 'Chit_A1_M19_Nagaraj', 'Chit_A1_M19_Nagaraj_Chit_A1_Auction_5', 5125, 0, -943321, NULL, NULL, 'Chit_Malar', '5125'),
('Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_6-0c265501', '2026-08-13', 'Chit_Receipt', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_6', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_6', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_6', 'Chit_A1_M25_Kaviyarasu', 'Chit_A1_M25_Kaviyarasu_Chit_A1_Auction_6', 20725, 0, -922596, 'UPI', NULL, 'Chit_Malar', '20725'),
('196de614', '2026-08-13', 'Chit_Payment', 'Chit_A1_Auction_6_M1', NULL, NULL, 'Chit_A1_M11_Kannan', 'To madu bala upi', NULL, 68000, -990596, 'UPI', 'Mathu bala upi', 'Chit_Malar', NULL),
('Chit_A1_M11_Kannan_Chit_A1_Auction_6-82ab3093', '2026-08-14', 'Chit_Receipt', 'Chit_A1_M11_Kannan_Chit_A1_Auction_6', 'Chit_A1_M11_Kannan_Chit_A1_Auction_6', 'Chit_A1_M11_Kannan_Chit_A1_Auction_6', 'Chit_A1_M11_Kannan', 'Chit_A1_M11_Kannan_Chit_A1_Auction_6', 10362.5, 0, -13740858.17, 'Other', 'adjusted to kannan', 'Malar_Finance', '10362.5'),
('dfafa10c', '2026-08-14', 'Chit_Payment', 'Chit_A1_Auction_6_M1', NULL, NULL, 'Chit_A1_M11_Kannan', NULL, NULL, 10362.5, -1000958.5, 'Other', 'chit adjusted', 'Chit_Malar', NULL),
('194af778', '2026-08-14', 'Chit_Payment', 'Chit_A1_Auction_6_M1', NULL, NULL, 'Chit_A1_M11_Kannan', 'arul chit a ananyaa chit', NULL, 88400, -1089358.5, 'Other', 'arul chit a ananyaa chit', 'Chit_Malar', NULL),
('49bd024a', '2026-08-18', 'Chit_Payment', 'Chit_A1_Auction_6_M1', NULL, NULL, 'Chit_A1_M11_Kannan', 'Ky pradeep upi', NULL, 40000, -1129358.5, 'UPI', 'Ky pradeep', 'Chit_Malar', NULL),
('Chit_A1_M8_Tharun_Chit_A1_Auction_6-1be435db', '2026-08-16', 'Chit_Receipt', 'Chit_A1_M8_Tharun_Chit_A1_Auction_6', 'Chit_A1_M8_Tharun_Chit_A1_Auction_6', 'Chit_A1_M8_Tharun_Chit_A1_Auction_6', 'Chit_A1_M8_Tharun', 'Chit_A1_M8_Tharun_Chit_A1_Auction_6', 4500, 0, -1124858.5, 'Cash', 'Chit amount', 'Chit_Malar', '20725'),
('Chit_A1_M6_Amuthavel_Chit_A1_Auction_6-24238694', '2026-08-12', 'Chit_Receipt', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_6', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_6', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_6', 'Chit_A1_M6_Amuthavel', 'Chit_A1_M6_Amuthavel_Chit_A1_Auction_6', 20725, 0, -1104133.5, 'UPI', NULL, 'Chit_Malar', '20725');
alter table "Transaction_Ledger" enable row level security;
create policy "read_all_Transaction_Ledger" on "Transaction_Ledger" for select using (true);

drop table if exists "Nature_Transaction" cascade;
create table "Nature_Transaction" ("Nature_Transaction" text, "Type" text, "Report" text);
insert into "Nature_Transaction" ("Nature_Transaction", "Type", "Report") values
('Customer_Interest', 'Receipt', 'Interest_IN_Out'),
('Depositer_Interest', 'Payment', 'Interest_IN_Out'),
('Other_Finance_Interest', 'Payment', 'Interest_IN_Out'),
('Other_Receipt', 'Receipt', 'Other'),
('Other_Payment', 'Payment', 'Other'),
('Loan_To_Customer', 'Payment', 'Loan_IN_Out'),
('Deposit_From_Customer', 'Receipt', 'Loan_IN_Out'),
('Deposit_Prin_Refund', 'Payment', 'Loan_IN_Out'),
('Other_Finance_Loan_Refund', 'Payment', 'Loan_IN_Out'),
('Customer_Loan_Prin_Repayment', 'Receipt', 'Loan_IN_Out'),
('Operning_Balance', 'Receipt', 'Other'),
('Chit_Receipt', 'Receipt', 'Chit_IN'),
('Chit_Payment', 'Payment', 'Chit_Out'),
('Old Pending Interest', 'Receipt', 'Other');
alter table "Nature_Transaction" enable row level security;
create policy "read_all_Nature_Transaction" on "Nature_Transaction" for select using (true);

drop table if exists "Deposit_Amount" cascade;
create table "Deposit_Amount" ("Finance_Name" text, "Deposit_Bought_Date" text, "Deposit_No" text, "Depositer_Name" text, "Depositer_Phone_No" numeric, "Depositer_Email" text, "Depositer_Address" text, "Deposit_Amount" numeric, "Interest_Per_Month_Per_Lakh" text, "Repaid_Amount" numeric, "Outstand_Amount" numeric, "Deposit_Status" text, "Payment_Type" text, "Remarks" text, "Interest_Type" text, "Depositer_Type" text, "Depositer_Type_Exists" text);
insert into "Deposit_Amount" ("Finance_Name", "Deposit_Bought_Date", "Deposit_No", "Depositer_Name", "Depositer_Phone_No", "Depositer_Email", "Depositer_Address", "Deposit_Amount", "Interest_Per_Month_Per_Lakh", "Repaid_Amount", "Outstand_Amount", "Deposit_Status", "Payment_Type", "Remarks", "Interest_Type", "Depositer_Type", "Depositer_Type_Exists") values
('Malar_Finance', '2025-06-04', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', 9360633144, NULL, NULL, 200000, NULL, 0, 200000, 'Active', 'Cash', NULL, NULL, NULL, NULL),
('Malar_Finance', '2025-03-01', 'Mal-D-2-Malar_Appa', 'Malar_Appa', 8973440117, NULL, NULL, 100000, NULL, 0, 100000, 'Active', 'Cash', NULL, NULL, NULL, NULL),
('Malar_Finance', '2025-06-01', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', 9360633144, NULL, NULL, 50000, NULL, 0, 50000, 'Active', 'Cash', NULL, NULL, NULL, NULL),
('Malar_Finance', '2025-09-24', 'Mal-D-4-test', 'test', NULL, NULL, NULL, 100, NULL, 0, 100, 'Active', 'Cash', NULL, NULL, 'New', NULL),
('Malar_Finance', '2026-03-05', 'Mal-D-5-malar_appa1', 'malar_appa1', 8973440117, NULL, NULL, 100000, NULL, 0, 100000, 'Active', 'Cash', NULL, NULL, 'New', NULL),
('Malar_Finance', '2026-04-08', 'Mal-D-6-Gokila_Akka', 'Gokila_Akka', 9360633144, NULL, NULL, 100000, NULL, 0, 100000, 'Active', 'Cash', NULL, NULL, 'Existing', NULL),
('Chit_Malar', '2026-04-16', 'Chi-D-7-Deepak', 'Deepak', NULL, NULL, NULL, 60000, NULL, 0, 60000, 'Active', 'Cash', NULL, NULL, 'New', NULL),
('Chit_Malar', '2026-05-20', 'Chi-D-8-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, NULL, 150000, NULL, 100000, 50000, 'Active', 'Cash', NULL, NULL, 'New', NULL),
('Chit_Malar', '2026-05-25', 'Chi-D-9-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, NULL, 600000, NULL, 0, 600000, 'Active', 'Cash', NULL, NULL, 'Existing', NULL),
('Chit_Malar', '2026-05-28', 'Chi-D-10-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, NULL, 500000, NULL, 0, 500000, 'Active', 'Other', NULL, NULL, 'Existing', NULL),
('Chit_Malar', '2026-07-02', 'Chi-D-11-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, NULL, 100000, NULL, 0, 100000, 'Active', 'Cash', 'Land advance back given to baskar finance', 'Per_Month', 'Existing', NULL),
('Chit_Malar', '2026-07-01', 'Chi-D-12-Gokila akka', 'Gokila akka', 9626262457, NULL, NULL, 300000, NULL, 0, 300000, 'Active', 'Cash', 'By appa on 16.07.26', 'Per_Month', 'New', NULL),
('Chit_Malar', '2026-07-18', 'Chi-D-13-Malar amma', 'Malar amma', 8973440117, NULL, NULL, 300000, NULL, 0, 300000, 'Active', 'Cash', NULL, 'Per_Month', 'New', NULL);
alter table "Deposit_Amount" enable row level security;
create policy "read_all_Deposit_Amount" on "Deposit_Amount" for select using (true);

drop table if exists "Depositer_Interest" cascade;
create table "Depositer_Interest" ("ID" text, "Finance_Name" text, "Deposit_No" text, "Depositer_Name" text, "Depositer_Phone_No" text, "Depositer_Email" text, "From_Date" text, "To_Date" text, "Actual_From_Date" text, "No_Days" numeric, "Interest_Per_Month_Per_Lakh" text, "Interest_Amount" numeric, "Deposit_Amount" text, "Deposit_Given_Date" text, "Month" text, "Description" text, "Amount_Received" numeric, "Status" text, "Interest_Pending" numeric, "Interest_Type" text, "Total_Month_Days" text);
insert into "Depositer_Interest" ("ID", "Finance_Name", "Deposit_No", "Depositer_Name", "Depositer_Phone_No", "Depositer_Email", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_Month_Per_Lakh", "Interest_Amount", "Deposit_Amount", "Deposit_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Interest_Type", "Total_Month_Days") values
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2025', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', NULL, NULL, '2025-05-01', '2025-05-31', '2025-05-01', 1, NULL, 1000, '100000', '2025-03-01', '05-2025', 'Depositer-Interest-05-2025', 1000, 'Paid', 0, NULL, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2025', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', NULL, NULL, '2025-06-01', '2025-06-30', '2025-06-04', 0.9, '2025-07-02', 1800, '200000', '2025-06-04', '06-2025', 'Depositer-Interest-06-2025', 1800, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2025', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', NULL, NULL, '2025-06-01', '2025-06-30', '2025-06-01', 1, '2025-07-02', 1000, '100000', '2025-03-01', '06-2025', 'Depositer-Interest-06-2025', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-06-2025', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', NULL, NULL, '2025-06-01', '2025-06-30', '2025-06-01', 1, '2025-07-02', 500, '50000', '2025-06-01', '06-2025', 'Depositer-Interest-06-2025', 0, 'Pending', 500, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2025', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', NULL, NULL, '2025-04-01', '2025-04-30', '2025-04-01', 1, '2025-07-02', 1000, '100000', '2025-03-01', '04-2025', 'Depositer-Interest-04-2025', 1000, 'Paid', 0, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-07-2025', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', NULL, NULL, '2025-07-01', '2025-07-31', '2025-07-01', 1, '2025-08-12', 2000, '200000', '2025-06-04', '07-2025', 'Depositer-Interest-07-2025', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2025', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', NULL, NULL, '2025-07-01', '2025-07-31', '2025-07-01', 1, '2025-08-12', 1000, '100000', '2025-03-01', '07-2025', 'Depositer-Interest-07-2025', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-07-2025', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', NULL, NULL, '2025-07-01', '2025-07-31', '2025-07-01', 1, '2025-08-12', 500, '50000', '2025-06-01', '07-2025', 'Depositer-Interest-07-2025', 0, 'Pending', 500, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-08-2025', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', NULL, NULL, '2025-08-01', '2025-08-31', '2025-08-01', 1, '2025-08-30', 2000, '200000', '2025-06-04', '08-2025', 'Depositer-Interest-08-2025', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-08-2025', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', NULL, NULL, '2025-08-01', '2025-08-31', '2025-08-01', 1, '2025-08-30', 1000, '100000', '2025-03-01', '08-2025', 'Depositer-Interest-08-2025', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-08-2025', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', NULL, NULL, '2025-08-01', '2025-08-31', '2025-08-01', 1, '2025-08-30', 500, '50000', '2025-06-01', '08-2025', 'Depositer-Interest-08-2025', 0, 'Pending', 500, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-09-2025', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2025-09-01', '2025-09-30', '2025-09-01', 1, '2025-10-05', 2000, '200000', '2025-06-04', '09-2025', 'Depositer-Interest-09-2025', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-09-2025', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2025-09-01', '2025-09-30', '2025-09-01', 1, '2025-10-05', 1000, '100000', '2025-03-01', '09-2025', 'Depositer-Interest-09-2025', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-09-2025', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2025-09-01', '2025-09-30', '2025-09-01', 1, '2025-10-05', 500, '50000', '2025-06-01', '09-2025', 'Depositer-Interest-09-2025', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-09-2025', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2025-09-01', '2025-09-30', '2025-09-24', 0.23333333333333334, '2025-10-05', 0.23333333333333336, '100', '2025-09-24', '09-2025', 'Depositer-Interest-09-2025', 0, 'Pending', 0.2333333333, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-10-2025', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2025-10-01', '2025-10-31', '2025-10-01', 1, '2025-11-10', 2000, '200000', '2025-06-04', '10-2025', 'Depositer-Interest-10-2025', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-10-2025', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2025-10-01', '2025-10-31', '2025-10-01', 1, '2025-11-10', 1000, '100000', '2025-03-01', '10-2025', 'Depositer-Interest-10-2025', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-10-2025', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2025-10-01', '2025-10-31', '2025-10-01', 1, '2025-11-10', 500, '50000', '2025-06-01', '10-2025', 'Depositer-Interest-10-2025', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-10-2025', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2025-10-01', '2025-10-31', '2025-10-01', 1, '2025-11-10', 1, '100', '2025-09-24', '10-2025', 'Depositer-Interest-10-2025', 0, 'Pending', 1, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-11-2025', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2025-11-01', '2025-11-30', '2025-11-01', 1, '2025-12-07', 2000, '200000', '2025-06-04', '11-2025', 'Depositer-Interest-11-2025', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-11-2025', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2025-11-01', '2025-11-30', '2025-11-01', 1, '2025-12-07', 1000, '100000', '2025-03-01', '11-2025', 'Depositer-Interest-11-2025', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-11-2025', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2025-11-01', '2025-11-30', '2025-11-01', 1, '2025-12-07', 500, '50000', '2025-06-01', '11-2025', 'Depositer-Interest-11-2025', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-11-2025', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2025-11-01', '2025-11-30', '2025-11-01', 1, '2025-12-07', 1, '100', '2025-09-24', '11-2025', 'Depositer-Interest-11-2025', 0, 'Pending', 1, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-12-2025', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2025-12-01', '2025-12-31', '2025-12-01', 1, '2026-01-19', 2000, '200000', '2025-06-04', '12-2025', 'Depositer-Interest-12-2025', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-12-2025', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2025-12-01', '2025-12-31', '2025-12-01', 1, '2026-01-19', 1000, '100000', '2025-03-01', '12-2025', 'Depositer-Interest-12-2025', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-12-2025', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2025-12-01', '2025-12-31', '2025-12-01', 1, '2026-01-19', 500, '50000', '2025-06-01', '12-2025', 'Depositer-Interest-12-2025', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-12-2025', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2025-12-01', '2025-12-31', '2025-12-01', 1, '2026-01-19', 1, '100', '2025-09-24', '12-2025', 'Depositer-Interest-12-2025', 0, 'Pending', 1, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-01-2026', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-01-01', '2026-01-31', '2026-01-01', 1, '2026-03-02', 2000, '200000', '2025-06-04', '01-2026', 'Depositer-Interest-01-2026', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-01-2026', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2026-01-01', '2026-01-31', '2026-01-01', 1, '2026-03-02', 1000, '100000', '2025-03-01', '01-2026', 'Depositer-Interest-01-2026', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-01-2026', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2026-01-01', '2026-01-31', '2026-01-01', 1, '2026-03-02', 500, '50000', '2025-06-01', '01-2026', 'Depositer-Interest-01-2026', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-01-2026', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2026-01-01', '2026-01-31', '2026-01-01', 1, '2026-03-02', 1, '100', '2025-09-24', '01-2026', 'Depositer-Interest-01-2026', 0, 'Pending', 1, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-02-2026', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-02-01', '2026-02-28', '2026-02-01', 1, '2026-03-02', 2000, '200000', '2025-06-04', '02-2026', 'Depositer-Interest-02-2026', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-02-2026', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2026-02-01', '2026-02-28', '2026-02-01', 1, '2026-03-02', 1000, '100000', '2025-03-01', '02-2026', 'Depositer-Interest-02-2026', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-02-2026', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2026-02-01', '2026-02-28', '2026-02-01', 1, '2026-03-02', 500, '50000', '2025-06-01', '02-2026', 'Depositer-Interest-02-2026', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-02-2026', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2026-02-01', '2026-02-28', '2026-02-01', 1, '2026-03-02', 1, '100', '2025-09-24', '02-2026', 'Depositer-Interest-02-2026', 0, 'Pending', 1, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-03-2026', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-03-01', '2026-03-31', '2026-03-01', 1, '2026-03-25', 2000, '200000', '2025-06-04', '03-2026', 'Depositer-Interest-03-2026', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-03-2026', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2026-03-01', '2026-03-31', '2026-03-01', 1, '2026-03-25', 1000, '100000', '2025-03-01', '03-2026', 'Depositer-Interest-03-2026', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-03-2026', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2026-03-01', '2026-03-31', '2026-03-01', 1, '2026-03-25', 500, '50000', '2025-06-01', '03-2026', 'Depositer-Interest-03-2026', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-03-2026', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2026-03-01', '2026-03-31', '2026-03-01', 1, '2026-03-25', 1, '100', '2025-09-24', '03-2026', 'Depositer-Interest-03-2026', 0, 'Pending', 1, 0, NULL),
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-03-2026', 'Malar_Finance', 'Mal-D-5-malar_appa1', 'malar_appa1', '8973440117', NULL, '2026-03-01', '2026-03-31', '2026-03-05', 0.9, '2026-03-25', 900, '100000', '2026-03-05', '03-2026', 'Depositer-Interest-03-2026', 900, 'Paid', 0, 0, NULL),
('085bfecc', 'Malar_Finance', 'Mal-D-1-Gokila_Akka , Mal-D-2-Malar_Appa , Mal-D-3-Ravi_Mama , Mal-D-4-test , Mal-D-5-malar_appa1', 'Gokila_Akka , Malar_Appa , Ravi_Mama , test , malar_appa1', '9360633144 , 8973440117 , 9360633144 ,  , 8973440117', ' ,  ,  ,  , ', '2026-03-01', '2026-03-31', '2026-03-27', NULL, '2026-03-27', NULL, '200000 , 100000 , 50000 , 100 , 100000', '06/04/2025 00:00:00 , 03/01/2025 00:00:00 , 06/01/2025 00:00:00 , 09/24/2025 00:00:00 , 03/05/2026 00:00:00', NULL, NULL, 0, 'Paid', 0, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-04-2026', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-04-01', '2026-04-30', '2026-04-01', 1, '2026-05-02', 2000, '200000', '2025-06-04', '04-2026', 'Depositer-Interest-04-2026', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-04-2026', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2026-04-01', '2026-04-30', '2026-04-01', 1, '2026-05-02', 1000, '100000', '2025-03-01', '04-2026', 'Depositer-Interest-04-2026', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-04-2026', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2026-04-01', '2026-04-30', '2026-04-01', 1, '2026-05-02', 500, '50000', '2025-06-01', '04-2026', 'Depositer-Interest-04-2026', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-04-2026', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2026-04-01', '2026-04-30', '2026-04-01', 1, '2026-05-02', 1, '100', '2025-09-24', '04-2026', 'Depositer-Interest-04-2026', 0, 'Pending', 1, 0, NULL),
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-04-2026', 'Malar_Finance', 'Mal-D-5-malar_appa1', 'malar_appa1', '8973440117', NULL, '2026-04-01', '2026-04-30', '2026-04-01', 1, '2026-05-02', 1000, '100000', '2026-03-05', '04-2026', 'Depositer-Interest-04-2026', 1000, 'Paid', 0, 0, NULL),
('Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-04-2026', 'Malar_Finance', 'Mal-D-6-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-04-01', '2026-04-30', '2026-04-08', 0.7666666666666667, '2026-05-02', 766.6666666666667, '100000', '2026-04-08', '04-2026', 'Depositer-Interest-04-2026', 766.6666667, 'Pending', -3.332161214e-10, 0, NULL),
('Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-04-2026', 'Chit_Malar', 'Chi-D-7-Deepak', 'Deepak', NULL, NULL, '2026-04-01', '2026-04-30', '2026-04-16', 0.5, '2026-05-02', 375, '60000', '2026-04-16', '04-2026', 'Depositer-Interest-04-2026', 375, 'Paid', 0, 0, NULL),
('Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-05-2026', 'Chit_Malar', 'Chi-D-7-Deepak', 'Deepak', NULL, NULL, '2026-05-01', '2026-05-31', '2026-05-01', 1, '2026-05-31', 750, '60000', '2026-04-16', '05-2026', 'Depositer-Interest-05-2026', 750, 'Paid', 0, 0, NULL),
('Nagaraj Post Office-Chi-D-8-Nagaraj Post Office-150000-Depositer-Interest-05-2026', 'Chit_Malar', 'Chi-D-8-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-05-01', '2026-05-31', '2026-05-20', 0.4, '2026-05-31', 750, '150000', '2026-05-20', '05-2026', 'Depositer-Interest-05-2026', 750, 'Paid', 0, 0, NULL),
('Nagaraj Post Office-Chi-D-9-Nagaraj Post Office-600000-Depositer-Interest-05-2026', 'Chit_Malar', 'Chi-D-9-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-05-01', '2026-05-31', '2026-05-25', 0.23333333333333334, '2026-05-31', 1750, '600000', '2026-05-25', '05-2026', 'Depositer-Interest-05-2026', 1750, 'Paid', 0, 0, NULL),
('Nagaraj Post Office-Chi-D-10-Nagaraj Post Office-500000-Depositer-Interest-05-2026', 'Chit_Malar', 'Chi-D-10-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-05-01', '2026-05-31', '2026-05-28', 0.13333333333333333, '2026-05-31', 833, '500000', '2026-05-28', '05-2026', 'Depositer-Interest-05-2026', 833, 'Paid', 0, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-05-2026', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-05-01', '2026-05-31', '2026-05-01', 1, '2026-05-31', 2000, '200000', '2025-06-04', '05-2026', 'Depositer-Interest-05-2026', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-05-2026', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2026-05-01', '2026-05-31', '2026-05-01', 1, '2026-05-31', 1000, '100000', '2025-03-01', '05-2026', 'Depositer-Interest-05-2026', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-05-2026', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2026-05-01', '2026-05-31', '2026-05-01', 1, '2026-05-31', 500, '50000', '2025-06-01', '05-2026', 'Depositer-Interest-05-2026', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-05-2026', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2026-05-01', '2026-05-31', '2026-05-01', 1, '2026-05-31', 1, '100', '2025-09-24', '05-2026', 'Depositer-Interest-05-2026', 0, 'Pending', 1, 0, NULL),
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-05-2026', 'Malar_Finance', 'Mal-D-5-malar_appa1', 'malar_appa1', '8973440117', NULL, '2026-05-01', '2026-05-31', '2026-05-01', 1, '2026-05-31', 1000, '100000', '2026-03-05', '05-2026', 'Depositer-Interest-05-2026', 1000, 'Paid', 0, 0, NULL),
('Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-05-2026', 'Malar_Finance', 'Mal-D-6-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-05-01', '2026-05-31', '2026-05-01', 1, '2026-05-31', 1000, '100000', '2026-04-08', '05-2026', 'Depositer-Interest-05-2026', 1000, 'Paid', 0, 0, NULL),
('Nagaraj Post Office-Chi-D-8-Nagaraj Post Office-100000-Deposit_Principle_Refund-Interest-06-2026', 'Chit_Malar', 'Chi-D-8-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-06-01', '2026-06-24', '2026-06-01', 0.8, '2026-06-24', 1000, '100000', '2026-05-20', '06-2026', 'Deposit_Principle_Refund-Interest-06-2026', 0, 'Pending', 1000, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-06-2026', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 2000, '200000', '2025-06-04', '06-2026', 'Depositer-Interest-06-2026', 2000, 'Paid', 0, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-06-2026', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 1000, '100000', '2025-03-01', '06-2026', 'Depositer-Interest-06-2026', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-06-2026', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 500, '50000', '2025-06-01', '06-2026', 'Depositer-Interest-06-2026', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-06-2026', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 1, '100', '2025-09-24', '06-2026', 'Depositer-Interest-06-2026', 0, 'Pending', 1, 0, NULL),
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-06-2026', 'Malar_Finance', 'Mal-D-5-malar_appa1', 'malar_appa1', '8973440117', NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 1000, '100000', '2026-03-05', '06-2026', 'Depositer-Interest-06-2026', 1000, 'Paid', 0, 0, NULL),
('Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-06-2026', 'Malar_Finance', 'Mal-D-6-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 1000, '100000', '2026-04-08', '06-2026', 'Depositer-Interest-06-2026', 1000, 'Paid', 0, 0, NULL),
('Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-06-2026', 'Chit_Malar', 'Chi-D-7-Deepak', 'Deepak', NULL, NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 750, '60000', '2026-04-16', '06-2026', 'Depositer-Interest-06-2026', 750, 'Paid', 0, 0, NULL),
('Nagaraj Post Office-Chi-D-8-Nagaraj Post Office-50000-Depositer-Interest-06-2026', 'Chit_Malar', 'Chi-D-8-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 625, '50000', '2026-05-20', '06-2026', 'Depositer-Interest-06-2026', 0, 'Pending', 625, 0, NULL),
('Nagaraj Post Office-Chi-D-9-Nagaraj Post Office-600000-Depositer-Interest-06-2026', 'Chit_Malar', 'Chi-D-9-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 7500, '600000', '2026-05-25', '06-2026', 'Depositer-Interest-06-2026', 0, 'Pending', 7500, 0, NULL),
('Nagaraj Post Office-Chi-D-10-Nagaraj Post Office-500000-Depositer-Interest-06-2026', 'Chit_Malar', 'Chi-D-10-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-06-01', '2026-06-30', '2026-06-01', 1, '2026-06-29', 6250, '500000', '2026-05-28', '06-2026', 'Depositer-Interest-06-2026', 0, 'Pending', 6250, 0, NULL),
('Gokila_Akka-Mal-D-1-Gokila_Akka-200000-Depositer-Interest-07-2026', 'Malar_Finance', 'Mal-D-1-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 2000, '200000', '2025-06-04', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 2000, 0, NULL),
('Malar_Appa-Mal-D-2-Malar_Appa-100000-Depositer-Interest-07-2026', 'Malar_Finance', 'Mal-D-2-Malar_Appa', 'Malar_Appa', '8973440117', NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 1000, '100000', '2025-03-01', '07-2026', 'Depositer-Interest-07-2026', 1000, 'Paid', 0, 0, NULL),
('Ravi_Mama-Mal-D-3-Ravi_Mama-50000-Depositer-Interest-07-2026', 'Malar_Finance', 'Mal-D-3-Ravi_Mama', 'Ravi_Mama', '9360633144', NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 500, '50000', '2025-06-01', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 500, 0, NULL),
('test-Mal-D-4-test-100-Depositer-Interest-07-2026', 'Malar_Finance', 'Mal-D-4-test', 'test', NULL, NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 1, '100', '2025-09-24', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 1, 0, NULL),
('malar_appa1-Mal-D-5-malar_appa1-100000-Depositer-Interest-07-2026', 'Malar_Finance', 'Mal-D-5-malar_appa1', 'malar_appa1', '8973440117', NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 1000, '100000', '2026-03-05', '07-2026', 'Depositer-Interest-07-2026', 1000, 'Paid', 0, 0, NULL),
('Gokila_Akka-Mal-D-6-Gokila_Akka-100000-Depositer-Interest-07-2026', 'Malar_Finance', 'Mal-D-6-Gokila_Akka', 'Gokila_Akka', '9360633144', NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 1000, '100000', '2026-04-08', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 1000, 0, NULL),
('Deepak-Chi-D-7-Deepak-60000-Depositer-Interest-07-2026', 'Chit_Malar', 'Chi-D-7-Deepak', 'Deepak', NULL, NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 750, '60000', '2026-04-16', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 750, 0, NULL),
('Nagaraj Post Office-Chi-D-8-Nagaraj Post Office-50000-Depositer-Interest-07-2026', 'Chit_Malar', 'Chi-D-8-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 625, '50000', '2026-05-20', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 625, 0, NULL),
('Nagaraj Post Office-Chi-D-9-Nagaraj Post Office-600000-Depositer-Interest-07-2026', 'Chit_Malar', 'Chi-D-9-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 7500, '600000', '2026-05-25', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 7500, 0, NULL),
('Nagaraj Post Office-Chi-D-10-Nagaraj Post Office-500000-Depositer-Interest-07-2026', 'Chit_Malar', 'Chi-D-10-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 6250, '500000', '2026-05-28', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 6250, 0, NULL),
('Nagaraj Post Office-Chi-D-11-Nagaraj Post Office-100000-Depositer-Interest-07-2026', 'Chit_Malar', 'Chi-D-11-Nagaraj Post Office', 'Nagaraj Post Office', NULL, NULL, '2026-07-01', '2026-07-31', '2026-07-02', 1, '2026-07-31', 1250, '100000', '2026-07-02', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 1250, 0, NULL),
('Gokila akka-Chi-D-12-Gokila akka-300000-Depositer-Interest-07-2026', 'Chit_Malar', 'Chi-D-12-Gokila akka', 'Gokila akka', '9626262457', NULL, '2026-07-01', '2026-07-31', '2026-07-01', 1, '2026-07-31', 3000, '300000', '2026-07-01', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 3000, 0, NULL),
('Malar amma-Chi-D-13-Malar amma-300000-Depositer-Interest-07-2026', 'Chit_Malar', 'Chi-D-13-Malar amma', 'Malar amma', '8973440117', NULL, '2026-07-01', '2026-07-31', '2026-07-18', 0.4666666666666667, '2026-07-31', 1400, '300000', '2026-07-18', '07-2026', 'Depositer-Interest-07-2026', 0, 'Pending', 1400, 0, NULL);
alter table "Depositer_Interest" enable row level security;
create policy "read_all_Depositer_Interest" on "Depositer_Interest" for select using (true);

drop table if exists "Jewel_Loan" cascade;
create table "Jewel_Loan" ("id" text);
alter table "Jewel_Loan" enable row level security;
create policy "read_all_Jewel_Loan" on "Jewel_Loan" for select using (true);

drop table if exists "Invested_Chit" cascade;
create table "Invested_Chit" ("Chit_ID" text, "Chit_Invested_By" text, "Chit_Invested_Company" text, "Chit_Invested_Company_Address" text, "Total_Amount_Chit" numeric, "No_Months" numeric, "Chit_Started_Date" text, "No_Months_Completed" numeric, "Total_Amount_Invested_Till_Now" numeric, "Chit_Status" text, "Chit_Taken" text, "Chit_Name" text);
insert into "Invested_Chit" ("Chit_ID", "Chit_Invested_By", "Chit_Invested_Company", "Chit_Invested_Company_Address", "Total_Amount_Chit", "No_Months", "Chit_Started_Date", "No_Months_Completed", "Total_Amount_Invested_Till_Now", "Chit_Status", "Chit_Taken", "Chit_Name") values
('Malar-Malar_Chit-250000-A_Chit', 'Malar', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 6, 63127.5, 'Active', 'No', 'A_Chit'),
('Arul-Malar_Chit-250000-A_Chit', 'Arul', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 6, 63132.5, 'Active', 'No', 'A_Chit'),
('Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 20, 89689, 'Completed', 'Yes', 'C1_Chit'),
('Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 15, 65370, 'Active', 'Yes', 'A1_Chit'),
('Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 15, 65370, 'Active', 'No', 'A1_Chit'),
('Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 9, 38120, 'Active', 'No', 'B1_Chit'),
('Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 12, 51530, 'Active', 'No', 'D1_Chit'),
('Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 20, 446350, 'Completed', 'Yes', 'Ram1'),
('Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 20, 446350, 'Completed', 'Yes', 'Ram1'),
('Arul-Ramkumar-500000-Ram2_1', 'Arul', 'Ramkumar', 'ramkumar finance', 500000, 20, '2026-07-10', 2, 25000, 'Active', 'No', 'Ram2_1'),
('Arul-Ramkumar-250000-Ram2_2', 'Arul', 'Ramkumar', 'ramkumar finance', 250000, 20, '2026-07-10', 2, 12500, 'Active', 'No', 'Ram2_2'),
('Malar-Ramkumar-500000-Ram2_1', 'Malar', 'Ramkumar', 'Ramkumar_Finance', 500000, 20, '2026-07-10', 2, 25000, 'Active', 'No', 'Ram2_1'),
('Malar-Ramkumar-250000-Ram2_2', 'Malar', 'Ramkumar', 'Ramkumar Finance', 250000, 20, '2026-07-10', 2, 12500, 'Active', 'No', 'Ram2_2');
alter table "Invested_Chit" enable row level security;
create policy "read_all_Invested_Chit" on "Invested_Chit" for select using (true);

drop table if exists "Invested_Chit_Trans" cascade;
create table "Invested_Chit_Trans" ("ID" text, "Chit_ID" text, "Chit_Invested_By" text, "Chit_Invested_Company" text, "Chit_Invested_Company_Address" text, "Total_Amount_Chit" numeric, "No_Months" numeric, "Chit_Started_Date" text, "Month_Count" numeric, "Chit_This_Month_Amount" numeric, "Date" text, "Month_Year" text, "Chit_Taken" text, "Chit_Name" text, "Paid_Date" text, "Remarks" text, "Chit_Status" text);
insert into "Invested_Chit_Trans" ("ID", "Chit_ID", "Chit_Invested_By", "Chit_Invested_Company", "Chit_Invested_Company_Address", "Total_Amount_Chit", "No_Months", "Chit_Started_Date", "Month_Count", "Chit_This_Month_Amount", "Date", "Month_Year", "Chit_Taken", "Chit_Name", "Paid_Date", "Remarks", "Chit_Status") values
('Arul-Ramkumar_Chit-500000-Ram1-20241101-1', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 1, 25000, '2024-11-01', 'Nov-2024', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-20241101-1', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 1, 25000, '2024-11-01', 'Nov-2024', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Ramkumar_Chit-500000-Ram1-20241201-2', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 2, 19400, '2024-12-01', 'Dec-2024', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-20241201-2', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 2, 19400, '2024-12-01', 'Dec-2024', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Jan-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 1, 5000, '2025-01-01', 'Jan-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Jan-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 3, 19900, '2025-01-01', 'Jan-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Jan-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 3, 19900, '2025-01-01', 'Jan-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Feb-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 2, 4000, '2025-02-01', 'Feb-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Feb-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 4, 20200, '2025-02-01', 'Feb-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Feb-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 4, 20200, '2025-02-01', 'Feb-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Mar-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 3, 4010, '2025-03-01', 'Mar-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Mar-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 5, 20275, '2025-03-01', 'Mar-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Mar-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 5, 20275, '2025-03-01', 'Mar-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Apr-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 4, 4080, '2025-04-01', 'Apr-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Apr-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 6, 20600, '2025-04-01', 'Apr-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Apr-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 6, 20600, '2025-04-01', 'Apr-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-May-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 5, 4130, '2025-05-01', 'May-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-May-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 7, 20900, '2025-05-01', 'May-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-May-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 7, 20900, '2025-05-01', 'May-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Jun-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 6, 4180, '2025-06-01', 'Jun-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Jun-2025', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 1, 5000, '2025-06-01', 'Jun-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Jun-2025', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 1, 5000, '2025-06-01', 'Jun-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Jun-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 8, 21275, '2025-06-01', 'Jun-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Jun-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 8, 21275, '2025-06-01', 'Jun-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Jul-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 7, 4220, '2025-07-01', 'Jul-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Jul-2025', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 2, 3990, '2025-07-01', 'Jul-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Jul-2025', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 2, 3990, '2025-07-01', 'Jul-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Jul-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 9, 21550, '2025-07-01', 'Jul-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Jul-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 9, 21550, '2025-07-01', 'Jul-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Aug-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 8, 4280, '2025-08-01', 'Aug-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Aug-2025', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 3, 4040, '2025-08-01', 'Aug-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Aug-2025', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 3, 4040, '2025-08-01', 'Aug-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Aug-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 10, 21825, '2025-08-01', 'Aug-2025', 'True', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Aug-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 10, 21825, '2025-08-01', 'Aug-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Sep-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 9, 4300, '2025-09-01', 'Sep-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Sep-2025', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 4, 4080, '2025-09-01', 'Sep-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Sep-2025', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 4, 4080, '2025-09-01', 'Sep-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Sep-2025', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 1, 5000, '2025-09-01', 'Sep-2025', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Sep-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 11, 22100, '2025-09-01', 'Sep-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Sep-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 11, 22100, '2025-09-01', 'Sep-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Oct-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 10, 4380, '2025-10-01', 'Oct-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Oct-2025', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 5, 4130, '2025-10-01', 'Oct-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Oct-2025', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 5, 4130, '2025-10-01', 'Oct-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Oct-2025', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 2, 3990, '2025-10-01', 'Oct-2025', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Oct-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 12, 22450, '2025-10-01', 'Oct-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Oct-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 12, 22450, '2025-10-01', 'Oct-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Nov-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 11, 4440, '2025-11-01', 'Nov-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Nov-2025', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 6, 4180, '2025-11-01', 'Nov-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Nov-2025', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 6, 4180, '2025-11-01', 'Nov-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Nov-2025', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 3, 4030, '2025-11-01', 'Nov-2025', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Nov-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 13, 22775, '2025-11-01', 'Nov-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Nov-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 13, 22775, '2025-11-01', 'Nov-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Dec-2025', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 12, 4500, '2025-12-01', 'Dec-2025', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Dec-2025', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 7, 4230, '2025-12-01', 'Dec-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Dec-2025', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 7, 4230, '2025-12-01', 'Dec-2025', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-B1_Chit-Dec-2025', 'Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 1, 5000, '2025-12-01', 'Dec-2025', 'No', 'B1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Dec-2025', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 4, 4080, '2025-12-01', 'Dec-2025', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Dec-2025', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 14, 23050, '2025-12-01', 'Dec-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Dec-2025', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 14, 23050, '2025-12-01', 'Dec-2025', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Jan-2026', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 13, 4550, '2026-01-01', 'Jan-2026', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Jan-2026', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 8, 4280, '2026-01-01', 'Jan-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Jan-2026', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 8, 4280, '2026-01-01', 'Jan-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-B1_Chit-Jan-2026', 'Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 2, 3990, '2026-01-01', 'Jan-2026', 'No', 'B1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Jan-2026', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 5, 4130, '2026-01-01', 'Jan-2026', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Jan-2026', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 15, 23350, '2026-01-01', 'Jan-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Jan-2026', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 15, 23350, '2026-01-01', 'Jan-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Arul-Kannan_Fin-100000-C1_Chit-Feb-2026', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 14, 4600, '2026-02-01', 'Feb-2026', 'True', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Feb-2026', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 9, 4330, '2026-02-01', 'Feb-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Feb-2026', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 9, 4330, '2026-02-01', 'Feb-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-B1_Chit-Feb-2026', 'Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 3, 4030, '2026-02-01', 'Feb-2026', 'No', 'B1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Feb-2026', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 6, 4180, '2026-02-01', 'Feb-2026', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Feb-2026', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 16, 23675, '2026-02-01', 'Feb-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Feb-2026', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 16, 23675, '2026-02-01', 'Feb-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Malar_Chit-250000-A_Chit-Mar-2026', 'Malar-Malar_Chit-250000-A_Chit', 'Malar', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 1, 12500, '2026-03-01', 'Mar-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Malar_Chit-250000-A_Chit-Mar-2026', 'Arul-Malar_Chit-250000-A_Chit', 'Arul', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 1, 12500, '2026-03-01', 'Mar-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-C1_Chit-Mar-2026', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 15, 4670, '2026-03-01', 'Mar-2026', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Mar-2026', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 10, 4380, '2026-03-01', 'Mar-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Mar-2026', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 10, 4380, '2026-03-01', 'Mar-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-B1_Chit-Mar-2026', 'Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 4, 4080, '2026-03-01', 'Mar-2026', 'No', 'B1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Mar-2026', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 7, 4220, '2026-03-01', 'Mar-2026', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Mar-2026', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 17, 24000, '2026-03-01', 'Mar-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Mar-2026', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 17, 24000, '2026-03-01', 'Mar-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Malar_Chit-250000-A_Chit-Apr-2026', 'Malar-Malar_Chit-250000-A_Chit', 'Malar', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 2, 9925, '2026-04-01', 'Apr-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Malar_Chit-250000-A_Chit-Apr-2026', 'Arul-Malar_Chit-250000-A_Chit', 'Arul', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 2, 9925, '2026-04-01', 'Apr-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-C1_Chit-Apr-2026', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 16, 4730, '2026-04-01', 'Apr-2026', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Apr-2026', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 11, 4430, '2026-04-01', 'Apr-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Apr-2026', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 11, 4430, '2026-04-01', 'Apr-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-B1_Chit-Apr-2026', 'Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 5, 4130, '2026-04-01', 'Apr-2026', 'No', 'B1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Apr-2026', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 8, 4280, '2026-04-01', 'Apr-2026', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Apr-2026', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 18, 24350, '2026-04-01', 'Apr-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Apr-2026', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 18, 24350, '2026-04-01', 'Apr-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Malar_Chit-250000-A_Chit-May-2026', 'Malar-Malar_Chit-250000-A_Chit', 'Malar', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 3, 9990, '2026-05-01', 'May-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Malar_Chit-250000-A_Chit-May-2026', 'Arul-Malar_Chit-250000-A_Chit', 'Arul', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 3, 9995, '2026-05-01', 'May-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-C1_Chit-May-2026', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 17, 4800, '2026-05-01', 'May-2026', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-May-2026', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 12, 4490, '2026-05-01', 'May-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-May-2026', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 12, 4490, '2026-05-01', 'May-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-B1_Chit-May-2026', 'Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 6, 4060, '2026-05-01', 'May-2026', 'No', 'B1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-May-2026', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 9, 4340, '2026-05-01', 'May-2026', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-May-2026', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 19, 24675, '2026-05-01', 'May-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-May-2026', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 19, 24675, '2026-05-01', 'May-2026', 'No', 'Ram1', NULL, NULL, 'Completed');
insert into "Invested_Chit_Trans" ("ID", "Chit_ID", "Chit_Invested_By", "Chit_Invested_Company", "Chit_Invested_Company_Address", "Total_Amount_Chit", "No_Months", "Chit_Started_Date", "Month_Count", "Chit_This_Month_Amount", "Date", "Month_Year", "Chit_Taken", "Chit_Name", "Paid_Date", "Remarks", "Chit_Status") values
('Malar-Malar_Chit-250000-A_Chit-Jun-2026', 'Malar-Malar_Chit-250000-A_Chit', 'Malar', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 4, 10100, '2026-06-01', 'Jun-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Malar_Chit-250000-A_Chit-Jun-2026', 'Arul-Malar_Chit-250000-A_Chit', 'Arul', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 4, 10100, '2026-06-01', 'Jun-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-C1_Chit-Jun-2026', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 18, 4880, '2026-06-01', 'Jun-2026', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Jun-2026', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 13, 4530, '2026-06-01', 'Jun-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Jun-2026', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 13, 4530, '2026-06-01', 'Jun-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-B1_Chit-Jun-2026', 'Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 7, 4200, '2026-06-01', 'Jun-2026', 'No', 'B1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Jun-2026', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 10, 4350, '2026-06-01', 'Jun-2026', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar_Chit-500000-Ram1-Jun-2026', 'Arul-Ramkumar_Chit-500000-Ram1', 'Arul', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 20, 25000, '2026-06-01', 'Jun-2026', 'No', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Ramkumar_Chit-500000-Ram1-Jun-2026', 'Malar-Ramkumar_Chit-500000-Ram1', 'Malar', 'Ramkumar_Chit', 'Ramkumar Finance', 500000, 20, '2024-11-01', 20, 25000, '2026-06-01', 'Jun-2026', 'True', 'Ram1', NULL, NULL, 'Completed'),
('Malar-Malar_Chit-250000-A_Chit-Jul-2026', 'Malar-Malar_Chit-250000-A_Chit', 'Malar', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 5, 10250, '2026-07-10', 'Jul-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Malar_Chit-250000-A_Chit-Jul-2026', 'Arul-Malar_Chit-250000-A_Chit', 'Arul', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 5, 10250, '2026-07-10', 'Jul-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-C1_Chit-Jul-2026', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 19, 4939, '2026-07-10', 'Jul-2026', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Jul-2026', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 14, 4610, '2026-07-10', 'Jul-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Jul-2026', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 14, 4610, '2026-07-10', 'Jul-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-B1_Chit-Jul-2026', 'Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 8, 4300, '2026-07-10', 'Jul-2026', 'No', 'B1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Jul-2026', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 11, 4440, '2026-07-10', 'Jul-2026', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar-500000-Ram2_1-Jul-2026', 'Arul-Ramkumar-500000-Ram2_1', 'Arul', 'Ramkumar', 'ramkumar finance', 500000, 20, '2026-07-10', 1, 25000, '2026-07-10', 'Jul-2026', 'No', 'Ram2_1', NULL, NULL, 'Active'),
('Arul-Ramkumar-250000-Ram2_2-Jul-2026', 'Arul-Ramkumar-250000-Ram2_2', 'Arul', 'Ramkumar', 'ramkumar finance', 250000, 20, '2026-07-10', 1, 12500, '2026-07-10', 'Jul-2026', 'No', 'Ram2_2', NULL, NULL, 'Active'),
('Malar-Ramkumar-500000-Ram2_1-Jul-2026', 'Malar-Ramkumar-500000-Ram2_1', 'Malar', 'Ramkumar', 'Ramkumar_Finance', 500000, 20, '2026-07-10', 1, 25000, '2026-07-10', 'Jul-2026', 'No', 'Ram2_1', NULL, NULL, 'Active'),
('Malar-Ramkumar-250000-Ram2_2-Jul-2026', 'Malar-Ramkumar-250000-Ram2_2', 'Malar', 'Ramkumar', 'Ramkumar Finance', 250000, 20, '2026-07-10', 1, 12500, '2026-07-01', 'Jul-2026', 'No', 'Ram2_2', NULL, NULL, 'Active'),
('Malar-Malar_Chit-250000-A_Chit-Aug-2026', 'Malar-Malar_Chit-250000-A_Chit', 'Malar', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 6, 10362.5, '2026-08-10', 'Aug-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Malar_Chit-250000-A_Chit-Aug-2026', 'Arul-Malar_Chit-250000-A_Chit', 'Arul', 'Malar_Chit', 'Vangapalayam, Tamil Nadu 639006, India', 250000, 20, '2026-03-10', 6, 10362.5, '2026-08-10', 'Aug-2026', 'No', 'A_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-C1_Chit-Aug-2026', 'Arul-Kannan_Fin-100000-C1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-01-06', 20, 5000, '2026-08-10', 'Aug-2026', 'No', 'C1_Chit', NULL, NULL, 'Active'),
('Ananyaa-Kannan_Fin-100000-A1_Chit-Aug-2026', 'Ananyaa-Kannan_Fin-100000-A1_Chit', 'Ananyaa', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 15, 4670, '2026-08-01', 'Aug-2026', 'True', 'A1_Chit', NULL, NULL, 'Active'),
('Adhvik-Kannan_Fin-100000-A1_Chit-Aug-2026', 'Adhvik-Kannan_Fin-100000-A1_Chit', 'Adhvik', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-06-06', 15, 4670, '2026-08-10', 'Aug-2026', 'No', 'A1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan_Fin-100000-B1_Chit-Aug-2026', 'Arul-Kannan_Fin-100000-B1_Chit', 'Arul', 'Kannan_Fin', 'Kannan finance', 100000, 20, '2025-12-10', 9, 4330, '2026-08-10', 'Aug-2026', 'No', 'B1_Chit', NULL, NULL, 'Active'),
('Arul-Kannan Finance-100000-D1_Chit-Aug-2026', 'Arul-Kannan Finance-100000-D1_Chit', 'Arul', 'Kannan Finance', 'Kannan Finance', 100000, 20, '2025-09-10', 12, 4490, '2026-08-10', 'Aug-2026', 'No', 'D1_Chit', NULL, NULL, 'Active'),
('Arul-Ramkumar-500000-Ram2_1-Aug-2026', 'Arul-Ramkumar-500000-Ram2_1', 'Arul', 'Ramkumar', 'ramkumar finance', 500000, 20, '2026-07-10', 2, 0, '2026-08-01', 'Aug-2026', 'No', 'Ram2_1', NULL, NULL, 'Active'),
('Arul-Ramkumar-250000-Ram2_2-Aug-2026', 'Arul-Ramkumar-250000-Ram2_2', 'Arul', 'Ramkumar', 'ramkumar finance', 250000, 20, '2026-07-10', 2, 0, '2026-08-01', 'Aug-2026', 'No', 'Ram2_2', NULL, NULL, 'Active'),
('Malar-Ramkumar-500000-Ram2_1-Aug-2026', 'Malar-Ramkumar-500000-Ram2_1', 'Malar', 'Ramkumar', 'Ramkumar_Finance', 500000, 20, '2026-07-10', 2, 0, '2026-08-01', 'Aug-2026', 'No', 'Ram2_1', NULL, NULL, 'Active'),
('Malar-Ramkumar-250000-Ram2_2-Aug-2026', 'Malar-Ramkumar-250000-Ram2_2', 'Malar', 'Ramkumar', 'Ramkumar Finance', 250000, 20, '2026-07-10', 2, 0, '2026-08-01', 'Aug-2026', 'No', 'Ram2_2', NULL, NULL, 'Active');
alter table "Invested_Chit_Trans" enable row level security;
create policy "read_all_Invested_Chit_Trans" on "Invested_Chit_Trans" for select using (true);

drop table if exists "Chit_Creation" cascade;
create table "Chit_Creation" ("Chit_ID" text, "Chit_Name" text, "Chit_From_Date" text, "Chit_To_Date" text, "No_Members" numeric, "Total_Month" numeric, "Total_Amount" numeric, "Chit_Percentage" numeric, "Chit_Amount" numeric, "Total_Chit_Count" numeric, "No_Month_Completed" numeric, "Total_Member_Taken" numeric, "Finance_Name" text, "Chit_Status" text);
insert into "Chit_Creation" ("Chit_ID", "Chit_Name", "Chit_From_Date", "Chit_To_Date", "No_Members", "Total_Month", "Total_Amount", "Chit_Percentage", "Chit_Amount", "Total_Chit_Count", "No_Month_Completed", "Total_Member_Taken", "Finance_Name", "Chit_Status") values
('Chit_A1', 'A', '2026-03-10', '2026-03-10', 25, 20, 500000, 3, 485000, 22.5, 6, 5.5, 'Chit_Malar', 'Open');
alter table "Chit_Creation" enable row level security;
create policy "read_all_Chit_Creation" on "Chit_Creation" for select using (true);

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
create policy "read_all_Chit_Member" on "Chit_Member" for select using (true);

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
create policy "read_all_Chit_Auction" on "Chit_Auction" for select using (true);

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
create policy "read_all_Chit_Taken_Member" on "Chit_Taken_Member" for select using (true);

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
create policy "read_all_Chit_Ledger" on "Chit_Ledger" for select using (true);

drop table if exists "Other_Finance_Loan" cascade;
create table "Other_Finance_Loan" ("Finance_Name" text, "Loan_Bought_Date" text, "Loan_No" text, "Loan_bought_Finance_Name" text, "Loan_bought_Finance_Phone_No" text, "Loan_bought_Finance_Email" text, "Loan_bought_Finance_Address" text, "Loan_Amount" numeric, "Interest_Per_day_Per_Lakh" numeric, "Repaid_Amount" numeric, "Outstand_Amount" numeric, "Loan_Status" text, "Payment_Type" text, "Remarks" text, "Interest_Type" text, "Interest_Per_Month_Per_Lakh" text, "Finance_Type" text);
insert into "Other_Finance_Loan" ("Finance_Name", "Loan_Bought_Date", "Loan_No", "Loan_bought_Finance_Name", "Loan_bought_Finance_Phone_No", "Loan_bought_Finance_Email", "Loan_bought_Finance_Address", "Loan_Amount", "Interest_Per_day_Per_Lakh", "Repaid_Amount", "Outstand_Amount", "Loan_Status", "Payment_Type", "Remarks", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Finance_Type") values
('Malar_Finance', '2025-08-19', 'Mal-O-1-AKPR finance', 'AKPR finance', NULL, NULL, NULL, 600000, 60, 600000, 0, 'Closed', 'Cash', NULL, 'Per_Day', '2025-08-19', NULL),
('Malar_Finance', '2025-08-19', 'Mal-O-2-Ramkumar_Appa', 'Ramkumar_Appa', NULL, NULL, NULL, 200000, 50, 0, 200000, 'Active', 'Cash', NULL, 'Per_Day', '2025-08-19', NULL),
('Malar_Finance', '2025-08-19', 'Mal-O-3-Vadivel', 'Vadivel', NULL, NULL, NULL, 150000, 26, 0, 150000, 'Active', 'UPI', NULL, 'Per_Day', '2025-08-19', NULL),
('Malar_Finance', '2025-08-21', 'Mal-O-4-Vadivel', 'Vadivel', NULL, NULL, NULL, 350000, 26, 0, 350000, 'Active', 'Cash', NULL, 'Per_Day', '2025-08-21', NULL),
('Malar_Finance', '2025-09-23', 'Mal-O-5-Kannan Finance', 'Kannan Finance', NULL, NULL, NULL, 50000, 70, 50000, 0, 'Closed', 'Cash', NULL, 'Per_Day', '2025-09-24', NULL),
('Malar_Finance', '2025-09-24', 'Mal-O-6-test', 'test', NULL, NULL, NULL, 100, 1000, 0, 100, 'Active', 'Cash', NULL, 'Per_Day', '2025-09-24', 'New'),
('Malar_Finance', '2026-03-05', 'Mal-O-7-Kannan Finance', 'Kannan Finance', NULL, NULL, NULL, 10000, 70, 10000, 0, 'Closed', 'Cash', NULL, 'Per_Day', '2026-03-05', 'Exist'),
('Malar_Finance', '2026-01-01', 'Mal-O-8-AKPR finance', 'AKPR finance', NULL, NULL, NULL, 25000, 60, 25000, 0, 'Closed', NULL, NULL, 'Per_Day', '2026-03-05', 'Exist'),
('Chit_Malar', '2026-04-15', 'Chi-O-9-Ramkumar', 'Ramkumar', NULL, NULL, NULL, 300000, 60, 300000, 0, 'Closed', 'Other', 'To palanisamy', 'Per_Day', '2026-05-15', 'New'),
('Chit_Malar', '2026-06-03', 'Chi-O-10-Baskar mama finance', 'Baskar mama finance', NULL, NULL, NULL, 250000, 60, 250000, 0, 'Closed', 'Cash', NULL, 'Per_Day', '2026-06-03', 'New'),
('Chit_Malar', '2026-06-18', 'Chi-O-11-Baskar mama finance', 'Baskar mama finance', NULL, NULL, NULL, 400000, 60, 400000, 0, 'Closed', 'Cash', NULL, 'Per_Day', '2026-06-18', 'Exist'),
('Chit_Malar', '2026-07-03', 'Chi-O-12-Prakash', 'Prakash', NULL, NULL, NULL, 500000, 50, 0, 500000, 'Active', NULL, NULL, 'Per_Day', '2026-07-04', 'New'),
('Chit_Malar', '2026-07-15', 'Chi-O-13-Ramkumar', 'Ramkumar', NULL, NULL, NULL, 200000, 70, 0, 200000, 'Active', 'Cash', 'given to tharun for chit amount', 'Per_Day', '2026-07-17', 'Exist');
alter table "Other_Finance_Loan" enable row level security;
create policy "read_all_Other_Finance_Loan" on "Other_Finance_Loan" for select using (true);

drop table if exists "Other_Finance_Interest" cascade;
create table "Other_Finance_Interest" ("id" text);
alter table "Other_Finance_Interest" enable row level security;
create policy "read_all_Other_Finance_Interest" on "Other_Finance_Interest" for select using (true);

drop table if exists "Given" cascade;
create table "Given" ("Date" text, "Name" text, "Description" text, "Mode" text, "Status" text, "Remarks" text, "ID" text, "Amount" numeric);
insert into "Given" ("Date", "Name", "Description", "Mode", "Status", "Remarks", "ID", "Amount") values
('2026-03-17', 'appa', '7500+5000 advocate fee', 'Other', 'Yet_to_Get', NULL, 'b19c2a41', 12500),
('2026-03-17', 'Chandrasekar', 'by finance kannan chit amount 1l-80k', 'Cash', 'Yet_to_Get', NULL, '67e76b92', 20000),
('2026-03-17', 'Chandrasekar', 'Valarmathi Chit amount', 'Cash', 'Fully_Got', 'Given arun  prakash', 'a47e6430', 25000),
('2026-03-17', 'Kannan', 'Suresh annan loan amount', 'Cash', 'Fully_Got', 'Paid to ravi loan', '3d801040', 45000),
('2026-03-17', 'Dinesh Muthusamy', 'tyre changed for fascino', 'Cash', 'Fully_Got', NULL, '83586402', 1450),
('2026-03-14', 'Chandrasekhar', 'Posb account at Pugalur', 'Cash', 'Fully_Got', 'Given to arun prakash', 'f966b134', 50000),
('2026-03-18', 'Arun prakash', 'Loan', 'Cash', 'Yet_to_Get', '50k adjusted and 50k pending out of 1l', '906d4679', 50000),
('2026-03-25', 'Vinoth', 'kovil vari', 'Cash', 'Fully_Got', 'by gpay', '63a36117', 1000),
('2026-03-25', 'malar app', 'ac', 'Cash', 'Fully_Got', NULL, 'c79cbcd7', 34000),
('2026-04-16', 'Malar appa', 'Loan', 'Cash', 'Fully_Got', 'As loan', 'b7a854ae', 50000),
('2026-04-18', 'Nagaraj', 'By upo', 'Upi', 'Fully_Got', NULL, '62a95b80', 1500),
('2026-05-17', 'Appa', 'Given to palkarar mama', 'Cash', 'Fully_Got', 'appa got it', 'cca189cc', 3000),
('2026-05-24', 'SuryaPrasath', 'given as cash', 'Cash', 'Fully_Got', NULL, 'ec77c07f', 20000),
('2026-06-23', 'Palanisamy', 'Through vellaiyan', 'Upi', 'Fully_Got', NULL, 'af552e8f', 14000),
('2026-07-06', 'Appa', 'Appa', 'Cash', 'Fully_Got', 'Adjusted 5k for mohan gpay remin5k, 5k chit adjusted', 'd57ae31d', 5000),
('2026-07-17', 'Surya', 'To இளமதி', 'Upi', 'Fully_Got', NULL, '70e45f4a', 6300),
('2026-07-24', 'Arun prakash', 'Bottle 800, 800, 1000 by cash', 'Other', 'Fully_Got', NULL, '21185931', 2600),
('2026-08-01', 'Kaviyarsu', 'Kavi', 'Upi', 'Yet_to_Get', NULL, '0cc84c54', 5000),
('2026-08-06', 'Nagaraj', 'Upi', 'Upi', 'Yet_to_Get', NULL, '7b623850', 20000);
alter table "Given" enable row level security;
create policy "read_all_Given" on "Given" for select using (true);

drop table if exists "Borrowed" cascade;
create table "Borrowed" ("Date" text, "Name" text, "Description" text, "Mode" text, "Status" text, "Remarks" text, "ID" text, "Amount" numeric);
insert into "Borrowed" ("Date", "Name", "Description", "Mode", "Status", "Remarks", "ID", "Amount") values
('2026-03-25', 'Tharun', 'advance chit for april by tharun', 'Cash', 'Fully_Given', '20000', '36967f20', 20000),
('2026-03-25', 'amuthavel', 'for ac', 'Other', 'Fully_Given', 'for ac', 'e799bd41', 12500),
('2026-04-21', 'Nagaraj jewel friend', '112200 out of which 90k given to ganesh jewellery', 'Account', 'Not_Given', NULL, '742b7c3f', 22200),
('2026-05-25', 'Nagaraj', '10-6=4l, 20k account, 20k account, 50 account = total 490000', 'Account', 'Not_Given', NULL, '2d1124fe', 490000),
('2026-06-19', 'Tharun', 'Cash', 'Other', 'Not_Given', NULL, '75c7280c', 15000);
alter table "Borrowed" enable row level security;
create policy "read_all_Borrowed" on "Borrowed" for select using (true);

drop table if exists "Hand_Exchange" cascade;
create table "Hand_Exchange" ("ID" text, "Date" text, "Person" text, "Person_Phone" text, "Category" text, "Amount" numeric, "Direction" text, "Type" text, "Mode" text, "Note" text, "Remarks" text, "Finance_Name" text);
insert into "Hand_Exchange" ("ID", "Date", "Person", "Person_Phone", "Amount", "Direction", "Type", "Mode", "Note", "Remarks") values
('b19c2a41', '2026-03-17', 'appa', NULL, 12500.0, 'out', 'Give', 'Other', '7500+5000 advocate fee', NULL),
('67e76b92', '2026-03-17', 'Chandrasekar', NULL, 20000.0, 'out', 'Give', 'Cash', 'by finance kannan chit amount 1l-80k', NULL),
('a47e6430', '2026-03-17', 'Chandrasekar', NULL, 25000.0, 'out', 'Give', 'Cash', 'Valarmathi Chit amount', 'Given arun  prakash'),
('a47e6430-got', '2026-03-17', 'Chandrasekar', NULL, 25000.0, 'in', 'Get', 'Cash', 'Received back — Valarmathi Chit amount', 'Given arun  prakash'),
('3d801040', '2026-03-17', 'Kannan', NULL, 45000.0, 'out', 'Give', 'Cash', 'Suresh annan loan amount', 'Paid to ravi loan'),
('3d801040-got', '2026-03-17', 'Kannan', NULL, 45000.0, 'in', 'Get', 'Cash', 'Received back — Suresh annan loan amount', 'Paid to ravi loan'),
('83586402', '2026-03-17', 'Dinesh Muthusamy', NULL, 1450.0, 'out', 'Give', 'Cash', 'tyre changed for fascino', NULL),
('83586402-got', '2026-03-17', 'Dinesh Muthusamy', NULL, 1450.0, 'in', 'Get', 'Cash', 'Received back — tyre changed for fascino', NULL),
('f966b134', '2026-03-14', 'Chandrasekhar', NULL, 50000.0, 'out', 'Give', 'Cash', 'Posb account at Pugalur', 'Given to arun prakash'),
('f966b134-got', '2026-03-14', 'Chandrasekhar', NULL, 50000.0, 'in', 'Get', 'Cash', 'Received back — Posb account at Pugalur', 'Given to arun prakash'),
('906d4679', '2026-03-18', 'Arun prakash', NULL, 50000.0, 'out', 'Give', 'Cash', 'Loan', '50k adjusted and 50k pending out of 1l'),
('63a36117', '2026-03-25', 'Vinoth', NULL, 1000.0, 'out', 'Give', 'Cash', 'kovil vari', 'by gpay'),
('63a36117-got', '2026-03-25', 'Vinoth', NULL, 1000.0, 'in', 'Get', 'Cash', 'Received back — kovil vari', 'by gpay'),
('c79cbcd7', '2026-03-25', 'malar app', NULL, 34000.0, 'out', 'Give', 'Cash', 'ac', NULL),
('c79cbcd7-got', '2026-03-25', 'malar app', NULL, 34000.0, 'in', 'Get', 'Cash', 'Received back — ac', NULL),
('b7a854ae', '2026-04-16', 'Malar appa', NULL, 50000.0, 'out', 'Give', 'Cash', 'Loan', 'As loan'),
('b7a854ae-got', '2026-04-16', 'Malar appa', NULL, 50000.0, 'in', 'Get', 'Cash', 'Received back — Loan', 'As loan'),
('62a95b80', '2026-04-18', 'Nagaraj', NULL, 1500.0, 'out', 'Give', 'Upi', 'By upo', NULL),
('62a95b80-got', '2026-04-18', 'Nagaraj', NULL, 1500.0, 'in', 'Get', 'Upi', 'Received back — By upo', NULL),
('cca189cc', '2026-05-17', 'Appa', NULL, 3000.0, 'out', 'Give', 'Cash', 'Given to palkarar mama', 'appa got it'),
('cca189cc-got', '2026-05-17', 'Appa', NULL, 3000.0, 'in', 'Get', 'Cash', 'Received back — Given to palkarar mama', 'appa got it'),
('ec77c07f', '2026-05-24', 'SuryaPrasath', NULL, 20000.0, 'out', 'Give', 'Cash', 'given as cash', NULL),
('ec77c07f-got', '2026-05-24', 'SuryaPrasath', NULL, 20000.0, 'in', 'Get', 'Cash', 'Received back — given as cash', NULL),
('af552e8f', '2026-06-23', 'Palanisamy', NULL, 14000.0, 'out', 'Give', 'Upi', 'Through vellaiyan', NULL),
('af552e8f-got', '2026-06-23', 'Palanisamy', NULL, 14000.0, 'in', 'Get', 'Upi', 'Received back — Through vellaiyan', NULL),
('d57ae31d', '2026-07-06', 'Appa', NULL, 5000.0, 'out', 'Give', 'Cash', 'Appa', 'Adjusted 5k for mohan gpay remin5k, 5k chit adjusted'),
('d57ae31d-got', '2026-07-06', 'Appa', NULL, 5000.0, 'in', 'Get', 'Cash', 'Received back — Appa', 'Adjusted 5k for mohan gpay remin5k, 5k chit adjusted'),
('70e45f4a', '2026-07-17', 'Surya', NULL, 6300.0, 'out', 'Give', 'Upi', 'To இளமதி', NULL),
('70e45f4a-got', '2026-07-17', 'Surya', NULL, 6300.0, 'in', 'Get', 'Upi', 'Received back — To இளமதி', NULL),
('21185931', '2026-07-24', 'Arun prakash', NULL, 2600.0, 'out', 'Give', 'Other', 'Bottle 800, 800, 1000 by cash', NULL),
('21185931-got', '2026-07-24', 'Arun prakash', NULL, 2600.0, 'in', 'Get', 'Other', 'Received back — Bottle 800, 800, 1000 by cash', NULL),
('0cc84c54', '2026-08-01', 'Kaviyarsu', NULL, 5000.0, 'out', 'Give', 'Upi', 'Kavi', NULL),
('7b623850', '2026-08-06', 'Nagaraj', NULL, 20000.0, 'out', 'Give', 'Upi', 'Upi', NULL),
('36967f20', '2026-03-25', 'Tharun', NULL, 20000.0, 'in', 'Borrow', 'Cash', 'advance chit for april by tharun', '20000'),
('36967f20-ret', '2026-03-25', 'Tharun', NULL, 20000.0, 'out', 'Return', 'Cash', 'Returned — advance chit for april by tharun', '20000'),
('e799bd41', '2026-03-25', 'amuthavel', NULL, 12500.0, 'in', 'Borrow', 'Other', 'for ac', 'for ac'),
('e799bd41-ret', '2026-03-25', 'amuthavel', NULL, 12500.0, 'out', 'Return', 'Other', 'Returned — for ac', 'for ac'),
('742b7c3f', '2026-04-21', 'Nagaraj jewel friend', NULL, 22200.0, 'in', 'Borrow', 'Account', '112200 out of which 90k given to ganesh jewellery', NULL),
('2d1124fe', '2026-05-25', 'Nagaraj', NULL, 490000.0, 'in', 'Borrow', 'Account', '10-6=4l, 20k account, 20k account, 50 account = total 490000', NULL),
('75c7280c', '2026-06-19', 'Tharun', NULL, 15000.0, 'in', 'Borrow', 'Other', 'Cash', NULL);
-- Existing hand-exchange rows predate finance scoping → file under Malar_Finance.
update "Hand_Exchange" set "Finance_Name" = 'Malar_Finance' where "Finance_Name" is null;
alter table "Hand_Exchange" enable row level security;
create policy "read_all_Hand_Exchange" on "Hand_Exchange" for select using (true);
