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

### Order observations and select the top one
```sql
WITH account_cumsum AS (
  SELECT
    *,
    COUNT(signup_date)
      OVER (PARTITION BY account_id ORDER BY signup_date)
      AS cumsum
   FROM account_data  
)

SELECT *
FROM account_cumsum
WHERE cumsum = 1
```

## Checking duplicates

```sql
SELECT
  account_id
FROM signup
GROUP BY account_id
HAVING COUNT(1) > 1
```

