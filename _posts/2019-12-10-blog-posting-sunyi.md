---
date: 2019-12-10T10:49:00-04:00
title: "Sunyi Web Series by Tropicana Slim"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Text Analysis
  - Web Series
  - Marketing
---

> Data is the new oil

Masih ingat dengan *quotes* di atas? Di tulisan saya yang
[lalu](https://ikanx101.github.io/blog/kuliah-umum-tel-u/), saya pernah
menyebutkan bahwa salah satu tantangan bagi kita saat ini terkait data
adalah **di mana kita bisa mendapatkannya**. Sejatinya di zaman digital
ini, data bertebaran di mana-mana.

Kembali ke judul tulisan ini, **Tropicana Slim** selalu saja membuat
*web series* yang menarik dan layak ditunggu di *channel*
**Youtube**-nya. Setelah meluncurkan *web series* **Sore** dan
**Janji**, kini ada **Sunyi**. Hal yang paling serunya lagi adalah
**Sunyi** bertemakan dunia *difabel* atau *disabilitas*.

*Cobain deh*, nonton episode
[pertamanya](https://www.youtube.com/watch?v=7_0V14TYVzc). Dijamin bikin
penasaran (*dan mungkin baper bagi Anda yang jomblo*). *hehe*

Sampai tulisan ini saya buat, **Sunyi** sudah sampai episode 3 *lhoo*.
*Viewers*-nya sudah belasan ribu.

*Nah*, sekarang saya coba *iseng* mengambil data dari **Youtube**
terkait *web series* ini. Untuk melakukannya saya menggunakan bantuan
~~Python~~ **R** dan **Youtube Data API**.

Proses membuat *Google Authetication* -nya mirip dengan layanan *Google
Vision AI*, yakni tidak menggunakan **API key** walau nama layanannya
**API**. Bagian ini saya *skip* yah. Kita langsung ke bagian ambil dan
ekstrak datanya. Penasaran data apa saja yang bisa diambil? *Yuk
cekidot\!*

-----

## Data pertama

Data yang paling mudah diambil adalah data berapa banyak *view*, *like*,
*dislike*, *favourite*, dan *comment*. Sepertinya hal yang receh yah.
Gak pake bantuan **R** sebenarnya bisa diambil sendiri *manual*
satu-persatu. Tapi kalau *web series*-nya kayak
[Tersanjung](https://id.wikipedia.org/wiki/Tersanjung) *gimana hayo*?

Hasil datanya seperti
    ini:

    ##   viewCount likeCount dislikeCount favoriteCount commentCount episode
    ## 1     16637      1246            3             0           60       1
    ## 2     14558       998            1             0           47       2
    ## 3     11153      1049            4             0           61       3

Heran yah, padahal sudah bagus gitu *web series*-nya, masih ada aja yang
*dislike*. *hehe*

Kalau dilihat sekilas, *viewers*-nya menurun tiap episode. Bisa jadi
karena memang *web series*-nya baru saja mulai. Jadi belum banyak yang
menonton.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-3-1.png "chart")

Walaupun begitu, tren yang berbeda ditunjukkan pada variabel `likeCount`
dan `commentCount`. Sempat menurun pada episode kedua tapi naik di
episode
ketiga.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-4-1.png "chart")

Coba yah kalau kita buat variabel `likeCount` dan `commentCount` dalam
bentuk rasio terhadap `viewCount`. Bentuknya jadi sebagai
berikut:

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-5-1.png "chart")

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-5-2.png "chart")

Nah kalau dari rasio sudah terlihat mirip kan yah polanya.

#### Kalau punya data ini trus *So What Gitu Lho?*

Nah, kira-kira ada yang kebayang gak data ini bisa diapakan saja? Nih,
saya kasih ide. Satu aja yah tapinya (lainnya harus dipikirkan sendiri
donk). *hehe*

> Misal, saya punya data ini (plus data durasi video) dari keseluruhan
> video yang ada di suatu *channel Youtube*, saya bisa bikin clustering
> analysis dari semua video itu. Lalu saya bisa analisa, karakteristik
> dari masing-masing cluster video yang terbentuk. Jangan-jangan ada
> pola antar beberapa video yang ada. Bisa jadi ide untuk *next content
> development*-nya.

Di tulisan berikutnya yah, saya cobain kayak gimana sih analisanya
*real*-nya.

-----

## Data kedua

Berikutnya adalah data detail properties dari video tersebut. Mencakup:
judul, waktu *upload*, deskripsi, resolusi, *hashtags* yang digunakan,
dll. Contohnya untuk episode 1, data yang dapat dilihat adalah sbb:

    ## $kind
    ## [1] "youtube#videoListResponse"
    ## 
    ## $etag
    ## [1] "\"j6xRRd8dTPVVptg711_CSPADRfg/6BfRUWI6BIx5UnfQ8l1QuQIYAj8\""
    ## 
    ## $pageInfo
    ## $pageInfo$totalResults
    ## [1] 1
    ## 
    ## $pageInfo$resultsPerPage
    ## [1] 1
    ## 
    ## 
    ## $items
    ## $items[[1]]
    ## $items[[1]]$kind
    ## [1] "youtube#video"
    ## 
    ## $items[[1]]$etag
    ## [1] "\"j6xRRd8dTPVVptg711_CSPADRfg/fm9wGb1oA7tosD14SOeixp0lW_Q\""
    ## 
    ## $items[[1]]$id
    ## [1] "7_0V14TYVzc"
    ## 
    ## $items[[1]]$snippet
    ## $items[[1]]$snippet$publishedAt
    ## [1] "2019-11-07T10:45:54.000Z"
    ## 
    ## $items[[1]]$snippet$channelId
    ## [1] "UCgXrsigk6dCc6wzOZU70KJA"
    ## 
    ## $items[[1]]$snippet$title
    ## [1] "#CeritaSunyi episode 01"
    ## 
    ## $items[[1]]$snippet$description
    ## [1] "Ada lebih banyak yang bisa disampaikan tanpa suara. Kini saatnya Sunyi bercerita. Subscribe Youtube Tropicana Slim untuk ikuti ceritanya."
    ## 
    ## $items[[1]]$snippet$thumbnails
    ## $items[[1]]$snippet$thumbnails$default
    ## $items[[1]]$snippet$thumbnails$default$url
    ## [1] "https://i.ytimg.com/vi/7_0V14TYVzc/default.jpg"
    ## 
    ## $items[[1]]$snippet$thumbnails$default$width
    ## [1] 120
    ## 
    ## $items[[1]]$snippet$thumbnails$default$height
    ## [1] 90
    ## 
    ## 
    ## $items[[1]]$snippet$thumbnails$medium
    ## $items[[1]]$snippet$thumbnails$medium$url
    ## [1] "https://i.ytimg.com/vi/7_0V14TYVzc/mqdefault.jpg"
    ## 
    ## $items[[1]]$snippet$thumbnails$medium$width
    ## [1] 320
    ## 
    ## $items[[1]]$snippet$thumbnails$medium$height
    ## [1] 180
    ## 
    ## 
    ## $items[[1]]$snippet$thumbnails$high
    ## $items[[1]]$snippet$thumbnails$high$url
    ## [1] "https://i.ytimg.com/vi/7_0V14TYVzc/hqdefault.jpg"
    ## 
    ## $items[[1]]$snippet$thumbnails$high$width
    ## [1] 480
    ## 
    ## $items[[1]]$snippet$thumbnails$high$height
    ## [1] 360
    ## 
    ## 
    ## 
    ## $items[[1]]$snippet$channelTitle
    ## [1] "Tropicana Slim"
    ## 
    ## $items[[1]]$snippet$tags
    ## $items[[1]]$snippet$tags[[1]]
    ## [1] "#TropicanaSlim"
    ## 
    ## $items[[1]]$snippet$tags[[2]]
    ## [1] "#CeritaSunyi"
    ## 
    ## 
    ## $items[[1]]$snippet$categoryId
    ## [1] "1"
    ## 
    ## $items[[1]]$snippet$liveBroadcastContent
    ## [1] "none"
    ## 
    ## $items[[1]]$snippet$localized
    ## $items[[1]]$snippet$localized$title
    ## [1] "#CeritaSunyi episode 01"
    ## 
    ## $items[[1]]$snippet$localized$description
    ## [1] "Ada lebih banyak yang bisa disampaikan tanpa suara. Kini saatnya Sunyi bercerita. Subscribe Youtube Tropicana Slim untuk ikuti ceritanya."
    ## 
    ## 
    ## $items[[1]]$snippet$defaultAudioLanguage
    ## [1] "id"

Saya kurang tertarik dengan data kedua ini, mungkin akan saya *skip*
dulu yah. Kalau teman-teman ada ide untuk melakukan analisa apa, *let me
know yah*.

-----

## Data ketiga

Data berikutnya yang bisa diambil adalah data komentar *viewers* di
masing-masing video. Jadi ini data murni komen terhadap videonya yah.
Jika ada *reply* dari komen, datanya ternyata tidak ada. Nah, ini baru
menarik. Apa aja isinya? Berikut nama variabelnya
    yah:

``` r
str(komen)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 150 obs. of  8 variables:
    ##  $ authorDisplayName    : chr  "Sunyi Coffee" "Ariva Azka" "Irfan Parikesit" "Marcella Soenggono" ...
    ##  $ authorProfileImageUrl: chr  "https://yt3.ggpht.com/a/AGF-l79Wg6bFQWROoyDBRBEIgCTCFYqW_9SGUd140g=s48-c-k-c0xffffffff-no-rj-mo" "https://yt3.ggpht.com/a/AGF-l78YLJk1eeS3fbmd4BF6HHRGEM7zua-2C0x8Ew=s48-c-k-c0xffffffff-no-rj-mo" "https://yt3.ggpht.com/a/AGF-l7-ZScpC4rsj27sFa625Vr5xVouf9ShoNdhUYA=s48-c-k-c0xffffffff-no-rj-mo" "https://yt3.ggpht.com/a/AGF-l79AW5Bdxz92Vc8G9nn37RPg56gdCe-OCzwPYQ=s48-c-k-c0xffffffff-no-rj-mo" ...
    ##  $ authorChannelUrl     : chr  "http://www.youtube.com/channel/UCkqV2x7C5G4-ekywNwwtS_Q" "http://www.youtube.com/channel/UCYukaD4hOQv946Ty4rIKJtw" "http://www.youtube.com/channel/UCj5MdRLgrW_0DollKMLzCSg" "http://www.youtube.com/channel/UC1pH7RkAaUW1gU9a7r55MOw" ...
    ##  $ textOriginal         : chr  "Mini Series hasil kolaborasi dengan TropicanaSlim, dengan aktor asli tuli dan kerjasama komunitas seni fantasi "| __truncated__ "Aku mau nonton nya nanti aja satu tahun kemudian, biar kaya SORE dan JANJI wkwkk\r\nBtw keren bgttttt web serie"| __truncated__ "oke mevvek tiba tiba pas paham" "Brilliant idea... salut bgt tropicana" ...
    ##  $ likeCount            : num  16 0 0 0 0 0 5 0 1 0 ...
    ##  $ publishedAt          : POSIXct, format: "2019-11-09 07:59:43" "2019-11-14 15:33:36" ...
    ##  $ updatedAt            : POSIXct, format: "2019-11-09 07:59:43" "2019-11-14 15:33:36" ...
    ##  $ episode              : num  1 1 1 1 1 1 1 1 1 1 ...

Setidaknya ada delapan variabel yang bisa kita ambil dan analisa, yakni:

1.  `authorDisplayName`: nama *commenter*.
2.  `authorProfileImageUrl`: *profil pic Youtube account* dari
    *commenter*.
3.  `authorChannelUrl`: *link channel Youtube* dari *commenter*.
4.  `textOriginal`: komentar.
5.  `likeCount`: Berapa banyak yang *likes* komentar tersebut.
6.  `publishedAt`: Kapan pertama kali komentar tersebut *published*.
7.  `updatedAt`: Kapan komentar tersebut diedit (jika ada).
8.  `episode`: Episode *web series* sunyi.

Oh iya, bagi rekan-rekan yang mau membedah sendiri datanya, saya
lampirkan di
[sini](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/komen.csv)
yah.

``` r
head(komen,15)
```

    ## # A tibble: 15 x 8
    ##    authorDisplayNa… authorProfileIm… authorChannelUrl textOriginal
    ##    <chr>            <chr>            <chr>            <chr>       
    ##  1 Sunyi Coffee     https://yt3.ggp… http://www.yout… "Mini Serie…
    ##  2 Ariva Azka       https://yt3.ggp… http://www.yout… "Aku mau no…
    ##  3 Irfan Parikesit  https://yt3.ggp… http://www.yout… oke mevvek …
    ##  4 Marcella Soengg… https://yt3.ggp… http://www.yout… Brilliant i…
    ##  5 Farell S         https://yt3.ggp… http://www.yout… Gold!       
    ##  6 Sachi Paramitha  https://yt3.ggp… http://www.yout… <U+2764><U+…
    ##  7 Pradana AJI      https://yt3.ggp… http://www.yout… was wonderi…
    ##  8 sherlock homele… https://yt3.ggp… http://www.yout… Astaga, lag…
    ##  9 Sachi Paramitha  https://yt3.ggp… http://www.yout… ":\"\"( gil…
    ## 10 zigi ziall       https://yt3.ggp… http://www.yout… Yg ceweknya…
    ## 11 Mojito Boss      https://yt3.ggp… http://www.yout… Saya baru p…
    ## 12 Ferlando Widjaya https://yt3.ggp… http://www.yout… Another bah…
    ## 13 Nym Supriyanto   https://yt3.ggp… http://www.yout… aktor nya t…
    ## 14 ayunizzahra      https://yt3.ggp… http://www.yout… <U+2764><U+…
    ## 15 nur widyastuti   https://yt3.ggp… http://www.yout… Lanjut mba …
    ## # … with 4 more variables: likeCount <dbl>, publishedAt <dttm>,
    ## #   updatedAt <dttm>, episode <dbl>

-----

### *Let the fun parts begin\!*

Bermodalkan data ketiga, mari kita oprek-oprek data ini. Kita mulai dari
yang paling sederhana dulu
yah.

#### Komentar paling banyak di- *like* per episode

``` r
new = komen %>% group_by(episode) %>% filter(likeCount == max(likeCount)) %>%
  select(episode,authorDisplayName,textOriginal,likeCount) %>% arrange(episode)
new
```

    ## # A tibble: 3 x 4
    ## # Groups:   episode [3]
    ##   episode authorDisplayName textOriginal                          likeCount
    ##     <dbl> <chr>             <chr>                                     <dbl>
    ## 1       1 Beela Shabeela    "Tropicana Slim memang terbaik soal …        18
    ## 2       2 SETYA NOVANTOL    "PENGEN TAU ALASAN TROPICANA SLIM BU…        17
    ## 3       3 Sunyi Coffee      Mini Series hasil kolaborasi dengan …        29

**Pada episode pertama**, komentar yang paling banyak di- *like* adalah
komentar:

    ## [1] "Tropicana Slim memang terbaik soal web series ga sabar lanjutannya "

Dengan `likeCount` sebanyak 18.

> Sebuah pujian yang tulus dari viewer terkait betapa bagusnya *web
> series*-nya TropicanaSlim.

**Sedangkan pada episode kedua**, komentar yang paling banyak di- *like*
adalah
    komentar:

    ## [1] "PENGEN TAU ALASAN TROPICANA SLIM BUAT PER EPS 1 MENIT GITU  KENAPAAAAA ?  MOHON ALASANNYA  PAPA INGIN TAU "

Dengan `likeCount` sebanyak 17.

> Nah, ini adalah pertanyaan viewer terkait durasi *web series* ini yang
> lebih singkat dibandingkan **Sore** dan **Janji**.

**Sedangkan pada episode ketiga**, komentar yang paling banyak di-
*like* adalah
    komentar:

    ## [1] "Mini Series hasil kolaborasi dengan TropicanaSlim dengan aktor asli tuli dan kerjasama komunitas seni fantasi tuli Sunyi hadir sebagai tempat pertemuan 2 dunia yg sebelumnya tidak terbayang dapat bertemu  Sunyi ingin terus berkembang untuk dapat memperkenalkan dunia disabilitas sebagai dunia yg mengagumkan dan penuh kejutan Oleh karena itu setiap like pada video CeritaSunyi di YouTube akan dikonversikan menjadi Rp 500 untuk pengembangan Sunyi House of Coffee and Hope dalam membantu memperluas kesempatan teman - teman disabilitas untuk berkreasi dan berekspresi melalui kopi  Ayo kita menjadi duta dunia yg menakjubkan ini dengan like dan share kepada rekan - rekan kalian semua karena setiap dukungan pasti sangat berarti  tropicanaslim CeritaSunyi SahabatSunyi"

Dengan `likeCount` sebanyak 29.

> Ini adalah komen dari akun resmi **Sunyi Coffee**. Sebenarnya, komen
> ini selalu muncul di setiap episode. Tapi baru di episode ketiga ini
> yang paling banyak di- *likes* oleh *viewer*.

#### Siapa yang komen?

Saya sih penasaran, apakah yang komen di ketiga video itu selalu orang
yang sama atau beda-beda yah. Yuk kita cek datanya.

    ## # A tibble: 3 x 2
    ##   summary                       banyak
    ##   <chr>                          <int>
    ## 1 Viewers yang komen di 1 video     92
    ## 2 Viewers yang komen di 2 video     18
    ## 3 Viewers yang komen di 3 video      7

    ## Loading required package: magrittr

![](2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

> Ternyata ada juga lho viewers yang selalu komen di 3 video. Selain
> **Sunyi Coffee**, ada yang bisa kasih tau siapa saja mereka? Dan apa
> komentarnya?

-----

#### *Text analysis* dari komentar *viewer*

Ini bagian paling seru. Bagaimana kita bisa melakukan *text analysis*
dari komentar-komentar *viewers*. Setidaknya ada empat analisa yang bisa
dilakukan:

1.  **Wordcloud**: Menghitung berapa banyak kata keluar dalam suatu data
    teks (*Word counting*).
2.  **Bi-Gram**: Melihat dua kata yang sering bermunculan bersamaan.
3.  **Word Association**: Melihat kumpulan dan hubungan kata-kata yang
    memiliki asosiasi tinggi.
4.  **Topic modellling**: mencari tahu kesamaan dari sekian banyak
    komentar itu dan dikelompokkan berdasarkan kesamaannya tersebut.
5.  **Sentiment Analysis**: Menganalisa sentimen dari masing-masing
    komentar *viewers*. Apakah positif atau negatif?

Oke, kita mulai dari yang paling gampang dulu yah.

-----

##### *Wordcloud*

Analisa ini sebenarnya sangat mudah. Hanya menghitung ada berapa banyak
kata yang keluar dalam suatu data teks. Sebelum mulai, kita akan lakukan
*preparation* terhadap data teksnya. Apa itu? Mengubah tulisannya jadi
*lowercase* biar mudah dianalisa.

Berhubung ini hanya untuk *fun* aja, saya akan *skip* bagian *word
stemming* dan *remove stopwords*.

> *Kindly Googling about those two terms yah in parts of text analytics*

*Yuk* kita lihat kata-kata apa saja yang sering muncul\!

Berikut adalah semua kata yang punya frekuensi minimal 5 yah:

    ## # A tibble: 70 x 2
    ##    words         n
    ##    <chr>     <int>
    ##  1 dan          22
    ##  2 ini          22
    ##  3 tropicana    18
    ##  4 banget       15
    ##  5 episode      15
    ##  6 sunyi        15
    ##  7 di           13
    ##  8 keren        13
    ##  9 teman        13
    ## 10 yg           13
    ## # … with 60 more rows

*Wordcloud*-nya seperti ini yah:

![alt
text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/sunyi%20wordcloud.png
"wordcloud")

> *Gimana, ada informasi yang bisa diambil dari wordcloud di atas?*

Ada yang mau *ngerjain* *wordcloud* per episodenya?

-----

##### *Bi-Gram*

Bi-gram adalah pasangan kata yang selalu muncul secara bersamaan dan
berurutan. Nah, kita akan lihat, apakah ada pasangan kata yang sering
muncul pada komentar *viewers*?

Berikut adalah grafik dari *bigrams* yang memiliki frekuensi kemunculan
lebih dari dua
(`>2`):

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-18-1.png "chart")

-----

##### *Word Association*

*Word association* itu sesimpel mencari kata yang berkorelasi dengan
kata lain. Bagaimana caranya? Kita gunakan *library* `NLP` dan `tm`.

Simpelnya adalah menghitung frekuensi masing-masing kata. Lalu korelasi
dihitung dengan seberapa sering dua kata muncul di *section* yang sama.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/asosiasi.png
"association")

Versi asli dari gambar tersebut, bisa di-zoom-in di link [berikut ini
yah](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/asosiasi.png).

Sekarang kita akan selidiki, kata mana saja yang erat asosiasinya dengan
kata:

1.  Tropicana
2.  Sunyi
3.  Tuli

##### *Word Association*: Tropicana

Sekarang kita selidiki kata mana saja yang berkorelasi dengan kata
**Tropicana**.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-20-1.png "chart")

##### *Word Association*: Sunyi

Sekarang kita selidiki kata mana saja yang berkorelasi dengan kata
**Sunyi**.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-21-1.png "chart")

##### *Word Association*: Tuli

Sekarang kita selidiki kata mana saja yang berkorelasi dengan kata
**Tuli**.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-22-1.png "chart")

-----

##### *Topic Modelling*

Sekarang kita akan lakukan *topic modelling* dari komen *viewers*.
Apakah bisa mesin menyimpulkan topik apa saja yang dibicarakan oleh
*viewers*?

Jika saya memilih `topic` = 3, maka didapatlah *keywords* sebagai
berikut:

    ##         term                                      
    ## Topic 1 "keren, episode, belajar, rizky, bikin"   
    ## Topic 2 "tropicana, slim, durasinya, menit, bikin"
    ## Topic 3 "dunia, tuli, teman, sunyi, like"

Jadi bisa disimpulkan bahwa topik yang dibicarakan *viewers* adalah
sebagai berikut:

1.  Berbicara mengenai tema disabilitas.
2.  Berbicara mengenai pujian terhadap web seriesnya.
3.  Berbicara mengenai
durasi.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Sunyi/2019-12-4-blog-posting-sunyi_files/figure-gfm/unnamed-chunk-24-1.png "chart")

*How?*

-----

##### *Sentiment Analysis*

*Nah*, untuk melakukan ini kita harus membuat *supervised learning
model*. Berhubung saya harus membuat *training dataset* dan belum sempat
membuatnya. Jadi untuk analisa ini sementara saya *skip* dulu yah.
