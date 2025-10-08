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
