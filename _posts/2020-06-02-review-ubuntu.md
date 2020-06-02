---
date: 2020-06-02T11:20:00-04:00
title: "NO FREE LUNCH Theorem for Machine Learning"
categories:
  - Blog
tags:
  - LINUX
  - Ubuntu
  - R
  - RStudio
---

Review: UBUNTU 20.04 LTS after 2 weeks as daily driver
================

<img src="https://computerscience.id/wp-content/uploads/2015/08/ubuntu-logo.png" width="50%" />

Pada masa WFH ini, saya sangat bergantung pada kekuatan dan kehandalan
laptop yang diberikan oleh kantor saya. Sebenarnya laptop tersebut
sangat mumpuni. Bisa dibilang bukan laptop murah lah dari segi
*hardware*. *Software* pun dibekali dengan **Windows Genuine** dan
**Microsoft 365 Licensed**. Namun beberapa bulan ini performanya jadi
merosot dan sangat lambat.

Praktis sejak pertengahan Maret, saya sudah tidak bisa lagi membuka
*files* **Microsoft Excel**. Padahal *file* format `.xlsx` menjadi
santapan utama dalam pekerjaan sehari-hari.

Awalnya saya berusaha berdamai dengan cara membuka dan *view*
menggunakan **RStudio**. Untuk beberapa kasus, saya harus membuka dan
melakukan operasi di dalam *file* tersebut. Maka dari itu, saya gunakan
**Google Sheet** (setelah saya *upload* terlebih dahulu ke **Google
Drive**)

Lambat laun, saya menjadi jengah dan tidak efisien dalam bekerja. Saya
coba hubungi tim *helpdesk* dari IT kantor untuk melakukan *remote
checking and repairing*.

Setelah dicek dan dibenarkan, didapati bahwa **Google Chrome** saya
*crash* karena proses *upgrade* yang tidak selesai. Setelah itu,
performa laptop saya sudah mulai membaik tapi belum cukup untuk bisa
dipakai lancar dalam bekerja. Apalagi didapati *system file* **Microsoft
Excel** saya ternyata *corrupt*.

Karena tidak mungkin bagi saya untuk ke kantor, maka saya harus mencari
solusi lain (mungkin sementara, mungkin seterusnya) agar laptop saya
bisa kembali difungsikan secara maksimal.

Sebenarnya di rumah ada laptop milik nyonya, tapi jika digunakan untuk
bekerja rasanya masih agak lama.

Lalu saya berpikir untuk mengalihkan beberapa *space* kosong yang
tersedia di *drive* laptop untuk di- *install* **OS** lain yang lebih
ringan tapi *powerful enough* untuk saya bekerja. Definisi powerful
adalah setidaknya saya bisa menggunakan **R** dan **RStudio** dalam
**OS** tersebut\! Wajib\!

Setelah riset ke sana dan ke sini, akhirnya saya memutuskan untuk
mencoba **Linux Ubuntu**.

Sebenarnya ini bukanlah yang pertama saya berkenalan dengan **Linux
OS**. Dulu sewaktu kuliah, saya sudah terbiasa menggunakan **Linux** di
komputer kampus (dulu **ITB** gencar memberikan *training* seputar
**Linux** dan *open source* pada mahasiswa barunya). Selain itu, saya
adalah pengguna **Raspberry Pi 3B+** yang menggunakan **Raspbian OS**
berbasis **Linux Debian Buster**.

> Berbeda dengan Raspberry yang memiliki insfrastruktur ARMHF, laptop
> saya ini jika dibekali Ubuntu pasti bisa diinstall R versi terbaru dan
> RStudio versi terbaru. Pikir saya.

# Proses Instalasi

Proses instalasi Ubuntu sebenarnya sangat mudah. Pertama-tama, kita bisa
*download image* Ubuntu terbaru di
[situsnya](https://ubuntu.com/download/desktop). Saya menggunakan versi
Ubuntu terbaru, yakni 20.04 LTS (*long time support*).

Dibutuhkan satu *usb drive* berkapasitas minimal 8Gb untuk dijadikan
semacam **installation and recovery USB**. Caranya bisa lihat di panduan
pada situs tersebut yah. Sangat mudah kok.

Proses download dan pembuatan recovery USB memakan waktu 30 menit
(tergantung koneksi juga *sih*).

Setelah itu, saya *reboot* laptop menggunakan USB tadi.

Saya telah mengalokasikan 55Gb *space* kosong di laptop saya.
Rencananya, akan saya bagi menjadi tiga bagian, yakni:

1.  5Gb untuk *swap memory*; Sebenarnya saya sudah memiliki RAM 8Gb
    dalam laptop saya, tapi saya tetap menambahkan *swap memory* sebagai
    *contingency plan* jika suatu saat saya mengoprek data dalam jumlah
    sangat amat besar.
2.  20Gb untuk `\home` sebagai *working directory* saya kelak.
3.  30Gb untuk *root directory*.

Proses instalasi Ubuntu relatif mudah dan cepat yah. Tidak sampai 30
menit, proses instalasinya sudah selesai.

# Instalasi Pernak - Pernik

*Nah*, sekarang agar Ubuntu bisa dijadikan *daily driver* saya yang
mumpuni, maka saya harus meng-*install* beberapa aplikasi pendukung
pekerjaan saya.

## Instalasi `Git`

Hal pertama yang saya lakukan adalah meng-*install* `Git` agar saya bisa
dengan mudah meng-*update* *repository* **github** saya dengan mudah.

Cara instalasi dan *setting* awalnya juga mudah dan cepat, yakni:

``` r
# sudo apt update
# sudo apt install git

# git config --global user.name "isi user name"
# git config --global user.email "isi email"
```

## Instalasi `Ubuntu Cleaner`

Ternyata Linux itu selalu menyimpan *files cache*, *logs*, *old files*,
dan *journals* dalam *root directory*. Oleh karena itu, ukuran *root
directory* pada awalnya saya buat lebih besar.

Untuk membersihkannya, saya akan gunakan aplikasi bernama `Ubuntu
Cleaner`.

``` r
# sudo add-apt-repository ppa:gerardpuig/ppa
# sudo apt update
# sudo apt install ubuntu-cleaner
```

Selain itu, saya juga bisa *bebersih* dengan menggunakan perintah
berikut ini:

``` r
# sudo apt-get autoremove
# sudo apt-get clean
# sudo apt-get autoclean
# sudo apt-get autoremove --purge

# journalctl --disk-usage
# sudo journalctl --rotate --vacuum-size=1M
```

## Instalasi `Chromium` *Web Browser*

Ubuntu secara default memiliki *browser Firefox* dan *Mail Client
Thunderbird*. Berhubung saya tidak membutuhkannya, maka saya *uninstall*
terlebih dahulu:

``` r
# sudo apt-get autoremove --purge firefox
# sudo apt-get autoremove --purge thunderbird
```

Sekarang saya akan meng-*install* **Chromium** sebagai *web browser*
saya. Kenapa tidak menggunakan **Chrome** saja? **Chromium** menurut
saya lebih ringan dengan fitur yang sama dengan **Chrome** (berdasarkan
pengalam menggunakan Raspbian OS).

``` r
# sudo apt-get install chromium-browser
```

## Instalasi `Openshot Editor`

Aplikasi ini biasa saya gunakan untuk mengedit video. Versi Linuxnya
sangat amat ringan. Entah kenapa berbeda jauh performanya dengan versi
di Windows yang selama ini saya gunakan.

``` r
# sudo add-apt-repository ppa:openshot.developers/ppa
# sudo apt-get update
# sudo apt-get install openshot-qt
```

## Instalasi `OBS Studio`

Aplikasi ini berguna banget jika ingin membuat video *screen capture*
atau membuat *live broadcast*. Pokoknya ini berguna banget lah.

``` r
# sudo apt install ffmpeg
# sudo add-apt-repository ppa:obsproject/obs-studio
# sudo apt update
# sudo apt install obs-studio
```

## Instalasi `Rambox`

`Rambox` adalah salah satu aplikasi komunikasi yang brilian menurut
saya. Dibangun secara *web-based*, kita bisa memasukkan hampir semua
layanan konektivitas kita seperti *Whatsapp* (*business* atau personal),
*Telegram*, *Microsoft Teams*, *Outlook 365*, *Facebook Messenger*,
*Instagram Direct*, *Google Hangout*, dll.

Ada dua aplikasi, `Rambox` biasa dan `Rambox Pro`. Saya sudah mencoba
keduanya, perbedaan antara yang **Pro** dan tidak hanya di tampilan
**GUI** dan banyaknya layanan yang ada.

## Instalasi `R` dan `RStudio`

Ini adalah menu utama dari Ubuntu saya. **R** dan **RStudio** yang akan
di-*install* haruslah versi yang terbaru dan stabil.

Pertama-tama, kita *install* terlebih dahulu `R 4.0` dari *cran
repository*.

``` r
# sudo apt install gnupg
# sudo apt install ca-certificates
# sudo apt install nano
# sudo apt install gdebi-core

# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

# sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

# sudo apt update
# sudo apt upgrade

# sudo apt install r-base
```

Maka dalam waktu sekejap, `R 4.0` tersedia di Ubuntu saya.

Untuk meng-*install* **RStudio**, kita langsung *download* saja
*installer*-nya di situsnya. Kita bisa *download* versi untuk
[Ubuntu 18](https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.3.959-amd64.deb)
*yah*.

Instalasinya menggunakan `gdebi` yang telah kita *install* tadi dengan
cara masuk ke dalam folder `Downloads` dan mengeksekusinya.

``` r
# cd Downloads
# sudo gdebi <nama file .deb>
```

Tahap akhir, karena saya biasa menggunakan `library(rvest)`, maka saya
perlu meng-*install* *dependencies* berikut ini:

``` r
# sudo apt install libcurl4-openssl-dev
# sudo apt install libssl-dev
# sudo apt install libxml2-dev
```

# Review Setelah 2 Minggu Pemakaian

## PLUS

1.  Proses *booting* sangat cepat. Dari mulai menyalakan komputer sampai
    masuk ke RStudio saja kurang dari 30 detik.
2.  Efisien dalam produktivitas. **RStudio** bekerja dengan baik dan
    cepat. Aplikasi seperti **Rambox** sangat berguna sekali.
3.  *Swap memory* hampir tidak pernah terpakai walau sudah digeber
    maksimal. Konsumsi RAM tertinggi hanya mencapai tak lebih dari 80%
    dari total RAM saja.

## MINUS

Ternyata Linux diam-diam masih menyimpan *cache*, *journals*, dan *log
files*. Oleh karena itu secara berkala saya harus membersihkan *drive*.

# Kesimpulan

Ternyata sangat amat berguna bagi saya sebagai seorang *market
researcher* dan *computational scientist* untuk menggunakan UBUNTU.
