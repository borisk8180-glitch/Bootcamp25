-- Calculate the running total of sales for each employee using the 
-- SUM() function with the RANGE frame specification.
SELECT 
	e.employee_id,
	first_name,
	last_name,
	department_id,
	sales,
	SUM(sales) OVER (ORDER BY sales
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS running_total
FROM sales_data sd
JOIN employees e ON e.employee_id = sd.employee_id
ORDER BY sales;
