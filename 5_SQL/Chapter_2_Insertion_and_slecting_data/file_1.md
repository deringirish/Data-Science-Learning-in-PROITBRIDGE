# Chapter 2 - Inserting and Selecting Data

#### Agenda at a glance

1. Inserting Data
2. Selecting Data
3. Theory

---

- In SQL, there are four main categories of SQL statements, each
  serving a different purpose:
    1. **Data Definition Language (DDL)**
    2. **Data Manipulation Language (DML)**
    3. **Data Control Language (DCL)**
    4. **Data Query Language (DQL)**

---

#### 1. Data Definition Language (DDL):

- DDL statements are used to define the structure of a database, including creating, modifying, and deleting database objects like tables, indsxes, and constraints.
- Key DDL statements include:
    - **CREATE**: Used to create new database objects, such as tables, indexes, and views.
    - **ALTER**: Used to modify the structure of existing database objects.

```sql
CREATE TABLE Students (
StudentID INT AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
BirthDate DATE,
Gender VARCHAR(10)

);
```

#### 2. Data Manipulation Language (DML)

- DML statements are used to manipulate the data within a database
    - **INSERT**: Adds new records to a table.
    - **UPDATE**: Modifies existing records in a table.

```sql
INSERT INTO Students (FirstName, LastName, BirthDate, Gender) VALUES
('John', 'Doe', '2000-05-15', 'Male'),
('Jane', 'Smith', '1999-04-12', 'Female'),
('Emily', 'Johnson', '2001-07-22', 'Female'),
('Michael', 'Williams', '2000-12-30', 'Male'),
('Sarah', 'Brown', '1998-10-10', 'Female'),
('David', 'Jones', '2002-03-25', 'Male'),
('Emma', 'Garcia', '2000-11-08', 'Female'),
('James', 'Martinez', '1999-01-01', 'Male'),
('Olivia', 'Hernandez', '2001-08-30', 'Female'),
('William', 'Lopez', '2000-02-14', 'Male');

```

#### 3. Data Control Language (DCL):

- DCL statements are used to manage permissions and access control within a database.
    - **GRANT**: Provides specific privileges to users or roles.
    - **REVOKE**: Removes specific privileges from users or roles

#### 4. Data Query Language (DQL)

- DQL statements are used to query and retrieve data from the database.
    - **SELECT**: Retrieves data from one or more tables based on specified criteria.

```sql
SELECT * FROM Students;

SELECT * FROM Courses;

SELECT * FROM Enrollment;

SELECT FirstName, LastName FROM Students;

SELECT * FROM Students WHERE Gender = 'Male';
```

---

#### SQL Query Execution Order

| Step  | Clause       | Sequence of Execution / Purpose                                                                       |
| ----- | ------------ | ----------------------------------------------------------------------------------------------------- |
| **1** | **FROM**     | Specifies the data source (tables, views, joins). Resolves the tables and retrieves the initial data. |
| **2** | **WHERE**    | Filters rows based on the specified condition.                                                        |
| **3** | **GROUP BY** | Groups rows into subsets based on one or more columns for aggregation.                                |
| **4** | **HAVING**   | Filters groups created by `GROUP BY` based on a condition.                                            |
| **5** | **SELECT**   | Selects specific columns, calculated expressions, or aggregated values for the output.                |
| **6** | **ORDER BY** | Sorts the result set based on specified columns in ascending (`ASC`) or descending (`DESC`) order.    |
| **7** | **LIMIT**    | Restricts the number of rows returned in the result set.                                              |

> Remembering The flow
>
> - First We Get Hungry, So Order Lunch

---

#### Miscellaneous

##### Alter vs Update

| Aspect             | ALTER                                                   | UPDATE                                        |
| ------------------ | ------------------------------------------------------- | --------------------------------------------- |
| **Purpose**        | Modify the structure of a table.                        | Modify the data stored in a table.            |
| **Scope**          | Affects columns, constraints, indexes, or table schema. | Affects rows and column values (actual data). |
| **Usage**          | Used for changing the database structure.               | Used for changing existing records.           |
| **SQL Category**   | DDL (Data Definition Language)                          | DML (Data Manipulation Language)              |
| **Effect on Data** | Does not directly change the data values.               | Changes the actual data values.               |
| **Examples**       | Add, drop, rename, or modify columns.                   | Update specific rows or all rows in a table.  |
