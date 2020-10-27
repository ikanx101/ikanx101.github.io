rm(list=ls())

nama = randomNames::randomNames(40*20)
tanggal = sample(c(1:28),40*20,replace = T)
bulan = sample(c(1:12),40*20,replace = T)
tahun = sample(c(2012:2014),40*20,replace = T)
berat_badan = rnorm(40*20,30,9)
tinggi_badan = rnorm(40*20,120,15)
kelas = sample(c("A","B","C","D","E","F","G","H","I","J",
                 "K","L","M","N","O","P","Q","R","S","T"),
               40*20,
               replace = T)

data = data.frame(nama,
                  tanggal_lahir = lubridate::date(paste(tahun,bulan,tanggal,sep = "-")),
                  berat_badan = round(berat_badan,0),
                  tinggi_badan = round(tinggi_badan,0),
                  kelas
                  )
save(data,file = "data.rda")

write.csv(data,"kelas anak.csv")