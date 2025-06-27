/*Think of RDBMS Like an Excel Sheet:

Imagine an Excel file where:

Each sheet = a table

Each row = a record

Each column = a field (attribute)

==============================

These SQL commands are grouped into categories based on their purpose. The most important ones are:

DDL – Data Definition Language - Used to define and modify the structure of database objects like tables, views, indexes, etc.
DML – Data Manipulation Language - Used to manipulate the data inside database objects (like inserting, updating, deleting, or retrieving data).
DCL – Data Control Language - Used to manage permissions and access control in the database.
TCL – Transaction Control Language - Used to manage transactions in a database, ensuring data consistency and integrity.

===================================

What is SQL Database?	
	
SQL (Structured Query Language) databases are relational databases. They store data in tables with fixed schemas .	
	
Examples:	

MySQL	
PostgreSQL	
Oracle	
Microsoft SQL Server	
	
What is NoSQL Database?	
	
NoSQL (Not Only SQL) databases are non-relational. They are more flexible and designed to handle unstructured or semi-structured data .	
	
"{
  ""user_id"": ""123"",
  ""timestamp"": ""2025-04-05T10:30:00Z"",
  ""event_type"": ""click"",
  ""page_url"": ""/home"",
  ""device"": ""mobile"",
  ""session_id"": ""abc123xyz""
}"	
	
Types of NoSQL DB

Document-based - MongoDB
Key-Value - Redis, DynamoDB
Column-family-Cassandra
Graph - Neo4j

HYBRID APPROCH 

SQL for core business logic (orders, payments)
NoSQL for logs, caching, user preferences
Example: Amazon uses DynamoDB (NoSQL) for product catalogs and Oracle/MySQL (SQL) for financial transactions.

Why Relational? - tables are related to each other via keys (like student_id, course_id, etc.).


*/


CREATE DATABASE school_db; -- To Create Database
USE school_db; --To use Database
DROP DATABASE school_db; --To delete Database
SHOW DATABASES; --To see all the databases 

--To create a table named students

CREATE TABLE students (
    student_id INT, --INT is a DataType
    first_name VARCHAR(50), -- VARCHAR is a DataType
    last_name VARCHAR(50),
    email VARCHAR(100),
    date_of_birth DATE --DATE is a Datatype
);


-- Step 1: Create the database
CREATE DATABASE school_db;

-- Step 2: Use the database
USE school_db;

-- Step 3: Create a table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    date_of_birth DATE
);

-- Step 4: Insert data into the table
INSERT INTO students (first_name, last_name, email, date_of_birth)
VALUES ('John', 'Doe', 'john@example.com', '2000-05-15');

-- Step 5: Query the data
SELECT * FROM students;

==================

-- Table: teachers
CREATE TABLE teachers (
    teacher_id INT ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    subject VARCHAR(50),
    hire_date DATE
);

-- Table: courses
CREATE TABLE courses (
    course_id INT,
    course_name VARCHAR(100),
);

=====================

--Class Room Practice 

CREATE Database SQLJuly2025;

create database mayorder;

show databases;

DROP DATABASE mayorder;

Show tables;

USE SQLJuly2025;

INSERT INTO students (student_id,first_name, last_name, email, date_of_birth)
VALUES (2,'Vishnu','Priya','vishunupriya@gmail.com','1993-05-17');
