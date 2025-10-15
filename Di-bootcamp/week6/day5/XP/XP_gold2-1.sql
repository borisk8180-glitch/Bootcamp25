-- Use the FIRST_VALUE() and LAST_VALUE() functions to find the first and last movie each actor appeared in. 
-- Display the actor’s name, 
-- first movie title, first movie release date, last movie title, and last movie release date.

WITH actor_movies AS ( -- make CTE table because we cannot group window functions in the same query
SELECT 
    p.person_name AS actor_name,
-- first values
    FIRST_VALUE(m.title) OVER (PARTITION BY p.person_id --all movies actor appeared in
        ORDER BY m.release_date) AS first_movie_title, -- in chronological order, choose first movie title
    FIRST_VALUE(m.release_date) OVER (PARTITION BY p.person_id  --all movies actor appeared in
        ORDER BY m.release_date) AS first_movie_date, -- in chronological order, choose first release date
-- last values
    LAST_VALUE(m.title) OVER (PARTITION BY p.person_id
        ORDER BY m.release_date
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_movie_title,
		-- Take all the lines within the partition (for given actor),
		-- regardless of the current line, and use them all and take the last one
		-- otherwise, only up to the current line
    LAST_VALUE(m.release_date) OVER (PARTITION BY p.person_id
        ORDER BY m.release_date
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_movie_date
		
FROM movies.movie_cast AS mc
JOIN movies.movie AS m ON mc.movie_id = m.movie_id
JOIN movies.person AS p ON mc.person_id = p.person_id
)

SELECT DISTINCT
    actor_name,
    first_movie_title,
    first_movie_date,
    last_movie_title,
    last_movie_date
FROM actor_movies
ORDER BY actor_name;