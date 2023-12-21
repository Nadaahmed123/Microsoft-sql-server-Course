
INSERT INTO Students
VALUES ('nada', 'ahmed', 30,'tanta',20);
INSERT INTO Students
VALUES ('ali', 'sami', 30,'shebien',10);
insert into Courses
VALUES(1,'front',3,'guyjghm hjfgj k',1);
insert into Courses
VALUES(2,'back',5,'guyjghm hjfgj k',2);
INSERT INTO Departments
VALUES(40,'is','2021-12-12',1);
INSERT INTO Instructors
VALUES (2,'ahmed','tanta',0.6,1200,3,3);
INSERT INTO Departments
VALUES(50,'cs','2011-12-12',3);
INSERT INTO Topics
VALUES(1,'html');
INSERT INTO Topics
VALUES(2,'js');
INSERT INTO Stud_Course
VALUES(10,2,70.00);
INSERT INTO Stud_Course
VALUES(20,1,90.50);
--1
INSERT INTO Students (FName, LName, Dep_Id)
VALUES ('asmaa', 'mohamed', 30);
--2
INSERT INTO Instructors (Name, id, Salary)
VALUES ('nada', 30, 4000);
UPDATE Instructors
SET Salary = Salary * 1.2
WHERE id = 30;