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

# kita induksi lagi cara kerjanya
tes = c("vJrwpWtwJgWrhcsFMMfFFhFp",
        "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
        "PmmdzqPrVvPwwTWBwg")

# hitung skor
hitung_skor = function(tes){
  # untuk elemen 1
  el_1 = strsplit(tes[1],split = "") %>% unlist()
  # untuk elemen 2
  el_2 = strsplit(tes[2],split = "") %>% unlist()
  # untuk elemen 3
  el_3 = strsplit(tes[3],split = "") %>% unlist()
  # cek share item dari ketiga elemen
  share_item = intersect(intersect(el_1,el_2),el_3)
  skor_final = 
    skor %>% filter(huruf %in% share_item)
  hasil = sum(skor_final$prio)
  return(hasil)
}


# sekarang kita akan bagi pertiga baris
skor_rucksack = rep(0,100)
k = 1
while(length(df) > 0){
  temp = df[1:3]
  skor_rucksack[k] = hitung_skor(temp)
  df = df[-1:-3]
  k = k + 1
}

skor_rucksack

# moment of truth
sum(skor_rucksack)


