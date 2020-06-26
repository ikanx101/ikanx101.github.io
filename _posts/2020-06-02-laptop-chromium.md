---
date: 2020-06-02T15:20:00-04:00
title: "Beli Laptop Murah Untuk Data Science"
categories:
  - Blog
tags:
  - LINUX
  - Chromium OS
  - R
  - RStudio
---

Selama beberapa tahun ini saya menggunakan Galaxy Tab A berukuran 10
inch sebagai second *daily driver* saya. Alasannya simpel: layar besar
dan bisa digunakan untuk melakukan *analytics on the go* (menggunakan
[*cloud*](https://ikanx101.github.io/blog/r-cloud/) atau [*hard
install*](https://passingthroughresearcher.wordpress.com/2019/06/12/analytics-on-the-go-cara-install-r-ke-gadget-android/)).

Jadi saya bukan gaya-gayaan pake tablet segede talenan yah. Tapi memang
ada alasan kuat dibalik itu.

Sepanjang perjalanannya, ternyata saya butuh sesuatu yang lebih powerful
tapi tidak juga menepikan unsur mobilitas. Saya diberikan laptop kantor
yang sangat powerful tapi bobotnya lumayan berat.

> Harus ada laptop lain berukuran kecil yang bisa digunakan untuk
> pekerjaan saya sehari-hari menggunakan **R**.

Setelah cek sana-sini, pilihan jatuh pada laptop *Axioo Mybook 11 lite*.
Kebetulan juga, sedang ada [*flash sale* di
**jd.id**](https://www.jd.id/product/axioo-mybook-11-lite-4gb-online-deal-silver_603033132/603034079.html).
Tanpa pikir panjang, maka saya beli saja langsung laptop tersebut.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chromium%20OS/axioo.png" width="1192" />

-----

## Kenapa sih pilihnya Axioo?

Saya dan istri punya sejarah panjang dengan merek ini.

Dulu waktu kuliah, saya menggunakan laptop Axioo sejak semester III
sampai kerja. Alhamdulillah Allah mengizinkan saya lulus kuliah
menggunakan laptop tersebut.

Pun demikian dengan istri saya saat kuliah dulu. Saya berhasil
meracuninya agar membeli laptop merek sama. Laptop tersebut menemani dia
dan adiknya saat kuliah dulu. Bahkan laptop tersebut masih hidup sampai
sekarang dan masih digunakan oleh mertua saya.

Kembali ke topik, jika dilihat dari speknya yang pas-pasan, maka dari
awal memang saya akan memasang **OS** non *Windows* ke dalam laptop
tersebut.

> Pasang Ubuntu juga nih. Biar greget\!

Seketika saya unboxing laptop tersebut, saya langsung *install*
[**Ubuntu**](https://ikanx101.github.io/blog/review-ubuntu/) dengan
protokol yang sama dengan yang saya lakukan sebelumnya ke laptop kantor.

Ternyata tidak secepat laptop kantor yah. Butuh waktu beberapa jam
hingga semua *tools* yang saya butuhkan terinstall di sana.

Setelah dipakai 2 minggu, saya belum puas maksimal dengan kinerjanya.
Jika diberikan skor, keandalannya dan kecepatan (reaktif) saya berikan
skor 75 (dibandingkan laptop kantor yang 100).

Tapi kalau dinilai wajar sih, saya memang menggunakan beberapa
*libraries* dan *functions* yang memakan kinerja laptop. Oh iya, si
[**Shinyapps Covid**](https://ikanx101.github.io/blog/covid-bersinar/)
itu saya finalisasi dan maintain dengan si Axioo ini lho.

> Harus ada cara lain agar laptop ini berfungsi seutuhnya.

Maka saya beralih ke Chromium OS dari
[CloudReady](https://www.neverware.com/). Ini juga bukan yang pertama
saya menggunakan Chromium OS yah. Saya pernah meng- *install*-nya ke
Raspberry Pi saya dan mencobanya dengan *live usb* ke laptop kantor.

> Sangat ringan.

Begitu impresinya.

Maka saya coba *install* Chromium OS ke sana. Caranya gimana? Bisa liat
langsung [tutorial di situs
resminya](https://www.neverware.com/freedownload#home-edition-install)
yah.

Sekarang saya akan berikan *step by step* untuk bisa meng- *install* R
versi terbaru (R 4.0.2) dan RStudio terbaru.

-----

# Install R

## Install Linux dulu

Pertama-tama *install* dulu Linux ke Chromium OS dengan cara *enable* di
*setting menu*.

## Cek versi Linux

``` r
# cat /etc/os-release
```

## Install Git

Ini salah satu yang penting, *install* dulu Git biar bisa *sync* ke
github.

``` r
# sudo apt install git
# git config --global user.name "isi user name"
# git config --global user.email "isi email"
```

## Persiapan install R versi terbaru

``` r
# sudo apt install gnupg
# sudo apt install ca-certificates
# sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
```

Sekarang kita akan tambahkan *source* CRAN ke dalam file `source.list`.

Caranya:

1.  Press ‘shift+g’ to go to the last line of the file
2.  Press ‘o’ to add a new line underneath and to switch to insert mode
3.  Paste the repo config line with ‘ctrl+shift+v’
4.  Press ‘Esc’ to exit insert mode
5.  Type ‘:wq’ and press ‘Return’, to write the file and exit vi

<!-- end list -->

``` r
# sudo vi /etc/apt/sources.list
# deb http://cloud.r-project.org/bin/linux/debian buster-cran40/
```

## *Update* dan *Upgrade* Linux

``` r
# sudo apt update
# sudo apt upgrade
```

## Install R versi terbaru

``` r
# sudo apt install r-base
```

## Install RStudio

``` r
# sudo apt install -y libgstreamer1.0 libgstreamer-plugins-base1.0 libxslt-dev
# curl -o rstudio.deb https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.3.959-amd64.deb
# sudo apt --fix-broken install
# sudo apt install libnss3
# sudo apt-get install libxslt1-dev
# sudo apt install gdebi-core
# sudo gdebi rstudio.deb
```

## Persiapan `rvest`

``` r
# sudo apt install libcurl4-openssl-dev
# sudo apt install libssl-dev
# sudo apt install libxml2-dev
```

-----

# Kesimpulan

Setelah diganti ke Chromium OS ternyata performa laptop ini meningkat. Jadi, walaupun murah tapi laptop ini gak murahan sih. 

> Wise man said: it is not about the gun, but the man behind the gun...
