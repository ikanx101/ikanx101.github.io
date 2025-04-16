---
date: 2025-04-16T09:18:00-04:00
title: "Range Harga Kost di Sekitar Nutrihub Surabaya"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Geocoding
  - Jarak
  - Geomarketing
  - Surabaya
  - OpenStreetMap
---

Beberapa hari yang lalu, saya dihubungi oleh salah seorang rekan kantor
yang bertanggung jawab terkait pekerjaan *general affairs* baik di *head
office* dan *branch office*. Rekan saya tersebut meminta tolong untuk
dicarikan *range* harga sewa kost bulanan di sekitar [Nutrihub
Surabaya](https://linktr.ee/NutrihubSurabaya). Salah satu sumbernya
adalah *website* [Mamikos](https://mamikos.com/).

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post_mamikos/Screenshot%20from%202025-04-16%2008-26-38.png" width="650" />

Oleh karena saya dan rekan saya tersebut tidak tahu nama area yang
dijadikan target, maka saya akan ambil semua *listed* kost yang ada di
*website* Mamikos dan akan saya hitung jaraknya ke Nutrihub Surabaya
[menggunakan OSRM](https://ikanx101.com/blog/osrm-R/).

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post_mamikos/mamikos.png)

Data yang akan saya ambil adalah nama kost, area, dan harga bulanan.

Berikut adalah sampel 10 baris data mentah yang saya dapatkan:

| nama_tempat                     | area      |   harga |
|:--------------------------------|:----------|--------:|
| Kost Kertajaya 6 Tipe B         | Gubeng    | 1900000 |
| Kost Opung Erwin Tipe A Mojo    | Gubeng    | 1526000 |
| Kost Omah Arjuno 1 Tipe Premium | Sawahan   | 1700000 |
| Kost Kertajaya 6 Tipe A         | Gubeng    | 1700000 |
| Kost Laksmi 1 Tipe A            | Gubeng    | 1500000 |
| Kost Only Seven Single          | Sawahan   | 1800000 |
| Kost Kupang Krajan Mira         | Sawahan   |  550000 |
| Kost 118 Tipe A                 | Tegalsari | 2000000 |
| Kost Pajajaran                  | Tegalsari | 2500000 |
| Kost Tp                         | Tegalsari | 1900000 |

Kemudian saya buatkan visualisasi sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post_mamikos/post_files/figure-commonmark/unnamed-chunk-3-1.png)

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post_mamikos/post_files/figure-commonmark/unnamed-chunk-3-2.png)

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post_mamikos/post_files/figure-commonmark/unnamed-chunk-3-3.png)

Semoga hasilnya bisa membantu rekan saya tersebut *ya*.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
