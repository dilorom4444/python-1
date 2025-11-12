create database hw_22
use hw_22

CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')

select * from sales_data
--1
SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS running_total
FROM sales_data
ORDER BY customer_id, order_date;
--2
SELECT
    product_category,
    COUNT(*) AS num_orders
FROM sales_data
GROUP BY product_category;
--3
SELECT
    product_category,
    MAX(total_amount) AS max_total
FROM sales_data
GROUP BY product_category;
--4
SELECT
    product_category,
    Min(unit_price) AS max_total
FROM sales_data
GROUP BY product_category;
--5
select order_date,
       total_amount,
	   avg(total_amount) 
	   over (order by order_date
	   rows between 1 preceding and 1 following)
	   as MovingAVG
from sales_data
order by order_date
--6
select region,
sum(total_amount) as total_sales
from sales_data
group by region
--7
select customer_name,
sum (total_amount) as total_purchase,
rank() over (order by sum(total_amount) desc) as customer_rank
from sales_data
group by customer_name
order by customer_rank
--8
select 
       customer_name,
	   order_date,
	   total_amount,
	   total_amount - lag(total_amount) over(partition by customer_name
	   order by order_date) as diff_from_prev
from sales_data
order by customer_name,order_date
--9
select product_category, product_name
from
(select*, ROW_NUMBER() over(partition by product_category
order by unit_price desc)as rn
from sales_data) as ranked_products
where rn <=3
order by product_category,rn
--10
SELECT
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY region
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;
--11
SELECT
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_revenue
FROM sales_data
ORDER BY product_category, order_date;
--12
SELECT
    ID,
    SUM(ID) OVER (
        ORDER BY ID
        ROWS UNBOUNDED PRECEDING
    ) AS SumPreValues
FROM numbers
ORDER BY ID;
--13
CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);
select* from OneColumn

SELECT
    Value,
    SUM(Value) OVER (
        ORDER BY Value
        ROWS UNBOUNDED PRECEDING
    ) AS [Sum of Previous]
FROM OneColumn;
--14
SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;
--15
SELECT *
FROM (
    SELECT 
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS total_spent,
        AVG(SUM(total_amount)) OVER (PARTITION BY region) AS avg_region_spent
    FROM sales_data
    GROUP BY customer_id, customer_name, region
) AS t
WHERE total_spent > avg_region_spent;
--16
SELECT 
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS total_spent,
    RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS region_rank
FROM sales_data
GROUP BY customer_id, customer_name, region
ORDER BY region, region_rank;
--17
SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;
--18
SELECT
    FORMAT(order_date, 'yyyy-MM') AS month,
    SUM(total_amount) AS monthly_sales,
    LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')) AS prev_month_sales,
    ROUND(
        ( (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM'))) 
        / NULLIF(LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')), 0) ) * 100, 2
    ) AS growth_rate
FROM sales_data
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY month;

--19
SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date)
ORDER BY customer_id, order_date;
--20
SELECT 
    product_name,
    product_category,
    unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);
--21
CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);
select * from MyData
--22
SELECT
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
    END AS Tot
FROM MyData
ORDER BY Grp, Id;
--23

CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 
WITH SeatCTE AS (
    SELECT 
        SeatNumber,
        LAG(SeatNumber) OVER (ORDER BY SeatNumber) AS PrevSeat
    FROM Seats
)
SELECT 
    PrevSeat + 1 AS [Gap Start],
    SeatNumber - 1 AS [Gap End]
FROM SeatCTE
WHERE SeatNumber - PrevSeat > 1
UNION ALL
-- Handle gap before first seat
SELECT 1 AS [Gap Start], MIN(SeatNumber) - 1 AS [Gap End]
FROM Seats
WHERE MIN(SeatNumber) > 1
UNION ALL
-- Handle gap after last seat (optional)
SELECT MAX(SeatNumber) + 1, NULL
FROM Seats
ORDER BY [Gap Start];
