---
date: 2019-12-13T14:25:00-04:00
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

Untuk mengambil data dari Youtube, ada beberapa hal yang saya butuhkan:

1.  **Youtube id** dari channel *KalbeFamily*. *Hayo, sekarang saya
    tanya, gimana caranya saya dapetin Youtube id dari user lain?* **Any
    ideas?**
2.  **R** yang dipersenjatai `tuber` *package*.
3.  **Google API** untuk **Youtube Data**.

Yuk kita mulai penelusuran dan investigasi dari *Youtube Channel*-nya
**KalbeFamily**.

# Load the data

Bagi *rekans* yang mau ikutan ngoprek datanya, bisa diambil sendiri di
github saya berikut ini yah. Bentuknya dalam format `.rda`, yakni **R
files** karena berisi lebih dari satu *datasets*. Oh iya, data ini saya
ambil pada `13 Desember 2019 pukul 2pm` yah.

``` r
load("/cloud/project/Bukan Infografis/KalbeFamily/kalbe all data.rda")
ls()
```

    ## [1] "all_videos"   "channel"      "eps"          "komen"       
    ## [5] "stat_channel"

Ada lima *datasets* pada *file* tersebut, yakni:

1.  `channel`: **Youtube id** dari channel *KalbeFamily*.
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

# Let’s the fun parts begins\!

## `stat_channel`

Mari kita lihat bersama, apa saja isi *dataset* `stat_channel`

``` r
stat_channel
```

    ## $kind
    ## [1] "youtube#channel"
    ## 
    ## $etag
    ## [1] "\"p4VTdlkQv3HQeTEaXgvLePAydmU/UgN55JqRLL3hhnc8yVWKF3zVbcw\""
    ## 
    ## $id
    ## [1] "UC5vmedW_cnfGUEopPnmMIsw"
    ## 
    ## $snippet
    ## $snippet$title
    ## [1] "KalbeFamily"
    ## 
    ## $snippet$description
    ## [1] "http://kalbestore.com"
    ## 
    ## $snippet$publishedAt
    ## [1] "2013-02-26T04:02:40.000Z"
    ## 
    ## $snippet$thumbnails
    ## $snippet$thumbnails$default
    ## $snippet$thumbnails$default$url
    ## [1] "https://yt3.ggpht.com/a/AGF-l7_Ksehv07fFYrEfEM1bLvXDmsbXQAoOkxeIhg=s88-c-k-c0xffffffff-no-rj-mo"
    ## 
    ## $snippet$thumbnails$default$width
    ## [1] 88
    ## 
    ## $snippet$thumbnails$default$height
    ## [1] 88
    ## 
    ## 
    ## $snippet$thumbnails$medium
    ## $snippet$thumbnails$medium$url
    ## [1] "https://yt3.ggpht.com/a/AGF-l7_Ksehv07fFYrEfEM1bLvXDmsbXQAoOkxeIhg=s240-c-k-c0xffffffff-no-rj-mo"
    ## 
    ## $snippet$thumbnails$medium$width
    ## [1] 240
    ## 
    ## $snippet$thumbnails$medium$height
    ## [1] 240
    ## 
    ## 
    ## $snippet$thumbnails$high
    ## $snippet$thumbnails$high$url
    ## [1] "https://yt3.ggpht.com/a/AGF-l7_Ksehv07fFYrEfEM1bLvXDmsbXQAoOkxeIhg=s800-c-k-c0xffffffff-no-rj-mo"
    ## 
    ## $snippet$thumbnails$high$width
    ## [1] 800
    ## 
    ## $snippet$thumbnails$high$height
    ## [1] 800
    ## 
    ## 
    ## 
    ## $snippet$localized
    ## $snippet$localized$title
    ## [1] "KalbeFamily"
    ## 
    ## $snippet$localized$description
    ## [1] "http://kalbestore.com"
    ## 
    ## 
    ## 
    ## $statistics
    ## $statistics$viewCount
    ## [1] "1102379"
    ## 
    ## $statistics$commentCount
    ## [1] "0"
    ## 
    ## $statistics$subscriberCount
    ## [1] "1230"
    ## 
    ## $statistics$hiddenSubscriberCount
    ## [1] FALSE
    ## 
    ## $statistics$videoCount
    ## [1] "77"

Kita bisa melihat bahwa *Youtube channel* **KalbeFamily** berdiri sejak
`2013-02-26`. Sampai saat ini, memiliki `77` buah video dan
*channel*-nya sendiri telah dilihat sebanyak `1.102.379` kali (bukan
*view video* yah). *Channel* ini memiliki *subscriber* sebanyak `1.230`
orang.

> **Dengan angka-angka seperti di atas, kira-kira untuk kategori
> *Youtube channel* sebuah perusahaan, sudah termasuk tinggi, menengah,
> atau rendah?**. Silakan komen yah.

## `all_videos`

Ada informasi apa saja di dataset `all_videos`? Yuk kita lihat bersama.

``` r
str(all_videos)
```

    ## 'data.frame':    77 obs. of  7 variables:
    ##  $ .id                            : chr  "items1" "items2" "items3" "items4" ...
    ##  $ kind                           : chr  "youtube#playlistItem" "youtube#playlistItem" "youtube#playlistItem" "youtube#playlistItem" ...
    ##  $ etag                           : chr  "\"p4VTdlkQv3HQeTEaXgvLePAydmU/Nyd3V6dTtq_D3eB9t4rZGmB036I\"" "\"p4VTdlkQv3HQeTEaXgvLePAydmU/C6ek0C99jKxbrkya6ztkbE-jno8\"" "\"p4VTdlkQv3HQeTEaXgvLePAydmU/05BMIpgFwHuskbT7ZsW04hL2DPE\"" "\"p4VTdlkQv3HQeTEaXgvLePAydmU/3S2Ez0hQLa8MrdRzzVXxxRlw3IA\"" ...
    ##  $ id                             : chr  "VVU1dm1lZFdfY25mR1VFb3BQbm1NSXN3LlpMQk1YRkx0blM4" "VVU1dm1lZFdfY25mR1VFb3BQbm1NSXN3LmNyVFRBZWx6dlQ0" "VVU1dm1lZFdfY25mR1VFb3BQbm1NSXN3LlVmazJLbjJ6eS04" "VVU1dm1lZFdfY25mR1VFb3BQbm1NSXN3LmJuSkVrek01ODVz" ...
    ##  $ contentDetails.videoId         : chr  "ZLBMXFLtnS8" "crTTAelzvT4" "Ufk2Kn2zy-8" "bnJEkzM585s" ...
    ##  $ contentDetails.videoPublishedAt: chr  "2019-09-03T07:26:51.000Z" "2019-09-03T07:24:49.000Z" "2019-04-01T01:11:43.000Z" "2018-01-29T03:05:20.000Z" ...
    ##  $ episode                        : chr  "video ke 1" "video ke 2" "video ke 3" "video ke 4" ...

*Mmh*, sepertinya saya hanya bisa menganalisa variabel
`contentDetails.videoPublishedAt`, yakni kapan masing-masing video
tersebut di-
*upload*.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/KalbeFamily/2019-12-12-blog-posting-youtube-kalbe_files/figure-gfm/unnamed-chunk-5-1.png "chart")

Ternyata ada yang menarik nih. Entah kenapa di tahun 2015, tidak ada
video yang diupload di *channel* ini. Setelah **rajin** *upload* di
tahun pertama, di tahun-tahun berikutnya ada penurunan yang lumayan
jauh. Dari sini kita bisa duga bahwa bisa jadi video-video tersebut
tidak diupload setiap bulannya. Mari kita
buktikan:

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/KalbeFamily/2019-12-12-blog-posting-youtube-kalbe_files/figure-gfm/unnamed-chunk-6-1.png "chart")

## `eps`

Ada informasi apa saja di dataset `eps`? Yuk kita lihat bersama.

``` r
str(eps)
```

    ## 'data.frame':    77 obs. of  7 variables:
    ##  $ id           : chr  "ZLBMXFLtnS8" "crTTAelzvT4" "Ufk2Kn2zy-8" "bnJEkzM585s" ...
    ##  $ viewCount    : num  251 140 574 3608 13911 ...
    ##  $ likeCount    : num  0 0 4 19 19 4 8 4 44 29 ...
    ##  $ dislikeCount : num  0 0 0 1 6 0 6 1 20 6 ...
    ##  $ favoriteCount: num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ commentCount : num  0 0 1 0 1 0 0 0 0 0 ...
    ##  $ episode      : chr  "video ke 1" "video ke 2" "video ke 3" "video ke 4" ...

*Nah*, yang ini baru seru kan?

> Atau saya doang yang bilang ini seru… *hehehe*

Mari kita mulai *brute force* analisanya. Terserah saya mau *diapain*
aja yah.

### *viewCount*

Berapa banyak sih yang *ngeliat* video di channel ini?

``` r
sum(eps$viewCount)
```

    ## [1] 1102445

Total ada `1.102.445` *viewers* dari `77` video. Dengan rata-rata
*viewers* per episode sebesar:

``` r
round(mean(eps$viewCount),2)
```

    ## [1] 14317.47

Satu angka yang lumayan menurut saya, `14.317` *viewers* per video. Tapi
dengan karakteristik *channel* yang frekuensi *upload* videonya
jarang-jarang, saya menduga akan ada pencilan atau bentuk *boxplot*-nya
pasti akan condong ke salah satu sisi. Mari kita liat dulu sebaran
datanya.

``` r
boxplot(eps$viewCount)
```

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/KalbeFamily/2019-12-12-blog-posting-youtube-kalbe_files/figure-gfm/unnamed-chunk-11-1.png "chart")

*Tuh kan*, ternyata benar ada pencilan *lhoo*.

Oke, sekarang kita lihat `viewCount` per masing-masing
video:

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/KalbeFamily/2019-12-12-blog-posting-youtube-kalbe_files/figure-gfm/unnamed-chunk-12-1.png "chart")

# To be continue

Saya selesaikan _after_ orientasi yah… _heeee_ sabar-sabar....
