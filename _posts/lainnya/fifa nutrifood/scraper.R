rm(list=ls())

library(rvest)
library(dplyr)

# informasi dan data terkait final piala dunia
url = "https://en.wikipedia.org/wiki/List_of_FIFA_World_Cup_finals"
final = url %>% read_html() %>% html_table(fill = T)
# data turunan
df_final = final[[4]]
df_winners = final[[5]]
df_winners_uefa_conmebol = final[[6]]

# informasi dan data terkait kualifikasi piala dunia
url = "https://en.wikipedia.org/wiki/2022_FIFA_World_Cup_qualification"
df_qualification = url %>% read_html() %>% html_table(fill = T)
# data turunan
df_negara_terkualifikasi = df_qualification[[2]]
df_asia_kualifikasi_1 = df_qualification[[5]]
df_asia_kualifikasi_2 = df_qualification[[6]]
df_amerika_kualifikasi = df_qualification[[9]]
df_conmebol_kualifikasi = df_qualification[[10]]


# kita save dulu
save(df_final,df_winners,df_winners_uefa_conmebol,
     df_negara_terkualifikasi,
     df_asia_kualifikasi_1,df_asia_kualifikasi_2,
     df_amerika_kualifikasi,df_conmebol_kualifikasi,
     file = "related_data.rda")