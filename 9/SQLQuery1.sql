create database RouteCompany
create table Department(
deptno varchar(5) primary key,
DeptName varchar(25),
Location varchar(max),

)


insert into Department(deptno,deptname,Location)values('d3','markiting','kw') 
create table employee (
emp_no int ,
emp_fname varchar(20) not null,
emp_lname varchar(20) not null,
dept_no  varchar (5),
salary int,
constraint c1 primary key(emp_no),
constraint c2 foreign key(dept_no) references department(deptno),
constraint c3 unique(salary),
)
create table projct(
projectno varchar(50) primary key,
projectname varchar(max) not null,
budget int null,
)
create table work_on(
empno int not null,
projectno varchar(50) not null ,
jop varchar(max) null,
Enter_Date date not null,
constraint c1 foreign key(empno) references employee(emp_no),
constraint c2 foreign key(projectno) references projct(projectno)
)




insert into employee(emp_no)values(11111)
update employee set emp_no=11111 where emp_no=10102
update employee set emp_no=10102where emp_no=22222
delete from employee where emp_no=10102
alter table employee add  telephone int;
alter table employee drop column telephone;


/*Create the following schema and transfer the following tables to it 
Company Schema 
Department table 
Project table 
Human Resource Schema
  Employee table 
*/

create schema company
alter schema company transfer dbo.department
alter schema company transfer dbo.projct
create schema hr
alter schema hr transfer dbo.employee

--Increase the budget of the project where the manager number is 10102 by 10%.
UPDATE company.
SET budget=budget*1.10
from company.projct p inner join works_on w
on w.projectno=p.projectno and w.empno=10102
--Change the name of the department for which the employee named James works.The new department name is Sales.
update company.Department set DeptName='sales'
from company.Department d inner join hr.employee e
on d.deptno=e.dept_no and e.emp_fname='JAMES'
/*Change the enter date for the projects for those employees who work in project p1
and belong to department ‘Sales’. The new date is 12.12.2007.*/
update works_on set enter_date='12.12.2007'
from works_on w inner join hr.employee e
on w.empno=e.emp_no and projectno='p1'
inner join company.Department d 
on dept_no=deptno and DeptName='sales'

--Delete the information in the works_on table for all employees who work for the department located in KW.
delete w from  works_on w inner join hr.employee e
on e.emp_no=w.empno inner join company.Department d
on e.dept_no=d.deptno and location='KW'


/*
Create an Audit table with the following structure 
ProjectNo
UserName 
ModifiedDate 
Budget_Old 
Budget_New 
p2
Dbo
2008-01-31
95000
200000

       This table will be used to audit the update trials on the Budget              
         column (Project table, Company DB)
If a user updated the budget column then the project number, username that made that update, 
the date of the modification and the value of the old and the new budget will be inserted 
into the Audit table
(Note: This process will take place only if the user updated the budget column)
*/
use [SD32-Company]



create table tb
(
projectno varchar(max),
username varchar (max),
ModifiedDate  date,
Budget_Old  int,
Budget_New  int

)
create trigger t1
on hr.project
for update 
as
if update(projectno)
begin
declare  @pronum varchar(max),@bold int,@bnew int
select @pronum=projectno  from inserted
select @bnew=budget   from inserted
select @bold=budget   from deleted
insert into tb values(@pronum,suser_name(),getdate(),@bold,@bnew)
end

---update hr.project set projectno='p1',projectname='dbo' ,budget=2000 where projectno='p1'


------par2--------


--Create an index on column (Hiredate) that allows you to cluster the data in table
---Department. What will happen?
use ITIdata
create nonclustered index indexHiredate
on department(Manager_hiredate) 
---Create an index that allows you to enter unique ages in the student table. What will happen?
create unique index indexage
on student(st_age)
--The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name 'dbo.Student' and the index name 'indexage'. The duplicate key value is (<NULL>).

--Try to Create Login Named(RouteStudent) who can access Only student and Course tables from ITI DB then allow him to select and insert data into tables and deny Delete and update
--Try to Create Login Named(RouteStudent) who can access Only student and Course tables from ITI DB then allow him to select and insert data into tables and deny Delete and update




---StdRoute
