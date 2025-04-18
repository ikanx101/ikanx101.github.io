rm(list=ls())
gc()

set.seed(20921004)

# Load necessary libraries
library(reticulate)
library(readr)
library(dplyr)
library(readxl)
library(cluster)
library(factoextra)
library(parallel)
library(tidytext)
library(ggraph)
library(igraph)
ncore = detectCores()

stop = readLines("https://raw.githubusercontent.com/stopwords-iso/stopwords-id/master/stopwords-id.txt")


# Membaca data komentar dan melakukan preprocessing sederhana
file  = list.files(pattern = "*csv")
df    = mclapply(file,read.csv,mc.cores = ncore)
df    = data.table::rbindlist(df,fill = T) |> as.data.frame()

komen = df |> janitor::clean_names()
komen = komen |> pull(judul) |> unique() |> sort()

input = data.frame(id = 1:length(komen),text = komen)

pre_data =
  input %>%
  unnest_tokens("words",text) %>%
  filter(!words %in% stop) %>% 
  filter(stringr::str_length(words) > 3) %>% 
  group_by(id) %>% 
  summarise(komen = paste(words,collapse = " ")) %>% 
  ungroup()

komen = pre_data$komen

# save(komen,file = "to colab.rda")

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


load("to blog.rda")


pca <- prcomp(embeddings_matrix, center = TRUE, scale. = TRUE)
pca_data <- as.data.frame(pca$x[,1:2])
#pca_data$cluster <- factor(complaints$cluster)

summary(pca) |> head()


ggplot(pca_data, aes(x = PC1, y = PC2
                     #color = cluster
)) +
  geom_point() +
  theme_minimal() +
  labs(title = "PCA dari 20 Komplain", x = "PC1", y = "PC2")


# kita coba dengan pendekatan lainnya
library(Rtsne)

tsne_model <- Rtsne(embeddings_matrix, 
                    dims = 2, 
                    perplexity = 30, 
                    theta = 0.5, max_iter = 1000,
                    check_duplicates = FALSE)

tsne_data <- data.frame(x = tsne_model$Y[, 1], y = tsne_model$Y[, 2])
ggplot(tsne_data, aes(x = x, y = y)) + geom_point()



library(factoextra)
library(fpc)

set.seed(240)  # Setting seed
dist.mat  <- dist(tsne_data,method = "euclidean")
# dist.mat  <- dist(embeddings_matrix,method = "euclidean")

Hierar_cl <- hclust(dist.mat, method = "ward.D2")
plot(Hierar_cl)

fit = cutree(Hierar_cl, k = 22)
plot(Hierar_cl)
rect.hclust(Hierar_cl, k = 22, border = "red")

tsne_data$cluster = fit
plot_tsne = ggplot(tsne_data, aes(x = x, y = y,color = as.factor(cluster))) + geom_point()

# Membuat data frame hasil clustering
keperluan_blog = data.frame(judul_asli = komen,cluster = fit)

# Menggabungkan komentar dalam setiap cluster
final = keperluan_blog |> 
  group_by(cluster) |> 
  summarise(komen = paste(judul_asli,collapse = ".")) |> 
  ungroup()






# ggplot(pca_data, aes(x = PC1, y = PC2,color = as.factor(fit) 
#                      #color = cluster
# )) +
#   geom_point() +
#   theme_minimal() +
#   labs(title = "PCA dari 20 Komplain", x = "PC1", y = "PC2")


# Menyimpan hasil clustering
save(df,pre_data,komen,plot_tsne,keperluan_blog,final,file = "clustered 2.rda")





