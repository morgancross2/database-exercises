USE employees;
-- 1. Find all the current employees with the same hire date as employee 101010 using a 
-- sub-query.

	-- INNER - find hire date of employee 101010
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010;

	-- OUTER - find all current employees matching subquery
	SELECT CONCAT(first_name, ' ', last_name)
    FROM employees
    WHERE hire_date = '1990-10-22';

	-- COMBINED
    SELECT CONCAT(first_name, ' ', last_name)
    FROM employees
    WHERE hire_date = (SELECT hire_date
						FROM employees
						WHERE emp_no = 101010);

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
	-- INNER - Find all current employees named Aamod
		SELECT emp_no
        FROM employees
        JOIN dept_emp USING(emp_no)
        WHERE first_name = 'Aamod'
        AND to_date > CURDATE();
    
    -- OUTER - Find all the titles held by an employee
		SELECT title
        FROM titles
        WHERE emp_no IN (12432,23141)
		GROUP BY title;
    
    -- COMBINED
    SELECT title
        FROM titles
        WHERE emp_no IN (SELECT emp_no
				FROM employees
				JOIN dept_emp USING(emp_no)
				WHERE first_name = 'Aamod'
				AND to_date > CURDATE())
		GROUP BY title;


-- 3. How many people in the employees table are no longer working for the company? Give 
-- the answer in a comment in your code.
	-- INNER - 
    SELECT emp_no
    FROM titles
    WHERE to_date > CURDATE()
    GROUP BY emp_no;
    
    -- OUTER
     SELECT count(*)
    FROM employees
    WHERE emp_no NOT IN (14323,43243);
    
    -- COMBINED
    SELECT count(*)
    FROM employees
    WHERE emp_no NOT IN (SELECT emp_no
						FROM titles
						WHERE to_date > CURDATE()
						GROUP BY emp_no);

-- 4. Find all the current department managers that are female. List their names in a 
-- comment in your code.
	-- INNER
    SELECT emp_no 
    FROM employees
    WHERE gender = 'F';
    
    -- OUTER
    SELECT emp_no, dept_no
    FROM dept_manager
    WHERE emp_no = (134123)
    AND to_date > CURDATE();
    
    -- COMBINED
	SELECT emp_no, dept_no, CONCAT(first_name, ' ', last_name)
    FROM dept_manager
    JOIN employees USING (emp_no)
    WHERE emp_no IN (SELECT emp_no
					FROM employees
					WHERE gender = 'F')
					AND to_date > CURDATE();

-- 5. Find all the employees who currently have a higher salary than the companies overall, 
-- historical average salary.
	-- INNER
    SELECT AVG(salary)
    FROM salaries;
    
    -- OUTER
    SELECT CONCAT(first_name, ' ', last_name), salary
    FROM employees
    JOIN salaries USING (emp_no)
    WHERE salary > (56322)
    AND to_date > CURDATE();
    
    -- COMBINED
	SELECT CONCAT(first_name, ' ', last_name), salary
    FROM employees
    JOIN salaries USING (emp_no)
    WHERE salary > (SELECT AVG(salary)
					FROM salaries)
    AND to_date > CURDATE();

-- 6. How many current salaries are within 1 standard deviation of the current highest 
-- salary? What percentage of all salaries is this?
	-- INNER - current highest salary
    SELECT MAX(salary)
    FROM salaries
    WHERE to_date > CURDATE();
    
    -- INNER - 1 STDDEV
    SELECT STDDEV(salary)
    FROM salaries
    WHERE to_date > CURDATE();
    
    -- COMBINED
    SELECT count(*)
    FROM salaries
    WHERE to_date > CURDATE()
    AND salary > ((SELECT MAX(salary)
					FROM salaries
					WHERE to_date > CURDATE())
                    -
                    (SELECT STDDEV(salary)
					FROM salaries
					WHERE to_date > CURDATE()));
    
    -- .03%
    SELECT 83/count(salary)
    FROM salaries
    WHERE to_date > CURDATE();
    


-- BONUS

-- 1. Find all the department names that currently have female managers.
SELECT dept_name
FROM departments
JOIN dept_manager USING (dept_no)
WHERE emp_no IN (SELECT emp_no
					FROM employees
					WHERE gender = 'F')
					AND to_date > CURDATE();
                    
-- 2. Find the first and last name of the employee with the highest salary.
SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE emp_no = (SELECT emp_no
				FROM salaries
				WHERE salary = (SELECT MAX(salary) 
								FROM salaries
								WHERE to_date > CURDATE()));

-- 3. Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
WHERE dept_no = (SELECT dept_no
				FROM dept_emp
				WHERE emp_no = (SELECT emp_no
								FROM salaries
								WHERE salary = (SELECT MAX(salary) 
												FROM salaries
												WHERE to_date > CURDATE())));