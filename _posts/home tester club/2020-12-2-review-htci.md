---
date: 2020-12-2T17:09:00-04:00
title: "Mengumpulkan Review Konsumen Tidak Pernah Semudah Ini"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Web Scrape
  - Home Tester
  - Market Research
  - Konsumen
  - Review Konsumen
  - Research
  - RVest
  - Tutorial
---

Di dunia *market research*, data terkait konsumen bisa dibagi menjadi
dua:

1.  Data persepsi.
2.  Data habit.

-----

## Data Persepsi

Persepsi (dari bahasa Latin: *perceptio* atau *percipio*) adalah
tindakan menyusun, mengenali, dan menafsirkan informasi sensoris guna
memberikan gambaran dan pemahaman tentang lingkungan.

Data persepsi merupakan data yang berasal dari pemahaman, ide, atau
pendapat pribadi dari konsumen.

Untuk mendapatkan data ini, cara terbaik yang bisa dilakukan adalah
dengan cara survey (DITANYAKAN langsung kepada responden).

-----

## Data Habit

Habit atau kebiasaan adalah suatu hal yang lazim, umum, dan yang biasa
dilakukan. Menurut Peter Cape (2013):

> *When you ask people randomly throughout the day what they are doing
> (behavior), 30% of the time there will be a mismatch between what they
> are doing and what they are thinking about.*

Oleh karena itu, cara terbaik untuk mendapatkan data ini adalah dengan
memanfaatkan sumber data lain seperti jejak digital, data transaksi, dan
lainnya.

Data seperti ini sebaiknya tidak ditanyakan langsung. Jika terpaksa
ditanyakan langsung, sebaiknya ada metode untuk melakukan validasi atas
jawaban tersebut.

-----

Sebagai *market researcher*, saya tahu betul bagaimana sulitnya mencari
data persepsi. Berdasarkan pengalaman saya selama ini, saya sangat
percaya bahwa metode seperti *face-to-face* interview adalah cara
terbaik untuk mendapatkan data persepsi konsumen. Namun biasanya ada
tiga hal yang membuat F2F interview menjadi sulit dilakukan:

1.  Waktu yang mepet.
2.  Biaya yang terbatas.
3.  Kekurangan tenaga (*man power*).

Di zaman transformasi digital seperti sekarang ini, kadang kita hanya
butuh duduk sejenak dan mencari apa yang kita mau di internet. Sama
seperti mencari data persepsi konsumen.

> Jika dulu saya harus mencari konsumen untuk dijadikan responden. Kini
> responden sendiri yang **“datang”** memberikan data persepsinya.

*Lho, gimana maksudnya?*

-----

Beberapa waktu lalu, seorang rekan kerja saya menginformasikan mengenai
keberadaan situs yang menampung *review* konsumen bernama [*Home Tester
Club Indonesia*](https://www.hometesterclub.com/id/id/).

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/blog-post_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

-----

## Situs Home Tester Club Indonesia

Berdasarkan informasi di situsnya:

> *Home Tester Club* adalah komunitas para pembeli yang menguji dan
> membagikan *review* produk untuk membantu pembeli lainnya berbelanja
> lebih baik. *Home Tester Club* adalah rumahnya ribuan *review* produk.
> Dengan bergabung di sini kamu akan mendapat kesempatan menguji coba
> produk gratis dan produknya akan diantar langsung ke rumah kamu.

Namun demikian, tidak semua *member* mendapatkan produk gratis untuk
diuji. Beberapa *member* masih bisa memberikan *review* berdasarkan
pengalaman pribadi mereka menggunakan produk yang mereka beli dengan
uang pribadi.

Jika kita asumsikan semua *member* memberikan *review* yang jujur, maka
data *review* ini sangat kaya akan informasi.

-----

## Bagaimana cara saya mengeksplorasi data ini?

Sebelum berbicara lebih jauh mengenai cara saya mengeksplorasi,
pertanyaan paling mendasar yang harus saya jawab adalah:

> **Bagaimana cara saya mengambil semua data yang ada di situs
> tersebut?**

Pertanyaan di atas adalah pertanyaan **paling standar** yang biasa
dihadapi oleh semua orang di zaman sekarang. *hehe*

-----

## *Webscraping* **Home Tester Club**

Seperti biasa, saya menggunakan **R** untuk membuat beberapa baris
algoritma yang bertugas untuk mendapatkan data yang saya mau.

Dari situs tersebut, ada beberapa data yang bisa saya ambil, yakni:

1.  Nama produk.
2.  Deskripsi produk.
3.  *Rating* produk.
4.  Berapa banyak *reviewers*.
5.  Isi komentar atau *review*.

Berikut adalah *functions* algoritma yang saya buat:

``` r
scrape_func = function(url){
  data = read_html(url) %>% {tibble(
      merek = html_nodes(.,"#htc-breadcrumb .active") %>% html_text(),
      rate = html_nodes(.,".pp-ratereview-counter li") %>% html_text() %>% paste(collapse = " "),
      deskripsi = (html_nodes(.,".text-left") %>% html_text())[[1]]
  )}
  return(data)
}
```

Cukup gunakan *function* tersebut ke *links* masing-masing produk di
situs tersebut.

Sebagai *showcase*, saya akan mengambil `384` produk yang ada di
kategori [**Dapur
Makanan**](https://www.hometesterclub.com/id/id/reviews/category-food-pantry).
*Links* `384` produk itu tersedia di
[sini](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Home%20Tester%20Club/Scraping%20Bahan/links.txt).

Data saya *scrape* pada tanggal `1 Desember 2020 pukul 14∶34∶57 WIB`.

-----

## *Showcase*: Semua Produk di Kategori **Dapur Makanan**

Setelah saya bersihkan data hasil *scrape*, saya dapatkan data berupa
tabel seperti di bawah ini:

    ## [1] "Contoh 10 data teratas hasil scrape"

    ## # A tibble: 10 x 4
    ##    merek               rate_no review_no deskripsi                              
    ##    <chr>                 <dbl>     <dbl> <chr>                                  
    ##  1 Bango Bumbu Kuline…     4.8        61 "Sajikan berbagai #KelezatanAsli daera…
    ##  2 Oreo Dutch Cocoa W…     4.8      1555 ""                                     
    ##  3 JAWARA Cabai Tabur…     4.6      1332 ""                                     
    ##  4 JAWARA Cabai Tabur…     4.6      1272 ""                                     
    ##  5 Mayumi                  4.8      1119 "Saus creamy serbaguna yang terbuat da…
    ##  6 Royco Kaldu Jamur       4.7      1314 ""                                     
    ##  7 Roti Tawar Funwari…     4.8       920 "Roti tawar yang dibuat dengan menggun…
    ##  8 Koko Krunch dengan…     4.9      4904 "Sereal sarapan dengan gandum utuh ras…
    ##  9 Serasa Food Bumbu …     4.7       205 "Bumbu berkualitas tinggi, menggunakan…
    ## 10 Finna Bumbu Masak …     4.6       228 "bumbu Tom Yum yang terbuat dari bahan…

Mari kita cek beberapa analisa sederhana berikut ini:

-----

### *Top Reviewed Product*

Dari `384` produk yang ada di kategori **dapur makanan**, ada beberapa
produk yang paling banyak di-*review* oleh *member*. Mari kita lihat
**Top 20** produk yang paling banyak di-*review*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/blog-post_files/figure-gfm/unnamed-chunk-4-1.png" width="672" />

Sekarang kebalikannya, kita cek 20 produk terbawah yang paling sedikit
di-*review* oleh *member*:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/blog-post_files/figure-gfm/unnamed-chunk-5-1.png" width="672" />

### Sebaran Banyaknya *Reviews*

Kalau kita lihat sebaran data banyaknya *reviews*, saya dapatkan
informasi berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/blog-post_files/figure-gfm/unnamed-chunk-6-1.png" width="672" />

Dari graifk sebaran di atas, kita bisa melihat ada ketidakmerataan
banyaknya *reviews* yang diberikan oleh *member*. Sebagian kecil produk
mendapatkan lebih dari `1000` *reviews*. Mayoritas dari produk
mendapatkan *reviews* sebanyak 128.5 (nilai tengah - median - dari data
*review*).

Kita bisa melihat bahwa beberapa produk Nutrifood mendapatkan *reviews*
di kisaran angka tersebut kecuali produk **Tropicana Slim Beras Merah**
yang mendapatkan *reviews* yang cukup banyak sehingga masuk **Top 20
Reviewed Products**.

### *Top Rating Product*

*Member* bisa memberikan *rating* kepada produk yang pernah
dikonsumsinya menggunakan skala `1-5`. Produk apa saja yang mendapatkan
*rating* terbaik?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/blog-post_files/figure-gfm/unnamed-chunk-7-1.png" width="672" />
Mungkin kalian bertanya-tanya, kenapa `59` produk yang ditampilkan?

Karena produk urutan ke `60` memiliki nilai yang sama dengan produk
urutan ke `61` sampai produk urutan ke `116`.

### Sebaran *Rating* Produk

Mari kita lihat bersama bagaimana sebaran dari *rating* yang diberikan
oleh *member*:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/blog-post_files/figure-gfm/unnamed-chunk-8-1.png" width="672" />

Ternyata mayoritas produk memiliki rating yang baik (diatas skala `4`).
Hanya sebagian kecil produk saja yang memiliki rating dibawah `3.5`.

Penasaran produk apa saja yang mendapatkan nilai rendah di antara
produk-produk yang bergelimang rating bagus?

    ## [1] "Produk yang memiliki rating di bawah 3.5"

    ## # A tibble: 6 x 3
    ##   merek                           rate_no review_no
    ##   <chr>                             <dbl>     <dbl>
    ## 1 Bee Huat Crisp Chocolate            3.4       111
    ## 2 Biskotto Maxi Class                 3.3        76
    ## 3 Indomie Bite Mie                    3.3       233
    ## 4 Snek Ku ShoyueMi Rasa Pedas         3          71
    ## 5 Chocomory Mini Choco Bar Cashew     2.5         3
    ## 6 Gado Telur Siap Saji                0           0

Hanya ada `6` produk yang memiliki rating di bawah `3.5`. *Special
cases* ada pada **Chocomory** dan **Gado Telur**:

  - Hanya ada `3` *member* saja yang memberikan *rating* dan *review*
    pada produk **Chocomory**.
  - Belum ada *member* yang memberikan *rating* dan *review* pada produk
    **Gado Telur Siap Saji**.

-----

# *What’s Next?*

## Beberapa Produk yang Ada di Kategori **Dapur Makanan**

Ternyata setelah saya lihat dengan seksama, ada beberapa pasang produk
dan kompetitornya yang ada di sana. Menarik jika kita lakukan analisa
*head-to-head* dari pasangan produk tersebut.

Apa saja analisanya?

> Tentunya analisa terkait dengan data komentar *member* yang berupa
> *free text*.

Hal yang bisa dilakukan:

1.  *Wordcloud*,
2.  *Bigrams*,
3.  *Topic modelling*
4.  *Crosswords*
5.  *Log odds ratio*

Nah, ada satu hal baru yang ingin saya lakukan (karena dari dulu belum
sempat mengerjakannya). Apa itu? *Sentiment analysis*.

Doakan semoga yang terakhir ini bisa dilakukan dengan baik *yah*.

Sekian dulu tulisan ini, hasil analisa komentar akan saya tulis di
tulisan berikutnya.
