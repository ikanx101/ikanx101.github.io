library(raster)
library(sp)
library(dplyr)
library(readxl)

rm(list=ls())
setwd("~/gmaps_scraper/Uji Coba RASTER")

df = read_excel("Data Scrape Koperasi.xlsx")

### Getting the brazil shapefile
indo_data = getData('GADM', country = 'Indonesia', level = 3, type = "sp")

### Extracting the attributes from the shapefile for the given points
city_names = extract(indo_data, df[, c("lon", "lat")])
kota       = city_names$NAME_2
kecamatan  = city_names$NAME_3

### Adding the city names to the Brazil data frame, with the coordinates
df$kota      = kota
df$kecamatan = kecamatan

save(df,file = "bahan post.rda")