USE tempdb;
GO

-- Triggers and CTEs

-- Demo tables
CREATE TABLE dbo.event_response
(
	event_id	INT				PRIMARY KEY CLUSTERED IDENTITY(1, 1) NOT NULL,
	event_name	sysname			NULL,
	event_date	DATETIME2(7)	NOT NULL DEFAULT SYSDATETIME()
);
GO

CREATE TABLE dbo.concurrent_event_requests
(
	concurrent_event_requests_id	INT PRIMARY KEY CLUSTERED IDENTITY(1, 1) NOT NULL,
	event_date						DATETIME2(7)	NOT NULL DEFAULT SYSDATETIME(),
	session_id						SMALLINT		NULL,
	status							NVARCHAR(30)	NULL,
	login_name						NVARCHAR(128)	NULL,
	text							NVARCHAR(MAX)	NULL
);
GO

CREATE TRIGGER dbo.trigger_event_response
	ON	dbo.event_response AFTER INSERT
AS
;
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
INSERT	dbo.concurrent_event_requests (session_id, status, login_name, text)
SELECT	[session_id]	= cte.session_id,
		[status]		= cte.status,
		[login_name]	= cte.login_name,
		[text]			= cte.text
FROM	CTE_Requests	AS cte;

GO

INSERT	dbo.event_response (event_name)
VALUES	('Something happened!');
GO

SELECT	event_id			= er.event_id,
		event_name			= er.event_name,
		event_date			= er.event_date
FROM	dbo.event_response	AS er;

SELECT	concurrent_event_requests_id	= cer.concurrent_event_requests_id,
		event_date						= cer.event_date,
		[session_id]					= cer.session_id,
		[status]						= cer.status,
		[login_name]					= cer.login_name,
		[text]							= cer.text
FROM	dbo.concurrent_event_requests	AS cer;
GO

-- Cleanup
DROP TABLE tempdb.dbo.event_response;

DROP TABLE tempdb.dbo.concurrent_event_requests;
GO
