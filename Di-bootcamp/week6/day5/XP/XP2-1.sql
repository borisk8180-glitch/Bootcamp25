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
