# Chapter 4 - Aggregate Functions and Subqueries


- Logical Operator = Aggregate Functions



| Function           | Description                                                                     |
| ------------------ | ------------------------------------------------------------------------------- |
| **COUNT()**        | Returns the total number of rows or non-NULL values in a column.                |
| **SUM()**          | Returns the sum of numeric values in a column.                                  |
| **AVG()**          | Returns the average (mean) of numeric values.                                   |
| **MIN()**          | Returns the smallest value in a column.                                         |
| **MAX()**          | Returns the largest value in a column.                                          |
| **GROUP_CONCAT()** | Concatenates multiple values into a single string, separated by commas (MySQL). |
| **VARIANCE()**     | Returns the population variance of numeric values.                              |
| **VAR_POP()**      | Returns the population variance (equivalent to `VARIANCE()`).                   |
| **VAR_SAMP()**     | Returns the sample variance of numeric values.                                  |
| **STD()**          | Returns the population standard deviation (alias for `STDDEV_POP()`).           |
| **STDDEV()**       | Returns the population standard deviation (alias for `STDDEV_POP()`).           |
| **STDDEV_POP()**   | Returns the population standard deviation.                                      |
| **STDDEV_SAMP()**  | Returns the sample standard deviation.                                          |




# SQL Notes: Aggregate Functions, GROUP BY, HAVING & Subqueries

## Database Used

```sql
USE sales_management;
```

---

# 1. Aggregate Functions

Aggregate functions perform calculations on multiple rows and return a single value.

| Function  | Purpose             |
| --------- | ------------------- |
| `COUNT()` | Counts rows         |
| `SUM()`   | Adds values         |
| `AVG()`   | Finds average       |
| `MIN()`   | Finds minimum value |
| `MAX()`   | Finds maximum value |

---

## COUNT()

### Count all products

```sql
SELECT COUNT(*) FROM products;
```

**Output**

```
110
```

---

### Using Alias

```sql
SELECT COUNT(*) AS "Total Product"
FROM products;
```

**Output**

| Total Product |
| ------------- |
| 110           |

---

## SUM()

Find total amount paid by all customers.

```sql
SELECT SUM(amount) AS "Total Amount"
FROM payments;
```

---

## AVG()

Find average buying price.

```sql
SELECT AVG(buyPrice) AS "Average Price"
FROM products;
```

---

## MIN()

Find lowest product price.

```sql
SELECT MIN(buyPrice) AS "Min Price"
FROM products;
```

---

## MAX()

Find highest product price.

```sql
SELECT MAX(buyPrice) AS "Max Price"
FROM products;
```

---

## Multiple Aggregate Functions

```sql
SELECT
    MIN(buyPrice) AS "Min Price",
    MAX(buyPrice) AS "Max Price"
FROM products;
```

---

# 2. Aggregate Functions with WHERE

`WHERE` filters rows **before** aggregation.

### Example

```sql
SELECT COUNT(*) AS Order_2026
FROM orders
WHERE YEAR(orderDate) = 2026;
```

### Execution Order

```
FROM orders
      ↓
WHERE YEAR(orderDate)=2026
      ↓
COUNT(*)
      ↓
SELECT
```

---

### Total amount paid by customer 2001

```sql
SELECT SUM(amount) AS Total_Paid
FROM payments
WHERE customerNumber = 2001;
```

---

# 3. GROUP BY

`GROUP BY` groups similar rows together.

### Example

```sql
SELECT
    productLine,
    COUNT(*) AS Total_Count,
    AVG(buyPrice)
FROM products
GROUP BY productLine;
```

Suppose the data is:

| productLine | buyPrice |
| ----------- | -------- |
| Cars        | 100      |
| Cars        | 200      |
| Bikes       | 50       |
| Bikes       | 150      |

After grouping:

| productLine | Count | Avg Price |
| ----------- | ----- | --------- |
| Cars        | 2     | 150       |
| Bikes       | 2     | 100       |

---

# 4. INSERT Statement

Adding a new customer.

```sql
INSERT INTO customers(
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
VALUES(
    2013,
    'Shazham Trader',
    'Sham',
    'Shaz',
    '+91-98765432234',
    'Sham Nagar',
    NULL,
    'Coimbatore',
    'Tamil Nadu',
    '600040',
    'India',
    1056,
    150000
);
```

> **Note:** There is a typo in your query: `"Comimbatore"` should be `"Coimbatore"`.

---

# 5. GROUP BY Multiple Columns

```sql
SELECT
    state,
    COUNT(*) AS State_Count,
    city,
    COUNT(*) AS City_Count
FROM customers
GROUP BY
    state,
    city;
```

This groups data by **state and city together**.

Example:

| State      | City       | Count |
| ---------- | ---------- | ----- |
| Tamil Nadu | Chennai    | 10    |
| Tamil Nadu | Coimbatore | 5     |
| Karnataka  | Bangalore  | 15    |

---

# 6. Window Function (OVER PARTITION BY)

Unlike `GROUP BY`, window functions **do not collapse rows**.

```sql
SELECT
    state,
    COUNT(*) OVER(PARTITION BY state) AS Total_In_State,
    city,
    COUNT(*) OVER(PARTITION BY city) AS Total_In_City
FROM customers;
```

Example:

| State      | City      | Total_In_State | Total_In_City |
| ---------- | --------- | -------------- | ------------- |
| Karnataka  | Bangalore | 15             | 15            |
| Karnataka  | Mysore    | 15             | 3             |
| Tamil Nadu | Chennai   | 8              | 8             |

Notice every row is preserved.

---

# GROUP BY vs Window Function

| GROUP BY             | Window Function      |
| -------------------- | -------------------- |
| Reduces rows         | Keeps all rows       |
| One result per group | Result for every row |
| Used for summaries   | Used for analysis    |

---

# 7. GROUP BY with SUM

```sql
SELECT
    customerNumber,
    SUM(amount) AS Total_Paid
FROM payments
GROUP BY customerNumber;
```

Example:

| Customer | Total Paid |
| -------- | ---------- |
| 103      | 12000      |
| 112      | 5000       |
| 119      | 25000      |

---

# 8. HAVING Clause

`HAVING` filters groups **after aggregation**.

```sql
SELECT
    customerNumber,
    SUM(amount) AS Total_Paid
FROM payments
GROUP BY customerNumber
HAVING Total_Paid > 10000;
```

Output:

| Customer | Total Paid |
| -------- | ---------- |
| 103      | 12000      |
| 119      | 25000      |

---

## WHERE vs HAVING

| WHERE                          | HAVING                      |
| ------------------------------ | --------------------------- |
| Filters rows                   | Filters groups              |
| Before GROUP BY                | After GROUP BY              |
| Cannot use aggregate functions | Can use aggregate functions |

Execution Order

```
FROM
   ↓
WHERE
   ↓
GROUP BY
   ↓
Aggregate Functions
   ↓
HAVING
   ↓
SELECT
   ↓
ORDER BY
```

---

# 9. Subqueries

A **subquery** is a query inside another query.

---

## Find Maximum Payment

```sql
SELECT
    customerNumber,
    amount
FROM payments
WHERE amount = (
    SELECT MAX(amount)
    FROM payments
);
```

### Execution Order

```
Run Subquery
      ↓
SELECT MAX(amount)
      ↓
Returns: 120000
      ↓
Outer Query
      ↓
Find rows having amount = 120000
```

---

## Find Minimum Payment

```sql
SELECT
    customerNumber,
    amount AS Min_Amount
FROM payments
WHERE amount = (
    SELECT MIN(amount)
    FROM payments
);
```

Execution:

```
Subquery
      ↓
MIN(amount)
      ↓
Returns minimum amount
      ↓
Outer query filters matching rows
```

---

# 10. Subquery using IN

```sql
SELECT customerName
FROM customers
WHERE customerNumber IN (
    SELECT customerNumber
    FROM orders
);
```

### What it does

Returns customers who have placed **at least one order**.

### Logical Execution Order

### Step 1

```sql
SELECT customerNumber
FROM orders;
```

Suppose it returns

```
103
112
119
121
```

---

### Step 2

The outer query becomes

```sql
SELECT customerName
FROM customers
WHERE customerNumber IN
(103,112,119,121);
```

---

### Step 3

Search every customer.

```
Customer 103 ✔

Customer 112 ✔

Customer 114 ✘

Customer 119 ✔
```

---

### Step 4

Return matching customer names.

---

# 11. Nested Subqueries

```sql
SELECT customerName
FROM customers
WHERE customerNumber IN (
    SELECT customerNumber
    FROM orders
    WHERE orderNumber IN (
        SELECT orderNumber
        FROM orderdetails
        WHERE quantityOrdered > 1
    )
);
```

### Purpose

Find customers who have ordered **at least one product with a quantity greater than 1**.

---

## Logical Execution Order

### Step 1 (Innermost Query)

```sql
SELECT orderNumber
FROM orderdetails
WHERE quantityOrdered > 1;
```

Example Output

```
10100
10102
10110
```

---

### Step 2 (Middle Query)

```sql
SELECT customerNumber
FROM orders
WHERE orderNumber IN
(10100,10102,10110);
```

Example Output

```
103
112
119
```

---

### Step 3 (Outer Query)

```sql
SELECT customerName
FROM customers
WHERE customerNumber IN
(103,112,119);
```

Output

```
Atelier graphique
Signal Gift Stores
La Rochelle Gifts
```

---

# Overall SQL Logical Execution Order

For most `SELECT` queries, SQL processes clauses in this logical order:

1. `FROM`
2. `WHERE`
3. `GROUP BY`
4. Aggregate Functions (`COUNT`, `SUM`, `AVG`, etc.)
5. `HAVING`
6. `SELECT`
7. `DISTINCT` (if present)
8. `ORDER BY`
9. `LIMIT`

**For queries with subqueries**, the innermost subquery is logically evaluated first, then each enclosing query uses its result. The database optimizer may choose a different physical execution plan for efficiency, but it always produces the same final result.
