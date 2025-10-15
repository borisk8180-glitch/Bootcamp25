-- Используем CTE и оконную функцию для вычисления среднего рейтинга 
-- фильмов по жанрам в 5-летнем окне.

WITH movie_with_year AS ( --joining the columns in one temp table
    SELECT 
        m.movie_id,
        g.genre_name,
        m.title,
        EXTRACT(YEAR FROM m.release_date) AS release_year, --get only year
        m.vote_average
    FROM movies.movie AS m
    JOIN movies.movie_genres AS mg ON m.movie_id = mg.movie_id
    JOIN movies.genre AS g ON mg.genre_id = g.genre_id
)
SELECT 
    genre_name,
    title,
    release_year,
    ROUND(AVG(vote_average) OVER (PARTITION BY genre_name --Each genre is considered as a separate block of data
	ORDER BY release_year -- Sets the order of films within each genre block by year of release
    RANGE BETWEEN 5 PRECEDING --select only films released within the last 5 years prior to the current film (inclusive)
	AND CURRENT ROW --current year
    ),2) AS moving_avg_rating --and calculates average vote for entire block (just one line per block)
	-- Each line (movie) gets its own value:
	-- The average rating of all films in this genre over the past 5 years (including the current one).
	
FROM movie_with_year

ORDER BY genre_name, release_year;
