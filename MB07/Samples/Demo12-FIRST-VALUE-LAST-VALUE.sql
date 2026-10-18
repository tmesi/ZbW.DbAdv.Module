USE AdventureWorks2022;
GO

--FIRST_VALUE and LAST_VALUE, Default frames
SELECT	CustomerID				= soh.CustomerID,
		OrderDate				= CAST(soh.OrderDate AS DATE),
		SalesOrderID			= soh.SalesOrderID,
		TotalDue				= soh.TotalDue,
		FirstOrderTotal			= FIRST_VALUE(soh.TotalDue)	OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID),
		LastOrderTotal			= LAST_VALUE(soh.TotalDue)	OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID)
FROM	Sales.SalesOrderHeader	AS soh;

--Specify the frame for LAST_VALUE
SELECT	CustomerID				= soh.CustomerID,
		OrderDate				= CAST(soh.OrderDate AS DATE),
		SalesOrderID			= soh.SalesOrderID,
		TotalDue				= soh.TotalDue,
		FirstOrderTotal			= FIRST_VALUE(soh.TotalDue)	OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID),
		LastOrderTotal			= LAST_VALUE(soh.TotalDue)	OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID 
																  ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM	Sales.SalesOrderHeader	AS soh
ORDER BY soh.CustomerID,
		 soh.SalesOrderID;

--Last year's sales
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
			LastYearsSales	= FIRST_VALUE(s.TotalSales) OVER (ORDER BY s.OrderYear, s.OrderMonth ROWS BETWEEN 12 PRECEDING AND CURRENT ROW)
FROM		Sales			AS s
ORDER BY	s.OrderYear,
			s.OrderMonth;


--Add CASE
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
			LastYearsSales	= CASE	WHEN COUNT(*) OVER (ORDER BY s.OrderYear, s.OrderMonth ROWS BETWEEN 12 PRECEDING AND CURRENT ROW) = 13
									THEN FIRST_VALUE(s.TotalSales) OVER (ORDER BY s.OrderYear, s.OrderMonth ROWS BETWEEN 12 PRECEDING AND CURRENT ROW)
									ELSE NULL END
FROM		Sales			AS s
ORDER BY	s.OrderYear,
			s.OrderMonth;





