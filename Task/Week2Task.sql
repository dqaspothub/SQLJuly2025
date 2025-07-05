--------------------Week2 Day 1 Task 

CREATE TABLE Students (
    StudentID INT,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50),
    Marks INT
);

INSERT INTO Students (StudentID, Name, Age, City, Marks) VALUES
(1, 'Alice', 18, 'Mumbai', 85),
(2, 'Bob', 19, 'Delhi', 72),
(3, 'Charlie', 20, 'Chennai', 60),
(4, 'David', 18, 'Delhi', 55),
(5, 'Eva', 21, 'Kolkata', 90),
(6, 'Frank', 19, 'Mumbai', 35),
(7, 'Grace', 20, 'Chennai', 75),
(8, 'Helen', 22, 'Bangalore', 50);

-- Questions

Display all students from the table.
Display names and marks of all students.
Find all students from either Delhi or Chennai
Find students whose marks are between 60 and 85.
Find students whose names start with ‘A’.
Increase marks by 5 for students from 'Mumbai'.
Change the city of student 'Frank' to 'Pune'.
Set Marks = 40 and City = 'Lucknow' for student ID 8.
Show names of students whose names contain 'a' and are from either Chennai or Kolkata
Display all students sorted by marks in descending order.

--------------------Week2 Day 2 Task 

-- Get the table and values from this word document under task 3 (https://docs.google.com/document/d/17Ts7jK-H86RsHJg9J41Qp5kPrEt6wKCktxhjqwkOh_s/edit?usp=sharing)

Select the detail of the employee whose name start with P.
How many permanent candidate take salary more than 5000.
Select the detail of employee whose emailId is in gmail.
Select the details of the employee who work either for department E-104 or E-102
What is the department name for DeptID E-102?
What is total salary that is paid to permanent employees?
List name of all employees whose name ends with a.
List the number of department of employees in each project.
How many project started in year 2010.
How many project started and finished in the same year.
select the name of the employee whose name's 3rd character is 'h'.

NOTE: Try to use all the SQL CONSTRAINTS which is learned in our previous session 

-------------------------------------

Schema 

Create a database record_company

Create a table bands which has two column ID and Name

ID and Name should not be NULL.
ID should be the primary key for the bands table

Create a table albums which has four column ID,Name,release year,Band_id

ID,Name,band_id should not be NULL.
ID should be the primary key for the albums table
Band_id should be foreign key which should reference bands table ID


Create a table songs which has four column ID,Name,release year,Band_id

ID,Name,album_id  should not be NULL.
ID should be the primary key for the songs table
Album_id should be foreign key which should reference albums table ID

For all the above 3 table insert the values based on your wish

1.List all the brand names
2.List all the column from albums table where the release_year should not be NULL and it should order the list in descending order based on release year
3.From the above 3 tables only display 2 values imagin each table has 5 values but we need to display only 2 values 



