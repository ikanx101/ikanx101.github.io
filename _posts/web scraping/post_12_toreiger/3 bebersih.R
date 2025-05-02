rm(list=ls())

library(dplyr)
library(tidyr)
library(parallel)
library(tidytext)
library(janitor)

n_core = detectCores()

setwd("~/ikanx101.github.io/_posts/web scraping/post_12_toreiger")
load("data.rda")

# function benerin rating dan sales
benerin_rating_sales = function(input){
  len_ = stringr::str_length(input)
  if(len_ == 0){output = data.frame(rating = NA,penjualan = NA)}
  if(len_ > 0){
    pisah  = strsplit(input,split = "") %>% unlist()
    marker = sum(pisah == ".")
    # jika tidak ada titik artinya hanya penjualan
    if(marker == 0){output = data.frame(rating    = NA,
                                        penjualan = stringr::str_squish(input))}
    # jika ada titik artinya ada rating dan ada penjualan
    if(marker > 0){
      n_titik = which(pisah == ".")
      n_mulai = n_titik - 1
      n_akhir = n_titik + 1
      rating  = pisah[n_mulai:n_akhir]
      rating  = paste(rating,collapse = "")
      penjualan = pisah[-n_mulai:-n_akhir]
      penjualan = paste(penjualan,collapse = "")
      penjualan = stringr::str_squish(penjualan)
      output  = data.frame(rating,penjualan)
    }
  }
  return(output)
}

df = 
  df %>% 
  mutate(harga = gsub("Rp|\\.","",harga)) %>% 
  mutate(harga = as.numeric(harga)) %>% 
  mutate(rating_terjual = gsub("Dilayani Tokopedia","",rating_terjual),
         rating_terjual = gsub("terjual","",rating_terjual)) 

# ambil rating dan penjualan dulu
input_tes = df %>% pull(rating_terjual) 
temp_rasales = mclapply(input_tes,benerin_rating_sales,mc.cores = n_core)
temp_rasales = data.table::rbindlist(temp_rasales) %>% as.data.frame()


data_final = data.frame(df,temp_rasales) %>% select(-rating_terjual) %>% distinct()

data_final = 
  data_final %>% 
  mutate(penjualan = gsub("rb","000",penjualan),
         penjualan = gsub("\\+","",penjualan),
         penjualan = as.numeric(penjualan)) %>% 
  mutate(kategori = case_when(
    grepl("SACK|ransel|waist|shoulder|bag|tas|backpack|pack|rucksack|carrier",nama_produk,ignore.case = T) ~ "Bag",
    grepl("shirt|pant|short|baju|celana|tees",nama_produk,ignore.case = T) ~ "Shirt, Pants & Shorts",
    grepl("pouch|wallet|belt|dompet|pinggang",nama_produk,ignore.case = T) ~ "Pouch, Wallet & Belt",
    grepl("tent|cover|tenda",nama_produk,ignore.case = T) ~ "Tent & Cover",
    grepl("cap|bandana|glove|topi|sarung tangan",nama_produk,ignore.case = T) ~ "Cap, Bandana & Gloves",
    grepl("jacket|sweater|vest|jaket",nama_produk,ignore.case = T) ~ "Jacket, Sweater & Vest",
    grepl("sandal|shoe|sock|sepatu",nama_produk,ignore.case = T) ~ "Sandals & Shoe",
    grepl("watch|case|jam",nama_produk,ignore.case = T) ~ "Watch & Cases",
    grepl("mask|sunglass",nama_produk,ignore.case = T) ~ "Mask & Sunglasses",
    grepl("mukena|sajadah|sarung",nama_produk,ignore.case = T) ~ "Mukena, Sajadah & Sarung"
  )) %>% 
  mutate(kategori = ifelse(is.na(kategori),"Others",kategori)) %>% 
  mutate(rating = as.numeric(rating))

save(data_final,file = "clean.rda")


data_final %>% 
  filter(kategori == "Mukena, Sajadah & Sarung") %>% 
  filter(grepl("eiger",nama_toko,ignore.case = T))




