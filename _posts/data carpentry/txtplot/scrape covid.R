rm(list=ls())

library(dplyr)
library(rvest)

url = "https://www.worldometers.info/coronavirus/"

tabel = 
  url %>% 
  read_html() %>% 
  html_table(fill = T)

df = tabel[[3]]

df = 
  df %>% 
  janitor::clean_names()

df = 
  df %>% 
  filter(!is.na(number))

df = 
  df %>% 
  select(number,country_other,total_cases,total_recovered) %>% 
  mutate(total_cases = gsub("\\,","",total_cases),
         total_recovered = gsub("\\,","",total_recovered),
         total_cases = as.numeric(total_cases),
         total_recovered = as.numeric(total_recovered)) %>% 
  head(20)

save(df,file = "cov.rda")
