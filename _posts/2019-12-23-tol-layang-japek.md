---
date: 2019-12-23T15:39:00-04:00
title: "Melihat Antusiasme Warganet Mengenai Tol Japek Elevated"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Web Scraping
  - Google
  - Google Trends
  - R
author: mr.ikanx
---

Beberapa waktu yang lalu, Pak Presiden Jokowi [meresmikan tol layang
Jakarta Cikampek
elevated](https://www.liputan6.com/bisnis/read/4132366/jokowi-resmikan-tol-layang-jakarta-cikampek-siang-ini).
Pembangunan jalan layang yang berhasil membuat kemacetan parah selama
ini akhirnya selesai juga.

Menarik bagi saya untuk melihat antusiasme warganet terhadap jalan
layang ini.

Kali ini, saya tidak akan mengambil data dari **twitter** atau sosial
media lainnya. Saya akan mencari *keywords* apa yang ditelusuri warganet
di Google terkait dengan topik ini.

Untuk itu, saya akan menggunakan `library(gtrendsR)` di **R**. Topik
yang akan saya cari adalah semua topik yang berkaitan dengan dua
*keywords* utama, yakni:

1.  `tol jakarta cikampek`
2.  `japek`

Tak butuh waktu satu detik, saya sudah mendapatkan hasilnya pencarian
saya. Ada empat *dataset* yang saya terima, yakni:

1.  `interest_over_time`
2.  `interest_by_region`
3.  `interest_by_city`
4.  `related_queries`

Seperti biasa, mari kita bedah satu-persatu:

# `interest_over_time`

Apa saja sih isi dari *dataset* ini?

    ## 'data.frame':    520 obs. of  7 variables:
    ##  $ date    : POSIXct, format: "2014-12-28" "2015-01-04" ...
    ##  $ hits    : int  4 2 3 3 3 4 4 1 2 3 ...
    ##  $ geo     : chr  "ID" "ID" "ID" "ID" ...
    ##  $ time    : chr  "today+5-y" "today+5-y" "today+5-y" "today+5-y" ...
    ##  $ keyword : chr  "tol jakarta cikampek" "tol jakarta cikampek" "tol jakarta cikampek" "tol jakarta cikampek" ...
    ##  $ gprop   : chr  "web" "web" "web" "web" ...
    ##  $ category: int  0 0 0 0 0 0 0 0 0 0 ...

Inti dari *dataset* ini adalah *trend* pencarian dua *keywords* ini
perwaktu. Dengan mudahnya saya bisa membuat *lineplot* dari *dataset*
ini
sbb:

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Japek%20Elevated/2019-12-23-japek-elevated_files/figure-gfm/unnamed-chunk-3-1.png "chart")

Sepertinya penggunaan singkatan **japek** baru nge- *hype* akhir-akhir
ini yah.

Coba kalau saya rapikan kembali datanya. Saya akan gabungkan pencarian
kedua *keywords* ini lalu akan saya jadikan dalam level bulanan. Saya
penasaran, apakah ada pola *seasonal* dari pencarian ini.

> Siapa tahu pencarian mengenai jalan tol ini meningkat **hanya** di
> saat-saat tertentu saja. Misalkan: pada saat liburan lebaran atau
> natal.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Japek%20Elevated/2019-12-23-japek-elevated_files/figure-gfm/unnamed-chunk-4-1.png "chart")

Gimana? Sudah terlihat ada pola *seasonal*-nya? Oke, kalau saya ubah ke
bentuk grafik berikut ini
gimana:

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Japek%20Elevated/2019-12-23-japek-elevated_files/figure-gfm/unnamed-chunk-5-1.png "chart")

Dugaan saya, ada peningkatan pencarian di dekat-dekat musim liburan
lebaran.

> Dengan menggunakan prinsip dekomposisi data *time series*, saya akan
> coba melihat *pattern underlying the
data*.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Japek%20Elevated/2019-12-23-japek-elevated_files/figure-gfm/unnamed-chunk-6-1.png "chart")

Dilihat dari *trend* pencarian, ternyata meningkat *over time*.
Bagaimana dengan pola *seasonal*-nya? Mari kita *highlight* bagian
seasonal dari grafik di atas menjadi sebagai
berikut:

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Japek%20Elevated/2019-12-23-japek-elevated_files/figure-gfm/unnamed-chunk-7-1.png "chart")

> Ternyata ada pola kenaikan pencarian pada masa-masa liburan lebaran
> dan akhir tahun.

-----

# `interest_by_region`

Berikutnya kita akan membahas *dataset* `interest_by_region`. Apa saja
variabel yang ada di *dataset* tersebut?

``` r
str(data$interest_by_region)
```

    ## 'data.frame':    68 obs. of  5 variables:
    ##  $ location: chr  "West Java" "Banten" "Special Capital Region of Jakarta" "Central Java" ...
    ##  $ hits    : int  100 52 44 12 11 9 4 4 4 2 ...
    ##  $ keyword : chr  "tol jakarta cikampek" "tol jakarta cikampek" "tol jakarta cikampek" "tol jakarta cikampek" ...
    ##  $ geo     : chr  "ID" "ID" "ID" "ID" ...
    ##  $ gprop   : chr  "web" "web" "web" "web" ...

Ternyata *dataset* ini berisi nama *region* dan seberapa besar mereka
mencari kedua *keywords* **japek**
ini.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Japek%20Elevated/2019-12-23-japek-elevated_files/figure-gfm/unnamed-chunk-9-1.png "chart")

Ternyata tidak warganet yang mencari *keywords* ini tidak hanya berasal
dari *region* Jawa Barat dan DKI Jakarta saja. Tapi cukup menyebar di
Indonesia.

-----

# `interest_by_city`

Berikutnya kita akan membahas *dataset* `interest_by_city`. Apa saja
variabel yang ada di *dataset* tersebut?

``` r
str(data$interest_by_city)
```

    ## 'data.frame':    14 obs. of  5 variables:
    ##  $ location: chr  "Cikampek" "East Telukjambe" "Karawang" "Bekasi" ...
    ##  $ hits    : chr  "100" "56" "51" "37" ...
    ##  $ keyword : chr  "tol jakarta cikampek" "tol jakarta cikampek" "tol jakarta cikampek" "tol jakarta cikampek" ...
    ##  $ geo     : chr  "ID" "ID" "ID" "ID" ...
    ##  $ gprop   : chr  "web" "web" "web" "web" ...

Ternyata *dataset* ini berisi nama *city* dan seberapa besar mereka
mencari kedua *keywords* **japek** ini.

> Mirip dengan *dataset* sebelumnya
yah.

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Japek%20Elevated/2019-12-23-japek-elevated_files/figure-gfm/unnamed-chunk-11-1.png "chart")

> Ternyata warganet yang paling banyak mencari berasal dari Bekasi.

-----

# `related_queries`

Nah, pada *dataset* terakhir, kita lihat ada variabel apa saja yah:

``` r
str(data$related_queries)
```

    ## 'data.frame':    77 obs. of  6 variables:
    ##  $ subject        : chr  "100" "97" "96" "84" ...
    ##  $ related_queries: chr  "top" "top" "top" "top" ...
    ##  $ value          : chr  "jalan tol cikampek jakarta" "jalan tol" "jalan tol cikampek" "info tol jakarta cikampek" ...
    ##  $ geo            : chr  "ID" "ID" "ID" "ID" ...
    ##  $ keyword        : chr  "tol jakarta cikampek" "tol jakarta cikampek" "tol jakarta cikampek" "tol jakarta cikampek" ...
    ##  $ category       : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  - attr(*, "reshapeLong")=List of 4
    ##   ..$ varying:List of 1
    ##   .. ..$ value: chr "top"
    ##   .. ..- attr(*, "v.names")= chr "value"
    ##   .. ..- attr(*, "times")= chr "top"
    ##   ..$ v.names: chr "value"
    ##   ..$ idvar  : chr "id"
    ##   ..$ timevar: chr "related_queries"

Kita akan lakukan *simple text analysis* dari data *related\_query* ini
yah.

## Wordcloud

![alt
text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Japek%20Elevated/wordcloud%20japek.png
"japek")

Ada yang bisa disimpulkan dari data *related queries* ini?
