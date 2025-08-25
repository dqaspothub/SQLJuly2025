############ INDEX#############################

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2)
);

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO Departments VALUES (1, 'HR'), (2, 'IT'), (3, 'Sales');

INSERT INTO Employees VALUES
(101, 'Alice', 1, 50000),
(102, 'Bob', 1, 60000),
(103, 'Charlie', 2, 70000),
(104, 'David', 2, 80000),
(105, 'Eve', 3, 40000),
(106, 'Frank', 3, 45000);

SELECT emp_name, salary
FROM Employees
WHERE salary > (
    SELECT AVG(salary) 
    FROM Employees
);


SELECT e.emp_name, e.salary, e.dept_id
FROM Employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM Employees e2
    WHERE e2.dept_id = e.dept_id
);


CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department VARCHAR(50)
);


SELECT * FROM Students WHERE student_id = 105;

# Non-Clustered Index

CREATE INDEX idx_student_name ON Students(name);

# Composite Index

CREATE INDEX idx_dept_age ON Students(department, age);


SELECT * FROM Students
WHERE department = 'Computer Science' AND age = 20;

-- Drop an index
DROP INDEX idx_student_name ON Students;  -- MySQL

############ SUb PARTITION ######################

CREATE TABLE Sales (
    sale_id INT NOT NULL,
    sale_date DATE NOT NULL,
    region VARCHAR(20) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
)
PARTITION BY RANGE (YEAR(sale_date))   -- Main Partitioning (By Year)
SUBPARTITION BY HASH (MONTH(sale_date))  -- Subpartition (By Month)
SUBPARTITIONS 4
(
    PARTITION p0 VALUES LESS THAN (2021),
    PARTITION p1 VALUES LESS THAN (2022),
    PARTITION p2 VALUES LESS THAN (2023),
    PARTITION p3 VALUES LESS THAN MAXVALUE
);


############ Trigger #########################


-- Employee table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Log table for salary updates
CREATE TABLE SalaryLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    EmpID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER after_salary_update
AFTER UPDATE ON Employees
FOR EACH ROW
BEGIN
    -- log salary changes
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO SalaryLog (EmpID, OldSalary, NewSalary)
        VALUES (OLD.EmpID, OLD.Salary, NEW.Salary);
    END IF;
END //

DELIMITER ;

INSERT INTO Employees VALUES (1, 'Alice', 50000);
INSERT INTO Employees VALUES (2, 'Bob', 60000);

SELECT * FROM SalaryLog;

SELECT * FROM Employees;

Update Employees set Salary=55000 where EmpID=1;


DELIMITER //
CREATE TRIGGER prevent_manager_delete
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
    IF OLD.EmpName = 'Alice' THEN
        SIGNAL SQLSTATE '45000' -- unhandled user-defined exception
        SET MESSAGE_TEXT = 'Cannot delete manager Alice!';
    END IF;
END //

DELIMITER ;

SET SQL_SAFE_UPDATES = 1;

DELETE FROM Employees WHERE EmpName = 'Alice';
