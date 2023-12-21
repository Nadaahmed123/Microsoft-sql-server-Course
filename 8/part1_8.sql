--1.	 Create a view “V1” that displays student data for students who live in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=’tanta’
--Where st_address=’alex’;


create view v1 as
select *
from Student 
where st_address IN ('Alex', 'Cairo')
WITH CHECK OPTION;
update v1 set st_address='tanta'
Where st_address='alex';


use [SD32-Company]
--1.	Create view named “v_dept” that will display the department# and department name
alter VIEW v_dept AS
Select deptno,DeptName
FROM department;
--2.	using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’
insert into department (deptno,DeptName)
VALUES (4, 'Development');
---Cannot insert duplicate key in object 'dbo.Department'. The duplicate key value is (4).

--3.	Create view name “v_2006_check” that will display employee Number, 
---the project Number where he works and the date of joining the project which must be
---from the first of January and the last of December 2006.this view will be used to insert 
--data so make sure that the coming new data must match the condition



