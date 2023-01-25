rm(list=ls())

# hari ini kita akan membicarakan mengenai birthday problem

# konon katanya, jika kita kumpulkan 30 orang secara acak dalam satu ruangan
# ada 70% kemungkinan bahwa minimal ada sepasang orang dengan tanggal lahir yang sama

# maksudnya tanggal lahir adalah tanggal dan bulan (tidak termasuk tahun lahir)

# JADI ada 70% kemungkinan

# nah, saya akan coba membuktikannya dengan melakukan simulasi montecarlo di R
# saya akan menggunakan prinsip paralel computing juga karena PC yang saya pakai 
# saat ini memiliki spek yang lumayan

# saya akan berusaha hanya memakai library parallel saja
# tidak ada library lain yang saya pakai

# oke kita mulai

# membersihkan jiwa
rm(list=ls())

library(parallel)

# kita akan deteksi ada berapa core di PC saya
# saya hanya akan pakai 10 cores saja
n_cores = detectCores() - 2

# kita akan set jumlah orang terlebih dahulu
n_orang = 30

# kita akan set jumlah hari dalam setahun
n_hari = 365

# kita akan set mau seberapa banyak simulasi montecarlo dilakukan
# karena cores saya ada 10, saya akan lakukan 900.000 kali simulasi
n_simulasi = 900000

# kita akan buat function simulasi terlebih dahulu
simu_lasi = function(dummy){
  # generate tanggal lahir dari 30 orang
  tgl = sample(n_hari,n_orang,replace = T)
  # kita akan cek apakah ada tanggal yang sama?
  # caranya dengan mengecek apakah ada yang duplikat
  # saat ada yang duplikat, maka akan saya berikan nilai 1
  # jika tidak ada duplikat, saya berikan nilai 0
  cek = unique(tgl)
  output = ifelse(length(cek) < n_orang,1,0)
  return(output)
}

# sekarang saatnya kita simulasikan
id_sim = 1:n_simulasi

# pakai parallel computing
hasil = mcmapply(simu_lasi,id_sim,mc.cores = n_cores)

# cepet yah selesainya
# kita akan hitung ada berapa nilai 1 dari n_simulasi
sum(hasil) / n_simulasi * 100

# terlihat bahwa persentasenya ada sekitar 70%

# saya akan ulang untuk n_simulasi yang lebih besar lagi

# terbukti bahwa ada minimal 70 persen peluang


































