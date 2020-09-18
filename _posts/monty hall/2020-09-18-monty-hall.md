---
date: 2020-09-18T05:08:00-04:00
title: "SIMULASI MONTECARLO: Saat Doctor Strange Ikutan Kuis Superdeal 1 Milliar"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
  - Kuis
  - Superdeal
  - Monty Hall
---


<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/monty%20hall/meme.jpeg" width="267" style="display: block; margin: auto;" />

Selepas kemenangan melawan *Thanos*, kini para anggota *Avengers*
melanjutkan hidupnya masing-masing. Untuk melawan kejenuhan akibat `5`
tahun berada di realita lain, *Doctor Strange* iseng-iseng mengikuti
kuis `Superdeal 1 Milliar`.

> Barangkali saya bisa menang…

Begitu pikirnya.

-----

Singkat cerita, *Doctor Strange* masuk ke dalam babak final. Dia berdiri
bersama dengan *host* di depan `3` pintu yang salah satunya berisi
hadiah *supercar*, sedangkan `2` pintu lainnya berisi *zonk*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/monty%20hall/monty-hall_files/figure-gfm/unnamed-chunk-2-1.png" width="60%" style="display: block; margin: auto;" />

  - Pertama-tama, si *host* meminta *Doctor Strange* untuk memilih salah
    satu pintu.
  - Setelah *Doctor Strange* memilih satu pintu, si *host* tiba-tiba
    membuka salah satu pintu yang berisi *zonk*.
  - Lalu dengan nada penuh kelicikan, si *host* menawarkan kepada
    *Doctor Strange*: **“Apakah kamu mau mengganti pilihan ke pintu yang
    lain?”**.

Seketika iman *Doctor Strange* agak goyah. *Doctor Strange* ingat saat
dulu melakukan simulasi `Fourteen million, six hundred and five times`
saat melawan *Thanos*. Kali ini dia lupa membawa *Time Stone*.

Kira-kira keputusan mana yang paling tepat?

> Di antara keputusan *stay* atau *switch*, keputusan mana yang
> memberikan peluang terbesar ia mendapatkan hadiah.

-----

Di dunia matematika permasalahan ini disebut dengan [*Monty Hall
Problem*](https://en.wikipedia.org/wiki/Monty_Hall_problem). Ada
berbagai macam cara untuk bisa menyelesaikan masalah ini. Salah satu
dengan dengan perhitungan logika biasa seperti *flow* di bawah ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/monty%20hall/monty-hall_files/figure-gfm/unnamed-chunk-3-1.png" width="60%" style="display: block; margin: auto;" />

Pilihan *switch* menjadi pilihan yang memberikan peluang terbesar, yakni
![\\frac{2}{3}
=](https://latex.codecogs.com/png.latex?%5Cfrac%7B2%7D%7B3%7D%20%3D
"\\frac{2}{3} =") 66.7% dibandingkan tetap *stay* pada pilihan awal.

-----

Dengan menggunakan prinsip yang pernah dilakukan oleh *Doctor Strange*
saat melawan *Thanos*, kita bisa melakukan jutaan simulasi **Monte
Carlo** untuk menghitung berapa peluang *stay* atau *switch*\!

Misalkan, saya akan buat simulasi sebanyak `1000` kali. Ini adalah `15`
data iterasi pertama:

| iterasi\_ke | stay | switch |
| ----------: | ---: | -----: |
|           1 |  0.0 |  100.0 |
|           2 | 50.0 |   50.0 |
|           3 | 33.3 |   66.7 |
|           4 | 25.0 |   75.0 |
|           5 | 20.0 |   80.0 |
|           6 | 16.7 |   83.3 |
|           7 | 14.3 |   85.7 |
|           8 | 12.5 |   87.5 |
|           9 | 11.1 |   88.9 |
|          10 | 20.0 |   80.0 |
|          11 | 18.2 |   81.8 |
|          12 | 16.7 |   83.3 |
|          13 | 23.1 |   76.9 |
|          14 | 21.4 |   78.6 |
|          15 | 20.0 |   80.0 |

Jika hasil simulasinya saya buat dalam bentuk grafik:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/monty%20hall/monty-hall_files/figure-gfm/unnamed-chunk-5-1.png" width="864" style="display: block; margin: auto;" />

Maka, keputusan yang harus diambil *Doctor Strange* adalah dia harus
*switch* pilihannya ke pintu lainnya.
