-- I'd be using the private Db this month

--distinct department id
select distinct (department_id) from Employees 


--workers with the highest salary
select top 10 salary from employees order by salary
-- top syntax cannot return highest salary so try max
select max (salary) as highest_sal from employees 
select top 10  * from Employees
order by salary 

where exists
	(
	select max (salary), * from employees 
	group by emp_id
	having max (salary) > 70)
	order by salary


-- the except syntax shows records from one table that another table does not have.
select WORKER_REF_ID, bonus_date from org.dbo.Bonus
except
select WORKER_REF_ID, AFFECTED_FROM from org.dbo.Title;

select [emp_id], [last_name]  from  employees
except
select  [id], [last_name] from staff

select top (5) * from  staff
except
select  [id] from staff


--subquery in the from clause having alias 
select s.ID, s.last_name, s.department, s.salary from
(select avg(salary) as averagesalary from employees) as avg_sal, staff as s
where s.salary > avg_sal.averagesalary


--join
select s.id
	, s.last_name
	, s.department
	, e.salary 
from staff as s
	join employees as e 
	on e.emp_id = s.id
		where e.salary > 60000 

--odd rows, modulus will be employed
SELECT * FROM employees WHERE emp_id % 2 <> 0;

--even rows
SELECT * FROM employees WHERE emp_id % 2 = 0;


select distinct emp_id e, id s
from employees e 
 join staff s
	on
	e.emp_id = s.id 

/*SELECT DISTINCT 
FROM 
LEFT JOIN sale s ON s.product_id=p.id
WHERE  IS NULL

SELECT name FROM product
WHERE cost <(SELECT AVG(price) from sale);
*/

--i just ran sub queries using in 	
	SELECT *
FROM staff
WHERE id IN 
	(SELECT distinct emp_id FROM Employees)

		

--Write an SQL query to show the top n (say 10) records of a table.
--whenever top is used 
select top 10 (salary) from employees
order by salary desc

--awesome
-- i have two tables that has similar fields but found out that there is an extra 46 rows that is differnt.
-- i needed to know which records are t
SELECT * 
FROM Employees
	WHERE emp_id NOT IN 
		(SELECT id
		FROM staff)

--query to show the current date and time.
select getdate()

--write an SQL query to show the top n (say 10) records of a table.
select top (10)* from  [private_db].[dbo].[staff]

SELECT * FROM 
SELECT * FROM [private_db].[dbo].[staff]
 WHERE ROW_NUM <= 10
WHERE ROWNUM <= 10
ORDER BY Salary DESC;


--query to determine the nth (say n=5) highest salary from a table.
select * 
from employees
where salary in ( select top 5 salary from employees) 
 
 use private_db
)
select * from CompDivs 

alter table CompDivs
set department = 

select * from compDiv from [dbo].[CompDivs]


drop table if exists [dbo].[CompDivs]

create table [dbo].[CompDivs]




 from compDiv
--where department like 'auto%'
select * from [dbo].[company_regions]

--SQL JOINS ON THREE TABLES
SELECT [company_division] FROM [dbo].[CompDivs] JOIN [dbo].[Employees]
ON [dbo].[Employees].[emp_id] = [dbo].[CompDivs].[department]

alter table 
--

--using the not operator in three different ways
select * from private_db.dbo.employees
where  department_id <> 12

select * from private_db.dbo.employees
where not department_id = 12

select * from private_db.dbo.employees
where  department_id != 12


--employees with lastname starting with letter a
select * from private_db.dbo.employees
where  last_name like 'a%'

--show employees with name, department, job title with the lowest 2 salaries
select top (2) salary, last_name, department_id, job_title
from private_db.dbo.Employees
order by salary asc


-- query to show the top n (say 10) records of a table.

SELECT top 10 * 
FROM staff
order by salary desc

--to determine the nth (say n=5) highest salary from a table.

SELECT top 5 * 
FROM staff
order by salary desc


--Write an SQL query to determine the 5th highest salary without using the TOP or limit method.
to do this  a subquery is needed.
it will be written in the where clause
alias the tables in the inner query as tb2 and that in the outer query as tb1
so, in the where clause you would 
 
SELECT Salary, id
FROM staff W1
WHERE 4 = (
 SELECT COUNT( DISTINCT ( W2.Salary ) )
 FROM staff W2
 WHERE W2.Salary >= W1.Salary
 );
Copy
Use the following generic method to find the nth highest salary without using TOP or limit.

SELECT Salary
FROM Worker W1
WHERE n-1 = (
 SELECT COUNT( DISTINCT (Salary ) )
 FROM staff \
 WHERE W2.Salary >= W1.Salary
 );


 
--query to fetch the list of employees with the same salary.
select  salary, count (job_title)
from staff
group by salary 

--subquery practice

--a subquery can be found in the select statement, from statement and the where clause

--this subquery is in the where clause
-- it will help us find which staff receives salary higher than the average
select last_name, salary
from staff
where salary >
	(select avg( salary)
	from staff
	)
--the average salary is 97331 for all 1000 staff members but those 
--who receive higher than the average are 493 

-- code 2
select CountryName, continent
from country
where CountryId in
	(select DepartmentId
	from department
	)
--it returned the department that is also in another country

--a better exmaple. i would like to know all workers who has received  a bonus
select first_name, department
from worker
where worker_id in
	(select worker_ref_id
	from bonus
	)
--only three workers has received a bonus

--the above result can also be achieved through a join

/*
if you run this join without a distinct keyword, it will return multiple
so, alway use the distinct
*/

	select  distinct (w.first_name),w.department
	from worker as w join
	 bonus as b
	on w.[WORKER_ID] = b.worker_ref_id

	--join and subquery
	select artist.first_name,
			artist.last_name,
			artist_sales.sales
	from artists
	join (
		select artist_id, sum(sales_price)
	as sales
		from sales
		group by artist_id 
		) as artist_sales
		on artist.id=
		artist_sales .artist_id

--this query seeks to know the details of workers and the total bonuses they have recievd  
select first_name, last_name, workers_bonus.total_bonus
from Worker
join 
	(
	select worker_ref_id, sum(bonus_amount) as total_bonus
	from bonus
	group by worker_ref_id
	) as workers_bonus
on 	Worker.worker_id = workers_bonus.worker_ref_id


--it is also possible to creat a cte from this


--i'd be practicing  how to use distinct and count in  various ways 
select   first_name
		 ,last_name
		 (
		 select count (*) as mmm
		 from sales
		 where collector.id = sales.collector_id
		 )
		 from collectors

select  first_name
		 ,last_name
		from artist 
		where not exixts 
		( select * from sales where sales.artist_id = artist_id




	select distinct * from staff where id is not null


	select count( case  when order_price > 1000 then 1 end) as important_orders from orders


