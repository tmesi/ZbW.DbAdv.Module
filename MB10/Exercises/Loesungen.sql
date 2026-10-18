USE OLAPExercise;
SELECT		kalenderwoche		= o.kalenderwoche,
			artikelgruppe		= o.artikelgruppe,
			verkauf				= SUM(o.anzahl) 
FROM		op_verkauf			AS o
WHERE		o.jahr				= 2011
AND			o.monat				= '03'
AND			o.warenkategorie	= 'Fisch'
GROUP BY	o.artikelgruppe,
			o.kalenderwoche
ORDER BY	o.kalenderwoche,
			o.artikelgruppe;

SELECT		kalenderwoche		= o.kalenderwoche,
			artikelgruppe		= o.artikelgruppe,
			verkauf				= SUM(o.anzahl) 
FROM		op_verkauf			AS o
WHERE		o.jahr				= 2011
AND			o.monat				= '03'
AND			o.warenkategorie	= 'Fisch'
GROUP BY	CUBE(o.artikelgruppe, o.kalenderwoche)
ORDER BY	o.kalenderwoche,
			o.artikelgruppe;


SELECT		kalenderwoche		= o.kalenderwoche,
			ort					= o.ort,
			artikelgruppe		= o.artikelgruppe,
			verkauf				= SUM(o.anzahl) 
FROM		op_verkauf			AS o
WHERE		o.jahr				= 2011
AND			o.monat				= '03'
AND			o.warenkategorie	= 'Fisch'
GROUP BY	ROLLUP(o.artikelgruppe, o.ort, o.kalenderwoche)
ORDER BY	o.kalenderwoche,
			o.ort,
			o.artikelgruppe;





-- Filialen Dimension 
SELECT		o.filialnr,
			o.filiale,
			o.plz,
			o.ort
INTO		dw_filialen_dmsn
FROM		op_verkauf o
GROUP BY	o.filialnr,
			o.filiale,
			o.plz,
			o.ort;

-- Artikel Dimension
SELECT		o.artnr,
			o.bezeichnung,
			o.artikelgruppe,
			o.warenkategorie,
			o.preis,
			o.mwst_satz
INTO		dw_artikel_dmsn
FROM		op_verkauf o
GROUP BY	o.artnr,
			o.bezeichnung,
			o.artikelgruppe,
			o.warenkategorie,
			o.preis,
			o.mwst_satz;

-- Zeit Dimension
SELECT		o.datum,
			o.monat,
			o.jahr,
			o.kalenderwoche,
			o.wochentag
INTO		dw_zeit_dmsn
FROM		op_verkauf o
GROUP BY	o.datum,
			o.monat,
			o.jahr,
			o.kalenderwoche,
			o.wochentag;

-- the Fact Table
SELECT	o.filialnr,
		o.artnr,
		o.datum,
		o.anzahl
INTO	dw_verkauf_fact
FROM	op_verkauf o;




-- declaring primary key constraints
ALTER TABLE dw_filialen_dmsn
ALTER COLUMN filialnr INT NOT NULL;
GO
ALTER TABLE dw_filialen_dmsn
ADD
PRIMARY KEY (filialnr);
GO

ALTER TABLE dw_artikel_dmsn
ALTER COLUMN artnr VARCHAR(12) NOT NULL;
GO
ALTER TABLE dw_artikel_dmsn
ADD
PRIMARY KEY (artnr);
GO

ALTER TABLE dw_zeit_dmsn
ALTER COLUMN datum DATETIME NOT NULL;
GO
ALTER TABLE dw_zeit_dmsn
ADD
PRIMARY KEY (datum);
GO




-- the primary key of the fact table is the concatenation of the primary keys of the dimensions
ALTER TABLE dw_verkauf_fact
ALTER COLUMN filialnr INT NOT NULL;
ALTER TABLE dw_verkauf_fact
ALTER COLUMN artnr VARCHAR(12) NOT NULL;
ALTER TABLE dw_verkauf_fact
ALTER COLUMN datum DATETIME NOT NULL;
GO
ALTER TABLE dw_verkauf_fact
ADD
PRIMARY KEY (filialnr, artnr, datum);
GO

-- declaring foreign key constraints on the fact table
ALTER TABLE dw_verkauf_fact
ADD
FOREIGN KEY (filialnr) REFERENCES dw_filialen_dmsn (filialnr);

ALTER TABLE dw_verkauf_fact
ADD
FOREIGN KEY (artnr) REFERENCES dw_artikel_dmsn (artnr);

ALTER TABLE dw_verkauf_fact
ADD
FOREIGN KEY (datum) REFERENCES dw_zeit_dmsn (datum);

