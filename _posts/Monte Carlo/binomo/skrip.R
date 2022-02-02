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
  money = 100000
  i = 1

  idx = c(i)
  uang = c(money)
  
  while(money > 0){
    money = binomo(money)
    i = i + 1
    idx = c(idx,i)
    uang = c(uang,money)
  }

  df = data.frame(idx,uang)
  return(df)
}

iter_max = 5000

rumah = vector("list",iter_max)

for(i in 1:iter_max){
  rumah[[i]] = simu_liu()
}

rumah
save(rumah,file = "simulasi.rda")
