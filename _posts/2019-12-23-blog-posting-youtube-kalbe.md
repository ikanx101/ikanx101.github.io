---
date: 2019-12-23T10:22:00-04:00
title: "Stalking Youtube Channel KalbeFamily"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Youtube Data API
  - Youtube
  - Kalbe
---

> Sebelumnya mohon maaf bahwa tulisan ini baru saya selesaikan sekarang.
> Lebih dari seminggu sejak data *Youtube channel* **KalbeFamily** ini
> saya *scrap*. Berhubung saya terkena 
> [cacar air](https://ikanx101.github.io/blog/cacar-air/) dan setelah itu
> harus menyelesaikan tugas kantor dulu, maka tulisan ini terbengkalai.
> *Hehe*

-----

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

-----

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

-----

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

Mari kita lihat beberapa video yang memiliki `viewCount` tinggi. Apa
saja sih?

### Video `viewCount` Tertinggi

Kita akan cek video pertama yang memiliki `viewCount` terbanyak, yakni:

    ##   viewCount likeCount dislikeCount favoriteCount commentCount
    ## 1    398117         7            0             0            0

    ##       episode contentDetails.videoPublishedAt
    ## 1 video ke 17        2016-12-19T06:49:09.000Z

Video tersebut adalah sebuah video yang pertama kali tayang di tanggal
19 Desember 2016. Di- *like* oleh 7 orang *viewers* tanpa ada komentar
sama sekali.

> Jika kita lihat videonya di [link berikut
> ini](https://www.youtube.com/watch?v=b-Ndj4ilz0s), ternyata tema dari
> video itu adalah **hari ibu**. *So*, wajar yah bahwa video itu punya
> `viewCount` yang tinggi.

### Video `viewCount` Tertinggi Kedua

Kita akan cek video selanjutnya yang memiliki `viewCount` terbanyak
kedua, yakni:

    ##   viewCount likeCount dislikeCount favoriteCount commentCount
    ## 1    263659        77           48             0            1

    ##       episode contentDetails.videoPublishedAt
    ## 1 video ke 41        2013-03-26T04:11:22.000Z

Ada hal menarik pada [video
ini](https://www.youtube.com/watch?v=BzYgSo2ekAA), video yang bertemakan
mengenai kehamilan ini di- *like* oleh 77 *viewers* tapi di- *dislike*
oleh 48 *viewers*.

> *Apa yang salah dari video ini?* Pikir saya. Kalau kalian tahu, *plis
> let me know* yah.

### Video `viewCount` Tertinggi Ketiga

Kita akan cek video selanjutnya yang memiliki `viewCount` terbanyak
ketiga, yakni:

    ##   viewCount likeCount dislikeCount favoriteCount commentCount
    ## 1    106103       205           43             0           16

    ##       episode contentDetails.videoPublishedAt
    ## 1 video ke 31        2013-10-02T01:35:03.000Z

Ada hal menarik pada [video
ini](https://www.youtube.com/watch?v=HR5YkChg80k), video yang bertemakan
mengenai *KALBE Family Rewards Card* ini di- *like* oleh 205 *viewers*
tapi di- *dislike* oleh 43 *viewers*.

Kalau kita lihat kolom komentar, kira-kira apa yang bisa kita simpulkan
dari video ini?

> Menurut saya, kita bisa mengambil pelajaran dari video ini. Apa itu?
> Plis komen yah.

-----

## `komen`

Nah, *dataset* ini berisi komentar-komentar dari *viewers* di semua
video yang ada di *Youtube channel* **KalbeFamily**.

Ternyata ada 49 komen. Saat saya baca sekilas, sepertinya seru kalau
dibuatkan *sentiment analysis*-nya. *Gak percaya?*

Nih, baca sendiri deh komentar-komentarnya:

    ##                 authorDisplayName
    ## 1                      my ciputra
    ## 2                  Velly Boutique
    ## 3                    Mutiara Kelf
    ## 4                    Gusti Raudah
    ## 5                    Gusti Raudah
    ## 6                       Happy Fun
    ## 7                   Sahidun Zuhri
    ## 8                  Aulia Ekayanty
    ## 9                   Ainun Habibie
    ## 10                   Asep Cahyogi
    ## 11                        dwi edc
    ## 12                 nviant channel
    ## 13                   Hilmi Azkiah
    ## 14                      iuz Vlade
    ## 15                 Dita Anggraini
    ## 16                TVCONAIR CMPlus
    ## 17                 Kharisma Cover
    ## 18                diniramadhaniku
    ## 19              Nela Puspita Sari
    ## 20                      Anik Sari
    ## 21                   Ragila Fajar
    ## 22                  Agus Iskandar
    ## 23                Andreas Santoso
    ## 24         Fianyta Dwi Prihartini
    ## 25                   Yeni Hastuti
    ## 26                 segaladireview
    ## 27              Nela Puspita Sari
    ## 28                  Aprilila ulfa
    ## 29                 Fatma Yulianti
    ## 30                     Rena Julia
    ## 31                  Adhitya Fariz
    ## 32                       eka dian
    ## 33                Raja Hindustani
    ## 34                      Happy Fun
    ## 35                   Heny Puspita
    ## 36                      Happy Fun
    ## 37 Democrats and Yellowtards Suck
    ## 38              Mis yanti Limpuru
    ## 39                    Zur'ah Zein
    ## 40               Morita Handayani
    ## 41                 smile to happy
    ## 42             Puji Rahayu Rahayu
    ## 43          Wayan sudamiati wayan
    ## 44                halimah selamat
    ## 45                   Ainy Dheriel
    ## 46                Herlina Gunawan
    ## 47                      Happy Fun
    ## 48                 Wawan Apriyoko
    ## 49                      Rada Bisa
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       textDisplay
    ## 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        YA KALBE
    ## 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Gendis
    ## 3                                                                                                                                                                                                                                                                                                                                                                                                                                                      Aneh. Masak anak nya ngejek ibu nya faktor U (yg berarti ibu nya menua). Kalo saya dlu wkt kecil, malah nangis2 kalo d bilang ibu ku menua
    ## 4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Iklan
    ## 5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Entrasol
    ## 6                                                                                                                                                                                                                                 Dear kalbe, saya telah melakukan pendaftaran melalui <a href="http://www.kalbestore.com/">www.kalbestore.com</a> dan telah melakukan pembelian produk kalbe nutritionals dengan minimal belanjan Rp. 200.000<br />Tapi kenapa sampai sekarang saya belum menerima kartu member kalbe family ?<br />Mohon informasi lebih lebih lanjut, terkait hal tersebut....
    ## 7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           <a href="http://www.youtube.com/results?search_query=%23BANGGAKALBE">#BANGGAKALBE</a>
    ## 8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Wah keren kali iniiiii\U0001f604\U0001f44d\U0001f3fb
    ## 9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     wow banyak jiwa mudanya ya... jadi pengen beli saham kalbe.
    ## 10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Pharos kpan kya gini yak \U0001f602
    ## 11                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Semoga adiku betah disana
    ## 12                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Kalbe olympic 2019 part 1 : <a href="https://youtu.be/yWopbAz31IA">https://youtu.be/yWopbAz31IA</a>
    ## 13                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Love you kalbe
    ## 14                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Halo BCA bgt sih wkwkwkkw
    ## 15                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Kantor gw ga ada begini2an..boro2 mah bikin begini, makan di meja kantor aja di SP
    ## 16                                                                                                                                                                                                                                                                                                                                                                         <a href="https://www.youtube.com/watch?v=xmsT9vU8bno&amp;t=0m51s">0:51</a> Abu.. Bakar Airlines.. Tuk Penerbangan Kita... Abu Bakar Airlines.. Dengan 5 Star SKYTRAX.. Wujudkan Mimpi Dan Cita2 Utk Bangsa Indonesia..
    ## 17                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     jadi yg lewat doang w haha
    ## 18                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     \U0001f601
    ## 19                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Menginspirasi :&#39;)
    ## 20                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Tiada hari tanpa berpelukan...<br />
    ## 21 Saya udah coba tapi susah banget, ada terapi buat masalah ketergantungan dengan gadget atau internet ngga sih? Efeknya krasa banget, yah saya emang punya lebih dari 1000 teman di facebook tapi dan yang saya kenal ngga nyampe 30% dari itu.. Efeknya krasa banget pas saya pimdah SMA di bandung, sama tetangga saya awalnya emang saya hai dan blaa bla bla cerita banyak lalu tukeran alamat Facebook BBM yah.. Nah setelah itu yah kalo di itung persentasenya saya lebih sering chatting sama dia daripada saya ngobrol langsung tatap muka dengan dia.. Ah semuanya tolong sayaaaa!!!!
    ## 22                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Nicely done, Kalbe team :)
    ## 23                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      a time to hug your family is priceless...
    ## 24                                                                                                                                                                                                                                                                                                          Keluarga adalah &quot;segalanya&quot;,maka jaga &quot;segalanya&quot; tersebut dengan cara berpelukan :)  <a href="http://www.youtube.com/results?search_query=%23HappyFamily">#HappyFamily</a>   <a href="http://www.youtube.com/results?search_query=%23FamilyHug">#FamilyHug</a>  
    ## 25                                                                                                                                                                                                                                                                                                                                                                                                  Berpelukan  selain untuk kasih sayang juga bagaikan obat ajaib untuk melepas lel ah ataupun kesedihan, selalu ingin berpelukan dengan keluargaku tercinta untuk menjadi pribadi yg tangguh :)
    ## 26                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <br /><br />Yups, sayangi mereka, jangan ragu untuk ekspresikan dengan pelukan hangat di setiap pertemuan :)
    ## 27                                                                                                                                                                                                                                                                                                                                                                    Kasih sayang antar anggota keluarga semakin terasa dengan kita saling berpelukan. Berpelukan adalah kehangatan cinta dikeluarga ♥♥♥<br /><a href="http://www.youtube.com/results?search_query=%23FamilyHug">#FamilyHug</a> 
    ## 28                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Berpelukan merupakan simbol kasih sayang... :)
    ## 29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Pelukan keluarga adalah semangatku
    ## 30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Tiada hari tanpa berpelukan with my princes
    ## 31                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            wah omesh udah terlanjur ada kontrak sama produk kompetitor ya? :-)
    ## 32                                                                                                                                                                                                                                                                                                                                                                                                                Love this apps, silakan download di <a href="https://play.google.com/store/apps/details?id=kalcare.mommychi">https://play.google.com/store/apps/details?id=kalcare.mommychi</a>
    ## 33                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Belanja nya dmna sih untuk member kalbe family
    ## 34                                                                                                                                                                                                                                Dear kalbe, saya telah melakukan pendaftaran melalui <a href="http://www.kalbestore.com/">www.kalbestore.com</a> dan telah melakukan pembelian produk kalbe nutritionals dengan minimal belanjan Rp. 200.000<br />Tapi kenapa sampai sekarang saya belum menerima kartu member kalbe family ?<br />Mohon informasi lebih lebih lanjut, terkait hal tersebut....
    ## 35                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Saya pakai produk Kalbe susu Morinaga, tapi bgaimana cara mendaftar lewat online?
    ## 36                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Pendaftaran by internet apa bisa?
    ## 37                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <a href="https://www.youtube.com/watch?v=HR5YkChg80k&amp;t=2m23s">2:23</a> Kalbe logo.
    ## 38                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Mau pesan tapi ngga bisa di buka link.
    ## 39                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Saya jg ada di kasi kartu kalbe tpi gk ngerti cara pemakaian nya
    ## 40                                                                                                                                                                                                                                                                                                                                                                                          Knp setiap penukaran harus melampirkan nota pembeliannya juga? Kadang setiap beli susu di Olshop tidak ada nota pembeliannya. <br /><br />Sedangkan dirumah sudah banyak bangetttt sendok nya, numpuk
    ## 41                                                                                                                                                                                                                                                                                                           kenapa penukaran hadiahx lama...<br />sdah nunggu 1 bulan jga egh malah di konfm hadiahx kosong... kecewa sama kalbe... lemout prosesx<br />trus mau belanja di kalbe store... ngak bisa... bolak balik ajha begithu aplikasix... <br />mohon di perbaiki admin. tank&#39;z  zblumx.
    ## 42                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Di daerah blitardimana ya belinya
    ## 43                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                mohon beri cara download formnya, bagaimana cara mendapatkan form lewat online?
    ## 44                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Ngk jelas..
    ## 45                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Ko di play store sya gx ad aplikasi alacards y
    ## 46                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Susu
    ## 47                                                                                                                                                                                                                                Dear kalbe, saya telah melakukan pendaftaran melalui <a href="http://www.kalbestore.com/">www.kalbestore.com</a> dan telah melakukan pembelian produk kalbe nutritionals dengan minimal belanjan Rp. 200.000<br />Tapi kenapa sampai sekarang saya belum menerima kartu member kalbe family ?<br />Mohon informasi lebih lebih lanjut, terkait hal tersebut....
    ## 48                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Berdasarkan APA y pemilihan Pelanggan setia
    ## 49                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Waw tidak boleh menyusui saat hamil tua

_____

> Udah dulu ah, kalau ada yang mau datanya, tinggal lihat aja skrip
> coding di atas yah. Sudah ada kok cara ngambilnya.
