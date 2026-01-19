USE AdventureWorks2022;
GO

--Use ROW_NUMBER() to demonstrate OVER
--**ORDER BY
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (PARTITION BY customerid
						ORDER BY CustomerID
						) AS RowNumber
FROM	Sales.SalesOrderHeader
WHERE	salesorderid < 50000;






--Different ORDER BY for query
SELECT		CustomerID,
			SalesOrderID,
			OrderDate,
			ROW_NUMBER() OVER (ORDER BY CustomerID) AS RowNumber
FROM		Sales.SalesOrderHeader
ORDER BY	SalesOrderID;

--Change the ORDER BY
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (ORDER BY OrderDate DESC) AS RowNumber
FROM	Sales.SalesOrderHeader;

--Use two columns
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (ORDER BY CustomerID,
									OrderDate DESC
						) AS RowNumber
FROM	Sales.SalesOrderHeader;

--An expression. Even CustomerIDs show up before Odd
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (ORDER BY CustomerID % 2) AS RowNumber
FROM	Sales.SalesOrderHeader;

--Random
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (ORDER BY NEWID()) AS RowNumber
FROM	Sales.SalesOrderHeader;

--A Subquery
-- SELECT 1 is constant -> ROW_NUMBER() will be applied in the clustered index key order
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (ORDER BY (
										SELECT	1
									)
						) AS RowNumber
FROM	Sales.SalesOrderHeader;



--**PARTITION BY
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (PARTITION BY CustomerID
						ORDER BY SalesOrderID
						) AS RowNumber
FROM	Sales.SalesOrderHeader;

--Multiple columns
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (PARTITION BY OrderDate,
										CustomerID
						ORDER BY SalesOrderID
						) AS RowNumber
FROM	Sales.SalesOrderHeader;

--An expression
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (PARTITION BY CustomerID % 2
						ORDER BY SalesOrderID
						) AS RowNumber
FROM	Sales.SalesOrderHeader;

--A subquery
-- SELECT 1 is constant -> one big Partition - the same as without PARTITION
SELECT	CustomerID,
		SalesOrderID,
		OrderDate,
		ROW_NUMBER() OVER (PARTITION BY (
											SELECT	1
										)
						ORDER BY SalesOrderID
						) AS RowNumber
FROM	Sales.SalesOrderHeader;







