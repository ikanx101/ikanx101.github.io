data = 
  data %>%
  filter(!grepl("jakarta",nama_kab_kota,ignore.case = T)) %>% 
  select(nama_kab_kota,
         provinsi,
         dokter_umum,
         dokter_spesialis,
         dokter_sub_spesialis,
         dokter_gigi,
         dokter_gigi_spesialis_dan_sub_spesialis) %>% 
  mutate(dokter_umum = cut(dokter_umum,breaks=7,labels=c(1:7)),
         dokter_spesialis = cut(dokter_spesialis,breaks=7,labels=c(1:7)),
         dokter_sub_spesialis = cut(dokter_sub_spesialis,breaks=7,labels=c(1:7)),
         dokter_gigi = cut(dokter_gigi,breaks=7,labels=c(1:7)),
         dokter_gigi_spesialis_dan_sub_spesialis = cut(dokter_gigi_spesialis_dan_sub_spesialis,breaks=7,labels=c(1:7))
  )

data_cluster = data %>% select(-nama_kab_kota,-provinsi) %>% mutate_if(is.factor,as.numeric)

library(factoextra)
library(cluster)
# fviz_nbclust(data_cluster, kmeans, method = "wss") 

hasil = kmeans(data_cluster, 5, nstart = 25)
data$cluster = hasil$cluster
save(hasil,data,file = "hasil kmeans.rda")