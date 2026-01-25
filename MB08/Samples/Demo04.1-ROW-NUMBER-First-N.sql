USE AdventureWorks2022

;WITH FirstN
AS
(
	SELECT	sod.ProductID,
			soh.SalesOrderID,
			OrderDate				= FORMAT(soh.OrderDate, 'yyyy-MM-dd'),
			RowNo					= ROW_NUMBER() OVER (PARTITION BY sod.ProductID ORDER BY soh.SalesOrderID)
	FROM	Sales.SalesOrderHeader	AS soh
			INNER JOIN
			Sales.SalesOrderDetail	AS sod
				ON soh.SalesOrderID	= sod.SalesOrderID
	WHERE	soh.OrderDate			>= '2011-01-01'
	  AND	soh.OrderDate			< '2012-01-01'
)
SELECT	f.ProductID,
		f.SalesOrderID,
		f.OrderDate
FROM	FirstN AS f
WHERE	f.RowNo <= 4
--ORDER BY f.ProductID, f.SalesOrderID, f.OrderDate;



SELECT	sod.ProductID,
		soh.SalesOrderID,
		--soh.OrderDate
		COUNT(*)
FROM	Sales.SalesOrderHeader	AS soh
		JOIN
		Sales.SalesOrderDetail	AS sod
			ON soh.SalesOrderID	= sod.SalesOrderID
WHERE	soh.OrderDate			>= '2011-01-01'
  AND	soh.OrderDate			< '2012-01-01'
GROUP BY sod.ProductID,
		 soh.SalesOrderID
--HAVING COUNT(*) > 1
		-- soh.OrderDate;
ORDER BY sod.ProductID