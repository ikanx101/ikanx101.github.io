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
jkw_persen = 100 - prb_persen

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
  # membuat objective function
  set_objective(sum_expr(x[i],
                         i = 1:758) + 10,
                "min") |>
  # constraint 1 hanya punya max 50 orang
  add_constraint(sum_expr(x[i]) <= 50,
                 i = 1:758)

  
bin_prog 

hasil = 
  bin_prog %>%
  solve_model(with_ROI(solver = "glpk",
                       verbose = T))


hasil_final = 
  hasil %>%
  get_solution(x[i])
  
hasil









