rm(list=ls())

library(rvest)
library(dplyr)

url = "https://www.hometesterclub.com/id/id/reviews/tropicana-slim-sweet-orange"

read_html(url) %>% 
  html_nodes(".pp-ratereview-counter li:nth-child(1)") %>% 
  html_text()

read_html(url) %>% 
  html_nodes(".pp-ratereview-counter li+ li") %>% 
  html_text()

read_html(url) %>% 
  html_nodes("#product_naturalurl > div.render-body > section.pp-wrapper > div > div.row.pp-product-wrapper > div.col-md-4.col-xs-12 > h2") %>% 
  html_text()

read_html(url) %>% 
  html_nodes(".review-user_comment") %>% 
  html_text()
