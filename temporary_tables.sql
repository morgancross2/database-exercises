USE employees;
-- 1. Using the example from the lesson, create a temporary table called employees_with_departments 
-- that contains first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", 
-- it means that the query was attempting to write a new table to a database that you can only read.
CREATE TEMPORARY TABLE leavitt_1866.employees_with_departments AS
	SELECT first_name, last_name, dept_name
		FROM employees
        JOIN dept_emp USING (emp_no)
        JOIN departments USING (dept_no);

USE leavitt_1866;
SELECT * FROM employees_with_departments LIMIT 10;
    

-- 1.a Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the 
-- lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

-- 1.b Update the table so that full name column contains the correct data
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

-- 1.c Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP first_name;
ALTER TABLE employees_with_departments DROP last_name;

-- 1.d What is another way you could have ended up with this same table?
-- created the initial temporary table with a concat instead of each column

-- 2.a Create a temporary table based on the payment table from the sakila database.
USE sakila;

CREATE TEMPORARY TABLE leavitt_1866.temp_pay(
	SELECT * FROM payment);
    
USE leavitt_1866;

-- 2.b Write the SQL necessary to transform the amount column such that it is stored as an integer representing 
-- the number of cents of the payment. For example, 1.99 should become 199.
ALTER TABLE temp_pay ADD newamount INT;
UPDATE temp_pay SET newamount = amount*100;
SELECT * FROM temp_pay LIMIT 10;
ALTER TABLE temp_pay DROP amount;

-- 3. Find out how the current average pay in each department compares to the overall current pay for everyone 
-- at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of 
-- salary, what is the best department right now to work for? The worst?
USE employees;

CREATE TEMPORARY TABLE leavitt_1866.temp_z(
SELECT dept_name, AVG(salaries.salary) as avg_sal
FROM departments
JOIN dept_emp USING (dept_no)
JOIN salaries USING (emp_no)
WHERE dept_emp.to_date > CURDATE()
AND salaries.to_date > CURDATE()
GROUP BY dept_name);

USE leavitt_1866;
DROP TABLE temp_z;
SELECT * FROM temp_z;
ALTER TABLE temp_z ADD zscore FLOAT;
ALTER TABLE temp_z ADD aasal FLOAT;
UPDATE temp_z SET aasal = (SELECT aasal FROM temp_z2);


UPDATE temp_z SET zscore = (
				(avg_sal - (aasal))
				/
				(stddev(avg_sal)));
                
CREATE TEMPORARY TABLE solutionplease (
SELECT * 
FROM temp_z
JOIN sd USING (dept_name));
SELECT * FROM solutionplease;

USE employees;
CREATE TEMPORARY TABLE leavitt_1866.sd (
	SELECT dept_name, stddev(salary) as std 
    FROM departments
    JOIN dept_emp USING (dept_no)
    JOIN salaries USING (emp_no)
    GROUP BY dept_name);
    
   USE leavitt_1866; 
SELECT * FROM sd;
-- will be easier to pull whole table needed into local temp table prior to crunching numbers and table



-- Hint Consider that the following code will produce the z score for current salaries.


-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved

-- SELECT salary,
--     (salary - (SELECT AVG(salary) FROM salaries))
--     /
--     (SELECT stddev(salary) FROM salaries) AS zscore
-- FROM salaries;

        
-- BONUS To your work with current salary zscores, determine the overall historic average departement average salary,
-- the historic overall average, and the historic zscores for salary. Do the zscores for current department average 
-- salaries tell a similar or a different story than the historic department salary zscores?

