---
date: 2020-1-15T11:05:00-04:00
title: "Mencari Informasi Travel Umrah dan Haji"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Web Scrap
  - Umrah
  - Haji
---

*Bismillah…*

Setelah kasus penipuan ibadah umrah *First Travel* kemarin, saya jadi
lebih berhati-hati dalam mencari dan memilih perusahaan travel umrah.
Jangan sampai niat untuk beribadah disalahgunakan oleh oknum yang hanya
mencari keuntungan duniawi.

> Tapi perlu diingat, jadi atau tidaknya kita berangkat umrah atau haji
> adalah keputusan mutlak dari Allah. Kita hanya berikhtiar dengan
> mencari travel umrah dan menyiapkan dananya tapi yang menjadikan kita
> berangkat atau tidak itu adalah Allah yah.

# Data Travel Umrah

Ternyata, ada *lho* suatu wadah perhimpunan penyelenggara umrah dan haji
khusus yang disingkat menjadi [HIMPUH](https://himpuh.or.id/). Di
situsnya kita bisa mencari dan menemukan informasi perusahaan mana saja
yang menjadi anggota dari HIMPUH.

Saya akan *scrap* data dari situs tersebut.

## Proses *web scraping*

Data akan saya *scrap* dari *page* [daftar
anggota](https://himpuh.or.id/daftar-anggota?page=1). Total ada 13
*pages* dan semuanya akan saya *scrap*. Hasilnya saya bisa diunduh di
[sini](https://github.com/ikanx101/belajaR/blob/master/Bukan%20Infografis/Travel%20Umrah/data%20scrap%20pertama.xlsx?raw=true).

Per 15 Januari 2020 pukul 11 AM, saya dapatkan ada `305` perusahaan
travel umrah anggota HIMPUH.

``` r
str(data)
```

    ## 'data.frame':    305 obs. of  5 variables:
    ##  $ No             : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Nama Perusahaan: chr  "PT. Abdi Ummat Wisata International" "PT. Adzikra" "PT. Aero Globe Indonesia" "PT. Aida Tourindo Wisata" ...
    ##  $ Merek Dagang   : chr  "ATTIN TOUR" "PT. Adzikra" "AEROHAJJ" "AIDA TOURINDO WISATA" ...
    ##  $ Kantor Pusat   : chr  "Jl. Lap. Tembak No. 39, Ciracas, Jakarta Timur, DKI Jakarta, 13720" "Pusat Niaga Duta Mas Fatmawati Blok C 2 No. 11-12, Jl. Fatmawati Raya No. 39, Kebayoran Baru, Jakarta Selatan, "| __truncated__ "Jl. Prajurit Kko Usman & Harun No. 32, Senen, Senen, Jakarta Pusat, DKI Jakarta, 10410" "Jl. Cempaka Putih Tengah No. 33, Cempaka Putih, Jakarta Pusat, DKI Jakarta, 10510" ...
    ##  $ link           : Factor w/ 331 levels "https://himpuh.or.id",..: 27 31 36 15 32 30 20 21 16 19 ...

``` r
head(data,10)
```

    ##    No                     Nama Perusahaan         Merek Dagang
    ## 1   1 PT. Abdi Ummat Wisata International           ATTIN TOUR
    ## 2   2                         PT. Adzikra          PT. Adzikra
    ## 3   3            PT. Aero Globe Indonesia             AEROHAJJ
    ## 4   4            PT. Aida Tourindo Wisata AIDA TOURINDO WISATA
    ## 5   5          PT. Al Ahram Sarana Wisata             AL AHRAM
    ## 6   6                       PT. Al Amanah            Al Amanah
    ## 7   7            PT. Al Amin Ahsan Travel Alisan Tour & Travel
    ## 8   8           PT. Al Amin Mulia Lestari   DAQU TOUR & TRAVEL
    ## 9   9              PT. Al Amsor Mubarokah           AMSOR TOUR
    ## 10 10        PT. Al Fatihah Tour & Travel           AL-FATIHAH
    ##                                                                                                                         Kantor Pusat
    ## 1                                                                 Jl. Lap. Tembak No. 39, Ciracas, Jakarta Timur, DKI Jakarta, 13720
    ## 2  Pusat Niaga Duta Mas Fatmawati Blok C 2 No. 11-12, Jl. Fatmawati Raya No. 39, Kebayoran Baru, Jakarta Selatan, DKI Jakarta, 12150
    ## 3                                             Jl. Prajurit Kko Usman & Harun No. 32, Senen, Senen, Jakarta Pusat, DKI Jakarta, 10410
    ## 4                                                  Jl. Cempaka Putih Tengah No. 33, Cempaka Putih, Jakarta Pusat, DKI Jakarta, 10510
    ## 5                                                              Jl. Tebet Barat Ix No. 11, Tebet, Jakarta Selatan, DKI Jakarta, 12810
    ## 6                                                  Ruko Grand Flower A8 , Jl. Pasar Kembang No.4-6, Sawahan, Surabaya, Jawa Timur, -
    ## 7                         Graha Alisan, Jl. Asem Baris Raya No. 126/3, Kebon Baru, Tebet, Tebet, Jakarta Selatan, DKI Jakarta, 12830
    ## 8                                                                Cbd Ciledug Blok A5 No. 21, Karang Tengah, Tangerang, Banten, 15157
    ## 9                                                  Jl. Duren Tiga Raya No. 101 Kav.a2, Cilandak, Jakarta Selatan, DKI Jakarta, 12760
    ## 10                                                                          Jl. Kalpataru 83 A, Lowokwaru, Malang, Jawa Timur, 65141
    ##                                                                               link
    ## 1  https://himpuh.or.id/daftar-anggota/detail/3/pt-abdi-ummat-wisata-international
    ## 2                          https://himpuh.or.id/daftar-anggota/detail/4/pt-adzikra
    ## 3            https://himpuh.or.id/daftar-anggota/detail/91/pt-aero-globe-indonesia
    ## 4             https://himpuh.or.id/daftar-anggota/detail/1/pt-aida-tourindo-wisata
    ## 5           https://himpuh.or.id/daftar-anggota/detail/5/pt-al-ahram-sarana-wisata
    ## 6                      https://himpuh.or.id/daftar-anggota/detail/355/pt-al-amanah
    ## 7           https://himpuh.or.id/daftar-anggota/detail/195/pt-al-amin-ahsan-travel
    ## 8            https://himpuh.or.id/daftar-anggota/detail/2/pt-al-amin-mulia-lestari
    ## 9             https://himpuh.or.id/daftar-anggota/detail/145/pt-al-amsor-mubarokah
    ## 10        https://himpuh.or.id/daftar-anggota/detail/191/pt-al-fatihah-tour-travel

Agar lebih lengkap lagi, saya juga akan *scrap* informasi yang ada di
detail *link* pada data di atas.

Datanya bisa diambil di
[sini](https://github.com/ikanx101/belajaR/blob/master/Bukan%20Infografis/Travel%20Umrah/final%20data.xlsx?raw=true).

# Selanjutnya apa?

Ada yang mau buat visualisasinya?
