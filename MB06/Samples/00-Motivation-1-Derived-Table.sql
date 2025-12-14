USE Northwind;

-- ohne CTE
BEGIN TRANSACTION;

-- Damit der Delete kein Fehler erzeugt
-- wird unten mit dem Rollback auch wieder hergestellt.
DELETE	FROM [Order Details];

DELETE	FROM dbo.Orders
FROM	dbo.Orders	o
		INNER JOIN
		(
			SELECT	CustomerID			= c.CustomerID,
					OrderID				= o.OrderID,
					RowN				= ROW_NUMBER() OVER (PARTITION BY c.CustomerID ORDER BY o.OrderDate DESC)
			FROM	dbo.Customers		AS c
					INNER JOIN
					dbo.Orders			AS o
						ON o.CustomerID	= c.CustomerID
		)					AS co
			ON	o.OrderID	= co.OrderID
WHERE	co.RowN			> 1
  AND	co.CustomerID	= 'VINET';


-- VINET hat 5 Bestellungen - jetzt noch eine
SELECT	*
FROM	dbo.Customers		AS c
		INNER JOIN
		dbo.Orders			AS o
			ON o.CustomerID	= c.CustomerID
WHERE	c.CustomerID		= 'VINET';

ROLLBACK;


-- mit CTE
BEGIN TRANSACTION;

-- Damit der Delete kein Fehler erzeugt
-- wird unten mit dem Rollback auch wieder hergestellt.
DELETE	FROM [Order Details];

;WITH CustomerOrders
AS
(
	SELECT	CustomerID				= c.CustomerID,
			OrderID					= o.OrderID,
			RowN					= ROW_NUMBER() OVER (PARTITION BY c.CustomerID ORDER BY o.OrderDate DESC)
	FROM	dbo.Customers			AS c
			INNER JOIN
			dbo.Orders				AS o
				ON	o.CustomerID	= c.CustomerID
)
--SELECT * 
DELETE	FROM dbo.Orders
FROM	dbo.Orders			AS o
		INNER JOIN
		CustomerOrders		AS co
			ON	o.OrderID	= co.OrderID
WHERE	co.RowN				> 1
AND		co.CustomerID		= 'VINET';

-- VINET hat 5 Bestellungen - jetzt noch eine
SELECT	*
FROM	dbo.Customers		AS c
		INNER JOIN
		dbo.Orders			AS o
			ON o.CustomerID	= c.CustomerID
WHERE	c.CustomerID		= 'VINET';

ROLLBACK;