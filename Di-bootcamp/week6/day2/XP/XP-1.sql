CREATE TABLE items(
 item_id SERIAL PRIMARY KEY,
 item_name VARCHAR (50) NOT NULL,
 price NUMERIC(10,2) NOT NULL 
 );

CREATE TABLE customers(
 customer_id SERIAL PRIMARY KEY,
 first_name VARCHAR(50),
 last_name VARCHAR (150) NOT NULL
 )

INSERT INTO items (item_name, price) VALUES
('Small Desk', 100),
('Large Desk', 300),
('Fan', 80);

-- Insert customers into customers table
INSERT INTO customers (first_name, last_name) VALUES
('Greg', 'Jones'),
('Sandra', 'Jones'),
('Scott', 'Scott'),
('Trevor', 'Green'),
('Melanie', 'Johnson');

-- Queries

-- 1. Fetch all the items
SELECT * FROM items;
SELECT * FROM customers;

-- 2. Fetch all the items with a price above 80 (80 not included)
SELECT * FROM items
WHERE price > 80;

-- 3. Fetch all the items with a price below 300 (300 included)
SELECT * FROM items
WHERE price <= 300;

-- 4. Fetch all customers whose last name is 'Smith'
SELECT * FROM customers
WHERE last_name = 'Smith';
-- Outcome: No rows (since we didn’t insert any customers with last_name 'Smith')

-- 5. Fetch all customers whose last name is 'Jones'
SELECT * FROM customers
WHERE last_name = 'Jones';

-- 6. Fetch all customers whose firstname is not 'Scott'
SELECT * FROM customers
WHERE first_name <> 'Scott';

-- All items, ordered by price (lowest to highest).
SELECT * FROM items
ORDER BY price;
-- Items with a price above 80 (80 included), ordered by price (highest to lowest).
SELECT * FROM items
WHERE price >= 80
ORDER BY price;
-- The first 3 customers in alphabetical order of the first name (A-Z) – exclude the primary key column from the results.
SELECT first_name, last_name
FROM customers
ORDER BY first_name ASC
LIMIT 3;

-- All last names (no other columns!), in reverse alphabetical order (Z-A)
SELECT last_name
FROM customers
ORDER BY last_name DESC;


