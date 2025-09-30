--JOINS IN SQL

--INNER JOIN

-- SELECT actors.first_name, actors.last_name,movies.movie_title
-- FROM actors
-- INNER JOIN movies
-- ON actors.actor_id = movies.actor_playing_id

--EXERCISE IN CLASS
-- CREATE TABLE producers(
-- producer_id SERIAL,
-- first_name VARCHAR(50) NOT NULL,
-- last_name VARCHAR(100) NOT NULL,
-- produced_movie_id INTEGER,
-- PRIMARY KEY (producer_id),
-- FOREIGN KEY (produced_movie_id) REFERENCES movies (movie_id)
-- )

-- INSERT INTO producers(first_name, last_name, produced_movie_id)
-- VALUES
-- ('Lawrence', 'Bender', (SELECT movie_id FROM movies WHERE movie_title = 'Good Will Hunting')),
-- ('Jerry', 'Weintraub', (SELECT movie_id FROM movies WHERE movie_title = 'Oceans Eleven')),
-- ('Christopher', 'Nolan', NULL)

-- SELECT m.movie_title, p.first_name, p.last_name
-- FROM movies AS m
-- INNER JOIN producers AS p
-- ON m.movie_id = p.produced_movie_id

--LEFT JOIN

-- SELECT p.first_name, p.last_name, m.movie_title
-- FROM producers AS p
-- LEFT JOIN movies AS m
-- ON p.produced_movie_id = m.movie_id


--JUST ADDING A MOVIE THAT DOESN'T HAVE A PRODUCER SO WE CAN SHOW THE FULL JOIN
-- INSERT INTO movies (movie_title, movie_story, actor_playing_id)
-- VALUES
-- ('Harry Potter and the philosophal stone', 'Harry Potter discovers that he is a wizard and that he will start learning at Hogwarts', 
-- (SELECT actor_id FROM actors WHERE first_name = 'Gal' AND last_name = 'Gadot'))

--FULL JOIN
-- SELECT p.first_name, p.last_name, m.movie_title
-- FROM producers AS p
-- FULL JOIN movies as m
-- ON p.produced_movie_id = m.movie_id

--EXERCISE 2 IN CLASS
-- CREATE TABLE countries(
-- country_id SERIAL PRIMARY KEY,
-- country_name VARCHAR(50) NOT NULL)

-- INSERT INTO countries (country_name)
-- VALUES('Israel'),('USA'), ('Brazil')

INSERT INTO countries (country_name)
VALUES('England'),('France');

SELECT c.country_name, a.first_name
FROM countries as c
FULL JOIN actors as a
ON c.country_id = a.actor_id

