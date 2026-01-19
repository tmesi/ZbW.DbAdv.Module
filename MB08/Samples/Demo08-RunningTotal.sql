USE AdventureWorks2022;

SELECT		SalesOrderId,
			SalesOrderDetailID,
			LineTotal,
			SUM(LineTotal) OVER (ORDER BY SalesOrderDetailID
								ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
								)	AS RunningTotal
FROM		Sales.SalesOrderDetail
WHERE		SalesOrderId = 43659
ORDER BY	SalesOrderDetailID;
