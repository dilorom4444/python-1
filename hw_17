DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);
select * from #RegionSales
-- produce every Region x Distributor combination, then left-join actual sales
--1
SELECT
  r.Region,
  d.Distributor,
  COALESCE(s.Sales, 0) AS Sales
FROM
  (SELECT DISTINCT Region FROM #RegionSales) AS r
CROSS JOIN
  (SELECT DISTINCT Distributor FROM #RegionSales) AS d
LEFT JOIN
  #RegionSales AS s
  ON s.Region = r.Region
  AND s.Distributor = d.Distributor
ORDER BY
  r.Region,
  d.Distributor;
  --2
  CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

select * from Employee

--SELECT m.name AS ManagerName, e.name AS EmployeeName
--FROM Employee e
--JOIN Employee m ON e.managerId = m.id;

SELECT 
    m.id,
    m.name,
    COUNT(e.id) AS DirectReports
FROM Employee m
JOIN Employee e
    ON m.id = e.managerId
GROUP BY m.id, m.name;
--3
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);
select * from products 
select * from Orders
select
    p.product_name,
	sum(o.unit) as Unit
from products p
join Orders o
ON p.product_id=o.product_id
where o.order_date >= '2020-02-01'
and o.order_date < '2020-03-01'
group by p.product_name
having sum(o.unit) >=100
--4
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');
select * from Orders

SELECT 
    CustomerID,
    Vendor
FROM (
    SELECT 
        CustomerID,
        Vendor,
        SUM([Count]) AS TotalOrders,
        RANK() OVER (PARTITION BY CustomerID ORDER BY SUM([Count]) DESC) AS rnk
    FROM Orders
    GROUP BY CustomerID, Vendor
) AS RankedVendors
WHERE rnk = 1;

--5
DECLARE @Check_Prime INT = 91;
-- Your WHILE-based SQL logic here
DECLARE @Check_Prime INT = 91;  -- You can change this value
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;  -- 1 means "prime", 0 means "not prime"

-- Numbers less than 2 are not prime
IF @Check_Prime < 2
    SET @isPrime = 0;
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;  -- No need to continue
        END
        SET @i = @i + 1;
    END
END

-- Output the result
IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';
--6
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');
select * from Device
go
WITH LocationCounts AS (
    SELECT
        Device_id,
        Locations,
        COUNT(*) AS signals_per_location
    FROM Device
    GROUP BY Device_id, Locations
),
Aggregates AS (
    SELECT
        Device_id,
        COUNT(*) AS no_of_location,
        MAX(signals_per_location) AS max_signals
    FROM LocationCounts
    GROUP BY Device_id
)
SELECT
    a.Device_id,
    a.no_of_location,
    l.Locations AS max_signal_location,
    SUM(l.signals_per_location) AS no_of_signals
FROM Aggregates a
JOIN LocationCounts l 
    ON a.Device_id = l.Device_id
    AND l.signals_per_location = a.max_signals
GROUP BY a.Device_id, a.no_of_location, l.Locations;

--7
drop table Employee
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

select * from Employee
--employe that erns more then avg in their dep

SELECT EmpID, EmpName, Salary
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);
--8

| Ticket ID | Number |
|-----------|--------|
| A23423    | 25     |
| A23423    | 45     |
| A23423    | 78     |
| B35643    | 25     |
| B35643    | 45     |
| B35643    | 98     |
| C98787    | 67     |
| C98787    | 86     |
| C98787    | 91     |

-- Step 1: Create the table
CREATE TABLE Numbers (
    Number INT
);

-- Step 2: Insert values into the table
INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);


-- Step 1: Create the Tickets table
CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);

-- Step 2: Insert the data into the table
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);
WITH TicketMatches AS (
    SELECT 
        t.TicketID,
        COUNT(*) AS match_count
    FROM Tickets t
    JOIN Numbers n
        ON t.Number = n.Number
    GROUP BY t.TicketID)
select * from ticketmatches
, WinningCount AS (
    SELECT COUNT(*) AS total_winning_numbers
    FROM Numbers
)
--select * from WINNINGCOUNT
SELECT 
    tm.TicketID,
    CASE
        WHEN tm.match_count = wc.total_winning_numbers THEN 100
        WHEN tm.match_count > 0 AND tm.match_count < wc.total_winning_numbers THEN 10
        ELSE 0
    END AS Winnings
FROM TicketMatches tm
CROSS JOIN WinningCount wc;

select * from numbers
select * from tickets
--9
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

select * from spending
-- Step 1: Platform-wise totals
WITH PlatformTotals AS (
    SELECT
        Spend_date,
        Platform,
        SUM(Amount) AS Total_Amount,
        COUNT(DISTINCT User_id) AS Total_users
    FROM Spending
    GROUP BY Spend_date, Platform
),
-- Step 2: Totals for both platforms combined
BothTotals AS (
    SELECT
        Spend_date,
        'Both' AS Platform,
        SUM(Amount) AS Total_Amount,
        COUNT(DISTINCT User_id) AS Total_users
    FROM Spending
    GROUP BY Spend_date
)
-- Step 3: Combine the results
SELECT * 
FROM PlatformTotals
UNION ALL
SELECT * 
FROM BothTotals
ORDER BY Spend_date, Platform;

--10
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);


SELECT g.Product, 1 AS Quantity
FROM Grouped g
CROSS APPLY STRING_SPLIT(REPLICATE('1,', g.Quantity), ',')
WHERE value <> '';
