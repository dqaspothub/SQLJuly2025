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
