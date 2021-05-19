---
date: 2021-05-19T09:50:00-04:00
title: "TUTORIAL: Install Linux Debian 10 dan RKWARD di Galaxy Tab"
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

Sekitar dua tahun lalu, di blog saya yang
[lama](https://passingthroughresearcher.wordpress.com/2019/06/12/analytics-on-the-go-cara-install-r-ke-gadget-android/),
saya pernah menjelaskan bagaimana meng-*install* **R** ke dalam Android
dengan memanfaatkan Linux versi *Command Line Interface* (**CLI**).

Di beberapa kesempatan lainnya, saya juga meng-*encourage* penggunaan
[Google Colab](https://ikanx101.com/blog/google-colab/) sebagai salah
satu solusi mengerjakan *data science* menggunakan *cloud computing*.

------------------------------------------------------------------------

Ketika bulan puasa kemarin, praktis saya meninggalkan Galaxy Tab saya
sama sekali sehingga si Tab ini akhirnya dipakai si Sulung. Kemarin,
setelah Tab ini saya akuisisi kembali, saya berpikir:

> ***Kira-kira bisa diapakan lagi ya Tab ini?***

Sampai akhirnya saya memutuskan untuk mencoba meng-*install* **Linux
versi** ***desktop*** (bukan versi **CLI**) lalu mencoba untuk
meng-*install* **R Studio**.

Kenapa **R Studio**?

> Saya penasaran untuk bisa menggunakan **R** **IDE** di *gadget*
> Android.

------------------------------------------------------------------------

## Instalasi Linux

Proses instalasi **Linux Desktop** sebenarnya cukup mudah. *Gadget*
Android tidak perlu di-*root*. Prinsipnya sama dengan [postingan saya
sebelumnya](https://passingthroughresearcher.wordpress.com/2019/06/12/analytics-on-the-go-cara-install-r-ke-gadget-android/).

Kita cukup meng-*install* aplikasi bernama ***UserLand*** dari
***PlayStore***.

<img src="https://passingthroughresearcher.files.wordpress.com/2019/06/screenshot_20190612-092848_google-play-store-e1560313247862.jpg" width="50%" style="display: block; margin: auto;" />

Sebagai informasi, aplikasi ini akan ter-*install* di *memory* internal.
Saya tidak menemukan cara untuk memindahkan instalasi ke *memory*
eksternal. Untuk instalasi **Linux** sampai **R** dan **RKWARD** beserta
`library(tidyverse)`, saya membutuhkan ruang sekitar **3Gb**.

Selain itu, kita perlu meng-*install* aplikasi ***VNC Viewer*** juga.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/special%20RKWARD/vnc viewer.jpg" width="50%" style="display: block; margin: auto;" />

Langkah pertama adalah, kita cukup membuka ***UserLand*** lalu memilih
instalasi **Linux Desktop: Lxde**. Linux ini berbasis **Debian 10**
alias **Debian Buster**.

Kita pilih opsi **VNC** pada saat instalasi tersebut. Silakan mengisi
*username*, *password*, dan *password VNC* sesuai selera kita.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/special%20RKWARD/userland.jpg" width="50%" style="display: block; margin: auto;" />

Proses instalasi akan berlangsung sekitar 5-10 menit tergantung dengan
koneksi internet.

Setelah selesai, kita akan langsung dialihkan ke aplikasi **VNC Viewer**
seperti ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/special%20RKWARD/koneksi1.jpg" width="50%" style="display: block; margin: auto;" />

Kita cukup klik **OK**.

Selanjutnya akan ada *warning* terkait ***unencrypted connection***.
Biarkan saja karena kita sebenarnya sedang mengakses koneksi dari dalam
*gadget* kita (**bukan mengakses cloud**). Kita klik **OK**.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/special%20RKWARD/koneksi2.jpg" width="50%" style="display: block; margin: auto;" />

Selanjutnya kita harus memasukkan *password VNC* yang telah kita
definisikan sebelumnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/special%20RKWARD/password.jpg" width="50%" style="display: block; margin: auto;" />

Jika langkah yang dilakukan benar, maka kita akan masuk ke halaman depan
**Linux Debian** berikut ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/special%20RKWARD/linux1.jpg" width="50%" style="display: block; margin: auto;" />

## Instalasi **R**

Langkah berikutnya adalah melakukan instalasi **R**. Banyak orang
menyangka bahwa **Linux** itu susah untuk dioperasikan. Justru
sebaliknya!

> ***Instalasi program apapun sangat mudah di Linux.***

Lantas bagaimana caranya?

Buka dulu **LXTerminal** sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/special%20RKWARD/terminal.jpg" width="50%" style="display: block; margin: auto;" />

Pada **terminal**, ketikkan perintah ini:

    sudo apt update
    sudo apt upgrade
    sudo install r-base

Silakan ketik **y** untuk mengotorisasi proses *upgrade* dan instalasi.
Silakan tunggu beberapa saat hingga selesai. Setelah itu, silakan ketik
`R` dan *hit* **Enter**.

InsyaAllah hasilnya sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/special%20RKWARD/terminaR.jpg" width="50%" style="display: block; margin: auto;" />

**R** sudah selesai kita *install*.

## **R IDE**

Tidak semua orang terbiasa menggunakan **R** berbasis **CLI**. Oleh
karena itu, ada program **IDE** seperti **R Studio**.

Masalahnya pada saat ini **R Studio** tidak mengakomodir arsitektur
**ARM** (seperti *Raspberry Pi*) dan **ARMH** (seperti Android).

Oleh karena itu, kita membutuhkan alternatif **IDE** lain untuk
menggunakan **R**.

Sebenarnya ada beberapa pilihan di luar sana. Kebetulan saya memilih
aplikasi bernama **RKWARD**.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/special%20RKWARD/rkward.jpg" width="50%" style="display: block; margin: auto;" />

Instalasinya juga sangat mudah. Cukup menuliskan perintah berikut pada
**terminal**:

    sudo apt-get install rkward

------------------------------------------------------------------------

Pengalaman memakai **RKWARD** tidak berbeda dengan menggunakan **R
Studio** dalam hal menuliskan *script*.

------------------------------------------------------------------------

`if you find this article helpful, please support this blog by clicking the ads.`
