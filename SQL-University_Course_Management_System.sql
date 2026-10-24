
CREATE DATABASE IF NOT EXISTS UniversityCourseManagement;
USE UniversityCourseManagement;

-- Drop tables in child-to-parent order so the script can be rerun.
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Instructors;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;

-- 1. Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- 2. Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    BirthDate DATE,
    EnrollmentDate DATE NOT NULL
);

-- 3. Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    Credits INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 4. Instructors Table
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    DepartmentID INT NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 5. Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

INSERT INTO Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);

INSERT INTO Instructors
(InstructorID, FirstName, LastName, Email, DepartmentID, Salary) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 65000.00),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 60000.00);

INSERT INTO Enrollments
(EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');


SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Instructors;
SELECT * FROM Enrollments;
SELECT * FROM Departments;





SELECT *
FROM Students
WHERE EnrollmentDate >= '2023-01-01';

-- QUERY 3: Retrieve courses offered by the Mathematics department, limit 5 courses.
SELECT c.CourseID, c.CourseName, c.DepartmentID, c.Credits
FROM Courses AS c
INNER JOIN Departments AS d ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;


SELECT c.CourseID, c.CourseName, COUNT(DISTINCT e.StudentID) AS StudentCount
FROM Courses AS c
LEFT JOIN Enrollments AS e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(DISTINCT e.StudentID) > 5;


SELECT s.StudentID, s.FirstName, s.LastName
FROM Students AS s
JOIN Enrollments AS e ON s.StudentID = e.StudentID
JOIN Courses AS c ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2;

SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students AS s
JOIN Enrollments AS e ON s.StudentID = e.StudentID
JOIN Courses AS c ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');

-- QUERY 7: Calculate the average credits for all courses.
SELECT AVG(Credits) AS AverageCredits
FROM Courses;

.
SELECT MAX(i.Salary) AS MaximumSalary
FROM Instructors AS i
JOIN Departments AS d ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';
.
SELECT d.DepartmentID, d.DepartmentName,
       COUNT(DISTINCT e.StudentID) AS StudentCount
FROM Departments AS d
LEFT JOIN Courses AS c ON d.DepartmentID = c.DepartmentID
LEFT JOIN Enrollments AS e ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName;


SELECT s.StudentID, s.FirstName, s.LastName, c.CourseID, c.CourseName
FROM Students AS s
INNER JOIN Enrollments AS e ON s.StudentID = e.StudentID
INNER JOIN Courses AS c ON e.CourseID = c.CourseID;


SELECT s.StudentID, s.FirstName, s.LastName, c.CourseID, c.CourseName
FROM Students AS s
LEFT JOIN Enrollments AS e ON s.StudentID = e.StudentID
LEFT JOIN Courses AS c ON e.CourseID = c.CourseID;


SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students AS s
JOIN Enrollments AS e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(DISTINCT StudentID) > 10
);


SELECT StudentID, FirstName, LastName, YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;

.
SELECT InstructorID, CONCAT(FirstName, ' ', LastName) AS InstructorName
FROM Instructors;


SELECT c.CourseID, c.CourseName,
       COUNT(e.StudentID) AS CourseEnrollmentCount,
       SUM(COUNT(e.StudentID)) OVER (
           ORDER BY c.CourseID
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS RunningTotal
FROM Courses AS c
LEFT JOIN Enrollments AS e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;


SELECT StudentID, FirstName, LastName, EnrollmentDate,
       CASE
           WHEN EnrollmentDate < DATE_SUB(CURDATE(), INTERVAL 4 YEAR) THEN 'Senior'
           ELSE 'Junior'
       END AS StudentLevel
FROM Students;
