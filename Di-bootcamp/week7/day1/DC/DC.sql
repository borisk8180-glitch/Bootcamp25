-- Create the employees table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date VARCHAR(20),
    department VARCHAR(50)
);

-- Insert 20 sample records 
INSERT INTO employees (employee_id, employee_name, salary, hire_date, department) VALUES
(1, 'Amy West', 60000.00, '2021-01-15', 'HR'),
(2, 'Ivy Lee', 75000.50, '2020-05-22', 'Sales'),
(3, 'joe smith', 80000.75, '2019-08-10', 'Marketing'), 
(4, 'John White', 90000.00, '2020-11-05', 'Finance'),
(5, 'Jane Hill', 55000.25, '2022-02-28', 'IT'),
(6, 'Dave West', 72000.00, '2020-03-12', 'Marketing'),
(7, 'Fanny Lee', 85000.50, '2018-06-25', 'Sales'),
(8, 'Amy Smith', 95000.25, '2019-11-30', 'Finance'),
(9, 'Ivy Hill', 62000.75, '2021-07-18', 'IT'),
(10, 'Joe White', 78000.00, '2022-04-05', 'Marketing'),
(11, 'John Lee', 68000.50, '2018-12-10', 'HR'),
(12, 'Jane West', 89000.25, '2017-09-15', 'Sales'),
(13, 'Dave Smith', 60000.75, '2022-01-08', NULL),
(14, 'Fanny White', 72000.00, '2019-04-22', 'IT'),
(15, 'Amy Hill', 84000.50, '2020-08-17', 'Marketing'),
(16, 'Ivy West', 92000.25, '2021-02-03', 'Finance'),
(17, 'Joe Lee', 58000.75, '2018-05-28', 'IT'),
(18, 'John Smith', 77000.00, '2019-10-10', 'HR'),
(19, 'Jane Hill', 81000.50, '2022-03-15', 'Sales'),
(20, 'Dave White', 70000.25, '2017-12-20', 'Marketing');

--Check for missing values. Use conditional statements
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN employee_name IS NULL OR TRIM(employee_name) = '' THEN 1 ELSE 0 END) AS missing_name,
    SUM(CASE WHEN salary IS NULL THEN 1 ELSE 0 END) AS missing_salary,
    SUM(CASE WHEN hire_date IS NULL OR TRIM(hire_date) = '' THEN 1 ELSE 0 END) AS missing_hire_date,
    SUM(CASE WHEN department IS NULL OR TRIM(department) = '' THEN 1 ELSE 0 END) AS missing_department
FROM employees;

--Handling missing values:
UPDATE employees
SET employee_name = 'Unknown'
WHERE employee_name IS NULL OR TRIM(employee_name) = '';

UPDATE employees
SET department = 'Unknown'
WHERE department IS NULL OR TRIM(department) = '';

UPDATE employees
SET salary = (SELECT AVG(salary) FROM employees WHERE salary IS NOT NULL)
WHERE salary IS NULL;

-- For hire_date, you might choose a default date if missing
UPDATE employees
SET hire_date = '2000-01-01'
WHERE hire_date IS NULL OR TRIM(hire_date) = '';

--Remove duplicate rows
DELETE FROM employees --we delete all but the unique ones or with the lowest rowid
WHERE rowid NOT IN ( --In SQLite, each row has a unique rowid, even if there is no explicit primary key.
    SELECT MIN(rowid) --The minimum rowid is selected from each group, that is, one row from the group is the one that will be saved.
    FROM employees
    GROUP BY employee_id, employee_name, salary, hire_date, department --if there are more than 1 group of similar values then..
  	--Groups rows by all columns, which determine the uniqueness of the record.
);

--Standardize text columns
-- Trim spaces
UPDATE employees
SET employee_name = TRIM(employee_name),
    department = TRIM(department);

-- Make department names lowercase
UPDATE employees
SET department = LOWER(department);

--Ensure proper data types
-- Example: standardizing format (assuming current format is flexible)
UPDATE employees
SET hire_date = SUBSTR(hire_date, 1, 10)
WHERE hire_date IS NOT NULL;

--Detect and handle outliers for salary
-- Find Q1 and Q3
WITH stats AS (
    SELECT 
        MIN(salary) AS min_salary,
        MAX(salary) AS max_salary,
        AVG(salary) AS avg_salary
    FROM employees
)
SELECT * FROM stats;

--To cap extreme salaries (manual example):
UPDATE employees
SET salary = 100000
WHERE salary > 100000;

UPDATE employees
SET salary = 20000
WHERE salary < 20000;

--Normalize salary (0–1 scale)
ALTER TABLE employees ADD COLUMN salary_normalized REAL;

UPDATE employees
SET salary_normalized = (salary - (SELECT MIN(salary) --calculates how much a particular employee's salary is higher than the minimum wage in the table.
                                   FROM employees)) * 1.0 / --It shows how far along the path from the minimum to the maximum the current salary is.
                                   							--translates any number into a range from 0 to 1.
                                   							--SQLite needs to perform real (not integer) division.
                        ((SELECT MAX(salary) FROM employees) - (SELECT MIN(salary) --this is the salary range: the difference between the largest and the smallest.
                                                                FROM employees));

