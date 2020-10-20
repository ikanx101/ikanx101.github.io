---
date: 2020-10-20T08:30:00-04:00
title: "Kabar Gembira Untuk Kita Semua: TikTok Kini Ada Ekstraknya!"
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
    ##  $ urls                      : chr [1:303] "https://v16-web-newkey.tiktokcdn.com/5289e419e05efbf4ccee703692af6196/5f8e9cb0/video/tos/alisg/tos-alisg-pve-00"| __truncated__ "https://v16-web-newkey.tiktokcdn.com/693a5e72dbdbfe21ada7e6ffc4e3eab4/5f8e9cb4/video/tos/alisg/tos-alisg-pve-00"| __truncated__ "https://v19-web-newkey.tiktokcdn.com/d81c7a1a787e66eeb4f4d5ebc6caf9f3/5f8e9cb0/video/tos/alisg/tos-alisg-pve-00"| __truncated__ "https://v19-web-newkey.tiktokcdn.com/be85f67a59e4ebdf37365917e4b1d1a6/5f8e9cb0/video/tos/alisg/tos-alisg-pve-00"| __truncated__ ...
    ##  $ id                        : chr [1:303] "6873746081885375745" "6873763084222106882" "6873779166312025345" "6873797426617142529" ...
    ##  $ text                      : chr [1:303] "Ikutan nih challenge gerak #SetinggiBintang #hiloteen biar #tumbuhkeatas walau cuma di rumah! Hadiahnya folding"| __truncated__ "Ikutan nih challenge gerak #SetinggiBintang #hiloteen biar #tumbuhkeatas walau cuma di rumah! Hadiahnya folding"| __truncated__ "Ikutan nih challenge gerak #SetinggiBintang #hiloteen biar #tumbuhkeatas walau cuma di rumah! Hadiahnya folding"| __truncated__ "Yuk ikutan challenge gerak #SetinggiBintang #hiloteen biar #tumbuhkeatas walau cuma di rumah! Hadiahnya folding"| __truncated__ ...
    ##  $ stitchEnabled             : chr [1:303] "TRUE" "FALSE" "TRUE" "TRUE" ...
    ##  $ shareEnabled              : chr [1:303] "TRUE" "TRUE" "TRUE" "TRUE" ...
    ##  $ createTime                : chr [1:303] "1600418732" "1600422689" "1600426430" "1600430682" ...
    ##  $ authorId                  : chr [1:303] "6785757639507969025" "6579410540539068417" "76121731081" "73760826557" ...
    ##  $ musicId                   : chr [1:303] "6871109231316043777" "6871109231316043777" "6871109231316043777" "6871109231316043777" ...
    ##  $ covers                    : chr [1:303] "c(\"https://p16-sign-sg.tiktokcdn.com/obj/tos-alisg-p-0037/c3f907f09ea342e9a0fff1f9fa64e8f6?x-expires=160318080"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/obj/v0201/57bf4af828a948d4839b05894a2c4f40_1600422692?x-expires=160318080"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/obj/v0201/940363cd57e14f63b73577deb75cd3aa_1600426434?x-expires=160318080"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/obj/v0201/4a1947eebc9b4bdbb77d8c330b51c45b_1600430699?x-expires=160318080"| __truncated__ ...
    ##  $ coversOrigin              : chr [1:303] "c(\"https://p3-sign-sg.tiktokcdn.com/obj/v0201/c45432cb97534f3d8bf693ae947e8f85_1600418735?x-expires=1603180800"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/obj/v0201/697a1bd6904b42e78729bedaee982180_1600422691?x-expires=160318080"| __truncated__ "c(\"https://p3-sign-sg.tiktokcdn.com/obj/v0201/0599a3ee35ee4ddcb87bd5f903a9b3c0_1600426433?x-expires=1603180800"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/obj/v0201/e83e0b19cf3e4278afb96b3b81be7ee7_1600430707?x-expires=160318080"| __truncated__ ...
    ##  $ shareCover                : chr [1:303] "c(\"\", \"https://p16-sign-sg.tiktokcdn.com/v0201/c45432cb97534f3d8bf693ae947e8f85_1600418735~tplv-tiktok-play."| __truncated__ "c(\"\", \"https://p16-sign-sg.tiktokcdn.com/v0201/697a1bd6904b42e78729bedaee982180_1600422691~tplv-tiktok-play."| __truncated__ "c(\"\", \"https://p16-sign-sg.tiktokcdn.com/v0201/0599a3ee35ee4ddcb87bd5f903a9b3c0_1600426433~tplv-tiktok-play."| __truncated__ "c(\"\", \"https://p16-sign-sg.tiktokcdn.com/v0201/e83e0b19cf3e4278afb96b3b81be7ee7_1600430707~tplv-tiktok-play."| __truncated__ ...
    ##  $ coversDynamic             : chr [1:303] "c(\"https://p16-sign-sg.tiktokcdn.com/obj/v0201/e5afa08d253e49208a4e550cc4beee9e_1600418736?x-expires=160318080"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/obj/v0201/cb623f7019774fdc91f51572b7870713_1600422692?x-expires=160318080"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/obj/v0201/a9365f87d90846eebf554b16f1c402a8_1600426433?x-expires=160318080"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/obj/v0201/b288458eb18441929327aec2ca5ce2e9_1600430701?x-expires=160318080"| __truncated__ ...
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
    ##  $ authorInfos_secUid        : chr [1:303] "MS4wLjABAAAAlEieHP_Y-z9on5ILSzxyLMA-O6BYhmvmqac6AO1Cc5y81FMvGLWf3rYajkgqw5Ch" "MS4wLjABAAAA3YBUlhAhpyKRwzdYk_3HjIBiK6L5s9JDMRR_9fdg80VatU7Cx1rBVL9LdZyHzpm3" "MS4wLjABAAAAL64aXBrK8f6coYju5AgIOnMG0GB0XSluZLUysxQa-So" "MS4wLjABAAAALIxCuImuwC3VWGe9Y5SUghkAOzOrFHqa9ysWNfm_e_M" ...
    ##  $ authorInfos_userId        : chr [1:303] "6785757639507969025" "6579410540539068417" "76121731081" "73760826557" ...
    ##  $ authorInfos_uniqueId      : chr [1:303] "phoebe.mulyana" "stanleyhao" "lutfialmsyh" "dinda_ans" ...
    ##  $ authorInfos_nickName      : chr [1:303] "vibi" "HAO" "Lutfi🦦" "Dinda Annisa" ...
    ##  $ authorInfos_signature     : chr [1:303] "follow me on ig😉\nTHANK U FOR 2M!💖💖" "random aja.\n20 🇮🇩" "Kamu gatau klo aku ada youtube? 👇🏻" "My Instagram ❤️ : Dinda_ans\nSamarinda Kaltim\nSubscribe Yah Youtube ku 👇👇" ...
    ##  $ authorInfos_verified      : chr [1:303] "FALSE" "FALSE" "TRUE" "TRUE" ...
    ##  $ authorInfos_covers        : chr [1:303] "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/100x100/tiktok-obj/5e125bee6ee76a2e4e4474d0fae6b606.jpeg?x-expires="| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/100x100/tos-alisg-avt-0068/8e8edc5b1fc8c2e873300c4a2721df89.jpeg?x-"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/100x100/tos-alisg-avt-0068/c1c1488a11094803fc278a8eca91da14.jpeg?x-"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/100x100/tos-alisg-avt-0068/ae4c04d28dbcc2abda995a29843700ce.jpeg?x-"| __truncated__ ...
    ##  $ authorInfos_coversMedium  : chr [1:303] "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/720x720/tiktok-obj/5e125bee6ee76a2e4e4474d0fae6b606.jpeg?x-expires="| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/720x720/tos-alisg-avt-0068/8e8edc5b1fc8c2e873300c4a2721df89.jpeg?x-"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/720x720/tos-alisg-avt-0068/c1c1488a11094803fc278a8eca91da14.jpeg?x-"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/720x720/tos-alisg-avt-0068/ae4c04d28dbcc2abda995a29843700ce.jpeg?x-"| __truncated__ ...
    ##  $ authorInfos_coversLarger  : chr [1:303] "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/1080x1080/tiktok-obj/5e125bee6ee76a2e4e4474d0fae6b606.jpeg?x-expire"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/1080x1080/tos-alisg-avt-0068/8e8edc5b1fc8c2e873300c4a2721df89.jpeg?"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/1080x1080/tos-alisg-avt-0068/c1c1488a11094803fc278a8eca91da14.jpeg?"| __truncated__ "c(\"https://p16-sign-sg.tiktokcdn.com/aweme/1080x1080/tos-alisg-avt-0068/ae4c04d28dbcc2abda995a29843700ce.jpeg?"| __truncated__ ...
    ##  $ authorInfos_isSecret      : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ authorInfos_secret        : chr [1:303] "FALSE" "FALSE" "FALSE" "FALSE" ...
    ##  $ authorInfos_relation      : int [1:303] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...
    ##  $ musicInfos_musicId        : chr [1:303] "6871109231316043777" "6871109231316043777" "6871109231316043777" "6871109231316043777" ...
    ##  $ musicInfos_musicName      : chr [1:303] "Setinggi Bintang" "Setinggi Bintang" "Setinggi Bintang" "Setinggi Bintang" ...
    ##  $ musicInfos_authorName     : chr [1:303] "HiLo Teen x DJ Desa" "HiLo Teen x DJ Desa" "HiLo Teen x DJ Desa" "HiLo Teen x DJ Desa" ...
    ##  $ musicInfos_original       : chr [1:303] "" "" "" "" ...
    ##  $ musicInfos_playUrl        : chr [1:303] "https://sf16-sg.tiktokcdn.com/obj/tiktok-obj/296e1c7d73b50c48f9117c7d438aff40.mp3" "https://sf16-sg.tiktokcdn.com/obj/tiktok-obj/296e1c7d73b50c48f9117c7d438aff40.mp3" "https://sf16-sg.tiktokcdn.com/obj/tiktok-obj/296e1c7d73b50c48f9117c7d438aff40.mp3" "https://sf16-sg.tiktokcdn.com/obj/tiktok-obj/296e1c7d73b50c48f9117c7d438aff40.mp3" ...
    ##  $ musicInfos_covers         : chr [1:303] "https://p16-sg.tiktokcdn.com/aweme/100x100/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" "https://p16-sg.tiktokcdn.com/aweme/100x100/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" "https://p16-sg.tiktokcdn.com/aweme/100x100/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" "https://p16-sg.tiktokcdn.com/aweme/100x100/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" ...
    ##  $ musicInfos_coversMedium   : chr [1:303] "https://p16-sg.tiktokcdn.com/aweme/200x200/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" "https://p16-sg.tiktokcdn.com/aweme/200x200/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" "https://p16-sg.tiktokcdn.com/aweme/200x200/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" "https://p16-sg.tiktokcdn.com/aweme/200x200/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" ...
    ##  $ musicInfos_coversLarger   : chr [1:303] "https://p16-sg.tiktokcdn.com/aweme/720x720/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" "https://p16-sg.tiktokcdn.com/aweme/720x720/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" "https://p16-sg.tiktokcdn.com/aweme/720x720/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" "https://p16-sg.tiktokcdn.com/aweme/720x720/tiktok-obj/image/eced34732f6e57b3dc31251a9c1c3051.png.jpeg" ...
    ##  $ authorStats_followingCount: int [1:303] 100 256 123 79 123 98 11 319 33 173 ...
    ##  $ authorStats_followerCount : int [1:303] 2100000 2200000 1300000 6900000 301700 777700 12600 14200 1072 778 ...
    ##  $ authorStats_heartCount    : chr [1:303] "21600000" "117000000" "27000000" "114900000" ...
    ##  $ authorStats_videoCount    : int [1:303] 217 1352 1114 477 740 449 87 128 44 95 ...
    ##  $ authorStats_diggCount     : int [1:303] 2143 24300 2694 3232 4220 2567 333 677 1839 40900 ...
    ##  $ challengeInfoList         : chr [1:303] "list(challengeId = \"1677327722001410\", challengeName = \"SetinggiBintang\", isCommerce = TRUE, text = \"Ayo g"| __truncated__ "list(challengeId = \"1677327722001410\", challengeName = \"SetinggiBintang\", isCommerce = TRUE, text = \"Ayo g"| __truncated__ "list(challengeId = \"1677327722001410\", challengeName = \"SetinggiBintang\", isCommerce = TRUE, text = \"Ayo g"| __truncated__ "list(challengeId = \"1677327722001410\", challengeName = \"SetinggiBintang\", isCommerce = TRUE, text = \"Ayo g"| __truncated__ ...
    ##  $ duetInfo                  : chr [1:303] "0" "0" "0" "0" ...
    ##  $ textExtra                 : chr [1:303] "list(AwemeId = c(\"\", \"\", \"\", \"\", \"\"), Start = c(131, 27, 44, 59, 141), End = c(140, 43, 53, 72, 144),"| __truncated__ "list(AwemeId = c(\"\", \"\", \"\", \"\"), Start = c(27, 44, 59, 142), End = c(43, 53, 72, 145), HashtagName = c"| __truncated__ "list(AwemeId = c(\"\", \"\", \"\", \"\", \"\"), Start = c(131, 27, 44, 59, 142), End = c(140, 43, 53, 72, 145),"| __truncated__ "list(AwemeId = c(\"\", \"\", \"\", \"\", \"\"), Start = c(131, 27, 44, 59, 141), End = c(140, 43, 53, 72, 144),"| __truncated__ ...
    ##  $ stickerTextList           : chr [1:303] "list()" "list()" "list()" "list()" ...

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
