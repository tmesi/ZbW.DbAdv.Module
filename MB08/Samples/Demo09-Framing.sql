USE AdventureWorks2022;
GO

--Running average
WITH Totals
AS
(
	SELECT		MONTH(OrderDate)	AS OrderMonth,
				SUM(TotalDue)		AS TotalSales
	FROM		Sales.SalesOrderHeader
	WHERE		OrderDate	>= '2012-01-01'
	AND			OrderDate			< '2013-01-01'
	GROUP BY	MONTH(OrderDate)
)
SELECT	OrderMonth,
		TotalSales,
		AVG(TotalSales) OVER (ORDER BY OrderMonth) AS Average
FROM	Totals;

--Calculate 3 month moving average
WITH Totals
AS
(
	SELECT		MONTH(OrderDate)	AS OrderMonth,
				SUM(TotalDue)		AS TotalSales
	FROM		Sales.SalesOrderHeader
	WHERE		OrderDate	>= '2012-01-01'
	AND			OrderDate			< '2013-01-01'
	GROUP BY	MONTH(OrderDate)
)
SELECT		OrderMonth,
			TotalSales,
			AVG(TotalSales) OVER (ORDER BY OrderMonth
								ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
								) AS ThreeMonthRunningAverage
FROM		Totals
ORDER BY	OrderMonth;


--Leave out months with less than 3 
WITH Totals
AS
(
	SELECT		MONTH(OrderDate)	AS OrderMonth,
				SUM(TotalDue)		AS TotalSales
	FROM		Sales.SalesOrderHeader
	WHERE		OrderDate	>= '2012-01-01'
	AND			OrderDate			< '2013-01-01'
	GROUP BY	MONTH(OrderDate)
)
SELECT	OrderMonth,
		TotalSales,
		CASE WHEN COUNT(*) OVER (ORDER BY OrderMonth
								ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
								) > 2 THEN AVG(TotalSales) OVER (ORDER BY OrderMonth
																ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
																) ELSE NULL END AS ThreeMonthRunningAverage
FROM	Totals;


--Reverse running total
SELECT		CustomerID,
			SalesOrderID,
			TotalDue,
			SUM(TotalDue) OVER (PARTITION BY CustomerID
								ORDER BY SalesOrderID
								ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
							)	AS ReverseRunningTotal
FROM		Sales.SalesOrderHeader
ORDER BY	CustomerID,
			SalesOrderID;

