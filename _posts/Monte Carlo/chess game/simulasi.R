# hari ini kita akan menyelesaikan puzzle terkait pertandingan catur
# antara dua grandmasters

# begini kisahnya:

# ada dua grandmasters yang akan dipertemukan dalam satu pertandingan
# dalam pertandingan tersebut
# mereka akan saling bertanding sebanyak 12 babak

# pemenang dari babak tersebut akan mendapatkan 1 poin
# jika draw, keduanya akan mendapatkan 0.5 poin
# jika kalah, pemain tidak mendapatkan poin sama sekali

# grandmasters yang pertama kali mendapatkan poin total 6.5 akan menang

# jika dalam 12 babak tersebut tidak ada yang mencapai poin 6.5
# maka pertandingan tersebut harus diulang di waktu yang lain
# padahal kedua grandmasters tersebut sudah tidak ingin bertemu lagi
# di lain kesempatan

# jika:
  # 1. peluang grandmaster A menang adalah sebesar 20%
  # 2. peluang grandmaster B menang adalah sebesar 15%
  # 3. peluang draw adalah sebesar 65%

# pertanyaannya:
  # BERAPA PELUANG DALAM PERTANDINGAN INI TIDAK DITEMUKAN PEMENANG?

# =================================================================

# bagaimana caranya agar kita bisa menjawab pertanyaan ini?
# kita akan lakukan deduksi untuk kemudian kita simulasikan 
# dengan monte carlo

# kita mulai dari hati yang bersih
rm(list=ls())

# sekarang kita akan buat function untuk satu pertandingan utuh
# berisi 12 babak
match_result = function(dummy){
  # initial
  skor_a  = 0
  skor_b  = 0
  n_babak = 0
  
  # kita akan lakukan looping hingga babak mencapai 12
  while(n_babak < 12){
    # generate pertandingan
    tanding = sample(c("a","d","b"),1,prob = c(.2,.65,.15))
    
    # kita rekap nilainya
    if(tanding == "a"){skor_a = skor_a + 1}
    if(tanding == "b"){skor_b = skor_b + 1}
    if(tanding == "d"){skor_a = skor_a + .5
                       skor_b = skor_b + .5}
    
    # menambah babak
    n_babak = n_babak + 1
    
    # kita akan keluarkan hasil tiap babak
    print(paste("babak ke:",n_babak))
    print(paste("skor A:",skor_a))
    print(paste("skor B:",skor_b))
    
    # kita akan hentikan pertandingan ini jika salah satu pemain
    # sudah mencapai nilai 6.5
    if(skor_a >= 6.5){output = "a";break}
    if(skor_b >= 6.5){output = "b";break}
  }
  
  # ini kita tambahkan agar kondisi dimana tidak ada yang mencapai
  # nilai 6.5 tetap terakomodir
  if(skor_a < 6.5 & skor_b < 6.5){output = "no winner"}
  return(output)
}


# sekarang kita akan lakukan parallel processing
library(parallel)

# set berapa banyak cores yang dipakai
numcore = detectCores() - 2 # saya hanya akan pakai 6 core saja

# set berapa banyak simulasi
n_sim  = 18000 # kita perbanyak lagi
id_sim = 1:n_sim

# parallel processing
hasil = mcmapply(match_result,id_sim,mc.cores = numcore)

# moment of truth
prop.table(table(hasil))


# ktia dapatkan peluang terjadi no winner condition adalah 
# sebesar: 0.1890000













