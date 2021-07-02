---
date: 2021-07-02T05:08:00-04:00
title: "Bisakah Mendapatkan Nilai Bagus pada Ujian dengan Cara Menjawab Asal?"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
  - Peluang
  - Binomial
  - Sekolah
  - Random
---

Waktu sekolah dulu (SMP atau SMA), apakah kalian pernah memiliki teman
yang selalu mendapatkan nilai bagus saat ujian tapi saat ditanya-tanya,
dia hanya bilang:

> ***Gw gak belajar, beruntung aja dapat nilai bagus padahal jawabnya
> ngasal…***

Dulu saya ppernah punya teman yang seperti itu. Saya pribadi *sih* tidak
percaya bahwa itu adalah keberuntungan. Kenapa? Secara simulasi
statistik, kita bisa membuktikan pernyataan itu.

------------------------------------------------------------------------

## Perhitungan Matematis

Misalkan saya memiliki 50 pertanyaan ujian berupa pilihan ganda (empat
opsi pilihan) dengan **hanya satu opsi yang benar**.

Secara simpel, kita bisa hitung bahwa **peluang seseorang menjawab satu
pertanyaan dengan benar\_ **secara **\_ngasal**\_ adalah
![\\frac{1}{4} = 25 \\%](https://latex.codecogs.com/png.latex?%5Cfrac%7B1%7D%7B4%7D%20%3D%2025%20%5C%25 "\frac{1}{4} = 25 \%").

Jadi untuk menjawab 50 pertanyaan secara ***ngasal***, kita bisa hitung
*expected* nilai ujiannya sebesar:

![\\frac{\\text{banyak pertanyaan benar}}{\\text{banyak pertanyaan}}.100 = \\frac{\\frac{1}{4} . 50}{50}.100 = 25](https://latex.codecogs.com/png.latex?%5Cfrac%7B%5Ctext%7Bbanyak%20pertanyaan%20benar%7D%7D%7B%5Ctext%7Bbanyak%20pertanyaan%7D%7D.100%20%3D%20%5Cfrac%7B%5Cfrac%7B1%7D%7B4%7D%20.%2050%7D%7B50%7D.100%20%3D%2025 "\frac{\text{banyak pertanyaan benar}}{\text{banyak pertanyaan}}.100 = \frac{\frac{1}{4} . 50}{50}.100 = 25")

Dari hitung-hitungan di atas, kita bisa dapatkan bahwa *expected* nilai
ujiannya adalah sebesar **25**.

## Pembuktian dengan Simulasi

Perhitungan di atas belum cukup untuk membuktikan pernyataan teman saya
tersebut. Kenapa?

> ***Saya perlu menghitung berapa peluang seseorang mendapatkan nilai
> bagus dengan cara menjawab ngasal!***

Lantas bagaimana cara saya menghitung peluangnya?

Saya akan gunakan simulasi Monte Carlo.

Bagaimana cara kerjanya?

Saya akan *generate* semua kemungkinan nilai ujian yang muncul sebanyak
`90.000` kali iterasi dengan ketentuan:

1.  Ada `50` soal ujian pilihan ganda.
2.  Ada `4` opsi jawaban dengan **hanya satu** pilihan yang benar.

Dari hasil `90.000` kali iterasi, saya akan buat histogramnya dan
kemudian saya akan hitung berapa peluang seseorang mendapatkan nilai
**bagus**.

Saya akan definisikan nilai **bagus** adalah minimal sebesar **80**
(minimal 40 soal terjawab benar dari 50 total soal yang ada).

Berikut hasil simulasi saya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/Ujian%20Asal/post_files/figure-gfm/unnamed-chunk-1-1.png" width="672" style="display: block; margin: auto;" />

Dilihat dari grafik hasil simulasi di atas, bahwa hampir tidak mungkin
seseorang mendapatkan nilai ujian minimal **80**.

> Peluangnya **nol**.

## Pembuktian dengan Distribusi Binomial

Sebenarnya kasus di atas bisa dipandang sebagai masalah di data
berdistribusi Binomial.

![P\_x = \\begin{pmatrix}
 n\\\\x
\\end{pmatrix} p^x(1-p)^{n-x}](https://latex.codecogs.com/png.latex?P_x%20%3D%20%5Cbegin%7Bpmatrix%7D%0A%20n%5C%5Cx%0A%5Cend%7Bpmatrix%7D%20p%5Ex%281-p%29%5E%7Bn-x%7D "P_x = \begin{pmatrix}
 n\\x
\end{pmatrix} p^x(1-p)^{n-x}")

Peluang terjadinya *event*
![x](https://latex.codecogs.com/png.latex?x "x") dari total
![n](https://latex.codecogs.com/png.latex?n "n") dengan proporsi
**sukses** sebesar ![p](https://latex.codecogs.com/png.latex?p "p").

Untuk kasus ini, maka peluang seseorang mendapatkan nilai **bagus**
adalah:

![P\_{40 \\leq x \\leq 50} = \\sum\_{i=40}^{50} P\_i = \\sum\_{i=40}^{50} \\begin{pmatrix}
 50\\\\i
\\end{pmatrix} 0.25^i(0.75)^{50-i} \\approx 4\*10^{-16} \\approx 0](https://latex.codecogs.com/png.latex?P_%7B40%20%5Cleq%20x%20%5Cleq%2050%7D%20%3D%20%5Csum_%7Bi%3D40%7D%5E%7B50%7D%20P_i%20%3D%20%5Csum_%7Bi%3D40%7D%5E%7B50%7D%20%5Cbegin%7Bpmatrix%7D%0A%2050%5C%5Ci%0A%5Cend%7Bpmatrix%7D%200.25%5Ei%280.75%29%5E%7B50-i%7D%20%5Capprox%204%2A10%5E%7B-16%7D%20%5Capprox%200 "P_{40 \leq x \leq 50} = \sum_{i=40}^{50} P_i = \sum_{i=40}^{50} \begin{pmatrix}
 50\\i
\end{pmatrix} 0.25^i(0.75)^{50-i} \approx 4*10^{-16} \approx 0")

Peluangnya **nol**.

------------------------------------------------------------------------

## Kesimpulan

Jadi teman saya sepertinya tidak bisa dipercayai omongannya. *hehe*

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads`.
