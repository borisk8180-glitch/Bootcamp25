SELECT DISTINCT name FROM language
ORDER BY NAME;

SELECT f.title, f.description, l.name
FROM film f INNER JOIN language l
ON f.language_id = l.language_id;

SELECT f.title, f.description, l.name
FROM  film f LEFT JOIN language l
ON f.language_id = l.language_id
ORDER BY l.name, f.title;

CREATE TABLE IF NOT EXISTS public.new_film
(
    id bigint NOT NULL,
    name VARCHAR(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT new_film_pkey PRIMARY KEY (id)
);

INSERT INTO new_film (
name) VALUES (
'Cruel, Cruel Love', 'Mabel at the Wheel')


DROP TABLE IF EXISTS public.customer_review;

CREATE TABLE customer_review (
    review_id SERIAL PRIMARY KEY, -- auto-increment, not null by default
    film_id INT NOT NULL,
    language_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    score INT CHECK (score BETWEEN 1 AND 10), -- must be between 1 and 10
    review_text TEXT, -- no length limit
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_film
        FOREIGN KEY (film_id)
        REFERENCES new_film (id)
        ON DELETE CASCADE, -- if film deleted, review is deleted
    
    CONSTRAINT fk_language
        FOREIGN KEY (language_id)
        REFERENCES language (language_id)
);


INSERT INTO customer_review (
film_id, language_id, title, score, review_text) VALUES (
2, 4, 'Greatest review', 10, 'Longest text')

INSERT INTO customer_review (
film_id, language_id, title, score, review_text) VALUES (
3, 2, 'Greate review', 5, 'Long text')

DELETE FROM public.new_film
    WHERE id IN (4);
