-- Determine the directors who have consistently produced movies in the top 10% of popularity 
-- within their genre. Use CTEs and window functions to calculate the required values 
-- and display the director’s name, the titles of their top movies, and their popularity ranks.

WITH -- make CTEs
ranked_movies AS (
    SELECT
        p.person_name AS director_name,
        m.movie_id,
        m.title,
        g.genre_name,
        m.popularity,
        PERCENT_RANK() OVER 
			(PARTITION BY g.genre_name
            ORDER BY m.popularity DESC --order by popularity within the block
        ) AS popularity_percentile
		
    FROM movies.movie AS m
    JOIN movies.movie_genres AS mg 
        ON m.movie_id = mg.movie_id
    JOIN movies.genre AS g 
        ON mg.genre_id = g.genre_id
    JOIN movies.movie_crew AS mc 
        ON m.movie_id = mc.movie_id
    JOIN movies.person AS p 
        ON mc.person_id = p.person_id
    WHERE mc.job = 'Director'
)
-- SELECT * FROM ranked_movies WHERE title = 'The Dark Knight'
,
best_rank_per_movie AS (
    SELECT
        director_name,
        movie_id,
        title,
        MIN(popularity_percentile) AS best_percentile   --we keep only one percentile value per film — 
														--the one where it was the most successful (min)
														--(the most popular relative to others in its genre).
    FROM ranked_movies
    GROUP BY director_name, movie_id, title -- Grouping all lines related to the same movie into 1 row
											-- (by movie_id) and director (genre doesn't matter)
)
-- SELECT * FROM best_rank_per_movie WHERE title = 'The Dark Knight'
,

top_directors AS (
    SELECT
        director_name,
        title,
        best_percentile
    FROM best_rank_per_movie
    WHERE best_percentile <= 0.10 -- movies in the top 10% of popularity within their genres
)

SELECT
    director_name,
    STRING_AGG(title, ', ') AS top_titles,  --concatenates multiple movie titles into one text string
											--separated by a comma and a space.
    COUNT(*) AS top_movie_count				--how many top movies each director has 
											--(how many rows per director in top_directors were)
FROM top_directors
GROUP BY director_name						--Just 1 director per row
HAVING COUNT(*) >= 2						--Filters out directors who have fewer than 2 top movies.

ORDER BY top_movie_count DESC;
