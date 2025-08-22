DROP TABLE IF EXISTS orders;

## Range
-----
CREATE TABLE orders (
    order_id   INT AUTO_INCREMENT ,
    order_date DATE NOT NULL, 
    customer_name VARCHAR(50),
    amount     DECIMAL(10,2),
PRIMARY KEY(order_id, order_date)
)
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p_before_2020 VALUES LESS THAN (2020),
    PARTITION p_2020       VALUES LESS THAN (2021),
    PARTITION p_2021       VALUES LESS THAN (2022),
    PARTITION p_2022       VALUES LESS THAN (2023),
    PARTITION p_future     VALUES LESS THAN MAXVALUE
);

INSERT INTO orders (order_date, customer_name, amount)
VALUES
('2019-05-10', 'Alice', 100.00),
('2020-01-15', 'Bob', 200.50),
('2020-12-01', 'Charlie', 300.00),
('2021-07-20', 'Diana', 150.75),
('2022-03-02', 'Edward', 500.00),
('2025-06-18', 'FutureMan', 9999.99);

SELECT 
    PARTITION_NAME,
    PARTITION_METHOD,
    PARTITION_EXPRESSION,
    SUBPARTITION_METHOD,
    SUBPARTITION_EXPRESSION
FROM information_schema.PARTITIONS
WHERE TABLE_SCHEMA = 'test'
AND TABLE_NAME   = 'orders';

Explain Analyze 

# show create table orders;

# Explain Analyze 
select * from orders where order_date='2025-06-18' ;

explain FORMAT=JSON
select * from orders where order_date='2021-07-20';

## List 

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    department  VARCHAR(50),
    primary key (employee_id,department)
)
PARTITION BY LIST COLUMNS (department) (
    PARTITION p_sales       VALUES IN ('Sales'),
    PARTITION p_hr          VALUES IN ('HR'),
    PARTITION p_engineering VALUES IN ('Engineering', 'DevOps'),
    PARTITION p_other       VALUES IN ('Finance', 'Marketing', 'Operations')
);

INSERT INTO employees (first_name, last_name, department)
VALUES
('Alice', 'Smith', 'Sales'),
('Bob', 'Johnson', 'HR'),
('Charlie', 'Lee', 'Engineering'),
('Diana', 'Lopez', 'DevOps'),
('Eve', 'Turner', 'Marketing');

explain FORMAT=JSON
select * from employees where department='Sales';

## HASH

DROP TABLE IF EXISTS sensor_data;

CREATE TABLE sensor_data (
    sensor_id     INT NOT NULL,
    reading_time  DATETIME NOT NULL,
    reading_value DECIMAL(10,2),
    PRIMARY KEY (sensor_id, reading_time)
)
PARTITION BY HASH(sensor_id)
PARTITIONS 3;

INSERT INTO sensor_data (sensor_id, reading_time, reading_value)
VALUES
(101, '2025-01-01 10:00:00', 23.50),
(102, '2025-01-01 10:05:00', 24.10),
(103, '2025-01-01 10:10:00', 22.75),
(104, '2025-01-01 10:15:00', 25.00),
(105, '2025-01-01 10:20:00', 20.00),
(106, '2025-01-01 10:25:00', 21.60);

explain format=json
select * from sensor_data where sensor_id=102;

## Sub Partition 

CREATE TABLE orders (
    order_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_date    DATE NOT NULL,
    customer_name VARCHAR(50),
    amount        DECIMAL(10,2)
)
-- Range partition by YEAR(order_date)
PARTITION BY RANGE (YEAR(order_date))
-- Subpartition by HASH on MONTH(order_date)
SUBPARTITION BY HASH (MONTH(order_date))
-- We want 3 top-level (range) partitions
PARTITIONS 3
-- Each partition splits into 2 subpartitions
SUBPARTITIONS 2
(
  PARTITION p_before_2020 VALUES LESS THAN (2020),
  PARTITION p_2020        VALUES LESS THAN (2021),
  PARTITION p_future      VALUES LESS THAN MAXVALUE
);


## Partition with index

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_date    DATE NOT NULL,
    customer_name VARCHAR(50),
    amount        DECIMAL(10,2)
)
-- Partitioning by YEAR(order_date)
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p_before_2020 VALUES LESS THAN (2020),
    PARTITION p_2020       VALUES LESS THAN (2021),
    PARTITION p_2021       VALUES LESS THAN (2022),
    PARTITION p_2022       VALUES LESS THAN (2023),
    PARTITION p_future     VALUES LESS THAN MAXVALUE
);
CREATE INDEX idx_order_date ON orders (order_date);


INSERT INTO orders (order_date, customer_name, amount)
VALUES
('2019-05-10', 'Alice', 100.00),
('2020-01-15', 'Bob', 200.50),
('2020-12-01', 'Charlie', 300.00),
('2021-07-20', 'Diana', 150.75),
('2022-03-02', 'Edward', 500.00),
('2025-06-18', 'FutureMan', 9999.99);

SELECT *
FROM orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31';


####################################REGEX########################################################

# In SQL, "regex" stands for "regular expression," which is a sequence of characters used to define a search pattern, allowing you to find and manipulate text data within your database by 
# matching complex patterns within strings, rather than just exact matches; essentially providing a powerful tool for searching, extracting, and validating data based on specific character patterns 
# within your SQL queries. 

# Eample 

use sqljuly2025;

DROP TABLE IF EXISTS regex_samples;

CREATE TABLE regex_samples (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sample_text VARCHAR(100)
);


INSERT INTO regex_samples (sample_text) VALUES 
('apple'),         -- id=1
('Banana'),        -- id=2 (note the capital B)
('cherry'),        -- id=3
('date'),          -- id=4
('elderberry'),    -- id=5
('fig'),           -- id=6
('grape'),         -- id=7
('honeydew'),      -- id=8
('running'),       -- id=9 (ends with "ing")
('123abc');        -- id=10 (starts with digits)


#Example 1: Match Strings That Start with “a”

SELECT * 
FROM regex_samples
WHERE sample_text REGEXP '^a';


#Example 2: Match Strings That End with “e”
SELECT * 
FROM regex_samples
WHERE sample_text REGEXP 'e$';


#Example 3: Match Strings That Start with a Digit

SELECT * 
FROM regex_samples
WHERE sample_text REGEXP '^[0-9]';


#Example 4: Match Strings Ending with “ing”
SELECT * 
FROM regex_samples
WHERE sample_text REGEXP 'ing$';

#Example 5: Match Strings with Consecutive Repeated Characters
SELECT * 
FROM regex_samples
WHERE sample_text REGEXP '(.)\\1';


#Example 6: Match Strings That Contain Only Letters

SELECT * 
FROM regex_samples
WHERE sample_text REGEXP '^[A-Za-z]+$';


#Example 7: Match Strings with Exactly 5 Characters

SELECT * 
FROM regex_samples
WHERE sample_text REGEXP '^.{5}$';


#Example 9: Match Only “apple” or “banana” Exactly
SELECT * 
FROM regex_samples
WHERE sample_text REGEXP '^(apple|banana)$';


#Example 10: Match Strings Starting with 3 Digits Followed by Letters

SELECT * 
FROM regex_samples
WHERE sample_text REGEXP '^[0-9]{3}[A-Za-z]+$';



CREATE TABLE demo_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50),
    phone VARCHAR(25),
    email VARCHAR(100),
    date_col VARCHAR(10),   -- Storing as VARCHAR for the demo
    status VARCHAR(20),
    sku VARCHAR(20),
    username VARCHAR(30),
    notes VARCHAR(100)
);


INSERT INTO demo_data (full_name, phone, email, date_col, status, sku, username, notes)
VALUES
-- 1
('John Smith', 
 '123-456-7890', 
 'john@example.com', 
 '2025-02-07', 
 'pending', 
 'ABCD', 
 'johnsmith', 
 'Ships to CA'),

-- 2
('Alice Johnson', 
 '(987) 654-3210', 
 'alice@@example.net', 
 '2025-02-07', 
 'inactive', 
 'SKU-123', 
 'alice', 
 'NY location'),

-- 3
('Bob Williams', 
 '+1-555-123-4567', 
 'bob@sample.org', 
 '20250207', 
 'complete', 
 '1SKU', 
 'bob123', 
 'Shipping to CA'),

-- 4
('Mary 1 White', 
 '(123) 123-4567', 
 'mary123@example.com', 
 '2025-13-31', 
 'PENDING', 
 'abc-999', 
 'mary_white', 
 'Something about CA or'),

-- 5
('Mark-Spencer', 
 '1234567890', 
 'mark@example.com', 
 '2024-11-02', 
 'active', 
 'SKU-9999', 
 'mark', 
 'Random note'),

-- 6
('Jane O''Connor',   -- Note the doubled apostrophe for SQL
 '987-654-3210', 
 'jane.o.connor@example.org', 
 '2024-12-31', 
 'inactive', 
 'ABCDE', 
 'janeO', 
 'Contains CA or NY'),

-- 7
('Invalid Mail', 
 '000-000-0000', 
 'invalid@@example..com', 
 '2023-01-15', 
 'inactive', 
 'XYZ000', 
 'invalid', 
 'Double @ and dots'),

-- 8
('NoSpacesHere', 
 '+12-345-678-9012',
 'nospaces@example.co',
 '2025-02-07',
 'pending',
 'SKU999',
 'NoSpaces',
 'Ends with .co domain');


#1. Matching a Strict Date Format (YYYY-MM-DD)

SELECT *
FROM demo_data
WHERE date_col REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';


#2. Matching Names Containing Only Letters and Spaces
SELECT *
FROM demo_data
WHERE full_name REGEXP '^[A-Za-z ]+$';


###################################### STRING FUNCTIONS ###################################

-- String Handling 

CREATE TABLE CustomerDetails (
    id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    phone_number VARCHAR(15)
);

INSERT INTO CustomerDetails (id, customer_name, city, phone_number) VALUES
(1, 'Alice Johnson', 'New York', '12345'),
(2, 'Bob Smith', 'Los Angeles', NULL),
(3, 'Charlie Brown', 'Chicago', '98765'),
(4, 'Daisy Adams', 'Houston', '54321'),
(5, 'Evan Lee', 'Phoenix', NULL);

SELECT 
    id,
    customer_name,
    LENGTH(customer_name) AS name_length,
    UPPER(customer_name) AS uppercase_name,
    LOWER(customer_name) AS lowercase_name,
    CONCAT(city, ' - ', COALESCE(phone_number, '00000')) AS contact_info,
    SUBSTRING(customer_name, 1, 7) AS name_prefix,
    TRIM('   ExampleCity   ') AS trimmed_city,
    LPAD(customer_name, 15, '*') AS left_padded_name,
    RPAD(customer_name, 15, '-') AS right_padded_name,
    REPLACE(customer_name, ' ', '_') AS updated_name,
    INSTR(customer_name, 'a') AS position_of_a,
    LEFT(customer_name, 5) AS first_5_chars,
    RIGHT(customer_name, 5) AS last_5_chars,
    REVERSE(customer_name) AS reversed_name,
    FORMAT(9876543210, 2) AS formatted_number
FROM 
    CustomerDetails;


SELECT 
    id,
    customer_name,
    -- Extract the length of the customer name
    LENGTH(customer_name) AS name_length,
    
    -- Convert customer name to uppercase and lowercase
    UPPER(customer_name) AS uppercase_name,
    LOWER(customer_name) AS lowercase_name,
    
    -- Concatenate city and phone number with formatting
    CONCAT(city, ' - ', COALESCE(phone_number, '00000')) AS contact_info,
    
    -- Extract a substring from the customer name
    SUBSTRING(customer_name, 1, 5) AS name_prefix,
    
    -- Trim whitespace from a sample city string
    TRIM('   ExampleCity   ') AS trimmed_city,
    
    -- Pad customer name on the left and right
    LPAD(customer_name, 15, '*') AS left_padded_name,
    RPAD(customer_name, 15, '-') AS right_padded_name,
    
    -- Replace spaces in customer name with underscores
    REPLACE(customer_name, ' ', '_') AS updated_name,
    
    -- Find the position of the letter 'a' in customer name
    INSTR(customer_name, 'a') AS position_of_a,
    
    -- Extract the first 5 and last 5 characters from the customer name
    LEFT(customer_name, 5) AS first_5_chars,
    RIGHT(customer_name, 5) AS last_5_chars,
    
    -- Reverse the customer name
    REVERSE(customer_name) AS reversed_name,
    
    -- Format a sample number
    FORMAT(9876543210, 2) AS formatted_number
    
FROM 
    CustomerDetails;
	
	
################################ NULL CHECKS #####################

-- null handling

CREATE TABLE CustomerData (
    id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(200),
    amount DECIMAL(10, 2)
);

INSERT INTO CustomerData VALUES
(1, 'Ravi', 'ravi@example.com', '9876', 'Chennai', 5000.00),
(2, 'Priya', NULL, '9876', 'Bangalore', NULL),
(3, 'Arjun', 'arjun@example.com', NULL, 'Hyderabad', 1500.00),
(4, 'Meena', NULL, NULL, 'Mumbai', 2500.00),
(5, 'Karthik', 'karthik@example.com', '9876', NULL, 3000.00);

# IS NULL
  ------
SELECT 
    COUNT(*) AS null_phone_count 
FROM 
    CustomerData 
WHERE 
    phone_number IS NULL;

# IS NOT NULL 
  -------
SELECT 
    COUNT(*) AS null_phone_count 
FROM 
    CustomerData 
WHERE 
    phone_number IS NOT NULL;



# Select Rows with at Least One Null
   ---------------------------

SELECT 
    id, 
    customer_name, 
    email, 
    phone_number, 
    address 
FROM 
    CustomerData 
WHERE 
    email IS NULL 
    OR phone_number IS NULL 
    OR address IS NULL;


# INVALID
  ------
SELECT * 
FROM CustomerData 
WHERE email = NULL;  -- > Invalid 


# COLAESCE
  -------
SELECT 
    customer_name, 
    COALESCE(amount, 0) AS adjusted_amount 
FROM 
    CustomerData;


# IFNULL
  ------
SELECT customer_name, IFNULL(amount, 0) AS adjusted_amount FROM CustomerData;