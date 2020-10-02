---
date: 2020-09-30T10:49:00-04:00
title: "Text Analysis: Membandingkan Dua Topik Artikel dari Harvard Business Review"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Text Analysis
  - Web Series
  - Marketing
  - Crosswords Analysis
  - Log Odds Ratio
---

Pernah rekan saya bertanya seperti ini:

> [Data berupa teks bisa dianalisa apa saja
> ya?](https://ikanx101.com/blog/QnA-1/#pertanyaan-9)

Setidaknya ada tiga tulisan terkait *text analysis* yang pernah saya
buat, yakni:

1.  Komentar netizen pada webseries
    [Sunyi](https://ikanx101.com/blog/blog-posting-sunyi/).
2.  *Keywords* di [tahun baru](https://ikanx101.com/blog/tahun-baru/).
3.  Membaca artikel diabetes di
    [detik.com](https://passingthroughresearcher.wordpress.com/2019/08/15/menelusuri-pencarian-keyword-diabetes-mellitus-di-detikhealth/).

Sekarang saya akan membuat sesuatu yang berbeda. Apa itu? Ada `2`
analisa yang mau saya coba kali ini, yakni:

1.  *Crosswords analysis* dan
2.  *Log odds ratio*.

Tujuan dari `2` analisa itu adalah membandingkan dan menemukan kata-kata
yang menjadi pembeda antara `2` topik atau kategori data teks.

-----

Sebagai contoh, saya akan menggunakan [data
teks](https://github.com/ikanx101/belajaR/blob/master/Bukan%20Infografis/HBR/clean.rda)
berupa `14` artikel terbaru dari situs [HBR](https://hbr.org/) yang saya
*scrape* pagi ini (30 September 2020 pukul 10.30 WIB). `14` artikel
tersebut terdiri dari `7` artikel dari kategori `leadership` dan `7`
artikel dari kategori `technology`.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/HBR/artikel-HBR_files/figure-gfm/unnamed-chunk-1-1.png" width="75%" style="display: block; margin: auto;" />

## Pre Processing Data

Sebelum jauh melakukan analisa, ada beberapa langkah *pre processing*
yang saya lakukan:

1.  *Stemming*: Yakni mengubah kata menjadi bentuk dasarnya di Bahasa
    Inggris. Saya membuat *function* dari `library(hunspell)`.
2.  *Remove stopwords* bahasa Inggris. *Database* *stopwords* saya ambil
    dari
    [sini](https://raw.githubusercontent.com/stopwords-iso/stopwords-en/master/stopwords-en.txt).
3.  Hapus tanda baca dan *trim white space*. Saya menggunakan
    `library(janitor)`.

## *Crosswords Analysis*

Cara kerja analisa ini cenderung sangat mudah. Begini caranya:

1.  Buat tabulasi frekuensi dari kata-kata yang muncul dari `2` kategori
    tersebut.
2.  Pilih semua kata yang beririsan dari kategori **A** dan **B**.
3.  Buat *scatterplot* dari data tersebut ![(A \\sim
    B)](https://latex.codecogs.com/png.latex?%28A%20%5Csim%20B%29
    "(A \\sim B)").

Jika ternyata kedua kategori ini **sama**, maka akan terlihat bahwa
mayoritas kata-kata yang digunakan berkumpul di membentuk garis lurus.

> Masih bingung? Ini saya berikan contohnya ya.

Saya mulai dengan menghitung frekuensi dari kata-kata yang muncul pada
kategori `leadership`, lalu saya buat *wordcloud* sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/HBR/artikel-HBR_files/figure-gfm/unnamed-chunk-2-1.png" width="672" style="display: block; margin: auto;" />

Berikutnya adalah frekuensi dari kata-kata yang muncul pada kategori
`technology` :

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/HBR/artikel-HBR_files/figure-gfm/unnamed-chunk-3-1.png" width="672" style="display: block; margin: auto;" />

Jika saya gabung kedua *wordclouds* tersebut, maka hasilnya seperti ini:

<table>

<caption>

Contoh: 10 Kata-Kata yang Beririsan dari 2 Kategori

</caption>

<thead>

<tr>

<th style="text-align:left;">

Words

</th>

<th style="text-align:right;">

% Leadership

</th>

<th style="text-align:right;">

% Technology

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

employee

</td>

<td style="text-align:right;">

3.85

</td>

<td style="text-align:right;">

1.21

</td>

</tr>

<tr>

<td style="text-align:left;">

lead

</td>

<td style="text-align:right;">

2.82

</td>

<td style="text-align:right;">

0.91

</td>

</tr>

<tr>

<td style="text-align:left;">

people

</td>

<td style="text-align:right;">

2.63

</td>

<td style="text-align:right;">

1.93

</td>

</tr>

<tr>

<td style="text-align:left;">

time

</td>

<td style="text-align:right;">

2.37

</td>

<td style="text-align:right;">

1.15

</td>

</tr>

<tr>

<td style="text-align:left;">

manage

</td>

<td style="text-align:right;">

2.31

</td>

<td style="text-align:right;">

1.27

</td>

</tr>

<tr>

<td style="text-align:left;">

company

</td>

<td style="text-align:right;">

2.12

</td>

<td style="text-align:right;">

2.60

</td>

</tr>

<tr>

<td style="text-align:left;">

covid

</td>

<td style="text-align:right;">

2.12

</td>

<td style="text-align:right;">

0.66

</td>

</tr>

<tr>

<td style="text-align:left;">

team

</td>

<td style="text-align:right;">

2.12

</td>

<td style="text-align:right;">

0.66

</td>

</tr>

<tr>

<td style="text-align:left;">

support

</td>

<td style="text-align:right;">

1.86

</td>

<td style="text-align:right;">

0.30

</td>

</tr>

<tr>

<td style="text-align:left;">

pandemic

</td>

<td style="text-align:right;">

1.73

</td>

<td style="text-align:right;">

0.84

</td>

</tr>

<tr>

<td style="text-align:left;">

response

</td>

<td style="text-align:right;">

1.73

</td>

<td style="text-align:right;">

0.18

</td>

</tr>

<tr>

<td style="text-align:left;">

remote

</td>

<td style="text-align:right;">

1.67

</td>

<td style="text-align:right;">

0.42

</td>

</tr>

<tr>

<td style="text-align:left;">

19

</td>

<td style="text-align:right;">

1.54

</td>

<td style="text-align:right;">

0.60

</td>

</tr>

<tr>

<td style="text-align:left;">

meet

</td>

<td style="text-align:right;">

1.48

</td>

<td style="text-align:right;">

0.24

</td>

</tr>

<tr>

<td style="text-align:left;">

heal

</td>

<td style="text-align:right;">

1.41

</td>

<td style="text-align:right;">

0.12

</td>

</tr>

<tr>

<td style="text-align:left;">

organization

</td>

<td style="text-align:right;">

1.41

</td>

<td style="text-align:right;">

0.60

</td>

</tr>

<tr>

<td style="text-align:left;">

value

</td>

<td style="text-align:right;">

1.41

</td>

<td style="text-align:right;">

0.18

</td>

</tr>

<tr>

<td style="text-align:left;">

feel

</td>

<td style="text-align:right;">

1.35

</td>

<td style="text-align:right;">

0.06

</td>

</tr>

<tr>

<td style="text-align:left;">

office

</td>

<td style="text-align:right;">

1.35

</td>

<td style="text-align:right;">

0.12

</td>

</tr>

<tr>

<td style="text-align:left;">

busy

</td>

<td style="text-align:right;">

1.28

</td>

<td style="text-align:right;">

1.69

</td>

</tr>

</tbody>

</table>

Dari tabel di atas saya buat *plot* sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/HBR/artikel-HBR_files/figure-gfm/unnamed-chunk-5-1.png" width="768" style="display: block; margin: auto;" />

Dari *scatterplot* di atas, kita bisa menghitung korelasi antara `2`
kategori tersebut:

    ## 
    ##  Pearson's product-moment correlation
    ## 
    ## data:  data$leader and data$tech
    ## t = 9.5837, df = 662, p-value < 2.2e-16
    ## alternative hypothesis: true correlation is not equal to 0
    ## 95 percent confidence interval:
    ##  0.2804146 0.4141413
    ## sample estimates:
    ##       cor 
    ## 0.3490537

Ternyata didapatkan korelasinya signifikan (tidak bisa diabaikan)
walaupun nilainya relatif lemah ![(r
= 0.349)](https://latex.codecogs.com/png.latex?%28r%20%3D%200.349%29
"(r = 0.349)"). Artinya kecenderungan kata yang sama dipakai di kedua
kategori artikel relatif kecil.

> Kedua artikel ini menggunakan kata-kata yang berbeda. Akibatnya topik
> bahasan juga benar-benar berbeda.

-----

## *Log Odds Ratio*

[*Log Odds
Ratio*](https://en.wikipedia.org/wiki/Odds_ratio#:~:text=The%20logarithm%20of%20the%20odds,%2F27%20maps%20to%20%E2%88%923.296.)
adalah kelanjutan dari *crosswords analysis*. Frekuensi kata dari `2`
kelompok akan dihitung nilai `logratio`-nya dengan rumus:

  
![logratio =
ln(\\frac{freq\_{kel1}}{freq\_{kel2}})](https://latex.codecogs.com/png.latex?logratio%20%3D%20ln%28%5Cfrac%7Bfreq_%7Bkel1%7D%7D%7Bfreq_%7Bkel2%7D%7D%29
"logratio = ln(\\frac{freq_{kel1}}{freq_{kel2}})")  

Angka tersebut akan menunjukkan kata mana yang *less or most likely come
from each group*. Berikut adalah bentuk *plot* yang dijadikan standar
perhitungan pada *log odds ratio*:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/HBR/odds%20ratio.png" width="75%" />

Dari *plot* di atas terlihat bahwa jika ada kata yang memiliki nilai
![logratio=0](https://latex.codecogs.com/png.latex?logratio%3D0
"logratio=0") artinya kata tersebut dipakai oleh kedua kategori artikel
dengan frekuensi yang sama. Selain itu, maka kata-kata lebih sering
dipakai di salah satu kategori artikel saja.

Berikut adalah bentuk finalnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/HBR/artikel-HBR_files/figure-gfm/unnamed-chunk-8-1.png" width="672" style="display: block; margin: auto;" />

Sekarang kelihatan *deh* kata-kata mana saja yang sering keluar di
`leadership` dan `technology`.

## Ada yang bisa disimpulkan dari analisa ini?
