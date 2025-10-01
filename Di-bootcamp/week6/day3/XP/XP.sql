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

--2---------------------------------------------------
-- Example: change some films from English (1) to Italian (2)
UPDATE film
SET language_id = 2
WHERE film_id IN (1, 2, 3);

-- To see all constraints
SELECT conname, confrelid::regclass AS referenced_table
FROM pg_constraint
WHERE conrelid = 'customer'::regclass;

DROP TABLE customer_review;
--Success

SELECT COUNT(*) AS outstanding_rentals
FROM rental
WHERE return_date IS NULL;

SELECT f.film_id, f.title, f.rental_rate, f.replacement_cost
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NULL
ORDER BY f.rental_rate DESC
LIMIT 30;

SELECT f.film_id, f.title, f.description
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.first_name = 'PENELOPE' 
  AND a.last_name = 'MONROE'
  AND f.description ILIKE '%sumo%';

SELECT film_id, title, length, rating
FROM film
WHERE length < 60
  AND rating = 'R'
  AND description ILIKE '%documentary%';

SELECT DISTINCT f.film_id, f.title, p.amount, r.return_date
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.first_name = 'MATTHEW' 
  AND c.last_name = 'MAHAN'
  AND p.amount > 4
  AND r.return_date BETWEEN '2005-07-28' AND '2005-08-01';

SELECT DISTINCT f.film_id, f.title, f.replacement_cost
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.first_name = 'MATTHEW'
  AND c.last_name = 'MAHAN'
  AND (f.title ILIKE '%boat%' OR f.description ILIKE '%boat%')
ORDER BY f.replacement_cost DESC;








