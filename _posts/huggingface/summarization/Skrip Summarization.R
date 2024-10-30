# mulai dari awal
setwd("~/ikanx101.github.io/_posts/huggingface/summarization")
rm(list=ls())

# libraries
library(dplyr)
library(tidytext)
library(stringdist)
library(TSP)

data = "Sering mengalami gangguan sinyal saat berada di dalam gedung atau area tertentu.; Kuota sering habis lebih cepat dari yang diharapkan, meskipun penggunaannya terbilang normal.; Semoga XL dapat meningkatkan kualitas jaringan di daerah-daerah yang masih kurang stabil.; Perlu ada peningkatan kecepatan upload, terutama untuk pengguna yang sering mengunggah konten.; Sering mengalami kesulitan saat melakukan panggilan video dengan kualitas yang baik.; Layanan pelanggan XL cukup responsif dalam mengatasi masalah yang saya hadapi.; Harganya bisa lebih terjangkau lagi, terutama untuk paket data dengan kuota besar.; Sering mengalami gangguan sinyal saat cuaca buruk.; Perlu ada promo yang lebih menarik untuk pelanggan setia.; Aplikasi XL Center seringkali mengalami error saat digunakan."

# data awal
data = data.frame(id_paragraf = c(1:length(data)),
                  paragraf = trimws(data))

# data referensi
referensi = 
  data %>% 
  unnest_tokens(kalimat,paragraf,token = "regex",pattern = "\\.") %>% 
  mutate(id_kalimat = c(1:length(kalimat)),
         kalimat = trimws(kalimat))

# ===================================
# hitung score
# stop words
stop = stop_words$word

# fungsi stemming
stem_ikanx = function(kata){
  hasil = tm::stemDocument(kata)
  return(hasil)
}

# process hitung score
stem_data = 
  referensi %>% 
  mutate(kalimat = janitor::make_clean_names(kalimat),
         kalimat = gsub("\\_"," ",kalimat)) %>% 
  unnest_tokens(kata,kalimat,"words") %>% 
  filter(!kata %in% stop) %>% 
  mutate(penanda = as.numeric(kata)) %>% 
  filter(is.na(penanda)) %>% 
  select(-penanda)
# stemming
stem_data$word_stemmed = sapply(stem_data$kata,stem_ikanx)  
# hitung score
dbase_score = 
  stem_data %>% 
  filter(!is.na(word_stemmed)) %>% 
  group_by(word_stemmed) %>% 
  count(sort = T) %>% 
  ungroup() %>% 
  mutate(score = n/sum(n))

# kita kembalikan dan hitung score dari kalimat
hasil = 
  stem_data %>% 
  filter(!is.na(word_stemmed)) %>% 
  merge(dbase_score) %>% 
  group_by(id_paragraf,id_kalimat) %>% 
  summarise(kalimat = paste(word_stemmed,collapse = " "),
            score = sum(score)/n()) %>% 
  ungroup()

# hanya mengambil kalimat dengan nilai terbaik 
hasil_importance = hasil
matrix           = stringdist::stringsimmatrix(hasil_importance$kalimat,
                                               method = "cosine")

# perhitungan degree
hasil_importance$degree_kalimat = sna::evcent(matrix)

hasil_new = 
  hasil_importance %>% 
  group_by(id_paragraf) %>% 
  mutate(mean_degree = median(degree_kalimat),
         mean_score  = median(score)) %>% 
  ungroup() %>%
  rowwise() %>% 
  filter(degree_kalimat > mean_degree & score > mean_score) %>% 
  ungroup()

summary_all = 
  referensi %>% 
  filter(id_kalimat %in% hasil_new$id_kalimat) %>% 
  summarise(all = paste(kalimat,collapse = ". "))

kesimpulan = trimws(summary_all$all)
kesimpulan = gsub('\\[([0-9]+)\\]', '', kesimpulan)

sink("hasil_summarizing_.txt")
print(kesimpulan)
sink()