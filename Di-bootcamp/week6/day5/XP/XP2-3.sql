-- Use the SUM() function to calculate the cumulative revenue of movies acted by each actor. 
-- Display the actor’s name and the cumulative revenue.
SELECT
    p.person_name AS actor,
    m.title,
    m.revenue,
	-- Calculate a running (cumulative) total of revenue for each actor
    SUM(m.revenue) OVER (PARTITION BY p.person_name ORDER BY m.revenue ASC	
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue
FROM movies.person AS p
JOIN movies.movie_cast AS mc ON p.person_id = mc.person_id
JOIN movies.movie AS m ON mc.movie_id = m.movie_id
WHERE m.revenue>0
ORDER BY p.person_name, cumulative_revenue ASC;
