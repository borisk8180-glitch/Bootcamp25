-- Use the SUM() function with the ROWS frame specification to calculate the running total 
-- of movie budgets within each genre. Display the genre name, movie title, budget, and running total budget.

SELECT
    g.genre_name,
    m.title,
    m.budget,
    SUM(m.budget) OVER (PARTITION BY g.genre_name ORDER BY m.date --means the running total restarts for each genre
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_budget
FROM movies.movie AS m
JOIN movies.movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN movies.genre AS g ON mg.genre_id = g.genre_id
WHERE m.budget>0
ORDER BY g.genre_name, m.budget;
