USE tempdb;
GO

-- Let's create a sample table with a simple parent/child hierarchy

CREATE TABLE dbo.ProductHierarchy
(
	ProductHierarchyID	INT NOT NULL PRIMARY KEY CLUSTERED IDENTITY(1, 1),
	ProductID			INT NOT NULL,
	ParentProductID		INT NULL
);
GO

INSERT	dbo.ProductHierarchy (ProductID, ParentProductID)
VALUES
(1, NULL),
(2, 1),
(3, 1),
(4, 2),
(5, 4),
(6, 4),
(7, 4);
GO
SELECT * FROM dbo.ProductHierarchy;

-- Now let's use a recursive CTE in order to traverse the hierarchy
WITH CTE_Products(ProductID, ParentProductID, ProductLevel, HierarchyPath)
AS
(
	SELECT	ProductID				= ph.ProductID,
			ParentProductID			= ph.ParentProductID,
			ProductLevel			= 0,
			HierarchyPath			= CAST(ph.ProductID AS NVARCHAR(4000))
	FROM	dbo.ProductHierarchy	AS ph
	WHERE	ParentProductID			IS NULL
	UNION	ALL
	SELECT	ProductID				= pn.ProductID,
			ParentProductID			= pn.ParentProductID,
			ProductLevel			= p1.ProductLevel + 1,
			HierarchyPath			= CAST(CONCAT(p1.HierarchyPath, ' > ', pn.ProductID) AS NVARCHAR(4000))
	FROM	dbo.ProductHierarchy	AS pn -- child
			INNER JOIN
			CTE_Products			AS p1 -- parent
				ON	p1.ProductID	= pn.ParentProductID
)
SELECT		ProductID			= cte.ProductID,
			ParentProductID		= cte.ParentProductID,
			ProductLevel		= cte.ProductLevel,
			HierarchyPath		= cte.HierarchyPath
FROM		CTE_Products		AS cte
ORDER BY	cte.ParentProductID;
GO

-- Cleanup
DROP TABLE dbo.ProductHierarchy;
GO

