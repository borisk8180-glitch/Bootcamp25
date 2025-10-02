DROP TABLE IF EXISTS public.customer;

CREATE TABLE IF NOT EXISTS public.customer
(
    id integer NOT NULL DEFAULT nextval('customer_id_seq'::regclass),
    first_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT customer_pkey PRIMARY KEY (id)
)


DROP TABLE IF EXISTS public.customer_profile;

CREATE TABLE IF NOT EXISTS public.customer_profile
(
    id SERIAL NOT NULL,
    isLoggedIn BOOLEAN NOT NULL DEFAULT false,
    customer_id INT NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id),
    CONSTRAINT fkey_cust_id FOREIGN KEY (customer_id)
        REFERENCES public.customer (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

COMMENT ON CONSTRAINT fkey_cust_id ON public.customer_profile
    IS 'reference table customer';


-- 3. Insert Customers
INSERT INTO Customer (first_name, last_name)
VALUES
('John', 'Doe'),
('Jerome', 'Lalu'),
('Lea', 'Rive');

-- 4. Insert Customer Profiles using subqueries
-- John is loggedIn
INSERT INTO Customer_profile (isLoggedIn, customer_id)
VALUES (
    TRUE,
    (SELECT id FROM Customer WHERE first_name = 'John' AND last_name = 'Doe')
);

-- Jerome is NOT logged in (default false, so we can omit isLoggedIn)
INSERT INTO Customer_profile (customer_id)
VALUES (
    (SELECT id FROM Customer WHERE first_name = 'Jerome' AND last_name = 'Lalu')
);

------------------------------------------------
-- QUERIES
------------------------------------------------

-- 5. First_name of the loggedIn customers
SELECT c.first_name
FROM Customer c
JOIN Customer_profile cp ON c.id = cp.customer_id
WHERE cp.isLoggedIn = TRUE;

-- 6. All customers first_name + isLoggedIn (including those without profile)
SELECT c.first_name, cp.isLoggedIn
FROM Customer c
LEFT JOIN Customer_profile cp ON c.id = cp.customer_id;

-- 7. Number of customers that are not LoggedIn
SELECT COUNT(*) AS not_logged_in_customers
FROM Customer c
LEFT JOIN Customer_profile cp ON c.id = cp.customer_id
WHERE cp.isLoggedIn = FALSE OR cp.isLoggedIn IS NULL;