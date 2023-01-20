# sekarang saya akan mencoba membuat persamaan regresi linear
# dengan menggunakan spiral dynamic optimization algorithm

# data yang digunakan adalah mtcars

mtcars

# saya akan memprediksi mpg dari disp dan hp

# kita mulai ya

# bebersih dulu
rm(list=ls())

# panggil libraries
library(dplyr)

# memanggil dan seleksi variabel data
df = mtcars %>% select(mpg,disp,hp)
head(df)

# saya akan buat regresi dengan base dulu
# nanti kita akan bandingkan hasilnya dengan hasil dari spiral
model_reg = lm(mpg ~.,data = df)
model_reg

# kita akan simpan hasil ini untuk kemudian nanti dibandingkan ya

# =============================================================================
# kita mulai si spiralnya
# ide dasarnya adalah dengan membuat 3 angka acak pada persamaan regresi:
  # mpg = a disp + b hp + c

# nilai a, b, dan c ini lah yang akan dicari

# kita akan gunakan MAE - mean absolute error sebagai parameter keberhasilan model kita nanti
MAE_hit = function(acak){
  df$mpg_hit = (acak[1] * df$disp) + (acak[2] * df$hp) + acak[3]
  mae = mean(abs(df$mpg - df$mpg_hit))
  return(mae)
}

# kita akan cari 3 angka terbaik dengan SDOA

# ini adalah function yang saya sudah buat untuk membuat matriks rotasi
# membuat function rotation matrix
buat_rot_mat = function(theta,n){
  # buat template sebuah matriks identitas
  temp_mat = matrix(0,ncol = n,nrow = n)
  diag(temp_mat) = 1
  
  # buat matriks identitas terlebih dahulu
  mat_rot = temp_mat
  # membuat isi matriks rotasi
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
  # output matriks rotasi
  return(mat_rot)
}

# fungsi untuk rotasi dan kontraksikan
ro_kon = function(list){
  X1 = mat_rotasi %*% (list - center)
  X1 = center + (.6 * X1)
  return(X1)
}


# oh iya kelupaan, saya harusnya bikin mat_rotasi dulu
mat_rotasi = buat_rot_mat(2 * pi/40, 3)

# ==============================================================================
# sekarang kita mulai SDOA nya
n_solusi = 20000
n_iter   = 70

buat_angka = function(){
  x12 = runif(2,min = -2,max = 2)
  x3  = sample(40,1)
  return(c(x12,x3))
}

# saya akan gunakan prinsip paralelisasi
library(parallel)
numCores = 5 # saya gunakan 5 cores dari 8 cores laptop saya

# generate 3 angka acak sebanyak n_solusi
calon = vector("list",n_solusi)
for(i in 1:n_solusi){calon[[i]] = buat_angka()}

# sekarang kita hitung nilai MAE dari semua calon solusi
mae_hit = mcmapply(MAE_hit,calon)

# kita mulai iterasinya dari sini:
for(ikanx in 1:n_iter){
  # mencari calon solusi dengan MAE terkecil
  n_min = which.min(mae_hit)
  
  print(mae_hit[n_min])
  
  # menjadikan calon solusi tersebut sebagai pusat rotasi
  center = calon[[n_min]]
  
  # kita rotasikan dan kontraksikan
  calon_new = mcmapply(ro_kon,calon)
  calon = lapply(seq_len(ncol(calon_new)), function(i) calon_new[,i])
  
  # sekarang kita hitung lagi MAE dari semua calon solusi
  mae_hit = mcmapply(MAE_hit,calon)
}

# mencari calon solusi dengan MAE terkecil
n_min = which.min(mae_hit)
mae_hit[n_min]
# menjadikan calon solusi tersebut sebagai pusat rotasi
center = calon[[n_min]]

# moment of truth
center

MAE_hit(center)

model_reg

save(df,MAE_hit,center,file = "bahan.rda")
MAE_hit(c(-0.03035,-0.02484,30.73590))

# terlihat MAEnya kini lebih kecil
# hanya ~ 2.3 sedangkan MAE hasil base reg di R itu nilainya 2.5

# kita simpulkan bahwa SDOA bisa membuat model regresi yang relatif lebih akurat dibandingkan perhitungan 
# base di R


