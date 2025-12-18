rm(list = ls())
gc()

# Skrip untuk menghasilkan 500 titik koordinat acak di Kota Bekasi
# Batas wilayah didasarkan pada data dari Pemerintah Kota Bekasi[citation:8]

# 1. Tentukan batas wilayah dalam derajat desimal
# Batas Bujur Timur (Longitude)
lon_min <- 106.905391
lon_max <- 107.044101

# Batas Lintang Selatan (Latitude)
# Karena lintang selatan bernilai negatif, nilai numerik yang lebih besar (kurang negatif) adalah batas utara.
lat_north <- -6.179323
lat_south <- -6.327506

# 2. Set seed untuk hasil yang dapat direproduksi (opsional)
# Hapus atau ubah angka ini jika menginginkan hasil acak yang berbeda setiap kali
set.seed(12345)

# 3. Buat 500 titik acak dengan distribusi seragam
# Jumlah titik yang diminta
n_points <- 800

# Generate angka acak
random_longitudes <- runif(n = n_points, min = lon_min, max = lon_max)
random_latitudes <- runif(n = n_points, min = lat_south, max = lat_north)

# 4. Gabungkan menjadi sebuah data frame
bekasi_random_points <- data.frame(
  id = 1:n_points,
  longitude = random_longitudes,
  latitude = random_latitudes
)

library(tidygeocoder)
reverse_geo_code = reverse_geo(lat = bekasi_random_points$latitude,
                               long = bekasi_random_points$longitude,
                               method = "arcgis",
                               address = "address",
                               full_results = T)


# ini finalnya
final = 
  reverse_geo_code %>% 
  select(lat,long,address,Neighborhood,City,MetroArea,Subregion,Region,Postal)

# kita gabung dulu ya
final_export = 
  data.frame(bekasi_random_points,final) |> 
  arrange(Neighborhood,City,MetroArea,Subregion,Region) %>% 
  janitor::clean_names() %>% 
  filter(region != "DKI Jakarta") %>% 
  filter(grepl("bekasi",subregion,ignore.case = T))

final_export %>% janitor::tabyl(subregion)

bekasi_random_points = final_export

# 6. (Opsional) Simpan ke file CSV
write.csv(bekasi_random_points, "titik_acak_bekasi.csv", row.names = FALSE)
cat("\nSeluruh 500 titik telah disimpan dalam file 'titik_acak_bekasi.csv' di direktori kerja Anda.\n")

# 7. (Opsional) Plot sederhana untuk visualisasi
# Pastikan paket 'leaflet' sudah terinstal: install.packages("leaflet")
library(leaflet)
leaflet(bekasi_random_points) %>%
  addTiles() %>%
  addCircleMarkers(lng = ~longitude, lat = ~latitude,
                   radius = 3, color = "red",
                   popup = ~paste("ID:", id, "<br>Lon:", round(longitude,4), "<br>Lat:", round(latitude,4)))
