---
date: 2020-1-9T5:30:00-04:00
title: "Data Carpentry: Harga Sedan Bekas di Carmudi"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Web Scrap
  - R
  - Unstructured Data
  - Semi structured data
  - Data Carpentry
---

# Pendahuluan

Salah satu keunggulan **R** dibandingkan dengan *analytics tools*
lainnya adalah kemampuannya untuk memanipulasi data. **Manipulasi**
dalam artian positif, yakni *preprocessing data* atau *data carpentry*.

Di dunia ini, tanpa kita sadari data tersebar sangat banyak. Namun tidak
semuanya berbentuk *structured data*. Sebagian besar sebenarnya masuk ke
dalam *unstructured data* atau *semi structured data*.

Seringkali kita enggan berhadapan dengan *unstructured data* atau *semi
structured data*. Nah, kali ini kita akan mencoba untuk mengolah
*unstructured data* menjadi informasi atau *insight(s)*.

# *Libraries* yang Digunakan

Berikut adalah beberapa *libraries* yang digunakan dalam *training* kali
ini:

1.  `rvest`: *web scraping*.
2.  `dplyr`: *data carpentry*.
3.  `tidytext`: *text data carpentry*.
4.  `tidyr`: *data carpentry* (*advance*).
5.  `ggplot2`: visualisasi data.

<!-- end list -->

``` r
library(dplyr)
library(rvest)
library(tidytext)
library(tidyr)
library(ggplot2)
```

# Data yang Digunakan

Kita akan *scrap* data situs
[carmudi](https://www.carmudi.co.id/cars/saloon/condition:all/) tentang
*listing* mobil sedan bekas.

Kalau kita lihat situsnya, ada 71 *pages*. Kita akan *scrap* semua
informasinya.

## Langkah pertama

Kita akan *define* semua *urls* dari carmudi lalu kita buat fungsi *web
scrap*-nya.

> Oh iya, tentang *web scraping* akan saya bahas di *training* atau
> tulisan terpisah yah. Kali ini rekan-rekan terima jadi aja fungsinya
> seperti ini.

``` r
#link dari carmudi
url = paste('https://www.carmudi.co.id/cars/saloon/condition:all/?page=',
            c(1:71),
            sep='')

#Bikin fungsi scrap carmudi
scrap = function(url){
  data = 
    read_html(url) %>% {
      tibble(
        nama = html_nodes(.,'.title-blue') %>% html_text(),
        harga = html_nodes(.,'.price a') %>% html_text(),
        lokasi = html_nodes(.,'.catalog-listing-item-location span') %>%
          html_text()
      )
    }
  return(data)
}
```

## Langkah kedua

Saya *scrap* datanya dari *url* pertama hingga selesai. Saya masih
senang menggunakan *looping* dibandingkan menggunakan fungsi `lapply()`.
Sepertinya lebih *firm* saja menurut saya.

``` r
#kita mulai scrap datanya
i = 1
sedan.data = scrap(url[i])

for(i in 2:length(url)){
  temp = scrap(url[i])
  sedan.data = rbind(sedan.data,temp)
}
str(sedan.data)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    2111 obs. of  3 variables:
    ##  $ nama  : chr  "\n2000 Toyota Corolla SE.G " "\n2013 Mercedes-Benz E300 AMG " "\n2016 Honda City Ivtec " "\n2014 Honda Civic 1.8 Ivtec " ...
    ##  $ harga : chr  "60 Juta" "430 Juta" "195 Juta" "185 Juta" ...
    ##  $ lokasi: chr  "\nKabupaten Sidoarjo " "\nJakarta Utara " "\nKota Jakarta Selatan " "\nKota Jakarta Selatan " ...

``` r
head(sedan.data,15)
```

    ## # A tibble: 15 x 3
    ##    nama                                      harga    lokasi               
    ##    <chr>                                     <chr>    <chr>                
    ##  1 "\n2000 Toyota Corolla SE.G "             60 Juta  "\nKabupaten Sidoarj…
    ##  2 "\n2013 Mercedes-Benz E300 AMG "          430 Juta "\nJakarta Utara "   
    ##  3 "\n2016 Honda City Ivtec "                195 Juta "\nKota Jakarta Sela…
    ##  4 "\n2014 Honda Civic 1.8 Ivtec "           185 Juta "\nKota Jakarta Sela…
    ##  5 "\n2008 Suzuki Baleno Matic "             100 Juta "\nMalang "          
    ##  6 "\n2008 Toyota Corolla Altis 1.8 VVTI Al… 92.5 Ju… "\nDKI Jakarta "     
    ##  7 "\n2010 Honda Accord 2.4 VTIL "           129 Juta "\nJakarta Barat "   
    ##  8 "\n2014 Toyota Camry 2.5 V AT "           189 Juta "\nJakarta Barat "   
    ##  9 "\n2014 Toyota Vios G Allnew A/T "        129 Juta "\nDKI Jakarta "     
    ## 10 "\n2016 BMW 320i Sport LCi Black On Blac… 565 Juta "\nJakarta Selatan " 
    ## 11 "\n2017 Mercedes-Benz E250 Avantgarde Re… 975 Juta "\nJakarta Selatan " 
    ## 12 "\n2018 Mercedes-Benz E200 Avantgarde Ni… 975 Juta "\nJakarta Selatan " 
    ## 13 "\n2018 BMW 520i Luxury Reg.2019 Black O… 895 Juta "\nJakarta Selatan " 
    ## 14 "\n2007 Honda Civic "                     110 Juta "\nJakarta Utara "   
    ## 15 "\n2010 Audi A4 TFSI 1.8L AT "            149 Juta "\nJakarta Barat "

## Hasil scrap data

Didapatkan ada `2104` baris data mobil sedan bekas yang di- *listing* di
**carmudi**.

Kalau kita lihat sekilas, data tersebut seolah-olah *structured*. Namun
kalau diperhatikan secara seksama, sebenarnya data tersebut
*semi-structured*. Variabel `harga` berupa *character* karena tulisan
juta. Sedangkan variabel `nama` masih campur aduk adanya tahun produksi
dan varian mobil.

*So*, kita memiliki tiga masalah, yakni:

1.  Bagaimana mengubah `harga` menjadi numerik agar bisa dianalisa?
2.  Bagaimana mengekstrak `tahun` dari variabel `nama`.
3.  Mungkinkah bagi kita menganalisa per `brand`?

## Proses Data *Carpentry*

### Membereskan variabel `harga`

Kita mulai dari membereskan variabel yang paling gampang, yakni
`harga`.

``` r
sedan.data = sedan.data %>% separate(harga,into=c('angka','unit'),sep=' ')

unique(sedan.data$unit)
```

    ## [1] "Juta"   "Milyar"

``` r
sedan.data = 
sedan.data %>% mutate(angka = as.numeric(angka),
                      unit = ifelse(unit == 'Juta',1000000,1000000000),
                      unit = as.numeric(unit),
                      harga = angka*unit,
                      angka = NULL,
                      unit = NULL)

head(sedan.data,15)
```

    ## # A tibble: 15 x 3
    ##    nama                                      lokasi                   harga
    ##    <chr>                                     <chr>                    <dbl>
    ##  1 "\n2000 Toyota Corolla SE.G "             "\nKabupaten Sidoarj…   6.00e7
    ##  2 "\n2013 Mercedes-Benz E300 AMG "          "\nJakarta Utara "      4.30e8
    ##  3 "\n2016 Honda City Ivtec "                "\nKota Jakarta Sela…   1.95e8
    ##  4 "\n2014 Honda Civic 1.8 Ivtec "           "\nKota Jakarta Sela…   1.85e8
    ##  5 "\n2008 Suzuki Baleno Matic "             "\nMalang "             1.00e8
    ##  6 "\n2008 Toyota Corolla Altis 1.8 VVTI Al… "\nDKI Jakarta "        9.25e7
    ##  7 "\n2010 Honda Accord 2.4 VTIL "           "\nJakarta Barat "      1.29e8
    ##  8 "\n2014 Toyota Camry 2.5 V AT "           "\nJakarta Barat "      1.89e8
    ##  9 "\n2014 Toyota Vios G Allnew A/T "        "\nDKI Jakarta "        1.29e8
    ## 10 "\n2016 BMW 320i Sport LCi Black On Blac… "\nJakarta Selatan "    5.65e8
    ## 11 "\n2017 Mercedes-Benz E250 Avantgarde Re… "\nJakarta Selatan "    9.75e8
    ## 12 "\n2018 Mercedes-Benz E200 Avantgarde Ni… "\nJakarta Selatan "    9.75e8
    ## 13 "\n2018 BMW 520i Luxury Reg.2019 Black O… "\nJakarta Selatan "    8.95e8
    ## 14 "\n2007 Honda Civic "                     "\nJakarta Utara "      1.10e8
    ## 15 "\n2010 Audi A4 TFSI 1.8L AT "            "\nJakarta Barat "      1.49e8

*Done\!\!\!* Selesai.

### Membereskan variabel `nama` dan mengekstrak `tahun`

Oke, sekarang kita akan membereskan variabel `nama`. Sebelum
melakukannya, saya akan menghapuskan tanda `\n` dan menambahkan variabel
`id` untuk memudahkan proses ekstrak `tahun` nantinya.

``` r
sedan.data = 
  sedan.data %>% 
  mutate(nama = gsub('\\\n','',nama),
         id = c(1:length(nama))) 
head(sedan.data,15)
```

    ## # A tibble: 15 x 4
    ##    nama                                 lokasi                  harga    id
    ##    <chr>                                <chr>                   <dbl> <int>
    ##  1 "2000 Toyota Corolla SE.G "          "\nKabupaten Sidoar…   6.00e7     1
    ##  2 "2013 Mercedes-Benz E300 AMG "       "\nJakarta Utara "     4.30e8     2
    ##  3 "2016 Honda City Ivtec "             "\nKota Jakarta Sel…   1.95e8     3
    ##  4 "2014 Honda Civic 1.8 Ivtec "        "\nKota Jakarta Sel…   1.85e8     4
    ##  5 "2008 Suzuki Baleno Matic "          "\nMalang "            1.00e8     5
    ##  6 "2008 Toyota Corolla Altis 1.8 VVTI… "\nDKI Jakarta "       9.25e7     6
    ##  7 "2010 Honda Accord 2.4 VTIL "        "\nJakarta Barat "     1.29e8     7
    ##  8 "2014 Toyota Camry 2.5 V AT "        "\nJakarta Barat "     1.89e8     8
    ##  9 "2014 Toyota Vios G Allnew A/T "     "\nDKI Jakarta "       1.29e8     9
    ## 10 "2016 BMW 320i Sport LCi Black On B… "\nJakarta Selatan "   5.65e8    10
    ## 11 "2017 Mercedes-Benz E250 Avantgarde… "\nJakarta Selatan "   9.75e8    11
    ## 12 "2018 Mercedes-Benz E200 Avantgarde… "\nJakarta Selatan "   9.75e8    12
    ## 13 "2018 BMW 520i Luxury Reg.2019 Blac… "\nJakarta Selatan "   8.95e8    13
    ## 14 "2007 Honda Civic "                  "\nJakarta Utara "     1.10e8    14
    ## 15 "2010 Audi A4 TFSI 1.8L AT "         "\nJakarta Barat "     1.49e8    15

Nah, sekarang untuk mengekstrak `tahun` saya akan gunakan metode yang
sama untuk membuat *word cloud* atau *word counting*. Pandang variabel
`nama` sebagai satu kalimat utuh yang kemudian akan dipisah-pisah per
kata. Setiap angka yang muncul akan kita jadikan variabel `tahun`.

``` r
new = 
  sedan.data %>% select(id,nama) %>%
  unnest_tokens('words',nama) %>% 
  mutate(words = as.numeric(words)) %>%
  filter(!is.na(words),words>1900,words<2021)
```

    ## Warning: NAs introduced by coercion

``` r
sedan.data = merge(sedan.data,new)
colnames(sedan.data)[5] = 'tahun'
head(sedan.data,15)
```

    ##    id                                         nama                  lokasi
    ## 1   1                    2000 Toyota Corolla SE.G    \nKabupaten Sidoarjo 
    ## 2   2                 2013 Mercedes-Benz E300 AMG         \nJakarta Utara 
    ## 3   3                       2016 Honda City Ivtec  \nKota Jakarta Selatan 
    ## 4   4                  2014 Honda Civic 1.8 Ivtec  \nKota Jakarta Selatan 
    ## 5   5                    2008 Suzuki Baleno Matic                \nMalang 
    ## 6   6  2008 Toyota Corolla Altis 1.8 VVTI Alln...           \nDKI Jakarta 
    ## 7   7                  2010 Honda Accord 2.4 VTIL         \nJakarta Barat 
    ## 8   8                  2014 Toyota Camry 2.5 V AT         \nJakarta Barat 
    ## 9   9               2014 Toyota Vios G Allnew A/T           \nDKI Jakarta 
    ## 10 10 2016 BMW 320i Sport LCi Black On Black A...       \nJakarta Selatan 
    ## 11 11 2017 Mercedes-Benz E250 Avantgarde Reg.2...       \nJakarta Selatan 
    ## 12 12 2018 Mercedes-Benz E200 Avantgarde Nik20...       \nJakarta Selatan 
    ## 13 13 2018 BMW 520i Luxury Reg.2019 Black On B...       \nJakarta Selatan 
    ## 14 13 2018 BMW 520i Luxury Reg.2019 Black On B...       \nJakarta Selatan 
    ## 15 14                            2007 Honda Civic         \nJakarta Utara 
    ##       harga tahun
    ## 1  6.00e+07  2000
    ## 2  4.30e+08  2013
    ## 3  1.95e+08  2016
    ## 4  1.85e+08  2014
    ## 5  1.00e+08  2008
    ## 6  9.25e+07  2008
    ## 7  1.29e+08  2010
    ## 8  1.89e+08  2014
    ## 9  1.29e+08  2014
    ## 10 5.65e+08  2016
    ## 11 9.75e+08  2017
    ## 12 9.75e+08  2018
    ## 13 8.95e+08  2018
    ## 14 8.95e+08  2019
    ## 15 1.10e+08  2007

*Done\!\!\!* Selesai.

### Mengekstrak *Brand* Mobil

Nah, pekerjaan yang paling menantang adalah mengambil dan mengekstrak
`brand` dari variabel `nama`.

Ada yang punya ide bagaimana caranya?

Hasil yang diinginkan seperti
    ini:

    ##    id                                         nama                  lokasi
    ## 1   1                    2000 Toyota Corolla SE.G    \nKabupaten Sidoarjo 
    ## 2   2                 2013 Mercedes-Benz E300 AMG         \nJakarta Utara 
    ## 3   3                       2016 Honda City Ivtec  \nKota Jakarta Selatan 
    ## 4   4                  2014 Honda Civic 1.8 Ivtec  \nKota Jakarta Selatan 
    ## 5   5                    2008 Suzuki Baleno Matic                \nMalang 
    ## 6   6  2008 Toyota Corolla Altis 1.8 VVTI Alln...           \nDKI Jakarta 
    ## 7   7                  2010 Honda Accord 2.4 VTIL         \nJakarta Barat 
    ## 8   8                  2014 Toyota Camry 2.5 V AT         \nJakarta Barat 
    ## 9   9               2014 Toyota Vios G Allnew A/T           \nDKI Jakarta 
    ## 10 10 2016 BMW 320i Sport LCi Black On Black A...       \nJakarta Selatan 
    ## 11 11 2017 Mercedes-Benz E250 Avantgarde Reg.2...       \nJakarta Selatan 
    ## 12 12 2018 Mercedes-Benz E200 Avantgarde Nik20...       \nJakarta Selatan 
    ## 13 13 2018 BMW 520i Luxury Reg.2019 Black On B...       \nJakarta Selatan 
    ## 14 13 2018 BMW 520i Luxury Reg.2019 Black On B...       \nJakarta Selatan 
    ## 15 13 2018 BMW 520i Luxury Reg.2019 Black On B...       \nJakarta Selatan 
    ##       harga tahun    words
    ## 1  6.00e+07  2000   toyota
    ## 2  4.30e+08  2013 mercedes
    ## 3  1.95e+08  2016    honda
    ## 4  1.85e+08  2014    honda
    ## 5  1.00e+08  2008   suzuki
    ## 6  9.25e+07  2008   toyota
    ## 7  1.29e+08  2010    honda
    ## 8  1.89e+08  2014   toyota
    ## 9  1.29e+08  2014   toyota
    ## 10 5.65e+08  2016      bmw
    ## 11 9.75e+08  2017 mercedes
    ## 12 9.75e+08  2018 mercedes
    ## 13 8.95e+08  2018      bmw
    ## 14 8.95e+08  2018      bmw
    ## 15 8.95e+08  2019      bmw

-----

# *Error Bar* Plot untuk harga mobil

*Nah*, saya sudah mendapatkan data yang saya butuhkan. Sekarang saya
akan membuat analisa harga per brand menggunakan *error bar*.

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Materi%20Training/Kamis%20Data%20Nutrifood/Data%20Carpentry/readme_files/figure-gfm/unnamed-chunk-10-1.png)

-----

# *Catatan Penting*

> Algoritma adalah formalisasi dari alur proses berpikir. *So* apa yang
> saya tulis di sini bukanlah satu-satunya solusi untuk membersihkan
> data yah\!

-----

# Referensi:

1.  [Analisa harga di
    mobil 88.](https://passingthroughresearcher.wordpress.com/2019/10/23/webscrap-mobil-bekas-di-mobil88/)
2.  [Mencari harga Terios
    bekas.](https://ikanx101.github.io/blog/blog-post-terios/)
3. [Data mentah sebelum dan setelah _data carpentry_.](https://github.com/ikanx101/belajaR/tree/master/Materi%20Training/Kamis%20Data%20Nutrifood/Data%20Carpentry)
