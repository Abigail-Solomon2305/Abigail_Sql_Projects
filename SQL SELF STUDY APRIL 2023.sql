select DATALENGTH (country) 
from [dbo].[company_regions]

--this query filters for character having a varying number of character
SELECT COUNTRY 
FROM [dbo].[company_regions]
WHERE DATALENGTH (country) = 3;

SELECT DISTINCT [start_date] 
datetrunc (year, start_date )
FROM [dbo].[Staff]
WHERE  TRIM([start_date]) = 2013
-- you dont use the trim function on numeric data type
--Msg 8116, Level 16, State 1, Line 9
--Argument data type date is invalid for argument 1 of Trim function.


SELECT DISTINCT start_date,
datetrunc (year, start_date ) as year,
datetrunc (month, start_date ) as month,
datetrunc (day, start_date ) as day
FROM [dbo].[Staff]
where start_date = 2013

SELECT 
datepart (year, start_date ) as year
FROM [dbo].[Staff]


SUBSTRING

--changes datatype
CAST 
--finds the first non null record
COALESCE
--how does the alter keyword change data type

--creating foreign keys

ALTER TABLE [dbo].[Staff]
ADD constraint fk_staff FOREIGN KEY (region_id) 
REFERENCES [dbo].[company_regions] ([region_id])
ON DELETE SET NULL

--intitially when i ran the above query, it threw an error that the data types are differnt 
-- hence i Wd alter the table and change the data type

ALTER TABLE [dbo].[Staff]
ALTER COLUMN  [id] INT

 --running it afresh
ALTER TABLE [dbo].[Staff]
ADD constraint fk_staff FOREIGN KEY (region_id) 
REFERENCES [dbo].[company_regions] ([region_id])
ON DELETE SET NULL

ALTER TABLE [dbo].[Staff]
ADD CONSTRAINT pk_staff PRIMARY KEY ([id]) INT 
SELECT [id]
      ,[last_name]
      ,[email]
      ,[gender]
      ,[department]
      ,[start_date]
      ,[salary]
      ,[job_title]
      ,[region_id]
  FROM [dbo].[Staff]



--THIS QUERY combines i.e. it concatenates a set of columns into a list

select [last_name] from staff
UNION
select [company_division] from [dbo].[CompDivs]

--after creating some relationships, i decided to
--use thr QUERY DESIGNER to do some joins

SELECT       SUM(Employees.salary) AS sumOFsalary, company_regions.company_regions, staff.department
FROM            company_regions 
						INNER JOIN Employees ON company_regions.region_id = Employees.region_id 
						INNER JOIN staff ON company_regions.region_id = staff.region_id
						GROUP BY company_regions.company_regions, staff.department
						HAVING       (SUM(Employees.salary) > 2010 - 01 - 01)
						ORDER BY sumOFsalary DESC, company_regions.company_regions

getdate
dateadd
TRIM
SUBSTRING
COALESCE
CAST
concat

SELECT SUM(E.salary) AS Sum_of_salary, round(SUM(E.salary),2), CR.company_regions, S.department
FROM company_regions CR
	INNER JOIN Employees E ON CR.region_id = E.region_id
	INNER JOIN staff S ON CR.region_id = S.region_id
		GROUP BY CR.company_regions, S.department
		HAVING SUM(E.salary) > 2010 - 01 - 01
		ORDER BY Sum_of_salary DESC, CR.company_regions



