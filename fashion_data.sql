SELECT *
FROM [dbo].[myntra_products_catalog]

SELECT * 
FROM [dbo].[Womens_Clothing_E_Commerce_Reviews]

--the steps i will take on this project will include
--clean, create joins, analyse, create visualisation
--

--checking for spaces leading and trailing spaces
SELECT DATALENGTH ([ProductID]), [ProductID]
FROM [dbo].[Womens_Clothing_E_Commerce_Reviews]

--try sorting to see if there is any outlier
SELECT LEN ([ProductID]) AS lengthOfData, [ProductID]
FROM [dbo].[myntra_products_catalog]
ORDER BY 1 desc


SELECT ltrim ([ProductID]) 
--AS lengthOfData, [ProductID]
FROM [dbo].[myntra_products_catalog]
ORDER BY 1 desc