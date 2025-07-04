
USE SQLJuly2025;

-- Create employees table

CREATE TABLE employees (
    employee_id INT ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2)
);

-- Create departments table
CREATE TABLE departments (
    department_id INT ,
    department_name VARCHAR(50)
);

-- Insert into employees
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary) VALUES
(1, 'Alice', 'Smith', 101, 75000.00),
(2, 'Bob', 'Johnson', 102, 65000.00),
(3, 'Charlie', 'Brown', 101, 80000.00),
(4, 'David', 'Lee', 103, 90000.00);

-- Insert into departments
INSERT INTO departments (department_id, department_name) VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance');


SELECT * FROM employees; -- Select All Columns

SELECT * FROM departments;

SELECT employee_id,first_name, last_name, salary 
FROM employees;   -- Select Specific Columns

SELECT first_name AS fname, last_name AS lname
FROM employees;    -- Rename Columns Using Aliases

SELECT first_name, last_name
FROM employees
WHERE department_id = 102;  -- Filtering Rows with WHERE Clause

select employee_id,first_name AS firstNAME ,last_name from employees where last_name = 'Lee';

SELECT first_name, salary
FROM employees
WHERE salary >= 75000;  -- Use Comparison Operators


SELECT first_name, department_id, salary
FROM employees
WHERE department_id = 101 OR salary > 75000; -- Multiple Conditions with AND / OR

SELECT first_name, department_id
FROM employees
WHERE department_id IN (101, 103);  -- IN Operator

SELECT department_id from departments where department_name IN ('HR','IT');

SELECT * FROM employees WHERE last_name IN ('SMITH','JOHNSON');

SELECT first_name, last_name salary
FROM employees
ORDER BY last_name ASC;  -- Sorting Results with ORDER BY

SELECT * FROM employees order by employee_id DESC;

-- Sorts results by salary in descending order (DESC). Default is ascending (ASC)

SELECT first_name, department_id, salary
FROM employees
ORDER BY department_id ASC, salary DESC; -- Sort by Multiple Columns

-- First sorts by department_id in ascending order, then within each department, it sorts salaries in descending order.

SELECT COUNT(*) AS total_employees,
       SUM(salary) AS total_salary,
       AVG(salary) AS average_salary
FROM employees; 

SELECT DISTINCT department_id
FROM employees; -- Removes duplicates from the result — useful when you want unique values.

-------------------------------------------------

SELECT first_name
FROM employees
WHERE first_name LIKE 'A%';  -- Starts With


SELECT last_name
FROM employees
WHERE last_name LIKE '%son';  -- Ends With

SELECT first_name
FROM employees
WHERE first_name LIKE '%li%';  -- Contains Pattern

SELECT * FROM employees
WHERE name LIKE '_____'; -- 5 underscores -- Names with exactly 5 characters

SELECT first_name
FROM employees
WHERE first_name LIKE '_o%'; -- Single Character Match

-- Matches names where the second letter is 'o', like Bob.

CREATE TABLE employees_New (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(50),
    joining_date DATE
);


INSERT INTO employees_New (emp_id, name, department, salary, city, joining_date) VALUES
(101, 'Alice', 'HR', 55000, 'Mumbai', '2020-03-01'),
(102, 'Bob', 'IT', 70000, 'Chennai', '2019-07-15'),
(103, 'Charlie', 'IT', 75000, 'Mumbai', '2021-01-20'),
(104, 'Diana', 'Marketing', 50000, 'Delhi', '2022-08-10'),
(105, 'Eve', 'HR', 60000, 'Kolkata', '2020-11-25');


--  When to Use IN?
--  When you want to match against multiple possible values.Makes your query more readable and efficient than multiple OR.


SELECT name, city
FROM employees_New
WHERE city IN ('Mumbai', 'Delhi');

-- it is equilent to 

--- WHERE city = 'Mumbai' OR city = 'Delhi'


-- The BETWEEN operator is used to filter results within a range, including both start and end values.

SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 50000 AND 70000;


SELECT name, joining_date
FROM employees
WHERE joining_date BETWEEN '2020-01-01' AND '2021-12-31';

SELECT name
FROM employees
WHERE name BETWEEN 'A' AND 'M';


-------------------------------------------------

-- Update a Single Row
UPDATE Employees
SET Salary = 52000
WHERE EmpID = 101;

-- Update Multiple Columns

UPDATE Employees
SET Department = 'HR', City = 'Pune'
WHERE EmpID = 104;

-- Update Multiple Rows with a Condition

UPDATE Employees
SET Salary = Salary + 5000
WHERE Department = 'IT';

-- Update All Rows (Use with Caution)

UPDATE Employees
SET City = 'Bangalore';
