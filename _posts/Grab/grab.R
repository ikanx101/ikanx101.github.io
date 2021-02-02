setwd("~/Documents/ikanx101/_posts/Grab")
rm(list=ls())

library(ralger)
library(dplyr)

# ambil saved html
url = list.files()
url = data.frame(id = 1, url) %>% filter(grepl("html",url,ignore.case = T))
url = url$url

# function ambil data
grab_donk = function(link){
  data = 
    tidy_scrap(link,
               c(".name___1Ls94",".ratingText___1Q08c",".openHoursText___9q0va",
                 ".menuItemInfo___PyfMY",".discountedPrice___3MBVA"),
               c("nama_merchant","rating","open_hours",
                 "menu","harga"))
  return(data)
}

# scraping
i = 1
hasil = grab_donk(url[i])
for(i in 1:length(url)){
  temp = grab_donk(url[i])
  hasil = rbind(temp,hasil)
  print(paste0("Alhamdulillah ",i," sudah diambil dengan selamat..."))
}

# bebersih
hasil = 
  hasil %>% 
  filter(!is.na(nama_merchant)) %>% 
  distinct()

# ambil nama
nama = unique(hasil$nama_merchant)
nama = paste0(nama,", bekasi")

# ambil longlat
library(googleway)
key = ""
tes = function(xxx){
  hasil=google_geocode(address=xxx,key=key)
  lengkap = hasil$results$formatted_address
  lat = hasil$results$geometry$location$lat
  long = hasil$results$geometry$location$lng
  final = paste(lengkap,lat,long,sep=";")
  return(final)
}

# scrape longlat
data_longlat_kota = data.frame(
  id = c(1:length(nama)),
  alamat = nama
) %>% 
  mutate(geocode = sapply(alamat,tes)) %>% 
  tidyr::separate(geocode,into = c("alamat_lengkap","lat","long"),sep = ";")

data_longlat_kota$long[24] = 106.9777664
data_longlat_kota$long[25] = 106.987715
data_longlat_kota$long[10] = 106.9711969

# gabungin data
hasil = 
  hasil %>% 
  mutate(alamat = paste0(nama_merchant,", bekasi"))
final = merge(hasil,data_longlat_kota)
final$alamat = NULL

save(final,file = "sekitar_sumarenkon.rda")