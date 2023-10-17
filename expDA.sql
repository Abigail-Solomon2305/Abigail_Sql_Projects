--using employees table from my private schema
--i shall be showing you a very basic aspect of exploring your data
--using sql
--first step is an overview of table content and structure
SELECT * 
FROM  private.employees
LIMIT 100

--total no of rows
SELECT count (*) 
FROM  private.employees

--distinct job title
SELECT count(distinct(job_title)) 
FROM private.employees

--minimum salary
SELECT MIN(salary) 
FROM private.employees

--maximum salary
SELECT MAX(salary) 
FROM private.employees
GROUP BY job_title

-- average salary
SELECT ROUND(AVG(salary),2) 
FROM private.employees


--standard deviation it tells how the values are spread accross the data
--a high tells the values are far from the average
--a low std means that the values are clustered around the average
SELECT stddev (salary) 
FROM private.employees

--variance is a measure of how far each number in a dataset vary 
--from the average
SELECT round (variance(salary) 
FROM private.employees
			  
			  
			  
			  




