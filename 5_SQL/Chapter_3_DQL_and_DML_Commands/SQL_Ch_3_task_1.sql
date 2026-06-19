USE sales_management_task;

-- Display all Classic Cars whose buy price is greater than 50.
SELECT * FROM products WHERE buyPrice > 50;

-- List the top 10 products with the highest MSRP.
SELECT * FROM products ORDER BY MSRP DESC LIMIT 10;

-- Display customers whose credit limit is greater than 60,000 and belong to USA.
SELECT *
FROM customers
WHERE
    creditLimit > 60000
    and country = "USA";

-- Find all employees who work in Office Code 1 and have the job title Sales Rep.
SELECT *
FROM employees
WHERE
    officeCode = 1
    and jobTitle = "Sales Rep";

-- Display all orders whose status is Shipped and were placed after 2004 -01 -01.
SELECT *
FROM orders
WHERE
    status = "Shipped"
    and orderDate > "2004-01-01";

-- Display products whose quantity in stock is less than 1,000, ordered by quantity.
SELECT *
FROM products
WHERE
    quantityInStock < 1000
ORDER BY quantityInStock DESC;

-- Update the credit limit of all customers from France to 100, 000.
UPDATE customers SET creditLimit = 10000 WHERE country = "France";

SELECT * FROM customers WHERE country = "France";

-- Increase the buy price of all products in the Motorcycles product line.
UPDATE products
SET
    buyPrice = buyPrice + (buyPrice * 0.2)
WHERE
    productLine = "Motorcycles";

SELECT * from products WHERE productLine = "Motorcycles";

-- Delete all payment records with an amount less than 1, 000.
DELETE from payments where amount < 1000;

SELECT * FROM payments;

-- Display the 5 cheapest products from the Planes product line.
SELECT *
FROM products
WHERE
    productLine = "Planes"
ORDER BY MSRP ASC
LIMIT 5;

-- Display all customers whose names start with the letter 'A'.
SELECT * FROM customers WHERE customerName LIKE "A%";

-- Find all products supplied by Aero Model Co.
SELECT * FROM products WHERE productVendor = "Aero Model Co";

-- Display the details of employees who report to employee number 1002.
SELECT * FROM employees WHERE reportsTo = 1002;

-- List all offices located in the USA, ordered by city name.
SELECT * FROM offices WHERE country = "USA" ORDER BY city;

-- Display the first 7 customers when sorted by their customer number.
SELECT * FROM customers ORDER BY customerNumber LIMIT 7;

-- Update the city of office code 3 to a new city name.
UPDATE offices SET city = "Kolkata" WHERE officeCode = 3;

SELECT * from offices WHERE officeCode = 3;

-- Update the quantity in stock of product code S10_1949 to 9000.
UPDATE products
set
    quantityInStock = 9000
WHERE
    productCode = "S24_2360";

SELECT * FROM products WHERE productCode = "S24_2360";

-- Insert a new office record with valid office details.
INSERT INTO
    offices
VALUES (
        8,
        'London',
        '+1 550 555 1234',
        'Church Street',
        ' ',
        'CA',
        'UK',
        91105,
        'NA'
    )

SELECT * FROM offices;

-- Display all products whose buy price is between 30 and 60, ordered by buy price in descending order.
SELECT * FROM products WHERE buyPrice > 30 and buyPrice < 60 ORDER BY buyPrice DESC;