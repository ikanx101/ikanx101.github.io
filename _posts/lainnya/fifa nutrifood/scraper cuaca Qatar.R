rm(list=ls())

library(dplyr)
library(rvest)
library(reshape2)

url = "https://weatherspark.com/y/150272/Average-Weather-in-Qatar-Year-Round"

tabel = url %>% read_html() %>% html_table(fill = T)

df_temperatur = tabel[[3]] %>% janitor::clean_names()

df_temperatur = 
  df_temperatur %>% 
  melt(id.vars = "average") %>%
  rename(bulan = variable,
         temp = average,
         label = value) %>%
  mutate(bulan = factor(bulan,levels = c("jan","feb","mar","apr","may","jun","jul","aug","sep",
                                         "oct","nov","dec"))) %>%
  mutate(temp = ifelse(temp == "Temp.","Avg",temp)) %>%
  mutate(value = gsub("°F","",label),
         value = as.numeric(value))

save(df_temperatur,file = "qatar.rda")

df_temperatur
