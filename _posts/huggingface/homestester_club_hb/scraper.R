rm(list=ls())
gc()

library(dplyr)
library(rvest)
library(parallel)

ncore = detectCores()

setwd("~/playwright-scraper/saved_pages")

files = "hometesterclub.com_id_id_reviews_heavenly-blush_20250325020255900.html"

baca =   
  files %>% 
  read_html() 

komen = 
  baca %>% 
  html_nodes(".mui-style-d2z1fp") %>% 
  html_text()
komen = komen[komen != ""]
komen = gsub("[\r\n]", " ", komen)
komen = stringr::str_trim(komen)
x_len = stringr::str_length(komen)
komen = komen[x_len > 5]

user = 
  baca %>% 
  html_nodes(".mui-style-9jay18") %>% 
  html_text()
user = gsub("Review|•","+",user)

input = user[22]

rapikan = function(input){
  temp      = strsplit(input,split = "\\+") %>% unlist()
  n_temp    = length(temp)
  tanggal   = stringr::str_trim(temp[n_temp])
  if(n_temp >= 3){
    kota_asal = stringr::str_trim(temp[n_temp-1])
    n_reviews = stringr::str_trim(temp[n_temp-2])
  }
  if(n_temp < 3){kota_asal = NA;n_reviews = NA}
  output    = 
    data.frame(kota_asal,n_reviews,tanggal) %>% 
    mutate(tanggal   = as.Date(tanggal,"%d/%m/%Y"),
           n_reviews = as.numeric(n_reviews))
  # keluarkan output
  return(output)
}


tempo = mclapply(user,rapikan,mc.cores = ncore)
tempo = data.table::rbindlist(tempo) %>% as.data.frame() %>% mutate(komen = komen)

setwd("~/ikanx101.github.io/_posts/huggingface/homestester club heavenly blush")

df = 
  tempo %>% 
  mutate(n_reviews = ifelse(is.na(n_reviews),kota_asal,n_reviews),
         n_reviews = as.numeric(n_reviews)) %>% 
  mutate(kota_grup = case_when(
    grepl("jakarta|bekasi|tangerang|depok|bogor",kota_asal,ignore.case = T) ~ "Jabodetabek",
    grepl("Semarang|Surakarta|Solo|Tegal|Pekalongan|Magelang|Salatiga|Yogyakart|jogja",kota_asal,ignore.case = T) ~ "Jateng-Jogja",
    grepl("Bandung||Cimahi|Sukabumi|Cirebon|Banjar|Tasikmalaya",kota_asal,ignore.case = T) ~ "Jabar",
    grepl("Badung|denpasar|Gianyar|Jembrana|Karangasem|Klungkung|Tabanan|Buleleng|Bangli",kota_asal,ignore.case = T) ~ "Bali",
    grepl("Surabaya|Malang|Kediri|Blitar|Madiun|Mojokerto|Pasuruan|Probolinggo|Batu",kota_asal,ignore.case = T) ~ "Jatim",
    grepl("Banda Aceh|Lhokseumawe|Langsa|Subulussalam|Medan|Binjai|Tebing Tinggi|Pematangsiantar|Tanjungbalai|Sibolga|Padangsidimpuan|Gunung Sitoli|Padang|Bukittinggi|Payakumbuh|Solok|Sawahlunto|Pariaman|Pekanbaru|Dumai|Jambi|Sungai Penuh|Palembang|Lubuklinggau|Pagar Alam|Prabumulih|Bengkulu|Bandar Lampung|Metro|Pangkalpinang",kota_asal,ignore.case = T) ~ "Sumatera"
  )) %>% 
  mutate(kota_grup = ifelse(is.na(kota_grup),"Others",kota_grup))

save(df,file = "ready.rda")




