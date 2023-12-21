--1.	 Display instructors who have salaries less than the average salary of all instructors.
select ins_name,salary
from instructor
where salary < (select avg(salary) from instructor)
--2.	 Display the Department name that contains the instructor who receives the minimum salary.
select dept_name
from instructor i inner join Department d
on d.Dept_Id=i.Dept_Id and Salary=(select min(Salary) from Instructor)

--3.	 Select max two salaries in instructor table. 
select top 2 Salary
from Instructor
order by salary desc
/*4.	 Write a query to select the highest two salaries in Each Department for
instructors who have salaries. “using one of Ranking Functions*/
select * 
from (
select *,ROW_NUMBER() over(partition by dept_id order by salary desc)
as "maxsalary"
from Instructor ) 
as ins
where maxsalary<=2
/*5.	 Write a query to select a random  student from each department. 
“using one of Ranking Functions”*/
select * from(
select  *,ROW_NUMBER() over(partition by dept_id order by newid()) 
as random
from Student)
as std
where random=1
