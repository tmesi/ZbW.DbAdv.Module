use Northwind;


SET STATISTICS IO ON;
GO
SET STATISTICS TIME ON;
GO

SELECT	CustomerID				= c.CustomerID,
		OrderID					= o.OrderID,
		RowN					= ROW_NUMBER() OVER (PARTITION BY c.CustomerID ORDER BY o.OrderDate DESC)
FROM	dbo.Customers			AS c
		INNER JOIN
		dbo.Orders				AS o
			ON	o.CustomerID	= c.CustomerID;

SET STATISTICS IO OFF;
GO
SET STATISTICS TIME OFF;
GO