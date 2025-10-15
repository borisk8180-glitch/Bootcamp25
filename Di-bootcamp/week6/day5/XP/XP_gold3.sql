-- Use the ROW_NUMBER(), RANK(), and DENSE_RANK() functions to create a comprehensive ranking system 
-- for movies based on revenue within each genre. Display the genre, movie title, revenue, 
-- and their respective row number, rank, and dense rank.

SELECT 
    g.genre_name,
    m.title,
    m.revenue,
    ROW_NUMBER() OVER (PARTITION BY g.genre_name ORDER BY m.revenue DESC) AS row_num,
    RANK() OVER (PARTITION BY g.genre_name ORDER BY m.revenue DESC) AS rank_num,
    DENSE_RANK() OVER (PARTITION BY g.genre_name ORDER BY m.revenue DESC) AS dense_rank_num
FROM movies.movie AS m
JOIN movies.movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN movies.genre AS g ON mg.genre_id = g.genre_id
ORDER BY g.genre_name, m.revenue DESC;
