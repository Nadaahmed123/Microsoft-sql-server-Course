--1
SELECT * FROM Employee;
--2
SELECT Fname, Lname, Salary, Dno
FROM Employee;
--3
SELECT p.Pname, p.Plocation, d.Dname
FROM Project p
INNER JOIN Departments d ON p.Dnum = d.Dnum;
--4
SELECT Fname + ' ' + Lname AS [Full Name], Salary * 0.1 AS [ANNUAL COMM]
FROM Employee;
--5
SELECT SSN, Fname + ' ' + Lname AS "Full Name"
FROM Employee
WHERE Salary > 1000;

--6
SELECT SSN, Fname + ' ' + Lname AS "Full Name"
FROM Employee
WHERE Salary * 12 > 10000;

--7
SELECT Fname + ' ' + Lname AS "Full Name", Salary
FROM Employee
WHERE Sex = 'F';

--8
SELECT Dnum, Dname
FROM Departments
WHERE MGRSSN = 968574;

--9
SELECT p.Pnumber, p.Pname, p.PLocation
FROM Project p
INNER JOIN Departments d ON p.Dnum = d.Dnum
WHERE d.Dnum = 10;