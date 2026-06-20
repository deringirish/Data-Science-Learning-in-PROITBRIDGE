-- Using Data which is created in Chapter 2 - Task

USE sales_management_task;

-- Task 1 – Aggregate Functions
-- Find the total number of customers available in the database.
SELECT COUNT(*) as Total_Customers FROM customers;

-- Find the average buy price of all products.
SELECT AVG(buyPrice) as Avg_Buying_Price from products

-- Find the highest payment amount made by any customer.
SELECT MAX(amount) as Highest_Payment_Amount from payments

-- Task 2 – Aggregate Functions with WHERE
-- Find the total number of products in the Classic Cars product line.
SELECT COUNT(*) as Total_Classic_Car
from products
WHERE
    productLine = "Classic Cars";

-- Find the average credit limit of customers from the USA.
SELECT AVG(creditLimit) as AVerage_Credit_Limit
from customers
WHERE
    country = "USA";

-- Find the total payment amount made by customer number 103.
SELECT SUM(amount) as Total_Payment
from payments
WHERE
    customerNumber = 103

-- Task 3 – Aggregate Functions with GROUP BY
-- Display the total number of products in each product line.
SELECT productLine, COUNT(*) FROM products GROUP BY productLine;

-- Display the average buy price of products for each product line.
SELECT productLine, AVG(buyPrice) from products GROUP BY productLine;

-- Display the total payment amount made by each customer.
SELECT customerNumber, SUM(amount) from payments GROUP BY customerNumber; 


-- Task 4 – Subqueries
-- Display the details of all products whose buy price is greater than the average buy price of all products.
SELECT AVG(buyPrice) from products;
SELECT * from products WHERE buyPrice > (SELECT AVG(buyPrice) from products) ORDER BY buyPrice;