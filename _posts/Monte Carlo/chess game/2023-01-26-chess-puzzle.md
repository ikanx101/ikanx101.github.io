---
date: 2023-01-26T14:11:00-04:00
title: "Menyelesaikan Chess Puzzle dengan Simulasi Monte Carlo dan Parallel Processing di R"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
  - Peluang
  - Parallel Computing
  - Random
---


Setelah mengerjakan *puzzle* terakhir terkait [tanggal ulang
tahun](https://ikanx101.com/blog/bday-prob/), saya tertarik mengerjakan
*puzzle* baru dengan memadukan simulasi Monte Carlo dan *parallel
processing*.

------------------------------------------------------------------------

## *Chess Puzzle*

Misalkan ada dua *grandmasters* catur terhebat di dunia saat ini. Mereka
akan dipertemukan dalam satu pertandingan berisi 12 babak.

-   Pemenang dari setiap babak tersebut akan mendapatkan 1 poin.
-   Jika terjadi *draw*, keduanya akan mendapatkan 0.5 poin.
-   Jika kalah, pemain tidak mendapatkan poin sama sekali.

*Grandmaster* yang pertama kali mendapatkan poin total 6.5 akan menang.
Jika dalam 12 babak tersebut tidak ada yang mencapai poin 6.5, maka kita
tidak bisa menyimpulkan siapa **GOAT** di antara mereka.

Dari statistik pertandingan yang ada saat ini, kita dapatkan informasi
sebagai berikut:

1.  Peluang *grandmaster* A menang adalah sebesar 20%.
2.  Peluang *grandmaster* B menang adalah sebesar 15%.
3.  Peluang *draw* adalah sebesar 65%.

Pertanyaannya:

> BERAPA PELUANG DALAM PERTANDINGAN INI KITA TIDAK BISA MENENTUKAN SIAPA
> GOAT?

## Solusi Menghitung Peluang

Untuk menghitung peluangnya, saya akan gunakan pendekatan simulasi Monte
Carlo. Langkah awal yang saya kerjakan adalah dengan melakukan deduksi
untuk satu babak terlebih dahulu lalu saya buat jadi 12 babak sehingga
*full* tercipta satu pertandingan.

Awalnya saya akan buat *initial condition* terlebih dahulu:

``` r
# initial
skor_a  = 0
skor_b  = 0
n_babak = 0
```

Buat *function* untuk satu babak:

``` r
# generate pertandingan
tanding = sample(c("a","d","b"),1,prob = c(.2,.65,.15))
tanding
```

    ## [1] "a"

Kemudian kita akan hitung skor masing-masing *grandmaster*:

``` r
# kita rekap nilainya
if(tanding == "a"){skor_a = skor_a + 1}
if(tanding == "b"){skor_b = skor_b + 1}
if(tanding == "d"){skor_a = skor_a + .5
                   skor_b = skor_b + .5}

# menambah babak
n_babak = n_babak + 1
```

Dari satu babak di atas, saya akan buat untuk **12 babak** ATAU **salah
satu** ***grandmaster*** **mencapai nilai 6.5 terlebih dahulu**.

Kemudian akan saya ulang `18.000` kali dengan prinsip *parallel
processing*. Berikut adalah detail *function*-nya:

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

Saya hanya menggunakan `library(parallel)` dan *base* **R** saja tanpa
melibatkan `tidyverse`.

## Hasil Perhitungan

Jadi peluang bahwa pertandingan 12 babak ini tidak menghasilkan **GOAT**
ada sekitar **18.9%**.

------------------------------------------------------------------------

Video *step by step ngoding*-nya saya *upload* di *channel* Youtube saya
di [*link* ini](https://youtu.be/mS7a19pw5oU).

`if you find this article helpful, support this blog by clicking the ads.`
