SELECT DISTINCT film.title, rental.rental_date, rental.return_date
from (film INNER
JOIN inventory ON film.film_id=inventory.film_id) INNER JOIN rental ON
inventory.inventory_id=rental.inventory_id
where (((rental.rental_date) is NOT
null) AND ((rental.return_date) is null));

SELECT DISTINCT customer.first_name, customer.last_name, film.title
from
customer INNER JOIN ((film INNER JOIN inventory ON
film.film_id=inventory.film_id) INNER JOIN rental ON
inventory.inventory_id=rental.inventory_id) ON
customer.customer_id=rental.customer_id
where (((rental.rental_date) is NOT
null) AND ((rental.return_date) is null));

SELECT category.name, film.title, actor.first_name, actor.last_name
from (film
INNER JOIN (actor INNER JOIN film_actor ON actor.actor_id =
film_actor.actor_id) ON film.film_id = film_actor.film_id) INNER JOIN (category
INNER JOIN film_category ON category.category_id = film_category.category_id)
ON film.film_id = film_category.film_id
where (((actor.first_name)='Joe') AND
((actor.last_name)='Swank'))
order BY category.name, film.title;

SELECT sum(store.store_id) AS sum_store_id, country.country, city.city
from
(country INNER JOIN (city INNER JOIN address ON city.city_id = address.city_id)
ON country.country_id = city.country_id) INNER JOIN store ON address.address_id
= store.address_id
group BY country.country, city.city;


SELECT sum(film.length) AS sum_length, film.title, store.store_id
from store
INNER JOIN (film INNER JOIN inventory ON film.film_id = inventory.film_id) ON
store.store_id = inventory.store_id
group BY film.title, store.store_id;

SELECT sum(film.length) AS sum_length, film.title, store.store_id,
rental.rental_date, rental.return_date
from (store INNER JOIN (film INNER JOIN
inventory ON film.film_id=inventory.film_id) ON
store.store_id=inventory.store_id) INNER JOIN rental ON
inventory.inventory_id=rental.inventory_id
group BY film.title,
store.store_id, rental.rental_date, rental.return_date
having
(((rental.rental_date) is NOT null) AND ((rental.return_date) is null));


SELECT country.country, customer.last_name, customer.first_name
from ((country
INNER JOIN (city INNER JOIN address ON city.city_id=address.city_id) ON
country.country_id=city.country_id) INNER JOIN store ON
address.address_id=store.address_id) INNER JOIN customer ON
store.store_id=customer.store_id
order BY country.country, customer.last_name,
customer.first_name;

SELECT category.name, F.title
from film F INNER JOIN (category INNER JOIN film_category
ON category.category_id = film_category.category_id) ON F.film_id =
film_category.film_id
WHERE F.film_id NOT IN (
    SELECT FC.film_id
    FROM Film_Category AS FC
    INNER JOIN Category AS C
        ON FC.category_id = C.Category_id
    WHERE C.Name = 'Horror'
)
OR (
    F.Title LIKE '*beast*'
    OR F.Title LIKE '*monster*'
    OR F.Title LIKE '*ghost*'
    OR F.Title LIKE '*dead*'
    OR F.Title LIKE '*zombie*'
    OR F.Title LIKE '*undead*'
    OR F.Description LIKE '*beast*'
    OR F.Description LIKE '*monster*'
    OR F.Description LIKE '*ghost*'
    OR F.Description LIKE '*dead*'
    OR F.Description LIKE '*zombie*'
    OR F.Description LIKE '*undead*'
);



