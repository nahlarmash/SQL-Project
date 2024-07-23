USE master; 
GO

-- Create Database
CREATE DATABASE StudentCourseManagement;
USE StudentCourseManagement;

--Create Students table
CREATE TABLE Students
(
student_id INT IDENTITY(1, 1),
first_name VARCHAR(15),
last_name VARCHAR(15),
email VARCHAR(50),
date_of_birth DATE,
CONSTRAINT students_pk PRIMARY KEY (student_id)
);

--Create Courses table
CREATE TABLE Courses(
     course_id INT IDENTITY(1, 1),
     course_name VARCHAR(30),
     course_description TEXT,
	 instructor_id INT,
	 CONSTRAINT courses_pk PRIMARY KEY (course_id),
	 CONSTRAINT instructors_fk FOREIGN KEY (instructor_id)
	 REFERENCES Instructors (instructor_id)
	 );

--Create Instructors table
CREATE TABLE Instructors(
     instructor_id INT IDENTITY(1, 1),
     first_name VARCHAR(15),
     last_name VARCHAR(15),
     email VARCHAR(30),
	 CONSTRAINT instructor_pk PRIMARY KEY (instructor_id)
	 );

--Create Enrollments table
CREATE TABLE Enrollments(
     enrollment_id INT IDENTITY(1, 1),
     enrollment_date DATE,
	 student_id INT,
	 course_id INT,
	 CONSTRAINT studnts_fk FOREIGN KEY (student_id)
	 REFERENCES Students (student_id),
	 CONSTRAINT courses_fk FOREIGN KEY (course_id)
	 REFERENCES Courses (course_id)
	 );

--Insert Sample Data into Students table 
INSERT INTO Students(first_name, last_name, email, date_of_birth)
VALUES ('Ahmed', 'Mohamed', 'ahmed.mohamed@gmail.com', '20000212'),
('Mostafa', 'Ali', 'mostafa.ali@gmail.com', '19990423'),
('Khaled', 'Mohamed', 'khaled.mohamed@gmail.com', '20010604'),
('Mona', 'Ahmed', 'monaahmed@gmail.com', '19980202'),
('Rowan', 'Osama', 'rowan.osama@gmail.com', '19990304'),
('Nada', 'Youssef', 'nada.youssef@gmail.com', '20000104'),
('Mohamed', 'Hassan', 'mohamed.hassan@gmail.com', '20000903'),
('Omar', 'Ahmed', 'omarahmed@gmail.com', '19980208'),
('Ali', 'Gaber', 'aligaber@gmail.com', '19990205'),
('Nahla', 'Ahmed', 'nahla.ahmed@gmail.com', '20000709');

--Insert Sample Data into Courses table 
INSERT INTO Courses(course_name, course_description, instructor_id)
VALUES ('Data Engineering', 'This course focuses on the design, implementation, and management of data pipelines. Topics include data ingestion, ETL (Extract, Transform, Load) processes, data storage solutions, big data technologies, and data warehousing. Students will learn to build and optimize scalable data architectures.', 1),
('Data Science', 'This course provides an in-depth understanding of data science principles and techniques. Topics include data exploration, statistical analysis, machine learning, predictive modeling, and data visualization. Students will work on real-world datasets to apply data science methods and tools.', 1),
('Machine Learning', 'This course covers the foundational concepts and techniques of machine learning. Topics include supervised and unsupervised learning, neural networks, decision trees, support vector machines, and clustering algorithms. Students will apply machine learning methods to real-world datasets.', 2),
('Artificial Intelligence', 'This course explores the principles and techniques of artificial intelligence. Topics include search algorithms, knowledge representation, machine learning, natural language processing, robotics, and ethical issues in AI. Students will implement AI algorithms and systems.', 3),
('Data Analysis', 'This course covers the fundamentals of data analysis and interpretation. Topics include data cleaning, exploratory data analysis, statistical techniques, hypothesis testing, and data visualization. Students will use tools like Python, R, and SQL to analyze and derive insights from data.', NULL),
('Cloud Computing', 'This course covers the fundamentals of cloud computing and its applications. Topics include cloud service models, virtualization, data storage, scalability, and security in the cloud. Students will gain hands-on experience with cloud platforms such as AWS, Azure, and Google Cloud.', 4);    

--Insert Sample Data into Instructors table 
INSERT INTO Instructors (first_name, last_name, email)
VALUES('Ahmed', 'Essam', 'ahmed.essam@gmail.com'),
('Ahmed', 'Azab', 'ahmed.azab@gmail.com'),
('Mohamed', 'Ali', 'mohamed.ali@gmail.com'),
('Salma', 'Mohamed', 'salma.mohamed@gmail.com');    

--Insert Sample Data into Enrollments table 
INSERT INTO Enrollments(student_id, course_id, enrollment_date)
VALUES(1, 1, '20240201'),
(2, 2, '20240203'),
(3, 1, '20240201'),
(4, 2, '20240204'),
(5, 3, '20240301'),
(6, 4, '20240201'),
(7, 1, '20240201'),
(8, 2, '20240301'),
(9, 3, '20240102'),
(1, 2, '20240203'),
(2, 1, '20240302'),
(3, 4, '20240504'),
(4, 2, '20240304'),
(5, 1, '20240304'),
(6, 1, '20240201');

--Select all Students
SELECT * FROM Studets;

--Select all Courses
SELECT * FROM Courses;

--Select all enrollments with student names and course names
SELECT enrollment_id,
       enrollment_date,
	   e.student_id,
	   c.course_id,
       first_name + ' ' + last_name AS student_name,
	   course_name
FROM Enrollments AS e
JOIN Students AS s
ON s.student_id = e.student_id
JOIN Courses AS c 
ON c.course_id = e.course_id;

--Select students who enrolled in a specific course
SELECT s.student_id,
       first_name + ' ' + last_name AS "Student Name",
	   c.course_name AS "Course Name"
FROM Students AS s
JOIN Enrollments AS e
ON s.student_id = e.student_id
JOIN Courses AS c
ON e.course_id = c.course_id
WHERE course_name = 'Data Engineering';

--Select courses with more than 5 students
SELECT  course_name,
        COUNT(student_id) AS "No of Students"
FROM Courses AS c
JOIN Enrollments AS e 
ON c.course_id = e.course_id
GROUP BY course_name
HAVING COUNT(student_id) > 5;

--Update a student's email
UPDATE Students 
SET email = 'ali.gaber@gmail.com'
WHERE student_id = 9;

UPDATE Students 
SET email = 'omar.ahmed@gmail.com'
WHERE student_id = 8;

UPDATE Students 
SET email = 'mona.ahmed@gmail.com'
WHERE student_id = 4;

--Delete a course that no students are enrolled in
DELETE FROM Courses
WHERE course_id NOT IN (
      SELECT DISTINCT course_id 
	  FROM Enrollments);


--Calculate the average age of students
SELECT AVG(DATEDIFF(YEAR, date_of_birth, GETDATE())) AS "Average Age"
FROM Students;


--Find the course with the maximum enrollments
SELECT TOP 1 
       course_name, 
       COUNT(e.student_id) AS "Enrollment Count"
FROM Courses AS c
JOIN Enrollments AS e 
ON e.course_id = c.course_id
GROUP BY course_name
ORDER BY COUNT(e.student_id) DESC;


--List courses along with the number of students enrolled (use GROUP BY)
SELECT course_name, 
       COUNT(e.student_id) AS "Student Count"
FROM Courses AS c 
JOIN Enrollments AS e 
ON e.course_id = c.course_id
GROUP BY course_name
ORDER BY COUNT(e.student_id) DESC;


-- Select all students with their enrolled courses (use JOIN)
SELECT first_name + ' ' + last_name AS "Student Name",
       s.student_id,
       course_name,
	   c.course_id,
	   enrollment_id
FROM Students AS s
JOIN Enrollments AS e 
ON e.student_id = s.student_id
JOIN Courses AS c
ON e.course_id = c.course_id;


--List all instructors and their courses
SELECT first_name + ' ' + last_name AS "Instructor Name",
       course_name
FROM Instructor AS i 
JOIN Courses AS c 
ON i.instructor_id = c.instructor_id;


--Find students who are not enrolled in any course
SELECT first_name + ' ' + last_name AS "Student Name",
	   s.student_id,
	   e.course_id
FROM Students AS s 
LEFT JOIN Enrollments AS e
ON e.student_id = s.student_id
WHERE e.course_id IS NULL;


-- Select students enrolled in more than one course (Using Subquery)
SELECT first_name + ' ' + last_name AS "Student Name", student_id
FROM Students
WHERE student_id IN (
                     SELECT student_id
					 FROM Enrollments
					 GROUP BY student_id
                     HAVING COUNT(course_id) > 1);


--Find courses taught by a specific instructor
SELECT course_id, course_name
FROM Courses
WHERE instructor_id = ( 
                       SELECT instructor_id
					   FROM Instructor
					   WHERE first_name = 'Ahmed' AND last_name = 'Azab');


--Select the top 3 students with the most enrollments
SELECT TOP 3 
       s.student_id,
	   first_name + ' ' + last_name AS "Student Name",
	   (SELECT COUNT (*) FROM Enrollments AS e
	    WHERE s.student_id = e.student_id) AS "Enroll_Count" 
FROM Students AS s
    ORDER BY Enroll_Count DESC;



--Use UNION to combine results of two different SELECT queries
-- Query 1: Select student names and their enrolled courses
SELECT s.student_id, first_name + ' ' + last_name AS "Name",
       c.course_id,
	   course_name
FROM Students AS s
JOIN Enrollments AS e ON s.student_id = e.student_id
JOIN Courses AS c ON e.course_id = c.course_id

UNION

-- Query 2: Select instructor names and their courses
SELECT i.instructor_id,
       first_name + ' ' + last_name AS "Name",
       course_id,
	   course_name
FROM Instructor AS i
JOIN Courses AS c ON i.instructor_id = c.instructor_id;


--Create a stored procedure to add a new student
CREATE PROCEDURE AddNewStudent
    @first_name VARCHAR(15),
    @last_name VARCHAR(15),
    @email VARCHAR(50),
    @date_of_birth DATE
AS    
BEGIN
    -- Insert statement to add a new student
    INSERT INTO Students (first_name, last_name, email, date_of_birth)
    VALUES (@first_name, @last_name, @email, @date_of_birth);
END;

EXEC AddNewStudent 'Morad', 'Mohamed', 'morad.mohamed@gmail.com', '2000-01-01';


--Create a function to calculate the age of a student based on their date of birth
CREATE FUNCTION CalculateAge (@date_of_birth DATE)
RETURNS INT
AS
BEGIN
    DECLARE @age INT;

    -- Calculate age using DATEDIFF function
    SET @age = DATEDIFF(YEAR, @date_of_birth, GETDATE()) -
               CASE
                   WHEN DATEADD(YEAR, DATEDIFF(YEAR, @date_of_birth, GETDATE()), @date_of_birth) > GETDATE()
                   THEN 1
                   ELSE 0
               END;

    RETURN @age;
END;


--Calculate the total number of students
SELECT COUNT(*) AS "Total Students" 
FROM Students;


--Calculate the average, minimum, and maximum number of enrollments per course
SELECT AVG(Enrollments) AS "Average Enrollments",
	   MAX(Enrollments) AS "Max Enrollments",
	   MIN(Enrollments) AS "Min Enrollments"
FROM (
       SELECT
	      course_id,
          COUNT(*) AS Enrollments
       FROM Enrollments
	   GROUP BY course_id
) AS "Enrollments Count";


--Create aliases for complex column names
SELECT s.first_name AS student_first_name, s.last_name AS student_last_name, c.course_name AS course_title
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_d;


-- Use CASE to categorize students based on their age.
SELECT 
    student_id,
    first_name,
    last_name,
    date_of_birth,
    CASE 
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) < 18 THEN 'Under 18'
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 18 AND 25 THEN '18-25'
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 26 AND 35 THEN '26-35'
        ELSE 'Over 35'
    END AS "Age Category"
FROM 
    Students;



-- Use EXISTS to find courses with at least one enrolled student.
SELECT course_id, course_name
FROM Courses AS c
WHERE EXISTS (
    SELECT 1
    FROM Enrollments AS e
    WHERE e.course_id = c.course_id);