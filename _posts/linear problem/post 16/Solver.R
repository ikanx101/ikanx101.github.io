rm(list=ls())
setwd("~/ikanx101.github.io/_posts/linear problem/post 16")

library(dplyr)
library(tidyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

load("soal 2.rda")

# 4 pekerja
# 4 hari
# 7 jam
# max 2 jam max 2 kali

# decision variable
# pekerja   : i = 1:4
# hari      : j = 1:4
# kegiatan  : k = 1:35
# kita definisikan x[i,j,k] binary

# kita simpan dulu vektor waktu
t      = df_req$waktu_kerja
k_4jam = df_req %>% filter(waktu_kerja >= 4) %>% row_number()



bin_prog = 
  MIPModel() %>%
  # menambah variabel
  add_variable(x[i,j,k],
               i = 1:4,
               j = 1:4,
               k = 1:35,
               type = "binary",
               lb = 0) |>
  # membuat objective function
  set_objective(sum_expr(x[i,j,k] * t[k] - 7,
                         i = 1:4,
                         j = 1:4,
                         k = 1:35),
                "min") |>
  # constraint 1 hari biasa
  add_constraint(sum_expr(x[i,j,k] * t[k],
                          k = 1:35) <= 9,
                 i = 1:4,
                 j = 1) |>
  # constraint 1 hari lembur
  add_constraint(sum_expr(x[i,j,k] * t[k],
                          k = 1:35) <= 7,
                 i = 1:4,
                 j = 2:4) |>
  # constraint 2
  add_constraint(sum_expr(x[i,j,k],
                          i = 1:4,
                          j = 1:4) == 1,
                 k = 1:35) %>% 
  # constraint 3
  add_constraint(sum_expr(x[i,j,k] * t[k],
                          k = k_4jam) >= 0,
                 i = 1:4,
                 j = 1:4)
  
bin_prog 

hasil = 
  bin_prog %>%
  solve_model(with_ROI(solver = "glpk",
                       verbose = T))


hasil_final = 
  hasil %>%
  get_solution(x[i,j,k]) %>%
  filter(value == 1) %>%
  cbind(t) %>% 
  arrange(i,j,k)

hasil_final

rekap = 
  hasil_final %>% 
  group_by(i,j) %>% 
  summarise(total_jam = sum(t)) %>% 
  ungroup() %>% 
  rename(orang = i,
         hari  = j)

rekap

rekap %>% 
  mutate(testing = total_jam - 7) %>% 
  .$testing %>% 
  sum()


#save(hasil_final,rekap,file = "solusi.rda")
