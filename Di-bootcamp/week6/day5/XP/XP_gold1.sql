-- Use the LEAD() and LAG() functions to identify movies where the budget increased compared to the previous movie 
-- but decreased compared to the next movie, in order of their release dates.
-- Display the movie title release date, and budget, along with the previous and next budgets.

SELECT 
    title,
    release_date,
    budget,
	prev_budget,
	next_budget

FROM (
    SELECT 
        title,
        release_date,
        budget,
        LAG(budget) OVER (ORDER BY release_date) AS prev_budget, --previous budget
        LEAD(budget) OVER (ORDER BY release_date) AS next_budget --next budget
    FROM movies.movie
) sub
WHERE budget > prev_budget AND budget < next_budget AND prev_budget>0
;
