---
title: "Membuat Blog dengan R Studio dan Github Pages"
date: 2022-08-10T07:34:00-04:00
categories:
  - Blog
tags:
  - Blog
  - Github
  - Github Pages
  - Google
  - Google Adsense
  - Google Analytics
---

Bulan Agustus ini menandai 3 tahun saya menggunakan alamat
`ikanx101.com` sebagai alamat *web* blog saya.

Dulu saya menggunakan *platform* **Wordpress** sebagai tempat saya
menulis [*blog* yang lama](passingthroughresearcher.wordpress.com).
Menulis *blog* pada saat itu cukup rumit karena saya harus meng-*export*
beberapa visualisasi data menjadi format `.png` atau `.jpg` lalu
meng-*upload*-nya ke *Wordpress*. Selain itu cara saya membagi skrip
juga kurang memuaskan.

Setelah saya mengetahui bahwa *Github* memiliki satu fitur bernama
*Github Pages* yang memungkinkan setiap *user* membuat *webpage* sendiri
secara gratis, saya akhirnya mencoba untuk memakainya.

Ternyata ada banyak keunggulan (dan tentunya kelemahan) dari *Github
Pages* ini. Salah satunya adalah saya harus belajar tentang *Github
Markdown* dan bagaimana proses *backbone* dalam hosting dan mengubah
*markdown* menjadi *website*.

## Pelajaran Pertama: *Github Pages*

Untuk membuat *Github Pages* sangatlah mudah. Kita cukup membuat akun
*Github* lalu membuat *repository* bernama `username.github.io`. Pada
*repository* tersebut, kita cukup membuat `index.html` layaknya kita
memiliki *server* `Apache` sendiri.

*Nah*, saya tidak memulainya dari *blank* sama sekali. Saya cukup
mencari berbagai *Github Repositories* lain yang memiliki *template*
*blog* terbaik. Biasanya basisnya adalah `Jekyll`. Kita tinggal
meng-*clone* *repository* tersebut dan mengubahnya sesuai dengan
keinginan kita saja.

## Pelajaran Kedua: *Github Markdown*

Salah satu *repository* yang saya pilih sebagai *template blog* saya
mengharuskan penulisan dilakukan dalam format *Github Markdown*.

Untuk itu, saya menulis *blog* menggunakan **R Studio**, yakni dengan
memanfaatkan *R Markdown* yang kemudian di-*render* menjadi *Github
Markdown*.

Tulis, lalu *knit* (alias *render*), *commit*, dan *push* maka tulisan
saya sudah *live*. Sesimpel itu.

## Pelajaran Ketiga: Menggunakan Alamat *Custom Domain*

Secara *default*, alamat *Github Pages* kita adalah
`username.github.io`. Namun kita bisa mengubahnya dengan cara membeli
alamat / domain. Saya sendiri membelinya dengan cukup murah dari salah
satu *provider* lokal. Hanya sekitar Rp150 ribu per tahun.

Setelah itu, saya cukup mem-*forward* alamat *default* *Github Pages*
saya ke alamat domain yang telah saya beli tersebut.

Untuk melakukan ini tidak rumit. Cukup *copy paste* beberapa baris kode
dari *provider* ke *Github* saja. Namun pastikan terlebih dahulu bahwa
*provider* yang kita tuju *support* untuk *forwarding github pages*.

## Pelajaran Keempat: *Google Analytics*

Salah satu kelebihan yang saya tidak temukan di *Wordpress* adalah
integrasi *Github Pages* ke dalam *Google Analytics*.

*Template* `Jekyll` yang saya pilih *support* *Google Analytics*. Saya
cukup meng-*copy-paste* ID *Google Analytics* ke dalam *repository*
saja.

## Pelajaran Kelima: *Google Adsense*

Dalam 2-3 bulan pertama saya menggunakan *Github Pages*, ternyata jumlah
*viewers*-nya sudah cukup lumayan. Iseng saya coba daftarkan *blog* saya
ini ke *Google Adsense*. Alhamdulillah, dalam hitungan jam permohonan
*blog* saya diterima.

Untuk memasukkan kode *Adsense* ke dalam *Github Pages* juga tidak
rumit. Kita perlu menambahkan beberapa skrip ke dalam *repository* kita
tersebut.

------------------------------------------------------------------------

Catatan: Tulisan ini dibuat menggunakan R Studio Server yang saya
*install* di [*Google Cloud Virtual
Machine*](https://ikanx101.com/blog/google-rstudio/).
