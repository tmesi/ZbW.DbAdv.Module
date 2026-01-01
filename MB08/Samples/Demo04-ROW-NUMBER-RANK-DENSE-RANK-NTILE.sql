USE AdventureWorks2016;
GO

--Compare ROW_NUMBER, RANK, and DENSE_RANK
SELECT		SOD.ProductID,
			SOH.SalesOrderID,
			FORMAT(SOH.OrderDate, 'yyyy-MM-dd') AS OrderDate,
			ROW_NUMBER() OVER (PARTITION BY SOD.ProductID
							ORDER BY SOH.SalesOrderID
							)				AS RowNum,
			RANK() OVER (PARTITION BY SOD.ProductID
						ORDER BY SOD.SalesOrderID
						)						AS [Rank],
			DENSE_RANK() OVER (PARTITION BY SOD.ProductID
							ORDER BY SOH.SalesOrderID
							)				AS [DenseRank]
FROM		Sales.SalesOrderHeader	SOH
			JOIN
			Sales.SalesOrderDetail	SOD
				ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE		SOD.ProductID
BETWEEN		710 AND 720
ORDER BY	SOD.ProductID,
			SOH.SalesOrderID;


--Non-unique ORDER BY
SELECT		SOD.ProductID,
			SOH.SalesOrderID,
			FORMAT(SOH.OrderDate, 'yyyy-MM-dd') AS OrderDate,
			ROW_NUMBER() OVER (PARTITION BY SOD.ProductID
							ORDER BY SOH.OrderDate
							)				AS RowNum,
			RANK() OVER (PARTITION BY SOD.ProductID
						ORDER BY SOH.OrderDate
						)						AS [Rank],
			DENSE_RANK() OVER (PARTITION BY SOD.ProductID
							ORDER BY SOH.OrderDate
							)				AS [DenseRank]
FROM		Sales.SalesOrderHeader	SOH
			JOIN
			Sales.SalesOrderDetail	SOD
				ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE		SOD.ProductID
BETWEEN		710 AND 720
ORDER BY	SOD.ProductID,
			SOH.OrderDate;



--NTILE
WITH Sales
AS
(
	SELECT		SOD.ProductID,
				COUNT(*)	AS OrderCount
	FROM		Sales.SalesOrderHeader	SOH
				JOIN
				Sales.SalesOrderDetail	SOD
					ON SOH.SalesOrderID = SOD.SalesOrderID
	GROUP BY	SOD.ProductID
)
SELECT	ProductID,
		OrderCount,
		NTILE(10) OVER (ORDER BY OrderCount) AS Bucket
FROM	Sales;

