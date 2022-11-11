# Case Study

1. [Finding the oldest record](#finding-the-oldest-record)
2. [Checking duplicates](#checking-duplicates)


## Finding the oldest record

[Reference](https://thoughtbot.com/blog/ordering-within-a-sql-group-by-clause)

### If there is no duplicate `event_date` at the account level
```sql
SELECT
  orders.*
FROM (
  SELECT
     account_id,
     MIN(event_date) AS oldest
  FROM orders
  GROUP BY account_id
) AS latest
INNER JOIN orders
  ON
        orders.account_id = latest.account_id
    AND orders.event_date = latest.oldest
```

Another example from [LeetCode: 511. Game Play Analysis I](https://leetcode.com/problems/game-play-analysis-i/).
```sql
SELECT
  A.player_id,
  MIN(A.event_date) AS first_login
FROM
  Activity AS A
GROUP BY
  A.player_id  
```

### Order observations and select the top one
```sql
WITH account_rownum AS (
  SELECT
    *,
    ROW_NUMBER()
      OVER (PARTITION BY account_id ORDER BY signup_date)
      AS rownum
   FROM account_data  
)

SELECT *
FROM account_rownum
WHERE rownum = 1
```

Another example from [LeetCode: 511. Game Play Analysis I](https://leetcode.com/problems/game-play-analysis-i/).
```sql
/* Solution 1 */
SELECT
  X.player_id,
  X.event_date AS first_login
FROM
  (
    SELECT
      A.player_id,
      A.event_date,
      RANK() OVER (
        PARTITION BY
          A.player_id
        ORDER BY
          A.event_date
      ) AS rnk
    FROM
      Activity A
  ) X
WHERE
  X.rnk = 1
  
/* Solution 2 */
SELECT DISTINCT
  A.player_id,
  FIRST_VALUE(A.event_date) OVER (
    PARTITION BY
      A.player_id
    ORDER BY
      A.event_date
  ) AS first_login
FROM
  Activity A
```

## Checking duplicates

```sql
SELECT
  account_id
FROM signup
GROUP BY account_id
HAVING COUNT(1) > 1
```

