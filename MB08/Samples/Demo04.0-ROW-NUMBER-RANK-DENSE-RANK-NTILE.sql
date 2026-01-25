USE AdventureWorks2022;
GO

--Compare ROW_NUMBER, RANK, and DENSE_RANK
SELECT		ProductID					= sod.ProductID,
			SalesOrderID				= soh.SalesOrderID,
			OrderDate					= FORMAT(soh.OrderDate, 'yyyy-MM-dd'),
			RowNum						= ROW_NUMBER()	OVER (PARTITION BY sod.ProductID ORDER BY soh.SalesOrderID),
			[Rank]						= RANK()		OVER (PARTITION BY sod.ProductID ORDER BY sod.SalesOrderID),
			[DenseRank]					= DENSE_RANK()	OVER (PARTITION BY sod.ProductID ORDER BY soh.SalesOrderID)
FROM		Sales.SalesOrderHeader		AS soh
			INNER JOIN
			Sales.SalesOrderDetail		AS sod
				ON	soh.SalesOrderID	= sod.SalesOrderID
WHERE		sod.ProductID				BETWEEN	710 AND 720
ORDER BY	sod.ProductID,
			soh.SalesOrderID;


--Non-unique ORDER BY
SELECT		ProductID					= sod.ProductID,
			SalesOrderID				= soh.SalesOrderID,
			OrderDate					= FORMAT(soh.OrderDate, 'yyyy-MM-dd'),
			RowNum						= ROW_NUMBER()	OVER (PARTITION BY sod.ProductID ORDER BY soh.OrderDate),
			[Rank]						= RANK()		OVER (PARTITION BY sod.ProductID ORDER BY soh.OrderDate),
			[DenseRank]					= DENSE_RANK()	OVER (PARTITION BY sod.ProductID ORDER BY soh.OrderDate)
FROM		Sales.SalesOrderHeader		AS soh
			INNER JOIN
			Sales.SalesOrderDetail		AS sod
				ON soh.SalesOrderID		= sod.SalesOrderID
WHERE		sod.ProductID				BETWEEN	710 AND 720
ORDER BY	sod.ProductID,
			soh.OrderDate;



--NTILE
WITH Sales
AS
(
	SELECT		ProductID					= sod.ProductID,
				OrderCount					= COUNT(*)
	FROM		Sales.SalesOrderHeader		AS soh
				INNER JOIN
				Sales.SalesOrderDetail		AS sod
					ON	soh.SalesOrderID	= sod.SalesOrderID
	GROUP BY	sod.ProductID
)
SELECT	ProductID	= s.ProductID,
		OrderCount	= s.OrderCount,
		Bucket		= NTILE(10) OVER (ORDER BY s.OrderCount) 
FROM	Sales		AS s;

