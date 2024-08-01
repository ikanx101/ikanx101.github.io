rm(list=ls())

library(dplyr)
library(tidyr)
library(parallel)

n_core = detectCores()

weekend  = 2
weekdays = 4

table_wd = function(){sample(50:80,1)}
table_we = function(){sample(80:120,1)}

duit = function(dummy){rnorm(1,80000,30000)}

pelanggan_we = function(dummy){
  calon = c("keluarga","pasangan","rombongan","sendiri")
  proba = c(.1,.2,.3,.4)
  siapa = sample(calon,1,prob = proba)
  n_orang = case_when(
    siapa == "keluarga" ~ sample(3:5,1),
    siapa == "pasangan" ~ 1,
    siapa == "rombongan" ~ sample(7:12,1),
    siapa == "sendiri" ~ 1
  )
  output = data.frame(siapa,n_orang)
  return(output)
}

pelanggan_wd = function(dummy){
  calon = c("keluarga","pasangan","rombongan","sendiri")
  proba = c(.5,.3,.1,.1)
  siapa = sample(calon,1,prob = proba)
  n_orang = case_when(
    siapa == "keluarga" ~ sample(3:7,1),
    siapa == "pasangan" ~ 1,
    siapa == "rombongan" ~ sample(5:10,1),
    siapa == "sendiri" ~ 1
  )
  output = data.frame(siapa,n_orang)
  return(output)
}

simulasi_bulanan = function(dummy_input){
  # weekdays
  simu_weekdays = vector("list",weekdays)
  for(i in 1:weekdays){
    n_table = 1:table_wd()
    uang    = sapply(n_table,duit)
    cust    = lapply(n_table,pelanggan_wd)
    cust    = data.table::rbindlist(cust) |> as.data.frame() |>
      mutate(uang = uang)
    simu_weekdays[[i]] = cust
  }
  # weekend
  simu_weekend = vector("list",weekend)
  for(i in 1:weekend){
    n_table = 1:table_we()
    uang    = sapply(n_table,duit)
    cust    = lapply(n_table,pelanggan_we)
    cust    = data.table::rbindlist(cust) |> as.data.frame() |>
      mutate(uang = uang)
    simu_weekend[[i]] = cust
  }
  # gabung dan hitung omset total selama seminggu
  output_final = 
    rbind(data.table::rbindlist(simu_weekend),
          data.table::rbindlist(simu_weekdays)) |>
    as.data.frame() |>
    mutate(omset = n_orang * uang) |>
    pull(omset) |>
    sum() * 4
  
  return(output_final)
}

n_sim = 1:(n_core*50)
hasil = mcmapply(simulasi_bulanan,n_sim,mc.cores = n_core)

df = data.frame(n_sim,hasil)
save(df,file = "ready.rda")

library(ggplot2)
df |>
  ggplot(aes(x = hasil)) +
  geom_density()
