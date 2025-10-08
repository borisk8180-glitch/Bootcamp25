-- Create a CTE to rank employees by sales performance and filter top performers
WITH ranked_sales AS (
    SELECT 
        e.employee_id,
        first_name,
        last_name,
        department_id,
        sales,
        RANK() OVER (PARTITION BY e.department_id ORDER BY sd.sales DESC) AS sales_rank
    FROM sales_data sd
	JOIN employees e ON e.employee_id = sd.employee_id
)
SELECT *
FROM ranked_sales
WHERE sales_rank = 1
;
	