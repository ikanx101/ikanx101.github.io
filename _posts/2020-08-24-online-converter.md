---
date: 2020-08-24T09:10:00-04:00
title: "Robotic Process Automation: Online Converter using R"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web App
  - ShinyApps
  - Algoritma
---

Dalam beberapa minggu ini saya sedang banyak *data science projects*
terkait *data converter*. Jadi ceritanya hampir di semua divisi di
kantor itu memiliki lebih dari satu aplikasi mandiri yang digunakan.
Beberapa aplikasi tersebut sebenarnya saling berhubungan tapi sayangnya
mereka tidak bisa saling berkomunikasi secara langsung.

Sebagai ilustrasi, hal yang sering saya temui adalah:

> Data yang dihasilkan oleh aplikasi pertama perlu diubah dulu
> strukturnya dan ditambahkan beberapa variabel yang diperlukan sebelum
> di-*feed* ke aplikasi kedua.

Awalnya proses manual ini dilakukan oleh beberapa orang admin dan
berjalan lancar. Namun akibat pandemi ini, pekerjaan-pekerjaan ini harus
bisa diambil alih oleh algoritma dengan alasan: kecepatan dan ketepatan
kerja.

Seperti hal yang biasa saya katakan:

> Algoritma (baca: *artificial intelligence*) sangat *powerful* jika
> digunakan untuk *replacing well defined jobs*.

Oleh karena itu saya dan beberapa divisi yang ada di kantor
berkolaborasi membuat algoritma *converter* tersebut.

Tentunya saya tidak bisa membocorkan secara utuh apa yang saya kerjakan,
tapi saya akan berikan gambaran yang semoga saja mudah dimengerti.

-----

Di suatu divisi, ada dua aplikasi utama yang digunakan. Aplikasi pertama
menghasilkan data berupa `planned data` hasil *input* dari divisi lain.
Data tersebut kemudian harus dibersihkan dulu dan diolah sesuai dengan
kebutuhan sebelum di-*feed* ke aplikasi kedua.

Proses pengolahan data tersebut saya bisa kategorikan ke dalam kelas
**menantang**. *Hahaha*

> *Gak sulit sebenarnya*, tapi ribet dan banyak sekali *rules* yang
> harus dibuat.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2020-08-24-online-converter_files/figure-gfm/unnamed-chunk-1-1.png" width="672" />

Setelah selesai, algoritma yang telah jadi tersebut diuji coba untuk
berbagai macam tipe-tipe kasus yang biasanya terjadi dari data tarikan
aplikasi pertama. Setelah *smooth* tanpa cela, saya akan melihat
bagaimana penggunaannya nanti di divisi tersebut.

Jika user dirasa bisa melakukan *running* algoritma secara mandiri, saya
hanya akan memberikan skrip algoritma **R** beserta **FAQ** dan **SOP**
cara melakukan *run* algoritmanya.

Namun ada kondisi di mana user tersebar di berbagai belahan Indonesia
dan tidak seragam pengetahuannya terhadap **R**. Oleh karena itu saya
memerlukan suatu sistem yang sifatnya mudah bagi siapapun untuk bisa
menjalankan algoritma saya tersebut.

Salah satu solusi yang saya berikan adalah dengan membuat *web app*
menggunakan *ShinyApps* di **R Studio** lalu membuatnya *available* di
*cloud*. Jadi sistem kerjanya menjadi simpel:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2020-08-24-online-converter_files/figure-gfm/unnamed-chunk-2-1.png" width="672" />

Lalu jika muncul pertanyaan:

  - Apakah data yang dikirim ke *web app* tersebut aman?
      - Saya membuat algoritmanya berupa *reactive object*, artinya data
        yang dikirim ke *web app* tersebut tidak disimpan permanen di
        cloud manapun. Jadi aman *yah*.
  - Bagaimana jika *link* dari *web app* tersebut tersebar ke pihak atau
    perusahaan lain?
      - Algoritma yang digunakan dalam *web app* tersebut bekerja
        seperti halnya virus. Maksudnya bagaimana? Spike protein dari
        virus hanya akan bisa menempel di sel reseptor tertentu saja.
        Jadi algoritma baru akan bekerja jika dimasukkan (di-*upload*)
        file yang sesuai dengan format yang sudah disepakati. Kalau
        dimasukkan file dengan format lain, tidak akan keluar hasilnya.
  - Bagaimana jika ada perubahan atau penambahan variabel di data
    aplikasi pertama?
      - Algoritma tersebut hanya menargetkan beberapa variabel spesifik
        dari data pertama. Selainnya jika nanti ada penambahan maka
        algoritma tetap bisa berjalan.
