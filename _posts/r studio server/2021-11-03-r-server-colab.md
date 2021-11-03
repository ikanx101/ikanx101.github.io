---
date: 2021-11-03T23:41:00-04:00
title: "Menginstall R Studio Server di Google Colab"
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
  - Ubuntu
  - R Studio Cloud
---

> ***Ya! Anda tidak salah baca!***

Sejak beralih ke [Ubuntu](https://ikanx101.com/blog/review-ubuntu/) saya
terobsesi untuk mencari cara agar saya bisa selalu mengakses **R
Studio** menggunakan *gadget* apapun di manapun. Mulai dari menggunakan
[*Google Colab*](https://ikanx101.com/blog/google-colab/) dan *install*
**R Studio Server** di
[laptop](https://ikanx101.com/blog/rstudio-server/).

Beberapa waktu yang lalu, saya tidak sengaja menemukan satu cara untuk
memenuhi obsesi saya tersebut.

*Google Colab* secara *default* berjalan di bahasa *Python*. Namun, jika
kita menambahkan tanda seru `!` di awal baris *code*, maka *Google
Colab* bertindak layaknya Ubuntu CLI.

Akibatnya apa?

> ***Kita bisa menginstall R Studio Server dalam virtual machine miliki
> Google!***

Caranya cukup mudah:

**STEP 1** *Update* dan *upgrade* sistem Ubuntu.

**STEP 2** Buat *user* baru di Ubuntu beserta *password*.

**STEP 3** *Download* *installer* **R Studio Server** dengan perintah
`wget`.

**STEP 4** *Install* program *ssh forwarding* dan aktifkan.

**STEP 5** Buka situs yang diberikan. Masukkan *user* dan *password*
yang kita buat. Selamat menikmati **R Studio Server**.

Berikut adalah `code`-nya, silakan *copy-paste-run* di *Google Colab*:

    # Add new user called "rstudio" and define password (here "password")
    !sudo useradd -m -s /bin/bash rstudio
    !echo rstudio:password | chpasswd

    # Install R and RStudio Server (Don't forget to update version to latest version)
    !apt-get update
    !apt-get install r-base
    !apt-get install libglpk-dev
    !apt-get install gdebi-core
    !wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1103-amd64.deb
    !gdebi -n rstudio-server-1.4.1103-amd64.deb

    # Install localtunnel
    !npm install -g npm
    !npm install -g localtunnel

    # Run localtunnel to tunnel RStudio app port 8787 to the outside world. 
    # This command runs in the background.
    !lt --port 8787 

Mudah kan?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by cliking the ads.`
