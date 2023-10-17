ADVENTURE_WORKS DB SQL TASK



--Retrieve information about the products with colour values except null, red, silver/black, white and list price between
--£75 and £750. Rename the column StandardCost to Price. Also, sort the results in descending order by list price.


 SELECT ProductID, Name, ProductNumber, StandardCost AS PRICE, ListPrice, Color
FROM [Production].[Product]
WHERE ListPrice BETWEEN 75 AND 750
AND 
Color <> 'Red' and color <> 'Silver/Black' and color <> 'White' and color <> 'NULL'
ORDER BY ListPrice DESC;







--Find all the male employees born between 1962 to 1970 and with hire date greater than 2001 and female
--employees born between 1972 and 1975 and hire date between 2001 and 2002.



SELECT Gender, BirthDate, HireDate 
FROM HumanResources.Employee
WHERE Gender LIKE 'M'
AND
year(BirthDate) BETWEEN 1962 AND 1970 AND
year(HireDate) > 2001
UNION 
SELECT Gender, BirthDate, HireDate
FROM HumanResources.Employee
WHERE Gender LIKE 'F'
AND
year(BirthDate) BETWEEN 1972 AND 1975 AND
year(HireDate) IN (2011, 2012);





--Create a list of 10 most expensive products that have a product number 
--beginning with ‘BK’. Include only the product ID, Name and colour.



SELECT TOP(10) ProductID, Name, Color, Listprice 
FROM Production.Product
WHERE ProductNumber LIKE 'BK%'
ORDER BY ListPrice DESC;


  4
/*Create a list of all contact persons, where the first 4 characters of the last name are
the same as the first four characters of the email address. Also, 
for all contacts whose first name and the last name begin with the same characters,
create a new column called full name combining first name and the last name only.
Also provide the length of the new column full name.*/


SELECT FirstName + '  ' + LastName AS 'FullName', 
PersonType, EmailAddress
FROM Person.Person AS PP LEFT OUTER JOIN Person.EmailAddress AS PEA
	ON PP.BusinessEntityID = PEA.BusinessEntityID
	WHERE SUBSTRING(LastName,1,4) LIKE SUBSTRING (Emailaddress, 1,4) 
	OR SUBSTRING(FirstName, 1, 5) LIKE SUBSTRING (LastName, 1,5);





  5
--Return all product subcategories that take an average of 3 days or longer to manufacture.

SELECT  *  
FROM [Production].[Product]
WHERE [DaysToManufacture] > 3






  6
--Create a list of product segmentation by defining criteria that places each item 
--in a predefined segment as follows. If price gets less than £200 then low value. 
--If price is between £201 and £750 then mid value.
--If between £750 and £1250 then mid to high value else higher value.
--Filter the results only for black, silver and red color products.



SELECT Name AS ProductName, ListPrice, Color,
CASE 
	WHEN ListPrice < £200 THEN 'Low Value'
	WHEN ListPrice BETWEEN £201 and £750 THEN 'Mid Value'
	WHEN ListPrice BETWEEN £750 and £1250 THEN 'Mid to High Value'  
	ELSE 'Higher Value'
	END AS Segment
FROM [Production].[Product]
WHERE Color IN ('Black','Silver','Red');



  7
--How many Distinct Job title is present in the Employee table?

SELECT COUNT (DISTINCT JobTitle) AS DistinctJobTitle
FROM [HumanResources].[Employee]





  8
--Use employee table and calculate the ages of each employee at the time of hiring.

SELECT DATEDIFF (Year, BirthDate, HireDate) AS AgeOfEmployment
FROM [HumanResources].[Employee]


   9
--How many employees will be due a long service award
--in the next 5 years, if long service is 20 years?

SELECT NationalIDNumber, JobTitle, HireDate,
DATEADD(Year, 15, HireDate) AS LongService
FROM [HumanResources].[Employee]
WHERE DATEADD(Year, 15, HireDate) <= EOMONTH (GETDATE());



  10
--How many more years does each employee have to work before 
--reaching sentiment, if sentiment age is 65?


SELECT NationalIDNumber, BirthDate, SentimentAge,
DATEDIFF(YEAR, BirthDate, GETDATE()) AS PresentAge 
FROM HumanResources.Employee)
WHERE DATEADD(Year, 15, HireDate) <= EOMONTH(GETDATE());

--Values from this result set above was used to set new column  into the table
ALTER TABLE HumanResources.Employee
ADD PresentAge Int

ALTER TABLE HumanResources.Employee
ADD SentimentAge Int

UPDATE HumanResources.Employee 
SET SentimentAge = 65

UPDATE HumanResources.Employee 
SET PresentAge = 0
WHERE PresentAge IS NULL

update HumanResources.Employee 
set PresentAge =46 
where NationalIDNumber = 134219713

--These steps was applied till all the column were filled


SELECT NationalIDNumber, BirthDate,  HireDate, SentimentAge, PresentAge, 
(SentimentAge - PresentAge) AS AgeDifference
FROM HumanResources.Employee;





  11
/*Implement new price policy on the product table base on the colour of the item
If white increase price by 8%, If yellow reduce price by 7.5%, If black increase 
price by 17.2%. If multi, silver, silver/black or blue take the square root of the 
price and double the value. Column should be called Newprice. For each item, 
also calculate commission as 37.5% of newly computed list price.*/

SELECT ListPrice+ 0.08 AS NewPrice,  
ListPrice+ 0.08* 0.375 AS Commission
FROM Production.Product
WHERE name = 'Mountain Bike Socks, M';
	SELECT ListPrice+ 0.08 AS NewPrice, 
	ListPrice+ 0.08* 0.375 AS Commission
	FROM Production.Product
	WHERE name = 'Racing Socks, M';
		SELECT  ListPrice - 0.075 AS NewPrice,  
		ListPrice - 0.075* 0.375 AS Commission
		FROM Production.Product
		WHERE name = 'Touring-1000 Yellow, 46';
				SELECT ListPrice- 0.075 AS NewPrice,  
				ListPrice- 0.075* 0.375 AS Commission
				FROM Production.Product
				WHERE name = 'Road-350-W Yellow, 40';
						 SELECT ListPrice- 0.075 AS NewPrice,  
							ListPrice- 0.075* 0.375 AS Commission
							FROM Production.Product
							WHERE name = 'Road-550-W Yellow, 40';
	



  12
/*Print the information about all the Sales.Person and their sales quota. 
For every Sales person you should provide their FirstName, LastName,
HireDate, SickLeaveHours and Region where they work*/


SELECT FirstName, LastName, SalesQuota, PersonType, HireDate, SickLeaveHours, CountryRegionCode
FROM Person.Person AS Person
	INNER JOIN HumanResources.Employee AS HrEmployee
	ON Person.BusinessEntityID = HrEmployee.BusinessEntityID 
		INNER JOIN Sales.SalesPerson AS S_Person
		ON HrEmployee.BusinessEntityID = S_Person.BusinessEntityID 
			INNER JOIN Sales.SalesTerritory AS S_Territory
			ON S_Person.TerritoryID = S_Territory.TerritoryID;

  13
/*Using adventure works, write a query to extract the following information:
 Product
 Product category
 Product subcategory
 Sales person
 Revenue
 Month of transaction
 Quarter of transaction
 Region*/

 
SELECT ProductSubcategoryID, Name AS ProductName, TotalDue AS Revenue,
Orderdate AS DateOfTransaction, SalesPersonID, 
DATEPART(MONTH,OrderDate) AS MonthOfTransaction,
	DATEPART(QUARTER,OrderDate) AS QuarterOfTRansaction, TerritoryID AS RegionID 
			 FROM Production.Product AS Product 
				 INNER JOIN Sales.SalesOrderDetail AS sod
					 ON Product. ProductID = sod.ProductID
						INNER JOIN Sales.SalesOrderHeader AS soh
							ON sod.SalesOrderID = soh.SalesOrderID;




--  14
/*Display the information about the details of an order i.e. order number, order date,
amount of order, which customer gives the order and which salesman works for
that customer and how much commission he gets for an order.*/


SELECT SalesOrderNumber as Ord_No, OrderDate, OrderQty as Amt_Of_Ord,
SalesPersonID as SalesMan, CustomerID, CommissionPct
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesOrderDetail AS sod
ON soh.SalesOrderID = sod.SalesOrderID 
INNER JOIN Sales.SalesPerson AS sp
ON sp.TerritoryID = soh.TerritoryID






  15
/*  15
For all the products calculate
- Commission as 14.790% of standard cost,
- Margin, if standard cost is increased or decreased as follows:
Black: +22%,
Red: -12%
Silver: +15%
Multi: +5%
White: Two times original cost divided by the square 
root of cost For other colours, standard cost remains the same*/

SELECT StandardCost*0.1479+0.22 AS StandardcostForBlack
FROM Production.Product
WHERE name = 'Mountain-100 Black, 38';
	SELECT StandardCost*0.1479-0.12 AS StandardcostForRed
	FROM Production.Product
	WHERE name = 'Road-150 Red, 62';
	 SELECT StandardCost*0.1479-0.12 AS StandardcostForSilver
	 FROM Production.Product
	 WHERE name = 'Mountain-100 Silver, 42';
		SELECT StandardCost*0.1479+0.5 AS StandardcostForMulti
		FROM Production.Product
		WHERE name = 'Long-Sleeve Logo Jersey, S';
			SELECT StandardCost*2*0.1479/77.58889 AS StandardcostForWhite
			FROM Production.Product
			WHERE name = 'Racing Socks, M';

  16
--Create a view to find out the top 5 most expensive products for each colour.

SELECT  DISTINCT TOP 5 Listprice, color
FROM Production.product
ORDER BY ListPrice DESC;

--THIS SYNTAX PROVIDED THE RESULT FOR THE VIEW

CREATE VIEW MostExpensiveProduct 
AS 
SELECT  DISTINCT TOP 5  Listprice, color
FROM Production.product
WHERE ListPrice IN  (3578.27,3399.99,3374.99,2443.35,2443.35)



