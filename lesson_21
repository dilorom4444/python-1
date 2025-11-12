CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);
INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 148.00, 2, 101),
(2, 'Product B', '2023-01-02', 202.00, 3, 102),
(3, 'Product C', '2023-01-03', 248.00, 1, 103),
(4, 'Product A', '2023-01-04', 149.50, 4, 101),
(5, 'Product B', '2023-01-05', 203.00, 5, 104),
(6, 'Product C', '2023-01-06', 252.00, 2, 105),
(7, 'Product A', '2023-01-07', 151.00, 1, 101),
(8, 'Product B', '2023-01-08', 205.00, 8, 102),
(9, 'Product C', '2023-01-09', 253.00, 7, 106),
(10, 'Product A', '2023-01-10', 152.00, 2, 107),
(11, 'Product B', '2023-01-11', 207.00, 3, 108),
(12, 'Product C', '2023-01-12', 249.00, 1, 109),
(13, 'Product A', '2023-01-13', 153.00, 4, 110),
(14, 'Product B', '2023-01-14', 208.50, 5, 111),
(15, 'Product C', '2023-01-15', 251.00, 2, 112),
(16, 'Product A', '2023-01-16', 154.00, 1, 113),
(17, 'Product B', '2023-01-17', 210.00, 8, 114),
(18, 'Product C', '2023-01-18', 254.00, 7, 115),
(19, 'Product A', '2023-01-19', 155.00, 3, 116),
(20, 'Product B', '2023-01-20', 211.00, 4, 117),
(21, 'Product C', '2023-01-21', 256.00, 2, 118),
(22, 'Product A', '2023-01-22', 157.00, 5, 119),
(23, 'Product B', '2023-01-23', 213.00, 3, 120),
(24, 'Product C', '2023-01-24', 255.00, 1, 121),
(25, 'Product A', '2023-01-25', 158.00, 6, 122),
(26, 'Product B', '2023-01-26', 215.00, 7, 123),
(27, 'Product C', '2023-01-27', 257.00, 3, 124),
(28, 'Product A', '2023-01-28', 159.50, 4, 125),
(29, 'Product B', '2023-01-29', 218.00, 5, 126),
(30, 'Product C', '2023-01-30', 258.00, 2, 127);

-- 1. Assign a row number to each sale based on SaleDate
SELECT *, 
       ROW_NUMBER() OVER (ORDER BY SaleDate, SaleID) AS RowNum
FROM ProductSales;


-- 2. Rank products based on total quantity sold (same rank for same amounts, no gaps)
SELECT ProductName, 
       SUM(Quantity) AS TotalQuantity,
       RANK() OVER (ORDER BY SUM(Quantity) DESC) AS RankQty
FROM ProductSales
GROUP BY ProductName;


-- 3. Identify the top sale for each customer based on SaleAmount
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS t
WHERE rn = 1;


-- 4. Display each sale's amount along with the next sale amount in order of SaleDate
SELECT SaleID, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate, SaleID) AS NextSaleAmount
FROM ProductSales;


-- 5. Display each sale's amount along with the previous sale amount in order of SaleDate
SELECT SaleID, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate, SaleID) AS PrevSaleAmount
FROM ProductSales;


-- 6. Identify sales amounts greater than the previous sale's amount
SELECT SaleID, SaleAmount
FROM (
    SELECT SaleID, SaleAmount,
           LAG(SaleAmount) OVER (ORDER BY SaleDate, SaleID) AS PrevSale
    FROM ProductSales
) AS t
WHERE SaleAmount > PrevSale;


-- 7. Difference in sale amount from the previous sale for every product
SELECT SaleID, ProductName, SaleAmount,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate, SaleID) AS DiffFromPrev
FROM ProductSales;


-- 8. Compare the current sale amount with the next sale amount in percentage change
SELECT SaleID, ProductName, SaleAmount,
       ROUND((LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate, SaleID) - SaleAmount) * 100.0 / SaleAmount, 2) AS PctChangeToNext
FROM ProductSales;


-- 9. Ratio of current sale amount to previous sale amount within the same product
SELECT SaleID, ProductName, SaleAmount,
       CASE WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate, SaleID) = 0 THEN NULL
            ELSE CAST(SaleAmount AS DECIMAL(10,2)) / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate, SaleID)
       END AS RatioToPrev
FROM ProductSales;


-- 10. Difference in sale amount from the very first sale of that product
SELECT SaleID, ProductName, SaleAmount,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate, SaleID) AS DiffFromFirst
FROM ProductSales;


-- 11. Sales that have been increasing continuously for a product
SELECT SaleID, ProductName, SaleAmount
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate, SaleID) AS PrevSale
    FROM ProductSales
) AS t
WHERE SaleAmount > PrevSale;


-- 12. Calculate a "closing balance" (running total) for sales amounts
SELECT SaleID, ProductName, SaleAmount,
       SUM(SaleAmount) OVER (ORDER BY SaleDate, SaleID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM ProductSales;


-- 13. Moving average of sales amounts over the last 3 sales
SELECT SaleID, ProductName, SaleAmount,
       AVG(SaleAmount) OVER (ORDER BY SaleDate, SaleID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg3
FROM ProductSales;

--14
CREATE TABLE Employees1 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees1 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');

SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DifferenceFromAvg
FROM ProductSales
ORDER BY SaleID;
--15
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary,
    DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees1
ORDER BY Department, Salary DESC;
--16
SELECT *
FROM (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
) AS Ranked
WHERE SalaryRank <= 2
ORDER BY Department, Salary DESC;
--17
SELECT *
FROM (
    SELECT *,
           RANK() OVER(PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
    FROM Employees1
) AS Ranked
WHERE SalaryRank = 1;
--18
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER(PARTITION BY Department ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Employees1
ORDER BY Department, HireDate;
--19
SELECT DISTINCT
    Department,
    SUM(Salary) OVER(PARTITION BY Department) AS TotalSalary
FROM Employees1;
--20
SELECT DISTINCT
    Department,
    AVG(Salary) OVER(PARTITION BY Department) AS AvgSalary
FROM Employees1;
--21
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    Salary - AVG(Salary) OVER(PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1
ORDER BY Department, EmployeeID;
--22
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER(
        PARTITION BY Department 
        ORDER BY HireDate 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM Employees1
ORDER BY Department, HireDate;
--23
SELECT SUM(Salary) AS Last3HiredTotal
FROM (
    SELECT Salary
    FROM Employees1
    ORDER BY HireDate DESC
    OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) AS Last3;
