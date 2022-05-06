---
title: "Konsep Automatic Replenishment pada Gudang Distributor"
date: 2022-05-06T13:14:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Optimisasi
  - Replenishment
---

Tujuan mulia setiap perusahaan adalah mendapatkan *profit*. Untuk
melakukannya, mereka harus menyelesaikan dua masalah utama, yakni:

1.  *Cost efficiency*,
2.  *Increase sales*.

Salah satu bentuk *cost efficiency* yang bisa dilakukan oleh perusahaan
manufaktur adalah dengan menelaah lebih kembali semua proses dalam
*supply chain management* (*SCM*). Secara simpel, SCM bisa saya
gambarkan dalam skema berikut ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/replenish/nomnoml.png" width="60%" />

Pada proses distribusi, proses *replenishment* gudang distributor
menjadi hal yang sangat krusial. Kenapa?

-   Jika terjadi *overstock*, tentu hal ini akan merugikan baik
    distributor dan produsen. Apalagi jika produk tersebut tidak
    termasuk produk yang cepat terjual. Istilah lapangan untuk hal ini
    adalah *duit nganggur*.
-   Jika terjadi *understock*, tentunya distributor dan produsen akan
    mengalami *loss sales*. Di saat *sales* bisa terjadi, justru produk
    langka.

Oleh karena itu, biasanya ada tim khusus yang bertugas untuk menghitung
kapan dan berapa gudang distributor harus diisi kembali. Untuk beberapa
perusahaan, tim khusus tersebut sudah diganti dengan **AI** (baca:
algoritma prediksi dan optimisasi).

> ***Lantas bagaimana algoritma tersebut bekerja?***

Secara sederhana, kita bisa membagi keadaan gudang menjadi tiga
*states*, yakni:

1.  *Input*, yakni berapa produk yang harus kita *feed* ke dalam gudang.
    Dalam hal *feeding* ini, kita perlu memperhitungkan *time delivery*
    produk dari pabrik hingga sampai ke distributor. Ini adalah tujuan
    dari algoritma *replenishment*.
2.  *Current*, yakni stok *existing* gudang dan maks kapasitas yang bisa
    ditampung oleh gudang.
3.  *Output*, yakni tarikan produk keluar akibat *demand* atau *sales*.

Keadaan akan semakin rumit saat produk yang terlibat memiliki banyak
varian dengan *demand* yang berbeda-beda.

Dalam kasus ini, misalkan saya hanya memiliki data historikal stok
harian produk-produk di distributor tertentu. Data tersebut sudah lebih
dari cukup untuk membuat algoritma *automatic replenishment*. Kok bisa?

## Tahap I

Dari data historikal stok harian setiap produk, kita bisa membuat model
*time series* yang bertujuan untuk melakukan *forecast* produk keluar
distributor (terjadi *sales*) dalam waktu 1 - 2 minggu ke depan (rentang
waktu ini tergantung pada waktu pengiriman produk dari pabrik ke
distributor).

Model *time series* ini akan dijadikan acuan angka *demand* harian yang
nilainya akan selalu berubah dan *updated* setiap harinya.

## Tahap II

Dari hasil *forecast* sebelumnya, kita akan membuat algoritma optimisasi
dengan parameter-parameter berupa:

1.  Waktu pengiriman produk.
2.  Biaya pengiriman produk.
3.  Kapasitas mobil pengiriman.
4.  Maks kapasitas gudang.
5.  *Inventory* produk *existing* di gudang.
6.  *Forecast* per produk.
7.  Minimal *inventory* per produk harian.

lalu *constraints*-nya:

1.  Pengiriman tidak boleh melebihi kapasitas mobil dan kapasitas gudang
    (setelah ditambah *inventory* *existing* di gudang).
2.  *Inventory* per produk harian harus selalu terpenuhi.

lalu tujuannya adalah:

> ***Meminimalkan biaya pengiriman***.
