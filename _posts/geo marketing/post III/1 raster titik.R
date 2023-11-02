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

rm(list=ls())
setwd("~/ikanx101.github.io/_posts/geo marketing/post III")
# ==============================================================================


# ==============================================================================
# ambil data
df = read_excel("dbase pasar done.xlsx")


df_sel = 
  df %>% 
  filter(grepl("bekasi",kabupaten,ignore.case = T))




# hanya ambil padang, warteg, dan bakso/mie ayam
df_sel = 
  df %>% 
  rename(resto = nama_halte) %>% 
  filter(grepl("warteg|tegal|bahari|mi ayam|mie|baso|bakso|padang|minang",
               resto,
               ignore.case = T)) %>% 
  mutate(kategori = case_when(
    grepl("padang|minang",resto,ignore.case = T) ~ "Padang",
    grepl("mi ayam|mie|bakso|baso",resto,ignore.case = T) ~ "Bakso/Mie Ayam",
    grepl("warteg|tegal|bahari",resto,ignore.case = T) ~ "Warung Tegal"
  ))

# mengambil shapefile indonesia
# indo_data = getData('GADM', country = 'Indonesia', level = 3, type = "sp")
# untuk load datanya silakan
# indo_data = readRDS("gadm36_IDN_3_sp.rds")
# ==============================================================================


# ==============================================================================
# Extracting the attributes from the shapefile for the given points
city_names = extract(indo_data, # ini data referensinya
                     df_sel[, c("lon", "lat")]) # ini data hasil seleksinya
kota       = city_names$NAME_2
kecamatan  = city_names$NAME_3

# Adding the city names to the data frame, with the coordinates
df_sel$kota      = kota
df_sel$kecamatan = kecamatan
# ==============================================================================


# ==============================================================================
# kita akan ambil hanya bekasi
df_post = 
  df_sel %>% 
  filter(grepl("kota bekasi",kota,ignore.case = T)) 

save(df_post,file = "bahan post.rda")