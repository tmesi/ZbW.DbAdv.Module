USE master;
GO

-----------------------------------------------------------------

-- Will this work?
SELECT	@@SERVERNAME;

-- Basic example
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

-----------------------------------------------------------------

-- What about this?
SELECT	@@SERVERNAME

-- Basic example
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