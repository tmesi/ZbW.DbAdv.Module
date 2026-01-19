USE AdventureWorks2022;
GO

SELECT	ProductID,
		name,
		FinishedGoodsFlag
FROM	Production.Product;


--Need a list of products and average list price
SELECT	ProductID,
		name,
		ListPrice,
		COUNT(*)		CountOfProduct,
		AVG(ListPrice)	AS AvgListPrice
FROM	Production.Product
WHERE	FinishedGoodsFlag = 1;

--Add a group by
SELECT		ProductID,
			name,
			ListPrice,
			COUNT(*)		CountOfProduct,
			AVG(ListPrice)	AS AvgListPrice
FROM		Production.Product
WHERE		FinishedGoodsFlag = 1
GROUP BY	ProductID,
			name,
			ListPrice;

--Add OVER clause instead
SELECT	ProductID,
		name,
		ListPrice,
		COUNT(*) OVER ()	CountOfProduct,
		AVG(ListPrice) OVER () AS AvgListPrice
FROM	Production.Product
WHERE	FinishedGoodsFlag = 1;

--Need subtotals by category
--Join to get categories
SELECT	P.ProductID,
		P.name					AS ProductName,
		C.Name					AS CategoryName,
		ListPrice,
		COUNT(*) OVER ()	CountOfProduct,
		AVG(ListPrice) OVER () AS AvgListPrice
FROM	Production.Product				AS P
		JOIN
		Production.ProductSubcategory	AS S
			ON S.ProductSubcategoryID = P.ProductSubcategoryID

		JOIN
		Production.ProductCategory		AS C
			ON C.ProductCategoryID = S.ProductCategoryID
WHERE	FinishedGoodsFlag = 1;



--Partition by ProductCategoryID
SELECT	P.ProductID,
		P.name													AS ProductName,
		C.Name													AS CategoryName,
		ListPrice,
		COUNT(*) OVER (PARTITION BY C.ProductCategoryID) CountOfProduct,
		AVG(ListPrice) OVER (PARTITION BY C.ProductCategoryID) AS AvgListPrice
FROM	Production.Product				AS P
		JOIN
		Production.ProductSubcategory	AS S
			ON S.ProductSubcategoryID = P.ProductSubcategoryID

		JOIN
		Production.ProductCategory		AS C
			ON C.ProductCategoryID = S.ProductCategoryID
WHERE	FinishedGoodsFlag = 1;


--Mix windows
SELECT	P.ProductID,
		P.name													AS ProductName,
		C.Name													AS CategoryName,
		ListPrice,
		COUNT(*) OVER (PARTITION BY C.ProductCategoryID) CountOfProduct,
		AVG(ListPrice) OVER (PARTITION BY C.ProductCategoryID) AS AvgListPrice,
		MIN(ListPrice) OVER ()								AS MinListPrice,
		MAX(ListPrice) OVER ()								AS MaxListPrice
FROM	Production.Product				AS P
		JOIN
		Production.ProductSubcategory	AS S
			ON S.ProductSubcategoryID = P.ProductSubcategoryID

		JOIN
		Production.ProductCategory		AS C
			ON C.ProductCategoryID = S.ProductCategoryID
WHERE	FinishedGoodsFlag = 1;


