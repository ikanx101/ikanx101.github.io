---
date: 2023-01-25T14:09:00-04:00
title: "Membuktikan Birthday Problem dengan Parallel Computing di R"
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


Pagi ini saat saya membuka sosmed, saya mendapatkan notifikasi bahwa ada
2 orang rekan kantor saya yang berulang tahun hari ini. Walaupun berbeda
tahun lahir, tapi tanggal dan bulannya *exactly* sama.

## *Birthday Problem*

> Jika kita kumpulkan 30 orang secara acak dalam satu ruangan, ada
> peluang `70%` ditemukan minimal sepasang orang yang memiliki tanggal
> dan bulan lahir yang sama.

Pernyataan di atas adalah *birthday problem*. Bagaimana cara saya
membuktikan hal tersebut?

## Pembuktian dengan **R**

Saya akan membuat simulasi Monte Carlo untuk men-*generate* kondisi 30
orang *random* yang dikumpulkan dan melihat apakah ada minimal dua orang
yang memiliki tanggal dan bulan lahir yang sama.

Karena PC yang saya gunakan memiliki 12 *cores*, saya akan gunakan 10
*cores* untuk melakukan *parallel processing* dengan
`library(parallel)`.

Berikut adalah skrip yang saya gunakan:

    library(parallel)
    n_cores = 10

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

Hasilnya adalah:

> Peluang ada minimal sepasang orang yang punya tanggal dan bulan lahir
> yang sama adalah sekitar `70.5%`.

------------------------------------------------------------------------

Proses saya melakukan simulasi di **R** bisa dilihat di *channel*
Youtube saya berikut [ini](https://youtu.be/W3lAoSHIL3I).

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
