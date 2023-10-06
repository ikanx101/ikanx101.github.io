---
date: 2023-10-06T16:18:00-04:00
title: "Analisa Geomarketing: Antara Warteg, Restoran Padang, dan Bakso-Mie Ayam di Kota Bekasi"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Raster
  - Geocoding
  - Google
  - Geomarketing
  - Bekasi
  - Kuliner
---


Melanjutkan *posting* saya sebelumnya terkait [pre-analisa dalam
*geomarketing*](https://ikanx101.com/blog/geo-marketing/), kali ini saya
akan melanjutkan ke bagian **analisa apa yang bisa kita lakukan pada**
***geomarketing***. Tulisan ini juga melanjutkan *posting* saya
sebelumnya terkait [*merchant Grab* pada Ramadhan tahun
lalu](https://ikanx101.com/blog/grab-buburit/).

------------------------------------------------------------------------

## Warteg, Restoran Padang, dan Bakso - Mie Ayam

Sejak kecil, saya sudah berdomisili di Kota Bekasi. Sudah banyak
perkembangan yang saya rasakan di kota ini. Salah satu hal yang menarik
bagi saya adalah keberadaan tempat-tempat makan kekinian di Bekasi yang
semakin menjamur. Namun, apapun tempat makannya, menurut saya hanya ada
tiga kategori tempat makan yang **paling juara** di antara yang lain.
Yakni:

- Warung Tegal,
- Restoran Padang,
- Bakso - Mie Ayam.

Sepenglihatan saya di Kota Bekasi, ketiga kategori ini tetap bertahan di
tengah gempuran tempat makan kekinian bahkan seperti tersebar di
mana-mana. Pada awal 2023, saya mengambil semua data tempat makan di
Kota Bekasi.

Ada satu pertanyaan yang muncul di benak saya:

> *Di antara ketiga kategori tersebut, siapa yang lebih unggul?*

- Jika kita menjawab berdasarkan **rasa**, tentunya akan menimbulkan
  perdebatan karena bergantung dengan preferensi pribadi.
- Jika kita menjawab berdasarkan **harga**, ini juga akan menimbulkan
  perdebatan yang tak kunjung selesai. *hehe*.

Maka dari itu, saya akan menjawabnya menggunakan prinsip bernama
**aksesbilitas**.

------------------------------------------------------------------------

## Apa itu Aksesbilitas?

**Aksesbilitas** saya definisikan sebagai:

> *Seberapa terjangkau suatu lokasi dari penggunanya.*

Mari kita lihat data sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%20II/post_files/figure-gfm/unnamed-chunk-2-1.png" width="672" style="display: block; margin: auto;" />

Dari banyaknya kategori tempat makan, kita bisa lihat bahwa bakso / mie
ayam memiliki persentase terbanyak. Namun apakah bakso / mie ayam
memiliki aksesbilitias yang terbaik?

Jawabannya: **belum tentu**. Kenapa? Bisa jadi bakso / mie ayam banyak
tapi tidak tersebar secara merata. Perhatikan peta sebaran sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%20II/Rplot.png" width="700" style="display: block; margin: auto;" />

Jika kita lihat sekilas, titik merah (bakso / mie ayam) sepertinya
tersebar merata namun di beberapa area terlihat kosong. Analisa visual
seperti ini tentunya menimbulkan misinterpretasi, oleh karena itu
bagaimana caranya agar kita bisa menghitung **aksesbilitas** dengan
lebih saintifik?

Untuk menghitung **aksesbilitas**, saya menggunakan perhitungan jarak
*Euclidean*. Rekan-rekan bisa membacanya di tulisan saya [berikut
ini](https://ikanx101.com/blog/jarak-simmilarity/).

Saya mengusulkan ide perhitungan sebagai berikut:

------------------------------------------------------------------------

## Ide Perhitungan Aksesbilitas

Perhatikan ilustrasi sebagai berikut:

> Ada dua orang konsumen yang hendak membeli makan dari tiga restoran.
> Posisi semua konsumen dan restoran bisa digambarkan dalam gambar di
> bawah. Jika diasumsikan ketiga restoran ini memiliki makanan yang
> sama, dan memiliki rasa serta harga yang sama, maka konsumen **akan
> memilih restoran yang terdekat**.

**Aksesbilitas** bisa dihitung dari jarak terpendek seorang konsumen
untuk mencapai restoran.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%20II/post_files/figure-gfm/unnamed-chunk-4-1.png" width="672" style="display: block; margin: auto;" />

Pada kasus ini:

- Aksesbilitas `Konsumen 1` adalah jarak antara `Konsumen 1` dan
  `Resto B`.
- Aksesbilitas `Konsumen 2` adalah jarak antara `Konsumen 2` dan
  `Resto C`.

------------------------------------------------------------------------

## Menghitung Aksesbilitas Warteg, Restoran Padang, dan Bakso - Mie Ayam

Untuk menjawab pertanyaan utama:

> *Di antara ketiga kategori tersebut, siapa yang lebih unggul?*

Saya akan menghitung nilai **aksesbilitas** ***overall*** untuk ketiga
kategori tempat makan tersebut. Secara simpel bisa saya bahasakan:

> Di antara warteg, restoran Padang, dan Bakso - Mie Ayam: mana yang
> lebih mudah dijangkau oleh konsumen?

Algoritma perhitungan **aksesbilitas**-nya sebagai berikut:

    STEP I
      generate n random longlat konsumen di kota bekasi
    STEP II
      hitung jarak masing-masing konsumen ke masing-masing tempat makan
    STEP III
      untuk setiap konsumen:
        pilih salah satu tempat makan terdekat per masing-masing kategori tempat makan
        simpan jarak tempat makan terdekat per kategori
    STEP IV
      hitung rata-rata jarak per kategori tempat makan
    STEP V
      ulangi STEP I hingga STEP IV dengan prinsip montecarlo

Sebagai ilustrasi, perhatikan peta berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%20II/post_files/figure-gfm/unnamed-chunk-5-1.png" width="672" style="display: block; margin: auto;" />

Maka untuk setiap konsumen akan saya hitung jarak terdekat masing-masing
ke `bakso`, `padang`, dan `warteg`.

Contohnya ini adalah matriks jarak antara konsumen dengan masing-masing
kategori tempat makan:

| konsumen   | Warteg-1 | Warteg-2 | Warteg-3 | Warteg-4 | Warteg-5 | Warteg-6 | Warteg-7 | Warteg-8 |
|:-----------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
| Konsumen-1 | x        | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-2 | x        | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-3 | x        | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-4 | x        | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-5 | x        | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-6 | x        | x        | x        | x        | x        | x        | x        | x        |

| konsumen   | Padang-1 | Padang-2 | Padang-3 | Padang-4 | Padang-5 | Padang-6 | Padang-7 |
|:-----------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
| Konsumen-1 | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-2 | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-3 | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-4 | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-5 | x        | x        | x        | x        | x        | x        | x        |
| Konsumen-6 | x        | x        | x        | x        | x        | x        | x        |

| konsumen   | Bakso-1 | Bakso-2 | Bakso-3 | Bakso-4 | Bakso-5 | Bakso-6 | Bakso-7 | Bakso-8 | Bakso-9 |
|:-----------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|
| Konsumen-1 | x       | x       | x       | x       | x       | x       | x       | x       | x       |
| Konsumen-2 | x       | x       | x       | x       | x       | x       | x       | x       | x       |
| Konsumen-3 | x       | x       | x       | x       | x       | x       | x       | x       | x       |
| Konsumen-4 | x       | x       | x       | x       | x       | x       | x       | x       | x       |
| Konsumen-5 | x       | x       | x       | x       | x       | x       | x       | x       | x       |
| Konsumen-6 | x       | x       | x       | x       | x       | x       | x       | x       | x       |

Kemudian akan saya pilih tempat makan dengan jarak terpendek pada
masing-masing konsumen, lalu saya hitung rata-rata untuk setiap
kategori.

Bagaimana hasilnya?

------------------------------------------------------------------------

## Nilai Aksesbilitas Warteg, Restoran Padang, dan Bakso - Mie Ayam

Saya gambarkan terlebih dahulu sebaran konsumen yang telah saya
*generate*:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%20II/konsumen.png" width="658" height="40%" />

Kelak, menggunakan prinsip Montecarlo saya akan mengulangi proses
*generating* konsumen berulang kali.

Singkat cerita, saya telah menghitung nilai **aksesbilitas**
masing-masing kategori tempat makan. Berikut adalah statistik
deskriptifnya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%20II/post_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

Saya hitung *mean differences*-nya untuk pasangan-pasangan data sebagai
berikut:

``` r
# bakso vs padang
t.test(df_akses$akses_bakso,df_akses$akses_padang)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  df_akses$akses_bakso and df_akses$akses_padang
    ## t = -16.805, df = 1602.4, p-value < 2.2e-16
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.004280391 -0.003385623
    ## sample estimates:
    ##   mean of x   mean of y 
    ## 0.005905042 0.009738049

Kesimpulan I: Mean aksesbilitas `Bakso / Mie Ayam` **lebih rendah
signifikan** dibandingkan `Padang`.

``` r
# bakso vs warteg
t.test(df_akses$akses_bakso,df_akses$akses_warteg)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  df_akses$akses_bakso and df_akses$akses_warteg
    ## t = -21.942, df = 1383.4, p-value < 2.2e-16
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.00687826 -0.00574932
    ## sample estimates:
    ##   mean of x   mean of y 
    ## 0.005905042 0.012218832

Kesimpulan II: Mean aksesbilitas `Bakso / Mie Ayam` **lebih rendah
signifikan** dibandingkan `Warteg`.

``` r
# padang vs warteg
t.test(df_akses$akses_padang,df_akses$akses_warteg)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  df_akses$akses_padang and df_akses$akses_warteg
    ## t = -7.4064, df = 1966.1, p-value = 1.916e-13
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.003137683 -0.001823883
    ## sample estimates:
    ##   mean of x   mean of y 
    ## 0.009738049 0.012218832

Kesimpulan III: Mean aksesbilitas `Padang` **lebih rendah signifikan**
dibandingkan `Warteg`.

Bisa saya tuliskan **aksesbilitas**: `Bakso / Mie Ayam` \< `Padang` \<
`Warteg`.

------------------------------------------------------------------------

## Kesimpulan

Terlihat dengan jelas bahwa secara sebaran data, tempat makan kategori
`Bakso / Mie Ayam` memiliki nilai **aksesbilitas** terkecil. Artinya:

> Mie ayam lebih mudah dijangkau oleh konsumen di Kota Bekasi
> dibandingkan dengan kategori tempat makan lainnya (Padang dan Warteg).

Terjawab sudah pertanyaan saya sebelumnya.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
