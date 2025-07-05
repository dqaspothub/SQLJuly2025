
-- Aggregate Functions

-- COUNT() — Total Employees

Select * from Employees;

SELECT COUNT(*) AS total_employees
FROM Employees;

-- SUM() — Total Salary Paid

SELECT SUM(Salary) AS total_salary
FROM Employees;

-- AVG() — Average Salary
SELECT AVG(Salary) AS average_salary
FROM Employees;

-- MIN() and MAX()

SELECT MIN(Salary) AS min_salary,
       MAX(Salary) AS max_salary
FROM Employees;

-- GROUP BY with Aggregate Function

SELECT department_id, COUNT(*) AS emp_count
FROM Employees
GROUP BY department_id;

--  HAVING with Aggregate

SELECT department_id, AVG(Salary) AS avg_salary
FROM Employees
GROUP BY department_id
HAVING AVG(Salary) > 60000;

-- SQL CONSTRAINTS

CREATE TABLE Student_New (
    StudentID INT PRIMARY KEY,         -- Unique and not null
    Name VARCHAR(100) NOT NULL,        -- Name must be provided
    Email VARCHAR(100) UNIQUE,         -- No duplicate emails
    Age INT CHECK (Age >= 17),         -- Must be at least 17
    City VARCHAR(100) DEFAULT 'Chennai' -- If not provided, defaults to Chennai
);

Select * from Student_New;

Insert into Student_New (StudentID,Name,Email, Age,City)
VALUES (3,"Kannathasan","kannathasansdet@gmail.com",30,"Madurai");

CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    PRIMARY KEY (employee_id)
);

-- Name VARCHAR(100) NOT NULL

-- Prevents storing a NULL in this column.
-- If you try to insert a student without a name, it will fail.

-- Email VARCHAR(100) UNIQUE

-- No two students can have the same email.
-- Duplicate values will cause an error.

-- StudentID INT PRIMARY KEY

-- Combines NOT NULL + UNIQUE
-- Identifies each row uniquely.

-- Age INT CHECK (Age >= 17)

-- Enforces a condition on values.
-- Any value below 17 will be rejected.

-- City VARCHAR(100) DEFAULT 'Chennai'

-- If no city is provided during INSERT, it automatically sets to "Chennai".


INSERT INTO Students (StudentID, Name, Email, Age)
VALUES (1, 'Arun', 'arun@test.com', 20);

-- The City will be automatically set to 'Chennai' due to the DEFAULT constraint.

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

CREATE TABLE Enrollments (
    Student_newID INT,
    CourseID INT,
    FOREIGN KEY (Student_newID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- This links Enrollments table to both Students and Courses.
-- You cannot insert a record into Enrollments if the StudentID or CourseID doesn't exist.

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2) CHECK (salary >= 0)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2),
    CONSTRAINT chk_salary_positive CHECK (salary >= 0)
);

----------------------------------------------------------------------

CREATE database StudentManagemnet;

USE StudentManagemnet;

CREATE TABLE Attendence (
    my_date DATE,
    my_time TIME,
    my_datetime DATETIME
);

SELECT * FROM Attendence;

drop table Attendence;
truncate table Attendence;



INSERT INTO Attendence values(current_date(),current_time(),now());

insert into Attendence values(current_date()+1,null,null);

insert into Attendence values(current_date()-1,null,null);

DROP TABLE Attendence;

DROP database StudentManagemnet;

########## NOT NULL CONTRAINTS##########

USE StudentManagemnet;

CREATE TABLE Colleges (
  college_id INT NOT NULL,
  college_code VARCHAR(20),
  college_name VARCHAR(50)
);

SELECT * FROM Colleges;

INSERT INTO Colleges
(college_id, college_code, college_name)
VALUES 
('01', 'COLL001', 'SVCET'),
('02', 'COLL002', 'AnnaUniv'),
('03', 'COLL003', 'MadrasUnvi');

INSERT INTO Colleges
(college_id, college_code, college_name)
VALUES 
('04', 'COLL004', NULL);

ALTER TABLE Colleges
MODIFY college_code VARCHAR(20) NOT NULL;  -- To modify the CONSTANT on the new column

INSERT INTO Colleges
(college_id, college_code, college_name)
VALUES 
('05', NULL, NULL); 

# Adding a NOT NULL constraint to an existing column #

SET SQL_SAFE_UPDATES = 0;  

UPDATE Colleges
SET
  college_name = "ANNAUNIV"
WHERE
  college_name IS NULL;
  
INSERT INTO Colleges
(college_id, college_code, college_name)
VALUES 
('04', NULL, 'SSN');

DROP TABLE Colleges;  -- To delete the complete table and structure 

truncate TABLE Colleges; -- To delete only values

############ UNIQUE Constraint #############

CREATE TABLE Colleges (
  college_id INT NOT NULL UNIQUE,
  college_code VARCHAR(20) UNIQUE,
  college_name VARCHAR(50),
  gender CHAR(6),
  Blog TEXT
);

INSERT INTO Colleges
(college_id, college_code, college_name)
VALUES 
('01', 'COLL001', 'SVCET'),
('02', 'COLL002', 'AnnaUniv'),
('03', 'COLL003', 'MadrasUnvi');

INSERT INTO Colleges
(college_id, college_code, college_name)
VALUES 
('04', 'COLL001', 'DMI');

#Other way unique Constraints

CREATE TABLE users (
  id INT ,
  username VARCHAR(25) NOT NULL,
  password VARCHAR(50) NOT NULL,
  phone VARCHAR(20),
  CONSTRAINT unique_username UNIQUE (username)
);

SELECT * FROM users;

INSERT INTO users
VALUES (01,"KANNA","1234","9840556879");

INSERT INTO users
VALUES (02,"KANNATHASAN","12345","9840556878","031");

# To add UNIQUE Constraint in existing table 

ALTER TABLE users 
ADD CONSTRAINT 
UNIQUE(phone);

ALTER TABLE users
ADD CONSTRAINT unique_phone UNIQUE (phone);

#To add the unique contraint for the new column

ALTER TABLE users
ADD employee_id INT UNIQUE;

INSERT INTO users
VALUES (03,"GAJA","12390","9840556899","031");

#To remove the constraint

ALTER TABLE users
DROP CONSTRAINT unique_phone;

INSERT INTO users
VALUES (04,"ANU","1236","87654902","033");

INSERT INTO users
VALUES (05,"DIYU","1239","87654902","035");

#PRIMARY KEY CONTRAINT

CREATE TABLE projects (
  project_id INT PRIMARY KEY,
  project_name VARCHAR(255) NOT NULL ,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL
);

SELECT * FROM projects;

# Other way of creating primary key

CREATE TABLE IF NOT EXISTS projects (
  project_id INT,
  project_name VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  PRIMARY KEY (project_id)
);

DROP table projects;

CREATE TABLE project_assignments (
  project_id INT,
  employee_id INT,
  assigned_date DATE NOT NULL,
  PRIMARY KEY (project_id, employee_id)
);

DROP table project_assignments;

CREATE TABLE project_milestones (
  milestone_id INT,
  project_id INT NOT NULL,
  milestone_name VARCHAR(255) NOT NULL,
  CONSTRAINT project_milestones_pk PRIMARY KEY (milestone_id)
);

DROP table project_milestones;

ALTER TABLE project_milestones 
DROP CONSTRAINT project_milestones_pk;

ALTER TABLE project_milestones
ADD PRIMARY KEY (milestone_id);

#FORINEKEY

CREATE TABLE projects (
    project_id INT  PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

CREATE TABLE project_milestones (
  milestone_id INT PRIMARY KEY,
  milestone VARCHAR(255),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  project_id INT NOT NULL,
  FOREIGN KEY (project_id) REFERENCES projects (project_id)
);

INSERT INTO
  projects 
VALUES
  (1,'Super App', '2025-01-01', '2025-12-31');
  
  INSERT INTO
  project_milestones (milestone_id,milestone, start_date, end_date, project_id)
VALUES
  (20,'Initiation', '2025-01-01', '2025-01-31', 1);
  
  INSERT INTO
  project_milestones (milestone, start_date, end_date, project_id)
VALUES
  ('Initiation', '2025-01-01', '2025-01-31', 1);
  
  CREATE TABLE project_tasks (
  task_id INT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  completed BOOL NOT NULL DEFAULT FALSE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  milestone_id INT
);

ALTER TABLE project_tasks
ADD CONSTRAINT project_tasks_milestone_id_fkey 
FOREIGN KEY (milestone_id) 
REFERENCES project_milestones (milestone_id);

ALTER TABLE project_tasks
DROP CONSTRAINT project_tasks_milestone_id_fkey;

#CHECK

CREATE TABLE IF NOT EXISTS offers (
  offer_id INT  PRIMARY KEY,
  offer_date DATE NOT NULL,
  job_id INT NOT NULL,
  candidate VARCHAR(255) NOT NULL CHECK (candidate ="kanna"),
  salary DECIMAL(19, 2) NOT NULL CHECK (salary > 0)
  );

SELECT * FROM offers;

DROP TABLE offers;

INSERT INTO
  offers (offer_id,offer_date, job_id, candidate, salary)
VALUES
  (1,'1994-05-07', 1, 'kanna', 1);
  
  INSERT INTO
  offers (offer_date, job_id, candidate, salary)
VALUES
  ('1994-05-07', 1, 'William Giet', 8300);
  
  SELECT
  offer_date,
  job_id,
  candidate,
  salary
FROM
  offers;
  
  CREATE TABLE hires (
  hire_id INT  PRIMARY KEY,
  offer_id INT NOT NULL,
  hire_date DATE NOT NULL,
  start_date DATE NOT NULL,
  CONSTRAINT check_start_date CHECK (start_date >= hire_date)
);

#DEFAULT

-- set default value of college_country column to 'US'
CREATE TABLE College (
  college_id INT PRIMARY KEY,
  college_code VARCHAR(20),
  college_country VARCHAR(20) DEFAULT 'US'
);

DROP TABLE College;

-- don't add any value to college_country column
-- thus default value 'US' is inserted to the column
INSERT INTO College (college_id, college_code)
VALUES (1, 'ARP76');

-- insert 'UAE' to the college_country column
INSERT INTO College (college_id, college_code, college_country)
VALUES (2, 'JWS89', 'UAE');

SELECT * FROM College;

ALTER TABLE College
ALTER college_country SET DEFAULT 'US';

ALTER TABLE College
ALTER college_country DROP DEFAULT;

DROP DATABASE StudentManagemnet;


CREATE TABLE Collegenew (
  college_id INT PRIMARY KEY,
  college_code VARCHAR(20) NOT NULL,
  college_name VARCHAR(50)
);

-- create index
CREATE INDEX college_index
ON Collegenew(college_code);

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



