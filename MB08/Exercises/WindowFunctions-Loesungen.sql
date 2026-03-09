
-- Excercise 1
SELECT		a.s_year,
			a.s_month,
			a.sales				AS monthly_sales,
			SUM(a.sales) OVER (ORDER BY a.s_year,
										a.s_month
							) AS cum_monthly_sales_total
FROM		ap_sales a
ORDER BY	a.s_year,
			a.s_month;


-- Excercise 2
SELECT		a.s_year,
			a.s_month,
			a.sales				AS monthly_sales,
			SUM(a.sales) OVER (ORDER BY a.s_year,
										a.s_month
							) AS cum_monthly_sales_total,
			SUM(a.sales) OVER (PARTITION BY a.s_year
							ORDER BY a.s_year,
										a.s_month
							) AS cum_monthly_sales_per_year
FROM		ap_sales a
ORDER BY	a.s_year,
			a.s_month;


-- Excercise 3
SELECT		a.s_year,
			a.s_month,
			a.sales					AS monthly_sales,
			LAG(a.sales, 1) OVER (ORDER BY a.s_year,
										a.s_month
								) AS previous_month_sales
FROM		ap_sales a
ORDER BY	a.s_year,
			a.s_month;


-- Excercise 4
SELECT		a.s_year,
			a.s_month,
			a.sales					AS monthly_sales,
			LAG(a.sales, 1) OVER (ORDER BY a.s_year,
										a.s_month
								) AS previous_month_sales,
			FORMAT(ROUND(	(a.sales / (LAG(a.sales, 1) OVER (ORDER BY a.s_year,
																	a.s_month
															)
									) - 1
							),
							1
						),
				'P'
				)				AS change
FROM		ap_sales a
ORDER BY	a.s_year,
			a.s_month;



-- *******************************************************
-- *                  Bonus Tracks                       *
-- *******************************************************
-- just to show a few more possibilities
-- of employing analytic functions 

-- cumulative monthly sales: overall, start anew each year, start anew each quarter
SELECT		a.s_year,
			a.s_month,
			a.sales						AS monthly_sales,
			SUM(a.sales) OVER (ORDER BY a.s_year,
										a.s_month
							)		AS cum_monthly_sales,
			SUM(a.sales) OVER (PARTITION BY a.s_year
							ORDER BY a.s_year,
										a.s_month
							)		AS cum_monthly_sales_per_year,
			FLOOR((a.s_month + 2) / 3) AS quarter,
			SUM(a.sales) OVER (PARTITION BY a.s_year,
											FLOOR((a.s_month + 2) / 3)
							ORDER BY a.s_year,
										FLOOR((a.s_month + 2) / 3) + 1,
										a.s_month
							)		AS cum_quarterly_sales
FROM		ap_sales a
ORDER BY	a.s_year,
			a.s_month;


--  cumulative monthly sales per year and total yearly sales
SELECT		a.s_year,
			a.s_month,
			a.sales										AS monthly_sales,
			SUM(a.sales) OVER (PARTITION BY a.s_year
							ORDER BY a.s_year,
										a.s_month
							)						AS cum_monthly_sales_per_year,
			SUM(a.sales) OVER (PARTITION BY a.s_year) AS yearly_sales
FROM		ap_sales a
ORDER BY	a.s_year,
			a.s_month;


--  as before plus monthly sales' proportion of this year's sales 
SELECT		a.s_year,
			a.s_month,
			a.sales																AS monthly_sales,
			SUM(a.sales) OVER (PARTITION BY a.s_year
							ORDER BY a.s_year,
										a.s_month
							)												AS cum_monthly_sales_per_year,
			SUM(a.sales) OVER (PARTITION BY a.s_year)				AS yearly_sales,
			FORMAT(a.Sales / SUM(a.sales) OVER (PARTITION BY a.s_year), 'P') AS proportion_of_year
FROM		ap_sales a
ORDER BY	a.s_year,
			a.s_month;

