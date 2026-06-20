CREATE DATABASE sales_datadb;

USE sales_datadb;

CREATE TABLE sales_data (
    transaction_id INT PRIMARY KEY,
    employee_id INT,
    month VARCHAR(7),
    sales_amount DECIMAL(10, 2)
);

INSERT INTO
    sales_data (
        transaction_id,
        employee_id,
        month,
        sales_amount
    )
VALUES (1, 101, '2024-01', 500.00),
    (2, 102, '2024-01', 600.00),
    (3, 101, '2024-02', 450.00),
    (4, 103, '2024-02', 700.00),
    (5, 102, '2024-02', 650.00),
    (6, 101, '2024-03', 550.00),
    (7, 103, '2024-03', 800.00),
    (8, 102, '2024-03', 700.00),
    (9, 104, '2024-03', 300.00);

SELECT * FROM sales_data;

-- Problem Statement
-- Write a query that Ranks the Sales amount in decending order from the sales_data table abnd assign a rank to each row.
SELECT *, RANK() OVER ( ORDER BY sales_amount DESC ) FROM sales_data;

SELECT *, RANK() OVER (
        ORDER BY sales_amount DESC
    ) as Rank_by_Sales_Amount
FROM sales_data;

-- If two row have same value then the rank will be same, here sales_amount of two row is same (700) and got the same ronk,  but the next rank number will be rejected,
-- Here two row got the rank 2 and rank 3 is not there, to get all the rank use "dense_rank()" function instead of rank()

SELECT *, DENSE_RANK() OVER (
        ORDER BY sales_amount DESC
    ) as Rank_by_Sales_Amount
FROM sales_data;

-- Problem Statement
-- Write a query that Ranks the sales_amount for each month (partition by month) in descending order from teh sales data table

SELECT *, RANK() OVER (
        PARTITION BY
            month
        ORDER BY sales_amount DESC
    ) as rk_partition_by_month
from sales_data;

SELECT employee_id, SUM(sales_amount) AS Total_Sales, RANK() OVER (
        ORDER BY SUM(sales_amount) DESC
    )
FROM sales_data
GROUP BY
    employee_id;

-- Write a query that calculates the running total of sales_amount for each employee, order by month from the sales data table
SELECT *, SUM(sales_amount) OVER (
        PARTITION BY
            employee_id
        ORDER BY month
    ) as sales_per_employee
FROM sales_data;

-- Problem Statement
-- Write a query that shows the previous month's sales_amount for each employee from the sales data table, using LAG() function
SELECT *, LAG(sales_amount) OVER (
        PARTITION BY
            employee_id
        ORDER BY month
    ) as previous_month
from sales_data;

SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (
        ORDER BY month
    ) AS previous_month_sales
FROM (
        SELECT month, SUM(sales_amount) AS total_sales
        FROM sales_data
        GROUP BY
            month
    ) AS monthly_sales;

SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (
        ORDER BY month
    ) AS previous_month_sales,
    ROUND(
        (
            (
                total_sales - LAG(total_sales) OVER (
                    ORDER BY month
                )
            ) / LAG(total_sales) OVER (
                ORDER BY month
            )
        ) * 100,
        2
    ) as growth_percentage
FROM (
        SELECT month, SUM(sales_amount) AS total_sales
        FROM sales_data
        GROUP BY
            month
    ) AS monthly_sales;

-- Problem Statement
-- Write a query that shows the next month's sales_amount for each employee from the sales data table, using LEAD() function

SELECT *, LEAD(sales_amount) OVER (
        PARTITION BY
            employee_id
        ORDER BY month
    ) as previous_month
from sales_data;

-- Stored Procedures

-- Problem Statement
-- Show all Sales

DELIMITER $$

CREATE PROCEDURE get_all_sales()

BEGIN 
    SELECT * from sales_data;
END $$

DELIMITER;

CALL get_all_sales ()

-- Droping the procedure
DROP PROCEDURE IF EXISTS get_all_sales;

DROP PROCEDURE get_all_sales;

-- for checking the status of the Procedures, where procedure exists or not
SHOW PROCEDURE STATUS WHERE Db = 'sales_datadb';

SHOW CREATE PROCEDURE get_all_sales;

-- Employee-wise Sales using parameter

DELIMITER $$

CREATE PROCEDURE get_employee_sales(in emp_id int)
BEGIN 
    SELECT * from sales_data WHERE employee_id = emp_id;
END $$

DELIMITER;

CALL get_employee_sales (101)

DROP PROCEDURE get_employee_sales;