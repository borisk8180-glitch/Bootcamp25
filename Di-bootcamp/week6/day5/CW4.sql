-- Use the LEAD() function to identify employees who have lower sales 
-- compared to their next colleague in the sorted list.
WITH sales_comparison AS (
    SELECT 
        e.employee_id,
        first_name,
        last_name,
        department_id,
        sales,
        LEAD(sales) OVER (ORDER BY sales) AS next_sales
    FROM sales_data sd
	JOIN employees e ON e.employee_id = sd.employee_id

)
SELECT *
FROM sales_comparison
WHERE sales < next_sales;
