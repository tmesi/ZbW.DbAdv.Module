USE AdventureWorks2022;

-- ohne CTE - mit Derived Tables
SELECT		FullName			= sp.FirstName + ' ' + sp.LastName,
			City				= sp.City,
			NetSales			= ts.NetSales,
			SalesQuota			= td.SalesQuota,
			QuotaDiff			= td.QuotaDiff
FROM		Sales.vSalesPerson	AS sp
			INNER JOIN
			(
				SELECT		SalesPersonID			= soh.SalesPersonID,
							NetSales				= ROUND(SUM(soh.SubTotal), 2)
				FROM		Sales.SalesOrderHeader	AS soh
				WHERE		soh.SalesPersonID		IS NOT NULL
				  AND		soh.OrderDate			BETWEEN '2014-01-01 00:00:00.000' AND '2015-12-31 23:59:59.000'
				GROUP BY	soh.SalesPersonID
			)							AS ts
				ON	sp.BusinessEntityID	= ts.SalesPersonID

			INNER JOIN
			(
				SELECT	SalesPersonID	= ts.SalesPersonID,
						SalesQuota		= CASE WHEN sp.SalesQuota IS NULL THEN 0			ELSE sp.SalesQuota					END,
						QuotaDiff		= CASE WHEN sp.SalesQuota IS NULL THEN ts.NetSales	ELSE ts.NetSales - sp.SalesQuota	END
				FROM	(
							SELECT		SalesPersonID			= soh.SalesPersonID,
										NetSales				= ROUND(SUM(soh.SubTotal), 2) 
							FROM		Sales.SalesOrderHeader	AS soh
							WHERE		soh.SalesPersonID		IS NOT NULL
							  AND		soh.OrderDate			BETWEEN '2014-01-01 00:00:00.000' AND '2015-12-31 23:59:59.000'
							GROUP BY	soh.SalesPersonID
						)						AS ts
						INNER JOIN
						Sales.SalesPerson		AS sp
							ON ts.SalesPersonID	= sp.BusinessEntityID
			)							AS td
				ON sp.BusinessEntityID	= td.SalesPersonID
ORDER BY	ts.NetSales DESC;


-- mit CTE
-- nun gibts die Derived-Table ts nur noch 1x - zudem sind diese in der CTE und die effektive Abfrage ist viel übersichtlicher
;
WITH cteTotalSales(SalesPersonID, NetSales)
AS
(
	SELECT		SalesPersonID			= soh.SalesPersonID,
				NetSales				= ROUND(SUM(soh.SubTotal), 2)
	FROM		Sales.SalesOrderHeader	AS soh
	WHERE		soh.SalesPersonID		IS NOT NULL
	  AND		soh.OrderDate			BETWEEN '2014-01-01 00:00:00.000' AND '2015-12-31 23:59:59.000'
	GROUP BY	soh.SalesPersonID
),
	cteTargetDiff (SalesPersonID, SalesQuota, QuotaDiff)
AS
(
	SELECT	ts.SalesPersonID,
			CASE WHEN sp.SalesQuota IS NULL THEN 0				ELSE sp.SalesQuota					END,
			CASE WHEN sp.SalesQuota IS NULL THEN ts.NetSales	ELSE ts.NetSales - sp.SalesQuota	END
	FROM	cteTotalSales				AS ts
			INNER JOIN
			Sales.SalesPerson			AS sp
				ON	ts.SalesPersonID	= sp.BusinessEntityID
)
SELECT		FirstName					= sp.FirstName + ' ' + sp.LastName,
			City						= sp.City,
			NetSales					= ts.NetSales,
			SalesQuota					= td.SalesQuota,
			QuotaDiff					= td.QuotaDiff
FROM		Sales.vSalesPerson			AS sp
			INNER JOIN
			cteTotalSales				AS ts
				ON	sp.BusinessEntityID	= ts.SalesPersonID

			INNER JOIN
			cteTargetDiff				AS td
				ON sp.BusinessEntityID	= td.SalesPersonID
ORDER BY	ts.NetSales DESC;