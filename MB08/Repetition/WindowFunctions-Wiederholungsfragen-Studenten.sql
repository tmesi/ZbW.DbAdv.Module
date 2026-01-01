DROP TABLE Studenten;
CREATE TABLE Studenten
(
	id		INTEGER			NOT NULL,
	Name	VARCHAR(MAX)	NOT NULL,
	Klasse	VARCHAR(1)		NOT NULL,
	Punkte	DECIMAL(3, 1) NOT NULL,
	PRIMARY KEY (id)
);

INSERT INTO Studenten (id, Klasse, Name, Punkte) values (1, 'A', 'Jakob', 15.5);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (2, 'A', 'Margrit', 15.0);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (3, 'A', 'Susi', 21.9);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (4, 'A', 'Walter', 19.5);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (5, 'B', 'Claudia', 15.7);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (6, 'B', 'Mario', 15.3);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (7, 'B', 'Roger', 13.6);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (8, 'C', 'Markus', 15.3);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (9, 'C', 'Anja', 14.3);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (10, 'C', 'Sybille', 14.6);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (11, 'C', 'Jonas', 22.1);
INSERT INTO Studenten (id, Klasse, Name, Punkte) values (12, 'C', 'Nando', 22.6);

SELECT	*,
		RANK() OVER (PARTITION BY Klasse
					ORDER BY Note DESC
					)	AS Rang
FROM	Studenten;