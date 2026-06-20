# Chapter 6 - Windows Functions and Stored Procedure


---

## What is a Window Function?

A **Window Function** performs calculations across a set of rows while **keeping every row in the result**.

Unlike `GROUP BY`, it **does not combine rows**.

Example:

```sql
SELECT *,
       RANK() OVER(ORDER BY sales_amount DESC)
FROM sales_data;
```

---

### General Syntax

```sql
Window_Function() OVER(
    PARTITION BY column_name
    ORDER BY column_name
)
```

#### Components

| Clause       | Purpose                       |
| ------------ | ----------------------------- |
| OVER()       | Defines the window            |
| ORDER BY     | Sorts rows before calculation |
| PARTITION BY | Divides rows into groups      |

---

### 1. RANK()

#### Definition

Assigns a rank to each row.

If two rows have the same value, they receive the **same rank**, and the next rank is skipped.

---

#### Syntax

```sql
RANK() OVER(
ORDER BY column DESC
)
```

---

#### Example

```sql
SELECT *,
RANK() OVER(
ORDER BY sales_amount DESC
) AS Rank_by_Sales
FROM sales_data;
```

Suppose

| Sales |
| ----- |
| 800   |
| 700   |
| 700   |
| 650   |

Output

| Sales | Rank |
| ----- | ---- |
| 800   | 1    |
| 700   | 2    |
| 700   | 2    |
| 650   | 4    |

Notice:

Rank **3** is skipped.

---

#### Execution

```text
FROM sales_data
      ↓
Sort by sales_amount DESC
      ↓
Assign ranks
      ↓
Display result
```

---

# 2. DENSE_RANK()

## Definition

Similar to `RANK()`, but **does not skip ranks**.

---

## Syntax

```sql
DENSE_RANK() OVER(
ORDER BY sales_amount DESC
)
```

---

Example

| Sales | Dense Rank |
| ----- | ---------- |
| 800   | 1          |
| 700   | 2          |
| 700   | 2          |
| 650   | 3          |

---

## Difference

| RANK()     | DENSE_RANK()      |
| ---------- | ----------------- |
| Skips rank | Doesn't skip rank |

---

# 3. PARTITION BY

## Definition

Divides rows into separate groups.

Ranking starts from **1** for every partition.

---

Example

```sql
SELECT *,
RANK() OVER(
PARTITION BY month
ORDER BY sales_amount DESC
) AS Month_Rank
FROM sales_data;
```

---

Suppose

January

| Sales |
| ----- |
| 600   |
| 500   |

Ranking

| Sales | Rank |
| ----- | ---- |
| 600   | 1    |
| 500   | 2    |

February

| Sales |
| ----- |
| 700   |
| 650   |
| 450   |

Ranking restarts

| Sales | Rank |
| ----- | ---- |
| 700   | 1    |
| 650   | 2    |
| 450   | 3    |

---

## Execution

```text
FROM sales_data
      ↓
Create partitions
(January, February, March)
      ↓
Sort inside each partition
      ↓
Assign rank
```

---

# 4. Ranking After GROUP BY

Example

```sql
SELECT
employee_id,
SUM(sales_amount) AS Total_Sales,
RANK() OVER(
ORDER BY SUM(sales_amount) DESC
)
FROM sales_data
GROUP BY employee_id;
```

---

Execution

```text
FROM sales_data
      ↓
GROUP BY employee_id
      ↓
SUM(sales_amount)
      ↓
RANK employees
      ↓
SELECT
```

---

# 5. Running Total

## Definition

Calculates a cumulative total.

---

Example

```sql
SELECT *,
SUM(sales_amount)
OVER(
PARTITION BY employee_id
ORDER BY month
) AS sales_per_employee
FROM sales_data;
```

Suppose Employee 101

| Month | Sales |
| ----- | ----- |
| Jan   | 500   |
| Feb   | 450   |
| Mar   | 550   |

Output

| Month | Sales | Running Total |
| ----- | ----- | ------------- |
| Jan   | 500   | 500           |
| Feb   | 450   | 950           |
| Mar   | 550   | 1500          |

---

Execution

```text
Employee 101

500
↓

500+450

↓

950+550

↓

1500
```

---

# 6. LAG()

## Definition

Returns the value from the **previous row**.

---

Syntax

```sql
LAG(column)
OVER(
PARTITION BY ...
ORDER BY ...
)
```

---

Example

```sql
SELECT *,
LAG(sales_amount)
OVER(
PARTITION BY employee_id
ORDER BY month
) AS Previous_Month
FROM sales_data;
```

Output

| Month | Sales | Previous |
| ----- | ----- | -------- |
| Jan   | 500   | NULL     |
| Feb   | 450   | 500      |
| Mar   | 550   | 450      |

---

Execution

```text
Current Row

↓

Look one row above

↓

Return value
```

---

# 7. Monthly Sales

First calculate total monthly sales.

```sql
SELECT
month,
SUM(sales_amount) AS total_sales
FROM sales_data
GROUP BY month;
```

Output

| Month | Total Sales |
| ----- | ----------- |
| Jan   | 1100        |
| Feb   | 1800        |
| Mar   | 2350        |

---

# 8. Previous Month Sales

```sql
SELECT
month,
total_sales,
LAG(total_sales)
OVER(
ORDER BY month
)
AS previous_month_sales
FROM monthly_sales;
```

Output

| Month | Total | Previous |
| ----- | ----- | -------- |
| Jan   | 1100  | NULL     |
| Feb   | 1800  | 1100     |
| Mar   | 2350  | 1800     |

---

# 9. Growth Percentage

Formula

```text
(Current - Previous)
/ Previous
×100
```

Query

```sql
ROUND(
(
(total_sales-
LAG(total_sales) OVER())
/
LAG(total_sales) OVER()
)*100,
2)
```

Example

January

1100

February

1800

Growth

```text
(1800-1100)
/1100

=63.64%
```

---

# 10. LEAD()

## Definition

Returns the value from the **next row**.

---

Syntax

```sql
LEAD(column)
OVER(
PARTITION BY ...
ORDER BY ...
)
```

---

Example

```sql
SELECT *,
LEAD(sales_amount)
OVER(
PARTITION BY employee_id
ORDER BY month
)
AS Next_Month
FROM sales_data;
```

Output

| Month | Sales | Next |
| ----- | ----- | ---- |
| Jan   | 500   | 450  |
| Feb   | 450   | 550  |
| Mar   | 550   | NULL |

---

## Difference

| LAG()        | LEAD()   |
| ------------ | -------- |
| Previous row | Next row |

---

# Stored Procedures

## Definition

A Stored Procedure is a **saved SQL program** stored inside the database.

Instead of writing the same query repeatedly, you execute the procedure.

---

# Create Procedure

```sql
DELIMITER $$

CREATE PROCEDURE get_all_sales()

BEGIN
SELECT *
FROM sales_data;
END $$

DELIMITER ;
```

---

# Execute Procedure

```sql
CALL get_all_sales();
```

---

# Drop Procedure

```sql
DROP PROCEDURE get_all_sales;
```

or

```sql
DROP PROCEDURE IF EXISTS get_all_sales;
```

---

# Show Procedures

```sql
SHOW PROCEDURE STATUS
WHERE Db='sales_datadb';
```

---

# View Procedure Code

```sql
SHOW CREATE PROCEDURE get_all_sales;
```

---

# Procedure with Parameter

```sql
CREATE PROCEDURE get_employee_sales(
IN emp_id INT
)
BEGIN
SELECT *
FROM sales_data
WHERE employee_id=emp_id;
END;
```

---

Call

```sql
CALL get_employee_sales(101);
```

Meaning

```text
emp_id = 101

↓

WHERE employee_id=101

↓

Return only Employee 101's sales
```

---

# Procedure Parameter Types

| Parameter | Meaning          |
| --------- | ---------------- |
| IN        | Input only       |
| OUT       | Output only      |
| INOUT     | Input and Output |

---

# Quick Revision

### Window Functions

* `RANK()` → Same rank for ties, skips next rank.
* `DENSE_RANK()` → Same rank for ties, no skipped ranks.
* `PARTITION BY` → Creates separate groups for calculations.
* `SUM() OVER()` → Running total.
* `LAG()` → Previous row value.
* `LEAD()` → Next row value.

### Stored Procedures

* `CREATE PROCEDURE` → Create a reusable SQL program.
* `CALL procedure_name()` → Execute it.
* `DROP PROCEDURE` → Delete it.
* `SHOW PROCEDURE STATUS` → List procedures.
* `SHOW CREATE PROCEDURE` → View procedure definition.
* `IN` parameter → Passes input values into the procedure.

> **Small improvement:** In your `LEAD()` query, the alias is `previous_month`, but `LEAD()` actually returns the **next** month's value. A clearer alias would be:

```sql
SELECT *,
       LEAD(sales_amount) OVER (
           PARTITION BY employee_id
           ORDER BY month
       ) AS next_month
FROM sales_data;
```

This makes the output easier to understand.
