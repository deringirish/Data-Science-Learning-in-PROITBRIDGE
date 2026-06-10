# Chapter 3 - Data Modelling

## 10 Steps of Data Analysis
1. Business Understanding
2. Data Understanding
3. Data Import
4. Data Cleaning(ETL)
5. Data Modelling
6. DAX Calculations
7. Visualization
8. Insights & Storytelling
9. Sharinig & Deployment
10. Maintenance

## Data Modelling
#### What is Data Modelling?
- Data modelling in Power BI is about **connecting tables in a meaning ful way.**
- A **Fact Table** contains the **main transactional or detailed records** (e.g., sales, orders, transactions).

| DateID   | ProductID | CustomerID | Quantity | SalesAmount |
|----------|-----------|------------|----------|-------------|
| 20250610 | P101      | C201       | 2        | 1000        |
| 20250610 | P102      | C202       | 1        | 500         |

[👆 Fact Table]()
- **Dimension Table** hold **descriptive information** related to the **fact table** (e.g., product details, customer info, Dimension Tables date attributes).

| ProductID | ProductName | Category    | Brand    |
|-----------|-------------|-------------|----------|
| P101      | Laptop      | Electronics | Dell     |
| P102      | Mouse       | Accessories | Logitech |

| CustomerID | CustomerName | City      |
|------------|--------------|-----------|
| C201       | John         | Bangalore |
| C202       | Sarah        | Mysore    |

| DateID   | Date        | Month | Quarter | Year |
|----------|-------------|-------|---------|------|
| 20250610 | 10-Jun-2025 | June  | Q2      | 2025 |

[👆 Dimenstion Tables]()

- By creating correct relationships between fact and dimension tables, Power Bl understands how the data is connected.
- Proper modelling allows you to build clear, accurate, and insightful 











