---
date: 2020-11-04T08:00:00-04:00
title: "Tetap Produktif dengan R via Cloud Menggunakan Google Colab"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Google
  - Google Colab
  - Github
  - R Studio
  - Chromium
  - Ubuntu
  - Android
  - R Studio Cloud
---


Kondisi *work from home* yang saat ini sedang saya jalani sejak bulan
`Maret 2020` bukanlah suatu hal yang selalu menyenangkan. Dalam beberapa
kesempatan, *work hours* saya menjadi kacau balau.

Saking kacaunya, saya bisa berkoordinasi (balas-balas *email*) pada dini
hari.

Selain itu, walau cuma di rumah saja, mobilitas saya tergolong tinggi.
Mulai dari *workspace* yang saya set di lantai 2, kamar tidur utama,
ruang tamu, garasi, hingga dapur. *hehe*.

> *Gak* mungkin saya bawa-bawa [laptop
> kantor](https://ikanx101.com/blog/review-ubuntu/) ke mana-mana.

Karena bobotnya yang berat dan ternyata sekarang bermasalah di *hardware
wifi*-nya sehingga koneksi internet membutuhkan *fixed USB tethering*.
Bukan berarti saya tidak puas dengan performa **Ubuntu** *yah*. Justru
sangat puas sekali tapi aspek lainnya membuat mobilitas saya kurang
fleksibel.

Bagaimana dengan laptop mini yang saya *install* [Chromium
OS](https://ikanx101.com/blog/laptop-chromium/)?

Laptop tersebut malah sudah saya jadikan *daily driver* selama `2`
minggu ke belakang. Lumayan *powerful* untuk harga segitu. Ukurannya
yang kecil dan ringan membuat mobilitasnya cukup oke.

**TAPI**

Beberapa hari ini, saya ternyata membutuhkan *gadget* yang lebih
*mobile* lagi tapi harus tetap *reliable*. Pilihan saya kembalikan ke
**Tablet Samsung Galaxy Tab A 10 inch** yang sempat saya bebas tugaskan.

> Sayang nih nganggur. Harus kembali dioptimalkan.

Bermodalkan [**Github**](https://ikanx101.com/blog/github-rstudio/) dan
koneksi internet, sebenarnya saya bisa (dan sudah biasa) menggunakan
[**R Studio Cloud**](https://ikanx101.com/blog/r-cloud/) untuk tetap
bekerja.

Meng-*install* [**R** di
android](https://passingthroughresearcher.wordpress.com/2019/07/30/install-r-3-5-2-di-android/)
sepertinya bukan pilihan bijak bagi saya saat ini mengingat ketiadaan
*memory card*.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google%20colab/Screenshot_20201104-175342_Chrome.jpg)<!-- -->

Jadi dengan menggunakan **R Studio Cloud**, pekerjaan saya sekarang bisa
diakses dimana saja dan kapan saja.

> Semua berjalan mulus sampai saya menyadari satu hal.

## *R Studio Cloud is no longer free\!*

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google%20colab/Screenshot_20201104-175719_Chrome.jpg)<!-- -->

Akun *free* kini hanya dibatasi menjadi `15` *projects* dan `15`
*project hours*.

Jangan pernah berpikir untuk melakukan *cheat* atau *hacks* terkait ini
*yah*. Saya sudah mencoba berbagai cara agar *project hours* bisa turun
tapi tidak berhasil *guys*.

> Berapa sih harga akun berbayarnya?

Ternyata lumayan juga sih kalau merogoh kantong sendiri. Jadi harus ada
cara lain nih yang harus saya gunakan saat *project hours* saya sudah
habis.

> Kalau kalian melihat, baru tanggal `4` November tapi *project hours*
> saya sudah habis sekitar `20%`.

-----

## Solusinya bernama **Google Colab**

*Google Colab* adalah salah satu layanan di *Google* yang memungkinkan
penggunanya untuk membuat *coding* menggunakan **Jupyter Notebook**
dalam bahasa *Python*. Saya sudah pernah mencobanya sejak tahun lalu.
Namun beberapa hari yang lalu saya baru mengetahui bahwa kini *Google*
sudah memberikan dukungan untuk bahasa **R** bisa digunakan di *Google
Colab* dengan tampilan ala **Jupyter Notebook**.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google%20colab/Screenshot_20201104-175901_Chrome.jpg)<!-- -->

Kita bisa menambahkan *libraries* dan meng-*upload* *dataset* kita ke
sana dengan mudah layaknya bekerja di **R** menggunakan *command line
interface*.

Saya kemudian jadi berpikir:

> Jika saya selamat hanya dengan mengandalkan laptop 2 juta bernafaskan
> Chromium OS, barangkali saya bisa selamat juga dengan bermodalkan
> tablet android ini\!

Oh iya, untuk mencobanya silakan menuju [colab.to/r](https://colab.to/r)
