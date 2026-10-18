USE master;
GO
IF EXISTS (
		SELECT		*
			FROM	sys.databases
			WHERE	name = 'TemporalDemo'
		)
BEGIN
	DROP DATABASE TemporalDemo;
END;
GO
CREATE DATABASE TemporalDemo;
ALTER DATABASE TemporalDemo
	SET RECOVERY SIMPLE
	WITH NO_WAIT;
GO
USE TemporalDemo;
GO


--#region CreateDWH

CREATE TABLE OP_VERKAUF
(
	FILIALNR		INT,
	FILIALE			VARCHAR(40),
	PLZ				CHAR(4),
	ORT				VARCHAR(30),
	ARTNR			VARCHAR(12),
	BEZEICHNUNG		VARCHAR(40),
	ARTIKELGRUPPE	VARCHAR(40),
	WARENKATEGORIE	VARCHAR(40),
	PREIS			DECIMAL(16, 2),
	MWST_SATZ		DECIMAL(16, 2),
	DATUM			DATETIME,
	MONAT			CHAR(2),
	JAHR			INT,
	KALENDERWOCHE	CHAR(2),
	WOCHENTAG		VARCHAR(10),
	ANZAHL			INT
);

INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 52);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 101);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 39);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 93);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 58);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 54);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 45);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 112);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 61);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 56);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 115);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 120);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 93);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 22);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 93);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 94);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 99);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 63);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 45);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 12);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 33);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 55);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 92);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 85);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 83);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 83);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 34);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 56);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 94);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 31);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 12);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 2);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 16);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 108);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 56);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 31);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 75);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 51);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 8);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 95);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 6);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 118);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 121);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 8);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 37);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 4);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 83);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 107);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 72);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 40);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 60);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 109);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 18);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 5);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 31);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 16);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 70);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 4);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 42);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 106);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 92);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 56);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 0);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 124);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 44);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 123);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 2);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 72);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 92);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 57);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 9);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 54);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 25);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 76);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 61);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 8);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 103);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 9);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 70);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 95);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 105);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 107);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 114);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 86);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 84);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 111);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 104);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 31);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 121);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 51);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 18);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 44);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 76);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 35);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 63);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 103);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 57);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 48);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 55);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 58);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 112);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 45);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 41);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 58);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 84);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 31);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 11);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 96);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 105);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 95);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 82);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 72);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 7);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 18);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 122);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 17);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 16);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 101);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 41);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 6);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 61);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 103);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 107);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 31);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 69);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 49);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 71);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 22);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 30);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 77);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 44);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 108);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 57);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 94);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 23);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 97);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 106);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 4);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 0);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 118);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 30);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 47);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 51);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 86);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 47);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 0);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 61);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 70);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 5);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 12);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 97);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 122);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 108);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 71);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 7);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 6);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 108);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 38);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 84);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 88);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 97);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 77);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 75);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 98);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 93);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 21);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 105);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 22);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 39);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 60);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 5);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 29);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 52);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 60);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 71);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 30);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 124);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 118);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 67);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 77);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 61);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 111);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 52);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 113);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 9);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 82);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 1);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 48);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 79);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 115);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 21);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 112);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 84);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 99);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 112);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 17);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 114);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 6);
INSERT INTO OP_VERKAUF
VALUES
(50, 'Aarau Centrum', '5001', 'Aarau', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 59);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '03-FEB-2011'), '02', 2011, '06', 'DIENSTAG', 385);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '08-FEB-2011'), '02', 2011, '06', 'SONNTAG', 766);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '13-FEB-2011'), '02', 2011, '07', 'FREITAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '16-FEB-2011'), '02', 2011, '08', 'MONTAG', 1014);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '25-FEB-2011'), '02', 2011, '09', 'MITTWOCH', 489);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '01-MAR-2011'), '03', 2011, '09', 'SONNTAG', 511);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '04-MAR-2011'), '03', 2011, '10', 'MITTWOCH', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '05-MAR-2011'), '03', 2011, '10', 'DONNERSTAG', 814);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '07-MAR-2011'), '03', 2011, '10', 'SAMSTAG', 603);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '22-MAR-2011'), '03', 2011, '12', 'SONNTAG', 959);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '02-FEB-2011'), '02', 2011, '06', 'MONTAG', 325);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '04-FEB-2011'), '02', 2011, '06', 'MITTWOCH', 706);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '14-FEB-2011'), '02', 2011, '07', 'SAMSTAG', 480);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '18-FEB-2011'), '02', 2011, '08', 'MITTWOCH', 114);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '24-FEB-2011'), '02', 2011, '09', 'DIENSTAG', 289);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '01-MAR-2011'), '03', 2011, '09', 'SONNTAG', 451);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '05-MAR-2011'), '03', 2011, '10', 'DONNERSTAG', 279);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '07-MAR-2011'), '03', 2011, '10', 'SAMSTAG', 514);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '09-MAR-2011'), '03', 2011, '11', 'MONTAG', 663);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '12-MAR-2011'), '03', 2011, '11', 'DONNERSTAG', 379);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '01-JAN-2011'), '01', 2011, '01', 'DONNERSTAG', 285);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '04-JAN-2011'), '01', 2011, '01', 'SONNTAG', 166);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '05-JAN-2011'), '01', 2011, '02', 'MONTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '06-JAN-2011'), '01', 2011, '02', 'DIENSTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '10-JAN-2011'), '01', 2011, '02', 'SAMSTAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '11-JAN-2011'), '01', 2011, '02', 'SONNTAG', 211);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '14-JAN-2011'), '01', 2011, '03', 'MITTWOCH', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '15-JAN-2011'), '01', 2011, '03', 'DONNERSTAG', 314);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '27-JAN-2011'), '01', 2011, '05', 'DIENSTAG', 303);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '29-JAN-2011'), '01', 2011, '05', 'DONNERSTAG', 259);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '01-FEB-2011'), '02', 2011, '05', 'SONNTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '09-FEB-2011'), '02', 2011, '07', 'MONTAG', 106);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '09-FEB-2011'), '02', 2011, '07', 'MONTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '10-FEB-2011'), '02', 2011, '07', 'DIENSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '10-FEB-2011'), '02', 2011, '07', 'DIENSTAG', 389);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '11-FEB-2011'), '02', 2011, '07', 'MITTWOCH', 151);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '15-FEB-2011'), '02', 2011, '07', 'SONNTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '17-FEB-2011'), '02', 2011, '08', 'DIENSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '19-FEB-2011'), '02', 2011, '08', 'DONNERSTAG', 263);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '28-FEB-2011'), '02', 2011, '09', 'SAMSTAG', 109);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '03-FEB-2011'), '02', 2011, '06', 'DIENSTAG', 285);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '08-FEB-2011'), '02', 2011, '06', 'SONNTAG', 166);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '13-FEB-2011'), '02', 2011, '07', 'FREITAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '16-FEB-2011'), '02', 2011, '08', 'MONTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '25-FEB-2011'), '02', 2011, '09', 'MITTWOCH', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '01-MAR-2011'), '03', 2011, '09', 'SONNTAG', 211);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '04-MAR-2011'), '03', 2011, '10', 'MITTWOCH', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '05-MAR-2011'), '03', 2011, '10', 'DONNERSTAG', 314);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '07-MAR-2011'), '03', 2011, '10', 'SAMSTAG', 303);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '22-MAR-2011'), '03', 2011, '12', 'SONNTAG', 259);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '02-FEB-2011'), '02', 2011, '06', 'MONTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '04-FEB-2011'), '02', 2011, '06', 'MITTWOCH', 106);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '14-FEB-2011'), '02', 2011, '07', 'SAMSTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '18-FEB-2011'), '02', 2011, '08', 'MITTWOCH', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '24-FEB-2011'), '02', 2011, '09', 'DIENSTAG', 389);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '04-MAR-2011'), '03', 2011, '10', 'MITTWOCH', 151);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '05-MAR-2011'), '03', 2011, '10', 'DONNERSTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '07-MAR-2011'), '03', 2011, '10', 'SAMSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '09-MAR-2011'), '03', 2011, '11', 'MONTAG', 263);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '12-MAR-2011'), '03', 2011, '11', 'DONNERSTAG', 109);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '01-JAN-2011'), '01', 2011, '01', 'DONNERSTAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '04-JAN-2011'), '01', 2011, '01', 'SONNTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '05-JAN-2011'), '01', 2011, '02', 'MONTAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-JAN-2011'), '01', 2011, '02', 'DIENSTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '10-JAN-2011'), '01', 2011, '02', 'SAMSTAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '11-JAN-2011'), '01', 2011, '02', 'SONNTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '14-JAN-2011'), '01', 2011, '03', 'MITTWOCH', 79);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '15-JAN-2011'), '01', 2011, '03', 'DONNERSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '27-JAN-2011'), '01', 2011, '05', 'DIENSTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '29-JAN-2011'), '01', 2011, '05', 'DONNERSTAG', 59);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '01-FEB-2011'), '02', 2011, '05', 'SONNTAG', 25);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '09-FEB-2011'), '02', 2011, '07', 'MONTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '09-FEB-2011'), '02', 2011, '07', 'MONTAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '10-FEB-2011'), '02', 2011, '07', 'DIENSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '10-FEB-2011'), '02', 2011, '07', 'DIENSTAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '11-FEB-2011'), '02', 2011, '07', 'MITTWOCH', 51);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '15-FEB-2011'), '02', 2011, '07', 'SONNTAG', 79);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '17-FEB-2011'), '02', 2011, '08', 'DIENSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '19-FEB-2011'), '02', 2011, '08', 'DONNERSTAG', 63);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '28-FEB-2011'), '02', 2011, '09', 'SAMSTAG', 99);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '03-FEB-2011'), '02', 2011, '06', 'DIENSTAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '08-FEB-2011'), '02', 2011, '06', 'SONNTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '13-FEB-2011'), '02', 2011, '07', 'FREITAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '16-FEB-2011'), '02', 2011, '08', 'MONTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '25-FEB-2011'), '02', 2011, '09', 'MITTWOCH', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '01-MAR-2011'), '03', 2011, '09', 'SONNTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '04-MAR-2011'), '03', 2011, '10', 'MITTWOCH', 79);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-MAR-2011'), '03', 2011, '10', 'FREITAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '07-MAR-2011'), '03', 2011, '10', 'SAMSTAG', 83);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '22-MAR-2011'), '03', 2011, '12', 'SONNTAG', 59);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '02-FEB-2011'), '02', 2011, '06', 'MONTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '04-FEB-2011'), '02', 2011, '06', 'MITTWOCH', 106);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '14-FEB-2011'), '02', 2011, '07', 'SAMSTAG', 155);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '18-FEB-2011'), '02', 2011, '08', 'MITTWOCH', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '24-FEB-2011'), '02', 2011, '09', 'DIENSTAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '09-MAR-2011'), '03', 2011, '11', 'MONTAG', 161);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '05-MAR-2011'), '03', 2011, '10', 'DONNERSTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '07-MAR-2011'), '03', 2011, '10', 'SAMSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '09-MAR-2011'), '03', 2011, '11', 'MONTAG', 93);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '12-MAR-2011'), '03', 2011, '11', 'DONNERSTAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '02-FEB-2011'), '02', 2011, '06', 'MONTAG', 25);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '04-FEB-2011'), '02', 2011, '06', 'MITTWOCH', 16);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '14-FEB-2011'), '02', 2011, '07', 'SAMSTAG', 15);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '18-FEB-2011'), '02', 2011, '08', 'MITTWOCH', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '24-FEB-2011'), '02', 2011, '09', 'DIENSTAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '04-MAR-2011'), '03', 2011, '10', 'MITTWOCH', 61);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '05-MAR-2011'), '03', 2011, '10', 'DONNERSTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '07-MAR-2011'), '03', 2011, '10', 'SAMSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '09-MAR-2011'), '03', 2011, '11', 'MONTAG', 23);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '12-MAR-2011'), '03', 2011, '11', 'DONNERSTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '01-JAN-2011'), '01', 2011, '01', 'DONNERSTAG', 15);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '04-JAN-2011'), '01', 2011, '01', 'SONNTAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '05-JAN-2011'), '01', 2011, '02', 'MONTAG', 30);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '06-JAN-2011'), '01', 2011, '02', 'DIENSTAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '10-JAN-2011'), '01', 2011, '02', 'SAMSTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '13-JAN-2011'), '01', 2011, '03', 'DIENSTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '14-JAN-2011'), '01', 2011, '03', 'MITTWOCH', 29);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '05-FEB-2011'), '02', 2011, '06', 'DONNERSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '07-FEB-2011'), '02', 2011, '06', 'SAMSTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '19-FEB-2011'), '02', 2011, '08', 'DONNERSTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '01-JUL-2010'), '07', 2010, '27', 'DIENSTAG', 285);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '04-JUL-2010'), '07', 2010, '27', 'FREITAG', 166);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '05-JUL-2010'), '07', 2010, '27', 'SAMSTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '06-JUL-2010'), '07', 2010, '27', 'SONNTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '10-JUL-2010'), '07', 2010, '28', 'DONNERSTAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '11-JUL-2010'), '07', 2010, '28', 'FREITAG', 211);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '14-JUL-2010'), '07', 2010, '29', 'MONTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '15-JUL-2010'), '07', 2010, '29', 'DIENSTAG', 314);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '27-JUL-2010'), '07', 2010, '30', 'SONNTAG', 303);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '29-JUL-2010'), '07', 2010, '31', 'DIENSTAG', 259);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '01-AUG-2010'), '08', 2010, '31', 'FREITAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '09-AUG-2010'), '08', 2010, '32', 'SAMSTAG', 106);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '09-AUG-2010'), '08', 2010, '32', 'SAMSTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '10-AUG-2010'), '08', 2010, '32', 'SONNTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '10-AUG-2010'), '08', 2010, '32', 'SONNTAG', 389);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '11-AUG-2010'), '08', 2010, '33', 'MONTAG', 151);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '15-AUG-2010'), '08', 2010, '33', 'FREITAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '17-AUG-2010'), '08', 2010, '33', 'SONNTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '19-AUG-2010'), '08', 2010, '34', 'DIENSTAG', 263);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '28-AUG-2010'), '08', 2010, '35', 'DONNERSTAG', 109);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '03-AUG-2010'), '08', 2010, '31', 'SONNTAG', 285);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '08-AUG-2010'), '08', 2010, '32', 'FREITAG', 166);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '13-AUG-2010'), '08', 2010, '33', 'MITTWOCH', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '16-AUG-2010'), '08', 2010, '33', 'SAMSTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '25-AUG-2010'), '08', 2010, '35', 'MONTAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '01-OCT-2010'), '10', 2010, '40', 'MITTWOCH', 211);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '04-OCT-2010'), '10', 2010, '40', 'SAMSTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '05-OCT-2010'), '10', 2010, '40', 'SONNTAG', 307);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '07-OCT-2010'), '10', 2010, '41', 'DIENSTAG', 303);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '22-OCT-2010'), '10', 2010, '43', 'MITTWOCH', 259);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '02-AUG-2010'), '08', 2010, '31', 'SAMSTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '04-AUG-2010'), '08', 2010, '32', 'MONTAG', 106);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '14-AUG-2010'), '08', 2010, '33', 'DONNERSTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '18-AUG-2010'), '08', 2010, '34', 'MONTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '24-AUG-2010'), '08', 2010, '34', 'SONNTAG', 389);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '04-OCT-2010'), '10', 2010, '40', 'SAMSTAG', 151);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '05-OCT-2010'), '10', 2010, '40', 'SONNTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '07-OCT-2010'), '10', 2010, '41', 'DIENSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '09-OCT-2010'), '10', 2010, '41', 'DONNERSTAG', 263);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '12-OCT-2010'), '10', 2010, '41', 'SONNTAG', 109);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '01-JUL-2010'), '07', 2010, '27', 'DIENSTAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '04-JUL-2010'), '07', 2010, '27', 'FREITAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '05-JUL-2010'), '07', 2010, '27', 'SAMSTAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-JUL-2010'), '07', 2010, '27', 'SONNTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '10-JUL-2010'), '07', 2010, '28', 'DONNERSTAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '11-JUL-2010'), '07', 2010, '28', 'FREITAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '14-JUL-2010'), '07', 2010, '29', 'MONTAG', 79);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '15-JUL-2010'), '07', 2010, '29', 'DIENSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '27-JUL-2010'), '07', 2010, '30', 'SONNTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '29-JUL-2010'), '07', 2010, '31', 'DIENSTAG', 59);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '01-AUG-2010'), '08', 2010, '31', 'FREITAG', 25);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '09-AUG-2010'), '08', 2010, '32', 'SAMSTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '09-AUG-2010'), '08', 2010, '32', 'SAMSTAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '10-AUG-2010'), '08', 2010, '32', 'SONNTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '10-AUG-2010'), '08', 2010, '32', 'SONNTAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '11-AUG-2010'), '08', 2010, '33', 'MONTAG', 51);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '15-AUG-2010'), '08', 2010, '33', 'FREITAG', 79);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '17-AUG-2010'), '08', 2010, '33', 'SONNTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '19-AUG-2010'), '08', 2010, '34', 'DIENSTAG', 63);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '28-AUG-2010'), '08', 2010, '35', 'DONNERSTAG', 99);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '03-AUG-2010'), '08', 2010, '31', 'SONNTAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '08-AUG-2010'), '08', 2010, '32', 'FREITAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '13-AUG-2010'), '08', 2010, '33', 'MITTWOCH', 80);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '16-AUG-2010'), '08', 2010, '33', 'SAMSTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '25-AUG-2010'), '08', 2010, '35', 'MONTAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '01-OCT-2010'), '10', 2010, '40', 'MITTWOCH', 11);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '04-OCT-2010'), '10', 2010, '40', 'SAMSTAG', 79);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-OCT-2010'), '10', 2010, '41', 'MONTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '07-OCT-2010'), '10', 2010, '41', 'DIENSTAG', 83);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '22-OCT-2010'), '10', 2010, '43', 'MITTWOCH', 59);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '02-AUG-2010'), '08', 2010, '31', 'SAMSTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '04-AUG-2010'), '08', 2010, '32', 'MONTAG', 106);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '14-AUG-2010'), '08', 2010, '33', 'DONNERSTAG', 155);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '18-AUG-2010'), '08', 2010, '34', 'MONTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '24-AUG-2010'), '08', 2010, '34', 'SONNTAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '09-OCT-2010'), '10', 2010, '41', 'DONNERSTAG', 161);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '05-OCT-2010'), '10', 2010, '40', 'SONNTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '07-OCT-2010'), '10', 2010, '41', 'DIENSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '09-OCT-2010'), '10', 2010, '41', 'DONNERSTAG', 93);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '12-OCT-2010'), '10', 2010, '41', 'SONNTAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '02-AUG-2010'), '08', 2010, '31', 'SAMSTAG', 25);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '04-AUG-2010'), '08', 2010, '32', 'MONTAG', 16);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '14-AUG-2010'), '08', 2010, '33', 'DONNERSTAG', 15);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '18-AUG-2010'), '08', 2010, '34', 'MONTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '24-AUG-2010'), '08', 2010, '34', 'SONNTAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '04-OCT-2010'), '10', 2010, '40', 'SAMSTAG', 61);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '05-OCT-2010'), '10', 2010, '40', 'SONNTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '07-OCT-2010'), '10', 2010, '41', 'DIENSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '09-OCT-2010'), '10', 2010, '41', 'DONNERSTAG', 23);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '12-OCT-2010'), '10', 2010, '41', 'SONNTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '01-JUL-2010'), '07', 2010, '27', 'DIENSTAG', 15);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '04-JUL-2010'), '07', 2010, '27', 'FREITAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '05-JUL-2010'), '07', 2010, '27', 'SAMSTAG', 30);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '06-JUL-2010'), '07', 2010, '27', 'SONNTAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '10-JUL-2010'), '07', 2010, '28', 'DONNERSTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '13-JUL-2010'), '07', 2010, '28', 'SONNTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '14-JUL-2010'), '07', 2010, '29', 'MONTAG', 29);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '05-AUG-2010'), '08', 2010, '32', 'DIENSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '07-AUG-2010'), '08', 2010, '32', 'DONNERSTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '19-AUG-2010'), '08', 2010, '34', 'DIENSTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '17-OCT-2010'), '10', 2010, '42', 'FREITAG', 23);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '19-OCT-2010'), '10', 2010, '42', 'SONNTAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '11-AUG-2010'), '08', 2010, '33', 'MONTAG', 67);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '02-AUG-2010'), '08', 2010, '31', 'SAMSTAG', 56);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '07-DEC-2010'), '12', 2010, '49', 'SONNTAG', 93);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '08-DEC-2010'), '12', 2010, '50', 'MONTAG', 107);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '20-DEC-2010'), '12', 2010, '51', 'SAMSTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-DEC-2010'), '12', 2010, '51', 'SONNTAG', 37);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '11-DEC-2010'), '12', 2010, '50', 'DONNERSTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '14-DEC-2010'), '12', 2010, '50', 'SONNTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '15-DEC-2010'), '12', 2010, '51', 'MONTAG', 364);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '27-DEC-2010'), '12', 2010, '52', 'SAMSTAG', 303);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '29-DEC-2010'), '12', 2010, '01', 'MONTAG', 59);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '01-DEC-2010'), '12', 2010, '49', 'MONTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '09-DEC-2010'), '12', 2010, '50', 'DIENSTAG', 106);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '09-DEC-2010'), '12', 2010, '50', 'DIENSTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '01-DEC-2010'), '12', 2010, '49', 'MONTAG', 211);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '04-DEC-2010'), '12', 2010, '49', 'DONNERSTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '05-DEC-2010'), '12', 2010, '49', 'FREITAG', 307);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '07-DEC-2010'), '12', 2010, '49', 'SONNTAG', 33);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '22-DEC-2010'), '12', 2010, '52', 'MONTAG', 259);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '02-DEC-2010'), '12', 2010, '49', 'DIENSTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '04-DEC-2010'), '12', 2010, '49', 'DONNERSTAG', 156);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '14-DEC-2010'), '12', 2010, '50', 'SONNTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '18-DEC-2010'), '12', 2010, '51', 'DONNERSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '07-DEC-2010'), '12', 2010, '49', 'SONNTAG', 264);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '31-DEC-2010'), '12', 2010, '01', 'MITTWOCH', 233);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '12-DEC-2010'), '12', 2010, '50', 'FREITAG', 109);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '01-DEC-2010'), '12', 2010, '49', 'MONTAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '04-DEC-2010'), '12', 2010, '49', 'DONNERSTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '05-DEC-2010'), '12', 2010, '49', 'FREITAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-DEC-2010'), '12', 2010, '49', 'SAMSTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '10-DEC-2010'), '12', 2010, '50', 'MITTWOCH', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '11-DEC-2010'), '12', 2010, '50', 'DONNERSTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '24-DEC-2010'), '12', 2010, '52', 'MITTWOCH', 79);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '15-DEC-2010'), '12', 2010, '51', 'MONTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '27-DEC-2010'), '12', 2010, '52', 'SAMSTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '29-DEC-2010'), '12', 2010, '01', 'MONTAG', 59);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '04-DEC-2010'), '12', 2010, '49', 'DONNERSTAG', 79);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '31-DEC-2010'), '12', 2010, '01', 'MITTWOCH', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '31-DEC-2010'), '12', 2010, '01', 'MITTWOCH', 83);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '22-DEC-2010'), '12', 2010, '52', 'MONTAG', 59);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '02-DEC-2010'), '12', 2010, '49', 'DIENSTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '18-DEC-2010'), '12', 2010, '51', 'DONNERSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '23-DEC-2010'), '12', 2010, '52', 'DIENSTAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '09-DEC-2010'), '12', 2010, '50', 'DIENSTAG', 161);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '07-DEC-2010'), '12', 2010, '49', 'SONNTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '09-DEC-2010'), '12', 2010, '50', 'DIENSTAG', 93);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '12-DEC-2010'), '12', 2010, '50', 'FREITAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '02-DEC-2010'), '12', 2010, '49', 'DIENSTAG', 25);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '04-DEC-2010'), '12', 2010, '49', 'DONNERSTAG', 16);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '14-DEC-2010'), '12', 2010, '50', 'SONNTAG', 15);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '18-DEC-2010'), '12', 2010, '51', 'DONNERSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '24-DEC-2010'), '12', 2010, '52', 'MITTWOCH', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '05-DEC-2010'), '12', 2010, '49', 'FREITAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '07-DEC-2010'), '12', 2010, '49', 'SONNTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '09-DEC-2010'), '12', 2010, '50', 'DIENSTAG', 23);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '12-DEC-2010'), '12', 2010, '50', 'FREITAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '04-DEC-2010'), '12', 2010, '49', 'DONNERSTAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '06-DEC-2010'), '12', 2010, '49', 'SAMSTAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '10-DEC-2010'), '12', 2010, '50', 'MITTWOCH', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '13-DEC-2010'), '12', 2010, '50', 'SAMSTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '19-DEC-2010'), '12', 2010, '51', 'FREITAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '17-DEC-2010'), '12', 2010, '51', 'MITTWOCH', 23);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '30-DEC-2010'), '12', 2010, '01', 'DIENSTAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '22-DEC-2010'), '12', 2010, '52', 'MONTAG', 67);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '11-AUG-2010'), '08', 2010, '33', 'MONTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '14-AUG-2010'), '08', 2010, '33', 'DONNERSTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '15-AUG-2010'), '08', 2010, '33', 'FREITAG', 364);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '27-AUG-2010'), '08', 2010, '35', 'MITTWOCH', 303);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '29-AUG-2010'), '08', 2010, '35', 'FREITAG', 59);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '01-AUG-2010'), '08', 2010, '31', 'FREITAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '09-AUG-2010'), '08', 2010, '32', 'SAMSTAG', 106);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '09-AUG-2010'), '08', 2010, '32', 'SAMSTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '01-AUG-2010'), '08', 2010, '31', 'FREITAG', 211);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '04-AUG-2010'), '08', 2010, '32', 'MONTAG', 179);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '05-AUG-2010'), '08', 2010, '32', 'DIENSTAG', 307);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '07-AUG-2010'), '08', 2010, '32', 'DONNERSTAG', 33);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '22-SEP-2010'), '09', 2010, '39', 'MONTAG', 259);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '02-SEP-2010'), '09', 2010, '36', 'DIENSTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '04-SEP-2010'), '09', 2010, '36', 'DONNERSTAG', 156);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '14-SEP-2010'), '09', 2010, '37', 'SONNTAG', 180);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '18-SEP-2010'), '09', 2010, '38', 'DONNERSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '07-SEP-2010'), '09', 2010, '36', 'SONNTAG', 264);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '30-SEP-2010'), '09', 2010, '40', 'DIENSTAG', 233);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '12-SEP-2010'), '09', 2010, '37', 'FREITAG', 109);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '01-SEP-2010'), '09', 2010, '36', 'MONTAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '04-OCT-2010'), '10', 2010, '40', 'SAMSTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '05-OCT-2010'), '10', 2010, '40', 'SONNTAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-OCT-2010'), '10', 2010, '41', 'MONTAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '10-OCT-2010'), '10', 2010, '41', 'FREITAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '11-OCT-2010'), '10', 2010, '41', 'SAMSTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '24-OCT-2010'), '10', 2010, '43', 'FREITAG', 79);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '15-OCT-2010'), '10', 2010, '42', 'MITTWOCH', 14);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '27-OCT-2010'), '10', 2010, '44', 'MONTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '29-OCT-2010'), '10', 2010, '44', 'MITTWOCH', 59);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '04-OCT-2010'), '10', 2010, '40', 'SAMSTAG', 79);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '28-NOV-2010'), '11', 2010, '48', 'FREITAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '29-NOV-2010'), '11', 2010, '48', 'SAMSTAG', 83);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '22-NOV-2010'), '11', 2010, '47', 'SAMSTAG', 59);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '02-NOV-2010'), '11', 2010, '44', 'SONNTAG', 125);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '18-NOV-2010'), '11', 2010, '47', 'DIENSTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '23-NOV-2010'), '11', 2010, '47', 'SONNTAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '09-NOV-2010'), '11', 2010, '45', 'SONNTAG', 161);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '07-DEC-2010'), '12', 2010, '49', 'SONNTAG', 214);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '09-DEC-2010'), '12', 2010, '50', 'DIENSTAG', 93);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '12-DEC-2010'), '12', 2010, '50', 'FREITAG', 189);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '02-DEC-2010'), '12', 2010, '49', 'DIENSTAG', 25);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '04-DEC-2010'), '12', 2010, '49', 'DONNERSTAG', 16);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '14-DEC-2010'), '12', 2010, '50', 'SONNTAG', 15);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '18-DEC-2010'), '12', 2010, '51', 'DONNERSTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '24-DEC-2010'), '12', 2010, '52', 'MITTWOCH', 89);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '05-DEC-2010'), '12', 2010, '49', 'FREITAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '07-DEC-2010'), '12', 2010, '49', 'SONNTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '09-DEC-2010'), '12', 2010, '50', 'DIENSTAG', 23);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '12-DEC-2010'), '12', 2010, '50', 'FREITAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '04-DEC-2010'), '12', 2010, '49', 'DONNERSTAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '06-DEC-2010'), '12', 2010, '49', 'SAMSTAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '10-DEC-2010'), '12', 2010, '50', 'MITTWOCH', 19);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '13-DEC-2010'), '12', 2010, '50', 'SAMSTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '19-DEC-2010'), '12', 2010, '51', 'FREITAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '17-DEC-2010'), '12', 2010, '51', 'MITTWOCH', 23);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '30-DEC-2010'), '12', 2010, '01', 'DIENSTAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(30, 'Winterthur Bahnhof', '8400', 'Winterthur', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '22-DEC-2010'), '12', 2010, '52', 'MONTAG', 67);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '04-MAR-2011'), '03', 2011, '10', 'MITTWOCH', 2);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '05-MAR-2011'), '03', 2011, '10', 'DONNERSTAG', 5);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '11-JAN-2011'), '01', 2011, '02', 'SONNTAG', 1);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '12-FEB-2011'), '02', 2011, '07', 'DONNERSTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '12-MAR-2011'), '03', 2011, '11', 'DONNERSTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '12-JUL-2010'), '07', 2010, '28', 'SAMSTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 73);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 72);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 116);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 94);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 77);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 98);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 95);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 84);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 116);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 18);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 27);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 67);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 120);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 37);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 0);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 63);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 55);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 73);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 112);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 69);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 41);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 82);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 108);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 18);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 12);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 105);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 33);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 76);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 108);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 113);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 82);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 101);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 47);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 10);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 17);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 117);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 30);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 39);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 98);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 43);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 41);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 82);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 105);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 28);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 67);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 63);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 105);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 21);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 57);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 16);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 34);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 115);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 4);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 12);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 75);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 120);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 112);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 109);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 98);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 28);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 121);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 41);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 93);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 107);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 103);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 83);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 30);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 8);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 90);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 8);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 98);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 29);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 41);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 103);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 34);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 89);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 123);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 84);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 28);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8,
3.5, CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 32);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 48);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 40);
INSERT INTO OP_VERKAUF
VALUES
(22, 'St. Gallen Marktplatz', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 41);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 112);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 119);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 22);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 49);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 115);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 107);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 95);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 77);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 1);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 70);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 113);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 123);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 95);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 76);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 68);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 107);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 60);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 41);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 73);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 88);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 60);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 1);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 74);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 3);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 42);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 99);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 121);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 82);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 37);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 34);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 32);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 33);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 77);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 30);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 1);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 17);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 41);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 62);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 87);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 16);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 61);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 28);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 68);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 63);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 118);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 35);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 107);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 67);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 45);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 111);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 35);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 40);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 2);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 63);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '03-MAR-2011'), '03', 2011, '10', 'DIENSTAG', 17);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 27);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 68);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 23);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 71);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 5);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 4);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 22);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 48);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '21-NOV-2010'), '11', 2010, '47', 'FREITAG', 107);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 24);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 62);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 68);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 112);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 45);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 80);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 29);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 123);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '19-NOV-2010'), '11', 2010, '47', 'MITTWOCH', 32);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 23);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 31);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 114);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 70);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 71);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 111);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 56);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '30-NOV-2010'), '11', 2010, '48', 'SONNTAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 61);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 4);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 13);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 90);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 28);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 72);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 27);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 42);
INSERT INTO OP_VERKAUF
VALUES
(23, 'Zuerich Bahnhof', '8001', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke', 1.55,
3.5, CONVERT(DATETIME, '25-SEP-2010'), '09', 2010, '39', 'DONNERSTAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 43);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 99);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 97);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 26);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 1);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 11);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 22);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '21-MAR-2011'), '03', 2011, '12', 'SAMSTAG', 79);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 53);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 6);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 0);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 31);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 70);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 6);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 85);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '06-FEB-2011'), '02', 2011, '06', 'FREITAG', 66);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 49);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 117);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 37);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 14);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 97);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 107);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 28);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '13-MAR-2011'), '03', 2011, '11', 'FREITAG', 95);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 70);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 24);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 7);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 114);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 57);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 36);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 20);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '02-MAR-2011'), '03', 2011, '10', 'MONTAG', 31);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 1);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 7);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 80);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 79);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 19);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 102);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 114);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 53);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.7812', 'Fanta light', 'Erfrischungsgetränke', 'Getränke',
1.55, 3.5, CONVERT(DATETIME, '12-JAN-2011'), '01', 2011, '03', 'MONTAG', 96);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1002', 'Forelle', 'Suesswasserfisch', 'Fisch', 29.72, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 119);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1156', 'Seeteufel', 'Seefisch', 'Fisch', 45, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 114);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-1158', 'King Prawns', 'Krustentiere', 'Fisch', 58.5, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 88);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3362', 'Paprika-Cracker', 'Salzgebäck', 'Gebäck', 3.9, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 83);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-3369', 'Salzstangen', 'Salzgebäck', 'Gebäck', 1.8, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 117);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-123-125', 'Randen, rot, CH', 'Frischgemüse', 'Gemüse', 3.8, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 94);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-5668', 'Randen Bio', 'Gemüse abgepackt', 'Gemüse', 2.75, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 45);
INSERT INTO OP_VERKAUF
VALUES
(26, 'St. Gallen St. Fiden', '8055', 'St. Gallen', 'FD-56.9003', 'Valser', 'Mineralwässer', 'Getränke', 1.7, 3.5,
CONVERT(DATETIME, '31-JAN-2011'), '01', 2011, '05', 'SAMSTAG', 31);

GO
--#endregion


IF OBJECT_ID('dbo.dw_verkauf_fact', 'U') IS NOT NULL
BEGIN
	DROP TABLE dw_verkauf_fact;
END;
IF OBJECT_ID('dbo.dw_filialen_dmsn', 'U') IS NOT NULL
BEGIN
	ALTER TABLE dw_filialen_dmsn SET (SYSTEM_VERSIONING = OFF);
	DROP TABLE dw_filialen_dmsn;
	DROP TABLE dw_filialen_dmsnHistory;
END;
IF OBJECT_ID('dbo.dw_artikel_dmsn', 'U') IS NOT NULL
BEGIN
	ALTER TABLE dw_artikel_dmsn SET (SYSTEM_VERSIONING = OFF);
	DROP TABLE dw_artikel_dmsn;
	DROP TABLE dw_artikel_dmsnHistory;
END;
IF OBJECT_ID('dbo.dw_zeit_dmsn', 'U') IS NOT NULL
BEGIN
	ALTER TABLE dw_zeit_dmsn SET (SYSTEM_VERSIONING = OFF);
	DROP TABLE dw_zeit_dmsn;
	DROP TABLE dw_zeit_dmsnHistory;
END;

CREATE TABLE [dbo].[dw_filialen_dmsn]
(
	[filialnr]	[INT]			NOT NULL PRIMARY KEY,
	[filiale]	[VARCHAR](40)	NULL,
	[plz]		[CHAR](4)		NULL,
	[ort]		[VARCHAR](30)	NULL,
	valid_from	DATETIME2		GENERATED ALWAYS AS ROW START
		CONSTRAINT DF_dw_filialen_dmsn_valid_from
			DEFAULT SYSUTCDATETIME() NOT NULL,
	valid_until DATETIME2	GENERATED ALWAYS AS ROW END
		CONSTRAINT DF_dw_filialen_dmsn_valid_until
			DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59') NOT NULL,
	PERIOD FOR SYSTEM_TIME(valid_from, valid_until)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.dw_filialen_dmsnHistory));
GO

CREATE TABLE [dbo].[dw_artikel_dmsn]
(
	[artnr]				[VARCHAR](12)		NOT NULL PRIMARY KEY,
	[bezeichnung]		[VARCHAR](40)		NULL,
	[artikelgruppe]		[VARCHAR](40)		NULL,
	[warenkategorie]	[VARCHAR](40)		NULL,
	[preis]				[DECIMAL](16, 2) NULL,
	[mwst_satz]			[DECIMAL](16, 2) NULL,
	valid_from			DATETIME2			GENERATED ALWAYS AS ROW START
		CONSTRAINT DF_dw_artikel_dmsn_valid_from
			DEFAULT SYSUTCDATETIME() NOT NULL,
	valid_until			DATETIME2			GENERATED ALWAYS AS ROW END
		CONSTRAINT DF_dw_artikel_dmsn_valid_until
			DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59') NOT NULL,
	PERIOD FOR SYSTEM_TIME(valid_from, valid_until)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.dw_artikel_dmsnHistory));
GO

CREATE TABLE [dbo].[dw_zeit_dmsn]
(
	[datum]			[DATETIME]		NOT NULL PRIMARY KEY,
	[monat]			[CHAR](2)		NULL,
	[jahr]			[INT]			NULL,
	[kalenderwoche] [CHAR](2)	NULL,
	[wochentag]		[VARCHAR](10)	NULL,
	valid_from		DATETIME2		GENERATED ALWAYS AS ROW START
		CONSTRAINT DF_dw_zeit_dmsn_valid_from
			DEFAULT SYSUTCDATETIME() NOT NULL,
	valid_until		DATETIME2		GENERATED ALWAYS AS ROW END
		CONSTRAINT DF_dw_zeit_dmsn_valid_until
			DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59') NOT NULL,
	PERIOD FOR SYSTEM_TIME(valid_from, valid_until)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.dw_zeit_dmsnHistory));
GO

-- Filialen Dimension 
INSERT	dw_filialen_dmsn
(
	filialnr,
	filiale,
	plz,
	ort
)
SELECT		o.FILIALNR,
			o.FILIALE,
			o.PLZ,
			o.ORT
FROM		OP_VERKAUF o
GROUP BY	o.FILIALNR,
			o.FILIALE,
			o.PLZ,
			o.ORT;

-- Artikel Dimension
INSERT INTO dw_artikel_dmsn
(
	artnr,
	bezeichnung,
	artikelgruppe,
	warenkategorie,
	preis,
	mwst_satz
)
SELECT		o.ARTNR,
			o.BEZEICHNUNG,
			o.ARTIKELGRUPPE,
			o.WARENKATEGORIE,
			o.PREIS,
			o.MWST_SATZ
FROM		OP_VERKAUF o
GROUP BY	o.ARTNR,
			o.BEZEICHNUNG,
			o.ARTIKELGRUPPE,
			o.WARENKATEGORIE,
			o.PREIS,
			o.MWST_SATZ;

-- Zeit Dimension
INSERT INTO dw_zeit_dmsn
(
	datum,
	monat,
	jahr,
	kalenderwoche,
	wochentag
)
SELECT		o.DATUM,
			o.MONAT,
			o.JAHR,
			o.KALENDERWOCHE,
			o.WOCHENTAG
FROM		OP_VERKAUF o
GROUP BY	o.DATUM,
			o.MONAT,
			o.JAHR,
			o.KALENDERWOCHE,
			o.WOCHENTAG;

-- the Fact Table
SELECT	o.FILIALNR,
		o.ARTNR,
		o.DATUM,
		o.ANZAHL
INTO	dw_verkauf_fact
FROM	OP_VERKAUF o;


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


---- INSERT --------------------------------------------
INSERT INTO dw_artikel_dmsn
(
	artnr,
	bezeichnung,
	artikelgruppe,
	warenkategorie,
	preis
)
VALUES
('FD-1234', 'Hai', 'Meeresfisch', 'Fisch', 300);
SELECT		*
FROM		dw_artikel_dmsn
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;
SELECT		*
FROM		dw_artikel_dmsnHistory
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- before insert data
SELECT		*
FROM		dw_artikel_dmsn
	FOR SYSTEM_TIME AS OF '2017-01-01 T10:00:00.7230011'
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- after insert data
SELECT		*
FROM		dw_artikel_dmsn
	FOR SYSTEM_TIME AS OF '2020-06-27 T18:50:00.7230011'
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- now
SELECT		*
FROM		dw_artikel_dmsn
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- all
SELECT		*
FROM		dw_artikel_dmsn FOR SYSTEM_TIME ALL
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

--------------------------------------------------------



---- UPDATE --------------------------------------------
-- update dw_artikel_dmsn and insert dw_artikel_dmsnHistory
SELECT		*
FROM		dw_artikel_dmsn
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;
SELECT		*
FROM		dw_artikel_dmsnHistory
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;
UPDATE	dw_artikel_dmsn
SET		preis = 400
WHERE	artnr = 'FD-1234';	-- update dw_artikel_dmsn and insert dw_artikel_dmsnHistory

-- look at valid_from in dw_artikel_dmsn
SELECT		*
FROM		dw_artikel_dmsn
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;
-- look at valid_from and valid_until in dw_artikel_dmsn
SELECT		*
FROM		dw_artikel_dmsnHistory
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- before Insert Data
SELECT		*
FROM		dw_artikel_dmsn
	FOR SYSTEM_TIME AS OF '2017-01-01 T10:00:00.7230011'
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- FOR SYSTEM_TIME ...
--     AS OF <date_time>
--     FROM <start_date_time> TO <end_date_time>
--     BETWEEN <start_date_time> AND <end_date_time>
--     CONTAINED IN (<start_date_time> , <end_date_time>)
--     ALL 

-- before update preis to 30
SELECT		*
FROM		dw_artikel_dmsn
	FOR SYSTEM_TIME AS OF '2017-12-16 T07:11:00.7230011'
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- now
SELECT		*
FROM		dw_artikel_dmsn
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- all
SELECT		*
FROM		dw_artikel_dmsn FOR SYSTEM_TIME ALL
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;
--------------------------------------------------------



---- DELETE --------------------------------------------
-- delete dw_artikel_dmsn and update dw_artikel_dmsnHistory
DELETE	FROM dw_artikel_dmsn
WHERE	artnr = 'FD-1234';

-- look at valid_from in dw_artikel_dmsn
SELECT		*
FROM		dw_artikel_dmsn
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;
-- look at valid_from and valid_until in dw_artikel_dmsn
SELECT		*
FROM		dw_artikel_dmsnHistory
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- before delete
SELECT		*
FROM		dw_artikel_dmsn
	FOR SYSTEM_TIME AS OF '2017-12-16 T07:16:00.7230011'
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- now
SELECT		*
FROM		dw_artikel_dmsn
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;

-- all
SELECT		*
FROM		dw_artikel_dmsn FOR SYSTEM_TIME ALL
WHERE		bezeichnung IN
	('Hai')
ORDER BY	artnr;
--------------------------------------------------------