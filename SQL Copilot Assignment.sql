-- Q1. Use Github Copilot to create a table SalesData whose columns are CustomerID, Name, Age, City,PurchaseAmount, PurchaseDate and then ask to insert 10,000 rows of random data.

-- Create Database (Optional)
CREATE DATABASE IF NOT EXISTS SalesDB;
USE SalesDB;

-- Drop table if it already exists
DROP TABLE IF EXISTS SalesData;

-- Create SalesData Table
CREATE TABLE SalesData (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50),
    PurchaseAmount DECIMAL(10,2),
    PurchaseDate DATE
);

-- Allow deeper recursion for 10,000 rows
SET SESSION cte_max_recursion_depth = 10000;

-- Insert 10,000 Random Records
WITH RECURSIVE Numbers AS
(
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < 10000
)

INSERT INTO SalesData
(CustomerID, Name, Age, City, PurchaseAmount, PurchaseDate)

SELECT
n,

CONCAT('Customer_', n),

FLOOR(18 + RAND() * 43),

ELT(
FLOOR(1 + RAND() * 10),
'New York',
'Los Angeles',
'Chicago',
'Houston',
'Phoenix',
'Dallas',
'Seattle',
'Miami',
'Boston',
'San Francisco'
),

ROUND(100 + RAND() * 4900, 2),

DATE_ADD('2023-01-01',
INTERVAL FLOOR(RAND() * 730) DAY)

FROM Numbers;

-- Verify
SELECT COUNT(*) AS TotalRows
FROM SalesData;

-- View Sample Data
SELECT *
FROM SalesData
LIMIT 20;

-- Question 2 : Use Copilot to:
-- Find total sales per city
-- Top 5 cities by revenue

SELECT
    City,
    SUM(PurchaseAmount) AS TotalSales
FROM SalesData
GROUP BY City
ORDER BY TotalSales DESC;


SELECT
    City,
    SUM(PurchaseAmount) AS TotalRevenue
FROM SalesData
GROUP BY City
ORDER BY TotalRevenue DESC
LIMIT 5;


-- Question 3 : Ask Copilot:
-- Find customers with purchases above average

SELECT
    CustomerID,
    Name,
    Age,
    City,
    PurchaseAmount,
    PurchaseDate
FROM SalesData
WHERE PurchaseAmount > (
    SELECT AVG(PurchaseAmount)
    FROM SalesData
)
ORDER BY PurchaseAmount DESC;