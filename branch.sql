show databases;
create database IF NOT exists bank12;
show databases;
use bank12;
create table Branch(Branch_name varchar(20),
Branchcity varchar(20),Assets real,primary key(Branch_name));
create table bankaccount(accno int,balance int,primary key(accno),Branch_name varchar(20),foreign key(Branch_name) references  Branch(Branch_name));
desc bankaccount;
create table customer(customerName varchar(20),customerstreet varchar(20),customerCity varchar(20),primary key (customername));
create table depositer(customerName varchar(20),accno int,foreign key(customername)references customer(customername),
foreign key(accno)references bankaccount(accno));
create table LOAN(loannumber int,Branch_name varchar(20),amount int,foreign key(Branch_name) references branch(Branch_name));
INSERT INTO Branch VALUES 
('SBI_ResidencyRoad', 'Bangalore', 5000000),
('SBI_Jayanagar', 'Bangalore', 3000000),
('HDFC_Indiranagar', 'Bangalore', 4500000),
('ICICI_MG_Road', 'Bangalore', 6000000),
('Axis_Rajajinagar', 'Bangalore', 2500000);
INSERT INTO bankaccount VALUES
(1, 15000, 'SBI_Jayanagar'),
(2, 22000, 'SBI_ResidencyRoad'),
(3, 34000, 'HDFC_Indiranagar'),
(8, 27000, 'SBI_ResidencyRoad'),
(10, 31000, 'SBI_ResidencyRoad'),
(11, 19000, 'Axis_Rajajinagar');
INSERT INTO customer VALUES
('Dinesh', 'MG_Road', 'Bangalore'),
('Avinash', 'BTM_Layout', 'Bangalore'),
('Ravi', 'Jayanagar', 'Bangalore'),
('Sneha', 'Indiranagar', 'Bangalore'),
('Pooja', 'Rajajinagar', 'Bangalore');
INSERT INTO depositer VALUES
('Dinesh', 2),
('Avinash', 8),
('Dinesh', 10),
('Ravi', 1),
('Sneha', 3),
('Pooja', 11);
INSERT INTO loan VALUES
(101, 'SBI_ResidencyRoad', 80000),
(102, 'SBI_Jayanagar', 45000),
(103, 'HDFC_Indiranagar', 90000),
(104, 'ICICI_MG_Road', 120000),
(105, 'Axis_Rajajinagar', 50000);
SELECT * FROM Branch;
SELECT * FROM bankaccount;
SELECT * FROM customer;
SELECT * FROM depositer;
SELECT * FROM loan;
select Branch_name,(Assets/100000) As 'Assets in Lakhs' FROM Branch;
desc Branch;
select * from branch;
SELECT 
  d.customerName, 
  b.Branch_name, 
  COUNT(d.accno) AS No_of_Accounts
FROM depositer d
JOIN bankaccount b ON d.accno = b.accno
GROUP BY d.customerName, b.Branch_name
HAVING COUNT(d.accno) >= 2;
CREATE VIEW v2  
AS SELECT branch_name, amount 
     FROM loan 
     WHERE (amount>50000);
select * from v2;
SELECT DISTINCT s.customername
FROM depositer s
WHERE NOT EXISTS (
    SELECT b.branch_name
    FROM branch b
    WHERE b.branch_city = 'Bangalore'
      AND b.branch_name NOT IN (
          SELECT r.branch_name
          FROM depositer t
          JOIN bankaccount r ON t.accno = r.accno
          WHERE t.customername = s.customername
      )
);

	




