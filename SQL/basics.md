# SQL Basics

[MODE Tutorial](https://mode.com/sql-tutorial/)

Query order:
```sql
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
```

## Basic commands

* SELECT
* LIMIT
* WHERE
* [LIKE](#like): simiar valueにmatchできるlogical operator
* IN: `WHERE rank IN (1, 2, 3)`
* BETWEEN: `WHERE rank BETWEEN 5 AND 10`
* IS NULL: we can't do `= NULL`
* AND/OR/NOT
* [ORDER BY](#order-by)
* Comments: `--` (two dashes) or `/* COMMENT */`
* COUNT: a total count of non-null rows
* SUM
* MIN/MAX
* AVG
* GROUP BY
* [HAVING](#having): `WHERE`はaggregateした値には使えないので必要
* [CASE](#case): If elseの代わり
* DISTINCT
* Jins


## LIKE

* `%`: any character or set of characters.
* `_`: a substitution for an individual character
* `ILIKE`: a case-insensitive version of `LIKE`

## ORDER BY

```sql
SELECT *
  FROM music
  WHERE rank <= 3
 ORDER BY year DESC, rank
```
You can use the order of the column in `SELECT` to specify the column.


## HAVING
```sql
SELECT year,
       MAX(high) AS high_monthly
  FROM mydata
 GROUP BY year, month
HAVING MAX(high) > 100
 ORDER BY year, month
```

## CASE

```sql
SELECT name,
       year,
       CASE WHEN year <= 10 THEN 'Cat 1'
            WHEN year <= 15 THEN 'Cat 2'
            ELSE 'Cat 3' END AS check
  FROM data
```
`ELSE` is optional.


```sql


```


## Usages

### Quotations
SQL functionと同じ名前の場合は、quotation

[S]ingle quotes are for [S]trings Literals (date literals are also strings);
[D]ouble quotes are for [D]atabase Identifiers;

### Arithmatic
```sql
SELECT A,
       B,
       C + D AS new_column
  FROM tutorial
```

