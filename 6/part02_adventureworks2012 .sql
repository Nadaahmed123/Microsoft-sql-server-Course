/*1.	 Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema)
to designate SalesOrders thatoccurred within the
period ‘7/28/2002’ and ‘7/29/2014’*/
select SalesOrderID,ShipDate
from Sales.SalesOrderHeader
where  OrderDate between '7/28/2002' and '7/29/2014'
/*2.	 Display only Products(Production schema) with a StandardCost
below $110.00 (show ProductID, Name only)*/
select productid,name,StandardCost
from Production.Product
where StandardCost<110.00
--3.	 Display ProductID, Name if its weight is unknown
select productid,name
from Production.Product
where Weight is null
--4.	 Display all Products with a Silver, Black, or Red Color
select *
from Production.Product
where color in ('silver','black','red')
--5.	 Display any Product with a Name starting with the letter B
select *
from Production.Product
where name like 'B%'
/*6.	Run the following Query
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3	
Then write a query that displays any Product description with underscore value in its description.
*/
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3	
select * 
from Production.ProductDescription
where Description like '%[_]%'
--7.	 Display the Employees HireDate (note no repeated values are allowed)
select distinct hiredate
from HumanResources.Employee
/*8.	Display the Product Name and its ListPrice within the values
of 100 and 120 the list should have the following format "The [product name] is only!
[List price]" (the list will be sorted according to its ListPrice value)*/
select concat('the [',name ,'] is only!',' [',listprice,']') as product
from Production.Product
where ListPrice between 100 and 120
order by listprice
