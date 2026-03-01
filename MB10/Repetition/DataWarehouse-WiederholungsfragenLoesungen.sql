USE TemporalDemo;
DROP TABLE employee;
CREATE TABLE employee
(
	id			INT			PRIMARY KEY,
	name		VARCHAR(50) NOT NULL,
	gender		VARCHAR(50) NOT NULL,
	salary		INT			NOT NULL,
	department	VARCHAR(50) NOT NULL,
	education	VARCHAR(50) NOT NULL
);

INSERT INTO employee
VALUES
(1, 'David', 'Male', 5000, 'Sales', 'HF'),
(2, 'Jim', 'Female', 6000, 'HR', 'HF'),
(3, 'Kate', 'Female', 7500, 'IT', 'HF'),
(4, 'Will', 'Male', 6500, 'Marketing', 'HF'),
(5, 'Shane', 'Female', 5500, 'Finance', 'HF'),
(6, 'Shed', 'Male', 8000, 'Sales', 'EFZ'),
(7, 'Vik', 'Male', 7200, 'HR', 'EFZ'),
(8, 'Vince', 'Female', 6600, 'IT', 'EFZ'),
(9, 'Jane', 'Female', 5400, 'Marketing', 'EFZ'),
(10, 'Laura', 'Female', 6300, 'Finance', 'PHD');
--(11, 'Mac', 'Male', 5700, 'Sales'),
--(12, 'Pat', 'Male', 7000, 'HR'),
--(13, 'Julie', 'Female', 7100, 'IT'),
--(14, 'Elice', 'Female', 6800,'Marketing'),
--(15, 'Wayne', 'Male', 5000, 'Finance')

SELECT	*
FROM	employee;

SELECT		department,
			gender,
			education,
			Salary_Sum	= SUM(salary) 
FROM		employee
GROUP BY	department,
			gender,
			education
UNION ALL
SELECT		department,
			gender,
			NULL,
			Salary_Sum	= SUM(salary) 
FROM		employee
GROUP BY	department,
			gender
UNION ALL
SELECT		department,
			NULL,
			NULL,
			Salary_Sum	= SUM(salary) 
FROM		employee
GROUP BY	department
UNION ALL
SELECT	NULL,
		NULL,
		NULL,
			Salary_Sum	= SUM(salary) 
FROM	employee;


SELECT		Department	= department,
			Gender		= gender,
			Salary_Sum	= SUM(salary) 
FROM		employee
GROUP BY	ROLLUP(Gender, Department);




SELECT		Department	= COALESCE(department, 'All Departments'),
			Gender		= COALESCE(gender, 'All Genders'),
			Salary_Sum	= SUM(salary)
FROM		employee
GROUP BY	CUBE(Department, Gender);