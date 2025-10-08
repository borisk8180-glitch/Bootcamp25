WITH salary_comparison AS (
    SELECT 
        employee_id,
        first_name,
        last_name,
        salary,
        LAG(salary) OVER (ORDER BY first_name) AS previous_salary
    FROM employees
)
SELECT *
FROM salary_comparison
WHERE salary < previous_salary;