Use sqljuly2025;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    joining_date DATE NOT NULL
);

INSERT INTO employees (emp_name, department, salary, joining_date) VALUES
('John Smith', 'IT', 60000, '2021-03-15'),
('Sarah Johnson', 'Finance', 55000, '2020-06-20'),
('Michael Brown', 'HR', 48000, '2022-01-10'),
('Emily Davis', 'IT', 72000, '2019-11-05'),
('David Wilson', 'Finance', 50000, '2021-08-12'),
('Emma Thompson', 'HR', 45000, '2023-02-18'),
('Daniel Martinez', 'IT', 80000, '2020-09-30'),
('Olivia Garcia', 'Finance', 65000, '2022-05-14'),
('James Lee', 'IT', 47000, '2023-07-21'),
('Sophia Taylor', 'HR', 52000, '2021-12-01');

-- Step 1: Change delimiter so MySQL doesn't stop at ;
DELIMITER $$

-- Step 2: Create the procedure
CREATE PROCEDURE GetEmployeeCountByDept(
    IN deptName VARCHAR(50),    -- Input parameter
    OUT totalEmp INT            -- Output parameter
)
BEGIN
    -- Declare a variable (optional)
    DECLARE tempCount INT;

    -- Get the count of employees into variable
    SELECT COUNT(*) INTO tempCount
    FROM employees
    WHERE department = deptName;

    -- Assign the variable to output parameter
    SET totalEmp = tempCount;
END $$

-- Step 3: Reset the delimiter
DELIMITER ;

-- Step 4: Call the procedure
CALL GetEmployeeCountByDept('IT', @count);

-- Step 5: View the output
SELECT @count AS Employee_Count;

#################################################


# Example 1 — Simple Procedure (No Parameters)
# Retrieve all employees from a table.

DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employees;
END //
DELIMITER ;

-- Call the procedure
CALL GetAllEmployees();

DROP PROCEDURE GetAllEmployees;

# Example 2 — Procedure with Input Parameter
# Fetch employees from a specific department.

DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN deptName VARCHAR(50))
BEGIN
    SELECT * 
    FROM employees
    WHERE department = deptName ;
END //
DELIMITER ;

-- Call
CALL GetEmployeesByDept('Finance');

# Example 3 — Procedure with Multiple Parameters
# Find employees with a salary greater than a value in a department.

DELIMITER //
CREATE PROCEDURE GetHighPaidEmployees(
    IN deptName VARCHAR(50),
    IN minSalary DECIMAL(10,2)
)
BEGIN
    SELECT * 
    FROM employees
    WHERE department = deptName
      AND salary > minSalary;
END //
DELIMITER ;

-- Call
CALL GetHighPaidEmployees('Finance', 50000);

# Example 4 — Procedure with Output Parameter
# Return the total number of employees in a department. 

DELIMITER //
CREATE PROCEDURE CountEmployeesByDept(
    IN deptName VARCHAR(50),
    OUT totalCount INT
)
BEGIN
    SELECT COUNT(emp_id) INTO totalCount
    FROM employees
    WHERE department = deptName;
END //
DELIMITER ;


-- Call with output
SET @count = 0;
CALL CountEmployeesByDept('IT', @count);
SELECT @count AS Total_Employees;

# Example 5 — Procedure with IF Condition
# Label salary as 'Low', 'Medium', or 'High'.

select salary from employees WHERE emp_id =1;

DELIMITER //
CREATE PROCEDURE CategorizeSalary(IN empId INT)
BEGIN
    DECLARE sal DECIMAL(10,2);
    SELECT salary INTO sal FROM employees WHERE emp_id = empId;

    IF sal < 50000 THEN
		SELECT 'Low' AS Category;
    ELSEIF sal BETWEEN 50000 AND 70000 THEN
		SELECT 'Medium' AS Category;
    ELSE
		SELECT 'High' AS Category;
    END IF;
END //
DELIMITER ;

-- Call
CALL CategorizeSalary(4);

# Example 6 — Procedure with LOOP
# Print numbers 1 to 5.

DELIMITER //
CREATE PROCEDURE PrintNumbers()
BEGIN
    DECLARE num INT DEFAULT 1;
    Vishnu_loop: LOOP
        IF num > 5 THEN
            LEAVE Vishnu_loop;
        END IF;
        SELECT num;
        SET num = num + 1;
    END LOOP Vishnu_loop;
END //
DELIMITER ;

-- Call
CALL PrintNumbers();

# Example 7 — Procedure with Cursor
# Loop through employees and print names.

DELIMITER //
CREATE PROCEDURE ListEmployeeNames()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE empName VARCHAR(50);
    DECLARE cur CURSOR FOR SELECT emp_name FROM employees;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO empName;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT empName;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

-- Call
CALL ListEmployeeNames();

# Example 8 — Procedure to Insert Data
# Insert a new employee record.

DELIMITER //
CREATE PROCEDURE AddEmployee(
    IN name VARCHAR(50),
    IN dept VARCHAR(50),
    IN sal DECIMAL(10,2),
    IN joinDate DATE
)
BEGIN
    INSERT INTO employees (emp_name, department, salary, joining_date)
    VALUES (name, dept, sal, joinDate);
END //
DELIMITER ;

-- Call
CALL AddEmployee('Helen', 'HR', 48000, '2023-05-01');
