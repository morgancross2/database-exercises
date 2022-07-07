-- JOIN EXAMPLE DATABASE
-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT * FROM users;
-- Has 6 rows, 2 w/o role_id
SELECT * FROM roles;
-- Has 4 rows

-- 2. Use join, left join, and right join to combine results from the users and roles 
-- tables as we did in the lesson. Before you run each query, guess the expected number of 
-- results.
SELECT *
FROM users
JOIN roles
	ON users.role_id = roles.id;
-- Prediction: 4 rows
-- Actual: 4 rows

SELECT *
FROM users
LEFT JOIN roles
	ON users.role_id = roles.id;
-- Prediction: 6 rows
-- Actual: 6 rows

SELECT *
FROM users
RIGHT JOIN roles
	ON users.role_id = roles.id;
-- Prediction: 4 rows
-- Actual: 5 rows - Two people with role_id 3, both listed because both match right table

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be 
-- used with join queries. Use count and the appropriate join type to get a list of roles 
-- along with the number of users that has the role. Hint: You will also need to use group 
-- by in the query.
SELECT roles.name, count(*)
FROM roles
LEFT JOIN users
	ON roles.id = users.role_id
GROUP BY roles.name;

-- EMPLOYEES DATABASE
-- 1. Use the employees database
USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query
-- that shows each department along with the name of the current manager for that department
SELECT 
	departments.dept_name AS Department_Name, 
    CONCAT(employees.first_name, ' ', employees.last_name) AS Department_Manager
FROM departments
JOIN dept_manager
	USING(dept_no)
JOIN employees 
	USING(emp_no)
WHERE dept_manager.to_date > CURDATE()
ORDER BY departments.dept_name;

-- 3. Find the name of all departments currently managed by women.
SELECT
	departments.dept_name AS Department_Name,
    CONCAT(employees.first_name, ' ', employees.last_name) AS Manager_Name
FROM departments
JOIN dept_manager
	USING (dept_no)
JOIN employees 
	USING (emp_no)
WHERE dept_manager.to_date > CURDATE()
AND employees.gender = 'F'
ORDER BY departments.dept_name;

-- 4. Find the current titles of employees currently working in the Customer Service
-- department.
SELECT titles.title, count(*)
FROM departments
JOIN dept_emp
	USING(dept_no)
JOIN titles
	USING(emp_no)
WHERE departments.dept_name = 'Customer Service'
AND titles.to_date > CURDATE()
AND dept_emp.to_date > CURDATE()
GROUP BY titles.title
ORDER BY titles.title;

-- 5. Find the current salary of all current managers.
SELECT 
	departments.dept_name AS Department_Name, 
    CONCAT(employees.first_name, ' ', employees.last_name) AS Name,
    salaries.salary AS Salary
FROM departments
JOIN dept_manager
	USING(dept_no)
JOIN employees
	USING(emp_no)
JOIN salaries
	USING(emp_no)
WHERE dept_manager.to_date > CURDATE()
AND salaries.to_date > CURDATE()
ORDER BY Department_Name;

-- 6. Find the number of current employees in each department
SELECT departments.dept_no, departments.dept_name, count(dept_emp.emp_no)
FROM departments
JOIN dept_emp
	USING(dept_no)
WHERE dept_emp.to_date > CURDATE()
GROUP BY departments.dept_no
ORDER BY departments.dept_no;

-- 7. Which department has the highest average salary? Use only current information.
SELECT departments.dept_name, AVG(salaries.salary) AS average_salary
FROM departments
	JOIN dept_emp
		USING(dept_no)
	JOIN salaries
		USING(emp_no)
WHERE salaries.to_date > CURDATE()
AND dept_emp.to_date > CURDATE()
GROUP BY departments.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name
FROM departments
JOIN dept_emp
	USING(dept_no)
JOIN salaries
	USING(emp_no)
JOIN employees
	USING(emp_no)
WHERE dept_emp.to_date > CURDATE()
AND salaries.to_date > CURDATE()
AND dept_name = 'Marketing'
ORDER BY salary DESC
LIMIT 1;

-- 9. Which current department manager has the higest salary?
SELECT 
	first_name, last_name, salary, dept_name
FROM departments
	JOIN dept_manager
		USING(dept_no)
	JOIN employees
		USING(emp_no)
	JOIN salaries
		USING(emp_no)
WHERE dept_manager.to_date > CURDATE()
AND salaries.to_date > CURDATE()
ORDER BY salary DESC
LIMIT 1;

-- 10. Determine the average salary for each department. Use all salary info and round
-- your results.
SELECT dept_name, ROUND(AVG(salary)) AS average_salary
FROM departments
	JOIN dept_emp
		USING(dept_no)
	JOIN salaries
		USING(emp_no)
GROUP BY dept_name
ORDER BY average_salary DESC;

-- 11. Find the names of all current employees, their department name, and their current 
-- manager's name.

-- without subquery
SELECT concat(manager.first_name, ' ', manager.last_name) as "Manager Name",
dept_name,
concat(employees.first_name, ' ', employees.last_name) as "Employee Name"
FROM employees as manager
JOIN dept_manager USING(emp_no)
JOIN departments USING(dept_no)
JOIN dept_emp USING (dept_no)
JOIN employees on dept_emp.emp_no = employees.emp_no
WHERE dept_manager.to_date >CURDATE()
AND dept_emp.to_date > CURDATE()
ORDER BY dept_name;

-- with subquery
SELECT CONCAT(first_name, ' ', last_name) AS Employee_Name,
	dept_name AS Department_Name,
    g.name AS Manager_Name
FROM employees
JOIN dept_emp
	USING(emp_no)
JOIN departments
	USING (dept_no)
JOIN (
	SELECT 
		CONCAT(first_name, ' ', last_name) AS name,
		dept_manager.dept_no, 
		dept_manager.to_date
    FROM dept_manager
	JOIN employees 
		USING (emp_no)
	) as g
-- dept_manager
USING (dept_no)
WHERE dept_emp.to_date > CURDATE()
AND g.to_date > CURDATE()
ORDER BY dept_name
LIMIT 10;

-- 12. Who is the highest paid employee within each department?
-- Returns 11 results due to duplicate max salaries within a department. 

-- with subquery
SELECT
	CONCAT(employees.first_name, ' ', employees.last_name) AS Employee_Name,
    g.deptname AS Department_Name,
    g.salary AS Salary
FROM (
	SELECT 
		departments.dept_name AS deptname,
		MAX(salaries.salary) AS salary
	FROM departments
		JOIN dept_emp USING(dept_no)
		JOIN salaries USING(emp_no)
	WHERE dept_emp.to_date > CURDATE()
	AND salaries.to_date > CURDATE()
	GROUP BY departments.dept_name
    ) as g
JOIN salaries ON g.salary = salaries.salary
JOIN employees USING(emp_no)
ORDER BY Department_Name;

-- Below was first attempt from reverse order. 
/*SELECT
	CONCAT(employees.first_name, ' ', employees.last_name) AS Employee_Name,
	departments.dept_name AS Department_Name,
    MAX(salaries.salary) AS salary
FROM employees
LEFT JOIN salaries USING(emp_no)
LEFT JOIN dept_emp USING(emp_no)
LEFT JOIN departments USING(dept_no)
WHERE salaries.to_date > CURDATE()
AND dept_emp.to_date > CURDATE()
GROUP BY Employee_Name, Department_Name
LIMIT 10;*/