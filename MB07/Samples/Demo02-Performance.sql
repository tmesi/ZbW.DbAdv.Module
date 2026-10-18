/*
T-SQL Window Functions Class
Demo2: Performance
*/

--Run Demo0_Setup.sql to create the table

USE PL_SampleData;
GO
SET STATISTICS IO ON;
GO


SELECT		TickerSymbol,
			TradeDate,
			ClosePrice,
			ClosePrice - LAG(ClosePrice) OVER (PARTITION BY TickerSymbol
											ORDER BY TradeDate
											) AS Dif
FROM		dbo.StockHistory
ORDER BY	TickerSymbol,
			TradeDate;









SELECT		O.TickerSymbol,
			O.TradeDate,
			O.ClosePrice,
			O.ClosePrice - CA.ClosePrice AS Change
FROM		dbo.StockHistory	AS O
			OUTER APPLY (
							SELECT		TOP (1)
										I.ClosePrice
							FROM		dbo.StockHistory AS I
							WHERE		I.TickerSymbol	= O.TickerSymbol
							AND			I.TradeDate				< O.TradeDate
							ORDER BY	I.TradeDate
						)		AS CA
ORDER BY	O.TickerSymbol,
			O.TradeDate;
















SET STATISTICS IO OFF;
GO
SET STATISTICS TIME ON;
GO

CREATE TABLE #Stock1
(
	TickerSymbol	VARCHAR(4),
	TradeDate		DATE,
	ClosePrice		MONEY,
	Change			MONEY
);
CREATE TABLE #Stock2
(
	TickerSymbol	VARCHAR(4),
	TradeDate		DATE,
	ClosePrice		MONEY,
	Change			MONEY
);


INSERT INTO #Stock1
(
	TickerSymbol,
	TradeDate,
	ClosePrice,
	Change
)
SELECT	TickerSymbol,
		TradeDate,
		ClosePrice,
		ClosePrice - LAG(ClosePrice) OVER (PARTITION BY TickerSymbol
										ORDER BY TradeDate
										) AS Change
FROM	dbo.StockHistory;

INSERT INTO #Stock2
(
	TickerSymbol,
	TradeDate,
	ClosePrice,
	Change
)
SELECT	O.TickerSymbol,
		O.TradeDate,
		O.ClosePrice,
		O.ClosePrice - CA.ClosePrice AS Change
FROM	dbo.StockHistory	AS O
		OUTER APPLY (
						SELECT		TOP (1)
									I.ClosePrice
						FROM		dbo.StockHistory AS I
						WHERE		I.TickerSymbol	= O.TickerSymbol
						AND			I.TradeDate				< O.TradeDate
						ORDER BY	I.TradeDate
					)		AS CA;


SET STATISTICS IO OFF;
GO
SET STATISTICS TIME OFF;
GO

--Turn on Actual Execution Plan
SELECT		TickerSymbol,
			TradeDate,
			ClosePrice,
			ClosePrice - LAG(ClosePrice) OVER (PARTITION BY TickerSymbol
											ORDER BY TradeDate
											) AS Dif
FROM		dbo.StockHistory
ORDER BY	TickerSymbol,
			TradeDate;


SELECT		O.TickerSymbol,
			O.TradeDate,
			O.ClosePrice,
			O.ClosePrice - CA.ClosePrice AS Change
FROM		dbo.StockHistory	AS O
			OUTER APPLY (
							SELECT		TOP (1)
										I.ClosePrice
							FROM		dbo.StockHistory AS I
							WHERE		I.TickerSymbol	= O.TickerSymbol
							AND			I.TradeDate				< O.TradeDate
							ORDER BY	I.TradeDate
						)		AS CA
ORDER BY	O.TickerSymbol,
			O.TradeDate;


