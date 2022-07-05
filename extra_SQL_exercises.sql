USE sakila;
-- SELECT STATEMENTS
-- 1.a Select all columns from the actor table.
SELECT * FROM actor;
-- 1.b Select only the last_name column from the actor table.
SELECT last_name FROM actor;
-- 1.c Select only the film_id, title, and release_year columns from the film table
SELECT film_id, title, release_year FROM film;

-- DISTINCT STATEMENTS
-- 2.a Select all distinct last names from the actor table
SELECT DISTINCT last_name FROM actor;
-- 2.b Select all distinct postal codes from the address table
SELECT DISTINCT postal_code FROM address;
-- 2.c Select all distinct ratings from the film table
SELECT DISTINCT rating FROM film;

-- WHERE OPERATOR
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

-- IN OPERATOR
-- 4.a Select phone and district from address table for addresses in California, England, Taipei, or West Java
SELECT phone, district FROM address WHERE district IN ('California', 'England', 'Taipei', 'West Java');
-- 4.b Select payment id, amount, and payment date from payment table for payments made on
-- 05/25/2005, 5/27/2005, and 5/29/2005
SELECT payment_id, amount, payment_date FROM payment WHERE DATE(payment_date) IN ('2005-05-25','2005-05-27','2005-05-29');
-- 4.c Select all from film table for rates G, PG-13, and NC-17
SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17');

-- BETWEEN OPERATOR
-- 5.a Select all from payment for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005
SELECT * FROM payment WHERE payment_date BETWEEN '2005-05-25 00:00:00' AND '2005-05-26 23:59:59';
-- 5.b Select film_id, title, and description from film table where length of description is between 100 and 120
SELECT film_id, title, description FROM film WHERE length(description) BETWEEN 100 AND 120;

-- LIKE OPERATOR
-- 6.a Select columns from film where description begins with 'A Thoughtful'
SELECT * FROM film WHERE description LIKE 'A Thoughtful%';
-- 6.b Select columns from film where description ends with 'Boat'
SELECT * FROM film WHERE description LIKE '%Boat';
-- 6.c Select columns from film where description contains 'Database' and length of film is greater than 3 hours
SELECT * FROM film WHERE ((description LIKE '%Database%') AND (length > 180));

-- LIMIT OPERATOR
-- 7.a Select all columns from payment table and only inlcude first 20 rows
SELECT * FROM payment LIMIT 20;
-- 7.b Select payment date and amount from payment where amount is greater than 5 and the
-- zero-based index in the result set is between 1000-2000
SELECT payment_date, amount FROM payment WHERE amount > 5 LIMIT 1001 OFFSET 999;
-- 7.c Select all columns from customer table limiting results where index is between 101-200
SELECT * FROM customer LIMIT 100 OFFSET 100;

-- ORDER BY STATEMENTS
-- 8.a Select all from film and order rows by length in ascending order
SELECT * FROM film ORDER BY length ;
-- 8.b Select all distinct ratings from film ordered by rating in decending order
SELECT DISTINCT rating FROM film ORDER BY rating DESC;
-- 8.c Select payment date and amount from payment table for first 20 payments ordered by payment amount descending
SELECT payment_date, amount FROM payment ORDER BY amount DESC LIMIT 20;
-- 8.d Select title, description, special features, length, and rental duration from film for first 10
-- films with behind the scenes footage under 2 hours and rental duration between 5-7 days, ordered
-- by length in descending order
SELECT title, description, special_features, length, rental_duration FROM film
WHERE ((special_features LIKE '%Behind the Scenes%')
AND (length < 120)
AND (rental_duration BETWEEN 5 AND 7))
LIMIT 10;

-- JOIN STATEMENTS