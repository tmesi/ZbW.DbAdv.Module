USE PL_SampleData;
GO


--The GAPS problem
SELECT	i.ID
FROM	dbo.Islands	AS i;

--Step 1: Pull next value with LEAD
SELECT	ThisValue	= i.ID									,
		NextValue	= LEAD(i.ID) OVER (ORDER BY ID),
		Diff		= i.ID - LEAD(i.ID) OVER (ORDER BY ID)
FROM	dbo.Islands	AS i;


--Step 2: Keep where the difference is not equal to -1
WITH Vals
AS
(
	SELECT	ThisValue	= i.ID									,
			NextValue	= LEAD(i.ID) OVER (ORDER BY ID),
			Diff		= i.ID - LEAD(i.ID) OVER (ORDER BY ID)
	FROM	dbo.Islands	AS i
)
SELECT	v.ThisValue,
		v.NextValue
FROM	Vals	AS v
WHERE	v.Diff	<> -1;

--Step 3: Adjust the results
WITH Vals
AS
(
	SELECT	ThisValue	= i.ID									,
			NextValue	= LEAD(i.ID) OVER (ORDER BY ID),
			Diff		= i.ID - LEAD(i.ID) OVER (ORDER BY ID)
	FROM	dbo.Islands	AS i
)
SELECT	StartOfGap	= v.ThisValue + 1,
		EndOfGap	= v.NextValue - 1
FROM	Vals		AS v
WHERE	v.Diff		<> -1;



--Date solution
WITH Step1
AS
(
	SELECT		i.OrderDate
	FROM		dbo.Islands	AS i
	GROUP BY	i.OrderDate
),
	Step2
AS
(
	SELECT	ThisValue	= s.OrderDate,
			NextValue	= LEAD(s.OrderDate) OVER (ORDER BY s.OrderDate),
			Diff		= DATEDIFF(d, LEAD(s.OrderDate) OVER (ORDER BY s.OrderDate), s.OrderDate)
	FROM	Step1		AS s
)
SELECT	StartOfGap	= DATEADD(d, 1, s.ThisValue),
		EndOfGap	= DATEADD(d, -1, s.NextValue)
FROM	Step2		AS s
WHERE	s.Diff		<> -1;



USE AdventureWorks2022;
GO

--YOY
--Step 1
SELECT		OrderYear				= YEAR(soh.OrderDate),
			OrderMonth				= MONTH(soh.OrderDate),
			TotalSales				= SUM(soh.TotalDue)
FROM		Sales.SalesOrderHeader	AS soh
GROUP BY	YEAR(soh.OrderDate),
			MONTH(soh.OrderDate)
ORDER BY	OrderYear,
			OrderMonth;


--Step 2
WITH Step1
AS
(
	SELECT		OrderYear				= YEAR(soh.OrderDate),
				OrderMonth				= MONTH(soh.OrderDate),
				TotalSales				= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	GROUP BY	YEAR(soh.OrderDate),
				MONTH(soh.OrderDate)
)
SELECT	OrderYear		= s.OrderYear,
		OrderMonth		= s.OrderMonth,
		TotalSales		= s.TotalSales,
		LastYearSales	= LAG(TotalSales, 12) OVER (ORDER BY s.OrderYear, s.OrderMonth)
FROM	Step1			AS s;


WITH Step1
AS
(
	SELECT		OrderYear				= YEAR(soh.OrderDate),
				OrderMonth				= MONTH(soh.OrderDate),
				TotalSales				= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	GROUP BY	YEAR(soh.OrderDate),
				MONTH(soh.OrderDate)
),
	Step2
AS
(
	SELECT	OrderYear		= s.OrderYear,
			OrderMonth		= s.OrderMonth,
			TotalSales		= s.TotalSales,
			LastYearSales	= LAG(TotalSales, 12) OVER (ORDER BY s.OrderYear, s.OrderMonth)
	FROM	Step1			AS s
)
SELECT	OrderYear		= s.OrderYear,
		OrderMonth		= s.OrderMonth,
		TotalSales		= s.TotalSales,
		LastYearSales	= s.LastYearSales,
		PercentChange	= FORMAT((s.TotalSales - s.LastYearSales) / s.LastYearSales, 'P')
FROM	Step2			AS s
WHERE	s.LastYearSales	IS NOT NULL;

--Quarters
WITH Step1
AS
(
	SELECT		OrderYear				= YEAR(soh.OrderDate),
				OrderQtr				= MONTH(soh.OrderDate) / 4 + 1,
				TotalSales				= SUM(soh.TotalDue)
	FROM		Sales.SalesOrderHeader	AS soh
	GROUP BY	YEAR(soh.OrderDate),
				MONTH(soh.OrderDate)  / 4 + 1
),
	Step2
AS
(
	SELECT	OrderYear		= s.OrderYear,
			OrderQtr		= s.OrderQtr,
			TotalSales		= s.TotalSales,
			LastYearSales	= LAG(s.TotalSales, 4) OVER (ORDER BY s.OrderYear, s.OrderQtr)
	FROM	Step1			AS s
)
SELECT	OrderYear		= s.OrderYear,
		OrderQtr		= s.OrderQtr,
		TotalSales		= s.TotalSales,
		LastYearSales	= s.LastYearSales,
		PercentChange	= FORMAT((s.TotalSales - s.LastYearSales) / s.LastYearSales, 'P')
FROM	Step2			AS s
WHERE	s.LastYearSales	IS NOT NULL;

