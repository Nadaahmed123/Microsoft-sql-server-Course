use ITIdata
--1.	Create a trigger to prevent anyone from inserting a new record in 
--the Department table ( Display a message for user to tell him that he can’t insert a new record in that table )

create trigger PreventInsertDept
ON Department
FOR INSERT
AS SELECT 'can’t insert a new record in that table'


INSERT INTO Department 
	VALUES (90,'web','webb','cairo',2,'2010-12-12');
---2.	Create a table named “StudentAudit”. Its Columns are (Server User Name , Date, Note) 
create table SstudentAudit
 (
 server_username varchar(50),
 datee date,
 note varchar(50)
 )

 --3.	Create a trigger on student table after insert to add Row in StudentAudit table 
--•	 The Name of User Has Inserted the New Student  
--•	Date
--•	Note that will be like ([username] Insert New Row with Key = [Student Id] in table [table name]
 alter trigger sttaudit
 ON Student
AFTER INSERT
AS
DECLARE @id NCHAR(10)= CONVERT(NCHAR(10),(SELECT St_Id FROM INSERTED))

INSERT INTO SstudentAudit (server_username, Datee, Note)
	VALUES (@@servername, GETDATE(), '['+SUSER_SNAME()+'] Insert New Row with Key=['+@id+'] in table [ dbo.Student ]')




--4.	Create a trigger on student table instead of delete to add Row in StudentAudit table 
--○	 The Name of User Has Inserted the New Student
--○	Date
--○	Note that will be like “try to delete Row with id = [Student Id]” 


create trigger noDeleteStd
ON Student
instead of delete
as

INSERT INTO SstudentAudit (server_username, datee, note)
	VALUES (@@servername, GETDATE(), 'try to delete Row with id=[Student Id]')

delete from Student
WHERE St_Id=16

--5.	Create a trigger that prevents the insertion Process for Employee table in March.
use MyCompany

create trigger Prevent_Insert_march
ON Employee
for insert
as
 DECLARE @CurrentMonth NVARCHAR(50) 
 
 SELECT @CurrentMonth=DATENAME(MONTH,GETDATE())
  IF @CurrentMonth='march'
	 BEGIN
		SELECT 'can’t insert a new record in march'
	 END
   
