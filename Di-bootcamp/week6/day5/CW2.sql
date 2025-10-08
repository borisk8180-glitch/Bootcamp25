--Calculate cumulative salary per department using ROWS frame specification
SELECT 
    department_id,
    employee_id,
    first_name,
    last_name,
    salary,
    SUM(salary) OVER (PARTITION BY department_id ORDER BY salary 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_salary
FROM employees;
