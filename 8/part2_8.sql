use ITIdata
--1.	Create a stored procedure to show the number of students per department.[use ITI DB] 
alter proc student_dept 
as
select Dept_Name as 'department' ,count(st_id) as numofstudents
from student s INNER JOIN Department d
ON s.Dept_Id=d.Dept_Id
group by (Dept_Name)

student_dept 

---2.	Create a stored procedure that will check for the Number of employees 
--in the project 100 if they are more than 3 print message to the user 
--“'The number of employees in the project 100 is 3 or more'” if they are less
--display a message to the user “'The following employees work for the project 100'” 
--in addition to the first name and last name of each one. [MyCompany DB] 
use MyCompany 

alter proc CheckNumberOFEmploees
	as
		declare @CountEmp int
		,@result NVARCHAR(MAX)

		SELECT
			@CountEmp = Count(e.SSN)
		FROM Employee e
		JOIN Works_for w
			ON e.SSN = w.ESSn
		JOIN Project p
			ON w.Pno = p.Pnumber
		WHERE w.Pno = 100

		IF @CountEmp >= 3
			SELECT
				@result = 'The number of employees in the project p1 is 3 or more'
		ELSE
		IF @CountEmp < 3
			SELECT
				@result = 'The following employees work for the project p1'

		SELECT e.Fname ,e.Lname,@RESULT
		from Employee e
		JOIN Works_for w
			on e.SSN = w.ESSn
		JOIN Project p
			on w.Pno = p.Pnumber
		where w.Pno = 100

--3.	Create a stored procedure that will be used in case an old employee has 
--left the project and a new one becomes his replacement. The procedure should take 3
--parameters (old Emp. number, new Emp. number and the project number) and 
--it will be used to update works_on table. [MyCompany DB]


alter proc updateEmployeeInProject @oldEmpNumber int, @newEmpNumber int,@projecNumber int
as begin try
update Employee 
SET SSN=@newEmpNumber
WHERE SSN=@oldEmpNumber

update Works_for
set ESSn=@newEmpNumber
where ESSn=@oldEmpNumber AND Pno=@projecNumber
end try
begin catch
	select 'cant Updated on Employees Or Projects'
end catch

updateEmployeeInProject 634562,111231,400











