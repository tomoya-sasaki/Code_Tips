# Case Study

1. [Finding the oldest record](#finding-the-oldest-record)


## Finding the oldest record

[Reference](https://thoughtbot.com/blog/ordering-within-a-sql-group-by-clause)

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

