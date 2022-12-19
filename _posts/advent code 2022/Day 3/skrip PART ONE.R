setwd("~/Ikanx 101 Blog/_posts/advent code 2022/Day 3")

# dimulai dari hati yang suci
rm(list=ls())

# apnggil libraries
library(dplyr)
library(tidyr)

# bikin skoring dari aturan:
 # Lowercase item types a through z have priorities 1 through 26.
 # Uppercase item types A through Z have priorities 27 through 52.

skor = data.frame(huruf = c(letters, # huruf kecil
                            LETTERS), # huruf kapital
                  prio = 1:52)

# ambil data
df = readLines("input.txt")

# untuk membuat function penghitung skor dari item yang sama antara bag 1 dan bag 2 kita lakukan induksi sbb:
# misalkan
tes = "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"

# kita buat function-nya
hitung_donk = function(tes){
  # kita pecah per huruf
  pecah = strsplit(tes,split = "") %>% unlist()
  # hitung ada berapa banyak huruf (dibagi dua)
  n_pecah = length(pecah)/2
  # kita masukkan ke bag 1
  bag_1 = pecah[1:n_pecah]
  # kita masukkan ke bag 2
  bag_2 = pecah[(n_pecah+1):(length(pecah))]
  # kita lihat share item antara bag 1 dan bag 2
  share_item = intersect(bag_1,bag_2)
  # kita hitung skor prioritas dari tabel skor
  final_skor = 
    skor %>% 
    filter(huruf %in% share_item)
  skor_final = sum(final_skor$prio)
  return(skor_final)
}

# sekarang kita hitung semua nilainya
skor_semua = sapply(df,hitung_donk)
# moment of truth
sum(skor_semua)
