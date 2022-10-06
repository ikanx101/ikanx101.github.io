rm(list=ls())

library(rvest)
library(dplyr)

# informasi dan data terkait final piala dunia
url = "https://en.wikipedia.org/wiki/List_of_FIFA_World_Cup_finals"
final = url %>% read_html() %>% html_table(fill = T)

# informasi dan data terkait piala dunia
url = "https://en.wikipedia.org/wiki/2022_FIFA_World_Cup"
df_pildun = url %>% read_html() %>% html_table(fill = T)

# informasi dan data terkait kualifikasi piala dunia
url = "https://en.wikipedia.org/wiki/2022_FIFA_World_Cup_qualification"
df_qualification = url %>% read_html() %>% html_table(fill = T)