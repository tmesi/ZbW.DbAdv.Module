USE AdventureWorks2022;
GO

--Compare ROW_NUMBER, RANK, and DENSE_RANK
SELECT		sod.ProductID,
			soh.SalesOrderID,
			FORMAT(soh.OrderDate, 'yyyy-MM-dd') AS OrderDate,
			ROW_NUMBER() OVER (PARTITION BY sod.ProductID
							ORDER BY soh.SalesOrderID
							)				AS RowNum,
			RANK() OVER (PARTITION BY sod.ProductID
						ORDER BY sod.SalesOrderID
						)						AS [Rank],
			DENSE_RANK() OVER (PARTITION BY sod.ProductID
							ORDER BY soh.SalesOrderID
							)				AS [DenseRank]
FROM		Sales.SalesOrderHeader	AS soh
			JOIN
			Sales.SalesOrderDetail	AS sod
				ON soh.SalesOrderID = sod.SalesOrderID
WHERE		sod.ProductID	BETWEEN	710 AND 720
ORDER BY	sod.ProductID,
			soh.SalesOrderID;


--Non-unique ORDER BY
SELECT		sod.ProductID,
			soh.SalesOrderID,
			FORMAT(soh.OrderDate, 'yyyy-MM-dd') AS OrderDate,
			ROW_NUMBER() OVER (PARTITION BY sod.ProductID
							ORDER BY soh.OrderDate
							)				AS RowNum,
			RANK() OVER (PARTITION BY sod.ProductID
						ORDER BY soh.OrderDate
						)						AS [Rank],
			DENSE_RANK() OVER (PARTITION BY sod.ProductID
							ORDER BY soh.OrderDate
							)				AS [DenseRank]
FROM		Sales.SalesOrderHeader	soh
			JOIN
			Sales.SalesOrderDetail	sod
				ON soh.SalesOrderID = sod.SalesOrderID
WHERE		sod.ProductID
BETWEEN		710 AND 720
ORDER BY	sod.ProductID,
			soh.OrderDate;



--NTILE
WITH Sales
AS
(
	SELECT		sod.ProductID,
				COUNT(*)	AS OrderCount
	FROM		Sales.SalesOrderHeader	soh
				JOIN
				Sales.SalesOrderDetail	sod
					ON soh.SalesOrderID = sod.SalesOrderID
	GROUP BY	sod.ProductID
)
SELECT	ProductID,
		OrderCount,
		NTILE(10) OVER (ORDER BY OrderCount) AS Bucket
FROM	Sales;

