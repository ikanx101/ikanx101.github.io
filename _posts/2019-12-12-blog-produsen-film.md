---
date: 2019-12-12T14:25:00-04:00
title: "Movie Production Companies: a Clustering Story"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - Hollywood
  - Movies
  - Clustering Analysis
---

Dalam beberapa waktu ini, saya sedang sering melihat data terkait film
yang dihimpun di situs
[**the-numbers**](https://www.the-numbers.com/movies/production-companies/).

> **“Sepertinya ada beberapa topik yang bisa dijadikan tulisan di
> blog”**, Pikir saya.

Melanjutkan _posting_ saya terkait [Hollywood kemarin](https://ikanx101.github.io/blog/blog-film-amerika/), ternyata dari sekian banyak film _production_companies_ di dunia, hanya segelintir saja yang mendominasi.

# Data **Movie Production Companies**

Dari *web* tersebut, kita mendapatkan data `12.891` *movie production
companies* yang tersebar di seluruh dunia. Mulai dari perusahaan film
yang besar dan terkenal sampai perusahaan film “kecil” yang hanya
memproduksi satu film saja.

``` r
head(data,10)
```

    ##    production_companies no_of_movies total_domestic_box_office
    ## 1          Warner Bros.          231           $18,453,647,421
    ## 2     Columbia Pictures          223           $17,371,001,173
    ## 3    Universal Pictures          228           $17,049,084,761
    ## 4  Walt Disney Pictures          124           $15,230,973,162
    ## 5        Marvel Studios           59           $12,978,459,542
    ## 6    Paramount Pictures          132           $11,808,196,121
    ## 7      20th Century Fox          104            $9,873,807,280
    ## 8      Relativity Media          115            $7,234,385,696
    ## 9   DreamWorks Pictures           82            $6,682,910,223
    ## 10   Dune Entertainment           70            $6,307,177,998
    ##    total_worldwide_box_office
    ## 1             $43,048,125,888
    ## 2             $39,302,081,581
    ## 3             $41,373,043,036
    ## 4             $37,187,782,141
    ## 5             $33,725,086,281
    ## 6             $28,251,464,054
    ## 7             $24,814,189,534
    ## 8             $15,131,894,432
    ## 9             $13,335,520,162
    ## 10            $16,471,533,740

``` r
str(data)
```

    ## 'data.frame':    12891 obs. of  4 variables:
    ##  $ production_companies      : chr  "Warner Bros." "Columbia Pictures" "Universal Pictures" "Walt Disney Pictures" ...
    ##  $ no_of_movies              : int  231 223 228 124 59 132 104 115 82 70 ...
    ##  $ total_domestic_box_office : chr  "$18,453,647,421" "$17,371,001,173" "$17,049,084,761" "$15,230,973,162" ...
    ##  $ total_worldwide_box_office: chr  "$43,048,125,888" "$39,302,081,581" "$41,373,043,036" "$37,187,782,141" ...

Variabel yang didapatkan antara lain:

1.  `production_companies`: nama perusahaan produsen film.
2.  `no_of_movies`: banyaknya film yang diproduksi.
3.  `total_domestic_box_office`: pendapatan film di pasar domestik.
4.  `total_worldwide_box_office`: pendapatan film total *worldwide*.

Sekarang, saya hanya akan memilih perusahaan yang minimal telah
memproduksi 30 film lalu saya buat *scatter plot* dari data tersebut.
Didapat hanya `113` buah perusahaan. Sumbu `x` akan saya isi dengan
`no_of_movies` dan sumbu `y` akan saya isi dengan
`total_worldwide_box_office`, sementara *size* dari *point* tergantung
dari besarnya
`total_domestic_box_office`.

## *Scatter plot* dari data

![alt text](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2019-12-10-blog-produsen-film_files/figure-gfm/unnamed-chunk-4-1.png "chart")

*Gimana?* sudah terlihat `production_companies` favorit kamu?

> *Btw menarik yah*, **Marvel Studios** dengan jumlah film lebih sedikit
> sudah melewati capaian 20th **Century Fox** dan **Paramount
> Pictures**.

-----

## *Clustering Analysis* dari data

Sekarang kita akan mencoba mengelompokkan `production_companies` dari
data-data yang ada. Saya akan menggunakan algoritma **k-means
clustering**.

> Contoh lain penggunaan k-means clustering sudah pernah saya tulis di
> [blog saya yang
> lama](https://passingthroughresearcher.wordpress.com/2019/11/24/clustering-negara-berdasarkan-gdp-happiness-index-dan-populasi/).

Agar memudahkan, angka real dari masing-masing variabel `no_of_movies`,
`total_domestic_box_office`, dan `total_worldwide_box_office` akan saya
buat dalam rentang 1-10 dengan fungsi `cut()` di **R**.

## Penentuan berapa banyak *cluster*

Seperti biasa, pada analisa *k-means clustering* langkah paling krusial
adalah menentukan berapa banyak *cluster* yang harus dibuat. Untuk
menentukannya, kita bisa menggunakan tiga metode:

1.  *Elbow method*
2.  *Silhoutte method*
3.  *Gap Stat method*

Dengan alasan kemudahan untuk melihat hasil, dari tiga metode tersebut
saya akan gunakan *elbow method*
yah.

![alt text](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2019-12-10-blog-produsen-film_files/figure-gfm/unnamed-chunk-5-1.png "chart")

Nah, salah satu *kelemahan elbow method* adalah penentuan banyaknya
*clusters* bisa jadi subjektif tergantung *visual* masing-masing orang.

> *Trus kalau gtu kenapa gak pakai: silhoutte method atau gap stat
> method saja yang lebih jelas dalam menentukan banyaknya cluster?*

Seperti biasa, hal tersebut sengaja dilakukan sebagai latihan buat
kalian yang membaca tulisan ini yah *guys*.

Kali ini saya akan memilih banyaknya *cluster* `k
    = 5`.

-----

## *5-means clustering*

    ##   no_of_movies total_domestic_box_office total_worldwide_box_office
    ## 1         1.83                      2.42                       2.42
    ## 2         2.75                      4.50                       4.75
    ## 3         6.00                      6.00                       6.00
    ## 4         3.86                      1.29                       1.29
    ## 5         1.10                      1.00                       1.02

Kita bisa melihat karakteristik dari masing-masing *cluster*-nya sebagai
berikut:

1.  Cluster 1: `production_companies` yang tidak banyak membuat film
    tapi pendapatan lokal dan *worldwide*-nya biasa saja.
2.  Cluster 2: `production_companies` yang lumayan membuat film (tapi
    tidak bisa dibilang banyak) tapi pendapatan lokal dan
    *worldwide*-nya termasuk tinggi.
3.  Cluster 3: `production_companies` yang bisa dibilang *“they are the
    kings”*. Tinggi di semua aspek.
4.  Cluster 4: `production_companies` yang lumayan banyak membuat film
    tapi memiliki pendapatan lokal dan *worldwide* yang kecil.
5.  Cluster 5: `production_companies` yang kecil di semua
aspek.

![alt text](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2019-12-10-blog-produsen-film_files/figure-gfm/unnamed-chunk-7-1.png "chart")

### Kita liat `production_companies` mana saja di masing-masing cluster yah

#### Cluster 1

    ##            production_companies
    ## 1              Relativity Media
    ## 2           DreamWorks Pictures
    ## 3            Dune Entertainment
    ## 4            Legendary Pictures
    ## 5               New Line Cinema
    ## 6          Amblin Entertainment
    ## 7          DreamWorks Animation
    ## 8  Village Roadshow Productions
    ## 9  Metro-Goldwyn-Mayer Pictures
    ## 10          Touchstone Pictures
    ## 11         RatPac Entertainment
    ## 12         Summit Entertainment

#### Cluster 2

    ##   production_companies
    ## 1 Walt Disney Pictures
    ## 2       Marvel Studios
    ## 3   Paramount Pictures
    ## 4     20th Century Fox

#### Cluster 3

    ##   production_companies
    ## 1         Warner Bros.
    ## 2    Columbia Pictures
    ## 3   Universal Pictures

#### Cluster 4

    ##   production_companies
    ## 1  Regency Enterprises
    ## 2            Lionsgate
    ## 3            Blumhouse
    ## 4           Canal Plus
    ## 5          StudioCanal
    ## 6            BBC Films
    ## 7                  BFI

#### Cluster 5 (yang terbanyak)

    ##              production_companies
    ## 1         di Bonaventura Pictures
    ## 2               Fox 2000 Pictures
    ## 3           Imagine Entertainment
    ## 4               TSG Entertainment
    ## 5    The Kennedy/Marshall Company
    ## 6                   Original Film
    ## 7             Working Title Films
    ## 8                   Happy Madison
    ## 9          Spyglass Entertainment
    ## 10          Twentieth Century Fox
    ## 11         Perfect World Pictures
    ## 12        Scott Rudin Productions
    ## 13      Temple Hill Entertainment
    ## 14                Silver Pictures
    ## 15                    New Regency
    ## 16              Tri-Star Pictures
    ## 17      Castle Rock Entertainment
    ## 18             Revolution Studios
    ## 19                   Walden Media
    ## 20                    Screen Gems
    ## 21               Scott Free Films
    ## 22                Ingenious Media
    ## 23              Participant Media
    ## 24            Davis Entertainment
    ## 25       Fox Searchlight Pictures
    ## 26                 Focus Features
    ## 27              Weinstein Company
    ## 28           Plan B Entertainment
    ## 29        Lakeshore Entertainment
    ## 30          21 Laps Entertainment
    ## 31               Millennium Films
    ## 32              Gold Circle Films
    ## 33                     EuropaCorp
    ## 34             Annapurna Pictures
    ## 35                  Miramax Films
    ## 36                   Tribeca Film
    ## 37       FilmNation Entertainment
    ## 38                UK Film Council
    ## 39              Entertainment One
    ## 40                      Cine Plus
    ## 41              Anonymous Content
    ## 42           TF1 Film Productions
    ## 43                      IM Global
    ## 44                          Film4
    ## 45                          Pathe
    ## 46           Samuel Goldwyn Films
    ## 47                            A24
    ## 48                     Wild Bunch
    ## 49                         Film 4
    ## 50                 Amazon Studios
    ## 51                 Orion Pictures
    ## 52              The Fyzz Facility
    ## 53               Voltage Pictures
    ## 54                      Automatik
    ## 55               Irish Film Board
    ## 56                   HanWay Films
    ## 57                        Gaumont
    ## 58               Screen Australia
    ## 59                France 3 Cinema
    ## 60                     Cinecinema
    ## 61                Telefilm Canada
    ## 62                Head Gear Films
    ## 63       Bord Scannan na hEireann
    ## 64                France 2 Cinema
    ## 65                   Bron Studios
    ## 66            Lipsync Productions
    ## 67              France Television
    ## 68             Arte France Cinema
    ## 69                      XYZ Films
    ## 70                    Film i Vast
    ## 71              Creative Scotland
    ## 72              Metrol Technology
    ## 73              Magnolia Pictures
    ## 74                     RAI Cinema
    ## 75                           Arte
    ## 76                            CNC
    ## 77                    ARTE France
    ## 78                      IFC Films
    ## 79                            ZDF
    ## 80                      Eurimages
    ## 81               Passion Pictures
    ## 82                    Saban Films
    ## 83                    The Orchard
    ## 84                        Netflix
    ## 85 Grindstone Entertainment Group
    ## 86                   IFC Midnight
    ## 87           The Hallmark Channel

### Yuk kita plot kembali ke dalam *scatter plot*

![alt text](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2019-12-10-blog-produsen-film_files/figure-gfm/unnamed-chunk-13-1.png "chart")

# *Any comments?*
