-- Identify the movie series (based on shared keywords) with the highest total revenue. 
-- Use window functions and CTEs to group movies by their series and calculate the total revenue.

WITH series_revenue AS (
    SELECT 
        k.keyword_name AS series_name,
        SUM(m.revenue) AS total_revenue
		
    FROM movies.movie AS m
    JOIN movies.movie_keywords AS mk ON m.movie_id = mk.movie_id
    JOIN movies.keyword AS k 	     ON mk.keyword_id = k.keyword_id
    GROUP BY k.keyword_name --Groups movies by keywords (keyword_name),
							-- which act as "series" identifiers
),
ranked_series AS (
    SELECT 
		series_name,
        total_revenue,
        RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
		-- Assigns each series a rank (RANK()) in descending order of income
    FROM series_revenue
)
SELECT 
    series_name AS movie_series,
    total_revenue
FROM ranked_series
WHERE revenue_rank = 1;
