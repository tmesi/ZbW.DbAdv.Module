USE AdventureWorks2022;
GO


SELECT		S.Name			AS BikeSubCategory,
			SUM(LineTotal)	AS BikeSales
FROM		Sales.SalesOrderDetail			AS sod
			JOIN
			Sales.SalesOrderHeader			AS soh
				ON sod.SalesOrderID		= soh.SalesOrderID

			JOIN
			Production.Product				AS P
				ON P.ProductID		= sod.ProductID

			JOIN
			Production.ProductSubcategory	AS S
				ON S.ProductSubcategoryID = P.ProductSubcategoryID
WHERE		S.Name LIKE '%Bikes%'
AND			soh.OrderDate	>= '2014-01-01'
AND			soh.OrderDate	< '2015-01-01'
GROUP BY	S.Name;


--One traditional way to solve
--Query without window aggregate
WITH GrandTotal
AS
(
	SELECT	SUM(LineTotal)	AS TotalSales
	FROM	Sales.SalesOrderDetail			AS sod
			JOIN
			Sales.SalesOrderHeader			AS soh
				ON sod.SalesOrderID		= soh.SalesOrderID

			JOIN
			Production.Product				AS P
				ON P.ProductID		= sod.ProductID

			JOIN
			Production.ProductSubcategory	AS S
				ON S.ProductSubcategoryID = P.ProductSubcategoryID
	WHERE	S.Name LIKE '%Bikes%'
	AND		soh.OrderDate	>= '2014-01-01'
	AND		soh.OrderDate	< '2015-01-01'
)
SELECT		S.Name										AS BikeSubCategory,
			SUM(LineTotal)								AS BikeSales,
			FORMAT(SUM(LineTotal) / TotalSales, 'P') AS PercentOfSales
FROM		Sales.SalesOrderDetail			AS sod
			JOIN
			Sales.SalesOrderHeader			AS soh
				ON sod.SalesOrderID = soh.SalesOrderID

			JOIN
			Production.Product				AS P
				ON P.ProductID = sod.ProductID

			JOIN
			Production.ProductSubcategory	AS S
				ON S.ProductSubcategoryID = P.ProductSubcategoryID
			CROSS JOIN GrandTotal
WHERE		S.Name LIKE '%Bikes%'
AND			soh.OrderDate	>= '2014-01-01'
AND			soh.OrderDate	< '2015-01-01'
GROUP BY	S.Name,
			TotalSales;



--Percent of sales for each type of bike
--Step 1
SELECT		S.Name			AS BikeSubCategory,
			SUM(LineTotal)	AS BikeSales
FROM		Sales.SalesOrderDetail			AS sod
			JOIN
			Sales.SalesOrderHeader			AS soh
				ON sod.SalesOrderID		= soh.SalesOrderID

			JOIN
			Production.Product				AS P
				ON P.ProductID		= sod.ProductID

			JOIN
			Production.ProductSubcategory	AS S
				ON S.ProductSubcategoryID = P.ProductSubcategoryID
WHERE		S.Name LIKE '%Bikes%'
AND			soh.OrderDate	>= '2014-01-01'
AND			soh.OrderDate	< '2015-01-01'
GROUP BY	S.Name;




--Step 2: CTE and add aggregate
WITH Sales
AS
(
	SELECT		S.Name			AS BikeSubCategory,
				SUM(LineTotal)	AS BikeSales
	FROM		Sales.SalesOrderDetail			AS sod
				JOIN
				Sales.SalesOrderHeader			AS soh
					ON sod.SalesOrderID		= soh.SalesOrderID

				JOIN
				Production.Product				AS P
					ON P.ProductID		= sod.ProductID

				JOIN
				Production.ProductSubcategory	AS S
					ON S.ProductSubcategoryID = P.ProductSubcategoryID
	WHERE		S.Name LIKE '%Bikes%'
	AND			soh.OrderDate	>= '2014-01-01'
	AND			soh.OrderDate	< '2015-01-01'
	GROUP BY	S.Name
)
SELECT	BikeSubCategory,
		BikeSales,
		SUM(BikeSales) OVER () AS TotalSales
FROM	Sales;

--Step 3: Division
WITH Sales
AS
(
	SELECT		S.Name			AS BikeSubCategory,
				SUM(LineTotal)	AS BikeSales
	FROM		Sales.SalesOrderDetail			AS sod
				JOIN
				Sales.SalesOrderHeader			AS soh
					ON sod.SalesOrderID		= soh.SalesOrderID

				JOIN
				Production.Product				AS P
					ON P.ProductID		= sod.ProductID

				JOIN
				Production.ProductSubcategory	AS S
					ON S.ProductSubcategoryID = P.ProductSubcategoryID
	WHERE		S.Name LIKE '%Bikes%'
	AND			soh.OrderDate	>= '2014-01-01'
	AND			soh.OrderDate	< '2015-01-01'
	GROUP BY	S.Name
)
SELECT	BikeSubCategory,
		BikeSales,
		--SUM(BikeSales) OVER() AS TotalSales,
		FORMAT(BikeSales / SUM(BikeSales) OVER (), 'P') AS PercentOfSales
FROM	Sales;






