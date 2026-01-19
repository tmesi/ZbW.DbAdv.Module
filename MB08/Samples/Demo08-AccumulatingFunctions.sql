USE AdventureWorks2022;
GO

--Window Aggregate vs. Accumulating Window Aggregate
SELECT	CustomerID,
		SalesOrderID,
		TotalDue,
		SUM(TotalDue) OVER (PARTITION BY CustomerID) AS SubTotal,
		SUM(TotalDue) OVER (PARTITION BY CustomerID
							ORDER BY SalesOrderID
						)							AS RunningTotal
FROM	Sales.SalesOrderHeader;

--Running average 
WITH Sales
AS
(
	SELECT		MONTH(OrderDate)	AS OrderMonth,
				SUM(TotalDue)		AS MonthlySales
	FROM		Sales.SalesOrderHeader
	WHERE		OrderDate	>= '2012-01-01'
	AND			OrderDate			< '2013-01-01'
	GROUP BY	MONTH(OrderDate)
)
SELECT	OrderMonth,
		MonthlySales,
		AVG(MonthlySales) OVER (ORDER BY OrderMonth) AS Average
FROM	Sales;



