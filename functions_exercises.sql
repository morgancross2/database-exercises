-- 1. Copy the order by exercise and save it as functions_exercises.sql.

	-- 1. Create a new file named order_by_exercises.sql and copy in the contents of your 
	-- exercise from the previous lesson.

		-- 1. use employees database
		USE employees;
		-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN.
		-- How many records were returned? 709
		SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
		-- 3. Same Q as above but using OR instead of insert
		-- How many records were returned? 1000
		SELECT * FROM employees WHERE first_name = ('Irena' OR 'Vidya' OR 'Maya');
		-- 4. Find all current employees with above names and is male.
		-- How many records were returned? 441
		SELECT * FROM employees WHERE (first_name IN ('Irena', 'VIdya', 'Maya') AND gender = "M");
		-- 5. Find all employees whose last name stars with 'E'
		-- How many returned? 7330
		SELECT * FROM employees WHERE last_name lIKE "E%";
		-- 6. Starts or ends with E?
		-- How many returned? 30723
		-- How many end with E but do not start with E? 23393
		SELECT * FROM employees WHERE (last_name LIKE "E%" OR last_name LIKE "%e");
		SELECT 30723 - 7330;
		-- 7. Starts AND ends with E?
		-- How many returned? 899
		SELECT * FROM employees WHERE (Last_name LIKE "E%" AND last_name LIKE "%e");
		-- 8. Find count of employees hired in the 90s. How many? 135214
		SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
		-- 9. How many were born on Christmas? 842
		SELECT * FROM employees WHERE birth_date LIKE '%12-25';
		-- 10. How many were hired in the 90s AND born on Christmas? 362
		SELECT * FROM employees WHERE ((hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (birth_date LIKE '%12-25'));
		-- 11. How many have a 'q' in their last name? 1873
		SELECT * FROM employees WHERE last_name LIKE '%q%';
		-- 12. How many have a 'q' in their last name but not 'qu'? 547
		SELECT * FROM employees WHERE (last_name LIKE '%q%' AND last_name NOT LIKE '%qu%');

	-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your 
	-- results returned by first name. In your comments, answer: What was the first and 
	-- last name in the first row of the results? What was the first and last name of the 
	-- last person in the table?
	SELECT * 
	FROM employees 
	WHERE first_name IN ('Irena','Vidya', 'Maya') 
	ORDER BY first_name;
	-- First and last name in first row: Irena Reutenauer
	-- First and last name in last row: Vidya Simmen

	-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your 
	-- results returned by first name and then last name. In your comments, answer: What was 
	-- the first and last name in the first row of the results? What was the first and last 
	-- name of the last person in the table?
	SELECT *
	FROM employees
	WHERE first_name IN ('Irena','Vidya','Maya')
	ORDER BY first_name, last_name;
	-- First row: Irena Acton
	-- Last row: Vidya Zweizig

	-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your 
	-- results returned by last name and then first name. In your comments, answer: What was 
	-- the first and last name in the first row of the results? What was the first and last 
	-- name of the last person in the table?
	SELECT *
	FROM employees
	WHERE first_name IN ('Irena','Vidya','Maya')
	ORDER BY last_name, first_name;
	-- First row: Irena Acton
	-- Last row: Maya Zyda

	-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. 
	-- Sort the results by their employee number. Enter a comment with the number of employees 
	-- returned, the first employee number and their first and last name, and the last employee 
	-- number with their first and last name.
	SELECT *
	FROM employees
	WHERE last_name LIKE 'e%e'
	ORDER BY emp_no;
	-- 899 employees returned
	-- First listed: 10021 Ramzi Erde
	-- Last listed: 499648 Tadahiro Erde

	-- 6. Write a query to to find all employees whose last name starts and ends with 'E'. 
	-- Sort the results by their hire date, so that the newest employees are listed first. 
	-- Enter a comment with the number of employees returned, the name of the newest employee, 
	-- and the name of the oldest employee.
	SELECT *
	FROM employees
	WHERE last_name LIKE 'e%e'
	ORDER BY hire_date DESC;
	-- 899 employees returned
	-- Newest: Teiji Eldridge
	-- Oldest: Sergi Erde

	-- 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that 
	-- the oldest employee who was hired last is the first result. Enter a comment with the 
	-- number of employees returned, the name of the oldest employee who was hired last, and 
	-- the name of the youngest employee who was hired first.
	SELECT *
	FROM employees
	WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%-12-25'
	ORDER BY birth_date, hire_date DESC;
	-- 362 employees returned
	-- Oldest employee hired last: Khun Bernini
	-- Youngest employee hired first: Douadi Pettis
    
-- 2. Write a query to to find all employees whose last name starts and ends with 'E'. Use 
-- concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name 
FROM employees
WHERE last_name lIKE "E%";

-- 3. Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name 
FROM employees
WHERE last_name lIKE "E%";

-- 4. Find all employees hired in the 90s and born on Christmas. Use datediff() function to 
-- find how many days they have been working at the company (Hint: You will also need to use
--  NOW() or CURDATE()),
SELECT first_name, last_name, datediff(CURDATE(),hire_date) AS employed_length
	FROM employees
	WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%-12-25';

-- 5. Find the smallest and largest current salary from the salaries table.
SELECT MAX(salary), MIN(salary)
FROM salaries;

-- 6. Use your knowledge of built in SQL functions to generate a username for all of the 
-- employees. A username should be all lowercase, and consist of the first character of the 
-- employees first name, the first 4 characters of the employees last name, an underscore, 
-- the month the employee was born, and the last two digits of the year that they were born.
-- Below is an example of what the first 10 rows will look like:
SELECT LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),'_',SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username,
first_name, last_name, birth_date
FROM employees
LIMIT 10;

-- +------------+------------+-----------+------------+
-- | username   | first_name | last_name | birth_date |
-- +------------+------------+-----------+------------+
-- | gface_0953 | Georgi     | Facello   | 1953-09-02 |
-- | bsimm_0664 | Bezalel    | Simmel    | 1964-06-02 |
-- | pbamf_1259 | Parto      | Bamford   | 1959-12-03 |
-- | ckobl_0554 | Chirstian  | Koblick   | 1954-05-01 |
-- | kmali_0155 | Kyoichi    | Maliniak  | 1955-01-21 |
-- | apreu_0453 | Anneke     | Preusig   | 1953-04-20 |
-- | tziel_0557 | Tzvetan    | Zielinski | 1957-05-23 |
-- | skall_0258 | Saniya     | Kalloufi  | 1958-02-19 |
-- | speac_0452 | Sumant     | Peac      | 1952-04-19 |
-- | dpive_0663 | Duangkaew  | Piveteau  | 1963-06-01 |
-- +------------+------------+-----------+------------+
-- 10 rows in set (0.05 sec)
