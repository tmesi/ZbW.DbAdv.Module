/*

USE [TemporalDemo]
GO
ALTER TABLE [dbo].[Salaries] SET ( SYSTEM_VERSIONING = OFF  )
GO
DROP TABLE [dbo].[Salaries]
GO
DROP TABLE [history].[dbo_Salaries]


GO
*/

CREATE SCHEMA [history]
GO
CREATE TABLE dbo.Salaries
(
	Id				INT				NOT NULL IDENTITY(1, 1),
	EmployeeId		INT				NOT NULL,
	Salary			DECIMAL(10, 2) NOT NULL,
	ValidFrom		DATE			NOT NULL,
	ValidTo			DATE			NOT NULL,
	[RowValidFrom]	DATETIME2(7)	GENERATED ALWAYS AS ROW START NOT NULL,
	[RowValidUntil] DATETIME2(7) GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME([RowValidFrom], [RowValidUntil]),
	CONSTRAINT [PK_Salaries]
		PRIMARY KEY CLUSTERED ([Id] ASC)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [history].[dbo_Salaries], DATA_CONSISTENCY_CHECK = ON, HISTORY_RETENTION_PERIOD = 27 MONTH));
GO


-- INSERT statements WITH salary amounts
-- Employee 101: Alice Mueller - Junior Developer to Senior Developer
INSERT INTO dbo.Salaries (EmployeeId, Salary, ValidFrom, ValidTo) VALUES
(101, 75000.00, '2022-01-01 00:00:00', '2022-12-31 23:59:59'),
(101, 78000.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59'),
(101, 82000.00, '2024-01-01 00:00:00', '9999-12-31 23:59:59');

-- Employee 102: Bob Schmidt - Steady progression
INSERT INTO dbo.Salaries (EmployeeId, Salary, ValidFrom, ValidTo) VALUES
(102, 65000.00, '2021-06-01 00:00:00', '2022-05-31 23:59:59'),
(102, 68000.00, '2022-06-01 00:00:00', '2023-05-31 23:59:59'),
(102, 71500.00, '2023-06-01 00:00:00', '2024-05-31 23:59:59'),
(102, 75000.00, '2024-06-01 00:00:00', '9999-12-31 23:59:59');

-- Employee 103: Carol Weber - Team Lead
INSERT INTO dbo.Salaries (EmployeeId, Salary, ValidFrom, ValidTo) VALUES
(103, 85000.00, '2023-03-15 00:00:00', '2024-03-14 23:59:59'),
(103, 90000.00, '2024-03-15 00:00:00', '9999-12-31 23:59:59');

-- Employee 104: David Keller - Senior Engineer
INSERT INTO dbo.Salaries (EmployeeId, Salary, ValidFrom, ValidTo) VALUES
(104, 95000.00, '2022-07-01 00:00:00', '2023-06-30 23:59:59'),
(104, 100000.00, '2023-07-01 00:00:00', '2024-06-30 23:59:59'),
(104, 105000.00, '2024-07-01 00:00:00', '9999-12-31 23:59:59');

-- Employee 105: Eva Fischer - Mid-level Developer
INSERT INTO dbo.Salaries (EmployeeId, Salary, ValidFrom, ValidTo) VALUES
(105, 72000.00, '2021-09-01 00:00:00', '2022-08-31 23:59:59'),
(105, 76000.00, '2022-09-01 00:00:00', '2023-08-31 23:59:59'),
(105, 80000.00, '2023-09-01 00:00:00', '9999-12-31 23:59:59');


SELECT * FROM dbo.Salaries FOR SYSTEM_TIME ALL 
WHERE EmployeeId = 106


INSERT INTO dbo.Salaries (EmployeeId, Salary, ValidFrom, ValidTo) VALUES
(106, 100000, '2025-01-01 00:00:00', '9999-12-31 23:59:59');

SELECT	*
FROM	dbo.Salaries FOR SYSTEM_TIME ALL
WHERE	EmployeeId = 106;


-- Wait a moment and check the results
WAITFOR DELAY '00:00:02';

SELECT	Id,
		EmployeeId,
		Salary,
		BusinessValidFrom	= ValidFrom,
		BusinessValidTo		= ValidTo,
		SystemKnewFrom		= RowValidFrom,
		SystemKnewUntil		= RowValidUntil
FROM	dbo.Salaries
WHERE	EmployeeId = 106;
GO


-- Now let's discover we made a mistake - the raise was actually on Jan 15, not Jan 1
PRINT 'Step 2: Correction - salary actually started Jan 15, 2026 (not Jan 1, 2025)';
WAITFOR DELAY '00:00:02';

UPDATE	dbo.Salaries
SET		ValidFrom = '2026-01-15 00:00:00'
WHERE	EmployeeId	= 106
AND		ValidTo			= '9999-12-31 23:59:59';
GO


UPDATE	dbo.Salaries
SET		Salary = 115000,
		ValidFrom = GETDATE(),
		ValidTo = '9999-12-31 23:59:59'
WHERE	EmployeeId = 106;

----------------------------------------------------------------------------------------------

SELECT	Id,
		EmployeeId,
		Salary,
		BusinessValidFrom	= ValidFrom,
		BusinessValidTo		= ValidTo,
		SystemKnewFrom		= RowValidFrom,
		SystemKnewUntil		= RowValidUntil
FROM	dbo.Salaries
WHERE	EmployeeId = 106;
GO


SELECT	Id,
		EmployeeId,
		Salary,
		BusinessValidFrom	= ValidFrom,
		BusinessValidTo		= ValidTo,
		SystemKnewFrom		= RowValidFrom,
		SystemKnewUntil		= RowValidUntil
FROM	history.dbo_Salaries
WHERE	EmployeeId = 106;
GO


-- Query 1: What is Employee 106's current salary record?
SELECT	EmployeeId,
		Salary,
		ValidFrom,
		ValidTo,
		RowValidFrom,
		'This is what we know NOW'	AS Note
FROM	dbo.Salaries
WHERE	EmployeeId = 106;
GO

-- Query 2: What did we THINK Employee 106's salary was 1 hour ago?
DECLARE @QueryDate DATETIME = DATEADD(HOUR, -1, GETDATE());
SELECT	EmployeeId,
		Salary,
		ValidFrom,
		ValidTo,
		RowValidFrom,
		RowValidUntil,
		'This is what we THOUGHT before the correction' AS Note
FROM	dbo.Salaries
	FOR SYSTEM_TIME AS OF @QueryDate
WHERE	EmployeeId = 106;
GO

-- Query 3: Show complete audit trail
SELECT	'CURRENT'	AS RecordType,
		EmployeeId,
		Salary,
		ValidFrom,
		ValidTo,
		RowValidFrom,
		RowValidUntil
FROM	dbo.Salaries
WHERE	EmployeeId = 106
UNION ALL
SELECT	'HISTORY'	AS RecordType,
		EmployeeId,
		Salary,
		ValidFrom,
		ValidTo,
		RowValidFrom,
		RowValidUntil
FROM	history.dbo_Salaries
WHERE	EmployeeId = 106
ORDER BY	RowValidFrom;
GO

-- Query 4: All changes to this record over time
SELECT		EmployeeId,
			Salary,
			BusinessValidFrom	= ValidFrom,
			BusinessValidTo		= ValidTo,
			SystemKnewFrom		= RowValidFrom,
			SystemKnewUntil		= RowValidUntil,
			CASE WHEN RowValidUntil = '9999-12-31 23:59:59.9999999' THEN 'CURRENT KNOWLEDGE' ELSE 'SUPERSEDED KNOWLEDGE' END AS Status
FROM		dbo.Salaries FOR SYSTEM_TIME ALL
WHERE		EmployeeId = 106
ORDER BY	RowValidFrom;
GO

----------------------------------------------------------------------------------------------


-- Query 1: Current salary overview
SELECT		EmployeeId,
			CurrentSalary	= Salary,
			EffectiveDate	= ValidFrom,
			DATEDIFF(MONTH, ValidFrom, GETDATE()) AS MonthsAtCurrentSalary
FROM		dbo.Salaries
WHERE		ValidTo = '9999-12-31 23:59:59'
ORDER BY	Salary DESC;
GO

-- Query 2: Salary progression for Employee 102
;WITH SalaryProgression
AS
(
	SELECT	EmployeeId,
			Salary,
			ValidFrom,
			ValidTo,
			InitialSalary = LAG(Salary) OVER (PARTITION BY EmployeeId ORDER BY ValidFrom),
			Progression = CONCAT('+', FORMAT((Salary - LAG(Salary) OVER (PARTITION BY EmployeeId ORDER BY ValidFrom)) / 
                     LAG(Salary) OVER (PARTITION BY EmployeeId ORDER BY ValidFrom) * 100, 'N1'), '%')
	FROM dbo.Salaries
	--WHERE EmployeeId = 102
)
SELECT	EmployeeId,
		Salary
		ValidFrom,
		ValidTo,
		sp.InitialSalary,
		Progression = CASE WHEN sp.InitialSalary IS NULL THEN NULL ELSE sp.Progression END
FROM	SalaryProgression	AS sp
ORDER BY sp.EmployeeId


GO

-- Query 3: Total salary budget over time
SELECT		YEAR(ValidFrom)				AS Year,
			COUNT(DISTINCT EmployeeId) AS EmployeeCount,
			SUM(Salary)					AS TotalSalaryBudget,
			AVG(Salary)					AS AverageSalary,
			MIN(Salary)					AS MinSalary,
			MAX(Salary)					AS MaxSalary
FROM		dbo.Salaries
WHERE		ValidFrom >= '2022-01-01'
GROUP BY	YEAR(ValidFrom)
ORDER BY	Year;
GO

-- Query 4: Historical query - What was the salary on a specific date?
DECLARE @QueryDate DATE = '2023-06-15';

SELECT		EmployeeId,
			Salary,
			ValidFrom,
			ValidTo
FROM		dbo.Salaries FOR SYSTEM_TIME AS OF @QueryDate
WHERE		@QueryDate
BETWEEN		ValidFrom AND ValidTo
ORDER BY	EmployeeId;
GO

-- Query 5: Show all changes for all employees
SELECT		EmployeeId,
			Salary,
			ValidFrom,
			ValidTo,
			RowValidFrom																AS RecordCreated,
			CASE WHEN ValidTo = '9999-12-31 23:59:59' THEN 'CURRENT' ELSE 'HISTORY' END AS Status
FROM		dbo.Salaries
ORDER BY	EmployeeId,
			ValidFrom;
GO

-- Query 6: Time-range query - All changes between dates
SELECT		EmployeeId,
			Salary,
			ValidFrom,
			ValidTo,
			RowValidFrom,
			RowValidUntil
FROM		dbo.Salaries FOR SYSTEM_TIME BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY	EmployeeId,
			ValidFrom;
GO

-- Query 7: Calculate total compensation paid to each employee
SELECT		EmployeeId,
			COUNT(*)																		AS NumberOfSalaryChanges,
			MIN(Salary)																		AS StartingSalary,
			MAX(Salary)																		AS CurrentOrFinalSalary,
			MAX(Salary) - MIN(Salary)													AS TotalIncrease,
			CONCAT(FORMAT(((MAX(Salary) - MIN(Salary)) / MIN(Salary)) * 100, 'N1'), '%') AS PercentageIncrease
FROM		dbo.Salaries
GROUP BY	EmployeeId
ORDER BY	EmployeeId;
GO