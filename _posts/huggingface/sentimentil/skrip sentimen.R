# system("pip install sentence-transformers")  # Komentar: Baris ini sepertinya tidak dieksekusi karena diawali dengan #. Jika ingin menginstall, hapus tanda pagar.

rm(list=ls())
gc()

# Load necessary libraries
library(reticulate)
library(readr)
library(dplyr)
library(readxl)

# Membacparallel# Membaca data komentar dan melakukan preprocessing sederhana
komen = read_excel("Komentar Nutrifood.xlsx") |> janitor::clean_names()
komen = komen |> select(username,text)
komen = komen |> filter(username != "nutrifood")
komen = komen$text


# Mengatur lingkungan Python yang akan digunakan. Pastikan path-nya benar.
use_python("/home/ikanx101/.virtualenvs/r-tensorflow/bin/python")
transformers <- import("transformers")

pipe <- transformers$pipeline(
  "text-classification",
  model = "ayameRushia/roberta-base-indonesian-1.5G-sentiment-analysis-smsa"
)

hitung_sentimen = function(input){
  result = pipe(input)
  data.frame(sentimen = result[[1]]$label,
             peluang  = result[[1]]$score)
}

temp = vector("list",length(komen))
for(i in 1:length(komen)){
  temp[[i]] = hitung_sentimen(komen[i])
  print(i)
}

hasil = data.table::rbindlist(temp) |> as.data.frame() |> mutate(teks = komen)
save(hasil,file = "senti.rda")
