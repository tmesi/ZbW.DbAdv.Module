USE WorldEvents;
GO

-- create CTE giving if this and if that for each event
WITH ThisAndThat
AS
(
	SELECT	EventID		= e.EventID,
			IfThis		= CASE WHEN e.EventDetails LIKE '%this%' THEN 1 ELSE 0 END,	-- does description contain THIS?
			IfThat		= CASE WHEN e.EventDetails LIKE '%that%' THEN 1 ELSE 0 END	-- does description contain THAT?
	FROM	tblEvent	AS e
)

-- show results
SELECT		IfThis				= t.IfThis,
			IfThat				= t.IfThat,
			'Number of events'	= COUNT(*)	
FROM		ThisAndThat			AS t
GROUP BY	t.IfThis,
			t.IfThat
ORDER BY	'Number of events' DESC;	-- can't order within CTE
