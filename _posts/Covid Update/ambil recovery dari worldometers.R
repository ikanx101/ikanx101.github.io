rm(list = ls())

library(rvest)
library(dplyr)

url = "https://www.worldometers.info/coronavirus/"

data = read_html(url) %>% html_table(fill = T)

data = data[[1]]

data = 
  data %>% 
  janitor::clean_names() %>% 
  select(country_other,total_cases,total_recovered) %>% 
  mutate(total_cases = gsub("\\,","",total_cases),
         total_cases = as.numeric(total_cases),
         total_recovered = gsub("\\,","",total_recovered),
         total_recovered = as.numeric(total_recovered)) %>% 
  mutate(recovery_rate = total_recovered / total_cases) %>% 
  filter(!is.na(recovery_rate))