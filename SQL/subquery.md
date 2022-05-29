# Subquery
  
Once the inner query runs, the outer query will run using the results from the inner query as its underlying table.

Usages:
* [Aggregation in multiple stages](https://mode.com/sql-tutorial/sql-sub-queries/#using-subqueries-to-aggregate-in-multiple-stages): まず日毎に集計して、それをさらに曜日月ごとに集計したいような場合
* [In conditional logic](https://mode.com/sql-tutorial/sql-sub-queries/#subqueries-in-conditional-logic): データセットから条件における値を求めたいとき
* [Speeding up](https://mode.com/sql-tutorial/sql-sub-queries/#joining-subqueries): aggregate and then join, not the reverse order
  
  
```sql
SELECT sub1.*
  FROM (
        SELECT *
          FROM original_data
         WHERE day_of_week != 'Wednesday'
       ) sub1
 WHERE sub1.value IS NOT NULL
```
