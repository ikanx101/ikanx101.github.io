# ==============================================================================
setwd("~/ikanx101.github.io/_posts/linear problem/post 17 - pilpres 2019")

rm(list=ls())

library(parallel)
library(dplyr)
library(tidyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

n_core = 2
# ==============================================================================

# ==============================================================================
# ambil data dulu
nama_files = c("Aren Jaya.txt","Bekasi Jaya.txt","Duren Jaya.txt","Margahayu.txt")

# nama function
ambil_file = function(nama_file){
  teks = readLines(nama_file)
  df = 
    data.frame(tps = teks) |>
    separate(tps,
             sep  = "\\t",
             into = c("tps","jkw","prb")) |>
    mutate(kecamatan = nama_file,
           kecamatan = gsub(".txt","",kecamatan)) |>
    mutate(jkw = as.numeric(jkw),
           prb = as.numeric(prb))
  return(df)
}

# kita save dulu
temp = mclapply(nama_files,ambil_file,mc.cores = n_core)
# kita gabung dulu
df_kpu = do.call(rbind,temp)
# ==============================================================================

# ==============================================================================
# rules
# cuma punya maks 50 orang
# harus adil di empat kecamatan: kalau bisa selisih 2-3 tps

# target
prb_persen = 44.68
jkw_persen = (100 - prb_persen) / 100

# decision variable
# i = 1:788 - binary menandakan apakah TPS tersebut dipilih atau tidak
# kita definisikan x[i] binary

bin_prog = 
  MIPModel() %>%
  # menambah variabel
  add_variable(x[i],
               i = 1:758,
               type = "binary",
               lb = 0) |>
  add_variable(jkw_p[i],
               i = 1:758,
               type = "continuous",
               lb = 0) |>
  add_variable(prb_p[i],
               i = 1:758,
               type = "continuous",
               lb = 0) |>
  add_variable(tot_p[i],
               i = 1:758,
               type = "continuous",
               lb = 0) |>
  add_variable(pembagi[k],
               k = 1,
               type = "continuous",
               lb = 0) |>
  add_variable(bagi_p[k],
               k = 1,
               type = "continuous",
               lb = 0) |>
  # constraint 1 hanya punya max 50 orang
  add_constraint(sum_expr(x[i],i = 1:758) <= 50) |>
  # add constraint 2 sebagai definisi jokowi
  add_constraint(jkw_p[i] == df_kpu$jkw[i] * x[i],
                 i = 1:758) |>
  # add constraint 3 sebagai definisi prabowo
  add_constraint(prb_p[i] == df_kpu$prb[i] * x[i],
                 i = 1:758) |>
  # add constraint 3 sebagai definisi total
  add_constraint(tot_p[i] == jkw_p[i] + prb_p[i],
                 i = 1:758) |>
  add_constraint(pembagi[k] == sum_expr(tot_p[i],i = 1:758) * jkw_persen,
                 k = 1) |>
  add_constraint(bagi_p[k] == sum_expr(jkw_p[i],i = 1:758),
                 k = 1) |>
  # membuat objective function
  set_objective(sum_expr(pembagi[k] - bagi_p[k],
                         k = 1),
                "min") 
  

  
bin_prog 

hasil = 
  bin_prog %>%
  solve_model(with_ROI(solver = "glpk",
                       verbose = T))
hasil

hasil_final = 
  hasil %>%
  get_solution(x[i]) |>
  filter(value > 0)

hasil_final

temp = 
  df_kpu[hasil_final$i,] |>
  summarise(jkw = sum(jkw),
            prb = sum(prb))
    
persen  = temp$jkw / sum(temp$jkw,temp$prb)
persen
selisih = abs(persen - jkw_persen)
selisih



