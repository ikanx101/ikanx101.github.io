---
title: "Menghitung Curah Hujan (Warna Hijau) dari Laporan Bulanan BMKG"
date: 2025-04-29T20:06:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Curah Hujan
  - Cuaca
  - BMKG
  - Image
  - Image Analysis
---

Data cuaca belakangan ini menjadi hal yang sangat krusial di beberapa
analisa yang saya lakukan sehari-hari. Biasanya, saya [mengumpulkan data
cuaca otomatis dari situs *open
weather*](https://ikanx101.com/blog/cuaca-action/). Data yang saya
dapatkan cukup lengkap **tapi ada satu variabel yang tidak saya
dapatkan, yakni curah hujan**. Satu-satunya data curah hujan di
Indonesia bisa kita dapatkan di situs BMKG.

Untuk mendapatkan data curah hujan secara detail, kita perlu mendaftar
di situs [*data online*
BMKG](https://dataonline.bmkg.go.id/dataonline-home).

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/curah_hijau/data_onlen.png" data-fig-align="center" width="450" />

Kita bisa melakukan *request* untuk mendapatkan data historikal bulanan.

------------------------------------------------------------------------

Suatu ketika, saya harus melakukan analisa perbandingan curah hujan
bulanan pertahun dengan cepat. Pada saat itu, Saya belum terdaftar di
situs *data online* BMKG. Maka saya memerlukan cara lain agar bisa
mendapatkan data curah hujan tersebut.

Salah seorang rekan saya menginformasikan bahwa BMKG memberikan laporan
curah hujan bulanan yang dipublikasikan di situsnya dalam bentuk grafik
berikut ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/curah_hijau/bulanan.png" data-fig-align="center" width="450" />

> *Semakin **hijau** petanya, berarti curah hujannya semakin tinggi*.

Saya hanya ingin melakukan analisa perbandingan apakah curah hujan
bulanan tahun 2023 lebih tinggi dibandingkan 2024. Maka saya bisa
melakukan aproksimasi data curah hujan dengan **seberapa hijau grafik
bulanan tersebut**.

Kemudian saya mengumpulkan semua gambar dari laporan bulanan di
*website* BMKG sejak **Januari 2023 hingga Desember 2024**.

## Cara Mengukur Seberapa Hijau

Setiap gambar digital memiliki setidaknya tiga *layers* yang terdiri
dari *layer **Red***, ***Green***, dan ***Blue***. Ketiga nilai dari
setiap *layer* ini bisa diekstrak dengan teknik tertentu dan disajikan
dalam bentuk matriks. Ukuran dari matriks ini merupakan
![n \times m](https://latex.codecogs.com/svg.latex?n%20%5Ctimes%20m "n \times m")
yang berasal dari dimensi *pixel* gambar tersebut.

Dari data berbentuk matriks tersebut, akan dihitung **tiga *metrics***
pengukuran, yakni:

1.  `average_green_intensity`: merupakan nilai rata-rata dari matriks di
    *layer green*.
2.  `proportion_high_green`: merupakan proporsi berapa banyak *pixel* di
    *layer green* yang memiliki tingkat hijau di atas *threhold* yang
    kita definisikan dibandingkan total *pixel* yang ada di *layer
    green* tersebut.
3.  `average_green_dominance`: merupakan nilai rata-rata dominasi warna
    *green* dibandingkan warna *red* dan *blue*.

## Hasil Pembacaan Warna Hijau

## `average_green_intensity`

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/curah_hijau/post_files/figure-commonmark/unnamed-chunk-2-1.png)

## `proportion_high_green`

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/curah_hijau/post_files/figure-commonmark/unnamed-chunk-3-1.png)

## `average_green_dominance`

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/curah_hijau/post_files/figure-commonmark/unnamed-chunk-4-1.png)

## Analisa Perbandingan 2023 vs 2024

Dari tiga *metrics* yang saya hitung di atas, saya bisa melakukan
*Wilcox Test* untuk membandingkan rata-rata “curah hijau” bulanan pada
2023 dan 2024.

# Kesimpulan

> Dari data berupa gambar, kita bisa mengekstrak beberapa informasi yang
> bisa dijadikan aproksimasi untuk mendekati curah hujan.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
