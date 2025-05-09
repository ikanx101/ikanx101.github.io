rm(list = ls())
gc()

library(dplyr)
library(tidyr)
library(ggplot2)
library(ggpubr)

n_simulasi  = 10^4
populasi    = 10^7
prob_ses    = 60
persen_usia = 73
harga       = 1500

target_market = populasi * (prob_ses / 100) * (persen_usia / 100)

persen_user = c(65,70)

n_user     = (runif(n_simulasi,
                    min = persen_user[1],
                    max = persen_user[2]) / 100) * populasi
n_non_user = populasi - n_user

persen_heavy_medium = c(25,35)

n_heavy_medium = (runif(n_simulasi,
                        min = persen_heavy_medium[1],
                        max = persen_heavy_medium[2])/100) * n_user
n_low_medium   = n_user - n_heavy_medium

# marketing I
freq_beli = c(4,6) # data hasil survey, marketing I untuk menaikkan 1 kali beli
qty_beli  = c(5,7) # data hasil survey, marketing I untuk menaikkan 1 unit produk

df_act_1 = 
  data.frame(n_heavy_medium,harga) %>% 
  mutate(freq_beli = runif(n_simulasi,
                           min = freq_beli[1],
                           max = freq_beli[2])) %>% 
  mutate(qty_beli = runif(n_simulasi,
                          min = qty_beli[1],
                          max = qty_beli[2])) %>% 
  mutate(omset = n_heavy_medium * freq_beli * qty_beli * harga) %>% 
  mutate(ket = "marketing 1")

# marketing II
freq_beli = c(1,4) # data hasil survey
qty_beli  = c(1,3) # data hasil survey

n_low_medium = rnorm(n_simulasi,
                     mean = mean(n_low_medium),
                     sd   = 10^6) # marketing II bertujuan mengecilkan deviasi

df_act_2 = 
  data.frame(n_low_medium,harga) %>% 
  mutate(freq_beli = runif(n_simulasi,
                           min = freq_beli[1],
                           max = freq_beli[2])) %>% 
  mutate(qty_beli = runif(n_simulasi,
                          min = qty_beli[1],
                          max = qty_beli[2])) %>% 
  mutate(omset = n_low_medium * freq_beli * qty_beli * harga) %>% 
  mutate(ket = "marketing 2")

# marketing III
prob_conversion = c(.05,.2) # ini yang diusahakan pada marketing III
freq_beli       = c(1,2) # ini yang diusahakan pada marketing III
qty_beli        = c(1,2) # ini yang diusahakan pada marketing III

df_act_3 = 
  data.frame(n_non_user,harga) %>% 
  mutate(conver_rate = runif(n_simulasi,
                             min = prob_conversion[1],
                             max = prob_conversion[2])) %>% 
  mutate(freq_beli = runif(n_simulasi,
                           min = freq_beli[1],
                           max = freq_beli[2])) %>% 
  mutate(qty_beli = runif(n_simulasi,
                          min = qty_beli[1],
                          max = qty_beli[2])) %>% 
  mutate(omset = n_non_user * conver_rate * freq_beli * qty_beli * harga) %>% 
  mutate(ket = "marketing 3")

hasil  = list(df_act_1,df_act_2,df_act_3)
df_sim = data.table::rbindlist(hasil,fill = T) %>% as.data.frame()

save(df_sim,file = "simu_liu.rda")
