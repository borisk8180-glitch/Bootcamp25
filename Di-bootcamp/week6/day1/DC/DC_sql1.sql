

-- DROP TABLE actors
CREATE TABLE actors (
 actor_id SERIAL PRIMARY KEY,
 first_name VARCHAR (50) NOT NULL,
 last_name VARCHAR (100) NOT NULL,
 age DATE NOT NULL,
 number_oscars SMALLINT NOT NULL
)

INSERT INTO actors (first_name, last_name, age, number_oscars)
-- VALUES('Matt','Damon','1970-10-08', 5);

INSERT INTO actors (first_name, last_name, age, number_oscars)
VALUES('Maria','Glayzer','06-05-1999', 2);

INSERT INTO actors (first_name, last_name, age, number_oscars)
VALUES('George','Clooney','06-05-1961', 2);

select * FROM actors

SELECT COUNT(*) AS total_actors
FROM actors;


INSERT INTO actors (first_name, last_name, age, number_oscars)
VALUES (NULL, NULL, NULL, NULL);

CREATE TABLE movies (
movie_id SERIAL,
movie_title VARCHAR (50) NOT NULL,
movie_story TEXT,
actor_playing_id INTEGER,
PRIMARY KEY (movie_id),
FOREIGN KEY (actor_playing_id) REFERENCES actors (actor_id)
);

INSERT INTO movies (movie_title, movie_story, actor_playing_id) VALUES
    ( 'Good Will Hunting', 
    'Written by Affleck and Damon, the film follows 20-year-old South Boston janitor Will Hunting',
    (SELECT actor_id from actors WHERE first_name='Matt' AND last_name='Damon')),
    ( 'Oceans Eleven', 
    'American heist film directed by Steven Soderbergh and written by Ted Griffin.', 
    (SELECT actor_id from actors WHERE first_name='Matt' AND last_name='Damon'));

CREATE TABLE producers AS p(
producer_id SERIAL,
producer_first_name VARCHAR (50) NOT NULL,
producer_last_name VARCHAR (150) NOT NULL,
movie_id INTEGER,
PRIMARY KEY (producer_id),
FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
);

INSERT INTO producers (producer_first_name, producer_last_name, movie_id) VALUES
    ( 'Christopher', 'Nouland', (SELECT movie_id from movies WHERE movie_title='Oceans Eleven'));

SELECT p.producer_first_name, p.producer_last_name, m.movie_title
FROM producers AS p
INNER JOIN movies AS m
ON p.producer_id = m.movie_id;

SELECT p.producer_first_name, p.producer_last_name, m.movie_title
FROM producers AS p
RIGHT JOIN movies AS m
ON p.producer_id = m.movie_id;


CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100)
);


INSERT INTO countries (country_name) VALUES
('USA'),        
('UK'),         
('France'),     
('Germany'),    
('Italy');      

SELECT * FROM countries

SELECT a.actor_id, a.first_name, a.last_name, c.country_id, c.country_name
FROM actors a
INNER JOIN countries c
    ON a.actor_id = c.country_id;

SELECT a.actor_id, a.first_name, a.last_name, c.country_id, c.country_name
FROM actors a
LEFT JOIN countries c
    ON a.actor_id = c.country_id;

SELECT a.actor_id, a.first_name, a.last_name, c.country_id, c.country_name
FROM actors a
RIGHT JOIN countries c
    ON a.actor_id = c.country_id;

SELECT a.actor_id, a.first_name, a.last_name, c.country_id, c.country_name
FROM actors a
FULL JOIN countries c
    ON a.actor_id = c.country_id;

