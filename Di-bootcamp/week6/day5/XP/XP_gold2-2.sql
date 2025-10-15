-- Create a nested subquery to identify genres where the average movie revenue is above the overall 
-- average movie revenue. Within those genres, use a window function to rank movies by their popularity. 
-- Display the genre, movie title, revenue, and rank.
WITH ranked_movies AS ( -- make CTE to be able to choose only 3 records per genre
SELECT 
    g.genre_name,
	m.release_date,
    m.title,
    m.revenue,
    RANK() OVER (PARTITION BY g.genre_name ORDER BY m.popularity DESC) AS popularity_rank
	-- make blocks of movies my genre name, order by popularity and rank them within each genre
	
FROM movies.movie AS m
JOIN movies.movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN movies.genre AS g ON mg.genre_id = g.genre_id -- to get genre name

WHERE g.genre_id IN 
( -- genres with above the overall average revenue
    SELECT mg2.genre_id
    FROM movies.movie AS m2
    JOIN movies.movie_genres AS mg2 ON m2.movie_id = mg2.movie_id
    GROUP BY mg2.genre_id
    HAVING AVG(m2.revenue) > 
	(SELECT AVG(revenue) FROM movies.movie) --take average revenue of all movies
)
)
SELECT
    genre_name,
    title,
	EXTRACT(YEAR FROM release_date) AS release_year,
  	revenue,
    popularity_rank
FROM ranked_movies
WHERE popularity_rank <= 5
ORDER BY genre_name, popularity_rank;
