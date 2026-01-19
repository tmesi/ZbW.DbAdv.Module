USE AdventureWorks2022;
GO

--LAG
SELECT	CustomerID,
		SalesOrderID,
		TotalDue,
		LAG(TotalDue) OVER (PARTITION BY CustomerID
							ORDER BY SalesOrderID
						)		AS PrevTotalDue,
		LAG(SalesOrderID) OVER (PARTITION BY CustomerID
								ORDER BY SalesOrderID
							)	AS PrevOrderID
FROM	Sales.SalesOrderHeader;

--LEAD
SELECT	CustomerID,
		SalesOrderID,
		TotalDue,
		LEAD(TotalDue) OVER (PARTITION BY CustomerID
							ORDER BY SalesOrderID
							)		AS NextTotalDue,
		LEAD(SalesOrderID) OVER (PARTITION BY CustomerID
								ORDER BY SalesOrderID
								)	AS NextOrderID
FROM	Sales.SalesOrderHeader;

--Nested in expression
SELECT	CustomerID,
		SalesOrderID,
		CAST(OrderDate AS DATE) AS OrderDate,
		DATEDIFF(	d,
					LAG(OrderDate) OVER (PARTITION BY CustomerID
										ORDER BY SalesOrderID
										),
					OrderDate
				)				AS DaysSincePrevOrder,
		DATEDIFF(	d,
					OrderDate,
					LEAD(OrderDate) OVER (PARTITION BY CustomerID
										ORDER BY SalesOrderID
										)
				)				AS DaysTillNextOrder
FROM	Sales.SalesOrderHeader;


--Compare sales by year
WITH Sales
AS
(
	SELECT		YEAR(OrderDate)		AS OrderYear,
				MONTH(OrderDate)	AS OrderMonth,
				SUM(TotalDue)		AS TotalSales
	FROM		Sales.SalesOrderHeader
	GROUP BY	YEAR(OrderDate),
				MONTH(OrderDate)
)
SELECT		OrderYear,
			OrderMonth,
			TotalSales,
			LAG(TotalSales, 12) OVER (ORDER BY OrderYear,
											OrderMonth
									) AS PrevYearsSales
FROM		Sales
ORDER BY	OrderYear,
			OrderMonth;


--Replace NULL
WITH Sales
AS
(
	SELECT		YEAR(OrderDate)		AS OrderYear,
				MONTH(OrderDate)	AS OrderMonth,
				SUM(TotalDue)		AS TotalSales
	FROM		Sales.SalesOrderHeader
	GROUP BY	YEAR(OrderDate),
				MONTH(OrderDate)
)
SELECT		OrderYear,
			OrderMonth,
			TotalSales,
			LAG(TotalSales, 12, 0) OVER (ORDER BY OrderYear,
												OrderMonth
										)	AS PrevYearsSales
FROM		Sales
ORDER BY	OrderYear,
			OrderMonth;

--Filter NULL
WITH Sales
AS
(
	SELECT		YEAR(OrderDate)		AS OrderYear,
				MONTH(OrderDate)	AS OrderMonth,
				SUM(TotalDue)		AS TotalSales
	FROM		Sales.SalesOrderHeader
	GROUP BY	YEAR(OrderDate),
				MONTH(OrderDate)
),
	CompareYears
AS
(
	SELECT	OrderYear,
			OrderMonth,
			TotalSales,
			LAG(TotalSales, 12) OVER (ORDER BY OrderYear,
											OrderMonth
									) AS PrevYearsSales
	FROM	Sales
)
SELECT		OrderYear,
			OrderMonth,
			TotalSales,
			PrevYearsSales
FROM		CompareYears
WHERE		PrevYearsSales IS NOT NULL
ORDER BY	OrderYear,
			OrderMonth;