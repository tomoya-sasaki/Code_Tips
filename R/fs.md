# fs

## List files
```r
fs::dir_ls(path = "data/", glob = "*/Meeting_*.csv")
```

## List files recursively
```r
files <- dir_ls(path = folder_raw, recurse = TRUE, glob = "*/*.txt")

files_tb <- 
  tibble(doc_id = 1:length(files),
         fullpath = files,
         foldername = files %>% path_dir() %>% str_split("/") %>% map_chr(tail, 1),
         filename = paste0(1:length(files),".txt"),
         folderpath = map_chr(files, path_dir)
         )
```
