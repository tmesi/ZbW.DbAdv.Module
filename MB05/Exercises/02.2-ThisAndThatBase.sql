SELECT	EventID		= e.EventID,
		IfThis		= CASE WHEN e.EventDetails LIKE '%this%' THEN 1 ELSE 0 END,	-- does description contain THIS?
		IfThat		= CASE WHEN e.EventDetails LIKE '%that%' THEN 1 ELSE 0 END	-- does description contain THAT?
FROM	tblEvent	AS e;