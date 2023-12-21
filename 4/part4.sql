

/*part 4*/
--1
SELECT d.Dnum, d.Dname, e.SSN, e.Fname AS ManagerName
FROM Departments d
INNER JOIN Employee e ON d.MGRSSN = e.Superssn;
--2
SELECT d.Dname, p.Pname
FROM Departments d
INNER JOIN Project p ON d.Dnum = p.Dnum;
--3
SELECT d.*
FROM Dependent d
INNER JOIN Employee e ON d.ESSN = e.SSN;
--4
SELECT Pnumber, Pname, Plocation
FROM Project
WHERE City IN ('Cairo', 'Alex');

--5
SELECT *
FROM Project
WHERE Pname LIKE 'a%';

--6
SELECT *
FROM Employee
WHERE Dno = 30 AND Salary BETWEEN 1000 AND 2000;

--7
SELECT e.fname +' '+e.Lname as "full name"
FROM Employee e
INNER JOIN Works_for w ON e.SSN = w.ESSN
INNER JOIN Project p ON w.Pno = p.Pnumber
WHERE e.Dno = 10 AND p.Pname = 'AL Rabwah' AND w.Hours >= 10;
--8
SELECT e.fname +' '+e.Lname as "full name", p.Pname
FROM Employee e
INNER JOIN Works_for w ON e.SSN = w.ESSN
INNER JOIN Project p ON w.Pno = p.PNumber
ORDER BY p.Pname;
--9
SELECT p.Pnumber, d.Dname, e.Lname, e.Address, e.Bdate
FROM Project p
INNER JOIN Departments d ON p.Dnum = d.Dnum
INNER JOIN Employee e ON d.MGRSSN = e.Superssn
WHERE p.City = 'Cairo';
