# Chapter 3 - DQL and DML Commands



#### Selecting the specific featues from the table
```sql
SELECT productName, productLine, productScale, productVendor, buyPrice, MSRP from products;
```

#### Selction using the single condition using where keywork
```sql
SELECT productName, productLine, productScale, productVendor, buyPrice, MSRP from products WHERE buyPrice > 7000;
```

#### Selction using the multiple condition using 'where' and 'and' keywork
```sql
SELECT productName, productLine, productScale, productVendor, buyPrice, MSRP from products WHERE buyPrice > 7000 AND productLine = 'Classic Cars';
```

#### Sorting using order by (ascending or descending) order
```sql
SELECT productName, productLine, productScale, productVendor, buyPrice, MSRP from products ORDER BY buyPrice;
```

```sql
SELECT
    productName,
    productLine,
    productScale,
    productVendor,
    buyPrice,
    MSRP
from products
ORDER BY buyPrice DESC;
```

#### limiting number of row by using limit
```sql
SELECT productName, productLine, productScale, productVendor, buyPrice, MSRP from products ORDER BY buyPrice DESC LIMIT 5;
```

#### Dropping the database
```sql
DROP DATABASE sales_management;
```




#### To Delete an attribute from the table
```sql
use studentsdb;

ALTER TABLE students DROP birthdate;

select * from students;
```
