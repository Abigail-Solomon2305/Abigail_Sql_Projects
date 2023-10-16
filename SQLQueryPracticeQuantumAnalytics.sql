

SELECT * FROM Production.Product

SELECT Color, StandardCost AS Price, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL
AND (Color = 'Silver' OR Color = 'Black')
AND Color = 'white'
AND Color = 'Red'
AND ListPrice BETWEEN £75 AND £750
ORDER BY ListPrice DESC


SELECT Gender, HireDate, BirthDate
FROM HumanResources.Employee
	WHERE Gender = 'M' 
	AND BirthDate BETWEEN 1962 AND 1970
	AND HireDate > 2001
AND Gender = 'F' AND BirthDate BETWEEN 1972 and 1975
AND HireDate BETWEEN 2001 AND 2002


select Gender, BirthDate, HireDate from HumanResources.Employee
where Gender Like 'M'
year(BirthDate) between 1962 and 1975 and
year(HireDate) > 2001;
UNION 
select Gender, BirthDate, HireDate from HumanResources.Employee
where Gender Like 'F'
and
year(BirthDate) between 1972 and 1975 and
year(HireDate) IN (2011, 2012);



SELECT TOP (10) ProductID, Name, Color, MAX (ListPrice), ProductNumber 
FROM Production.Product
WHERE ProductNumber LIKE 'BK%'
GROUP BY ProductID, Name, Color, ListPrice, ProductNumber


753	Road-150 Red, 56	Red
752	Road-150 Red, 52	Red
751	Road-150 Red, 48	Red
750	Road-150 Red, 44	Red
749	Road-150 Red, 62	Red
771	Mountain-100 Silver, 38	Silver
772	Mountain-100 Silver, 42	Silver
773	Mountain-100 Silver, 44	Silver
774	Mountain-100 Silver, 48	Silver
775	Mountain-100 Black, 38	Black

SELECT CONCAT (FirstName  LastName) AS 'FullName', 
PersonType, EmailAddress
FROM Person.Person AS PP LEFT OUTER JOIN Person.EmailAddress AS PEA
	ON PP.BusinessEntityID = PEA.BusinessEntityID
	WHERE SUBSTRING(LastName,1,4) LIKE SUBSTRING (Emailaddress, 1,4) 
	OR SUBSTRING(FirstName, 1, 5) LIKE SUBSTRING (LastName, 1,5);


	SELECT SUBSTRING(LastName,1,4) 
FROM Person.Person
	UNION 
	SELECT SUBSTRING(EmailAddress,1,4)
FROM Person.EmailAddress
SELECT SUBSTRING ( FirstName,1 ,1) SUBSTRING (LastName,1,1)
FROM Person.Person
UNION 
SELECT SUBSTRING (LastName,1,1)
FROM 



SELECT FirstName, substring(firstname,1,1), lastname FROM Person.Person


SELECT *
FROM [Production].[WorkOrderRouting]





SELECT ListPrice, Color
FROM [Production].[Product]
WHERE ListPrice < £200



SELECT COUNT Sentiment

IF boolean_expression   
BEGIN
    { statement_block }
END


SELECT *
FROM
[Purchasing].[PurchaseOrderDetail]

SELECT * FROM [Purchasing].[PurchaseOrderHeader]

--sample
SELECT a.ord_no,a.ord_date,a.purch_amt,
b.cust_name AS "Customer Name", b.grade, 
c.name AS "Salesman", c.commission 
FROM orders a 
INNER JOIN customer b 
ON a.customer_id=b.customer_id 
INNER JOIN salesman c 
ON a.salesman_id=c.salesman_id;



CREATE VIEW [MostExpensiveProduct] AS
SELECT Top (5)
FROM [Production].[Product]
WHERE Country = 'Brazil';

OR 

SELECT
 Columnname
    CASE
        WHEN DATEDIFF(day, required_date, shipped_date) < 0
        THEN 'Late'
        ELSE 'OnTime'
    END shipment
FROM 
    sales.orders
WHERE 
    shipped_date IS NOT NULL
ORDER BY 
    required_date;





(4./*Create a list of all contact persons, where the first 4 characters of the last name are
the same as the first four characters of the email address. Also, 
for all contacts whose first name and the last name begin with the same characters,
create a new column called full name combining first name and the last name only.
Also provide the length of the new column full name.*/

Question 5 
--Return all product subcategories that take an average of 3 days or longer to manufacture.

Question 6
--Create a list of product segmentation by defining criteria that places each item 
--in a predefined segment as follows. If price gets less than £200 then low value. 
--If price is between £201 and £750 then mid value.
--If between £750 and £1250 then mid to high value else higher value.
--Filter the results only for black, silver and red color products.


SELECT ListPrice, Color, Name,
CASE 
	WHEN Listprice < 200 THEN 'LowValue'
	WHEN ListPrice BETWEEN 201 AND 750 THEN 'MidValue'
	WHEN ListPrice BETWEEN 750 AND 1250 THEN 'Mid_To_High_Value'
ELSE 'HigherValue'
END AS Segment
FROM Production.Product
WHERE Color IN ('Black', 'Silver','Red') 











q. 4 ANSWERED AND CORRECT
SELECT CONCAT(FirstName, LastName)  AS 'Full name', PersonType, EmailAddress
	from Person.Person AS PP LEFT OUTER JOIN Person.EmailAddress AS PEA
	ON PP.BusinessEntityID = PEA.BusinessEntityID
			WHERE SUBSTRING(LastName, 1, 4) like SUBSTRING(EmailAddress, 1, 4) OR
			SUBSTRING(FirstName, 1, 5) like SUBSTRING(LastName, 1, 5);




SELECT  [DaysToManufacture]
FROM [Production].[Product]


ANSWERED AND CORRECT
5--Return all product subcategories that take an average of 3 days or longer to manufacture.

SELECT name AS ProductName, [DaysToManufacture]
FROM [Production].[Product]
WHERE [DaysToManufacture] >= 3



ANSWERED AND CORRECT
7--How many Distinct Job title is present in the Employee table?
SELECT COUNT(DISTINCT [JobTitle]) 
FROM [HumanResources].[Employee]


ANSWERED AND CORRECT
8.--Use employee table and calculate the ages of each employee at the time of hiring.
Select BirthDate, HireDate,
datediff(year, BirthDate, HireDate) Age 
from HumanResources.Employee

/*
Select BirthDate, HireDate,
datediff(year, BirthDate, HireDate) AS Age 
from HumanResources.Employee
WHERE  
DATEADD(YEAR,65,Birthdate)  AS added_date

SELECT NationalIDNumber, JobTitle, HireDate,
DATEADD(YEAR, 65, HireDate) AS SENTIMENT_AGE
FROM HumanResources.Employee
*/


ANSWERED AND CORRECT
9.--How many employees will be due a long service award in the next 5 years, if long service is 20 years?

SELECT NationalIDNumber, JobTitle, HireDate, DATEADD(YEAR, 15, HireDate) AS DUEFORLONGSERVICEAWARD
FROM HumanResources.Employee
WHERE DATEADD(YEAR, 15, HireDate) <=  EOMONTH(GETDATE());




NOT DONE, STILL ON
10--How many more years does each employee have to work before reaching sentiment,
if sentiment age is 65?
SELECT NationalIDNumber,  JobTitle, BirthDate, HireDate,
	DATEDIFF (Year,BirthDate, HireDate)   AS PresentAge
FROM HumanResources.Employee 
(---9
SELECT NationalIDNumber, JobTitle, HireDate, DATEADD(YEAR, 15, HireDate) AS DUEFORLONGSERVICEAWARD
FROM HumanResources.Employee
WHERE DATEADD(YEAR, 15, HireDate) <=  EOMONTH(GETDATE());
---8
Select BirthDate, HireDate,
datediff(year, BirthDate, HireDate) Age 
from HumanResources.Employee
)
;


SELECT NationalIDNumber, BirthDate, 
GETDATE() AS TODAY, 65, 
DATEDIFF(YEAR, BirthDate, GETDATE()) AS AGE_LEFT
FROM HumanResources.Employee;




NOT DONE
question 11
--Implement new price policy on the product table base on the colour of the item
--If white increase price by 8%, If yellow reduce price by 7.5%, If black increase 
--price by 17.2%. If multi, silver, silver/black or blue take the square root of the 
--price and double the value. Column should be called Newprice. For each item, 
--also calculate commission as 37.5% of newly computed list price.

SELECT Color, ListPrice,
CASE	
	WHEN Color = 'White' THEN (ListPrice+0.08)
	WHEN Color = 'Yellow' THEN (ListPrice - 0.075)
	WHEN Color = 'Black' THEN (ListPrice + 0.172)
	WHEN Color IN ('multi', 'silver', 'silver/black', 'blue') THEN SQRT(490)
	ELSE 'Money'
	END AS NEWPRICE  
FROM[Production].[Product]


SELECT CommissionPct,
FROM Sales.SalesPerson
CASE
WHEN COLOR LIKE BLACK THEN COMMISSION = (STANDARDCOSTMARGIN*14.79/100+22%
WHEN COLOR LIKE RED THEN COMMISSION = (STANDARD COS)


select StandardCost, Color, ListPrice
from production.product
 

 SELECT 




SELECT Color, ListPrice
from [Production].[Product]
ORDER BY Listprice
SELECT LISTPRICE, COLOR,
CASE 
WHEN COLOR LIKE 'WHITE' THEN 'INCREASE ListPrice BY 8%'
WHEN COLOR LIKE 'YELLOW' THEN 'REDUCE ListPrice BY 7.5%'
WHEN COLOR LIKE 'BLACK' THEN 'INCREASE ListPrice BY 17.2%'



ANSWERED AND CORRECT
QUESTION 12
--Print the information about all the Sales.Person and their sales quota. 
--For every Sales person you should provide their FirstName, LastName,
--HireDate, SickLeaveHours and Region where they work



SELECT FirstName, LastName, SalesQuota, PersonType, HireDate, SickLeaveHours, CountryRegionCode
from Person.Person AS PP 
	INNER JOIN HumanResources.Employee AS HRE
	ON PP.BusinessEntityID = HRE.BusinessEntityID 
INNER JOIN Sales.SalesPerson AS SS
ON HRE.BusinessEntityID = SS.BusinessEntityID 
	INNER JOIN Sales.SalesTerritory AS SST
	ON SS.TerritoryID = SST.TerritoryID;


	STILL ON
	Question 13
--Question 13 Using adventure works, write a query to extract the following information.
--• Product name • Product category name • Product subcategory name • Sales person •
--Revenue • Month of transaction • Quarter of transaction • Region

 

SELECT Name AS productName, ProductCategoryID AS ProductCategoryName, PersonType 
ProductSubcategoryID AS Pro_Sb_Name, 
FROM Production.ProductSubcategory AS PPSC
INNER JOIN Sales.SalesPerson AS SSP
ON PP.BusinessEntityID = SSP.BusinessEntityID


SELECT ProductCategoryID, ProductSubcategoryID, Name
FROM Production.ProductSubcategory

DATEPART(Q,
SELECT TOP 5 * FROM Production.ProductCategory
SELECT TOP 5 * FROM Production.ProductSubcategory
SELECT * FROM Person.Person
SELECT * from Sales.SalesPerson
select * from sales.SalesPersonQuotaHistory


ANSWERED CORRECT
--Question 14  
--Display the information about the details of an order i.e. order number, order date,
--amount of order, which customer gives the order and which salesman works for
--that customer and how much commission he gets for an order.


SELECT SalesOrderNumber as Ord_No, OrderDate, OrderQty as Amt_Of_Ord,
SalesPersonID as SalesMan, CustomerID, CommissionPct
FROM Sales.SalesOrderHeader AS SSOH
INNER JOIN Sales.SalesOrderDetail AS SSOD
ON SSOH.SalesOrderID = SSOD.SalesOrderID 
INNER JOIN Sales.SalesPerson AS SSP
ON SSP.TerritoryID = SSOH.TerritoryID


NOT DONE   QUESTIONS , 10 , 11,13 and 15 t go

/*Question 15
For all the products calculate
- Commission as 14.790% of standard cost,
- Margin, if standard cost is increased or decreased as follows:
Black: +22%,
Red: -12%
Silver: +15%
Multi: +5%
White: Two times original cost divided by the square 
root of cost For other colours, standard cost remains the same*/



ANSWERED  AND CORRECT
/*Question 16
Create a view to find out the top 5 most expensive products for each colour.*/


--(SELECT  DISTINCT TOP 5 Listprice, color
--FROM Production.product
--ORDER BY ListPrice DESC;)	tHIS SYNTAX LED US TO THE THE RESULT FOR CREATE VIEW

	
CREATE VIEW MostExpensiveProduct 
AS 
SELECT  DISTINCT TOP 5  Listprice, color
FROM Production.product
WHERE ListPrice IN  (3578.27,3399.99,3374.99,2443.35,2443.35)

