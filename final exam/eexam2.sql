use Library
--1. Write a query that displays Full name of an employee who has more than
--3 letters in his/her First Name.{1 Point}
select concat(fname, ' ', lname) as "full name"
from Employee where len(fname) > 3;

--2. Write a query to display the total number of Programming books
--available in the library with alias name ‘NO OF PROGRAMMING
---BOOKS’ {1 Point}
select count(*) as "NO OF PROGRAMMING BOOKS"
from book b join Category c 
on c.Id=b.Cat_id and c.Cat_name = 'programming'

---3. Write a query to display the number of books published by
--(HarperCollins) with the alias name 'NO_OF_BOOKS'. {1 Point}
select count(*) as NO_OF_BOOKS
from book b join Publisher p
on b.Publisher_id=p.Id and p.Name = 'HarperCollins';

--4. Write a query to display the User SSN and name, date of borrowing and
---due date of the User whose due date is before July 2022. {1 Point}
select u.SSN as "User SSN" , u.User_Name as "user name", bor.Borrow_date as "date of borrowing", bor.Due_date as "due date"
from Users u join Borrowing bor 
on u.SSN = bor.User_ssn
where bor.Due_date < '2022-07-01';

--5. Write a query to display book title, author name and display in the
---following format,
---' [Book Title] is written by [Author Name]. {2 Points}

select  concat('[', b.title, '] is written by [', a.Name, '].') 
from book b join Book_Author ba on b.Id = ba.Book_id
join Author a on a.Id=ba.Author_id;

--6. Write a query to display the name of users who have letter 'A' in their
--names. {1 Point}
select user_name
from users
where user_name like '%A%';

--7. Write a query that display user SSN who makes the most borrowing{2
--Points}
select top (1) user_ssn
from Borrowing
group by user_ssn
order by count(*) desc;

--8. Write a query that displays the total amount of money that each user paid
---for borrowing books. {2 Points}
select user_ssn, sum(amount) as "total amount of money"
from Borrowing
group by user_ssn;

--9. write a query that displays the category which has the book that has the
----minimum amount of money for borrowing. {2 Points}
select  top(1) c.id,c.Cat_name
from Category c
join book b on b.Cat_id = c.Id
join Borrowing bor on b.Id = bor.Book_id
group by  c.id, c.cat_name
order by min(bor.Amount);

--10.write a query that displays the email of an employee if it's not found,
-----display address if it's not found, display date of birthday. {1 Point}

/*select id, coalesce (email,address,cast (dob as varchar(50)))
from Employee*/
select coalesce (email,address,cast (dob as varchar(50)))
from Employee
--11. Write a query to list the category and number of books in each category
----with the alias name 'Count Of Books'. {1 Point}

select c.Cat_name, count(*) as 'Count Of Books'
from Book b join Category c 
ON b.Cat_id= c.Id
group by Cat_name
order by 'Count Of Books';

--12. Write a query that display books id which is not found in floor num = 1
--and shelf-code = A1.{2 Points}
select Book.Id
from Book
where not exists (
select * from Shelf
where Shelf.Code = Book.Shelf_code and shelf.Floor_num = 1 and Shelf.Code = 'A1'
)

--13.Write a query that displays the floor number , Number of Blocks and
----number of employees working on that floor.{2 Points}
select f.Number,f.Num_blocks ,count(*) as 'number of employees'
FROM Employee e
JOIN Floor f on e.Id = f.MG_ID or e.Floor_no=f.Number
GROUP BY f.Number,f.Num_blocks;

---14.Display Book Title and User Name to designate Borrowing that occurred
-----within the period ‘3/1/2022’ and ‘10/1/2022’.{2 Points}
select b.Title as "Book Title", u.User_name as "User Name" 
from Borrowing bor
join Book b on bor.Book_id= b.Id
join Users u on bor.User_ssn= u.SSN
where bor.Borrow_date between cast('3/1/2022'as date) and cast('10/1/2022' as date);

--15.Display Employee Full Name and Name Of his/her Supervisor as
---Supervisor Name.{2 Points}
select e.fname+' '+e.lname as 'Employee Full Name', super.fname+' '+super.lname as 'Supervisor Name'
from Employee  e ,Employee super
where e.Super_id= super.id
order by super.fname
----using join-------
select e.fname+' '+e.lname as 'Employee Full Name', super.fname+' '+super.lname as 'Supervisor Name'
from Employee  e inner join Employee super
on e.Super_id= super.id
order by super.fname

---16.Select Employee name and his/her salary but if there is no salary display
----Employee bonus. {2 Points}
--------------------using isnull----------------------
select fname+' '+lname as 'Employee Full Name', isnull(salary,bouns)
from employee
----------usig coalesce function------------
select fname+' '+lname as 'Employee Full Name', coalesce (salary,bouns)
from employee 

--17.Display max and min salary for Employees {2 Points}
select max(salary) as"max value" , min(salary) as "min value"
from employee
--18.Write a function that take Number and display if it is even or odd {2 Points}
create function even_Odd(@x int)
returns varchar(5)
as 
  begin
    declare @result varchar(5);
    if @x % 2 = 0
	begin
     set @result = 'even';
	end
   else
    begin
     set @result = 'odd';
    end
return @result;
end;
select dbo.evenOrOdd(9);
select dbo.evenOrOdd(2);

---19.write a function that take category name and display Title of books in that
----category {2 Points}
create function display_Book(@x varchar(50))
returns table
as
return
(
select b.title
from book b join category c
on   c.Id=b.Cat_id and c.cat_name=@x

)

select * from display_Book('self improvement');

---20. write a function that takes the phone of the user and displays Book Title ,
----user-name, amount of money and due-date. {2 Points}
create function display_user(@phone varchar(11))
returns table
as
return
(
select b.title ,u.User_Name,bor.Amount,bor.Due_date
from book b join Borrowing bor on b.Id=bor.Book_id
join users u  on u.SSN=bor.User_ssn
join User_phones ph
on   u.SSN=ph.User_ssn and ph.Phone_num=@phone

)
select * from display_user('0102302155')

----21.Write a function that take user name and check if it's duplicated
---return Message in the following format ([User Name] is Repeated
---[Count] times) if it's not duplicated display msg with this format [user
--name] is not duplicated,if it's not Found Return [User Name] is Not
----Found {2 Points}
create function checkUsername(@name varchar(50))
returns varchar(100)
as 
begin
declare @i int;
declare @msg varchar(max)
select @i = count(*)
from Users
where User_name = @name;
if @i > 1
 set @msg= concat('[', @name, ']  is Repeated [', @i, '] times')
else if @i = 1
set @msg=concat('[', @name, '] is not duplicated');
else
set @msg=concat('[', @name, ']  is Not Found');
return @msg
end

select dbo.checkUsername('Amr Ahmed')
/*select dbo.checkUsername('Alaa Omar')
select dbo.checkUsername('Nada Ahmed')
*/
--22.Create a scalar function that takes date and Format to return Date With
----That Format. {2 Points}
create function dateformate(@datee date,@f varchar(30))
returns varchar(30)
begin 
declare @x varchar(30)
select @x=FORMAT(@datee,@f)
return @x
end
select dbo.dateformate(getdate(),'dddd')
select dbo.dateformate('3-10-2023','dd/MM/yyyy')
---------
create function dateformatee(@datee date,@f int)
returns varchar(30)
begin 
declare @x varchar(30)
select @x=convert(varchar(30),@datee,@f)
return @x
end
select dbo.dateformatee(getdate(),105)


--23.Create a stored procedure to show the number of books per Category.{2
---Points}
create proc numberofbooks
as
select c.Cat_name   ,count(b.id) as 'number of books'
from Category c INNER JOIN book b
ON c.Id=b.Cat_id
group by Cat_name

numberofbooks

----24.Create a stored procedure that will be used in case there is an old manager
--who has left the floor and a new one becomes his replacement. The
--procedure should take 3 parameters (old Emp.id, new Emp.id and the
---floor number) and it will be used to update the floor table.
create proc Manager @old_id int,@new_id int ,@floornum int 
as 
update floor set MG_ID=@new_id
where MG_ID=@old_id and Number=@floornum
Manager  3,4,3
/*
create proc Manager1 @old_id int,@new_id int ,@floornum int 
as 
update floor set MG_ID=@new_id,Number=@floornum
where MG_ID=@old_id 

Manager1  2,10,99
*/

--25.Create a view AlexAndCairoEmp that displays Employee data for users
--who live in Alex or Cairo. {2 Points}

create view AlexAndCairoEmp
as 
select * from Employee
where Address in ('cairo','alex')

select * from AlexAndCairoEmp
--26.create a view "V2" That displays number of books per shelf {2 Points}
 alter view V2
 as
 select s.Code as code, count(b.Id) as 'numberofbooks'
 from book b inner join shelf s
 on b.Shelf_code=s.Code
 group by (s.code)

 select * from V2 
--27.create a view "V3" That display the shelf code that have maximum
---number of books using the previous view "V2" {2 Points}
alter view v3 
as  
select code ,numberofbooks from v2

where numberofbooks in( select max(numberofbooks) from V2)
select * from v3

-------------

---28.Create a table named ‘ReturnedBooks’ With the Following Structure :
--User SSN Book Id Due Date Return
--Date
--fees
create table ReturnedBooks
(
userSSN int,
bookID int,
duedate date,
returnDate date,
fees float
)
--then create A trigger that instead of inserting the data of returned book
---checks if the return date is the due date or not if not so the user must pay
----a fee and it will be 20% of the amount that was paid before. {3 Points}
create trigger ReturnDate
on ReturnedBooks
instead of insert
as 
update ReturnedBooks 
set fees = fees*0.2
where not  exists (select * from ReturnedBooks where returndate = duedate)
-------------insert into ReturnedBooks values(6,2,'2022-03-01','2022-03-01',.8)
--29.In the Floor table insert new Floor With Number of blocks 2 , employee
--with SSN = 20 as a manager for this Floor,The start date for this manager
--is Now. Do what is required if you know that : Mr.Omar Amr(SSN=5)
--moved to be the manager of the new Floor (id = 6), and they give Mr. Ali
--Mohamed(his SSN =12) His position . {3 Points}
begin transaction
begin try
insert into managment.Floor (number,Num_blocks,MG_ID,Hiring_Date )
values (6,2,20,getdate())
update Employee set Floor_no = 6 where id = 5;
update Employee set Floor_no= (select floor_no from Employee where id = 5) 
where id=12;
commit;
end try
begin catch
    rollback
end catch;
--30.Create view name (v_2006_check) that will display Manager id, Floor
--Number where he/she works , Number of Blocks and the Hiring Date
--which must be from the first of March and the May of December
--2022.this view will be used to insert data so make sure that the coming
--new data must match the condition then try to insert this 2 rows and
--Mention What will happen {3 Point}
--Employee Id Floor Number Number of Blocks Hiring Date
--          2   6            2                    7-8-2023
--4 7 1 4-8-2022
alter view v_2006_check
as
select mg_Id ,Number, Num_Blocks ,Hiring_Date from  Floor
where hiring_date >= '2022-03-01' and hiring_date<= '2022-12-31'
insert into v_2006_check (mg_Id ,Number, Num_Blocks ,Hiring_Date)
select 2,6, 2 ,'2023-07-08'
where '2023-07-08' between '2022-03-01' and  '2022-12-31'
insert into v_2006_check (mg_Id ,Number, Num_Blocks ,Hiring_Date)
select 4,7,1 ,'2023-04-08'
where '2022-04-08' between '2022-03-01' and  '2022-12-31'
--31.Create a trigger to prevent anyone from Modifying or Delete or Insert in
--the Employee table ( Display a message for user to tell him that he can’t
--take any action with this Table) {3 Point}
create trigger preventactions 
on employee 
instead of update,delete,insert
as select ' he can’t take any action with this Table'
---delete Employee
--32.Testing Referential Integrity , Mention What Will Happen When:
--A. Add a new User Phone Number with User_SSN = 50 in
---User_Phones Table {1 Point}
insert into user_phones (user_ssn,phone_num)
values(50,'01096601631')
--The INSERT statement conflicted with the FOREIGN KEY constraint "FK_User_phones_User". The conflict occurred in database

--B. Modify the employee id 20 in the employee table to 21 {1 Point}
update employee set Id=21
where id =20
---i can't take any action on the table there is trigger
--C. Delete the employee with id 1 {1 Point}
delete from employee 
where id=1
---i can't take any action on the table there is trigger
--D. Delete the employee with id 12 {1 Point}
delete from employee 
where id=12
---i can't take any action on the table there is trigger
--E. Create an index on column (Salary) that allows you to cluster the
--data in table Employee. {1 Point}create clustered index clustered_salaryon employee(salary)--i Cannot create more than one clustered index on table 'employee'.i must first Drop the existing clustered index before creating another

---33.Try to Create Login With Your Name And give yourself access Only to
--Employee and Floor tables then allow this login to select and insert data
--into tables and deny Delete and update (Don't Forget To take screenshot
---to every step) {5 Points}

create schema managment

alter schema managment 
transfer employee
alter schema managment 
transfer floor
