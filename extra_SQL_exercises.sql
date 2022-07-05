USE sakila;
-- 1.a Select all columns from the actor table.
SELECT * FROM actor;
-- 1.b Select only the last_name column from the actor table.
SELECT last_name FROM actor;
-- 1.c Select only the film_id, title, and release_year columns from the film table
SELECT film_id, title, release_year FROM film;

-- 2.a Select all distinct last names from the actor table
SELECT DISTINCT last_name FROM actor;
-- 2.b Select all distinct postal codes from the address table
SELECT DISTINCT postal_code FROM address;
-- 2.c Select all distinct ratings from the film table
SELECT DISTINCT rating FROM film;

-- 3.a Select title, description, rating, movie length from the films table that last 3 hours or longer
SELECT title, description, rating, length FROM film WHERE length >= 180;
-- 3.b Select payment id, amount and payment date from payment table for payments made on or after 05/27/2005
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27';
-- 3.c Select primary key, amount, and payment date for payments made on 05/27/2005
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date = '2005-05-27';
-- 3.d Select all from customer table for rows with last names beginning with S and first names ending with N
SELECT * FROM customer WHERE ((last_name LIKE 'S%') AND (first_name LIKE '%N'));
-- 3.e Select all from customer where customer is inactive or has last name beginning with M
SELECT * FROM customer WHERE ((active = 0) OR (last_name LIKE 'M%'));
-- 3.f Select all columns from category table where primary key is greater than 4 and the name begins with C, S, or T
SELECT * FROM category WHERE ((category_id > 4) AND (name LIKE 'C%' OR name LIKE 'S%' OR name LIKE 'T%'));
-- 3.g Select all minus password from staff table for rows that contain a password
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff WHERE password IS NOT NULL;
-- 3.h Select all minus password from staff table for rows that do not contain a password
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff WHERE password IS NULL;

-- 4.a Select phone and district from address table for addresses in California, England, Taipei, or West Java
SELECT phone, district FROM address WHERE district IN ('California', 'England', 'Taipei', 'West Java');
-- 4.b Select payment id, amount, and payment date from payment table for payments made on
-- 05/25/2005, 5/27/2005, and 5/29/2005
SELECT payment_id, amount, payment_date FROM payment WHERE DATE(payment_date) IN ('2005-05-25','2005-05-27','2005-05-29');
-- 4.c Select all from film table for rates G, PG-13, and NC-17
SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17');

-- 5.a