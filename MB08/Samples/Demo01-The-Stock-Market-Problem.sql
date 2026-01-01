/*
T-SQL Window Functions Class
Demo1: Solving the Stock Market Problem
*/

--Run Demo0_Setup.sql to create the table

USE PL_SampleData;
GO

USE PL_SampleData;
GO
SET STATISTICS IO ON;
GO

SELECT		TickerSymbol,
			TradeDate,
			ClosePrice
FROM		dbo.StockHistory
ORDER BY	TickerSymbol,
			TradeDate;

SELECT		O.TickerSymbol,
			O.TradeDate,
			O.ClosePrice,
			O.ClosePrice - (
							SELECT		TOP (1)
										I.ClosePrice
							FROM		dbo.StockHistory AS I
							WHERE		I.TickerSymbol	= O.TickerSymbol
							AND			I.TradeDate			< O.TradeDate
							ORDER BY	I.TradeDate
						)	AS Change
FROM		dbo.StockHistory AS O

ORDER BY	O.TickerSymbol,
			O.TradeDate;

/*
OUTER APPLY ist ähnlich wie JOIN - Abfrage wird für jede Zeile gemacht 
und nicht für das ganze SET.
*/
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


SELECT		TickerSymbol,
			TradeDate,
			ClosePrice,
			ClosePrice - LAG(ClosePrice) OVER (PARTITION BY TickerSymbol
											ORDER BY TradeDate
											) AS Dif
FROM		dbo.StockHistory
ORDER BY	TickerSymbol,
			TradeDate;







