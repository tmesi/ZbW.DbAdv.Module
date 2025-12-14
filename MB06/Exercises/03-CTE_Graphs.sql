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

-- Paths from Palermo to Milano...
;
WITH both_ways (from_city, to_city, distance) /* Working Table containing all ways */
AS
(
	SELECT	from_city	= p.from_city,
			to_city		= p.to_city,
			distance	= p.distance
	FROM	pairs		AS p
	UNION	ALL
	SELECT	from_city	= p.to_city,
			to_city		= p.from_city,
			distance	= p.distance
	FROM	pairs		AS p
),
	paths (from_city, to_city, distance, path, Step)
AS
(
	SELECT	from_city		= b1.from_city,
			to_city			= b1.to_city,
			distance		= b1.distance,
			[path]			= CAST('[' + b1.from_city + ']' AS VARCHAR(MAX)),
			Step			= 1
	FROM	both_ways		AS b1
	WHERE	b1.from_city	= 'Palermo'	--<<< Start Node >>>
	UNION	ALL
	SELECT	from_city		= b2.from_city,
			to_city			= b2.to_city,
			distance		= p.distance + b2.distance,
			[path]			= p.[path] + '[' + b2.from_city + ']',
			Step			= p.Step + 1
	FROM	both_ways		AS b2
			JOIN
			paths			AS p
				ON
				(
					p.to_city									= b2.from_city
					AND	
					CHARINDEX('[' + b2.from_city + ']', p.path)	= 0 /* Prevent re-tracing */
					AND
					p.Step										< 6
				)
)
SELECT		TOP (5)
			[path]						= REPLACE(REPLACE(REPLACE(p.[path], '][', ','), '[', ''), ']', ',') + to_city,
			distance					= p.distance
FROM		paths						AS p
WHERE		to_city						= 'Milano' --<<< End node >>>
  AND		CHARINDEX('[Napoli]', path)	> 0
  AND		CHARINDEX('[Roma]', path)	> 0
  AND		CHARINDEX('[Bari]', path)	> 0	-- <<< via... >>>
ORDER BY	distance, [path];