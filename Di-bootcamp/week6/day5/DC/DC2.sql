-- Identify the actor who has appeared in the most movies that are rated above the average rating of all movies. 
-- Use window functions and CTEs to calculate the average rating and filter the actors based on this criterion.

WITH avg_movie_rating AS (
    -- Calculate the average rating across all movies
    SELECT AVG(vote_average) AS overall_avg_rating
    FROM movies.movie
),
actor_high_rating_movies AS (
    -- Find all movies above the overall average and link them to actors
    SELECT
        p.person_name,
        m.movie_id,
        m.title,
        m.vote_average
    FROM movies.movie AS m
    JOIN movies.movie_cast AS mc ON m.movie_id = mc.movie_id
    JOIN movies.person AS p ON mc.person_id = p.person_id
	CROSS JOIN avg_movie_rating AS amr --adds the average score of all films to each line.
    WHERE m.vote_average > amr.overall_avg_rating
	-- select only those films whose rating is above the average in the database.
),
actor_movie_counts AS (
    -- Count how many above-average movies each actor appeared in
    SELECT
        person_name,
        COUNT(movie_id) AS high_rating_movie_count 
		--Counts the number of above-average-rated movies per actor.
    FROM actor_high_rating_movies
    GROUP BY person_name
)
-- Rank actors by the number of above-average movies
SELECT
    person_name,
    high_rating_movie_count,
    RANK() OVER (ORDER BY high_rating_movie_count DESC) AS rank_position
	--add a column to rank actors by the number of high-rated movies
FROM actor_movie_counts
ORDER BY rank_position
LIMIT 1 -- select 1 actor who has appeared in the most movies that are rated above the average
;

