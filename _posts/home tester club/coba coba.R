rm(list=ls())

library(rvest)
library(dplyr)

url = "https://www.hometesterclub.com/id/id/reviews/tropicana-slim-sweet-orange"
url_komen = paste0(url,"?review-page=1,165&orderby=id%20desc")

rate =
  read_html(url) %>% 
  html_nodes(".pp-ratereview-counter li") %>% 
  html_text() %>% 
  paste(collapse = " ")

produk =
  read_html(url) %>% 
  html_nodes("#product_naturalurl > div.render-body > section.pp-wrapper > div > div.row.pp-product-wrapper > div.col-md-4.col-xs-12 > h2") %>% 
  html_text() 
produk = gsub("\\n","",produk)
produk = trimws(produk)

deskripsi = 
  read_html(url) %>% 
  html_nodes(".text-left") %>% 
  html_text()
deskripsi = deskripsi[1]
deskripsi = gsub("\\n|\\r","",deskripsi)
deskripsi = trimws(deskripsi)

komen = 
  read_html(url_komen) %>% 
  html_nodes(".review-user_comment") %>% 
  html_text()

data = 
  data.frame(
    produk,
    rate,
    deskripsi,
    komen
  )

save(data,file = "scrape TS.rda")