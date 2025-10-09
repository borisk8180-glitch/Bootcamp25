-- Calculate the average budget growth rate for each production company across all movies they have produced. 
-- Use window functions to determine the budget growth rate and then calculate the average growth rate.

WITH company_budget_growth AS (
    SELECT
        pc.company_name,
        m.movie_id,
        m.title,
        m.budget,
        LAG(m.budget) OVER (PARTITION BY pc.company_name 
		ORDER BY m.release_date) AS prev_budget
		--to get the previous movie’s budget for the same company.
		
    FROM movies.movie AS m 
    JOIN movies.movie_company AS mc ON m.movie_id = mc.movie_id
    JOIN movies.production_company AS pc ON mc.company_id = pc.company_id
	AND budget>0
),
	budget_growth_calc AS (
	    SELECT
	        company_name,
	        movie_id,
	        title,
	        budget,
	        prev_budget,
	        CASE 
	            WHEN prev_budget IS NULL OR prev_budget = 0 THEN NULL
	            ELSE (budget - prev_budget) / prev_budget::DECIMAL
	        END AS budget_growth_rate
	    FROM company_budget_growth
)

-- SELECT * FROM budget_growth_calc

SELECT
    company_name,
    ROUND(AVG(budget_growth_rate)) AS avg_budget_growth_rate
FROM budget_growth_calc
GROUP BY company_name, budget_growth_rate
HAVING budget_growth_rate IS NOT NULL
ORDER BY avg_budget_growth_rate DESC;


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


-- Identify the movie series (based on shared keywords) with the highest total revenue. 
-- Use window functions and CTEs to group movies by their series and calculate the total revenue.

WITH series_revenue AS (
    SELECT 
        k.keyword_name AS series_name,
        SUM(m.revenue) AS total_revenue
		
    FROM movies.movie AS m
    JOIN movies.movie_keywords AS mk ON m.movie_id = mk.movie_id
    JOIN movies.keyword AS k 	     ON mk.keyword_id = k.keyword_id
    GROUP BY k.keyword_name --Groups movies by keywords (keyword_name),
							-- which act as "series" identifiers
),
ranked_series AS (
    SELECT 
		series_name,
        total_revenue,
        RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
		-- Assigns each series a rank (RANK()) in descending order of income
    FROM series_revenue
)
SELECT 
    series_name AS movie_series,
    total_revenue
FROM ranked_series
WHERE revenue_rank = 1;
olling average revenue for movies within each genre, considering only the last three movies released in the genre. 
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


-- Identify the movie series (based on shared keywords) with the highest total revenue. 
-- Use window functions and CTEs to group movies by their series and calculate the total revenue.

WITH series_revenue AS (
    SELECT 
        k.keyword_name AS series_name,
        SUM(m.revenue) AS total_revenue
		
    FROM movies.movie AS m
    JOIN movies.movie_keywords AS mk ON m.movie_id = mk.movie_id
    JOIN movies.keyword AS k 	     ON mk.keyword_id = k.keyword_id
    GROUP BY k.keyword_name --Groups movies by keywords (keyword_name),
							-- which act as "series" identifiers
),
ranked_series AS (
    SELECT 
		series_name,
        total_revenue,
        RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
		-- Assigns each series a rank (RANK()) in descending order of income
    FROM series_revenue
)
SELECT 
    series_name AS movie_series,
    total_revenue
FROM ranked_series
WHERE revenue_rank = 1;
