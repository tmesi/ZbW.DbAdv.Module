USE PL_SampleData;
GO

--Step 1, view the data 
SELECT	*
FROM	dbo.Subscription;




--Step 2, counts based on Dates
SELECT		COUNT(*)	AS NewSubCount,
			DateJoined
FROM		dbo.Subscription
GROUP BY	DateJoined;

SELECT		COUNT(*)	AS CancellationCount,
			DateLeft
FROM		dbo.Subscription
GROUP BY	DateLeft;

--Step 3 join these two queries
WITH Joined
AS
(
	SELECT		COUNT(*)	AS NewSubCount,
				DateJoined
	FROM		dbo.Subscription
	GROUP BY	DateJoined
),
	Cancelled
AS
(
	SELECT		COUNT(*)	AS CancellationCount,
				DateLeft
	FROM		dbo.Subscription
	GROUP BY	DateLeft
)
SELECT	DateJoined,
		NewSubCount,
		CancellationCount
FROM	Joined
		LEFT JOIN
		Cancelled
			ON Joined.DateJoined = Cancelled.DateLeft;

--Step 4, running total
WITH Joined
AS
(
	SELECT		COUNT(*)	AS NewSubCount,
				DateJoined
	FROM		dbo.Subscription
	GROUP BY	DateJoined
),
	Cancelled
AS
(
	SELECT		COUNT(*)	AS CancellationCount,
				DateLeft
	FROM		dbo.Subscription
	GROUP BY	DateLeft
)
SELECT	DateJoined,
		NewSubCount,
		CancellationCount,
		SUM(NewSubCount - ISNULL(CancellationCount, 0)) OVER (ORDER BY DateJoined
															ROWS UNBOUNDED PRECEDING
															) AS CurrentSubscribers
FROM	Joined
		LEFT JOIN
		Cancelled
			ON Joined.DateJoined = Cancelled.DateLeft;







