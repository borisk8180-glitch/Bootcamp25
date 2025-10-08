-- Use a CTE and a window function to find the director whose movies have the highest total budget. 
-- Display the director’s name and the total budget.

WITH director_budget AS (
    SELECT
        p.person_name,
        SUM(m.budget) AS total_budget
    FROM movies.movie AS m
    JOIN movies.movie_crew AS mc ON m.movie_id = mc.movie_id
    JOIN movies.person AS p ON mc.person_id = p.person_id
    WHERE mc.job = 'Director'
    GROUP BY p.person_name
)
SELECT
    person_name,
    total_budget,
    RANK() OVER (ORDER BY total_budget DESC) AS budget_rank
	-- to rank directors by total budget
	-- Orders by budget_rank so the top-ranked (highest total budget) director appears first

FROM director_budget
ORDER BY budget_rank
LIMIT 1;

