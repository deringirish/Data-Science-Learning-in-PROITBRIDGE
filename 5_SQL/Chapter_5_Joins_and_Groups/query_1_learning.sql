-- USE sales_management_task;
USE sales_management_task;

-- Inner Join

SELECT customers.customerName, orders.orderNumber
FROM customers
    INNER JOIN orders ON customers.customerNumber = orders.customerNumber;

-- Left Join
SELECT customers.customerName, orders.orderNumber
FROM customers
    LEFT JOIN orders ON customers.customerNumber = orders.customerNumber;

-- Right Join
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO
    orders (
        orderNumber,
        orderDate,
        requiredDate,
        shippedDate,
        status,
        comments,
        customerNumber
    )
VALUES (
        10101,
        '2026-01-05',
        '2026-01-12',
        '2026-01-09',
        'Shipped',
        'Delivered on time',
        123
    ),
    (
        10102,
        '2026-01-10',
        '2026-01-17',
        '2026-01-15',
        'Shipped',
        'Fragile items',
        456
    ),
    (
        10103,
        '2026-02-01',
        '2026-02-08',
        NULL,
        'In Process',
        'Awaiting shipment',
        789
    );

SELECT customers.customerName, orders.orderNumber
FROM customers
    RIGHT JOIN orders ON customers.customerNumber = orders.customerNumber;

SET FOREIGN_KEY_CHECKS = 1;

-- Full Join
SELECT customers.customerName, orders.orderNumber
FROM customers
    LEFT JOIN orders ON customers.customerNumber = orders.customerNumber
UNION
SELECT customers.customerName, orders.orderNumber
FROM customers
    RIGHT JOIN orders ON customers.customerNumber = orders.customerNumber;

-- Self Join - for checking hierarchy
SELECT e.firstName as employee, m.firstName as managers
FROM employees e
    LEFT JOIN employees m on e.reportsTo = m.employeeNumber

SELECT e.firstName as employee, e.employeeNumber, e.reportsTo, m.firstName as managers, m.employeeNumber
FROM employees e
    LEFT JOIN employees m on e.reportsTo = m.employeeNumber

-- Cross Join 
SELECT 
    customers.customerName,
    products.productName
FROM customers
CROSS JOIN products;