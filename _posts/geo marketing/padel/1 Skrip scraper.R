rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(googleway)

setwd("~/ikanx101.github.io/_posts/geo marketing/padel")

key = "rahasia"

carikan = "padel in Rawalumbu Bekasi"
berapa_page = 10

# ini pencarian pertama
hasil = google_places(search_string = carikan,
                      key = key)
hasil_1 = hasil$results

# ini untuk bersihin tipe tempat
tipe_tempat = c()
for(ulang in 1:nrow(hasil_1)){
  temporary = hasil_1$types[ulang] %>% unlist()
  tipe_tempat[ulang] = paste(temporary[1:2],collapse = ";")
}

# kita save hasil pencarian pertama
output  = data.frame(
  nama = hasil_1$name,
  alamat = hasil_1$formatted_address,
  long = hasil_1$geometry$location$lng,
  lat = hasil_1$geometry$location$lat,
  rating = hasil_1$rating,
  user_rating = hasil_1$user_ratings_total,
  tipe = tipe_tempat,
  place_id = hasil_1$place_id
)

# kita kasih jeda dulu
Sys.sleep(runif(1,2,4))

# buat rumah dulu
rumah_kita = list()

# nah, berikutnya kita loop sampe gila
for(ikanx in 1:berapa_page){
  # ini pencarian berikutnya
  print(hasil$next_page_token)
  
  hasil = google_places(search_string = carikan,
                        page_token = hasil$next_page_token,
                        key = key)
  hasil_1 = hasil$results
  
  # ini untuk bersihin tipe tempat
  tipe_tempat = c()
  for(ulang in 1:nrow(hasil_1)){
    temporary = hasil_1$types[ulang] %>% unlist()
    tipe_tempat[ulang] = paste(temporary[1:2],collapse = ";")
  }
  
  # kita simpan as dataframe
  temp  = data.frame(
    nama = hasil_1$name,
    alamat = hasil_1$formatted_address,
    long = hasil_1$geometry$location$lng,
    lat = hasil_1$geometry$location$lat,
    rating = hasil_1$rating,
    user_rating = hasil_1$user_ratings_total,
    tipe = tipe_tempat,
    place_id = hasil_1$place_id
  )
  
  print(temp)
  
  # masukin ke rumah
  rumah_kita[[ikanx]] = temp
  
  # jeda
  Sys.sleep(runif(1,2,4))
  
  print(ikanx)
}

output_final = 
  data.table::rbindlist(rumah_kita) %>% 
  as.data.frame() %>% 
  rbind(output) %>% 
  distinct()

cat("Total didapatkan:")
nrow(output_final)

save(output_final,file = paste0(carikan,".rda"))

# hasil_detail = google_place_details(place_id = output_final$place_id[1], key = key)

# openxlsx::write.xlsx(output_final,file = "pilates surabaya.xlsx")