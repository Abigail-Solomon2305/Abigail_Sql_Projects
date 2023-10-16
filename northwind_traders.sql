--QUERYING for sales trend

create view sales_trend as
select year(o.orderDate) as order_year,
datename (month, o.orderDate) as order_month,
 sum(od.quantity) as total_quantity
 from orders as o
 join order_details as od
 on o.orderID = od.orderID
 group by year(orderDate), 
datename (month, orderDate)
--order by 3


-- I created view to access this result for a report
create view NW_report as
 select 
	 year(o.orderDate) as order_year,
	 datename (month, o.orderDate) as order_month,
	 sum(od.quantity) as total_quantity
 from orders as o
 join order_details as od on o.orderID = od.orderID
 group by 
	 year(orderDate), 
	 datename (month, orderDate)


--QUERYING for top selling products
create view top_selling_Products as
select 
	productID,

	count (distinct orderID) 'unique product', 
	sum(unitPrice) 'total sales'
from [dbo].[order_details]
group by productID
order by sum(unitPrice) desc

--QUERYING for least selling product 
select 
	orderID, 
	count(distinct productID) 'unique product', 
	sum(unitPrice) 'total sales'
from [dbo].[order_details]
group by orderID
having count(distinct productID) = 1
order by 2,3 asc


--QUERYING for top selling product names with profit
select 
	od.productID, 
	count(distinct od.orderID) 'number of product ordered ', 
	sum(od.unitPrice) 'total revenue per product',
	p.productName
from 
	[dbo].[order_details] od
	join [dbo].[products] p
	on od.productID = p.productID
group by
	od.productID,
	p.productName
order by  
sum(od.unitPrice) desc,
count(distinct od.orderID) desc;

--QUERYING for top selling product names with no of orders
select 
	od.productID, 
	count(distinct od.orderID) 'number of product ordered ', 
	sum(od.unitPrice) 'total revenue per product',
	p.productName
from 
	[dbo].[order_details] od
	join [dbo].[products] p
	on od.productID = p.productID
group by
	od.productID,
	p.productName
order by  
count(distinct od.orderID) desc,
sum(od.unitPrice) desc;


--QUERYING for top performing customers
select 
	sum(od.quantity) as total_quantity,
	o.orderID,
	c.companyName
 from 
	orders as o
join order_details as od on o.orderID = od.orderID
join customers c on c.customerID = o.customerID
group by 
	o.orderID,	
	c.companyName
order by 1 desc

-- querying to see total ordered quantity grouped by company name
select 
	sum(od.quantity) as total_quantity,
	c.companyName
 from
 orders o
 JOIN 	order_details as od
	on o.orderID = od.orderID
	JOIN customers c 
	on c.customerID = o.customerID
group by 
	c.companyName
order by 
2


--QUERYING for inconsistent shipping cost
select 
	round (od.discount, 4), 
	round (o.freight, 5),
	od.unitPrice,
	c.customerID,
	o.shipperID,
	c.companyName
 from orders  as o
 join order_details as od on o.orderID = od.orderID
 join customers c on c.customerID = o.customerID
-- group by 
--	o.orderID,	
--	c.companyName
order by 3

--querying for customers who receive the highest discount in percentage by quantity bought
SELECT  
 max(od.discount /od.unitPrice * 100) as 'in %',
	round (od.discount, 4) AS discount,
	c.companyName,
	count (od.quantity) AS quantity
FROM order_details od
JOIN orders o ON od.orderID = o.orderID
JOIN customers c ON o.customerID = c.customerID
WHERE od.discount <> 0
GROUP BY 
	round (od.discount, 4),
	c.companyName,
	od.unitPrice,
	od.discount
	having count (od.quantity) > 1
ORDER BY 
	1 desc
	--3 desc


--QUERYING for unique discounts across shippers
SELECT distinct (discount)
FROM order_details






--QUERYING to group customers by discount
--THIS DID NOT WORK AS I EXPECTED MAY TRY OUT SOME OTHER WAYS
/*SELECT  
	round (od.discount, 4) AS discount,
	c.companyName
FROM order_details od
JOIN orders o ON od.orderID = o.orderID
JOIN customers c ON o.customerID = c.customerID
WHERE od.discount in  (0.25, 0.15, 0.39, 0.01, 0.20, 0.10, 0.05)
GROUP BY 
	round (od.discount, 4),
	c.companyName*/
--	,
	--unitPrice
--ORDER BY 
	--1,
--	3 desc

--QUERYING TO SEE PRODUCTS THAT HAS THE HIGHEST DISCOUNT

select distinct top 10 max(od.discount /od.unitPrice * 100) as 'in %',
od.unitPrice, od.discount, p.productName
from order_details od
join products p
on od.productID = p.productID
where discount <> 0
group by od.unitPrice, od.discount, p.productName

--product category with higher discounts
--watch out i concatenated product name and categoryName
select distinct top 10 max(od.discount /od.unitPrice * 100) as 'in %',
od.unitPrice, od.discount, p.productName + c. categoryName 
from order_details od
join products p
on od.productID = p.productID
join categories c 
on p.categoryID = c.categoryID
where discount <> 0
group by od.unitPrice, od.discount, p.productName, c.categoryName
order by 1 desc

 
--SEE PRODUCTS CATEGORY WITH THE HIGHEST NUMBER OF ORDERS
-- I used the count and having
select count(od.orderID) as 'number of orders', p.productName, c. categoryName
from order_details od
join products p
on od.productID = p.productID
join categories c 
on p.categoryID = c.categoryID
group by p.productName, c.categoryName
order by 1 desc




--SEE PRODUCT CATEGORY WITH HIGHEST REVENUE
select 
top 10 max(od.unitPrice *od.quantity) as 'revenue', p.productName, c. categoryName
from order_details od
join products p
on od.productID = p.productID
join categories c 
on p.categoryID = c.categoryID
group by p.productName, c.categoryName
order by 1 desc
 



--see days with most sales
select count ([orderID]) as 'no of orders', orderDate
from orders
group by orderDate
having count([orderID]) > 2
order by 1 desc


--see product category with no_of orders
--although, id love to see daily sales that will require using avg
select
c.categoryName, 
count (od.orderID) number_of_orders, o.orderDate
from order_details od
join products p
on od.productID = p.productID
join categories c 
on p.categoryID = c.categoryID
join orders o
on o.orderID = od.orderID
--where orderDate in (2015-01-01, 2015-12-31)
group by 
--p.productName,
c.categoryName, 
o.orderDate
having count (od.orderID) > 2
order by 2 desc






/*
see monthly product category with least revenue
see employees with more customers driving in revenue
check if discount from employees drives for increased purchase like returning customers
query to see if disccount comes on quantity or unitprice
see which country makes most sales per product category
i may concat product n category column
*/


SELECT * FROM [dbo].[employees]
--second highest quantity purchased using top
-- i used distinct here because the there are two duplicate records
select top 1 quantity
from 
(
select distinct top 2  quantity
from order_details
order by quantity desc
) as ordT
order by quantity asc


--second highest quantity purchased using max
select max (quantity)
from order_details
where quantity <
(
select max(quantity)
from order_details 
)

--finding duplicate orderId 
select count (orderID)
from order_details
group by orderID
having count (orderID) > 1

--removing duplicate orderId
--best practice would be to create a table and select unique values result into it
select * into uniquetable
from
(select count (orderID)
from order_details
group by orderID
having count (orderID) = 1) as a