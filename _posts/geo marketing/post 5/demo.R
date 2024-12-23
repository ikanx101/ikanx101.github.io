df

x = runif(100,df$min_lat,df$max_lat)
y = runif(100,df$min_lon,df$max_lon)

df_final = expand.grid(x,y) |> rename(lat = Var1,lon = Var2)

# kita bikin fungsi raster
enrich = function(df_input){
  city_names = raster::extract(indo, # ini data referensinya
                               df_input[, c("lon", "lat")]) # ini data hasil seleksinya
  kota       = city_names$NAME_2
  provinsi_  = city_names$NAME_1
  
  df_output = 
    df_input |> 
    mutate(provinsi = provinsi_,
           kota     = kota) |> 
    filter(!is.na(provinsi)) |> 
    arrange(provinsi,kota)
  
  return(df_output)
}


setwd("~/gmaps_scraper/Hitung Potensi Sekolah/GADM")
indo = raster::shapefile("gadm41_IDN_2.shp", package = "raster")

# kita randomized dulu
bilangan = 1:nrow(df_final)

# Acak urutan bilangan
bilangan_acak <- sample(bilangan)

# Bagi menjadi 70 kelompok
jumlah_kelompok <- 500
kelompok <- split(bilangan_acak, cut(seq_along(bilangan_acak), jumlah_kelompok))

# kita mulai loopingnya
for(i in 1:jumlah_kelompok){
  nama_file = paste0("df_final_",i)
  df_input  = df_final[kelompok[[i]],]
  df_output = enrich(df_input)
  assign(nama_file,
         df_output)
  print(paste0(i," done"))
}


# Buat list kosong untuk menampung hasil penggabungan
data_list <- list()

# Loop untuk menambahkan setiap data frame ke dalam list
for (i in 1:jumlah_kelompok) {
  data_list[[i]] <- get(paste0("df_final_", i))
}

data_geocoded = data.table::rbindlist(data_list,fill = T) |> as.data.frame()
data_geocoded = data_geocoded |> filter(kota == "Kota Kediri")

save(data_geocoded,file = "demo_kediri.rda")




