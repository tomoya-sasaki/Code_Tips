# Shiny
[My examples](../Examples/Shiny/)

## Table of Contents
1. [File organization](#file-organization)


## File organization

Put `ui.R` and `server.R` in the same folder and `shiny::runApp('./')`
```r
# ui.R
library(shiny)
library(shinydashboard)
library(tidyverse)

fluidPage()
```

```r
# server.R
function(input, output) {

}
```
