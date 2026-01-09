rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(parallel)

ncore = detectCores()

rdas = list.files(pattern = "*rda")

ambilin = function(target){
  load(target)
  return(output_final)
}

temp = mclapply(rdas,ambilin,mc.cores = ncore)
hasil = data.table::rbindlist(temp,fill = T) %>% 
        select(-tipe) %>% as.data.frame %>% distinct() %>% 
        filter(grepl("padel",nama,ignore.case = T)) %>% 
        filter(grepl("bekasi|bks",alamat,ignore.case = T)) %>% 
        filter(!grepl("jakarta",alamat,ignore.case = T)) %>% 
        filter(!grepl("kabupaten",alamat,ignore.case = T))
nrow(hasil)

hasil %>%
  filter(grepl("gunung",alamat,ignore.case = T))

library(leaflet)
leaflet(hasil) %>%
  addTiles() %>%
  addCircleMarkers(lng = ~long, lat = ~lat,
                   radius = 3, color = "red",
                   popup = ~nama)

save(hasil,file = "final.rda")


library(ggmap)
library(ggvoronoi)

basis = hasil

key = "AIzaSyBlZpsnqIhuJDHZ-nGo1VrU3PmKDW18-ls"

register_google(key = key)

lisbon_satellite <- get_map("Kota Bekasi", 
                            source = "google", 
                            api_key = api_secret,zoom=11)

basis = 
  basis %>% 
  select(lat,long) %>% 
  distinct()

ggmap(lisbon_satellite) +
  geom_point(data = basis,aes(x = long,y = lat),
             size = .9,
             color = "steelblue") +
  stat_voronoi(data = basis,aes(x = long,y = lat),
               geom = "path",
               alpha = .25,
               linewidth = .5,
               color = "darkgreen")
