USE tempdb;
GO


-- Scalar user-defined function
CREATE FUNCTION dbo.total_concurrent_requests
()
RETURNS SMALLINT
AS
BEGIN

	DECLARE @output_count SMALLINT;

	WITH CTE_Requests (session_id, status, login_name, text)
	AS
	(
		SELECT	[session_id]									= r.session_id,
				[status]										= r.status,
				[login_name]									= s.login_name,
				[text]											= t.text
		FROM	sys.dm_exec_requests							AS r
				INNER JOIN
				sys.dm_exec_sessions							AS s
					ON	s.session_id							= r.session_id
	
				INNER JOIN
				sys.dm_exec_connections							AS c
					ON	s.session_id							= c.session_id
				CROSS APPLY
				sys.dm_exec_sql_text(c.most_recent_sql_handle)	AS t
		WHERE	r.status										IN (N'running', N'runnable', N'suspended')
	)
	SELECT	@output_count	= COUNT(*)
	FROM	CTE_Requests	AS cte;

	RETURN (@output_count);
END;
GO

SELECT	concurrent_request_count	= dbo.total_concurrent_requests()
GO

-- Multi-statement table-valued function
CREATE FUNCTION dbo.mstvf_concurrent_requests
()
RETURNS @concurrent_requests TABLE
(
	session_id	SMALLINT		NULL,
	status		NVARCHAR(30)	NULL,
	login_name	NVARCHAR(128)	NULL,
	text		NVARCHAR(MAX)	NULL
)
AS
BEGIN;
	WITH CTE_Requests (session_id, status, login_name, text)
	AS
	(
		SELECT	[session_id]									= r.session_id,
				[status]										= r.status,
				[login_name]									= s.login_name,
				[text]											= t.text
		FROM	sys.dm_exec_requests							AS r
				INNER JOIN
				sys.dm_exec_sessions							AS s
					ON	s.session_id							= r.session_id
	
				INNER JOIN
				sys.dm_exec_connections							AS c
					ON	s.session_id							= c.session_id
				CROSS APPLY
				sys.dm_exec_sql_text(c.most_recent_sql_handle)	AS t
		WHERE	r.status										IN (N'running', N'runnable', N'suspended')
	)
	INSERT	@concurrent_requests
	SELECT	[session_id]	= cte.session_id,
			[status]		= cte.status,
			[login_name]	= cte.login_name,
			[text]			= cte.text
	FROM	CTE_Requests	AS cte;

	RETURN;
END;
GO

SELECT	[session_id]					= fn.session_id,
		[status]						= fn.status,
		[login_name]					= fn.login_name,
		[text]							= fn.text
FROM	dbo.mstvf_concurrent_requests() AS fn;
GO

-- Inline table-valued user-defined function
CREATE FUNCTION dbo.itvf_concurrent_requests
()
RETURNS TABLE
AS
	RETURN
	WITH CTE_Requests (session_id, status, login_name, text)
	AS
	(
		SELECT	[session_id]									= r.session_id,
				[status]										= r.status,
				[login_name]									= s.login_name,
				[text]											= t.text
		FROM	sys.dm_exec_requests							AS r
				INNER JOIN
				sys.dm_exec_sessions							AS s
					ON	s.session_id							= r.session_id
	
				INNER JOIN
				sys.dm_exec_connections							AS c
					ON	s.session_id							= c.session_id
				CROSS APPLY
				sys.dm_exec_sql_text(c.most_recent_sql_handle)	AS t
		WHERE	r.status										IN (N'running', N'runnable', N'suspended')
	)
	SELECT	[session_id]	= cte.session_id,
			[status]		= cte.status,
			[login_name]	= cte.login_name,
			[text]			= cte.text
	FROM	CTE_Requests	AS cte;
GO

SELECT	[session_id]					= fn.session_id,
		[status]						= fn.status,
		[login_name]					= fn.login_name,
		[text]							= fn.text
FROM	dbo.itvf_concurrent_requests()	AS fn;

-- Cleanup
DROP FUNCTION dbo.total_concurrent_requests;
DROP FUNCTION dbo.mstvf_concurrent_requests;
DROP FUNCTION dbo.itvf_concurrent_requests;
GO
