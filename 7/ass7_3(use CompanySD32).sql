
create schema assignments
--1.	Create a view named   “v_clerk” that will display employee Number ,project Number
--, the date of hiring of all the jobs of the type 'Clerk'.
alter view assignments.v_clerk
as
select e.EmpNo as empno,w.projectno as projectno 
from 
hr.Employee e inner join Works_on w
on e.EmpNo=w.EmpNo and w.job='clerk'

select * from assignments.v_clerk

--2. Create view named  “v_without_budget” that will display all 
--the projects data without budget
create view assignments.v_without_budget 
 as 
 select projectNo,projectName
 from hr.project

 select * from assignments.v_without_budget 

 --3.	Create view named  “v_count “ that will display the project name
 --and the Number of jobs in it
create view assignments.v_count
 as
 select projectname as 'project name', count(job) as jobs
 from works_on w inner join HR.project p
 on p.projectno=w.projectno
 group by projectname

 select * from assignments.v_count 
 --4.	 Create view named ” v_project_p2” that will display the emp# s for the project# ‘p2’ .
 --(use the previously created view  “v_clerk”)
 create view assignments.v_project_p2
as
select empno,projectno from v_clerk 
where projectno=2
select*from assignments.v_project_p2

---5.	modify the view named  “v_without_budget”  to display all DATA 
--in project p1 and p2.
alter view assignments.v_without_budget
as
select * from hr.Project p
where Projectno in (1,2)
select * from assignments.v_without_budget

--6.	Delete the views  “v_ clerk” and “v_count”
drop view assignments.v_count
drop view assignments.v_clerk

---7.	Create view that will display the emp# and emp last name
---who works on deptNumber is ‘d2’

create view assignments.dep2
as
select e.emplname , count(EmpNo) as numberofemployees from
hr.Employee e,Department d
where d.DeptNo=e.DeptNo and d.DeptNo=2
group by emplname

select * from assignments.dep2

--8.	Display the employee  lastname that contains
---letter “J” (Use the previous view created in Q#7)
select emplname from assignments.dep2 where emplname like '%j%'

--9.	Create view named “v_dept” that will display the department# and department name
create view assignments.v_dept
as
select DeptNo, DeptName
from Department

select * from assignments.v_dept