rm(list=ls())

library(dplyr)

df = readLines("input.txt")

# kita bikin initial condition dulu
crate_1 = c("Z","J","N","W","P","S")
crate_2 = c("G","S","T")
crate_3 = c("V","Q","R","L","H")
crate_4 = c("V","S","T","D")
crate_5 = c("Q","Z","T","D","B","M","J")
crate_6 = c("M","W","T","J","D","C","Z","L")
crate_7 = c("L","P","M","W","G","T","J")
crate_8 = c("N","G","M","T","B","F","Q","H")
crate_9 = c("R","D","G","C","P","B","Q","W")

# sekarang kita bikin induksi untuk pergantian posisi
# rulesnya:
  # move k from i to j
  # misal:
  # move 1 from 3 to 5
k = 2
i = 2
j = 8

move_kij = function(k,i,j){
  # bikin untuk pemilihan crate pertama
  if(i == 1){temp_1 = crate_1}
  if(i == 2){temp_1 = crate_2}
  if(i == 3){temp_1 = crate_3}
  if(i == 4){temp_1 = crate_4}
  if(i == 5){temp_1 = crate_5}
  if(i == 6){temp_1 = crate_6}
  if(i == 7){temp_1 = crate_7}
  if(i == 8){temp_1 = crate_8}
  if(i == 9){temp_1 = crate_9}
  
  # bikin untuk pemilihan crate kedua
  if(j == 1){temp_2 = crate_1}
  if(j == 2){temp_2 = crate_2}
  if(j == 3){temp_2 = crate_3}
  if(j == 4){temp_2 = crate_4}
  if(j == 5){temp_2 = crate_5}
  if(j == 6){temp_2 = crate_6}
  if(j == 7){temp_2 = crate_7}
  if(j == 8){temp_2 = crate_8}
  if(j == 9){temp_2 = crate_9}
  
  # sekarang kita pindahkan dari i ke j sebanyak k buah
  temp_1
  temp_2
  for(z in 1:k){
    max_temp_1 = length(temp_1)
    pindah = temp_1[max_temp_1]
    temp_2 = c(temp_2,pindah)
    temp_1 = temp_1[-max_temp_1]
  }
  
  # sudah pindah
  temp_1
  temp_2
  
  # sekarang kita kembalikan si temp ke crate awalnya
  # bikin untuk pengembalian crate pertama
  if(i == 1){crate_1 <<- temp_1}
  if(i == 2){crate_2 <<- temp_1}
  if(i == 3){crate_3 <<- temp_1}
  if(i == 4){crate_4 <<- temp_1}
  if(i == 5){crate_5 <<- temp_1}
  if(i == 6){crate_6 <<- temp_1}
  if(i == 7){crate_7 <<- temp_1}
  if(i == 8){crate_8 <<- temp_1}
  if(i == 9){crate_9 <<- temp_1}
  
  # bikin untuk pengembalian crate kedua
  if(j == 1){crate_1 <<- temp_2}
  if(j == 2){crate_2 <<- temp_2}
  if(j == 3){crate_3 <<- temp_2}
  if(j == 4){crate_4 <<- temp_2}
  if(j == 5){crate_5 <<- temp_2}
  if(j == 6){crate_6 <<- temp_2}
  if(j == 7){crate_7 <<- temp_2}
  if(j == 8){crate_8 <<- temp_2}
  if(j == 9){crate_9 <<- temp_2}
}

# karena sudah berjalan dengan baik, maka kita akan lanjut menjalankan sesuai rules dari soal
df = df[11:length(df)]
df = gsub("[A-z]","",df)
df = trimws(df)

# misal
ambil_kij = function(p){
  ekstrak = strsplit(df[p],split = " ") %>% unlist()
  ambil_k = ekstrak[1] %>% as.numeric()
  ambil_i = ekstrak[3] %>% as.numeric()
  ambil_j = ekstrak[5] %>% as.numeric()
  return(c(ambil_k,ambil_i,ambil_j))
}

for(p in 1:length(df)){
  new = ambil_kij(p)
  move_kij(new[1],new[2],new[3])
}

# moment of truth
# kita uji coba berjalan atau tidak function-nya
paste0(crate_1[length(crate_1)],
       crate_2[length(crate_2)],
       crate_3[length(crate_3)],
       crate_4[length(crate_4)],
       crate_5[length(crate_5)],
       crate_6[length(crate_6)],
       crate_7[length(crate_7)],
       crate_8[length(crate_8)],
       crate_9[length(crate_9)])

