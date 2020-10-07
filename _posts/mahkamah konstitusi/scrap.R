rm(list=ls())

url = "https://mkri.id/index.php?page=web.RekapPUU&menu=4"

library(rvest)

data = 
  read_html(url) %>% 
  html_table(fill = T)

data = data[[1]]
