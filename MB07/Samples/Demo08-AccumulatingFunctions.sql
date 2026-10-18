USE AdventureWorks2022;
GO

--Window Aggregate vs. Accumulating Window Aggregate
SELECT	soh.CustomerID,
		soh.SalesOrderID,
		soh.TotalDue,
		SubTotal				= SUM(soh.TotalDue) OVER (PARTITION BY soh.CustomerID),
		RunningTotal			= SUM(soh.TotalDue) OVER (PARTITION BY soh.CustomerID ORDER BY soh.SalesOrderID)
FROM	Sales.SalesOrderHeader	AS soh;

--Running average 
WITH Sales
AS
(
	SELECT		OrderMonth				= MONTH(soh.OrderDate),
				MonthlySales			= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	WHERE		soh.OrderDate			>= '2012-01-01'
	AND			soh.OrderDate			< '2013-01-01'
	GROUP BY	MONTH(soh.OrderDate)
)
SELECT	OrderMonth,
		MonthlySales,
		Average			= AVG(MonthlySales) OVER (ORDER BY OrderMonth)
FROM	Sales			AS s;



