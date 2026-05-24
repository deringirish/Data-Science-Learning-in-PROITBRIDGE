Good question. If I were the \*\*business owner / football federation / coach\*\* holding this Euro 2012 data, and I wanted insights from a \*\*Data Analyst\*\*, I would ask business-style questions that can be solved using \*\*sorting, slicing, filtering, and selection\*\*.



Here are categorized questions:



\# 1. Sorting Questions



(Find top/bottom performers)



\### Performance Ranking



\* Which teams scored the \*\*highest goals\*\*?

\* Which teams had the \*\*best passing accuracy\*\*?

\* Which teams received the \*\*most yellow cards\*\*?

\* Which teams conceded the \*\*fewest goals\*\*?

\* Top 5 teams with the \*\*highest shooting accuracy\*\*.



Typical pandas:



```python

sort\_values()

```



\---



\# 2. Filtering Questions



(Apply conditions)



\### Discipline Analysis



\* Which teams got \*\*at least 1 red card\*\*?

\* Which teams received \*\*more than 10 yellow cards\*\*?

\* Teams with \*\*clean sheets AND low fouls\*\*.



\### Attack Performance



\* Teams with \*\*Goals > 5\*\*.

\* Teams with \*\*Shooting Accuracy > 50%\*\*.

\* Teams with \*\*more shots but low conversion\*\*.



Typical pandas:



```python

>, <, >=, <=

\&, |

```



\---



\# 3. Selection Questions



(Choose important information)



Business may not want all 35 columns.



Questions:



\* Show only:



&#x20; \* Team

&#x20; \* Goals

&#x20; \* Passing Accuracy



\* Show:



&#x20; \* Team

&#x20; \* Yellow Cards

&#x20; \* Red Cards



Typical pandas:



```python

df\[\["Team","Goals"]]

```



\---



\# 4. Slicing Questions



(View only a portion of data)



\* Show first 5 teams.

\* Show last 3 teams.

\* Review rows 5–10 only.

\* Inspect selected columns and rows.



Typical pandas:



```python

head()

tail()

iloc\[]

loc\[]

```



\---



\# 5. Combined Business Questions



(Real analyst-style questions)



\### Coach Questions



\* Which teams had \*\*high passing accuracy but low goals\*\*?

\* Which disciplined teams performed better?

\* Teams with \*\*many shots but poor shooting accuracy\*\*.



\### Federation Questions



\* Which teams played \*\*aggressively\*\*?



&#x20; \* High fouls

&#x20; \* High yellow/red cards



\### Performance Questions



\* Top attacking teams:



&#x20; \* High goals

&#x20; \* High shooting accuracy

&#x20; \* High shots on target



Example:



```python

euro12\[

&#x20;   (euro12\["Goals"] > 5) \&

&#x20;   (euro12\["Yellow Cards"] < 10)

]\[\["Team","Goals"]]

```



\---



Think like this:



> \*\*Sorting → Who is best/worst?\*\*

> \*\*Filtering → Who matches a condition?\*\*

> \*\*Selection → Which information do I want?\*\*

> \*\*Slicing → Which part of data should I inspect?\*\*



This is how business questions become pandas tasks.



