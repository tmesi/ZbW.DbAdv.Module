SELECT		TickerSymbol,
			TradeDate,
			ClosePrice
FROM		dbo.StockHistory
WHERE		TickerSymbol LIKE 'X1'
ORDER BY	TickerSymbol,
			TradeDate;


/*
correlated with MAX aggregate

Notes: 
- Works in any SQL Server version
- Naturally handles gaps (weekends, holidays)
- First row per ticker → NULL diff

Performance:
- Correlated subquery → can be expensive (without index about 2 min./with index 14 sec.)

Needs a supporting index:

	CREATE INDEX IX_StockHistory_TickerDate
		ON dbo.StockHistory (TickerSymbol, TradeDate)
		INCLUDE (ClosePrice);
*/
SELECT  cur.TickerSymbol,
        cur.TradeDate,
        cur.ClosePrice,
        prev.ClosePrice,
        Diff = cur.ClosePrice - prev.ClosePrice
FROM    dbo.StockHistory            AS cur
        LEFT JOIN dbo.StockHistory  AS prev
            ON  prev.TickerSymbol   = cur.TickerSymbol
           AND  prev.TradeDate =
                (
                    SELECT  MAX(p2.TradeDate)
                    FROM    dbo.StockHistory   AS p2
                    WHERE   p2.TickerSymbol   = cur.TickerSymbol
                      AND   p2.TradeDate        < cur.TradeDate
                )
--WHERE cur.TickerSymbol LIKE 'X1'
ORDER BY
    cur.TickerSymbol,
    cur.TradeDate;


/*
correlated with NOT EXISTS

Notes:
- Logically: “join to the closest earlier row”
- Very explicit and correct
- No aggregates

Performance:
- Often becomes a Nested Loops + Seek
- Same index as above works well

*/
SELECT	cur.TickerSymbol,
		cur.TradeDate,
		cur.ClosePrice,
		prev.ClosePrice,
		Diff						= cur.ClosePrice - prev.ClosePrice
FROM	dbo.StockHistory			AS cur
		LEFT JOIN
		dbo.StockHistory			AS prev
			ON	prev.TickerSymbol	= cur.TickerSymbol
			AND prev.TradeDate		< cur.TradeDate
			AND NOT EXISTS (
							SELECT		1
							FROM		dbo.StockHistory	AS x
							WHERE		x.TickerSymbol		= cur.TickerSymbol
							AND			x.TradeDate			< cur.TradeDate
							AND			x.TradeDate			> prev.TradeDate
						)
WHERE	cur.TickerSymbol LIKE 'X1'
ORDER BY	cur.TickerSymbol,
			cur.TradeDate;

/*
correlated with OUTER APPLY

Notes:
- Reads almost like LAG()
- Extremely easy to reason about
- Handles gaps correctly

Performance
- With index (TickerSymbol, TradeDate) → very efficient

Usually produces:
- Index Seek
- Top
- Nested Loops

This is often the best alternative to window functions.
*/
SELECT		cur.TickerSymbol,
			cur.TradeDate,
			cur.ClosePrice,
			p.TradeDate,
			p.ClosePrice,
			cur.ClosePrice - p.ClosePrice AS Diff
FROM		dbo.StockHistory	AS cur
			OUTER APPLY (
							SELECT		TOP (1)
										prev.ClosePrice,
										prev.TradeDate
							FROM		dbo.StockHistory	AS prev
							WHERE		prev.TickerSymbol	= cur.TickerSymbol
							AND			prev.TradeDate		< cur.TradeDate
							ORDER BY	prev.TradeDate DESC
						)		AS p
WHERE		cur.TickerSymbol LIKE 'X1'
ORDER BY	cur.TickerSymbol,
			cur.TradeDate;

/*
using ROW_NUMBER()

Derived table with row numbering (pre-LAG simulation)
*/
SELECT	cur.TickerSymbol,
		cur.TradeDate,
		cur.ClosePrice,
		cur.rn,
		prev.TradeDate,
		prev.ClosePrice,
		prev.rn,
		Diff				= cur.ClosePrice - prev.ClosePrice
FROM	(
			SELECT	TickerSymbol,
					TradeDate,
					ClosePrice,
					ROW_NUMBER() OVER (PARTITION BY TickerSymbol ORDER BY TradeDate) AS rn
			FROM	dbo.StockHistory
		)	AS cur
		LEFT JOIN
		(
			SELECT	TickerSymbol,
					TradeDate,
					ClosePrice,
					ROW_NUMBER() OVER (PARTITION BY TickerSymbol ORDER BY TradeDate) AS rn
			FROM	dbo.StockHistory
		)							AS prev
			ON	prev.TickerSymbol	= cur.TickerSymbol
			AND prev.rn				= cur.rn - 1
WHERE		cur.TickerSymbol LIKE 'X1';


/* using ROW_NUMBER() in CTE */
WITH StockPrices
AS
(
	SELECT	TickerSymbol,
			TradeDate,
			ClosePrice,
			rn = ROW_NUMBER() OVER (PARTITION BY TickerSymbol ORDER BY TradeDate)
	FROM	dbo.StockHistory
)
SELECT	cur.TickerSymbol,
		cur.TradeDate,
		cur.ClosePrice,
		cur.rn,
		prev.TradeDate,
		prev.ClosePrice,
		prev.rn,
		Diff						= cur.ClosePrice - prev.ClosePrice
FROM	StockPrices					AS cur
		LEFT JOIN
		StockPrices					AS prev
			ON	prev.TickerSymbol	= cur.TickerSymbol
		   AND	prev.rn				= cur.rn - 1
--WHERE	cur.TickerSymbol LIKE 'X1';

