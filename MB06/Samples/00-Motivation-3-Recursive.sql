USE tempdb;
GO

-- Let's create a sample table with a simple parent/child hierarchy

-- tempdb: table exists for the current connection

DROP TABLE IF EXISTS dbo.ProductHierarchy 

CREATE TABLE dbo.ProductHierarchy
(
	ProductHierarchyID	INT NOT NULL PRIMARY KEY CLUSTERED IDENTITY(1, 1),
	ProductID				INT NOT NULL,
	ParentProductID		INT NULL
);
GO

INSERT	dbo.ProductHierarchy
(
	ProductID,
	ParentProductID
)
VALUES
(1, NULL),
(2, 1),
(3, 1),
(4, 2),
(5, 4),
(6, 4),
(7, 4);
GO

-- ohne CTE - es muss bekannt sein, wieviele Hierarchien
-- pro Hierarchie einen Union mit Derived Table
SELECT	ProductID				= p0.ProductID,
		ParentProductID			= p0.ParentProductID,
		ProductLevel			= 0
FROM	dbo.ProductHierarchy	AS p0
WHERE	p0.ParentProductID		IS NULL
UNION	ALL
SELECT	ProductID				= p1.ProductID,
		ParentProductID			= p1.ParentProductID,
		ProductLevel			= 1
FROM	dbo.ProductHierarchy	AS p1
		JOIN
		(
			SELECT	ProductID				= p0.ProductID,
					ParentProductID			= p0.ParentProductID,
					ProductLevel			= 0
			FROM	dbo.ProductHierarchy	AS p0
			WHERE	p0.ParentProductID		IS NULL
		)							AS p0
			ON	p1.ParentProductID	= p0.ProductID
UNION	ALL
SELECT	ProductID				= p2.ProductID,
		ParentProductID			= p2.ParentProductID,
		ProductLevel			= 2
FROM	dbo.ProductHierarchy	AS p2
		JOIN
		(
			SELECT	ProductID				= p1.ProductID,
					ParentProductID			= p1.ParentProductID,
					ProductLevel			= 1
			FROM	dbo.ProductHierarchy	AS p1
					JOIN
					(
						SELECT	ProductID				= p0.ProductID,
								ParentProductID			= p0.ParentProductID,
								ProductLevel			= 0
						FROM	dbo.ProductHierarchy	AS p0
						WHERE	p0.ParentProductID		IS NULL
					)							AS p0
						ON	p1.ParentProductID	= p0.ProductID
		)							AS p1
			ON	p2.ParentProductID	= p1.ProductID
UNION	ALL
SELECT	ProductID				= p3.ProductID,
		ParentProductID			= p3.ParentProductID,
		ProductLevel			= 3
FROM	dbo.ProductHierarchy	AS p3
		JOIN
		(
			SELECT	ProductID				= p2.ProductID,
					ParentProductID			= p2.ParentProductID,
					ProductLevel			= 2
			FROM	dbo.ProductHierarchy	AS p2
					JOIN
					(
						SELECT	ProductID				= p1.ProductID,
								ParentProductID			= p1.ParentProductID,
								ProductLevel			= 1
						FROM	dbo.ProductHierarchy	AS p1
								JOIN
								(
									SELECT	ProductID				= p0.ProductID,
											ParentProductID			= p0.ParentProductID,
											ProductLevel			= 0
									FROM	dbo.ProductHierarchy	AS p0
									WHERE	p0.ParentProductID		IS NULL
								)							AS p0
									ON	p1.ParentProductID	= p0.ProductID
					)							AS p1
						ON	p2.ParentProductID	= p1.ProductID
		)							AS p2
			ON	p3.ParentProductID	= p2.ProductID;


-- mit CTE -> Rekursiv  
-- Now let's use a recursive CTE in order to traverse the hierarchy
WITH CTE_Products (ProductID, ParentProductID, ProductLevel)
AS
(
	SELECT	ProductID				= ph.ProductID,
			ParentProductID			= ph.ParentProductID,
			ProductLevel			= 0
	FROM	dbo.ProductHierarchy	AS ph
	WHERE	ph.ParentProductID		IS NULL
	UNION	ALL
	SELECT	ProductID				= pn.ProductID,
			ParentProductID			= pn.ParentProductID,
			ProductLevel			= p1.ProductLevel + 1
	FROM	dbo.ProductHierarchy	AS pn
			INNER JOIN
			CTE_Products			AS p1
				ON	p1.ProductID	= pn.ParentProductID
)
SELECT		ProductID		= p.ProductID,
			ParentProductID	= p.ParentProductID,
			ProductLevel	= ProductLevel
FROM		CTE_Products	AS p
ORDER BY	ParentProductID;
GO

-- Cleanup
DROP TABLE	dbo.ProductHierarchy;
GO

