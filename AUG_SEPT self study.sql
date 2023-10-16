--querying to fetch departments along 
--with the total salaries paid for each of them.

SELECT department, sum (salary)
FROM worker
GROUP BY department


--query to fetch nth max 
--salaries from a table.

--practising dubquery in a where clause
SELECT COUNT (salary) FROM worker
where max(salary) > 1 
(
SELECT max(salary)
FROM worker as max_CTE


--practicing sql joins 
SELECT TOP 10 SUM (order_qty) AS t_oqty
FROM sales.salesorderHeader sh
INNER JOIN sales.salesorderDetails sd
ON sd.salesorderid on sh.salesorderid
group by customer 
order by SUM (order_qty)



--sample query to find nulls
SELECT  c.accountNumber, c.CustomerId
FROM Customer c
LEFT JOIN salesHeaderOrder s
ON c.customerid=s.customerid
WHERE s.salesorderid IS NULL


--querying for UNIQUE RECORDS
select emp_id, last_name, salary
from
(
SELECT emp_id, last_name, salary,
ROW_NUMBER () OVER(PARTITION BY salary order by emp_id) as rn
FROM employees)
where rn > 1

  --fetching all data from table
SELECT *
FROM employees

