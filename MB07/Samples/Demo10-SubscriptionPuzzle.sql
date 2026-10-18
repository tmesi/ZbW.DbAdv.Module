USE PL_SampleData;
GO

--Step 1, view the data 
SELECT	*
FROM	dbo.Subscription	AS s




--Step 2, counts based on Dates
SELECT		NewSubCount			= COUNT(*),
			DateJoined			= s.DateJoined
FROM		dbo.Subscription	AS s
GROUP BY	s.DateJoined;

SELECT		CancellationCount	= COUNT(*),
			DateLeft			= s.DateLeft
FROM		dbo.Subscription	AS s
GROUP BY	s.DateLeft;

--Step 3 join these two queries
WITH Joined
AS
(
	SELECT		NewSubCount			= COUNT(*),
				DateJoined			= s.DateJoined
	FROM		dbo.Subscription	AS s
	GROUP BY	s.DateJoined
),
	Cancelled
AS
(
	SELECT		CancellationCount	= COUNT(*),
				DateLeft			= s.DateLeft
	FROM		dbo.Subscription	AS s
	GROUP BY	s.DateLeft
)
SELECT	DateJoined			= j.DateJoined,
		NewSubCount			= j.NewSubCount,
		CancellationCount	= c.CancellationCount
FROM	Joined				AS j
		LEFT JOIN
		Cancelled			AS c
			ON j.DateJoined	= c.DateLeft;

--Step 4, running total
WITH Joined
AS
(
	SELECT		NewSubCount			= COUNT(*),
				DateJoined			= s.DateJoined
	FROM		dbo.Subscription	AS s
	GROUP BY	s.DateJoined
),
	Cancelled
AS
(
	SELECT		CancellationCount	= COUNT(*),
				DateLeft			= s.DateLeft
	FROM		dbo.Subscription	AS s
	GROUP BY	s.DateLeft
)
SELECT	DateJoined			= j.DateJoined,
		NewSubCount			= j.NewSubCount,
		CancellationCount	= c.CancellationCount,
		CurrentSubscribers	= SUM(NewSubCount - ISNULL(CancellationCount, 0)) OVER (ORDER BY DateJoined ROWS UNBOUNDED PRECEDING)
FROM	Joined				AS j
		LEFT JOIN
		Cancelled			AS c
			ON j.DateJoined	= c.DateLeft;







