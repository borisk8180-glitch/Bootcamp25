-- Use the RANK() function to rank movies by their popularity within each genre. 
-- Display the genre name, movie title, and their rank based on popularity.
SELECT
    g.genre_name,
    m.title,
    popularity,
    RANK() OVER (PARTITION BY g.genre_name ORDER BY m.popularity DESC) AS popularity_rank
FROM movies.movie AS m
JOIN movies.movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN movies.genre AS g ON mg.genre_id = g.genre_id

ORDER BY g.genre_name, popularity_rank;

SELECT
    pc.company_name,
    m.title,
    m.revenue,
    NTILE(4) OVER (PARTITION BY pc.company_name ORDER BY m.revenue DESC) AS revenue_quartile
	-- Divides each company’s movies into 4 quartiles (1 = highest revenue group, 4 = lowest).
FROM movies.movie AS m
JOIN movies.movie_company AS mc ON m.movie_id = mc.movie_id
JOIN movies.production_company AS pc ON mc.company_id = pc.company_id
WHERE m.revenue>0 
-- AND pc.company_name = '1492 Pictures'
ORDER BY pc.company_name, revenue_quartile, m.revenue DESC;

-- Use the SUM() function with the ROWS frame specification to calculate the running total 
-- of movie budgets within each genre. Display the genre name, movie title, budget, and running total budget.

SELECT
    g.genre_name,
    m.title,
    m.budget,
    SUM(m.budget) OVER (PARTITION BY g.genre_name ORDER BY m.budget --means the running total restarts for each genre
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_budget
FROM movies.movie AS m
JOIN movies.movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN movies.genre AS g ON mg.genre_id = g.genre_id
WHERE m.budget>0
ORDER BY g.genre_name, m.budget;


-- Use the FIRST_VALUE() function to find the most recent movie within each genre based on the release date. 
-- Display the genre name, movie title, and release date.

SELECT
    g.genre_name,
    m.title,
    m.release_date,
	-- picks the title of the most recent movie in that genre
    FIRST_VALUE(m.title) OVER (PARTITION BY g.genre_name --the function works separately for each genre.
	ORDER BY m.release_date DESC) AS most_recent_movie
FROM movies.movie AS m
JOIN movies.movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN movies.genre AS g ON mg.genre_id = g.genre_id
ORDER BY g.genre_name, m.release_date DESC;


-- Use the DENSE_RANK() function to rank actors based on the number of movies they have appeared in. 
-- Display the actor’s name and their rank.
SELECT
    p.person_name,
    COUNT(mc.movie_id) AS movie_count,
    DENSE_RANK() OVER (ORDER BY COUNT(mc.movie_id) DESC) AS actor_rank
	-- Ranks actors by total movie appearances (most movies = rank 1)
FROM movies.person AS p
JOIN movies.movie_cast AS mc ON p.person_id = mc.person_id
GROUP BY p.person_id, p.person_name
ORDER BY actor_rank, p.person_name;


-- Use a CTE and the RANK() function to find the director with the highest average movie rating. 
-- Display the director’s name and their average rating.
WITH director_avg_rating AS (
    SELECT
        p.person_name,
        ROUND(AVG(m.vote_average)) AS avg_rating
    FROM movies.movie AS m
    JOIN movies.movie_crew AS mc ON m.movie_id = mc.movie_id
    JOIN movies.person AS p ON mc.person_id = p.person_id
    WHERE mc.job = 'Director'
    GROUP BY p.person_name
)
SELECT
    person_name,
    avg_rating,
    RANK() OVER (ORDER BY avg_rating DESC) AS rating_rank
	-- rank directors by average rating (highest = rank 1)
FROM director_avg_rating
ORDER BY rating_rank
LIMIT 1;


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

