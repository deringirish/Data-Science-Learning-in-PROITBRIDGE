# Chapter 2 - Functions and Formulas


## Arithmetic formulas: SUM, AVERAGE, COUNT

1. **What SUM Does:**
    - Adds up all the values within a given range of cells.
    - **Syntax:**
        `=SUM(number1, [number2], ...)` or `=SUM(A1:A10)`
    - **General Steps to Use SUM:**
      1. Click the cell where you want the total
      2. Type `=SUM(`
      3. Select the range of cells to add
      4. Close with `)` and press Enter
    <br>
   
2. **What AVERAGE Does:**
    - Calculates the mean(average) of selected numeric values.
    - **Syntax:**
        `=AVERAGE(number1, [number2], ...)` or `=AVERAGE(B2:B10)`
    - **General steps to Use AVERAGE:**
        1. Select the cell where you want the average to appear
        2. Type `=AVERAGE(`
        3. Highlight or type the range of numbers
        4. Close with `)` and press Enter
    <br>

3. **What COUNT Does:**
    - Counts the number of numeric entries in a range of cells.
    - Text or blank cells are ignored.
    - **Syntax:**
      `COUNT(Value1, [Value2]...)` or `COUNT(C2:C10)`
    - **General steps to Use COUNT:**
      1. Select the cell where you wantthe count 
      2. Type `=COUNT(`
      3. Highlight the range of cells containing numbers
      4. Close the bracket `)` and press Enter
    <br>


## Logical operators: IF, AND, OR, NOT

- Logical operators are functions that help Excel make decisions by evaluating conditions as TRUE or FALSE.
- They're used to:
    1. Compare values
    2. Test multiple conditions
    3. Return different results based on logic

| Operator | Meaning                                  |
|----------|------------------------------------------|
| Not      | Test if value is NOT something           |
| And      | Test for more than one condition         |
| Or       | Test if the value is either OR something |
| Xor      | Test if one and only one value is true   |


1. **`IF()` - The Decision Maker**
    - If something is true, do this. If not, do that.
    - **Syntax:**
        `=IF(condition, value_if_true, value_if_false)`
    - **Example Use:** Pass/Fail, Eligible/Not Eligible, Yes/No outputs
<br>

2.  **`AND()` - All Must Be True**
    - Only return TRUE if every condition is true.
    - **Syntax:**
        `=AND(condition1, condition2, ... )`
    - Use inside IF() to check multiple criteria (**e.g.,** marks AND attendance)
<br>

3. **`OR()` — One is Enough**
    - Return TRUE if any one condition is true.
    - **Syntax:**
        `=OR(condition1, condition2, ...)`
    - Use when multiple options are acceptable (**e.g.,** A OR B OR C)
<br>
4. **`NOT()` — Flip the Logic**
    - Return the opposite — if TRUE, give FALSE.
    - **Syntax:**
        `=NOT(condition)`
    - Great for highlighting exclusions or exceptions

#### Summary - Arithemetic & Logical Functions
1. Arithemetic Operators - Sum, Max, Min, CountA, Count, Average
2. Conditional Operatos - IF, SUMIF, COUNTIF, AVERAGEIF, SUMIFS, COUNTIFS
3. 