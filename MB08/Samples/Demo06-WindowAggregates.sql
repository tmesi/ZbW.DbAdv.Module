USE AdventureWorks2022;
GO

SELECT	ProductID				= p.ProductID,
		[name]					= p.[name],
		FinishedGoodsFlag		= p.FinishedGoodsFlag
FROM	Production.[Product]	AS p;


--Need a list of products and average list price
SELECT	ProductID				= p.ProductID,
		[name]					= p.[name],
		ListPrice				= p.ListPrice,
		CountOfProduct			= COUNT(*),
		AvgListPrice			= AVG(p.ListPrice)
FROM	Production.[Product]	AS p
WHERE	FinishedGoodsFlag		= 1;

--Add a group by
SELECT	ProductID				= p.ProductID,
		[name]					= p.[name],
		ListPrice				= p.ListPrice,
		CountOfProduct			= COUNT(*),
		AvgListPrice			= AVG(p.ListPrice)
FROM	Production.[Product]	AS p
WHERE	FinishedGoodsFlag		= 1
GROUP BY	ProductID,
			[name],
			ListPrice;

--Add OVER clause instead
SELECT	ProductID				= p.ProductID,
		[name]					= p.[name],
		ListPrice				= p.ListPrice,
		CountOfProduct			= COUNT(*) OVER (),
		AvgListPrice			= AVG(ListPrice) OVER ()
FROM	Production.[Product]	AS p
WHERE	FinishedGoodsFlag		= 1

--Need subtotals by category
--Join to get categories
SELECT	ProductID						= p.ProductID,
		ProductName						= p.[name],
		CategoryName					= c.[name],
		ListPrice						= p.ListPrice,
		CountOfProduct					= COUNT(*) OVER (),
		AvgListPrice					= AVG(p.ListPrice) OVER ()
FROM	Production.[Product]			AS p
		INNER JOIN
		Production.ProductSubcategory	AS s
			ON	s.ProductSubcategoryID	= p.ProductSubcategoryID
		INNER JOIN
		Production.ProductCategory		AS c
			ON	c.ProductCategoryID		= s.ProductCategoryID
WHERE	p.FinishedGoodsFlag				= 1;



--Partition by ProductCategoryID
SELECT	ProductID						= p.ProductID,
		ProductName						= p.[name],
		CategoryName					= c.[name],
		ListPrice						= p.ListPrice,
		CountOfProduct					= COUNT(*) OVER (PARTITION BY C.ProductCategoryID),
		AvgListPrice					= AVG(ListPrice) OVER (PARTITION BY C.ProductCategoryID)
FROM	Production.[Product]			AS p
		INNER JOIN
		Production.ProductSubcategory	AS s
			ON	s.ProductSubcategoryID	= p.ProductSubcategoryID
		INNER JOIN
		Production.ProductCategory		AS c
			ON	c.ProductCategoryID		= s.ProductCategoryID
WHERE	p.FinishedGoodsFlag				= 1;



--Mix windows
SELECT	ProductID						= p.ProductID,
		ProductName						= p.[name],
		CategoryName					= c.[name],
		ListPrice						= p.ListPrice,
		CountOfProduct					= COUNT(*) OVER (PARTITION BY C.ProductCategoryID),
		AvgListPrice					= AVG(ListPrice) OVER (PARTITION BY C.ProductCategoryID),
		MinListPrice					= MIN(ListPrice) OVER (),
		MaxListPrice					= MAX(ListPrice) OVER ()
FROM	Production.[Product]			AS p
		INNER JOIN
		Production.ProductSubcategory	AS s
			ON	s.ProductSubcategoryID	= p.ProductSubcategoryID
		INNER JOIN
		Production.ProductCategory		AS c
			ON	c.ProductCategoryID		= s.ProductCategoryID
WHERE	p.FinishedGoodsFlag				= 1;


