# Maptools

## Table of Contents
1. [Read Attribute Table](#read-attribute-table)

## Read Attribute Table
```r
> library(maptools)
> data_shp <- readShapeSpatial("A16-10_00_DID.shp")
> data <- data.frame(data_shp)
> data$A16_003 <- iconv(data$A16_003,from="shift-jis",to="utf-8")
> head(data,3)
  A16_001 A16_002      A16_003 A16_004 A16_005 A16_006 A16_007 A16_008 A16_009 A16_010 A16_011
0   11011   01101 札幌市中央区       1  217633   23.00  200393   22.99    98.8    49.5    2010
1   11021   01102   札幌市北区       1  232186   28.63  227341   28.05    83.3    45.1    2010
2   11021   01102   札幌市北区       1  232186   28.63  227341   28.05    83.3    45.1    2010
```
