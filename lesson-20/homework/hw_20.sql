CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');
--1
SELECT DISTINCT CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND MONTH(s2.SaleDate) = 3
      AND YEAR(s2.SaleDate) = 2024
);

--2
SELECT Product
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT SUM(Quantity * Price) AS TotalRevenue
        FROM #Sales
        GROUP BY Product
    ) AS t
);

--3
SELECT MAX(Quantity * Price) AS SecondHighestSale
FROM #Sales
WHERE Quantity * Price < (
    SELECT MAX(Quantity * Price)
    FROM #Sales
);

--4
SELECT DISTINCT 
       YEAR(SaleDate) AS SaleYear,
       MONTH(SaleDate) AS SaleMonth,
       (SELECT SUM(Quantity)
        FROM #Sales s2
        WHERE YEAR(s2.SaleDate) = YEAR(s1.SaleDate)
          AND MONTH(s2.SaleDate) = MONTH(s1.SaleDate)
       ) AS TotalQuantity
FROM #Sales s1
ORDER BY SaleYear, SaleMonth;

--5
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.Product = s1.Product
      AND s2.CustomerName <> s1.CustomerName
);

--6
create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')
							SELECT
    Name,
    SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name
ORDER BY Name;

--7
create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)
WITH RecursiveFamily AS (
    -- Base case: direct parent-child relationships
    SELECT ParentId AS PID, ChildID AS CHID
    FROM Family

    UNION ALL

    -- Recursive step: find further descendants
    SELECT rf.PID, f.ChildID
    FROM RecursiveFamily rf
    JOIN Family f ON rf.CHID = f.ParentId
)
SELECT *
FROM RecursiveFamily
ORDER BY PID, CHID;

--8
CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

SELECT *
FROM #Orders o1
WHERE o1.DeliveryState = 'TX'
  AND EXISTS (
        SELECT 1
        FROM #Orders o2
        WHERE o2.CustomerID = o1.CustomerID
          AND o2.DeliveryState = 'CA'
  );
  --9
  create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')

-- Update address to include name if missing
UPDATE #residents
SET address = CONCAT(address, ' name=', fullname)
WHERE CHARINDEX('name=', address) = 0;

-- Check the result
SELECT * FROM #residents;

--10
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

WITH RecursiveRoutes AS (
    -- Anchor member: start from Tashkent
    SELECT 
        CAST(DepartureCity AS VARCHAR(MAX)) AS Route,
        ArrivalCity,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    
    UNION ALL
    
    -- Recursive member: extend the route
    SELECT 
        rr.Route + ' - ' + r.ArrivalCity,
        r.ArrivalCity,
        rr.Cost + r.Cost
    FROM RecursiveRoutes rr
    JOIN #Routes r
        ON rr.ArrivalCity = r.DepartureCity
    WHERE CHARINDEX(r.ArrivalCity, rr.Route) = 0 -- avoid cycles
)
SELECT Route, Cost
FROM RecursiveRoutes
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost;
--12
SELECT e.EmployeeID, e.EmployeeName, e.Department, e.SalesAmount
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);


SELECT e.EmployeeID, e.EmployeeName, e.Department, e.SalesAmount, e.SalesMonth, e.SalesYear
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.SalesMonth = e.SalesMonth
      AND e2.SalesYear = e.SalesYear
    GROUP BY e2.SalesMonth, e2.SalesYear
    HAVING MAX(e2.SalesAmount) = e.SalesAmount
);


SELECT DISTINCT e.EmployeeID, e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM (SELECT DISTINCT SalesMonth, SalesYear FROM #EmployeeSales) m
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales s
        WHERE s.EmployeeID = e.EmployeeID
          AND s.SalesMonth = m.SalesMonth
          AND s.SalesYear = m.SalesYear
    )
);


SELECT Name, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);


SELECT Name, Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);


SELECT Name, Category
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');


SELECT Name, Price
FROM Products
WHERE Price > (SELECT MIN(Price) FROM Products WHERE Category = 'Electronics');


SELECT p1.Name, p1.Category, p1.Price
FROM Products p1
WHERE Price > (
    SELECT AVG(p2.Price)
    FROM Products p2
    WHERE p2.Category = p1.Category
);


SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;


SELECT p.Name, SUM(o.Quantity) AS TotalOrdered
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders);


SELECT Name
FROM Products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM Orders);


SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY SUM(o.Quantity) DESC;
