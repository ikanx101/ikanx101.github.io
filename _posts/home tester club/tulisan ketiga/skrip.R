rm(list=ls())

url = "https://www.hometesterclub.com/id/id/reviews/tropicana-slim-oat-drink?review-page=1,50"

library(dplyr)
library(rvest)

df = 
  url %>% 
  read_html() %>% 
  html_nodes(".review-user_comment") %>% 
  html_text(trim = T)

save(df,file = "bahan.rda")
