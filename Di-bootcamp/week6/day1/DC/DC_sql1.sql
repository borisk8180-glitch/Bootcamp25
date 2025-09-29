

-- DROP TABLE actors
CREATE TABLE actors(
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
-- ERROR:  значение NULL в столбце "first_name" отношения "actors" нарушает ограничение NOT NULL
-- Ошибочная строка содержит (4, null, null, null, null). 

-- ОШИБКА:  значение NULL в столбце "first_name" отношения "actors" нарушает ограничение NOT NULL
-- SQL state: 23502
-- Detail: Ошибочная строка содержит (4, null, null, null, null).

