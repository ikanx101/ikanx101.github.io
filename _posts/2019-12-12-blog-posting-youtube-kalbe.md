---
date: 2019-12-12T17:25:00-04:00
title: "Stalking Youtube Channel KalbeFamily"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - Youtube
---

Sudah lihat tulisan saya sebelumnya tentang [data yang diambil dari
Youtube](https://ikanx101.github.io/blog/blog-posting-sunyi/)?

*Nah*, penasaran gak sih dengan data di *Youtube Channel*-nya **Kalbe**?

Tadinya saya mencari *Youtube Channel* dari **Diabetasol**, tapi
ternyata isinya hanya segelintir video saja. Oleh karena itu, saya
mengambil data dari *Youtube Channel*-nya
[KalbeFamily](https://www.youtube.com/user/KalbeFamily).

Yuk kita mulai penelusuran dan investigasi dari *Youtube Channel*-nya
**KalbeFamily**.

# Load the data

Bagi *rekans* yang mau ikutan ngoprek datanya, bisa diambil sendiri di
github saya berikut ini yah. Bentuknya dalam format `.rda`, yakni **R
files** karena berisi lebih dari satu *datasets*.

``` r
load("/cloud/project/Bukan Infografis/KalbeFamily/kalbe all data.rda")
ls()
```

    ## [1] "all_videos"   "channel"      "eps"          "komen"       
    ## [5] "stat_channel"

Ada lima *datasets* pada *file* tersebut, yakni:

1.  `channel`: merupakan **Youtube id** dari channel *KalbeFamily*.
    *Hayo, sekarang saya tanya, gimana caranya saya dapetin Youtube id
    user lain?*
2.  `stat_channel`: berisi informasi dan statistik mengenai channel
    *KalbeFamily*.
3.  `all_videos`: berisi informasi mengenai seluruh video yang ada di
    channel *KalbeFamily*.
4.  `eps`: berisi statistik semua video yang ada di channel
    *KalbeFamily*. Apa saja isinya? Contohnya bisa dilihat di [*posting*
    saya
    terdahulu](\(https://ikanx101.github.io/blog/blog-posting-sunyi/\)).
5.  `komen`: berisi seluruh data komentar *viewers* di masing-masing
    video yang ada di channel *KalbeFamily*.

### Bersambung…

Saya selesaikan after FINDx yah…
