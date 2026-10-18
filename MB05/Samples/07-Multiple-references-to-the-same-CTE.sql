USE master;
GO

-- We can reference a CTE multiple times, unlike with derived
-- tables where they must be defined for each reference

-- Before (derived tables)
SELECT	min_hour							= c.last_execution_time_by_hour - 1,
		max_hour							= c.last_execution_time_by_hour,
		two_hour_average_execution_count	= (c.sum_execution_count + ISNULL(p.sum_execution_count, 0)) / 2
FROM	(
			SELECT		last_execution_time_by_hour	= DATEPART(HOUR, qs.last_execution_time),
						sum_execution_count			= SUM(qs.execution_count)
			FROM		sys.dm_exec_query_stats		AS qs
			GROUP BY	DATEPART(HOUR, qs.last_execution_time)
		)	AS c
		LEFT OUTER JOIN
		(
			SELECT		last_execution_time_by_hour	= DATEPART(HOUR, qs.last_execution_time),
						sum_execution_count			= SUM(qs.execution_count)
			FROM		sys.dm_exec_query_stats		AS qs
			GROUP BY	DATEPART(HOUR, last_execution_time)
		)											AS p
			ON	c.last_execution_time_by_hour - 1	= p.last_execution_time_by_hour;

-- After (CTEs)
WITH CTE_Stats_by_Hour (last_execution_time_by_hour, sum_execution_count)
AS
(
	SELECT		DATEPART(HOUR, last_execution_time),
				SUM(execution_count)
	-- notice I don't have to alias the two columns
	FROM		sys.dm_exec_query_stats
	GROUP BY	DATEPART(HOUR, last_execution_time)
)
SELECT	min_hour									= c.last_execution_time_by_hour - 1,
		max_hour									= c.last_execution_time_by_hour,
		two_hour_average_execution_count			= (c.sum_execution_count + ISNULL(p.sum_execution_count, 0)) / 2
FROM	CTE_Stats_by_Hour							AS c
		LEFT OUTER JOIN
		CTE_Stats_by_Hour							AS p
			ON c.last_execution_time_by_hour - 1	= p.last_execution_time_by_hour;

-- As an aside - what do the execution plans look like?