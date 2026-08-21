-- Kannan_Finance.xlsx import: New Finance + Kannnan_Personal
-- Paste into Supabase > SQL Editor > Run. Safe to re-run (clears these two finances first).

delete from "Finance_Details" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "Finance_Details" ("Finance_Name", "Date_Opened", "No_Partners", "Initial_Capital_Partner", "Phone_Number", "MD_Name") values
('New Finance', '2025-04-01', '10.0', 300000.0, NULL, 'Kannan'),
('Kannnan_Personal', '2026-01-01', '1', 100000.0, 9976592192.0, 'Kannan');

delete from "Partner" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "Partner" ("Partner_ID", "Finance_Name", "Partner_Name", "Photo", "Phone_Number", "Email_Address", "Pending_Message") values
('New-P1', 'New Finance', 'Arul Sampath', NULL, 8940864888.0, NULL, 'Arul Sampath
Jul-2026 - Total Interest Rs 17150

Referral Total Interest Pending Rs 12030

Sankara Narayanan-07-2026 - Pending Rs 6510
Ramesh-07-2026 - Pending Rs 740
Arul S-07-2026 - Pending Rs 2390
Rangis-07-2026 - Pending Rs 2170
Kaviraj-07-2026 - Pending Rs 220'),
('New-P2', 'New Finance', 'Arul Muthusamy', NULL, 9626262427.0, NULL, 'Arul Muthusamy
Jul-2026 - Total Interest Rs 36080

Referral Total Interest Pending Rs 37340

Ramasamy Divya-05-2026 - Pending Rs 1090
Ramasamy Divya-06-2026 - Pending Rs 1050
Balasubramani Suresh-06-2026 - Pending Rs 6930
Ramasamy Divya-07-2026 - Pending Rs 1090
Sundaravadivel-07-2026 - Pending Rs 2170
Balasubramani Suresh-07-2026 - Pending Rs 8680
Nagaraj Post-07-2026 - Pending Rs 960
Arul M-07-2026 - Pending Rs 1190
Manoj raghavendra shop-07-2026 - Pending Rs 220
Surya Shed-07-2026 - Pending Rs 10630
Gopal post-07-2026 - Pending Rs 3330'),
('New-P3', 'New Finance', 'Kannan Jeganathan', NULL, 9976592192.0, NULL, 'Kannan Jeganathan
Jul-2026 - Total Interest Rs 12805 - Cover Amount Rs 22500
Pls Improve the Loan as it will decrease the Capital amount of Finance
Referral Total Interest Pending Rs 11760

John-06-2026 - Pending Rs 2200
Praveen Ram-07-2026 - Pending Rs 1740
Tharun-07-2026 - Pending Rs 220
Viji Vasanth-07-2026 - Pending Rs 3260
Bala kaarthi-07-2026 - Pending Rs 4340'),
('New-P4', 'New Finance', 'Kaviyarasu', NULL, 9629998999.0, NULL, 'Kaviyarasu
Jul-2026 - Total Interest Rs 24360

Referral Total Interest Pending Rs 24360

Kaviyarasu Arul-07-2026 - Pending Rs 20020
Karthi cake shop-07-2026 - Pending Rs 4340'),
('New-P5', 'New Finance', 'Ponnusamy A', NULL, 9942713540.0, NULL, 'Ponnusamy A
Jul-2026 - Total Interest Rs 12815 - Cover Amount Rs 15000
Pls Improve the Loan as it will decrease the Capital amount of Finance
Referral Total Interest Pending Rs 14390

Udhayakumar-06-2026 - Pending Rs 1760
Jayapal-06-2026 - Pending Rs 2100
Murugesan pons-07-2026 - Pending Rs 420
Jayapal-07-2026 - Pending Rs 2170
Udhayakumar-07-2026 - Pending Rs 2390
Suresh Abudhabi-07-2026 - Pending Rs 1300
Yagappan-07-2026 - Pending Rs 500
Sakthivel Jayaraj-07-2026 - Pending Rs 2660
Mahesh-07-2026 - Pending Rs 1090'),
('New-P6', 'New Finance', 'Prakash Manoharan', NULL, 9865388000.0, NULL, 'Prakash Manoharan
Jul-2026 - Total Interest Rs 17360

Referral Total Interest Pending Rs 25590

Danendran-06-2026 - Pending Rs 2000
Karnan-06-2026 - Pending Rs 8400
Danendran-07-2026 - Pending Rs 2060
Rajendran-07-2026 - Pending Rs 370
Karnan-07-2026 - Pending Rs 8680
Vinoth-07-2026 - Pending Rs 1090
Ashok-07-2026 - Pending Rs 370
Prakash S M-07-2026 - Pending Rs 1740
Kamaraj Prakash-07-2026 - Pending Rs 880'),
('New-P7', 'New Finance', 'Ram Kumar PNR', NULL, 9578562182.0, NULL, 'Ram Kumar PNR
Jul-2026 - Total Interest Rs 7600

Referral Total Interest Pending Rs 7600

Ramkumar-07-2026 - Pending Rs 4340
Sakthivel Broker-07-2026 - Pending Rs 2170
Moorthy-07-2026 - Pending Rs 1090'),
('New-P8', 'New Finance', 'Ravi Paramasivam', NULL, 9751277888.0, NULL, 'Ravi Paramasivam
Jul-2026 - Total Interest Rs 18230

Referral Total Interest Pending Rs 16610

Kalimuthu-06-2026 - Pending Rs 1050
Murugesan-07-2026 - Pending Rs 600
Shanmugam-07-2026 - Pending Rs 740
Manivannan-07-2026 - Pending Rs 6510
Ramprakash-07-2026 - Pending Rs 1190
Kalimuthu-07-2026 - Pending Rs 1090
Vignesh Arun Kumba-07-2026 - Pending Rs 2170
Tharun Tex-07-2026 - Pending Rs 1090
Durai Master Kumbaa-07-2026 - Pending Rs 2170'),
('New-P9', 'New Finance', 'Vasu Devar Paramasivam', NULL, 9751519191.0, NULL, 'Vasu Devar Paramasivam
Jul-2026 - Total Interest Rs 18530

Referral Total Interest Pending Rs 35180

Selvaguru-06-2026 - Pending Rs 3150
Vasudevan-06-2026 - Pending Rs 11400
Pradeep_NPA-06-2026 - Pending Rs 2100
Selvaguru-07-2026 - Pending Rs 3260
Vasudevan-07-2026 - Pending Rs 12260
Pradeep_NPA-07-2026 - Pending Rs 2170
Divakar-07-2026 - Pending Rs 840'),
('New-P10', 'New Finance', 'Vinayagam Sankaralingam', NULL, 9751707865.0, NULL, 'Vinayagam Sankaralingam
Jul-2026 - Total Interest Rs 21215

Referral Total Interest Pending Rs 14705

Nandhakumar-07-2026 - Pending Rs 3785
Muniyappan-07-2026 - Pending Rs 2170
Vignesh-07-2026 - Pending Rs 2170
Anand-07-2026 - Pending Rs 500
Subramani-07-2026 - Pending Rs 3260
Nagurammal-07-2026 - Pending Rs 2820'),
('Kan-P1', 'Kannnan_Personal', 'Kannan', NULL, 9976592192.0, NULL, 'Kannan
Jul-2026 - Total Interest Rs 0 - Cover Amount Rs 


Referral Total Interest Pending Rs 426200

Elango Sports-03-2026 - Pending Rs 400

Kavin Surrendar-03-2026 - Pending Rs 5850

Arun Kumba-03-2026 - Pending Rs 12210

Ashok Bro-03-2026 - Pending Rs 5360

Arun Lorry-03-2026 - Pending Rs 8900

Gokulnath-03-2026 - Pending Rs 130

Karthi China-03-2026 - Pending Rs 21700

Sethu-03-2026 - Pending Rs 1860

Rail Ragavan-03-2026 - Pending Rs 1090

Saravanan Battery-03-2026 - Pending Rs 8250

Jayaprabha-03-2026 - Pending Rs 9770

Theena Aravind-03-2026 - Pending Rs 990

Sridhar Aalves-03-2026 - Pending Rs 3280

Aravind Vasu-03-2026 - Pending Rs 6360

Kanagaraj Chola-03-2026 - Pending Rs 3270

Sudhakar-03-2026 - Pending Rs 3910

Abdul Rahman-03-2026 - Pending Rs 430

Vijay-03-2026 - Pending Rs 2170

Karthi Oil-03-2026 - Pending Rs 870

Viji Vasanth-03-2026 - Pending Rs 6000

Venkat Pilot-03-2026 - Pending Rs 4880

Sabarish-03-2026 - Pending Rs 2170

Murugesan-03-2026 - Pending Rs 1300

John-03-2026 - Pending Rs 4880

Manoj-03-2026 - Pending Rs 10850

Palanisamy Auto-03-2026 - Pending Rs 2170

Vallarasu_Kumaravel-03-2026 - Pending Rs 1980

Govindhasamy-03-2026 - Pending Rs 1410

Saravanan Chola-03-2026 - Pending Rs 500

Guna-03-2026 - Pending Rs 6510

Maniraj-03-2026 - Pending Rs 5250

Dinesh-03-2026 - Pending Rs 2170

Jeeva-03-2026 - Pending Rs 540

Prabhakar-03-2026 - Pending Rs 870

Devaraj-03-2026 - Pending Rs 1240

Arumugam-03-2026 - Pending Rs 560

Rekha-03-2026 - Pending Rs 990

Sasi Master-03-2026 - Pending Rs 500

Sathish Siva-03-2026 - Pending Rs 500

Kongu Kochai-03-2026 - Pending Rs 3690

Amutha Ashok-03-2026 - Pending Rs 11400

Prabhu-03-2026 - Pending Rs 2400

Kan-STL4-Arun Lorry - Old Pending Interest Rs 108620

Kan-STL75-Kan-STL75 - Old Pending Interest Rs 64660

Kan-STL95-Kan-STL95 - Old Pending Interest Rs 18590

Kan-STL108-Kan-STL108 - Old Pending Interest Rs 12390

Kan-STL153-Kan-STL153 - Old Pending Interest Rs 4950

Kan-STL154-Kan-STL154 - Old Pending Interest Rs 34400

Kan-STL191-Kan-STL191 - Old Pending Interest Rs 1280

Kan-STL197-Kan-STL197 - Old Pending Interest Rs 5880

Kan-STL216-Kan-STL216 - Old Pending Interest Rs 870

Kan-STL2-Ashok Bro - Old Pending Interest Rs 5000');

delete from "STL_CRM" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "STL_CRM" ("Finance_Name", "Customer_Name", "Customer_STL_NO", "Customer_Phone_No", "Customer_Email", "Customer_Adhar_No", "Customer_Photo", "Total_Loan_Given", "Outstand_Loan", "Total_Interest_Paid", "Outstanding_Interest", "Status", "Pending_Message", "Pending111") values
('New Finance', 'Sankara Narayanan', 'New-STL179', 9003333055.0, NULL, NULL, NULL, 300000, 300000, 31500, 6510, 'Active', 'New-STL179
Total Interest Pending Rs 6510
07-2026 - Int_Amount Rs 6510 - Pending Rs 6510', 'Total Interest Pending Rs 6510
07-2026 - Int_Amount Rs 6510 - Pending Rs 6510'),
('New Finance', 'Ramesh', 'New-STL257', 8072765170.0, NULL, NULL, NULL, 30000, 30000, 3700, 740, 'Active', 'New-STL257
Total Interest Pending Rs 740
07-2026 - Int_Amount Rs 740 - Pending Rs 740', 'Total Interest Pending Rs 740
07-2026 - Int_Amount Rs 740 - Pending Rs 740'),
('New Finance', 'Arul S', 'New-STL270', 8940864888.0, NULL, NULL, NULL, 190000, 110000, 8410, 2390, 'Active', 'New-STL270
Total Interest Pending Rs 2390
07-2026 - Int_Amount Rs 2390 - Pending Rs 2390', 'Total Interest Pending Rs 2390
07-2026 - Int_Amount Rs 2390 - Pending Rs 2390'),
('New Finance', 'Rangis', 'New-STL295', 9443732655.0, NULL, NULL, NULL, 100000, 100000, 10500, 2170, 'Active', 'New-STL295
Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('New Finance', 'RanjithKumar', 'New-STL319', 9042090520.0, NULL, NULL, NULL, 450000, 0, 26360, -2940, 'Inactive', 'New-STL319
Total Interest Pending Rs -2940
07-2026 - Int_Amount Rs 2940 - Pending Rs -2940', 'Total Interest Pending Rs -2940
07-2026 - Int_Amount Rs 2940 - Pending Rs -2940'),
('New Finance', 'Pradeep', 'New-STL67', 9626262427.0, NULL, NULL, NULL, 150000, 0, 8118, 0, 'Inactive', 'New-STL67
No entries found', 'No entries found'),
('New Finance', 'Ramasamy Divya', 'New-STL156', 9894465610.0, NULL, NULL, NULL, 50000, 50000, 3120, 3230, 'Active', 'New-STL156
Total Interest Pending Rs 3230
05-2026 - Int_Amount Rs 1090 - Pending Rs 1090
06-2026 - Int_Amount Rs 1050 - Pending Rs 1050
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090', 'Total Interest Pending Rs 3230
05-2026 - Int_Amount Rs 1090 - Pending Rs 1090
06-2026 - Int_Amount Rs 1050 - Pending Rs 1050
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090'),
('New Finance', 'Kaviyarasu', 'New-STL252', 9629998999.0, NULL, NULL, NULL, 350000, 0, 10080, 0, 'Inactive', 'New-STL252
No entries found', 'No entries found'),
('New Finance', 'Sundaravadivel', 'New-STL271', 8072211260.0, NULL, NULL, NULL, 100000, 100000, 12050, 2170, 'Active', 'New-STL271
Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('New Finance', 'Balasubramani Suresh', 'New-STL275', 9080548538.0, NULL, NULL, NULL, 400000, 400000, 28140, 15610, 'Active', 'New-STL275
Total Interest Pending Rs 8680
07-2026 - Int_Amount Rs 8680 - Pending Rs 8680', 'Total Interest Pending Rs 8680
07-2026 - Int_Amount Rs 8680 - Pending Rs 8680'),
('New Finance', 'Nagaraj Post', 'New-STL301', 9150787857.0, NULL, NULL, NULL, 40000, 40000, 3640, 960, 'Active', 'New-STL301
Total Interest Pending Rs 960
07-2026 - Int_Amount Rs 960 - Pending Rs 960', 'Total Interest Pending Rs 960
07-2026 - Int_Amount Rs 960 - Pending Rs 960'),
('New Finance', 'Priya', 'New-STL320', 9840807102.0, NULL, NULL, NULL, 690000, 360000, 36470, -7810, 'Active', 'New-STL320
Total Interest Pending Rs -7810
07-2026 - Int_Amount Rs 7810 - Pending Rs -7810', 'Total Interest Pending Rs -7810
07-2026 - Int_Amount Rs 7810 - Pending Rs -7810'),
('New Finance', 'Arul M', 'New-STL330', 9626262427.0, NULL, NULL, NULL, 55000, 55000, 5579, 1190, 'Active', 'New-STL330
Total Interest Pending Rs 1190
07-2026 - Int_Amount Rs 1190 - Pending Rs 1190', 'Total Interest Pending Rs 1190
07-2026 - Int_Amount Rs 1190 - Pending Rs 1190'),
('New Finance', 'John', 'New-STL292', 7418824749.0, NULL, NULL, NULL, 150000, 0, 12610, 2200, 'Inactive', 'New-STL292
Total Interest Pending Rs 2200
06-2026 - Int_Amount Rs 2200 - Pending Rs 2200', 'Total Interest Pending Rs 2200
06-2026 - Int_Amount Rs 2200 - Pending Rs 2200'),
('New Finance', 'Tharun', 'New-STL303', 9843722055.0, NULL, NULL, NULL, 120000, 10000, 3930, 150, 'Active', 'New-STL303
Total Interest Pending Rs 150
04-2026 - Int_Amount Rs 710 - Pending Rs -70
07-2026 - Int_Amount Rs 220 - Pending Rs 220', 'Total Interest Pending Rs 150
04-2026 - Int_Amount Rs 710 - Pending Rs -70
07-2026 - Int_Amount Rs 220 - Pending Rs 220'),
('New Finance', 'Praveen Ram', 'New-STL324', 9715778326.0, NULL, NULL, NULL, 80000, 80000, 8410, 1740, 'Active', 'New-STL324
Total Interest Pending Rs 1740
07-2026 - Int_Amount Rs 1740 - Pending Rs 1740', 'Total Interest Pending Rs 1740
07-2026 - Int_Amount Rs 1740 - Pending Rs 1740'),
('New Finance', 'Kongu Kochai', 'New-STL329', 9976592192.0, NULL, NULL, NULL, 200000, 0, 11770, 0, 'Inactive', 'New-STL329
No entries found', 'No entries found'),
('New Finance', 'Sakthivel', 'New-STL332', 9003755903.0, NULL, NULL, NULL, 300000, 0, 1680, 0, 'Inactive', 'New-STL332
No entries found', 'No entries found'),
('New Finance', 'Dinesh', 'New-STL78', 9942153364.0, NULL, NULL, NULL, 50000, 0, 2490, -130, 'Inactive', 'New-STL78
Total Interest Pending Rs -120
05-2026 - Int_Amount Rs 80 - Pending Rs -120', 'Total Interest Pending Rs -120
05-2026 - Int_Amount Rs 80 - Pending Rs -120'),
('New Finance', 'Jayapal', 'New-STL121', 9788544477.0, NULL, NULL, NULL, 100000, 100000, 8400, 4270, 'Active', 'New-STL121
Total Interest Pending Rs 4270
06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 4270
06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('New Finance', 'Udhayakumar', 'New-STL126', 9965656493.0, NULL, NULL, NULL, 180000, 110000, 12540, 4150, 'Active', 'New-STL126
Total Interest Pending Rs 2390
07-2026 - Int_Amount Rs 2390 - Pending Rs 2390', 'Total Interest Pending Rs 2390
07-2026 - Int_Amount Rs 2390 - Pending Rs 2390'),
('New Finance', 'Boopathy Crane', 'New-STL217', 9159296091.0, NULL, NULL, NULL, 30000, 0, 2140, 0, 'Inactive', 'New-STL217
No entries found', 'No entries found'),
('New Finance', 'Suresh Abudhabi', 'New-STL273', 7200035939.0, NULL, NULL, NULL, 60000, 60000, 6300, 1300, 'Active', 'New-STL273
Total Interest Pending Rs 1300
07-2026 - Int_Amount Rs 1300 - Pending Rs 1300', 'Total Interest Pending Rs 1300
07-2026 - Int_Amount Rs 1300 - Pending Rs 1300'),
('New Finance', 'Jayaraj', 'New-STL277', 9788644477.0, NULL, NULL, NULL, 250000, 0, 2210, 0, 'Inactive', 'New-STL277
No entries found', 'No entries found'),
('New Finance', 'Yagappan', 'New-STL278', 8248805311.0, NULL, NULL, NULL, 20000, 20000, 2410, 500, 'Active', 'New-STL278
Total Interest Pending Rs 500
07-2026 - Int_Amount Rs 500 - Pending Rs 500', 'Total Interest Pending Rs 500
07-2026 - Int_Amount Rs 500 - Pending Rs 500'),
('New Finance', 'Sakthivel Jayaraj', 'New-STL304', 9943013586.0, NULL, NULL, NULL, 200000, 200000, 10290, 2660, 'Active', 'New-STL304
Total Interest Pending Rs 2660
07-2026 - Int_Amount Rs 2660 - Pending Rs 2660', 'Total Interest Pending Rs 2660
07-2026 - Int_Amount Rs 2660 - Pending Rs 2660'),
('New Finance', 'Mahesh', 'New-STL308', 9080383024.0, NULL, NULL, NULL, 50000, 50000, 5260, 1090, 'Active', 'New-STL308
Total Interest Pending Rs 1090
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090', 'Total Interest Pending Rs 1090
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090'),
('New Finance', 'Kaviyarasu Arul', 'New-STL323', 9629998999.0, NULL, NULL, NULL, 1000000, 900000, 91380, 20020, 'Active', 'New-STL323
Total Interest Pending Rs 20020
07-2026 - Int_Amount Rs 20020 - Pending Rs 20020', 'Total Interest Pending Rs 20020
07-2026 - Int_Amount Rs 20020 - Pending Rs 20020'),
('New Finance', 'Danendran', 'New-STL46', 9865388000.0, NULL, NULL, NULL, 95000, 95000, 7980, 4060, 'Active', 'New-STL46
Total Interest Pending Rs 4060
06-2026 - Int_Amount Rs 2000 - Pending Rs 2000
07-2026 - Int_Amount Rs 2060 - Pending Rs 2060', 'Total Interest Pending Rs 4060
06-2026 - Int_Amount Rs 2000 - Pending Rs 2000
07-2026 - Int_Amount Rs 2060 - Pending Rs 2060'),
('New Finance', 'Rajendran', 'New-STL58', 9865388000.0, NULL, NULL, NULL, 15000, 15000, 1800, 370, 'Active', 'New-STL58
Total Interest Pending Rs 370
07-2026 - Int_Amount Rs 370 - Pending Rs 370', 'Total Interest Pending Rs 370
07-2026 - Int_Amount Rs 370 - Pending Rs 370'),
('New Finance', 'Karnan', 'New-STL160', 9789502425.0, NULL, NULL, NULL, 400000, 400000, 33600, 17080, 'Active', 'New-STL160
Total Interest Pending Rs 17080
06-2026 - Int_Amount Rs 8400 - Pending Rs 8400
07-2026 - Int_Amount Rs 8680 - Pending Rs 8680', 'Total Interest Pending Rs 17080
06-2026 - Int_Amount Rs 8400 - Pending Rs 8400
07-2026 - Int_Amount Rs 8680 - Pending Rs 8680'),
('New Finance', 'Vinoth', 'New-STL262', 9047015007.0, NULL, NULL, NULL, 50000, 50000, 5260, 1090, 'Active', 'New-STL262
Total Interest Pending Rs 1090
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090', 'Total Interest Pending Rs 1090
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090'),
('New Finance', 'Ashok', 'New-STL282', 7708880250.0, NULL, NULL, NULL, 15000, 15000, 1800, 370, 'Active', 'New-STL282
Total Interest Pending Rs 370
07-2026 - Int_Amount Rs 370 - Pending Rs 370', 'Total Interest Pending Rs 370
07-2026 - Int_Amount Rs 370 - Pending Rs 370'),
('New Finance', 'Mariyammal', 'New-STL297', 9952102163.0, NULL, NULL, NULL, 100000, 100000, 14840, -2170, 'Active', 'New-STL297
Total Interest Pending Rs -2170
07-2026 - Int_Amount Rs 2170 - Pending Rs -2170', 'Total Interest Pending Rs -2170
07-2026 - Int_Amount Rs 2170 - Pending Rs -2170'),
('New Finance', 'Ramkumar', 'New-STL231', 9578562182.0, NULL, NULL, NULL, 430000, 200000, 24010, 2240, 'Active', 'New-STL231
Total Interest Pending Rs 2240
04-2026 - Int_Amount Rs 3540 - Pending Rs -2100
07-2026 - Int_Amount Rs 4340 - Pending Rs 4340', 'Total Interest Pending Rs 2240
04-2026 - Int_Amount Rs 3540 - Pending Rs -2100
07-2026 - Int_Amount Rs 4340 - Pending Rs 4340'),
('New Finance', 'Kannan', 'New-STL235', 9976592192.0, NULL, NULL, NULL, 415000, 0, 17240, 0, 'Inactive', 'New-STL235
No entries found', 'No entries found'),
('New Finance', 'Sakthivel Broker', 'New-STL263', 9443835225.0, NULL, NULL, NULL, 100000, 100000, 10500, 2170, 'Active', 'New-STL263
Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('New Finance', 'Sabarish', 'New-STL280', 9080753749.0, NULL, NULL, NULL, 285000, 35000, 15310, -760, 'Active', 'New-STL280
Total Interest Pending Rs -760
07-2026 - Int_Amount Rs 760 - Pending Rs -760', 'Total Interest Pending Rs -760
07-2026 - Int_Amount Rs 760 - Pending Rs -760'),
('New Finance', 'Moorthy', 'New-STL312', 9578562182.0, NULL, NULL, NULL, 50000, 50000, 5260, 1090, 'Active', 'New-STL312
Total Interest Pending Rs 1090
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090', 'Total Interest Pending Rs 1090
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090'),
('New Finance', 'Shanmugam', 'New-STL139', 9943519663.0, NULL, NULL, NULL, 30000, 30000, 3590, 740, 'Active', 'New-STL139
Total Interest Pending Rs 740
07-2026 - Int_Amount Rs 740 - Pending Rs 740', 'Total Interest Pending Rs 740
07-2026 - Int_Amount Rs 740 - Pending Rs 740'),
('New Finance', 'Manivannan', 'New-STL182', 9715884248.0, NULL, NULL, NULL, 300000, 300000, 31500, 6510, 'Active', 'New-STL182
Total Interest Pending Rs 6510
07-2026 - Int_Amount Rs 6510 - Pending Rs 6510', 'Total Interest Pending Rs 6510
07-2026 - Int_Amount Rs 6510 - Pending Rs 6510'),
('New Finance', 'Ramprakash', 'New-STL234', 9003525303.0, NULL, NULL, NULL, 55000, 55000, 5790, 1190, 'Active', 'New-STL234
Total Interest Pending Rs 1190
07-2026 - Int_Amount Rs 1190 - Pending Rs 1190', 'Total Interest Pending Rs 1190
07-2026 - Int_Amount Rs 1190 - Pending Rs 1190'),
('New Finance', 'Kalimuthu', 'New-STL248', 9047042275.0, NULL, NULL, NULL, 50000, 50000, 4210, 2140, 'Active', 'New-STL248
Total Interest Pending Rs 2140
06-2026 - Int_Amount Rs 1050 - Pending Rs 1050
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090', 'Total Interest Pending Rs 2140
06-2026 - Int_Amount Rs 1050 - Pending Rs 1050
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090'),
('New Finance', 'Murugesan', 'New-STL326', 7373932218.0, NULL, NULL, NULL, 220000, 20000, 3110, 600, 'Active', 'New-STL326
Total Interest Pending Rs 600
07-2026 - Int_Amount Rs 1300 - Pending Rs 600', 'Total Interest Pending Rs 600
07-2026 - Int_Amount Rs 1300 - Pending Rs 600'),
('New Finance', 'Ravi', 'New-STL306', 9751277888.0, NULL, NULL, NULL, 295000, 20000, 11180, 0, 'Active', 'New-STL306
No entries found', 'No entries found'),
('New Finance', 'Selvaguru', 'New-STL35', 9786177888.0, NULL, NULL, NULL, 150000, 150000, 12410, 6410, 'Active', 'New-STL35
Total Interest Pending Rs 6410
06-2026 - Int_Amount Rs 3150 - Pending Rs 3150
07-2026 - Int_Amount Rs 3260 - Pending Rs 3260', 'Total Interest Pending Rs 6410
06-2026 - Int_Amount Rs 3150 - Pending Rs 3150
07-2026 - Int_Amount Rs 3260 - Pending Rs 3260'),
('New Finance', 'Vasudevan', 'New-STL116', 9751519191.0, NULL, NULL, NULL, 575000, 565000, 37680, 23660, 'Active', 'New-STL116
Total Interest Pending Rs 23660
06-2026 - Int_Amount Rs 11490 - Pending Rs 11400
07-2026 - Int_Amount Rs 12260 - Pending Rs 12260', 'Total Interest Pending Rs 23660
06-2026 - Int_Amount Rs 11490 - Pending Rs 11400
07-2026 - Int_Amount Rs 12260 - Pending Rs 12260'),
('New Finance', 'Paramasivam', 'New-STL153', 9364455525.0, NULL, NULL, NULL, 35000, 0, 3360, 0, 'Inactive', 'New-STL153
No entries found', 'No entries found'),
('New Finance', 'Karthick', 'New-STL185', 9751519191.0, NULL, NULL, NULL, 20000, 0, 1930, 0, 'Inactive', 'New-STL185
No entries found', 'No entries found'),
('New Finance', 'Manikandan', 'New-STL195', 9751519191.0, NULL, NULL, NULL, 50000, 0, 3010, 0, 'Inactive', 'New-STL195
No entries found', 'No entries found'),
('New Finance', 'Pradeep_NPA', 'New-STL123', 9751519191.0, NULL, NULL, NULL, 100000, 100000, 8400, 4270, 'Active', 'New-STL123
Total Interest Pending Rs 4270
06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 4270
06-2026 - Int_Amount Rs 2100 - Pending Rs 2100
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('New Finance', 'Logambal', 'New-STL283', 8056834412.0, NULL, NULL, NULL, 100000, 0, 4490, 0, 'Inactive', 'New-STL283
No entries found', 'No entries found'),
('New Finance', 'Divakar', 'New-STL318', 8610561010.0, NULL, NULL, NULL, 35000, 35000, 3490, 840, 'Active', 'New-STL318
Total Interest Pending Rs 840
07-2026 - Int_Amount Rs 840 - Pending Rs 840', 'Total Interest Pending Rs 840
07-2026 - Int_Amount Rs 840 - Pending Rs 840'),
('New Finance', 'Muniyappan', 'New-STL150', 9159214139.0, NULL, NULL, NULL, 100000, 100000, 10500, 2170, 'Active', 'New-STL150
Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('New Finance', 'Shanmugaraj', 'New-STL151', 9443781565.0, NULL, NULL, NULL, 300000, 300000, 44520, -6510, 'Active', 'New-STL151
Total Interest Pending Rs -6510
07-2026 - Int_Amount Rs 6510 - Pending Rs -6510', 'Total Interest Pending Rs -6510
07-2026 - Int_Amount Rs 6510 - Pending Rs -6510'),
('New Finance', 'Nandhakumar', 'New-STL227', 9361446918.0, NULL, NULL, NULL, 300000, 150000, 19040, 3785, 'Active', 'New-STL227
Total Interest Pending Rs 3785
07-2026 - Int_Amount Rs 3785 - Pending Rs 3785', 'Total Interest Pending Rs 3785
07-2026 - Int_Amount Rs 3785 - Pending Rs 3785'),
('New Finance', 'Vignesh', 'New-STL260', 9159048096.0, NULL, NULL, NULL, 100000, 100000, 10500, 2170, 'Active', 'New-STL260
Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('New Finance', 'Anand', 'New-STL274', 7695808377.0, NULL, NULL, NULL, 20000, 20000, 2410, 500, 'Active', 'New-STL274
Total Interest Pending Rs 500
07-2026 - Int_Amount Rs 500 - Pending Rs 500', 'Total Interest Pending Rs 500
07-2026 - Int_Amount Rs 500 - Pending Rs 500'),
('New Finance', 'Subramani', 'New-STL287', 9003446318.0, NULL, NULL, NULL, 150000, 150000, 15760, 3260, 'Active', 'New-STL287
Total Interest Pending Rs 3260
07-2026 - Int_Amount Rs 3260 - Pending Rs 3260', 'Total Interest Pending Rs 3260
07-2026 - Int_Amount Rs 3260 - Pending Rs 3260'),
('New Finance', 'Nagurammal', 'New-STL331', 9786870661.0, NULL, NULL, NULL, 150000, 130000, 15230, 2820, 'Active', 'New-STL331
Total Interest Pending Rs 2820
07-2026 - Int_Amount Rs 2820 - Pending Rs 2820', 'Total Interest Pending Rs 2820
07-2026 - Int_Amount Rs 2820 - Pending Rs 2820'),
('New Finance', 'Mani Basketball', 'New-STL333', 9894450873.0, NULL, NULL, NULL, 150000, 50000, 11490, 0, 'Active', 'New-STL333
No entries found', 'No entries found'),
('New Finance', 'Viji Vasanth', 'New-STL313', 9844139371.0, NULL, NULL, NULL, 250000, 150000, 15330, 3260, 'Active', 'New-STL313
Total Interest Pending Rs 3260
07-2026 - Int_Amount Rs 3260 - Pending Rs 3260', 'Total Interest Pending Rs 3260
07-2026 - Int_Amount Rs 3260 - Pending Rs 3260'),
('New Finance', 'Vignesh Arun Kumba', 'New-STL334', 8973249929.0, NULL, NULL, NULL, 100000, 100000, 6650, 2170, 'Active', 'New-STL334
Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('New Finance', 'Tharun Tex', 'New-STL221', 8056834412.0, NULL, NULL, NULL, 100000, 50000, 4120, 1090, 'Active', 'New-STL221
Total Interest Pending Rs 1090
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090', 'Total Interest Pending Rs 1090
07-2026 - Int_Amount Rs 1090 - Pending Rs 1090'),
('New Finance', 'Durai Master Kumbaa', 'New-STL335', 6369910360.0, NULL, NULL, NULL, 100000, 100000, 6440, 2170, 'Active', 'New-STL335
Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
07-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('Kannnan_Personal', 'Ashok Bro', 'Kan-STL2', 9791958906.0, NULL, NULL, NULL, 150000, 0, 0, 5360, 'Inactive', 'Kan-STL2
Total Interest Pending Rs 10360
03-2026 - Int_Amount Rs 5360 - Pending Rs 5360
Kan-STL2 - Old Pending Interest Rs 5000', 'Total Interest Pending Rs 10360
03-2026 - Int_Amount Rs 5360 - Pending Rs 5360
Kan-STL2 - Old Pending Interest Rs 5000'),
('Kannnan_Personal', 'Arun Lorry', 'Kan-STL4', 9626262427.0, NULL, NULL, NULL, 410000, 410000, 0, 8900, 'Active', 'Kan-STL4
Total Interest Pending Rs 117520
03-2026 - Int_Amount Rs 8900 - Pending Rs 8900
Kan-STL4 - Old Pending Interest Rs 108620', 'Total Interest Pending Rs 117520
03-2026 - Int_Amount Rs 8900 - Pending Rs 8900
Kan-STL4 - Old Pending Interest Rs 108620'),
('Kannnan_Personal', 'Gokulnath', 'Kan-STL40', 8072395221.0, NULL, NULL, NULL, 20000, 20000, 0, 130, 'Active', 'Kan-STL40
Total Interest Pending Rs 130
03-2026 - Int_Amount Rs 130 - Pending Rs 130', 'Total Interest Pending Rs 130
03-2026 - Int_Amount Rs 130 - Pending Rs 130'),
('Kannnan_Personal', 'Elango Sports', 'Kan-STL49', 9943831310.0, NULL, NULL, NULL, 80000, 50000, 0, 400, 'Active', 'Kan-STL49
Total Interest Pending Rs 400
03-2026 - Int_Amount Rs 400 - Pending Rs 400', 'Total Interest Pending Rs 400
03-2026 - Int_Amount Rs 400 - Pending Rs 400'),
('Kannnan_Personal', 'Karthi China', 'Kan-STL60', 7373173783.0, NULL, NULL, NULL, 1000000, 1000000, 0, 21700, 'Active', 'Kan-STL60
Total Interest Pending Rs 21700
03-2026 - Int_Amount Rs 21700 - Pending Rs 21700', 'Total Interest Pending Rs 21700
03-2026 - Int_Amount Rs 21700 - Pending Rs 21700'),
('Kannnan_Personal', 'Sethu', 'Kan-STL65', 9842498218.0, NULL, NULL, NULL, 100000, 100000, 0, 1860, 'Active', 'Kan-STL65
Total Interest Pending Rs 1860
03-2026 - Int_Amount Rs 1860 - Pending Rs 1860', 'Total Interest Pending Rs 1860
03-2026 - Int_Amount Rs 1860 - Pending Rs 1860'),
('Kannnan_Personal', 'Rail Ragavan', 'Kan-STL74', 7550394660.0, NULL, NULL, NULL, 60000, 60000, 0, 1090, 'Active', 'Kan-STL74
Total Interest Pending Rs 1090
03-2026 - Int_Amount Rs 1090 - Pending Rs 1090', 'Total Interest Pending Rs 1090
03-2026 - Int_Amount Rs 1090 - Pending Rs 1090'),
('Kannnan_Personal', 'Saravanan Battery', 'Kan-STL75', 9715087870.0, NULL, NULL, NULL, 380000, 380000, 0, 8250, 'Active', 'Kan-STL75
Total Interest Pending Rs 72910
03-2026 - Int_Amount Rs 8250 - Pending Rs 8250
Kan-STL75 - Old Pending Interest Rs 64660', 'Total Interest Pending Rs 72910
03-2026 - Int_Amount Rs 8250 - Pending Rs 8250
Kan-STL75 - Old Pending Interest Rs 64660'),
('Kannnan_Personal', 'Jayaprabha', 'Kan-STL95', 9500821444.0, NULL, NULL, NULL, 450000, 450000, 0, 9770, 'Active', 'Kan-STL95
Total Interest Pending Rs 28360
03-2026 - Int_Amount Rs 9770 - Pending Rs 9770
Kan-STL95 - Old Pending Interest Rs 18590', 'Total Interest Pending Rs 28360
03-2026 - Int_Amount Rs 9770 - Pending Rs 9770
Kan-STL95 - Old Pending Interest Rs 18590'),
('Kannnan_Personal', 'Theena Aravind', 'Kan-STL103', 9894049151.0, NULL, NULL, NULL, 40000, 40000, 0, 990, 'Active', 'Kan-STL103
Total Interest Pending Rs 990
03-2026 - Int_Amount Rs 990 - Pending Rs 990', 'Total Interest Pending Rs 990
03-2026 - Int_Amount Rs 990 - Pending Rs 990'),
('Kannnan_Personal', 'Kavin Surrendar', 'Kan-STL108', 9025112544.0, NULL, NULL, NULL, 300000, 250000, 0, 5850, 'Active', 'Kan-STL108
Total Interest Pending Rs 18240
03-2026 - Int_Amount Rs 5850 - Pending Rs 5850
Kan-STL108 - Old Pending Interest Rs 12390', 'Total Interest Pending Rs 18240
03-2026 - Int_Amount Rs 5850 - Pending Rs 5850
Kan-STL108 - Old Pending Interest Rs 12390'),
('Kannnan_Personal', 'Sridhar Aalves', 'Kan-STL123', 90475555591.0, NULL, NULL, NULL, 160000, 160000, 0, 3280, 'Active', 'Kan-STL123
Total Interest Pending Rs 3280
03-2026 - Int_Amount Rs 3280 - Pending Rs 3280', 'Total Interest Pending Rs 3280
03-2026 - Int_Amount Rs 3280 - Pending Rs 3280'),
('Kannnan_Personal', 'Aravind Vasu', 'Kan-STL129', 9751519292.0, NULL, NULL, NULL, 293000, 293000, 0, 6360, 'Active', 'Kan-STL129
Total Interest Pending Rs 6360
03-2026 - Int_Amount Rs 6360 - Pending Rs 6360', 'Total Interest Pending Rs 6360
03-2026 - Int_Amount Rs 6360 - Pending Rs 6360'),
('Kannnan_Personal', 'Arun Kumba', 'Kan-STL139', 9894049151.0, NULL, NULL, NULL, 605000, 555000, 0, 12210, 'Active', 'Kan-STL139
Total Interest Pending Rs 12210
03-2026 - Int_Amount Rs 12210 - Pending Rs 12210', 'Total Interest Pending Rs 12210
03-2026 - Int_Amount Rs 12210 - Pending Rs 12210'),
('Kannnan_Personal', 'Kanagaraj Chola', 'Kan-STL153', 9943829996.0, NULL, NULL, NULL, 170000, 170000, 0, 3270, 'Active', 'Kan-STL153
Total Interest Pending Rs 8220
03-2026 - Int_Amount Rs 3270 - Pending Rs 3270
Kan-STL153 - Old Pending Interest Rs 4950', 'Total Interest Pending Rs 8220
03-2026 - Int_Amount Rs 3270 - Pending Rs 3270
Kan-STL153 - Old Pending Interest Rs 4950'),
('Kannnan_Personal', 'Sudhakar', 'Kan-STL154', 7010493151.0, NULL, NULL, NULL, 180000, 180000, 0, 3910, 'Active', 'Kan-STL154
Total Interest Pending Rs 38310
03-2026 - Int_Amount Rs 3910 - Pending Rs 3910
Kan-STL154 - Old Pending Interest Rs 34400', 'Total Interest Pending Rs 38310
03-2026 - Int_Amount Rs 3910 - Pending Rs 3910
Kan-STL154 - Old Pending Interest Rs 34400'),
('Kannnan_Personal', 'Abdul Rahman', 'Kan-STL155', 9095650806.0, NULL, NULL, NULL, 20000, 20000, 0, 430, 'Active', 'Kan-STL155
Total Interest Pending Rs 430
03-2026 - Int_Amount Rs 430 - Pending Rs 430', 'Total Interest Pending Rs 430
03-2026 - Int_Amount Rs 430 - Pending Rs 430'),
('Kannnan_Personal', 'Vijay', 'Kan-STL161', 8778588896.0, NULL, NULL, NULL, 100000, 100000, 0, 2170, 'Active', 'Kan-STL161
Total Interest Pending Rs 2170
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('Kannnan_Personal', 'Karthi Oil', 'Kan-STL162', 9715406070.0, NULL, NULL, NULL, 40000, 40000, 0, 870, 'Active', 'Kan-STL162
Total Interest Pending Rs 870
03-2026 - Int_Amount Rs 870 - Pending Rs 870', 'Total Interest Pending Rs 870
03-2026 - Int_Amount Rs 870 - Pending Rs 870'),
('Kannnan_Personal', 'Viji Vasanth', 'Kan-STL164', 9344139371.0, NULL, NULL, NULL, 300000, 300000, 0, 6000, 'Active', 'Kan-STL164
Total Interest Pending Rs 6000
03-2026 - Int_Amount Rs 6000 - Pending Rs 6000', 'Total Interest Pending Rs 6000
03-2026 - Int_Amount Rs 6000 - Pending Rs 6000'),
('Kannnan_Personal', 'Venkat Pilot', 'Kan-STL173', 9585600378.0, NULL, NULL, NULL, 225000, 225000, 0, 4880, 'Active', 'Kan-STL173
Total Interest Pending Rs 4880
03-2026 - Int_Amount Rs 4880 - Pending Rs 4880', 'Total Interest Pending Rs 4880
03-2026 - Int_Amount Rs 4880 - Pending Rs 4880'),
('Kannnan_Personal', 'Sabarish', 'Kan-STL174', 9080753749.0, NULL, NULL, NULL, 100000, 100000, 0, 2170, 'Active', 'Kan-STL174
Total Interest Pending Rs 2170
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('Kannnan_Personal', 'Murugesan', 'Kan-STL177', 9787979779.0, NULL, NULL, NULL, 60000, 60000, 0, 1300, 'Active', 'Kan-STL177
Total Interest Pending Rs 1300
03-2026 - Int_Amount Rs 1300 - Pending Rs 1300', 'Total Interest Pending Rs 1300
03-2026 - Int_Amount Rs 1300 - Pending Rs 1300'),
('Kannnan_Personal', 'John', 'Kan-STL182', 8946048074.0, NULL, NULL, NULL, 225000, 225000, 0, 4880, 'Active', 'Kan-STL182
Total Interest Pending Rs 4880
03-2026 - Int_Amount Rs 4880 - Pending Rs 4880', 'Total Interest Pending Rs 4880
03-2026 - Int_Amount Rs 4880 - Pending Rs 4880'),
('Kannnan_Personal', 'Manoj', 'Kan-STL184', 8838114684.0, NULL, NULL, NULL, 500000, 500000, 0, 10850, 'Active', 'Kan-STL184
Total Interest Pending Rs 10850
03-2026 - Int_Amount Rs 10850 - Pending Rs 10850', 'Total Interest Pending Rs 10850
03-2026 - Int_Amount Rs 10850 - Pending Rs 10850'),
('Kannnan_Personal', 'Palanisamy Auto', 'Kan-STL187', 8883083604.0, NULL, NULL, NULL, 100000, 100000, 0, 2170, 'Active', 'Kan-STL187
Total Interest Pending Rs 2170
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('Kannnan_Personal', 'Vallarasu_Kumaravel', 'Kan-STL189', 9080753749.0, NULL, NULL, NULL, 80000, 80000, 0, 1980, 'Active', 'Kan-STL189
Total Interest Pending Rs 1980
03-2026 - Int_Amount Rs 1980 - Pending Rs 1980', 'Total Interest Pending Rs 1980
03-2026 - Int_Amount Rs 1980 - Pending Rs 1980'),
('Kannnan_Personal', 'Govindhasamy', 'Kan-STL191', 9751747987.0, NULL, NULL, NULL, 65000, 65000, 0, 1410, 'Active', 'Kan-STL191
Total Interest Pending Rs 2690
03-2026 - Int_Amount Rs 1410 - Pending Rs 1410
Kan-STL191 - Old Pending Interest Rs 1280', 'Total Interest Pending Rs 2690
03-2026 - Int_Amount Rs 1410 - Pending Rs 1410
Kan-STL191 - Old Pending Interest Rs 1280'),
('Kannnan_Personal', 'Saravanan Chola', 'Kan-STL193', 9943829996.0, NULL, NULL, NULL, 20000, 20000, 0, 500, 'Active', 'Kan-STL193
Total Interest Pending Rs 500
03-2026 - Int_Amount Rs 500 - Pending Rs 500', 'Total Interest Pending Rs 500
03-2026 - Int_Amount Rs 500 - Pending Rs 500'),
('Kannnan_Personal', 'Guna', 'Kan-STL197', 9698733233.0, NULL, NULL, NULL, 300000, 300000, 0, 6510, 'Active', 'Kan-STL197
Total Interest Pending Rs 12390
03-2026 - Int_Amount Rs 6510 - Pending Rs 6510
Kan-STL197 - Old Pending Interest Rs 5880', 'Total Interest Pending Rs 12390
03-2026 - Int_Amount Rs 6510 - Pending Rs 6510
Kan-STL197 - Old Pending Interest Rs 5880'),
('Kannnan_Personal', 'Maniraj', 'Kan-STL201', 9626279956.0, NULL, NULL, NULL, 300000, 300000, 0, 5250, 'Active', 'Kan-STL201
Total Interest Pending Rs 5250
03-2026 - Int_Amount Rs 5250 - Pending Rs 5250', 'Total Interest Pending Rs 5250
03-2026 - Int_Amount Rs 5250 - Pending Rs 5250'),
('Kannnan_Personal', 'Dinesh', 'Kan-STL203', 7708121402.0, NULL, NULL, NULL, 100000, 100000, 0, 2170, 'Active', 'Kan-STL203
Total Interest Pending Rs 2170
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170', 'Total Interest Pending Rs 2170
03-2026 - Int_Amount Rs 2170 - Pending Rs 2170'),
('Kannnan_Personal', 'Jeeva', 'Kan-STL205', 7200123452.0, NULL, NULL, NULL, 25000, 25000, 0, 540, 'Active', 'Kan-STL205
Total Interest Pending Rs 540
03-2026 - Int_Amount Rs 540 - Pending Rs 540', 'Total Interest Pending Rs 540
03-2026 - Int_Amount Rs 540 - Pending Rs 540'),
('Kannnan_Personal', 'Prabhakar', 'Kan-STL206', 6380232340.0, NULL, NULL, NULL, 60000, 60000, 0, 870, 'Active', 'Kan-STL206
Total Interest Pending Rs 870
03-2026 - Int_Amount Rs 870 - Pending Rs 870', 'Total Interest Pending Rs 870
03-2026 - Int_Amount Rs 870 - Pending Rs 870'),
('Kannnan_Personal', 'Devaraj', 'Kan-STL211', 9629691014.0, NULL, NULL, NULL, 50000, 50000, 0, 1240, 'Active', 'Kan-STL211
Total Interest Pending Rs 1240
03-2026 - Int_Amount Rs 1240 - Pending Rs 1240', 'Total Interest Pending Rs 1240
03-2026 - Int_Amount Rs 1240 - Pending Rs 1240');
insert into "STL_CRM" ("Finance_Name", "Customer_Name", "Customer_STL_NO", "Customer_Phone_No", "Customer_Email", "Customer_Adhar_No", "Customer_Photo", "Total_Loan_Given", "Outstand_Loan", "Total_Interest_Paid", "Outstanding_Interest", "Status", "Pending_Message", "Pending111") values
('Kannnan_Personal', 'Arumugam', 'Kan-STL212', 6374635641.0, NULL, NULL, NULL, 20000, 20000, 0, 560, 'Active', 'Kan-STL212
Total Interest Pending Rs 560
03-2026 - Int_Amount Rs 560 - Pending Rs 560', 'Total Interest Pending Rs 560
03-2026 - Int_Amount Rs 560 - Pending Rs 560'),
('Kannnan_Personal', 'Rekha', 'Kan-STL215', 8754896997.0, NULL, NULL, NULL, 40000, 40000, 0, 990, 'Active', 'Kan-STL215
Total Interest Pending Rs 990
03-2026 - Int_Amount Rs 990 - Pending Rs 990', 'Total Interest Pending Rs 990
03-2026 - Int_Amount Rs 990 - Pending Rs 990'),
('Kannnan_Personal', 'Sasi Master', 'Kan-STL216', 9655400148.0, NULL, NULL, NULL, 20000, 20000, 0, 500, 'Active', 'Kan-STL216
Total Interest Pending Rs 1370
03-2026 - Int_Amount Rs 500 - Pending Rs 500
Kan-STL216 - Old Pending Interest Rs 870', 'Total Interest Pending Rs 1370
03-2026 - Int_Amount Rs 500 - Pending Rs 500
Kan-STL216 - Old Pending Interest Rs 870'),
('Kannnan_Personal', 'Sathish Siva', 'Kan-STL217', 9994092494.0, NULL, NULL, NULL, 20000, 20000, 0, 500, 'Active', 'Kan-STL217
Total Interest Pending Rs 500
03-2026 - Int_Amount Rs 500 - Pending Rs 500', 'Total Interest Pending Rs 500
03-2026 - Int_Amount Rs 500 - Pending Rs 500'),
('Kannnan_Personal', 'Kongu Kochai', 'Kan-STL218', 9976592192.0, NULL, NULL, NULL, 170000, 170000, 0, 3690, 'Active', 'Kan-STL218
Total Interest Pending Rs 3690
03-2026 - Int_Amount Rs 3690 - Pending Rs 3690', 'Total Interest Pending Rs 3690
03-2026 - Int_Amount Rs 3690 - Pending Rs 3690'),
('Kannnan_Personal', 'Amutha Ashok', 'Kan-STL219', 9791958906.0, NULL, NULL, NULL, 1000000, 1000000, 0, 11400, 'Active', 'Kan-STL219
Total Interest Pending Rs 11400
03-2026 - Int_Amount Rs 11400 - Pending Rs 11400', 'Total Interest Pending Rs 11400
03-2026 - Int_Amount Rs 11400 - Pending Rs 11400'),
('Kannnan_Personal', 'Prabhu', 'Kan-STL220', 7010012727.0, NULL, NULL, NULL, 250000, 250000, 0, 2400, 'Active', 'Kan-STL220
Total Interest Pending Rs 2400
03-2026 - Int_Amount Rs 2400 - Pending Rs 2400', 'Total Interest Pending Rs 2400
03-2026 - Int_Amount Rs 2400 - Pending Rs 2400'),
('Kannnan_Personal', NULL, 'Kan-STL43', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'Inactive', 'Kan-STL43
', NULL),
('Kannnan_Personal', 'dssdds', 'Kan-STL444', 343544.0, NULL, NULL, NULL, 0, 0, 0, 0, 'Inactive', 'Kan-STL444
No entries found', 'No entries found'),
('New Finance', 'Karthi cake shop', 'New-STL337', 9787390814.0, NULL, NULL, NULL, 200000, 200000, 11060, 4340, 'Active', 'New-STL337
Total Interest Pending Rs 4340
07-2026 - Int_Amount Rs 4340 - Pending Rs 4340', 'Total Interest Pending Rs 4340
07-2026 - Int_Amount Rs 4340 - Pending Rs 4340'),
('New Finance', 'Manoj raghavendra shop', 'New-STL336', 8838622618.0, NULL, NULL, NULL, 10000, 10000, 620, 220, 'Active', 'New-STL336
Total Interest Pending Rs 220
07-2026 - Int_Amount Rs 220 - Pending Rs 220', 'Total Interest Pending Rs 220
07-2026 - Int_Amount Rs 220 - Pending Rs 220'),
('New Finance', 'Kaviraj', 'New-STL338', 9943341540.0, NULL, NULL, NULL, 50000, 10000, 1470, 220, 'Active', 'New-STL338
Total Interest Pending Rs 220
07-2026 - Int_Amount Rs 220 - Pending Rs 220', 'Total Interest Pending Rs 220
07-2026 - Int_Amount Rs 220 - Pending Rs 220'),
('New Finance', 'Surya Shed', 'New-STL339', 9787878005.0, NULL, NULL, NULL, 490000, 490000, 10740, 10630, 'Active', 'New-STL339
Total Interest Pending Rs 10630
07-2026 - Int_Amount Rs 10630 - Pending Rs 10630', 'Total Interest Pending Rs 10630
07-2026 - Int_Amount Rs 10630 - Pending Rs 10630'),
('New Finance', 'Bala kaarthi', 'New-STL340', 9677843432.0, NULL, NULL, NULL, 200000, 200000, 6860, 4340, 'Active', 'New-STL340
Total Interest Pending Rs 4340
07-2026 - Int_Amount Rs 4340 - Pending Rs 4340', 'Total Interest Pending Rs 4340
07-2026 - Int_Amount Rs 4340 - Pending Rs 4340'),
('New Finance', 'Murugesan pons', 'New-STL341', 9942713540.0, NULL, NULL, NULL, 295000, 25000, 8560, -630, 'Active', 'New-STL341
Total Interest Pending Rs 420
07-2026 - Int_Amount Rs 2460 - Pending Rs 420', 'Total Interest Pending Rs 420
07-2026 - Int_Amount Rs 2460 - Pending Rs 420'),
('New Finance', 'Jeyaraj pons', 'New-STL342', 9788644477.0, NULL, NULL, NULL, 50000, 0, 1790, -245, 'Inactive', 'New-STL342
Total Interest Pending Rs -245
07-2026 - Int_Amount Rs 245 - Pending Rs -245', 'Total Interest Pending Rs -245
07-2026 - Int_Amount Rs 245 - Pending Rs -245'),
('New Finance', 'Prakash S M', 'New-STL343', 9865388000.0, NULL, NULL, NULL, 80000, 80000, 1460, 1740, 'Active', 'New-STL343
Total Interest Pending Rs 1740
07-2026 - Int_Amount Rs 1740 - Pending Rs 1740', 'Total Interest Pending Rs 1740
07-2026 - Int_Amount Rs 1740 - Pending Rs 1740'),
('New Finance', 'Suresh CCTV', 'New-STL344', 8861715281.0, NULL, NULL, NULL, 50000, 50000, 2740, -1090, 'Active', 'New-STL344
Total Interest Pending Rs -1090
07-2026 - Int_Amount Rs 1090 - Pending Rs -1090', 'Total Interest Pending Rs -1090
07-2026 - Int_Amount Rs 1090 - Pending Rs -1090'),
('New Finance', 'Kamaraj Prakash', 'New-STL345', 9600996663.0, NULL, NULL, NULL, 50000, 50000, 0, 880, 'Active', 'New-STL345
Total Interest Pending Rs 880
07-2026 - Int_Amount Rs 880 - Pending Rs 880', 'Total Interest Pending Rs 880
07-2026 - Int_Amount Rs 880 - Pending Rs 880'),
('New Finance', 'Gopal post', 'New-STL346', 8838723676.0, NULL, NULL, NULL, 250000, 250000, 0, 3330, 'Active', 'New-STL346
Total Interest Pending Rs 3330
07-2026 - Int_Amount Rs 3330 - Pending Rs 3330', 'Total Interest Pending Rs 3330
07-2026 - Int_Amount Rs 3330 - Pending Rs 3330'),
('New Finance', 'Vinoth Ravi vangalamman', 'New-STL347', 8122484554.0, NULL, NULL, NULL, 250000, 0, 2450, -1225, 'Inactive', 'New-STL347
Total Interest Pending Rs -1225
07-2026 - Int_Amount Rs 1225 - Pending Rs -1225', 'Total Interest Pending Rs -1225
07-2026 - Int_Amount Rs 1225 - Pending Rs -1225'),
('New Finance', 'Gobinath', 'New-STL348', 9597539696.0, NULL, NULL, NULL, 200000, 200000, 2520, -1260, 'Active', 'New-STL348
Total Interest Pending Rs -1260
07-2026 - Int_Amount Rs 1260 - Pending Rs -1260', 'Total Interest Pending Rs -1260
07-2026 - Int_Amount Rs 1260 - Pending Rs -1260');

delete from "Loan_Processing" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "Loan_Processing" ("Finance_Name", "Loan_Given_Date", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "Customer_Email", "Customer_Adhar_No", "Loan_Amount", "Interest_Per_day_Per_Lakh", "No_Bond_Received", "No_Chq_Received", "Attach1", "Attach2", "Photo1", "Photo2", "Repaid_Amount", "Outstand_Amount", "Loan_Status", "Referred_Partner", "Payment_Type", "Remarks", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days", "Customer_Type", "Customer_Ref") values
('New Finance', '2026-02-01', 'New-1', 'New-STL179', 'Sankara Narayanan', 9003333055.0, NULL, NULL, 300000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300000, 'Active', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL179-Sankara Narayanan'),
('New Finance', '2026-02-01', 'New-2', 'New-STL257', 'Ramesh', 8072765170.0, NULL, NULL, 30000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30000, 'Active', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL257-Ramesh'),
('New Finance', '2026-02-01', 'New-3', 'New-STL270', 'Arul S', 8940864888.0, NULL, NULL, 150000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 80000, 70000, 'Active', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL270-Arul S'),
('New Finance', '2026-02-01', 'New-4', 'New-STL295', 'Rangis', 9443732655.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL295-Rangis'),
('New Finance', '2026-02-01', 'New-5', 'New-STL319', 'RanjithKumar', 9042090520.0, NULL, NULL, 250000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 250000, 0, 'Closed', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL319-RanjithKumar'),
('New Finance', '2026-02-01', 'New-6', 'New-STL67', 'Pradeep', 9626262427.0, NULL, NULL, 150000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 150000, 0, 'Closed', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL67-Pradeep'),
('New Finance', '2026-02-01', 'New-7', 'New-STL156', 'Ramasamy Divya', 9894465610.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL156-Ramasamy Divya'),
('New Finance', '2026-02-01', 'New-8', 'New-STL252', 'Kaviyarasu', 9629998999.0, NULL, NULL, 350000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 350000, 0, 'Closed', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL252-Kaviyarasu'),
('New Finance', '2026-02-01', 'New-9', 'New-STL271', 'Sundaravadivel', 8072211260.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL271-Sundaravadivel'),
('New Finance', '2026-02-01', 'New-10', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL275-Balasubramani Suresh'),
('New Finance', '2026-02-01', 'New-11', 'New-STL301', 'Nagaraj Post', 9150787857.0, NULL, NULL, 30000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL301-Nagaraj Post'),
('New Finance', '2026-02-01', 'New-12', 'New-STL320', 'Priya', 9840807102.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 0, 'Closed', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL320-Priya'),
('New Finance', '2026-02-01', 'New-13', 'New-STL330', 'Arul M', 9626262427.0, NULL, NULL, 35000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 35000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL330-Arul M'),
('New Finance', '2026-02-01', 'New-14', 'New-STL292', 'John', 7418824749.0, NULL, NULL, 150000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 150000, 0, 'Closed', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL292-John'),
('New Finance', '2026-02-01', 'New-15', 'New-STL303', 'Tharun', 9843722055.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 0, 'Closed', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL303-Tharun'),
('New Finance', '2026-02-01', 'New-16', 'New-STL324', 'Praveen Ram', 9715778326.0, NULL, NULL, 80000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 80000, 'Active', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL324-Praveen Ram'),
('New Finance', '2026-02-01', 'New-17', 'New-STL329', 'Kongu Kochai', 9976592192.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL329-Kongu Kochai'),
('New Finance', '2026-02-27', 'New-18', 'New-STL332', 'Sakthivel', 9003755903.0, NULL, NULL, 300000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 300000, 0, 'Closed', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL332-Sakthivel'),
('New Finance', '2026-02-01', 'New-19', 'New-STL78', 'Dinesh', 9942153364.0, NULL, NULL, 40000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 40000, 0, 'Closed', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL78-Dinesh'),
('New Finance', '2026-02-01', 'New-20', 'New-STL121', 'Jayapal', 9788544477.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL121-Jayapal'),
('New Finance', '2026-02-01', 'New-21', 'New-STL126', 'Udhayakumar', 9965656493.0, NULL, NULL, 180000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 70000, 110000, 'Active', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL126-Udhayakumar'),
('New Finance', '2026-02-01', 'New-22', 'New-STL217', 'Boopathy Crane', 9159296091.0, NULL, NULL, 30000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 30000, 0, 'Closed', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL217-Boopathy Crane'),
('New Finance', '2026-02-01', 'New-23', 'New-STL273', 'Suresh Abudhabi', 7200035939.0, NULL, NULL, 60000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60000, 'Active', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL273-Suresh Abudhabi'),
('New Finance', '2026-02-01', 'New-24', 'New-STL277', 'Jayaraj', 9788644477.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 0, 'Closed', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL277-Jayaraj'),
('New Finance', '2026-02-01', 'New-25', 'New-STL278', 'Yagappan', 8248805311.0, NULL, NULL, 20000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL278-Yagappan'),
('New Finance', '2026-02-01', 'New-26', 'New-STL304', 'Sakthivel Jayaraj', 9943013586.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL304-Sakthivel Jayaraj'),
('New Finance', '2026-02-01', 'New-27', 'New-STL308', 'Mahesh', 9080383024.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL308-Mahesh'),
('New Finance', '2026-02-01', 'New-28', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, NULL, NULL, 800000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 750000, 'Active', 'New-P4', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL323-Kaviyarasu Arul'),
('New Finance', '2026-02-01', 'New-29', 'New-STL46', 'Danendran', 9865388000.0, NULL, NULL, 95000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 95000, 'Active', 'New-P6', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL46-Danendran'),
('New Finance', '2026-02-01', 'New-30', 'New-STL58', 'Rajendran', 9865388000.0, NULL, NULL, 15000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 15000, 'Active', 'New-P6', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL58-Rajendran'),
('New Finance', '2026-02-01', 'New-31', 'New-STL160', 'Karnan', 9789502425.0, NULL, NULL, 400000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 400000, 'Active', 'New-P6', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL160-Karnan'),
('New Finance', '2026-02-01', 'New-32', 'New-STL262', 'Vinoth', 9047015007.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P6', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL262-Vinoth'),
('New Finance', '2026-02-01', 'New-33', 'New-STL282', 'Ashok', 7708880250.0, NULL, NULL, 15000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 15000, 'Active', 'New-P6', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL282-Ashok'),
('New Finance', '2026-02-01', 'New-34', 'New-STL297', 'Mariyammal', 9952102163.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P6', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL297-Mariyammal'),
('New Finance', '2026-02-01', 'New-35', 'New-STL231', 'Ramkumar', 9578562182.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 100000, 'Active', 'New-P7', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL231-Ramkumar'),
('New Finance', '2026-02-01', 'New-36', 'New-STL235', 'Kannan', 9976592192.0, NULL, NULL, 215000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 215000, 0, 'Closed', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL235-Kannan'),
('New Finance', '2026-02-01', 'New-37', 'New-STL263', 'Sakthivel Broker', 9443835225.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P7', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL263-Sakthivel Broker'),
('New Finance', '2026-02-01', 'New-38', 'New-STL280', 'Sabarish', 9080753749.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL280-Sabarish'),
('New Finance', '2026-02-01', 'New-39', 'New-STL312', 'Moorthy', 9578562182.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P7', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL312-Moorthy'),
('New Finance', '2026-02-01', 'New-40', 'New-STL139', 'Shanmugam', 9943519663.0, NULL, NULL, 30000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30000, 'Active', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL139-Shanmugam'),
('New Finance', '2026-02-01', 'New-41', 'New-STL182', 'Manivannan', 9715884248.0, NULL, NULL, 300000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300000, 'Active', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL182-Manivannan'),
('New Finance', '2026-02-01', 'New-42', 'New-STL234', 'Ramprakash', 9003525303.0, NULL, NULL, 55000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 55000, 'Active', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL234-Ramprakash'),
('New Finance', '2026-02-01', 'New-43', 'New-STL326', 'Murugesan', 7373932218.0, NULL, NULL, 20000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL326-Murugesan'),
('New Finance', '2026-02-01', 'New-44', 'New-STL248', 'Kalimuthu', 9047042275.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL248-Kalimuthu'),
('New Finance', '2026-02-01', 'New-45', 'New-STL306', 'Ravi', 9751277888.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL306-Ravi'),
('New Finance', '2026-02-01', 'New-46', 'New-STL35', 'Selvaguru', 9786177888.0, NULL, NULL, 150000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150000, 'Active', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL35-Selvaguru'),
('New Finance', '2026-02-01', 'New-47', 'New-STL116', 'Vasudevan', 9751519191.0, NULL, NULL, 450000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 10000, 440000, 'Active', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL116-Vasudevan'),
('New Finance', '2026-02-01', 'New-48', 'New-STL153', 'Paramasivam', 9364455525.0, NULL, NULL, 35000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 35000, 0, 'Closed', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL153-Paramasivam'),
('New Finance', '2026-02-01', 'New-49', 'New-STL185', 'Karthick', 9751519191.0, NULL, NULL, 20000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 20000, 0, 'Closed', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL185-Karthick'),
('New Finance', '2026-02-01', 'New-50', 'New-STL195', 'Manikandan', 9751519191.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 0, 'Closed', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL195-Manikandan'),
('New Finance', '2026-02-01', 'New-51', 'New-STL123', 'Pradeep_NPA', 9751519191.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL123-Pradeep_NPA'),
('New Finance', '2026-02-01', 'New-52', 'New-STL283', 'Logambal', 8056834412.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 0, 'Closed', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL283-Logambal'),
('New Finance', '2026-02-01', 'New-53', 'New-STL318', 'Divakar', 8610561010.0, NULL, NULL, 25000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 25000, 'Active', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL318-Divakar'),
('New Finance', '2026-02-01', 'New-54', 'New-STL150', 'Muniyappan', 9159214139.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P10', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL150-Muniyappan'),
('New Finance', '2026-02-01', 'New-55', 'New-STL151', 'Shanmugaraj', 9443781565.0, NULL, NULL, 300000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300000, 'Active', 'New-P10', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL151-Shanmugaraj'),
('New Finance', '2026-02-01', 'New-56', 'New-STL227', 'Nandhakumar', 9361446918.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 0, 'Closed', 'New-P10', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL227-Nandhakumar'),
('New Finance', '2026-02-01', 'New-57', 'New-STL260', 'Vignesh', 9751707865.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P10', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL260-Vignesh'),
('New Finance', '2026-02-01', 'New-58', 'New-STL274', 'Anand', 7695808377.0, NULL, NULL, 20000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'New-P10', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL274-Anand'),
('New Finance', '2026-02-01', 'New-59', 'New-STL287', 'Subramani', 9003446318.0, NULL, NULL, 150000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150000, 'Active', 'New-P10', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL287-Subramani'),
('New Finance', '2026-02-05', 'New-60', 'New-STL331', 'Nagurammal', 9786870661.0, NULL, NULL, 150000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 20000, 130000, 'Active', 'New-P10', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL331-Nagurammal'),
('New Finance', '2026-03-04', 'New-61', 'New-STL333', 'Mani Basketball', 9894450873.0, NULL, NULL, 150000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 50000, 'Active', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL61-Mani Basketball'),
('New Finance', '2026-03-07', 'New-62', 'New-STL330', 'Arul M', 9626262427.0, NULL, NULL, 15000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 15000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL330-Arul M'),
('New Finance', '2026-03-09', 'New-63', 'New-STL280', 'Sabarish', 9080753749.0, NULL, NULL, 60000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 10000, 'Active', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL280-Sabarish'),
('New Finance', '2026-03-12', 'New-64', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL275-Balasubramani Suresh'),
('New Finance', '2026-03-14', 'New-65', 'New-STL320', 'Priya', 9840807102.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 80000, 20000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL320-Priya'),
('New Finance', '2026-03-16', 'New-66', 'New-STL303', 'Tharun', 9843722055.0, NULL, NULL, 70000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 60000, 10000, 'Active', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL303-Tharun'),
('New Finance', '2026-03-17', 'New-67', 'New-STL313', 'Viji Vasanth', 9844139371.0, NULL, NULL, 250000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 150000, 'Active', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL313-Viji Vasanth'),
('New Finance', '2026-03-18', 'New-68', 'New-STL330', 'Arul M', 9626262427.0, NULL, NULL, 5000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 5000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL330-Arul M'),
('New Finance', '2026-03-20', 'New-69', 'New-STL231', 'Ramkumar', 9578562182.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 100000, 0, 'Closed', 'New-P7', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL231-Ramkumar'),
('New Finance', '2026-03-20', 'New-70', 'New-STL277', 'Jayaraj', 9788644477.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL277-Jayaraj'),
('New Finance', '2026-03-24', 'New-71', 'New-STL231', 'Ramkumar', 9578562182.0, NULL, NULL, 130000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 30000, 100000, 'Active', 'New-P7', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL231-Ramkumar'),
('New Finance', '2026-03-26', 'New-72', 'New-STL319', 'RanjithKumar', 9042090520.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL319-RanjithKumar'),
('New Finance', '2026-03-28', 'New-73', 'New-STL334', 'Vignesh Arun Kumba', 8973249929.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL334-Vignesh Arun Kumba'),
('New Finance', '2026-03-28', 'New-74', 'New-STL221', 'Tharun Tex', 8056834412.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 50000, 'Active', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL221-Tharun Tex'),
('New Finance', '2026-03-31', 'New-75', 'New-STL335', 'Durai Master Kumbaa', 6369910360.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P8', 'Cash', 'Arun Kumba party but in Ravi recommend, all details of bond and cheque with Arun Kumba', 'Per_Day', NULL, NULL, 'Existing', 'New-STL335-Durai Master Kumbaa'),
('Kannnan_Personal', '2026-03-01', 'Kan-76', 'Kan-STL2', 'Ashok Bro', 9791958906.0, NULL, NULL, 150000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 150000, 0, 'Closed', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL2-Ashok Bro'),
('Kannnan_Personal', '2026-03-01', 'Kan-77', 'Kan-STL4', 'Arun Lorry', 9626262427.0, NULL, NULL, 410000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 410000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL4-Arun Lorry'),
('Kannnan_Personal', '2026-03-24', 'Kan-78', 'Kan-STL40', 'Gokulnath', 8072395221.0, NULL, NULL, 20000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL40-Gokulnath'),
('Kannnan_Personal', '2026-03-01', 'Kan-79', 'Kan-STL49', 'Elango Sports', 9943831310.0, NULL, NULL, 60000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 30000, 30000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL49-Elango Sports'),
('Kannnan_Personal', '2026-03-01', 'Kan-80', 'Kan-STL60', 'Karthi China', 7373173783.0, NULL, NULL, 1000000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1000000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL60-Karthi China'),
('Kannnan_Personal', '2026-03-01', 'Kan-81', 'Kan-STL65', 'Sethu', 9842498218.0, NULL, NULL, 100000.0, 60.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL65-Sethu'),
('Kannnan_Personal', '2026-03-01', 'Kan-82', 'Kan-STL74', 'Rail Ragavan', 7550394660.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL74-Rail Ragavan'),
('Kannnan_Personal', '2026-03-01', 'Kan-83', 'Kan-STL75', 'Saravanan Bakery', 9715087870.0, NULL, NULL, 380000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 380000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL75-Saravanan Bakery'),
('Kannnan_Personal', '2026-03-01', 'Kan-84', 'Kan-STL95', 'Jayaprabha', 9500821444.0, NULL, NULL, 450000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 450000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL95-Jayaprabha'),
('Kannnan_Personal', '2026-03-01', 'Kan-85', 'Kan-STL103', 'Theena Aravind', 9894049151.0, NULL, NULL, 40000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 40000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL103-Theena Aravind'),
('Kannnan_Personal', '2026-03-01', 'Kan-86', 'Kan-STL108', 'Kavin Surrendar', 9025112544.0, NULL, NULL, 300000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 250000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL108-Kavin Surrendar'),
('Kannnan_Personal', '2026-03-01', 'Kan-87', 'Kan-STL123', 'Sridhar Aalves', 90475555591.0, NULL, NULL, 140000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 140000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL123-Sridhar Aalves'),
('Kannnan_Personal', '2026-03-01', 'Kan-88', 'Kan-STL129', 'Aravind Vasu', 9751519292.0, NULL, NULL, 293000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 293000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL129-Aravind Vasu'),
('Kannnan_Personal', '2026-03-01', 'Kan-89', 'Kan-STL139', 'Arun Kumba', 9894049151.0, NULL, NULL, 565000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 515000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL139-Arun Kumba'),
('Kannnan_Personal', '2026-03-01', 'Kan-90', 'Kan-STL153', 'Kanagaraj Chola', 9943829996.0, NULL, NULL, 140000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 140000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL153-Kanagaraj Chola'),
('Kannnan_Personal', '2026-03-01', 'Kan-91', 'Kan-STL154', 'Sudhakar', 7010493151.0, NULL, NULL, 180000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL154-Sudhakar'),
('Kannnan_Personal', '2026-03-01', 'Kan-92', 'Kan-STL155', 'Abdul Rahman', 9095650806.0, NULL, NULL, 20000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL155-Abdul Rahman'),
('Kannnan_Personal', '2026-03-01', 'Kan-93', 'Kan-STL161', 'Vijay', 8778588896.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL161-Vijay'),
('Kannnan_Personal', '2026-03-01', 'Kan-94', 'Kan-STL162', 'Karthi Oil', 9715406070.0, NULL, NULL, 40000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 40000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL162-Karthi Oil'),
('Kannnan_Personal', '2026-03-01', 'Kan-95', 'Kan-STL164', 'Viji Vasanth', 9344139371.0, NULL, NULL, 300000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Month', 2000.0, NULL, 'Existing', 'Kan-STL164-Viji Vasanth'),
('Kannnan_Personal', '2026-03-01', 'Kan-96', 'Kan-STL173', 'Venkat Pilot', 9585600378.0, NULL, NULL, 225000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 225000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL173-Venkat Pilot'),
('Kannnan_Personal', '2026-03-01', 'Kan-97', 'Kan-STL174', 'Sabarish', 9080753749.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL174-Sabarish'),
('Kannnan_Personal', '2026-03-01', 'Kan-98', 'Kan-STL177', 'Murugesan', 9787979779.0, NULL, NULL, 60000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL177-Murugesan'),
('Kannnan_Personal', '2026-03-01', 'Kan-99', 'Kan-STL182', 'John', 8946048074.0, NULL, NULL, 225000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 225000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL182-John'),
('Kannnan_Personal', '2026-03-01', 'Kan-100', 'Kan-STL184', 'Manoj', 8838114684.0, NULL, NULL, 500000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 500000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL184-Manoj');
insert into "Loan_Processing" ("Finance_Name", "Loan_Given_Date", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "Customer_Email", "Customer_Adhar_No", "Loan_Amount", "Interest_Per_day_Per_Lakh", "No_Bond_Received", "No_Chq_Received", "Attach1", "Attach2", "Photo1", "Photo2", "Repaid_Amount", "Outstand_Amount", "Loan_Status", "Referred_Partner", "Payment_Type", "Remarks", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days", "Customer_Type", "Customer_Ref") values
('Kannnan_Personal', '2026-03-01', 'Kan-101', 'Kan-STL187', 'Palanisamy Auto', 8883083604.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL187-Palanisamy Auto'),
('Kannnan_Personal', '2026-03-01', 'Kan-102', 'Kan-STL189', 'Vallarasu_Kumaravel', 9080753749.0, NULL, NULL, 80000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 80000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL189-Vallarasu_Kumaravel'),
('Kannnan_Personal', '2026-03-01', 'Kan-103', 'Kan-STL191', 'Govindhasamy', 9751747987.0, NULL, NULL, 65000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 65000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL191-Govindhasamy'),
('Kannnan_Personal', '2026-03-01', 'Kan-104', 'Kan-STL193', 'Saravanan Chola', 9943829996.0, NULL, NULL, 20000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL193-Saravanan Chola'),
('Kannnan_Personal', '2026-03-01', 'Kan-105', 'Kan-STL197', 'Guna', 9698733233.0, NULL, NULL, 300000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL197-Guna'),
('Kannnan_Personal', '2026-03-07', 'Kan-106', 'Kan-STL201', 'Maniraj', 9626279956.0, NULL, NULL, 300000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL201-Maniraj'),
('Kannnan_Personal', '2026-03-01', 'Kan-107', 'Kan-STL203', 'Dinesh', 7708121402.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL203-Dinesh'),
('Kannnan_Personal', '2026-03-01', 'Kan-108', 'Kan-STL205', 'Jeeva', 7200123452.0, NULL, NULL, 25000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 25000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL205-Jeeva'),
('Kannnan_Personal', '2026-03-01', 'Kan-109', 'Kan-STL206', 'Prabhakar', 6380232340.0, NULL, NULL, 40000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 40000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL206-Prabhakar'),
('Kannnan_Personal', '2026-03-01', 'Kan-110', 'Kan-STL211', 'Devaraj', 9629691014.0, NULL, NULL, 50000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL211-Devaraj'),
('Kannnan_Personal', '2026-03-01', 'Kan-111', 'Kan-STL212', 'Arumugam', 6374635641.0, NULL, NULL, 20000.0, 90.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL212-Arumugam'),
('Kannnan_Personal', '2026-03-01', 'Kan-112', 'Kan-STL215', 'Rekha', 8754896997.0, NULL, NULL, 40000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 40000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL215-Rekha'),
('Kannnan_Personal', '2026-03-01', 'Kan-113', 'Kan-STL216', 'Sasi Master', 9655400148.0, NULL, NULL, 20000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL216-Sasi Master'),
('Kannnan_Personal', '2026-03-01', 'Kan-114', 'Kan-STL217', 'Sathish Siva', 9994092494.0, NULL, NULL, 20000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL217-Sathish Siva'),
('Kannnan_Personal', '2026-03-01', 'Kan-115', 'Kan-STL218', 'Kongu Kochai', 9976592192.0, NULL, NULL, 170000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 170000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL218-Kongu Kochai'),
('Kannnan_Personal', '2026-03-13', 'Kan-116', 'Kan-STL219', 'Amutha Ashok', 9791958906.0, NULL, NULL, 1000000.0, 60.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1000000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL219-Amutha Ashok'),
('Kannnan_Personal', '2026-03-16', 'Kan-117', 'Kan-STL220', 'Prabhu', 7010012727.0, NULL, NULL, 250000.0, 60.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 250000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL220-Prabhu'),
('Kannnan_Personal', '2026-03-09', 'Kan-118', 'Kan-STL49', 'Elango Sports', 9943831310.0, NULL, NULL, 20000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL49-Elango Sports'),
('Kannnan_Personal', '2026-03-15', 'Kan-119', 'Kan-STL123', 'Sridhar Aalves', 90475555591.0, NULL, NULL, 20000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL123-Sridhar Aalves'),
('Kannnan_Personal', '2026-03-09', 'Kan-120', 'Kan-STL139', 'Arun Kumba', 9894049151.0, NULL, NULL, 30000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL139-Arun Kumba'),
('Kannnan_Personal', '2026-04-02', 'Kan-121', 'Kan-STL139', 'Arun Kumba', 9894049151.0, NULL, NULL, 10000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL139-Arun Kumba'),
('Kannnan_Personal', '2026-03-21', 'Kan-122', 'Kan-STL153', 'Kanagaraj Chola', 9943829996.0, NULL, NULL, 30000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30000, 'Active', 'Kan-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL153-Kanagaraj Chola'),
('Kannnan_Personal', '2026-03-01', 'Kan-123', 'Kan-STL74', 'Rail Ragavan', 7550394660.0, NULL, NULL, 10000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10000, 'Active', 'Kan-P1', 'UPI', 'Already 50k, now total 60k', 'Per_Day', NULL, NULL, 'Existing', NULL),
('Kannnan_Personal', '2026-04-15', 'Kan-124', 'Kan-STL206', 'Prabhakar', 6380232340.0, NULL, NULL, 20000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'Kan-P1', 'UPI', 'Total loan 60k', 'Per_Day', NULL, NULL, 'Existing', 'Kan-STL206-Prabhakar'),
('New Finance', '2026-04-02', 'New-125', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 150000, 'Active', 'New-P4', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL323-Kaviyarasu Arul'),
('New Finance', '2026-04-02', 'New-126', 'New-STL78', 'Dinesh', 9942153364.0, NULL, NULL, 10000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 10000, 0, 'Closed', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL78-Dinesh'),
('New Finance', '2026-04-13', 'New-127', 'New-STL227', 'Nandhakumar', 9361446918.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 150000, 'Active', 'New-P10', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL227-Nandhakumar'),
('New Finance', '2026-04-13', 'New-128', 'New-STL337', 'Karthi cake shop', 9787390814.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200000, 'Active', 'New-P4', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL337-Karthi cake shop'),
('New Finance', '2026-04-04', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618.0, NULL, NULL, 10000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL336-Manoj raghavendra shop'),
('New Finance', '2026-04-13', 'New-130', 'New-STL320', 'Priya', 9840807102.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL320-Priya'),
('New Finance', '2026-04-17', 'New-131', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P2', 'UPI', '55000 sent.', 'Per_Day', NULL, NULL, 'Existing', 'New-STL275-Balasubramani Suresh'),
('New Finance', '2026-04-18', 'New-132', 'New-STL271', 'Sundaravadivel', 8072211260.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL271-Sundaravadivel'),
('New Finance', '2026-04-20', 'New-133', 'New-STL338', 'Kaviraj', 9943341540.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 40000, 10000, 'Active', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL338-Kaviraj'),
('New Finance', '2026-04-25', 'New-134', 'New-STL306', 'Ravi', 9751277888.0, NULL, NULL, 20000.0, 80.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL306-Ravi'),
('New Finance', '2026-04-27', 'New-135', 'New-STL339', 'Surya Shed', 9787878005.0, NULL, NULL, 120000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL339-Surya Shed'),
('New Finance', '2026-04-30', 'New-136', 'New-STL339', 'Surya Shed', 9787878005.0, NULL, NULL, 20000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20000, 'Active', 'New-P2', 'UPI', 'Tharun sent 35k, 15k return to koli kodumudi', 'Per_Day', NULL, NULL, 'Existing', 'New-STL339-Surya Shed'),
('New Finance', '2026-05-01', 'New-137', 'New-STL318', 'Divakar', 8610561010.0, NULL, NULL, 10000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10000, 'Active', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL318-Divakar'),
('New Finance', '2026-05-05', 'New-138', 'New-STL235', 'Kannan', 9976592192.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL235-Kannan'),
('New Finance', '2026-05-13', 'New-139', 'New-STL340', 'Bala kaarthi', 9677843432.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200000, 'Active', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'New', 'New-STL340-Bala kaarthi'),
('New Finance', '2026-05-16', 'New-140', 'New-STL320', 'Priya', 9840807102.0, NULL, NULL, 150000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 150000, 0, 'Closed', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL320-Priya'),
('New Finance', '2026-05-28', 'New-141', 'New-STL341', 'Murugesan pons', 9942713540.0, NULL, NULL, 80000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 70000, 10000, 'Active', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'New', 'New-STL341-Murugesan pons'),
('New Finance', '2026-05-25', 'New-142', 'New-STL342', 'Jeyaraj pons', 9788644477.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 50000, 0, 'Closed', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL342-Jeyaraj pons'),
('New Finance', '2026-06-01', 'New-143', 'New-STL341', 'Murugesan pons', 9942713540.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL341-Murugesan pons'),
('New Finance', '2026-06-01', 'New-144', 'New-STL320', 'Priya', 9840807102.0, NULL, NULL, 140000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 140000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL320-Priya'),
('New Finance', '2026-06-05', 'New-145', 'New-STL343', 'Prakash S M', 9865388000.0, NULL, NULL, 80000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 80000, 'Active', 'New-P6', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL343-Prakash S M'),
('New Finance', '2026-06-01', 'New-146', 'New-STL116', 'Vasudevan', 9751519191.0, NULL, NULL, 35000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 35000, 'Active', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL116-Vasudevan'),
('New Finance', '2026-06-10', 'New-147', 'New-STL116', 'Vasudevan', 9751519191.0, NULL, NULL, 60000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60000, 'Active', 'New-P9', 'Cash', 'Gold Chain', 'Per_Day', NULL, NULL, 'Existing', 'New-STL116-Vasudevan'),
('New Finance', '2026-06-13', 'New-148', 'New-STL339', 'Surya Shed', 9787878005.0, NULL, NULL, 350000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 350000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL339-Surya Shed'),
('New Finance', '2026-06-15', 'New-149', 'New-STL344', 'Suresh CCTV', 8861715281.0, NULL, NULL, 50000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL344-Suresh CCTV'),
('New Finance', '2026-06-22', 'New-150', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL275-Balasubramani Suresh'),
('New Finance', '2026-06-16', 'New-151', 'New-STL301', 'Nagaraj Post', 9150787857.0, NULL, NULL, 10000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10000, 'Active', 'New-P2', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL301-Nagaraj Post'),
('New Finance', '2026-06-01', 'New-152', 'New-STL116', 'Vasudevan', 9751519191.0, NULL, NULL, 30000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30000, 'Active', 'New-P9', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL116-Vasudevan'),
('New Finance', '2026-07-01', 'New-153', 'New-STL270', 'Arul S', 8940864888.0, NULL, NULL, 40000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 40000, 'Active', 'New-P1', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL270-Arul S'),
('New Finance', '2026-07-01', 'New-154', 'New-STL306', 'Ravi', 9751277888.0, NULL, NULL, 75000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 75000, 0, 'Closed', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL306-Ravi'),
('New Finance', '2026-07-01', 'New-155', 'New-STL280', 'Sabarish', 9080753749.0, NULL, NULL, 25000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 25000, 'Active', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL280-Sabarish'),
('New Finance', '2026-07-07', 'New-156', 'New-STL345', 'Kamaraj Prakash', 9600996663.0, NULL, NULL, 50000.0, 70.0, '1', NULL, NULL, NULL, NULL, NULL, 0, 50000, 'Active', 'New-P6', 'Cash', 'Given in prakash finance', 'Per_Day', NULL, NULL, 'Existing', 'New-STL345-Kamaraj Prakash'),
('New Finance', '2026-07-10', 'New-157', 'New-STL326', 'Murugesan', 7373932218.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 0, 'Closed', 'New-P8', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL326-Murugesan'),
('New Finance', '2026-07-13', 'New-158', 'New-STL346', 'Gopal post', 8838723676.0, NULL, NULL, 250000.0, 70.0, '2', '1 IPPB', NULL, NULL, NULL, NULL, 0, 250000, 'Active', 'New-P2', 'Cash', 'Total 5 lacs, 2.5 in my personal', 'Per_Day', NULL, NULL, 'Existing', 'New-STL346-Gopal post'),
('New Finance', '2026-07-15', 'New-159', 'New-STL347', 'Vinoth Ravi vangalamman', 8122484554.0, NULL, NULL, 250000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 250000, 0, 'Closed', 'New-P3', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL347-Vinoth Ravi vangalamman'),
('New Finance', '2026-07-18', 'New-160', 'New-STL341', 'Murugesan pons', 9942713540.0, NULL, NULL, 15000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 15000, 'Active', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL341-Murugesan pons'),
('New Finance', '2026-07-23', 'New-161', 'New-STL348', 'Gobinath', 9597539696.0, NULL, NULL, 200000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 200000, 'Active', 'New-P3', 'Cash', 'Naveen Arun Kumbaa', 'Per_Day', NULL, NULL, 'Existing', 'New-STL348-Gobinath'),
('New Finance', '2026-07-25', 'New-162', 'New-STL304', 'Sakthivel Jayaraj', 9943013586.0, NULL, NULL, 100000.0, 70.0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Active', 'New-P5', 'Cash', NULL, 'Per_Day', NULL, NULL, 'Existing', 'New-STL304-Sakthivel Jayaraj');

delete from "Interest_Details" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "Interest_Details" ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days") values
('Sankara Narayanan-New-STL179-New-1-300000-Interest-02-2026', 'New Finance', 'New-1', 'New-STL179', 'Sankara Narayanan', 9003333055.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 5880.0, 300000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 5880, 'Paid', 0, 'New-P1', 0, 'Yes', 5880, 0.0, 'Per_Day', NULL, 28.0),
('Arul S-New-STL270-New-3-150000-Interest-02-2026', 'New Finance', 'New-3', 'New-STL270', 'Arul S', 8940864888.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1230.0, 150000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1230, 'Paid', 0, 'New-P1', 0, 'Yes', 1230, 0.0, 'Per_Day', NULL, 28.0),
('Rangis-New-STL295-New-4-100000-Interest-02-2026', 'New Finance', 'New-4', 'New-STL295', 'Rangis', 9443732655.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1960.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1960, 'Paid', 0, 'New-P1', 0, 'Yes', 1960, 0.0, 'Per_Day', NULL, 28.0),
('RanjithKumar-New-STL319-New-5-250000-Interest-02-2026', 'New Finance', 'New-5', 'New-STL319', 'RanjithKumar', 9042090520.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 4310.0, 250000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 4310, 'Paid', 0, 'New-P1', 0, 'Yes', 4310, 0.0, 'Per_Day', NULL, 28.0),
('Pradeep-New-STL67-New-6-150000-Interest-02-2026', 'New Finance', 'New-6', 'New-STL67', 'Pradeep', 9626262427.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 2940.0, 150000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 2940, 'Paid', 0, 'New-P2', 0, 'Yes', 2940, 0.0, 'Per_Day', NULL, 28.0),
('Ramasamy Divya-New-STL156-New-7-50000-Interest-02-2026', 'New Finance', 'New-7', 'New-STL156', 'Ramasamy Divya', 9894465610.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 980.0, 50000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 980, 'Paid', 0, 'New-P2', 0, 'Yes', 980, 0.0, 'Per_Day', NULL, 28.0),
('Kaviyarasu-New-STL252-New-8-350000-Interest-02-2026', 'New Finance', 'New-8', 'New-STL252', 'Kaviyarasu', 9629998999.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 6860.0, 350000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 6860, 'Paid', 0, 'New-P2', 0, 'Yes', 6860, 0.0, 'Per_Day', NULL, 28.0),
('Sundaravadivel-New-STL271-New-9-50000-Interest-02-2026', 'New Finance', 'New-9', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 980.0, 50000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 980, 'Paid', 0, 'New-P2', 0, 'Yes', 980, 0.0, 'Per_Day', NULL, 28.0),
('Balasubramani Suresh-New-STL275-New-10-200000-Interest-02-2026', 'New Finance', 'New-10', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 3920.0, 200000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 3920, 'Paid', 0, 'New-P2', 0, 'Yes', 3920, 0.0, 'Per_Day', NULL, 28.0),
('Nagaraj Post-New-STL301-New-11-30000-Interest-02-2026', 'New Finance', 'New-11', 'New-STL301', 'Nagaraj Post', 9150787857.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 590.0, 30000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 590, 'Paid', 0, 'New-P2', 0, 'Yes', 590, 0.0, 'Per_Day', NULL, 28.0),
('Priya-New-STL320-New-12-100000-Interest-02-2026', 'New Finance', 'New-12', 'New-STL320', 'Priya', 9840807102.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 960.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 960, 'Paid', 0, 'New-P2', 0, 'Yes', 960, 0.0, 'Per_Day', NULL, 28.0),
('Arul M-New-STL330-New-13-35000-Interest-02-2026', 'New Finance', 'New-13', 'New-STL330', 'Arul M', 9626262427.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 780.0, 35000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 780, 'Paid', 0, 'New-P2', 0, 'Yes', 780, 0.0, 'Per_Day', NULL, 28.0),
('John-New-STL292-New-14-150000-Interest-02-2026', 'New Finance', 'New-14', 'New-STL292', 'John', 7418824749.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 2940.0, 150000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 2940, 'Paid', 0, 'New-P3', 0, 'Yes', 2940, 0.0, 'Per_Day', NULL, 28.0),
('Tharun-New-STL303-New-15-50000-Interest-02-2026', 'New Finance', 'New-15', 'New-STL303', 'Tharun', 9843722055.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1120.0, 50000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1120, 'Paid', 0, 'New-P3', 0, 'Yes', 1120, 0.0, 'Per_Day', NULL, 28.0),
('Praveen Ram-New-STL324-New-16-80000-Interest-02-2026', 'New Finance', 'New-16', 'New-STL324', 'Praveen Ram', 9715778326.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1570.0, 80000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1570, 'Paid', 0, 'New-P3', 0, 'Yes', 1570, 0.0, 'Per_Day', NULL, 28.0),
('Kongu Kochai-New-STL329-New-17-200000-Interest-02-2026', 'New Finance', 'New-17', 'New-STL329', 'Kongu Kochai', 9976592192.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 3920.0, 200000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 3920, 'Paid', 0, 'New-P3', 0, 'Yes', 3920, 0.0, 'Per_Day', NULL, 28.0),
('Sakthivel-New-STL332-New-18-300000-Interest-02-2026', 'New Finance', 'New-18', 'New-STL332', 'Sakthivel', 9003755903.0, '2026-02-01', '2026-02-28', '2026-02-27', 2.0, '70.0', 420.0, 300000.0, '2026-02-27', '02-2026', 'Interest-02-2026', 420, 'Paid', 0, 'New-P3', 0, 'Yes', 420, 0.0, 'Per_Day', NULL, 28.0),
('Dinesh-New-STL78-New-19-400000-Interest-02-2026', 'New Finance', 'New-19', 'New-STL78', 'Dinesh', 9942153364.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 790.0, 40000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 790, 'Paid', 0, 'New-P5', 0, 'Yes', 790, 0.0, 'Per_Day', NULL, 28.0),
('Jayapal-New-STL121-New-20-100000-Interest-02-2026', 'New Finance', 'New-20', 'New-STL121', 'Jayapal', 9788544477.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1960.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1960, 'Paid', 0, 'New-P5', 0, 'Yes', 1960, 0.0, 'Per_Day', NULL, 28.0),
('Udhayakumar-New-STL126-New-21-180000-Interest-02-2026', 'New Finance', 'New-21', 'New-STL126', 'Udhayakumar', 9965656493.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 3530.0, 180000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 3530, 'Paid', 0, 'New-P5', 0, 'Yes', 3530, 0.0, 'Per_Day', NULL, 28.0),
('Boopathy Crane-New-STL217-New-22-30000-Interest-02-2026', 'New Finance', 'New-22', 'New-STL217', 'Boopathy Crane', 9159296091.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 670.0, 30000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 670, 'Paid', 0, 'New-P5', 0, 'Yes', 670, 0.0, 'Per_Day', NULL, 28.0),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-02-2026', 'New Finance', 'New-23', 'New-STL273', 'Suresh Abudhabi', 7200035939.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1180.0, 60000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1180, 'Paid', 0, 'New-P5', 0, 'Yes', 1180, 0.0, 'Per_Day', NULL, 28.0),
('Jayaraj-New-STL277-New-24-50000-Interest-02-2026', 'New Finance', 'New-24', 'New-STL277', 'Jayaraj', 9788644477.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 980.0, 50000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 980, 'Paid', 0, 'New-P5', 0, 'Yes', 980, 0.0, 'Per_Day', NULL, 28.0),
('Yagappan-New-STL278-New-25-20000-Interest-02-2026', 'New Finance', 'New-25', 'New-STL278', 'Yagappan', 8248805311.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 450.0, 20000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 450, 'Paid', 0, 'New-P5', 0, 'Yes', 450, 0.0, 'Per_Day', NULL, 28.0),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-02-2026', 'New Finance', 'New-26', 'New-STL304', 'Sakthivel Jayaraj', 9943013586.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1750.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1750, 'Paid', 0, 'New-P5', 0, 'Yes', 1750, 0.0, 'Per_Day', NULL, 28.0),
('Mahesh-New-STL308-New-27-50000-Interest-02-2026', 'New Finance', 'New-27', 'New-STL308', 'Mahesh', 9080383024.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 980.0, 50000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 980, 'Paid', 0, 'New-P5', 0, 'Yes', 980, 0.0, 'Per_Day', NULL, 28.0),
('Kaviyarasu Arul-New-STL323-New-28-800000-Interest-02-2026', 'New Finance', 'New-28', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 13860.0, 800000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 13860, 'Paid', 0, 'New-P4', 0, 'Yes', 13860, 0.0, 'Per_Day', NULL, 28.0),
('Danendran-New-STL46-New-29-95000-Interest-02-2026', 'New Finance', 'New-29', 'New-STL46', 'Danendran', 9865388000.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1860.0, 95000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1860, 'Paid', 0, 'New-P6', 0, 'Yes', 1860, 0.0, 'Per_Day', NULL, 28.0),
('Rajendran-New-STL58-New-30-15000-Interest-02-2026', 'New Finance', 'New-30', 'New-STL58', 'Rajendran', 9865388000.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 340.0, 15000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 340, 'Paid', 0, 'New-P6', 0, 'Yes', 340, 0.0, 'Per_Day', NULL, 28.0),
('Karnan-New-STL160-New-31-400000-Interest-02-2026', 'New Finance', 'New-31', 'New-STL160', 'Karnan', 9789502425.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 7840.0, 400000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 7840, 'Paid', 0, 'New-P6', 0, 'Yes', 7840, 0.0, 'Per_Day', NULL, 28.0),
('Vinoth-New-STL262-New-32-50000-Interest-02-2026', 'New Finance', 'New-32', 'New-STL262', 'Vinoth', 9047015007.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 980.0, 50000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 980, 'Paid', 0, 'New-P6', 0, 'Yes', 980, 0.0, 'Per_Day', NULL, 28.0),
('Ashok-New-STL282-New-33-15000-Interest-02-2026', 'New Finance', 'New-33', 'New-STL282', 'Ashok', 7708880250.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 340.0, 15000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 340, 'Paid', 0, 'New-P6', 0, 'Yes', 340, 0.0, 'Per_Day', NULL, 28.0),
('Mariyammal-New-STL297-New-34-100000-Interest-02-2026', 'New Finance', 'New-34', 'New-STL297', 'Mariyammal', 9952102163.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1960.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1960, 'Paid', 0, 'New-P6', 0, 'Yes', 1960, 0.0, 'Per_Day', NULL, 28.0),
('Ramkumar-New-STL231-New-35-200000-Interest-02-2026', 'New Finance', 'New-35', 'New-STL231', 'Ramkumar', 9578562182.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 3920.0, 200000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 3920, 'Paid', 0, 'New-P7', 0, 'Yes', 3920, 0.0, 'Per_Day', NULL, 28.0),
('Kannan-New-STL235-New-36-215000-Interest-02-2026', 'New Finance', 'New-36', 'New-STL235', 'Kannan', 9976592192.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 4210.0, 215000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 4210, 'Paid', 0, 'New-P3', 0, 'Yes', 4210, 0.0, 'Per_Day', NULL, 28.0),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-02-2026', 'New Finance', 'New-37', 'New-STL263', 'Sakthivel Broker', 9443835225.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1960.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1960, 'Paid', 0, 'New-P7', 0, 'Yes', 1960, 0.0, 'Per_Day', NULL, 28.0),
('Sabarish-New-STL280-New-38-200000-Interest-02-2026', 'New Finance', 'New-38', 'New-STL280', 'Sabarish', 9080753749.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 3640.0, 200000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 3640, 'Paid', 0, 'New-P3', 0, 'Yes', 3640, 0.0, 'Per_Day', NULL, 28.0),
('Moorthy-New-STL312-New-39-50000-Interest-02-2026', 'New Finance', 'New-39', 'New-STL312', 'Moorthy', 9578562182.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 980.0, 50000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 980, 'Paid', 0, 'New-P7', 0, 'Yes', 980, 0.0, 'Per_Day', NULL, 28.0),
('Shanmugam-New-STL139-New-40-30000-Interest-02-2026', 'New Finance', 'New-40', 'New-STL139', 'Shanmugam', 9943519663.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 670.0, 30000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 670, 'Paid', 0, 'New-P8', 0, 'Yes', 670, 0.0, 'Per_Day', NULL, 28.0),
('Manivannan-New-STL182-New-41-300000-Interest-02-2026', 'New Finance', 'New-41', 'New-STL182', 'Manivannan', 9715884248.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 5880.0, 300000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 5880, 'Paid', 0, 'New-P8', 0, 'Yes', 5880, 0.0, 'Per_Day', NULL, 28.0),
('Ramprakash-New-STL234-New-42-55000-Interest-02-2026', 'New Finance', 'New-42', 'New-STL234', 'Ramprakash', 9003525303.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1080.0, 55000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1080, 'Paid', 0, 'New-P8', 0, 'Yes', 1080, 0.0, 'Per_Day', NULL, 28.0),
('Murugesan-New-STL326-New-43-20000-Interest-02-2026', 'New Finance', 'New-43', 'New-STL326', 'Murugesan', 7373932218.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 450.0, 20000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 450, 'Paid', 0, 'New-P8', 0, 'Yes', 450, 0.0, 'Per_Day', NULL, 28.0),
('Kalimuthu-New-STL248-New-44-50000-Interest-02-2026', 'New Finance', 'New-44', 'New-STL248', 'Kalimuthu', 9047042275.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 980.0, 50000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 980, 'Paid', 0, 'New-P8', 0, 'Yes', 980, 0.0, 'Per_Day', NULL, 28.0),
('Ravi-New-STL306-New-45-200000-Interest-02-2026', 'New Finance', 'New-45', 'New-STL306', 'Ravi', 9751277888.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 3920.0, 200000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 3920, 'Paid', 0, 'New-P8', 0, 'Yes', 3920, 0.0, 'Per_Day', NULL, 28.0),
('Selvaguru-New-STL35-New-46-150000-Interest-02-2026', 'New Finance', 'New-46', 'New-STL35', 'Selvaguru', 9786177888.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 2740.0, 150000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 2740, 'Paid', 0, 'New-P9', 0, 'Yes', 2740, 0.0, 'Per_Day', NULL, 28.0),
('Vasudevan-New-STL116-New-47-450000-Interest-02-2026', 'New Finance', 'New-47', 'New-STL116', 'Vasudevan', 9751519191.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 8820.0, 450000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 8820, 'Paid', 0, 'New-P9', 0, 'Yes', 8820, 0.0, 'Per_Day', NULL, 28.0),
('Paramasivam-New-STL153-New-48-35000-Interest-02-2026', 'New Finance', 'New-48', 'New-STL153', 'Paramasivam', 9364455525.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 780.0, 35000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 780, 'Paid', 0, 'New-P9', 0, 'Yes', 780, 0.0, 'Per_Day', NULL, 28.0),
('Karthick-New-STL185-New-49-20000-Interest-02-2026', 'New Finance', 'New-49', 'New-STL185', 'Karthick', 9751519191.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 450.0, 20000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 450, 'Paid', 0, 'New-P9', 0, 'Yes', 450, 0.0, 'Per_Day', NULL, 28.0),
('Manikandan-New-STL195-New-50-50000-Interest-02-2026', 'New Finance', 'New-50', 'New-STL195', 'Manikandan', 9751519191.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 980.0, 50000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 980, 'Paid', 0, 'New-P9', 0, 'Yes', 980, 0.0, 'Per_Day', NULL, 28.0),
('Pradeep-New-STL123-New-51-100000-Interest-02-2026', 'New Finance', 'New-51', 'New-STL123', 'Pradeep_NPA', 9751519191.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1960.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1960, 'Paid', 0, 'New-P9', 0, 'Yes', 1960, 0.0, 'Per_Day', NULL, 28.0),
('Logambal-New-STL283-New-52-100000-Interest-02-2026', 'New Finance', 'New-52', 'New-STL283', 'Logambal', 8056834412.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1790.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1790, 'Paid', 0, 'New-P9', 0, 'Yes', 1790, 0.0, 'Per_Day', NULL, 28.0),
('Divakar-New-STL318-New-53-25000-Interest-02-2026', 'New Finance', 'New-53', 'New-STL318', 'Divakar', 8610561010.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 560.0, 25000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 560, 'Paid', 0, 'New-P9', 0, 'Yes', 560, 0.0, 'Per_Day', NULL, 28.0),
('Muniyappan-New-STL150-New-54-100000-Interest-02-2026', 'New Finance', 'New-54', 'New-STL150', 'Muniyappan', 9159214139.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1960.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1960, 'Paid', 0, 'New-P10', 0, 'Yes', 1960, 0.0, 'Per_Day', NULL, 28.0),
('Shanmugaraj-New-STL151-New-55-300000-Interest-02-2026', 'New Finance', 'New-55', 'New-STL151', 'Shanmugaraj', 9443781565.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 5880.0, 300000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 5880, 'Paid', 0, 'New-P10', 0, 'Yes', 5880, 0.0, 'Per_Day', NULL, 28.0),
('Nandhakumar-New-STL227-New-56-100000-Interest-02-2026', 'New Finance', 'New-56', 'New-STL227', 'Nandhakumar', 9361446918.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1960.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1960, 'Paid', 0, 'New-P10', 0, 'Yes', 1960, 0.0, 'Per_Day', NULL, 28.0),
('Vignesh-New-STL260-New-57-100000-Interest-02-2026', 'New Finance', 'New-57', 'New-STL260', 'Vignesh', 9751707865.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 1960.0, 100000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 1960, 'Paid', 0, 'New-P10', 0, 'Yes', 1960, 0.0, 'Per_Day', NULL, 28.0),
('Anand-New-STL274-New-58-20000-Interest-02-2026', 'New Finance', 'New-58', 'New-STL274', 'Anand', 7695808377.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 450.0, 20000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 450, 'Paid', 0, 'New-P10', 0, 'Yes', 450, 0.0, 'Per_Day', NULL, 28.0),
('Subramani-New-STL287-New-59-150000-Interest-02-2026', 'New Finance', 'New-59', 'New-STL287', 'Subramani', 9003446318.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '70.0', 2940.0, 150000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 2940, 'Paid', 0, 'New-P10', 0, 'Yes', 2940, 0.0, 'Per_Day', NULL, 28.0),
('Nagurammal-New-STL331-New-60-150000-Interest-02-2026', 'New Finance', 'New-60', 'New-STL331', 'Nagurammal', 9786870661.0, '2026-02-01', '2026-02-28', '2026-02-05', 24.0, '70.0', 2520.0, 150000.0, '2026-02-05', '02-2026', 'Interest-02-2026', 2520, 'Paid', 0, 'New-P10', 0, 'Yes', 2520, 0.0, 'Per_Day', NULL, 28.0),
('Ramesh-New-STL257-New-2-30000-Interest-02-2026', 'New Finance', 'New-2', 'New-STL257', 'Ramesh', 8072765170.0, '2026-02-01', '2026-02-28', '2026-02-01', 28.0, '80.0', 770.0, 30000.0, '2026-02-01', '02-2026', 'Interest-02-2026', 770, 'Paid', 0, 'New-P1', 0, 'Yes', 770, 0.0, 'Per_Day', NULL, 28.0),
('Arul S-New-STL270-New-3-50000-Interest-03-2026', 'New Finance', 'New-3', 'New-STL270', 'Arul S', 8940864888.0, '2026-03-01', '2026-03-03', '2026-03-01', 3.0, '70.0', 110, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 110, 'Paid', 0, 'New-P1', 0, 'Yes', 2280, 0.0, 'Per_Day', NULL, 3.0),
('Priya-New-STL320-New-12-100000-Interest-03-2026', 'New Finance', 'New-12', 'New-STL320', 'Priya', 9840807102.0, '2026-03-01', '2026-03-04', '2026-03-01', 3.0, '70.0', 210, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 210, 'Paid', 0, 'New-P2', 0, 'Yes', 1470, 0.0, 'Per_Day', NULL, 3.0),
('Tharun-New-STL303-New-15-50000-Interest-03-2026', 'New Finance', 'New-15', 'New-STL303', 'Tharun', 9843722055.0, '2026-03-01', '2026-03-04', '2026-03-01', 4.0, '70.0', 140, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 140, 'Paid', 0, 'New-P3', 0, 'Yes', 920, 0.0, 'Per_Day', NULL, 4.0),
('Udhayakumar-New-STL126-New-21-50000-Interest-03-2026', 'New Finance', 'New-21', 'New-STL126', 'Udhayakumar', 9965656493.0, '2026-03-01', '2026-03-06', '2026-03-01', 6.0, '70.0', 210, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 210, 'Paid', 0, 'New-P5', 0, 'Yes', 3030, 0.0, 'Per_Day', NULL, 6.0),
('Sakthivel-New-STL332-New-18-300000-Interest-03-2026', 'New Finance', 'New-18', 'New-STL332', 'Sakthivel', 9003755903.0, '2026-03-01', '2026-03-06', '2026-03-01', 6.0, '70.0', 1260, 300000.0, '2026-02-27', '03-2026', 'Interest-03-2026', 1260, 'Paid', 0, 'New-P3', 0, 'Yes', 1260, 0.0, 'Per_Day', NULL, 6.0),
('Kaviyarasu-New-STL252-New-8-200000-Interest-03-2026', 'New Finance', 'New-8', 'New-STL252', 'Kaviyarasu', 9629998999.0, '2026-03-01', '2026-03-10', '2026-03-01', 10.0, '70.0', 1400, 200000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1400, 'Paid', 0, 'New-P2', 0, 'Yes', 3220, 0.0, 'Per_Day', NULL, 10.0),
('Kaviyarasu-New-STL252-New-8-50000-Interest-03-2026', 'New Finance', 'New-8', 'New-STL252', 'Kaviyarasu', 9629998999.0, '2026-03-01', '2026-03-12', '2026-03-01', 12.0, '70.0', 420, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 420, 'Paid', 0, 'New-P2', 0, 'No', 3220, 0.0, 'Per_Day', NULL, 12.0),
('RanjithKumar-New-STL319-New-5-50000-Interest-03-2026', 'New Finance', 'New-5', 'New-STL319', 'RanjithKumar', 9042090520.0, '2026-03-01', '2026-03-18', '2026-03-01', 18.0, '70.0', 630, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 630, 'Paid', 0, 'New-P1', 0, 'Yes', 3430, 0.0, 'Per_Day', NULL, 18.0),
('Kaviyarasu-New-STL252-New-8-100000-Interest-03-2026', 'New Finance', 'New-8', 'New-STL252', 'Kaviyarasu', 9629998999.0, '2026-03-01', '2026-03-20', '2026-03-01', 20.0, '70.0', 1400, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1400, 'Paid', 0, 'New-P2', 0, 'No', 3220, 0.0, 'Per_Day', NULL, 20.0),
('Jayaraj-New-STL277-New-70-200000-Interest-03-2026', 'New Finance', 'New-70', 'New-STL277', 'Jayaraj', 9788644477.0, '2026-03-01', '2026-03-22', '2026-03-20', 3.0, '70.0', 420, 200000.0, '2026-03-20', '03-2026', 'Interest-03-2026', 420, 'Paid', 0, 'New-P5', 0, 'Yes', 1230, 0.0, 'Per_Day', NULL, 22.0),
('Kaviyarasu Arul-New-STL323-New-28-50000-Interest-03-2026', 'New Finance', 'New-28', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, '2026-03-01', '2026-03-25', '2026-03-01', 25.0, '70.0', 870.0, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 870, 'Paid', 0, 'New-P4', 0, 'Yes', 17150, 0.0, 'Per_Day', NULL, 25.0),
('Ravi-New-STL306-New-45-100000-Interest-03-2026', 'New Finance', 'New-45', 'New-STL306', 'Ravi', 9751277888.0, '2026-03-01', '2026-03-27', '2026-03-01', 27.0, '70.0', 1890, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1890, 'Paid', 0, 'New-P8', 0, 'Yes', 4050, 0.0, 'Per_Day', NULL, 27.0),
('Jayaraj-New-STL277-New-24-50000-Interest-03-2026', 'New Finance', 'New-24', 'New-STL277', 'Jayaraj', 9788644477.0, '2026-03-01', '2026-03-23', '2026-03-01', 23.0, '70.0', 810, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 810, 'Paid', 0, 'New-P5', 0, 'No', 1230, 0.0, 'Per_Day', NULL, 23.0),
('Ravi-New-STL306-New-45-25000-Interest-03-2026', 'New Finance', 'New-45', 'New-STL306', 'Ravi', 9751277888.0, '2026-03-01', '2026-03-30', '2026-03-01', 30.0, '70.0', 530, 25000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 530, 'Paid', 0, 'New-P8', 0, 'No', 4050, 0.0, 'Per_Day', NULL, 30.0),
('RanjithKumar-New-STL319-New-5-200000-Interest-03-2026', 'New Finance', 'New-5', 'New-STL319', 'RanjithKumar', 9042090520.0, '2026-03-01', '2026-03-14', '2026-03-01', 14.0, '70.0', 1960, 200000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1960, 'Paid', 0, 'New-P1', 0, 'No', 3430, 0.0, 'Per_Day', NULL, 14.0),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-03-2026', 'New Finance', 'New-1', 'New-STL179', 'Sankara Narayanan', 9003333055.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 6510, 300000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 6510, 'Paid', 0, 'New-P1', 0, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Ramesh-New-STL257-New-2-30000-Interest-03-2026', 'New Finance', 'New-2', 'New-STL257', 'Ramesh', 8072765170.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 750.0, 30000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 750, 'Paid', 0, 'New-P1', 0, 'Yes', 750, 0.0, 'Per_Day', NULL, 31.0),
('Arul S-New-STL270-New-3-100000-Interest-03-2026', 'New Finance', 'New-3', 'New-STL270', 'Arul S', 8940864888.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P1', 0, 'No', 2280, 0.0, 'Per_Day', NULL, 31.0),
('Rangis-New-STL295-New-4-100000-Interest-03-2026', 'New Finance', 'New-4', 'New-STL295', 'Rangis', 9443732655.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P1', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Pradeep-New-STL67-New-6-150000-Interest-03-2026', 'New Finance', 'New-6', 'New-STL67', 'Pradeep', 9626262427.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3260, 150000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 3260, 'Paid', 0, 'New-P2', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Ramasamy Divya-New-STL156-New-7-50000-Interest-03-2026', 'New Finance', 'New-7', 'New-STL156', 'Ramasamy Divya', 9894465610.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1090, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1090, 'Paid', 0, 'New-P2', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Sundaravadivel-New-STL271-New-9-50000-Interest-03-2026', 'New Finance', 'New-9', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1090, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1090, 'Paid', 0, 'New-P2', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Balasubramani Suresh-New-STL275-New-10-200000-Interest-03-2026', 'New Finance', 'New-10', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 4340, 200000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 4340, 'Paid', 0, 'New-P2', 0, 'Yes', 5040, 0.0, 'Per_Day', NULL, 31.0),
('Nagaraj Post-New-STL301-New-11-30000-Interest-03-2026', 'New Finance', 'New-11', 'New-STL301', 'Nagaraj Post', 9150787857.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 750.0, 30000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 750, 'Paid', 0, 'New-P2', 0, 'Yes', 750, 0.0, 'Per_Day', NULL, 31.0),
('Arul M-New-STL330-New-13-35000-Interest-03-2026', 'New Finance', 'New-13', 'New-STL330', 'Arul M', 9626262427.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 870, 35000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 870, 'Paid', 0, 'New-P2', 0, 'Yes', 1179, 0.0, 'Per_Day', NULL, 31.0),
('John-New-STL292-New-14-150000-Interest-03-2026', 'New Finance', 'New-14', 'New-STL292', 'John', 7418824749.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3260, 150000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 3260, 'Paid', 0, 'New-P3', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Praveen Ram-New-STL324-New-16-80000-Interest-03-2026', 'New Finance', 'New-16', 'New-STL324', 'Praveen Ram', 9715778326.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1740, 80000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1740, 'Paid', 0, 'New-P3', 0, 'Yes', 1740, 0.0, 'Per_Day', NULL, 31.0),
('Kongu Kochai-New-STL329-New-17-200000-Interest-03-2026', 'New Finance', 'New-17', 'New-STL329', 'Kongu Kochai', 9976592192.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 4340, 200000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 4340, 'Paid', 0, 'New-P3', 0, 'Yes', 4340, 0.0, 'Per_Day', NULL, 31.0),
('Dinesh-New-STL78-New-19-30000-Interest-03-2026', 'New Finance', 'New-19', 'New-STL78', 'Dinesh', 9942153364.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 660.0, 30000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 660, 'Paid', 0, 'New-P5', -10, 'Yes', 650, 0.0, 'Per_Day', NULL, 31.0),
('Jayapal-New-STL121-New-20-100000-Interest-03-2026', 'New Finance', 'New-20', 'New-STL121', 'Jayapal', 9788544477.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P5', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Udhayakumar-New-STL126-New-21-130000-Interest-03-2026', 'New Finance', 'New-21', 'New-STL126', 'Udhayakumar', 9965656493.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2820, 130000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2820, 'Paid', 0, 'New-P5', 0, 'No', 3030, 0.0, 'Per_Day', NULL, 31.0),
('Boopathy Crane-New-STL217-New-22-30000-Interest-03-2026', 'New Finance', 'New-22', 'New-STL217', 'Boopathy Crane', 9159296091.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 750.0, 30000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 750, 'Paid', 0, 'New-P5', 0, 'Yes', 750, 0.0, 'Per_Day', NULL, 31.0),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-03-2026', 'New Finance', 'New-23', 'New-STL273', 'Suresh Abudhabi', 7200035939.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1300, 60000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1300, 'Paid', 0, 'New-P5', 0, 'Yes', 1300, 0.0, 'Per_Day', NULL, 31.0),
('Yagappan-New-STL278-New-25-20000-Interest-03-2026', 'New Finance', 'New-25', 'New-STL278', 'Yagappan', 8248805311.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 500, 20000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 500, 'Paid', 0, 'New-P5', 0, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-03-2026', 'New Finance', 'New-26', 'New-STL304', 'Sakthivel Jayaraj', 9943013586.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P5', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Mahesh-New-STL308-New-27-50000-Interest-03-2026', 'New Finance', 'New-27', 'New-STL308', 'Mahesh', NULL, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1090, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1090, 'Paid', 0, 'New-P5', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Kaviyarasu Arul-New-STL323-New-28-750000-Interest-03-2026', 'New Finance', 'New-28', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 16280, 750000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 16280, 'Paid', 0, 'New-P4', 0, 'No', 17150, 0.0, 'Per_Day', NULL, 31.0),
('Danendran-New-STL46-New-29-95000-Interest-03-2026', 'New Finance', 'New-29', 'New-STL46', 'Danendran', 9865388000.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2060, 95000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2060, 'Paid', 0, 'New-P6', 0, 'Yes', 2060, 0.0, 'Per_Day', NULL, 31.0),
('Rajendran-New-STL58-New-30-15000-Interest-03-2026', 'New Finance', 'New-30', 'New-STL58', 'Rajendran', 9865388000.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 370, 15000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 370, 'Paid', 0, 'New-P6', 0, 'Yes', 370, 0.0, 'Per_Day', NULL, 31.0),
('Karnan-New-STL160-New-31-400000-Interest-03-2026', 'New Finance', 'New-31', 'New-STL160', 'Karnan', 9789502425.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 8680, 400000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 8680, 'Paid', 0, 'New-P6', 0, 'Yes', 8680, 0.0, 'Per_Day', NULL, 31.0);
insert into "Interest_Details" ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days") values
('Vinoth-New-STL262-New-32-50000-Interest-03-2026', 'New Finance', 'New-32', 'New-STL262', 'Vinoth', 9047015007.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1090, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1090, 'Paid', 0, 'New-P6', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Ashok-New-STL282-New-33-15000-Interest-03-2026', 'New Finance', 'New-33', 'New-STL282', 'Ashok', 7708880250.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 370, 15000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 370, 'Paid', 0, 'New-P6', 0, 'Yes', 370, 0.0, 'Per_Day', NULL, 31.0),
('Mariyammal-New-STL297-New-34-100000-Interest-03-2026', 'New Finance', 'New-34', 'New-STL297', 'Mariyammal', 9952102163.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P6', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Ramkumar-New-STL231-New-35-200000-Interest-03-2026', 'New Finance', 'New-35', 'New-STL231', 'Ramkumar', 9578562182.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 4340, 200000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 4340, 'Paid', 0, 'New-P7', 0, 'Yes', 5910, 0.0, 'Per_Day', NULL, 31.0),
('Kannan-New-STL235-New-36-215000-Interest-03-2026', 'New Finance', 'New-36', 'New-STL235', 'Kannan', 9976592192.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 4670, 215000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 4670, 'Paid', 0, 'New-P3', 0, 'Yes', 4670, 0.0, 'Per_Day', NULL, 31.0),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-03-2026', 'New Finance', 'New-37', 'New-STL263', 'Sakthivel Broker', 9443835225.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P7', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Sabarish-New-STL280-New-38-200000-Interest-03-2026', 'New Finance', 'New-38', 'New-STL280', 'Sabarish', 9080753749.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 4340, 200000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 4340, 'Paid', 0, 'New-P3', 0, 'Yes', 5310, 0.0, 'Per_Day', NULL, 31.0),
('Moorthy-New-STL312-New-39-50000-Interest-03-2026', 'New Finance', 'New-39', 'New-STL312', 'Moorthy', 9578562182.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1090, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1090, 'Paid', 0, 'New-P7', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Shanmugam-New-STL139-New-40-30000-Interest-03-2026', 'New Finance', 'New-40', 'New-STL139', 'Shanmugam', 9943519663.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 740, 30000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 740, 'Paid', 0, 'New-P8', 0, 'Yes', 740, 0.0, 'Per_Day', NULL, 31.0),
('Manivannan-New-STL182-New-41-300000-Interest-03-2026', 'New Finance', 'New-41', 'New-STL182', 'Manivannan', 9715884248.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 6510, 300000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 6510, 'Paid', 0, 'New-P8', 0, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Ramprakash-New-STL234-New-42-55000-Interest-03-2026', 'New Finance', 'New-42', 'New-STL234', 'Ramprakash', 9003525303.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1200.0, 55000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1200, 'Paid', 0, 'New-P8', 0, 'Yes', 1200, 0.0, 'Per_Day', NULL, 31.0),
('Murugesan-New-STL326-New-43-20000-Interest-03-2026', 'New Finance', 'New-43', 'New-STL326', 'Murugesan', 7373932218.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 500, 20000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 500, 'Paid', 0, 'New-P8', 0, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Kalimuthu-New-STL248-New-44-50000-Interest-03-2026', 'New Finance', 'New-44', 'New-STL248', 'Kalimuthu', 9047042275.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1090, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1090, 'Paid', 0, 'New-P8', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Ravi-New-STL306-New-45-75000-Interest-03-2026', 'New Finance', 'New-45', 'New-STL306', 'Ravi', 9751277888.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1630, 75000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1630, 'Paid', 0, 'New-P8', 0, 'No', 4050, 0.0, 'Per_Day', NULL, 31.0),
('Selvaguru-New-STL35-New-46-150000-Interest-03-2026', 'New Finance', 'New-46', 'New-STL35', 'Selvaguru', 9786177888.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3260, 150000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 3260, 'Paid', 0, 'New-P9', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Vasudevan-New-STL116-New-47-450000-Interest-03-2026', 'New Finance', 'New-47', 'New-STL116', 'Vasudevan', 9751519191.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 9770, 450000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 9770, 'Paid', 0, 'New-P9', 0, 'Yes', 9770, 0.0, 'Per_Day', NULL, 31.0),
('Paramasivam-New-STL153-New-48-35000-Interest-03-2026', 'New Finance', 'New-48', 'New-STL153', 'Paramasivam', 9364455525.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 870, 35000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 870, 'Paid', 0, 'New-P9', 0, 'Yes', 870, 0.0, 'Per_Day', NULL, 31.0),
('Karthick-New-STL185-New-49-20000-Interest-03-2026', 'New Finance', 'New-49', 'New-STL185', 'Karthick', 9751519191.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 500, 20000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 500, 'Paid', 0, 'New-P9', 0, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Manikandan-New-STL195-New-50-50000-Interest-03-2026', 'New Finance', 'New-50', 'New-STL195', 'Manikandan', 9751519191.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1090, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1090, 'Paid', 0, 'New-P9', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Pradeep-New-STL123-New-51-100000-Interest-03-2026', 'New Finance', 'New-51', 'New-STL123', 'Pradeep_NPA', 9751519191.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P9', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Logambal-New-STL283-New-52-50000-Interest-03-2026', 'New Finance', 'New-52', 'New-STL283', 'Logambal', 8056834412.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1090, 50000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 1090, 'Paid', 0, 'New-P9', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Divakar-New-STL318-New-53-25000-Interest-03-2026', 'New Finance', 'New-53', 'New-STL318', 'Divakar Vasu', NULL, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 620, 25000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 620, 'Paid', 0, 'New-P9', 0, 'Yes', 620, 0.0, 'Per_Day', NULL, 31.0),
('Muniyappan-New-STL150-New-54-100000-Interest-03-2026', 'New Finance', 'New-54', 'New-STL150', 'Muniyappan', 9159214139.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P10', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Shanmugaraj-New-STL151-New-55-300000-Interest-03-2026', 'New Finance', 'New-55', 'New-STL151', 'Shanmugaraj', 9443781565.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 6510, 300000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 6510, 'Paid', 0, 'New-P10', 0, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Nandhakumar-New-STL227-New-56-100000-Interest-03-2026', 'New Finance', 'New-56', 'New-STL227', 'Nandhakumar', 9361446918.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P10', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Vignesh-New-STL260-New-57-100000-Interest-03-2026', 'New Finance', 'New-57', 'New-STL260', 'Vignesh', 9751707865.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 2170, 'Paid', 0, 'New-P10', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Anand-New-STL274-New-58-20000-Interest-03-2026', 'New Finance', 'New-58', 'New-STL274', 'Anand', 7695808377.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 500, 20000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 500, 'Paid', 0, 'New-P10', 0, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Subramani-New-STL287-New-59-150000-Interest-03-2026', 'New Finance', 'New-59', 'New-STL287', 'Subramani', 9003446318.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3260, 150000.0, '2026-02-01', '03-2026', 'Interest-03-2026', 3260, 'Paid', 0, 'New-P10', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Nagurammal-New-STL331-New-60-150000-Interest-03-2026', 'New Finance', 'New-60', 'New-STL331', 'Nagurammal', 9786870661.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3260, 150000.0, '2026-02-05', '03-2026', 'Interest-03-2026', 3260, 'Paid', 0, 'New-P10', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Mani Basketball-New-STL333-New-61-150000-Interest-03-2026', 'New Finance', 'New-61', 'New-STL333', 'Mani Basketball', 9894450373.0, '2026-03-01', '2026-03-31', '2026-03-04', 28.0, '70.0', 2940, 150000.0, '2026-03-04', '03-2026', 'Interest-03-2026', 2940, 'Paid', 0, 'New-P1', 0, 'Yes', 2940, 0.0, 'Per_Day', NULL, 31.0),
('Arul M-New-STL330-New-62-15000-Interest-03-2026', 'New Finance', 'New-62', 'New-STL330', 'Arul M', 9626262427.0, '2026-03-01', '2026-03-31', '2026-03-07', 25.0, '70.0', 260, 15000.0, '2026-03-07', '03-2026', 'Interest-03-2026', 260, 'Paid', 0, 'New-P2', 0, 'No', 1179, 0.0, 'Per_Day', NULL, 31.0),
('Sabarish-New-STL280-New-63-60000-Interest-03-2026', 'New Finance', 'New-63', 'New-STL280', 'Sabarish', 9080753749.0, '2026-03-01', '2026-03-31', '2026-03-09', 23.0, '70.0', 970, 60000.0, '2026-03-09', '03-2026', 'Interest-03-2026', 970, 'Paid', 0, 'New-P3', 0, 'No', 5310, 0.0, 'Per_Day', NULL, 31.0),
('Balasubramani Suresh-New-STL275-New-64-50000-Interest-03-2026', 'New Finance', 'New-64', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-03-01', '2026-03-31', '2026-03-12', 20.0, '70.0', 700, 50000.0, '2026-03-12', '03-2026', 'Interest-03-2026', 700, 'Paid', 0, 'New-P2', 0, 'No', 5040, 0.0, 'Per_Day', NULL, 31.0),
('Priya-New-STL320-New-65-100000-Interest-03-2026', 'New Finance', 'New-65', 'New-STL320', 'Priya', 9840807102.0, '2026-03-01', '2026-03-31', '2026-03-14', 18.0, '70.0', 1260, 100000.0, '2026-03-14', '03-2026', 'Interest-03-2026', 1260, 'Paid', 0, 'New-P2', 0, 'No', 1470, 0.0, 'Per_Day', NULL, 31.0),
('Tharun-New-STL303-New-66-70000-Interest-03-2026', 'New Finance', 'New-66', 'New-STL303', 'Tharun', 9843722055.0, '2026-03-01', '2026-03-31', '2026-03-16', 16.0, '70.0', 780, 70000.0, '2026-03-16', '03-2026', 'Interest-03-2026', 780, 'Paid', 0, 'New-P3', 0, 'No', 920, 0.0, 'Per_Day', NULL, 31.0),
('Viji Vasanth-New-STL313-New-67-250000-Interest-03-2026', 'New Finance', 'New-67', 'New-STL313', 'Viji Vasanth', 9844139371.0, '2026-03-01', '2026-03-31', '2026-03-17', 15.0, '70.0', 2620.0, 250000.0, '2026-03-17', '03-2026', 'Interest-03-2026', 2620, 'Paid', 0, 'New-P3', 0, 'Yes', 2620, 0.0, 'Per_Day', NULL, 31.0),
('Arul M-New-STL330-New-68-50000-Interest-03-2026', 'New Finance', 'New-68', 'New-STL330', 'Arul M', 9626262427.0, '2026-03-01', '2026-03-31', '2026-03-18', 14.0, '70.0', 49.0, 5000.0, '2026-03-18', '03-2026', 'Interest-03-2026', 49, 'Paid', 0, 'New-P2', 0, 'No', 1179, 0.0, 'Per_Day', NULL, 31.0),
('Ramkumar-New-STL231-New-69-100000-Interest-03-2026', 'New Finance', 'New-69', 'New-STL231', 'Ramkumar', 9578562182.0, '2026-03-01', '2026-03-31', '2026-03-20', 12.0, '70.0', 840, 100000.0, '2026-03-20', '03-2026', 'Interest-03-2026', 840, 'Paid', 0, 'New-P7', 0, 'No', 5910, 0.0, 'Per_Day', NULL, 31.0),
('Ramkumar-New-STL231-New-71-130000-Interest-03-2026', 'New Finance', 'New-71', 'New-STL231', 'Ramkumar', 9578562182.0, '2026-03-01', '2026-03-31', '2026-03-24', 8.0, '70.0', 730, 130000.0, '2026-03-24', '03-2026', 'Interest-03-2026', 730, 'Paid', 0, 'New-P7', 0, 'No', 5910, 0.0, 'Per_Day', NULL, 31.0),
('RanjithKumar-New-STL319-New-72-200000-Interest-03-2026', 'New Finance', 'New-72', 'New-STL319', 'RanjithKumar', 9042090520.0, '2026-03-01', '2026-03-31', '2026-03-26', 6.0, '70.0', 840, 200000.0, '2026-03-26', '03-2026', 'Interest-03-2026', 840, 'Paid', 0, 'New-P1', 0, 'No', 3430, 0.0, 'Per_Day', NULL, 31.0),
('Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-03-2026', 'New Finance', 'New-73', 'New-STL334', 'Vignesh Arun Kumba', 8973249929.0, '2026-03-01', '2026-03-31', '2026-03-28', 4.0, '70.0', 280, 100000.0, '2026-03-28', '03-2026', 'Interest-03-2026', 280, 'Paid', 0, 'New-P8', 0, 'Yes', 280, 0.0, 'Per_Day', NULL, 31.0),
('Tharun Tex-New-STL221-New-74-100000-Interest-03-2026', 'New Finance', 'New-74', 'New-STL221', 'Tharun Tex', 8056834412.0, '2026-03-01', '2026-03-31', '2026-03-28', 4.0, '70.0', 280, 100000.0, '2026-03-28', '03-2026', 'Interest-03-2026', 280, 'Paid', 0, 'New-P8', 0, 'Yes', 280, 0.0, 'Per_Day', NULL, 31.0),
('Durai Master Kumbaa-New-STL335-New-75-100000-Interest-03-2026', 'New Finance', 'New-75', 'New-STL335', 'Durai Master Kumbaa', 6369910360.0, '2026-03-01', '2026-03-31', '2026-03-01', 1.0, '70.0', 70.0, 100000.0, '2026-03-31', '03-2026', 'Interest-03-2026', 70, 'Paid', 0, 'New-P8', 0, 'Yes', 70, 0.0, 'Per_Day', NULL, 1.0),
('Elango Sports-Kan-STL49-Kan-79-30000-Interest-03-2026', 'Kannnan_Personal', 'Kan-79', 'Kan-STL49', 'Elango Sports', 9943831310.0, '2026-03-01', '2026-03-04', '2026-03-01', 4.0, '70.0', 80, 30000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 80, 'Kan-P1', 400, 'Yes', 400, 0.0, 'Per_Day', NULL, 4.0),
('Kavin Surrendar-Kan-STL108-Kan-86-50000-Interest-03-2026', 'Kannnan_Personal', 'Kan-86', 'Kan-STL108', 'Kavin Surrendar', 9025112544.0, '2026-03-01', '2026-03-12', '2026-03-01', 12.0, '70.0', 420, 50000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 420, 'Kan-P1', 5850, 'Yes', 5850, 0.0, 'Per_Day', NULL, 12.0),
('Arun Kumba-Kan-STL139-Kan-89-30000-Interest-03-2026', 'Kannnan_Personal', 'Kan-89', 'Kan-STL139', 'Arun Kumba', 9894049151.0, '2026-03-01', '2026-03-11', '2026-03-01', 11.0, '70.0', 230, 30000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 230, 'Kan-P1', 12210, 'Yes', 12210, 0.0, 'Per_Day', NULL, 11.0),
('Arun Kumba-Kan-STL139-Kan-89-20000-Interest-03-2026', 'Kannnan_Personal', 'Kan-89', 'Kan-STL139', 'Arun Kumba', 9894049151.0, '2026-03-01', '2026-03-23', '2026-03-01', 23.0, '70.0', 320, 20000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 320, 'Kan-P1', 12210, 'No', 12210, 0.0, 'Per_Day', NULL, 23.0),
('Ashok Bro-Kan-STL2-Kan-76-150000-Interest-03-2026', 'Kannnan_Personal', 'Kan-76', 'Kan-STL2', 'Ashok Bro', 9791958906.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3260, 150000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 3260, 'Kan-P1', 5360, 'Yes', 5360, 0.0, 'Per_Day', NULL, 31.0),
('Arun Lorry-Kan-STL4-Kan-77-410000-Interest-03-2026', 'Kannnan_Personal', 'Kan-77', 'Kan-STL4', 'Arun Lorry', 9626262427.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 8900, 410000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 8900, 'Kan-P1', 8900, 'Yes', 8900, 0.0, 'Per_Day', NULL, 31.0),
('Gokulnath-Kan-STL40-Kan-78-20000-Interest-03-2026', 'Kannnan_Personal', 'Kan-78', 'Kan-STL40', 'Gokulnath', 8072395221.0, '2026-03-01', '2026-03-31', '2026-03-24', 8.0, '80.0', 130, 20000.0, '2026-03-24', '03-2026', 'Interest-03-2026', 0, 'Pending', 130, 'Kan-P1', 130, 'Yes', 130, 0.0, 'Per_Day', NULL, 31.0),
('Karthi China-Kan-STL60-Kan-80-1000000-Interest-03-2026', 'Kannnan_Personal', 'Kan-80', 'Kan-STL60', 'Karthi China', 7373173783.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 21700, 1000000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 21700, 'Kan-P1', 21700, 'Yes', 21700, 0.0, 'Per_Day', NULL, 31.0),
('Sethu-Kan-STL65-Kan-81-100000-Interest-03-2026', 'Kannnan_Personal', 'Kan-81', 'Kan-STL65', 'Sethu', 9842498218.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '60.0', 1860, 100000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 1860, 'Kan-P1', 1860, 'Yes', 1860, 0.0, 'Per_Day', NULL, 31.0),
('Rail Ragavan-Kan-STL74-Kan-82-50000-Interest-03-2026', 'Kannnan_Personal', 'Kan-82', 'Kan-STL74', 'Rail Ragavan', 7550394660.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1090, 50000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 1090, 'Kan-P1', 1090, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Saravanan Battery-Kan-STL75-Kan-83-380000-Interest-03-2026', 'Kannnan_Personal', 'Kan-83', 'Kan-STL75', 'Saravanan Battery', 9715087870.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 8250, 380000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 8250, 'Kan-P1', 8250, 'Yes', 8250, 0.0, 'Per_Day', NULL, 31.0),
('Jayaprabha-Kan-STL95-Kan-84-450000-Interest-03-2026', 'Kannnan_Personal', 'Kan-84', 'Kan-STL95', 'Jayaprabha', 9500821444.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 9770, 450000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 9770, 'Kan-P1', 9770, 'Yes', 9770, 0.0, 'Per_Day', NULL, 31.0),
('Theena Aravind-Kan-STL103-Kan-85-40000-Interest-03-2026', 'Kannnan_Personal', 'Kan-85', 'Kan-STL103', 'Theena Aravind', 9894049151.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 990, 20000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 990, 'Kan-P1', 990, 'Yes', 990, 0.0, 'Per_Day', NULL, 31.0),
('Kavin Surrendar-Kan-STL108-Kan-86-250000-Interest-03-2026', 'Kannnan_Personal', 'Kan-86', 'Kan-STL108', 'Kavin Surrendar', 9025112544.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 5430, 250000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 5430, 'Kan-P1', 5850, 'No', 5850, 0.0, 'Per_Day', NULL, 31.0),
('Sridhar Aalves-Kan-STL123-Kan-87-140000-Interest-03-2026', 'Kannnan_Personal', 'Kan-87', 'Kan-STL123', 'Sridhar Aalves', 90475555591.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3040, 140000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 3040, 'Kan-P1', 3280, 'Yes', 3280, 0.0, 'Per_Day', NULL, 31.0),
('Aravind Vasu-Kan-STL129-Kan-88-293000-Interest-03-2026', 'Kannnan_Personal', 'Kan-88', 'Kan-STL129', 'Aravind Vasu', 9751519292.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '60', 6360, 293000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 6360, 'Kan-P1', 6360, 'Yes', 6360, 0.0, 'Per_Day', NULL, 31.0),
('Arun Kumba-Kan-STL139-Kan-89-515000-Interest-03-2026', 'Kannnan_Personal', 'Kan-89', 'Kan-STL139', 'Arun Kumba', 9894049151.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 11180, 515000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 11180, 'Kan-P1', 12210, 'No', 12210, 0.0, 'Per_Day', NULL, 31.0),
('Kanagaraj Chola-Kan-STL153-Kan-90-140000-Interest-03-2026', 'Kannnan_Personal', 'Kan-90', 'Kan-STL153', 'Kanagaraj Chola', 9943829996.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3040, 140000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 3040, 'Kan-P1', 3270, 'Yes', 3270, 0.0, 'Per_Day', NULL, 31.0),
('Sudhakar-Kan-STL154-Kan-91-180000-Interest-03-2026', 'Kannnan_Personal', 'Kan-91', 'Kan-STL154', 'Sudhakar', 7010493151.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3910, 180000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 3910, 'Kan-P1', 3910, 'Yes', 3910, 0.0, 'Per_Day', NULL, 31.0),
('Abdul Rahman-Kan-STL155-Kan-92-20000-Interest-03-2026', 'Kannnan_Personal', 'Kan-92', 'Kan-STL155', 'Abdul Rahman', 9095650806.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 430, 20000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 430, 'Kan-P1', 430, 'Yes', 430, 0.0, 'Per_Day', NULL, 31.0),
('Vijay-Kan-STL161-Kan-93-100000-Interest-03-2026', 'Kannnan_Personal', 'Kan-93', 'Kan-STL161', 'Vijay', 8778588896.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 2170, 'Kan-P1', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Karthi Oil-Kan-STL162-Kan-94-40000-Interest-03-2026', 'Kannnan_Personal', 'Kan-94', 'Kan-STL162', 'Karthi Oil', 9715406070.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 870, 40000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 870, 'Kan-P1', 870, 'Yes', 870, 0.0, 'Per_Day', NULL, 31.0),
('Viji Vasanth-Kan-STL164-Kan-95-300000-Interest-03-2026', 'Kannnan_Personal', 'Kan-95', 'Kan-STL164', 'Viji Vasanth', 9344139371.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 6000, 300000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 6000, 'Kan-P1', 6000, 'Yes', 6000, 0.0, 'Per_Month', 2000.0, 31.0),
('Venkat Pilot-Kan-STL173-Kan-96-225000-Interest-03-2026', 'Kannnan_Personal', 'Kan-96', 'Kan-STL173', 'Venkat Pilot', 9585600378.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 4880, 225000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 4880, 'Kan-P1', 4880, 'Yes', 4880, 0.0, 'Per_Day', NULL, 31.0),
('Sabarish-Kan-STL174-Kan-97-100000-Interest-03-2026', 'Kannnan_Personal', 'Kan-97', 'Kan-STL174', 'Sabarish', 9080753749.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 2170, 'Kan-P1', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Murugesan-Kan-STL177-Kan-98-60000-Interest-03-2026', 'Kannnan_Personal', 'Kan-98', 'Kan-STL177', 'Murugesan', 9787979779.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1300, 60000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 1300, 'Kan-P1', 1300, 'Yes', 1300, 0.0, 'Per_Day', NULL, 31.0),
('John-Kan-STL182-Kan-99-225000-Interest-03-2026', 'Kannnan_Personal', 'Kan-99', 'Kan-STL182', 'John', 8946048074.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 4880, 225000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 4880, 'Kan-P1', 4880, 'Yes', 4880, 0.0, 'Per_Day', NULL, 31.0),
('Manoj-Kan-STL184-Kan-100-500000-Interest-03-2026', 'Kannnan_Personal', 'Kan-100', 'Kan-STL184', 'Manoj', 8838114684.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 10850, 500000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 10850, 'Kan-P1', 10850, 'Yes', 10850, 0.0, 'Per_Day', NULL, 31.0),
('Palanisamy Auto-Kan-STL187-Kan-101-100000-Interest-03-2026', 'Kannnan_Personal', 'Kan-101', 'Kan-STL187', 'Palanisamy Auto', 8883083604.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 2170, 'Kan-P1', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Vallarasu_Kumaravel-Kan-STL189-Kan-102-80000-Interest-03-2026', 'Kannnan_Personal', 'Kan-102', 'Kan-STL189', 'Vallarasu_Kumaravel', 9080753749.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 1980, 80000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 1980, 'Kan-P1', 1980, 'Yes', 1980, 0.0, 'Per_Day', NULL, 31.0),
('Govindhasamy-Kan-STL191-Kan-103-65000-Interest-03-2026', 'Kannnan_Personal', 'Kan-103', 'Kan-STL191', 'Govindhasamy', 9751747987.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 1410, 65000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 1410, 'Kan-P1', 1410, 'Yes', 1410, 0.0, 'Per_Day', NULL, 31.0),
('Saravanan Chola-Kan-STL193-Kan-104-20000-Interest-03-2026', 'Kannnan_Personal', 'Kan-104', 'Kan-STL193', 'Saravanan Chola', 9943829996.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 500, 20000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 500, 'Kan-P1', 500, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Guna-Kan-STL197-Kan-105-300000-Interest-03-2026', 'Kannnan_Personal', 'Kan-105', 'Kan-STL197', 'Guna', 9698733233.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 6510, 300000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 6510, 'Kan-P1', 6510, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Maniraj-Kan-STL201-Kan-106-300000-Interest-03-2026', 'Kannnan_Personal', 'Kan-106', 'Kan-STL201', 'Maniraj', 9626279956.0, '2026-03-01', '2026-03-31', '2026-03-07', 25.0, '70.0', 5250, 300000.0, '2026-03-07', '03-2026', 'Interest-03-2026', 0, 'Pending', 5250, 'Kan-P1', 5250, 'Yes', 5250, 0.0, 'Per_Day', NULL, 31.0),
('Dinesh-Kan-STL203-Kan-107-100000-Interest-03-2026', 'Kannnan_Personal', 'Kan-107', 'Kan-STL203', 'Dinesh', 7708121402.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 2170, 100000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 2170, 'Kan-P1', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Jeeva-Kan-STL205-Kan-108-25000-Interest-03-2026', 'Kannnan_Personal', 'Kan-108', 'Kan-STL205', 'Jeeva', 7200123452.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 540, 25000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 540, 'Kan-P1', 540, 'Yes', 540, 0.0, 'Per_Day', NULL, 31.0),
('Prabhakar-Kan-STL206-Kan-109-40000-Interest-03-2026', 'Kannnan_Personal', 'Kan-109', 'Kan-STL206', 'Prabhakar', 6380232340.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 870, 40000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 870, 'Kan-P1', 870, 'Yes', 870, 0.0, 'Per_Day', NULL, 31.0),
('Devaraj-Kan-STL211-Kan-110-50000-Interest-03-2026', 'Kannnan_Personal', 'Kan-110', 'Kan-STL211', 'Devaraj', 9629691014.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 1240, 50000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 1240, 'Kan-P1', 1240, 'Yes', 1240, 0.0, 'Per_Day', NULL, 31.0),
('Arumugam-Kan-STL212-Kan-111-20000-Interest-03-2026', 'Kannnan_Personal', 'Kan-111', 'Kan-STL212', 'Arumugam', 6374635641.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '90.0', 560, 20000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 560, 'Kan-P1', 560, 'Yes', 560, 0.0, 'Per_Day', NULL, 31.0),
('Rekha-Kan-STL215-Kan-112-40000-Interest-03-2026', 'Kannnan_Personal', 'Kan-112', 'Kan-STL215', 'Rekha', 8754896997.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 990, 40000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 990, 'Kan-P1', 990, 'Yes', 990, 0.0, 'Per_Day', NULL, 31.0),
('Sasi Master-Kan-STL216-Kan-113-20000-Interest-03-2026', 'Kannnan_Personal', 'Kan-113', 'Kan-STL216', 'Sasi Master', 9655400148.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 500, 20000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 500, 'Kan-P1', 500, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Sathish Siva-Kan-STL217-Kan-114-20000-Interest-03-2026', 'Kannnan_Personal', 'Kan-114', 'Kan-STL217', 'Sathish Siva', 9994092494.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '80.0', 500, 20000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 500, 'Kan-P1', 500, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Kongu Kochai-Kan-STL218-Kan-115-170000-Interest-03-2026', 'Kannnan_Personal', 'Kan-115', 'Kan-STL218', 'Kongu Kochai', 9976592192.0, '2026-03-01', '2026-03-31', '2026-03-01', 31.0, '70.0', 3690, 170000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 3690, 'Kan-P1', 3690, 'Yes', 3690, 0.0, 'Per_Day', NULL, 31.0),
('Amutha Ashok-Kan-STL219-Kan-116-1000000-Interest-03-2026', 'Kannnan_Personal', 'Kan-116', 'Kan-STL219', 'Amutha Ashok', 9791958906.0, '2026-03-01', '2026-03-31', '2026-03-13', 19.0, '60.0', 11400, 1000000.0, '2026-03-13', '03-2026', 'Interest-03-2026', 0, 'Pending', 11400, 'Kan-P1', 11400, 'Yes', 11400, 0.0, 'Per_Day', NULL, 31.0),
('Prabhu-Kan-STL220-Kan-117-250000-Interest-03-2026', 'Kannnan_Personal', 'Kan-117', 'Kan-STL220', 'Prabhu', 7010012727.0, '2026-03-01', '2026-03-31', '2026-03-16', 16.0, '60.0', 2400, 250000.0, '2026-03-16', '03-2026', 'Interest-03-2026', 0, 'Pending', 2400, 'Kan-P1', 2400, 'Yes', 2400, 0.0, 'Per_Day', NULL, 31.0),
('Elango Sports-Kan-STL49-Kan-118-20000-Interest-03-2026', 'Kannnan_Personal', 'Kan-118', 'Kan-STL49', 'Elango Sports', 9943831310.0, '2026-03-01', '2026-03-31', '2026-03-09', 23.0, '70.0', 320, 20000.0, '2026-03-09', '03-2026', 'Interest-03-2026', 0, 'Pending', 320, 'Kan-P1', 400, 'No', 400, 0.0, 'Per_Day', NULL, 31.0),
('Sridhar Aalves-Kan-STL123-Kan-119-20000-Interest-03-2026', 'Kannnan_Personal', 'Kan-119', 'Kan-STL123', 'Sridhar Aalves', 90475555591.0, '2026-03-01', '2026-03-31', '2026-03-15', 17.0, '70.0', 240, 20000.0, '2026-03-15', '03-2026', 'Interest-03-2026', 0, 'Pending', 240, 'Kan-P1', 3280, 'No', 3280, 0.0, 'Per_Day', NULL, 31.0),
('Arun Kumba-Kan-STL139-Kan-120-30000-Interest-03-2026', 'Kannnan_Personal', 'Kan-120', 'Kan-STL139', 'Arun Kumba', 9894049151.0, '2026-03-01', '2026-03-31', '2026-03-09', 23.0, '70.0', 480, 30000.0, '2026-03-09', '03-2026', 'Interest-03-2026', 0, 'Pending', 480, 'Kan-P1', 12210, 'No', 12210, 0.0, 'Per_Day', NULL, 31.0),
('Kanagaraj Chola-Kan-STL153-Kan-122-30000-Interest-03-2026', 'Kannnan_Personal', 'Kan-122', 'Kan-STL153', 'Kanagaraj Chola', 9943829996.0, '2026-03-01', '2026-03-31', '2026-03-21', 11.0, '70.0', 230, 30000.0, '2026-03-21', '03-2026', 'Interest-03-2026', 0, 'Pending', 230, 'Kan-P1', 3270, 'No', 3270, 0.0, 'Per_Day', NULL, 31.0),
('Ashok Bro-Kan-STL2-Kan-76-100000-Interest-03-2026', 'Kannnan_Personal', 'Kan-76', 'Kan-STL2', 'Ashok Bro', 9791958906.0, '2026-03-01', '2026-03-18', '2026-03-01', 18.0, '70.0', 1260, 100000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 1260, 'Kan-P1', 5360, 'No', 5360, 0.0, 'Per_Day', NULL, 18.0),
('Ashok Bro-Kan-STL2-Kan-76-50000-Interest-03-2026', 'Kannnan_Personal', 'Kan-76', 'Kan-STL2', 'Ashok Bro', 9791958906.0, '2026-03-01', '2026-03-24', '2026-03-01', 24.0, '70.0', 840, 50000.0, '2026-03-01', '03-2026', 'Interest-03-2026', 0, 'Pending', 840, 'Kan-P1', 5360, 'No', 5360, 0.0, 'Per_Day', NULL, 24.0),
('Kongu Kochai-New-STL329-New-17-50000-Interest-04-2026', 'New Finance', 'New-17', 'New-STL329', 'Kongu Kochai', 9976592192.0, '2026-04-01', '2026-04-01', '2026-04-01', 1.0, '70.0', 40, 50000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 40, 'Paid', 0, 'New-P3', 0, 'Yes', 3190, 0.0, 'Per_Day', NULL, 1.0),
('Ravi-New-STL306-New-45-75000-Interest-04-2026', 'New Finance', 'New-45', 'New-STL306', 'Ravi', 9751277888.0, '2026-04-01', '2026-04-03', '2026-04-01', 3.0, '70.0', 160, 75000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 160, 'Paid', 0, 'New-P8', 0, 'Yes', 260, 0.0, 'Per_Day', NULL, 3.0),
('Ramkumar-New-STL231-New-35-100000-Interest-04-2026', 'New Finance', 'New-35', 'New-STL231', 'Ramkumar', 9578562182.0, '2026-04-01', '2026-04-12', '2026-04-01', 12.0, '70.0', 1440.0, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 3540, 'Pending', -2100, 'New-P7', -2100, 'Yes', 3540, 0.0, 'Per_Day', NULL, 12.0),
('Tharun Tex-New-STL221-New-74-40000-Interest-04-2026', 'New Finance', 'New-74', 'New-STL221', 'Tharun Tex', 8056834412.0, '2026-04-01', '2026-04-14', '2026-04-01', 14.0, '70.0', 390, 40000.0, '2026-03-28', '04-2026', 'Interest-04-2026', 390, 'Paid', 0, 'New-P8', 0, 'Yes', 1650, 0.0, 'Per_Day', NULL, 14.0),
('Pradeep-New-STL67-New-6-60000-Interest-04-2026', 'New Finance', 'New-6', 'New-STL67', 'Pradeep', 9626262427.0, '2026-04-01', '2026-04-17', '2026-04-01', 15.0, '70.0', 714.0, 60000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 714, 'Paid', 0, 'New-P2', 0, 'Yes', 1918, 0.0, 'Per_Day', NULL, 15.0),
('Dinesh-New-STL78-New-126-10000-Interest-03-2026', 'New Finance', 'New-126', 'New-STL78', 'Dinesh', 9942153364.0, '2026-03-01', '2026-03-31', '2026-04-02', -1.0, '70.0', -10, 10000.0, '2026-04-02', '03-2026', 'Interest-03-2026', 0, 'Pending', -10, 'New-P5', -10, 'No', 650, 0.0, 'Per_Day', NULL, 31.0);
insert into "Interest_Details" ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days") values
('Sabarish-New-STL280-New-38-200000-Interest-04-2026', 'New Finance', 'New-38', 'New-STL280', 'Sabarish', 9080753749.0, '2026-04-01', '2026-04-09', '2026-04-01', 9.0, '70.0', 1260, 200000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1260, 'Paid', 0, 'New-P3', 0, 'Yes', 2520, 0.0, 'Per_Day', NULL, 9.0),
('Kannan-New-STL235-New-36-115000-Interest-04-2026', 'New Finance', 'New-36', 'New-STL235', 'Kannan', 9976592192.0, '2026-04-01', '2026-04-16', '2026-04-01', 16.0, '70.0', 1290, 115000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1290, 'Paid', 0, 'New-P3', 0, 'Yes', 3390, 0.0, 'Per_Day', NULL, 16.0),
('Manikandan-New-STL195-New-50-40000-Interest-04-2026', 'New Finance', 'New-50', 'New-STL195', 'Manikandan', 9751519191.0, '2026-04-01', '2026-04-17', '2026-04-01', 17.0, '70.0', 480, 40000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 480, 'Paid', 0, 'New-P9', 0, 'Yes', 690, 0.0, 'Per_Day', NULL, 17.0),
('Pradeep-New-STL67-New-6-40000-Interest-04-2026', 'New Finance', 'New-6', 'New-STL67', 'Pradeep', 9626262427.0, '2026-04-01', '2026-04-18', '2026-04-01', 18.0, '70', 504.0, 40000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 504, 'Paid', 0, 'New-P2', 0, 'No', 1918, 0.0, 'Per_Day', NULL, 17.0),
('Pradeep-New-STL67-New-6-50000-Interest-04-2026', 'New Finance', 'New-6', 'New-STL67', 'Pradeep', 9626262427.0, '2026-04-01', '2026-04-20', '2026-04-01', 20.0, '70.0', 700.0, 50000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 700, 'Paid', 0, 'New-P2', 0, 'No', 1918, 0.0, 'Per_Day', NULL, 19.0),
('Arul S-New-STL270-New-3-30000-Interest-04-2026', 'New Finance', 'New-3', 'New-STL270', 'Arul S', 8940864888.0, '2026-04-01', '2026-04-21', '2026-04-01', 21.0, '70.0', 440, 30000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 440, 'Paid', 0, 'New-P1', 0, 'Yes', 1910, 0.0, 'Per_Day', NULL, 21.0),
('Tharun-New-STL303-New-66-35000-Interest-04-2026', 'New Finance', 'New-66', 'New-STL303', 'Tharun', 9843722055.0, '2026-04-01', '2026-04-29', '2026-04-01', 29.0, '70.0', 710, 35000.0, '2026-03-16', '04-2026', 'Interest-04-2026', 780, 'Pending', -70, 'New-P3', -70, 'Yes', 710, 0.0, 'Per_Day', NULL, 29.0),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-04-2026', 'New Finance', 'New-1', 'New-STL179', 'Sankara Narayanan', 9003333055.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 6300, 300000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 6300, 'Paid', 0, 'New-P1', 0, 'Yes', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Ramesh-New-STL257-New-2-30000-Interest-04-2026', 'New Finance', 'New-2', 'New-STL257', 'Ramesh', 8072765170.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 720, 30000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 720, 'Paid', 0, 'New-P1', 0, 'Yes', 720, 0.0, 'Per_Day', NULL, 30.0),
('Arul S-New-STL270-New-3-70000-Interest-04-2026', 'New Finance', 'New-3', 'New-STL270', 'Arul S', 8940864888.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1470, 70000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1470, 'Paid', 0, 'New-P1', 0, 'No', 1910, 0.0, 'Per_Day', NULL, 30.0),
('Rangis-New-STL295-New-4-100000-Interest-04-2026', 'New Finance', 'New-4', 'New-STL295', 'Rangis', 9443732655.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P1', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Ramasamy Divya-New-STL156-New-7-50000-Interest-04-2026', 'New Finance', 'New-7', 'New-STL156', 'Ramasamy Divya', 9894465610.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1050, 50000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1050, 'Paid', 0, 'New-P2', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Sundaravadivel-New-STL271-New-9-50000-Interest-04-2026', 'New Finance', 'New-9', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1050, 50000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1050, 'Paid', 0, 'New-P2', 0, 'Yes', 1510, 0.0, 'Per_Day', NULL, 30.0),
('Balasubramani Suresh-New-STL275-New-10-200000-Interest-04-2026', 'New Finance', 'New-10', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 4200, 200000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 4200, 'Paid', 0, 'New-P2', 0, 'Yes', 5740, 0.0, 'Per_Day', NULL, 30.0),
('Nagaraj Post-New-STL301-New-11-30000-Interest-04-2026', 'New Finance', 'New-11', 'New-STL301', 'Nagaraj Post', 9150787857.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 720, 30000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 720, 'Paid', 0, 'New-P2', 0, 'Yes', 720, 0.0, 'Per_Day', NULL, 30.0),
('Arul M-New-STL330-New-13-35000-Interest-04-2026', 'New Finance', 'New-13', 'New-STL330', 'Arul M', 9626262427.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 840, 35000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 840, 'Paid', 0, 'New-P2', 0, 'Yes', 1270, 0.0, 'Per_Day', NULL, 30.0),
('John-New-STL292-New-14-150000-Interest-04-2026', 'New Finance', 'New-14', 'New-STL292', 'John', 7418824749.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 3150, 150000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 3150, 'Paid', 0, 'New-P3', 0, 'Yes', 3150, 0.0, 'Per_Day', NULL, 30.0),
('Praveen Ram-New-STL324-New-16-80000-Interest-04-2026', 'New Finance', 'New-16', 'New-STL324', 'Praveen Ram', 9715778326.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1680, 80000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1680, 'Paid', 0, 'New-P3', 0, 'Yes', 1680, 0.0, 'Per_Day', NULL, 30.0),
('Kongu Kochai-New-STL329-New-17-150000-Interest-04-2026', 'New Finance', 'New-17', 'New-STL329', 'Kongu Kochai', 9976592192.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 3150, 150000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 3150, 'Paid', 0, 'New-P3', 0, 'No', 3190, 0.0, 'Per_Day', NULL, 30.0),
('Dinesh-New-STL78-New-19-30000-Interest-04-2026', 'New Finance', 'New-19', 'New-STL78', 'Dinesh', 9942153364.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 630, 30000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 630, 'Paid', 0, 'New-P5', 0, 'Yes', 630, 0.0, 'Per_Day', NULL, 30.0),
('Jayapal-New-STL121-New-20-100000-Interest-04-2026', 'New Finance', 'New-20', 'New-STL121', 'Jayapal', 9788544477.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P5', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Udhayakumar-New-STL126-New-21-130000-Interest-04-2026', 'New Finance', 'New-21', 'New-STL126', 'Udhayakumar', 9965656493.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2730, 130000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2730, 'Paid', 0, 'New-P5', 0, 'Yes', 2730, 0.0, 'Per_Day', NULL, 30.0),
('Boopathy Crane-New-STL217-New-22-30000-Interest-04-2026', 'New Finance', 'New-22', 'New-STL217', 'Boopathy Crane', 9159296091.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 720, 30000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 720, 'Paid', 0, 'New-P5', 0, 'Yes', 720, 0.0, 'Per_Day', NULL, 30.0),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-04-2026', 'New Finance', 'New-23', 'New-STL273', 'Suresh Abudhabi', 7200035939.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1260, 60000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1260, 'Paid', 0, 'New-P5', 0, 'Yes', 1260, 0.0, 'Per_Day', NULL, 30.0),
('Yagappan-New-STL278-New-25-20000-Interest-04-2026', 'New Finance', 'New-25', 'New-STL278', 'Yagappan', 8248805311.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 480, 20000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 480, 'Paid', 0, 'New-P5', 0, 'Yes', 480, 0.0, 'Per_Day', NULL, 30.0),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-04-2026', 'New Finance', 'New-26', 'New-STL304', 'Sakthivel Jayaraj', 9943013586.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P5', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Mahesh-New-STL308-New-27-50000-Interest-04-2026', 'New Finance', 'New-27', 'New-STL308', 'Mahesh', 9080383024.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1050, 50000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1050, 'Paid', 0, 'New-P5', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Kaviyarasu Arul-New-STL323-New-28-750000-Interest-04-2026', 'New Finance', 'New-28', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 15750, 750000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 15750, 'Paid', 0, 'New-P4', 0, 'Yes', 19810, 0.0, 'Per_Day', NULL, 30.0),
('Danendran-New-STL46-New-29-95000-Interest-04-2026', 'New Finance', 'New-29', 'New-STL46', 'Danendran', 9865388000.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2000, 95000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2000, 'Paid', 0, 'New-P6', 0, 'Yes', 2000, 0.0, 'Per_Day', NULL, 30.0),
('Rajendran-New-STL58-New-30-15000-Interest-04-2026', 'New Finance', 'New-30', 'New-STL58', 'Rajendran', 9865388000.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 360, 15000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 360, 'Paid', 0, 'New-P6', 0, 'Yes', 360, 0.0, 'Per_Day', NULL, 30.0),
('Karnan-New-STL160-New-31-400000-Interest-04-2026', 'New Finance', 'New-31', 'New-STL160', 'Karnan', 9789502425.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 8400, 400000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 8400, 'Paid', 0, 'New-P6', 0, 'Yes', 8400, 0.0, 'Per_Day', NULL, 30.0),
('Vinoth-New-STL262-New-32-50000-Interest-04-2026', 'New Finance', 'New-32', 'New-STL262', 'Vinoth', 9047015007.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1050, 50000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1050, 'Paid', 0, 'New-P6', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Ashok-New-STL282-New-33-15000-Interest-04-2026', 'New Finance', 'New-33', 'New-STL282', 'Ashok', 7708880250.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 360, 15000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 360, 'Paid', 0, 'New-P6', 0, 'Yes', 360, 0.0, 'Per_Day', NULL, 30.0),
('Mariyammal-New-STL297-New-34-100000-Interest-04-2026', 'New Finance', 'New-34', 'New-STL297', 'Mariyammal', 9952102163.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P6', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Kannan-New-STL235-New-36-100000-Interest-04-2026', 'New Finance', 'New-36', 'New-STL235', 'Kannan', 9976592192.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P3', 0, 'No', 3390, 0.0, 'Per_Day', NULL, 30.0),
('Shanmugam-New-STL139-New-40-30000-Interest-04-2026', 'New Finance', 'New-40', 'New-STL139', 'Shanmugam', 9943519663.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 720, 30000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 720, 'Paid', 0, 'New-P8', 0, 'Yes', 720, 0.0, 'Per_Day', NULL, 30.0),
('Manivannan-New-STL182-New-41-300000-Interest-04-2026', 'New Finance', 'New-41', 'New-STL182', 'Manivannan', 9715884248.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 6300, 300000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 6300, 'Paid', 0, 'New-P8', 0, 'Yes', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Ramprakash-New-STL234-New-42-55000-Interest-04-2026', 'New Finance', 'New-42', 'New-STL234', 'Ramprakash', 9003525303.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1160, 55000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1160, 'Paid', 0, 'New-P8', 0, 'Yes', 1160, 0.0, 'Per_Day', NULL, 30.0),
('Murugesan-New-STL326-New-43-20000-Interest-04-2026', 'New Finance', 'New-43', 'New-STL326', 'Murugesan', 7373932218.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 480, 20000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 480, 'Paid', 0, 'New-P8', 0, 'Yes', 480, 0.0, 'Per_Day', NULL, 30.0),
('Kalimuthu-New-STL248-New-44-50000-Interest-04-2026', 'New Finance', 'New-44', 'New-STL248', 'Kalimuthu', 9047042275.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1050, 50000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1050, 'Paid', 0, 'New-P8', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Selvaguru-New-STL35-New-46-150000-Interest-04-2026', 'New Finance', 'New-46', 'New-STL35', 'Selvaguru', 9786177888.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 3150, 150000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 3150, 'Paid', 0, 'New-P9', 0, 'Yes', 3150, 0.0, 'Per_Day', NULL, 30.0),
('Vasudevan-New-STL116-New-47-450000-Interest-04-2026', 'New Finance', 'New-47', 'New-STL116', 'Vasudevan', 9751519191.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 9450, 450000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 9450, 'Paid', 0, 'New-P9', 0, 'Yes', 9450, 0.0, 'Per_Day', NULL, 30.0),
('Paramasivam-New-STL153-New-48-35000-Interest-04-2026', 'New Finance', 'New-48', 'New-STL153', 'Paramasivam', 9364455525.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 840, 35000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 840, 'Paid', 0, 'New-P9', 0, 'Yes', 840, 0.0, 'Per_Day', NULL, 30.0),
('Karthick-New-STL185-New-49-20000-Interest-04-2026', 'New Finance', 'New-49', 'New-STL185', 'Karthick', 9751519191.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 480, 20000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 480, 'Paid', 0, 'New-P9', 0, 'Yes', 480, 0.0, 'Per_Day', NULL, 30.0),
('Manikandan-New-STL195-New-50-10000-Interest-04-2026', 'New Finance', 'New-50', 'New-STL195', 'Manikandan', 9751519191.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 210, 10000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 210, 'Paid', 0, 'New-P9', 0, 'No', 690, 0.0, 'Per_Day', NULL, 30.0),
('Pradeep_NPA-New-STL123-New-51-100000-Interest-04-2026', 'New Finance', 'New-51', 'New-STL123', 'Pradeep_NPA', 9751519191.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P9', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Logambal-New-STL283-New-52-50000-Interest-04-2026', 'New Finance', 'New-52', 'New-STL283', 'Logambal', 8056834412.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1050, 50000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1050, 'Paid', 0, 'New-P9', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Divakar-New-STL318-New-53-25000-Interest-04-2026', 'New Finance', 'New-53', 'New-STL318', 'Divakar', 8610561010.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 600, 25000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 600, 'Paid', 0, 'New-P9', 0, 'Yes', 600, 0.0, 'Per_Day', NULL, 30.0),
('Muniyappan-New-STL150-New-54-100000-Interest-04-2026', 'New Finance', 'New-54', 'New-STL150', 'Muniyappan', 9159214139.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P10', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Shanmugaraj-New-STL151-New-55-300000-Interest-04-2026', 'New Finance', 'New-55', 'New-STL151', 'Shanmugaraj', 9443781565.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 6300, 300000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 6300, 'Paid', 0, 'New-P10', 0, 'Yes', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Nandhakumar-New-STL227-New-56-100000-Interest-04-2026', 'New Finance', 'New-56', 'New-STL227', 'Nandhakumar', 9361446918.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P10', 0, 'Yes', 4620, 0.0, 'Per_Day', NULL, 30.0),
('Vignesh-New-STL260-New-57-100000-Interest-04-2026', 'New Finance', 'New-57', 'New-STL260', 'Vignesh', 9751707865.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P10', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Anand-New-STL274-New-58-20000-Interest-04-2026', 'New Finance', 'New-58', 'New-STL274', 'Anand', 7695808377.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '80.0', 480, 20000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 480, 'Paid', 0, 'New-P10', 0, 'Yes', 480, 0.0, 'Per_Day', NULL, 30.0),
('Subramani-New-STL287-New-59-150000-Interest-04-2026', 'New Finance', 'New-59', 'New-STL287', 'Subramani', 9003446318.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 3150, 150000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 3150, 'Paid', 0, 'New-P10', 0, 'Yes', 3150, 0.0, 'Per_Day', NULL, 30.0),
('Nagurammal-New-STL331-New-60-150000-Interest-04-2026', 'New Finance', 'New-60', 'New-STL331', 'Nagurammal', 9786870661.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 3150, 150000.0, '2026-02-05', '04-2026', 'Interest-04-2026', 3150, 'Paid', 0, 'New-P10', 0, 'Yes', 3150, 0.0, 'Per_Day', NULL, 30.0),
('Mani Basketball-New-STL333-New-61-150000-Interest-04-2026', 'New Finance', 'New-61', 'New-STL333', 'Mani Basketball', 9894450873.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 3150, 150000.0, '2026-03-04', '04-2026', 'Interest-04-2026', 3150, 'Paid', 0, 'New-P1', 0, 'Yes', 3150, 0.0, 'Per_Day', NULL, 30.0),
('Arul M-New-STL330-New-62-15000-Interest-04-2026', 'New Finance', 'New-62', 'New-STL330', 'Arul M', 9626262427.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 320, 15000.0, '2026-03-07', '04-2026', 'Interest-04-2026', 320, 'Paid', 0, 'New-P2', 0, 'No', 1270, 0.0, 'Per_Day', NULL, 30.0),
('Sabarish-New-STL280-New-63-60000-Interest-04-2026', 'New Finance', 'New-63', 'New-STL280', 'Sabarish', 9080753749.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1260, 60000.0, '2026-03-09', '04-2026', 'Interest-04-2026', 1260, 'Paid', 0, 'New-P3', 0, 'No', 2520, 0.0, 'Per_Day', NULL, 30.0),
('Balasubramani Suresh-New-STL275-New-64-50000-Interest-04-2026', 'New Finance', 'New-64', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1050, 50000.0, '2026-03-12', '04-2026', 'Interest-04-2026', 1050, 'Paid', 0, 'New-P2', 0, 'No', 5740, 0.0, 'Per_Day', NULL, 30.0),
('Priya-New-STL320-New-65-100000-Interest-04-2026', 'New Finance', 'New-65', 'New-STL320', 'Priya', 9840807102.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-03-14', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P2', 0, 'Yes', 4620, 0.0, 'Per_Day', NULL, 30.0),
('Viji Vasanth-New-STL313-New-67-250000-Interest-04-2026', 'New Finance', 'New-67', 'New-STL313', 'Viji Vasanth', 9844139371.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 5250, 250000.0, '2026-03-17', '04-2026', 'Interest-04-2026', 5250, 'Paid', 0, 'New-P3', 0, 'Yes', 5250, 0.0, 'Per_Day', NULL, 30.0),
('Arul M-New-STL330-New-68-5000-Interest-04-2026', 'New Finance', 'New-68', 'New-STL330', 'Arul M', 9626262427.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 110, 5000.0, '2026-03-18', '04-2026', 'Interest-04-2026', 110, 'Paid', 0, 'New-P2', 0, 'No', 1270, 0.0, 'Per_Day', NULL, 30.0),
('RanjithKumar-New-STL319-New-72-200000-Interest-04-2026', 'New Finance', 'New-72', 'New-STL319', 'RanjithKumar', 9042090520.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 4200, 200000.0, '2026-03-26', '04-2026', 'Interest-04-2026', 4200, 'Paid', 0, 'New-P1', 0, 'Yes', 4200, 0.0, 'Per_Day', NULL, 30.0),
('Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-04-2026', 'New Finance', 'New-73', 'New-STL334', 'Vignesh Arun Kumba', 8973249929.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-03-28', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P8', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Tharun Tex-New-STL221-New-74-60000-Interest-04-2026', 'New Finance', 'New-74', 'New-STL221', 'Tharun Tex', 8056834412.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1260, 60000.0, '2026-03-28', '04-2026', 'Interest-04-2026', 1260, 'Paid', 0, 'New-P8', 0, 'No', 1650, 0.0, 'Per_Day', NULL, 30.0),
('Durai Master Kumbaa-New-STL335-New-75-100000-Interest-04-2026', 'New Finance', 'New-75', 'New-STL335', 'Durai Master Kumbaa', 6369910360.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-03-31', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P8', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Kaviyarasu Arul-New-STL323-New-125-200000-Interest-04-2026', 'New Finance', 'New-125', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, '2026-04-01', '2026-04-30', '2026-04-02', 29.0, '70.0', 4060, 200000.0, '2026-04-02', '04-2026', 'Interest-04-2026', 4060, 'Paid', 0, 'New-P4', 0, 'No', 19810, 0.0, 'Per_Day', NULL, 30.0),
('Nandhakumar-New-STL227-New-127-200000-Interest-04-2026', 'New Finance', 'New-127', 'New-STL227', 'Nandhakumar', 9361446918.0, '2026-04-01', '2026-04-30', '2026-04-13', 18.0, '70.0', 2520, 200000.0, '2026-04-13', '04-2026', 'Interest-04-2026', 2520, 'Paid', 0, 'New-P10', 0, 'No', 4620, 0.0, 'Per_Day', NULL, 30.0),
('Karthi cake shop-New-STL337-New-128-200000-Interest-04-2026', 'New Finance', 'New-128', 'New-STL337', 'Karthi cake shop', NULL, '2026-04-01', '2026-04-30', '2026-04-13', 18.0, '70.0', 2520, 200000.0, '2026-04-13', '04-2026', 'Interest-04-2026', 2520, 'Paid', 0, 'New-P4', 0, 'Yes', 2520, 0.0, 'Per_Day', NULL, 30.0),
('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-04-2026', 'New Finance', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618.0, '2026-04-01', '2026-04-30', '2026-04-04', 27.0, '70.0', 190, 10000.0, '2026-04-04', '04-2026', 'Interest-04-2026', 190, 'Paid', 0, 'New-P2', 0, 'Yes', 190, 0.0, 'Per_Day', NULL, 30.0),
('Priya-New-STL320-New-130-200000-Interest-04-2026', 'New Finance', 'New-130', 'New-STL320', 'Priya', 9840807102.0, '2026-04-01', '2026-04-30', '2026-04-13', 18.0, '70.0', 2520, 200000.0, '2026-04-13', '04-2026', 'Interest-04-2026', 2520, 'Paid', 0, 'New-P2', 0, 'No', 4620, 0.0, 'Per_Day', NULL, 30.0),
('Balasubramani Suresh-New-STL275-New-131-50000-Interest-04-2026', 'New Finance', 'New-131', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-04-01', '2026-04-30', '2026-04-17', 14.0, '70.0', 490, 50000.0, '2026-04-17', '04-2026', 'Interest-04-2026', 490, 'Paid', 0, 'New-P2', 0, 'No', 5740, 0.0, 'Per_Day', NULL, 30.0),
('Sundaravadivel-New-STL271-New-132-50000-Interest-04-2026', 'New Finance', 'New-132', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-04-01', '2026-04-30', '2026-04-18', 13.0, '70.0', 460, 50000.0, '2026-04-18', '04-2026', 'Interest-04-2026', 460, 'Paid', 0, 'New-P2', 0, 'No', 1510, 0.0, 'Per_Day', NULL, 30.0),
('Kaviraj-New-STL338-New-133-50000-Interest-04-2026', 'New Finance', 'New-133', 'New-STL338', 'Kaviraj', 9943341540.0, '2026-04-01', '2026-04-30', '2026-04-20', 11.0, '70.0', 390, 50000.0, '2026-04-20', '04-2026', 'Interest-04-2026', 390, 'Paid', 0, 'New-P1', 0, 'Yes', 390, 0.0, 'Per_Day', NULL, 30.0),
('Ravi-New-STL306-New-134-20000-Interest-04-2026', 'New Finance', 'New-134', 'New-STL306', 'Ravi', 9751277888.0, '2026-04-01', '2026-04-30', '2026-04-25', 6.0, '80.0', 100, 20000.0, '2026-04-25', '04-2026', 'Interest-04-2026', 100, 'Paid', 0, 'New-P8', 0, 'No', 260, 0.0, 'Per_Day', NULL, 30.0),
('Surya Shed-New-STL339-New-135-120000-Interest-04-2026', 'New Finance', 'New-135', 'New-STL339', 'Surya Shed', 9787878005.0, '2026-04-01', '2026-04-30', '2026-04-27', 4.0, '70.0', 340, 120000.0, '2026-04-27', '04-2026', 'Interest-04-2026', 340, 'Paid', 0, 'New-P2', 0, 'Yes', 350, 0.0, 'Per_Day', NULL, 30.0),
('Surya Shed-New-STL339-New-136-20000-Interest-04-2026', 'New Finance', 'New-136', 'New-STL339', 'Surya Shed', 9787878005.0, '2026-04-01', '2026-04-30', '2026-04-30', 1.0, '70.0', 10, 20000.0, '2026-04-30', '04-2026', 'Interest-04-2026', 10, 'Paid', 0, 'New-P2', 0, 'No', 350, 0.0, 'Per_Day', NULL, 30.0),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-04-2026', 'New Finance', 'New-37', 'New-STL263', 'Sakthivel Broker', 9443835225.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P7', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Moorthy-New-STL312-New-39-50000-Interest-04-2026', 'New Finance', 'New-39', 'New-STL312', 'Moorthy', 9578562182.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 1050, 50000.0, '2026-02-01', '04-2026', 'Interest-04-2026', 1050, 'Paid', 0, 'New-P7', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Ramkumar-New-STL231-New-71-100000-Interest-04-2026', 'New Finance', 'New-71', 'New-STL231', 'Ramkumar', 9578562182.0, '2026-04-01', '2026-04-30', '2026-04-01', 30.0, '70.0', 2100, 100000.0, '2026-03-24', '04-2026', 'Interest-04-2026', 2100, 'Paid', 0, 'New-P7', -2100, 'No', 3540, 0.0, 'Per_Day', NULL, 30.0),
('Priya-New-STL320-New-65-80000-Interest-06-2026', 'New Finance', 'New-65', 'New-STL320', 'Priya', 9840807102.0, '2026-06-01', '2026-06-03', '2026-06-01', 3.0, '70.0', 170, 80000.0, '2026-03-14', '06-2026', 'Interest-06-2026', 170, 'Paid', 0, 'New-P2', 0, 'Yes', 7730, 0.0, 'Per_Day', NULL, 3.0),
('Kongu Kochai-New-STL329-New-17-150000-Interest-06-2026', 'New Finance', 'New-17', 'New-STL329', 'Kongu Kochai', 9976592192.0, '2026-06-01', '2026-06-03', '2026-06-01', 3.0, '70.0', 320, 150000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 320, 'Paid', 0, 'New-P3', 0, 'Yes', 320, 0.0, 'Per_Day', NULL, 3.0),
('Udhayakumar-New-STL126-New-21-10000-Interest-06-2026', 'New Finance', 'New-21', 'New-STL126', 'Udhayakumar', 9965656493.0, '2026-06-01', '2026-06-03', '2026-06-01', 3.0, '70.0', 20, 10000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 20, 'Paid', 0, 'New-P5', 1760, 'Yes', 2330, 0.0, 'Per_Day', NULL, 3.0),
('Dinesh-New-STL78-New-19-10000-Interest-05-2026', 'New Finance', 'New-19', 'New-STL78', 'Dinesh', 9942153364.0, '2026-05-01', '2026-05-12', '2026-05-01', 12.0, '70.0', 80, 10000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 200, 'Pending', -120, 'New-P5', -120, 'Yes', 80, 0.0, 'Per_Day', NULL, 12.0),
('Kannan-New-STL235-New-138-200000-Interest-05-2026', 'New Finance', 'New-138', 'New-STL235', 'Kannan', 9976592192.0, '2026-05-01', '2026-05-14', '2026-05-05', 10.0, '70.0', 1400, 200000.0, '2026-05-05', '05-2026', 'Interest-05-2026', 1400, 'Paid', 0, 'New-P3', 0, 'Yes', 4970, 0.0, 'Per_Day', NULL, 14.0),
('Viji Vasanth-New-STL313-New-67-100000-Interest-05-2026', 'New Finance', 'New-67', 'New-STL313', 'Viji Vasanth', 9844139371.0, '2026-05-01', '2026-05-15', '2026-05-01', 15.0, '70.0', 1050, 100000.0, '2026-03-17', '05-2026', 'Interest-05-2026', 1050, 'Paid', 0, 'New-P3', 0, 'Yes', 4310, 0.0, 'Per_Day', NULL, 15.0),
('Logambal-New-STL283-New-52-30000-Interest-05-2026', 'New Finance', 'New-52', 'New-STL283', 'Logambal', 8056834412.0, '2026-05-01', '2026-05-21', '2026-05-01', 21.0, '70.0', 560.0, 30000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 560, 'Paid', 0, 'New-P9', 0, 'Yes', 560, 0.0, 'Per_Day', NULL, 21.0),
('Kaviraj-New-STL338-New-133-40000-Interest-05-2026', 'New Finance', 'New-133', 'New-STL338', 'Kaviraj', 9943341540.0, '2026-05-01', '2026-05-22', '2026-05-01', 22.0, '70.0', 840.0, 40000.0, '2026-04-20', '05-2026', 'Interest-05-2026', 840, 'Paid', 0, 'New-P1', 0, 'Yes', 840, 0.0, 'Per_Day', NULL, 22.0),
('Priya-New-STL320-New-140-150000-Interest-05-2026', 'New Finance', 'New-140', 'New-STL320', 'Priya', 9840807102.0, '2026-05-01', '2026-05-22', '2026-05-16', 7.0, '70.0', 740, 150000.0, '2026-05-16', '05-2026', 'Interest-05-2026', 740, 'Paid', 0, 'New-P2', 0, 'Yes', 6070, 0.0, 'Per_Day', NULL, 22.0),
('Nandhakumar-New-STL227-New-56-100000-Interest-05-2026', 'New Finance', 'New-56', 'New-STL227', 'Nandhakumar', 9361446918.0, '2026-05-01', '2026-05-24', '2026-05-01', 24.0, '70.0', 1750.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1750, 'Paid', 0, 'New-P10', 0, 'Yes', 6090, 0.0, 'Per_Day', NULL, 24.0),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-05-2026', 'New Finance', 'New-1', 'New-STL179', 'Sankara Narayanan', 9003333055.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 6510.0, 300000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 6510, 'Paid', 0, 'New-P1', 0, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Ramesh-New-STL257-New-2-30000-Interest-05-2026', 'New Finance', 'New-2', 'New-STL257', 'Ramesh', 8072765170.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 740.0, 30000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 740, 'Paid', 0, 'New-P1', 0, 'Yes', 740, 0.0, 'Per_Day', NULL, 31.0),
('Arul S-New-STL270-New-3-70000-Interest-05-2026', 'New Finance', 'New-3', 'New-STL270', 'Arul S', 8940864888.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1520.0, 70000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1520, 'Paid', 0, 'New-P1', 0, 'Yes', 1520, 0.0, 'Per_Day', NULL, 31.0),
('Rangis-New-STL295-New-4-100000-Interest-05-2026', 'New Finance', 'New-4', 'New-STL295', 'Rangis', 9443732655.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P1', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Ramasamy Divya-New-STL156-New-7-50000-Interest-05-2026', 'New Finance', 'New-7', 'New-STL156', 'Ramasamy Divya', 9894465610.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 0, 'Pending', 1090, 'New-P2', 1090, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Sundaravadivel-New-STL271-New-9-New-132-100000-Interest-05-2026', 'New Finance', 'New-9-New-132', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P2', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Balasubramani Suresh-New-STL275-New-10-New-64-New-131-300000-Interest-05-2026', 'New Finance', 'New-10-New-64-New-131', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 6510.0, 300000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 6510, 'Paid', 0, 'New-P2', 0, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Nagaraj Post-New-STL301-New-11-30000-Interest-05-2026', 'New Finance', 'New-11', 'New-STL301', 'Nagaraj Post', 9150787857.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 740.0, 30000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 740, 'Paid', 0, 'New-P2', 0, 'Yes', 740, 0.0, 'Per_Day', NULL, 31.0),
('Arul M-New-STL330-New-13-New-62-New-68-55000-Interest-05-2026', 'New Finance', 'New-13-New-62-New-68', 'New-STL330', 'Arul M', 9626262427.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1190.0, 55000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1190, 'Paid', 0, 'New-P2', 0, 'Yes', 1190, 0.0, 'Per_Day', NULL, 31.0),
('John-New-STL292-New-14-150000-Interest-05-2026', 'New Finance', 'New-14', 'New-STL292', 'John', 7418824749.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 3260.0, 150000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 3260, 'Paid', 0, 'New-P3', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0);
insert into "Interest_Details" ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days") values
('Praveen Ram-New-STL324-New-16-80000-Interest-05-2026', 'New Finance', 'New-16', 'New-STL324', 'Praveen Ram', 9715778326.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1740.0, 80000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1740, 'Paid', 0, 'New-P3', 0, 'Yes', 1740, 0.0, 'Per_Day', NULL, 31.0),
('Jayapal-New-STL121-New-20-100000-Interest-05-2026', 'New Finance', 'New-20', 'New-STL121', 'Jayapal', 9788544477.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P5', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Udhayakumar-New-STL126-New-21-120000-Interest-05-2026', 'New Finance', 'New-21', 'New-STL126', 'Udhayakumar', 9965656493.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2680.0, 120000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2680, 'Paid', 0, 'New-P5', 0, 'Yes', 2680, 0.0, 'Per_Day', NULL, 31.0),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-05-2026', 'New Finance', 'New-23', 'New-STL273', 'Suresh Abudhabi', 7200035939.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1300.0, 60000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1300, 'Paid', 0, 'New-P5', 0, 'Yes', 1300, 0.0, 'Per_Day', NULL, 31.0),
('Yagappan-New-STL278-New-25-20000-Interest-05-2026', 'New Finance', 'New-25', 'New-STL278', 'Yagappan', 8248805311.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 500.0, 20000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 500, 'Paid', 0, 'New-P5', 0, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-05-2026', 'New Finance', 'New-26', 'New-STL304', 'Sakthivel Jayaraj', 9943013586.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P5', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Mahesh-New-STL308-New-27-50000-Interest-05-2026', 'New Finance', 'New-27', 'New-STL308', 'Mahesh', 9080383024.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1090, 'Paid', 0, 'New-P5', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Kaviyarasu Arul-New-STL323-New-28-New-125-950000-Interest-05-2026', 'New Finance', 'New-28-New-125', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 20610.0, 950000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 20610, 'Paid', 0, 'New-P4', 0, 'Yes', 20610, 0.0, 'Per_Day', NULL, 31.0),
('Danendran-New-STL46-New-29-95000-Interest-05-2026', 'New Finance', 'New-29', 'New-STL46', 'Danendran', 9865388000.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2060.0, 95000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2060, 'Paid', 0, 'New-P6', 0, 'Yes', 2060, 0.0, 'Per_Day', NULL, 31.0),
('Rajendran-New-STL58-New-30-15000-Interest-05-2026', 'New Finance', 'New-30', 'New-STL58', 'Rajendran', 9865388000.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 370.0, 15000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 370, 'Paid', 0, 'New-P6', 0, 'Yes', 370, 0.0, 'Per_Day', NULL, 31.0),
('Karnan-New-STL160-New-31-400000-Interest-05-2026', 'New Finance', 'New-31', 'New-STL160', 'Karnan', 9789502425.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 8680.0, 400000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 8680, 'Paid', 0, 'New-P6', 0, 'Yes', 8680, 0.0, 'Per_Day', NULL, 31.0),
('Vinoth-New-STL262-New-32-50000-Interest-05-2026', 'New Finance', 'New-32', 'New-STL262', 'Vinoth', 9047015007.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1090, 'Paid', 0, 'New-P6', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Ashok-New-STL282-New-33-15000-Interest-05-2026', 'New Finance', 'New-33', 'New-STL282', 'Ashok', 7708880250.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 370.0, 15000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 370, 'Paid', 0, 'New-P6', 0, 'Yes', 370, 0.0, 'Per_Day', NULL, 31.0),
('Mariyammal-New-STL297-New-34-100000-Interest-05-2026', 'New Finance', 'New-34', 'New-STL297', 'Mariyammal', 9952102163.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P6', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Ramkumar-New-STL231-New-35-New-71-200000-Interest-05-2026', 'New Finance', 'New-35-New-71', 'New-STL231', 'Ramkumar', 9578562182.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 4340.0, 200000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 4340, 'Paid', 0, 'New-P7', 0, 'Yes', 4340, 0.0, 'Per_Day', NULL, 31.0),
('Kannan-New-STL235-New-36-100000-Interest-05-2026', 'New Finance', 'New-36', 'New-STL235', 'Kannan', 9976592192.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 3570.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 3570, 'Paid', 0, 'New-P3', 0, 'No', 4970, 0.0, 'Per_Day', NULL, 31.0),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-05-2026', 'New Finance', 'New-37', 'New-STL263', 'Sakthivel Broker', 9443835225.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P7', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Moorthy-New-STL312-New-39-50000-Interest-05-2026', 'New Finance', 'New-39', 'New-STL312', 'Moorthy', 9578562182.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1090, 'Paid', 0, 'New-P7', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Shanmugam-New-STL139-New-40-30000-Interest-05-2026', 'New Finance', 'New-40', 'New-STL139', 'Shanmugam', 9943519663.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 740.0, 30000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 740, 'Paid', 0, 'New-P8', 0, 'Yes', 740, 0.0, 'Per_Day', NULL, 31.0),
('Manivannan-New-STL182-New-41-300000-Interest-05-2026', 'New Finance', 'New-41', 'New-STL182', 'Manivannan', 9715884248.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 6510.0, 300000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 6510, 'Paid', 0, 'New-P8', 0, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Ramprakash-New-STL234-New-42-55000-Interest-05-2026', 'New Finance', 'New-42', 'New-STL234', 'Ramprakash', 9003525303.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1190.0, 55000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1190, 'Paid', 0, 'New-P8', 0, 'Yes', 1190, 0.0, 'Per_Day', NULL, 31.0),
('Murugesan-New-STL326-New-43-20000-Interest-05-2026', 'New Finance', 'New-43', 'New-STL326', 'Murugesan', 7373932218.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 500.0, 20000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 500, 'Paid', 0, 'New-P8', 0, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Kalimuthu-New-STL248-New-44-50000-Interest-05-2026', 'New Finance', 'New-44', 'New-STL248', 'Kalimuthu', 9047042275.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 1090, 'Paid', 0, 'New-P8', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Selvaguru-New-STL35-New-46-150000-Interest-05-2026', 'New Finance', 'New-46', 'New-STL35', 'Selvaguru', 9786177888.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 3260.0, 150000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 3260, 'Paid', 0, 'New-P9', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Vasudevan-New-STL116-New-47-440000-Interest-05-2026', 'New Finance', 'New-47', 'New-STL116', 'Vasudevan', 9751519191.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 9550.0, 440000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 9550, 'Paid', 0, 'New-P9', 0, 'Yes', 9550, 0.0, 'Per_Day', NULL, 31.0),
('Paramasivam-New-STL153-New-48-35000-Interest-05-2026', 'New Finance', 'New-48', 'New-STL153', 'Paramasivam', 9364455525.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 870.0, 35000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 870, 'Paid', 0, 'New-P9', 0, 'Yes', 870, 0.0, 'Per_Day', NULL, 31.0),
('Karthick-New-STL185-New-49-20000-Interest-05-2026', 'New Finance', 'New-49', 'New-STL185', 'Karthick', 9751519191.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 500.0, 20000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 500, 'Paid', 0, 'New-P9', 0, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Manikandan-New-STL195-New-50-10000-Interest-05-2026', 'New Finance', 'New-50', 'New-STL195', 'Manikandan', 9751519191.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 250.0, 10000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 250, 'Paid', 0, 'New-P9', 0, 'Yes', 250, 0.0, 'Per_Day', NULL, 31.0),
('Pradeep_NPA-New-STL123-New-51-100000-Interest-05-2026', 'New Finance', 'New-51', 'New-STL123', 'Pradeep_NPA', 9751519191.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P9', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Divakar-New-STL318-New-53-New-137-35000-Interest-05-2026', 'New Finance', 'New-53-New-137', 'New-STL318', 'Divakar', 8610561010.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 870.0, 35000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 870, 'Paid', 0, 'New-P9', 0, 'Yes', 870, 0.0, 'Per_Day', NULL, 31.0),
('Muniyappan-New-STL150-New-54-100000-Interest-05-2026', 'New Finance', 'New-54', 'New-STL150', 'Muniyappan', 9159214139.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P10', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Shanmugaraj-New-STL151-New-55-300000-Interest-05-2026', 'New Finance', 'New-55', 'New-STL151', 'Shanmugaraj', 9443781565.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 6510.0, 300000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 6510, 'Paid', 0, 'New-P10', 0, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Vignesh-New-STL260-New-57-100000-Interest-05-2026', 'New Finance', 'New-57', 'New-STL260', 'Vignesh', 9751707865.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P10', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Anand-New-STL274-New-58-20000-Interest-05-2026', 'New Finance', 'New-58', 'New-STL274', 'Anand', 7695808377.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 500.0, 20000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 500, 'Paid', 0, 'New-P10', 0, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Subramani-New-STL287-New-59-150000-Interest-05-2026', 'New Finance', 'New-59', 'New-STL287', 'Subramani', 9003446318.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 3260.0, 150000.0, '2026-02-01', '05-2026', 'Interest-05-2026', 3260, 'Paid', 0, 'New-P10', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Nagurammal-New-STL331-New-60-150000-Interest-05-2026', 'New Finance', 'New-60', 'New-STL331', 'Nagurammal', 9786870661.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 3260.0, 150000.0, '2026-02-05', '05-2026', 'Interest-05-2026', 3260, 'Paid', 0, 'New-P10', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Mani Basketball-New-STL333-New-61-150000-Interest-05-2026', 'New Finance', 'New-61', 'New-STL333', 'Mani Basketball', 9894450873.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 3260.0, 150000.0, '2026-03-04', '05-2026', 'Interest-05-2026', 3260, 'Paid', 0, 'New-P1', 0, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Sabarish-New-STL280-New-63-60000-Interest-05-2026', 'New Finance', 'New-63', 'New-STL280', 'Sabarish', 9080753749.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1300.0, 60000.0, '2026-03-09', '05-2026', 'Interest-05-2026', 1300, 'Paid', 0, 'New-P3', 0, 'Yes', 1300, 0.0, 'Per_Day', NULL, 31.0),
('Priya-New-STL320-New-65-New-130-220000-Interest-05-2026', 'New Finance', 'New-65-New-130', 'New-STL320', 'Priya', 9840807102.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 5330.0, 220000.0, '2026-03-14', '05-2026', 'Interest-05-2026', 5330, 'Paid', 0, 'New-P2', 0, 'No', 6070, 0.0, 'Per_Day', NULL, 31.0),
('Tharun-New-STL303-New-66-35000-Interest-05-2026', 'New Finance', 'New-66', 'New-STL303', 'Tharun', 9843722055.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 870.0, 35000.0, '2026-03-16', '05-2026', 'Interest-05-2026', 870, 'Paid', 0, 'New-P3', 0, 'Yes', 870, 0.0, 'Per_Day', NULL, 31.0),
('Viji Vasanth-New-STL313-New-67-150000-Interest-05-2026', 'New Finance', 'New-67', 'New-STL313', 'Viji Vasanth', 9844139371.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 3260.0, 150000.0, '2026-03-17', '05-2026', 'Interest-05-2026', 3260, 'Paid', 0, 'New-P3', 0, 'No', 4310, 0.0, 'Per_Day', NULL, 31.0),
('RanjithKumar-New-STL319-New-72-200000-Interest-05-2026', 'New Finance', 'New-72', 'New-STL319', 'RanjithKumar', 9042090520.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 4340.0, 200000.0, '2026-03-26', '05-2026', 'Interest-05-2026', 4340, 'Paid', 0, 'New-P1', 0, 'Yes', 4340, 0.0, 'Per_Day', NULL, 31.0),
('Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-05-2026', 'New Finance', 'New-73', 'New-STL334', 'Vignesh Arun Kumba', 8973249929.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-03-28', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P8', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Tharun Tex-New-STL221-New-74-50000-Interest-05-2026', 'New Finance', 'New-74', 'New-STL221', 'Tharun Tex', 8056834412.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 1140.0, 50000.0, '2026-03-28', '05-2026', 'Interest-05-2026', 1140, 'Paid', 0, 'New-P8', 0, 'Yes', 1140, 0.0, 'Per_Day', NULL, 31.0),
('Durai Master Kumbaa-New-STL335-New-75-100000-Interest-05-2026', 'New Finance', 'New-75', 'New-STL335', 'Durai Master Kumbaa', 6369910360.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 2170.0, 100000.0, '2026-03-31', '05-2026', 'Interest-05-2026', 2170, 'Paid', 0, 'New-P8', 0, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Nandhakumar-New-STL227-New-127-200000-Interest-05-2026', 'New Finance', 'New-127', 'New-STL227', 'Nandhakumar', 9361446918.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 4340.0, 200000.0, '2026-04-13', '05-2026', 'Interest-05-2026', 4340, 'Paid', 0, 'New-P10', 0, 'No', 6090, 0.0, 'Per_Day', NULL, 31.0),
('Karthi cake shop-New-STL337-New-128-200000-Interest-05-2026', 'New Finance', 'New-128', 'New-STL337', 'Karthi cake shop', 9787390814.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 4340.0, 200000.0, '2026-04-13', '05-2026', 'Interest-05-2026', 4340, 'Paid', 0, 'New-P4', 0, 'Yes', 4340, 0.0, 'Per_Day', NULL, 31.0),
('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-05-2026', 'New Finance', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 220.0, 10000.0, '2026-04-04', '05-2026', 'Interest-05-2026', 220, 'Paid', 0, 'New-P2', 0, 'Yes', 220, 0.0, 'Per_Day', NULL, 31.0),
('Ravi-New-STL306-New-134-20000-Interest-05-2026', 'New Finance', 'New-134', 'New-STL306', 'Ravi', 9751277888.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '80.0', 500.0, 20000.0, '2026-04-25', '05-2026', 'Interest-05-2026', 500, 'Paid', 0, 'New-P8', 0, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Surya Shed-New-STL339-New-135-New-136-140000-Interest-05-2026', 'New Finance', 'New-135-New-136', 'New-STL339', 'Surya Shed', 9787878005.0, '2026-05-01', '2026-05-31', '2026-05-01', 31.0, '70.0', 3040.0, 140000.0, '2026-04-27', '05-2026', 'Interest-05-2026', 3040, 'Paid', 0, 'New-P2', 0, 'Yes', 3040, 0.0, 'Per_Day', NULL, 31.0),
('Bala kaarthi-New-STL340-New-139-200000-Interest-05-2026', 'New Finance', 'New-139', 'New-STL340', 'Bala kaarthi', 9677843432.0, '2026-05-01', '2026-05-31', '2026-05-13', 19.0, '70.0', 2660.0, 200000.0, '2026-05-13', '05-2026', 'Interest-05-2026', 2660, 'Paid', 0, 'New-P3', 0, 'Yes', 2660, 0.0, 'Per_Day', NULL, 31.0),
('Murugesan pons-New-STL341-New-141-80000-Interest-05-2026', 'New Finance', 'New-141', 'New-STL341', 'Murugesan pons', 9942713540.0, '2026-05-01', '2026-05-31', '2026-05-28', 4.0, '70.0', 220.0, 80000.0, '2026-05-28', '05-2026', 'Interest-05-2026', 220, 'Paid', 0, 'New-P5', 0, 'Yes', 220, 0.0, 'Per_Day', NULL, 31.0),
('Jeyaraj pons-New-STL342-New-142-50000-Interest-05-2026', 'New Finance', 'New-142', 'New-STL342', 'Jeyaraj pons', 9788644477.0, '2026-05-01', '2026-05-31', '2026-05-25', 7.0, '70.0', 250.0, 50000.0, '2026-05-25', '05-2026', 'Interest-05-2026', 250, 'Paid', 0, 'New-P5', 0, 'Yes', 250, 0.0, 'Per_Day', NULL, 31.0),
('John-New-STL292-New-14-150000-Interest-06-2026', 'New Finance', 'New-14', 'New-STL292', 'John', 7418824749.0, '2026-06-01', '2026-06-21', '2026-06-01', 21.0, '70.0', 2200.0, 150000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 2200, 'New-P3', 2200, 'Yes', 2200, 0.0, 'Per_Day', NULL, 21.0),
('Nagurammal-New-STL331-New-60-20000-Interest-06-2026', 'New Finance', 'New-60', 'New-STL331', 'Nagurammal', 9786870661.0, '2026-06-01', '2026-06-23', '2026-06-01', 23.0, '70.0', 310.0, 20000.0, '2026-02-05', '06-2026', 'Interest-06-2026', 310, 'Paid', 0, 'New-P10', 0, 'Yes', 3040, 0.0, 'Per_Day', NULL, 23.0),
('Sabarish-New-STL280-New-63-50000-Interest-06-2026', 'New Finance', 'New-63', 'New-STL280', 'Sabarish', 9080753749.0, '2026-06-01', '2026-06-23', '2026-06-01', 23.0, '70.0', 810.0, 50000.0, '2026-03-09', '06-2026', 'Interest-06-2026', 810, 'Paid', 0, 'New-P3', 0, 'Yes', 1020, 0.0, 'Per_Day', NULL, 23.0),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-06-2026', 'New Finance', 'New-1', 'New-STL179', 'Sankara Narayanan', 9003333055.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 6300.0, 300000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 6300, 'Paid', 0, 'New-P1', 0, 'Yes', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Ramesh-New-STL257-New-2-30000-Interest-06-2026', 'New Finance', 'New-2', 'New-STL257', 'Ramesh', 8072765170.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 720.0, 30000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 720, 'Paid', 0, 'New-P1', 0, 'Yes', 720, 0.0, 'Per_Day', NULL, 30.0),
('Arul S-New-STL270-New-3-70000-Interest-06-2026', 'New Finance', 'New-3', 'New-STL270', 'Arul S', 8940864888.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1470.0, 70000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 1470, 'Paid', 0, 'New-P1', 0, 'Yes', 1470, 0.0, 'Per_Day', NULL, 30.0),
('Rangis-New-STL295-New-4-100000-Interest-06-2026', 'New Finance', 'New-4', 'New-STL295', 'Rangis', 9443732655.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P1', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Ramasamy Divya-New-STL156-New-7-50000-Interest-06-2026', 'New Finance', 'New-7', 'New-STL156', 'Ramasamy Divya', 9894465610.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 1050, 'New-P2', 1050, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Sundaravadivel-New-STL271-New-9-New-132-100000-Interest-06-2026', 'New Finance', 'New-9-New-132', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P2', 0, 'Yes', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Balasubramani Suresh-New-STL275-New-10-New-64-New-131-New-150-400000-Interest-06-2026', 'New Finance', 'New-10-New-64-New-131-New-150', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 6930.0, 400000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 6930, 'Paid', 0, 'New-P2', 6930, 'Yes', 13860, 0.0, 'Per_Day', NULL, 30.0),
('Nagaraj Post-New-STL301-New-11-New-151-40000-Interest-06-2026', 'New Finance', 'New-11-New-151', 'New-STL301', 'Nagaraj Post', 9150787857.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 840.0, 40000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 840, 'Paid', 0, 'New-P2', 0, 'Yes', 840, 0.0, 'Per_Day', NULL, 30.0),
('Arul M-New-STL330-New-13-New-62-New-68-55000-Interest-06-2026', 'New Finance', 'New-13-New-62-New-68', 'New-STL330', 'Arul M', 9626262427.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1160.0, 55000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 1160, 'Paid', 0, 'New-P2', 0, 'Yes', 1160, 0.0, 'Per_Day', NULL, 30.0),
('Praveen Ram-New-STL324-New-16-80000-Interest-06-2026', 'New Finance', 'New-16', 'New-STL324', 'Praveen Ram', 9715778326.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1680.0, 80000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 1680, 'Paid', 0, 'New-P3', 0, 'Yes', 1680, 0.0, 'Per_Day', NULL, 30.0),
('Dinesh-New-STL78-New-19-10000-Interest-06-2026', 'New Finance', 'New-19', 'New-STL78', 'Dinesh', 9942153364.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 210.0, 10000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 210, 'Paid', 0, 'New-P5', 0, 'Yes', 210, 0.0, 'Per_Day', NULL, 30.0),
('Jayapal-New-STL121-New-20-100000-Interest-06-2026', 'New Finance', 'New-20', 'New-STL121', 'Jayapal', 9788544477.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 2100, 'New-P5', 2100, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Udhayakumar-New-STL126-New-21-110000-Interest-06-2026', 'New Finance', 'New-21', 'New-STL126', 'Udhayakumar', 9965656493.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2310.0, 110000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 550, 'Pending', 1760, 'New-P5', 1760, 'No', 2330, 0.0, 'Per_Day', NULL, 30.0),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-06-2026', 'New Finance', 'New-23', 'New-STL273', 'Suresh Abudhabi', 7200035939.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1260.0, 60000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 1260, 'Paid', 0, 'New-P5', 0, 'Yes', 1260, 0.0, 'Per_Day', NULL, 30.0),
('Yagappan-New-STL278-New-25-20000-Interest-06-2026', 'New Finance', 'New-25', 'New-STL278', 'Yagappan', 8248805311.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 480.0, 20000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 480, 'Paid', 0, 'New-P5', 0, 'Yes', 480, 0.0, 'Per_Day', NULL, 30.0),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-06-2026', 'New Finance', 'New-26', 'New-STL304', 'Sakthivel Jayaraj', 9943013586.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P5', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Mahesh-New-STL308-New-27-50000-Interest-06-2026', 'New Finance', 'New-27', 'New-STL308', 'Mahesh', 9080383024.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 1050, 'Paid', 0, 'New-P5', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Kaviyarasu Arul-New-STL323-New-28-New-125-950000-Interest-06-2026', 'New Finance', 'New-28-New-125', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 19950.0, 950000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 19950, 'Paid', 0, 'New-P4', 0, 'Yes', 19950, 0.0, 'Per_Day', NULL, 30.0),
('Danendran-New-STL46-New-29-95000-Interest-06-2026', 'New Finance', 'New-29', 'New-STL46', 'Danendran', 9865388000.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2000.0, 95000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 2000, 'New-P6', 2000, 'Yes', 2000, 0.0, 'Per_Day', NULL, 30.0),
('Rajendran-New-STL58-New-30-15000-Interest-06-2026', 'New Finance', 'New-30', 'New-STL58', 'Rajendran', 9865388000.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 360.0, 15000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 360, 'Paid', 0, 'New-P6', 0, 'Yes', 360, 0.0, 'Per_Day', NULL, 30.0),
('Karnan-New-STL160-New-31-400000-Interest-06-2026', 'New Finance', 'New-31', 'New-STL160', 'Karnan', 9789502425.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 8400.0, 400000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 8400, 'New-P6', 8400, 'Yes', 8400, 0.0, 'Per_Day', NULL, 30.0),
('Vinoth-New-STL262-New-32-50000-Interest-06-2026', 'New Finance', 'New-32', 'New-STL262', 'Vinoth', 9047015007.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 1050, 'Paid', 0, 'New-P6', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Ashok-New-STL282-New-33-15000-Interest-06-2026', 'New Finance', 'New-33', 'New-STL282', 'Ashok', 7708880250.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 360.0, 15000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 360, 'Paid', 0, 'New-P6', 0, 'Yes', 360, 0.0, 'Per_Day', NULL, 30.0),
('Mariyammal-New-STL297-New-34-100000-Interest-06-2026', 'New Finance', 'New-34', 'New-STL297', 'Mariyammal', 9952102163.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P6', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Ramkumar-New-STL231-New-35-New-71-200000-Interest-06-2026', 'New Finance', 'New-35-New-71', 'New-STL231', 'Ramkumar', 9578562182.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 4200.0, 200000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 4200, 'Paid', 0, 'New-P7', 0, 'Yes', 4200, 0.0, 'Per_Day', NULL, 30.0),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-06-2026', 'New Finance', 'New-37', 'New-STL263', 'Sakthivel Broker', 9443835225.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P7', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Moorthy-New-STL312-New-39-50000-Interest-06-2026', 'New Finance', 'New-39', 'New-STL312', 'Moorthy', 9578562182.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 1050, 'Paid', 0, 'New-P7', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Shanmugam-New-STL139-New-40-30000-Interest-06-2026', 'New Finance', 'New-40', 'New-STL139', 'Shanmugam', 9943519663.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 720.0, 30000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 720, 'Paid', 0, 'New-P8', 0, 'Yes', 720, 0.0, 'Per_Day', NULL, 30.0),
('Manivannan-New-STL182-New-41-300000-Interest-06-2026', 'New Finance', 'New-41', 'New-STL182', 'Manivannan', 9715884248.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 6300.0, 300000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 6300, 'Paid', 0, 'New-P8', 0, 'Yes', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Ramprakash-New-STL234-New-42-55000-Interest-06-2026', 'New Finance', 'New-42', 'New-STL234', 'Ramprakash', 9003525303.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1160.0, 55000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 1160, 'Paid', 0, 'New-P8', 0, 'Yes', 1160, 0.0, 'Per_Day', NULL, 30.0),
('Murugesan-New-STL326-New-43-20000-Interest-06-2026', 'New Finance', 'New-43', 'New-STL326', 'Murugesan', 7373932218.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 480.0, 20000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 480, 'Paid', 0, 'New-P8', 0, 'Yes', 480, 0.0, 'Per_Day', NULL, 30.0),
('Kalimuthu-New-STL248-New-44-50000-Interest-06-2026', 'New Finance', 'New-44', 'New-STL248', 'Kalimuthu', 9047042275.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 1050, 'New-P8', 1050, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Selvaguru-New-STL35-New-46-150000-Interest-06-2026', 'New Finance', 'New-46', 'New-STL35', 'Selvaguru', 9786177888.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 3150.0, 150000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 3150, 'New-P9', 3150, 'Yes', 3150, 0.0, 'Per_Day', NULL, 30.0),
('Vasudevan-New-STL116-New-47-New-146-New-147-New-152-565000-Interest-06-2026', 'New Finance', 'New-47-New-146-New-147-New-152', 'New-STL116', 'Vasudevan', 9751519191.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 11490.0, 565000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 90, 'Pending', 11400, 'New-P9', 11400, 'Yes', 11490, 0.0, 'Per_Day', NULL, 30.0),
('Pradeep_NPA-New-STL123-New-51-100000-Interest-06-2026', 'New Finance', 'New-51', 'New-STL123', 'Pradeep_NPA', 9751519191.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 2100, 'New-P9', 2100, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Divakar-New-STL318-New-53-New-137-35000-Interest-06-2026', 'New Finance', 'New-53-New-137', 'New-STL318', 'Divakar', 8610561010.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 840.0, 35000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 840, 'Paid', 0, 'New-P9', 0, 'Yes', 840, 0.0, 'Per_Day', NULL, 30.0),
('Muniyappan-New-STL150-New-54-100000-Interest-06-2026', 'New Finance', 'New-54', 'New-STL150', 'Muniyappan', 9159214139.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P10', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Shanmugaraj-New-STL151-New-55-300000-Interest-06-2026', 'New Finance', 'New-55', 'New-STL151', 'Shanmugaraj', 9443781565.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 6300.0, 300000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 6300, 'Paid', 0, 'New-P10', 0, 'Yes', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Vignesh-New-STL260-New-57-100000-Interest-06-2026', 'New Finance', 'New-57', 'New-STL260', 'Vignesh', 9751707865.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P10', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Anand-New-STL274-New-58-20000-Interest-06-2026', 'New Finance', 'New-58', 'New-STL274', 'Anand', 7695808377.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 480.0, 20000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 480, 'Paid', 0, 'New-P10', 0, 'Yes', 480, 0.0, 'Per_Day', NULL, 30.0),
('Subramani-New-STL287-New-59-150000-Interest-06-2026', 'New Finance', 'New-59', 'New-STL287', 'Subramani', 9003446318.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 3150.0, 150000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 3150, 'Paid', 0, 'New-P10', 0, 'Yes', 3150, 0.0, 'Per_Day', NULL, 30.0),
('Nagurammal-New-STL331-New-60-130000-Interest-06-2026', 'New Finance', 'New-60', 'New-STL331', 'Nagurammal', 9786870661.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2730.0, 130000.0, '2026-02-05', '06-2026', 'Interest-06-2026', 2730, 'Paid', 0, 'New-P10', 0, 'No', 3040, 0.0, 'Per_Day', NULL, 30.0),
('Mani Basketball-New-STL333-New-61-50000-Interest-06-2026', 'New Finance', 'New-61', 'New-STL333', 'Mani Basketball', 9894450873.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-03-04', '06-2026', 'Interest-06-2026', 1050, 'Paid', 0, 'New-P1', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Sabarish-New-STL280-New-63-10000-Interest-06-2026', 'New Finance', 'New-63', 'New-STL280', 'Sabarish', 9080753749.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 210.0, 10000.0, '2026-03-09', '06-2026', 'Interest-06-2026', 210, 'Paid', 0, 'New-P3', 0, 'No', 1020, 0.0, 'Per_Day', NULL, 30.0);
insert into "Interest_Details" ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Total_Month_Days") values
('Priya-New-STL320-New-65-New-130-New-144-360000-Interest-06-2026', 'New Finance', 'New-65-New-130-New-144', 'New-STL320', 'Priya', 9840807102.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 7560.0, 360000.0, '2026-03-14', '06-2026', 'Interest-06-2026', 7560, 'Paid', 0, 'New-P2', 0, 'No', 7730, 0.0, 'Per_Day', NULL, 30.0),
('Tharun-New-STL303-New-66-10000-Interest-06-2026', 'New Finance', 'New-66', 'New-STL303', 'Tharun', 9843722055.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80', 240.0, 10000.0, '2026-03-16', '06-2026', 'Interest-06-2026', 240, 'Paid', 0, 'New-P3', 0, 'Yes', 240, 0.0, 'Per_Day', NULL, 30.0),
('Viji Vasanth-New-STL313-New-67-150000-Interest-06-2026', 'New Finance', 'New-67', 'New-STL313', 'Viji Vasanth', 9844139371.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 3150.0, 150000.0, '2026-03-17', '06-2026', 'Interest-06-2026', 3150, 'Paid', 0, 'New-P3', 0, 'Yes', 3150, 0.0, 'Per_Day', NULL, 30.0),
('RanjithKumar-New-STL319-New-72-200000-Interest-06-2026', 'New Finance', 'New-72', 'New-STL319', 'RanjithKumar', 9042090520.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 4200.0, 200000.0, '2026-03-26', '06-2026', 'Interest-06-2026', 4200, 'Paid', 0, 'New-P1', 0, 'Yes', 4200, 0.0, 'Per_Day', NULL, 30.0),
('Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-06-2026', 'New Finance', 'New-73', 'New-STL334', 'Vignesh Arun Kumba', 8973249929.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-03-28', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P8', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Tharun Tex-New-STL221-New-74-50000-Interest-06-2026', 'New Finance', 'New-74', 'New-STL221', 'Tharun Tex', 8056834412.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-03-28', '06-2026', 'Interest-06-2026', 1050, 'Paid', 0, 'New-P8', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Durai Master Kumbaa-New-STL335-New-75-100000-Interest-06-2026', 'New Finance', 'New-75', 'New-STL335', 'Durai Master Kumbaa', 6369910360.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-03-31', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P8', 0, 'Yes', 2100, 0.0, 'Per_Day', NULL, 30.0),
('Nandhakumar-New-STL227-New-127-200000-Interest-06-2026', 'New Finance', 'New-127', 'New-STL227', 'Nandhakumar', 9361446918.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 4200.0, 200000.0, '2026-04-13', '06-2026', 'Interest-06-2026', 4200, 'Paid', 0, 'New-P10', 0, 'Yes', 4200, 0.0, 'Per_Day', NULL, 30.0),
('Karthi cake shop-New-STL337-New-128-200000-Interest-06-2026', 'New Finance', 'New-128', 'New-STL337', 'Karthi cake shop', 9787390814.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 4200.0, 200000.0, '2026-04-13', '06-2026', 'Interest-06-2026', 4200, 'Paid', 0, 'New-P4', 0, 'Yes', 4200, 0.0, 'Per_Day', NULL, 30.0),
('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-06-2026', 'New Finance', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 210.0, 10000.0, '2026-04-04', '06-2026', 'Interest-06-2026', 210, 'Paid', 0, 'New-P2', 0, 'Yes', 210, 0.0, 'Per_Day', NULL, 30.0),
('Kaviraj-New-STL338-New-133-10000-Interest-06-2026', 'New Finance', 'New-133', 'New-STL338', 'Kaviraj', 9943341540.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80', 240.0, 10000.0, '2026-04-20', '06-2026', 'Interest-06-2026', 240, 'Paid', 0, 'New-P1', 0, 'Yes', 240, 0.0, 'Per_Day', NULL, 30.0),
('Ravi-New-STL306-New-134-20000-Interest-06-2026', 'New Finance', 'New-134', 'New-STL306', 'Ravi', 9751277888.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '80.0', 480.0, 20000.0, '2026-04-25', '06-2026', 'Interest-06-2026', 480, 'Paid', 0, 'New-P8', 0, 'Yes', 480, 0.0, 'Per_Day', NULL, 30.0),
('Surya Shed-New-STL339-New-135-New-136-New-148-490000-Interest-06-2026', 'New Finance', 'New-135-New-136-New-148', 'New-STL339', 'Surya Shed', 9787878005.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 7350.0, 490000.0, '2026-04-27', '06-2026', 'Interest-06-2026', 7350, 'Paid', 0, 'New-P2', 0, 'Yes', 7350, 0.0, 'Per_Day', NULL, 30.0),
('Bala kaarthi-New-STL340-New-139-200000-Interest-06-2026', 'New Finance', 'New-139', 'New-STL340', 'Bala kaarthi', 9677843432.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 4200.0, 200000.0, '2026-05-13', '06-2026', 'Interest-06-2026', 4200, 'Paid', 0, 'New-P3', 0, 'Yes', 4200, 0.0, 'Per_Day', NULL, 30.0),
('Murugesan pons-New-STL341-New-141-New-143-280000-Interest-06-2026', 'New Finance', 'New-141-New-143', 'New-STL341', 'Murugesan pons', 9942713540.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 5880.0, 280000.0, '2026-05-28', '06-2026', 'Interest-06-2026', 5880, 'Paid', 0, 'New-P5', -1050, 'Yes', 5250, 0.0, 'Per_Day', NULL, 30.0),
('Jeyaraj pons-New-STL342-New-142-50000-Interest-06-2026', 'New Finance', 'New-142', 'New-STL342', 'Jeyaraj pons', 9788644477.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-05-25', '06-2026', 'Interest-06-2026', 1050, 'Paid', 0, 'New-P5', 0, 'Yes', 1050, 0.0, 'Per_Day', NULL, 30.0),
('Prakash S M-New-STL343-New-145-80000-Interest-06-2026', 'New Finance', 'New-145', 'New-STL343', 'Prakash S M', 9865388000.0, '2026-06-01', '2026-06-30', '2026-06-05', 26.0, '70.0', 1460.0, 80000.0, '2026-06-05', '06-2026', 'Interest-06-2026', 1460, 'Paid', 0, 'New-P6', 0, 'Yes', 1460, 0.0, 'Per_Day', NULL, 30.0),
('Suresh CCTV-New-STL344-New-149-50000-Interest-06-2026', 'New Finance', 'New-149', 'New-STL344', 'Suresh CCTV', 8861715281.0, '2026-06-01', '2026-06-30', '2026-06-15', 16.0, '70.0', 560.0, 50000.0, '2026-06-15', '06-2026', 'Interest-06-2026', 560, 'Paid', 0, 'New-P1', 0, 'Yes', 560, 0.0, 'Per_Day', NULL, 30.0),
('Sundaravadivel-New-STL271-New-9-132-100000-Interest-06-2026', 'New Finance', 'New-9-132', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 2100.0, 100000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 2100, 'Paid', 0, 'New-P2', 0, 'No', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Murugesan pons-New-STL341-New-141-20000-Interest-06-2026', 'New Finance', 'New-141', 'New-STL341', 'Murugesan pons', 9942713540.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 420.0, 20000.0, '2026-05-28', '06-2026', 'Interest-06-2026', 420, 'Paid', 0, 'New-P5', -1050, 'No', 5250, 0.0, 'Per_Day', NULL, 30.0),
('Jeyaraj pons-New-STL342-New-142-50000-Interest-07-2026', 'New Finance', 'New-142', 'New-STL342', 'Jeyaraj pons', 9788644477.0, '2026-07-01', '2026-07-07', '2026-07-01', 7.0, '70.0', 245.0, 50000.0, '2026-05-25', '07-2026', 'Interest-07-2026', 490, 'Pending', -245, 'New-P5', -245, 'Yes', 245, 0.0, 'Per_Day', NULL, 7.0),
('Murugesan pons-New-STL341-New-143-250000-Interest-07-2026', 'New Finance', 'New-143', 'New-STL341', 'Murugesan pons', 9942713540.0, '2026-07-01', '2026-07-12', '2026-07-01', 12.0, '70.0', 2100.0, 250000.0, '2026-06-01', '07-2026', 'Interest-07-2026', 2040, 'Pending', 60, 'New-P5', 420, 'Yes', 2460, 0.0, 'Per_Day', NULL, 12.0),
('Kaviyarasu Arul-New-STL323-New-125-50000-Interest-07-2026', 'New Finance', 'New-125', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, '2026-07-01', '2026-07-14', '2026-07-01', 14.0, '70.0', 490.0, 50000.0, '2026-04-02', '07-2026', 'Interest-07-2026', 0, 'Pending', 490, 'New-P4', 20020, 'Yes', 20020, 0.0, 'Per_Day', NULL, 14.0),
('Murugesan-New-STL326-New-157-200000-Interest-07-2026', 'New Finance', 'New-157', 'New-STL326', 'Murugesan', 7373932218.0, '2026-07-01', '2026-07-14', '2026-07-10', 5.0, '80.0', 800.0, 200000.0, '2026-07-10', '07-2026', 'Interest-07-2026', 700, 'Pending', 100, 'New-P8', 600, 'Yes', 1300, 0.0, 'Per_Day', NULL, 14.0),
('Nandhakumar-New-STL227-New-127-50000-Interest-07-2026', 'New Finance', 'New-127', 'New-STL227', 'Nandhakumar', 9361446918.0, '2026-07-01', '2026-07-15', '2026-07-01', 15.0, '70.0', 525.0, 50000.0, '2026-04-13', '07-2026', 'Interest-07-2026', 0, 'Pending', 525, 'New-P10', 3785, 'Yes', 3785, 0.0, 'Per_Day', NULL, 15.0),
('RanjithKumar-New-STL319-New-72-200000-Interest-07-2026', 'New Finance', 'New-72', 'New-STL319', 'RanjithKumar', 9042090520.0, '2026-07-01', '2026-07-21', '2026-07-01', 21.0, '70.0', 2940.0, 200000.0, '2026-03-26', '07-2026', 'Interest-07-2026', 5880, 'Pending', -2940, 'New-P1', -2940, 'Yes', 2940, 0.0, 'Per_Day', NULL, 21.0),
('Vinoth Ravi vangalamman-New-STL347-New-159-250000-Interest-07-2026', 'New Finance', 'New-159', 'New-STL347', 'Vinoth Ravi vangalamman', 8122484554.0, '2026-07-01', '2026-07-21', '2026-07-15', 7.0, '70.0', 1225.0, 250000.0, '2026-07-15', '07-2026', 'Interest-07-2026', 2450, 'Pending', -1225, 'New-P3', -1225, 'Yes', 1225, 0.0, 'Per_Day', NULL, 21.0),
('Ravi-New-STL306-New-154-75000-Interest-07-2026', 'New Finance', 'New-154', 'New-STL306', 'Ravi', 9751277888.0, '2026-07-01', '2026-07-28', '2026-07-01', 28.0, '70.0', 1470.0, 75000.0, '2026-07-01', '07-2026', 'Interest-07-2026', 1470, 'Paid', 0, 'New-P8', 0, 'Yes', 1970, 0.0, 'Per_Day', NULL, 28.0),
('Murugesan pons-New-STL341-New-143--50000-Interest-06-2026', 'New Finance', 'New-143', 'New-STL341', 'Murugesan pons', 9942713540.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', -1050.0, -50000.0, '2026-06-01', '06-2026', 'Interest-06-2026', 0, 'Pending', -1050, 'New-P5', -1050, 'No', 5250, 0.0, 'Per_Day', NULL, 30.0),
('Sundaravadivel-New-STL271-New-9-50000-Interest-06-2026', 'New Finance', 'New-9', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 1050, 'Paid', 0, 'New-P2', 0, 'No', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Balasubramani Suresh-New-STL275-New-10-64-131-150-400000-Interest-06-2026', 'New Finance', 'New-10-64-131-150', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 6930.0, 400000.0, '2026-02-01', '06-2026', 'Interest-06-2026', 0, 'Pending', 6930, 'New-P2', 6930, 'No', 13860, 0.0, 'Per_Day', NULL, 30.0),
('Sundaravadivel-New-STL271-New-132-50000-Interest-06-2026', 'New Finance', 'New-132', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-06-01', '2026-06-30', '2026-06-01', 30.0, '70.0', 1050.0, 50000.0, '2026-04-18', '06-2026', 'Interest-06-2026', 1050, 'Paid', 0, 'New-P2', 0, 'No', 6300, 0.0, 'Per_Day', NULL, 30.0),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-07-2026', 'New Finance', 'New-1', 'New-STL179', 'Sankara Narayanan', 9003333055.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 6510.0, 300000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 6510, 'New-P1', 6510, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Ramesh-New-STL257-New-2-30000-Interest-07-2026', 'New Finance', 'New-2', 'New-STL257', 'Ramesh', 8072765170.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 740.0, 30000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 740, 'New-P1', 740, 'Yes', 740, 0.0, 'Per_Day', NULL, 31.0),
('Arul S-New-STL270-New-3-New-153-110000-Interest-07-2026', 'New Finance', 'New-3-New-153', 'New-STL270', 'Arul S', 8940864888.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2390.0, 110000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2390, 'New-P1', 2390, 'Yes', 2390, 0.0, 'Per_Day', NULL, 31.0),
('Rangis-New-STL295-New-4-100000-Interest-07-2026', 'New Finance', 'New-4', 'New-STL295', 'Rangis', 9443732655.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'New-P1', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Ramasamy Divya-New-STL156-New-7-50000-Interest-07-2026', 'New Finance', 'New-7', 'New-STL156', 'Ramasamy Divya', 9894465610.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1090, 'New-P2', 1090, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Sundaravadivel-New-STL271-New-9-New-132-100000-Interest-07-2026', 'New Finance', 'New-9-New-132', 'New-STL271', 'Sundaravadivel', 8072211260.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'New-P2', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Balasubramani Suresh-New-STL275-New-10-New-64-New-131-New-150-400000-Interest-07-2026', 'New Finance', 'New-10-New-64-New-131-New-150', 'New-STL275', 'Balasubramani Suresh', 9080548538.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 8680.0, 400000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 8680, 'New-P2', 8680, 'Yes', 8680, 0.0, 'Per_Day', NULL, 31.0),
('Nagaraj Post-New-STL301-New-11-New-151-40000-Interest-07-2026', 'New Finance', 'New-11-New-151', 'New-STL301', 'Nagaraj Post', 9150787857.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 960.0, 40000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 960, 'New-P2', 960, 'Yes', 960, 0.0, 'Per_Day', NULL, 31.0),
('Arul M-New-STL330-New-13-New-62-New-68-55000-Interest-07-2026', 'New Finance', 'New-13-New-62-New-68', 'New-STL330', 'Arul M', 9626262427.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1190.0, 55000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1190, 'New-P2', 1190, 'Yes', 1190, 0.0, 'Per_Day', NULL, 31.0),
('Praveen Ram-New-STL324-New-16-80000-Interest-07-2026', 'New Finance', 'New-16', 'New-STL324', 'Praveen Ram', 9715778326.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1740.0, 80000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1740, 'New-P3', 1740, 'Yes', 1740, 0.0, 'Per_Day', NULL, 31.0),
('Jayapal-New-STL121-New-20-100000-Interest-07-2026', 'New Finance', 'New-20', 'New-STL121', 'Jayapal', 9788544477.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'New-P5', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Udhayakumar-New-STL126-New-21-110000-Interest-07-2026', 'New Finance', 'New-21', 'New-STL126', 'Udhayakumar', 9965656493.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2390.0, 110000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2390, 'New-P5', 2390, 'Yes', 2390, 0.0, 'Per_Day', NULL, 31.0),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-07-2026', 'New Finance', 'New-23', 'New-STL273', 'Suresh Abudhabi', 7200035939.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1300.0, 60000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1300, 'New-P5', 1300, 'Yes', 1300, 0.0, 'Per_Day', NULL, 31.0),
('Yagappan-New-STL278-New-25-20000-Interest-07-2026', 'New Finance', 'New-25', 'New-STL278', 'Yagappan', 8248805311.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 500.0, 20000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 500, 'New-P5', 500, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Sakthivel Jayaraj-New-STL304-New-26-New-162-200000-Interest-07-2026', 'New Finance', 'New-26-New-162', 'New-STL304', 'Sakthivel Jayaraj', 9943013586.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2660.0, 200000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2660, 'New-P5', 2660, 'Yes', 2660, 0.0, 'Per_Day', NULL, 31.0),
('Mahesh-New-STL308-New-27-50000-Interest-07-2026', 'New Finance', 'New-27', 'New-STL308', 'Mahesh', 9080383024.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1090, 'New-P5', 1090, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Kaviyarasu Arul-New-STL323-New-28-New-125-900000-Interest-07-2026', 'New Finance', 'New-28-New-125', 'New-STL323', 'Kaviyarasu Arul', 9629998999.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 19530.0, 900000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 19530, 'New-P4', 20020, 'No', 20020, 0.0, 'Per_Day', NULL, 31.0),
('Danendran-New-STL46-New-29-95000-Interest-07-2026', 'New Finance', 'New-29', 'New-STL46', 'Danendran', 9865388000.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2060.0, 95000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2060, 'New-P6', 2060, 'Yes', 2060, 0.0, 'Per_Day', NULL, 31.0),
('Rajendran-New-STL58-New-30-15000-Interest-07-2026', 'New Finance', 'New-30', 'New-STL58', 'Rajendran', 9865388000.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 370.0, 15000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 370, 'New-P6', 370, 'Yes', 370, 0.0, 'Per_Day', NULL, 31.0),
('Karnan-New-STL160-New-31-400000-Interest-07-2026', 'New Finance', 'New-31', 'New-STL160', 'Karnan', 9789502425.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 8680.0, 400000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 8680, 'New-P6', 8680, 'Yes', 8680, 0.0, 'Per_Day', NULL, 31.0),
('Vinoth-New-STL262-New-32-50000-Interest-07-2026', 'New Finance', 'New-32', 'New-STL262', 'Vinoth', 9047015007.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1090, 'New-P6', 1090, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Ashok-New-STL282-New-33-15000-Interest-07-2026', 'New Finance', 'New-33', 'New-STL282', 'Ashok', 7708880250.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 370.0, 15000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 370, 'New-P6', 370, 'Yes', 370, 0.0, 'Per_Day', NULL, 31.0),
('Mariyammal-New-STL297-New-34-100000-Interest-07-2026', 'New Finance', 'New-34', 'New-STL297', 'Mariyammal', 9952102163.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 4340, 'Pending', -2170, 'New-P6', -2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Ramkumar-New-STL231-New-35-New-71-200000-Interest-07-2026', 'New Finance', 'New-35-New-71', 'New-STL231', 'Ramkumar', 9578562182.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 4340.0, 200000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 4340, 'New-P7', 4340, 'Yes', 4340, 0.0, 'Per_Day', NULL, 31.0),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-07-2026', 'New Finance', 'New-37', 'New-STL263', 'Sakthivel Broker', 9443835225.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'New-P7', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Moorthy-New-STL312-New-39-50000-Interest-07-2026', 'New Finance', 'New-39', 'New-STL312', 'Moorthy', 9578562182.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1090, 'New-P7', 1090, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Shanmugam-New-STL139-New-40-30000-Interest-07-2026', 'New Finance', 'New-40', 'New-STL139', 'Shanmugam', 9943519663.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 740.0, 30000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 740, 'New-P8', 740, 'Yes', 740, 0.0, 'Per_Day', NULL, 31.0),
('Manivannan-New-STL182-New-41-300000-Interest-07-2026', 'New Finance', 'New-41', 'New-STL182', 'Manivannan', 9715884248.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 6510.0, 300000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 6510, 'New-P8', 6510, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Ramprakash-New-STL234-New-42-55000-Interest-07-2026', 'New Finance', 'New-42', 'New-STL234', 'Ramprakash', 9003525303.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1190.0, 55000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1190, 'New-P8', 1190, 'Yes', 1190, 0.0, 'Per_Day', NULL, 31.0),
('Murugesan-New-STL326-New-43-20000-Interest-07-2026', 'New Finance', 'New-43', 'New-STL326', 'Murugesan', 7373932218.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 500.0, 20000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 500, 'New-P8', 600, 'No', 1300, 0.0, 'Per_Day', NULL, 31.0),
('Kalimuthu-New-STL248-New-44-50000-Interest-07-2026', 'New Finance', 'New-44', 'New-STL248', 'Kalimuthu', 9047042275.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1090.0, 50000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 1090, 'New-P8', 1090, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Selvaguru-New-STL35-New-46-150000-Interest-07-2026', 'New Finance', 'New-46', 'New-STL35', 'Selvaguru', 9786177888.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 3260.0, 150000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 3260, 'New-P9', 3260, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Vasudevan-New-STL116-New-47-New-146-New-147-New-152-565000-Interest-07-2026', 'New Finance', 'New-47-New-146-New-147-New-152', 'New-STL116', 'Vasudevan', 9751519191.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 12260.0, 565000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 12260, 'New-P9', 12260, 'Yes', 12260, 0.0, 'Per_Day', NULL, 31.0),
('Pradeep_NPA-New-STL123-New-51-100000-Interest-07-2026', 'New Finance', 'New-51', 'New-STL123', 'Pradeep_NPA', 9751519191.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'New-P9', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Divakar-New-STL318-New-53-New-137-35000-Interest-07-2026', 'New Finance', 'New-53-New-137', 'New-STL318', 'Divakar', 8610561010.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 840.0, 35000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 840, 'New-P9', 840, 'Yes', 840, 0.0, 'Per_Day', NULL, 31.0),
('Muniyappan-New-STL150-New-54-100000-Interest-07-2026', 'New Finance', 'New-54', 'New-STL150', 'Muniyappan', 9159214139.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'New-P10', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Shanmugaraj-New-STL151-New-55-300000-Interest-07-2026', 'New Finance', 'New-55', 'New-STL151', 'Shanmugaraj', 9443781565.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 6510.0, 300000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 13020, 'Pending', -6510, 'New-P10', -6510, 'Yes', 6510, 0.0, 'Per_Day', NULL, 31.0),
('Vignesh-New-STL260-New-57-100000-Interest-07-2026', 'New Finance', 'New-57', 'New-STL260', 'Vignesh', 9751707865.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'New-P10', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Anand-New-STL274-New-58-20000-Interest-07-2026', 'New Finance', 'New-58', 'New-STL274', 'Anand', 7695808377.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 500.0, 20000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 500, 'New-P10', 500, 'Yes', 500, 0.0, 'Per_Day', NULL, 31.0),
('Subramani-New-STL287-New-59-150000-Interest-07-2026', 'New Finance', 'New-59', 'New-STL287', 'Subramani', 9003446318.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 3260.0, 150000.0, '2026-02-01', '07-2026', 'Interest-07-2026', 0, 'Pending', 3260, 'New-P10', 3260, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Nagurammal-New-STL331-New-60-130000-Interest-07-2026', 'New Finance', 'New-60', 'New-STL331', 'Nagurammal', 9786870661.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2820.0, 130000.0, '2026-02-05', '07-2026', 'Interest-07-2026', 0, 'Pending', 2820, 'New-P10', 2820, 'Yes', 2820, 0.0, 'Per_Day', NULL, 31.0),
('Mani Basketball-New-STL333-New-61-50000-Interest-07-2026', 'New Finance', 'New-61', 'New-STL333', 'Mani Basketball', 9894450873.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1090.0, 50000.0, '2026-03-04', '07-2026', 'Interest-07-2026', 1090, 'Paid', 0, 'New-P1', 0, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Sabarish-New-STL280-New-63-New-155-35000-Interest-07-2026', 'New Finance', 'New-63-New-155', 'New-STL280', 'Sabarish', 9080753749.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 760.0, 35000.0, '2026-03-09', '07-2026', 'Interest-07-2026', 1520, 'Pending', -760, 'New-P3', -760, 'Yes', 760, 0.0, 'Per_Day', NULL, 31.0),
('Priya-New-STL320-New-65-New-130-New-144-360000-Interest-07-2026', 'New Finance', 'New-65-New-130-New-144', 'New-STL320', 'Priya', 9840807102.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 7810.0, 360000.0, '2026-03-14', '07-2026', 'Interest-07-2026', 15620, 'Pending', -7810, 'New-P2', -7810, 'Yes', 7810, 0.0, 'Per_Day', NULL, 31.0),
('Tharun-New-STL303-New-66-10000-Interest-07-2026', 'New Finance', 'New-66', 'New-STL303', 'Tharun', 9843722055.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 220.0, 10000.0, '2026-03-16', '07-2026', 'Interest-07-2026', 0, 'Pending', 220, 'New-P3', 220, 'Yes', 220, 0.0, 'Per_Day', NULL, 31.0),
('Viji Vasanth-New-STL313-New-67-150000-Interest-07-2026', 'New Finance', 'New-67', 'New-STL313', 'Viji Vasanth', 9844139371.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 3260.0, 150000.0, '2026-03-17', '07-2026', 'Interest-07-2026', 0, 'Pending', 3260, 'New-P3', 3260, 'Yes', 3260, 0.0, 'Per_Day', NULL, 31.0),
('Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-07-2026', 'New Finance', 'New-73', 'New-STL334', 'Vignesh Arun Kumba', 8973249929.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-03-28', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'New-P8', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Tharun Tex-New-STL221-New-74-50000-Interest-07-2026', 'New Finance', 'New-74', 'New-STL221', 'Tharun Tex', 8056834412.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1090.0, 50000.0, '2026-03-28', '07-2026', 'Interest-07-2026', 0, 'Pending', 1090, 'New-P8', 1090, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Durai Master Kumbaa-New-STL335-New-75-100000-Interest-07-2026', 'New Finance', 'New-75', 'New-STL335', 'Durai Master Kumbaa', 6369910360.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 2170.0, 100000.0, '2026-03-31', '07-2026', 'Interest-07-2026', 0, 'Pending', 2170, 'New-P8', 2170, 'Yes', 2170, 0.0, 'Per_Day', NULL, 31.0),
('Nandhakumar-New-STL227-New-127-150000-Interest-07-2026', 'New Finance', 'New-127', 'New-STL227', 'Nandhakumar', 9361446918.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 3260.0, 150000.0, '2026-04-13', '07-2026', 'Interest-07-2026', 0, 'Pending', 3260, 'New-P10', 3785, 'No', 3785, 0.0, 'Per_Day', NULL, 31.0),
('Karthi cake shop-New-STL337-New-128-200000-Interest-07-2026', 'New Finance', 'New-128', 'New-STL337', 'Karthi cake shop', 9787390814.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 4340.0, 200000.0, '2026-04-13', '07-2026', 'Interest-07-2026', 0, 'Pending', 4340, 'New-P4', 4340, 'Yes', 4340, 0.0, 'Per_Day', NULL, 31.0),
('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-07-2026', 'New Finance', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 220.0, 10000.0, '2026-04-04', '07-2026', 'Interest-07-2026', 0, 'Pending', 220, 'New-P2', 220, 'Yes', 220, 0.0, 'Per_Day', NULL, 31.0),
('Kaviraj-New-STL338-New-133-10000-Interest-07-2026', 'New Finance', 'New-133', 'New-STL338', 'Kaviraj', 9943341540.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80', 220.0, 10000.0, '2026-04-20', '07-2026', 'Interest-07-2026', 0, 'Pending', 220, 'New-P1', 220, 'Yes', 220, 0.0, 'Per_Day', NULL, 31.0),
('Ravi-New-STL306-New-134-20000-Interest-07-2026', 'New Finance', 'New-134', 'New-STL306', 'Ravi', 9751277888.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '80.0', 500.0, 20000.0, '2026-04-25', '07-2026', 'Interest-07-2026', 500, 'Paid', 0, 'New-P8', 0, 'No', 1970, 0.0, 'Per_Day', NULL, 31.0),
('Surya Shed-New-STL339-New-135-New-136-New-148-490000-Interest-07-2026', 'New Finance', 'New-135-New-136-New-148', 'New-STL339', 'Surya Shed', 9787878005.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 10630.0, 490000.0, '2026-04-27', '07-2026', 'Interest-07-2026', 0, 'Pending', 10630, 'New-P2', 10630, 'Yes', 10630, 0.0, 'Per_Day', NULL, 31.0),
('Bala kaarthi-New-STL340-New-139-200000-Interest-07-2026', 'New Finance', 'New-139', 'New-STL340', 'Bala kaarthi', 9677843432.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 4340.0, 200000.0, '2026-05-13', '07-2026', 'Interest-07-2026', 0, 'Pending', 4340, 'New-P3', 4340, 'Yes', 4340, 0.0, 'Per_Day', NULL, 31.0),
('Murugesan pons-New-STL341-New-141-New-160-25000-Interest-07-2026', 'New Finance', 'New-141-New-160', 'New-STL341', 'Murugesan pons', 9942713540.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 360.0, 25000.0, '2026-05-28', '07-2026', 'Interest-07-2026', 0, 'Pending', 360, 'New-P5', 420, 'No', 2460, 0.0, 'Per_Day', NULL, 31.0),
('Prakash S M-New-STL343-New-145-80000-Interest-07-2026', 'New Finance', 'New-145', 'New-STL343', 'Prakash S M', 9865388000.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1740.0, 80000.0, '2026-06-05', '07-2026', 'Interest-07-2026', 0, 'Pending', 1740, 'New-P6', 1740, 'Yes', 1740, 0.0, 'Per_Day', NULL, 31.0),
('Suresh CCTV-New-STL344-New-149-50000-Interest-07-2026', 'New Finance', 'New-149', 'New-STL344', 'Suresh CCTV', 8861715281.0, '2026-07-01', '2026-07-31', '2026-07-01', 31.0, '70.0', 1090.0, 50000.0, '2026-06-15', '07-2026', 'Interest-07-2026', 2180, 'Pending', -1090, 'New-P1', -1090, 'Yes', 1090, 0.0, 'Per_Day', NULL, 31.0),
('Kamaraj Prakash-New-STL345-New-156-50000-Interest-07-2026', 'New Finance', 'New-156', 'New-STL345', 'Kamaraj Prakash', 9600996663.0, '2026-07-01', '2026-07-31', '2026-07-07', 25.0, '70.0', 880.0, 50000.0, '2026-07-07', '07-2026', 'Interest-07-2026', 0, 'Pending', 880, 'New-P6', 880, 'Yes', 880, 0.0, 'Per_Day', NULL, 31.0),
('Gopal post-New-STL346-New-158-250000-Interest-07-2026', 'New Finance', 'New-158', 'New-STL346', 'Gopal post', 8838723676.0, '2026-07-01', '2026-07-31', '2026-07-13', 19.0, '70.0', 3330.0, 250000.0, '2026-07-13', '07-2026', 'Interest-07-2026', 0, 'Pending', 3330, 'New-P2', 3330, 'Yes', 3330, 0.0, 'Per_Day', NULL, 31.0),
('Gobinath-New-STL348-New-161-200000-Interest-07-2026', 'New Finance', 'New-161', 'New-STL348', 'Gobinath', 9597539696.0, '2026-07-01', '2026-07-31', '2026-07-23', 9.0, '70.0', 1260.0, 200000.0, '2026-07-23', '07-2026', 'Interest-07-2026', 2520, 'Pending', -1260, 'New-P3', -1260, 'Yes', 1260, 0.0, 'Per_Day', NULL, 31.0);

delete from "Transaction_Ledger" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('82a3cecd', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL179-Sankara Narayanan', 'New-STL179', 'New-1', 'Sankara Narayanan', NULL, NULL, 300000.0, -300000, 'Cash', NULL, 'New Finance', NULL),
('51cab9de', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL257-Ramesh', 'New-STL257', 'New-2', 'Ramesh', NULL, NULL, 30000.0, -330000, 'Cash', NULL, 'New Finance', NULL),
('92ed86cd', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL270-Arul S', 'New-STL270', 'New-3', 'Arul S', NULL, NULL, 150000.0, -480000, 'Cash', NULL, 'New Finance', NULL),
('390518ca', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL295-Rangis', 'New-STL295', 'New-4', 'Rangis', NULL, NULL, 100000.0, -580000, 'Cash', NULL, 'New Finance', NULL),
('40b2d686', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL319-RanjithKumar', 'New-STL319', 'New-5', 'RanjithKumar', NULL, NULL, 250000.0, -830000, 'Cash', NULL, 'New Finance', NULL),
('6ff561bc', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL67-Pradeep', 'New-STL67', 'New-6', 'Pradeep', NULL, NULL, 150000.0, -980000, 'Cash', NULL, 'New Finance', NULL),
('a3480245', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL156-Ramasamy Divya', 'New-STL156', 'New-7', 'Ramasamy Divya', NULL, NULL, 50000.0, -1030000, 'Cash', NULL, 'New Finance', NULL),
('1b900ddc', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL252-Kaviyarasu', 'New-STL252', 'New-8', 'Kaviyarasu', NULL, NULL, 350000.0, -1380000, 'Cash', NULL, 'New Finance', NULL),
('160e7ed3', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL271-Sundaravadivel', 'New-STL271', 'New-9', 'Sundaravadivel', NULL, NULL, 50000.0, -1430000, 'Cash', NULL, 'New Finance', NULL),
('fe875bfb', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL275-Balasubramani Suresh', 'New-STL275', 'New-10', 'Balasubramani Suresh', NULL, NULL, 200000.0, -1630000, 'Cash', NULL, 'New Finance', NULL),
('4a795a2c', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL301-Nagaraj Post', 'New-STL301', 'New-11', 'Nagaraj Post', NULL, NULL, 30000.0, -1660000, 'Cash', NULL, 'New Finance', NULL),
('97a64cfb', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL320-Priya', 'New-STL320', 'New-12', 'Priya', NULL, NULL, 100000.0, -1760000, 'Cash', NULL, 'New Finance', NULL),
('68a0580f', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL330-Arul M', 'New-STL330', 'New-13', 'Arul M', NULL, NULL, 35000.0, -1795000, 'Cash', NULL, 'New Finance', NULL),
('df079462', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL292-John', 'New-STL292', 'New-14', 'John', NULL, NULL, 150000.0, -1945000, 'Cash', NULL, 'New Finance', NULL),
('79cc5abc', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL303-Tharun', 'New-STL303', 'New-15', 'Tharun', NULL, NULL, 50000.0, -1995000, 'Cash', NULL, 'New Finance', NULL),
('f1ce2edc', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL324-Praveen Ram', 'New-STL324', 'New-16', 'Praveen Ram', NULL, NULL, 80000.0, -2075000, 'Cash', NULL, 'New Finance', NULL),
('e60cd283', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL329-Kongu Kochai', 'New-STL329', 'New-17', 'Kongu Kochai', NULL, NULL, 200000.0, -2275000, 'Cash', NULL, 'New Finance', NULL),
('4eed274c', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL332-Sakthivel', 'New-STL332', 'New-18', 'Sakthivel', NULL, NULL, 300000.0, -2575000, 'Cash', NULL, 'New Finance', NULL),
('a68d0067', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL78-Dinesh', 'New-STL78', 'New-19', 'Dinesh', NULL, NULL, 400000.0, -2975000, 'Cash', NULL, 'New Finance', NULL),
('7155f3b8', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL121-Jayapal', 'New-STL121', 'New-20', 'Jayapal', NULL, NULL, 100000.0, -3075000, 'Cash', NULL, 'New Finance', NULL),
('c2da990f', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL126-Udhayakumar', 'New-STL126', 'New-21', 'Udhayakumar', NULL, NULL, 180000.0, -3255000, 'Cash', NULL, 'New Finance', NULL),
('2d0489e5', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL217-Boopathy Crane', 'New-STL217', 'New-22', 'Boopathy Crane', NULL, NULL, 30000.0, -3285000, 'Cash', NULL, 'New Finance', NULL),
('753bc8d9', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL273-Suresh Abudhabi', 'New-STL273', 'New-23', 'Suresh Abudhabi', NULL, NULL, 60000.0, -3345000, 'Cash', NULL, 'New Finance', NULL),
('d8316435', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL277-Jayaraj', 'New-STL277', 'New-24', 'Jayaraj', NULL, NULL, 50000.0, -3395000, 'Cash', NULL, 'New Finance', NULL),
('f48ebdfa', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL278-Yagappan', 'New-STL278', 'New-25', 'Yagappan', NULL, NULL, 20000.0, -3415000, 'Cash', NULL, 'New Finance', NULL),
('bebf8b63', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL304-Sakthivel Jayaraj', 'New-STL304', 'New-26', 'Sakthivel Jayaraj', NULL, NULL, 100000.0, -3515000, 'Cash', NULL, 'New Finance', NULL),
('0b254493', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL308-Mahesh', 'New-STL308', 'New-27', 'Mahesh', NULL, NULL, 50000.0, -3565000, 'Cash', NULL, 'New Finance', NULL),
('afb48435', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL308-Mahesh', 'New-STL308', 'New-27', 'Mahesh', NULL, NULL, 50000.0, -3615000, 'Cash', NULL, 'New Finance', NULL),
('e1c01d60', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL332-Sakthivel', 'New-STL332', 'New-18', 'Sakthivel', NULL, NULL, 300000.0, -3915000, 'Cash', NULL, 'New Finance', NULL),
('c9a8913c', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL323-Kaviyarasu Arul', 'New-STL323', 'New-28', 'Kaviyarasu Arul', NULL, NULL, 800000.0, -4715000, 'Cash', NULL, 'New Finance', NULL),
('06d6cde8', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL46-Danendran', 'New-STL46', 'New-29', 'Danendran', NULL, NULL, 95000.0, -4810000, 'Cash', NULL, 'New Finance', NULL),
('495c8202', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL58-Rajendran', 'New-STL58', 'New-30', 'Rajendran', NULL, NULL, 15000.0, -4825000, 'Cash', NULL, 'New Finance', NULL),
('0362a757', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL160-Karnan', 'New-STL160', 'New-31', 'Karnan', NULL, NULL, 400000.0, -5225000, 'Cash', NULL, 'New Finance', NULL),
('2f8eaaaa', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL262-Vinoth', 'New-STL262', 'New-32', 'Vinoth', NULL, NULL, 50000.0, -5275000, 'Cash', NULL, 'New Finance', NULL),
('c31c9217', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL282-Ashok', 'New-STL282', 'New-33', 'Ashok', NULL, NULL, 15000.0, -5290000, 'Cash', NULL, 'New Finance', NULL),
('03eeb95c', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL297-Mariyammal', 'New-STL297', 'New-34', 'Mariyammal', NULL, NULL, 100000.0, -5390000, 'Cash', NULL, 'New Finance', NULL),
('fa9b9668', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL231-Ramkumar', 'New-STL231', 'New-35', 'Ramkumar', NULL, NULL, 200000.0, -5590000, 'Cash', NULL, 'New Finance', NULL),
('ba25e60f', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL235-Kannan', 'New-STL235', 'New-36', 'Kannan', NULL, NULL, 215000.0, -5805000, 'Cash', NULL, 'New Finance', NULL),
('6bd396ff', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL263-Sakthivel Broker', 'New-STL263', 'New-37', 'Sakthivel Broker', NULL, NULL, 100000.0, -5905000, 'Cash', NULL, 'New Finance', NULL),
('58957e2c', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL280-Sabarish', 'New-STL280', 'New-38', 'Sabarish', NULL, NULL, 200000.0, -6105000, 'Cash', NULL, 'New Finance', NULL),
('3af94ddf', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL312-Moorthy', 'New-STL312', 'New-39', 'Moorthy', NULL, NULL, 50000.0, -6155000, 'Cash', NULL, 'New Finance', NULL),
('82d2690c', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL139-Shanmugam', 'New-STL139', 'New-40', 'Shanmugam', NULL, NULL, 30000.0, -6185000, 'Cash', NULL, 'New Finance', NULL),
('1ce4a21f', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL182-Manivannan', 'New-STL182', 'New-41', 'Manivannan', NULL, NULL, 300000.0, -6485000, 'Cash', NULL, 'New Finance', NULL),
('e949448a', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL234-Ramprakash', 'New-STL234', 'New-42', 'Ramprakash', NULL, NULL, 55000.0, -6540000, 'Cash', NULL, 'New Finance', NULL),
('36f415fb', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL326-Murugesan', 'New-STL326', 'New-43', 'Murugesan', NULL, NULL, 20000.0, -6560000, 'Cash', NULL, 'New Finance', NULL),
('ba15134e', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL248-Kalimuthu', 'New-STL248', 'New-44', 'Kalimuthu', NULL, NULL, 50000.0, -6610000, 'Cash', NULL, 'New Finance', NULL),
('8211c56d', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL306-Ravi', 'New-STL306', 'New-45', 'Ravi', NULL, NULL, 200000.0, -6810000, 'Cash', NULL, 'New Finance', NULL),
('a573212e', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL35-Selvaguru', 'New-STL35', 'New-46', 'Selvaguru', NULL, NULL, 150000.0, -6960000, 'Cash', NULL, 'New Finance', NULL),
('53d048e1', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL116-Vasudevan', 'New-STL116', 'New-47', 'Vasudevan', NULL, NULL, 450000.0, -7410000, 'Cash', NULL, 'New Finance', NULL),
('758cf2a3', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL153-Paramasivam', 'New-STL153', 'New-48', 'Paramasivam', NULL, NULL, 35000.0, -7445000, 'Cash', NULL, 'New Finance', NULL),
('f5caed87', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL185-Karthick', 'New-STL185', 'New-49', 'Karthick', NULL, NULL, 20000.0, -7465000, 'Cash', NULL, 'New Finance', NULL),
('f81cddfa', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL195-Manikandan', 'New-STL195', 'New-50', 'Manikandan', NULL, NULL, 50000.0, -7515000, 'Cash', NULL, 'New Finance', NULL),
('2da9076c', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL123-Pradeep', 'New-STL123', 'New-51', 'Pradeep', NULL, NULL, 100000.0, -7615000, 'Cash', NULL, 'New Finance', NULL),
('b483bdfc', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL283-Logambal', 'New-STL283', 'New-52', 'Logambal', NULL, NULL, 100000.0, -7715000, 'Cash', NULL, 'New Finance', NULL),
('878f92d9', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL318-Divakar', 'New-STL318', 'New-53', 'Divakar', NULL, NULL, 25000.0, -7740000, 'Cash', NULL, 'New Finance', NULL),
('80b1b7fd', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL150-Muniyappan', 'New-STL150', 'New-54', 'Muniyappan', NULL, NULL, 100000.0, -7840000, 'Cash', NULL, 'New Finance', NULL),
('fbf872cf', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL151-Shanmugaraj', 'New-STL151', 'New-55', 'Shanmugaraj', NULL, NULL, 300000.0, -8140000, 'Cash', NULL, 'New Finance', NULL),
('a9b11781', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL227-Nandhakumar', 'New-STL227', 'New-56', 'Nandhakumar', NULL, NULL, 100000.0, -8240000, 'Cash', NULL, 'New Finance', NULL),
('40e6ba49', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL260-Vignesh', 'New-STL260', 'New-57', 'Vignesh', NULL, NULL, 100000.0, -8340000, 'Cash', NULL, 'New Finance', NULL),
('0031c4ef', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL274-Anand', 'New-STL274', 'New-58', 'Anand', NULL, NULL, 20000.0, -8360000, 'Cash', NULL, 'New Finance', NULL),
('679db95d', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL287-Subramani', 'New-STL287', 'New-59', 'Subramani', NULL, NULL, 150000.0, -8510000, 'Cash', NULL, 'New Finance', NULL),
('8fad8fa3', '2026-03-26', 'Loan_To_Customer', 'Loan_To_Customer-New-STL331-Nagurammal', 'New-STL331', 'New-60', 'Nagurammal', NULL, NULL, 150000.0, -8660000, 'Cash', NULL, 'New Finance', NULL),
('Ramesh-New-STL257-New-2-30000-Interest-02-2026-424c1add', '2026-03-26', 'Customer_Interest', 'Ramesh-New-STL257-New-2-30000-Interest-02-2026', 'New-STL257', 'New-2', 'Ramesh', 'Interest-02-2026', 770.0, 0.0, -8659230, 'Cash', NULL, 'New Finance', '770.0'),
('a8812b59', '2026-02-28', 'Customer_Loan_Prin_Repayment', 'New-STL78-New-19-Dinesh-40000', 'New-STL78', 'New-19', 'Dinesh', 'New-19', 10000.0, NULL, -8649230, 'Cash', NULL, 'New Finance', '790'),
('7a56979e', '2026-03-03', 'Customer_Loan_Prin_Repayment', 'New-STL270-New-3-Arul S-150000', 'New-STL270', 'New-3', 'Arul S', 'New-3', 50000.0, NULL, -8599230, 'Cash', NULL, 'New Finance', '1230'),
('969a808a', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL61-Mani Basketball', 'New-STL61', 'New-61', 'Mani Basketball', NULL, NULL, 150000.0, -8749230, 'Cash', NULL, 'New Finance', NULL),
('581fed42', '2026-03-03', 'Customer_Loan_Prin_Repayment', 'New-STL320-New-12-Priya-100000', 'New-STL320', 'New-12', 'Priya', 'New-12', 100000.0, NULL, -8649230, 'Cash', NULL, 'New Finance', '960'),
('de2853e4', '2026-03-04', 'Customer_Loan_Prin_Repayment', 'New-STL303-New-15-Tharun-50000', 'New-STL303', 'New-15', 'Tharun', 'New-15', 50000.0, NULL, -8599230, 'Cash', NULL, 'New Finance', '1120'),
('69e20f3e', '2026-03-06', 'Customer_Loan_Prin_Repayment', 'New-STL126-New-21-Udhayakumar-180000', 'New-STL126', 'New-21', 'Udhayakumar', 'New-21', 50000.0, NULL, -8549230, 'Cash', NULL, 'New Finance', '3530'),
('a3f6f422', '2026-03-06', 'Customer_Loan_Prin_Repayment', 'New-STL332-New-18-Sakthivel-300000', 'New-STL332', 'New-18', 'Sakthivel', 'New-18', 300000.0, NULL, -8249230, 'Cash', NULL, 'New Finance', '420'),
('0c79a6ec', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL330-Arul M', 'New-STL330', 'New-62', 'Arul M', NULL, NULL, 15000.0, -8264230, 'Cash', NULL, 'New Finance', NULL),
('a7a65f84', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL280-Sabarish', 'New-STL280', 'New-63', 'Sabarish', NULL, NULL, 60000.0, -8324230, 'Cash', NULL, 'New Finance', NULL),
('57f3b96f', '2026-03-10', 'Customer_Loan_Prin_Repayment', 'New-STL252-New-8-Kaviyarasu-350000', 'New-STL252', 'New-8', 'Kaviyarasu', 'New-8', 200000.0, NULL, -8124230, NULL, NULL, 'New Finance', '6860'),
('7e82923c', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL275-Balasubramani Suresh', 'New-STL275', 'New-64', 'Balasubramani Suresh', NULL, NULL, 50000.0, -8174230, 'Cash', NULL, 'New Finance', NULL),
('3936f16d', '2026-03-12', 'Customer_Loan_Prin_Repayment', 'New-STL252-New-8-Kaviyarasu-350000', 'New-STL252', 'New-8', 'Kaviyarasu', 'New-8', 50000.0, NULL, -8124230, 'Cash', NULL, 'New Finance', '6860'),
('97bd2dbc', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL320-Priya', 'New-STL320', 'New-65', 'Priya', NULL, NULL, 100000.0, -8224230, 'Cash', NULL, 'New Finance', NULL),
('2dee3f06', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL303-Tharun', 'New-STL303', 'New-66', 'Tharun', NULL, NULL, 70000.0, -8294230, 'Cash', NULL, 'New Finance', NULL),
('c580392a', '2026-03-15', 'Customer_Loan_Prin_Repayment', 'New-STL283-New-52-Logambal-100000', 'New-STL283', 'New-52', 'Logambal', 'New-52', 50000.0, NULL, -8244230, 'Cash', NULL, 'New Finance', '1790'),
('85d63155', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL313-Viji Vasanth', 'New-STL313', 'New-67', 'Viji Vasanth', NULL, NULL, 250000.0, -8494230, 'Cash', NULL, 'New Finance', NULL),
('fa65af06', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL330-Arul M', 'New-STL330', 'New-68', 'Arul M', NULL, NULL, 50000.0, -8544230, 'Cash', NULL, 'New Finance', NULL),
('a40f08f9', '2026-03-18', 'Customer_Loan_Prin_Repayment', 'New-STL319-New-5-RanjithKumar-50000', 'New-STL319', 'New-5', 'RanjithKumar', 'New-5', 50000.0, NULL, -8494230, NULL, NULL, 'New Finance', '4310,4200'),
('1ca48f74', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL231-Ramkumar', 'New-STL231', 'New-69', 'Ramkumar', NULL, NULL, 100000.0, -8594230, 'Cash', NULL, 'New Finance', NULL),
('26bf82f9', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL277-Jayaraj', 'New-STL277', 'New-70', 'Jayaraj', NULL, NULL, 200000.0, -8794230, 'Cash', NULL, 'New Finance', NULL),
('d9564409', '2026-03-20', 'Customer_Loan_Prin_Repayment', 'New-STL252-New-8-Kaviyarasu-100000', 'New-STL252', 'New-8', 'Kaviyarasu', 'New-8', 100000.0, NULL, -8694230, 'Cash', NULL, 'New Finance', '6860,1400,420'),
('7475b404', '2026-03-22', 'Customer_Loan_Prin_Repayment', 'New-STL277-New-70-Jayaraj-200000', 'New-STL277', 'New-70', 'Jayaraj', 'New-70', 200000.0, NULL, -8494230, NULL, NULL, 'New Finance', '980'),
('943f6c30', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL231-Ramkumar', 'New-STL231', 'New-71', 'Ramkumar', NULL, NULL, 130000.0, -8624230, 'Cash', NULL, 'New Finance', NULL),
('1c0b89a3', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL319-RanjithKumar', 'New-STL319', 'New-72', 'RanjithKumar', NULL, NULL, 200000.0, -8824230, 'Cash', NULL, 'New Finance', NULL),
('42a197fd', '2026-03-25', 'Customer_Loan_Prin_Repayment', 'New-STL323-New-28-Kaviyarasu Arul-800000', 'New-STL323', 'New-28', 'Kaviyarasu Arul', 'New-28', 50000.0, NULL, -8774230, 'Cash', NULL, 'New Finance', '13860'),
('caa46eb3', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL334-Vignesh Arun Kumba', 'New-STL334', 'New-73', 'Vignesh Arun Kumba', NULL, NULL, 100000.0, -8874230, 'Cash', NULL, 'New Finance', NULL),
('d7347b3c', '2026-03-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL221-Tharun Tex', 'New-STL221', 'New-74', 'Tharun Tex', NULL, NULL, 100000.0, -8974230, 'Cash', NULL, 'New Finance', NULL),
('ee4b0305', '2026-03-27', 'Customer_Loan_Prin_Repayment', 'New-STL306-New-45-Ravi-200000', 'New-STL306', 'New-45', 'Ravi', 'New-45', 100000.0, NULL, -8874230, NULL, NULL, 'New Finance', '3920'),
('75d40e78', '2026-03-23', 'Customer_Loan_Prin_Repayment', 'New-STL277-New-24-Jayaraj-50000', 'New-STL277', 'New-24', 'Jayaraj', 'New-24', 50000.0, NULL, -8824230, 'Cash', NULL, 'New Finance', '980,420,1090'),
('3316b54f', '2026-03-31', 'Loan_To_Customer', 'Loan_To_Customer-New-STL335-Durai Master Kumbaa', 'New-STL335', 'New-75', 'Durai Master Kumbaa', NULL, NULL, 100000.0, -8924230, 'Cash', 'Arun Kumba party but in Ravi recommend, all details of bond and cheque with Arun Kumba', 'New Finance', NULL),
('e56e5dc1', '2026-03-30', 'Customer_Loan_Prin_Repayment', 'New-STL306-New-45-Ravi-100000', 'New-STL306', 'New-45', 'Ravi', 'New-45', 25000.0, NULL, -8899230, 'Cash', 'Arul.M loan of 2 lacs in 1.80 was transferred to Ravi and now Arul repaid 1 lakh on 28.03 send 25k on 31.03', 'New Finance', '3920,1890'),
('b2103e05', '2026-03-31', 'Loan_To_Customer', 'Loan_To_Customer-New-STL257-Ramesh', 'New-STL257', 'New-2', 'Ramesh', NULL, NULL, 30000.0, -8929230, 'Cash', NULL, 'New Finance', NULL),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-02-2026-f30e6689', '2026-03-21', 'Customer_Interest', 'Sankara Narayanan-New-STL179-New-1-300000-Interest-02-2026', 'New-STL179', 'New-1', 'Sankara Narayanan', 'Interest-02-2026', 5880.0, 0.0, -8923350, 'UPI', NULL, 'New Finance', '5880.0'),
('Rangis-New-STL295-New-4-100000-Interest-02-2026-853715df', '2026-03-01', 'Customer_Interest', 'Rangis-New-STL295-New-4-100000-Interest-02-2026', 'New-STL295', 'New-4', 'Rangis', 'Interest-02-2026', 1960.0, 0.0, -8921390, 'UPI', NULL, 'New Finance', '1960.0'),
('79705a59', '2026-03-14', 'Customer_Loan_Prin_Repayment', 'New-STL319-New-5-RanjithKumar-200000', 'New-STL319', 'New-5', 'RanjithKumar', 'New-5', 200000.0, NULL, -8721390, 'Cash', NULL, 'New Finance', '4310,630'),
('RanjithKumar-New-STL319-New-5-250000-Interest-02-2026-01d60408', '2026-03-01', 'Customer_Interest', 'RanjithKumar-New-STL319-New-5-250000-Interest-02-2026', 'New-STL319', 'New-5', 'RanjithKumar', 'Interest-02-2026', 4310.0, 0.0, -8717080, 'Cash', NULL, 'New Finance', '4310.0'),
('RanjithKumar-New-STL319-New-5-50000-Interest-03-2026-01d60408', '2026-03-01', 'Customer_Interest', 'RanjithKumar-New-STL319-New-5-50000-Interest-03-2026', 'New-STL319', 'New-5', 'RanjithKumar', 'Interest-03-2026', 630.0, 0.0, -8716450, 'Cash', NULL, 'New Finance', '630.0');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('RanjithKumar-New-STL319-New-5-200000-Interest-03-2026-01d60408', '2026-03-01', 'Customer_Interest', 'RanjithKumar-New-STL319-New-5-200000-Interest-03-2026', 'New-STL319', 'New-5', 'RanjithKumar', 'Interest-03-2026', 1960.0, 0.0, -8714490, 'Cash', NULL, 'New Finance', '1960.0'),
('Kaviyarasu-New-STL252-New-8-350000-Interest-02-2026-e3eecdcd', '2026-03-26', 'Customer_Interest', 'Kaviyarasu-New-STL252-New-8-350000-Interest-02-2026', 'New-STL252', 'New-8', 'Kaviyarasu', 'Interest-02-2026', 6860.0, 0.0, -8707630, 'Cash', NULL, 'New Finance', '6860.0'),
('Kaviyarasu-New-STL252-New-8-200000-Interest-03-2026-e3eecdcd', '2026-03-26', 'Customer_Interest', 'Kaviyarasu-New-STL252-New-8-200000-Interest-03-2026', 'New-STL252', 'New-8', 'Kaviyarasu', 'Interest-03-2026', 1400.0, 0.0, -8706230, 'Cash', NULL, 'New Finance', '1400.0'),
('Kaviyarasu-New-STL252-New-8-50000-Interest-03-2026-e3eecdcd', '2026-03-26', 'Customer_Interest', 'Kaviyarasu-New-STL252-New-8-50000-Interest-03-2026', 'New-STL252', 'New-8', 'Kaviyarasu', 'Interest-03-2026', 420.0, 0.0, -8705810, 'Cash', NULL, 'New Finance', '420.0'),
('Kaviyarasu-New-STL252-New-8-100000-Interest-03-2026-e3eecdcd', '2026-03-26', 'Customer_Interest', 'Kaviyarasu-New-STL252-New-8-100000-Interest-03-2026', 'New-STL252', 'New-8', 'Kaviyarasu', 'Interest-03-2026', 1400.0, 0.0, -8704410, 'Cash', NULL, 'New Finance', '1400.0'),
('Sundaravadivel-New-STL271-New-9-50000-Interest-02-2026-0723ae34', '2026-03-10', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-9-50000-Interest-02-2026', 'New-STL271', 'New-9', 'Sundaravadivel', 'Interest-02-2026', 980.0, 0.0, -8703430, 'Cash', NULL, 'New Finance', '980.0'),
('Priya-New-STL320-New-12-100000-Interest-02-2026-a1876f12', '2026-03-04', 'Customer_Interest', 'Priya-New-STL320-New-12-100000-Interest-02-2026', 'New-STL320', 'New-12', 'Priya', 'Interest-02-2026', 960.0, 0.0, -8702470, NULL, NULL, 'New Finance', '960.0'),
('Priya-New-STL320-New-12-100000-Interest-03-2026-a1876f12', '2026-03-04', 'Customer_Interest', 'Priya-New-STL320-New-12-100000-Interest-03-2026', 'New-STL320', 'New-12', 'Priya', 'Interest-03-2026', 210.0, 0.0, -8702260, NULL, NULL, 'New Finance', '210.0'),
('John-New-STL292-New-14-150000-Interest-02-2026-8ebeb246', '2026-03-14', 'Customer_Interest', 'John-New-STL292-New-14-150000-Interest-02-2026', 'New-STL292', 'New-14', 'John', 'Interest-02-2026', 2940.0, 0.0, -8699320, 'UPI', NULL, 'New Finance', '2940.0'),
('Tharun-New-STL303-New-15-50000-Interest-02-2026-5fb44501', '2026-03-18', 'Customer_Interest', 'Tharun-New-STL303-New-15-50000-Interest-02-2026', 'New-STL303', 'New-15', 'Tharun', 'Interest-02-2026', 1120.0, 0.0, -8698200, 'UPI', NULL, 'New Finance', '1120.0'),
('Tharun-New-STL303-New-15-50000-Interest-03-2026-5fb44501', '2026-03-18', 'Customer_Interest', 'Tharun-New-STL303-New-15-50000-Interest-03-2026', 'New-STL303', 'New-15', 'Tharun', 'Interest-03-2026', 140.0, 0.0, -8698060, 'UPI', NULL, 'New Finance', '140.0'),
('Praveen Ram-New-STL324-New-16-80000-Interest-02-2026-37d20b8f', '2026-03-06', 'Customer_Interest', 'Praveen Ram-New-STL324-New-16-80000-Interest-02-2026', 'New-STL324', 'New-16', 'Praveen Ram', 'Interest-02-2026', 1570.0, 0.0, -8696490, 'Cash', NULL, 'New Finance', '1570.0'),
('Kongu Kochai-New-STL329-New-17-200000-Interest-02-2026-b5a5d9c9', '2026-03-01', 'Customer_Interest', 'Kongu Kochai-New-STL329-New-17-200000-Interest-02-2026', 'New-STL329', 'New-17', 'Kongu Kochai', 'Interest-02-2026', 3920.0, 0.0, -8692570, 'Cash', NULL, 'New Finance', '3920.0'),
('Sakthivel-New-STL332-New-18-300000-Interest-02-2026-a259c0c4', '2026-03-07', 'Customer_Interest', 'Sakthivel-New-STL332-New-18-300000-Interest-02-2026', 'New-STL332', 'New-18', 'Sakthivel', 'Interest-02-2026', 420.0, 0.0, -8692150, 'Cash', NULL, 'New Finance', '420.0'),
('Sakthivel-New-STL332-New-18-300000-Interest-03-2026-a259c0c4', '2026-03-07', 'Customer_Interest', 'Sakthivel-New-STL332-New-18-300000-Interest-03-2026', 'New-STL332', 'New-18', 'Sakthivel', 'Interest-03-2026', 1260.0, 0.0, -8690890, 'Cash', NULL, 'New Finance', '1260.0'),
('Dinesh-New-STL78-New-19-400000-Interest-02-2026-f112d7a3', '2026-03-01', 'Customer_Interest', 'Dinesh-New-STL78-New-19-400000-Interest-02-2026', 'New-STL78', 'New-19', 'Dinesh', 'Interest-02-2026', 790.0, 0.0, -8690100, 'UPI', NULL, 'New Finance', '790.0'),
('Udhayakumar-New-STL126-New-21-180000-Interest-02-2026-911bc403', '2026-03-18', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-180000-Interest-02-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-02-2026', 3530.0, 0.0, -8686570, 'Cash', NULL, 'New Finance', '3530.0'),
('Boopathy Crane-New-STL217-New-22-30000-Interest-02-2026-4ccdb3d2', '2026-03-17', 'Customer_Interest', 'Boopathy Crane-New-STL217-New-22-30000-Interest-02-2026', 'New-STL217', 'New-22', 'Boopathy Crane', 'Interest-02-2026', 670.0, 0.0, -8685900, 'Cash', NULL, 'New Finance', '670.0'),
('Yagappan-New-STL278-New-25-20000-Interest-02-2026-0baade96', '2026-03-13', 'Customer_Interest', 'Yagappan-New-STL278-New-25-20000-Interest-02-2026', 'New-STL278', 'New-25', 'Yagappan', 'Interest-02-2026', 450.0, 0.0, -8685450, 'UPI', NULL, 'New Finance', '450.0'),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-02-2026-37531f9a', '2026-03-02', 'Customer_Interest', 'Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-02-2026', 'New-STL304', 'New-26', 'Sakthivel Jayaraj', 'Interest-02-2026', 1750.0, 0.0, -8683700, 'UPI', NULL, 'New Finance', '1750.0'),
('Mahesh-New-STL308-New-27-50000-Interest-02-2026-f74c4a49', '2026-03-16', 'Customer_Interest', 'Mahesh-New-STL308-New-27-50000-Interest-02-2026', 'New-STL308', 'New-27', 'Mahesh', 'Interest-02-2026', 980.0, 0.0, -8682720, 'UPI', NULL, 'New Finance', '980.0'),
('Kaviyarasu Arul-New-STL323-New-28-800000-Interest-02-2026-21b24057', '2026-03-11', 'Customer_Interest', 'Kaviyarasu Arul-New-STL323-New-28-800000-Interest-02-2026', 'New-STL323', 'New-28', 'Kaviyarasu Arul', 'Interest-02-2026', 13860.0, 0.0, -8668860, 'Cash', NULL, 'New Finance', '13860.0'),
('Rajendran-New-STL58-New-30-15000-Interest-02-2026-12932d23', '2026-03-20', 'Customer_Interest', 'Rajendran-New-STL58-New-30-15000-Interest-02-2026', 'New-STL58', 'New-30', 'Rajendran', 'Interest-02-2026', 340.0, 0.0, -8668520, 'Cash', NULL, 'New Finance', '340.0'),
('Karnan-New-STL160-New-31-400000-Interest-02-2026-c710a5e1', '2026-03-20', 'Customer_Interest', 'Karnan-New-STL160-New-31-400000-Interest-02-2026', 'New-STL160', 'New-31', 'Karnan', 'Interest-02-2026', 7840.0, 0.0, -8660680, 'Cash', NULL, 'New Finance', '7840.0'),
('Vinoth-New-STL262-New-32-50000-Interest-02-2026-574a455a', '2026-03-20', 'Customer_Interest', 'Vinoth-New-STL262-New-32-50000-Interest-02-2026', 'New-STL262', 'New-32', 'Vinoth', 'Interest-02-2026', 980.0, 0.0, -8659700, 'Cash', NULL, 'New Finance', '980.0'),
('Ashok-New-STL282-New-33-15000-Interest-02-2026-000cd45e', '2026-03-20', 'Customer_Interest', 'Ashok-New-STL282-New-33-15000-Interest-02-2026', 'New-STL282', 'New-33', 'Ashok', 'Interest-02-2026', 340.0, 0.0, -8659360, 'Cash', NULL, 'New Finance', '340.0'),
('Mariyammal-New-STL297-New-34-100000-Interest-02-2026-71a6a0e7', '2026-03-20', 'Customer_Interest', 'Mariyammal-New-STL297-New-34-100000-Interest-02-2026', 'New-STL297', 'New-34', 'Mariyammal', 'Interest-02-2026', 1960.0, 0.0, -8657400, 'UPI', NULL, 'New Finance', '1960.0'),
('Ramkumar-New-STL231-New-35-200000-Interest-02-2026-cff96df8', '2026-03-20', 'Customer_Interest', 'Ramkumar-New-STL231-New-35-200000-Interest-02-2026', 'New-STL231', 'New-35', 'Ramkumar', 'Interest-02-2026', 3920.0, 0.0, -8653480, 'Cash', NULL, 'New Finance', '3920.0'),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-02-2026-85435706', '2026-03-20', 'Customer_Interest', 'Sakthivel Broker-New-STL263-New-37-100000-Interest-02-2026', 'New-STL263', 'New-37', 'Sakthivel Broker', 'Interest-02-2026', 1960.0, 0.0, -8651520, 'Cash', NULL, 'New Finance', '1960.0'),
('Sabarish-New-STL280-New-38-200000-Interest-02-2026-130afca2', '2026-03-04', 'Customer_Interest', 'Sabarish-New-STL280-New-38-200000-Interest-02-2026', 'New-STL280', 'New-38', 'Sabarish', 'Interest-02-2026', 3640.0, 0.0, -8647880, 'Cash', NULL, 'New Finance', '3640.0'),
('Moorthy-New-STL312-New-39-50000-Interest-02-2026-73caf992', '2026-03-20', 'Customer_Interest', 'Moorthy-New-STL312-New-39-50000-Interest-02-2026', 'New-STL312', 'New-39', 'Moorthy', 'Interest-02-2026', 980.0, 0.0, -8646900, 'Cash', NULL, 'New Finance', '980.0'),
('Shanmugam-New-STL139-New-40-30000-Interest-02-2026-5da557c1', '2026-03-07', 'Customer_Interest', 'Shanmugam-New-STL139-New-40-30000-Interest-02-2026', 'New-STL139', 'New-40', 'Shanmugam', 'Interest-02-2026', 670.0, 0.0, -8646230, 'UPI', NULL, 'New Finance', '670.0'),
('Ramprakash-New-STL234-New-42-55000-Interest-02-2026-45cfa025', '2026-03-14', 'Customer_Interest', 'Ramprakash-New-STL234-New-42-55000-Interest-02-2026', 'New-STL234', 'New-42', 'Ramprakash', 'Interest-02-2026', 1080.0, 0.0, -8645150, 'Cash', NULL, 'New Finance', '1080.0'),
('Murugesan-New-STL326-New-43-20000-Interest-02-2026-7d1a3094', '2026-03-13', 'Customer_Interest', 'Murugesan-New-STL326-New-43-20000-Interest-02-2026', 'New-STL326', 'New-43', 'Murugesan', 'Interest-02-2026', 450.0, 0.0, -8644700, 'UPI', NULL, 'New Finance', '450.0'),
('Kalimuthu-New-STL248-New-44-50000-Interest-02-2026-709fef45', '2026-03-26', 'Customer_Interest', 'Kalimuthu-New-STL248-New-44-50000-Interest-02-2026', 'New-STL248', 'New-44', 'Kalimuthu', 'Interest-02-2026', 980.0, 0.0, -8643720, 'Cash', NULL, 'New Finance', '980.0'),
('Ravi-New-STL306-New-45-200000-Interest-02-2026-8ff577a8', '2026-03-20', 'Customer_Interest', 'Ravi-New-STL306-New-45-200000-Interest-02-2026', 'New-STL306', 'New-45', 'Ravi', 'Interest-02-2026', 3920.0, 0.0, -8639800, 'Cash', NULL, 'New Finance', '3920.0'),
('Logambal-New-STL283-New-52-100000-Interest-02-2026-993f093a', '2026-03-07', 'Customer_Interest', 'Logambal-New-STL283-New-52-100000-Interest-02-2026', 'New-STL283', 'New-52', 'Logambal', 'Interest-02-2026', 1790.0, 0.0, -8638010, 'Cash', NULL, 'New Finance', '1790.0'),
('Muniyappan-New-STL150-New-54-100000-Interest-02-2026-dbb9693c', '2026-03-14', 'Customer_Interest', 'Muniyappan-New-STL150-New-54-100000-Interest-02-2026', 'New-STL150', 'New-54', 'Muniyappan', 'Interest-02-2026', 1960.0, 0.0, -8636050, 'UPI', NULL, 'New Finance', '1960.0'),
('Shanmugaraj-New-STL151-New-55-300000-Interest-02-2026-d89637fd', '2026-03-03', 'Customer_Interest', 'Shanmugaraj-New-STL151-New-55-300000-Interest-02-2026', 'New-STL151', 'New-55', 'Shanmugaraj', 'Interest-02-2026', 5880.0, 0.0, -8630170, 'UPI', NULL, 'New Finance', '5880.0'),
('Nandhakumar-New-STL227-New-56-100000-Interest-02-2026-d2297275', '2026-03-16', 'Customer_Interest', 'Nandhakumar-New-STL227-New-56-100000-Interest-02-2026', 'New-STL227', 'New-56', 'Nandhakumar', 'Interest-02-2026', 1960.0, 0.0, -8628210, 'UPI', NULL, 'New Finance', '1960.0'),
('Vignesh-New-STL260-New-57-100000-Interest-02-2026-b71379eb', '2026-03-06', 'Customer_Interest', 'Vignesh-New-STL260-New-57-100000-Interest-02-2026', 'New-STL260', 'New-57', 'Vignesh', 'Interest-02-2026', 1960.0, 0.0, -8626250, 'UPI', NULL, 'New Finance', '1960.0'),
('Anand-New-STL274-New-58-20000-Interest-02-2026-f73653e3', '2026-03-20', 'Customer_Interest', 'Anand-New-STL274-New-58-20000-Interest-02-2026', 'New-STL274', 'New-58', 'Anand', 'Interest-02-2026', 450.0, 0.0, -8625800, 'Cash', NULL, 'New Finance', '450.0'),
('Subramani-New-STL287-New-59-150000-Interest-02-2026-de31acc4', '2026-03-14', 'Customer_Interest', 'Subramani-New-STL287-New-59-150000-Interest-02-2026', 'New-STL287', 'New-59', 'Subramani', 'Interest-02-2026', 2940.0, 0.0, -8622860, 'UPI', NULL, 'New Finance', '2940.0'),
('Nagurammal-New-STL331-New-60-150000-Interest-02-2026-2d7f74ff', '2026-03-10', 'Customer_Interest', 'Nagurammal-New-STL331-New-60-150000-Interest-02-2026', 'New-STL331', 'New-60', 'Nagurammal', 'Interest-02-2026', 2520.0, 0.0, -8620340, 'Cash', NULL, 'New Finance', '2520.0'),
('New _A1_M1_Chitra_New _A1_Auction_1-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_1', 'New _A1_M1_Chitra_New _A1_Auction_1', 'New _A1_M1_Chitra_New _A1_Auction_1', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_1', 5000.0, 0.0, -8615340, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M1_Chitra_New _A1_Auction_2-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_2', 'New _A1_M1_Chitra_New _A1_Auction_2', 'New _A1_M1_Chitra_New _A1_Auction_2', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_2', 3990.0, 0.0, -8611350, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M1_Chitra_New _A1_Auction_3-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_3', 'New _A1_M1_Chitra_New _A1_Auction_3', 'New _A1_M1_Chitra_New _A1_Auction_3', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_3', 4040.0, 0.0, -8607310, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M1_Chitra_New _A1_Auction_4-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_4', 'New _A1_M1_Chitra_New _A1_Auction_4', 'New _A1_M1_Chitra_New _A1_Auction_4', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_4', 4080.0, 0.0, -8603230, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M1_Chitra_New _A1_Auction_5-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_5', 'New _A1_M1_Chitra_New _A1_Auction_5', 'New _A1_M1_Chitra_New _A1_Auction_5', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_5', 4130.0, 0.0, -8599100, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M1_Chitra_New _A1_Auction_6-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_6', 'New _A1_M1_Chitra_New _A1_Auction_6', 'New _A1_M1_Chitra_New _A1_Auction_6', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_6', 4180.0, 0.0, -8594920, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M1_Chitra_New _A1_Auction_7-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_7', 'New _A1_M1_Chitra_New _A1_Auction_7', 'New _A1_M1_Chitra_New _A1_Auction_7', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_7', 4230.0, 0.0, -8590690, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M1_Chitra_New _A1_Auction_8-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_8', 'New _A1_M1_Chitra_New _A1_Auction_8', 'New _A1_M1_Chitra_New _A1_Auction_8', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_8', 4280.0, 0.0, -8586410, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M1_Chitra_New _A1_Auction_9-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_9', 'New _A1_M1_Chitra_New _A1_Auction_9', 'New _A1_M1_Chitra_New _A1_Auction_9', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_9', 4330.0, 0.0, -8582080, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M1_Chitra_New _A1_Auction_10-a6b3b6d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M1_Chitra_New _A1_Auction_10', 'New _A1_M1_Chitra_New _A1_Auction_10', 'New _A1_M1_Chitra_New _A1_Auction_10', 'New _A1_M1_Chitra', 'New _A1_M1_Chitra_New _A1_Auction_10', 4380.0, 0.0, -8577700, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_1-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_1', 'New _A1_M3_SanjuSri_New _A1_Auction_1', 'New _A1_M3_SanjuSri_New _A1_Auction_1', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_1', 5000.0, 0.0, -8572700, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_3-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_3', 'New _A1_M3_SanjuSri_New _A1_Auction_3', 'New _A1_M3_SanjuSri_New _A1_Auction_3', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_3', 4040.0, 0.0, -8568660, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_5-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_5', 'New _A1_M3_SanjuSri_New _A1_Auction_5', 'New _A1_M3_SanjuSri_New _A1_Auction_5', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_5', 4130.0, 0.0, -8564530, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_7-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_7', 'New _A1_M3_SanjuSri_New _A1_Auction_7', 'New _A1_M3_SanjuSri_New _A1_Auction_7', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_7', 4230.0, 0.0, -8560300, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_9-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_9', 'New _A1_M3_SanjuSri_New _A1_Auction_9', 'New _A1_M3_SanjuSri_New _A1_Auction_9', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_9', 4330.0, 0.0, -8555970, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_10-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_10', 'New _A1_M3_SanjuSri_New _A1_Auction_10', 'New _A1_M3_SanjuSri_New _A1_Auction_10', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_10', 4380.0, 0.0, -8551590, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_2-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_2', 'New _A1_M3_SanjuSri_New _A1_Auction_2', 'New _A1_M3_SanjuSri_New _A1_Auction_2', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_2', 3990.0, 0.0, -8547600, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_4-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_4', 'New _A1_M3_SanjuSri_New _A1_Auction_4', 'New _A1_M3_SanjuSri_New _A1_Auction_4', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_4', 4080.0, 0.0, -8543520, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_6-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_6', 'New _A1_M3_SanjuSri_New _A1_Auction_6', 'New _A1_M3_SanjuSri_New _A1_Auction_6', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_6', 4180.0, 0.0, -8539340, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M3_SanjuSri_New _A1_Auction_8-9b4a1daf', '2026-03-15', 'Chit_Receipt', 'New _A1_M3_SanjuSri_New _A1_Auction_8', 'New _A1_M3_SanjuSri_New _A1_Auction_8', 'New _A1_M3_SanjuSri_New _A1_Auction_8', 'New _A1_M3_SanjuSri', 'New _A1_M3_SanjuSri_New _A1_Auction_8', 4280.0, 0.0, -8535060, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M2_Karthika_New _A1_Auction_1-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_1', 'New _A1_M2_Karthika_New _A1_Auction_1', 'New _A1_M2_Karthika_New _A1_Auction_1', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_1', 5000.0, 0.0, -8530060, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M2_Karthika_New _A1_Auction_2-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_2', 'New _A1_M2_Karthika_New _A1_Auction_2', 'New _A1_M2_Karthika_New _A1_Auction_2', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_2', 3990.0, 0.0, -8526070, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M2_Karthika_New _A1_Auction_3-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_3', 'New _A1_M2_Karthika_New _A1_Auction_3', 'New _A1_M2_Karthika_New _A1_Auction_3', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_3', 4040.0, 0.0, -8522030, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M2_Karthika_New _A1_Auction_4-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_4', 'New _A1_M2_Karthika_New _A1_Auction_4', 'New _A1_M2_Karthika_New _A1_Auction_4', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_4', 4080.0, 0.0, -8517950, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M2_Karthika_New _A1_Auction_5-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_5', 'New _A1_M2_Karthika_New _A1_Auction_5', 'New _A1_M2_Karthika_New _A1_Auction_5', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_5', 4130.0, 0.0, -8513820, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M2_Karthika_New _A1_Auction_6-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_6', 'New _A1_M2_Karthika_New _A1_Auction_6', 'New _A1_M2_Karthika_New _A1_Auction_6', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_6', 4180.0, 0.0, -8509640, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M2_Karthika_New _A1_Auction_7-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_7', 'New _A1_M2_Karthika_New _A1_Auction_7', 'New _A1_M2_Karthika_New _A1_Auction_7', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_7', 4230.0, 0.0, -8505410, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M2_Karthika_New _A1_Auction_8-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_8', 'New _A1_M2_Karthika_New _A1_Auction_8', 'New _A1_M2_Karthika_New _A1_Auction_8', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_8', 4280.0, 0.0, -8501130, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M2_Karthika_New _A1_Auction_9-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_9', 'New _A1_M2_Karthika_New _A1_Auction_9', 'New _A1_M2_Karthika_New _A1_Auction_9', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_9', 4330.0, 0.0, -8496800, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M2_Karthika_New _A1_Auction_10-388d38b9', '2026-03-15', 'Chit_Receipt', 'New _A1_M2_Karthika_New _A1_Auction_10', 'New _A1_M2_Karthika_New _A1_Auction_10', 'New _A1_M2_Karthika_New _A1_Auction_10', 'New _A1_M2_Karthika', 'New _A1_M2_Karthika_New _A1_Auction_10', 4380.0, 0.0, -8492420, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M4_Saranya_New _A1_Auction_1-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_1', 'New _A1_M4_Saranya_New _A1_Auction_1', 'New _A1_M4_Saranya_New _A1_Auction_1', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_1', 5000.0, 0.0, -8487420, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M4_Saranya_New _A1_Auction_2-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_2', 'New _A1_M4_Saranya_New _A1_Auction_2', 'New _A1_M4_Saranya_New _A1_Auction_2', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_2', 3990.0, 0.0, -8483430, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M4_Saranya_New _A1_Auction_3-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_3', 'New _A1_M4_Saranya_New _A1_Auction_3', 'New _A1_M4_Saranya_New _A1_Auction_3', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_3', 4040.0, 0.0, -8479390, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M4_Saranya_New _A1_Auction_4-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_4', 'New _A1_M4_Saranya_New _A1_Auction_4', 'New _A1_M4_Saranya_New _A1_Auction_4', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_4', 4080.0, 0.0, -8475310, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M4_Saranya_New _A1_Auction_5-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_5', 'New _A1_M4_Saranya_New _A1_Auction_5', 'New _A1_M4_Saranya_New _A1_Auction_5', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_5', 4130.0, 0.0, -8471180, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M4_Saranya_New _A1_Auction_6-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_6', 'New _A1_M4_Saranya_New _A1_Auction_6', 'New _A1_M4_Saranya_New _A1_Auction_6', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_6', 4180.0, 0.0, -8467000, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M4_Saranya_New _A1_Auction_7-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_7', 'New _A1_M4_Saranya_New _A1_Auction_7', 'New _A1_M4_Saranya_New _A1_Auction_7', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_7', 4230.0, 0.0, -8462770, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M4_Saranya_New _A1_Auction_8-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_8', 'New _A1_M4_Saranya_New _A1_Auction_8', 'New _A1_M4_Saranya_New _A1_Auction_8', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_8', 4280.0, 0.0, -8458490, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M4_Saranya_New _A1_Auction_9-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_9', 'New _A1_M4_Saranya_New _A1_Auction_9', 'New _A1_M4_Saranya_New _A1_Auction_9', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_9', 4330.0, 0.0, -8454160, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M4_Saranya_New _A1_Auction_10-7d5887e6', '2026-03-15', 'Chit_Receipt', 'New _A1_M4_Saranya_New _A1_Auction_10', 'New _A1_M4_Saranya_New _A1_Auction_10', 'New _A1_M4_Saranya_New _A1_Auction_10', 'New _A1_M4_Saranya', 'New _A1_M4_Saranya_New _A1_Auction_10', 4380.0, 0.0, -8449780, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_1-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_1', 'New _A1_M5_Sagunthala1_New _A1_Auction_1', 'New _A1_M5_Sagunthala1_New _A1_Auction_1', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_1', 5000.0, 0.0, -8444780, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_2-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_2', 'New _A1_M5_Sagunthala1_New _A1_Auction_2', 'New _A1_M5_Sagunthala1_New _A1_Auction_2', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_2', 3990.0, 0.0, -8440790, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_3-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_3', 'New _A1_M5_Sagunthala1_New _A1_Auction_3', 'New _A1_M5_Sagunthala1_New _A1_Auction_3', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_3', 4040.0, 0.0, -8436750, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_4-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_4', 'New _A1_M5_Sagunthala1_New _A1_Auction_4', 'New _A1_M5_Sagunthala1_New _A1_Auction_4', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_4', 4080.0, 0.0, -8432670, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_5-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_5', 'New _A1_M5_Sagunthala1_New _A1_Auction_5', 'New _A1_M5_Sagunthala1_New _A1_Auction_5', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_5', 4130.0, 0.0, -8428540, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_6-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_6', 'New _A1_M5_Sagunthala1_New _A1_Auction_6', 'New _A1_M5_Sagunthala1_New _A1_Auction_6', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_6', 4180.0, 0.0, -8424360, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_7-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_7', 'New _A1_M5_Sagunthala1_New _A1_Auction_7', 'New _A1_M5_Sagunthala1_New _A1_Auction_7', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_7', 4230.0, 0.0, -8420130, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_8-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_8', 'New _A1_M5_Sagunthala1_New _A1_Auction_8', 'New _A1_M5_Sagunthala1_New _A1_Auction_8', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_8', 4280.0, 0.0, -8415850, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_9-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_9', 'New _A1_M5_Sagunthala1_New _A1_Auction_9', 'New _A1_M5_Sagunthala1_New _A1_Auction_9', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_9', 4330.0, 0.0, -8411520, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M5_Sagunthala1_New _A1_Auction_10-9316f974', '2026-03-15', 'Chit_Receipt', 'New _A1_M5_Sagunthala1_New _A1_Auction_10', 'New _A1_M5_Sagunthala1_New _A1_Auction_10', 'New _A1_M5_Sagunthala1_New _A1_Auction_10', 'New _A1_M5_Sagunthala1', 'New _A1_M5_Sagunthala1_New _A1_Auction_10', 4380.0, 0.0, -8407140, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M6_Sagunthala2_New _A1_Auction_1-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_1', 'New _A1_M6_Sagunthala2_New _A1_Auction_1', 'New _A1_M6_Sagunthala2_New _A1_Auction_1', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_1', 5000.0, 0.0, -8402140, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M6_Sagunthala2_New _A1_Auction_2-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_2', 'New _A1_M6_Sagunthala2_New _A1_Auction_2', 'New _A1_M6_Sagunthala2_New _A1_Auction_2', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_2', 3990.0, 0.0, -8398150, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M6_Sagunthala2_New _A1_Auction_3-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_3', 'New _A1_M6_Sagunthala2_New _A1_Auction_3', 'New _A1_M6_Sagunthala2_New _A1_Auction_3', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_3', 4040.0, 0.0, -8394110, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M6_Sagunthala2_New _A1_Auction_4-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_4', 'New _A1_M6_Sagunthala2_New _A1_Auction_4', 'New _A1_M6_Sagunthala2_New _A1_Auction_4', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_4', 4080.0, 0.0, -8390030, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M6_Sagunthala2_New _A1_Auction_5-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_5', 'New _A1_M6_Sagunthala2_New _A1_Auction_5', 'New _A1_M6_Sagunthala2_New _A1_Auction_5', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_5', 4130.0, 0.0, -8385900, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M6_Sagunthala2_New _A1_Auction_6-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_6', 'New _A1_M6_Sagunthala2_New _A1_Auction_6', 'New _A1_M6_Sagunthala2_New _A1_Auction_6', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_6', 4180.0, 0.0, -8381720, 'Cash', NULL, 'New Finance', '4180.0');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('New _A1_M6_Sagunthala2_New _A1_Auction_7-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_7', 'New _A1_M6_Sagunthala2_New _A1_Auction_7', 'New _A1_M6_Sagunthala2_New _A1_Auction_7', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_7', 4230.0, 0.0, -8377490, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M6_Sagunthala2_New _A1_Auction_8-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_8', 'New _A1_M6_Sagunthala2_New _A1_Auction_8', 'New _A1_M6_Sagunthala2_New _A1_Auction_8', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_8', 4280.0, 0.0, -8373210, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M6_Sagunthala2_New _A1_Auction_9-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_9', 'New _A1_M6_Sagunthala2_New _A1_Auction_9', 'New _A1_M6_Sagunthala2_New _A1_Auction_9', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_9', 4330.0, 0.0, -8368880, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M6_Sagunthala2_New _A1_Auction_10-7a367bd1', '2026-03-15', 'Chit_Receipt', 'New _A1_M6_Sagunthala2_New _A1_Auction_10', 'New _A1_M6_Sagunthala2_New _A1_Auction_10', 'New _A1_M6_Sagunthala2_New _A1_Auction_10', 'New _A1_M6_Sagunthala2', 'New _A1_M6_Sagunthala2_New _A1_Auction_10', 4380.0, 0.0, -8364500, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_1-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_1', 'New _A1_M7_Ananyaa_New _A1_Auction_1', 'New _A1_M7_Ananyaa_New _A1_Auction_1', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_1', 5000.0, 0.0, -8359500, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_2-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_2', 'New _A1_M7_Ananyaa_New _A1_Auction_2', 'New _A1_M7_Ananyaa_New _A1_Auction_2', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_2', 3990.0, 0.0, -8355510, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_3-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_3', 'New _A1_M7_Ananyaa_New _A1_Auction_3', 'New _A1_M7_Ananyaa_New _A1_Auction_3', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_3', 4040.0, 0.0, -8351470, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_4-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_4', 'New _A1_M7_Ananyaa_New _A1_Auction_4', 'New _A1_M7_Ananyaa_New _A1_Auction_4', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_4', 4080.0, 0.0, -8347390, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_5-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_5', 'New _A1_M7_Ananyaa_New _A1_Auction_5', 'New _A1_M7_Ananyaa_New _A1_Auction_5', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_5', 4130.0, 0.0, -8343260, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_6-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_6', 'New _A1_M7_Ananyaa_New _A1_Auction_6', 'New _A1_M7_Ananyaa_New _A1_Auction_6', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_6', 4180.0, 0.0, -8339080, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_7-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_7', 'New _A1_M7_Ananyaa_New _A1_Auction_7', 'New _A1_M7_Ananyaa_New _A1_Auction_7', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_7', 4230.0, 0.0, -8334850, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_8-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_8', 'New _A1_M7_Ananyaa_New _A1_Auction_8', 'New _A1_M7_Ananyaa_New _A1_Auction_8', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_8', 4280.0, 0.0, -8330570, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_9-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_9', 'New _A1_M7_Ananyaa_New _A1_Auction_9', 'New _A1_M7_Ananyaa_New _A1_Auction_9', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_9', 4330.0, 0.0, -8326240, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M7_Ananyaa_New _A1_Auction_10-e6589cb8', '2026-03-15', 'Chit_Receipt', 'New _A1_M7_Ananyaa_New _A1_Auction_10', 'New _A1_M7_Ananyaa_New _A1_Auction_10', 'New _A1_M7_Ananyaa_New _A1_Auction_10', 'New _A1_M7_Ananyaa', 'New _A1_M7_Ananyaa_New _A1_Auction_10', 4380.0, 0.0, -8321860, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M8_Adhvik_New _A1_Auction_1-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_1', 'New _A1_M8_Adhvik_New _A1_Auction_1', 'New _A1_M8_Adhvik_New _A1_Auction_1', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_1', 5000.0, 0.0, -8316860, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M8_Adhvik_New _A1_Auction_2-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_2', 'New _A1_M8_Adhvik_New _A1_Auction_2', 'New _A1_M8_Adhvik_New _A1_Auction_2', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_2', 3990.0, 0.0, -8312870, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M8_Adhvik_New _A1_Auction_3-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_3', 'New _A1_M8_Adhvik_New _A1_Auction_3', 'New _A1_M8_Adhvik_New _A1_Auction_3', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_3', 4040.0, 0.0, -8308830, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M8_Adhvik_New _A1_Auction_4-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_4', 'New _A1_M8_Adhvik_New _A1_Auction_4', 'New _A1_M8_Adhvik_New _A1_Auction_4', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_4', 4080.0, 0.0, -8304750, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M8_Adhvik_New _A1_Auction_5-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_5', 'New _A1_M8_Adhvik_New _A1_Auction_5', 'New _A1_M8_Adhvik_New _A1_Auction_5', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_5', 4130.0, 0.0, -8300620, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M8_Adhvik_New _A1_Auction_6-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_6', 'New _A1_M8_Adhvik_New _A1_Auction_6', 'New _A1_M8_Adhvik_New _A1_Auction_6', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_6', 4180.0, 0.0, -8296440, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M8_Adhvik_New _A1_Auction_7-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_7', 'New _A1_M8_Adhvik_New _A1_Auction_7', 'New _A1_M8_Adhvik_New _A1_Auction_7', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_7', 4230.0, 0.0, -8292210, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M8_Adhvik_New _A1_Auction_8-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_8', 'New _A1_M8_Adhvik_New _A1_Auction_8', 'New _A1_M8_Adhvik_New _A1_Auction_8', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_8', 4280.0, 0.0, -8287930, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M8_Adhvik_New _A1_Auction_9-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_9', 'New _A1_M8_Adhvik_New _A1_Auction_9', 'New _A1_M8_Adhvik_New _A1_Auction_9', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_9', 4330.0, 0.0, -8283600, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M8_Adhvik_New _A1_Auction_10-ef4bdb16', '2026-03-15', 'Chit_Receipt', 'New _A1_M8_Adhvik_New _A1_Auction_10', 'New _A1_M8_Adhvik_New _A1_Auction_10', 'New _A1_M8_Adhvik_New _A1_Auction_10', 'New _A1_M8_Adhvik', 'New _A1_M8_Adhvik_New _A1_Auction_10', 4380.0, 0.0, -8279220, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_1-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_1', 'New _A1_M9_Pandiyan1_New _A1_Auction_1', 'New _A1_M9_Pandiyan1_New _A1_Auction_1', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_1', 5000.0, 0.0, -8274220, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_2-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_2', 'New _A1_M9_Pandiyan1_New _A1_Auction_2', 'New _A1_M9_Pandiyan1_New _A1_Auction_2', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_2', 3990.0, 0.0, -8270230, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_3-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_3', 'New _A1_M9_Pandiyan1_New _A1_Auction_3', 'New _A1_M9_Pandiyan1_New _A1_Auction_3', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_3', 4040.0, 0.0, -8266190, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_4-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_4', 'New _A1_M9_Pandiyan1_New _A1_Auction_4', 'New _A1_M9_Pandiyan1_New _A1_Auction_4', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_4', 4080.0, 0.0, -8262110, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_5-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_5', 'New _A1_M9_Pandiyan1_New _A1_Auction_5', 'New _A1_M9_Pandiyan1_New _A1_Auction_5', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_5', 4130.0, 0.0, -8257980, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_6-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_6', 'New _A1_M9_Pandiyan1_New _A1_Auction_6', 'New _A1_M9_Pandiyan1_New _A1_Auction_6', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_6', 4180.0, 0.0, -8253800, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_7-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_7', 'New _A1_M9_Pandiyan1_New _A1_Auction_7', 'New _A1_M9_Pandiyan1_New _A1_Auction_7', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_7', 4230.0, 0.0, -8249570, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_8-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_8', 'New _A1_M9_Pandiyan1_New _A1_Auction_8', 'New _A1_M9_Pandiyan1_New _A1_Auction_8', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_8', 4280.0, 0.0, -8245290, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_9-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_9', 'New _A1_M9_Pandiyan1_New _A1_Auction_9', 'New _A1_M9_Pandiyan1_New _A1_Auction_9', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_9', 4330.0, 0.0, -8240960, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M9_Pandiyan1_New _A1_Auction_10-52bf3d5e', '2026-03-15', 'Chit_Receipt', 'New _A1_M9_Pandiyan1_New _A1_Auction_10', 'New _A1_M9_Pandiyan1_New _A1_Auction_10', 'New _A1_M9_Pandiyan1_New _A1_Auction_10', 'New _A1_M9_Pandiyan1', 'New _A1_M9_Pandiyan1_New _A1_Auction_10', 4380.0, 0.0, -8236580, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_1-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_1', 'New _A1_M10_Pandiyan2_New _A1_Auction_1', 'New _A1_M10_Pandiyan2_New _A1_Auction_1', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_1', 5000.0, 0.0, -8231580, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_2-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_2', 'New _A1_M10_Pandiyan2_New _A1_Auction_2', 'New _A1_M10_Pandiyan2_New _A1_Auction_2', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_2', 3990.0, 0.0, -8227590, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_3-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_3', 'New _A1_M10_Pandiyan2_New _A1_Auction_3', 'New _A1_M10_Pandiyan2_New _A1_Auction_3', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_3', 4040.0, 0.0, -8223550, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_4-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_4', 'New _A1_M10_Pandiyan2_New _A1_Auction_4', 'New _A1_M10_Pandiyan2_New _A1_Auction_4', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_4', 4080.0, 0.0, -8219470, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_5-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_5', 'New _A1_M10_Pandiyan2_New _A1_Auction_5', 'New _A1_M10_Pandiyan2_New _A1_Auction_5', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_5', 4130.0, 0.0, -8215340, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_6-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_6', 'New _A1_M10_Pandiyan2_New _A1_Auction_6', 'New _A1_M10_Pandiyan2_New _A1_Auction_6', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_6', 4180.0, 0.0, -8211160, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_7-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_7', 'New _A1_M10_Pandiyan2_New _A1_Auction_7', 'New _A1_M10_Pandiyan2_New _A1_Auction_7', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_7', 4230.0, 0.0, -8206930, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_8-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_8', 'New _A1_M10_Pandiyan2_New _A1_Auction_8', 'New _A1_M10_Pandiyan2_New _A1_Auction_8', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_8', 4280.0, 0.0, -8202650, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_9-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_9', 'New _A1_M10_Pandiyan2_New _A1_Auction_9', 'New _A1_M10_Pandiyan2_New _A1_Auction_9', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_9', 4330.0, 0.0, -8198320, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M10_Pandiyan2_New _A1_Auction_10-f0bf57bf', '2026-03-15', 'Chit_Receipt', 'New _A1_M10_Pandiyan2_New _A1_Auction_10', 'New _A1_M10_Pandiyan2_New _A1_Auction_10', 'New _A1_M10_Pandiyan2_New _A1_Auction_10', 'New _A1_M10_Pandiyan2', 'New _A1_M10_Pandiyan2_New _A1_Auction_10', 4380.0, 0.0, -8193940, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_1-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_1', 'New _A1_M11_Vinayagam_New _A1_Auction_1', 'New _A1_M11_Vinayagam_New _A1_Auction_1', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_1', 5000.0, 0.0, -8188940, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_2-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_2', 'New _A1_M11_Vinayagam_New _A1_Auction_2', 'New _A1_M11_Vinayagam_New _A1_Auction_2', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_2', 3990.0, 0.0, -8184950, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_3-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_3', 'New _A1_M11_Vinayagam_New _A1_Auction_3', 'New _A1_M11_Vinayagam_New _A1_Auction_3', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_3', 4040.0, 0.0, -8180910, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_4-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_4', 'New _A1_M11_Vinayagam_New _A1_Auction_4', 'New _A1_M11_Vinayagam_New _A1_Auction_4', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_4', 4080.0, 0.0, -8176830, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_5-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_5', 'New _A1_M11_Vinayagam_New _A1_Auction_5', 'New _A1_M11_Vinayagam_New _A1_Auction_5', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_5', 4130.0, 0.0, -8172700, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_6-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_6', 'New _A1_M11_Vinayagam_New _A1_Auction_6', 'New _A1_M11_Vinayagam_New _A1_Auction_6', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_6', 4180.0, 0.0, -8168520, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_7-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_7', 'New _A1_M11_Vinayagam_New _A1_Auction_7', 'New _A1_M11_Vinayagam_New _A1_Auction_7', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_7', 4230.0, 0.0, -8164290, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_8-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_8', 'New _A1_M11_Vinayagam_New _A1_Auction_8', 'New _A1_M11_Vinayagam_New _A1_Auction_8', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_8', 4280.0, 0.0, -8160010, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_9-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_9', 'New _A1_M11_Vinayagam_New _A1_Auction_9', 'New _A1_M11_Vinayagam_New _A1_Auction_9', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_9', 4330.0, 0.0, -8155680, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M11_Vinayagam_New _A1_Auction_10-bfb0d576', '2026-03-15', 'Chit_Receipt', 'New _A1_M11_Vinayagam_New _A1_Auction_10', 'New _A1_M11_Vinayagam_New _A1_Auction_10', 'New _A1_M11_Vinayagam_New _A1_Auction_10', 'New _A1_M11_Vinayagam', 'New _A1_M11_Vinayagam_New _A1_Auction_10', 4380.0, 0.0, -8151300, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M12_Gopi_New _A1_Auction_1-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_1', 'New _A1_M12_Gopi_New _A1_Auction_1', 'New _A1_M12_Gopi_New _A1_Auction_1', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_1', 5000.0, 0.0, -8146300, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M12_Gopi_New _A1_Auction_2-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_2', 'New _A1_M12_Gopi_New _A1_Auction_2', 'New _A1_M12_Gopi_New _A1_Auction_2', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_2', 3990.0, 0.0, -8142310, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M12_Gopi_New _A1_Auction_3-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_3', 'New _A1_M12_Gopi_New _A1_Auction_3', 'New _A1_M12_Gopi_New _A1_Auction_3', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_3', 4040.0, 0.0, -8138270, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M12_Gopi_New _A1_Auction_4-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_4', 'New _A1_M12_Gopi_New _A1_Auction_4', 'New _A1_M12_Gopi_New _A1_Auction_4', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_4', 4080.0, 0.0, -8134190, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M12_Gopi_New _A1_Auction_5-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_5', 'New _A1_M12_Gopi_New _A1_Auction_5', 'New _A1_M12_Gopi_New _A1_Auction_5', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_5', 4130.0, 0.0, -8130060, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M12_Gopi_New _A1_Auction_6-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_6', 'New _A1_M12_Gopi_New _A1_Auction_6', 'New _A1_M12_Gopi_New _A1_Auction_6', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_6', 4180.0, 0.0, -8125880, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M12_Gopi_New _A1_Auction_7-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_7', 'New _A1_M12_Gopi_New _A1_Auction_7', 'New _A1_M12_Gopi_New _A1_Auction_7', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_7', 4230.0, 0.0, -8121650, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M12_Gopi_New _A1_Auction_8-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_8', 'New _A1_M12_Gopi_New _A1_Auction_8', 'New _A1_M12_Gopi_New _A1_Auction_8', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_8', 4280.0, 0.0, -8117370, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M12_Gopi_New _A1_Auction_9-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_9', 'New _A1_M12_Gopi_New _A1_Auction_9', 'New _A1_M12_Gopi_New _A1_Auction_9', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_9', 4330.0, 0.0, -8113040, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M12_Gopi_New _A1_Auction_10-5ca2f09f', '2026-03-15', 'Chit_Receipt', 'New _A1_M12_Gopi_New _A1_Auction_10', 'New _A1_M12_Gopi_New _A1_Auction_10', 'New _A1_M12_Gopi_New _A1_Auction_10', 'New _A1_M12_Gopi', 'New _A1_M12_Gopi_New _A1_Auction_10', 4380.0, 0.0, -8108660, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M13_Gokul_New _A1_Auction_1-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_1', 'New _A1_M13_Gokul_New _A1_Auction_1', 'New _A1_M13_Gokul_New _A1_Auction_1', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_1', 5000.0, 0.0, -8103660, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M13_Gokul_New _A1_Auction_2-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_2', 'New _A1_M13_Gokul_New _A1_Auction_2', 'New _A1_M13_Gokul_New _A1_Auction_2', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_2', 3990.0, 0.0, -8099670, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M13_Gokul_New _A1_Auction_3-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_3', 'New _A1_M13_Gokul_New _A1_Auction_3', 'New _A1_M13_Gokul_New _A1_Auction_3', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_3', 4040.0, 0.0, -8095630, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M13_Gokul_New _A1_Auction_4-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_4', 'New _A1_M13_Gokul_New _A1_Auction_4', 'New _A1_M13_Gokul_New _A1_Auction_4', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_4', 4080.0, 0.0, -8091550, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M13_Gokul_New _A1_Auction_5-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_5', 'New _A1_M13_Gokul_New _A1_Auction_5', 'New _A1_M13_Gokul_New _A1_Auction_5', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_5', 4130.0, 0.0, -8087420, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M13_Gokul_New _A1_Auction_6-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_6', 'New _A1_M13_Gokul_New _A1_Auction_6', 'New _A1_M13_Gokul_New _A1_Auction_6', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_6', 4180.0, 0.0, -8083240, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M13_Gokul_New _A1_Auction_7-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_7', 'New _A1_M13_Gokul_New _A1_Auction_7', 'New _A1_M13_Gokul_New _A1_Auction_7', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_7', 4230.0, 0.0, -8079010, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M13_Gokul_New _A1_Auction_8-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_8', 'New _A1_M13_Gokul_New _A1_Auction_8', 'New _A1_M13_Gokul_New _A1_Auction_8', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_8', 4280.0, 0.0, -8074730, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M13_Gokul_New _A1_Auction_9-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_9', 'New _A1_M13_Gokul_New _A1_Auction_9', 'New _A1_M13_Gokul_New _A1_Auction_9', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_9', 4330.0, 0.0, -8070400, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M13_Gokul_New _A1_Auction_10-73c662d7', '2026-03-15', 'Chit_Receipt', 'New _A1_M13_Gokul_New _A1_Auction_10', 'New _A1_M13_Gokul_New _A1_Auction_10', 'New _A1_M13_Gokul_New _A1_Auction_10', 'New _A1_M13_Gokul', 'New _A1_M13_Gokul_New _A1_Auction_10', 4380.0, 0.0, -8066020, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_1-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_1', 'New _A1_M14_DineshSKP_New _A1_Auction_1', 'New _A1_M14_DineshSKP_New _A1_Auction_1', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_1', 5000.0, 0.0, -8061020, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_2-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_2', 'New _A1_M14_DineshSKP_New _A1_Auction_2', 'New _A1_M14_DineshSKP_New _A1_Auction_2', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_2', 3990.0, 0.0, -8057030, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_3-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_3', 'New _A1_M14_DineshSKP_New _A1_Auction_3', 'New _A1_M14_DineshSKP_New _A1_Auction_3', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_3', 4040.0, 0.0, -8052990, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_4-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_4', 'New _A1_M14_DineshSKP_New _A1_Auction_4', 'New _A1_M14_DineshSKP_New _A1_Auction_4', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_4', 4080.0, 0.0, -8048910, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_5-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_5', 'New _A1_M14_DineshSKP_New _A1_Auction_5', 'New _A1_M14_DineshSKP_New _A1_Auction_5', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_5', 4130.0, 0.0, -8044780, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_6-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_6', 'New _A1_M14_DineshSKP_New _A1_Auction_6', 'New _A1_M14_DineshSKP_New _A1_Auction_6', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_6', 4180.0, 0.0, -8040600, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_7-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_7', 'New _A1_M14_DineshSKP_New _A1_Auction_7', 'New _A1_M14_DineshSKP_New _A1_Auction_7', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_7', 4230.0, 0.0, -8036370, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_8-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_8', 'New _A1_M14_DineshSKP_New _A1_Auction_8', 'New _A1_M14_DineshSKP_New _A1_Auction_8', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_8', 4280.0, 0.0, -8032090, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_9-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_9', 'New _A1_M14_DineshSKP_New _A1_Auction_9', 'New _A1_M14_DineshSKP_New _A1_Auction_9', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_9', 4330.0, 0.0, -8027760, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M14_DineshSKP_New _A1_Auction_10-16dcb976', '2026-03-15', 'Chit_Receipt', 'New _A1_M14_DineshSKP_New _A1_Auction_10', 'New _A1_M14_DineshSKP_New _A1_Auction_10', 'New _A1_M14_DineshSKP_New _A1_Auction_10', 'New _A1_M14_DineshSKP', 'New _A1_M14_DineshSKP_New _A1_Auction_10', 4380.0, 0.0, -8023380, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M15_Ramya_New _A1_Auction_1-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_1', 'New _A1_M15_Ramya_New _A1_Auction_1', 'New _A1_M15_Ramya_New _A1_Auction_1', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_1', 5000.0, 0.0, -8018380, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M15_Ramya_New _A1_Auction_2-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_2', 'New _A1_M15_Ramya_New _A1_Auction_2', 'New _A1_M15_Ramya_New _A1_Auction_2', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_2', 3990.0, 0.0, -8014390, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M15_Ramya_New _A1_Auction_3-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_3', 'New _A1_M15_Ramya_New _A1_Auction_3', 'New _A1_M15_Ramya_New _A1_Auction_3', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_3', 4040.0, 0.0, -8010350, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M15_Ramya_New _A1_Auction_4-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_4', 'New _A1_M15_Ramya_New _A1_Auction_4', 'New _A1_M15_Ramya_New _A1_Auction_4', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_4', 4080.0, 0.0, -8006270, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M15_Ramya_New _A1_Auction_5-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_5', 'New _A1_M15_Ramya_New _A1_Auction_5', 'New _A1_M15_Ramya_New _A1_Auction_5', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_5', 4130.0, 0.0, -8002140, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M15_Ramya_New _A1_Auction_6-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_6', 'New _A1_M15_Ramya_New _A1_Auction_6', 'New _A1_M15_Ramya_New _A1_Auction_6', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_6', 4180.0, 0.0, -7997960, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M15_Ramya_New _A1_Auction_7-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_7', 'New _A1_M15_Ramya_New _A1_Auction_7', 'New _A1_M15_Ramya_New _A1_Auction_7', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_7', 4230.0, 0.0, -7993730, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M15_Ramya_New _A1_Auction_8-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_8', 'New _A1_M15_Ramya_New _A1_Auction_8', 'New _A1_M15_Ramya_New _A1_Auction_8', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_8', 4280.0, 0.0, -7989450, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M15_Ramya_New _A1_Auction_9-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_9', 'New _A1_M15_Ramya_New _A1_Auction_9', 'New _A1_M15_Ramya_New _A1_Auction_9', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_9', 4330.0, 0.0, -7985120, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M15_Ramya_New _A1_Auction_10-2fe553ab', '2026-03-15', 'Chit_Receipt', 'New _A1_M15_Ramya_New _A1_Auction_10', 'New _A1_M15_Ramya_New _A1_Auction_10', 'New _A1_M15_Ramya_New _A1_Auction_10', 'New _A1_M15_Ramya', 'New _A1_M15_Ramya_New _A1_Auction_10', 4380.0, 0.0, -7980740, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M16_Balamurali_New _A1_Auction_1-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_1', 'New _A1_M16_Balamurali_New _A1_Auction_1', 'New _A1_M16_Balamurali_New _A1_Auction_1', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_1', 5000.0, 0.0, -7975740, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M16_Balamurali_New _A1_Auction_2-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_2', 'New _A1_M16_Balamurali_New _A1_Auction_2', 'New _A1_M16_Balamurali_New _A1_Auction_2', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_2', 3990.0, 0.0, -7971750, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M16_Balamurali_New _A1_Auction_3-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_3', 'New _A1_M16_Balamurali_New _A1_Auction_3', 'New _A1_M16_Balamurali_New _A1_Auction_3', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_3', 4040.0, 0.0, -7967710, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M16_Balamurali_New _A1_Auction_4-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_4', 'New _A1_M16_Balamurali_New _A1_Auction_4', 'New _A1_M16_Balamurali_New _A1_Auction_4', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_4', 4080.0, 0.0, -7963630, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M16_Balamurali_New _A1_Auction_5-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_5', 'New _A1_M16_Balamurali_New _A1_Auction_5', 'New _A1_M16_Balamurali_New _A1_Auction_5', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_5', 4130.0, 0.0, -7959500, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M16_Balamurali_New _A1_Auction_6-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_6', 'New _A1_M16_Balamurali_New _A1_Auction_6', 'New _A1_M16_Balamurali_New _A1_Auction_6', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_6', 4180.0, 0.0, -7955320, 'Cash', NULL, 'New Finance', '4180.0');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('New _A1_M16_Balamurali_New _A1_Auction_7-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_7', 'New _A1_M16_Balamurali_New _A1_Auction_7', 'New _A1_M16_Balamurali_New _A1_Auction_7', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_7', 4230.0, 0.0, -7951090, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M16_Balamurali_New _A1_Auction_8-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_8', 'New _A1_M16_Balamurali_New _A1_Auction_8', 'New _A1_M16_Balamurali_New _A1_Auction_8', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_8', 4280.0, 0.0, -7946810, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M16_Balamurali_New _A1_Auction_9-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_9', 'New _A1_M16_Balamurali_New _A1_Auction_9', 'New _A1_M16_Balamurali_New _A1_Auction_9', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_9', 4330.0, 0.0, -7942480, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M16_Balamurali_New _A1_Auction_10-593bb35f', '2026-03-15', 'Chit_Receipt', 'New _A1_M16_Balamurali_New _A1_Auction_10', 'New _A1_M16_Balamurali_New _A1_Auction_10', 'New _A1_M16_Balamurali_New _A1_Auction_10', 'New _A1_M16_Balamurali', 'New _A1_M16_Balamurali_New _A1_Auction_10', 4380.0, 0.0, -7938100, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_1-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_1', 'New _A1_M17_Ramkumar_New _A1_Auction_1', 'New _A1_M17_Ramkumar_New _A1_Auction_1', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_1', 5000.0, 0.0, -7933100, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_2-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_2', 'New _A1_M17_Ramkumar_New _A1_Auction_2', 'New _A1_M17_Ramkumar_New _A1_Auction_2', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_2', 3990.0, 0.0, -7929110, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_3-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_3', 'New _A1_M17_Ramkumar_New _A1_Auction_3', 'New _A1_M17_Ramkumar_New _A1_Auction_3', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_3', 4040.0, 0.0, -7925070, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_4-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_4', 'New _A1_M17_Ramkumar_New _A1_Auction_4', 'New _A1_M17_Ramkumar_New _A1_Auction_4', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_4', 4080.0, 0.0, -7920990, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_5-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_5', 'New _A1_M17_Ramkumar_New _A1_Auction_5', 'New _A1_M17_Ramkumar_New _A1_Auction_5', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_5', 4130.0, 0.0, -7916860, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_6-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_6', 'New _A1_M17_Ramkumar_New _A1_Auction_6', 'New _A1_M17_Ramkumar_New _A1_Auction_6', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_6', 4180.0, 0.0, -7912680, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_7-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_7', 'New _A1_M17_Ramkumar_New _A1_Auction_7', 'New _A1_M17_Ramkumar_New _A1_Auction_7', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_7', 4230.0, 0.0, -7908450, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_8-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_8', 'New _A1_M17_Ramkumar_New _A1_Auction_8', 'New _A1_M17_Ramkumar_New _A1_Auction_8', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_8', 4280.0, 0.0, -7904170, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_9-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_9', 'New _A1_M17_Ramkumar_New _A1_Auction_9', 'New _A1_M17_Ramkumar_New _A1_Auction_9', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_9', 4330.0, 0.0, -7899840, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M17_Ramkumar_New _A1_Auction_10-890c1b25', '2026-03-15', 'Chit_Receipt', 'New _A1_M17_Ramkumar_New _A1_Auction_10', 'New _A1_M17_Ramkumar_New _A1_Auction_10', 'New _A1_M17_Ramkumar_New _A1_Auction_10', 'New _A1_M17_Ramkumar', 'New _A1_M17_Ramkumar_New _A1_Auction_10', 4380.0, 0.0, -7895460, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_1-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_1', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_1', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_1', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_1', 5000.0, 0.0, -7890460, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_2-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_2', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_2', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_2', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_2', 3990.0, 0.0, -7886470, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_3-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_3', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_3', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_3', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_3', 4040.0, 0.0, -7882430, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_4-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_4', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_4', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_4', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_4', 4080.0, 0.0, -7878350, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_5-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_5', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_5', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_5', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_5', 4130.0, 0.0, -7874220, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_6-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_6', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_6', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_6', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_6', 4180.0, 0.0, -7870040, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_7-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_7', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_7', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_7', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_7', 4230.0, 0.0, -7865810, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_8-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_8', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_8', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_8', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_8', 4280.0, 0.0, -7861530, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_9-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_9', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_9', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_9', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_9', 4330.0, 0.0, -7857200, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M18_Kalaiyarasi_New _A1_Auction_10-72f84562', '2026-03-15', 'Chit_Receipt', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_10', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_10', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_10', 'New _A1_M18_Kalaiyarasi', 'New _A1_M18_Kalaiyarasi_New _A1_Auction_10', 4380.0, 0.0, -7852820, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M19_Finance1_New _A1_Auction_1-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_1', 'New _A1_M19_Finance1_New _A1_Auction_1', 'New _A1_M19_Finance1_New _A1_Auction_1', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_1', 5000.0, 0.0, -7847820, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M19_Finance1_New _A1_Auction_2-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_2', 'New _A1_M19_Finance1_New _A1_Auction_2', 'New _A1_M19_Finance1_New _A1_Auction_2', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_2', 3990.0, 0.0, -7843830, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M19_Finance1_New _A1_Auction_3-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_3', 'New _A1_M19_Finance1_New _A1_Auction_3', 'New _A1_M19_Finance1_New _A1_Auction_3', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_3', 4040.0, 0.0, -7839790, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M19_Finance1_New _A1_Auction_4-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_4', 'New _A1_M19_Finance1_New _A1_Auction_4', 'New _A1_M19_Finance1_New _A1_Auction_4', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_4', 4080.0, 0.0, -7835710, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M19_Finance1_New _A1_Auction_5-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_5', 'New _A1_M19_Finance1_New _A1_Auction_5', 'New _A1_M19_Finance1_New _A1_Auction_5', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_5', 4130.0, 0.0, -7831580, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M19_Finance1_New _A1_Auction_6-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_6', 'New _A1_M19_Finance1_New _A1_Auction_6', 'New _A1_M19_Finance1_New _A1_Auction_6', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_6', 4180.0, 0.0, -7827400, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M19_Finance1_New _A1_Auction_7-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_7', 'New _A1_M19_Finance1_New _A1_Auction_7', 'New _A1_M19_Finance1_New _A1_Auction_7', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_7', 4230.0, 0.0, -7823170, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M19_Finance1_New _A1_Auction_8-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_8', 'New _A1_M19_Finance1_New _A1_Auction_8', 'New _A1_M19_Finance1_New _A1_Auction_8', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_8', 4280.0, 0.0, -7818890, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M19_Finance1_New _A1_Auction_9-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_9', 'New _A1_M19_Finance1_New _A1_Auction_9', 'New _A1_M19_Finance1_New _A1_Auction_9', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_9', 4330.0, 0.0, -7814560, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M19_Finance1_New _A1_Auction_10-6b15bd9c', '2026-03-15', 'Chit_Receipt', 'New _A1_M19_Finance1_New _A1_Auction_10', 'New _A1_M19_Finance1_New _A1_Auction_10', 'New _A1_M19_Finance1_New _A1_Auction_10', 'New _A1_M19_Finance1', 'New _A1_M19_Finance1_New _A1_Auction_10', 4380.0, 0.0, -7810180, 'Cash', NULL, 'New Finance', '4380.0'),
('New _A1_M20_Finance2_New _A1_Auction_1-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_1', 'New _A1_M20_Finance2_New _A1_Auction_1', 'New _A1_M20_Finance2_New _A1_Auction_1', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_1', 5000.0, 0.0, -7805180, 'Cash', NULL, 'New Finance', '5000.0'),
('New _A1_M20_Finance2_New _A1_Auction_2-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_2', 'New _A1_M20_Finance2_New _A1_Auction_2', 'New _A1_M20_Finance2_New _A1_Auction_2', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_2', 3990.0, 0.0, -7801190, 'Cash', NULL, 'New Finance', '3990.0'),
('New _A1_M20_Finance2_New _A1_Auction_3-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_3', 'New _A1_M20_Finance2_New _A1_Auction_3', 'New _A1_M20_Finance2_New _A1_Auction_3', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_3', 4040.0, 0.0, -7797150, 'Cash', NULL, 'New Finance', '4040.0'),
('New _A1_M20_Finance2_New _A1_Auction_4-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_4', 'New _A1_M20_Finance2_New _A1_Auction_4', 'New _A1_M20_Finance2_New _A1_Auction_4', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_4', 4080.0, 0.0, -7793070, 'Cash', NULL, 'New Finance', '4080.0'),
('New _A1_M20_Finance2_New _A1_Auction_5-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_5', 'New _A1_M20_Finance2_New _A1_Auction_5', 'New _A1_M20_Finance2_New _A1_Auction_5', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_5', 4130.0, 0.0, -7788940, 'Cash', NULL, 'New Finance', '4130.0'),
('New _A1_M20_Finance2_New _A1_Auction_6-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_6', 'New _A1_M20_Finance2_New _A1_Auction_6', 'New _A1_M20_Finance2_New _A1_Auction_6', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_6', 4180.0, 0.0, -7784760, 'Cash', NULL, 'New Finance', '4180.0'),
('New _A1_M20_Finance2_New _A1_Auction_7-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_7', 'New _A1_M20_Finance2_New _A1_Auction_7', 'New _A1_M20_Finance2_New _A1_Auction_7', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_7', 4230.0, 0.0, -7780530, 'Cash', NULL, 'New Finance', '4230.0'),
('New _A1_M20_Finance2_New _A1_Auction_8-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_8', 'New _A1_M20_Finance2_New _A1_Auction_8', 'New _A1_M20_Finance2_New _A1_Auction_8', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_8', 4280.0, 0.0, -7776250, 'Cash', NULL, 'New Finance', '4280.0'),
('New _A1_M20_Finance2_New _A1_Auction_9-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_9', 'New _A1_M20_Finance2_New _A1_Auction_9', 'New _A1_M20_Finance2_New _A1_Auction_9', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_9', 4330.0, 0.0, -7771920, 'Cash', NULL, 'New Finance', '4330.0'),
('New _A1_M20_Finance2_New _A1_Auction_10-0ec21b23', '2026-03-15', 'Chit_Receipt', 'New _A1_M20_Finance2_New _A1_Auction_10', 'New _A1_M20_Finance2_New _A1_Auction_10', 'New _A1_M20_Finance2_New _A1_Auction_10', 'New _A1_M20_Finance2', 'New _A1_M20_Finance2_New _A1_Auction_10', 4380.0, 0.0, -7767540, 'Cash', NULL, 'New Finance', '4380.0'),
('78dc07a9', '2026-03-15', 'Chit_Payment', 'New _A1_Auction_1_M1', NULL, NULL, 'New _A1_M19_Finance1', NULL, NULL, 100000.0, -7867540, 'Cash', NULL, 'New Finance', NULL),
('60364b84', '2026-03-31', 'Operning_Balance', 'opending balance adjustment', NULL, NULL, 'opening balance adjusment', 'opending balance adjustment', 8116230.0, NULL, 248690, 'Other', NULL, 'New Finance', NULL),
('088cc8a6', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL2-Ashok Bro', 'Kan-STL2', 'Kan-76', 'Ashok Bro', NULL, NULL, 150000.0, -150000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('6e13c975', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL4-Arun Lorry', 'Kan-STL4', 'Kan-77', 'Arun Lorry', NULL, NULL, 410000.0, -560000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('c89159f0', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL40-Gokulnath', 'Kan-STL40', 'Kan-78', 'Gokulnath', NULL, NULL, 20000.0, -580000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('a7533086', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL49-Elango Sports', 'Kan-STL49', 'Kan-79', 'Elango Sports', NULL, NULL, 60000.0, -640000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('1fb942a8', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL60-Karthi China', 'Kan-STL60', 'Kan-80', 'Karthi China', NULL, NULL, 1000000.0, -1640000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('8d1b46eb', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL65-Sethu', 'Kan-STL65', 'Kan-81', 'Sethu', NULL, NULL, 100000.0, -1740000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('bec110ef', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL74-Rail Ragavan', 'Kan-STL74', 'Kan-82', 'Rail Ragavan', NULL, NULL, 50000.0, -1790000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('6aeac8e5', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL75-Saravanan Bakery', 'Kan-STL75', 'Kan-83', 'Saravanan Bakery', NULL, NULL, 380000.0, -2170000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('da8722a8', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL95-Jayaprabha', 'Kan-STL95', 'Kan-84', 'Jayaprabha', NULL, NULL, 450000.0, -2620000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('40e3b993', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL103-Theena Aravind', 'Kan-STL103', 'Kan-85', 'Theena Aravind', NULL, NULL, 40000.0, -2660000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('18a32a61', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL108-Kavin Surrendar', 'Kan-STL108', 'Kan-86', 'Kavin Surrendar', NULL, NULL, 300000.0, -2960000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('e310e370', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL123-Sridhar Aalves', 'Kan-STL123', 'Kan-87', 'Sridhar Aalves', NULL, NULL, 140000.0, -3100000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('588e7cd0', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL129-Aravind Vasu', 'Kan-STL129', 'Kan-88', 'Aravind Vasu', NULL, NULL, 293000.0, -3393000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('3156ee43', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL139-Arun Kumba', 'Kan-STL139', 'Kan-89', 'Arun Kumba', NULL, NULL, 565000.0, -3958000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('a3d9ca0b', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL153-Kanagaraj Chola', 'Kan-STL153', 'Kan-90', 'Kanagaraj Chola', NULL, NULL, 140000.0, -4098000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('22fd2c04', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL154-Sudhakar', 'Kan-STL154', 'Kan-91', 'Sudhakar', NULL, NULL, 180000.0, -4278000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('c21271af', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL155-Abdul Rahman', 'Kan-STL155', 'Kan-92', 'Abdul Rahman', NULL, NULL, 20000.0, -4298000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('6e359ce9', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL161-Vijay', 'Kan-STL161', 'Kan-93', 'Vijay', NULL, NULL, 100000.0, -4398000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('d64d9208', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL162-Karthi Oil', 'Kan-STL162', 'Kan-94', 'Karthi Oil', NULL, NULL, 40000.0, -4438000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('822bb2d7', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL164-Viji Vasanth', 'Kan-STL164', 'Kan-95', 'Viji Vasanth', NULL, NULL, 300000.0, -4738000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('26f68579', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL173-Venkat Pilot', 'Kan-STL173', 'Kan-96', 'Venkat Pilot', NULL, NULL, 225000.0, -4963000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('e7eed9be', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL174-Sabarish', 'Kan-STL174', 'Kan-97', 'Sabarish', NULL, NULL, 100000.0, -5063000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('9e2c3617', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL177-Murugesan', 'Kan-STL177', 'Kan-98', 'Murugesan', NULL, NULL, 60000.0, -5123000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('3ce33bb5', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL182-John', 'Kan-STL182', 'Kan-99', 'John', NULL, NULL, 225000.0, -5348000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('6c8aa6ac', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL184-Manoj', 'Kan-STL184', 'Kan-100', 'Manoj', NULL, NULL, 500000.0, -5848000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('fe7026b3', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL187-Palanisamy Auto', 'Kan-STL187', 'Kan-101', 'Palanisamy Auto', NULL, NULL, 100000.0, -5948000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('9fea5d76', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL189-Vallarasu_Kumaravel', 'Kan-STL189', 'Kan-102', 'Vallarasu_Kumaravel', NULL, NULL, 80000.0, -6028000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('5957841d', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL191-Govindhasamy', 'Kan-STL191', 'Kan-103', 'Govindhasamy', NULL, NULL, 65000.0, -6093000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('ddaeb90d', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL193-Saravanan Chola', 'Kan-STL193', 'Kan-104', 'Saravanan Chola', NULL, NULL, 20000.0, -6113000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('b4179c09', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL197-Guna', 'Kan-STL197', 'Kan-105', 'Guna', NULL, NULL, 300000.0, -6413000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('b2fdb3f8', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL201-Maniraj', 'Kan-STL201', 'Kan-106', 'Maniraj', NULL, NULL, 300000.0, -6713000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('f60178a7', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL203-Dinesh', 'Kan-STL203', 'Kan-107', 'Dinesh', NULL, NULL, 100000.0, -6813000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('07e5e3eb', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL205-Jeeva', 'Kan-STL205', 'Kan-108', 'Jeeva', NULL, NULL, 25000.0, -6838000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('9c32f132', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL206-Prabhakar', 'Kan-STL206', 'Kan-109', 'Prabhakar', NULL, NULL, 40000.0, -6878000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('ce926661', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL211-Devaraj', 'Kan-STL211', 'Kan-110', 'Devaraj', NULL, NULL, 50000.0, -6928000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('d73e989e', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL212-Arumugam', 'Kan-STL212', 'Kan-111', 'Arumugam', NULL, NULL, 20000.0, -6948000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('9798d6af', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL215-Rekha', 'Kan-STL215', 'Kan-112', 'Rekha', NULL, NULL, 40000.0, -6988000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('2f9e58fa', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL216-Sasi Master', 'Kan-STL216', 'Kan-113', 'Sasi Master', NULL, NULL, 20000.0, -7008000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('465be7ac', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL217-Sathish Siva', 'Kan-STL217', 'Kan-114', 'Sathish Siva', NULL, NULL, 20000.0, -7028000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('aa38ee3d', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL218-Kongu Kochai', 'Kan-STL218', 'Kan-115', 'Kongu Kochai', NULL, NULL, 170000.0, -7198000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('01d1bb9c', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL219-Amutha Ashok', 'Kan-STL219', 'Kan-116', 'Amutha Ashok', NULL, NULL, 1000000.0, -8198000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('86155d81', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL220-Prabhu', 'Kan-STL220', 'Kan-117', 'Prabhu', NULL, NULL, 250000.0, -8448000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('99d73538', '2026-03-04', 'Customer_Loan_Prin_Repayment', 'Kan-STL49-Kan-79-Elango Sports-60000', 'Kan-STL49', 'Kan-79', 'Elango Sports', 'Kan-79', 30000.0, NULL, -8418000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('91bc888a', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL49-Elango Sports', 'Kan-STL49', 'Kan-118', 'Elango Sports', NULL, NULL, 20000.0, -8438000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('104c0295', '2026-03-12', 'Customer_Loan_Prin_Repayment', 'Kan-STL108-Kan-86-Kavin Surrendar-300000', 'Kan-STL108', 'Kan-86', 'Kavin Surrendar', 'Kan-86', 50000.0, NULL, -8388000, NULL, NULL, 'Kannnan_Personal', NULL),
('8b2b2c8f', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL123-Sridhar Aalves', 'Kan-STL123', 'Kan-119', 'Sridhar Aalves', NULL, NULL, 20000.0, -8408000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('8250a9c0', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL139-Arun Kumba', 'Kan-STL139', 'Kan-120', 'Arun Kumba', NULL, NULL, 30000.0, -8438000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('0c2d7613', '2026-03-11', 'Customer_Loan_Prin_Repayment', 'Kan-STL139-Kan-89-Arun Kumba-565000', 'Kan-STL139', 'Kan-89', 'Arun Kumba', 'Kan-89', 30000.0, NULL, -8408000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('5fe71fcd', '2026-03-23', 'Customer_Loan_Prin_Repayment', 'Kan-STL139-Kan-89-Arun Kumba-565000', 'Kan-STL139', 'Kan-89', 'Arun Kumba', 'Kan-89', 20000.0, NULL, -8388000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('9451df57', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL139-Arun Kumba', 'Kan-STL139', 'Kan-121', 'Arun Kumba', NULL, NULL, 10000.0, -8398000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('400fa559', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL153-Kanagaraj Chola', 'Kan-STL153', 'Kan-122', 'Kanagaraj Chola', NULL, NULL, 30000.0, -8428000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('27d64830', '2026-03-18', 'Customer_Loan_Prin_Repayment', 'Kan-STL2-Kan-76-Ashok Bro-150000', 'Kan-STL2', 'Kan-76', 'Ashok Bro', 'Kan-76', 100000.0, NULL, -8328000, 'Cash', NULL, 'Kannnan_Personal', NULL),
('f6fede78', '2026-03-24', 'Customer_Loan_Prin_Repayment', 'Kan-STL2-Kan-76-Ashok Bro-50000', 'Kan-STL2', 'Kan-76', 'Ashok Bro', 'Kan-76', 50000.0, NULL, -8278000, 'Cash', NULL, 'Kannnan_Personal', '3260,1260'),
('46a68802', '2026-04-12', 'Loan_To_Customer', 'Loan_To_Customer-Rail-Rail Ragavan', 'Rail', 'Kan-123', 'Rail Ragavan', NULL, NULL, 10000.0, -8288000, 'UPI', 'Already 50k, now total 60k', 'Kannnan_Personal', NULL);
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('9001e90b', '2026-04-15', 'Loan_To_Customer', 'Loan_To_Customer-Kan-STL206-Prabhakar', 'Kan-STL206', 'Hi', 'Prabhakar', NULL, NULL, 20000.0, -8308000, 'UPI', 'Total loan 60k', 'Kannnan_Personal', NULL),
('de4abfeb', '2026-04-01', 'Customer_Loan_Prin_Repayment', 'New-STL231-New-35-Ramkumar-200000', 'New-STL231', 'New-35', 'Ramkumar', 'New-35', 100000.0, NULL, 348690, 'Cash', NULL, 'New Finance', '4340,840,730'),
('5ce6c15b', '2026-04-01', 'Customer_Loan_Prin_Repayment', 'New-STL329-New-17-Kongu Kochai-200000', 'New-STL329', 'New-17', 'Kongu Kochai', 'New-17', 50000.0, NULL, 398690, 'Cash', NULL, 'New Finance', '4340'),
('bbddd80d', '2026-04-02', 'Loan_To_Customer', 'Loan_To_Customer-New-STL323-Kaviyarasu Arul', 'New-STL323', 'New-125', 'Kaviyarasu Arul', NULL, NULL, 200000.0, 198690, 'Cash', NULL, 'New Finance', NULL),
('bf95f7b6', '2026-04-03', 'Customer_Loan_Prin_Repayment', 'New-STL306-New-45-Ravi-75000', 'New-STL306', 'New-45', 'Ravi', 'New-45', 75000.0, NULL, 273690, 'Cash', NULL, 'New Finance', '1890,530,1630'),
('8d3fcdd1', '2026-04-13', 'Loan_To_Customer', 'Loan_To_Customer-New-STL227-Nandhakumar', 'New-STL227', 'New-127', 'Nandhakumar', NULL, NULL, 200000.0, 73690, 'Cash', NULL, 'New Finance', NULL),
('6a158bcc', '2026-04-15', 'Customer_Loan_Prin_Repayment', 'New-STL231-New-69-Ramkumar-100000', 'New-STL231', 'New-69', 'Ramkumar', 'New-69', 100000.0, NULL, 173690, 'Cash', NULL, 'New Finance', '4340,840,730,70,840'),
('d50b8303', '2026-04-12', 'Customer_Loan_Prin_Repayment', 'New-STL231-New-71-Ramkumar-130000', 'New-STL231', 'New-71', 'Ramkumar', 'New-71', 30000.0, NULL, 203690, NULL, NULL, 'New Finance', '4340,840,730,70,840,1050'),
('af2925d0', '2026-04-13', 'Loan_To_Customer', 'Loan_To_Customer-New-STL337-Karthi cake shop', 'New-STL337', 'New-128', 'Karthi cake shop', NULL, NULL, 200000.0, 3690, 'Cash', NULL, 'New Finance', NULL),
('f1924f58', '2026-04-04', 'Loan_To_Customer', 'Loan_To_Customer-New-STL336-Manoj raghavendra shop', 'New-STL336', 'New-129', 'Manoj raghavendra shop', NULL, NULL, 10000.0, -6310, 'Cash', NULL, 'New Finance', NULL),
('5a3b52e9', '2026-04-13', 'Loan_To_Customer', 'Loan_To_Customer-New-STL320-Priya', 'New-STL320', 'New-130', 'Priya', NULL, NULL, 200000.0, -206310, 'Cash', NULL, 'New Finance', NULL),
('2bb6969c', '2026-04-14', 'Customer_Loan_Prin_Repayment', 'New-STL221-New-74-Tharun Tex-100000', 'New-STL221', 'New-74', 'Tharun Tex', 'New-74', 40000.0, NULL, -166310, 'Cash', NULL, 'New Finance', '280'),
('010b5a30', '2026-04-15', 'Customer_Loan_Prin_Repayment', 'New-STL67-New-6-Pradeep-150000', 'New-STL67', 'New-6', 'Pradeep', 'New-6', 60000.0, NULL, -106310, 'Cash', 'By arul', 'New Finance', '2940,1960,3260,2170'),
('2f67ea5e', '2026-03-31', 'Customer_Loan_Prin_Repayment', 'New-STL78-New-126-Dinesh-10000', 'New-STL78', 'New-126', 'Dinesh', 'New-126', 10000.0, NULL, -96310, 'Cash', NULL, 'New Finance', '660'),
('ffe7c25b', '2026-04-09', 'Customer_Loan_Prin_Repayment', 'New-STL280-New-38-Sabarish-200000', 'New-STL280', 'New-38', 'Sabarish', 'New-38', 200000.0, NULL, 103690, 'Cash', NULL, 'New Finance', '4340,970'),
('af0b08ec', '2026-04-16', 'Customer_Loan_Prin_Repayment', 'New-STL235-New-36-Kannan-215000', 'New-STL235', 'New-36', 'Kannan', 'New-36', 115000.0, NULL, 218690, 'Cash', NULL, 'New Finance', '4210,4670'),
('4cb1b97d', '2026-04-17', 'Loan_To_Customer', 'Loan_To_Customer-New-STL275-Balasubramani Suresh', 'New-STL275', 'New-131', 'Balasubramani Suresh', 'Loan to Customer', NULL, 50000.0, 168690, 'UPI', '55000 sent.', 'New Finance', NULL),
('b053d923', '2026-04-17', 'Customer_Loan_Prin_Repayment', 'New-STL195-New-50-Manikandan-50000', 'New-STL195', 'New-50', 'Manikandan', 'New-50', 40000.0, NULL, 208690, 'Cash', NULL, 'New Finance', '980,1090'),
('24bf93ea', '2026-04-17', 'Customer_Loan_Prin_Repayment', 'New-STL67-New-6-Pradeep-90000', 'New-STL67', 'New-6', 'Pradeep', 'New-6', 40000.0, NULL, 248690, 'Account', NULL, 'New Finance', '2940,1960,3260,2170,630'),
('748592fa', '2026-04-18', 'Loan_To_Customer', 'Loan_To_Customer-New-STL271-Sundaravadivel', 'New-STL271', 'New-132', 'Sundaravadivel', 'Loan to Customer', NULL, 50000.0, 198690, 'Cash', NULL, 'New Finance', NULL),
('0ba1559d', '2026-04-19', 'Customer_Loan_Prin_Repayment', 'New-STL67-New-6-Pradeep-90000', 'New-STL67', 'New-6', 'Pradeep', 'New-6', 50000.0, NULL, 248690, 'Cash', NULL, 'New Finance', '2940,1960,3260,2170,630'),
('780faf2e', '2026-04-20', 'Loan_To_Customer', 'Loan_To_Customer-New-STL338-Kaviraj', 'New-STL338', 'New-133', 'Kaviraj', 'Loan to Customer', NULL, 50000.0, 198690, 'Cash', NULL, 'New Finance', NULL),
('5b37804d', '2026-04-21', 'Customer_Loan_Prin_Repayment', 'New-STL270-New-3-Arul S-100000', 'New-STL270', 'New-3', 'Arul S', 'New-3', 30000.0, NULL, 228690, 'Cash', NULL, 'New Finance', '1230,110,2170'),
('e7142588', '2026-04-25', 'Loan_To_Customer', 'Loan_To_Customer-New-STL306-Ravi', 'New-STL306', 'New-134', 'Ravi', 'Loan to Customer', NULL, 20000.0, 208690, 'Cash', NULL, 'New Finance', NULL),
('70b7d405', '2026-04-27', 'Loan_To_Customer', 'Loan_To_Customer-New-STL339-Surya Shed', 'New-STL339', 'New-135', 'Surya Shed', 'Loan to Customer', NULL, 120000.0, 88690, 'Cash', NULL, 'New Finance', NULL),
('ed72fb67', '2026-04-30', 'Loan_To_Customer', 'Loan_To_Customer-New-STL339-Surya Shed', 'New-STL339', 'New-136', 'Surya Shed', 'Loan to Customer', NULL, 20000.0, 68690, 'UPI', 'Tharun sent 35k, 15k return to koli kodumudi', 'New Finance', NULL),
('a7e08bf9', '2026-04-29', 'Customer_Loan_Prin_Repayment', 'New-STL303-New-66-Tharun-70000', 'New-STL303', 'New-66', 'Tharun', 'New-66', 35000.0, NULL, 103690, 'UPI', 'sent to surya shed', 'New Finance', '780'),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-03-2026-ca9f230c', '2026-04-17', 'Customer_Interest', 'Sankara Narayanan-New-STL179-New-1-300000-Interest-03-2026', 'New-STL179', 'New-1', 'Sankara Narayanan', 'Interest-03-2026', 6510.0, 0.0, 110200, NULL, NULL, 'New Finance', '6510.0'),
('Ramesh-New-STL257-New-2-30000-Interest-03-2026-74fc2b07', '2026-04-13', 'Customer_Interest', 'Ramesh-New-STL257-New-2-30000-Interest-03-2026', 'New-STL257', 'New-2', 'Ramesh', 'Interest-03-2026', 750.0, 0.0, 110950, NULL, NULL, 'New Finance', '750.0'),
('Arul S-New-STL270-New-3-150000-Interest-02-2026-94fecb49', '2026-04-17', 'Customer_Interest', 'Arul S-New-STL270-New-3-150000-Interest-02-2026', 'New-STL270', 'New-3', 'Arul S', 'Interest-02-2026', 1230.0, 0.0, 112180, NULL, NULL, 'New Finance', '1230.0'),
('Arul S-New-STL270-New-3-50000-Interest-03-2026-94fecb49', '2026-04-17', 'Customer_Interest', 'Arul S-New-STL270-New-3-50000-Interest-03-2026', 'New-STL270', 'New-3', 'Arul S', 'Interest-03-2026', 110.0, 0.0, 112290, NULL, NULL, 'New Finance', '110.0'),
('Arul S-New-STL270-New-3-100000-Interest-03-2026-94fecb49', '2026-04-17', 'Customer_Interest', 'Arul S-New-STL270-New-3-100000-Interest-03-2026', 'New-STL270', 'New-3', 'Arul S', 'Interest-03-2026', 2170.0, 0.0, 114460, NULL, NULL, 'New Finance', '2170.0'),
('Rangis-New-STL295-New-4-100000-Interest-03-2026-eb5fb556', '2026-04-09', 'Customer_Interest', 'Rangis-New-STL295-New-4-100000-Interest-03-2026', 'New-STL295', 'New-4', 'Rangis', 'Interest-03-2026', 2170.0, 0.0, 116630, NULL, NULL, 'New Finance', '2170.0'),
('Mani Basketball-New-STL333-New-61-150000-Interest-03-2026-1274cef5', '2026-04-06', 'Customer_Interest', 'Mani Basketball-New-STL333-New-61-150000-Interest-03-2026', 'New-STL333', 'New-61', 'Mani Basketball', 'Interest-03-2026', 2940.0, 0.0, 119570, NULL, NULL, 'New Finance', '2940.0'),
('RanjithKumar-New-STL319-New-72-200000-Interest-03-2026-a26f3f93', '2026-04-08', 'Customer_Interest', 'RanjithKumar-New-STL319-New-72-200000-Interest-03-2026', 'New-STL319', 'New-72', 'RanjithKumar', 'Interest-03-2026', 840.0, 0.0, 120410, NULL, NULL, 'New Finance', '840.0'),
('Pradeep-New-STL67-New-6-150000-Interest-02-2026-8ee4ed96', '2026-04-17', 'Customer_Interest', 'Pradeep-New-STL67-New-6-150000-Interest-02-2026', 'New-STL67', 'New-6', 'Pradeep', 'Interest-02-2026', 2940.0, 0.0, 123350, NULL, NULL, 'New Finance', '2940.0'),
('Pradeep-New-STL67-New-6-150000-Interest-03-2026-8ee4ed96', '2026-04-17', 'Customer_Interest', 'Pradeep-New-STL67-New-6-150000-Interest-03-2026', 'New-STL67', 'New-6', 'Pradeep', 'Interest-03-2026', 3260.0, 0.0, 126610, NULL, NULL, 'New Finance', '3260.0'),
('Ramasamy Divya-New-STL156-New-7-50000-Interest-02-2026-fee36e3a', '2026-04-18', 'Customer_Interest', 'Ramasamy Divya-New-STL156-New-7-50000-Interest-02-2026', 'New-STL156', 'New-7', 'Ramasamy Divya', 'Interest-02-2026', 980.0, 0.0, 127590, NULL, NULL, 'New Finance', '980.0'),
('Sundaravadivel-New-STL271-New-9-50000-Interest-03-2026-4ee1ddb6', '2026-04-10', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-9-50000-Interest-03-2026', 'New-STL271', 'New-9', 'Sundaravadivel', 'Interest-03-2026', 1090.0, 0.0, 128680, NULL, NULL, 'New Finance', '1090.0'),
('Balasubramani Suresh-New-STL275-New-10-200000-Interest-02-2026-5be512e5', '2026-04-08', 'Customer_Interest', 'Balasubramani Suresh-New-STL275-New-10-200000-Interest-02-2026', 'New-STL275', 'New-10', 'Balasubramani Suresh', 'Interest-02-2026', 3920.0, 0.0, 132600, NULL, NULL, 'New Finance', '3920.0'),
('Balasubramani Suresh-New-STL275-New-10-200000-Interest-03-2026-5be512e5', '2026-04-08', 'Customer_Interest', 'Balasubramani Suresh-New-STL275-New-10-200000-Interest-03-2026', 'New-STL275', 'New-10', 'Balasubramani Suresh', 'Interest-03-2026', 4340.0, 0.0, 136940, NULL, NULL, 'New Finance', '4340.0'),
('Balasubramani Suresh-New-STL275-New-64-50000-Interest-03-2026-5be512e5', '2026-04-08', 'Customer_Interest', 'Balasubramani Suresh-New-STL275-New-64-50000-Interest-03-2026', 'New-STL275', 'New-64', 'Balasubramani Suresh', 'Interest-03-2026', 700.0, 0.0, 137640, NULL, NULL, 'New Finance', '700.0'),
('Priya-New-STL320-New-65-100000-Interest-03-2026-7405a6ae', '2026-04-05', 'Customer_Interest', 'Priya-New-STL320-New-65-100000-Interest-03-2026', 'New-STL320', 'New-65', 'Priya', 'Interest-03-2026', 1260.0, 0.0, 138900, NULL, NULL, 'New Finance', '1260.0'),
('Arul M-New-STL330-New-13-35000-Interest-02-2026-d9b71cbc', '2026-04-17', 'Customer_Interest', 'Arul M-New-STL330-New-13-35000-Interest-02-2026', 'New-STL330', 'New-13', 'Arul M', 'Interest-02-2026', 780.0, 0.0, 139680, NULL, NULL, 'New Finance', '780.0'),
('Arul M-New-STL330-New-13-35000-Interest-03-2026-d9b71cbc', '2026-04-17', 'Customer_Interest', 'Arul M-New-STL330-New-13-35000-Interest-03-2026', 'New-STL330', 'New-13', 'Arul M', 'Interest-03-2026', 870.0, 0.0, 140550, NULL, NULL, 'New Finance', '870.0'),
('Arul M-New-STL330-New-62-15000-Interest-03-2026-d9b71cbc', '2026-04-17', 'Customer_Interest', 'Arul M-New-STL330-New-62-15000-Interest-03-2026', 'New-STL330', 'New-62', 'Arul M', 'Interest-03-2026', 260.0, 0.0, 140810, NULL, NULL, 'New Finance', '260.0'),
('Arul M-New-STL330-New-68-50000-Interest-03-2026-d9b71cbc', '2026-04-17', 'Customer_Interest', 'Arul M-New-STL330-New-68-50000-Interest-03-2026', 'New-STL330', 'New-68', 'Arul M', 'Interest-03-2026', 49.0, 0.0, 140859, NULL, NULL, 'New Finance', '49.0'),
('John-New-STL292-New-14-150000-Interest-03-2026-221693f0', '2026-04-30', 'Customer_Interest', 'John-New-STL292-New-14-150000-Interest-03-2026', 'New-STL292', 'New-14', 'John', 'Interest-03-2026', 3260.0, 0.0, 144119, 'UPI', NULL, 'New Finance', '3260.0'),
('Praveen Ram-New-STL324-New-16-80000-Interest-03-2026-112d3dd5', '2026-04-08', 'Customer_Interest', 'Praveen Ram-New-STL324-New-16-80000-Interest-03-2026', 'New-STL324', 'New-16', 'Praveen Ram', 'Interest-03-2026', 1740.0, 0.0, 145859, NULL, NULL, 'New Finance', '1740.0'),
('Viji Vasanth-New-STL313-New-67-250000-Interest-03-2026-6d5612c5', '2026-04-04', 'Customer_Interest', 'Viji Vasanth-New-STL313-New-67-250000-Interest-03-2026', 'New-STL313', 'New-67', 'Viji Vasanth', 'Interest-03-2026', 2620.0, 0.0, 148479, NULL, NULL, 'New Finance', '2620.0'),
('Sabarish-New-STL280-New-38-200000-Interest-03-2026-6d69e9c3', '2026-04-05', 'Customer_Interest', 'Sabarish-New-STL280-New-38-200000-Interest-03-2026', 'New-STL280', 'New-38', 'Sabarish', 'Interest-03-2026', 4340.0, 0.0, 152819, NULL, NULL, 'New Finance', '4340.0'),
('Sabarish-New-STL280-New-63-60000-Interest-03-2026-6d69e9c3', '2026-04-05', 'Customer_Interest', 'Sabarish-New-STL280-New-63-60000-Interest-03-2026', 'New-STL280', 'New-63', 'Sabarish', 'Interest-03-2026', 970.0, 0.0, 153789, NULL, NULL, 'New Finance', '970.0'),
('Dinesh-New-STL78-New-19-30000-Interest-03-2026-ad6d6b5e', '2026-04-01', 'Customer_Interest', 'Dinesh-New-STL78-New-19-30000-Interest-03-2026', 'New-STL78', 'New-19', 'Dinesh', 'Interest-03-2026', 660.0, 0.0, 154449, NULL, NULL, 'New Finance', '660.0'),
('Boopathy Crane-New-STL217-New-22-30000-Interest-03-2026-79a2d6f8', '2026-04-15', 'Customer_Interest', 'Boopathy Crane-New-STL217-New-22-30000-Interest-03-2026', 'New-STL217', 'New-22', 'Boopathy Crane', 'Interest-03-2026', 750.0, 0.0, 155199, NULL, NULL, 'New Finance', '750.0'),
('Yagappan-New-STL278-New-25-20000-Interest-03-2026-cf0d7886', '2026-04-07', 'Customer_Interest', 'Yagappan-New-STL278-New-25-20000-Interest-03-2026', 'New-STL278', 'New-25', 'Yagappan', 'Interest-03-2026', 500.0, 0.0, 155699, NULL, NULL, 'New Finance', '500.0'),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-03-2026-cc741ce4', '2026-04-03', 'Customer_Interest', 'Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-03-2026', 'New-STL304', 'New-26', 'Sakthivel Jayaraj', 'Interest-03-2026', 2170.0, 0.0, 157869, NULL, NULL, 'New Finance', '2170.0'),
('Mahesh-New-STL308-New-27-50000-Interest-03-2026-64a517f3', '2026-04-22', 'Customer_Interest', 'Mahesh-New-STL308-New-27-50000-Interest-03-2026', 'New-STL308', 'New-27', 'Mahesh', 'Interest-03-2026', 1090.0, 0.0, 158959, NULL, NULL, 'New Finance', '1090.0'),
('Kaviyarasu Arul-New-STL323-New-28-50000-Interest-03-2026-c853a467', '2026-04-14', 'Customer_Interest', 'Kaviyarasu Arul-New-STL323-New-28-50000-Interest-03-2026', 'New-STL323', 'New-28', 'Kaviyarasu Arul', 'Interest-03-2026', 870.0, 0.0, 159829, NULL, NULL, 'New Finance', '870.0'),
('Kaviyarasu Arul-New-STL323-New-28-750000-Interest-03-2026-c853a467', '2026-04-14', 'Customer_Interest', 'Kaviyarasu Arul-New-STL323-New-28-750000-Interest-03-2026', 'New-STL323', 'New-28', 'Kaviyarasu Arul', 'Interest-03-2026', 16280.0, 0.0, 176109, NULL, NULL, 'New Finance', '16280.0'),
('Rajendran-New-STL58-New-30-15000-Interest-03-2026-d1c4cbec', '2026-04-17', 'Customer_Interest', 'Rajendran-New-STL58-New-30-15000-Interest-03-2026', 'New-STL58', 'New-30', 'Rajendran', 'Interest-03-2026', 370.0, 0.0, 176479, NULL, NULL, 'New Finance', '370.0'),
('Vinoth-New-STL262-New-32-50000-Interest-03-2026-e46d83a1', '2026-04-17', 'Customer_Interest', 'Vinoth-New-STL262-New-32-50000-Interest-03-2026', 'New-STL262', 'New-32', 'Vinoth', 'Interest-03-2026', 1090.0, 0.0, 177569, NULL, NULL, 'New Finance', '1090.0'),
('Ashok-New-STL282-New-33-15000-Interest-03-2026-738d5bf9', '2026-04-17', 'Customer_Interest', 'Ashok-New-STL282-New-33-15000-Interest-03-2026', 'New-STL282', 'New-33', 'Ashok', 'Interest-03-2026', 370.0, 0.0, 177939, NULL, NULL, 'New Finance', '370.0'),
('Mariyammal-New-STL297-New-34-100000-Interest-03-2026-6ae0bde3', '2026-04-08', 'Customer_Interest', 'Mariyammal-New-STL297-New-34-100000-Interest-03-2026', 'New-STL297', 'New-34', 'Mariyammal', 'Interest-03-2026', 2170.0, 0.0, 180109, NULL, NULL, 'New Finance', '2170.0'),
('Ramkumar-New-STL231-New-35-200000-Interest-03-2026-34e758b4', '2026-04-17', 'Customer_Interest', 'Ramkumar-New-STL231-New-35-200000-Interest-03-2026', 'New-STL231', 'New-35', 'Ramkumar', 'Interest-03-2026', 4340.0, 0.0, 184449, NULL, NULL, 'New Finance', '4340.0'),
('Ramkumar-New-STL231-New-69-100000-Interest-03-2026-34e758b4', '2026-04-17', 'Customer_Interest', 'Ramkumar-New-STL231-New-69-100000-Interest-03-2026', 'New-STL231', 'New-69', 'Ramkumar', 'Interest-03-2026', 840.0, 0.0, 185289, NULL, NULL, 'New Finance', '840.0'),
('Ramkumar-New-STL231-New-71-130000-Interest-03-2026-34e758b4', '2026-04-17', 'Customer_Interest', 'Ramkumar-New-STL231-New-71-130000-Interest-03-2026', 'New-STL231', 'New-71', 'Ramkumar', 'Interest-03-2026', 730.0, 0.0, 186019, NULL, NULL, 'New Finance', '730.0'),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-03-2026-ea94fbbd', '2026-04-17', 'Customer_Interest', 'Sakthivel Broker-New-STL263-New-37-100000-Interest-03-2026', 'New-STL263', 'New-37', 'Sakthivel Broker', 'Interest-03-2026', 2170.0, 0.0, 188189, NULL, NULL, 'New Finance', '2170.0'),
('Moorthy-New-STL312-New-39-50000-Interest-03-2026-61dcf33b', '2026-04-17', 'Customer_Interest', 'Moorthy-New-STL312-New-39-50000-Interest-03-2026', 'New-STL312', 'New-39', 'Moorthy', 'Interest-03-2026', 1090.0, 0.0, 189279, NULL, NULL, 'New Finance', '1090.0'),
('Shanmugam-New-STL139-New-40-30000-Interest-03-2026-d140787b', '2026-04-10', 'Customer_Interest', 'Shanmugam-New-STL139-New-40-30000-Interest-03-2026', 'New-STL139', 'New-40', 'Shanmugam', 'Interest-03-2026', 740.0, 0.0, 190019, NULL, NULL, 'New Finance', '740.0'),
('Ramprakash-New-STL234-New-42-55000-Interest-03-2026-2040784c', '2026-04-17', 'Customer_Interest', 'Ramprakash-New-STL234-New-42-55000-Interest-03-2026', 'New-STL234', 'New-42', 'Ramprakash', 'Interest-03-2026', 1200.0, 0.0, 191219, NULL, NULL, 'New Finance', '1200.0'),
('Ravi-New-STL306-New-45-100000-Interest-03-2026-491f7131', '2026-04-17', 'Customer_Interest', 'Ravi-New-STL306-New-45-100000-Interest-03-2026', 'New-STL306', 'New-45', 'Ravi', 'Interest-03-2026', 1890.0, 0.0, 193109, NULL, NULL, 'New Finance', '1890.0'),
('Ravi-New-STL306-New-45-25000-Interest-03-2026-491f7131', '2026-04-17', 'Customer_Interest', 'Ravi-New-STL306-New-45-25000-Interest-03-2026', 'New-STL306', 'New-45', 'Ravi', 'Interest-03-2026', 530.0, 0.0, 193639, NULL, NULL, 'New Finance', '530.0'),
('Ravi-New-STL306-New-45-75000-Interest-03-2026-491f7131', '2026-04-17', 'Customer_Interest', 'Ravi-New-STL306-New-45-75000-Interest-03-2026', 'New-STL306', 'New-45', 'Ravi', 'Interest-03-2026', 1630.0, 0.0, 195269, NULL, NULL, 'New Finance', '1630.0'),
('Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-03-2026-e21d0c3b', '2026-04-10', 'Customer_Interest', 'Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-03-2026', 'New-STL334', 'New-73', 'Vignesh Arun Kumba', 'Interest-03-2026', 280.0, 0.0, 195549, NULL, NULL, 'New Finance', '280.0'),
('Tharun Tex-New-STL221-New-74-100000-Interest-03-2026-716bd2b6', '2026-04-06', 'Customer_Interest', 'Tharun Tex-New-STL221-New-74-100000-Interest-03-2026', 'New-STL221', 'New-74', 'Tharun Tex', 'Interest-03-2026', 280.0, 0.0, 195829, NULL, NULL, 'New Finance', '280.0'),
('Logambal-New-STL283-New-52-50000-Interest-03-2026-b50e5250', '2026-04-06', 'Customer_Interest', 'Logambal-New-STL283-New-52-50000-Interest-03-2026', 'New-STL283', 'New-52', 'Logambal', 'Interest-03-2026', 1090.0, 0.0, 196919, NULL, NULL, 'New Finance', '1610.0'),
('Muniyappan-New-STL150-New-54-100000-Interest-03-2026-092692a0', '2026-04-13', 'Customer_Interest', 'Muniyappan-New-STL150-New-54-100000-Interest-03-2026', 'New-STL150', 'New-54', 'Muniyappan', 'Interest-03-2026', 2170.0, 0.0, 199089, NULL, NULL, 'New Finance', '2170.0'),
('Nandhakumar-New-STL227-New-56-100000-Interest-03-2026-ea521a30', '2026-04-13', 'Customer_Interest', 'Nandhakumar-New-STL227-New-56-100000-Interest-03-2026', 'New-STL227', 'New-56', 'Nandhakumar', 'Interest-03-2026', 2170.0, 0.0, 201259, NULL, NULL, 'New Finance', '2170.0'),
('Vignesh-New-STL260-New-57-100000-Interest-03-2026-4a17b826', '2026-04-06', 'Customer_Interest', 'Vignesh-New-STL260-New-57-100000-Interest-03-2026', 'New-STL260', 'New-57', 'Vignesh', 'Interest-03-2026', 2170.0, 0.0, 203429, NULL, NULL, 'New Finance', '2170.0'),
('Anand-New-STL274-New-58-20000-Interest-03-2026-15d052e0', '2026-04-20', 'Customer_Interest', 'Anand-New-STL274-New-58-20000-Interest-03-2026', 'New-STL274', 'New-58', 'Anand', 'Interest-03-2026', 500.0, 0.0, 203929, NULL, NULL, 'New Finance', '500.0'),
('Subramani-New-STL287-New-59-150000-Interest-03-2026-3ee69c67', '2026-04-13', 'Customer_Interest', 'Subramani-New-STL287-New-59-150000-Interest-03-2026', 'New-STL287', 'New-59', 'Subramani', 'Interest-03-2026', 3260.0, 0.0, 207189, NULL, NULL, 'New Finance', '3260.0'),
('Nagurammal-New-STL331-New-60-150000-Interest-03-2026-504081af', '2026-04-02', 'Customer_Interest', 'Nagurammal-New-STL331-New-60-150000-Interest-03-2026', 'New-STL331', 'New-60', 'Nagurammal', 'Interest-03-2026', 3260.0, 0.0, 210449, NULL, NULL, 'New Finance', '3260.0'),
('Nagaraj Post-New-STL301-New-11-30000-Interest-02-2026-e2ea7703', '2026-03-01', 'Customer_Interest', 'Nagaraj Post-New-STL301-New-11-30000-Interest-02-2026', 'New-STL301', 'New-11', 'Nagaraj Post', 'Interest-02-2026', 590.0, 0.0, 211039, NULL, NULL, 'New Finance', '590.0'),
('Jayapal-New-STL121-New-20-100000-Interest-02-2026-e1177213', '2026-04-17', 'Customer_Interest', 'Jayapal-New-STL121-New-20-100000-Interest-02-2026', 'New-STL121', 'New-20', 'Jayapal', 'Interest-02-2026', 1960.0, 0.0, 212999, NULL, NULL, 'New Finance', '1960.0'),
('Danendran-New-STL46-New-29-95000-Interest-02-2026-8fa7dffc', '2026-04-17', 'Customer_Interest', 'Danendran-New-STL46-New-29-95000-Interest-02-2026', 'New-STL46', 'New-29', 'Danendran', 'Interest-02-2026', 1860.0, 0.0, 214859, NULL, 'prakash cover', 'New Finance', '1860.0'),
('Kannan-New-STL235-New-36-215000-Interest-02-2026-966f03e5', '2026-04-17', 'Customer_Interest', 'Kannan-New-STL235-New-36-215000-Interest-02-2026', 'New-STL235', 'New-36', 'Kannan', 'Interest-02-2026', 4210.0, 0.0, 219069, NULL, 'cover kannan', 'New Finance', '4210.0'),
('Selvaguru-New-STL35-New-46-150000-Interest-02-2026-28f8d731', '2026-04-29', 'Customer_Interest', 'Selvaguru-New-STL35-New-46-150000-Interest-02-2026', 'New-STL35', 'New-46', 'Selvaguru', 'Interest-02-2026', 2740.0, 0.0, 221809, NULL, NULL, 'New Finance', '2740.0'),
('Vasudevan-New-STL116-New-47-450000-Interest-02-2026-4c67514d', '2026-04-17', 'Customer_Interest', 'Vasudevan-New-STL116-New-47-450000-Interest-02-2026', 'New-STL116', 'New-47', 'Vasudevan', 'Interest-02-2026', 8820.0, 0.0, 230629, 'Cash', 'cover', 'New Finance', '8820.0'),
('Paramasivam-New-STL153-New-48-35000-Interest-02-2026-094b7eef', '2026-04-17', 'Customer_Interest', 'Paramasivam-New-STL153-New-48-35000-Interest-02-2026', 'New-STL153', 'New-48', 'Paramasivam', 'Interest-02-2026', 780.0, 0.0, 231409, NULL, NULL, 'New Finance', '780.0'),
('Karthick-New-STL185-New-49-20000-Interest-02-2026-105a8cb3', '2026-04-17', 'Customer_Interest', 'Karthick-New-STL185-New-49-20000-Interest-02-2026', 'New-STL185', 'New-49', 'Karthick', 'Interest-02-2026', 450.0, 0.0, 231859, NULL, NULL, 'New Finance', '450.0'),
('Manikandan-New-STL195-New-50-50000-Interest-02-2026-5d941349', '2026-04-17', 'Customer_Interest', 'Manikandan-New-STL195-New-50-50000-Interest-02-2026', 'New-STL195', 'New-50', 'Manikandan', 'Interest-02-2026', 980.0, 0.0, 232839, NULL, NULL, 'New Finance', '980.0'),
('Pradeep-New-STL123-New-51-100000-Interest-02-2026-8d4c791a', '2026-04-17', 'Customer_Interest', 'Pradeep-New-STL123-New-51-100000-Interest-02-2026', 'New-STL123', 'New-51', 'Pradeep_NPA', 'Interest-02-2026', 1960.0, 0.0, 234799, NULL, NULL, 'New Finance', '1960.0'),
('Manivannan-New-STL182-New-41-300000-Interest-02-2026-349b0ffe', '2026-05-02', 'Customer_Interest', 'Manivannan-New-STL182-New-41-300000-Interest-02-2026', 'New-STL182', 'New-41', 'Manivannan', 'Interest-02-2026', 5880.0, 0.0, 240679, 'UPI', NULL, 'New Finance', '5880.0'),
('Manivannan-New-STL182-New-41-300000-Interest-03-2026-349b0ffe', '2026-05-02', 'Customer_Interest', 'Manivannan-New-STL182-New-41-300000-Interest-03-2026', 'New-STL182', 'New-41', 'Manivannan', 'Interest-03-2026', 6510.0, 0.0, 247189, 'UPI', NULL, 'New Finance', '6510.0'),
('Surya Shed-New-STL339-New-135-120000-Interest-04-2026-d9dbf363', '2026-05-02', 'Customer_Interest', 'Surya Shed-New-STL339-New-135-120000-Interest-04-2026', 'New-STL339', 'New-135', 'Surya Shed', 'Interest-04-2026', 340.0, 0.0, 247529, 'UPI', NULL, 'New Finance', '340.0'),
('Surya Shed-New-STL339-New-136-20000-Interest-04-2026-d9dbf363', '2026-05-02', 'Customer_Interest', 'Surya Shed-New-STL339-New-136-20000-Interest-04-2026', 'New-STL339', 'New-136', 'Surya Shed', 'Interest-04-2026', 10.0, 0.0, 247539, 'UPI', NULL, 'New Finance', '10.0'),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-04-2026-2db89887', '2026-05-02', 'Customer_Interest', 'Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-04-2026', 'New-STL304', 'New-26', 'Sakthivel Jayaraj', 'Interest-04-2026', 2100.0, 0.0, 249639, 'UPI', NULL, 'New Finance', '2100.0'),
('3e5d410a', '2026-05-01', 'Loan_To_Customer', 'Loan_To_Customer-New-STL318-Divakar', 'New-STL318', 'New-137', 'Divakar', 'Loan to Customer', NULL, 10000.0, 239639, 'Cash', NULL, 'New Finance', NULL),
('f55a5ad0', '2026-04-30', 'Customer_Loan_Prin_Repayment', 'New-STL116-New-47-Vasudevan-450000', 'New-STL116', 'New-47', 'Vasudevan', 'New-47', 10000.0, NULL, 249639, NULL, 'Divagar loan exchange', 'New Finance', '9770,9450'),
('3963593a', '2026-05-05', 'Loan_To_Customer', 'Loan_To_Customer-New-STL235-Kannan', 'New-STL235', 'New-138', 'Kannan', 'Loan to Customer', NULL, 200000.0, 49639, 'Cash', NULL, 'New Finance', NULL);
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('303de929', '2026-06-03', 'Customer_Loan_Prin_Repayment', 'New-STL221-New-74-Tharun Tex-60000', 'New-STL221', 'New-74', 'Tharun Tex', 'New-74', 10000.0, NULL, 59639, NULL, NULL, 'New Finance', '390,1260'),
('8da8466d', '2026-06-03', 'Customer_Loan_Prin_Repayment', 'New-STL283-New-52-Logambal-50000', 'New-STL283', 'New-52', 'Logambal', 'New-52', 20000.0, NULL, 79639, NULL, NULL, 'New Finance', '1050'),
('1288eed0', '2026-06-03', 'Customer_Loan_Prin_Repayment', 'New-STL320-New-65-Priya-100000', 'New-STL320', 'New-65', 'Priya', 'New-65', 80000.0, NULL, 159639, NULL, NULL, 'New Finance', '2100,2520'),
('05fcc140', '2026-06-03', 'Customer_Loan_Prin_Repayment', 'New-STL329-New-17-Kongu Kochai-150000', 'New-STL329', 'New-17', 'Kongu Kochai', 'New-17', 150000.0, NULL, 309639, NULL, NULL, 'New Finance', '4340,40,3150'),
('0cc860e1', '2026-06-03', 'Customer_Loan_Prin_Repayment', 'New-STL126-New-21-Udhayakumar-130000', 'New-STL126', 'New-21', 'Udhayakumar', 'New-21', 10000.0, NULL, 319639, NULL, NULL, 'New Finance', '210,2820,2730'),
('74d2e980', '2026-05-13', 'Loan_To_Customer', 'Loan_To_Customer-New-STL340-Bala kaarthi', 'New-STL340', 'New-139', 'Bala kaarthi', 'Loan to Customer', NULL, 200000.0, 119639, 'Cash', NULL, 'New Finance', NULL),
('f5bbea37', '2026-05-12', 'Customer_Loan_Prin_Repayment', 'New-STL78-New-19-Dinesh-30000', 'New-STL78', 'New-19', 'Dinesh', 'New-19', 10000.0, NULL, 129639, NULL, NULL, 'New Finance', '630'),
('aa6aa719', '2026-05-14', 'Customer_Loan_Prin_Repayment', 'New-STL235-New-138-Kannan-200000', 'New-STL235', 'New-138', 'Kannan', 'New-138', 200000.0, NULL, 329639, NULL, NULL, 'New Finance', '4670,1290,2100'),
('eb21894f', '2026-05-15', 'Customer_Loan_Prin_Repayment', 'New-STL313-New-67-Viji Vasanth-250000', 'New-STL313', 'New-67', 'Viji Vasanth', 'New-67', 100000.0, NULL, 429639, 'Account', 'Axis', 'New Finance', '5250'),
('cb4505fc', '2026-05-16', 'Loan_To_Customer', 'Loan_To_Customer-New-STL320-Priya', 'New-STL320', 'New-140', 'Priya', 'Loan to Customer', NULL, 150000.0, 279639, 'Cash', NULL, 'New Finance', NULL),
('030985a0', '2026-05-18', 'Customer_Loan_Prin_Repayment', 'New-STL78-New-19-Dinesh-20000', 'New-STL78', 'New-19', 'Dinesh', 'New-19', 10000.0, NULL, 289639, NULL, NULL, 'New Finance', '630,80'),
('17c9b428', '2026-05-21', 'Customer_Loan_Prin_Repayment', 'New-STL283-New-52-Logambal-30000', 'New-STL283', 'New-52', 'Logambal', 'New-52', 30000.0, NULL, 319639, NULL, NULL, 'New Finance', '1050,40'),
('85da0c85', '2026-05-22', 'Customer_Loan_Prin_Repayment', 'New-STL338-New-133-Kaviraj-50000', 'New-STL338', 'New-133', 'Kaviraj', 'New-133', 40000.0, NULL, 359639, NULL, '41,000 gave', 'New Finance', '390'),
('eed284e2', '2026-05-22', 'Customer_Loan_Prin_Repayment', 'New-STL320-New-140-Priya-150000', 'New-STL320', 'New-140', 'Priya', 'New-140', 150000.0, NULL, 509639, NULL, NULL, 'New Finance', '2100,2520,170'),
('d6f5c875', '2026-05-24', 'Customer_Loan_Prin_Repayment', 'New-STL227-New-56-Nandhakumar-100000', 'New-STL227', 'New-56', 'Nandhakumar', 'New-56', 100000.0, NULL, 609639, NULL, NULL, 'New Finance', '2100,2520'),
('5ad7d7b9', '2026-05-28', 'Loan_To_Customer', 'Loan_To_Customer-New-STL341-Murugesan pons', 'New-STL341', 'New-141', 'Murugesan pons', 'Loan to Customer', NULL, 80000.0, 529639, 'Cash', NULL, 'New Finance', NULL),
('69737f29', '2026-05-25', 'Loan_To_Customer', 'Loan_To_Customer-New-STL342-Jeyaraj pons', 'New-STL342', 'New-142', 'Jeyaraj pons', 'Loan to Customer', NULL, 50000.0, 479639, 'Cash', NULL, 'New Finance', NULL),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-04-2026-faf3a0df', '2026-05-14', 'Customer_Interest', 'Sankara Narayanan-New-STL179-New-1-300000-Interest-04-2026', 'New-STL179', 'New-1', 'Sankara Narayanan', 'Interest-04-2026', 6300.0, 0.0, 485939, NULL, NULL, 'New Finance', '6300.0'),
('Ramesh-New-STL257-New-2-30000-Interest-04-2026-cb598a6f', '2026-05-15', 'Customer_Interest', 'Ramesh-New-STL257-New-2-30000-Interest-04-2026', 'New-STL257', 'New-2', 'Ramesh', 'Interest-04-2026', 720.0, 0.0, 486659, NULL, NULL, 'New Finance', '720.0'),
('Arul S-New-STL270-New-3-30000-Interest-04-2026-6d4f18f9', '2026-05-19', 'Customer_Interest', 'Arul S-New-STL270-New-3-30000-Interest-04-2026', 'New-STL270', 'New-3', 'Arul S', 'Interest-04-2026', 440.0, 0.0, 487099, NULL, NULL, 'New Finance', '440.0'),
('Arul S-New-STL270-New-3-70000-Interest-04-2026-6d4f18f9', '2026-05-19', 'Customer_Interest', 'Arul S-New-STL270-New-3-70000-Interest-04-2026', 'New-STL270', 'New-3', 'Arul S', 'Interest-04-2026', 1470.0, 0.0, 488569, NULL, NULL, 'New Finance', '1470.0'),
('Rangis-New-STL295-New-4-100000-Interest-04-2026-df9c9b09', '2026-05-08', 'Customer_Interest', 'Rangis-New-STL295-New-4-100000-Interest-04-2026', 'New-STL295', 'New-4', 'Rangis', 'Interest-04-2026', 2100.0, 0.0, 490669, NULL, NULL, 'New Finance', '2100.0'),
('RanjithKumar-New-STL319-New-72-200000-Interest-04-2026-89c35e3a', '2026-05-12', 'Customer_Interest', 'RanjithKumar-New-STL319-New-72-200000-Interest-04-2026', 'New-STL319', 'New-72', 'RanjithKumar', 'Interest-04-2026', 4200.0, 0.0, 494869, NULL, NULL, 'New Finance', '4200.0'),
('Mani Basketball-New-STL333-New-61-150000-Interest-04-2026-7a411ff0', '2026-05-02', 'Customer_Interest', 'Mani Basketball-New-STL333-New-61-150000-Interest-04-2026', 'New-STL333', 'New-61', 'Mani Basketball', 'Interest-04-2026', 3150.0, 0.0, 498019, NULL, NULL, 'New Finance', '3150.0'),
('Sundaravadivel-New-STL271-New-9-50000-Interest-04-2026-84f973a3', '2026-05-11', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-9-50000-Interest-04-2026', 'New-STL271', 'New-9', 'Sundaravadivel', 'Interest-04-2026', 1050.0, 0.0, 499069, NULL, NULL, 'New Finance', '1050.0'),
('Sundaravadivel-New-STL271-New-132-50000-Interest-04-2026-84f973a3', '2026-05-11', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-132-50000-Interest-04-2026', 'New-STL271', 'New-132', 'Sundaravadivel', 'Interest-04-2026', 460.0, 0.0, 499529, NULL, NULL, 'New Finance', '460.0'),
('Balasubramani Suresh-New-STL275-New-10-200000-Interest-04-2026-0dfd1562', '2026-05-07', 'Customer_Interest', 'Balasubramani Suresh-New-STL275-New-10-200000-Interest-04-2026', 'New-STL275', 'New-10', 'Balasubramani Suresh', 'Interest-04-2026', 4200.0, 0.0, 503729, NULL, NULL, 'New Finance', '4200.0'),
('Balasubramani Suresh-New-STL275-New-64-50000-Interest-04-2026-0dfd1562', '2026-05-07', 'Customer_Interest', 'Balasubramani Suresh-New-STL275-New-64-50000-Interest-04-2026', 'New-STL275', 'New-64', 'Balasubramani Suresh', 'Interest-04-2026', 1050.0, 0.0, 504779, NULL, NULL, 'New Finance', '1050.0'),
('Balasubramani Suresh-New-STL275-New-131-50000-Interest-04-2026-0dfd1562', '2026-05-07', 'Customer_Interest', 'Balasubramani Suresh-New-STL275-New-131-50000-Interest-04-2026', 'New-STL275', 'New-131', 'Balasubramani Suresh', 'Interest-04-2026', 490.0, 0.0, 505269, NULL, NULL, 'New Finance', '490.0'),
('Priya-New-STL320-New-65-100000-Interest-04-2026-f5d62083', '2026-05-07', 'Customer_Interest', 'Priya-New-STL320-New-65-100000-Interest-04-2026', 'New-STL320', 'New-65', 'Priya', 'Interest-04-2026', 2100.0, 0.0, 507369, NULL, NULL, 'New Finance', '2100.0'),
('Priya-New-STL320-New-130-200000-Interest-04-2026-f5d62083', '2026-05-07', 'Customer_Interest', 'Priya-New-STL320-New-130-200000-Interest-04-2026', 'New-STL320', 'New-130', 'Priya', 'Interest-04-2026', 2520.0, 0.0, 509889, NULL, NULL, 'New Finance', '2520.0'),
('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-04-2026-dc34a2f1', '2026-05-04', 'Customer_Interest', 'Manoj raghavendra shop-New-STL336-New-129-10000-Interest-04-2026', 'New-STL336', 'New-129', 'Manoj raghavendra shop', 'Interest-04-2026', 190.0, 0.0, 510079, NULL, NULL, 'New Finance', '190.0'),
('John-New-STL292-New-14-150000-Interest-04-2026-9ebec32b', '2026-05-27', 'Customer_Interest', 'John-New-STL292-New-14-150000-Interest-04-2026', 'New-STL292', 'New-14', 'John', 'Interest-04-2026', 3150.0, 0.0, 513229, NULL, NULL, 'New Finance', '3150.0'),
('Tharun-New-STL303-New-66-70000-Interest-03-2026-79930f26', '2026-05-19', 'Customer_Interest', 'Tharun-New-STL303-New-66-70000-Interest-03-2026', 'New-STL303', 'New-66', 'Tharun', 'Interest-03-2026', 780.0, 0.0, 514009, NULL, NULL, 'New Finance', '780.0'),
('Tharun-New-STL303-New-66-35000-Interest-04-2026-79930f26', '2026-05-19', 'Customer_Interest', 'Tharun-New-STL303-New-66-35000-Interest-04-2026', 'New-STL303', 'New-66', 'Tharun', 'Interest-04-2026', 670.0, 0.0, 514679, NULL, NULL, 'New Finance', '710.0'),
('Praveen Ram-New-STL324-New-16-80000-Interest-04-2026-5d977299', '2026-05-08', 'Customer_Interest', 'Praveen Ram-New-STL324-New-16-80000-Interest-04-2026', 'New-STL324', 'New-16', 'Praveen Ram', 'Interest-04-2026', 1680.0, 0.0, 516359, NULL, NULL, 'New Finance', '1680.0'),
('Viji Vasanth-New-STL313-New-67-250000-Interest-04-2026-516b4d1d', '2026-05-03', 'Customer_Interest', 'Viji Vasanth-New-STL313-New-67-250000-Interest-04-2026', 'New-STL313', 'New-67', 'Viji Vasanth', 'Interest-04-2026', 5250.0, 0.0, 521609, NULL, NULL, 'New Finance', '5250.0'),
('Dinesh-New-STL78-New-19-30000-Interest-04-2026-080b4837', '2026-05-07', 'Customer_Interest', 'Dinesh-New-STL78-New-19-30000-Interest-04-2026', 'New-STL78', 'New-19', 'Dinesh', 'Interest-04-2026', 420.0, 0.0, 522029, NULL, NULL, 'New Finance', '630.0'),
('Udhayakumar-New-STL126-New-21-50000-Interest-03-2026-458e7b5f', '2026-05-18', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-50000-Interest-03-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-03-2026', 210.0, 0.0, 522239, NULL, NULL, 'New Finance', '210.0'),
('Udhayakumar-New-STL126-New-21-130000-Interest-03-2026-458e7b5f', '2026-05-18', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-130000-Interest-03-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-03-2026', 2520.0, 0.0, 524759, NULL, NULL, 'New Finance', '2820.0'),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-02-2026-5af74f45', '2026-05-15', 'Customer_Interest', 'Suresh Abudhabi-New-STL273-New-23-60000-Interest-02-2026', 'New-STL273', 'New-23', 'Suresh Abudhabi', 'Interest-02-2026', 1180.0, 0.0, 525939, NULL, NULL, 'New Finance', '1180.0'),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-03-2026-5af74f45', '2026-05-15', 'Customer_Interest', 'Suresh Abudhabi-New-STL273-New-23-60000-Interest-03-2026', 'New-STL273', 'New-23', 'Suresh Abudhabi', 'Interest-03-2026', 80.0, 0.0, 526019, NULL, NULL, 'New Finance', '1300.0'),
('Yagappan-New-STL278-New-25-20000-Interest-04-2026-8dfd716a', '2026-05-18', 'Customer_Interest', 'Yagappan-New-STL278-New-25-20000-Interest-04-2026', 'New-STL278', 'New-25', 'Yagappan', 'Interest-04-2026', 480.0, 0.0, 526499, NULL, NULL, 'New Finance', '480.0'),
('Mahesh-New-STL308-New-27-50000-Interest-04-2026-dbc33f6c', '2026-05-15', 'Customer_Interest', 'Mahesh-New-STL308-New-27-50000-Interest-04-2026', 'New-STL308', 'New-27', 'Mahesh', 'Interest-04-2026', 1050.0, 0.0, 527549, NULL, NULL, 'New Finance', '1050.0'),
('Kaviraj-New-STL338-New-133-50000-Interest-04-2026-48dd82c6', '2026-05-21', 'Customer_Interest', 'Kaviraj-New-STL338-New-133-50000-Interest-04-2026', 'New-STL338', 'New-133', 'Kaviraj', 'Interest-04-2026', 0.0, 0.0, 527549, NULL, NULL, 'New Finance', '390.0'),
('Sabarish-New-STL280-New-38-200000-Interest-04-2026-b81f78bc', '2026-05-02', 'Customer_Interest', 'Sabarish-New-STL280-New-38-200000-Interest-04-2026', 'New-STL280', 'New-38', 'Sabarish', 'Interest-04-2026', 1260.0, 0.0, 528809, NULL, NULL, 'New Finance', '1260.0'),
('Sabarish-New-STL280-New-63-60000-Interest-04-2026-b81f78bc', '2026-05-02', 'Customer_Interest', 'Sabarish-New-STL280-New-63-60000-Interest-04-2026', 'New-STL280', 'New-63', 'Sabarish', 'Interest-04-2026', 1260.0, 0.0, 530069, NULL, NULL, 'New Finance', '1260.0'),
('Kaviyarasu Arul-New-STL323-New-28-750000-Interest-04-2026-f585ba0e', '2026-05-08', 'Customer_Interest', 'Kaviyarasu Arul-New-STL323-New-28-750000-Interest-04-2026', 'New-STL323', 'New-28', 'Kaviyarasu Arul', 'Interest-04-2026', 15750.0, 0.0, 545819, NULL, NULL, 'New Finance', '15750.0'),
('Kaviyarasu Arul-New-STL323-New-125-200000-Interest-04-2026-f585ba0e', '2026-05-08', 'Customer_Interest', 'Kaviyarasu Arul-New-STL323-New-125-200000-Interest-04-2026', 'New-STL323', 'New-125', 'Kaviyarasu Arul', 'Interest-04-2026', 4060.0, 0.0, 549879, NULL, NULL, 'New Finance', '4060.0'),
('Kaviyarasu Arul-New-STL323-New-28-750000-Interest-04-2026-8ae39e25', '2026-05-08', 'Customer_Interest', 'Kaviyarasu Arul-New-STL323-New-28-750000-Interest-04-2026', 'New-STL323', 'New-28', 'Kaviyarasu Arul', 'Interest-04-2026', 0.0, 0.0, 549879, NULL, NULL, 'New Finance', '15750.0'),
('Karthi cake shop-New-STL337-New-128-200000-Interest-04-2026-57b896bf', '2026-05-08', 'Customer_Interest', 'Karthi cake shop-New-STL337-New-128-200000-Interest-04-2026', 'New-STL337', 'New-128', 'Karthi cake shop', 'Interest-04-2026', 2520.0, 0.0, 552399, NULL, NULL, 'New Finance', '2520.0'),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-03-2026-d84f2621', '2026-05-22', 'Customer_Interest', 'Suresh Abudhabi-New-STL273-New-23-60000-Interest-03-2026', 'New-STL273', 'New-23', 'Suresh Abudhabi', 'Interest-03-2026', 1220.0, 0.0, 553619, NULL, NULL, 'New Finance', '1220.0'),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-04-2026-d84f2621', '2026-05-22', 'Customer_Interest', 'Suresh Abudhabi-New-STL273-New-23-60000-Interest-04-2026', 'New-STL273', 'New-23', 'Suresh Abudhabi', 'Interest-04-2026', 40.0, 0.0, 553659, NULL, NULL, 'New Finance', '1260.0'),
('Mariyammal-New-STL297-New-34-100000-Interest-04-2026-32d3849d', '2026-05-06', 'Customer_Interest', 'Mariyammal-New-STL297-New-34-100000-Interest-04-2026', 'New-STL297', 'New-34', 'Mariyammal', 'Interest-04-2026', 2100.0, 0.0, 555759, NULL, NULL, 'New Finance', '2100.0'),
('Rajendran-New-STL58-New-30-15000-Interest-04-2026-99c079ed', '2026-05-18', 'Customer_Interest', 'Rajendran-New-STL58-New-30-15000-Interest-04-2026', 'New-STL58', 'New-30', 'Rajendran', 'Interest-04-2026', 360.0, 0.0, 556119, NULL, NULL, 'New Finance', '360.0'),
('Kaviraj-New-STL338-New-133-50000-Interest-04-2026-af80d998', '2026-05-23', 'Customer_Interest', 'Kaviraj-New-STL338-New-133-50000-Interest-04-2026', 'New-STL338', 'New-133', 'Kaviraj', 'Interest-04-2026', 390.0, 0.0, 556509, 'Cash', NULL, 'New Finance', '390.0'),
('Kaviraj-New-STL338-New-133-40000-Interest-05-2026-af80d998', '2026-05-23', 'Customer_Interest', 'Kaviraj-New-STL338-New-133-40000-Interest-05-2026', 'New-STL338', 'New-133', 'Kaviraj', 'Interest-05-2026', 610.0, 0.0, 557119, 'Cash', NULL, 'New Finance', '840.0'),
('Pradeep-New-STL67-New-6-60000-Interest-04-2026-b18d5859', '2026-06-05', 'Customer_Interest', 'Pradeep-New-STL67-New-6-60000-Interest-04-2026', 'New-STL67', 'New-6', 'Pradeep', 'Interest-04-2026', 714.0, 0.0, 557833, 'Other', NULL, 'New Finance', '714.0'),
('Pradeep-New-STL67-New-6-40000-Interest-04-2026-b18d5859', '2026-06-05', 'Customer_Interest', 'Pradeep-New-STL67-New-6-40000-Interest-04-2026', 'New-STL67', 'New-6', 'Pradeep', 'Interest-04-2026', 504.0, 0.0, 558337, 'Other', NULL, 'New Finance', '504.0'),
('Pradeep-New-STL67-New-6-50000-Interest-04-2026-b18d5859', '2026-06-05', 'Customer_Interest', 'Pradeep-New-STL67-New-6-50000-Interest-04-2026', 'New-STL67', 'New-6', 'Pradeep', 'Interest-04-2026', 700.0, 0.0, 559037, 'Other', NULL, 'New Finance', '700.0'),
('Arul M-New-STL330-New-13-35000-Interest-04-2026-69c63dd4', '2026-06-05', 'Customer_Interest', 'Arul M-New-STL330-New-13-35000-Interest-04-2026', 'New-STL330', 'New-13', 'Arul M', 'Interest-04-2026', 840.0, 0.0, 559877, 'Other', NULL, 'New Finance', '840.0'),
('Arul M-New-STL330-New-62-15000-Interest-04-2026-69c63dd4', '2026-06-05', 'Customer_Interest', 'Arul M-New-STL330-New-62-15000-Interest-04-2026', 'New-STL330', 'New-62', 'Arul M', 'Interest-04-2026', 320.0, 0.0, 560197, 'Other', NULL, 'New Finance', '320.0'),
('Arul M-New-STL330-New-68-5000-Interest-04-2026-69c63dd4', '2026-06-05', 'Customer_Interest', 'Arul M-New-STL330-New-68-5000-Interest-04-2026', 'New-STL330', 'New-68', 'Arul M', 'Interest-04-2026', 110.0, 0.0, 560307, 'Other', NULL, 'New Finance', '110.0'),
('Kongu Kochai-New-STL329-New-17-200000-Interest-03-2026-54f7ac78', '2026-06-05', 'Customer_Interest', 'Kongu Kochai-New-STL329-New-17-200000-Interest-03-2026', 'New-STL329', 'New-17', 'Kongu Kochai', 'Interest-03-2026', 4340.0, 0.0, 564647, 'Other', 'adjusted in cover', 'New Finance', '4340.0'),
('Kongu Kochai-New-STL329-New-17-50000-Interest-04-2026-54f7ac78', '2026-06-05', 'Customer_Interest', 'Kongu Kochai-New-STL329-New-17-50000-Interest-04-2026', 'New-STL329', 'New-17', 'Kongu Kochai', 'Interest-04-2026', 40.0, 0.0, 564687, 'Other', 'adjusted in cover', 'New Finance', '40.0'),
('Kongu Kochai-New-STL329-New-17-150000-Interest-04-2026-54f7ac78', '2026-06-05', 'Customer_Interest', 'Kongu Kochai-New-STL329-New-17-150000-Interest-04-2026', 'New-STL329', 'New-17', 'Kongu Kochai', 'Interest-04-2026', 3150.0, 0.0, 567837, 'Other', 'adjusted in cover', 'New Finance', '3150.0'),
('Kongu Kochai-New-STL329-New-17-150000-Interest-06-2026-54f7ac78', '2026-06-05', 'Customer_Interest', 'Kongu Kochai-New-STL329-New-17-150000-Interest-06-2026', 'New-STL329', 'New-17', 'Kongu Kochai', 'Interest-06-2026', 320.0, 0.0, 568157, 'Other', 'adjusted in cover', 'New Finance', '320.0'),
('Kannan-New-STL235-New-36-215000-Interest-03-2026-b74fe404', '2026-06-05', 'Customer_Interest', 'Kannan-New-STL235-New-36-215000-Interest-03-2026', 'New-STL235', 'New-36', 'Kannan', 'Interest-03-2026', 4670.0, 0.0, 572827, 'Other', 'adjusted in cover', 'New Finance', '4670.0'),
('Kannan-New-STL235-New-36-115000-Interest-04-2026-b74fe404', '2026-06-05', 'Customer_Interest', 'Kannan-New-STL235-New-36-115000-Interest-04-2026', 'New-STL235', 'New-36', 'Kannan', 'Interest-04-2026', 1290.0, 0.0, 574117, 'Other', 'adjusted in cover', 'New Finance', '1290.0'),
('Kannan-New-STL235-New-36-100000-Interest-04-2026-b74fe404', '2026-06-05', 'Customer_Interest', 'Kannan-New-STL235-New-36-100000-Interest-04-2026', 'New-STL235', 'New-36', 'Kannan', 'Interest-04-2026', 2100.0, 0.0, 576217, 'Other', 'adjusted in cover', 'New Finance', '2100.0'),
('Kannan-New-STL235-New-138-200000-Interest-05-2026-b74fe404', '2026-06-05', 'Customer_Interest', 'Kannan-New-STL235-New-138-200000-Interest-05-2026', 'New-STL235', 'New-138', 'Kannan', 'Interest-05-2026', 1400.0, 0.0, 577617, 'Other', 'adjusted in cover', 'New Finance', '1400.0'),
('Tharun-New-STL303-New-66-35000-Interest-04-2026-14cad2ed', '2026-06-05', 'Customer_Interest', 'Tharun-New-STL303-New-66-35000-Interest-04-2026', 'New-STL303', 'New-66', 'Tharun', 'Interest-04-2026', 40.0, 0.0, 577657, 'Other', 'adjusted', 'New Finance', '40.0'),
('Tharun-New-STL303-New-66-35000-Interest-04-2026-14cad2ed', '2026-06-05', 'Customer_Interest', 'Tharun-New-STL303-New-66-35000-Interest-04-2026', 'New-STL303', 'New-66', 'Tharun', 'Interest-04-2026', 70.0, 0.0, 577727, 'Other', 'adjusted', 'New Finance', '70.0'),
('Dinesh-New-STL78-New-19-30000-Interest-04-2026-bb50e490', '2026-06-05', 'Customer_Interest', 'Dinesh-New-STL78-New-19-30000-Interest-04-2026', 'New-STL78', 'New-19', 'Dinesh', 'Interest-04-2026', 210.0, 0.0, 577937, 'Other', NULL, 'New Finance', '210.0'),
('Dinesh-New-STL78-New-19-10000-Interest-05-2026-bb50e490', '2026-06-05', 'Customer_Interest', 'Dinesh-New-STL78-New-19-10000-Interest-05-2026', 'New-STL78', 'New-19', 'Dinesh', 'Interest-05-2026', 80.0, 0.0, 578017, 'Other', NULL, 'New Finance', '80.0'),
('Dinesh-New-STL78-New-19-10000-Interest-05-2026-bb50e490', '2026-06-05', 'Customer_Interest', 'Dinesh-New-STL78-New-19-10000-Interest-05-2026', 'New-STL78', 'New-19', 'Dinesh', 'Interest-05-2026', 120.0, 0.0, 578137, 'Other', NULL, 'New Finance', '130.0'),
('Udhayakumar-New-STL126-New-21-130000-Interest-03-2026-43554344', '2026-06-05', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-130000-Interest-03-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-03-2026', 300.0, 0.0, 578437, 'Other', NULL, 'New Finance', '300.0'),
('Udhayakumar-New-STL126-New-21-130000-Interest-04-2026-43554344', '2026-06-05', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-130000-Interest-04-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-04-2026', 2430.0, 0.0, 580867, 'Other', NULL, 'New Finance', '2730.0'),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-04-2026-8c682ca9', '2026-06-05', 'Customer_Interest', 'Suresh Abudhabi-New-STL273-New-23-60000-Interest-04-2026', 'New-STL273', 'New-23', 'Suresh Abudhabi', 'Interest-04-2026', 1220.0, 0.0, 582087, 'Other', NULL, 'New Finance', '1220.0'),
('Boopathy Crane-New-STL217-New-22-30000-Interest-04-2026-30199813', '2026-06-05', 'Customer_Interest', 'Boopathy Crane-New-STL217-New-22-30000-Interest-04-2026', 'New-STL217', 'New-22', 'Boopathy Crane', 'Interest-04-2026', 720.0, 0.0, 582807, 'Other', NULL, 'New Finance', '720.0'),
('Vinoth-New-STL262-New-32-50000-Interest-04-2026-eb13e447', '2026-05-18', 'Customer_Interest', 'Vinoth-New-STL262-New-32-50000-Interest-04-2026', 'New-STL262', 'New-32', 'Vinoth', 'Interest-04-2026', 1050.0, 0.0, 583857, 'Other', NULL, 'New Finance', '1050.0'),
('Ashok-New-STL282-New-33-15000-Interest-04-2026-6b8d2cd7', '2026-06-05', 'Customer_Interest', 'Ashok-New-STL282-New-33-15000-Interest-04-2026', 'New-STL282', 'New-33', 'Ashok', 'Interest-04-2026', 360.0, 0.0, 584217, NULL, NULL, 'New Finance', '360.0'),
('Ramkumar-New-STL231-New-35-100000-Interest-04-2026-3911f2b5', '2026-05-16', 'Customer_Interest', 'Ramkumar-New-STL231-New-35-100000-Interest-04-2026', 'New-STL231', 'New-35', 'Ramkumar', 'Interest-04-2026', 1440.0, 0.0, 585657, NULL, NULL, 'New Finance', '1440.0'),
('Ramkumar-New-STL231-New-35-100000-Interest-04-2026-3911f2b5', '2026-05-16', 'Customer_Interest', 'Ramkumar-New-STL231-New-35-100000-Interest-04-2026', 'New-STL231', 'New-35', 'Ramkumar', 'Interest-04-2026', 2100.0, 0.0, 587757, NULL, NULL, 'New Finance', '2100.0'),
('Ramkumar-New-STL231-New-71-100000-Interest-04-2026-3911f2b5', '2026-05-16', 'Customer_Interest', 'Ramkumar-New-STL231-New-71-100000-Interest-04-2026', 'New-STL231', 'New-71', 'Ramkumar', 'Interest-04-2026', 2100.0, 0.0, 589857, NULL, NULL, 'New Finance', '2100.0'),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-04-2026-6b5ae4b6', '2026-05-16', 'Customer_Interest', 'Sakthivel Broker-New-STL263-New-37-100000-Interest-04-2026', 'New-STL263', 'New-37', 'Sakthivel Broker', 'Interest-04-2026', 2100.0, 0.0, 591957, NULL, NULL, 'New Finance', '2100.0'),
('Moorthy-New-STL312-New-39-50000-Interest-04-2026-44b58200', '2026-05-16', 'Customer_Interest', 'Moorthy-New-STL312-New-39-50000-Interest-04-2026', 'New-STL312', 'New-39', 'Moorthy', 'Interest-04-2026', 1050.0, 0.0, 593007, NULL, NULL, 'New Finance', '1050.0'),
('Shanmugam-New-STL139-New-40-30000-Interest-04-2026-57d920ef', '2026-05-06', 'Customer_Interest', 'Shanmugam-New-STL139-New-40-30000-Interest-04-2026', 'New-STL139', 'New-40', 'Shanmugam', 'Interest-04-2026', 720.0, 0.0, 593727, NULL, NULL, 'New Finance', '720.0'),
('Ramprakash-New-STL234-New-42-55000-Interest-04-2026-11ec9937', '2026-05-13', 'Customer_Interest', 'Ramprakash-New-STL234-New-42-55000-Interest-04-2026', 'New-STL234', 'New-42', 'Ramprakash', 'Interest-04-2026', 1160.0, 0.0, 594887, NULL, NULL, 'New Finance', '1160.0'),
('Murugesan-New-STL326-New-43-20000-Interest-03-2026-4d80b4bc', '2026-05-15', 'Customer_Interest', 'Murugesan-New-STL326-New-43-20000-Interest-03-2026', 'New-STL326', 'New-43', 'Murugesan', 'Interest-03-2026', 500.0, 0.0, 595387, NULL, NULL, 'New Finance', '500.0'),
('Murugesan-New-STL326-New-43-20000-Interest-04-2026-4d80b4bc', '2026-05-15', 'Customer_Interest', 'Murugesan-New-STL326-New-43-20000-Interest-04-2026', 'New-STL326', 'New-43', 'Murugesan', 'Interest-04-2026', 480.0, 0.0, 595867, NULL, NULL, 'New Finance', '480.0'),
('Kalimuthu-New-STL248-New-44-50000-Interest-03-2026-709f0df3', '2026-05-31', 'Customer_Interest', 'Kalimuthu-New-STL248-New-44-50000-Interest-03-2026', 'New-STL248', 'New-44', 'Kalimuthu', 'Interest-03-2026', 1090.0, 0.0, 596957, NULL, NULL, 'New Finance', '1090.0'),
('Kalimuthu-New-STL248-New-44-50000-Interest-04-2026-709f0df3', '2026-05-31', 'Customer_Interest', 'Kalimuthu-New-STL248-New-44-50000-Interest-04-2026', 'New-STL248', 'New-44', 'Kalimuthu', 'Interest-04-2026', 1050.0, 0.0, 598007, NULL, NULL, 'New Finance', '1050.0'),
('Ravi-New-STL306-New-45-75000-Interest-04-2026-11248afe', '2026-05-15', 'Customer_Interest', 'Ravi-New-STL306-New-45-75000-Interest-04-2026', 'New-STL306', 'New-45', 'Ravi', 'Interest-04-2026', 160.0, 0.0, 598167, NULL, NULL, 'New Finance', '160.0'),
('Ravi-New-STL306-New-134-20000-Interest-04-2026-11248afe', '2026-05-15', 'Customer_Interest', 'Ravi-New-STL306-New-134-20000-Interest-04-2026', 'New-STL306', 'New-134', 'Ravi', 'Interest-04-2026', 100.0, 0.0, 598267, NULL, NULL, 'New Finance', '100.0'),
('Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-04-2026-7529f2dc', '2026-05-11', 'Customer_Interest', 'Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-04-2026', 'New-STL334', 'New-73', 'Vignesh Arun Kumba', 'Interest-04-2026', 2100.0, 0.0, 600367, NULL, NULL, 'New Finance', '2100.0'),
('Durai Master Kumbaa-New-STL335-New-75-100000-Interest-03-2026-b56d9b46', '2026-05-19', 'Customer_Interest', 'Durai Master Kumbaa-New-STL335-New-75-100000-Interest-03-2026', 'New-STL335', 'New-75', 'Durai Master Kumbaa', 'Interest-03-2026', 70.0, 0.0, 600437, NULL, NULL, 'New Finance', '70.0'),
('Durai Master Kumbaa-New-STL335-New-75-100000-Interest-04-2026-b56d9b46', '2026-05-19', 'Customer_Interest', 'Durai Master Kumbaa-New-STL335-New-75-100000-Interest-04-2026', 'New-STL335', 'New-75', 'Durai Master Kumbaa', 'Interest-04-2026', 2100.0, 0.0, 602537, NULL, NULL, 'New Finance', '2100.0'),
('Tharun Tex-New-STL221-New-74-40000-Interest-04-2026-0ace44db', '2026-05-09', 'Customer_Interest', 'Tharun Tex-New-STL221-New-74-40000-Interest-04-2026', 'New-STL221', 'New-74', 'Tharun Tex', 'Interest-04-2026', 390.0, 0.0, 602927, NULL, NULL, 'New Finance', '390.0'),
('Tharun Tex-New-STL221-New-74-60000-Interest-04-2026-0ace44db', '2026-05-09', 'Customer_Interest', 'Tharun Tex-New-STL221-New-74-60000-Interest-04-2026', 'New-STL221', 'New-74', 'Tharun Tex', 'Interest-04-2026', 1260.0, 0.0, 604187, NULL, NULL, 'New Finance', '1260.0');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('Tharun Tex-New-STL221-New-74-10000-Interest-06-2026-0ace44db', '2026-05-09', 'Customer_Interest', 'Tharun Tex-New-STL221-New-74-10000-Interest-06-2026', 'New-STL221', 'New-74', 'Tharun Tex', 'Interest-06-2026', 20.0, 0.0, 604207, NULL, NULL, 'New Finance', '20.0'),
('Logambal-New-STL283-New-52-50000-Interest-04-2026-c9f7bdac', '2026-05-11', 'Customer_Interest', 'Logambal-New-STL283-New-52-50000-Interest-04-2026', 'New-STL283', 'New-52', 'Logambal', 'Interest-04-2026', 1050.0, 0.0, 605257, NULL, NULL, 'New Finance', '1050.0'),
('Divakar-New-STL318-New-53-25000-Interest-02-2026-d58cfc6d', '2026-05-16', 'Customer_Interest', 'Divakar-New-STL318-New-53-25000-Interest-02-2026', 'New-STL318', 'New-53', 'Divakar', 'Interest-02-2026', 560.0, 0.0, 605817, NULL, NULL, 'New Finance', '560.0'),
('Divakar-New-STL318-New-53-25000-Interest-04-2026-d58cfc6d', '2026-05-16', 'Customer_Interest', 'Divakar-New-STL318-New-53-25000-Interest-04-2026', 'New-STL318', 'New-53', 'Divakar', 'Interest-04-2026', 40.0, 0.0, 605857, NULL, NULL, 'New Finance', '600.0'),
('Divakar-New-STL318-New-53-25000-Interest-04-2026-060bfc16', '2026-06-05', 'Customer_Interest', 'Divakar-New-STL318-New-53-25000-Interest-04-2026', 'New-STL318', 'New-53', 'Divakar', 'Interest-04-2026', 560.0, 0.0, 606417, 'Other', NULL, 'New Finance', '560.0'),
('Muniyappan-New-STL150-New-54-100000-Interest-04-2026-6278870b', '2026-05-10', 'Customer_Interest', 'Muniyappan-New-STL150-New-54-100000-Interest-04-2026', 'New-STL150', 'New-54', 'Muniyappan', 'Interest-04-2026', 2100.0, 0.0, 608517, NULL, NULL, 'New Finance', '2100.0'),
('Shanmugaraj-New-STL151-New-55-300000-Interest-03-2026-62b88e11', '2026-05-15', 'Customer_Interest', 'Shanmugaraj-New-STL151-New-55-300000-Interest-03-2026', 'New-STL151', 'New-55', 'Shanmugaraj', 'Interest-03-2026', 6510.0, 0.0, 615027, NULL, NULL, 'New Finance', '6510.0'),
('Shanmugaraj-New-STL151-New-55-300000-Interest-04-2026-62b88e11', '2026-05-15', 'Customer_Interest', 'Shanmugaraj-New-STL151-New-55-300000-Interest-04-2026', 'New-STL151', 'New-55', 'Shanmugaraj', 'Interest-04-2026', 6300.0, 0.0, 621327, NULL, NULL, 'New Finance', '6300.0'),
('Nandhakumar-New-STL227-New-56-100000-Interest-04-2026-027811ef', '2026-05-17', 'Customer_Interest', 'Nandhakumar-New-STL227-New-56-100000-Interest-04-2026', 'New-STL227', 'New-56', 'Nandhakumar', 'Interest-04-2026', 2100.0, 0.0, 623427, NULL, NULL, 'New Finance', '2100.0'),
('Nandhakumar-New-STL227-New-127-200000-Interest-04-2026-027811ef', '2026-05-17', 'Customer_Interest', 'Nandhakumar-New-STL227-New-127-200000-Interest-04-2026', 'New-STL227', 'New-127', 'Nandhakumar', 'Interest-04-2026', 2520.0, 0.0, 625947, NULL, NULL, 'New Finance', '2520.0'),
('Vignesh-New-STL260-New-57-100000-Interest-04-2026-c59b00f2', '2026-05-11', 'Customer_Interest', 'Vignesh-New-STL260-New-57-100000-Interest-04-2026', 'New-STL260', 'New-57', 'Vignesh', 'Interest-04-2026', 2100.0, 0.0, 628047, NULL, NULL, 'New Finance', '2100.0'),
('Anand-New-STL274-New-58-20000-Interest-04-2026-d0e3dc09', '2026-05-15', 'Customer_Interest', 'Anand-New-STL274-New-58-20000-Interest-04-2026', 'New-STL274', 'New-58', 'Anand', 'Interest-04-2026', 480.0, 0.0, 628527, NULL, NULL, 'New Finance', '480.0'),
('Subramani-New-STL287-New-59-150000-Interest-04-2026-121d2b68', '2026-05-09', 'Customer_Interest', 'Subramani-New-STL287-New-59-150000-Interest-04-2026', 'New-STL287', 'New-59', 'Subramani', 'Interest-04-2026', 3150.0, 0.0, 631677, NULL, NULL, 'New Finance', '3150.0'),
('Nagurammal-New-STL331-New-60-150000-Interest-04-2026-c137bc98', '2026-05-04', 'Customer_Interest', 'Nagurammal-New-STL331-New-60-150000-Interest-04-2026', 'New-STL331', 'New-60', 'Nagurammal', 'Interest-04-2026', 3150.0, 0.0, 634827, NULL, NULL, 'New Finance', '3150.0'),
('478a00b7', '2026-04-15', 'Customer_Loan_Prin_Repayment', 'New-STL217-New-22-Boopathy Crane-30000', 'New-STL217', 'New-22', 'Boopathy Crane', 'New-22', 30000.0, NULL, 664827, 'Cash', NULL, 'New Finance', '740'),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-05-2026-3c6e07b0', '2026-06-03', 'Customer_Interest', 'Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-05-2026', 'New-STL304', 'New-26', 'Sakthivel Jayaraj', 'Interest-05-2026', 2170.0, 0.0, 666997, 'UPI', NULL, 'New Finance', '2170.0'),
('Subramani-New-STL287-New-59-150000-Interest-05-2026-514f62e7', '2026-06-08', 'Customer_Interest', 'Subramani-New-STL287-New-59-150000-Interest-05-2026', 'New-STL287', 'New-59', 'Subramani', 'Interest-05-2026', 3260.0, 0.0, 670257, 'UPI', NULL, 'New Finance', '3260.0'),
('Sundaravadivel-New-STL271-New-9-New-132-100000-Interest-05-2026-662ca1d3', '2026-06-13', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-9-New-132-100000-Interest-05-2026', 'New-STL271', 'New-9-New-132', 'Sundaravadivel', 'Interest-05-2026', 2170.0, 0.0, 672427, 'Cash', NULL, 'New Finance', '2170.0'),
('Balasubramani Suresh-New-STL275-New-10-New-64-New-131-300000-Interest-05-2026-8bf990c6', '2026-06-04', 'Customer_Interest', 'Balasubramani Suresh-New-STL275-New-10-New-64-New-131-300000-Interest-05-2026', 'New-STL275', 'New-10-New-64-New-131', 'Balasubramani Suresh', 'Interest-05-2026', 6510.0, 0.0, 678937, 'UPI', NULL, 'New Finance', '6510.0'),
('Priya-New-STL320-New-65-80000-Interest-06-2026-22ec61dd', '2026-07-07', 'Customer_Interest', 'Priya-New-STL320-New-65-80000-Interest-06-2026', 'New-STL320', 'New-65', 'Priya', 'Interest-06-2026', 170.0, 0.0, 679107, NULL, NULL, 'New Finance', '170.0'),
('Priya-New-STL320-New-140-150000-Interest-05-2026-22ec61dd', '2026-07-07', 'Customer_Interest', 'Priya-New-STL320-New-140-150000-Interest-05-2026', 'New-STL320', 'New-140', 'Priya', 'Interest-05-2026', 740.0, 0.0, 679847, NULL, NULL, 'New Finance', '740.0'),
('Priya-New-STL320-New-65-New-130-220000-Interest-05-2026-22ec61dd', '2026-07-07', 'Customer_Interest', 'Priya-New-STL320-New-65-New-130-220000-Interest-05-2026', 'New-STL320', 'New-65-New-130', 'Priya', 'Interest-05-2026', 5160.0, 0.0, 685007, NULL, NULL, 'New Finance', '5330.0'),
('Arul M-New-STL330-New-13-New-62-New-68-55000-Interest-05-2026-06e2cbeb', '2026-06-19', 'Customer_Interest', 'Arul M-New-STL330-New-13-New-62-New-68-55000-Interest-05-2026', 'New-STL330', 'New-13-New-62-New-68', 'Arul M', 'Interest-05-2026', 1190.0, 0.0, 686197, NULL, NULL, 'New Finance', '1190.0'),
('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-05-2026-a1f7f3a5', '2026-06-05', 'Customer_Interest', 'Manoj raghavendra shop-New-STL336-New-129-10000-Interest-05-2026', 'New-STL336', 'New-129', 'Manoj raghavendra shop', 'Interest-05-2026', 220.0, 0.0, 686417, NULL, NULL, 'New Finance', '220.0'),
('Surya Shed-New-STL339-New-135-New-136-140000-Interest-05-2026-cb45b065', '2026-06-15', 'Customer_Interest', 'Surya Shed-New-STL339-New-135-New-136-140000-Interest-05-2026', 'New-STL339', 'New-135-New-136', 'Surya Shed', 'Interest-05-2026', 3040.0, 0.0, 689457, NULL, NULL, 'New Finance', '3040.0'),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-05-2026-5a27a6cc', '2026-06-15', 'Customer_Interest', 'Sankara Narayanan-New-STL179-New-1-300000-Interest-05-2026', 'New-STL179', 'New-1', 'Sankara Narayanan', 'Interest-05-2026', 6510.0, 0.0, 695967, NULL, NULL, 'New Finance', '6510.0'),
('Ramesh-New-STL257-New-2-30000-Interest-05-2026-bca06a9a', '2026-06-18', 'Customer_Interest', 'Ramesh-New-STL257-New-2-30000-Interest-05-2026', 'New-STL257', 'New-2', 'Ramesh', 'Interest-05-2026', 740.0, 0.0, 696707, NULL, NULL, 'New Finance', '740.0'),
('Arul S-New-STL270-New-3-70000-Interest-05-2026-582c83cf', '2026-06-19', 'Customer_Interest', 'Arul S-New-STL270-New-3-70000-Interest-05-2026', 'New-STL270', 'New-3', 'Arul S', 'Interest-05-2026', 1520.0, 0.0, 698227, NULL, NULL, 'New Finance', '1520.0'),
('Rangis-New-STL295-New-4-100000-Interest-05-2026-66c1488b', '2026-06-08', 'Customer_Interest', 'Rangis-New-STL295-New-4-100000-Interest-05-2026', 'New-STL295', 'New-4', 'Rangis', 'Interest-05-2026', 2170.0, 0.0, 700397, NULL, NULL, 'New Finance', '2170.0'),
('Mani Basketball-New-STL333-New-61-150000-Interest-05-2026-0c2437d0', '2026-06-01', 'Customer_Interest', 'Mani Basketball-New-STL333-New-61-150000-Interest-05-2026', 'New-STL333', 'New-61', 'Mani Basketball', 'Interest-05-2026', 3260.0, 0.0, 703657, 'UPI', NULL, 'New Finance', '3260.0'),
('RanjithKumar-New-STL319-New-72-200000-Interest-05-2026-9ac33cc4', '2026-06-13', 'Customer_Interest', 'RanjithKumar-New-STL319-New-72-200000-Interest-05-2026', 'New-STL319', 'New-72', 'RanjithKumar', 'Interest-05-2026', 4340.0, 0.0, 707997, 'Cash', NULL, 'New Finance', '4340.0'),
('Kaviraj-New-STL338-New-133-40000-Interest-05-2026-1c123a8e', '2026-06-08', 'Customer_Interest', 'Kaviraj-New-STL338-New-133-40000-Interest-05-2026', 'New-STL338', 'New-133', 'Kaviraj', 'Interest-05-2026', 230.0, 0.0, 708227, NULL, NULL, 'New Finance', '230.0'),
('John-New-STL292-New-14-150000-Interest-05-2026-540b0ca5', '2026-06-15', 'Customer_Interest', 'John-New-STL292-New-14-150000-Interest-05-2026', 'New-STL292', 'New-14', 'John', 'Interest-05-2026', 3260.0, 0.0, 711487, 'UPI', NULL, 'New Finance', '3260.0'),
('Tharun-New-STL303-New-66-35000-Interest-05-2026-aace8c15', '2026-06-15', 'Customer_Interest', 'Tharun-New-STL303-New-66-35000-Interest-05-2026', 'New-STL303', 'New-66', 'Tharun', 'Interest-05-2026', 870.0, 0.0, 712357, 'Cash', 'Minus in Chit O', 'New Finance', '870.0'),
('Praveen Ram-New-STL324-New-16-80000-Interest-05-2026-42b15385', '2026-06-06', 'Customer_Interest', 'Praveen Ram-New-STL324-New-16-80000-Interest-05-2026', 'New-STL324', 'New-16', 'Praveen Ram', 'Interest-05-2026', 1740.0, 0.0, 714097, NULL, NULL, 'New Finance', '1740.0'),
('Viji Vasanth-New-STL313-New-67-100000-Interest-05-2026-c8079d89', '2026-06-02', 'Customer_Interest', 'Viji Vasanth-New-STL313-New-67-100000-Interest-05-2026', 'New-STL313', 'New-67', 'Viji Vasanth', 'Interest-05-2026', 1050.0, 0.0, 715147, NULL, NULL, 'New Finance', '1050.0'),
('Viji Vasanth-New-STL313-New-67-150000-Interest-05-2026-c8079d89', '2026-06-02', 'Customer_Interest', 'Viji Vasanth-New-STL313-New-67-150000-Interest-05-2026', 'New-STL313', 'New-67', 'Viji Vasanth', 'Interest-05-2026', 3250.0, 0.0, 718397, NULL, NULL, 'New Finance', '3260.0'),
('Sabarish-New-STL280-New-63-60000-Interest-05-2026-35b4ea66', '2026-06-20', 'Customer_Interest', 'Sabarish-New-STL280-New-63-60000-Interest-05-2026', 'New-STL280', 'New-63', 'Sabarish', 'Interest-05-2026', 1300.0, 0.0, 719697, NULL, NULL, 'New Finance', '1300.0'),
('Bala kaarthi-New-STL340-New-139-200000-Interest-05-2026-e13c10a5', '2026-06-11', 'Customer_Interest', 'Bala kaarthi-New-STL340-New-139-200000-Interest-05-2026', 'New-STL340', 'New-139', 'Bala kaarthi', 'Interest-05-2026', 2660.0, 0.0, 722357, NULL, NULL, 'New Finance', '2660.0'),
('Kannan-New-STL235-New-36-100000-Interest-05-2026-d5425f68', '2026-06-19', 'Customer_Interest', 'Kannan-New-STL235-New-36-100000-Interest-05-2026', 'New-STL235', 'New-36', 'Kannan', 'Interest-05-2026', 3570.0, 0.0, 725927, NULL, NULL, 'New Finance', '3570.0'),
('Kaviyarasu Arul-New-STL323-New-28-New-125-950000-Interest-05-2026-1d2426b5', '2026-06-13', 'Customer_Interest', 'Kaviyarasu Arul-New-STL323-New-28-New-125-950000-Interest-05-2026', 'New-STL323', 'New-28-New-125', 'Kaviyarasu Arul', 'Interest-05-2026', 20610.0, 0.0, 746537, NULL, NULL, 'New Finance', '20610.0'),
('Karthi cake shop-New-STL337-New-128-200000-Interest-05-2026-2b43f346', '2026-06-13', 'Customer_Interest', 'Karthi cake shop-New-STL337-New-128-200000-Interest-05-2026', 'New-STL337', 'New-128', 'Karthi cake shop', 'Interest-05-2026', 4340.0, 0.0, 750877, NULL, NULL, 'New Finance', '4340.0'),
('Yagappan-New-STL278-New-25-20000-Interest-05-2026-002a5217', '2026-06-18', 'Customer_Interest', 'Yagappan-New-STL278-New-25-20000-Interest-05-2026', 'New-STL278', 'New-25', 'Yagappan', 'Interest-05-2026', 500.0, 0.0, 751377, NULL, NULL, 'New Finance', '500.0'),
('Mahesh-New-STL308-New-27-50000-Interest-05-2026-17257c0d', '2026-06-13', 'Customer_Interest', 'Mahesh-New-STL308-New-27-50000-Interest-05-2026', 'New-STL308', 'New-27', 'Mahesh', 'Interest-05-2026', 1090.0, 0.0, 752467, NULL, NULL, 'New Finance', '1090.0'),
('Murugesan pons-New-STL341-New-141-80000-Interest-05-2026-26223eec', '2026-06-19', 'Customer_Interest', 'Murugesan pons-New-STL341-New-141-80000-Interest-05-2026', 'New-STL341', 'New-141', 'Murugesan pons', 'Interest-05-2026', 220.0, 0.0, 752687, NULL, NULL, 'New Finance', '220.0'),
('Jeyaraj pons-New-STL342-New-142-50000-Interest-05-2026-58ba4a15', '2026-06-17', 'Customer_Interest', 'Jeyaraj pons-New-STL342-New-142-50000-Interest-05-2026', 'New-STL342', 'New-142', 'Jeyaraj pons', 'Interest-05-2026', 250.0, 0.0, 752937, NULL, NULL, 'New Finance', '250.0'),
('Rajendran-New-STL58-New-30-15000-Interest-05-2026-927d60a8', '2026-06-19', 'Customer_Interest', 'Rajendran-New-STL58-New-30-15000-Interest-05-2026', 'New-STL58', 'New-30', 'Rajendran', 'Interest-05-2026', 370.0, 0.0, 753307, NULL, NULL, 'New Finance', '370.0'),
('Vinoth-New-STL262-New-32-50000-Interest-05-2026-b334c530', '2026-06-19', 'Customer_Interest', 'Vinoth-New-STL262-New-32-50000-Interest-05-2026', 'New-STL262', 'New-32', 'Vinoth', 'Interest-05-2026', 1090.0, 0.0, 754397, NULL, NULL, 'New Finance', '1090.0'),
('Ashok-New-STL282-New-33-15000-Interest-05-2026-491059c5', '2026-06-19', 'Customer_Interest', 'Ashok-New-STL282-New-33-15000-Interest-05-2026', 'New-STL282', 'New-33', 'Ashok', 'Interest-05-2026', 370.0, 0.0, 754767, NULL, NULL, 'New Finance', '370.0'),
('Mariyammal-New-STL297-New-34-100000-Interest-05-2026-4cb78e4f', '2026-06-19', 'Customer_Interest', 'Mariyammal-New-STL297-New-34-100000-Interest-05-2026', 'New-STL297', 'New-34', 'Mariyammal', 'Interest-05-2026', 2170.0, 0.0, 756937, NULL, NULL, 'New Finance', '2170.0'),
('Ramkumar-New-STL231-New-35-New-71-200000-Interest-05-2026-7e186b37', '2026-06-20', 'Customer_Interest', 'Ramkumar-New-STL231-New-35-New-71-200000-Interest-05-2026', 'New-STL231', 'New-35-New-71', 'Ramkumar', 'Interest-05-2026', 4340.0, 0.0, 761277, NULL, NULL, 'New Finance', '4340.0'),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-05-2026-37919898', '2026-06-20', 'Customer_Interest', 'Sakthivel Broker-New-STL263-New-37-100000-Interest-05-2026', 'New-STL263', 'New-37', 'Sakthivel Broker', 'Interest-05-2026', 2170.0, 0.0, 763447, NULL, NULL, 'New Finance', '2170.0'),
('Moorthy-New-STL312-New-39-50000-Interest-05-2026-7ac60515', '2026-06-20', 'Customer_Interest', 'Moorthy-New-STL312-New-39-50000-Interest-05-2026', 'New-STL312', 'New-39', 'Moorthy', 'Interest-05-2026', 1090.0, 0.0, 764537, NULL, NULL, 'New Finance', '1090.0'),
('Shanmugam-New-STL139-New-40-30000-Interest-05-2026-d6cadd53', '2026-06-08', 'Customer_Interest', 'Shanmugam-New-STL139-New-40-30000-Interest-05-2026', 'New-STL139', 'New-40', 'Shanmugam', 'Interest-05-2026', 740.0, 0.0, 765277, NULL, NULL, 'New Finance', '740.0'),
('Ramprakash-New-STL234-New-42-55000-Interest-05-2026-307f140a', '2026-06-23', 'Customer_Interest', 'Ramprakash-New-STL234-New-42-55000-Interest-05-2026', 'New-STL234', 'New-42', 'Ramprakash', 'Interest-05-2026', 1190.0, 0.0, 766467, NULL, NULL, 'New Finance', '1190.0'),
('Murugesan-New-STL326-New-43-20000-Interest-05-2026-46fb5c56', '2026-07-02', 'Customer_Interest', 'Murugesan-New-STL326-New-43-20000-Interest-05-2026', 'New-STL326', 'New-43', 'Murugesan', 'Interest-05-2026', 500.0, 0.0, 766967, NULL, NULL, 'New Finance', '500.0'),
('Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-05-2026-d9723b08', '2026-06-05', 'Customer_Interest', 'Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-05-2026', 'New-STL334', 'New-73', 'Vignesh Arun Kumba', 'Interest-05-2026', 2170.0, 0.0, 769137, NULL, NULL, 'New Finance', '2170.0'),
('Tharun Tex-New-STL221-New-74-50000-Interest-05-2026-015e6bd5', '2026-06-10', 'Customer_Interest', 'Tharun Tex-New-STL221-New-74-50000-Interest-05-2026', 'New-STL221', 'New-74', 'Tharun Tex', 'Interest-05-2026', 1140.0, 0.0, 770277, NULL, NULL, 'New Finance', '1140.0'),
('Durai Master Kumbaa-New-STL335-New-75-100000-Interest-05-2026-53b6e79e', '2026-06-12', 'Customer_Interest', 'Durai Master Kumbaa-New-STL335-New-75-100000-Interest-05-2026', 'New-STL335', 'New-75', 'Durai Master Kumbaa', 'Interest-05-2026', 2170.0, 0.0, 772447, NULL, NULL, 'New Finance', '2170.0'),
('Ravi-New-STL306-New-134-20000-Interest-05-2026-e4cb6b53', '2026-06-19', 'Customer_Interest', 'Ravi-New-STL306-New-134-20000-Interest-05-2026', 'New-STL306', 'New-134', 'Ravi', 'Interest-05-2026', 500.0, 0.0, 772947, NULL, NULL, 'New Finance', '500.0'),
('Divakar-New-STL318-New-53-New-137-35000-Interest-05-2026-313b3de6', '2026-06-27', 'Customer_Interest', 'Divakar-New-STL318-New-53-New-137-35000-Interest-05-2026', 'New-STL318', 'New-53-New-137', 'Divakar', 'Interest-05-2026', 870.0, 0.0, 773817, NULL, NULL, 'New Finance', '870.0'),
('Logambal-New-STL283-New-52-30000-Interest-05-2026-3db79a8c', '2026-06-10', 'Customer_Interest', 'Logambal-New-STL283-New-52-30000-Interest-05-2026', 'New-STL283', 'New-52', 'Logambal', 'Interest-05-2026', 560.0, 0.0, 774377, NULL, NULL, 'New Finance', '560.0'),
('Muniyappan-New-STL150-New-54-100000-Interest-05-2026-99bf1bbb', '2026-06-11', 'Customer_Interest', 'Muniyappan-New-STL150-New-54-100000-Interest-05-2026', 'New-STL150', 'New-54', 'Muniyappan', 'Interest-05-2026', 2170.0, 0.0, 776547, NULL, NULL, 'New Finance', '2170.0'),
('Shanmugaraj-New-STL151-New-55-300000-Interest-05-2026-507be997', '2026-06-07', 'Customer_Interest', 'Shanmugaraj-New-STL151-New-55-300000-Interest-05-2026', 'New-STL151', 'New-55', 'Shanmugaraj', 'Interest-05-2026', 6510.0, 0.0, 783057, NULL, NULL, 'New Finance', '6510.0'),
('Nandhakumar-New-STL227-New-56-100000-Interest-05-2026-46fd348e', '2026-06-16', 'Customer_Interest', 'Nandhakumar-New-STL227-New-56-100000-Interest-05-2026', 'New-STL227', 'New-56', 'Nandhakumar', 'Interest-05-2026', 1750.0, 0.0, 784807, NULL, NULL, 'New Finance', '1750.0'),
('Nandhakumar-New-STL227-New-127-200000-Interest-05-2026-46fd348e', '2026-06-16', 'Customer_Interest', 'Nandhakumar-New-STL227-New-127-200000-Interest-05-2026', 'New-STL227', 'New-127', 'Nandhakumar', 'Interest-05-2026', 4340.0, 0.0, 789147, NULL, NULL, 'New Finance', '4340.0'),
('Vignesh-New-STL260-New-57-100000-Interest-05-2026-b73a8c0a', '2026-06-08', 'Customer_Interest', 'Vignesh-New-STL260-New-57-100000-Interest-05-2026', 'New-STL260', 'New-57', 'Vignesh', 'Interest-05-2026', 2170.0, 0.0, 791317, NULL, NULL, 'New Finance', '2170.0'),
('Anand-New-STL274-New-58-20000-Interest-05-2026-d6eb3681', '2026-06-19', 'Customer_Interest', 'Anand-New-STL274-New-58-20000-Interest-05-2026', 'New-STL274', 'New-58', 'Anand', 'Interest-05-2026', 500.0, 0.0, 791817, NULL, NULL, 'New Finance', '500.0'),
('Nagurammal-New-STL331-New-60-150000-Interest-05-2026-cae9f3be', '2026-06-15', 'Customer_Interest', 'Nagurammal-New-STL331-New-60-150000-Interest-05-2026', 'New-STL331', 'New-60', 'Nagurammal', 'Interest-05-2026', 3260.0, 0.0, 795077, NULL, NULL, 'New Finance', '3260.0'),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-05-2026-a521173c', '2026-06-13', 'Customer_Interest', 'Suresh Abudhabi-New-STL273-New-23-60000-Interest-05-2026', 'New-STL273', 'New-23', 'Suresh Abudhabi', 'Interest-05-2026', 650.0, 0.0, 795727, 'UPI', 'Pollachi paid', 'New Finance', '1300.0'),
('Udhayakumar-New-STL126-New-21-130000-Interest-04-2026-7b4149b8', '2026-06-13', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-130000-Interest-04-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-04-2026', 300.0, 0.0, 796027, 'Cash', 'Bakery 650, another 220 paid.  Balance Uday 1810', 'New Finance', '300.0'),
('Udhayakumar-New-STL126-New-21-10000-Interest-06-2026-7b4149b8', '2026-06-13', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-10000-Interest-06-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-06-2026', 20.0, 0.0, 796047, 'Cash', 'Bakery 650, another 220 paid.  Balance Uday 1810', 'New Finance', '20.0'),
('Udhayakumar-New-STL126-New-21-120000-Interest-05-2026-7b4149b8', '2026-06-13', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-120000-Interest-05-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-05-2026', 550.0, 0.0, 796597, 'Cash', 'Bakery 650, another 220 paid.  Balance Uday 1810', 'New Finance', '2680.0'),
('Viji Vasanth-New-STL313-New-67-150000-Interest-05-2026-61e1c3aa', '2026-07-07', 'Customer_Interest', 'Viji Vasanth-New-STL313-New-67-150000-Interest-05-2026', 'New-STL313', 'New-67', 'Viji Vasanth', 'Interest-05-2026', 10.0, 0.0, 796607, NULL, NULL, 'New Finance', '10.0'),
('Priya-New-STL320-New-65-New-130-220000-Interest-05-2026-8ab2fc68', '2026-07-07', 'Customer_Interest', 'Priya-New-STL320-New-65-New-130-220000-Interest-05-2026', 'New-STL320', 'New-65-New-130', 'Priya', 'Interest-05-2026', 170.0, 0.0, 796777, NULL, NULL, 'New Finance', '170.0'),
('065a14df', '2026-06-01', 'Loan_To_Customer', 'Loan_To_Customer-New-STL341-Murugesan pons', 'New-STL341', 'New-143', 'Murugesan pons', 'Loan to Customer', NULL, 200000.0, 596777, 'Cash', NULL, 'New Finance', NULL),
('5fd78757', '2026-05-31', 'Customer_Loan_Prin_Repayment', 'New-STL333-New-61-Mani Basketball-150000', 'New-STL333', 'New-61', 'Mani Basketball', 'New-61', 100000.0, NULL, 696777, 'Cash', NULL, 'New Finance', NULL),
('5ad1205d', '2026-06-01', 'Loan_To_Customer', 'Loan_To_Customer-New-STL320-Priya', 'New-STL320', 'New-144', 'Priya', 'Loan to Customer', NULL, 140000.0, 556777, 'Cash', NULL, 'New Finance', NULL),
('8f34a5cd', '2026-05-31', 'Customer_Loan_Prin_Repayment', 'New-STL303-New-66-Tharun-35000', 'New-STL303', 'New-66', 'Tharun', 'New-66', 25000.0, NULL, 581777, 'Cash', NULL, 'New Finance', NULL),
('2b6da026', '2026-05-31', 'Customer_Loan_Prin_Repayment', 'New-STL126-New-21-Udhayakumar-120000', 'New-STL126', 'New-21', 'Udhayakumar', 'New-21', 10000.0, NULL, 591777, NULL, 'udhay balance 70k', 'New Finance', '2130'),
('7d7232ca', '2026-05-31', 'Customer_Loan_Prin_Repayment', 'New-STL235-New-36-Kannan-100000', 'New-STL235', 'New-36', 'Kannan', 'New-36', 100000.0, NULL, 691777, NULL, NULL, 'New Finance', NULL),
('7db11b89', '2026-06-05', 'Loan_To_Customer', 'Loan_To_Customer-New-STL343-Prakash S M', 'New-STL343', 'New-145', 'Prakash S M', 'Loan to Customer', NULL, 80000.0, 611777, 'Cash', NULL, 'New Finance', NULL),
('bb6413e5', '2026-05-31', 'Customer_Loan_Prin_Repayment', 'New-STL153-New-48-Paramasivam-35000', 'New-STL153', 'New-48', 'Paramasivam', 'New-48', 35000.0, NULL, 646777, 'Cash', NULL, 'New Finance', '870,840,870'),
('edd14a7a', '2026-06-01', 'Loan_To_Customer', 'Loan_To_Customer-New-STL116-Vasudevan', 'New-STL116', 'New-146', 'Vasudevan', 'Loan to Customer', NULL, 35000.0, 611777, 'Cash', NULL, 'New Finance', NULL),
('df9f4412', '2026-06-10', 'Loan_To_Customer', 'Loan_To_Customer-New-STL116-Vasudevan', 'New-STL116', 'New-147', 'Vasudevan', 'Loan to Customer', NULL, 60000.0, 551777, 'Cash', 'Gold Chain', 'New Finance', NULL),
('b43815e7', '2026-06-13', 'Loan_To_Customer', 'Loan_To_Customer-New-STL339-Surya Shed', 'New-STL339', 'New-148', 'Surya Shed', 'Loan to Customer', NULL, 350000.0, 201777, 'Cash', NULL, 'New Finance', NULL),
('d230f557', '2026-06-15', 'Loan_To_Customer', 'Loan_To_Customer-New-STL344-Suresh CCTV', 'New-STL344', 'New-149', 'Suresh CCTV', 'Loan to Customer', NULL, 50000.0, 151777, 'Cash', NULL, 'New Finance', NULL),
('05a0a60e', '2026-06-22', 'Loan_To_Customer', 'Loan_To_Customer-New-STL275-Balasubramani Suresh', 'New-STL275', 'New-150', 'Balasubramani Suresh', 'Loan to Customer', NULL, 100000.0, 51777, 'Cash', NULL, 'New Finance', NULL),
('e98b8487', '2026-06-21', 'Customer_Loan_Prin_Repayment', 'New-STL292-New-14-John-150000', 'New-STL292', 'New-14', 'John', 'New-14', 150000.0, NULL, 201777, NULL, NULL, 'New Finance', NULL),
('2fa2a55b', '2026-06-16', 'Loan_To_Customer', 'Loan_To_Customer-New-STL301-Nagaraj Post', 'New-STL301', 'New-151', 'Nagaraj Post', 'Loan to Customer', NULL, 10000.0, 191777, 'Cash', NULL, 'New Finance', NULL),
('dc40b6be', '2026-06-23', 'Customer_Loan_Prin_Repayment', 'New-STL331-New-60-Nagurammal-150000', 'New-STL331', 'New-60', 'Nagurammal', 'New-60', 20000.0, NULL, 211777, NULL, NULL, 'New Finance', NULL),
('1db7ff8b', '2026-06-23', 'Customer_Loan_Prin_Repayment', 'New-STL280-New-63-Sabarish-60000', 'New-STL280', 'New-63', 'Sabarish', 'New-63', 50000.0, NULL, 261777, NULL, NULL, 'New Finance', NULL),
('64d43325', '2026-05-31', 'Customer_Loan_Prin_Repayment', 'New-STL185-New-49-Karthick-20000', 'New-STL185', 'New-49', 'Karthick', 'New-49', 20000.0, NULL, 281777, 'Cash', NULL, 'New Finance', '500,480,500'),
('b7b34bd7', '2026-05-31', 'Customer_Loan_Prin_Repayment', 'New-STL195-New-50-Manikandan-10000', 'New-STL195', 'New-50', 'Manikandan', 'New-50', 10000.0, NULL, 291777, 'Cash', NULL, 'New Finance', '1090,480,210,250'),
('50703aa6', '2026-06-01', 'Loan_To_Customer', 'Loan_To_Customer-New-STL116-Vasudevan', 'New-STL116', 'New-152', 'Vasudevan', 'Loan to Customer', NULL, 30000.0, 261777, 'Cash', NULL, 'New Finance', NULL),
('3d393dc0', '2026-05-18', 'Customer_Loan_Prin_Repayment', 'New-STL78-New-19-Dinesh-10000', 'New-STL78', 'New-19', 'Dinesh', 'New-19', 10000.0, NULL, 271777, NULL, NULL, 'New Finance', '210'),
('3463bdcd', '2026-07-01', 'Loan_To_Customer', 'Loan_To_Customer-New-STL270-Arul S', 'New-STL270', 'New-153', 'Arul S', 'Loan to Customer', NULL, 40000.0, 231777, 'Cash', NULL, 'New Finance', NULL),
('b3c6f573', '2026-07-01', 'Loan_To_Customer', 'Loan_To_Customer-New-STL306-Ravi', 'New-STL306', 'New-154', 'Ravi', 'Loan to Customer', NULL, 75000.0, 156777, 'Cash', NULL, 'New Finance', NULL),
('4a4adeab', '2026-06-30', 'Customer_Loan_Prin_Repayment', 'New-STL341-New-141-Murugesan pons-80000', 'New-STL341', 'New-141', 'Murugesan pons', 'New-141', 70000.0, NULL, 226777, NULL, NULL, 'New Finance', '5880'),
('49cbb42e', '2026-07-01', 'Loan_To_Customer', 'Loan_To_Customer-New-STL280-Sabarish', 'New-STL280', 'New-155', 'Sabarish', 'Loan to Customer', NULL, 25000.0, 201777, 'Cash', NULL, 'New Finance', NULL);
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('0ea520e7', '2026-07-07', 'Loan_To_Customer', 'Loan_To_Customer-New-STL345-Kamaraj Prakash', 'New-STL345', 'New-156', 'Kamaraj Prakash', 'Loan to Customer', NULL, 50000.0, 151777, 'Cash', 'Given in prakash finance', 'New Finance', NULL),
('b2d294c5', '2026-07-07', 'Customer_Loan_Prin_Repayment', 'New-STL342-New-142-Jeyaraj pons-50000', 'New-STL342', 'New-142', 'Jeyaraj pons', 'New-142', 50000.0, NULL, 201777, 'Cash', NULL, 'New Finance', '1050'),
('3cbbb293', '2026-07-10', 'Loan_To_Customer', 'Loan_To_Customer-New-STL326-Murugesan', 'New-STL326', 'New-157', 'Murugesan', 'Loan to Customer', NULL, 200000.0, 1777, 'Cash', NULL, 'New Finance', NULL),
('a3078463', '2026-07-12', 'Customer_Loan_Prin_Repayment', 'New-STL341-New-143-Murugesan pons-200000', 'New-STL341', 'New-143', 'Murugesan pons', 'New-143', 200000.0, NULL, 201777, 'Cash', NULL, 'New Finance', '5880,420'),
('fe6364b2', '2026-07-13', 'Loan_To_Customer', 'Loan_To_Customer-New-STL346-Gopal post', 'New-STL346', 'New-158', 'Gopal post', 'Loan to Customer', NULL, 250000.0, -48223, 'Cash', 'Total 5 lacs, 2.5 in my personal', 'New Finance', NULL),
('85eb60db', '2026-07-14', 'Customer_Loan_Prin_Repayment', 'New-STL323-New-125-Kaviyarasu Arul-200000', 'New-STL323', 'New-125', 'Kaviyarasu Arul', 'New-125', 50000.0, NULL, 1777, NULL, NULL, 'New Finance', '19950'),
('d8f9533d', '2026-07-14', 'Customer_Loan_Prin_Repayment', 'New-STL326-New-157-Murugesan-200000', 'New-STL326', 'New-157', 'Murugesan', 'New-157', 200000.0, NULL, 201777, NULL, NULL, 'New Finance', '480'),
('f70057a6', '2026-07-15', 'Loan_To_Customer', 'Loan_To_Customer-New-STL347-Vinoth Ravi vangalamman', 'New-STL347', 'New-159', 'Vinoth Ravi vangalamman', 'Loan to Customer', NULL, 250000.0, -48223, 'Cash', NULL, 'New Finance', NULL),
('71158ff6', '2026-07-15', 'Customer_Loan_Prin_Repayment', 'New-STL227-New-127-Nandhakumar-200000', 'New-STL227', 'New-127', 'Nandhakumar', 'New-127', 50000.0, NULL, 1777, 'Cash', NULL, 'New Finance', '4200'),
('d7542db1', '2026-07-18', 'Loan_To_Customer', 'Loan_To_Customer-New-STL341-Murugesan pons', 'New-STL341', 'New-160', 'Murugesan pons', 'Loan to Customer', NULL, 15000.0, -13223, 'Cash', NULL, 'New Finance', NULL),
('c0e64b1f', '2026-07-21', 'Customer_Loan_Prin_Repayment', 'New-STL319-New-72-RanjithKumar-200000', 'New-STL319', 'New-72', 'RanjithKumar', 'New-72', 200000.0, NULL, 186777, 'Cash', NULL, 'New Finance', '4200'),
('8ffd771b', '2026-07-21', 'Customer_Loan_Prin_Repayment', 'New-STL347-New-159-Vinoth Ravi vangalamman-250000', 'New-STL347', 'New-159', 'Vinoth Ravi vangalamman', 'New-159', 250000.0, NULL, 436777, NULL, NULL, 'New Finance', NULL),
('24c48029', '2026-07-23', 'Loan_To_Customer', 'Loan_To_Customer-New-STL348-Gobinath', 'New-STL348', 'New-161', 'Gobinath', 'Loan to Customer', NULL, 200000.0, 236777, 'Cash', 'Naveen Arun Kumbaa', 'New Finance', NULL),
('12993f58', '2026-07-25', 'Loan_To_Customer', 'Loan_To_Customer-New-STL304-Sakthivel Jayaraj', 'New-STL304', 'New-162', 'Sakthivel Jayaraj', 'Loan to Customer', NULL, 100000.0, 136777, 'Cash', NULL, 'New Finance', NULL),
('950f62ce', '2026-07-28', 'Customer_Loan_Prin_Repayment', 'New-STL306-New-154-Ravi-75000', 'New-STL306', 'New-154', 'Ravi', 'New-154', 75000.0, NULL, 211777, 'Cash', 'Tharun Tex gave', 'New Finance', '480'),
('Nagaraj Post-New-STL301-New-11-30000-Interest-03-2026-2ca3ca89', '2026-06-16', 'Customer_Interest', 'Nagaraj Post-New-STL301-New-11-30000-Interest-03-2026', 'New-STL301', 'New-11', 'Nagaraj Post', 'Interest-03-2026', 740.0, 0.0, 212517, NULL, NULL, 'New Finance', '750.0'),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-05-2026-0a819269', '2026-07-19', 'Customer_Interest', 'Suresh Abudhabi-New-STL273-New-23-60000-Interest-05-2026', 'New-STL273', 'New-23', 'Suresh Abudhabi', 'Interest-05-2026', 650.0, 0.0, 213167, 'UPI', NULL, 'New Finance', '650.0'),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-06-2026-0a819269', '2026-07-19', 'Customer_Interest', 'Suresh Abudhabi-New-STL273-New-23-60000-Interest-06-2026', 'New-STL273', 'New-23', 'Suresh Abudhabi', 'Interest-06-2026', 650.0, 0.0, 213817, 'UPI', NULL, 'New Finance', '1260.0'),
('Udhayakumar-New-STL126-New-21-120000-Interest-05-2026-b5f787b8', '2026-07-13', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-120000-Interest-05-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-05-2026', 2130.0, 0.0, 215947, NULL, NULL, 'New Finance', '2130.0'),
('Udhayakumar-New-STL126-New-21-110000-Interest-06-2026-b5f787b8', '2026-07-13', 'Customer_Interest', 'Udhayakumar-New-STL126-New-21-110000-Interest-06-2026', 'New-STL126', 'New-21', 'Udhayakumar', 'Interest-06-2026', 550.0, 0.0, 216497, NULL, NULL, 'New Finance', '2310.0'),
('Jayapal-New-STL121-New-20-100000-Interest-03-2026-fe22431e', '2026-07-17', 'Customer_Interest', 'Jayapal-New-STL121-New-20-100000-Interest-03-2026', 'New-STL121', 'New-20', 'Jayapal', 'Interest-03-2026', 2170.0, 0.0, 218667, NULL, NULL, 'New Finance', '2170.0'),
('Karnan-New-STL160-New-31-400000-Interest-03-2026-01d6917e', '2026-07-16', 'Customer_Interest', 'Karnan-New-STL160-New-31-400000-Interest-03-2026', 'New-STL160', 'New-31', 'Karnan', 'Interest-03-2026', 8680.0, 0.0, 227347, NULL, NULL, 'New Finance', '8680.0'),
('Danendran-New-STL46-New-29-95000-Interest-03-2026-fecbd6fe', '2026-07-17', 'Customer_Interest', 'Danendran-New-STL46-New-29-95000-Interest-03-2026', 'New-STL46', 'New-29', 'Danendran', 'Interest-03-2026', 2060.0, 0.0, 229407, NULL, NULL, 'New Finance', '2060.0'),
('Manivannan-New-STL182-New-41-300000-Interest-04-2026-c98f6cd4', '2026-07-07', 'Customer_Interest', 'Manivannan-New-STL182-New-41-300000-Interest-04-2026', 'New-STL182', 'New-41', 'Manivannan', 'Interest-04-2026', 6300.0, 0.0, 235707, 'UPI', NULL, 'New Finance', '6300.0'),
('Manivannan-New-STL182-New-41-300000-Interest-05-2026-c98f6cd4', '2026-07-07', 'Customer_Interest', 'Manivannan-New-STL182-New-41-300000-Interest-05-2026', 'New-STL182', 'New-41', 'Manivannan', 'Interest-05-2026', 210.0, 0.0, 235917, 'UPI', NULL, 'New Finance', '6510.0'),
('Kalimuthu-New-STL248-New-44-50000-Interest-05-2026-a2f20901', '2026-07-15', 'Customer_Interest', 'Kalimuthu-New-STL248-New-44-50000-Interest-05-2026', 'New-STL248', 'New-44', 'Kalimuthu', 'Interest-05-2026', 1090.0, 0.0, 237007, NULL, NULL, 'New Finance', '1090.0'),
('Selvaguru-New-STL35-New-46-150000-Interest-03-2026-f8327235', '2026-07-31', 'Customer_Interest', 'Selvaguru-New-STL35-New-46-150000-Interest-03-2026', 'New-STL35', 'New-46', 'Selvaguru', 'Interest-03-2026', 3260.0, 0.0, 240267, NULL, NULL, 'New Finance', '3260.0'),
('Vasudevan-New-STL116-New-47-450000-Interest-03-2026-c2a916bc', '2026-07-17', 'Customer_Interest', 'Vasudevan-New-STL116-New-47-450000-Interest-03-2026', 'New-STL116', 'New-47', 'Vasudevan', 'Interest-03-2026', 9550.0, 0.0, 249817, NULL, NULL, 'New Finance', '9770.0'),
('Paramasivam-New-STL153-New-48-35000-Interest-03-2026-19a357e7', '2026-07-17', 'Customer_Interest', 'Paramasivam-New-STL153-New-48-35000-Interest-03-2026', 'New-STL153', 'New-48', 'Paramasivam', 'Interest-03-2026', 870.0, 0.0, 250687, NULL, NULL, 'New Finance', '870.0'),
('Karthick-New-STL185-New-49-20000-Interest-03-2026-2f0ed154', '2026-07-17', 'Customer_Interest', 'Karthick-New-STL185-New-49-20000-Interest-03-2026', 'New-STL185', 'New-49', 'Karthick', 'Interest-03-2026', 500.0, 0.0, 251187, NULL, NULL, 'New Finance', '500.0'),
('Manikandan-New-STL195-New-50-50000-Interest-03-2026-6e94f77c', '2026-07-17', 'Customer_Interest', 'Manikandan-New-STL195-New-50-50000-Interest-03-2026', 'New-STL195', 'New-50', 'Manikandan', 'Interest-03-2026', 250.0, 0.0, 251437, NULL, NULL, 'New Finance', '1090.0'),
('Pradeep-New-STL123-New-51-100000-Interest-03-2026-6bdb2288', '2026-07-17', 'Customer_Interest', 'Pradeep-New-STL123-New-51-100000-Interest-03-2026', 'New-STL123', 'New-51', 'Pradeep_NPA', 'Interest-03-2026', 2170.0, 0.0, 253607, NULL, NULL, 'New Finance', '2170.0'),
('Jayaraj-New-STL277-New-24-50000-Interest-02-2026-1b64824b', '2026-05-16', 'Customer_Interest', 'Jayaraj-New-STL277-New-24-50000-Interest-02-2026', 'New-STL277', 'New-24', 'Jayaraj', 'Interest-02-2026', 0.0, 0.0, 253607, NULL, NULL, 'New Finance', '980.0'),
('Jayaraj-New-STL277-New-24-50000-Interest-02-2026-296725b5', '2026-07-31', 'Customer_Interest', 'Jayaraj-New-STL277-New-24-50000-Interest-02-2026', 'New-STL277', 'New-24', 'Jayaraj', 'Interest-02-2026', 980.0, 0.0, 254587, NULL, NULL, 'New Finance', '980.0'),
('Ramasamy Divya-New-STL156-New-7-50000-Interest-03-2026-35bae083', '2026-06-06', 'Customer_Interest', 'Ramasamy Divya-New-STL156-New-7-50000-Interest-03-2026', 'New-STL156', 'New-7', 'Ramasamy Divya', 'Interest-03-2026', 1090.0, 0.0, 255677, NULL, NULL, 'New Finance', '1090.0'),
('Nagaraj Post-New-STL301-New-11-30000-Interest-03-2026-f826210e', '2026-06-06', 'Customer_Interest', 'Nagaraj Post-New-STL301-New-11-30000-Interest-03-2026', 'New-STL301', 'New-11', 'Nagaraj Post', 'Interest-03-2026', 10.0, 0.0, 255687, NULL, NULL, 'New Finance', '10.0'),
('Nagaraj Post-New-STL301-New-11-30000-Interest-04-2026-f826210e', '2026-06-06', 'Customer_Interest', 'Nagaraj Post-New-STL301-New-11-30000-Interest-04-2026', 'New-STL301', 'New-11', 'Nagaraj Post', 'Interest-04-2026', 720.0, 0.0, 256407, NULL, NULL, 'New Finance', '720.0'),
('Nagaraj Post-New-STL301-New-11-30000-Interest-05-2026-f826210e', '2026-06-06', 'Customer_Interest', 'Nagaraj Post-New-STL301-New-11-30000-Interest-05-2026', 'New-STL301', 'New-11', 'Nagaraj Post', 'Interest-05-2026', 20.0, 0.0, 256427, NULL, NULL, 'New Finance', '740.0'),
('Vasudevan-New-STL116-New-47-450000-Interest-03-2026-e598349a', '2026-05-15', 'Customer_Interest', 'Vasudevan-New-STL116-New-47-450000-Interest-03-2026', 'New-STL116', 'New-47', 'Vasudevan', 'Interest-03-2026', 220.0, 0.0, 256647, NULL, NULL, 'New Finance', '220.0'),
('Vasudevan-New-STL116-New-47-450000-Interest-04-2026-e598349a', '2026-05-15', 'Customer_Interest', 'Vasudevan-New-STL116-New-47-450000-Interest-04-2026', 'New-STL116', 'New-47', 'Vasudevan', 'Interest-04-2026', 9450.0, 0.0, 266097, NULL, NULL, 'New Finance', '9450.0'),
('Vasudevan-New-STL116-New-47-440000-Interest-05-2026-e598349a', '2026-05-15', 'Customer_Interest', 'Vasudevan-New-STL116-New-47-440000-Interest-05-2026', 'New-STL116', 'New-47', 'Vasudevan', 'Interest-05-2026', 90.0, 0.0, 266187, NULL, NULL, 'New Finance', '9550.0'),
('Manikandan-New-STL195-New-50-50000-Interest-03-2026-b69f985a', '2026-05-15', 'Customer_Interest', 'Manikandan-New-STL195-New-50-50000-Interest-03-2026', 'New-STL195', 'New-50', 'Manikandan', 'Interest-03-2026', 840.0, 0.0, 267027, NULL, NULL, 'New Finance', '840.0'),
('Manikandan-New-STL195-New-50-40000-Interest-04-2026-b69f985a', '2026-05-15', 'Customer_Interest', 'Manikandan-New-STL195-New-50-40000-Interest-04-2026', 'New-STL195', 'New-50', 'Manikandan', 'Interest-04-2026', 250.0, 0.0, 267277, NULL, NULL, 'New Finance', '480.0'),
('Divakar-New-STL318-New-53-25000-Interest-03-2026-924696d6', '2026-04-15', 'Customer_Interest', 'Divakar-New-STL318-New-53-25000-Interest-03-2026', 'New-STL318', 'New-53', 'Divakar Vasu', 'Interest-03-2026', 620.0, 0.0, 267897, NULL, NULL, 'New Finance', '620.0'),
('Jayaraj-New-STL277-New-70-200000-Interest-03-2026-0bdc2d84', '2026-05-16', 'Customer_Interest', 'Jayaraj-New-STL277-New-70-200000-Interest-03-2026', 'New-STL277', 'New-70', 'Jayaraj', 'Interest-03-2026', 420.0, 0.0, 268317, NULL, NULL, 'New Finance', '420.0'),
('Jayaraj-New-STL277-New-24-50000-Interest-03-2026-0bdc2d84', '2026-05-16', 'Customer_Interest', 'Jayaraj-New-STL277-New-24-50000-Interest-03-2026', 'New-STL277', 'New-24', 'Jayaraj', 'Interest-03-2026', 810.0, 0.0, 269127, NULL, NULL, 'New Finance', '810.0'),
('Ramasamy Divya-New-STL156-New-7-50000-Interest-04-2026-829ad987', '2026-06-15', 'Customer_Interest', 'Ramasamy Divya-New-STL156-New-7-50000-Interest-04-2026', 'New-STL156', 'New-7', 'Ramasamy Divya', 'Interest-04-2026', 1050.0, 0.0, 270177, NULL, NULL, 'New Finance', '1050.0'),
('Jayapal-New-STL121-New-20-100000-Interest-04-2026-cc1cc5c0', '2026-06-19', 'Customer_Interest', 'Jayapal-New-STL121-New-20-100000-Interest-04-2026', 'New-STL121', 'New-20', 'Jayapal', 'Interest-04-2026', 2100.0, 0.0, 272277, NULL, NULL, 'New Finance', '2100.0'),
('Danendran-New-STL46-New-29-95000-Interest-04-2026-c1950dbe', '2026-06-19', 'Customer_Interest', 'Danendran-New-STL46-New-29-95000-Interest-04-2026', 'New-STL46', 'New-29', 'Danendran', 'Interest-04-2026', 2000.0, 0.0, 274277, NULL, NULL, 'New Finance', '2000.0'),
('Karnan-New-STL160-New-31-400000-Interest-04-2026-de5429aa', '2026-06-19', 'Customer_Interest', 'Karnan-New-STL160-New-31-400000-Interest-04-2026', 'New-STL160', 'New-31', 'Karnan', 'Interest-04-2026', 8400.0, 0.0, 282677, NULL, NULL, 'New Finance', '8400.0'),
('Selvaguru-New-STL35-New-46-150000-Interest-04-2026-089e9e02', '2026-07-07', 'Customer_Interest', 'Selvaguru-New-STL35-New-46-150000-Interest-04-2026', 'New-STL35', 'New-46', 'Selvaguru', 'Interest-04-2026', 3150.0, 0.0, 285827, NULL, NULL, 'New Finance', '3150.0'),
('Paramasivam-New-STL153-New-48-35000-Interest-04-2026-a3ca0e8c', '2026-06-19', 'Customer_Interest', 'Paramasivam-New-STL153-New-48-35000-Interest-04-2026', 'New-STL153', 'New-48', 'Paramasivam', 'Interest-04-2026', 840.0, 0.0, 286667, NULL, NULL, 'New Finance', '840.0'),
('Karthick-New-STL185-New-49-20000-Interest-04-2026-3b5107da', '2026-06-19', 'Customer_Interest', 'Karthick-New-STL185-New-49-20000-Interest-04-2026', 'New-STL185', 'New-49', 'Karthick', 'Interest-04-2026', 480.0, 0.0, 287147, NULL, NULL, 'New Finance', '480.0'),
('Manikandan-New-STL195-New-50-40000-Interest-04-2026-b4743cf7', '2026-06-19', 'Customer_Interest', 'Manikandan-New-STL195-New-50-40000-Interest-04-2026', 'New-STL195', 'New-50', 'Manikandan', 'Interest-04-2026', 230.0, 0.0, 287377, NULL, NULL, 'New Finance', '230.0'),
('Manikandan-New-STL195-New-50-10000-Interest-04-2026-b4743cf7', '2026-06-19', 'Customer_Interest', 'Manikandan-New-STL195-New-50-10000-Interest-04-2026', 'New-STL195', 'New-50', 'Manikandan', 'Interest-04-2026', 210.0, 0.0, 287587, NULL, NULL, 'New Finance', '210.0'),
('Manikandan-New-STL195-New-50-10000-Interest-05-2026-b4743cf7', '2026-06-19', 'Customer_Interest', 'Manikandan-New-STL195-New-50-10000-Interest-05-2026', 'New-STL195', 'New-50', 'Manikandan', 'Interest-05-2026', 250.0, 0.0, 287837, NULL, NULL, 'New Finance', '250.0'),
('Pradeep_NPA-New-STL123-New-51-100000-Interest-04-2026-2dbb551e', '2026-06-19', 'Customer_Interest', 'Pradeep_NPA-New-STL123-New-51-100000-Interest-04-2026', 'New-STL123', 'New-51', 'Pradeep_NPA', 'Interest-04-2026', 2100.0, 0.0, 289937, NULL, NULL, 'New Finance', '2100.0'),
('Nagaraj Post-New-STL301-New-11-30000-Interest-05-2026-37cfba0e', '2026-07-16', 'Customer_Interest', 'Nagaraj Post-New-STL301-New-11-30000-Interest-05-2026', 'New-STL301', 'New-11', 'Nagaraj Post', 'Interest-05-2026', 720.0, 0.0, 290657, NULL, 'Loan', 'New Finance', '720.0'),
('Nagaraj Post-New-STL301-New-11-New-151-40000-Interest-06-2026-37cfba0e', '2026-07-16', 'Customer_Interest', 'Nagaraj Post-New-STL301-New-11-New-151-40000-Interest-06-2026', 'New-STL301', 'New-11-New-151', 'Nagaraj Post', 'Interest-06-2026', 20.0, 0.0, 290677, NULL, 'Loan', 'New Finance', '840.0'),
('Jayapal-New-STL121-New-20-100000-Interest-05-2026-75f30982', '2026-07-17', 'Customer_Interest', 'Jayapal-New-STL121-New-20-100000-Interest-05-2026', 'New-STL121', 'New-20', 'Jayapal', 'Interest-05-2026', 2170.0, 0.0, 292847, NULL, NULL, 'New Finance', '2170.0'),
('Danendran-New-STL46-New-29-95000-Interest-05-2026-559ce8b2', '2026-07-17', 'Customer_Interest', 'Danendran-New-STL46-New-29-95000-Interest-05-2026', 'New-STL46', 'New-29', 'Danendran', 'Interest-05-2026', 2060.0, 0.0, 294907, NULL, NULL, 'New Finance', '2060.0'),
('Karnan-New-STL160-New-31-400000-Interest-05-2026-b108da2a', '2026-07-16', 'Customer_Interest', 'Karnan-New-STL160-New-31-400000-Interest-05-2026', 'New-STL160', 'New-31', 'Karnan', 'Interest-05-2026', 8680.0, 0.0, 303587, NULL, NULL, 'New Finance', '8680.0'),
('Manivannan-New-STL182-New-41-300000-Interest-05-2026-b5fcdd9b', '2026-07-07', 'Customer_Interest', 'Manivannan-New-STL182-New-41-300000-Interest-05-2026', 'New-STL182', 'New-41', 'Manivannan', 'Interest-05-2026', 6300.0, 0.0, 309887, NULL, NULL, 'New Finance', '6300.0'),
('Manivannan-New-STL182-New-41-300000-Interest-06-2026-b5fcdd9b', '2026-07-07', 'Customer_Interest', 'Manivannan-New-STL182-New-41-300000-Interest-06-2026', 'New-STL182', 'New-41', 'Manivannan', 'Interest-06-2026', 210.0, 0.0, 310097, NULL, NULL, 'New Finance', '6300.0'),
('Selvaguru-New-STL35-New-46-150000-Interest-05-2026-348e682d', '2026-07-31', 'Customer_Interest', 'Selvaguru-New-STL35-New-46-150000-Interest-05-2026', 'New-STL35', 'New-46', 'Selvaguru', 'Interest-05-2026', 3260.0, 0.0, 313357, NULL, NULL, 'New Finance', '3260.0'),
('Vasudevan-New-STL116-New-47-440000-Interest-05-2026-250e68a7', '2026-07-17', 'Customer_Interest', 'Vasudevan-New-STL116-New-47-440000-Interest-05-2026', 'New-STL116', 'New-47', 'Vasudevan', 'Interest-05-2026', 9460.0, 0.0, 322817, NULL, NULL, 'New Finance', '9460.0'),
('Vasudevan-New-STL116-New-47-New-146-New-147-New-152-565000-Interest-06-2026-250e68a7', '2026-07-17', 'Customer_Interest', 'Vasudevan-New-STL116-New-47-New-146-New-147-New-152-565000-Interest-06-2026', 'New-STL116', 'New-47-New-146-New-147-New-152', 'Vasudevan', 'Interest-06-2026', 90.0, 0.0, 322907, NULL, NULL, 'New Finance', '11490.0'),
('Paramasivam-New-STL153-New-48-35000-Interest-05-2026-8bf4fbfa', '2026-07-17', 'Customer_Interest', 'Paramasivam-New-STL153-New-48-35000-Interest-05-2026', 'New-STL153', 'New-48', 'Paramasivam', 'Interest-05-2026', 870.0, 0.0, 323777, NULL, NULL, 'New Finance', '870.0'),
('Karthick-New-STL185-New-49-20000-Interest-05-2026-4bce3d2c', '2026-07-17', 'Customer_Interest', 'Karthick-New-STL185-New-49-20000-Interest-05-2026', 'New-STL185', 'New-49', 'Karthick', 'Interest-05-2026', 500.0, 0.0, 324277, NULL, NULL, 'New Finance', '500.0'),
('Pradeep_NPA-New-STL123-New-51-100000-Interest-05-2026-aeee6e34', '2026-07-17', 'Customer_Interest', 'Pradeep_NPA-New-STL123-New-51-100000-Interest-05-2026', 'New-STL123', 'New-51', 'Pradeep_NPA', 'Interest-05-2026', 2170.0, 0.0, 326447, NULL, NULL, 'New Finance', '2170.0'),
('Sundaravadivel-New-STL271-New-9-New-132-100000-Interest-06-2026-48137906', '2026-07-15', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-9-New-132-100000-Interest-06-2026', 'New-STL271', 'New-9-New-132', 'Sundaravadivel', 'Interest-06-2026', 2100.0, 0.0, 328547, NULL, NULL, 'New Finance', '2100.0'),
('Balasubramani Suresh-New-STL275-New-10-New-64-New-131-New-150-400000-Interest-06-2026-c02f1116', '2026-07-20', 'Customer_Interest', 'Balasubramani Suresh-New-STL275-New-10-New-64-New-131-New-150-400000-Interest-06-2026', 'New-STL275', 'New-10-New-64-New-131-New-150', 'Balasubramani Suresh', 'Interest-06-2026', 6930.0, 0.0, 335477, NULL, NULL, 'New Finance', '6930.0'),
('Nagaraj Post-New-STL301-New-11-New-151-40000-Interest-06-2026-fbb339e8', '2026-07-24', 'Customer_Interest', 'Nagaraj Post-New-STL301-New-11-New-151-40000-Interest-06-2026', 'New-STL301', 'New-11-New-151', 'Nagaraj Post', 'Interest-06-2026', 820.0, 0.0, 336297, NULL, NULL, 'New Finance', '820.0'),
('Priya-New-STL320-New-65-New-130-New-144-360000-Interest-06-2026-e42d6d9c', '2026-07-03', 'Customer_Interest', 'Priya-New-STL320-New-65-New-130-New-144-360000-Interest-06-2026', 'New-STL320', 'New-65-New-130-New-144', 'Priya', 'Interest-06-2026', 7560.0, 0.0, 343857, NULL, NULL, 'New Finance', '7560.0'),
('Arul M-New-STL330-New-13-New-62-New-68-55000-Interest-06-2026-acae5019', '2026-07-17', 'Customer_Interest', 'Arul M-New-STL330-New-13-New-62-New-68-55000-Interest-06-2026', 'New-STL330', 'New-13-New-62-New-68', 'Arul M', 'Interest-06-2026', 1160.0, 0.0, 345017, NULL, NULL, 'New Finance', '1160.0'),
('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-06-2026-583fe56c', '2026-07-16', 'Customer_Interest', 'Manoj raghavendra shop-New-STL336-New-129-10000-Interest-06-2026', 'New-STL336', 'New-129', 'Manoj raghavendra shop', 'Interest-06-2026', 210.0, 0.0, 345227, NULL, NULL, 'New Finance', '210.0'),
('Surya Shed-New-STL339-New-135-New-136-New-148-490000-Interest-06-2026-f53117fc', '2026-07-27', 'Customer_Interest', 'Surya Shed-New-STL339-New-135-New-136-New-148-490000-Interest-06-2026', 'New-STL339', 'New-135-New-136-New-148', 'Surya Shed', 'Interest-06-2026', 7350.0, 0.0, 352577, NULL, NULL, 'New Finance', '7350.0'),
('Sankara Narayanan-New-STL179-New-1-300000-Interest-06-2026-fb5b0a66', '2026-07-15', 'Customer_Interest', 'Sankara Narayanan-New-STL179-New-1-300000-Interest-06-2026', 'New-STL179', 'New-1', 'Sankara Narayanan', 'Interest-06-2026', 6300.0, 0.0, 358877, NULL, NULL, 'New Finance', '6300.0'),
('Ramesh-New-STL257-New-2-30000-Interest-06-2026-924f495a', '2026-07-06', 'Customer_Interest', 'Ramesh-New-STL257-New-2-30000-Interest-06-2026', 'New-STL257', 'New-2', 'Ramesh', 'Interest-06-2026', 720.0, 0.0, 359597, NULL, NULL, 'New Finance', '720.0'),
('Arul S-New-STL270-New-3-70000-Interest-06-2026-78a45dca', '2026-07-29', 'Customer_Interest', 'Arul S-New-STL270-New-3-70000-Interest-06-2026', 'New-STL270', 'New-3', 'Arul S', 'Interest-06-2026', 1470.0, 0.0, 361067, NULL, NULL, 'New Finance', '1470.0'),
('Rangis-New-STL295-New-4-100000-Interest-06-2026-ba0d246d', '2026-07-12', 'Customer_Interest', 'Rangis-New-STL295-New-4-100000-Interest-06-2026', 'New-STL295', 'New-4', 'Rangis', 'Interest-06-2026', 2100.0, 0.0, 363167, NULL, NULL, 'New Finance', '2100.0'),
('RanjithKumar-New-STL319-New-72-200000-Interest-06-2026-485dbadc', '2026-07-10', 'Customer_Interest', 'RanjithKumar-New-STL319-New-72-200000-Interest-06-2026', 'New-STL319', 'New-72', 'RanjithKumar', 'Interest-06-2026', 4200.0, 0.0, 367367, NULL, NULL, 'New Finance', '4200.0'),
('Kaviraj-New-STL338-New-133-10000-Interest-06-2026-9023a51b', '2026-07-16', 'Customer_Interest', 'Kaviraj-New-STL338-New-133-10000-Interest-06-2026', 'New-STL338', 'New-133', 'Kaviraj', 'Interest-06-2026', 240.0, 0.0, 367607, NULL, NULL, 'New Finance', '240.0'),
('Suresh CCTV-New-STL344-New-149-50000-Interest-06-2026-88d833d4', '2026-07-07', 'Customer_Interest', 'Suresh CCTV-New-STL344-New-149-50000-Interest-06-2026', 'New-STL344', 'New-149', 'Suresh CCTV', 'Interest-06-2026', 560.0, 0.0, 368167, NULL, NULL, 'New Finance', '560.0'),
('Tharun-New-STL303-New-66-10000-Interest-06-2026-4da5c2b0', '2026-07-17', 'Customer_Interest', 'Tharun-New-STL303-New-66-10000-Interest-06-2026', 'New-STL303', 'New-66', 'Tharun', 'Interest-06-2026', 240.0, 0.0, 368407, NULL, NULL, 'New Finance', '240.0'),
('Praveen Ram-New-STL324-New-16-80000-Interest-06-2026-09a1d1e4', '2026-07-17', 'Customer_Interest', 'Praveen Ram-New-STL324-New-16-80000-Interest-06-2026', 'New-STL324', 'New-16', 'Praveen Ram', 'Interest-06-2026', 1680.0, 0.0, 370087, NULL, NULL, 'New Finance', '1680.0'),
('Viji Vasanth-New-STL313-New-67-150000-Interest-06-2026-9f17954a', '2026-07-04', 'Customer_Interest', 'Viji Vasanth-New-STL313-New-67-150000-Interest-06-2026', 'New-STL313', 'New-67', 'Viji Vasanth', 'Interest-06-2026', 3150.0, 0.0, 373237, NULL, NULL, 'New Finance', '3150.0'),
('Bala kaarthi-New-STL340-New-139-200000-Interest-06-2026-aef27d80', '2026-07-08', 'Customer_Interest', 'Bala kaarthi-New-STL340-New-139-200000-Interest-06-2026', 'New-STL340', 'New-139', 'Bala kaarthi', 'Interest-06-2026', 4200.0, 0.0, 377437, NULL, NULL, 'New Finance', '4200.0'),
('Sabarish-New-STL280-New-63-50000-Interest-06-2026-594aecfd', '2026-07-02', 'Customer_Interest', 'Sabarish-New-STL280-New-63-50000-Interest-06-2026', 'New-STL280', 'New-63', 'Sabarish', 'Interest-06-2026', 810.0, 0.0, 378247, NULL, NULL, 'New Finance', '810.0'),
('Sabarish-New-STL280-New-63-10000-Interest-06-2026-594aecfd', '2026-07-02', 'Customer_Interest', 'Sabarish-New-STL280-New-63-10000-Interest-06-2026', 'New-STL280', 'New-63', 'Sabarish', 'Interest-06-2026', 210.0, 0.0, 378457, NULL, NULL, 'New Finance', '210.0'),
('Dinesh-New-STL78-New-19-10000-Interest-06-2026-7a475aae', '2026-07-03', 'Customer_Interest', 'Dinesh-New-STL78-New-19-10000-Interest-06-2026', 'New-STL78', 'New-19', 'Dinesh', 'Interest-06-2026', 210.0, 0.0, 378667, NULL, NULL, 'New Finance', '210.0'),
('Suresh Abudhabi-New-STL273-New-23-60000-Interest-06-2026-22fc41e7', '2026-07-19', 'Customer_Interest', 'Suresh Abudhabi-New-STL273-New-23-60000-Interest-06-2026', 'New-STL273', 'New-23', 'Suresh Abudhabi', 'Interest-06-2026', 610.0, 0.0, 379277, NULL, NULL, 'New Finance', '610.0'),
('Yagappan-New-STL278-New-25-20000-Interest-06-2026-7780d02e', '2026-07-18', 'Customer_Interest', 'Yagappan-New-STL278-New-25-20000-Interest-06-2026', 'New-STL278', 'New-25', 'Yagappan', 'Interest-06-2026', 480.0, 0.0, 379757, NULL, NULL, 'New Finance', '480.0'),
('Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-06-2026-619b8f6f', '2026-07-01', 'Customer_Interest', 'Sakthivel Jayaraj-New-STL304-New-26-100000-Interest-06-2026', 'New-STL304', 'New-26', 'Sakthivel Jayaraj', 'Interest-06-2026', 2100.0, 0.0, 381857, NULL, NULL, 'New Finance', '2100.0'),
('Mahesh-New-STL308-New-27-50000-Interest-06-2026-e4d26e5a', '2026-07-13', 'Customer_Interest', 'Mahesh-New-STL308-New-27-50000-Interest-06-2026', 'New-STL308', 'New-27', 'Mahesh', 'Interest-06-2026', 1050.0, 0.0, 382907, NULL, NULL, 'New Finance', '1050.0'),
('Murugesan pons-New-STL341-New-141-New-143-280000-Interest-06-2026-85836ada', '2026-07-03', 'Customer_Interest', 'Murugesan pons-New-STL341-New-141-New-143-280000-Interest-06-2026', 'New-STL341', 'New-141-New-143', 'Murugesan pons', 'Interest-06-2026', 5880.0, 0.0, 388787, NULL, NULL, 'New Finance', '5880.0'),
('Jeyaraj pons-New-STL342-New-142-50000-Interest-06-2026-1c7b0f4b', '2026-07-08', 'Customer_Interest', 'Jeyaraj pons-New-STL342-New-142-50000-Interest-06-2026', 'New-STL342', 'New-142', 'Jeyaraj pons', 'Interest-06-2026', 1050.0, 0.0, 389837, NULL, NULL, 'New Finance', '1050.0'),
('Karthi cake shop-New-STL337-New-128-200000-Interest-06-2026-feda0727', '2026-07-11', 'Customer_Interest', 'Karthi cake shop-New-STL337-New-128-200000-Interest-06-2026', 'New-STL337', 'New-128', 'Karthi cake shop', 'Interest-06-2026', 4200.0, 0.0, 394037, NULL, NULL, 'New Finance', '4200.0'),
('Kaviyarasu Arul-New-STL323-New-28-New-125-950000-Interest-06-2026-30af8ab7', '2026-07-11', 'Customer_Interest', 'Kaviyarasu Arul-New-STL323-New-28-New-125-950000-Interest-06-2026', 'New-STL323', 'New-28-New-125', 'Kaviyarasu Arul', 'Interest-06-2026', 19950.0, 0.0, 413987, NULL, NULL, 'New Finance', '19950.0'),
('Rajendran-New-STL58-New-30-15000-Interest-06-2026-25a4674e', '2026-07-17', 'Customer_Interest', 'Rajendran-New-STL58-New-30-15000-Interest-06-2026', 'New-STL58', 'New-30', 'Rajendran', 'Interest-06-2026', 360.0, 0.0, 414347, NULL, NULL, 'New Finance', '360.0');
insert into "Transaction_Ledger" ("Ref_ID", "Date_Transaction", "Nature_Transaction", "ID", "STL_No", "Loan_No", "Customer_Name", "Description", "Receipt_Amount", "Payment_Amount", "Balance", "Payment_Type", "Remarks", "Finance_Name", "Interest_Amount") values
('Vinoth-New-STL262-New-32-50000-Interest-06-2026-a004e10b', '2026-07-17', 'Customer_Interest', 'Vinoth-New-STL262-New-32-50000-Interest-06-2026', 'New-STL262', 'New-32', 'Vinoth', 'Interest-06-2026', 1050.0, 0.0, 415397, NULL, NULL, 'New Finance', '1050.0'),
('Ashok-New-STL282-New-33-15000-Interest-06-2026-d0737c27', '2026-07-17', 'Customer_Interest', 'Ashok-New-STL282-New-33-15000-Interest-06-2026', 'New-STL282', 'New-33', 'Ashok', 'Interest-06-2026', 360.0, 0.0, 415757, NULL, NULL, 'New Finance', '360.0'),
('Mariyammal-New-STL297-New-34-100000-Interest-06-2026-600fa0c4', '2026-07-10', 'Customer_Interest', 'Mariyammal-New-STL297-New-34-100000-Interest-06-2026', 'New-STL297', 'New-34', 'Mariyammal', 'Interest-06-2026', 2100.0, 0.0, 417857, NULL, NULL, 'New Finance', '2100.0'),
('Prakash S M-New-STL343-New-145-80000-Interest-06-2026-22b6cf53', '2026-07-17', 'Customer_Interest', 'Prakash S M-New-STL343-New-145-80000-Interest-06-2026', 'New-STL343', 'New-145', 'Prakash S M', 'Interest-06-2026', 1460.0, 0.0, 419317, NULL, NULL, 'New Finance', '1460.0'),
('Ramkumar-New-STL231-New-35-New-71-200000-Interest-06-2026-be83c315', '2026-07-17', 'Customer_Interest', 'Ramkumar-New-STL231-New-35-New-71-200000-Interest-06-2026', 'New-STL231', 'New-35-New-71', 'Ramkumar', 'Interest-06-2026', 4200.0, 0.0, 423517, NULL, NULL, 'New Finance', '4200.0'),
('Sakthivel Broker-New-STL263-New-37-100000-Interest-06-2026-0fce254f', '2026-07-17', 'Customer_Interest', 'Sakthivel Broker-New-STL263-New-37-100000-Interest-06-2026', 'New-STL263', 'New-37', 'Sakthivel Broker', 'Interest-06-2026', 2100.0, 0.0, 425617, NULL, NULL, 'New Finance', '2100.0'),
('Moorthy-New-STL312-New-39-50000-Interest-06-2026-16181548', '2026-07-17', 'Customer_Interest', 'Moorthy-New-STL312-New-39-50000-Interest-06-2026', 'New-STL312', 'New-39', 'Moorthy', 'Interest-06-2026', 1050.0, 0.0, 426667, NULL, NULL, 'New Finance', '1050.0'),
('Shanmugam-New-STL139-New-40-30000-Interest-06-2026-8082eeb3', '2026-07-10', 'Customer_Interest', 'Shanmugam-New-STL139-New-40-30000-Interest-06-2026', 'New-STL139', 'New-40', 'Shanmugam', 'Interest-06-2026', 720.0, 0.0, 427387, NULL, NULL, 'New Finance', '720.0'),
('Manivannan-New-STL182-New-41-300000-Interest-06-2026-4ce45fd1', '2026-07-07', 'Customer_Interest', 'Manivannan-New-STL182-New-41-300000-Interest-06-2026', 'New-STL182', 'New-41', 'Manivannan', 'Interest-06-2026', 6090.0, 0.0, 433477, NULL, NULL, 'New Finance', '6090.0'),
('Ramprakash-New-STL234-New-42-55000-Interest-06-2026-622ca0ee', '2026-07-14', 'Customer_Interest', 'Ramprakash-New-STL234-New-42-55000-Interest-06-2026', 'New-STL234', 'New-42', 'Ramprakash', 'Interest-06-2026', 1160.0, 0.0, 434637, NULL, NULL, 'New Finance', '1160.0'),
('Murugesan-New-STL326-New-43-20000-Interest-06-2026-0d1c4b16', '2026-07-02', 'Customer_Interest', 'Murugesan-New-STL326-New-43-20000-Interest-06-2026', 'New-STL326', 'New-43', 'Murugesan', 'Interest-06-2026', 480.0, 0.0, 435117, NULL, NULL, 'New Finance', '480.0'),
('Ravi-New-STL306-New-134-20000-Interest-06-2026-f2ec6e06', '2026-07-17', 'Customer_Interest', 'Ravi-New-STL306-New-134-20000-Interest-06-2026', 'New-STL306', 'New-134', 'Ravi', 'Interest-06-2026', 480.0, 0.0, 435597, NULL, NULL, 'New Finance', '480.0'),
('Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-06-2026-40418be9', '2026-07-13', 'Customer_Interest', 'Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-06-2026', 'New-STL334', 'New-73', 'Vignesh Arun Kumba', 'Interest-06-2026', 2100.0, 0.0, 437697, NULL, NULL, 'New Finance', '2100.0'),
('Durai Master Kumbaa-New-STL335-New-75-100000-Interest-06-2026-8f217def', '2026-07-15', 'Customer_Interest', 'Durai Master Kumbaa-New-STL335-New-75-100000-Interest-06-2026', 'New-STL335', 'New-75', 'Durai Master Kumbaa', 'Interest-06-2026', 2100.0, 0.0, 439797, NULL, NULL, 'New Finance', '2100.0'),
('Tharun Tex-New-STL221-New-74-50000-Interest-06-2026-6eff4efc', '2026-07-09', 'Customer_Interest', 'Tharun Tex-New-STL221-New-74-50000-Interest-06-2026', 'New-STL221', 'New-74', 'Tharun Tex', 'Interest-06-2026', 1050.0, 0.0, 440847, NULL, NULL, 'New Finance', '1050.0'),
('Divakar-New-STL318-New-53-New-137-35000-Interest-06-2026-a4ce4e03', '2026-07-17', 'Customer_Interest', 'Divakar-New-STL318-New-53-New-137-35000-Interest-06-2026', 'New-STL318', 'New-53-New-137', 'Divakar', 'Interest-06-2026', 840.0, 0.0, 441687, NULL, NULL, 'New Finance', '840.0'),
('Muniyappan-New-STL150-New-54-100000-Interest-06-2026-b4bd89d3', '2026-07-20', 'Customer_Interest', 'Muniyappan-New-STL150-New-54-100000-Interest-06-2026', 'New-STL150', 'New-54', 'Muniyappan', 'Interest-06-2026', 2100.0, 0.0, 443787, NULL, NULL, 'New Finance', '2100.0'),
('Shanmugaraj-New-STL151-New-55-300000-Interest-06-2026-06402fcd', '2026-07-19', 'Customer_Interest', 'Shanmugaraj-New-STL151-New-55-300000-Interest-06-2026', 'New-STL151', 'New-55', 'Shanmugaraj', 'Interest-06-2026', 6300.0, 0.0, 450087, NULL, NULL, 'New Finance', '6300.0'),
('Nandhakumar-New-STL227-New-127-200000-Interest-06-2026-cb1b4d72', '2026-07-17', 'Customer_Interest', 'Nandhakumar-New-STL227-New-127-200000-Interest-06-2026', 'New-STL227', 'New-127', 'Nandhakumar', 'Interest-06-2026', 4200.0, 0.0, 454287, NULL, NULL, 'New Finance', '4200.0'),
('Vignesh-New-STL260-New-57-100000-Interest-06-2026-cc40abeb', '2026-07-08', 'Customer_Interest', 'Vignesh-New-STL260-New-57-100000-Interest-06-2026', 'New-STL260', 'New-57', 'Vignesh', 'Interest-06-2026', 2100.0, 0.0, 456387, NULL, NULL, 'New Finance', '2100.0'),
('Anand-New-STL274-New-58-20000-Interest-06-2026-293bcdaf', '2026-07-17', 'Customer_Interest', 'Anand-New-STL274-New-58-20000-Interest-06-2026', 'New-STL274', 'New-58', 'Anand', 'Interest-06-2026', 480.0, 0.0, 456867, NULL, NULL, 'New Finance', '480.0'),
('Subramani-New-STL287-New-59-150000-Interest-06-2026-dbd3d6c3', '2026-07-14', 'Customer_Interest', 'Subramani-New-STL287-New-59-150000-Interest-06-2026', 'New-STL287', 'New-59', 'Subramani', 'Interest-06-2026', 3150.0, 0.0, 460017, NULL, NULL, 'New Finance', '3150.0'),
('Nagurammal-New-STL331-New-60-20000-Interest-06-2026-265ac494', '2026-07-03', 'Customer_Interest', 'Nagurammal-New-STL331-New-60-20000-Interest-06-2026', 'New-STL331', 'New-60', 'Nagurammal', 'Interest-06-2026', 310.0, 0.0, 460327, NULL, NULL, 'New Finance', '310.0'),
('Nagurammal-New-STL331-New-60-130000-Interest-06-2026-265ac494', '2026-07-03', 'Customer_Interest', 'Nagurammal-New-STL331-New-60-130000-Interest-06-2026', 'New-STL331', 'New-60', 'Nagurammal', 'Interest-06-2026', 2730.0, 0.0, 463057, NULL, NULL, 'New Finance', '2730.0'),
('Sundaravadivel-New-STL271-New-9-132-100000-Interest-06-2026-d0a0f739', '2026-07-15', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-9-132-100000-Interest-06-2026', 'New-STL271', 'New-9-132', 'Sundaravadivel', 'Interest-06-2026', 2100.0, 0.0, 465157, NULL, NULL, 'New Finance', '2100.0'),
('e9206a7a', '2026-07-22', 'Customer_Interest', 'RanjithKumar-New-STL319-New-72-200000-Interest-07-2026', 'New-STL319', 'New-72', 'RanjithKumar', 'Interest-07-2026', 2940.0, NULL, 468097, NULL, NULL, 'New Finance', '2940'),
('RanjithKumar-New-STL319-New-72-200000-Interest-07-2026-e9206a7a', '2026-07-22', 'Customer_Interest', 'RanjithKumar-New-STL319-New-72-200000-Interest-07-2026', 'New-STL319', 'New-72', 'RanjithKumar', 'Interest-07-2026', 2940.0, 0.0, 471037, NULL, NULL, 'New Finance', '2940.0'),
('1f9dd6f0', '2026-07-23', 'Customer_Interest', 'Vinoth Ravi vangalamman-New-STL347-New-159-250000-Interest-07-2026', 'New-STL347', 'New-159', 'Vinoth Ravi vangalamman', 'Interest-07-2026', 1225.0, NULL, 472262, NULL, NULL, 'New Finance', '1225'),
('Vinoth Ravi vangalamman-New-STL347-New-159-250000-Interest-07-2026-1f9dd6f0', '2026-07-23', 'Customer_Interest', 'Vinoth Ravi vangalamman-New-STL347-New-159-250000-Interest-07-2026', 'New-STL347', 'New-159', 'Vinoth Ravi vangalamman', 'Interest-07-2026', 1225.0, 0.0, 473487, NULL, NULL, 'New Finance', '1225.0'),
('6e1de87f', '2026-07-08', 'Customer_Interest', 'Jeyaraj pons-New-STL342-New-142-50000-Interest-07-2026', 'New-STL342', 'New-142', 'Jeyaraj pons', 'Interest-07-2026', 245.0, NULL, 473732, NULL, NULL, 'New Finance', '245'),
('Jeyaraj pons-New-STL342-New-142-50000-Interest-07-2026-6e1de87f', '2026-07-08', 'Customer_Interest', 'Jeyaraj pons-New-STL342-New-142-50000-Interest-07-2026', 'New-STL342', 'New-142', 'Jeyaraj pons', 'Interest-07-2026', 245.0, 0.0, 473977, NULL, NULL, 'New Finance', '245.0'),
('67f1f1ce', '2026-08-04', 'Customer_Interest', 'Murugesan pons-New-STL341-New-141-20000-Interest-06-2026,Murugesan pons-New-STL341-New-143-250000-Interest-07-2026,Murugesan pons-New-STL341-New-141-New-160-25000-Interest-07-2026', 'New-STL341,New-STL341,New-STL341', 'New-141,New-143,New-141-New-160', 'Murugesan pons', 'Interest-06-2026,Interest-07-2026,Interest-07-2026', 2460.0, NULL, 476437, NULL, 'Cash asal+ vatti', 'New Finance', '420,2100,360'),
('Murugesan pons-New-STL341-New-141-20000-Interest-06-2026-67f1f1ce', '2026-08-04', 'Customer_Interest', 'Murugesan pons-New-STL341-New-141-20000-Interest-06-2026', 'New-STL341', 'New-141', 'Murugesan pons', 'Interest-06-2026', 420.0, 0.0, 476857, NULL, 'Cash asal+ vatti', 'New Finance', '420.0'),
('Murugesan pons-New-STL341-New-143-250000-Interest-07-2026-67f1f1ce', '2026-08-04', 'Customer_Interest', 'Murugesan pons-New-STL341-New-143-250000-Interest-07-2026', 'New-STL341', 'New-143', 'Murugesan pons', 'Interest-07-2026', 2040.0, 0.0, 478897, NULL, 'Cash asal+ vatti', 'New Finance', '2100.0'),
('52dadd5a', '2026-08-01', 'Customer_Interest', 'Ravi-New-STL306-New-154-75000-Interest-07-2026,Ravi-New-STL306-New-134-20000-Interest-07-2026', 'New-STL306,New-STL306', 'New-154,New-134', 'Ravi', 'Interest-07-2026,Interest-07-2026', 2020.0, NULL, 480917, NULL, 'Cover', 'New Finance', '1470,500'),
('Ravi-New-STL306-New-154-75000-Interest-07-2026-52dadd5a', '2026-08-01', 'Customer_Interest', 'Ravi-New-STL306-New-154-75000-Interest-07-2026', 'New-STL306', 'New-154', 'Ravi', 'Interest-07-2026', 1470.0, 0.0, 482387, NULL, 'Cover', 'New Finance', '1470.0'),
('Ravi-New-STL306-New-134-20000-Interest-07-2026-52dadd5a', '2026-08-01', 'Customer_Interest', 'Ravi-New-STL306-New-134-20000-Interest-07-2026', 'New-STL306', 'New-134', 'Ravi', 'Interest-07-2026', 500.0, 0.0, 482887, NULL, 'Cover', 'New Finance', '500.0'),
('3d4039b5', '2026-08-01', 'Customer_Interest', 'Murugesan-New-STL326-New-157-200000-Interest-07-2026,Murugesan-New-STL326-New-43-20000-Interest-07-2026', 'New-STL326,New-STL326', 'New-157,New-43', 'Murugesan', 'Interest-07-2026,Interest-07-2026', 700.0, NULL, 483587, NULL, NULL, 'New Finance', '800,500'),
('Murugesan-New-STL326-New-157-200000-Interest-07-2026-3d4039b5', '2026-08-01', 'Customer_Interest', 'Murugesan-New-STL326-New-157-200000-Interest-07-2026', 'New-STL326', 'New-157', 'Murugesan', 'Interest-07-2026', 700.0, 0.0, 484287, NULL, NULL, 'New Finance', '800.0'),
('c2ee9c5e', '2026-07-17', 'Customer_Interest', 'Shanmugaraj-New-STL151-New-55-300000-Interest-07-2026', 'New-STL151', 'New-55', 'Shanmugaraj', 'Interest-07-2026', 6510.0, NULL, 490797, NULL, 'June and July received same', 'New Finance', '6510'),
('Shanmugaraj-New-STL151-New-55-300000-Interest-07-2026-c2ee9c5e', '2026-07-17', 'Customer_Interest', 'Shanmugaraj-New-STL151-New-55-300000-Interest-07-2026', 'New-STL151', 'New-55', 'Shanmugaraj', 'Interest-07-2026', 6510.0, 0.0, 497307, NULL, 'June and July received same', 'New Finance', '6510.0'),
('0b574b6a', '2026-07-15', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-132-50000-Interest-06-2026,Sundaravadivel-New-STL271-New-9-50000-Interest-06-2026,Sundaravadivel-New-STL271-New-9-New-132-100000-Interest-07-2026', 'New-STL271,New-STL271,New-STL271', 'New-132,New-9,New-9-New-132', 'Sundaravadivel', 'Interest-06-2026,Interest-06-2026,Interest-07-2026', 2100.0, NULL, 499407, NULL, NULL, 'New Finance', '1050,1050,2170'),
('Sundaravadivel-New-STL271-New-132-50000-Interest-06-2026-0b574b6a', '2026-07-15', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-132-50000-Interest-06-2026', 'New-STL271', 'New-132', 'Sundaravadivel', 'Interest-06-2026', 1050.0, 0.0, 500457, NULL, NULL, 'New Finance', '1050.0'),
('Sundaravadivel-New-STL271-New-9-50000-Interest-06-2026-0b574b6a', '2026-07-15', 'Customer_Interest', 'Sundaravadivel-New-STL271-New-9-50000-Interest-06-2026', 'New-STL271', 'New-9', 'Sundaravadivel', 'Interest-06-2026', 1050.0, 0.0, 501507, NULL, NULL, 'New Finance', '1050.0'),
('26d7d76d', '2026-07-20', 'Customer_Interest', 'Balasubramani Suresh-New-STL275-New-10-New-64-New-131-New-150-400000-Interest-07-2026,Balasubramani Suresh-New-STL275-New-10-64-131-150-400000-Interest-06-2026', 'New-STL275,New-STL275', 'New-10-New-64-New-131-New-150,New-10-64-131-150', 'Balasubramani Suresh', 'Interest-07-2026,Interest-06-2026', 6930.0, NULL, 508437, NULL, NULL, 'New Finance', '8680,6930'),
('6e91007d', '2026-08-04', 'Customer_Interest', 'Mani Basketball-New-STL333-New-61-50000-Interest-06-2026,Mani Basketball-New-STL333-New-61-50000-Interest-07-2026', 'New-STL333,New-STL333', 'New-61,New-61', 'Mani Basketball', 'Interest-06-2026,Interest-07-2026', 2140.0, NULL, 510577, NULL, NULL, 'New Finance', '1050,1090'),
('Mani Basketball-New-STL333-New-61-50000-Interest-06-2026-6e91007d', '2026-08-04', 'Customer_Interest', 'Mani Basketball-New-STL333-New-61-50000-Interest-06-2026', 'New-STL333', 'New-61', 'Mani Basketball', 'Interest-06-2026', 1050.0, 0.0, 511627, NULL, NULL, 'New Finance', '1050.0'),
('Mani Basketball-New-STL333-New-61-50000-Interest-07-2026-6e91007d', '2026-08-04', 'Customer_Interest', 'Mani Basketball-New-STL333-New-61-50000-Interest-07-2026', 'New-STL333', 'New-61', 'Mani Basketball', 'Interest-07-2026', 1090.0, 0.0, 512717, NULL, NULL, 'New Finance', '1090.0'),
('3c77b426', '2026-08-02', 'Customer_Interest', 'Priya-New-STL320-New-65-New-130-New-144-360000-Interest-07-2026', 'New-STL320', 'New-65-New-130-New-144', 'Priya', 'Interest-07-2026', 7810.0, NULL, 520527, NULL, NULL, 'New Finance', '7810'),
('Priya-New-STL320-New-65-New-130-New-144-360000-Interest-07-2026-3c77b426', '2026-08-02', 'Customer_Interest', 'Priya-New-STL320-New-65-New-130-New-144-360000-Interest-07-2026', 'New-STL320', 'New-65-New-130-New-144', 'Priya', 'Interest-07-2026', 7810.0, 0.0, 528337, NULL, NULL, 'New Finance', '7810.0'),
('e05e6d06', '2026-08-02', 'Customer_Interest', 'Sabarish-New-STL280-New-63-New-155-35000-Interest-07-2026', 'New-STL280', 'New-63-New-155', 'Sabarish', 'Interest-07-2026', 760.0, NULL, 529097, NULL, NULL, 'New Finance', '760'),
('Sabarish-New-STL280-New-63-New-155-35000-Interest-07-2026-e05e6d06', '2026-08-02', 'Customer_Interest', 'Sabarish-New-STL280-New-63-New-155-35000-Interest-07-2026', 'New-STL280', 'New-63-New-155', 'Sabarish', 'Interest-07-2026', 760.0, 0.0, 529857, NULL, NULL, 'New Finance', '760.0'),
('600e0a19', '2026-08-04', 'Customer_Interest', 'Suresh CCTV-New-STL344-New-149-50000-Interest-07-2026', 'New-STL344', 'New-149', 'Suresh CCTV', 'Interest-07-2026', 1090.0, NULL, 530947, NULL, NULL, 'New Finance', '1090'),
('Suresh CCTV-New-STL344-New-149-50000-Interest-07-2026-600e0a19', '2026-08-04', 'Customer_Interest', 'Suresh CCTV-New-STL344-New-149-50000-Interest-07-2026', 'New-STL344', 'New-149', 'Suresh CCTV', 'Interest-07-2026', 1090.0, 0.0, 532037, NULL, NULL, 'New Finance', '1090.0'),
('283336ee', '2026-08-04', 'Customer_Interest', 'Surya Shed-New-STL339-New-135-New-136-New-148-490000-Interest-07-2026', 'New-STL339', 'New-135-New-136-New-148', 'Surya Shed', 'Interest-07-2026', NULL, NULL, 532037, NULL, NULL, 'New Finance', '10630'),
('d95f50ff', '2026-08-06', 'Customer_Interest', 'Gobinath-New-STL348-New-161-200000-Interest-07-2026', 'New-STL348', 'New-161', 'Gobinath', 'Interest-07-2026', 1260.0, NULL, 533297, NULL, NULL, 'New Finance', '1260'),
('Gobinath-New-STL348-New-161-200000-Interest-07-2026-d95f50ff', '2026-08-06', 'Customer_Interest', 'Gobinath-New-STL348-New-161-200000-Interest-07-2026', 'New-STL348', 'New-161', 'Gobinath', 'Interest-07-2026', 1260.0, 0.0, 534557, NULL, NULL, 'New Finance', '1260.0'),
('364a5c1b', '2026-08-04', 'Customer_Interest', 'Surya Shed-New-STL339-New-135-New-136-New-148-490000-Interest-07-2026', 'New-STL339', 'New-135-New-136-New-148', 'Surya Shed', 'Interest-07-2026', NULL, NULL, 534557, NULL, NULL, 'New Finance', '10630'),
('9b1cdb1a', '2026-08-05', 'Customer_Interest', 'Kamaraj Prakash-New-STL345-New-156-50000-Interest-07-2026', 'New-STL345', 'New-156', 'Kamaraj Prakash', 'Interest-07-2026', NULL, NULL, 534557, NULL, NULL, 'New Finance', '880'),
('903784c6', '2026-08-08', 'Customer_Interest', 'Mariyammal-New-STL297-New-34-100000-Interest-07-2026', 'New-STL297', 'New-34', 'Mariyammal', 'Interest-07-2026', 2170.0, NULL, 536727, NULL, NULL, 'New Finance', '2170'),
('Mariyammal-New-STL297-New-34-100000-Interest-07-2026-903784c6', '2026-08-08', 'Customer_Interest', 'Mariyammal-New-STL297-New-34-100000-Interest-07-2026', 'New-STL297', 'New-34', 'Mariyammal', 'Interest-07-2026', 2170.0, 0.0, 538897, NULL, NULL, 'New Finance', '2170.0'),
('db545914', '2026-08-07', 'Customer_Interest', 'Vignesh Arun Kumba-New-STL334-New-73-100000-Interest-07-2026', 'New-STL334', 'New-73', 'Vignesh Arun Kumba', 'Interest-07-2026', NULL, NULL, 538897, NULL, NULL, 'New Finance', '2170'),
('fb746d8e', '2026-08-05', 'Customer_Interest', 'Vignesh-New-STL260-New-57-100000-Interest-07-2026', 'New-STL260', 'New-57', 'Vignesh', 'Interest-07-2026', NULL, NULL, 538897, NULL, NULL, 'New Finance', '2170'),
('569de4df', '2026-08-04', 'Customer_Interest', 'Nagurammal-New-STL331-New-60-130000-Interest-07-2026', 'New-STL331', 'New-60', 'Nagurammal', 'Interest-07-2026', NULL, NULL, 538897, NULL, NULL, 'New Finance', '2820');

delete from "Other_Finance_Loan" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "Other_Finance_Loan" ("Finance_Name", "Loan_Bought_Date", "Loan_No", "Loan_bought_Finance_Name", "Loan_bought_Finance_Phone_No", "Loan_bought_Finance_Email", "Loan_bought_Finance_Address", "Loan_Amount", "Interest_Per_day_Per_Lakh", "Repaid_Amount", "Outstand_Amount", "Loan_Status", "Payment_Type", "Remarks", "Interest_Type", "Interest_Per_Month_Per_Lakh", "Finance_Type") values
('New Finance', '2026-04-04', 'New-O-1-dffd', 'dffd', NULL, NULL, NULL, 100000.0, 70.0, 0, 100000, 'Active', 'Cash', NULL, '0.0', '2026-04-04', 'New');

delete from "Chit_Creation" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "Chit_Creation" ("Chit_ID", "Chit_Name", "Chit_From_Date", "Chit_To_Date", "No_Members", "Total_Month", "Total_Amount", "Chit_Percentage", "Chit_Amount", "Total_Chit_Count", "No_Month_Completed", "Total_Member_Taken", "Finance_Name", "Chit_Status") values
('New _A1', 'A', '2025-05-01', '2026-12-31', 20, 20.0, 100000.0, 5.0, 95000, 20, 10, 6, 'New Finance', 'Open'),
('New _B1', 'B', '2025-12-01', '2027-07-31', 0, 20.0, 100000.0, 5.0, 95000, 0, 0, 0, 'New Finance', 'Open');

delete from "Chit_Member" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "Chit_Member" ("Chit_Name", "Member_ID", "Member_Name", "Member_Phone_No", "Member_Address", "Member_Photo", "Date_Added", "Member_Percentage", "Recommended_Partner", "Chit_Taken", "Chit_Taken_Amount", "Month_Taken", "Total_Auction_Amount", "Amount_Given", "Remaining_Amount", "Member_Type", "Chit_ID", "Finance_Name", "Message", "Pending_Amount", "Last_Receipt") values
('A', 'New _A1_M1_Chitra', 'Chitra', 9865388000.0, 'Karur', NULL, '2026-04-01', 1.0, 'Prakash Manoharan', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Chitra
ID : New _A1_M1_Chitra

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M2_Karthika', 'Karthika', 9865388000.0, 'Karur', NULL, '2026-04-01', 1.0, 'Prakash Manoharan', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Karthika
ID : New _A1_M2_Karthika

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M3_SanjuSri', 'Sanju Sri', 9976592192.0, 'Karur', NULL, '2026-04-01', 1.0, 'Kannan Jeganathan', 'Taken', 75800, '2026-04-01', 75800, 0, 75800, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Sanju Sri
ID : New _A1_M3_SanjuSri

Total Pending: 0
Chit Status : Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M4_Saranya', 'Saranya', 9976592192.0, 'Karur', NULL, '2026-04-01', 1.0, 'Kannan Jeganathan', 'Taken', 76600, '2026-04-01', 76600, 0, 76600, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Saranya
ID : New _A1_M4_Saranya

Total Pending: 0
Chit Status : Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M5_Sagunthala1', 'Sagunthala1', 8940864888.0, 'Karur', NULL, '2026-04-01', 1.0, 'Arul Sampath', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Sagunthala1
ID : New _A1_M5_Sagunthala1

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M6_Sagunthala2', 'Sagunthala2', 8940864888.0, 'Karur', NULL, '2026-04-01', 1.0, 'Arul Sampath', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Sagunthala2
ID : New _A1_M6_Sagunthala2

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M7_Ananyaa', 'Ananyaa', 9626262427.0, 'Karur', NULL, '2026-04-01', 1.0, 'Arul Muthusamy', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Ananyaa
ID : New _A1_M7_Ananyaa

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M8_Adhvik', 'Adhvik', 9626262427.0, 'Karur', NULL, '2026-04-01', 1.0, 'Arul Muthusamy', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Adhvik
ID : New _A1_M8_Adhvik

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M9_Pandiyan1', 'Pandiyan1', 9952522853.0, 'Karur', NULL, '2026-04-01', 1.0, 'Ravi Paramasivam', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Pandiyan1
ID : New _A1_M9_Pandiyan1

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M10_Pandiyan2', 'Pandiyan2', 7418087965.0, 'Karur', NULL, '2026-04-01', 1.0, 'Ravi Paramasivam', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Pandiyan2
ID : New _A1_M10_Pandiyan2

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M11_Vinayagam', 'Vinayagam', 9751707865.0, 'Karur', NULL, '2026-04-01', 1.0, 'Vinayagam Sankaralingam', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Vinayagam
ID : New _A1_M11_Vinayagam

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M12_Gopi', 'Gopi', 9655527254.0, 'Karur', NULL, '2026-04-01', 1.0, 'Vinayagam Sankaralingam', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Gopi
ID : New _A1_M12_Gopi

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M13_Gokul', 'Gokul', 8072395221.0, 'karur', NULL, '2026-04-01', 1.0, 'Vasu Devar Paramasivam', 'Taken', 82600, '2026-04-01', 82600, 0, 82600, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Gokul
ID : New _A1_M13_Gokul

Total Pending: 0
Chit Status : Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M14_DineshSKP', 'Dinesh SKP', 9788057438.0, 'Karur', NULL, '2026-04-01', 1.0, 'Vasu Devar Paramasivam', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Dinesh SKP
ID : New _A1_M14_DineshSKP

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M15_Ramya', 'Ramya', 7010538470.0, 'Karur', NULL, '2026-04-01', 1.0, 'Ponnusamy A', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Ramya
ID : New _A1_M15_Ramya

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M16_Balamurali', 'Balamurali', 8973985500.0, 'Ponnusamy', NULL, '2026-04-01', 1.0, 'Ponnusamy A', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Balamurali
ID : New _A1_M16_Balamurali

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M17_Ramkumar', 'Ramkumar', 9578562182.0, 'Karur', NULL, '2026-04-01', 1.0, 'Ram Kumar PNR', 'Taken', 74800, '2026-04-01', 74800, 0, 74800, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Ramkumar
ID : New _A1_M17_Ramkumar

Total Pending: 0
Chit Status : Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M18_Kalaiyarasi', 'Kalaiyarasi', 9443839082.0, 'Karur', NULL, '2026-04-01', 1.0, 'Kannan Jeganathan', 'Taken', 77600, '2026-04-01', 77600, 0, 77600, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Kalaiyarasi
ID : New _A1_M18_Kalaiyarasi

Total Pending: 0
Chit Status : Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M19_Finance1', 'Finance1', 9976592192.0, 'Karur', NULL, '2026-04-01', 1.0, 'Kannan Jeganathan', 'Taken', 100000, '2026-04-01', 100000, 0, 100000, 'Finance', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Finance1
ID : New _A1_M19_Finance1

Total Pending: 0
Chit Status : Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - '),
('A', 'New _A1_M20_Finance2', 'Finance2', 9976592192.0, 'Karur', NULL, '2026-04-01', 1.0, 'Kannan Jeganathan', 'Not_Taken', 0, '2026-04-01', 0, 0, 0, 'Member', 'New _A1', 'New Finance', NULL, 'Chit Details:

Name : Finance2
ID : New _A1_M20_Finance2

Total Pending: 0
Chit Status : Not_Taken
Chit Completed Month : 10
Last Receipt : Last Receipt : 5000 - Cash - 

Note: Amount can be sent through UPI No: 9626262427
or through Account Details:
Name: T MALARVIZHI
IFSC: IOBA0002882
Account No: 288201000006548
Sukkaliyur, Karur Branch', 'Last Receipt : 5000 - Cash - ');

delete from "Chit_Auction" where "Finance_Name" in ('New Finance', 'Kannnan_Personal');
insert into "Chit_Auction" ("Chit_Auction_ID", "Chit_Name", "Date_Auction", "Month_Count", "Total_Auction_Amount", "Indivitual_Member_Amount", "Interest_Percentage", "Total_Auction_Amount_After_Commission", "Chit_ID", "Finance_Name", "Auction_Status", "Member_Type", "Remaining", "Update") values
('New _A1_Auction_1', 'A', '2025-06-06', 1.0, 100000.0, 5000.0, 0.0, 100000.0, 'New _A1', 'New Finance', 'Closed', 'Finance', 0, NULL),
('New _A1_Auction_2', 'A', '2025-07-07', 2.0, 79800.0, 3990.0, 1.0, 74800.0, 'New _A1', 'New Finance', 'Closed', 'Other', 0, NULL),
('New _A1_Auction_3', 'A', '2025-08-06', 3.0, 80800.0, 4040.0, 1.0, 75800.0, 'New _A1', 'New Finance', 'Closed', 'Other', 0, NULL),
('New _A1_Auction_4', 'A', '2025-09-06', 4.0, 81600.0, 4080.0, 1.0, 76600.0, 'New _A1', 'New Finance', 'Closed', 'Other', 0, NULL),
('New _A1_Auction_5', 'A', '2025-10-06', 5.0, 82600.0, 4130.0, 1.0, 77600.0, 'New _A1', 'New Finance', 'Closed', 'Other', 0, NULL),
('New _A1_Auction_6', 'A', '2025-11-06', 6.0, 83600.0, 4180.0, 1.0, 78600.0, 'New _A1', 'New Finance', 'Closed', 'Other', 0, NULL),
('New _A1_Auction_7', 'A', '2025-12-06', 7.0, 84600.0, 4230.0, 1.0, 79600.0, 'New _A1', 'New Finance', 'Closed', 'Other', 0, NULL),
('New _A1_Auction_8', 'A', '2026-01-06', 8.0, 85600.0, 4280.0, 1.0, 80600.0, 'New _A1', 'New Finance', 'Closed', 'Other', 0, NULL),
('New _A1_Auction_9', 'A', '2026-02-06', 9.0, 86600.0, 4330.0, 1.0, 81600.0, 'New _A1', 'New Finance', 'Closed', 'Other', 0, NULL),
('New _A1_Auction_10', 'A', '2026-03-06', 10.0, 87600.0, 4380.0, 1.0, 82600.0, 'New _A1', 'New Finance', 'Closed', 'Other', 0, NULL);
