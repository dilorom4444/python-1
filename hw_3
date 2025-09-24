--1
Bulk insert - import large amount of data quickly from a text file (.csv, .txt)
The purpose of BULK INSERT is to efficiently load massive datasets into a table with minimal overhead,
which is much faster than inserting rows one at a time using INSERT INTO.

--2
CSV (Comma-Separated Values)

TXT (Plain Text)

XML (Extensible Markup Language)

JSON (JavaScript Object Notation)

--3
create table products (
    productID INT PRIMARY KEY,
    productName VARCHAR(50),
    price DECIMAL(10, 2)
)

select *from products
--4
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
    (2, 'apple', 12.99),
    (4, 'orange', 14.50),
    (8, 'banana', 13.00);

--5
| Concept  | `NULL`                                                     | `NOT NULL`                                 |
| -------- | ---------------------------------------------------------- | ------------------------------------------ |
| Meaning  | Represents **missing or unknown** value                    | Specifies that a value **must be present** |
| Storage  | The column can store empty values                          | The column **must** have a value           |
| Default  | Columns are `NULL` by default (unless specified otherwise) | You must provide a value during `INSERT`   |
| Use case | Useful when data is optional                               | Used when data is required or critical     |

--6
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

ALTER TABLE Products
ADD UNIQUE (ProductName);

--8
alter table products
add categoryid int
 --9
 CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);
select * from categories
--10
IDENTITY property is used to create auto-incrementing primary keys,
similar to AUTO_INCREMENT in MySQL or SERIAL in PostgreSQL.
--11
select * from emails
 truncate table emails
 bulk insert emails
 from 'C:\Users\dilorom\Downloads\emails.txt'
 WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2            
);
--12
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

--13
| Feature          | PRIMARY KEY                            | UNIQUE KEY                     |
| ---------------- | -------------------------------------- | ------------------------------ |
| Null values      | Not allowed (automatically `NOT NULL`) | Allows **one** `NULL` value    |
| Uniqueness       | Must be unique                         | Must be unique                 |
| Number per table | Only one                               | Multiple allowed               |
| Purpose          | Entity identifier                      | Enforce uniqueness on a column |

--14
alter table products
add constraint CHK_products_price
check (price > 0)

--15
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

select * from products

--16
UPDATE Products
SET Price = ISNULL(Price, 0);

--17
A FOREIGN KEY enforces a relationship between two tables.

It ensures that values in the child table
must exist in the parent table

--18
select * from customers
create table customers ( cutomerID int Primary key,
                         name varchar (50) not null,
						 age int check (age >=18))
--19
create table teachers
(teacherid int identity (100,10) primary key,
teachername varchar (50) not null,
price decimal (10,2))
 drop table teachers

 --20
 CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
);
--21
ISNULL = SQL Server-specific, simpler. COALESCE = portable, more flexible.
--22
| Feature          | PRIMARY KEY         | UNIQUE KEY              |
| ---------------- | ------------------- | ----------------------- |
| Purpose          | Row identifier      | Enforce uniqueness      |
| Number per table | 1                   | Many                    |
| Allows NULL?     | ❌ No                | ✅ Yes (only 1 allowed)  |
| Index created    | Clustered (default) | Non-clustered (default) |

create table employees
(empid int primary key,
name varchar(50),
email varchar (60) Unique)

--23
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
