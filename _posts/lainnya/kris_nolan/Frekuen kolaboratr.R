rm(list=ls())
gc()

library(dplyr)
library(tidyr)

file = list.files(pattern = "txt")
file

ekstraksi = function(input){
  baca = readLines(input)
  data.frame(raw = baca) %>% 
    separate(raw,
             into = c("actor","dummy"),
             sep = " as ") %>% 
    select(-dummy) %>% 
    mutate(film = input) %>% 
    mutate(film = gsub(".txt","",film)) %>% 
    mutate(actor = stringr::str_trim(actor))
}

hasilnya = vector("list",length(file))
i = 1
for(x in file){
  hasilnya[[i]] = ekstraksi(x)
  print(x)
  i = i + 1
}

data_gabung = data.table::rbindlist(hasilnya) %>% as.data.frame()
data_gabung = data_gabung %>% distinct()

# chat$chat("Dari data `data_gabung`, tolong filter baris mana saja yang benar-benar berisi nama aktor/aktris pada kolom actor!")

# kita akan filter yang benar-benar nama aktor dan aktris saja

actor_names = 
  data_gabung %>% 
  mutate(filter = stringr::str_length(actor)) %>% 
  filter(filter <= 30)

frequent_collaborator = 
  actor_names %>%
  reshape2::dcast(actor ~ film,fun.aggregate = length)

freq_actor = 
  actor_names %>% 
  group_by(actor) %>% 
  tally() %>% 
  ungroup() %>% 
  arrange(desc(n))

save(actor_names,frequent_collaborator,freq_actor,file = "info.rda")

