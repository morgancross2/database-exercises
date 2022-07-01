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