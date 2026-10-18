USE AdventureWorks2022;

SELECT		sod.SalesOrderId,
			sod.SalesOrderDetailID,
			sod.LineTotal,
			RunningTotal		 = SUM(LineTotal) OVER (ORDER BY SalesOrderDetailID 
														/*ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW*/) 
FROM		Sales.SalesOrderDetail	AS sod
WHERE		sod.SalesOrderId		= 43659
ORDER BY	sod.SalesOrderDetailID;

/*
SELECT		soh.OrderDate,
			sod.SalesOrderId,
			sod.LineTotal,
			ROW_NUMBER() OVER (ORDER BY soh.OrderDate),
			RANK() OVER (ORDER BY soh.OrderDate)
FROM		Sales.SalesOrderDetail	AS sod
			INNER JOIN
			Sales.SalesOrderHeader AS soh
				ON soh.SalesOrderID = sod.SalesOrderID
ORDER BY	sod.SalesOrderDetailID;
*/
