-- Beispielabfrage
SELECT      TOP (5)
            CompanyName				= c.CompanyName,
			Sales					= SUM(od.UnitPrice * od.Quantity)
FROM        dbo.Customers			AS c
			INNER JOIN
			dbo.Orders				AS o
				ON	c.CustomerID	= o.CustomerID
			INNER JOIN
			dbo.[Order Details]		AS od
				ON	o.OrderID		= od.OrderID
WHERE       o.OrderDate				>= '1997-01-01'
GROUP BY    c.CompanyName
HAVING      SUM(od.UnitPrice * od.Quantity) > 10000
ORDER BY    Sales DESC;

-- Bestellungen eines Kunden
SELECT		CustomerID				= c.CustomerID,
			CompanyName				= c.CompanyName,
			OrderID					= o.OrderID,
			OrderDate				= o.OrderDate
FROM        dbo.Customers			AS c
			INNER JOIN
			dbo.Orders				AS o
				ON	c.CustomerID	= o.CustomerID
WHERE		c.CustomerID			= 'QUICK'
ORDER BY	o.OrderDate DESC;

-- Gruppierung der Kunden
SELECT		CompanyName				= c.CompanyName,
			OrderCount				= COUNT(o.OrderID)
FROM        dbo.Customers			AS c
			INNER JOIN
			dbo.Orders				AS o
				ON	c.CustomerID	= o.CustomerID
GROUP BY	c.CompanyName
ORDER BY	OrderCount DESC;
