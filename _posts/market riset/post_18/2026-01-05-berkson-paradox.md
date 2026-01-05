---
date: 2026-01-05T10:49:00-04:00
title: "Mengenal Berkson’s Paradox: Mengapa Restoran Mahal Seringkali Rasanya Biasa Saja?"
categories:
  - Blog
tags:
  - Market Riset
  - Kuliner
  - Paradox
  - Bias
  - Selective Bias
---

Beberapa minggu belakangan ini, algoritma Instagram memberikan saya
banyak sekali rekomendasi kuliner di Kota Bekasi yang ternyata lokasinya
tidak jauh dari rumah. Setelah saya coba lihat, ternyata lokasi kuliner
tersebut berbentuk warung makan biasa atau angkringan yang harganya
lebih murah dan *surprisingly* lebih enak dibandingkan rumah makan atau
restoran yang harganya lebih mahal.

> “Banyak *hidden gem* ternyata di dekat rumah.”

Begitu pikiran saya.

Saya jadi berpikir pernahkah kita merasa seperti ini:

> ***“Kok kalau restoran yang harganya murah, rasanya enak banget
> (hidden gem). Tapi kalau restoran yang mahal dan estetik, rasanya
> seringkali cuma ‘oke aja’ atau malah mengecewakan?”***

Hal ini merupakan salah satu contoh dari **Berkson’s Paradox**. Apa itu
**Berkson’s Paradox**? Apakah berbeda dengan [**Simpson Paradox** yang
pernah saya tulis?](https://ikanx101.com/blog/simpson-paradox/)

------------------------------------------------------------------------

Apakah kita pernah merasa dikhianati oleh harga? Kita pesan makanan di
aplikasi *online* dari restoran yang harganya lumayan mahal dan
tempatnya estetik tapi makanannya *“standar”* alias *“begitu saja”*.
Lalu di lain waktu, kita pesan dari warung pinggiran yang harganya lebih
murah tapi rasanya malah *“juara dunia”*. Akhirnya kita membuat
kesimpulan:

> **Makin mahal harga suatu tempat makan, biasanya yang dijual cuma
> tempat tapi rasanya pasti kalah dengan tempat makan yang lebih
> murah.**

Nah, sebelum kita bikin teori **“Hukum Rasa vs Harga”**, mari kita bedah
pakai statistik. Jangan-jangan, ini adalah fenomena **Berkson’s
Paradox** yang lagi memainkan logika kita.

## Logika Seleksi di Mulut Kita

Kenapa kita merasa ada korelasi negatif antara **Harga** dan **Rasa**?
Karena kita punya filter seleksi saat mau pesan makanan.

Bayangkan ada ribuan restoran di Jakarta. Secara statistik, rasa dan
harga itu harusnya *random* atau malah seharusnya berkorelasi positif
(bahan mahal = rasa lebih enak). Tapi, kita sebagai konsumen hanya akan
memesan makanan yang:

1.  **Harganya Murah** (dengan prinsip: kalau rasa *“biasa saja”* tidak
    jadi masalah karena *“yang penting kenyang”*).
2.  **Rasanya Enak Banget** (dengan prinsip: biarpun mahal, kita rela
    bayar demi *self-reward*).

Akibat *filter* yang secara tak sadar kita perbuat, hasilnya restoran
yang **Harganya Mahal DAN Rasanya Gak Enak** tidak akan pernah kita
pesan. Restoran-restoran seperti ini hilang dari *“radar”* pengamatan
kita.

## Simulasi dengan **R**

Untuk menunjukkan fenomena **Berkson’s Paradox**, saya akan buat
simulasi 1.000 restoran fiktif dengan harga dan rasa yang acak (sesuai
dengan kondisi *real*). Rasa dan harga akan saya buat dalam bentuk
*normalized rating* **-1 sampai 1**.

Berikut adalah *scatterplot* antara rasa dan harga dari semua restoran
yang saya buat:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market%20riset/post_18/post_files/figure-commonmark/unnamed-chunk-3-1.png)

Kita bisa lihat bahwa tak ada hubungan antara rasa dan harga (semua
terjadi secara *random* ~ tidak ada korelasi antara rasa dan harga).
Kemudian, secara normal, kita hanya akan memilih restoran yang
*“murah-murah”* atau yang *“enak-enak* saja. Misalkan saya buat skrip
untuk kita memilih restoran dengan kriteria perpaduan antara *“murah”*
dan *“enak”*.

Berikut adalah plot hasil pemilihannya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market%20riset/post_18/post_files/figure-commonmark/unnamed-chunk-5-1.png)

> Terlihat bahwa dari *selected restaurants* kita dapatkan korelasi
> antara rasa dan harga menjadi **negatif dan kuat**.

Fenomena ini muncul karena secara tak sadar kita memilih restoran yang
memaksimalkan fungsi utilitas yang kita definisikan sendiri. Akibatnya
terjadi korelasi negatif pada *selected data* padahal secara populasi
tak ada korelasi yang terjadi.

## Kesimpulan

*Berkson’s Paradox* ini adalah pengingat bahwa **sampel yang kita ambil
bisa jadi mengandung bias**.

Kita sering menganggap dunia ini tidak adil (restoran yang mahal kok
rasanya biasa saja), padahal itu karena kita secara sadar atau tidak
telah mem-*filter* pilihan kita. Restoran mahal yang *benar-benar enak
banget* itu ada banyak tapi karena ekspektasi kita sudah terlanjur
tinggi di harga mahal, *“rasa enak”* yang standar jadi terlihat
mengecewakan dibanding tempat makan murah yang rasanya *“di atas
ekspektasi”*.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
