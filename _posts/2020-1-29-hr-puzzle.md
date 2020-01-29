---
date: 2020-1-27T13:08:00-04:00
title: "Interview Overbudget Problem"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
---

Apakah Kamu sudah selesai menyelesaikan [tiga puzzles di
blog](https://ikanx101.github.io/tags/#monte-carlo) ini?

Sekarang ada *puzzle* ke empat. Terinspirasi dari *Airline Overbooking
Problem*, saya modifikasi sedikit dengan memasukan *local wisdom* yah.
*heee*

-----

Jadi begini ceritanya:

> Tim HR di suatu perusahaan menggunakan jasa biro psikologi untuk
> melakukan seleksi kandidat karyawan. Setiap minggunya, tim HR
> menelepon dan memanggil **75 orang** kandidat karyawan untuk dites
> oleh biro tersebut. Kenapa 75 orang? Karena ruang aula dan peralatan
> yang ada di biro itu hanya mampu menampung 75 orang kandidat.
> Berdasarkan data historikal, biasanya hanya **85%** saja yang datang.

Oleh karena itu, tim HR berinisiatif untuk memanggil lebih dari 75 orang
sebagai *buffer* agar kuota dan ruangan aulanya bisa dipenuhi.

Kondisi yang dihadapi:

  - Jika peserta yang datang kurang dari `75` orang, tim HR rugi Rp
    100.000 per orang karena mubazir *man power* dari biro dan katering
    kandidat.
  - **TAPI**, jika kandidat yang datang melebihi kapasitas ruang aula,
    tim HR harus menyewa peralatan tambahan kepada pihak biro sebesar Rp
    100.000 per orang dan menambah Rp 30.000 per orang untuk katering.

> Berapa banyaknya kandidat yang harus dipanggil oleh tim HR sehingga
> ruang aula penuh tanpa harus menyewa peralatan dari pihak biro dan
> tanpa ada *overbudget* katering?

-----

## Jawaban *Logic*

Simpelnya, jika kita memiliki kondisi:

1.  Dari `75` orang yang dipanggil hanya `85%` yang datang.
2.  Aula harus penuh tanpa *over capacity*.

Maka kita tinggal menghitung `n` orang kandidat sedemikian sehingga akan
datang `75` orang kandidat.

``` r
n = 75 / (89/100)
round(n,0)
```

    ## [1] 84

Cukup `84` orang kandidat saja.

Jawaban ini tanpa memperhitungkan kerugian yang ditimbulkan saat terjadi
kekurangan atau kelebihan kandidat.

-----

## Jawaban Simulasi

Sekarang, kita akan lakukan simulasi **Monte Carlo** untuk mendapatkan
jawaban dan mencocokkannya dengan jawaban di atas.

Untuk kasus ini, saya akan mencari keoptimalan di bagian `biaya` yang
dikeluarkan HR. Logikanya sederhana:

1.  Jika kandidat yang datang `n < 75`, maka HR akan merugi sebesar
    `n*100` ribu rupiah.
2.  Jika kandidat yang datang `n > 75`, maka HR akan merugi sebesar
    `n*(100+30)` ribu rupiah.
3.  Jika kandidat yang datang `n = 75`, maka HR tidak mengeluarkan biaya
    apa-apa.

*So*, apakah ada penambahan *buffer* yang menghasilkan `biaya` yang
paling kecil?

Jadi *personally*, masalah ini berubah menjadi optimasi *instead of
probabilistic problem*.

![simulesyen](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/puzzles/HR%20Interview%20Overbooking/blog-post_files/figure-gfm/unnamed-chunk-2-1.png)

> Dari simulasi di atas, ternyata kita bisa memanggil lebih dari `84`
> orang.

*Menarique yah*.
