# Chapter 5 - Joins and Groupings

Here is the content from your image formatted into a clean and easy-to-read table for your notes.

# SQL Joins

| Join Type                         | Description                                                                                                                  | Returns                                                                                                                             |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **INNER JOIN**                    | Returns only the matching rows from both tables.                                                                             | Records that are common in both tables.                                                                                             |
| **LEFT JOIN (LEFT OUTER JOIN)**   | Returns all rows from the left table and the matching rows from the right table.                                             | All rows from the left table and matched rows from the right. If there is no match, `NULL` values are returned for the right table. |
| **RIGHT JOIN (RIGHT OUTER JOIN)** | Returns all rows from the right table and the matching rows from the left table.                                             | All rows from the right table and matched rows from the left. If there is no match, `NULL` values are returned for the left table.  |
| **FULL JOIN (FULL OUTER JOIN)**   | Returns all rows when there is a match in either the left or right table.                                                    | All rows from both tables. Unmatched rows contain `NULL` values for the missing side.                                               |
| **CROSS JOIN**                    | Returns the Cartesian product of both tables (every row from the first table combined with every row from the second table). | Every possible combination of rows from both tables.                                                                                |
| **SELF JOIN**                     | Joins a table with itself, usually using aliases. Useful for hierarchical or self-referencing relationships.                 | Rows from the same table matched with other rows in the same table.                                                                 |

---
Your SQL queries are correct. Below are **well-structured study notes** that explain each query, when to use it, and the execution flow.

---

# SQL Study Notes – Joins

A **JOIN** is used to combine rows from two or more tables based on a related column.

---

# 1. INNER JOIN

## Definition

Returns **only the matching rows** from both tables.

If there is no match, the row is not included in the result.

### Syntax

```sql
SELECT column_list
FROM table1
INNER JOIN table2
ON table1.column = table2.column;
```

### Example

```sql
SELECT customers.customerName, orders.orderNumber
FROM customers
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber;
```

### Execution Flow

```
FROM customers
        ↓
INNER JOIN orders
        ↓
Match:
customers.customerNumber = orders.customerNumber
        ↓
Return only matching rows
```

### Result

| Customer | Order |
| -------- | ----- |
| John     | 10101 |
| Alice    | 10102 |

---

# 2. LEFT JOIN

## Definition

Returns **all rows from the left table** and the matching rows from the right table.

If no match exists in the right table, SQL returns **NULL**.

### Syntax

```sql
SELECT column_list
FROM table1
LEFT JOIN table2
ON table1.column = table2.column;
```

### Example

```sql
SELECT customers.customerName, orders.orderNumber
FROM customers
LEFT JOIN orders
ON customers.customerNumber = orders.customerNumber;
```

### Execution Flow

```
FROM customers
        ↓
LEFT JOIN orders
        ↓
Match customerNumber
        ↓
Keep ALL customers
        ↓
If no order exists
→ orderNumber = NULL
```

### Result

| Customer | Order |
| -------- | ----- |
| John     | 10101 |
| Alice    | 10102 |
| David    | NULL  |

---

# 3. RIGHT JOIN

## Definition

Returns **all rows from the right table** and the matching rows from the left table.

If no match exists in the left table, SQL returns **NULL**.

### Syntax

```sql
SELECT column_list
FROM table1
RIGHT JOIN table2
ON table1.column = table2.column;
```

### Example

```sql
SELECT customers.customerName, orders.orderNumber
FROM customers
RIGHT JOIN orders
ON customers.customerNumber = orders.customerNumber;
```

### Execution Flow

```
FROM customers
        ↓
RIGHT JOIN orders
        ↓
Match customerNumber
        ↓
Keep ALL orders
        ↓
If customer doesn't exist
→ customerName = NULL
```

### Result

| Customer | Order |
| -------- | ----- |
| John     | 10101 |
| Alice    | 10102 |
| NULL     | 10110 |

---

# 4. FULL JOIN

## Definition

Returns:

* All matching rows.
* Unmatched rows from the left table.
* Unmatched rows from the right table.

MySQL **does not support FULL JOIN**, so it is simulated using `LEFT JOIN` and `RIGHT JOIN` with `UNION`.

### Example

```sql
SELECT customers.customerName, orders.orderNumber
FROM customers
LEFT JOIN orders
ON customers.customerNumber = orders.customerNumber

UNION

SELECT customers.customerName, orders.orderNumber
FROM customers
RIGHT JOIN orders
ON customers.customerNumber = orders.customerNumber;
```

### Execution Flow

```
LEFT JOIN Result
        +
RIGHT JOIN Result
        ↓
UNION
(Removes duplicate matching rows)
        ↓
Final FULL JOIN Result
```

### Result

| Customer | Order |
| -------- | ----- |
| John     | 10101 |
| Alice    | 10102 |
| David    | NULL  |
| NULL     | 10110 |

---

# 5. SELF JOIN

## Definition

A **Self Join** joins a table with itself.

Used when rows in the same table are related, such as:

* Employee → Manager
* Parent → Child
* Teacher → Student

---

## Query

```sql
SELECT
    e.firstName AS employee,
    m.firstName AS managers
FROM employees e
LEFT JOIN employees m
ON e.reportsTo = m.employeeNumber;
```

---

## Understanding the Aliases

```sql
FROM employees e
```

`e` is the first copy of the `employees` table.

Think of it as:

```
Employee Table
```

---

```sql
LEFT JOIN employees m
```

`m` is the second copy of the same table.

Think of it as:

```
Manager Table
```

---

## Join Condition

```sql
ON e.reportsTo = m.employeeNumber
```

Meaning:

```
Employee's Manager ID
          =
Manager's Employee ID
```

Example

| Employee | reportsTo |
| -------- | --------- |
| Alice    | 1002      |

Manager Table

| Employee Number | Name |
| --------------- | ---- |
| 1002            | John |

Since

```
1002 = 1002
```

Manager = John

---

## Result

| Employee | Manager |
| -------- | ------- |
| John     | NULL    |
| Alice    | John    |
| Bob      | John    |
| David    | Alice   |

---

## Detailed Self Join Query

```sql
SELECT
    e.firstName AS employee,
    e.employeeNumber,
    e.reportsTo,
    m.firstName AS managers,
    m.employeeNumber
FROM employees e
LEFT JOIN employees m
ON e.reportsTo = m.employeeNumber;
```

### Purpose

Displays both employee and manager details.

Example Output

| Employee | Emp ID | Reports To | Manager | Manager ID |
| -------- | ------ | ---------- | ------- | ---------- |
| John     | 1002   | NULL       | NULL    | NULL       |
| Alice    | 1056   | 1002       | John    | 1002       |
| Bob      | 1076   | 1002       | John    | 1002       |

---

# 6. CROSS JOIN

## Definition

Returns **every possible combination** of rows from both tables.

Also called the **Cartesian Product**.

No matching condition is required.

---

## Query

```sql
SELECT
    customers.customerName,
    products.productName
FROM customers
CROSS JOIN products;
```

---

## Execution

Suppose

Customers

| Customer |
| -------- |
| John     |
| Alice    |

Products

| Product |
| ------- |
| Laptop  |
| Mouse   |

Result

| Customer | Product |
| -------- | ------- |
| John     | Laptop  |
| John     | Mouse   |
| Alice    | Laptop  |
| Alice    | Mouse   |

---

## Formula

If

```
Customers = m rows

Products = n rows
```

Then

```
Result = m × n rows
```

Example

```
Customers = 100

Products = 20

Result = 2000 rows
```

---

# Summary Table

| Join Type      | Returns                                                                                   |
| -------------- | ----------------------------------------------------------------------------------------- |
| **INNER JOIN** | Only matching rows from both tables                                                       |
| **LEFT JOIN**  | All rows from the left table + matching rows from the right table (`NULL` if no match)    |
| **RIGHT JOIN** | All rows from the right table + matching rows from the left table (`NULL` if no match)    |
| **FULL JOIN**  | All rows from both tables (simulated in MySQL using `LEFT JOIN` + `RIGHT JOIN` + `UNION`) |
| **SELF JOIN**  | Joins a table with itself using aliases to represent different roles                      |
| **CROSS JOIN** | Returns every possible combination of rows from both tables (Cartesian Product)           |

---

# Memory Tricks

* **INNER JOIN** → *Intersection* (only common records)
* **LEFT JOIN** → Keep **everything on the left**
* **RIGHT JOIN** → Keep **everything on the right**
* **FULL JOIN** → Keep **everything from both sides**
* **SELF JOIN** → One table, **two roles** (e.g., Employee ↔ Manager)
* **CROSS JOIN** → **Every row × Every row** (Cartesian Product)
