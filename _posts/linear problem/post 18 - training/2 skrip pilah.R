# ==============================================================================
setwd("~/ikanx101.github.io/_posts/linear problem/post 18 - training")

rm(list=ls())

library(readxl)
library(janitor)
library(parallel)
library(dplyr)
library(tidyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

n_core = detectCores()
# ==============================================================================


# ==============================================================================
# ambil data dulu
load("saved data.rda")

# kita buat function terlebih dahulu
# fungsi pertama
hit_jab = function(input){
  input %>% pull(gol_select) %>% unique() %>% length()
}
# fungsi kedua
hit_work = function(input){
  input %>% pull(work_select) %>% unique() %>% length()
}
# hitung manager
hit_mana = function(tes){
  sum(tes$gol_select == "manager")
}
# function matriks rotasi
buat_rot_mat = function(theta,n){
  # buat template sebuah matriks identitas
  temp_mat = matrix(0,ncol = n,nrow = n)
  diag(temp_mat) = 1
  
  # buat matriks identitas terlebih dahulu
  mat_rot = temp_mat
  
  for(i in 1:(n-1)){
    for(j in 1:i){
      temp = temp_mat
      idx = n-i
      idy = n+1-j
      # print(paste0("Matriks rotasi untuk ",idx," - ",idy,": DONE"))
      temp[idx,idx] = cos(theta)
      temp[idx,idy] = -sin(theta)
      temp[idy,idx] = sin(theta)
      temp[idy,idy] = cos(theta)
      # assign(paste0("M",idx,idy),temp)
      mat_rot = mat_rot %*% temp
      mat_rot = mat_rot 
    }
  }
  
  return(mat_rot)
}

# kita bat matriks rotasi
mat_rotasi = buat_rot_mat(2 * pi / 100,nrow(df))

# star randomizer
N      = n_core * 40
n_grup = 100/4

# fungsi big bang
big_bang = function(dummy){
  id_rand  = sample(n_grup,100,replace = T)
  return(id_rand)
}
# ==============================================================================


# ==============================================================================
# objective function
f_tot = function(id_grup){
  # kita masukin dulu ke sini ya
  df_input = df %>% mutate(grup = id_grup)
  temp     = df_input %>% group_split(grup)
  
  # harus 25 kelompok
  n_grup_hit = length(unique(id_grup))
  n_grup_hit = abs(n_grup_hit - 25) * 100000
  poin_5     = sum(n_grup_hit)
  
  # pertama hitung berapa anggota
  n_anggota = sapply(temp,nrow) 
  n_anggota = abs(n_anggota - 4) 
  # kalau sudah ada 4 orang ya aman ya
  n_anggota = ifelse(n_anggota >= 1,5000,0)
  poin_1    = sum(n_anggota)
  
  # hitung diversitas jabatan
  n_jabatan = sapply(temp,hit_jab) 
  n_jabatan = abs(n_jabatan - 2) * 20
  poin_2    = sum(n_jabatan)
  
  # hitung tempat kerja
  n_work    = sapply(temp,hit_work) 
  n_work    = abs(n_work - 2) * 30
  poin_3    = sum(n_work)
  
  # manager harus cuma 1
  n_man     = sapply(temp,hit_mana)
  n_man     = abs(n_man - 1)
  # kalau sudah ada minimal satu manager, ya sudah lah
  n_man     = ifelse(n_man >= 0, 0 , 10)
  point_4   = sum(n_man)
  
  # total obj
  sum(poin_1,poin_2,poin_3,point_4,poin_5)
}
# ==============================================================================


# ==============================================================================
# kita generate
star  = mclapply(1:N,big_bang,mc.cores = n_core)
f_hit = mclapply(star,f_tot,mc.cores = n_core)

# mulai part serunya
for(ikanx in 1:100){
  # penentuan black hole
  n_bhole = which.min(f_hit)
  bhole   = star[[n_bhole]]
  
  for(i in 1:N){
    Xt = star[[i]]
    X  = mat_rotasi %*% (Xt - bhole)
    X  = bhole + (.75 * X)
    # kita jaga agar tetap di 1 sampai 28
    X  = round(X,0)
    X  = ifelse(X <= 0,1,X)
    X  = ifelse(X > n_grup,n_grup,X)
    star[[i]] = X
  }
  
  # perhitungan obj function
  temp_f_hit = mclapply(star,f_tot,mc.cores = n_core)
  f_hit      = temp_f_hit %>% unlist()
  
  # print dulu
  cat("f_tot: ")
  print(ikanx)
  print(min(f_hit))
}

# ==============================================================================
# ini hasilnya
n_bhole = which.min(f_hit)
bhole   = star[[n_bhole]]
df_out  = df %>% mutate(grup = bhole)
final   = df_out %>% group_split(grup)
final








