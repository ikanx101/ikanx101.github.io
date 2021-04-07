rm(list=ls())
library(dplyr)
library(rvest)

url = "https://gis.bnpb.go.id/databencana/tabel/pencarian.php"

scraped_data = read_html(url) %>% html_table(fill = T)

scraped_data = scraped_data[[1]]

bersihin = function(string){
  hasil = trimws(tolower(string))
  hasil = gsub("\\.","",hasil)
  hasil = gsub(" ","_",hasil)
  return(hasil)
}

colnames(scraped_data) = bersihin(scraped_data[1,])
scraped_data = scraped_data[-1,]

str(scraped_data)

save(scraped_data,file = "bahan blog.rda")
