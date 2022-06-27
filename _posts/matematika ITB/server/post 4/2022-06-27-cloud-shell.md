---
date: 2022-06-27T19:37:00-04:00
title: "Unlimited Virtual Machine Menggunakan Google Cloud Shell"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Server
  - Linux
  - Google
  - Virtual Machine
  - Google Cloud
  - Cloud Computing
---


Pada [tulisan tahun lalu](https://ikanx101.com/blog/vm-cloud/), saya
pernah menuliskan bagaimana caranya kita menyewa *Linux virtual machine*
di **Google Cloud**. Masalahnya adalah saat *free credit* yang kita
miliki habis, kita harus membayar biaya sewa tersebut. Sebenarnya biaya
sewa per jam (atau per bulan) relatif sangat murah.

> Tapi apakah ada layanan VM yang lebih “gratis” namun tetap *reliable*?

Pertanyaan itu yang sering muncul di benak saya.

Setelah mencari tahu ke sana sini dan mengoprek beberapa fitur yang ada,
saya menemukan satu cara menggunakan *virtual machine* milik **Google**
secara gratis. Namun tentunya *no free lunch* yah. Karena gratis, maka
*session* yang kita lakukan saat ini akan hilang jika *session*-nya
berakhir. Oleh karena itu, kita bisa akali dengan cara:

1.  Tidak menutup *session* selama mungkin; atau
2.  Menggunakan aplikasi seperti `git` untuk menyimpan pekerjaan di
    setiap waktu.

Selain itu, saya tidak menemukan keberadaan *ip public* sehingga untuk
mengakses *virtual machine* ini, kita akan lakukan via *web browser*
langsung bukan dari *command line* di *local computer*.

Salah satu kelebihan lainnya, kita bisa mengaksesnya menggunakan
aplikasi `cloud console` di *gadget* Android.

Lantas bagaimana cara mengaksesnya? Berikut adalah langkah-langkahnya:

### Langkah I

Buka situs *Google Cloud Console* di [*link*
berikut](https://console.cloud.google.com/).

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/server/post%204/langkah_1.png" width="70%" style="display: block; margin: auto;" />

### Langkah II

Klik tanda *command line* (bertuliskan *activate cloud shell*) di
sebelah kanan atas sehingga tampilannya menjadi:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/server/post%204/langkah_2.png" width="70%" style="display: block; margin: auto;" />

### Langkah III

Nah, *cloud shell* sudah bisa langsung digunakan. Kita bisa langsung
mengetik semua perintah dalam *linux* untuk meng-*install* berbagai
aplikasi yang hendak kita gunakan.

Misalkan, saya hendak meng-*install* `git` dan `R`, maka saya cukup
mengetikkan:

    sudo apt-get update
    sudo apt-get upgrade

Hasil proses *update* dan *upgrade*:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/server/post%204/langkah_3.png" width="70%" style="display: block; margin: auto;" />

Proses instalasi:

    sudo apt-get install git r-base-dev

Berikut adalah hasil instalasi **R**-nya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/server/post%204/langkah_4.png" width="70%" style="display: block; margin: auto;" />

Kita dapatkan versi **R** `4.0.4` dalam *cloud shell* tersebut.

Selanjutnya kita bisa melakukan *clone* ***git repository*** dan
melakukan instalasi *packages* di **R**.

------------------------------------------------------------------------

Semoga bermanfaat *yah*.
