SELECT 
    m.name AS table_name,
    group_concat(p.name, ', ') AS columns
FROM sqlite_master AS m
JOIN pragma_table_info(m.name) AS p
WHERE m.type = 'table' AND m.name NOT LIKE 'sqlite_%'
GROUP BY m.name
ORDER BY m.name;

CREATE TEMP TABLE temp_employee AS
SELECT 
    e.employee_code_emp AS employee_id,
    e.employee_name_emp AS employee_name,
    e.GEN_M_F AS gender,
    e.age,
    c.company_name,
    c.company_city,
    c.company_state,
    c.company_type,
    c.const_site_category,
    f.function_code,
    f.function,
    f.function_group,
    s.salary,
    DATE(s.date) AS date,
    s.employee_id || '_' || DATE(s.date) AS id
FROM employees e
LEFT JOIN salaries s
    ON e.employee_code_emp = s.employee_id
LEFT JOIN companies c 
    ON e.comp_code_emp = c.company_name  -- подставьте правильный ключ
LEFT JOIN functions f
    ON s.func_code = f.function_code;
    
SELECT * FROM temp_employee;
--Updating an existing temp_employee table
UPDATE temp_employee
SET 
    employee_id = TRIM(employee_id),
    employee_name = TRIM(employee_name),
    gender = TRIM(gender),
    company_name = TRIM(company_name),
    company_city = TRIM(company_city),
    company_state = TRIM(company_state),
    company_type = TRIM(company_type),
    const_site_category = TRIM(const_site_category),
    function_code = TRIM(function_code),
    function = TRIM(function),
    function_group = TRIM(function_group),
    id = TRIM(id);  

--Counting the number of empty or NULL values in columns
SELECT *
FROM temp_employee
WHERE employee_name IS NULL OR employee_name = ''
   OR gender IS NULL OR gender = ''
   OR company_name IS NULL OR company_name = ''
   OR company_city IS NULL OR company_city = ''
   OR company_state IS NULL OR company_state = ''
   OR company_type IS NULL OR company_type = ''
   OR const_site_category IS NULL OR const_site_category = ''
   OR function_code IS NULL OR function_code = ''
   OR function IS NULL OR function = ''
   OR function_group IS NULL OR function_group = ''
   OR salary IS NULL
   OR date IS NULL OR date = ''
   OR id IS NULL OR id = '';

--Deleting rows with empty or NULL values in all text columns
DELETE FROM temp_employee
WHERE employee_id IS NULL OR TRIM(employee_id) = ''
   OR employee_name IS NULL OR TRIM(employee_name) = ''
   OR gender IS NULL OR TRIM(gender) = ''
   OR company_name IS NULL OR TRIM(company_name) = ''
   OR company_city IS NULL OR TRIM(company_city) = ''
   OR company_state IS NULL OR TRIM(company_state) = ''
   OR company_type IS NULL OR TRIM(company_type) = ''
   OR const_site_category IS NULL OR TRIM(const_site_category) = ''
   OR function_code IS NULL OR TRIM(function_code) = ''
   OR function IS NULL OR TRIM(function) = ''
   OR function_group IS NULL OR TRIM(function_group) = ''
   OR salary IS NULL
   OR date IS NULL OR TRIM(date) = ''
   OR id IS NULL OR TRIM(id) = '';

--SQL query for counting employees by company
SELECT 
    company_name,
    COUNT(DISTINCT employee_id) AS num_employees
FROM temp_employee
GROUP BY company_name
ORDER BY num_employees DESC;
--Total number of employees per city with percentage
SELECT 
    company_city,
    COUNT(DISTINCT employee_id) AS num_employees,
    ROUND(
        100.0 * COUNT(DISTINCT employee_id) / 
        (SELECT COUNT(DISTINCT employee_id) FROM temp_employee), 2
    ) AS percentage
FROM temp_employee
GROUP BY company_city
ORDER BY num_employees DESC;

--Total number of employees each month
SELECT 
    strftime('%Y-%m', date) AS year_month,
    COUNT(DISTINCT employee_id) AS num_employees
FROM temp_employee
GROUP BY year_month
ORDER BY year_month;

--Average number of employees per month
SELECT 
    ROUND(AVG(monthly_count), 2) AS avg_employees_per_month
FROM (
    SELECT 
        strftime('%Y-%m', date) AS year_month,
        COUNT(DISTINCT employee_id) AS monthly_count
    FROM temp_employee
    GROUP BY year_month
) AS monthly_counts;

--Minimum and maximum number of employees by month and when they were
CREATE TEMP TABLE IF NOT EXISTS monthly_counts AS
SELECT 
    strftime('%Y-%m', date) AS year_month,
    COUNT(DISTINCT employee_id) AS num_employees
FROM temp_employee
GROUP BY year_month;

-- Minimum number of employees and month
SELECT mc.num_employees AS min_employees, mc.year_month AS min_month
FROM monthly_counts mc
WHERE mc.num_employees = (SELECT MIN(num_employees) FROM monthly_counts)
LIMIT 1;

-- Максимальное количество сотрудников и месяц
SELECT mc.num_employees AS max_employees, mc.year_month AS max_month
FROM monthly_counts mc
WHERE mc.num_employees = (SELECT MAX(num_employees) FROM monthly_counts)
LIMIT 1;

--For the average number of employees by function_group by month
SELECT 
    function_group,
    ROUND(AVG(monthly_count), 2) AS avg_employees_per_month
FROM (
    SELECT 
        strftime('%Y-%m', date) AS year_month,
        function_group,
        COUNT(DISTINCT employee_id) AS monthly_count
    FROM temp_employee
    GROUP BY year_month, function_group
) AS monthly_group_counts
GROUP BY function_group
ORDER BY avg_employees_per_month DESC;

--Annual average salary
SELECT 
    strftime('%Y', date) AS year,
    ROUND(AVG(salary), 2) AS avg_salary
FROM temp_employee
GROUP BY year
ORDER BY year;




