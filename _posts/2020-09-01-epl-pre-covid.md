---
date: 2020-09-01T05:00:00-04:00
title: "English Premier League: Sebelum dan Saat Pandemi"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Sport Science
  - Soccer
  - Football
  - t-Test
  - 2-proportion test
  - Premier League
  - R
---


Sebagaimana yang kita ketahui bersama, pandemi COVID-19 ini sudah
melanda banyak segi dalam kehidupan manusia. Sepakbola pun tak luput
dari pengaruhnya. Salah satunya adalah dihentikan sementara semua
kompetisi sepakbola di Eropa, baik kompetisi liga lokal hingga kompetisi
antar negara di sana.

Salah satunya adalah **English Premier League** pada musim 2019-2020.

Jika sebelumnya saya menuliskan tentang [mitos **Home vs
Away**](https://ikanx101.com/blog/EPL-home-away/), kini dengan data yang
sama saya akan melihat apakah ada perbedaan dalam segi pertandingan
sebelum dan saat pandemi di liga tersebut.

Setidaknya saya akan mencoba membandingkan dua hal, yakni:

1.  Apakah ada perbedaan proporsi tim pemenang pertandingan? Apakah tim
    kandang menjadi lebih lemah akibat tidak ada penonton saat pandemi?
    Apakah tim tandang menjadi lebih percaya diri sehingga lebih mudah
    menang saat berlaga saat pandemi?
2.  Apakah ada perbedaan banyaknya gol yang tercipta pada pertandingan
    sebelum dan saat pandemi?

Oh iya, mungkin Anda bertanya:

> Kenapa yang dibandingkan dua hal ini saja?

Jawabannya:

1.  Karena memang datanya terbatas. Sebenarnya ada data mengenai
    *shoots* tapi menurut saya *ending* pertandingan ada di angka gol
    dan hasil akhir. Namun jika ada data detail seperti *passes*,
    *tackles*, *dribbling*, dst mungkin akan lebih asik lagi
    *ngoprek*-nya.
2.  Hitung-hitung sebagai latihan dan diskusi bagi para pembaca jika
    ingin mengulang analisa dengan data lain.

Oh iya, sebagai informasi:

  - **English Premier League** musim 2019-2020 pertama bergulir sejak 9
    Agustus 2019 dan dihentikan sementara pada 9 Maret 2020.
  - Kemudian dilanjutkan kembali saat pandemi mulai 17 Juni 2020 sampai
    berakhir di 26 Juli 2020 dengan catatan pertandingan tidak
    disaksikan penonton di stadiun.

<table>

<caption>

Tabel: Berapa banyak pertandingan yang dijalankan?

</caption>

<thead>

<tr>

<th style="text-align:left;">

Kondisi

</th>

<th style="text-align:right;">

Banyak pertandingan

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Pre COVID

</td>

<td style="text-align:right;">

288

</td>

</tr>

<tr>

<td style="text-align:left;">

Saat COVID

</td>

<td style="text-align:right;">

92

</td>

</tr>

</tbody>

</table>

## Membandingkan Tim Pemenang Laga

Oke, saya mulai perbandingan yang pertama *yah*. Jadi saya akan
membandingkan kondisi `pre COVID` dengan kondisi `saat COVID`. Apakah
ada perbedaan siapa pemenang laga?

Mari kita lihat kondisi `pre COVID` sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL%20v2/post-baru_files/figure-gfm/unnamed-chunk-2-1.png" width="672" />

Sekarang kita lihat data `saat COVID`:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL%20v2/post-baru_files/figure-gfm/unnamed-chunk-3-1.png" width="672" />

Oke, sekarang saya sandingkan kedua *pie charts* di atas menjadi satu
sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL%20v2/post-baru_files/figure-gfm/unnamed-chunk-4-1.png" width="672" />

Sekarang saya akan melakukan **tiga** uji hipotesis:

1.  Apakah proporsi *home team* menang `saat COVID` berbeda dibandingkan
    `pre COVID`?
2.  Apakah proporsi *away team* menang `saat COVID` berbeda dibandingkan
    `pre COVID`?
3.  Apakah proporsi seri `saat COVID` berbeda dibandingkan `pre COVID`?

Ingat kembali bahwa langkah-langkah uji hipotesis adalah:

1.  ![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0"):
    ![proporsi\_{preCOVID} =
    proporsi\_{saatCOVID}](https://latex.codecogs.com/png.latex?proporsi_%7BpreCOVID%7D%20%3D%20proporsi_%7BsaatCOVID%7D
    "proporsi_{preCOVID} = proporsi_{saatCOVID}").
2.  ![H\_1](https://latex.codecogs.com/png.latex?H_1 "H_1"):
    ![proporsi\_{preCOVID} \\neq
    proporsi\_{saatCOVID}](https://latex.codecogs.com/png.latex?proporsi_%7BpreCOVID%7D%20%5Cneq%20proporsi_%7BsaatCOVID%7D
    "proporsi_{preCOVID} \\neq proporsi_{saatCOVID}").
3.  Jika
    ![p\_{-value}\< 0.05](https://latex.codecogs.com/png.latex?p_%7B-value%7D%3C%200.05
    "p_{-value}\< 0.05"), tolak
    ![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0").

### Uji pertama: *home team menang*

    ## 
    ##  2-sample test for equality of proportions with continuity correction
    ## 
    ## data:  c(43, 129) out of c(92, 288)
    ## X-squared = 0.042604, df = 1, p-value = 0.8365
    ## alternative hypothesis: two.sided
    ## 95 percent confidence interval:
    ##  -0.1047123  0.1436616
    ## sample estimates:
    ##    prop 1    prop 2 
    ## 0.4673913 0.4479167

    ## [1] "H0 tidak ditolak"

Oleh karena nilai ![p\_{-value}
=](https://latex.codecogs.com/png.latex?p_%7B-value%7D%20%3D
"p_{-value} =") 0.8364734
![\>0.05](https://latex.codecogs.com/png.latex?%3E0.05 "\>0.05"), kita
bisa ambil kesimpulan bahwa
![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0") tidak ditolak.

> Proporsi *home team* menang sebelum dan saat COVID sama\!

### Uji kedua: *away team menang*

    ## 
    ##  2-sample test for equality of proportions with continuity correction
    ## 
    ## data:  c(29, 87) out of c(92, 288)
    ## X-squared = 0.011691, df = 1, p-value = 0.9139
    ## alternative hypothesis: two.sided
    ## 95 percent confidence interval:
    ##  -0.1027804  0.1290485
    ## sample estimates:
    ##    prop 1    prop 2 
    ## 0.3152174 0.3020833

    ## [1] "H0 tidak ditolak"

Oleh karena nilai ![p\_{-value}
=](https://latex.codecogs.com/png.latex?p_%7B-value%7D%20%3D
"p_{-value} =") 0.9138962
![\>0.05](https://latex.codecogs.com/png.latex?%3E0.05 "\>0.05"), kita
bisa ambil kesimpulan bahwa
![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0") tidak ditolak.

> Proporsi *away team* menang sebelum dan saat COVID sama\!

### Uji ketiga: *seri*

    ## 
    ##  2-sample test for equality of proportions with continuity correction
    ## 
    ## data:  c(20, 72) out of c(92, 288)
    ## X-squared = 0.24589, df = 1, p-value = 0.62
    ## alternative hypothesis: two.sided
    ## 95 percent confidence interval:
    ##  -0.1377838  0.0725664
    ## sample estimates:
    ##    prop 1    prop 2 
    ## 0.2173913 0.2500000

    ## [1] "H0 tidak ditolak"

Oleh karena nilai ![p\_{-value}
=](https://latex.codecogs.com/png.latex?p_%7B-value%7D%20%3D
"p_{-value} =") 0.6199833
![\>0.05](https://latex.codecogs.com/png.latex?%3E0.05 "\>0.05"), kita
bisa ambil kesimpulan bahwa
![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0") tidak ditolak.

> Proporsi seri sebelum dan saat COVID sama\!

### Kesimpulan PERTAMA:

Dari hasil uji perbedaan proporsi tim pemenang laga, bisa saya simpulkan
bahwa: **tidak ada perbedaan atau perubahan dari sebelum dan saat COVID
di EPL 2019-2020**.

Jika saya cek lagi, *home team* menjadi tim yang paling sering menang
pertandingan sebelum dan saat COVID.

-----

## Membandingkan Banyaknya *Goals* yang Tercipta

Sekarang saya akan coba membandingkan banyaknya *goals* yang tercipta
pada `pre COVID` dan `saat COVID`.

Pertama-tama, kita lihat perbandingan *goals* yang dicetak oleh *home
team*:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL%20v2/post-baru_files/figure-gfm/unnamed-chunk-8-1.png" width="672" />

Kita lihat juga perbandingan *goals* yang dicetak oleh *away team*:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL%20v2/post-baru_files/figure-gfm/unnamed-chunk-9-1.png" width="672" />

<table>

<caption>

Tabel: Apakah ada perbedaan goal yang tercipta?

</caption>

<thead>

<tr>

<th style="text-align:left;">

Kondisi

</th>

<th style="text-align:right;">

Goal Home Team

</th>

<th style="text-align:right;">

StDev Goal Home Team

</th>

<th style="text-align:right;">

Goal Away Team

</th>

<th style="text-align:right;">

StDev Goal Away Team

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Pre COVID

</td>

<td style="text-align:right;">

1.506944

</td>

<td style="text-align:right;">

1.192290

</td>

<td style="text-align:right;">

1.215278

</td>

<td style="text-align:right;">

1.207775

</td>

</tr>

<tr>

<td style="text-align:left;">

Saat COVID

</td>

<td style="text-align:right;">

1.543478

</td>

<td style="text-align:right;">

1.417419

</td>

<td style="text-align:right;">

1.173913

</td>

<td style="text-align:right;">

1.182368

</td>

</tr>

</tbody>

</table>

Melihat tabel di atas, sebenarnya tanpa melakukan uji apapun sudah bisa
dilihat bahwa **tidak ada perbedaan** goal yang dicetak oleh *home team*
atau *away team* pada `pre COVID` dan `saat COVID`.

Tapi biar pasti, akan saya uji menggunakan\_ \_t.Test\_\_ untuk
masing-masing *home team* dan *away team*.

Ingat kembali bahwa langkah-langkah uji hipotesis adalah:

1.  ![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0"):
    ![mean(goal)\_{preCOVID} =
    mean(goal)\_{saatCOVID}](https://latex.codecogs.com/png.latex?mean%28goal%29_%7BpreCOVID%7D%20%3D%20mean%28goal%29_%7BsaatCOVID%7D
    "mean(goal)_{preCOVID} = mean(goal)_{saatCOVID}").
2.  ![H\_1](https://latex.codecogs.com/png.latex?H_1 "H_1"):
    ![mean(goal)\_{preCOVID} \\neq
    mean(goal)\_{saatCOVID}](https://latex.codecogs.com/png.latex?mean%28goal%29_%7BpreCOVID%7D%20%5Cneq%20mean%28goal%29_%7BsaatCOVID%7D
    "mean(goal)_{preCOVID} \\neq mean(goal)_{saatCOVID}").
3.  Jika
    ![p\_{-value}\< 0.05](https://latex.codecogs.com/png.latex?p_%7B-value%7D%3C%200.05
    "p_{-value}\< 0.05"), tolak
    ![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0").

### Uji pertama: goal dari *home team*

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  fthg by kondisi
    ## t = -0.22328, df = 134.61, p-value = 0.8237
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.3601460  0.2870784
    ## sample estimates:
    ##  mean in group Pre COVID mean in group Saat COVID 
    ##                 1.506944                 1.543478

    ## [1] "H0 tidak ditolak"

Oleh karena nilai ![p\_{-value}
=](https://latex.codecogs.com/png.latex?p_%7B-value%7D%20%3D
"p_{-value} =") 0.8236598
![\>0.05](https://latex.codecogs.com/png.latex?%3E0.05 "\>0.05"), kita
bisa ambil kesimpulan bahwa
![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0") tidak ditolak.

> Rata-rata goal *home team* ketika `pre COVID` dan `saat COVID` tidak
> ada perbedaan.

### Uji kedua: goal dari *away team*

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  ftag by kondisi
    ## t = 0.29061, df = 156.27, p-value = 0.7717
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.2397932  0.3225227
    ## sample estimates:
    ##  mean in group Pre COVID mean in group Saat COVID 
    ##                 1.215278                 1.173913

    ## [1] "H0 tidak ditolak"

Oleh karena nilai ![p\_{-value}
=](https://latex.codecogs.com/png.latex?p_%7B-value%7D%20%3D
"p_{-value} =") 0.7717381
![\>0.05](https://latex.codecogs.com/png.latex?%3E0.05 "\>0.05"), kita
bisa ambil kesimpulan bahwa
![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0") tidak ditolak.

> Rata-rata goal *away team* ketika `pre COVID` dan `saat COVID` tidak
> ada perbedaan.

### Kesimpulan KEDUA:

Ternyata tidak ada perbedaan rata-rata goal yang tercipta ketika `pre
COVID` dan `saat COVID`.

## KESIMPULAN

Sebagai salah satu liga sepakbola terbaik di atas bumi ini, tampaknya
kualitas pertandingan sebelum dan saat pandemi ini tidak ada perbedaan
signifikan.

> Mantab lah\!
