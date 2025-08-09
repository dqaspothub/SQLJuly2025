CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2023-01-10'),
(102, 2, '2023-01-12'),
(103, 4, '2023-01-15');  -- Note: CustomerID 4 does not exist in Customers

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(103, 1, '2023-01-11'),
(104, 2, '2023-01-14');


SELECT * FROM Customers;

SELECT * FROM Orders;

SELECT Customers.CustomerName, Orders.OrderDate
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName, Orders.OrderDate
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName, Orders.OrderDate
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT A.CustomerName AS Customer1, B.CustomerName AS Customer2
FROM Customers A, Customers B
WHERE A.CustomerID != B.CustomerID;

CREATE TABLE Sales2023 (
    CustomerName VARCHAR(50)
);

CREATE TABLE Sales2024 (
    CustomerName VARCHAR(50)
);

INSERT INTO Sales2023 VALUES ('Alice'), ('Bob'), ('Charlie');
INSERT INTO Sales2024 VALUES ('Bob'), ('David'), ('Alice');

SELECT s1.CustomerName
FROM Sales2023 s1
INNER JOIN Sales2024 s2 ON s1.CustomerName = s2.CustomerName;

SELECT CustomerName FROM Sales2023
UNION
SELECT CustomerName FROM Sales2024;

SELECT CustomerName FROM Sales2023
UNION ALL
SELECT CustomerName FROM Sales2024;

CREATE TABLE Departments_001 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employees_002 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (dept_id) REFERENCES Departments_001(dept_id)
);

INSERT INTO Departments_001 (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');

INSERT INTO Employees_002 (emp_id, emp_name, dept_id, salary) VALUES
(101, 'Alice', 1, 50000),
(102, 'Bob', 2, 60000),
(103, 'Charlie', 3, 55000),
(104, 'David', NULL, 40000),  -- No department assigned
(105, 'Eva', 3, 70000);

#Get employees with their department names (only if they have a matching department).

SELECT e.emp_name, d.dept_name, e.salary
FROM Employees_002 e
INNER JOIN Departments_001 d
ON e.dept_id = d.dept_id;

#Get all employees, even if they don’t have a department.

SELECT e.emp_name, d.dept_name, e.salary
FROM Employees_002 e
LEFT JOIN Departments_001 d
ON e.dept_id = d.dept_id;

#Get all departments, even if they have no employees.

SELECT e.emp_name, d.dept_name
FROM Employees_002 e
RIGHT JOIN Departments_001 d
ON e.dept_id = d.dept_id;

#This gives all records from both sides.

SELECT e.emp_name, d.dept_name
FROM Employees_002 e
LEFT JOIN Departments_001 d
ON e.dept_id = d.dept_id

UNION

SELECT e.emp_name, d.dept_name
FROM Employees e
RIGHT JOIN Departments d
ON e.dept_id = d.dept_id;

#Get all combinations of employees and departments.


SELECT e.emp_name, d.dept_name
FROM Employees e
CROSS JOIN Departments d;

#ROLL UP Concept

CREATE TABLE Sales_001 (
    Region VARCHAR(50),
    Product VARCHAR(50),
    Amount DECIMAL(10,2)
);

INSERT INTO Sales_001 (Region, Product, Amount) VALUES
('North', 'Laptop', 1000),
('North', 'Phone', 500),
('South', 'Laptop', 1200),
('South', 'Phone', 700),
('East', 'Laptop', 900),
('East', 'Phone', 400);

SELECT* FROM Sales_001;

SELECT Region, Product, SUM(Amount) AS TotalSales
FROM Sales_001
GROUP BY ROLLUP (Region, Product);

##### View Concepts ######

CREATE TABLE StudentDetails (
    S_ID INT PRIMARY KEY,
    NAME VARCHAR(255),
    ADDRESS VARCHAR(255)
);

CREATE TABLE StudentMarks (
    ID INT PRIMARY KEY,
    NAME VARCHAR(255),
    MARKS INT,
    AGE INT
);

INSERT INTO StudentDetails (S_ID, NAME, ADDRESS) VALUES
(1, 'Harsh', 'Kolkata'),
(2, 'Ashish', 'Durgapur'),
(3, 'Pratik', 'Delhi'),
(4, 'Dhanraj', 'Bihar'),
(5, 'Ram', 'Rajasthan');

INSERT INTO StudentMarks (ID, NAME, MARKS, AGE) VALUES
(1, 'Harsh', 90, 19),
(2, 'Suresh', 50, 20),
(3, 'Pratik', 80, 19),
(4, 'Dhanraj', 95, 21),
(5, 'Ram', 85, 18);

CREATE VIEW DetailsView AS
SELECT NAME, ADDRESS
FROM StudentDetails
WHERE S_ID < 5;

SELECT * FROM DetailsView;

CREATE VIEW MarksView AS
SELECT 
    StudentDetails.NAME,
    StudentDetails.ADDRESS,
    StudentMarks.MARKS
FROM StudentDetails
JOIN StudentMarks ON StudentDetails.NAME = StudentMarks.NAME;


SELECT * FROM DetailsView;
SELECT * FROM MarksView;


CREATE OR REPLACE VIEW DetailsView AS
SELECT NAME, ADDRESS FROM StudentDetails WHERE S_ID <= 5;

DROP VIEW DetailsView;


CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10, 2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

INSERT INTO Employee (emp_id, emp_name, salary, dept_id) VALUES
(101, 'Alice', 50000, 1),
(102, 'Bob', 60000, 2),
(103, 'Charlie', 70000, 2),
(104, 'David', 55000, 3),
(105, 'Eva', 65000, 1);

#We’ll create a view to show employee details along with their department name.

CREATE VIEW EmployeeDetails AS
SELECT 
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id;

SELECT * FROM EmployeeDetails;




