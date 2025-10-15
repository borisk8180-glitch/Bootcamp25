-- Calculate the cumulative average rating for each movie in each genre, but only include movies 
-- that have at least 50 votes. Use the AVG() function with windowing and filter the results.

SELECT
    g.genre_name,
    m.title,
    m.popularity,
    m.vote_count,
    ROUND(AVG(m.popularity) OVER ( --average popularity
        PARTITION BY g.genre_name
        ORDER BY m.release_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ),2)AS cumulative_avg_rating
FROM movies.movie m
JOIN movies.movie_genres mg ON m.movie_id = mg.movie_id
JOIN movies.genre g ON mg.genre_id = g.genre_id
WHERE m.vote_count >= 50;
