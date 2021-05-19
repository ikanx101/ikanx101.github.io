---
date: 2021-05-19T17:50:00-04:00
title: "TUTORIAL: Instalasi R STUDIO SERVER di Laptop Ubuntu"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Training R
  - Tutorial
  - Linux
  - R IDE
---

> ***Salah satu persepsi yang sangat kuat di kepala saya adalah R STUDIO
> SERVER merupakan software berbayar.***

Setelah saya menuliskan artikel terkait [instalasi RKWARD
pagi ini](https://ikanx101.com/blog/rkward-debian/), salah seorang teman
saya yang merupakan ***useR*** memberikan satu saran:

> *Kenapa gak pakai R STUDIO SERVER aja Kang?*

Setelah berdiskusi panjang, ternyata proses instalasi R STUDIO SERVER
`sangat amat mudah` di Ubuntu.

Lantas apa sih faedahnya menggunakan R STUDIO SERVER?

Jika kita meng-*install* R STUDIO SERVER di salah satu komputer di
jaringan, kita bisa mengakses R Studio menggunakan *gadget* apapun di
jaringan tersebut. Jadi mirip dengan
[RStudio.cloud](https://rstudio.cloud/) tapi *unlimited processing
time*. Sama seperti R Studio Desktop tapi bisa diakses di manapun dengan
*gadget* apapun di jaringan.

Sebagai contoh, tulisan ini ditulis menggunakan R STUDIO SERVER yang
saya buka menggunakan *browser* **Google Chrome** di *Galaxy Tab*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Studio%20Server/server1.jpg" width="60%" style="display: block; margin: auto;" />

Jadi bagaimana caranya?

# Proses Instalasi

Komputer saya menggunakan **OS Ubuntu 20 LTS**. Langkah pertama yang
harus dilakukan adalah meng-*install* **R** terlebih dahulu di komputer.
Caranya sudah pernah saya bahas di
[sini](https://ikanx101.com/blog/review-ubuntu/#instalasi-r-dan-rstudio).

Setelah itu, kita tinggal mengunduh R STUDIO SERVER langsung dari
**terminal** dengan cara:

    wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1106-amd64.deb

Langkah berikutnya adalah meng-*install* dengan memanfaatkan `gdebi`.

Jadi, pastikan terlebih dahulu kita telah meng-*install* `gdebi` dengan
cara:

    sudo apt-get install gdebi-core

Langkah terakhir yang perlu dilakukan adalah meng-*install* R Studio
Server dengan cara:

    sudo gdebi rstudio-server-1.4.1106-amd64.deb

Proses instalasinya sudah selesai.

Sekarang kita tinggal membuka *browser* di *gadget* manapun yang berada
di jaringan yang sama dengan komputer tempat kita meng-*install* R
STUDIO SERVER.

Kita tinggal menuju alamat: `http://IP Address:8787`. Untuk komputer
saya, saya tinggal menuju: `http://192.168.8.113:8787/`.

Halaman depannya berupa *login page*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Studio%20Server/login.jpg" width="60%" style="display: block; margin: auto;" />

Kita perlu memasukkan *login* yang sama dengan *profile* pada *setting
user* di **Ubuntu**.

## Menambah *User*

Jika diperlukan, kita bisa menambahkan *user*. Caranya cukup ketik di
**terminal**:

    sudo adduser nama_user

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
