# Chapter 4 - DAX Calculation

## DAX - Data Analysis Expression

#### What is DAX?
- **DAX is used to create calculations in Power BI** - It helps us make totals, averages, counts, and other useful numbers for analysis.
- **Measures in DAX change with filters** - When we select a store, product, or date, the measure automatically recalculates the correct value.
- **CALCULATE and other DAX functions help apply logic** - Functions like CALCULATE, SUM and VAR let us filter data, add conditions, and build smarter formulas.


---



#### Reuse and Creating Measures

``` DAX
Total Price = SUM(fact_table[total_price])
// (Store Key & Total Profit)
```
``` DAX
Total Quantity = SUM(fact_table[quantity])
// (Item Key & total Quantity)
```
```DAX
Total Transaction = COUNTROWS(fact_table)
// (Store Key & Total Profit & Total Trans)
```
- Formating the data type of the **measures**
- Can reuse the measures

```DAX
Average Trans = DIVIDE([Total Price], [Total Transaction])
// (Store Key & Total Profit & Total Trans & Average Trans)
```

``` DAX
Average Quanity = DIVIDE([Total Quantity], [Total Transaction])
// (Store Key & Total Profit & Total Trans & Average Trans & Average Quanity)
```

#### Distinct Count
- Count the unique values in the column
```DAX
Item Count = DISTINCTCOUNT(fact_table[item_key])
// visualize in card
```
```DAX
Store Count = DISTINCTCOUNT(fact_table[store_key])
// visualize in card
```

#### Min, Avg, Max
```DAX
Max Trans Amount = MAX(fact_table[total_price])
// visualize in card
```
```DAX
Min Tans Amount = MIN(fact_table[total_price])
// visualize in card
```
```DAX
Average Trans Amount = AVERAGE(fact_table[total_price])
// visualize in card
```
#### Calculated DAX 
- First filter and then calculate
```DAX
// To calcuate the total price of the coke classic 12 ox cans
Coke Classic 12 oz cans trans = CALCULATE([Total Price], item_dim[item_name] = "Coke Classic 12 oz cans")
// visualize in card
```
```DAX
// To calcuate the total price of the diet mountain dew 120z cans trans
Diet Mountain Dew 12oz cans trans = CALCULATE([Total Price], item_dim[item_name] = "Diet Mountain Dew 12oz cans")
// visualize in card
```
```DAX
// To calcuate the total price of the Dr. pepper - 12 oz cans 
Dr. Pepper - 12 oz cans trans = CALCULATE([Total Price], item_dim[item_name] = "Dr. Pepper - 12 oz cans")
// visualize in card
```


## IF - Else Condition
```DAX
Store Category = IF([Average Trans] >= 100, "Premium Store", "Regular Store")
// (Story Key & Average Trans & Store Category)
```
```DAX
Store Category 2 = IF([Average Trans] >= 100, "😀", "🙁")
// (Story Key & Average Trans & Store Category 2)
```









