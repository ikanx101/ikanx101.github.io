---
date: 2020-7-6T10:08:00-04:00
title: "Berapa Banyak Rapid Tes yang Dibutuhkan?"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
  - Covid 19
  - Corona
  - Pandemi
---

Kayaknya hampir semua orang kaget saat mendengar kabar bahwa [pabrik
Unilever di
Cikarang](https://www.cnnindonesia.com/nasional/20200703141857-20-520535/36-positif-corona-dari-klaster-unilever-bekasi-bupati-gusar)
sudah ada 36 orang karyawan yang terpapar Covid 19. Tentunya ini adalah
pukulan bagi perusahaan tersebut.

Hal serupa juga hantu yang membayangi setiap perusahaan manufaktur. Jika
saja ada satu orang karyawan yang positif, bisa jadi merembet ke
mana-mana.

Beberapa hari yang lalu, HP saya berdering. Teman saya di ujung telepon
bertanya:

> Di pabrik saya ada sekitar 2.000 orang, kira-kira saya butuh ngetes
> berapa banyak orang karyawan agar bisa mendapatkan gambaran kondisi di
> perusahaan saya aman atau tidak?

*Mmh*, mendengar pertanyaan dari teman saya tersebut saya coba berpikir
sejenak. Apa tujuan sebenarnya dari tes ini? Lalu apa yang akan
dilakukan saat mendapati karyawan yang positif Covid 19?

Untuk menghitung berapa banyak sampel, setidaknya ada beberapa cara yang
bisa digunakan. TAPI, izinkan saya membuat analogi berikut ini:

> Misal, di komplek perumahan saya tinggal 200 orang. Saya penasaran,
> apakah ada orang dari suku Betawi yang hidup bersama saya di komplek
> ini.

Setelah dihitung menggunakan *sample size calculator online* seperti
milik [raosoft](http://www.raosoft.com/samplesize.html), saya harus
mewawancarai 132 orang.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Shiny%20Test%20Covid%20Pabrik/gambar%201.png" width="1366" />

Jika menggunakan cara ini, setidaknya kita membutuhkan tiga informasi,
yakni:

1.  N, berapa banyak populasi.
2.  *Margin of error*.
3.  *Confidence level*.

Penjelasan mengenai *margin of error* dan *confidence level* sudah
pernah saya tulis di
[sini](https://passingthroughresearcher.wordpress.com/2019/04/18/research-101-mengenal-margin-of-error-dan-confidence-level/).

## Komplikasi

Nah, misalkan saya hendak bertanya ke 132 orang secara acak. Bisa jadi
saat saya bertanya ke orang pertama saya sudah mendapatkan orang Betawi.
Bisa jadi saya baru mendapatkan orang Betawi pada saat bertanya ke orang
ke-90. Bisa jadi pada saat orang ke-130.

Jadi apakah memungkinkan kita menghitung berapa sampel yang dibutuhkan
plus peluang mendapatkan orang positif dengan efisien?

> Karena sejatinya saya cukup mendapatkan satu orang Betawi saja tanpa
> harus menghitung berapa banyak orang Betawi di komplek saya\!

Nah, di sini saya mencoba menghitungnya dengan menggunakan simulasi
Monte Carlo. Prosesnya cukup simpel, yakni dengan menghitung peluang
dari ribuan kombinasi yang mungkin muncul dari kondisi ini.

Untuk membangun algoritma simulasinya, saya membutuh dua hal:

1.  N populasi,
2.  Dugaan berapa banyak orang Betawi yang ada di komplek saya.

Jadi kalau dikembalikan ke kasus teman saya tadi, seandainya ada 10
orang yang positif, maka dibutuhkan:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Shiny%20Test%20Covid%20Pabrik/gambar%202.png" width="1108" />

Jadi saat saya mewawancarai 106 orang secara acak, saya berpeluang besar
sudah mendapatkan setidaknya satu orang betawi.

Bahkan saat saya mewawancarai 50 orang saja, saya mendapatkan peluang 60% - 75% saya sudah mendapatkan orang betawi.

-----

Simulasinya saya taruh di [shinyapps
Covid 19](https://ikanx.shinyapps.io/covid_19/) saya ya. *Feel free to
use it*.
