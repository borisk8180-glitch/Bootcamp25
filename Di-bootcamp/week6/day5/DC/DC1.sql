-- Calculate the average budget growth rate for each production company across all movies they have produced. 
-- Use window functions to determine the budget growth rate and then calculate the average growth rate.

WITH company_budget_growth AS (
    SELECT
        pc.company_name,
        m.movie_id,
        m.title,
        m.budget,
        LAG(m.budget) OVER (PARTITION BY pc.company_name ORDER BY m.release_date) 
		AS prev_budget	--add a column to get the previous movie’s budget for the same company in the same row.
		
    FROM movies.movie AS m 
    JOIN movies.movie_company AS mc ON m.movie_id = mc.movie_id
    JOIN movies.production_company AS pc ON mc.company_id = pc.company_id
),
	budget_growth_calc AS (
	    SELECT
	        company_name,
	        movie_id,
	        title,
	        budget,
	        prev_budget,
	        CASE --conditional statement
	            WHEN prev_budget IS NULL OR prev_budget < 100 THEN NULL 
				--exclude rows with prev_budget null or low values (outliers)
	            ELSE (budget - prev_budget) / prev_budget::DECIMAL --fraction
	        END 
			AS budget_growth_rate
	    FROM company_budget_growth
)

-- SELECT * FROM budget_growth_calc WHERE company_name = 'Paramount Pictures';

SELECT
    company_name,
    ROUND(AVG(budget_growth_rate),2) AS avg_budget_growth_rate
	-- budget_growth_rate
FROM budget_growth_calc
WHERE budget_growth_rate IS NOT NULL --cutting off null values
GROUP BY company_name--, budget_growth_rate
ORDER BY avg_budget_growth_rate DESC
;