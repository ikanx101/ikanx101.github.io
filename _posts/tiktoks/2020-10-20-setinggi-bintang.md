---
date: 2020-10-20T10:00:00-04:00
title: "EDA: #SetinggiBintang"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Exploratory Data Analysis
  - Social Media
  - Web Scrape
---

Sebagaimana yang kita ketahui bersama, semua aktivitas yang ada di
*social media* sejatinya adalah data publik yang bisa diambil dan diolah
dengan *tools* yang tepat.

Dulu, saya pernah menjelaskan bagaimana kita bisa mengambil data dari
[*twitter*](https://passingthroughresearcher.wordpress.com/2019/10/05/twitter-analytics-menggunakan-r/),
[*instagram*](https://passingthroughresearcher.wordpress.com/2019/10/29/instagram-scraper-tropicanaslim/),
dan [*Youtube*](https://ikanx101.com/blog/blog-posting-sunyi/) lalu
menganalisanya sesuai dengan tujuan yang diinginkan.

Sekarang saya akan mencoba mengambil data dari *platform* *social media*
yang lagi *trending*.

> **TIKTOK\!\!\!**

Ternyata *social media* ini masih memiliki banyak celah untuk bisa
dieksploitasi datanya. Suatu hal yang menguntungkan bagi para **OSINT**
*lovers* *kayak* saya ini. Saya berdoa agar celah-celah ini dibiarkan
apa adanya. *haha*.

> Bahaya kalau sampai nanti ditutup lalu jadi tidak *accessible* lagi
> untuk diambil datanya.

-----

Oh iya, bagi yang belum tahu, **OSINT** adalah *Open Source
Intelligent*. Semacam kumpulan metode (dan atau *tools*) mengambil dan
menganalisa data yang tersedia secara publik.

-----

Oke, kembali ke topik. Saya akan menggunakan kombinasi antara **R** dan
*TikTok page source* untuk mengambil data yang saya mau. Nah, kali ini
saya akan mengambil data terkait *hashtag* **\#SetinggiBintang** di
*TikTok*. Semua data ini saya *scrape* per tanggal `20 Oktober 2020`
pukul `10:50` WIB *yah*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/setinggibintang.png" width="639" />

-----

## Mengambil Data

Untuk mengambil data *posting* terkait *hashtag* **\#SetinggiBintang**,
saya menggunakan *Phyton* yang di-*run* di **R**.

> Analoginya seperti *Googling* di *Yahoo*.

Data apa saja yang bisa diambil? Karena saya mengambil semua posting
terkait *hashtag* tersebut, maka data yang bisa diambil antara lain:

  - `Video meta`: ukuran video, ratio, dan durasi.
  - `user-post related`: Siapa yang *posting*, kapan, deskripsi video,
    musik yang digunakan, *like count*, *share count*, *play count*,
    *comment count*,

Tapi kalau isi komen dan siapa yang komen, saya harus mengambilnya dari
*page source* si **TikTok**-nya.

Sayangnya datanya memiliki struktur *list* jadi tidak bisa diubah dengan
mudah ke dalam *Excel format files*. Bentuk data yang paling
memungkinkan adalah dengan forma `.json`.

Berikut adalah struktur data dari `303` *posting* **\#SetinggiBintang**
yang saya ambil:

    ## tibble [303 × 59] (S3: tbl_df/tbl/data.frame)
    ##  $ videoMeta_width           : int [1:303] 540 576 540 540 540 544 576 544 544 576 ...
    ##  $ videoMeta_height          : int [1:303] 960 1024 920 960 960 960 1024 960 960 1024 ...
    ##  $ videoMeta_ratio           : int [1:303] 15 19 15 15 15 17 14 15 16 15 ...
    ##  $ videoMeta_duration        : int [1:303] 15 19 15 15 15 17 14 15 16 15 ...
    ##  $ id                        : chr [1:303] "6873746081885375745" "6873763084222106882" "6873779166312025345" "6873797426617142529" ...
    ##  $ text                      : chr [1:303] "Ikutan nih challenge gerak #SetinggiBintang #hiloteen biar #tumbuhkeatas walau cuma di rumah! Hadiahnya folding"| __truncated__ "Ikutan nih challenge gerak #SetinggiBintang #hiloteen biar #tumbuhkeatas walau cuma di rumah! Hadiahnya folding"| __truncated__ "Ikutan nih challenge gerak #SetinggiBintang #hiloteen biar #tumbuhkeatas walau cuma di rumah! Hadiahnya folding"| __truncated__ "Yuk ikutan challenge gerak #SetinggiBintang #hiloteen biar #tumbuhkeatas walau cuma di rumah! Hadiahnya folding"| __truncated__ ...
    ##  $ stitchEnabled             : chr [1:303] "TRUE" "FALSE" "TRUE" "TRUE" ...
    ##  $ shareEnabled              : chr [1:303] "TRUE" "TRUE" "TRUE" "TRUE" ...
    ##  $ createTime                : chr [1:303] "1600418732" "1600422689" "1600426430" "1600430682" ...
    ##  $ authorId                  : chr [1:303] "6785757639507969025" "6579410540539068417" "76121731081" "73760826557" ...
    ##  $ musicId                   : chr [1:303] "6871109231316043777" "6871109231316043777" "6871109231316043777" "6871109231316043777" ...
    ##  $ diggCount                 : int [1:303] 29000 37000 14200 76800 14900 11400 952 689 557 3474 ...
    ##  $ shareCount                : int [1:303] 356 235 376 292 138 202 15 25 13 53 ...
    ##  $ playCount                 : int [1:303] 562500 592200 373500 972700 291600 292100 47100 35100 29500 172800 ...
    ##  $ commentCount              : int [1:303] 181 356 107 257 94 83 7 12 8 38 ...
    ##  $ isOriginal                : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ isOfficial                : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ isActivityItem            : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ secret                    : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ forFriend                 : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ vl1                       : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ warnInfo                  : chr [1:303] "list()" "list()" "list()" "list()" ...
    ##  $ liked                     : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ commentStatus             : int [1:303] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ showNotPass               : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ authorInfos_userId        : chr [1:303] "6785757639507969025" "6579410540539068417" "76121731081" "73760826557" ...
    ##  $ authorInfos_uniqueId      : chr [1:303] "phoebe.mulyana" "stanleyhao" "lutfialmsyh" "dinda_ans" ...
    ##  $ authorInfos_nickName      : chr [1:303] "vibi" "HAO" "Lutfi🦦" "Dinda Annisa" ...
    ##  $ authorInfos_signature     : chr [1:303] "follow me on ig😉\nTHANK U FOR 2M!💖💖" "random aja.\n20 🇮🇩" "Kamu gatau klo aku ada youtube? 👇🏻" "My Instagram ❤️ : Dinda_ans\nSamarinda Kaltim\nSubscribe Yah Youtube ku 👇👇" ...
    ##  $ authorInfos_verified      : chr [1:303] "FALSE" "FALSE" "TRUE" "TRUE" ...
    ##  $ authorInfos_isSecret      : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ authorInfos_secret        : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ authorInfos_relation      : int [1:303] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...
    ##  $ musicInfos_musicId        : chr [1:303] "6871109231316043777" "6871109231316043777" "6871109231316043777" "6871109231316043777" ...
    ##  $ musicInfos_musicName      : chr [1:303] "Setinggi Bintang" "Setinggi Bintang" "Setinggi Bintang" "Setinggi Bintang" ...
    ##  $ musicInfos_authorName     : chr [1:303] "HiLo Teen x DJ Desa" "HiLo Teen x DJ Desa" "HiLo Teen x DJ Desa" "HiLo Teen x DJ Desa" ...
    ##  $ musicInfos_original       : chr [1:303] "" "" "" "" ...
    ##  $ authorStats_followingCount: int [1:303] 100 256 123 79 123 98 11 319 33 173 ...
    ##  $ authorStats_followerCount : int [1:303] 2100000 2200000 1300000 6900000 301700 777700 12600 14200 1072 778 ...
    ##  $ authorStats_heartCount    : chr [1:303] "21600000" "117000000" "27000000" "114900000" ...
    ##  $ authorStats_videoCount    : int [1:303] 217 1352 1114 477 740 449 87 128 44 95 ...
    ##  $ authorStats_diggCount     : int [1:303] 2143 24300 2694 3232 4220 2567 333 677 1839 40900 ...
    

Oke, kalau bingung melihat strukturnya, saya langsung masuk ke
visualisasi dari data tersebut.

### Exploratory Data Analysis: Semua *Posting* **\#SetinggiBintang**

### Durasi Video

**TikTok** memang membatasi video yang di-*post* oleh *user*-nya. Untuk
*hashtag* **\#SetinggiBintang** ada dua kelompok video berdasarkan
durasinya. Sebagian besar berada di kisaran `15` detik, selainnya ada di
`19` detik.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-3-1.png" width="672" />

### Video Ratio (width x height)

*Video ratio* dari yang paling sering digunakan adalah `576 x 1024` px,
yakni sebanyak `192` buah *post*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-4-1.png" width="672" />

### Waktu *Posting*

Berikutnya saya akan coba lihat waktu *posting* video
**\#SetinggiBintang**.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-5-1.png" width="672" /><img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-5-2.png" width="672" /><img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-5-3.png" width="672" /><img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-5-4.png" width="672" />

### Most *Likes*, *Comments*, *Share*, and *Play*

Sekarang saya akan coba lihat, *user* mana saja yang mendapatkan *likes*
terbanyak.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-6-1.png" width="672" />

Sekarang saya akan coba lihat, *user* mana saja yang mendapatkan
*comments* terbanyak.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-7-1.png" width="672" />

Sekarang saya akan coba lihat, *user* mana saja yang mendapatkan *share*
terbanyak.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-8-1.png" width="672" />

Sekarang saya akan coba lihat, *user* mana saja yang mendapatkan *play*
terbanyak.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-9-1.png" width="672" />

Menarik bahwa ternyata kita bisa temukan *user* yang berbeda-beda di
masing-masing kategori. Kalau saya buat analisa *cross* antara *likes*
dan *comments*, berikut hasilnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-10-1.png" width="672" />

### User Mana yang Punya Follower dan Video Terbanyak

Dari sekian banyak *user* **TikTok** yang posting **\#SetinggiBintang**,
saya penasaran… Siapa yang memiliki *follower* terbanyak? Siapa yang
paling **produktif**? (memiliki video terbanyak di **TikTok**).

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-11-1.png" width="672" />

-----

# *What’s Next?*

Selain data agregasi seperti di atas, saya juga memiliki data `20`
*latest comments* *netizen* kepada video **\#SetinggiBintang** dari
`phoebe.mulyana` sebagai berikut:

    ## [1] "ga bakal dinotice"
    ## [1] "kak kayak mana ikutan nya buat filter aq gaptek\nmohon bantuu"
    ## [1] "hayy kakak cantik🙋🏻‍♀❤\n@phoebe.mulyana \ndi notif gk ni:?"
    ## [1] "Kaka cantikkk🥰🥰🥰"
    ## [1] "Hii kak aku pengen banget disapa❤😭"
    ## [1] "up"
    ## [1] "8uynvbjjjoihjb"
    ## [1] "gesit kalii"
    ## [1] "halo kak😁"
    ## [1] "keren lagu.. pas dancenya.... joss"
    ## [1] "jok8b"
    ## [1] "kok cantik😇"
    ## [1] "hiu 🥰"
    ## [1] "hdir pgi kak..y"
    ## [1] "kak cantik sekali kaya kak naisa"
    ## [1] "cocok juga buat olahraga pagi😬"
    ## [1] "trik marketing s3 good job hilo 😂."
    ## [1] "sponsor mpkmb IPB 😁"
    ## [1] "halo kak 🙋"
    ## [1] "Haha lucu banget lompat2 gitu🤭🤭"

Tentunya ada data lain juga yang *embedded* ke data komen ini. Mirip
dengan data agregasi: `waktu`, `nama user`, dan `likes`.

-----

### *Udah ah segitu dulu…*
