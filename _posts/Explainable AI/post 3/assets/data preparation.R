# Data Preparation
# clear environment
rm(list=ls())

# libraries
library(dplyr)
library(tidyr)

# ===========================
# data carpentry

# import data
load("data.rda")

# gabung data
n = length(hasil)
data = data.frame()

for(i in 1:n){
  if(is.data.frame(hasil[[i]])){
    data = rbind(hasil[[i]],data)
    print(paste0(i," adalah data frame"))
  } else{
    print(paste0(i," bukan data frame"))
  }
}

# cek struktur data
data %>% str()

# fungsi modus
modus = function(x){
  names(sort(-table(x)))[1]
}

# kita rapikan terlebih dahulu
clean = 
  data %>% 
  mutate(seat = as.numeric(seat),
         seat = ifelse(is.na(seat),
                       modus(seat),
                       seat),
         mileage = gsub("K","000",mileage),
         mileage = stringr::str_squish(mileage),
         mileage = gsub(" ","",mileage)) %>% 
  separate(mileage,
           into = c("v1","v2"),
           sep = "-") %>% 
  mutate(v1 = as.numeric(v1),
         v2 = as.numeric(v2),
         v2 = ifelse(is.na(v2),0,v2),
         mileage = ifelse(v1 > v2,
                          v1,
                          v2),
         mileage = ifelse(mileage == 1,1000,mileage),
         v1 = NULL,
         v2 = NULL
         ) %>% 
  mutate(mesin = gsub(" |[a-z]","",trans),
         mesin = as.numeric(mesin),
         trans = NULL) %>% 
  mutate(harga = gsub("\\.| |Rp","",harga),
         harga = as.numeric(harga),
         target = log(harga))

save(clean,file = "clean.rda")