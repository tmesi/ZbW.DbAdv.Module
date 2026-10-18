USE master;
GO
IF EXISTS(SELECT * FROM sys.databases WHERE	name = 'CTEExercise')
BEGIN
	DROP DATABASE CTEExercise;
END;
GO
CREATE DATABASE CTEExercise;

USE CTEExercise;
GO

CREATE TABLE pairs
(
	from_city	VARCHAR(255)	NOT NULL,
	to_city		VARCHAR(255)	NOT NULL,
	distance	INTEGER			NOT NULL,
	PRIMARY KEY (from_city, to_city),
	CHECK (from_city < to_city)
);


INSERT INTO pairs
VALUES
('Bari', 'Bologna', 672),
('Bari', 'Genova', 944),
('Bari', 'Milano', 881),
('Bari', 'Napoli', 257),
('Bari', 'Palermo', 708),
('Bologna', 'Genova', 190),
('Bologna', 'Milano', 200),
('Bologna', 'Napoli', 470),
('Bologna', 'Palermo', 730),
('Bologna', 'Roma', 300),
('Genova', 'Milano', 120),
('Genova', 'Napoli', 590),
('Genova', 'Palermo', 790),
('Genova', 'Roma', 400),
('Milano', 'Napoli', 660),
('Milano', 'Palermo', 890),
('Milano', 'Roma', 480),
('Napoli', 'Palermo', 310),
('Napoli', 'Roma', 190),
('Palermo', 'Roma', 430);


SELECT	*
FROM	pairs;

