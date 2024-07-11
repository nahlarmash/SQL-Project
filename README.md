# SQL-Project

## Student Course Management System

### Project Overview:
This project involves creating a database for managing student courses. The database will have tables for students, courses, enrollments, and instructors. Students will learn and practice SQL queries covering various topics such as selection, filtering, aggregation, joins, and subqueries.

#### Project Requirements:

##### Database Setup
- Create a database named **StudentCourseManagement**.

##### Table Creation
- Create the following tables with appropriate data types and constraints:
  
**Students**:
* student_id (Primary Key, INT, AUTO_INCREMENT)
* first_name (VARCHAR)
* last_name (VARCHAR)
* email (VARCHAR)
* date_of_birth (DATE)

**Courses**: 
* course_id (Primary Key, INT, AUTO_INCREMENT)
* course_name (VARCHAR)
* course_description (TEXT)

**Instructors**:
* instructor_id (Primary Key, INT, AUTO_INCREMENT)
* first_name (VARCHAR)
* last_name (VARCHAR)
* email (VARCHAR)

**Enrollments**:
* enrollment_id (Primary Key, INT, AUTO_INCREMENT)
* student_id (Foreign Key, INT)
* course_id (Foreign Key, INT)
* enrollment_date (DATE)

##### Insert Sample Data
- Insert at least 10 students, 5 courses, 3 instructors, and 15 enrollments.

##### Basic Queries
- Select all students.
- Select all courses.
- Select all enrollments with student names and course names.
 
##### Advanced Queries
- Select students who enrolled in a specific course.
- Select courses with more than 5 students.
- Update a student's email.
- Delete a course that no students are enrolled in.
- Calculate the average age of students.
- Find the course with the maximum enrollments.
- List courses along with the number of students enrolled (use GROUP BY).

##### Join Queries
- Select all students with their enrolled courses (use JOIN).
- List all instructors and their courses.
- Find students who are not enrolled in any course.
  
##### Subqueries and Set Operations
- Select students enrolled in more than one course.
- Find courses taught by a specific instructor.
- Select the top 3 students with the most enrollments.
- Use UNION to combine results of two different SELECT queries.
- Functions and Stored Procedures
- Create a stored procedure to add a new student.
- Create a function to calculate the age of a student based on their date of birth.
  
##### Aggregate Functions and Grouping
- Calculate the total number of students.
- Calculate the average, minimum, and maximum number of enrollments per course.

##### Additional Tasks
- Create aliases for complex column names.
- Use CASE to categorize students based on their age.
- Use EXISTS to find courses with at least one enrolled student.
- Create comments in SQL for clarity.
  
##### Expected Learning Outcomes:
- Understand and practice SQL syntax and basic operations.
- Learn to create, read, update, and delete data using SQL.
- Perform complex queries involving joins, subqueries, and set operations.
- Utilize aggregate functions and grouping to analyze data.
- Implement stored procedures and functions for database operations.

##### Submission:
Students should submit their SQL scripts along with a report explaining each query and its output.
