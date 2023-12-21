use ITIdata
--1.	Create a scalar function that takes a date and returns the Month name of that date.
create function getmonth(@date date)
returns varchar(50)
begin
declare @name varchar(50)
select @name= (format(@date,'MMMM') )
return @name
end
select dbo.getmonth('12-4-2023')
--------------------------
-------------------
create function get_month(@date date)
returns varchar(50)
begin
 declare @monthname varchar(50)
 if month(@date)=1
  select @monthname = 'january'
   if month(@date)=2
  select @monthname = 'febrewary'
   if month(@date)=3
  select @monthname = 'march'
   if month(@date)=4
  select @monthname = 'april'
   if month(@date)=5
  select @monthname = 'may'
   if month(@date)=6
  select @monthname = 'jun'
   if month(@date)=7
  select @monthname = 'jully'
   if month(@date)=8
  select @monthname = 'augast'
   if month(@date)=9
  select @monthname = 'september'
   if month(@date)=10
  select @monthname = 'october'
   if month(@date)=11
  select @monthname = 'novamber'
   if month(@date)=12
  select @monthname = 'december'

   return @monthname
end

select dbo.get_month('12-4-2023')


--2.	 Create a multi-statements table-valued function that takes 2 
-- integers and returns the values between them.
create function get_value_between(@num1 int,@num2 int)
returns @table table
(val int)
as
 begin
	  declare @val int = @num1+1
      while  @val<@num2 
      begin
      insert into @table select @val
      select @val+=1
      end
     return
end
select*from dbo.get_value_between(0,20) 



------------------
---3.	 Create a table-valued function that takes Student No and returns Department Name
---with Student full name.
create function get_std_dept(@id int)
returns table
as
return
(select Dept_Name,S.St_Fname+' '+s.St_Lname as 'full name'
from Department d,Student s
where  St_Id=@id and d.Dept_Id=s.Dept_Id )
select *from get_std_dept(3)


--------
---4.	Create a scalar function that takes Student ID and returns a message to user 
---a.	If first name and Last name are null then display 'First name & last name are null'
--b.	If First name is null then display 'first name is null'
--c.	If Last name is null then display 'last name is null'
--d.	Else display 'First name & last name are not null'

create function display(@id int)
returns varchar(50)
begin
declare @msg varchar(50)
declare @firstname varchar(20)
declare @lastname varchar(20)
select @firstname=st_fname from Student where St_Id=@id
select @lastname=St_Lname from Student where St_Id=@id
if @firstname is null and @lastname is null
select @msg= 'First name & last name are null'

if @firstname is null
select @msg= 'First name is null'
if @lastname is null
select @msg= 'last name is null'
else
select @msg= 'First name & last name are not null'
return @msg
end

select dbo.display(30)
----------------
--5.	Create a function that takes an integer which represents the format of the Manager hiring
--date and displays department name, Manager Name and hiring date with this format. 

alter function dbo.displayformatofdate(@id int, @format_hiredate int)
returns @table table (Department_Name varchar(20), Manager_Name varchar(20), hDate varchar(10))
as
begin
    insert into @table
    select d.Dept_Name, i.Ins_Name, 
          case
               when @format_hiredate = 1 then convert(varchar(10), d.Manager_hiredate, 101)
               when @format_hiredate = 2 then convert(varchar(10), d.Manager_hiredate, 120)
              when @format_hiredate = 3  then convert(varchar(10), d.Manager_hiredate, 103) 
              else convert(varchar(10), d.Manager_hiredate, 101) -- Default to MM/DD/YYYY
           end as hiredate
    from Department d
    inner join Instructor i on d.Dept_Manager = i.Ins_Id
    where i.Ins_Id = @id

    return
end

select *from displayformatofdate(2,1)
select *from displayformatofdate(2,2)
select *from displayformatofdate(2,3)

-------------------------
------6.	Create multi-statement table-valued function that takes a string
---a.	If string='first name' returns student first name
-----b.	If string='last name' returns student last name 
--c.	If string='full name' returns Full Name from student table  (Note: Use “ISNULL” function)
create function checkname(@name varchar(50))
returns @table table
(
name varchar(50)
)
as  begin
if @name='first name'
insert into @table
select ISNULL(st_fname,' ')from Student
else if @name='last name'
insert into @table
select ISNULL(St_Lname,' ')from Student
else if @name='full name'
insert into @table
select ISNULL(St_Fname+' '+St_Lname,' ')from Student
return
end
select * from checkname('first name')

---------------------
----------------------------------
-------------------
----part2
---------
--1.	 Create a view that displays the student's full name, course name
--if the student has a grade more than 50.
create view studentview
as 
select st_fname+' '+st_lname as fullname,crs_name
from Student s inner join Stud_Course sc
on s.St_Id=sc.St_Id
inner join Course c
on c.Crs_Id=sc.Crs_Id and grade>50

select *from studentview

--Create an Encrypted view that displays manager names and the topics they teach. 
create view Display_manager
with encryption
as
select distinct i.Ins_Name ,t.Top_Name
from Department d
join Instructor i on d.Dept_Manager = i.Ins_Id
join Ins_Course ic on i.Ins_Id = ic.Ins_Id
join Course c on ic.Crs_Id = c.Crs_Id
join Topic t on  c.Top_Id = t.Top_Id

select * from Display_manager 

--3.	Create a view that will display Instructor Name, Department Name for
--the ‘SD’ or ‘Java’ Department “use Schema binding”
--and describe what is the meaning of Schema Binding
 create view dbo.instructor_department
 WITH SCHEMABINDING
 as
   select ins_name,dept_name from dbo.Instructor i 
   inner join dbo.Department d on d.Dept_Id=i.Dept_Id and d.Dept_Name in ('sd','java')

 select*from instructor_department
 /*
Schema binding is an optional feature in SQL Server that can be used when creating views or functions. When you specify WITH SCHEMABINDING while creating a view or function, it "binds" the view or function to the schema of the underlying objects it references.
- when schema binding is used, any modifications to the underlying objects require dropping and recreating the view or function.
*/


