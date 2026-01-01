USE MASTER;
GO
IF EXISTS(SELECT * FROM sys.databases WHERE NAME = 'WFExercise') BEGIN
	DROP DATABASE WFExercise;
END;
GO
CREATE DATABASE WFExercise;
ALTER DATABASE WFExercise SET RECOVERY SIMPLE WITH NO_WAIT;
GO
USE WFExercise;
GO


CREATE TABLE ap_sales
(
  S_YEAR             VARCHAR(4),
  S_QUARTER          VARCHAR(2),
  S_MONTH            VARCHAR(3),
  SALES             DECIMAL(10,2)
);

INSERT INTO ap_sales VALUES   ('2012', 'Q3', '09',  150);
INSERT INTO ap_sales VALUES   ('2012', 'Q4', '10',  630);
INSERT INTO ap_sales VALUES   ('2012', 'Q4', '11', 1300);
INSERT INTO ap_sales VALUES   ('2012', 'Q4', '12', 1400);
INSERT INTO ap_sales VALUES   ('2013', 'Q1', '01', 1000);
INSERT INTO ap_sales VALUES   ('2013', 'Q1', '02', 1030);
INSERT INTO ap_sales VALUES   ('2013', 'Q1', '03', 1120);
INSERT INTO ap_sales VALUES   ('2013', 'Q2', '04',  900);
INSERT INTO ap_sales VALUES   ('2013', 'Q2', '05',  980);
INSERT INTO ap_sales VALUES   ('2013', 'Q2', '06',  700);
INSERT INTO ap_sales VALUES   ('2013', 'Q3', '07', 1091);
INSERT INTO ap_sales VALUES   ('2013', 'Q3', '08', 1200);
INSERT INTO ap_sales VALUES   ('2013', 'Q3', '09', 1300);
INSERT INTO ap_sales VALUES   ('2013', 'Q4', '10', 1500);
INSERT INTO ap_sales VALUES   ('2013', 'Q4', '11', 1700);
INSERT INTO ap_sales VALUES   ('2013', 'Q4', '12', 2000);
INSERT INTO ap_sales VALUES   ('2014', 'Q1', '01', 1600);
INSERT INTO ap_sales VALUES   ('2014', 'Q1', '02', 1400);
INSERT INTO ap_sales VALUES   ('2014', 'Q1', '03', 1815);
INSERT INTO ap_sales VALUES   ('2014', 'Q2', '04', 1100);