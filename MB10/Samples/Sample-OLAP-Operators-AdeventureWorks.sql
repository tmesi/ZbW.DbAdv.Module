USE AdventureWorksDW2022

SELECT		d.CalendarYear,
			p.EnglishProductName,
			t.SalesTerritoryCountry,
			TotalSales							= SUM(f.SalesAmount)
FROM		dbo.FactInternetSales				AS f
			INNER JOIN
			dbo.DimDate							AS d
				ON f.OrderDateKey				= d.DateKey
			INNER JOIN
			dbo.DimProduct						AS p
				ON f.ProductKey					= p.ProductKey
			INNER JOIN
			dbo.DimProductSubcategory			AS ps
				ON p.ProductSubcategoryKey		= ps.ProductSubcategoryKey
			INNER JOIN
			dbo.DimProductCategory				AS pc
				ON ps.ProductCategoryKey		= pc.ProductCategoryKey
			INNER JOIN
			dbo.DimSalesTerritory				AS t
				ON f.SalesTerritoryKey			= t.SalesTerritoryKey
GROUP BY	d.CalendarYear,
			p.EnglishProductName,
			t.SalesTerritoryCountry
ORDER BY d.CalendarYear, p.EnglishProductName, t.SalesTerritoryCountry;


/* ROLLUP

Year
  → Category
    → Country

ROLLUP erzeugt:

1. Year + Category + Country
2. Year + Category
3. Year
4. Grand Total

NULL bedeutet hier: „Aggregationsebene“

*/
SELECT		d.CalendarYear,
			p.EnglishProductName,
			t.SalesTerritoryCountry,
			TotalSales							= SUM(f.SalesAmount)
FROM		dbo.FactInternetSales				AS f
			INNER JOIN
			dbo.DimDate							AS d
				ON f.OrderDateKey				= d.DateKey
			INNER JOIN
			dbo.DimProduct						AS p
				ON f.ProductKey					= p.ProductKey
			INNER JOIN
			dbo.DimProductSubcategory			AS ps
				ON p.ProductSubcategoryKey		= ps.ProductSubcategoryKey
			INNER JOIN
			dbo.DimProductCategory				AS pc
				ON ps.ProductCategoryKey		= pc.ProductCategoryKey
			INNER JOIN
			dbo.DimSalesTerritory				AS t
				ON f.SalesTerritoryKey			= t.SalesTerritoryKey
GROUP BY	ROLLUP (
				d.CalendarYear,
				p.EnglishProductName,
				t.SalesTerritoryCountry
			);

/* CUBE

Für 3 Dimensionen:

2³ = 8 Kombinationen:

1. Year, Category, Country
2. Year, Category
3. Year, Country
4. Category, Country
5. Year
6. Category
7. Country
8. Grand Total

*/
SELECT		d.CalendarYear,
			p.EnglishProductName,
			t.SalesTerritoryCountry,
			TotalSales							= SUM(f.SalesAmount)
FROM		dbo.FactInternetSales				AS f
			INNER JOIN
			dbo.DimDate							AS d
				ON f.OrderDateKey				= d.DateKey
			INNER JOIN
			dbo.DimProduct						AS p
				ON f.ProductKey					= p.ProductKey
			INNER JOIN
			dbo.DimProductSubcategory			AS ps
				ON p.ProductSubcategoryKey		= ps.ProductSubcategoryKey
			INNER JOIN
			dbo.DimProductCategory				AS pc
				ON ps.ProductCategoryKey		= pc.ProductCategoryKey
			INNER JOIN
			dbo.DimSalesTerritory				AS t
				ON f.SalesTerritoryKey			= t.SalesTerritoryKey
GROUP BY	CUBE (
				d.CalendarYear,
				p.EnglishProductName,
				t.SalesTerritoryCountry
			);


/* GROUPING SETS

Detail
Jahr-Total
Kategorie-Total
Grand Total

*/
SELECT		d.CalendarYear,
			p.EnglishProductName,
			t.SalesTerritoryCountry,
			TotalSales							= SUM(f.SalesAmount)
FROM		dbo.FactInternetSales				AS f
			INNER JOIN
			dbo.DimDate							AS d
				ON f.OrderDateKey				= d.DateKey
			INNER JOIN
			dbo.DimProduct						AS p
				ON f.ProductKey					= p.ProductKey
			INNER JOIN
			dbo.DimProductSubcategory			AS ps
				ON p.ProductSubcategoryKey		= ps.ProductSubcategoryKey
			INNER JOIN
			dbo.DimProductCategory				AS pc
				ON ps.ProductCategoryKey		= pc.ProductCategoryKey
			INNER JOIN
			dbo.DimSalesTerritory				AS t
				ON f.SalesTerritoryKey			= t.SalesTerritoryKey
GROUP BY	GROUPING SETS (
				(d.CalendarYear, p.EnglishProductName, t.SalesTerritoryCountry),
				(d.CalendarYear),
				(p.EnglishProductName),
				()
			);