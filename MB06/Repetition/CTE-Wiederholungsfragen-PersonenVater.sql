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
-- solution here
)
SELECT	*
FROM	cte;