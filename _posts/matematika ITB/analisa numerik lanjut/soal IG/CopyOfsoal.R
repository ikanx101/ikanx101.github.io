rm(list=ls())
setwd("~/ikanx101.github.io/_posts/matematika ITB/analisa numerik lanjut/soal IG")

library(dplyr)
library(tidyr)
library(parallel)

n_core = detectCores()
n_var  = 2

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

# bikin matriks rotasinya
A_rot = buat_rot_mat(2*pi/120,n_var)

# constrain
cons_1 = function(vec){
  x = vec[1]
  y = vec[2]
  z = x + y - 8
  return(z)
}

# objective function
obj_func = function(vec){
  x = vec[1]
  y = vec[2]
  hasil = x^y
  return(hasil)
}

# hitung total
f_hit = function(vec){
  con = cons_1(vec)
  obj = obj_func(vec)
  f   = -obj + 10^10 * con^2
  return(f)
}

# generate solusi
big_bang = function(dummy){
  x = runif(1,0,8)
  random_numb = runif(1)
  if(random_numb < .5){
    y = runif(1,0,8)
  }
  else if(random_numb >= .5){
    y = 8 - x
  }
  return(c(x,y))
}

# kita mulai
n_solusi = n_core * 50

calon_solusi = mclapply(1:n_solusi,big_bang,mc.cores = n_core)
f_hitung     = mclapply(calon_solusi,f_hit,mc.cores = n_core)

buat_grafik  = vector("list",150)

for(ikanx in 1:150){
  
  # kita tambahin multi-bandit
  bandit = runif(1,0,1)
  if(bandit < .07){
    n_min = sort(unlist(f_hitung),index.return = T)
    n_min = n_min$ix[2]
  } else 
    if(bandit >= .07){
      n_min = which.min(f_hitung)
    }
  
  center_star  = calon_solusi[[n_min]]
  
  # proses rotasi semua calon
  for(i in 1:n_solusi){
    Xt = calon_solusi[[i]]
    X  = A_rot %*% (Xt - center_star)
    X  = center_star + (.95 * X)
    X  = abs(X)
    X_ = c(X[1],X[2])
    calon_solusi[[i]] = X_ 
  }
  
  f_hitung             = mclapply(calon_solusi,f_hit,mc.cores = n_core)
  buat_grafik[[ikanx]] = calon_solusi
}

# kita mau bikin grafiknya
# 

buatin_grafik = function(i){
  input = buat_grafik[[i]]
  misal = input %>% unlist()
  x_    = misal[seq(1,length(misal),2)]
  y_    = misal[seq(2,length(misal),2)]
  df_grafik = data.frame(x = x_,y = y_,t = i)
  return(df_grafik)
}

buat_grafik_df = mclapply(1:150,buatin_grafik,mc.cores = n_core)
buat_grafik_df = data.table::rbindlist(buat_grafik_df)

library(ggplot2)
library(gganimate) # sebagai animator grafik
library(av)        # untuk render animasi ke dalam mp4

plt = 
  buat_grafik_df %>%  
  ggplot(aes(x = x ,y = y)) +
  geom_point(aes(color = t),size = .5) +
  theme(legend.position = "none") +
  transition_time(t) +
  shadow_wake(wake_length = 0.05, alpha = FALSE) +
  labs(x = "X",
       y = "Y",
       title = "Pencarian Solusi Soal dengan Spiral Dynamics Optim Algrithm",
       subtitle = "iterasi ke - {frame_time}")

a = animate(plt, 
            width = 450, height = 450,
            duration = 30, fps = 7, renderer = av_renderer())
anim_save("animation bandit.mp4", a)

# a = animate(plt,width = 450, height = 450,duration = 20)
# anim_save("animated.gif", a)


n_min        = which.min(f_hitung)
center_star  = calon_solusi[[n_min]]
center_star
obj_func(center_star)
cons_1(center_star)
f_hit(center_star)

