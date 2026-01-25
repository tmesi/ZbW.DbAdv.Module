USE PL_SampleData;
GO
--Look for dbo.Islands in ID
SELECT	ID
FROM	dbo.Islands;



--Step 1: add a row_number()
SELECT	ID			= i.ID,
		RowNum		= ROW_NUMBER() OVER (ORDER BY i.ID)
FROM	dbo.Islands	AS i;





--Step 2: find the difference
SELECT	ID			= i.ID,
		RowNum		= ROW_NUMBER()			OVER (ORDER BY i.ID),
		Diff		= i.ID - ROW_NUMBER()	OVER (ORDER BY i.ID)
FROM	dbo.Islands	AS i;





--Step 3: Group by Diff
WITH Diffs
AS
(
	SELECT	ID			= i.ID,
			RowNum		= ROW_NUMBER()			OVER (ORDER BY i.ID),
			Diff		= i.ID - ROW_NUMBER()	OVER (ORDER BY i.ID)
	FROM	dbo.Islands	AS i
)
SELECT		BeginningOfIsland	= MIN(d.ID),
			EndOfIsland			= MAX(d.ID)
FROM		Diffs				AS d
GROUP BY	d.Diff;





--Find the dbo.Islands in Dates
SELECT		OrderDate
FROM		dbo.Islands
ORDER BY	OrderDate;


--Step 1: Add row_number
SELECT	OrderDate	= i.OrderDate,
		RowNum		= ROW_NUMBER() OVER (ORDER BY i.OrderDate)
FROM	dbo.Islands	AS i;

--Try RANK
SELECT	OrderDate	= i.OrderDate,
		Rnk			= RANK() OVER (ORDER BY i.OrderDate)
FROM	dbo.Islands	AS i;

--Try DENSE_RANK
SELECT	OrderDate	= i.OrderDate,
		DenseRnk	= DENSE_RANK() OVER (ORDER BY i.OrderDate)
FROM	dbo.Islands	AS i;

--Step 2: Add to a base date
WITH Level1
AS
(
	SELECT	OrderDate	= i.OrderDate,
			DenseRnk	= DENSE_RANK() OVER (ORDER BY i.OrderDate)
	FROM	dbo.Islands	AS i
)
SELECT	OrderDate	= l.OrderDate,
		NewDate		= DATEADD(d, l.DenseRnk, '2014-12-31')
FROM	Level1		AS l;

--Step 3: Find the difference
WITH Level1
AS
(
	SELECT	OrderDate	= i.OrderDate,
			DenseRnk	= DENSE_RANK() OVER (ORDER BY i.OrderDate)
	FROM	dbo.Islands	AS i
),
	Level2
AS
(
	SELECT	OrderDate	= l.OrderDate,
			NewDate		= DATEADD(d, l.DenseRnk, '2014-12-31')
	FROM	Level1		AS l
)
SELECT	OrderDate	= l.OrderDate,
		Diff		= DATEDIFF(d, l.NewDate, l.OrderDate)
FROM	Level2		AS l;



--Step 4: Group by the difference
WITH Level1
AS
(
	SELECT	OrderDate	= i.OrderDate,
			DenseRnk	= DENSE_RANK() OVER (ORDER BY i.OrderDate)
	FROM	dbo.Islands	AS i
),
	Level2
AS
(
	SELECT	OrderDate	= l.OrderDate,
			NewDate		= DATEADD(d, l.DenseRnk, '2014-12-31')
	FROM	Level1		AS l
),
	Level3
AS
(
	SELECT	OrderDate	= l.OrderDate,
			Diff		= DATEDIFF(d, l.NewDate, l.OrderDate)
	FROM	Level2		AS l
)
SELECT		Islandstart	= MIN(OrderDate),
			IslandEnd	= MAX(OrderDate)
FROM		Level3		AS l
GROUP BY	l.Diff;

-- Zusammenfassung der verschiedenen CTE-Levels zu einem CTE
WITH Dates
AS
(
	SELECT	OrderDate		= i.OrderDate,
			Diff			= DATEDIFF(d, DATEADD(d, DENSE_RANK() OVER (ORDER BY i.OrderDate), '2014-12-31'), i.OrderDate)
	FROM	dbo.Islands		AS i
)
SELECT		Islandstart		= MIN(d.OrderDate),
			IslandEnd		= MAX(d.OrderDate) 
FROM		Dates			AS d
GROUP BY	d.Diff;








--Deduplication
/*
To recreate the table if needed:
exec usp_CreateDuplicates;
*/
SELECT	ID				= d.ID,
		Val1			= d.Val1,
		Val2			= d.Val2
FROM	dbo.Duplicates	AS d;






--Step 1: Add a row_number
SELECT	ID				= d.ID,
		Val1			= d.Val1,
		Val2			= d.Val2,
		RowNum			= ROW_NUMBER() OVER (ORDER BY d.ID)
FROM	dbo.Duplicates	AS d;





--Step 2: Partition by each column
SELECT	ID				= d.ID,
		Val1			= d.Val1,
		Val2			= d.Val2,
		RowNum			= ROW_NUMBER() OVER (PARTITION BY d.Id, d.Val1, d.Val2 ORDER BY d.ID)
FROM	dbo.Duplicates	AS d;


-- ergibt Fehler - Lösung?
SELECT	ID				= d.ID,
		Val1			= d.Val1,
		Val2			= d.Val2,
		RowNum			= ROW_NUMBER() OVER (PARTITION BY d.Id, d.Val1, d.Val2 ORDER BY d.ID)
FROM	dbo.Duplicates	AS d
WHERE	ROW_NUMBER()	OVER (PARTITION BY d.Id, d.Val1, d.Val2 ORDER BY d.ID) <> 1;

--DELETE	FROM duplicates
SELECT	*
FROM	dbo.duplicates	AS d
WHERE	d.id IN
		(
			SELECT	sq.ID
			FROM	(
						SELECT	ID				= d.ID,
								Val1			= d.Val1,
								Val2			= d.Val2,
								RowNum			= ROW_NUMBER() OVER (PARTITION BY d.Id, d.Val1, d.Val2 ORDER BY d.ID)
						FROM	dbo.Duplicates	AS d
					) AS sq
			WHERE	sq.RowNum <> 1
		);





--Step 3: Separate the logic and filter
WITH Dupes
AS
(
	SELECT	ID				= d.ID,
			Val1			= d.Val1,
			Val2			= d.Val2,
			RowNum			= ROW_NUMBER() OVER (PARTITION BY d.Id, d.Val1, d.Val2 ORDER BY d.ID)
	FROM	dbo.Duplicates	AS d
)
SELECT	ID,
		Val1,
		Val2,
		RowNum
FROM	Dupes
WHERE	RowNum <> 1;



--Step 4: Delete
WITH Dupes
AS
(
	SELECT	ID				= d.ID,
			Val1			= d.Val1,
			Val2			= d.Val2,
			RowNum			= ROW_NUMBER() OVER (PARTITION BY d.Id, d.Val1, d.Val2 ORDER BY d.ID)
	FROM	dbo.Duplicates	AS d
)
DELETE	Dupes
WHERE	RowNum <> 1;



--View the results
SELECT		ID				= d.ID,
			Val1			= d.Val1,
			Val2			= d.Val2
FROM		dbo.Duplicates	AS d
ORDER BY	ID;




--First N
USE AdventureWorks2022;
GO

--What are the first four orders for each product?
SELECT	ProductID				= sod.ProductID,
		SalesOrderID			= soh.SalesOrderID,
		OrderDate				= FORMAT(soh.OrderDate, 'yyyy-MM-dd') 
FROM	Sales.SalesOrderHeader	AS soh
		INNER JOIN
		Sales.SalesOrderDetail	AS sod
			ON soh.SalesOrderID	= sod.SalesOrderID
WHERE	soh.OrderDate			>= '2011-01-01'
  AND	soh.OrderDate			< '2012-01-01';



--TOP(4) ?
SELECT	TOP (4)
		ProductID				= sod.ProductID,
		SalesOrderID			= soh.SalesOrderID,
		OrderDate				= FORMAT(soh.OrderDate, 'yyyy-MM-dd') 
FROM	Sales.SalesOrderHeader	AS soh
		INNER JOIN
		Sales.SalesOrderDetail	AS sod
			ON soh.SalesOrderID	= sod.SalesOrderID
WHERE	soh.OrderDate			>= '2011-01-01'
  AND	soh.OrderDate			< '2012-01-01';



--Step 1: Add a ROW_NUMBER
SELECT	ProductID				= sod.ProductID,
		SalesOrderID			= soh.SalesOrderID,
		OrderDate				= FORMAT(soh.OrderDate, 'yyyy-MM-dd'),
		RowNum					= ROW_NUMBER() OVER (PARTITION BY SOD.ProductID ORDER BY SOH.SalesOrderID)
FROM	Sales.SalesOrderHeader	AS soh
		INNER JOIN
		Sales.SalesOrderDetail	AS sod
			ON soh.SalesOrderID	= sod.SalesOrderID
WHERE	soh.OrderDate			>= '2011-01-01'
  AND	soh.OrderDate			< '2012-01-01';


--Step 2: Separate the logic
WITH Orders
AS
(
	SELECT	ProductID				= sod.ProductID,
			SalesOrderID			= soh.SalesOrderID,
			OrderDate				= FORMAT(soh.OrderDate, 'yyyy-MM-dd'),
			RowNum					= ROW_NUMBER() OVER (PARTITION BY SOD.ProductID ORDER BY SOH.SalesOrderID)
	FROM	Sales.SalesOrderHeader	AS soh
			INNER JOIN
			Sales.SalesOrderDetail	AS sod
				ON soh.SalesOrderID	= sod.SalesOrderID
	WHERE	soh.OrderDate			>= '2011-01-01'
	  AND	soh.OrderDate			< '2012-01-01'
)
SELECT	o.ProductID,
		o.SalesOrderID,
		o.OrderDate
FROM	Orders	AS o
WHERE	RowNum	<= 4;



--The Gold Star Customers
USE AdventureWorks2022;
GO


--Step 1: Write aggregate query
SELECT		TotalSales				= SUM(soh.TotalDue),
			CustomerID				= soh.CustomerID
FROM		Sales.SalesOrderHeader	AS soh
WHERE		OrderDate				>= '2014-01-01'
AND			OrderDate				< '2015-01-01'
GROUP BY	soh.CustomerID;



--Step 2: Move Query to CTE and add NTILE
WITH Sales
AS
(
	SELECT		TotalSales				= SUM(soh.TotalDue),
				CustomerID				= soh.CustomerID
	FROM		Sales.SalesOrderHeader	AS soh
	WHERE		OrderDate				>= '2014-01-01'
	AND			OrderDate				< '2015-01-01'
	GROUP BY	soh.CustomerID
)
SELECT		TotalSales		= s.TotalSales,
			CustomerID		= s.CustomerID,
			Bucket			= NTILE(4) OVER (ORDER BY s.TotalSales)
FROM		Sales			AS s
ORDER BY	s.customerid;





--Step 3: Add Gold Star logic
WITH Sales
AS
(
	SELECT		TotalSales				= SUM(soh.TotalDue),
				CustomerID				= soh.CustomerID
	FROM		Sales.SalesOrderHeader	AS soh
	WHERE		OrderDate				>= '2014-01-01'
	AND			OrderDate				< '2015-01-01'
	GROUP BY	soh.CustomerID
),
	Buckets
AS
(
	SELECT	TotalSales	= TotalSales,
			CustomerID	= CustomerID,
			Bucket		= NTILE(4) OVER (ORDER BY TotalSales) 
	FROM	Sales		AS s
)
SELECT	TotalSales			= b.TotalSales,
		CustomerID			= b.CustomerID,
		CustomerCategory	= CHOOSE(Bucket, 'No star', 'Bronze Star', 'Silver Star', 'Gold Star')
FROM	Buckets				AS b;

-- gleich wie oben, jedoch ohne CTE
SELECT		TotalSales				= SUM(TotalDue),
			CustomerID				= soh.CustomerID,
			CustomerCategory		= CHOOSE(NTILE(4) OVER (ORDER BY SUM(soh.TotalDue)), 'No star', 'Bronze Star', 'Silver Star', 'Gold Star')
FROM		Sales.SalesOrderHeader	AS soh
WHERE		soh.OrderDate			>= '2014-01-01'
AND			soh.OrderDate			< '2015-01-01'
GROUP BY	soh.CustomerID;
