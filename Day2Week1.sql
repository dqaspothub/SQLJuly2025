USE SQLJuly2025;

CREATE TABLE employees (
    id INT ,
    name VARCHAR(100) ,
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    joining_date DATE,
    email VARCHAR(100)
);

-- DECIMAL(precision, scale)
-- Total number of digits (both left and right of the decimal)
-- Number of digits after the decimal point

-- Invalid 

-- 1234567890.12 → too many digits (11 digits total)

 -- 123456789.123 → 3 digits after decimal (scale is only 2)

-- Valid 

-- 12345678.90 , 0.99 , 99999999.99

-- This will list columns, data types, nullability, keys, etc.

DESCRIBE employees;

-- Insert a Single Row (With Column Names)

INSERT INTO employees (id, name, department, salary, joining_date, email)
VALUES (1, 'Alice', 'HR', 55000.00, '2023-01-15', 'alice@example.com');

-- Insert a Single Row (Without Column Names)

INSERT INTO employees
VALUES (2, 'Bob', 'Tech', 65000.50, '2023-03-10', 'bob@example.com');

-- Insert Multiple Rows at Once

INSERT INTO employees (id, name, department, salary, joining_date, email)
VALUES 
(3, 'Charlie', 'Finance', 48000.75, '2023-05-20', 'charlie@example.com'),
(4, 'David', 'Sales', 60000.00, '2023-06-01', 'david@example.com'),
(5, 'Emma', 'Tech', 72000.00, '2023-07-01', 'emma@example.com');

-- Multiple row at once without column names

INSERT INTO employees
VALUES 
(6, 'Kanna', 'Finance', 48000.75, '2023-05-20', 'charlie@example.com'),
(7, 'Anu', 'Sales', 60000.00, '2023-06-01', 'david@example.com'),
(8, 'Diyu', 'Tech', 72000.00, '2023-07-01', 'emma@example.com');

-- Insert into Only Selected Columns (Let Others Be NULL )

INSERT INTO employees (id, name, salary, joining_date, email)
VALUES (9, 'Frank', 52000.00, '2023-08-01', 'frank@example.com');

-- Insert with NULL Values Explicitly

INSERT INTO employees (id, name, department, salary, joining_date, email)
VALUES (11, 'Henry', NULL, NULL, NULL, 'henry@example.com');

-- To view all records

SELECT * FROM EMPLOYEES;


-- Insert Using SET (MySQL Only)

INSERT INTO employees
SET id = 9, name = 'Ivy', department = 'HR', salary = 45000.00,
joining_date = '2023-09-10', email = 'ivy@example.com';

-- Insert Data from Another Table (Using SELECT) -  Very useful for data migration or copying rows.

INSERT INTO employees (id, name, department, salary, joining_date, email)
SELECT id, name, department, salary, joining_date, email
FROM new_employees
WHERE department = 'Tech';

-- Insert with Variables (Dynamic) — Example in MySQL

SET @empId = 10;
SET @empName = 'John';
SET @empEmail = 'john@example.com';

INSERT INTO employees (id, name, email)
VALUES (@empId, @empName, @empEmail);

--  Add a New Column

ALTER TABLE employees
ADD phone_number VARCHAR(15);

-- Modify Column Data Type

ALTER TABLE employees
MODIFY salary DECIMAL(12, 2);

ALTER TABLE employees
modify department VARCHAR(100);

-- Rename a Column (DBMS-specific)

ALTER TABLE employees
CHANGE name full_name VARCHAR(100);

describe employees;

-- PostgreSQL

ALTER TABLE employees
RENAME COLUMN name TO full_name;

-- Drop a Column

ALTER TABLE employees
DROP COLUMN phone_number;

-- Rename a Table

ALTER TABLE employees
RENAME TO employee_records;

-- Add a Constraint

ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

-- Drop a Constraint (Example for MySQL)

ALTER TABLE employees
DROP INDEX unique_email;


--  Select All Columns

SELECT * FROM employees;

-- Select Specific Columns

SELECT id, name, department FROM employees;

-- Add Conditions (WHERE Clause)

SELECT * FROM employees
WHERE department = 'Tech';

-- Sort Data (ORDER BY)

SELECT * FROM employees
ORDER BY salary DESC;

--- Limit Rows (Pagination)

SELECT * FROM employees
LIMIT 5;

-- Filter with Multiple Conditions

SELECT * FROM employees
WHERE department = 'Tech' AND salary > 60000;

-- Find Unique Values

SELECT DISTINCT department FROM employees;





Select * from employee_records where salary > 55000;

