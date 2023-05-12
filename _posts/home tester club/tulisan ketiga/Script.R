rm(list=ls())

setwd("~/ikanx101.github.io/_posts/home tester club/tulisan ketiga")

library(dplyr)
library(tidyr)
library(tidytext)
library(igraph)
library(ggplot2)
library(ggraph)

# ==============================================
# ambil data yang telah didapatkan
saved_rda = "hasil komen.rda"
load(saved_rda)

# kita simpan dulu data frame nya
df = data.frame(komen = c(temp[[1]],
                          temp[[2]],
                          temp[[3]]))
df$resp_id = 1:nrow(df)

# kita ambil stopwords
stop = readLines("https://raw.githubusercontent.com/ikanx101/ID-Stopwords/master/id.stopwords.02.01.2016.txt")
stop = c(stop,"yang","saya","aku","ini","untuk","sedang","lagi","karena",
         "ingin","tapi","yg","yang","ga","nggak","gak")

# kita pecah perkalimat ya
df = 
  df |>
  mutate(komen = tolower(komen),
         komen = stringr::str_trim(komen)) |>
  mutate(komen = gsub("[[:punct:]]|\\n|\\r|\\t"," ",komen),
         komen = stringr::str_trim(komen)) |>
  unnest_tokens("words",komen) |>
  filter(!words %in% stop)

# kita simpan dulu ya
raw = 
  df |> 
  group_by(resp_id) |> 
  summarise(komen = paste(words,collapse = " ")) |>
  ungroup()

# kita pecah per id dulu
temp = 
  df |>
  group_by(resp_id,words) |>
  tally() |>
  ungroup() |>
  group_split(resp_id)

# kita ambil function untuk ambil 10 teratas
ambil_teratas = function(list){
  list |>
    arrange(desc(n)) |>
    head(3)
}  

# ini adalah proses mencari yang tertinggi saja
library(parallel)
num_cores = detectCores()
hasil = mclapply(temp,ambil_teratas,mc.cores = num_cores)

# kita gabung lagi
matriks = 
  do.call(rbind,hasil) |>
  reshape2::dcast(resp_id ~ words,
                  value.var = "n",fun.aggregate = sum)

matriks

library(factoextra)

dist(matriks,method = "euclidean")

library(stringdist)
library(stringr)

produk_raw = c("Kecap Manis Jerigen 10l","Kecap Manis Jerigen 10l Free Piring Cantik Selusin",
               "Kecap Asin Pouch 5.2Kg","Kecap Asin Pouch 5.2Kg - 3 Pouch")
produk = janitor::make_clean_names(produk_raw)
produk = gsub("\\_","",produk)

matriks = stringsimmatrix(produk,method = "cosine")
matriks = as.matrix(matriks)
sim_matrix = round(matriks,3)
sim_matrix[lower.tri(sim_matrix)] = 0
diag(sim_matrix) = 0

elbow = fviz_nbclust(matriks, kmeans, method = "wss")
# png("elbow.png")
plot(elbow)
# dev.off()







# ==============================================
# kita buat grafik bigram dulu
bigram_plot = 
  raw |>
  unnest_tokens("bigrams",komen,token = "ngrams",n = 2) |>
  group_by(bigrams)|>
  tally(sort = T) |>
  ungroup() |>
  head(30) |>
  separate(bigrams,into = c("from","to"),sep = " ") %>% 
  graph_from_data_frame() %>% 
  ggraph(layout = 'fr') +
  geom_edge_bend(aes(edge_alpha=n),
                 show.legend = F,
                 color='darkred') +
  geom_node_point(size=1,color='steelblue') +
  geom_node_text(aes(label=name),alpha=0.4,size=3,repel = T) +
  theme_void()


save(bigram_plot,raw,df,matriks,file = "all related.rda")