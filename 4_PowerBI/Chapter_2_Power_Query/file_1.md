# Chapter 2 - Power Query

## Data Import and Power Query

#### What is Data Import?
- Bringing data from various sources into power BI
- Can load files like Excel, CSV, Patabases, Web, SharePoint
- First step before cleaning, transforming, or building reports

#### What is Powr Query?
- Power Query is a Power Bl tool used to connect, clean, transform, and prepare data before loading it into the data model.
- **Key Uses:**
    - Connect to multiple sources
    - Clean data (remove blanks, errors, duplicates)
    - Transform data (split/merge columns, unpivot, filter, change types)
    - Automate steps using Applied Steps
    - Optional advanced logic using **M Language**



**Steps**
- Extract the date
- Transform the data (Don't load it first)





**In Transform**
- Use First Row as Header



**Tools used in PowerBI**

- Get Data
- Transform data
- User First Row as Header
- Applied Steps - Keep Track of Operation did stil now
- Filter option
- Rename Column
- 
- (Right Click)
  - Split Column
  - Trim Data ( Transform -> Trim )
  - Remove Column
  - Remove 
  - Remove Other Columns
  - Duplicate Columns
  - Change Type
  - 
- Conditional column - Add Column -> Conditional Column

- Step Set: Calculate Age in Days
  ├── 1. Add Age Column:  [Ribbon] -> [Add Column] -> [Date]-> [Age]
  └── 2. Extract Days:    [Ribbon] -> [Transform] -> [Duration] -> [Days]
