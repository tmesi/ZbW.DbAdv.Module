USE OLAPExercise

SELECT	*
FROM	dbo.op_verkauf;

--- GROUPING SETS ---
SELECT		ort,
			artikelgruppe,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	GROUPING SETS((artikelgruppe, ort), (ort));

SELECT		ort,
			artikelgruppe,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	artikelgruppe,
			ort
UNION ALL
SELECT		ort,
			NULL,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	ort;

--- CUBE ---
SELECT		jahr,
			artikelgruppe,
			ort,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	CUBE(jahr, artikelgruppe, ort);

SELECT		jahr,
			artikelgruppe,
			ort,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	jahr,
			artikelgruppe,
			ort
UNION ALL
SELECT		jahr,
			artikelgruppe,
			NULL,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	jahr,
			artikelgruppe
UNION ALL
SELECT		jahr,
			NULL,
			ort,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	jahr,
			ort
UNION ALL
SELECT		NULL,
			artikelgruppe,
			ort,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	artikelgruppe,
			ort
UNION ALL
SELECT		jahr,
			NULL,
			NULL,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	jahr
UNION ALL
SELECT		NULL,
			artikelgruppe,
			NULL,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	artikelgruppe
UNION ALL
SELECT		NULL,
			NULL,
			ort,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	ort
UNION ALL
SELECT	NULL,
		NULL,
		NULL,
		SUM(preis * anzahl)
FROM	dbo.op_verkauf;


--- ROLLUP ---
SELECT		jahr,
			artikelgruppe,
			ort,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	ROLLUP(jahr, artikelgruppe, ort);

SELECT		jahr,
			artikelgruppe,
			ort,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	jahr,
			artikelgruppe,
			ort
UNION ALL
SELECT		jahr,
			artikelgruppe,
			NULL,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	jahr,
			artikelgruppe
UNION ALL
SELECT		jahr,
			NULL,
			NULL,
			SUM(preis * anzahl)
FROM		dbo.op_verkauf
GROUP BY	jahr
UNION ALL
SELECT	NULL,
		NULL,
		NULL,
		SUM(preis * anzahl)
FROM	dbo.op_verkauf;

