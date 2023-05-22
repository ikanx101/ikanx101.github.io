rm(list=ls())

library(dplyr)
library(tidyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

load("soal.rda")

# 4 pekerja
# 4 hari
# 7 jam
# max 2 jam max 2 kali

# decision variable
# pekerja   : i = 1:4
# hari      : j = 1:4
# kegiatan  : k = 1:30
# kita definisikan x[i,j,k] binary

# kita simpan dulu vektor waktu
t = df_req$waktu_kerja

bin_prog = 
  MIPModel() %>%
  # menambah variabel
  add_variable(x[i,j,k],
               i = 1:4,
               j = 1:4,
               k = 1:30,
               type = "binary",
               lb = 0) |>
  # membuat objective function
  set_objective(sum_expr(x[i,j,k] * t[k],
                         i = 1:4,
                         j = 1:4,
                         k = 1:30),
                "min") |>
  # constraint 1
  add_constraint(sum_expr(x[i,j,k],
                          i = 1:4,
                          j = 1:4) == 1,
                 k = 1:30) 
  # constraint 2
  add_constraint(sum_expr(x[i,j],j = 1:4) <= 1,
                 i = 1:6) 
bin_prog 


hasil = 
  bin_prog %>%
  solve_model(with_ROI(solver = "glpk",
                       verbose = T))


hasil %>%
  get_solution(x[i,j,k])
