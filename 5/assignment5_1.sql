--1
select COUNT(st_age) as numberofstudents
from Student
where St_Age is not null
--2
select COUNT(crs_id) as n_courses,top_name
from Course c inner join Topic t
on t.Top_Id=c.Top_Id
group by Top_Name
--3	
select s1.st_fname,s2.*
from Student s1,Student s2
where s1.St_id=s2.St_super

--4	
select isnull(st_id,'no data') StudentID,isnull(st_fname+' '+st_lname,'no data ') as "student full name",isnull(dept_name,' no data') as "department name"
from Student s,Department d
where d.Dept_Id=s.Dept_Id


--5
SELECT I.Ins_Name,
    ISNULL(CONVERT(VARCHAR(10), I.Salary), '0000') AS Salary
FROM Instructor AS I;


---6
Select S.st_Fname AS SupervisorFirstName, COUNT(*) AS NumberOfStudentsSupervised
FROM Student AS S
GROUP BY S.st_Fname;
--7
select max(salary) as "max value" ,min(salary) as "min val"
from Instructor
--8

SELECT AVG(Salary) aS "Average Salary"
FROM Instructor;



	