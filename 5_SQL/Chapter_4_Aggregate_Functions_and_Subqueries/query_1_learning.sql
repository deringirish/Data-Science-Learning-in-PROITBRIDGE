-- Aggregate Functions and Sub Queries

use sales_management;

SELECT COUNT(*) FROM products;

SELECT COUNT(*) as "Total Product" FROM products;

SELECT SUM(amount) as "Total Amount" FROM payments;

SELECT AVG(buyPrice) as "Average price" FROM products;

SELECT MIN(buyPrice) as "Min Price" FROM products;

SELECT MAX(buyPrice) as "Max Price" FROM products;

SELECT MIN(buyPrice) as "Min Price", MAX(buyPrice) as "Max Price"
from products;

-- Aggregate Functions using where
SELECT COUNT(*) as Order_2024
from orders
WHERE
    year(orderDate) = 2026;

SELECT sum(amount) as Total_Paid
from payments
WHERE
    customerNumber = 2001;

-- Aggregate Functions using groupby
SELECT productLine, COUNT(*) as Total_Count, AVG(buyPrice)
FROM products
GROUP BY
    productLine;

insert into
    customers (
        customerNumber,
        customerName,
        contactLastName,
        contactFirstName,
        phone,
        addressLine1,
        addressLine2,
        city,
        state,
        postalCode,
        country,
        salesRepEmployeeNumber,
        creditLimit
    )
values (
        2013,
        'Shazham Trader',
        'Sham',
        'Shaz',
        '+91-98765432234',
        'Sham Nagar',
        NULL,
        'Comimbatore',
        'Tamil Nadu',
        '600040',
        'India',
        1056,
        150000
    )

SELECT
    state,
    COUNT(*) as State_Count,
    city,
    COUNT(*) as City_Count
from customers
GROUP BY
    state,
    city;

SELECT
    state,
    COUNT(*) OVER (
        PARTITION BY
            state
    ) as Total_In_State,
    city,
    COUNT(*) OVER (
        PARTITION BY
            city
    ) as Total_In_City
FROM customers;

SELECT customerNumber, sum(amount) as Total_Paid
from payments
GROUP BY
    customerNumber;

SELECT customerNumber, sum(amount) as Total_Paid
from payments
GROUP BY
    customerNumber
HAVING
    Total_Paid > 10000;

-- SubQueries

SELECT customerNumber, amount
from payments
WHERE
    amount = (
        SELECT
        MAX(amount)
        from payments
    )

SELECT customerNumber, amount as Min_Amount
from payments 
WHERE amount = (
    SELECT MIN(amount) from payments
)

SELECT customerName
from customers 
WHERE customerNumber in (
    SELECT `customerNumber` from orders
)
 
SELECT customerName
from customers 
WHERE customerNumber in (
    SELECT `customerNumber` from orders where `orderNumber`  in (
        SELECT `orderNumber` from orderdetails WHERE `quantityOrdered` > 1
    )
)