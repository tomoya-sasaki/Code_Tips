# Formatting

## Number
```r
format_number <- function(x, round = 1) {
  dplyr::case_when(
      x < 1e3 ~ as.character(x),
      x < 1e6 ~ paste0(as.character(round(x / 1e3, round)), "K"),
      x < 1e9 ~ paste0(as.character(round(x / 1e6, round)), "M"),
      TRUE ~ "To be implemented..."
  )
}
```

## Table

Also check [flextable](./flextable.md).

```r
format_table <- function(x, sep = " ", type = c("basic", "latex"), ...) {
  type <- match.arg(type)

  if (type == "basic") {
    return(format_table_basic(x, sep, ...))
  }

  if (type == "latex") {
    return(format_table_latex(x, sep, ...))
  }
}

format_table_basic <- function(x, sep = " ", ...) {
  return(
    insight::export_table(
      x,
      sep = sep,
      ...
    )
  )
}

format_table_latex <- function(x, ...) {
  xtable::xtable(x, include.rownames = FALSE, caption.placement = "top", table.placement = "H")
}

save_table <- function(x, filename) {
  if ("xtable" %in% class(x)) {
    write(as.character(print(x)), file = filename)
  }
}
```

## Date
```r
yeardate_fast <- function(x) {
  # No separator, e.g., "20210401"
  return(fasttime::fastDate(x, fixed = 4))
}
```
