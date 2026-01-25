USE AdventureWorks2022;

SELECT		sod.SalesOrderId,
			sod.SalesOrderDetailID,
			sod.LineTotal,
			RunningTotal		 = SUM(LineTotal) OVER (ORDER BY SalesOrderDetailID 
														ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
FROM		Sales.SalesOrderDetail	AS sod
WHERE		sod.SalesOrderId		= 43659
ORDER BY	sod.SalesOrderDetailID;
