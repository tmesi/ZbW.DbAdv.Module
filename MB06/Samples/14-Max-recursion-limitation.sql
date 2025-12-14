USE tempdb;
GO

SET NOCOUNT ON;
GO

-- Let's create a sample table with a simple parent/child hierarchy
CREATE TABLE dbo.ProductHierarchy
(
    ProductHierarchyID INT NOT NULL
                            PRIMARY KEY CLUSTERED
                            IDENTITY (1, 1) ,
    ProductID INT NOT NULL ,
    ParentProductID INT NULL
);
GO

INSERT dbo.ProductHierarchy
        ( ProductID, ParentProductID )
VALUES  ( 1, NULL ),
        ( 2, 1 );
GO

INSERT dbo.ProductHierarchy
SELECT	TOP (1) ProductID + 1,
		ParentProductID + 1
FROM dbo.ProductHierarchy
WHERE ParentProductID IS NOT NULL
ORDER BY ProductID DESC;
GO 100

-- Explore the data we just loaded
SELECT ProductID, ParentProductID
FROM dbo.ProductHierarchy;
GO

-- Now let's use a recursive CTE in order to traverse the hierarchy
WITH CTE_Products (
	ProductID, ParentProductID, ProductLevel )
AS (
	SELECT	ProductID ,
            ParentProductID ,
            0 AS ProductLevel
    FROM dbo.ProductHierarchy
    WHERE ParentProductID IS NULL
    UNION ALL
    SELECT	pn.ProductID ,
            pn.ParentProductID ,
            p1.ProductLevel + 1
    FROM dbo.ProductHierarchy AS pn
    INNER JOIN CTE_Products AS p1
		ON p1.ProductID = pn.ParentProductID
)
SELECT  ProductID ,
        ParentProductID ,
        ProductLevel
FROM CTE_Products
ORDER BY ParentProductID;
GO

-- Now let's use a hint to exceed the 100-level default
WITH CTE_Products (
	ProductID, ParentProductID, ProductLevel )
AS (
	SELECT	ProductID ,
            ParentProductID ,
            0 AS ProductLevel
    FROM dbo.ProductHierarchy
    WHERE ParentProductID IS NULL
    UNION ALL
    SELECT	pn.ProductID ,
            pn.ParentProductID ,
            p1.ProductLevel + 1
    FROM dbo.ProductHierarchy AS pn
    INNER JOIN CTE_Products AS p1
		ON p1.ProductID = pn.ParentProductID
)
SELECT  ProductID ,
        ParentProductID ,
        ProductLevel
FROM CTE_Products
ORDER BY ParentProductID
OPTION (MAXRECURSION 101); -- If 0, no limit is applied
GO

-- Cleanup
DROP TABLE dbo.ProductHierarchy;
GO

