DROP TABLE Studenten;
CREATE TABLE Studenten
(
	id		INTEGER			NOT NULL,
	Name	VARCHAR(MAX)	NOT NULL,
	Klasse	VARCHAR(1)		NOT NULL,
	Note	DECIMAL(3, 1) NOT NULL,
	PRIMARY KEY (id)
);

INSERT INTO Studenten (id, Klasse, Name, Note) values (1, 'A', 'Jakob', 5.5);
INSERT INTO Studenten (id, Klasse, Name, Note) values (2, 'A', 'Margrit', 5.0);
INSERT INTO Studenten (id, Klasse, Name, Note) values (3, 'A', 'Susi', 4.9);
INSERT INTO Studenten (id, Klasse, Name, Note) values (4, 'A', 'Walter', 5.5);
INSERT INTO Studenten (id, Klasse, Name, Note) values (5, 'B', 'Claudia', 5.7);
INSERT INTO Studenten (id, Klasse, Name, Note) values (6, 'B', 'Mario', 5.3);
INSERT INTO Studenten (id, Klasse, Name, Note) values (7, 'B', 'Roger', 3.6);
INSERT INTO Studenten (id, Klasse, Name, Note) values (8, 'C', 'Markus', 5.3);
INSERT INTO Studenten (id, Klasse, Name, Note) values (9, 'C', 'Anja', 4.3);
INSERT INTO Studenten (id, Klasse, Name, Note) values (10, 'C', 'Sybille', 4.6);
INSERT INTO Studenten (id, Klasse, Name, Note) values (11, 'C', 'Jonas', 2.1);
INSERT INTO Studenten (id, Klasse, Name, Note) values (12, 'C', 'Nando', 6.0);

SELECT	*,
		RANK() OVER (PARTITION BY Klasse
					ORDER BY Note DESC
					)	AS Rang
FROM	Studenten;