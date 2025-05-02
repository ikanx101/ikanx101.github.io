rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(rvest)
library(parallel)

ncore = detectCores()

setwd("~/ikanx101.github.io/_posts/web scraping/post_12_toreiger/saved/saved_pages")

files = list.files(full.names = T)

i = 10
url = files[i]

ambilin = function(url){
  baca = url %>% read_html() 
  
  nama_produk = 
    baca %>% 
    html_nodes(".css-pq4vhy") %>% 
    html_text()
  
  harga = 
    baca %>% 
    html_nodes(".css-1fug3np") %>% 
    html_text()
  
  rating_terjual = 
    baca %>%  
    html_nodes(".css-yaxhi2") %>% 
    html_text()
  
  nama_toko = 
    baca %>% 
    html_nodes(".css-k0cj6p") %>% 
    html_text()
  
  output = data.frame(nama_produk,harga,rating_terjual,nama_toko)
  
  return(output)
}

# ambilin(url)

# kita randomized dulu
bilangan = 1:length(files)

# Acak urutan bilangan
bilangan_acak <- sample(bilangan)

# Bagi menjadi 70 kelompok
jumlah_kelompok <- round(length(files) / (ncore * .5),0)
kelompok <- split(bilangan_acak, cut(seq_along(bilangan_acak), jumlah_kelompok))

# kita mulai loopingnya
for(i in 1:jumlah_kelompok){
  nama_file = paste0("df_final_",i)
  df_input  = files[kelompok[[i]]]
  df_output = mclapply(df_input,ambilin,mc.cores = ncore)
  df        = data.table::rbindlist(df_output,fill = T) %>% as.data.frame() %>% distinct()
  
  assign(nama_file,
         df)
  print(paste0(i," done"))
}


# Buat list kosong untuk menampung hasil penggabungan
temp <- list()

# Loop untuk menambahkan setiap data frame ke dalam list
for (i in 1:jumlah_kelompok) {
  temp[[i]] <- get(paste0("df_final_", i))
  print(i)
}

df = data.table::rbindlist(temp) %>% as.data.frame() %>% distinct() %>% filter(!is.na(nama_produk))

setwd("~/ikanx101.github.io/_posts/web scraping/post_12_toreiger")

save(df,file = "data.rda")
# unlink(files)
# openxlsx::write.xlsx(df,file = "sampel.xlsx")






