-- Calculate the rolling average revenue for movies within each genre, considering only the last three movies released in the genre. 
-- Use window functions with the ROWS frame specification to achieve this.
SELECT 
    g.genre_name,
    m.title,
    m.release_date,
    m.revenue,
    ROUND(AVG(m.revenue) OVER (PARTITION BY g.genre_name  ORDER BY m.release_date
	-- Divides all films by genre — each group is considered separately and orders by resease date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)) AS rolling_avg_revenue
		-- Defines a “window" from the current movie and the previous two — 
		-- that is, the last three films in the genre-and calculates their average revenue.
FROM movies.movie AS m
JOIN movies.movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN movies.genre AS g 		   ON mg.genre_id = g.genre_id
ORDER BY g.genre_name, m.release_date;
