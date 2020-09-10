rm(list=ls())

library(dplyr)
library(tidyr)

babak = function(id){
  # data awal
  data = data.frame(pintu = c('a','b','c'),
                    hadiah = sample(c("mobil",'zonk','zonk'))
  )
  # di mana pintu hadiah dan pintu apa yang dpilihi
  data = 
    data %>% 
    mutate(pintu_isi_hadiah = ifelse(hadiah == "mobil",1,0),
           pintu_pilihan = sample(c(0,0,1)))
  # mencari pintu zonk untuk  dibuka
  dummy = 
    data %>% 
    mutate(dummy = pintu_isi_hadiah + pintu_pilihan) %>% 
    filter(dummy == 0) %>% 
    select(pintu)
  pintu_dibuka = sample(c(dummy$pintu),1)
  data$pintu_dibuka = ifelse(data$pintu == pintu_dibuka,1,0)
  # apakah pilihan kita berhasil?
  data = 
    data %>% filter(pintu_pilihan == 1)
  mean(data$pintu_pilihan == data$pintu_isi_hadiah)
}

simulasi = data.frame(id = c(1:900))
simulasi$hasil = sapply(simulasi$id,babak)

library(ggplot2)
simulasi %>% 
  mutate(stay = cumsum(hasil)/id*100,
         switch = 100-stay,
         hasil = NULL) %>% 
  reshape2::melt(id.vars = "id") %>% 
  ggplot(aes(x = id,y = value)) +
  geom_col(aes(fill = variable)) +
  geom_hline(yintercept = 2/3*100)
