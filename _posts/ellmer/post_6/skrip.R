rm(list=ls())

library(dplyr)
library(tidyr)
library(parallel)
library(ellmer)
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


