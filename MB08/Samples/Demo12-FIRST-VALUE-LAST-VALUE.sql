USE AdventureWorks2022;
GO

--FIRST_VALUE and LAST_VALUE, Default frames
SELECT	CustomerID,
		CAST(OrderDate AS DATE)		AS OrderDate,
		SalesOrderID,
		TotalDue,
		FIRST_VALUE(TotalDue) OVER (PARTITION BY CustomerID
									ORDER BY SalesOrderID
								)	AS FirstOrderTotal,
		LAST_VALUE(TotalDue) OVER (PARTITION BY CustomerID
								ORDER BY SalesOrderID
								)	AS LastOrderTotal
FROM	Sales.SalesOrderHeader;

--Specify the frame for LAST_VALUE
SELECT		CustomerID,
			CAST(OrderDate AS DATE)		AS OrderDate,
			SalesOrderID,
			TotalDue,
			FIRST_VALUE(TotalDue) OVER (PARTITION BY CustomerID
										ORDER BY SalesOrderID
									)	AS FirstOrderTotal,
			LAST_VALUE(TotalDue) OVER (PARTITION BY CustomerID
									ORDER BY SalesOrderID
									ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
									)	AS LastOrderTotal
FROM		Sales.SalesOrderHeader
ORDER BY	CustomerID,
			SalesOrderID;

--Last year's sales
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
			FIRST_VALUE(TotalSales) OVER (ORDER BY OrderYear,
												OrderMonth
										ROWS BETWEEN 12 PRECEDING AND CURRENT ROW
										) AS LastYearsSales
FROM		Sales
ORDER BY	OrderYear,
			OrderMonth;


--Add CASE
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
			CASE WHEN COUNT(*) OVER (ORDER BY OrderYear,
											OrderMonth
									ROWS BETWEEN 12 PRECEDING AND CURRENT ROW
									) = 13 THEN FIRST_VALUE(TotalSales) OVER (ORDER BY OrderYear,
																					OrderMonth
																			ROWS BETWEEN 12 PRECEDING AND CURRENT ROW
																			) ELSE NULL END AS LastYearsSales
FROM		Sales
ORDER BY	OrderYear,
			OrderMonth;





