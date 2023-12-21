--1
SELECT DISTINCT Ins_Name FROM Instructor;
--2
SELECT i.ins_Name AS InstractorName, d.Dept_Name AS DepartmentName
FROM Instructor i
LEFT JOIN Department d ON i.Dept_Id = d.Dept_Id;
---3
SELECT s.st_Fname + ' ' + s.st_Lname AS StudentFullName, c.Crs_Name
FROM Student s
INNER JOIN Stud_Course sc ON s.St_id = sc.St_Id
INNER JOIN Course c ON sc.Crs_id = c.Crs_Id;


SELECT @@VERSION
SELECT @@SERVERNAME
/*
SELECT @@VERSION: This statement retrieves the version information 
of the SQL Server instance that you are connected to. The result will 
be a string that includes the version number and other details about the SQL Server instance.
For example, the result might look like "Microsoft SQL Server 2019 (RTM) - 15.0.2000.5".

SELECT @@SERVERNAME: This statement retrieves the name of the SQL Server instance. 
The result will be a string that represents the name of the server where the
SQL Server instance is running. The server name can be useful for identifying the specific
server in a multi-server environment.
*/