-- 3. Use the employees database
USE employees;
-- 4. List all the tables in the database
SHOW TABLES;
-- 5. What types data types are present in the employees table?
	# Int, date, and string (varchar, enum)
DESCRIBE employees;
-- 6. Which table(s) do you think contain a numeric type column?
	-- all of them (dep numbers, employee numbers, etc.)
-- 7. Which table(s) do you think contain a string type column?
	-- Departments, employees, and titles in order to display the actual names tied to the respective id numbers
-- 8. Which table(s) do you think contain a date type column
	-- titles, salaries, dept_emp, and dept_manager (from and to dates), employees (birthdate and hire date)
-- 9. What is the relationship between the employees and the departments tables?
	-- None of the rows are the same in order to merge them on. However, both tables have primary keys set by employee number and department numbers.
DESCRIBE departments;
-- 10. Show the SQL that created the dept_manager table.
SHOW CREATE TABLE dept_manager;