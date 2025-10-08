-- Use the FIRST_VALUE() function to find the most recent movie within each genre based on the release date. 
-- Display the genre name, movie title, and release date.

SELECT
    g.genre_name,
    m.title,
    m.release_date,
	-- picks the title of the most recent movie in that genre
    FIRST_VALUE(m.title) OVER (PARTITION BY g.genre_name --the function works separately for each genre.
	ORDER BY m.release_date DESC) AS most_recent_movie
FROM movies.movie AS m
JOIN movies.movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN movies.genre AS g ON mg.genre_id = g.genre_id
ORDER BY g.genre_name, m.release_date DESC;
