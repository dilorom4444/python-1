1. Data refers to raw facts, figures, or information that can be recorded and processed by a computer. It can be in the form of text, numbers, images, audio, or video.
   A database is an organized collection of data that can be easily accessed, managed, and updated. It is designed to store large amounts of information efficiently.
   A relational database is a type of database that stores data in tables (also called relations), where each table consists of rows and columns. Relationships can be established between tables using keys.

Example:
A school database might have:

A Students table (ID, Name, Grade)

A Courses table (CourseID, Title)

A Registrations table linking students to courses

A table is a structure in a relational database that organizes data into rows (records) and columns (fields). Each row represents a single record, and each column represents a specific attribute

4)
create database SChoolDB
use schooldb
create table students(studentid int Primary key,
                       name varchar (50),
					   age int)
select * from students

SQL Server is the engine that runs databases.

SSMS is the tool you use to interact with SQL Server.

SQL is the language you use to talk to both.
7)
DQL – Data Query Language
common command
SELECT
ex: SELECT * FROM Students;

DML – Data Manipulation Language
Common Commands:
INSERT
UPDATE
DELETE

-- Insert a new student
INSERT INTO Students (StudentID, Name, Age)
VALUES (1, 'Alice', 20);

-- Update a student's age
UPDATE Students
SET Age = 21
WHERE StudentID = 1;

-- Delete a student
DELETE FROM Students
WHERE StudentID = 1;


DDL – Data Definition Language
Common Commands:
CREATE
ALTER
DROP
TRUNCATE

-- Create a new table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

-- Add a new column
ALTER TABLE Students
ADD Grade VARCHAR(5);

-- Delete the table
DROP TABLE Students;

DCL – Data Control Language

Common Commands:
GRANT
REVOKE
-- Grant SELECT permission to a user
GRANT SELECT ON Students TO user1;

-- Revoke permission
REVOKE SELECT ON Students FROM user1;

TCL – Transaction Control Language
Common Commands:
BEGIN TRANSACTION
COMMIT
ROLLBACK
SAVEPOINT

BEGIN TRANSACTION;

UPDATE Students
SET Age = 22
WHERE StudentID = 1;

-- If everything is fine
COMMIT;

-- If something goes wrong
-- ROLLBACK;

| Command Type | Purpose                    | Examples                          |
| ------------ | -------------------------- | --------------------------------- |
| **DQL**      | Query data                 | `SELECT`                          |
| **DML**      | Modify data                | `INSERT`, `UPDATE`, `DELETE`      |
| **DDL**      | Define or change structure | `CREATE`, `ALTER`, `DROP`         |
| **DCL**      | Control access             | `GRANT`, `REVOKE`                 |
| **TCL**      | Manage transactions        | `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

8)
DROP TABLE Students;
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
INSERT INTO Students (Name, Age)
VALUES 
('Alice', 20),
('Bob', 22),
('Charlie', 21);

select * from students






