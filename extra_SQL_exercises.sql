-- Exercises found at https://ds.codeup.com/sql/more-exercises/

USE sakila;
-- SELECT STATEMENTS
-- 1.a Select all columns from the actor table.
SELECT * 
FROM actor;
-- 1.b Select only the last_name column from the actor table.
SELECT last_name 
FROM actor;
-- 1.c Select only the film_id, title, and release_year columns from the film table
SELECT film_id, title, release_year 
FROM film;

-- DISTINCT STATEMENTS
-- 2.a Select all distinct last names from the actor table
SELECT DISTINCT last_name 
FROM actor;
-- 2.b Select all distinct postal codes from the address table
SELECT DISTINCT postal_code 
FROM address;
-- 2.c Select all distinct ratings from the film table
SELECT DISTINCT rating 
FROM film;

-- WHERE OPERATOR
-- 3.a Select title, description, rating, movie length from the films table that last 3 hours or longer
SELECT title, description, rating, length 
FROM film 
WHERE length >= 180;
-- 3.b Select payment id, amount and payment date from payment table for payments made on or after 05/27/2005
SELECT payment_id, amount, payment_date 
FROM payment 
WHERE payment_date >= '2005-05-27';
-- 3.c Select primary key, amount, and payment date for payments made on 05/27/2005
SELECT payment_id, amount, payment_date 
FROM payment 
WHERE payment_date = '2005-05-27';
-- 3.d Select all from customer table for rows with last names beginning with S and first names ending with N
SELECT * 
FROM customer 
WHERE ((last_name LIKE 'S%') 
AND (first_name LIKE '%N'));
-- 3.e Select all from customer where customer is inactive or has last name beginning with M
SELECT * 
FROM customer 
WHERE ((active = 0) 
OR (last_name LIKE 'M%'));
-- 3.f Select all columns from category table where primary key is greater than 4 and the name begins with C, S, or T
SELECT * 
FROM category 
WHERE ((category_id > 4) 
AND (name LIKE 'C%' OR name LIKE 'S%' OR name LIKE 'T%'));
-- 3.g Select all minus password from staff table for rows that contain a password
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update 
FROM staff 
WHERE password IS NOT NULL;
-- 3.h Select all minus password from staff table for rows that do not contain a password
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update 
FROM staff 
WHERE password IS NULL;

-- IN OPERATOR
-- 4.a Select phone and district from address table for addresses in California, England, Taipei, or West Java
SELECT phone, district 
FROM address 
WHERE district IN ('California', 'England', 'Taipei', 'West Java');
-- 4.b Select payment id, amount, and payment date from payment table for payments made on
-- 05/25/2005, 5/27/2005, and 5/29/2005
SELECT payment_id, amount, payment_date 
FROM payment 
WHERE DATE(payment_date) IN ('2005-05-25','2005-05-27','2005-05-29');
-- 4.c Select all from film table for rates G, PG-13, and NC-17
SELECT * 
FROM film 
WHERE rating IN ('G', 'PG-13', 'NC-17');

-- BETWEEN OPERATOR
-- 5.a Select all from payment for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005
SELECT * 
FROM payment 
WHERE payment_date BETWEEN '2005-05-25 00:00:00' AND '2005-05-26 23:59:59';
-- 5.b Select film_id, title, and description from film table where length of description is between 100 and 120
SELECT film_id, title, description 
FROM film 
WHERE length(description) BETWEEN 100 AND 120;

-- LIKE OPERATOR
-- 6.a Select columns from film where description begins with 'A Thoughtful'
SELECT * 
FROM film 
WHERE description LIKE 'A Thoughtful%';
-- 6.b Select columns from film where description ends with 'Boat'
SELECT * 
FROM film 
WHERE description LIKE '%Boat';
-- 6.c Select columns from film where description contains 'Database' and length of film is greater than 3 hours
SELECT * 
FROM film 
WHERE ((description LIKE '%Database%') 
AND (length > 180));

-- LIMIT OPERATOR
-- 7.a Select all columns from payment table and only inlcude first 20 rows
SELECT * 
FROM payment 
LIMIT 20;
-- 7.b Select payment date and amount from payment where amount is greater than 5 and the
-- zero-based index in the result set is between 1000-2000
SELECT payment_date, amount 
FROM payment 
WHERE amount > 5 
LIMIT 1001 OFFSET 999;
-- 7.c Select all columns from customer table limiting results where index is between 101-200
SELECT * 
FROM customer 
LIMIT 100 OFFSET 100;

-- ORDER BY STATEMENTS
-- 8.a Select all from film and order rows by length in ascending order
SELECT * 
FROM film 
ORDER BY length ;
-- 8.b Select all distinct ratings from film ordered by rating in decending order
SELECT DISTINCT rating 
FROM film 
ORDER BY rating DESC;
-- 8.c Select payment date and amount from payment table for first 20 payments ordered by payment amount descending
SELECT payment_date, amount 
FROM payment 
ORDER BY amount DESC 
LIMIT 20;
-- 8.d Select title, description, special features, length, and rental duration from film for first 10
-- films with behind the scenes footage under 2 hours and rental duration between 5-7 days, ordered
-- by length in descending order
SELECT title, description, special_features, length, rental_duration 
FROM film
WHERE ((special_features LIKE '%Behind the Scenes%')
AND (length < 120)
AND (rental_duration BETWEEN 5 AND 7))
LIMIT 10;

-- JOIN STATEMENTS
-- 9.a Select customer first and last name and actor first and last name performing a left join
SELECT customer.first_name AS customer_first_name, customer.last_name AS customer_last_name, actor.first_name AS actor_first_name, actor.last_name AS actor_last_name
FROM customer
LEFT JOIN actor ON customer.last_name = actor.last_name;
-- 9.b Same as above but as a right join
SELECT customer.first_name AS customer_first_name, customer.last_name AS customer_last_name, actor.first_name AS actor_first_name, actor.last_name AS actor_last_name
FROM customer
RIGHT JOIN actor ON customer.last_name = actor.last_name;
-- 9.c Same as above but as an inner join
SELECT customer.first_name AS customer_first_name, customer.last_name AS customer_last_name, actor.first_name AS actor_first_name, actor.last_name AS actor_last_name
FROM customer
JOIN actor ON customer.last_name = actor.last_name;
-- 9.d Select city name and country name from city table performing left join with country
-- table to get country name column
SELECT city.city_id, city.country_id AS city_country_id, country.country_id AS country_country_id, country.country
FROM city
LEFT JOIN country ON city.country_id = country.country_id;
-- 9.e Select title, description, release year, and language from film table. Perform
-- left join with language table to get language column. Label language.name as "language"
SELECT film.title, film.description, film.release_year, film.language_id AS film_lang_id, language.language_id AS lang_lang_id, language.name AS "language"
FROM film
LEFT JOIN language ON film.language_id = language.language_id;
-- 9.f Select first name, last name, address, address2, city name, district, and postal code
-- from staff table. Perform 2 left joins with address table then city table to get address
-- and city related columns
SELECT staff.first_name, staff.last_name, staff.address_id AS staff_address_id, 
address.address_id AS address_address_id, address.address, address.address2, address.city_id AS address_city_id, address.district, address.postal_code,
city.city_id AS city_city_id, city.city AS city_name
FROM staff
LEFT JOIN address ON staff.address_id = address.address_id
LEFT JOIN city ON address.city_id = city.city_id;


-- MORE DRILLS

-- 1. Display the first and last names in all lowercase of all the actors.
SELECT LOWER(first_name), LOWER(last_name)
FROM actor;

-- 2. You need to find the ID number, first name, and last name of an actor, of whom you 
-- know only the first name, "Joe." What is one query would you could use to obtain this 
-- information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

-- 3. Find all actors whose last name contain the letters "gen":
SELECT *
FROM actor
WHERE last_name LIKE '%gen%';

-- 4. Find all actors whose last names contain the letters "li". This time, order the rows
-- by last name and first name, in that order.
SELECT *
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

-- 5. Using IN, display the country_id and country columns for the following countries: 
-- Afghanistan, Bangladesh, and China:
SELECT *
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 6. List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, COUNT(last_name) AS Count
FROM actor
GROUP BY last_name;

-- 7. List last names of actors and the number of actors who have that last name, but only 
-- for names that are shared by at least two actors
SELECT last_name, COUNT(last_name) AS count
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

-- 8. You cannot locate the schema of the address table. Which query would you use to 
-- recreate it?
SHOW TABLES;
DESCRIBE address;

-- 9. Use JOIN to display the first and last names, as well as the address, of each staff 
-- member.
SELECT staff.first_name, staff.last_name, staff.address_id AS staff_address_id, address.address_id AS address_id, address.address
FROM staff
LEFT JOIN address ON staff.address_id = address.address_id;

-- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.
SELECT staff.first_name, staff.last_name, staff.staff_id AS staff_id, payment.staff_id AS payment_staff_id, SUM(payment.amount)
FROM staff
LEFT JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id;

-- 11. List each film and the number of actors who are listed for that film.
SELECT film.film_id AS film_film_id, film.title, film_actor.film_id AS actor_film_id, SUM(film_actor.actor_id)
FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id;

-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film.film_id AS film_film_id, film.title, inventory.film_id AS inventory_film_id
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title = 'Hunchback Impossible';

-- 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an 
-- unintended consequence, films starting with the letters K and Q have also soared in 
-- popularity. Use subqueries to display the titles of movies starting with the letters K 
-- and Q whose language is English.
SELECT f.title, language.name AS language, f.language_id AS lang_id1, language.language_id AS lang_id2
FROM (
	SELECT *
    FROM film
    WHERE (title LIKE 'K%') OR (title LIKE 'Q%'))
    AS f
LEFT JOIN language ON f.language_id = language.language_id
WHERE language.name = 'English';

-- 14. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT f.title, actor.first_name, actor.last_name
FROM (
	SELECT title, film_id
    FROM film
    WHERE title = "Alone Trip") as f
LEFT JOIN film_actor ON f.film_id = film_actor.film_id
LEFT JOIN actor ON film_actor.actor_id = actor.actor_id;

-- 15. You want to run an email marketing campaign in Canada, for which you will need the 
-- names and email addresses of all Canadian customers.
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
LEFT JOIN address ON customer.address_id = address.address_id
LEFT JOIN city ON address.city_id = city.city_id
LEFT JOIN country ON city.country_id = country.country_id
WHERE country = 'Canada';

-- 16. Sales have been lagging among young families, and you wish to target all family 
-- movies for a promotion. Identify all movies categorized as famiy films.
SELECT film.title, category.name AS cat_name, film.film_id AS film_id1, film_category.film_id AS film_id2, 
film_category.category_id AS cat_id1, category.category_id as cat_id2
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id
LIMIT 10;

-- 17. Write a query to display how much business, in dollars, each store brought in.
SELECT customer.store_id AS Store, SUM(payment.amount)
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY Store;

-- 18. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id AS ID, city.city AS city, country.country AS country
FROM store
LEFT JOIN address ON store.address_id = address.address_id
LEFT JOIN city ON address.city_id = city.city_id
LEFT JOIN country ON city.country_id = country.country_id;

-- 19. List the top five genres in gross revenue in descending order. (Hint: you may need 
-- to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT category.name AS genre, SUM(payment.amount) AS gross_revenue
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
LEFT JOIN inventory ON film_category.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY genre
ORDER BY gross_revenue DESC
LIMIT 5;


-- NEXT SET
-- 1.a What is the average replacement cost of a film? 
SELECT AVG(replacement_cost) FROM film;

-- 1.b Does this change depending on the rating of the film?
SELECT rating, AVG(replacement_cost)
FROM film
GROUP BY rating
ORDER BY rating;

-- 2. How many different films of each genre are in the database?
SELECT category.name, COUNT(*)
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
LEFT JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY category.name;

-- 3. What are the 5 most frequently rented films?
SELECT film.title, COUNT(*)
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.title
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 4. What are the most profitable films (in terms of gross revenue)?
SELECT film.title, SUM(payment.amount) AS total
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.title
ORDER BY total DESC
LIMIT 5;

-- 5. Who is the best customer?
SELECT CONCAT(customer.last_name, ', ', customer.first_name) AS name, SUM(payment.amount) AS total
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY name
ORDER BY total DESC
LIMIT 1;

-- 6. Who are the most popular actors (that have appeared in the most films)?
SELECT CONCAT(actor.last_name, ', ', actor.first_name) AS actor_name, COUNT(film.film_id) AS total
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id
GROUP BY actor_name
ORDER BY total DESC
LIMIT 5;

-- 7. What are the sales for each store for each month in 2005?
SELECT 
	SUBSTR(payment.payment_date,1,7) AS month, 
	staff.store_id, 
	SUM(payment.amount) AS sales
FROM payment
LEFT JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY month, staff.store_id
HAVING month LIKE '2005%'
ORDER BY month;

-- 8. Find the film title, customer name, customer phone number, and customer address 
-- for all the outstanding DVDs
SELECT 
	film.title,
    CONCAT(customer.last_name, ', ', customer.first_name) AS customer_name,
	address.phone,
    address.address
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN customer ON rental.customer_id = customer.customer_id
LEFT JOIN address ON customer.address_id = address.address_id
WHERE rental.return_date IS NULL AND rental.rental_date IS NOT NULL;
    
    
-- EMPLOYEES DATABASE
-- 1. How much do the current managers of each department get paid, relative to the average
-- salary for the department? Is there any department where the department manager gets paid
-- less than the average salary?
USE employees;

-- Below gives avg department salary
SELECT departments.dept_name, AVG(salaries.salary)
FROM departments
LEFT JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
LEFT JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE dept_emp.to_date > CURDATE()
AND salaries.to_date > CURDATE()
GROUP BY departments.dept_name
ORDER BY departments.dept_name;

-- Below gives department manager salary
SELECT departments.dept_name, salaries.salary
FROM departments
LEFT JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
LEFT JOIN salaries ON dept_manager.emp_no = salaries.emp_no
WHERE dept_manager.to_date > CURDATE()
AND salaries.to_date > CURDATE()
ORDER BY departments.dept_name;

/*Tried to do it all in one table. g.salary returned as unable to aggregate g.salary.

SELECT departments.dept_name, g.salary AS manager_salary, AVG(salaries.salary)
FROM departments
LEFT JOIN (
	SELECT salaries.salary, dept_manager.dept_no
    FROM dept_manager
    LEFT JOIN salaries ON dept_manager.emp_no = salaries.emp_no
    WHERE dept_manager.to_date > CURDATE()
    AND salaries.to_date > CURDATE()
    ) as g
	ON departments.dept_no = g.dept_no
LEFT JOIN dept_emp ON g.dept_no = dept_emp.dept_no
LEFT JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE dept_emp.to_date > CURDATE()
AND salaries.to_date > CURDATE()
GROUP BY departments.dept_name;
*/


-- WORLD DATABASE
USE world;

-- 1. What languages are spoken in Santa Monica?
SELECT countrylanguage.language, countrylanguage.percentage
FROM city
LEFT JOIN countrylanguage ON city.countrycode = countrylanguage.countrycode
WHERE name LIKE "Santa Monica"
ORDER BY countrylanguage.percentage;

-- 2. How many different countries are in each region?
SELECT region, count(*) as num_countries
FROM country
GROUP BY region
ORDER BY num_countries;

-- 3. What is the population for each region?
SELECT region, SUM(population) AS population
FROM country
GROUP BY region
ORDER BY population DESC;

-- 4. What is the popoulation for each continent?
SELECT continent, SUM(population) AS population
FROM country
GROUP BY continent
ORDER BY population DESC;

-- 5. What is the average life expectancy globally?
SELECT AVG(LifeExpectancy) FROM country;

-- 6.a What is the average life expectancy for each region? Sort results
-- from shortest to longest.
SELECT region, AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY region
ORDER BY life_expectancy;

-- 6.b Each continent?
SELECT continent, AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY continent
ORDER BY life_expectancy;

-- 7. Find all the countries whose local name is different from the official name.
SELECT Name, LocalName
FROM country
WHERE Name != LocalName;

-- 8. How many countries have a life expectancy less than x?


-- 9. What state is city x located in?


-- 10. What region of the world is city x located in?


-- 11. What country (human readable anme) is city x located in?


-- 12. What is the life expectancy in city x?