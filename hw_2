--1
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);
--2
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'anvar', 300.00);

--3
UPDATE Employees
SET Salary = 400
WHERE EmpID = 1;
--4
DELETE FROM Employees
WHERE EmpID = 2;
--5
| Command      | Action                              | Structure kept? | Rollback possible?  |
| ------------ | ----------------------------------- | --------------- | ------------------- |
| **DELETE**   | Removes specific rows using `WHERE` | ✅ Yes           | ✅ Yes               |
| **TRUNCATE** | Removes *all* rows                  | ✅ Yes           | ⚠️ No (in most DBs) |
| **DROP**     | Removes the *entire table*          | ❌ No            | ⚠️ No               |
--6
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);
--7
ALTER TABLE Employees
ADD dep VARCHAR(50);
--8
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;
--9
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
--10
TRUNCATE TABLE Employees;
--11
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION ALL
SELECT 2, 'Finance' UNION ALL
SELECT 3, 'IT' UNION ALL
SELECT 4, 'Marketing' UNION ALL
SELECT 5, 'Sales';
--12
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;
--13
TRUNCATE TABLE Employees;

--14
ALTER TABLE Employees
DROP COLUMN Department;

--15
EXEC sp_rename 'Employees', 'StaffMembers';

--16
DROP TABLE Departments;

--17
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Description VARCHAR(255)
);

--18
ALTER TABLE Products
ADD CONSTRAINT chk_Price_Positive CHECK (Price > 0);
--19
ALTER TABLE Products
ADD CONSTRAINT chk_Price_Positive CHECK (Price > 0);
--20
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';
--21
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES
(1, 'Laptop', 'Electronics', 1200.00, '15-inch display'),
(2, 'Mouse', 'Electronics', 25.00, 'Wireless optical mouse'),
(3, 'Desk Chair', 'Furniture', 150.00, 'Ergonomic office chair'),
(4, 'Notebook', 'Stationery', 3.50, 'A5 lined notebook'),
(5, 'Water Bottle', 'Accessories', 10.00, 'Reusable stainless steel bottle');
--22
SELECT *
INTO Products_Backup
FROM Products;

--23
EXEC sp_rename 'Products', 'Inventory';
--24
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;
-25
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5);
