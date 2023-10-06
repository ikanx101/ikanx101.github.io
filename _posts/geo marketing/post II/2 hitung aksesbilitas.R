# ==============================================================================
#
# ikanx101.com
# geomarketing tempat makan di bekasi
#
# ==============================================================================


# ==============================================================================
# load libraries
library(raster)
library(sp)
library(dplyr)
library(readxl)
library(leaflet)
library(parallel)

rm(list=ls())
setwd("~/ikanx101.github.io/_posts/geo marketing/post II")
load("bahan post.rda")
indo_data = readRDS("gadm36_IDN_3_sp.rds")
num_core  = 7
# ==============================================================================


# ==============================================================================
# kita akan generate berapa banyak konsumen
n_gen = 2000
df_gen = 
  data.frame(lat = runif(n_gen,-6.4013574008921275,-6.167170277078308),
             lon = runif(n_gen,106.90010168410983,107.04498466868782))

# kita ambil dulu nama kota dari yang digenerate
city_names = extract(indo_data, # ini data referensinya
                     df_gen[, c("lon", "lat")]) # ini data hasil seleksinya
kota       = city_names$NAME_2
df_gen$kt  = kota

df_gen = df_gen %>% filter(grepl("kota bekasi",kota,ignore.case = T)) 

# bikin peta biar keliatan
leaflet(df_gen) %>%
  addTiles() %>%
  addCircleMarkers(lng = ~lon,
                   lat = ~lat,
                   radius = 3)
# ==============================================================================


# ==============================================================================
# jadi ada dua data nih
# data konsumen di df_gen
# data resto di df_post
# kita pisah dulu per data
df_padang = df_post %>% filter(grepl("padang",kategori,ignore.case = T))
df_warteg = df_post %>% filter(grepl("tegal",kategori,ignore.case = T))
df_bakso  = df_post %>% filter(grepl("bakso",kategori,ignore.case = T))

# kita bikin function euclidian distance
euclid = function(x1,x2,y1,y2){
  sqrt((x1-x2)^2 + (y1-y2)^2)
}
# ==============================================================================


# ==============================================================================
# kita hitung padang
# kita bikin function untuk menghitung aksesbility
aksesbility = function(input){
  resp = input[[1]]$Var1
  pada = input[[1]]$Var2
  
  euclid(df_gen$lat[resp],df_padang$lat[pada],
         df_gen$lon[resp],df_padang$lon[pada])
  
}

# semua kombinasi padang
id_resp   = 1:nrow(df_gen)
id_padang = 1:nrow(df_padang)
proses    = expand.grid(id_resp,id_padang)

input_padang = vector("list",nrow(proses))
for(ikanx in 1:nrow(proses)){
  input_padang[[ikanx]] = list(proses[ikanx,])
}

akses_padang = mclapply(input_padang,aksesbility,mc.cores = num_core)
akses_padang = unlist(akses_padang)

# kita akan hitung jarak terpendek per customer
hitung_padang = 
  proses %>% 
  mutate(akses_padang = akses_padang) %>% 
  rename(konsumen = Var1) %>% 
  group_by(konsumen) %>% 
  summarise(akses_padang = min(akses_padang)) %>% 
  ungroup()
# ==============================================================================


# ==============================================================================
# kita hitung warteg
# kita bikin function untuk menghitung aksesbility
aksesbility = function(input){
  resp = input[[1]]$Var1
  pada = input[[1]]$Var2
  
  euclid(df_gen$lat[resp],df_warteg$lat[pada],
         df_gen$lon[resp],df_warteg$lon[pada])
  
}

# semua kombinasi padang
id_resp   = 1:nrow(df_gen)
id_warteg = 1:nrow(df_warteg)
proses    = expand.grid(id_resp,id_warteg)

input_warteg = vector("list",nrow(proses))
for(ikanx in 1:nrow(proses)){
  input_warteg[[ikanx]] = list(proses[ikanx,])
}

akses_warteg = mclapply(input_warteg,aksesbility,mc.cores = num_core)
akses_warteg = unlist(akses_warteg)

# kita akan hitung jarak terpendek per customer
hitung_warteg = 
  proses %>% 
  mutate(akses_warteg = akses_warteg) %>% 
  rename(konsumen = Var1) %>% 
  group_by(konsumen) %>% 
  summarise(akses_warteg = min(akses_warteg)) %>% 
  ungroup()
# ==============================================================================


# ==============================================================================
# kita hitung bakso
# kita bikin function untuk menghitung aksesbility
aksesbility = function(input){
  resp = input[[1]]$Var1
  pada = input[[1]]$Var2
  
  euclid(df_gen$lat[resp],df_bakso$lat[pada],
         df_gen$lon[resp],df_bakso$lon[pada])
  
}

# semua kombinasi padang
id_resp   = 1:nrow(df_gen)
id_bakso  = 1:nrow(df_bakso)
proses    = expand.grid(id_resp,id_bakso)

input_bakso = vector("list",nrow(proses))
for(ikanx in 1:nrow(proses)){
  input_bakso[[ikanx]] = list(proses[ikanx,])
}

akses_bakso = mclapply(input_bakso,aksesbility,mc.cores = num_core)
akses_bakso = unlist(akses_bakso)

# kita akan hitung jarak terpendek per customer
hitung_bakso = 
  proses %>% 
  mutate(akses_bakso = akses_bakso) %>% 
  rename(konsumen = Var1) %>% 
  group_by(konsumen) %>% 
  summarise(akses_bakso = min(akses_bakso)) %>% 
  ungroup()
# ==============================================================================


save(df_gen,
     hitung_padang,
     hitung_warteg,
     hitung_bakso,
     file = "akses.rda")