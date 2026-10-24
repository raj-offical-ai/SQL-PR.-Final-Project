# University Course Management System

**Author:** Raj Dabhade

## Project Overview
The University Course Management System is a MySQL-based database project designed to manage university departments, students, courses, instructors, and enrollments. It demonstrates database relationships and SQL queries for retrieving and analyzing academic information.

## Technologies Used
- MySQL
- SQL (DDL, DML, and DQL)
- Joins, Subqueries, Aggregate Functions, and Window Functions

## Database Tables
The project contains five tables:

1. **Departments** – Stores department details.
2. **Students** – Stores student information and enrollment dates.
3. **Courses** – Stores course names, credits, and department details.
4. **Instructors** – Stores instructor information, departments, and salaries.
5. **Enrollments** – Maintains student-course enrollment records.

## Key Features
- Creates and initializes the university database.
- Inserts sample records into all five tables.
- Retrieves student, course, instructor, department, and enrollment details.
- Filters students by enrollment date.
- Finds courses offered by a specific department.
- Calculates average course credits and maximum instructor salary.
- Counts students in courses and departments.
- Uses INNER JOIN and LEFT JOIN to combine related data.
- Demonstrates subqueries, GROUP BY, HAVING, and DISTINCT.
- Uses date functions, CONCAT(), CASE expressions, and running totals.

## SQL Concepts Demonstrated
- Database and table creation
- Primary and foreign keys
- UNIQUE and NOT NULL constraints
- INSERT and SELECT statements
- JOIN operations
- Aggregate functions: COUNT(), AVG(), MAX(), SUM()
- Subqueries and grouping
- Window functions
- Date and string functions
- Conditional logic using CASE

## How to Run
1. Open MySQL Workbench or another MySQL-compatible SQL editor.
2. Copy the project SQL script into a query window.
3. Execute the script to create the database and tables and insert sample data.
4. Run the SELECT queries individually or execute the complete corrected script.
5. Review the output for each query.

## Expected Output
The project displays academic records and query results, including student details, course information, instructor salaries, department-wise student counts, course enrollments, average credits, and student classifications.

**Note:** The sample data contains two students, two courses, two instructors, two departments, and two enrollment records. Queries requiring more than five or ten students may return empty results with the current sample data.

## Conclusion
This project provides practical experience with MySQL database design, relational table management, and advanced SQL queries. It demonstrates how structured academic data can be stored, connected, and analyzed efficiently.
# SQL-PR.-Final-Project
