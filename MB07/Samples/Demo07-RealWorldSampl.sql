USE AdventureWorks2022;
GO


SELECT		BikeSubCategory					= s.[Name],
			BikeSales						= SUM(sod.LineTotal)
FROM		Sales.SalesOrderDetail			AS sod
			INNER JOIN
			Sales.SalesOrderHeader			AS soh
				ON sod.SalesOrderID			= soh.SalesOrderID
			INNER JOIN
			Production.[Product]			AS p
				ON P.ProductID				= sod.ProductID
			INNER JOIN
			Production.ProductSubcategory	AS s
				ON S.ProductSubcategoryID	= P.ProductSubcategoryID
WHERE		s.[Name]						LIKE '%Bikes%'
AND			soh.OrderDate					>= '2014-01-01'
AND			soh.OrderDate					< '2015-01-01'
GROUP BY	s.[Name];


--One traditional way to solve
--Query without window aggregate
WITH GrandTotal
AS
(
	SELECT	TotalSales						= SUM(sod.LineTotal)
	FROM	Sales.SalesOrderDetail			AS sod
			INNER JOIN
			Sales.SalesOrderHeader			AS soh
				ON sod.SalesOrderID			= soh.SalesOrderID
			INNER JOIN
			Production.[Product]			AS p
				ON P.ProductID				= sod.ProductID
			JOIN
			Production.ProductSubcategory	AS s
				ON S.ProductSubcategoryID	= P.ProductSubcategoryID
	WHERE	s.[Name]						LIKE '%Bikes%'
	AND		soh.OrderDate					>= '2014-01-01'
	AND		soh.OrderDate					< '2015-01-01'
)
SELECT		BikeSubCategory					= s.[Name],
			BikeSales						= SUM(sod.LineTotal),
			PercentOfSales					= FORMAT(SUM(sod.LineTotal) / g.TotalSales, 'P')
FROM		Sales.SalesOrderDetail			AS sod
			INNER JOIN
			Sales.SalesOrderHeader			AS soh
				ON sod.SalesOrderID = soh.SalesOrderID
			INNER JOIN
			Production.Product				AS p
				ON P.ProductID = sod.ProductID
			INNER JOIN
			Production.ProductSubcategory	AS s
				ON s.ProductSubcategoryID = p.ProductSubcategoryID
			CROSS JOIN
			GrandTotal						AS g
WHERE		s.[Name] LIKE '%Bikes%'
AND			soh.OrderDate	>= '2014-01-01'
AND			soh.OrderDate	< '2015-01-01'
GROUP BY	s.[Name],
			g.TotalSales;



--Percent of sales for each type of bike
--Step 1
SELECT		BikeSubCategory					= s.[Name],
			BikeSales						= SUM(sod.LineTotal)
FROM		Sales.SalesOrderDetail			AS sod
			INNER JOIN
			Sales.SalesOrderHeader			AS soh
				ON sod.SalesOrderID			= soh.SalesOrderID
			INNER JOIN
			Production.[Product]			AS p
				ON P.ProductID				= sod.ProductID
			INNER JOIN
			Production.ProductSubcategory	AS s
				ON S.ProductSubcategoryID	= P.ProductSubcategoryID
WHERE		s.[Name]						LIKE '%Bikes%'
AND			soh.OrderDate					>= '2014-01-01'
AND			soh.OrderDate					< '2015-01-01'
GROUP BY	s.[Name];




--Step 2: CTE and add aggregate
WITH Sales
AS
(
	SELECT		BikeSubCategory					= s.[Name],
				BikeSales						= SUM(sod.LineTotal)
	FROM		Sales.SalesOrderDetail			AS sod
				INNER JOIN
				Sales.SalesOrderHeader			AS soh
					ON sod.SalesOrderID			= soh.SalesOrderID
				INNER JOIN
				Production.[Product]			AS p
					ON P.ProductID				= sod.ProductID
				INNER JOIN
				Production.ProductSubcategory	AS s
					ON S.ProductSubcategoryID	= P.ProductSubcategoryID
	WHERE		s.[Name]						LIKE '%Bikes%'
	AND			soh.OrderDate					>= '2014-01-01'
	AND			soh.OrderDate					< '2015-01-01'
	GROUP BY	s.[Name]
)
SELECT	BikeSubCategory		= s.BikeSubCategory,
		BikeSales			= s.BikeSales,
		TotalSales			= SUM(s.BikeSales) OVER ()
FROM	Sales				AS s;

--Step 3: Division
WITH Sales
AS
(
	SELECT		BikeSubCategory					= s.[Name],
				BikeSales						= SUM(sod.LineTotal)
	FROM		Sales.SalesOrderDetail			AS sod
				INNER JOIN
				Sales.SalesOrderHeader			AS soh
					ON sod.SalesOrderID			= soh.SalesOrderID
				INNER JOIN
				Production.[Product]			AS p
					ON P.ProductID				= sod.ProductID
				INNER JOIN
				Production.ProductSubcategory	AS s
					ON S.ProductSubcategoryID	= P.ProductSubcategoryID
	WHERE		s.[Name]						LIKE '%Bikes%'
	AND			soh.OrderDate					>= '2014-01-01'
	AND			soh.OrderDate					< '2015-01-01'
	GROUP BY	s.[Name]
)
SELECT	BikeSubCategory		= s.BikeSubCategory,
		BikeSales			= s.BikeSales,
		--SUM(BikeSales) OVER() AS TotalSales,
		PercentOfSales		= FORMAT(BikeSales / SUM(BikeSales) OVER (), 'P')
FROM	Sales				AS s;






