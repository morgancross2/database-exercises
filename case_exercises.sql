USE employees;

-- 1. Write a query that returns all employees, their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SELECT CONCAT(first_name, ' ', last_name) fullname, dept_no, from_date, to_date, 
	IF(to_date > CURDATE(), true, false) AS is_current_employee
	FROM employees
    JOIN dept_emp USING (emp_no)
    JOIN departments USING (dept_no);

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that 
-- returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name, last_name, 
	CASE
		WHEN last_name LIKE 'A%' OR last_name LIKE 'B%' OR last_name LIKE 'C%' OR last_name LIKE 'D%' OR last_name LIKE 'E%' OR last_name LIKE 'F%' OR last_name LIKE 'G%' OR last_name LIKE 'H%' THEN 'A-H'
        WHEN last_name LIKE 'I%' OR last_name LIKE  'J%' OR last_name LIKE 'K%' OR last_name LIKE 'L%' OR last_name LIKE 'M%' OR last_name LIKE 'N%' OR last_name LIKE 'O%' OR last_name LIKE 'P%' OR last_name LIKE 'Q%' THEN 'I-Q'
        ELSE 'R-Z'
    END AS alpha_group
    FROM employees;

-- 3. How many employees (current or previous) were born in each decade?
SELECT
	CASE
		WHEN birth_date LIKE '195%' THEN '50s'
        ELSE '60s'
	END AS decade, count(*)
    FROM employees
    GROUP BY decade;

-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, 
-- Prod & QM, Finance & HR, Customer Service?
SELECT 
	CASE
		WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        ELSE 'Customer Service'
	END AS dept_group ,avg(salary)
    FROM employees
    JOIN salaries USING (emp_no)
    JOIN dept_emp USING (emp_no)
    JOIN departments USING (dept_no)
    WHERE dept_emp.to_date > CURDATE()
    AND salaries.to_date > CURDATE()
    GROUP BY dept_group;
