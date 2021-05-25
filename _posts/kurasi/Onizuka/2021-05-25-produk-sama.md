---
date: 2021-05-25T11:30:00-04:00
title: "Mengukur Kesamaan Produk yang Dijual dari Dua Online Stores"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - NLP
  - Language Modelling
  - Cosine Simlarity
  - Summarization
  - Extraction Based
  - Text Analysis
  - Log Odds Ration
  - Crosswords Analysis
---

Beberapa waktu yang lalu, saya iseng-iseng melihat dua *official stores*
dari perusahaan yang sama (sebut saja perusahaan **X**). Satu *official
store* ada di Tokopedia, sedangkan satu lagi ada di Shopee.

Ketika *skimming* singkat, saya jadi penasaran:

> Apakah ada perbedaan **listed products** antara dua **official
> stores** tersebut?

Bagaimana cara saya melihatnya?

------------------------------------------------------------------------

Singkat cerita, saya berhasil *scrape* **semua nama** ***listed
products*** dari dua *official stores* tersebut. Saya dapatkan data
banyaknya *listed products* berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/kurasi/Onizuka/post_files/figure-gfm/unnamed-chunk-1-1.png" width="672" style="display: block; margin: auto;" />

Saya lihat sekilas ternyata perusahaan tersebut lebih banyak *listing*
produknya di Shopee dibandingkan di Tokopedia.

> Karena produknya banyak, saya tidak mungkin membandingkannya satu
> persatu.

Jadi, bagaimana cara saya membandingkan dengan cepat dan (lumayan)
tepat?

Setidaknya ada dua cara yang terpikir oleh saya.

1.  Menggunakan *crosswords analysis* dan *log odds ratio* seperti yang
    pernah saya *post* di
    [sini](https://ikanx101.com/blog/artikel-HBR/).
2.  Menggunakan *cosine similarity* seperti yang pernah saya *post* di
    [sini](https://ikanx101.com/blog/phone-book/).

------------------------------------------------------------------------

## Metode Pertama

### *Crosswords Analysis*

Metode ini sangat mudah dilakukan. Saya cukup menghitung berapa banyak
kata yang muncul per *listed products* dari kedua *official stores*
tersebut dan membandingkan frekuensinya dalam *scatter plot*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/kurasi/Onizuka/post_files/figure-gfm/unnamed-chunk-2-1.png" width="672" style="display: block; margin: auto;" />

Terlihat sekilas bahwa sangat sedikit sekali kata-kata yang hanya
*unique* terdapat di salah satu *official store*. Untuk membuktikannya,
saya akan hitung *log odds ratio*-nya.

### *Log Odds Ratio*

Rumus untuk menghitung *ratio* adalah sebagai berikut:

logratio = ln(freq kelompok1 / freq kelompok2)

Angka tersebut akan menunjukkan kata mana yang *less or most likely come
from each group*. Jika nilai *l**o**g**r**a**t**i**o* = 0 artinya kata
tersebut dipakai oleh kedua *official stores* dengan frekuensi yang
sama. Selain itu, maka kata-kata lebih sering dipakai di salah satu
*official store* saja.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/kurasi/Onizuka/post_files/figure-gfm/unnamed-chunk-3-1.png" width="672" style="display: block; margin: auto;" />

Beberapa *highlights* yang bisa diambil:

-   Shopee: Sambal cabai, masker wajah, pelembab, *bodyspray*, oatmeal,
    antiseptik, penyegar dan pelembab.
-   Tokopedia: Pemutih (*bleach*), *handwash*, *disinfectant*, pomade,
    dan **St. Ives**.

## Metode Kedua

### *Cosine Similarity*

Ketika saya melihat kembali tulisan *listed product* yang ada, saya
menemukan beberapa produk sebenarnya sama tapi ditulis dengan cara
berbeda.

Ilustrasi:

-   Produk 1: **Kecap Manis Jerigen 10l**.
-   Produk 2: **Kecap Manis Jerigen 10l Free Piring Cantik Selusin**.

Sejatinya kedua produk tersebut adalah produk yang sama hanya ada
penambahan *gimmick* atau bonus.

Untuk mengakomodir kasus seperti di atas yang bisa saja terjadi untuk
ratusan *listed products*, kita akan gunakan metode analisa [*cosine
similarity*](https://ikanx101.com/blog/phone-book/).

Ilustrasi:

Misalkan saya memiliki 4 *listed products* di bawah ini:

-   Produk 1: **Kecap Manis Jerigen 10l**.
-   Produk 2: **Kecap Manis Jerigen 10l Free Piring Cantik Selusin**.
-   Produk 3: **Kecap Asin Pouch 5.2Kg**.
-   Produk 4: **Kecap Asin Pouch 5.2Kg - 3 Pouch**.

Kita hendak memasangkan dua *listed products* yang mirip. Maka kita bisa
menghitung skor *similarity* sebagai berikut:

| entry 1 | entry 2 | score |
|:--------:|:--------:|:-----:|
|    3     |    4     | 0.954 |
|    1     |    2     | 0.949 |

    ## Pasangan produk  1  dengan score similarity:  0.954 
    ## Produk ke:  3  ~  Kecap Asin Pouch 5.2Kg 
    ## Produk ke:  4  ~  Kecap Asin Pouch 5.2Kg - 3 Pouch 
    ## 
    ## Pasangan produk  2  dengan score similarity:  0.949 
    ## Produk ke:  1  ~  Kecap Manis Jerigen 10l 
    ## Produk ke:  2  ~  Kecap Manis Jerigen 10l Free Piring Cantik Selusin

Dengan prinsip di atas, menggunakan *threshold* indeks *similarity*
sebesar `0.8` kita akan hitung ada berapa banyak produk yang sama di
kedua *official stores* tersebut.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/kurasi/Onizuka/post_files/figure-gfm/unnamed-chunk-5-1.png" width="672" style="display: block; margin: auto;" />

Ternyata dari *cosine similarity* saya mendapatkan bahwa lebih dari
separuh produk hanya *unique* dimiliki oleh masing-masing *official
store*.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
