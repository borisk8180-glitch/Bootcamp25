-- Use a combination of window functions and CTEs to find actors who have appeared in movies 
-- that have collectively grossed in the top 10% of all movie revenues. 
-- Display the actor’s name and the total revenue of the movies they have appeared in.

WITH ranked_movies AS (
    SELECT 
        movie_id,
        revenue,
        PERCENT_RANK() OVER (ORDER BY revenue DESC) --adds rank by revenue in descending order
		AS revenue_percent_rank
    FROM movies.movie
),
top_movies AS (
    SELECT movie_id, revenue
    FROM ranked_movies
    WHERE revenue_percent_rank <= 0.10  -- select top 10 % of all ranks
),
actor_revenue AS (
    SELECT 
        p.person_id,
        p.person_name,
        SUM(t.revenue) AS total_revenue --adds sum of revenue to each actor
    FROM movies.movie_cast AS mc
    JOIN movies.person AS p ON mc.person_id = p.person_id
    JOIN top_movies AS t ON mc.movie_id = t.movie_id
    GROUP BY p.person_id, p.person_name
)
SELECT 
    person_name AS actor_name,
    total_revenue
FROM actor_revenue
ORDER BY total_revenue DESC; --just orders by revenue
