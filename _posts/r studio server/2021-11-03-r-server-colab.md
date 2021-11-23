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

    # saya berikan penjelasan setiap baris codesnya ya
    # dua baris ini adalah untuk membuat user di Linux
    # secara default saya buat sebagai berikut:
      # user : rstudio
      # pass : password
    # feel free untuk mengganti ATAU menambahkan multi user
    # ingatlah bahwa compute engine ini milik Google
    # jadi siapa tahu bisa dirun paralel untuk multi user
    !sudo useradd -m -s /bin/bash rstudio
    !echo rstudio:password | chpasswd

    # melakukan update Linux
    !apt-get update

    # install R base (cli version)
    !apt-get install r-base

    # install beberapa library Linux
    !apt-get install libglpk-dev # ini khusus untuk optimisasi
    !apt-get install gdebi-core

    # download installer R studio server dari situs resmi
    !wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1103-amd64.deb

    # proses instalasi R studio server
    !gdebi -n rstudio-server-1.4.1103-amd64.deb

    # Install localtunnel
    !npm install -g npm
    !npm install -g localtunnel

    # forward port 8787 ke public
    !lt --port 8787 

Proses ini berkisar antara 2-3 menit saja.

Setelah prosesnya selesai, silakan buka alamat situs yang tertera. Klik
`continue` dan masukkan *username* dan *password* yang telah kita
tentukan.

## Persiapan **R Studio Server**

**R Studio Server** sudah bisa digunakan. Beberapa *libraries* standar
seperti `dplyr` dan `ggplot2` sudah *pre-installed* di dalam sistem.

Jika kita ingin meng-*install* *libraries* lain, kita perlu melakukan
konfigurasi *time zone* dengan perintah sederhana sebagai berikut:

### *Set Time Zone*

*Copy-paste-run codes below:*

    Sys.setenv(TZ = "GMT")

Pada *tab* `Console`.

Lantas bagaimana jika kita hendak bekerja dengan *file* yang sudah kita
miliki sebelumnya atau dengan *file* berukuran besar?

Kita bisa menggunakan *Github Repository* untuk di-*clone* ke dalam
*environment* **R** kita.

## *Config Git Global Setting*

Untuk menghubungkan **R Studio Server** dengan Github *repository*, kita
perlu melakukan konfigurasi sebagai berikut:

*Copy-paste-run codes below:*

    system('git config --global user.name "yourname"')
    system('git config --global user.email "youremail@email.com"')

Pada *tab* `Console`.

### *Clone Github Repository*

Sekarang kita akan *clone github repository* ke dalam **R Studio**
*Environment*.

Semua persiapan yang kita lakukan sudah selesai. Seharusnya hanya
berjalan 5-10 menit saja. Selama *session* **Google Colab** tidak
terputus, *R Studio Server* bisa diandalkan.

Pengalaman saya *run* semalaman saat tidak ada eksekusi sama sekali,
*session*-nya tidak terputus.

------------------------------------------------------------------------

## *Updates!*

Bagaimana mengakali agar *Google Colab Session* tidak mudah berakhir?

> Kita bisa tambahkan *function* berikut ini di bagian `console` Google
> Chrome:

    function ClickConnect(){
        console.log("Working")
        document.querySelector("colab-connect-button").click()
    }
    setInterval(ClickConnect,60000)

------------------------------------------------------------------------

> Mudah kan?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by cliking the ads.`
