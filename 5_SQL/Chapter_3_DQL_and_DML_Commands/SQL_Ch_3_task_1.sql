-- Using Data which is created in Chapter 2 - Task

USE sales_management_task;

-- 1. Display all Classic Cars whose buy price is greater than 50.
SELECT *
FROM products
WHERE
    productLine = "Classic Cars"
    and buyPrice > 50;

-- 2. List the top 10 products with the highest MSRP.
SELECT * FROM products ORDER BY MSRP DESC LIMIT 10;

-- 3. Display customers whose credit limit is greater than 60,000 and belong to USA.
SELECT *
FROM customers
WHERE
    creditLimit > 60000
    and country = "USA";

-- 4. Find all employees who work in Office Code 1 and have the job title Sales Rep.
SELECT *
FROM employees
WHERE
    officeCode = 1
    and jobTitle = "Sales Rep";

-- 5. Display all orders whose status is Shipped and were placed after 2004 -01 -01.
SELECT *
FROM orders
WHERE
    status = "Shipped"
    and orderDate > "2004-01-01";

-- 6. Display products whose quantity in stock is less than 1,000, ordered by quantity.
SELECT *
FROM products
WHERE
    quantityInStock < 1000
ORDER BY quantityInStock ASC;

-- 7. Update the credit limit of all customers from France to 10,000.
UPDATE customers SET creditLimit = 10000 WHERE country = "France";

SELECT * FROM customers WHERE country = "France";

-- 8. Increase the buy price of all products in the Motorcycles product line.
UPDATE products
SET
    buyPrice = buyPrice + (buyPrice * 0.2)
WHERE
    productLine = "Motorcycles";

SELECT * from products WHERE productLine = "Motorcycles";

-- 9. Delete all payment records with an amount less than 1, 000.
DELETE from payments where amount < 1000;

SELECT * FROM payments;

-- 10. Display the 5 cheapest products from the Planes product line.
SELECT *
FROM products
WHERE
    productLine = "Planes"
ORDER BY buyPrice ASC
LIMIT 5;

-- 11. Display all customers whose names start with the letter 'A'.
SELECT * FROM customers WHERE customerName LIKE "A%";

-- 12. Find all products supplied by Aero Model Co.
SELECT * FROM products WHERE productVendor = "Aero Model Co";

-- 13. Display the details of employees who report to employee number 1002.
SELECT * FROM employees WHERE reportsTo = 1002;

-- 14. List all offices located in the USA, ordered by city name.
SELECT * FROM offices WHERE country = "USA" ORDER BY city;

-- 15. Display the first 7 customers when sorted by their customer number.
SELECT * FROM customers ORDER BY customerNumber LIMIT 7;

-- 16. Update the city of office code 3 to a new city name.
UPDATE offices SET city = "Kolkata" WHERE officeCode = 3;

SELECT * from offices WHERE officeCode = 3;

-- 17. Update the quantity in stock of product code S24_2360 to 9000.
UPDATE products
set
    quantityInStock = 9000
WHERE
    productCode = "S24_2360";

SELECT * FROM products WHERE productCode = "S24_2360";

-- 18. Insert a new office record with valid office details.
INSERT INTO
    offices (
        officeCode,
        city,
        phone,
        addressLine1,
        addressLine2,
        state,
        country,
        postalCode,
        territory
    )
VALUES (
        8,
        'London',
        '+1 550 555 1234',
        'Church Street',
        'NULL',
        'CA',
        'UK',
        91105,
        'NA'
    );

SELECT * FROM offices;

-- 19. Display all products whose buy price is between 30 and 60, ordered by buy price in descending order.
SELECT *
FROM products
WHERE
    buyPrice > 30
    and buyPrice < 60
ORDER BY buyPrice DESC;