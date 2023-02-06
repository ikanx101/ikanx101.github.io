rm(list=ls())

# halo
# kali ini saya akan membuat cara menghitung nilai e
# menggunakan simulasi monte carlo dan parallel computing di R Studio

# bagaimana caranya?

# cekidot:

# ==============================================================================

# jika kita melakukan random number generation dari [0,1]
# lalu jika kita jumlahkan n buah number tersebut hingga > 1
# maka expected banyaknya n buah number tersebut akan menjadi nilai e

# oke kita mulai ya

# kita definisikan functionnya

trial_simulasi = function(dummy){
  # definisi random number
  rand_number = c()
  i           = 1
  
  while(sum(rand_number) < 1){
    # kita akan generate random number [0,1]
    rand_number[i] = runif(1)
    i              = i + 1
  }
  
  # sekarang kita akan lihat butuh berapa i agar sum(rand_number) melebihi 1
  length(rand_number)
  }


# kita akan coba simulasi
n_simulasi = 1:16000

# kita simulasikan 8000 x

library(parallel)
numcore = 8

# kita akan mulai simulasinya
hasil = mcmapply(trial_simulasi,n_simulasi,mc.cores = numcore)

# oh iya, berikut adalah nilai e yang asli
exp(1)

# kita akan hitung nilai expected alias mean nya
mean(hasil)

# sudah hampir mirip
# saya akan perbesar n_simulasinya

# sudah sangat mirip kan?
# kita hitung error absolute nya
abs(exp(1) - mean(hasil))


# semoga berguna ya

