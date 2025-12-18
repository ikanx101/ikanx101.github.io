rm(list=ls())
gc()

library(tidyverse)
library(readxl)
library(leaflet)
library(osrm) 
library(parallel)

ncore = detectCores()

setwd("~/ikanx101.github.io/_posts/geo marketing/laundry")

# ambil titik laundry
file = "laundry.xlsx"
df = read_excel(file) %>% filter(region != "DKI Jakarta")

# leaflet laundry
leaflet(df) %>%
  addTiles() %>%
  addCircleMarkers(lng = ~long, lat = ~lat,
                   radius = 5, color = "steelblue")

# ambil titik pelanggan
df_pelanggan = 
  read.csv("titik_acak_bekasi.csv") %>% 
  filter(grepl("kota bekasi",subregion,ignore.case = T))

# leaflet pelanggan
leaflet(df_pelanggan) %>%
  addTiles() %>%
  addCircleMarkers(lng = ~longitude, lat = ~latitude,
                   radius = 3, color = "red",
                   popup = ~paste("ID:", id, "<br>Lon:", round(longitude,4), "<br>Lat:", round(latitude,4)))

# function untuk menghitung jarak
# cara kerjanya dengan menggunakan id
hitung_jarak = function(input){
  # id pelanggan
  x = input$id_pelanggan
  # id laundry
  y = input$id_laundry
  
  # kita tetapkan pelanggan
  pelanggan = c(df_pelanggan$long[x], df_pelanggan$lat[x])
  laundry = c(df$long[y], df$lat[y])
  
  # perhitungan jarak tempuh berdasarkan osm
  hasil = 
    osrm::osrmRoute(src = pelanggan,
                    dst = laundry,
                    overview = "full",
                    osrm.profile	= "bike")
  # hanya ambil jarak
  output = hasil$distance
  return(output)
}

# kita mulai bangun perhitungan jaraknya
id_pelanggan = 1:nrow(df_pelanggan)
id_laundry = 1:nrow(df)

# kita bentuk dulu tarjeta amarilla
df_target = 
  expand_grid(id_pelanggan,id_laundry) %>% 
  as.data.frame() %>%
  mutate(id = 1:126665) %>% 
  group_split(id)

# multiple cores
jarak = mclapply(df_target,hitung_jarak,mc.cores = ncore)
