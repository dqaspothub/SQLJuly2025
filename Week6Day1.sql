
# CURDATE() → Returns current date

SELECT CURDATE() AS Today;

# NOW() → Returns current date and time

SELECT NOW() AS CurrentDateTime;

# YEAR(), MONTH(), DAY() → Extract parts of date

SELECT 
    YEAR('2025-08-16') AS YearPart,
    MONTH('2025-08-16') AS MonthPart,
    DAY('2025-08-16') AS DayPart;

# DATE_ADD() → Add days, months, years

SELECT DATE_ADD('2025-08-1', INTERVAL 10 DAY) AS After10Days;

# DATE_SUB() → Subtract days, months, years

SELECT DATE_SUB('2025-08-16', INTERVAL 1 MONTH) AS OneMonthBefore;

# DATEDIFF() → Difference in days between two dates

SELECT DATEDIFF('2025-12-31', '2025-08-16') AS DaysLeft;

# DATE_FORMAT() → Format date

SELECT DATE_FORMAT('2025-08-16', '%d-%m-%Y') AS FormattedDate;

# Returns the name of the day or month.

SELECT 
  DAYNAME('2023-08-01') AS day_name,
  MONTHNAME('2023-08-01') AS month_name;

########### Function @@@@@@@@@@@@@@@@@@@@@

drop table Sales;

CREATE TABLE Sales (
    id INT,
    customer VARCHAR(50),
    amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO Sales VALUES
(1, 'Alice', 1000, '2025-08-01'),
(2, 'Bob', 500, '2025-08-10'),
(3, 'Charlie', 1500, '2025-08-15');


-- Sum of all sales
SELECT SUM(amount) AS TotalSales FROM Sales;

-- Average sale amount
SELECT AVG(amount) AS AverageSale FROM Sales;

-- Count customers
SELECT COUNT(*) AS TotalOrders FROM Sales;

-- Get current date
SELECT CURDATE() AS Today;

-- Extract year and month from date
SELECT YEAR(sale_date) AS SaleYear, MONTH(sale_date) AS SaleMonth
FROM Sales;


DELIMITER $$

CREATE FUNCTION GetDiscount(amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE discount DECIMAL(10,2);

    IF amount > 1000 THEN
        SET discount = amount * 0.10; -- 10% discount
    ELSE
        SET discount = amount * 0.05; -- 5% discount
    END IF;

    RETURN discount;
END$$

DELIMITER ;


SELECT 
    id,
    customer,
    amount,
    GetDiscount(amount) AS Discount
FROM Sales;


# DELIMITER is used to avoid confusion between SQL statements and function body.

# You must declare a return type (RETURNS DECIMAL(10,2) here).

# $ DETERMINISTIC means the function always returns the same result for the same input.

-- Step 1: Create a sample table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Step 2: Insert sample data
INSERT INTO Orders VALUES
(1, 'Alice', '2025-08-01', 1200),
(2, 'Bob', '2025-08-10', 800),
(3, 'Charlie', '2025-07-25', 450),
(4, 'David', CURDATE(), 999);

-- Step 3: Use different DATE functions
SELECT 
    order_id,
    customer_name,
    order_date,

    -- Current date & time
    CURDATE() AS Today,
    NOW() AS CurrentDateTime,

    -- Extract parts of date
    YEAR(order_date) AS YearPart,
    MONTH(order_date) AS MonthPart,
    DAY(order_date) AS DayPart,

    -- Add & subtract
    DATE_ADD(order_date, INTERVAL 5 DAY) AS DeliveryDate,
    DATE_SUB(order_date, INTERVAL 10 DAY) AS Before10Days,

    -- Difference in days
    DATEDIFF(CURDATE(), order_date) AS DaysAgo,

    -- Formatting date
    DATE_FORMAT(order_date, '%d-%m-%Y') AS FormattedDate

FROM Orders;



################## Transactions ##################

START TRANSACTION;

-- your SQL queries (INSERT, UPDATE, DELETE)

COMMIT;   -- save changes permanently
ROLLBACK; -- undo changes


CREATE TABLE BankAccounts (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO BankAccounts VALUES
(1, 'Alice', 5000.00),
(2, 'Bob', 3000.00);


START TRANSACTION;

-- Step 1: Deduct from Alice

UPDATE BankAccounts
SET balance = balance - 500
WHERE account_id = 1;

select * from BankAccounts;

-- Step 2: Add to Bob
UPDATE BankAccounts
SET balance = balance + 1000
WHERE account_id = 2;

-- If everything is fine
COMMIT;

-- If something went wrong
 ROLLBACK;



###################################### User Creations ##########################

-- Create a user
CREATE USER 'report_user'@'localhost' IDENTIFIED BY 'report123';

-- Grant read-only access to reports_db
GRANT SELECT ON reports_db.* TO 'report_user'@'localhost';

-- Check permissions
SHOW GRANTS FOR 'report_user'@'localhost';

-- Later revoke access
REVOKE SELECT ON reports_db.* FROM 'report_user'@'localhost';

-- Delete the user if not needed
DROP USER 'report_user'@'localhost';


########################## CTE ###########################

drop table Employees;

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT
);


INSERT INTO Employees (emp_id, name, salary, dept_id) VALUES
(1, 'Alice', 60000, 101),
(2, 'Bob', 45000, 101),
(3, 'Charlie', 70000, 102),
(4, 'David', 50000, 103),
(5, 'Eva', 55000, 102),
(6, 'Frank', 65000, 103);


SELECT emp_id, name, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);


WITH AvgSalary AS (
    SELECT AVG(salary) AS avg_sal FROM Employees
)
SELECT emp_id, name, salary
FROM Employees, AvgSalary
WHERE Employees.salary > AvgSalary.avg_sal;


CREATE VIEW HighSalaryEmployees AS
SELECT emp_id, name, salary
FROM Employees
WHERE salary > 55000;


WITH RECURSIVE CountCTE AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM CountCTE
    WHERE n < 5
)
SELECT * FROM CountCTE;
