-- Identify the top 5 movies in each genre based on the revenue growth rate compared to the 
-- previous movie released in the same genre. Use window functions to calculate the growth rate 
-- and rank the movies. Then, list the movies with their rank and revenue growth rate.

WITH revenue_growth AS (
    SELECT
        g.genre_name,
        m.title,
        m.revenue,
        m.release_date,
        
		LAG(m.revenue) OVER (PARTITION BY g.genre_name ORDER BY m.release_date) AS prev_revenue,
		--get previous revenue of the current film in each genre and place in separate field
        CASE
            WHEN LAG(m.revenue) OVER (PARTITION BY g.genre_name ORDER BY m.release_date) IS NULL THEN NULL
			--don't do any calculation if NULL
            ELSE ROUND(
                (m.revenue - LAG(m.revenue) OVER (PARTITION BY g.genre_name ORDER BY m.release_date))
                / LAG(m.revenue) OVER (PARTITION BY g.genre_name ORDER BY m.release_date) * 100, 2
            ) --divide current revenue by previous revenue
        END AS growth_rate
		
    FROM movies.movie m
    JOIN movies.movie_genres mg ON m.movie_id = mg.movie_id
	JOIN movies.genre g on mg.genre_id = g.genre_id
	WHERE m.revenue > 100000
	-- ORDER BY revenue
)
SELECT
    genre_name,
    title,
    growth_rate,
    RANK() OVER (PARTITION BY genre_name ORDER BY growth_rate DESC) AS rank_in_genre
	
FROM revenue_growth
WHERE growth_rate IS NOT NULL

