use MyCompany
/*1.	Display the data of the department which has 
the smallest employee ID over all employees' ID.*/
select d.* from Departments d ,Employee e
where d.dnum=e.dno and ssn =( select min(ssn) from Employee e)
--2.	List the last name of all managers who have no dependents.
select distinct lname from Employee 
inner join Departments on ssn=MGRSSN
left join Dependent on ssn=ESSN 
where essn is null
/*3.	For each department-- if its average salary is less than the 
average salary of all employees display its number, 
name and number of its employees.
*/
select Dnum,dname,count(ssn) as "count employess "
from Employee e,Departments d
where d.dnum=e.dno
group by d.Dnum,d.dname
having avg(Salary)<(select AVG(salary) from Employee )
--4.	Try to get the max 2 salaries using subquery
select fname, lname, Salary
from (
select ROW_NUMBER() over (order by salary desc) AS rowsnumber, fname, lname, Salary
from Employee
) AS Employee_row_number
WHERE rowsnumber <= 2
-------------------
select  top 2(salary) 
from employee  
order by salary desc

/*5.	Display the employee number and name if he/she has at least one
dependent (use exists keyword) self-study.*/
select ssn,(fname+'  '+ lname ) as "full name "
from Employee
where exists (select ssn,essn 
from Employee, Dependent 
where ssn=essn)

