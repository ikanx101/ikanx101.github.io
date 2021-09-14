---
date: 2021-09-14T09:00:00-04:00
title: "Menghitung Nilai Pi dengan Trapezoid (Aproksimasi Numerik)"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Computational Science
  - Sains Komputasi
  - Matematika
  - Kuliah
  - ITB
  - Analisa Numerik Lanjut
  - Komputasi
  - Aproksimasi
  - Pi
  - Matematika
  - Lingkaran
---


Pada *post* yang lalu, saya pernah menuliskan bagaimana [simulasi
MonteCarlo](https://ikanx101.com/blog/hitung-pi/) digunakan untuk
mengaproksimasi nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\pi"). Jika kamu
belum membacanya, saya sarankan untuk membacanya terlebih dahulu.

Pada tulisan tersebut, saya mencoba mengaproksimasi dengan cara seperti
melempar *darts* ke
![1/4](https://latex.codecogs.com/png.latex?1%2F4 "1/4") lingkaran. Luas
lingkarannya adalah rasio banyaknya **darts on target per total lemparan
darts** yang saya lakukan.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/Hitung%20Pi/Blog-post_files/figure-gfm/unnamed-chunk-2-1.png" width="50%" style="display: block; margin: auto;" />

------------------------------------------------------------------------

## Aproksimasi Cara Lain

Sebenarnya ada banyak cara untuk menghampiri nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\pi"), salah satunya
adalah dengan menghitung integral atau luas daerah di bawah kurva
lingkaran berjari-jari 1 satuan.

Oke, untuk memudahkan, saya akan buat
![1/4](https://latex.codecogs.com/png.latex?1%2F4 "1/4") lingkaran
berikut ini:

![f(x) = \\sqrt{1 - x^2} \\text{, untuk x } \\in \[0,1\]](https://latex.codecogs.com/png.latex?f%28x%29%20%3D%20%5Csqrt%7B1%20-%20x%5E2%7D%20%5Ctext%7B%2C%20untuk%20x%20%7D%20%5Cin%20%5B0%2C1%5D "f(x) = \sqrt{1 - x^2} \text{, untuk x } \in [0,1]")

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/analisa%20numerik%20lanjut/hitung%20Pi/pi_lagi_files/figure-gfm/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

Ekspektasinya adalah:
![\\pi = 4 \\times \\int\_0^1 f(x)](https://latex.codecogs.com/png.latex?%5Cpi%20%3D%204%20%5Ctimes%20%5Cint_0%5E1%20f%28x%29 "\pi = 4 \times \int_0^1 f(x)").

Secara eksak, kita bisa menghitung integral fungsinya dan akhirnya
mendapatkan nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\pi").

> *Bagaimana jika saya terlalu malas untuk melakukan integral?*

Saya bisa memilih untuk melakukan pendekatan secara numerik. Yakni
dengan menghitung luas di bawah kurva menggunakan hampiran *trapezoid*.
Berikut adalah ilustrasinya:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/analisa%20numerik%20lanjut/hitung%20Pi/images.png" alt="Sumber bragitoff.com" width="55%" />
<p class="caption">
Sumber bragitoff.com
</p>

</div>

Menggunakan rumus yang tertera di atas, tugas kita sekarang “hanya”
menentukan mau menggunakan nilai *N* berapa. *N* adalah berapa banyak
*trapezoid* yang hendak kita *generate*. Tentunya semakin banyak, semaki
akurat, tapi secara komputasi akan lebih “lama” (walaupun gak lama-lama
*banget donk*).

*Yuk* kita hitung dengan berbagai macam nilai *N*. Kita akan bandingkan:

1.  *Error*-nya dengan nilai
    ![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\pi") *default*
    di **R**. Saya definisikan
    ![error = \|\\pi - hampiran\|](https://latex.codecogs.com/png.latex?error%20%3D%20%7C%5Cpi%20-%20hampiran%7C "error = |\pi - hampiran|").
2.  *Processing time*.

|     N | Pi\_hampiran |     Error | Proc\_Time |
|------:|-------------:|----------:|-----------:|
|     5 |     3.037049 | 0.1045438 |  0.0016525 |
|    10 |     3.104518 | 0.0370743 |  0.0000131 |
|    40 |     3.136948 | 0.0046449 |  0.0000274 |
|   100 |     3.140417 | 0.0011756 |  0.0000610 |
|   400 |     3.141446 | 0.0001470 |  0.0002158 |
|  1000 |     3.141555 | 0.0000372 |  0.0005553 |
|  2500 |     3.141583 | 0.0000094 |  0.0013666 |
|  5000 |     3.141589 | 0.0000033 |  0.0026932 |
| 10000 |     3.141592 | 0.0000012 |  0.0052893 |
| 25000 |     3.141592 | 0.0000003 |  0.0155118 |
| 60000 |     3.141593 | 0.0000001 |  0.0341628 |

Terkonfirmasi *yah* bahwa semakin banyak *N* hasil hampirannya semakin
akurat dan *processing time*-nya relatif lebih lama.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
