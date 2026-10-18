USE master;
GO

-- We've seen examples of SELECT in prior demos

-- Demo (temporary) table
CREATE TABLE #all_views
(
	name		sysname			NULL,
	object_id	INT				NULL,
	type_desc	NVARCHAR(60)	NULL
);
GO

-- INSERT
WITH CTE_Views (object_id, name, type_desc)
AS
(
	SELECT	[object_id]		= aw.object_id,
			[name]			= aw.name,
			[type_desc]		= aw.type_desc
	FROM	sys.all_views	AS aw
)
INSERT	#all_views (name, object_id, type_desc)
SELECT	cte.name,
		cte.object_id,
		cte.type_desc
FROM	CTE_Views		AS cte;
GO

-- UPDATE
WITH CTE_Views (object_id, name, type_desc)
AS
(
	SELECT	[object_id]		= aw.object_id,
			[name]			= aw.name,
			[type_desc]		= aw.type_desc
	FROM	sys.all_views	AS aw
)
UPDATE	t
SET		name				= v.name
FROM	#all_views			AS t
		INNER JOIN
		CTE_Views			AS v
			ON t.object_id	= v.object_id;
GO

-- DELETE
WITH CTE_Views (object_id, name, type_desc)
AS
(
	SELECT	[object_id]		= aw.object_id,
			[name]			= aw.name,
			[type_desc]		= aw.type_desc
	FROM	sys.all_views	AS aw
)
DELETE	t
FROM	#all_views			AS t
		INNER JOIN
		CTE_Views			AS v
			ON t.object_id	= v.object_id;
GO

-- MERGE
WITH CTE_Views (object_id, name, type_desc)
AS
(
	SELECT	[object_id]		= aw.object_id,
			[name]			= aw.name,
			[type_desc]		= aw.type_desc
	FROM	sys.all_views	AS aw
)
MERGE	#all_views			AS t
USING	CTE_Views			AS s
			ON	t.object_id	= s.object_id
WHEN	NOT MATCHED THEN	INSERT (object_id, name, type_desc)
							VALUES (s.object_id, s.name, s.type_desc);
GO

SELECT	[name]		= aw.name,
		[object_id]	= aw.object_id,
		[type_desc]	= aw.type_desc
FROM	#all_views	AS aw;
GO

-- Cleanup
DROP TABLE #all_views;
GO
