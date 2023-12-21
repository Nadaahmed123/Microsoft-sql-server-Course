
use MyCompany
---part 1
---7.	Create function that takes project number 
--and display all employees in this project (Use MyCompany DB)

create function displayemployees(@pro_Num int)
returns @table table (FullName varchar(50) ,projectName  varchar(50))
begin
	insert into @table
	select e.Fname+' '+e.Lname as FullName ,w.Pno
	from Employee e ,Works_for w 
	where e.SSN=w.ESSn and Pno=@pro_Num
return
end
select * from displayemployees(500)


---part 2
--4.	Create a view that will display the project name and the number of
--employees working on it. (Use Company DB)
create view  Display_Project
as
select p.Pname ,w.ESSn
FROM Project p , Works_for w
WHERE p.Pnumber = w.Pno

select*from Display_Project

