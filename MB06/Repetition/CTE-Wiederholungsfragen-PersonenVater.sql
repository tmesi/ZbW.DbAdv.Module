USE tempdb;
GO
/*drop table person;*/
CREATE TABLE Person
(
	id		INTEGER			NOT NULL,
	Name	VARCHAR(MAX)	NOT NULL,
	Vater	INTEGER,
	Mutter	INTEGER,
	PRIMARY KEY (id)
);
ALTER TABLE Person ADD FOREIGN KEY (Vater) REFERENCES Person (Id);
ALTER TABLE Person ADD FOREIGN KEY (Mutter) REFERENCES Person (Id);

INSERT INTO Person (id, Name, Vater, Mutter) values (1, 'Jakob', null, null);
INSERT INTO Person (id, Name, Vater, Mutter) values (2, 'Margrit', null, null);
INSERT INTO Person (id, Name, Vater, Mutter) values (3, 'Susi', 1, 2);
INSERT INTO Person (id, Name, Vater, Mutter) values (4, 'Walter', 1, 2);
INSERT INTO Person (id, Name, Vater, Mutter) values (5, 'Claudia', null, null);
INSERT INTO Person (id, Name, Vater, Mutter) values (6, 'Mario', 4, 5);

WITH cte
AS
(
	SELECT	id,
			Name,
			CAST('???' AS VARCHAR(MAX)) AS Vater
	FROM	Person
	WHERE	Vater IS NULL
	UNION ALL
	SELECT	a.id,
			a.Name,
			CAST(a.Name + '->' + b.Vater AS VARCHAR(MAX))
	FROM	Person	a
			INNER JOIN
			cte		b
				ON a.Vater = b.id
)
SELECT	*
FROM	cte;