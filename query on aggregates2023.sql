select * from  private.company_departments



--- Aggregation Operators in use

select
department_id, last_name, sum(salary)
from 
   private.employees
   group by department_id, last_name
   order by department_id desc
   
select *
from private.employees
where job_title = 'structural engineer' 

--querying for the first 10 rows in the employees table
select
   *
from 
   private.employees
limit 10;

--fitering based on region_id that is equal to 2
select
   *
from 
   private.employees
where
   region_id = 2;

--doing a count on the employees table
select
   count(*)
from 
   private.employees;

--summarising to see minimum, maximum and count of salary
select
   count(*), min(salary), max(salary)
from 
   private.employees;
  
--summarising to see minimum, maximum and count of salary with a filter
select
   count(*), min(salary), max(salary)
from 
  private.employees
where   
   region_id = 2;

--summarising to see minimum, maximum and count of id
select
   count(*), min(id), max(id)
from 
private.employees

--fetching alternate rows 
select * 
from private.company_departments
where mod (cd_id , 2) = 0


--showing the details of the employee table 
select
  *
from
private.employees;

--showing the first ten rows in the employee table
select
  *
from
private.employees
limit 10;

-- showing the total amount spent on salary
select
  sum(salary)
from 
 private.employees;
 
-- removing decimals with trunc
select
   trunc( sum(salary))
from
private.employees
	 
-- showing the average total amount spent on salary for each department
select
   department_id
  , sum(salary) as total_salary
from 
  private.employees
group by department_id;


-- showing the total salary and average salary spent on each department
select
	  department_id
	  , sum(salary) as total_salary
	  , avg(salary) as average_salary
from 
  private.employees
group by department_id;

--rounding up average column of the above result
select
	  department_id
	  , sum(salary)
	  , round(avg(salary),2)
from 
  private.employees
group by department_id;

--computing a statistical measure on the table 
--using the square of the population stdv
select
	 department_id
	 , sum(salary)
	 , round(avg(salary),2)
	 , var_pop(salary)
from 
  private.employees
group by department_id
order by avg(salary) desc
;

--computing the standard deviation
select
  	department_id
	,sum(salary)
	,round(avg(salary),2)
	,var_pop(salary)
	,stddev_pop(salary)
from 
  private.employees
group by department_id;

--rounding the result of the above
select
  department_id, 
  sum(salary), 
  round(avg(salary),2), 
  var_pop(salary), 
  round(stddev_pop(salary),2)
from 
employees
group by department_id;

