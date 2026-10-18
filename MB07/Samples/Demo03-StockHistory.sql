USE PL_SampleData;
GO

SELECT	*,
		AVG(ClosePrice) OVER (PARTITION BY TickerSymbol
							ORDER BY TradeDate
							RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
							)
FROM	dbo.StockHistory;



SELECT		TickerSymbol,
			TradeDate,
			ClosePrice,
			ClosePrice - LAG(ClosePrice, 1) OVER (PARTITION BY TickerSymbol
												ORDER BY TradeDate
												) AS Dif
FROM		dbo.StockHistory
ORDER BY	TickerSymbol,
			TradeDate;