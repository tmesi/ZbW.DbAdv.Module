USE PL_SampleData;
GO


--The GAPS problem
SELECT	ID
FROM	dbo.Islands;

--Step 1: Pull next value with LEAD
SELECT	ID									AS ThisValue,
		LEAD(ID) OVER (ORDER BY ID) AS NextValue,
		ID - LEAD(ID) OVER (ORDER BY ID) AS Diff
FROM	dbo.Islands;


--Step 2: Keep where the difference is not equal to -1
WITH Vals
AS
(
	SELECT	ID									AS ThisValue,
			LEAD(ID) OVER (ORDER BY ID) AS NextValue,
			ID - LEAD(ID) OVER (ORDER BY ID) AS Diff
	FROM	dbo.Islands
)
SELECT	ThisValue,
		NextValue
FROM	Vals
WHERE	Diff <> -1;

--Step 3: Adjust the results
WITH Vals
AS
(
	SELECT	ID									AS ThisValue,
			LEAD(ID) OVER (ORDER BY ID) AS NextValue,
			ID - LEAD(ID) OVER (ORDER BY ID) AS Diff
	FROM	dbo.Islands
)
SELECT	ThisValue + 1 AS StartOfGap,
		NextValue - 1 AS EndOfGap
FROM	Vals
WHERE	Diff <> -1;



--Date solution
WITH Step1
AS
(
	SELECT		OrderDate
	FROM		dbo.Islands
	GROUP BY	OrderDate
),
	Step2
AS
(
	SELECT	OrderDate															AS ThisValue,
			LEAD(OrderDate) OVER (ORDER BY OrderDate)					AS NextValue,
			DATEDIFF(d, LEAD(OrderDate) OVER (ORDER BY OrderDate), OrderDate) AS Diff
	FROM	Step1
)
SELECT	DATEADD(d, 1, ThisValue) AS StartOfGap,
		DATEADD(d, -1, NextValue) AS EndOfGap
FROM	Step2
WHERE	Diff <> -1;



USE AdventureWorks2016;
GO

--YOY
--Step 1
SELECT		YEAR(OrderDate)		AS OrderYear,
			MONTH(OrderDate)	AS OrderMonth,
			SUM(TotalDue)		AS TotalSales
FROM		Sales.SalesOrderHeader
GROUP BY	YEAR(OrderDate),
			MONTH(OrderDate)
ORDER BY	OrderYear,
			OrderMonth;


--Step 2
WITH Step1
AS
(
	SELECT		YEAR(OrderDate)		AS OrderYear,
				MONTH(OrderDate)	AS OrderMonth,
				SUM(TotalDue)		AS TotalSales
	FROM		Sales.SalesOrderHeader
	GROUP BY	YEAR(OrderDate),
				MONTH(OrderDate)
)
SELECT	OrderYear,
		OrderMonth,
		TotalSales,
		LAG(TotalSales, 12) OVER (ORDER BY OrderYear,
										OrderMonth
								) AS LastYearSales
FROM	Step1;


WITH Step1
AS
(
	SELECT		YEAR(OrderDate)		AS OrderYear,
				MONTH(OrderDate)	AS OrderMonth,
				SUM(TotalDue)		AS TotalSales
	FROM		Sales.SalesOrderHeader
	GROUP BY	YEAR(OrderDate),
				MONTH(OrderDate)
),
	Step2
AS
(
	SELECT	OrderYear,
			OrderMonth,
			TotalSales,
			LAG(TotalSales, 12) OVER (ORDER BY OrderYear,
											OrderMonth
									) AS LastYearSales
	FROM	Step1
)
SELECT	OrderYear,
		OrderMonth,
		TotalSales,
		LastYearSales,
		FORMAT((TotalSales - LastYearSales) / LastYearSales, 'P') AS PercentChange
FROM	Step2
WHERE	LastYearSales IS NOT NULL;

--Quarters
WITH Step1
AS
(
	SELECT		YEAR(OrderDate)				AS OrderYear,
				MONTH(OrderDate) / 4 + 1 AS OrderQtr,
				SUM(TotalDue)				AS TotalSales
	FROM		Sales.SalesOrderHeader
	GROUP BY	YEAR(OrderDate),
				MONTH(OrderDate) / 4 + 1
),
	Step2
AS
(
	SELECT	OrderYear,
			OrderQtr,
			TotalSales,
			LAG(TotalSales, 4) OVER (ORDER BY OrderYear,
											OrderQtr
									)	AS LastYearSales
	FROM	Step1
)
SELECT	OrderYear,
		OrderQtr,
		TotalSales,
		LastYearSales,
		FORMAT((TotalSales - LastYearSales) / LastYearSales, 'P') AS PercentChange
FROM	Step2
WHERE	LastYearSales IS NOT NULL;

