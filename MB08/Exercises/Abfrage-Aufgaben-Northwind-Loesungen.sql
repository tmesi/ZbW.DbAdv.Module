USE [Northwind]

/*	Hinweis:
	Die bereitgestellten Lösungen sind als Musterlösungen zu verstehen.
	Es gibt in der Regel mehrere korrekte Varianten, um eine Abfrage umzusetzen.
*/

/*
	1. INNER JOIN

	Aufgabe:
	Gib alle Bestellungen aus und zeige dazu den Firmennamen des Kunden sowie das Bestelldatum an.
*/
SELECT	o.OrderID,
		c.CompanyName,
		o.OrderDate
FROM	dbo.Orders		AS o
		INNER JOIN
		dbo.Customers	AS c
			ON o.CustomerID = c.CustomerID;


/*
2. INNER JOIN + WHERE

Aufgabe:
Zeige alle Bestellungen aus dem Jahr 1997 an, inklusive Kundenname und vollständigem Namen des Mitarbeiters.
*/
SELECT		c.CompanyName,
			c.ContactName,
			EmployeeFullName	= CONCAT(e.FirstName, ' ', e.LastName),
			o.OrderDate
FROM		dbo.Orders			AS o
			INNER JOIN
			dbo.Customers		AS c
				ON c.CustomerID	= o.CustomerID
			INNER JOIN
			dbo.Employees		AS e
				ON e.EmployeeID	= o.EmployeeID
WHERE		--YEAR(o.OrderDate)		IN (1997) -- auch eine Möglichkeit
			o.OrderDate			BETWEEN	'1997-01-01' AND '1997-12-31'
ORDER BY	c.CompanyName;


/*
3. INNER JOIN (mehrere Tabellen)

Aufgabe:
Zeige für alle Bestellpositionen die Bestellnummer, den Produktnamen, die Menge und den Einzelpreis an.
*/
SELECT		o.OrderID,
			p.ProductName,
			od.Quantity,
			od.UnitPrice
FROM		dbo.Orders			AS o
			INNER JOIN
			dbo.[Order Details] AS od
				ON od.OrderID = o.OrderID
			INNER JOIN
			dbo.Products		AS p
				ON p.ProductID = od.ProductID
ORDER BY	o.OrderID;


/*
4. LEFT JOIN (fehlende Datensätze erkennen)

Aufgabe:
Liste alle Kunden und deren Bestellungen auf. Kunden ohne Bestellungen sollen ebenfalls erscheinen.
*/
SELECT		c.CompanyName,
			o.OrderDate
FROM		dbo.Customers	AS c
			LEFT JOIN
			dbo.Orders		AS o
				ON o.CustomerID = C.CustomerID
ORDER BY	C.CompanyName;


/*
5. LEFT JOIN + WHERE (NULL-Filterung)

Aufgabe:
Ermittle alle Kunden, die noch nie eine Bestellung aufgegeben haben.
*/
SELECT		c.CustomerID,
			c.CompanyName,
			o.OrderDate
FROM		dbo.Customers	AS c
			LEFT JOIN
			dbo.Orders		AS o
				ON o.CustomerID = c.CustomerID
WHERE		o.OrderID IS NULL
ORDER BY	c.CustomerID, c.CompanyName;


/*
6. LEFT JOIN mit Aggregation

Aufgabe:
Zeige für jeden Kunden die Anzahl seiner Bestellungen an – auch Kunden ohne Bestellungen.
*/
SELECT		c.CompanyName,
			COUNT(o.OrderDate)
FROM		dbo.Customers	AS c
			LEFT JOIN
			dbo.Orders		AS o
				ON o.CustomerID = c.CustomerID
GROUP BY	c.CompanyName
ORDER BY	c.CompanyName;

/*
7. FULL OUTER JOIN

Aufgabe:
Erstelle eine Ergebnismenge, die alle Kunden und alle Bestellungen enthält – auch wenn auf einer Seite kein entsprechender Datensatz existiert.
*/
SELECT		c.CompanyName,
			o.OrderDate
FROM		dbo.Customers	AS c
			FULL OUTER JOIN
			dbo.Orders		AS o
				ON o.CustomerID = c.CustomerID
ORDER BY	c.CompanyName;


/*
8. FULL OUTER JOIN + WHERE

Aufgabe:
Identifiziere Kunden ohne Bestellungen sowie Bestellungen ohne zugeordneten Kunden (Datenintegritätsprüfung).
*/
SELECT		c.CompanyName,
			o.OrderDate
FROM		dbo.Customers	AS c
			FULL OUTER JOIN
			dbo.Orders		AS o
				ON o.CustomerID = c.CustomerID
WHERE		c.CompanyName IS NULL
OR			o.OrderID IS NULL
ORDER BY	c.CompanyName;


/*
9. CROSS JOIN

Aufgabe:
Erzeuge alle möglichen Kombinationen von Produkten und Versandfirmen.
*/
SELECT	p.ProductID,
		p.ProductName,
		s.ShipperID,
		s.CompanyName
FROM	dbo.Products			AS p
		CROSS JOIN dbo.Shippers AS s;


/*
10. CROSS JOIN mit WHERE

Aufgabe:
Erstelle eine Preissimulation, bei der alle Produkte mit Rabattstufen von 5 %, 10 % und 15 % kombiniert werden.
*/
SELECT		p.ProductID,
			p.ProductName,
			p.UnitPrice,
			d.DiscountRate,
			DiscountedPrice					= CAST(p.UnitPrice * (1 - d.DiscountRate) AS DECIMAL(10,2))
FROM		dbo.Products					AS p
			CROSS JOIN 
			(
				SELECT DiscountRate	= 0.05
				UNION
				SELECT DiscountRate	= 0.10
				UNION
				SELECT DiscountRate = 0.15
			)								AS d


/*
11. GROUP BY (einfache Aggregation)

Aufgabe:
Berechne den Gesamtumsatz pro Bestellung.
*/
SELECT		od.OrderID,
			SUM(od.UnitPrice)
FROM		dbo.[Order Details] AS od
GROUP BY	od.OrderID;



/*
12. GROUP BY mit mehreren Aggregaten

Aufgabe:
Zeige pro Produkt die verkaufte Gesamtmenge, den durchschnittlichen Einzelpreis und den Gesamtumsatz an.
*/
SELECT		p.ProductID,
			TotalQuantity		= SUM(od.Quantity),
			AverageUnitPrice	= AVG(od.UnitPrice),
			RevenuePerProduct	= SUM(CAST((od.UnitPrice * od.Quantity) * (1 - od.Discount) AS DECIMAL(10, 2)))
FROM		dbo.[Order Details] AS od
			INNER JOIN
			dbo.Products		AS p
				ON p.ProductID = od.ProductID
GROUP BY	p.ProductID
ORDER BY	p.ProductID;


/*
13. GROUP BY + HAVING

Aufgabe:
Liste alle Kunden auf, die mehr als 10 Bestellungen aufgegeben haben.
*/
SELECT		c.CustomerID,
			OrderCount	= COUNT(o.OrderID)
FROM		dbo.Customers	AS c
			INNER JOIN
			dbo.Orders		AS o
				ON o.CustomerID = c.CustomerID
GROUP BY	c.CustomerID
HAVING		COUNT(o.OrderID) > 10
ORDER BY	COUNT(o.OrderID) DESC;


/*
14. GROUP BY mit Datumslogik

Aufgabe:
Zeige den Gesamtumsatz pro Jahr an.
*/
SELECT		TotalSales	= SUM(CAST((od.UnitPrice * od.Quantity) * (1 - od.Discount) AS DECIMAL(10, 2))),
			YEAR(o.OrderDate)
FROM		dbo.[Order Details] AS od
			INNER JOIN
			dbo.Orders			AS o
				ON o.OrderID = od.OrderID
GROUP BY	YEAR(o.OrderDate)
ORDER BY	YEAR(o.OrderDate);


/*
15. Skalar-Subquery

Aufgabe:
Zeige alle Produkte, deren Einzelpreis über dem durchschnittlichen Produktpreis liegt.
*/
SELECT		p.ProductName,
			p.UnitPrice
FROM		dbo.Products AS p
WHERE		p.UnitPrice > (
							SELECT		AvergageUnitPrice	= AVG(UnitPrice)
							FROM		dbo.Products AS p
						)
ORDER BY	p.UnitPrice DESC;


/*
16. Subquery in WHERE (IN)

Aufgabe:
Liste alle Kunden auf, die Produkte aus der Kategorie „Beverages“ bestellt haben.
*/
SELECT	DISTINCT
		c.CustomerID,
		c.CompanyName
FROM	dbo.Customers	AS c
		INNER JOIN
		dbo.Orders		AS o
			ON c.CustomerID = o.CustomerID
WHERE	o.OrderID IN
		(
			SELECT	od.OrderID
			FROM	dbo.[Order Details]	AS od
					INNER JOIN
					dbo.Products		AS p
						ON od.ProductID	= p.ProductID
					INNER JOIN
					dbo.Categories		AS cat
						ON p.CategoryID	= cat.CategoryID
			WHERE	cat.CategoryName	= 'Beverages'
		);



/*
17. Korrelierte Subquery

Aufgabe:
Zeige alle Mitarbeiter, die mehr Bestellungen bearbeitet haben als der durchschnittliche Mitarbeiter.
*/
SELECT	e.EmployeeID,
		e.FirstName,
		e.LastName
FROM	dbo.Employees e
WHERE	(
			SELECT	COUNT(*)
			FROM	dbo.Orders		AS o
			WHERE	o.EmployeeID	= e.EmployeeID
		) > (
				SELECT	AVG(OrderCount)
				FROM	(
							SELECT		OrderCount = COUNT(*) 
							FROM		dbo.Orders
							GROUP BY	EmployeeID
						)	AS x
			);


/*
18. Einfache CTE

Aufgabe:
Berechne mit einer CTE den Gesamtumsatz pro Bestellung und zeige nur Bestellungen mit einem Umsatz über 10’000 an.
*/
WITH OrderTotals
AS
(
	SELECT		OrderID,
				TotalAmount	= SUM(UnitPrice * Quantity)
	FROM		dbo.[Order Details]
	GROUP BY	OrderID
)
SELECT	ot.OrderID,
		ot.TotalAmount
FROM	OrderTotals	AS ot
WHERE	TotalAmount > 10000;


/*
19. CTE mit JOIN

Aufgabe:
Berechne den Gesamtumsatz pro Kunde mithilfe einer CTE und verbinde das Ergebnis mit der Kundentabelle.
*/
WITH CustomerSales
AS
(
	SELECT		o.CustomerID,
				TotalSales			= SUM(od.UnitPrice * od.Quantity) 
	FROM		dbo.Orders			AS o
				INNER JOIN
				dbo.[Order Details]	AS od
					ON o.OrderID	= od.OrderID
	GROUP BY	o.CustomerID
)
SELECT	c.CustomerID,
		c.CompanyName,
		cs.TotalSales
FROM	CustomerSales			AS cs
		INNER JOIN
		dbo.Customers			AS c
			ON cs.CustomerID	= c.CustomerID;


/*
20. CTE + GROUP BY + HAVING

Aufgabe:
Erstelle eine CTE, die den Absatz pro Produkt aggregiert, und gib nur Produkte aus, von denen mehr als 1’000 Stück verkauft wurden.
*/
WITH ProductSales
AS
(
	SELECT		p.ProductID,
				p.ProductName,
				TotalUnits			= SUM(od.Quantity)
	FROM		dbo.Products		AS p
				INNER JOIN
				dbo.[Order Details]	AS od
					ON p.ProductID	= od.ProductID
	GROUP BY	p.ProductID,
				p.ProductName
)
SELECT	*
FROM	ProductSales
WHERE	TotalUnits > 1000;