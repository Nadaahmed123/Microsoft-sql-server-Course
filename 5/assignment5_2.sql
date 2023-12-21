/*part 02*/
--1
select P.Pname ,sum(Hours) as 'Total Hour'
from Employee E , Project P , Works_for 
where E.Dno = P.Dnum and E.SSN = Works_for.ESSn 
group by p.Pname 

--2
select 
dname,max(salary)as max_val,min(salary) as min_val,avg(salary) as average
from Employee,Departments
where Dno=Dnum group by dname
--3
SELECT Lname, Fname, Pname
FROM Employee E ,Departments D, Project P
where d.Dnum=e.Dno and d.Dnum= P.Dnum
ORDER BY  lName,Fname

--4
UPDATE E
SET E.Salary = E.Salary * 1.3
FROM Employee AS E
JOIN Works_for AS W ON E.SSN = W.ESSN
JOIN Project AS P ON W.Pno = P.Pnumber
WHERE P.Pname = 'Al Rabwah';

---------------------
--------------------
/*Dml*/
---1
insert into Departments(Dname,Dnum,MGRSSN,"MGRStart Date")
values('Dept IT',100,112233,'1/11/2006')

--2
Update Departments set MGRSSN = 968574
where Dnum=100

Update Departments set MGRSSN = 102672
where Dnum=20  /*error conflect */


Update Employee set Superssn = 102672
where SSN=102660

--3
Delete from works_for where ESSn=223344
update Departments set MGRSSN=102675 where MGRSSN=223344 
delete from Dependent where ESSN =223344
update Employee set Superssn = 102672 where Superssn = 223344
delete from Employee where ssn = 223344


/*part 03*/
---1
SELECT Fname, Lname FROM Employee
INNER JOIN Works_for ON Employee.SSN = Works_for.ESSN
INNER JOIN Project ON Works_for.Pno = Project.Pnumber
WHERE Dno= 10 AND Project.Pname = 'AL Rabwah' AND Works_for.Hours >= 10;
--2

SELECT E.FName +' '+ E.LName as EmployeeName,
S.FName+' '+ S.LName as supervisor 
FROM Employee E ,  Employee S 
WHERE E.superssn =S.SSN  And S.FName = 'Kamel' AND S.LName = 'Mohamed' ;
/*
SELECT E.FName +' '+ E.LName as EmployeeName,
S.FName+' '+ S.LName as supervisor 
FROM Employee E ,  Employee S 
WHERE S.superssn =E.SSN  And S.FName = 'Kamel' AND S.LName = 'Mohamed' ;

*/

--3
Select * from Departments 
join Employee on MGRSSN = SSN

--4
select fname,lname, pname
from Employee , Project ,Works_for
where Pno = Pnumber and ESSn = SSN
order by Pname

--5
select pnumber , Dname , Fname , Lname , Address , BDate
from Departments D, Project P, Employee E
where City ='Cairo'  and SSN = mgrssn and p.Dnum = D.Dnum
--6
Select * from Employee 
left join Dependent on SSN = ESSN


