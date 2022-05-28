# SQL Basics

## Basic commands
* SELECT
* LIMIT
* WHERE
* LIKE: simiar valueにmatchできるlogical operator
* IN
* BETWEEN
* IS NULL
* AND/OR/NOT
* ORDER BY

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

