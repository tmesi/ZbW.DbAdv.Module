DROP TABLE Employee;
CREATE TABLE Employee
(
	id		INTEGER			NOT NULL,
	Name	VARCHAR(MAX)	NOT NULL,
	Salary	DECIMAL(10, 2) NOT NULL,
	PRIMARY KEY (id)
);

INSERT INTO Employee (id,  Name, Salary) values (1,  'Jakob', 2015.5);
INSERT INTO Employee (id,  Name, Salary) values (2,  'Margrit', 3515.0);
INSERT INTO Employee (id,  Name, Salary) values (3,  'Susi', 3621.9);
INSERT INTO Employee (id,  Name, Salary) values (4,  'Walter', 4119.5);
INSERT INTO Employee (id,  Name, Salary) values (5,  'Claudia', 2915.7);
INSERT INTO Employee (id,  Name, Salary) values (6,  'Mario', 3615.3);
INSERT INTO Employee (id,  Name, Salary) values (7,  'Roger', 3313.6);
INSERT INTO Employee (id,  Name, Salary) values (8,  'Markus', 4015.3);
INSERT INTO Employee (id,  Name, Salary) values (9,  'Anja', 7014.3);
INSERT INTO Employee (id,  Name, Salary) values (10,  'Sybille', 1914.6);
INSERT INTO Employee (id,  Name, Salary) values (11,  'Jonas', 2622.1);
INSERT INTO Employee (id,  Name, Salary) values (12,  'Nando', 2422.6);

SELECT		Name,
			Salary,
			SUM(Salary) OVER (ORDER BY Salary DESC) AS x
FROM		Employee
ORDER BY	Salary DESC;
