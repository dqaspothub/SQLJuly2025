CREATE TABLE employees_v (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100), -- Can be NULL
    department VARCHAR(50) NOT NULL
);

-- Insert 1: Full record
INSERT INTO employees_v (name, email, department)
VALUES ('John Doe', 'john@example.com', 'HR');

SELECT * FROM employees_v;

-- Insert 2: NULL value in email
INSERT INTO employees (name, email, department)
VALUES ('Jane Smith', NULL, 'Finance');

-- Insert 3: Without email (implicitly NULL)
INSERT INTO employees (name, department)
VALUES ('Mike Ross', 'IT');

-- Insert 4: Missing name (should fail due to NOT NULL)
-- This will throw an error:
-- INSERT INTO employees (email, department)
-- VALUES ('mike@abc.com', 'Marketing');



#AUTO INCREMENT

CREATE TABLE Trasnsaction(

Trasnsaction_id INT PRIMARY KEY AUTO_INCREMENT,
Trasnsaction_Amount DECIMAL(5,2)
);

INSERT INTO Trasnsaction(Trasnsaction_Amount)
VALUES (40.00);

INSERT INTO Trasnsaction(Trasnsaction_Amount)
VALUES (70.00);

SELECT * FROM Trasnsaction;

Alter TABLE Trasnsaction
AUTO_INCREMENT = 1000;

INSERT INTO Trasnsaction(Trasnsaction_Amount)
VALUES (71.00);


CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    salesperson VARCHAR(50),
    region VARCHAR(50),
    amount DECIMAL(10, 2)
);


INSERT INTO sales (salesperson, region, amount) VALUES
('Alice', 'North', 1200.50),
('Bob', 'South', 950.00),
('Alice', 'North', 800.75),
('Charlie', 'North', 700.00),
('Bob', 'South', 1100.00),
('Alice', 'South', 400.00);


SELECT salesperson, SUM(amount) AS total_sales
FROM sales
GROUP BY salesperson;


#HAVING Clause – Filter After Grouping
#Unlike WHERE, which filters before grouping, HAVING filters after grouping.

SELECT salesperson, SUM(amount) AS total_sales
FROM sales
GROUP BY salesperson
HAVING SUM(amount) > 2000;


SELECT salesperson, SUM(amount) AS total_sales
FROM sales
GROUP BY salesperson
ORDER BY total_sales DESC;

#Combine All: GROUP BY + HAVING + ORDER BY

SELECT salesperson, SUM(amount) AS total_sales
FROM sales
GROUP BY salesperson
HAVING SUM(amount) > 1000
ORDER BY total_sales DESC;



###############################

#UNION and UNION ALL

CREATE TABLE cs_students (
    name VARCHAR(50),
    year INT
);

CREATE TABLE it_students (
    name VARCHAR(50),
    year INT
);

INSERT INTO cs_students VALUES 
('Alice', 2),
('Bob', 3),
('Charlie', 2);

INSERT INTO it_students VALUES
('Alice', 2),
('David', 3),
('Eve', 1);


SELECT name, year FROM cs_students
UNION
SELECT name, year FROM it_students;

SELECT name, year FROM cs_students
UNION ALL
SELECT name, year FROM it_students;

CREATE TABLE Articles (
    id INT PRIMARY KEY,
    title VARCHAR(255),
    content LONGTEXT
);

INSERT INTO Articles VALUES (1, 'Introduction to SQL', 'This is a long article...');


#Good Use of CHAR:

#gender CHAR(1) -- M/F/U
#country_code CHAR(2) -- US, IN, UK

#good Use of VARCHAR:

#name VARCHAR(100)
#email VARCHAR(255)
#phone_number VARCHAR(20)

#Good Use of TEXT:

#description TEXT
#blog_post LONGTEXT
#error_log MEDIUMTEXT


CREATE TABLE SampleIntegers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    t_val TINYINT,          -- Small range: -128 to 127
    s_val SMALLINT,         -- -32,768 to 32,767
    m_val MEDIUMINT,        -- -8,388,608 to 8,388,607
    i_val INT,              -- -2,147,483,648 to 2,147,483,647
    b_val BIGINT            -- Up to ±9.2 x 10^18
);

INSERT INTO SampleIntegers (t_val, s_val, m_val, i_val, b_val) VALUES
(-100, -1000, -100000, -1000000, -1000000000),
(127, 32767, 8388607, 2147483647, 9223372036854775807),
(0, 0, 0, 0, 0);

SELECT * FROM SampleIntegers;


CREATE TABLE employees_vk (
    id INT,
    name VARCHAR(50),
    salary DECIMAL(10, 2),
    join_date DATE,
    bonus DECIMAL(10, 2)
);

INSERT INTO employees_vk (id, name, salary, join_date, bonus) VALUES
(1, 'Alice Johnson', 55000.75, '2020-01-15', 5000.00),
(2, 'bob smith', 47000.50, '2021-06-10', 3000.00),
(3, 'CHARLIE MILLER', 62000.90, '2019-11-01', NULL),
(4, 'Diana Prince', 58000.00, '2022-03-22', 4000.00);


SELECT 
    id,
    name,
    salary,
    ROUND(salary, 0) AS rounded_salary,
    COALESCE(bonus, 0) AS final_bonus
FROM employees;


SELECT 
    name,
    UPPER(name) AS upper_case,
    LOWER(name) AS lower_case,
    LENGTH(name) AS name_length,
    SUBSTRING(name, 1, 5) AS short_name
FROM employees_vk;


SELECT 
    name,
    join_date,
    YEAR(join_date) AS joined_year,
    MONTH(join_date) AS joined_month,
    DAY(join_date) AS joined_day
FROM employees_vk;


SELECT 
    name,
    salary,
    POWER(salary, 2) AS salary_squared,
    SQRT(salary) AS salary_sqrt,
    CEIL(salary) AS ceiling_value,
    FLOOR(salary) AS floor_value
FROM employees_vk;
