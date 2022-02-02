rm(list=ls())

library(dplyr)

# binomo
  # kalau benar dapat 80%
  # kalau salah langsung hangus
  # berikut ini function nya
binomo = function(init_money){
  tebak = sample(c(0,1),2,replace = T, prob = c(.5,.5))
  pengali = ifelse(tebak[1] == tebak[2], 1.8, 0)
  init_money = init_money * pengali
  return(init_money)
}

# kita buat function iterasinya
simu_liu = function(){
  # initial money
  money = 100000
  i = 1
  # siapin rumah
  idx = c(i)
  uang = c(money)
  # iterasi tebakan binomo
  while(money > 0){
    money = binomo(money)
    i = i + 1
    idx = c(idx,i)
    uang = c(uang,money)
  }
  # hasil akhir
  df = data.frame(idx,uang)
  return(df)
}

# iterasi maksimum
iter_max = 4000

# bikin rumah untuk hasil simulasi
rumah = vector("list",iter_max)

# iterasi simulasi
for(i in 1:iter_max){
  rumah[[i]] = simu_liu()
}

# data final gabung semua
data_final = do.call(bind_rows,rumah)
data_final$exp = NA
data_final$exp[1] = 1
idx = 1

for(i in 2:nrow(data_final)){
  data_final$exp[i] = ifelse(data_final$idx[i] == 1,
                             data_final$exp[i-1] + 1,
                             data_final$exp[i-1])
}

data_final

save(data_final,file = "simulasi.rda")
