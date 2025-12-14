USE master;
GO

-- We can define multiple CTEs, but have a choice of actually
-- referencing some or all
WITH CTE_Views (object_id, name, type_desc)
AS
(
	SELECT	[object_id]		= aw.object_id,
			[name]			= aw.name,
			[type_desc]		= aw.type_desc
	FROM	sys.all_views	AS aw
),

CTE_Triggers (object_id, name, type_desc)
AS
(
	SELECT	[object_id]		= t.object_id,
			[name]			= t.name,
			[type_desc]		= t.type_desc
	FROM	sys.triggers	AS t
)
SELECT	cte.name,
		cte.object_id,
		cte.type_desc
FROM	CTE_Views		AS cte;
GO

-- And of course, we can reference all defined CTEs within the
-- same execution scope
WITH CTE_Views (object_id, name, type_desc)
AS
(
	SELECT	[object_id]		= aw.object_id,
			[name]			= aw.name,
			[type_desc]		= aw.type_desc
	FROM	sys.all_views	AS aw
),
	CTE_Triggers (object_id, name, type_desc)
AS
(
	SELECT	[object_id]		= t.object_id,
			[name]			= t.name,
			[type_desc]		= t.type_desc
	FROM	sys.triggers	AS t
)
SELECT	cte.name,
		cte.object_id,
		cte.type_desc
FROM	CTE_Views		AS cte
UNION
SELECT	cte.name,
		cte.object_id,
		cte.type_desc
FROM	CTE_Triggers	AS cte;
GO