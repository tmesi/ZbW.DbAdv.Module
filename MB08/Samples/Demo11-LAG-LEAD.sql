USE AdventureWorks2022;
GO

--LAG
SELECT	CustomerID				= soh.CustomerID,
		SalesOrderID			= soh.SalesOrderID,
		TotalDue				= soh.TotalDue,
		PrevTotalDue			= LAG(soh.TotalDue)		OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID),
		PrevOrderID				= LAG(soh.SalesOrderID) OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID) 
FROM	Sales.SalesOrderHeader	AS soh;
	
--LEAD
SELECT	CustomerID				= soh.CustomerID,
		SalesOrderID			= soh.SalesOrderID,
		TotalDue				= soh.TotalDue,
		NextTotalDue			= LEAD(TotalDue)		OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID),
		NextOrderID				= LEAD(SalesOrderID)	OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID)
FROM	Sales.SalesOrderHeader	AS soh;

--Nested in expression
SELECT	CustomerID				= soh.CustomerID,
		SalesOrderID			= soh.SalesOrderID,
		OrderDate				= CAST(soh.OrderDate AS DATE),
		DaysSincePrevOrder		= DATEDIFF(d, LAG(soh.OrderDate) OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID), soh.OrderDate),
		DaysTillNextOrder		= DATEDIFF(d, soh.OrderDate, LEAD(soh.OrderDate) OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID))
FROM	Sales.SalesOrderHeader	AS soh;


--Compare sales by year
WITH Sales
AS
(
	SELECT		OrderYear				= YEAR(soh.OrderDate),
				OrderMonth				= MONTH(soh.OrderDate),
				TotalSales				= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	GROUP BY	YEAR(soh.OrderDate),
				MONTH(soh.OrderDate)
)
SELECT		OrderYear		= s.OrderYear,
			OrderMonth		= s.OrderMonth,
			TotalSales		= s.TotalSales,
			PrevYearsSales	= LAG(s.TotalSales, 12) OVER (ORDER BY s.OrderYear, s.OrderMonth)
FROM		Sales			AS s
ORDER BY	s.OrderYear,
			s.OrderMonth;


--Replace NULL
WITH Sales
AS
(
	SELECT		OrderYear				= YEAR(soh.OrderDate),
				OrderMonth				= MONTH(soh.OrderDate),
				TotalSales				= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	GROUP BY	YEAR(soh.OrderDate),
				MONTH(soh.OrderDate)
)
SELECT		OrderYear		= s.OrderYear,
			OrderMonth		= s.OrderMonth,
			TotalSales		= s.TotalSales,
			PrevYearsSales	= LAG(TotalSales, 12, 0)  OVER (ORDER BY s.OrderYear, s.OrderMonth)
FROM		Sales			AS s
ORDER BY	s.OrderYear,
			s.OrderMonth;

--Filter NULL
WITH Sales
AS
(
	SELECT		OrderYear				= YEAR(soh.OrderDate),
				OrderMonth				= MONTH(soh.OrderDate),
				TotalSales				= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	GROUP BY	YEAR(soh.OrderDate),
				MONTH(soh.OrderDate)
),
	CompareYears
AS
(
	SELECT		OrderYear		= s.OrderYear,
				OrderMonth		= s.OrderMonth,
				TotalSales		= s.TotalSales,
				PrevYearsSales	= LAG(s.TotalSales, 12) OVER (ORDER BY s.OrderYear, s.OrderMonth)
	FROM		Sales			AS s
)
SELECT		OrderYear,
			OrderMonth,
			TotalSales,
			PrevYearsSales
FROM		CompareYears
WHERE		PrevYearsSales IS NOT NULL
ORDER BY	OrderYear,
			OrderMonth;