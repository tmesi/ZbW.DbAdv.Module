USE AdventureWorks2022;
GO

--Running average
WITH Totals
AS
(
	SELECT		OrderMonth				= MONTH(soh.OrderDate),
				TotalSales				= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	WHERE		soh.OrderDate			>= '2012-01-01'
	AND			soh.OrderDate			< '2013-01-01'
	GROUP BY	MONTH(soh.OrderDate)
)
SELECT	OrderMonth	= t.OrderMonth,
		TotalSales	= t.TotalSales,
		Average		= AVG(t.TotalSales) OVER (ORDER BY t.OrderMonth)
FROM	Totals		AS t;

--Calculate 3 month moving average
WITH Totals
AS
(
	SELECT		OrderMonth				= MONTH(soh.OrderDate),
				TotalSales				= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	WHERE		soh.OrderDate			>= '2012-01-01'
	AND			soh.OrderDate			< '2013-01-01'
	GROUP BY	MONTH(soh.OrderDate)
)
SELECT		OrderMonth					= t.OrderMonth,
			TotalSales					= t.TotalSales,
			ThreeMonthRunningAverage	= AVG(t.TotalSales) OVER (ORDER BY t.OrderMonth 
																  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
FROM		Totals						AS t
ORDER BY	t.OrderMonth;


--Leave out months with less than 3 
WITH Totals
AS
(
	SELECT		OrderMonth				= MONTH(soh.OrderDate),
				TotalSales				= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	WHERE		soh.OrderDate			>= '2012-01-01'
	AND			soh.OrderDate			< '2013-01-01'
	GROUP BY	MONTH(soh.OrderDate)
)
SELECT	OrderMonth					= t.OrderMonth,
		TotalSales					= t.TotalSales,
		ThreeMonthRunningAverage	= CASE	WHEN COUNT(*) OVER (ORDER BY OrderMonth ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) > 2
									  THEN AVG(TotalSales) OVER (ORDER BY OrderMonth ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
									  ELSE NULL END
FROM	Totals						AS t;


--Reverse running total
SELECT		CustomerID				= soh.CustomerID,
			SalesOrderID			= soh.SalesOrderID,
			TotalDue				= soh.TotalDue,
			ReverseRunningTotal		= SUM(soh.TotalDue) OVER (PARTITION BY CustomerID ORDER BY SalesOrderID
															  ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM		Sales.SalesOrderHeader	AS soh
ORDER BY	soh.CustomerID,
			soh.SalesOrderID;

