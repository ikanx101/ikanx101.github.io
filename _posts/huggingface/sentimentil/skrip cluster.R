#system("pip install sentence-transformers")  # Komentar: Baris ini sepertinya tidak dieksekusi karena diawali dengan #. Jika ingin menginstall, hapus tanda pagar.

rm(list=ls())
gc()

# Load necessary libraries
library(reticulate)
library(readr)
library(dplyr)
library(readxl)
library(cluster)
library(factoextra)

# Mengatur lingkungan Python yang akan digunakan. Pastikan path-nya benar.
use_python("/home/ikanx101/.virtualenvs/r-tensorflow/bin/python")
transformers <- reticulate::import("sentence-transformers")

# Membaca data komentar dan melakukan preprocessing sederhana
komen = read_excel("Komentar Nutrifood.xlsx") |> janitor::clean_names()
komen = komen |> select(username,text)
komen = komen |> filter(username != "nutrifood")
komen = komen$text

# Memuat model IndoBERT dan menghitung embedding untuk setiap komentar
model = transformers$SentenceTransformer('firqaaa/indo-sentence-bert-base')
complaint_embeddings <- model$encode(komen)

# Mengubah hasil embedding menjadi matriks numerik
embeddings_matrix <- as.matrix(reticulate::py_to_r(complaint_embeddings))

# Menentukan rentang jumlah cluster yang akan diuji dan menghitung rata-rata silhouette
k_range <- 2:10
avg_sil_widths <- sapply(k_range, function(k) {
  # Melakukan clustering k-means dan menghitung silhouette score untuk setiap nilai k
  kmeans_result <- kmeans(embeddings_matrix, centers = k,iter.max = 50)
  sil <- silhouette(kmeans_result$cluster, dist(embeddings_matrix))
  mean(sil[, 3])
})

# Menentukan jumlah cluster optimal berdasarkan nilai silhouette tertinggi
optimal_k <- k_range[which.max(avg_sil_widths)]

# Melakukan clustering k-means dengan jumlah cluster optimal
kmeans_result <- kmeans(embeddings_matrix, centers = optimal_k,iter.max = 50)

# Membuat data frame hasil clustering
hasil = data.frame(text = komen,cluster = kmeans_result$cluster)

# Menggabungkan komentar dalam setiap cluster
final = hasil |> 
  group_by(cluster) |> 
  summarise(komen = paste(text,collapse = ".")) |> 
  ungroup()

# Menyimpan hasil clustering
save(final,file = "clustered.rda")


