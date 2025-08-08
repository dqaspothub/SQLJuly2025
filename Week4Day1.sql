-- Create Departments table
CREATE TABLE Departments_1 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

-- Insert values into Departments
INSERT INTO Departments_1 (dept_id, dept_name, location) VALUES
(101, 'IT', 'New York'),
(102, 'HR', 'Chicago'),
(103, 'Finance', 'Dallas');

-- Create Employees table
CREATE TABLE Employees_1 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments_1(dept_id)
);

-- Insert values into Employees
INSERT INTO Employees_1 (emp_id, emp_name, salary, dept_id) VALUES
(1, 'Alice', 60000, 101),
(2, 'Bob', 45000, 102),
(3, 'Charlie', 70000, 101),
(4, 'David', 40000, 103),
(5, 'Emma', 55000, 102);


SELECT * FROM Departments_1;
SELECT * FROM Employees_1;

-- Problem:

-- Find all employees who work in the IT department.

-- Step 1 — Inner Query (Subquery):

-- We first find the dept_id for IT.

SELECT dept_id 
FROM Departments_1 
WHERE dept_name = 'IT';

SELECT emp_name, salary
FROM Employees_1
WHERE dept_id = (
    SELECT dept_id 
    FROM Departments_1
    WHERE dept_name = 'IT'
);

--CASE

CREATE TABLE Employees_2 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT
);

INSERT INTO Employees_2 (emp_id, emp_name, salary, dept_id) VALUES
(1, 'Alice', 60000, 101),
(2, 'Bob', 45000, 102),
(3, 'Charlie', 70000, 101),
(4, 'David', 40000, 103),
(5, 'Emma', 55000, 102);

-- We can categorize employees into Low, Medium, or High salary ranges.

SELECT 
    emp_name,
    salary,
    CASE
        WHEN salary >= 65000 THEN 'High Salary'
        WHEN salary BETWEEN 50000 AND 64999 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM Employees_2;

-- Mapping Department Names

SELECT 
    emp_name,
    dept_id,
    CASE dept_id
        WHEN 101 THEN 'IT'
        WHEN 102 THEN 'HR'
        WHEN 103 THEN 'Finance'
        ELSE 'Unknown'
    END AS department_name
FROM Employees_1;
