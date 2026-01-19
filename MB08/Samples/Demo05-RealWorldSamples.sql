USE PL_SampleData;
GO
--Look for dbo.Islands in ID
SELECT	ID
FROM	dbo.Islands;









--Step 1: add a row_number()
SELECT	ID,
		ROW_NUMBER() OVER (ORDER BY ID) AS RowNum
FROM	dbo.Islands;





--Step 2: find the difference
SELECT	ID,
		ROW_NUMBER() OVER (ORDER BY ID) AS RowNum,
		ID - ROW_NUMBER() OVER (ORDER BY ID) AS Diff
FROM	dbo.Islands;





--Step 3: Group by Diff
WITH Diffs
AS
(
	SELECT	ID,
			ROW_NUMBER() OVER (ORDER BY ID) AS RowNum,
			ID - ROW_NUMBER() OVER (ORDER BY ID) AS Diff
	FROM	dbo.Islands
)
SELECT		MIN(ID) AS BeginningOfIsland,
			MAX(ID) AS EndOfIsland
FROM		Diffs
GROUP BY	Diff;





--Find the dbo.Islands in Dates
SELECT		OrderDate
FROM		dbo.Islands
ORDER BY	OrderDate;


--Step 1: Add row_number
SELECT	OrderDate,
		ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNum
FROM	dbo.Islands;

--Try RANK
SELECT	OrderDate,
		RANK() OVER (ORDER BY OrderDate) AS Rnk
FROM	dbo.Islands;

--Try DENSE_RANK
SELECT	OrderDate,
		DENSE_RANK() OVER (ORDER BY OrderDate) AS DenseRnk
FROM	dbo.Islands;

--Step 2: Add to a base date
WITH Level1
AS
(
	SELECT	OrderDate,
			DENSE_RANK() OVER (ORDER BY OrderDate) AS DenseRnk
	FROM	dbo.Islands
)
SELECT	OrderDate,
		DATEADD(d, DenseRnk, '2014-12-31') AS NewDate
FROM	Level1;

--Step 3: Find the difference
WITH Level1
AS
(
	SELECT	OrderDate,
			DENSE_RANK() OVER (ORDER BY OrderDate) AS DenseRnk
	FROM	dbo.Islands
),
	Level2
AS
(
	SELECT	OrderDate,
			DATEADD(d, DenseRnk, '2014-12-31') AS NewDate
	FROM	Level1
)
SELECT	OrderDate,
		DATEDIFF(d, NewDate, OrderDate) DIFF
FROM	Level2;



--Step 4: Group by the difference
WITH Level1
AS
(
	SELECT	OrderDate,
			DENSE_RANK() OVER (ORDER BY OrderDate) AS DenseRnk
	FROM	dbo.Islands
),
	Level2
AS
(
	SELECT	OrderDate,
			DATEADD(d, DenseRnk, '2014-12-31') AS NewDate
	FROM	Level1
),
	Level3
AS
(
	SELECT	OrderDate,
			DATEDIFF(d, NewDate, OrderDate) DIFF
	FROM	Level2
)
SELECT		MIN(OrderDate)	AS Islandstart,
			MAX(OrderDate)	AS IslandEnd
FROM		Level3
GROUP BY	DIFF;

-- Zusammenfassung der verschiedenen CTE-Levels zu einem CTE
WITH Dates
AS
(
	SELECT	OrderDate,
			DATEDIFF(d, DATEADD(d, DENSE_RANK() OVER (ORDER BY OrderDate), '2014-12-31'), OrderDate) AS DIFF
	FROM	dbo.Islands
)
SELECT		MIN(OrderDate)	AS Islandstart,
			MAX(OrderDate)	AS IslandEnd
FROM		Dates
GROUP BY	DIFF;








--Deduplication
/*
To recreate the table if needed:
exec usp_CreateDuplicates;
*/
SELECT	ID,
		Val1,
		Val2
FROM	Duplicates;






--Step 1: Add a row_number
SELECT	ID,
		Val1,
		Val2,
		ROW_NUMBER() OVER (ORDER BY ID) AS RowNum
FROM	Duplicates;





--Step 2: Partition by each column
SELECT	ID,
		Val1,
		Val2,
		ROW_NUMBER() OVER (PARTITION BY ID,
										Val1,
										Val2
						ORDER BY ID
						) AS RowNum
FROM	Duplicates;

-- ergibt Fehler - Lösung?
SELECT	ID,
		Val1,
		Val2,
		ROW_NUMBER() OVER (PARTITION BY ID,
										Val1,
										Val2
						ORDER BY ID
						) AS RowNum
FROM	Duplicates
WHERE	ROW_NUMBER() OVER (PARTITION BY ID,
										Val1,
										Val2
						ORDER BY ID
						) <> 1;

DELETE	FROM duplicates
WHERE	id IN
		(
			SELECT	id
			FROM	(
						SELECT	ID,
								Val1,
								Val2,
								ROW_NUMBER() OVER (PARTITION BY ID,
																Val1,
																Val2
												ORDER BY ID
												) AS RowNum
						FROM	Duplicates
					) AS sq
			WHERE	sq.RowNum <> 1
		);





--Step 3: Separate the logic and filter
WITH Dupes
AS
(
	SELECT	ID,
			Val1,
			Val2,
			ROW_NUMBER() OVER (PARTITION BY ID,
											Val1,
											Val2
							ORDER BY ID
							) AS RowNum
	FROM	Duplicates
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
	SELECT	ID,
			Val1,
			Val2,
			ROW_NUMBER() OVER (PARTITION BY ID,
											Val1,
											Val2
							ORDER BY ID
							) AS RowNum
	FROM	Duplicates
)
DELETE	Dupes
WHERE	RowNum <> 1;



--View the results
SELECT		ID,
			Val1,
			Val2
FROM		Duplicates
ORDER BY	ID;




--First N
USE AdventureWorks2016;
GO

--What are the first four orders for each product?
SELECT	SOD.ProductID,
		SOH.SalesOrderID,
		FORMAT(SOH.OrderDate, 'yyyy-MM-dd') AS OrderDate
FROM	Sales.SalesOrderHeader	AS SOH
		JOIN
		Sales.SalesOrderDetail	AS SOD
			ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE	SOH.OrderDate	>= '2011-01-01'
AND		SOH.OrderDate		< '2012-01-01';



--TOP(4) ?
SELECT	TOP (4)
		SOD.ProductID,
		SOH.SalesOrderID,
		FORMAT(SOH.OrderDate, 'yyyy-MM-dd') AS OrderDate
FROM	Sales.SalesOrderHeader	AS SOH
		JOIN
		Sales.SalesOrderDetail	AS SOD
			ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE	SOH.OrderDate	>= '2011-01-01'
AND		SOH.OrderDate		< '2012-01-01';



--Step 1: Add a ROW_NUMBER
SELECT	SOD.ProductID,
		SOH.SalesOrderID,
		FORMAT(SOH.OrderDate, 'yyyy-MM-dd') AS OrderDate,
		ROW_NUMBER() OVER (PARTITION BY SOD.ProductID
						ORDER BY SOH.SalesOrderID
						)				AS RowNum
FROM	Sales.SalesOrderHeader	AS SOH
		JOIN
		Sales.SalesOrderDetail	AS SOD
			ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE	SOH.OrderDate	>= '2011-01-01'
AND		SOH.OrderDate		< '2012-01-01';




--Step 2: Separate the logic
WITH Orders
AS
(
	SELECT	SOD.ProductID,
			SOH.SalesOrderID,
			FORMAT(SOH.OrderDate, 'yyyy-MM-dd') AS OrderDate,
			ROW_NUMBER() OVER (PARTITION BY SOD.ProductID
							ORDER BY SOH.SalesOrderID
							)				AS RowNum
	FROM	Sales.SalesOrderHeader	AS SOH
			JOIN
			Sales.SalesOrderDetail	AS SOD
				ON SOH.SalesOrderID = SOD.SalesOrderID
	WHERE	SOH.OrderDate	>= '2011-01-01'
	AND		SOH.OrderDate		< '2012-01-01'
)
SELECT	ProductID,
		SalesOrderID,
		OrderDate
FROM	Orders
WHERE	RowNum <= 4;



--The Gold Star Customers
USE AdventureWorks2016;
GO


--Step 1: Write aggregate query
SELECT		SUM(TotalDue)	AS TotalSales,
			CustomerID
FROM		Sales.SalesOrderHeader
WHERE		OrderDate	>= '2014-01-01'
AND			OrderDate			< '2015-01-01'
GROUP BY	CustomerID;






--Step 2: Move Query to CTE and add NTILE
WITH Sales
AS
(
	SELECT		SUM(TotalDue)	AS TotalSales,
				CustomerID
	FROM		Sales.SalesOrderHeader
	WHERE		OrderDate	>= '2014-01-01'
	AND			OrderDate			< '2015-01-01'
	GROUP BY	CustomerID
)
SELECT		TotalSales,
			CustomerID,
			NTILE(4) OVER (ORDER BY TotalSales) AS Bucket
FROM		Sales
ORDER BY	customerid;





--Step 3: Add Gold Star logic
WITH Sales
AS
(
	SELECT		SUM(TotalDue)	AS TotalSales,
				CustomerID
	FROM		Sales.SalesOrderHeader
	WHERE		OrderDate	>= '2014-01-01'
	AND			OrderDate			< '2015-01-01'
	GROUP BY	CustomerID
),
	Buckets
AS
(
	SELECT	TotalSales,
			CustomerID,
			NTILE(4) OVER (ORDER BY TotalSales) AS Bucket
	FROM	Sales
)
SELECT	TotalSales,
		CustomerID,
		CHOOSE(Bucket, 'No star', 'Bronze Star', 'Silver Star', 'Gold Star') AS CustomerCategory
FROM	Buckets;

-- gleich wie oben, jedoch ohne CTE
SELECT		SUM(TotalDue)																							AS TotalSales,
			CustomerID,
			CHOOSE(NTILE(4) OVER (ORDER BY SUM(TotalDue)), 'No star', 'Bronze Star', 'Silver Star', 'Gold Star') AS CustomerCategory
FROM		Sales.SalesOrderHeader
WHERE		OrderDate	>= '2014-01-01'
AND			OrderDate			< '2015-01-01'
GROUP BY	CustomerID;
