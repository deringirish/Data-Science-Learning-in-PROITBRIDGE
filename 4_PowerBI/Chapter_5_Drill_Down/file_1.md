# Chapter 5 - Drill Down

- Drill Down in Power Bl allows you to move from a high-level summary into more detailed data inside teh same visual
- Drill Down shows more details inside the selected category
- Instead of switching between multiple charts, you can explore top level -> middle level —> detailed level


---
## Power BI Hierarchy Navigation (Short Notes)

### 1. Drill Down (↓)

* Moves from a parent level to a child level.
* Focuses on a selected branch only.
* Example:

  * Category → Product Name
  * Click **Dairy** → Shows only Dairy products.

**Memory:** Go deeper into one category.

---

### 2. Drill Up (↑)

* Returns to the previous (higher) level in the hierarchy.
* Example:

  * Product Name → Back to Category.

**Memory:** Move back to the parent level.

---

### 3. Go to Next Level (⇓)

* Moves to the next hierarchy level for all data.
* Current level disappears.
* Example:

  * Category view → Shows all Product Names from all categories.

**Memory:** Replace current level with the next level.

---

### 4. Expand All Down One Level (⤓)

* Shows current level and next level together.
* Example:

  * Category

    * Product 1
    * Product 2

**Memory:** Keep parent and display children.

---

## Example Hierarchy (Your Dataset)

```text
Category
   └── Supplier_Name
         └── Product_Name
```

Example:

```text
Dairy
   └── Wordify
         └── Egg (Duck)
```

---

## Quick Comparison

| Feature                   | Action                           |
|---------------------------|----------------------------------|
| Drill Down                | View child data of selected item |
| Drill Up                  | Return to parent level           |
| Go to Next Level          | Show next level only             |
| Expand All Down One Level | Show parent and child together   |

### Easy Trick

* **Drill Down** → One branch ↓
* **Drill Up** → Go back ↑
* **Next Level** → Replace level ⇓
* **Expand** → Parent + Child ⤓
