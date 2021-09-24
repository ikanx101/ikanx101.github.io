---
date: 2021-09-24T04:00:00-04:00
title: "Menghitung Nilai Integral Tentu Dengan Modifikasi Simulasi Monte Carlo"
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

Sepertinya sudah lama saya tidak menulis lagi karena *riweuh* di kantor
dan kuliah.

Untuk membuka kembali niat untuk menulis, saya akan bercerita tentang
salah satu metode aproksimasi (hampiran) yang bisa digunakan untuk
menghitung nilai integral tentu di matematika.

Sebelumnya, saya pernah menulis tentang cara menghitung nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\pi") dengan dua
cara:

1.  [Melempar *darts* ala Simulasi Monte
    Carlo](https://ikanx101.com/blog/hitung-pi/).
2.  [Membuat pendekatan trapezoid dari fungsi seperempat
    lingkaran](https://ikanx101.com/blog/pi-trapezoid/).

Nah, cara ketiga ini merupakan modifikasi atau gabungan dari keduanya.

> *Lho kok bisa?*

Jadi saya akan gunakan prinsip Monte Carlo untuk *generate random
points* di selang integral tentu lalu menggunakan pendekatan luas
*square* seperti halnya *trapezoid*.

------------------------------------------------------------------------

Sebagai contoh, saya akan menyelesaikan soal berikut:

Hitunglah:

![f(x) = \\int\_2^3 (x^2 + 4x \\sin{x}) dx](https://latex.codecogs.com/png.latex?f%28x%29%20%3D%20%5Cint_2%5E3%20%28x%5E2%20%2B%204x%20%5Csin%7Bx%7D%29%20dx "f(x) = \int_2^3 (x^2 + 4x \sin{x}) dx")

Jika kita hendak mencari solusi analitiknya, sepertinya agak susah
*yah*. *hehe* (atau saya saja yang cenderung malas)

Solusi analitik dari
![f(x) = \\int (x^2 + 4x \\sin{x}) dx](https://latex.codecogs.com/png.latex?f%28x%29%20%3D%20%5Cint%20%28x%5E2%20%2B%204x%20%5Csin%7Bx%7D%29%20dx "f(x) = \int (x^2 + 4x \sin{x}) dx")
adalah:

![F(x) = \\frac{x^3}{3} - 4x \\cos{x} + 4 \\sin{x}](https://latex.codecogs.com/png.latex?F%28x%29%20%3D%20%5Cfrac%7Bx%5E3%7D%7B3%7D%20-%204x%20%5Ccos%7Bx%7D%20%2B%204%20%5Csin%7Bx%7D "F(x) = \frac{x^3}{3} - 4x \cos{x} + 4 \sin{x}")

Sehingga:

![\\int\_2^3 (x^2 + 4x \\sin{x}) dx \\approx 11.811358925](https://latex.codecogs.com/png.latex?%5Cint_2%5E3%20%28x%5E2%20%2B%204x%20%5Csin%7Bx%7D%29%20dx%20%5Capprox%2011.811358925 "\int_2^3 (x^2 + 4x \sin{x}) dx \approx 11.811358925")

Oleh karena itu ada metode aproksimasi yang relatif lebih mudah
dilakukan (menurut saya).

Ide dari algoritma ini adalah men-*generate* titik *random* di selang
integral, kemudian dihitung luas *square* yang ada.

> Perhatikan bahwa titik yang di-*generate* adalah pada sumbu
> ![x](https://latex.codecogs.com/png.latex?x "x") (selang integral)
> saja. Berbeda dengan *darts* yang memerlukan random di sumbu
> ![x](https://latex.codecogs.com/png.latex?x "x") dan
> ![y](https://latex.codecogs.com/png.latex?y "y").

Sehingga:

![I = \\int\_z^b f(x)dx](https://latex.codecogs.com/png.latex?I%20%3D%20%5Cint_z%5Eb%20f%28x%29dx "I = \int_z^b f(x)dx")

dihitung sebagai:

![&lt;F^N&gt; = \\frac{b-a}{N+1} \\sum\_{i=0}^N f(a + (b-a) \\xi\_i)](https://latex.codecogs.com/png.latex?%3CF%5EN%3E%20%3D%20%5Cfrac%7Bb-a%7D%7BN%2B1%7D%20%5Csum_%7Bi%3D0%7D%5EN%20f%28a%20%2B%20%28b-a%29%20%5Cxi_i%29 "<F^N> = \frac{b-a}{N+1} \sum_{i=0}^N f(a + (b-a) \xi_i)")

dengan

![\\xi\_i \\text{ adalah random number antara 0 dan 1}](https://latex.codecogs.com/png.latex?%5Cxi_i%20%5Ctext%7B%20adalah%20random%20number%20antara%200%20dan%201%7D "\xi_i \text{ adalah random number antara 0 dan 1}")

Berikut adalah *flowchart*-nya:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/Integral/squre_files/figure-gfm/unnamed-chunk-1-1.png" alt="Flowchart Modifikasi Monte Carlo" width="50%" />
<p class="caption">
Flowchart Modifikasi Monte Carlo
</p>

</div>

Berdasarkan *flowchart* di atas, berikut adalah *function* di **R**
-nya:

``` r
modif_monte = function(f,x1,x2,N){
  # set template terlebih dahulu
  hasil = c()
  
  # kita akan ulang proses ini 100 kali untuk N titik
  for(ikang in 1:100){
    # generating random number
    x = runif(N,x1,x2)
    # hitung f(x)
    f_x = f(x)
    # hitung luas
    luas = (x2-x1) * f_x
    mean_luas = mean(luas)
    hasil[ikang] = mean_luas
  }
  # mean luas
  output = mean(hasil)
  # output
  return(output)
  }
```

> *Simple* kan?

Oke, sebelum menyelesaikannya dengan fungsi di atas, saya akan berikan
ilustrasi sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/Integral/squre_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Di atas adalah grafik dari
![f(x)](https://latex.codecogs.com/png.latex?f%28x%29 "f(x)"). Metode
ini bertujuan untuk men-*generate* **satu** random titik di antara
selang
![\[2,3\]](https://latex.codecogs.com/png.latex?%5B2%2C3%5D "[2,3]")
(misal saya tuliskan sebagai
![x\_i](https://latex.codecogs.com/png.latex?x_i "x_i") kemudian
dihitung nilai
![f(x\_i)](https://latex.codecogs.com/png.latex?f%28x_i%29 "f(x_i)").

Contoh:

Saya akan *generate* satu titik sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/Integral/squre_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

Dari titik tersebut, saya akan buat garis sehingga terbentuklah sebuah
*square*:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/Integral/squre_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Kelak kita akan menghitung luas dari *square* tersebut.

Semakin banyak kita *generate* titiknya, kita bisa menghitung rata-rata
luas dari *squares* tersebut. Nilai rata-rata tersebut akan dijadikan
hampiran integral tentu.

Berikut adalah nilai hampirannya untuk berbagai banyak titik yang
di-*generate*:

|   N    | Solusi Aproksimasi | Selisih dengan Nilai Eksak |
|:------:|:------------------:|:--------------------------:|
|   10   |      11.78907      |         0.0222857          |
|  100   |      11.80707      |         0.0042907          |
|  500   |      11.81512      |         0.0037561          |
|  750   |      11.81119      |         0.0001678          |
|  1000  |      11.81079      |         0.0005681          |
|  5000  |      11.81043      |         0.0009298          |
|  7500  |      11.81094      |         0.0004159          |
| 10000  |      11.81127      |         0.0000927          |
| 25000  |      11.81206      |         0.0007033          |
| 50000  |      11.81161      |         0.0002520          |
| 100000 |      11.81105      |         0.0003059          |
| 250000 |      11.81138      |         0.0000242          |
| 500000 |      11.81129      |         0.0000719          |
| 750000 |      11.81142      |         0.0000590          |

Hasil Perbandingan Solusi Numerik dan Eksak

Untuk setiap banyak titik, prosesnya saya ulangi hingga 100 kali agar
lebih konvergen ke hasilnya.

Terlihat bahwa nilai hampirannya sudah **sangat dekat** dengan nilai
eksaknya.

------------------------------------------------------------------------

`if you find thsi article helpful, support this blog by clicking the ads.`
