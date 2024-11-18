rm(list=ls())
gc()

# Load necessary libraries
library(reticulate)
library(readr)
library(dplyr)
library(readxl)
library(cluster)
library(factoextra)
library(parallel)
ncore = detectCores()

# Membaca data komentar dan melakukan preprocessing sederhana
file  = list.files(pattern = "*csv")
df    = mclapply(file,read.csv,mc.cores = ncore)
df    = data.table::rbindlist(df,fill = T) |> as.data.frame()

komen = df |> janitor::clean_names()
komen = komen |> pull(judul) |> unique() |> sort()

save(komen,file = "to colab.rda")

# python3 -m venv blog
# source blog/bin/activate


# Mengatur lingkungan Python yang akan digunakan. Pastikan path-nya benar.
# use_python("~/.virtualenvs/r-reticulate/bin/python")
# use_python()
# system("pip install sentence-transformers")  # Komentar: Baris ini sepertinya tidak dieksekusi karena diawali dengan #. Jika ingin menginstall, hapus tanda pagar.
# py_config()
# py_available()

# Install Python package into virtual environment
# reticulate::py_install("transformers", pip = TRUE)
# reticulate::py_install("sentence-transformers", pip = TRUE)

# Also installing pytorch just as a contingency?
# reticulate::py_install(c("torch", "sentencepiece"), pip = TRUE)
# transformers <- reticulate::import("sentence-transformers")

# Memuat model IndoBERT dan menghitung embedding untuk setiap komentar
# model = transformers$SentenceTransformer('firqaaa/indo-sentence-bert-base')
# complaint_embeddings <- model$encode(komen)

# Mengubah hasil embedding menjadi matriks numerik
# embeddings_matrix <- as.matrix(reticulate::py_to_r(complaint_embeddings))



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


