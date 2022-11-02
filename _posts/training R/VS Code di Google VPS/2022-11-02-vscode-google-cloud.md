---
date: 2022-11-02T12:33:00-04:00
title: "TUTORIAL: Install VS Code Server di Google Cloud Virtual Machine"
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
  - R GUI
  - Visual Studio Code
---

Pada tulisan [sebelumnya](https://ikanx101.com/blog/vs-code/), saya
telah menjelaskan bagaimana meng-*install* *Visual Studio Code* ke dalam
laptop atau PC berbasis Linux (baik Debian atau Ubuntu sama saja
prosesnya).

Sekarang saya mau *share* salah satu keisengan saya lagi, yakni
meng-*install* ***Visual Studio Code Server*** ke dalam *virtual private
server* (VPS) di *Google Cloud*. Namun, sebelum saya memulai, saya akan
menjelaskan terlebih dahulu apa itu ***Visual Studio Code Server***.

------------------------------------------------------------------------

***VS Code Server*** adalah bentuk *server* dari aplikasi *VS Code* yang
bisa digunakan untuk *ngoding* berbagai macam bahasa pemrograman (salah
satunya **R**). Penggunaannya sama halnya dengan ***R Studio Server***,
yakni memungkinkan *user* mengaksesnya via *gadget* apapun tanpa harus
meng-*install*-nya (hanya bermodalkan *web browser* saja).

Saya sudah beberapa kali menulis tentang *R Studio Server*, seperti:

1.  Cara *install* di [laptop
    Ubuntu](https://ikanx101.com/blog/rstudio-server/),
2.  Cara *install* di [Google
    Colab](https://ikanx101.com/blog/r-server-colab/),
3.  Cara *install* di [Google
    VPS](https://ikanx101.com/blog/google-rstudio/),

Namun, salah satu kelemahan bagi *R Studio Server* adalah kita harus
memiliki *IP public* agar *R Studio Server* bisa diakses dari *gadget*
apapun dengan jaringan manapun. Jika tidak punya *IP public*, kita bisa
mengakalinya dengan menggunakan bantuan
[*pagekite*](https://ikanx101.com/blog/page-kite/) atau
[*ngrok*](https://ikanx101.com/blog/ngrok-io/).

Di sinilah letak keunggulan ***VS Code Server***. Secara otomatis, ***VS
Code Server*** akan melakukan *ssh tunneling* sehingga walaupun tanpa
*IP public* ***VS Code Server*** tetap bisa diakses oleh *gadget*
manapun dengan jaringan apapun. Asal laptop atau VPS tempat kita
meng-*install* terkoneksi internet. Selain itu kita tidak perlu
diribetkan oleh *setting firewall* di *Google Cloud* yang rumit.

Prasyarat mutlak yang wajib dipenuhi adalah keberadaan akun Github.

------------------------------------------------------------------------

Sekarang saya akan menunjukkan cara meng-*install* ***VS Code Server***
ke *Google VPS*. Kira-kira langkahnya adalah sebagai berikut:

1.  *Create an instance* (membuat VPS baru di layanan *Google Cloud
    Console*).
2.  *Install* **R** dan berbagai *libraries*-nya dengan bantuan *command
    line*.
3.  *Install* ***VS Code Server*** dan lakukan otentifikasi Akun Github.

### Langkah I

Saya akan membuat VPS baru di *Google Cloud* sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/VS%20Code%20di%20Google%20VPS/Screenshot 2022-11-01 14.33.04.png" width="60%" />

Untuk OS nya, saya akan menggunakan Debian 11 `Bullseye`.

### Langkah II

Berikutnya, saya akan gunakan koneksi `ssh` untuk meng-*install* **R**
dan berbagai macam kebutuhan lainnya.

Saya menggunakan perintah sebagai berikut:

    apt install pandoc gnupg ca-certificates nano gdebi-core build-essential libgdal-dev python3-pip libcurl4-openssl-dev libssl-dev libxml2-dev cmake libglpk-dev libcairo2-dev libfontconfig1-dev 

    pip3 install -U radian

    apt-get update
    apt-get upgrade
    apt-get install r-base r-base-dev

Pastikan kita sudah menjadi `superuser` saat menjalankan perintah
tersebut.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/VS%20Code%20di%20Google%20VPS/Screenshot 2022-11-01 14.38.26.png" width="60%" /><img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/VS%20Code%20di%20Google%20VPS/Screenshot 2022-11-01 15.00.14.png" width="60%" />

Setelah **R** ter-*install*, buka **R** dan *install* beberapa
*libraries* berikut:

    rm(list=ls())
    pakets = installed.packages()
    pakets_needed = c("dplyr","tidyr","readxl","janitor",
                      "knitr","expss","openxlsx","stringr",
                      "rvest","ggplot2","txtplot","tidytext","reshape2",
                      "rmarkdown","Ryacas","languageserver","httpgd")
    necessary = setdiff(pakets_needed,pakets)
    if(length(necessary) > 0){
      for(i in 1:length(necessary)) install.packages(necessary[i])
    } else print("+++ semua libraries sudah ready +++")

    rm(list=ls())

Proses ini mungkin akan memakan waktu yang relatif cukup lama (maksimum
30 - 45 menit). Oleh karena itu, kita bisa tinggal tidur saja. Tapi
*setting* ini cukup dilakukan sekali saja.

### Langkah III

Kita akan *install* ***VS Code Server*** dengan mengeksekusi perintah
berikut ini:

    wget -O- https://aka.ms/install-vscode-server/setup.sh | sh

*Nah*, prosesnya sudah hampir selesai. Untuk menyalakan *server*, kita
eksekusi perintah ini:

    code-server

------------------------------------------------------------------------

Jika berhasil, kita akan disuruh menjawab beberapa baris pertanyaan dan
melakukan otentifikasi ke akun Github seperti ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/VS%20Code%20di%20Google%20VPS/Screenshot 2022-11-01 20.24.36.png" width="60%" />

Setelah itu kita akan diberikan alamat `url` *unique* tempat kita akan
mengakses ***VS Code Server***.

------------------------------------------------------------------------

Setelah kita buka `url` pada *web browser*, akan terlihat tampilan
sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/VS%20Code%20di%20Google%20VPS/Screenshot 2022-11-01 20.26.54.png" width="60%" />

Kita tunggu saja proses instalasinya hingga selesai. Maksimum memakan
waktu sekitar 15-30 menit.

Oh iya, langkah terakhir adalah dengan meng-*install* ekstensi **R**
pada *VS Code Server* berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/VS%20Code%20di%20Google%20VPS/Screenshot 2022-11-01 20.34.44.png" width="60%" />

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads`
