rm(list=ls())

library(dplyr)
library(tidyr)
library(parallel)
library(ellmer)
library(janitor)
ncore = 5

# ==============================================================================
# working directory
setwd("~/ikanx101.github.io/_posts/huggingface/alodokter")

# ambil semua file csv
csvs = list.files(pattern = "csv")

# bikin function ambil data csv dulu
ambilin = function(input){
  read.csv(input) |> janitor::clean_names()
}

# baca semua file csv
temp = mclapply(csvs,ambilin,mc.cores = ncore)

# kita gabung dulu
df = data.table::rbindlist(temp,fill = T) |> as.data.frame() |> distinct()
# ==============================================================================


# ==============================================================================
# ganti lagi working directory ke awal
setwd("~/ikanx101.github.io/_posts/ellmer/post_6")

# bikin prompt awal
prompt_viz =
  stringr::str_squish("Kamu adalah expert dalam bahasa Indonesia. User akan memberikan satu buah pertanyaan. Tugas kamu adalah menilai apakah pertanyaan tersebut bernada:
  
  1. CEMAS
  2. BINGUNG
  3. OPTIMIS
  
  Berikan jawaban secara singkat dengan menuliskan jawabannya saja! Tidak perlu penjelasan.
                      ")

# kita bikin agent
model_1 = "deepseek-chat"
chat = chat_deepseek(system_prompt = prompt_viz,
                     model         = model_1)
# ==============================================================================


# ==============================================================================
# sekarang kita bikin untuk semuanya
hasil_analisa = rep("na",nrow(df))
for(ikanx in 1:nrow(df)){
  input = df$konten[ikanx]
  hasil_analisa[ikanx] = chat$chat(input)
  print(ikanx)
}

df$psikologi = hasil_analisa
# ==============================================================================


# ==============================================================================
# ALASAN CEMAS

# bikin prompt awal
prompt_viz =
  stringr::str_squish("Kamu adalah expert dalam bahasa Indonesia. User akan memberikan kumpulan dari banyak pertanyaan. Tugas kamu adalah:
  
  Gunakan teknik seperti keyword extraction, topic modeling, atau clustering untuk menemukan tema dominan. Cari tahu apa yang membuat orang merasa cemas dari pertanyaan-pertanyaan yang diajukan! Jangan dicampur antara cemas dan bingung!
  
  Jawab secara singkat maksimum dalam 5 poin-poin saja.
                      ")

# kita bikin agent
model_1 = "deepseek-chat"
chat = chat_deepseek(system_prompt = prompt_viz,
                     model         = model_1)

tanya = 
  df |> 
  filter(psikologi == "CEMAS") |> 
  summarise(gabung = paste(konten,collapse = ". ")) |> 
  pull(gabung)

alasan_cemas = chat$chat(tanya)
# ==============================================================================



# ==============================================================================
# ALASAN BINGUNG

# bikin prompt awal
prompt_viz =
  stringr::str_squish("Kamu adalah expert dalam bahasa Indonesia. User akan memberikan kumpulan dari banyak pertanyaan. Tugas kamu adalah:
  
  Gunakan teknik seperti keyword extraction, topic modeling, atau clustering untuk menemukan tema dominan. Cari tahu apa yang membuat orang merasa bingung dari pertanyaan-pertanyaan yang diajukan! Jangan dicampur antara cemas dan bingung!
  
  Jawab secara singkat maksimum dalam 5 poin-poin saja.
                      ")

# kita bikin agent
model_1 = "deepseek-chat"
chat = chat_deepseek(system_prompt = prompt_viz,
                     model         = model_1)

tanya = 
  df |> 
  filter(psikologi == "BINGUNG") |> 
  summarise(gabung = paste(konten,collapse = ". ")) |> 
  pull(gabung)

alasan_bingung = chat$chat(tanya)
# ==============================================================================


# ==============================================================================
# ALASAN BINGUNG

# bikin prompt awal
prompt_viz =
  stringr::str_squish("Kamu adalah ahli komunikasi kesehatan yang hebat dan berpengalaman. User akan memberikan input berupa hasil analisa dari target market. Berikan saran lengkap dan spesifik bagaimana membuat health campaign dari informasi itu.
  
  Jawab secara singkat dalam maksimal 5 poin saja.
                      ")

# kita bikin agent
model_1 = "deepseek-chat"
chat = chat_deepseek(system_prompt = prompt_viz,
                     model         = model_1)

marketing_cemas   = chat$chat(alasan_cemas)
marketing_bingung = chat$chat(alasan_bingung)

# ==============================================================================



save(df,tanya,
     alasan_bingung,
     alasan_cemas,
     marketing_cemas,
     marketing_bingung,
     file = "hasil.rda")




