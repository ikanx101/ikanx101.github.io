---
title: "Kenapa Kita Tidak Bisa Mengandalkan dengan Price Elasticity Semata?"
date: 2021-01-12T08:16:30-04:00
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Price Elasticity
  - Regresi Linear
  - Optimization
  - Korelasi
  - Correlation
---

Tahun lalu, saya sempat menjelaskan mengenai [*price
elasticity*](https://ikanx101.com/blog/blog-posting-regresi/). Suatu
analisa regresi linear sederhana yang memodelkan kausalitas (sebab
akibat) antara harga dengan *sales quantity* suatu produk.

Saya sendiri sering menggunakan analisa ini untuk pekerjaan market riset
di kantor.

Salah satu asumsi yang mendasari analisa ini adalah:

> Jika harga semakin mahal, maka secara logika *sales qty* akan menurun.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/price%20elasticity/post%201/post_files/figure-gfm/unnamed-chunk-1-1.png" width="672" style="display: block; margin: auto;" />

Atau dengan kalimat matematisnya: **ada korelasi kuat negatif antara**
`harga` **dengan** `sales qty`.

Oleh karena itu, salah satu langkah terpenting adalah memastikan `harga`
dan `sales qty` memiliki data yang cukup untuk bisa dihitung korelasinya
(*pearson correlation*).

-----

Kenapa saya justru korelasi padahal yang mau dilakukan adalah regresi
(kausalitas)?

Jawabannya sederhana:

> Nilai korelasi yang kuat antara `harga` dan `sales qty` (misal saya
> notasikan sebagai ![R](https://latex.codecogs.com/png.latex?R "R"))
> akan menghasilkan model [regresi
> linear](https://ikanx101.com/blog/belajar-regresi/) yang kuat juga.
> Hal ini tergambar dari nilai *R-square*
> (![R^2](https://latex.codecogs.com/png.latex?R%5E2 "R^2")) yang baik.

Nilai korelasi Pearson jika dikuadratkan akan sama dengan nilai
*R-squared*.

Jadi ini adalah *screening* awal saya dalam membuat model antara `harga`
dan `sales qty`.

Saya pernah menuliskan materi terkait korelasi [di
sini](https://ikanx101.com/blog/materi-korelasi/).

-----

### Lantas bagaimana jika korelasi yang didapatkan bernilai positif?

Saat saya menemukan ada produk dengan nilai korelasi positif (dan juga
kuat), ada dua hal yang terlintas di pikiran saya, yakni:

  - Apakah semakin mahal produknya, `sales qty` malah semakin tinggi?
    Kalau begitu kita buat mahal saja produknya agar makin mendapatkan
    profit.
  - Pasti ada yang salah dengan datanya. Kalau begini, produk tersebut
    tidak bisa dan tidak perlu dianalisa lebih lanjut.

-----

### Data seperti itu jangan buru-buru ditinggalkan\!

Ternyata saat kita menemukan data yang memiliki korelasi kuat positif
seperti ini, kita jangan buru-buru untuk tidak menganalisanya.
Setidaknya kita bisa melihat historikal datanya terlebih dahulu dan
melakukan investigasi atas data tersebut.

Bingung?

Oke saya jelaskan dengan kasus *real* berikut *yah*\!

-----

## Kompetisi *Optimization* Tahap II

Setelah selesai kompetisi [tahap
pertama](https://ikanx101.com/blog/binary-marketplace/) kemarin, kami
melanjutkan mengadakan kompetisi tahap II. Berbekal data *real* dari
salah satu *market place* rekan-rekan mahasiswa disuruh menghitung
*price* paling optimal yang bisa ditawarkan ke konsumen.

Cara menghitung *price* optimal didasarkan pada model regresi *price
elasticity*. Semua berjalan dengan baik hingga ada satu merek minyak
goreng `XYZ` memiliki korelasi positif sebesar 0.25.

Jika saya buat model regresinya, berikut adalah hasilnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/price%20elasticity/post%201/post_files/figure-gfm/unnamed-chunk-3-1.png" width="672" style="display: block; margin: auto;" />

Dengan hasil tersebut wajar jika kita mengatakan ada yang aneh dengan
data tersebut. Tapi jika data tersebut kita *plot* terpisah menjadi dua:

1.  `sales qty` per waktu.
2.  `harga` per waktu.

Kita akan dapatkan hasil sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/price%20elasticity/post%201/post_files/figure-gfm/unnamed-chunk-4-1.png" width="672" style="display: block; margin: auto;" />

Terlihat ada strategi *pricing* yang dilakukan oleh merek minyak goreng
`XYZ` ini.

#### Q1 - Q3

Di awal tahun (Q1), mereka sempat menaikkan harganya sehingga
mengakibatkan `sales qty`-nya menurun. Tapi saat mereka menurunkan
harganya perlahan (namun tetap di atas harga di awal tahun) di Q2 dan
Q3, `sales qty` mereka juga perlahan naik. Jadi ada kesan kepada
konsumen seolah-olah harga turun.

#### Q4

Lalu pada Q4 ada anomali saat harganya naik tapi *sales qty* juga
meningkat. Kenapa hal ini terjadi?

> Melihat *single* data seperti ini mungkin akan membuat kita bingung
> kenapa hal ini terjadi.

Tapi setelah saya melihat data harga yang ada di market minyak goreng
kemasan sejenis. Ternyata harga yang ditawarkan oleh kompetitor minyak
goreng `XYZ` juga memiliki tren yang mirip (kompetitor juga menaikkan
harganya pada Q4).

Tampaknya tidak ada pilihan lain bagi konsumen untuk menerima harga baru
tersebut.

-----

# Kesimpulan

Kita tidak bisa mengandalkan hanya satu analisa *price elasticity*. Ada
bainya kita juga melihat *historical price* yang terjadi. Selain itu ada
baiknya jika kita memasangkan data produk tertentu dengan data lain
seperti data kompetitor agar mendapatkan analisa yang lebih konklusif
dan holistik.

-----

`if you find this article helpful, please support this blog by clicking
the ads.`
