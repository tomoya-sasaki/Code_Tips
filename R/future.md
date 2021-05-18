# future family

## Sample functions
```r
library(future.apply)
library(furrr)
nworkers <- 5
plan(multisession, workers = nworkers)

run_simulation <- function(nworkers, nsim, fn_simulation, parameters) {
  run_batch <- function(fn_simulation, nsim, parameters) {
    res <- map_dfr(1:nsim, function(i) {fn_simulation(parameters)}) 
    return(res)
  }
  res <- future_map_dfr(1:nworkers,
                          function(i) {
                          run_batch(fn_simulation,
                                    floor(nsim / nworkers),
                                    parameters)
                          },
                          .options = furrr_options(seed = TRUE)
                         )
  return(res)
}

run_simulation2 <- function(nworkers, fn_simulation, parameters, grid) {
  run_batch <- function(fn_simulation, index, parameters, grid) {
    res <- map_dfr(index, function(i) {fn_simulation(parameters,
                                          grid$lambda1[i],
                                          grid$lambda2[i])}) 
    return(res)
  }

  nrows <- nrow(grid)
  batch_size <- ceiling(nrows / nworkers)
  split_index <- split(1:nrows, ceiling(seq_along(1:nrows)/batch_size))
  res <- future_map_dfr(split_index,
                          function(index) {
                            run_batch(fn_simulation,
                                      index,
                                      parameters, grid)
                          },
                          .options = furrr_options(seed = TRUE,
                                                   packages = "ordinal")
                         )
  return(res)
}
```

## Pass packages
```r
.options = furrr_options(seed = TRUE,
                         packages = c("ordinal"))
```
