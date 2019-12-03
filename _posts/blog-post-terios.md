Mencari Harga Daihatsu Terios Bekas
================

Ceritanya, dalam beberapa waktu ke depan saya berencana untuk menjual
mobil Daihatsu Terios saya. Mobil saya itu keluaran tahun 2014.
Merupakan tipe Terios termahal pada zamannya. *hehe*

> Sekarang kira-kira berapa yah harganya?

Begitu pikir saya.

Kemudian, saya coba mencari-cari ada di kisaran berapa mobil saya jika
hendak dijual. Jadi saya akan mencari rentang harga mobil Daihatsu
Terios per tahun keluarnya tanpa memperdulikan apakah mobil tersebut
*manual* atau *matic*.

Salah satu *web* yang saya jadikan acuan adalah [carmudi
indonesia](https://www.carmudi.co.id). Saya coba cari dan *scrap* data
dari situs tersebut.

## Langkah pertama

Saya coba cek dulu *link* apa saja yang akan saya ambil datanya lalu
saya persiapkan fungsi untuk *scrap* datanya

``` r
library(dplyr)
library(rvest)
library(tidytext)
library(ggplot2)
#link dari carmudi utk daihatsu Terios
url = paste('https://www.carmudi.co.id/cars/daihatsu/terios/?page=',
            c(1:19),
            sep='')

#Bikin fungsi scrap
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

Saya *scrap* datanya dari *link* pertama hingga selesai. Saya masih
senang menggunakan *looping* dibandingkan menggunakan fungsi `lapply()`.
Sepertinya lebih *firm* saja menurut saya.

``` r
#kita mulai scrap datanya
i = 1
terios.data = scrap(url[i])

for(i in 2:length(url)){
  temp = scrap(url[i])
  terios.data = rbind(terios.data,temp)
}
str(terios.data)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    548 obs. of  3 variables:
    ##  $ nama  : chr  "\n2019 Daihatsu Terios TDP MULAI DR 21JTAA... " "\n2019 Daihatsu Terios " "\n2019 Daihatsu Terios PROMO DAIHATSU AKHI... " "\n2013 Daihatsu Terios TX M/T " ...
    ##  $ harga : chr  "245 Juta" "195 Juta" "189 Juta" "120 Juta" ...
    ##  $ lokasi: chr  "\nKota Jakarta Barat " "\nKota Jakarta Barat " "\n Jakarta Timur " "\nKota Jakarta Timur " ...

``` r
head(terios.data,15)
```

    ## # A tibble: 15 x 3
    ##    nama                                      harga     lokasi              
    ##    <chr>                                     <chr>     <chr>               
    ##  1 "\n2019 Daihatsu Terios TDP MULAI DR 21J… 245 Juta  "\nKota Jakarta Bar…
    ##  2 "\n2019 Daihatsu Terios "                 195 Juta  "\nKota Jakarta Bar…
    ##  3 "\n2019 Daihatsu Terios PROMO DAIHATSU A… 189 Juta  "\n Jakarta Timur " 
    ##  4 "\n2013 Daihatsu Terios TX M/T "          120 Juta  "\nKota Jakarta Tim…
    ##  5 "\n2019 Daihatsu Terios PROMO TERMURAH D… 190 Juta  "\nKota Jkt Utara " 
    ##  6 "\n2019 Daihatsu Terios cash kredit disk… 189 Juta  "\nJakarta Selatan "
    ##  7 "\n2019 Daihatsu Terios Prom... "         192.3 Ju… "\nKota Tgr. Sel. " 
    ##  8 "\n2016 Daihatsu Terios X A/T KM23Rb "    155 Juta  "\nMalang "         
    ##  9 "\n2007 Daihatsu Terios "                 100 Juta  "\nDepok "          
    ## 10 "\n2012 Daihatsu Terios "                 120 Juta  "\nDepok "          
    ## 11 "\n2016 Daihatsu Terios "                 157 Juta  "\nDepok "          
    ## 12 "\n2016 Daihatsu Terios X M/T "           148 Juta  "\nSurabaya "       
    ## 13 "\n2013 Daihatsu Terios TX M/T "          143 Juta  "\nMalang "         
    ## 14 "\n2017 Daihatsu Terios R adventure mt "  184 Juta  "\nMalang "         
    ## 15 "\n2018 Daihatsu Terios All New R Deluxe… 220 Juta  "\nMalang "

## Hasil scrap data

Didapatkan ada 548 baris data mobil Daihatsu Terios yang di- *listing*
di **carmudi**.

Kalau kita lihat sekilas, data tersebut seolah-olah *structured*. Namun
kalau diperhatikan secara seksama, sebenarnya data tersebut
*semi-structured*. Variabel `harga` berupa *character* karena tulisan
juta. Sedangkan variabel `nama` masih campur aduk adanya tahun produksi
dan varian mobil.

*So*, kita memiliki dua masalah, yakni:

1.  Bagaimana mengubah `harga` menjadi numerik agar bisa dianalisa?
2.  Bagaimana mengekstrak `tahun` dari variabel `nama`.

## Proses Data Carpentry

### Membereskan variabel `harga`

Kita mulai dari membereskan variabel yang paling gampang, yakni `harga`.

``` r
terios.data = 
  terios.data %>% 
  mutate(harga = gsub('juta','',harga,ignore.case = T), 
         harga = gsub('\\ ','',harga),
         harga = as.numeric(harga)) 
head(terios.data,15)
```

    ## # A tibble: 15 x 3
    ##    nama                                         harga lokasi               
    ##    <chr>                                        <dbl> <chr>                
    ##  1 "\n2019 Daihatsu Terios TDP MULAI DR 21JTAA…  245  "\nKota Jakarta Bara…
    ##  2 "\n2019 Daihatsu Terios "                     195  "\nKota Jakarta Bara…
    ##  3 "\n2019 Daihatsu Terios PROMO DAIHATSU AKHI…  189  "\n Jakarta Timur "  
    ##  4 "\n2013 Daihatsu Terios TX M/T "              120  "\nKota Jakarta Timu…
    ##  5 "\n2019 Daihatsu Terios PROMO TERMURAH DP D…  190  "\nKota Jkt Utara "  
    ##  6 "\n2019 Daihatsu Terios cash kredit diskon …  189  "\nJakarta Selatan " 
    ##  7 "\n2019 Daihatsu Terios Prom... "             192. "\nKota Tgr. Sel. "  
    ##  8 "\n2016 Daihatsu Terios X A/T KM23Rb "        155  "\nMalang "          
    ##  9 "\n2007 Daihatsu Terios "                     100  "\nDepok "           
    ## 10 "\n2012 Daihatsu Terios "                     120  "\nDepok "           
    ## 11 "\n2016 Daihatsu Terios "                     157  "\nDepok "           
    ## 12 "\n2016 Daihatsu Terios X M/T "               148  "\nSurabaya "        
    ## 13 "\n2013 Daihatsu Terios TX M/T "              143  "\nMalang "          
    ## 14 "\n2017 Daihatsu Terios R adventure mt "      184  "\nMalang "          
    ## 15 "\n2018 Daihatsu Terios All New R Deluxe A/…  220  "\nMalang "

*Done\!\!\!* Selesai.

### Membereskan variabel `nama` dan mengekstrak `tahun`

Oke, sekarang kita akan membereskan variabel `nama`. Sebelum
melakukannya, saya akan menghapuskan tanda `\n` dan menambahkan variabel
`id` untuk memudahkan proses ekstrak `tahun` nantinya.

``` r
terios.data = 
  terios.data %>% 
  mutate(nama = gsub('\\\n','',nama),
         id = c(1:length(nama))) 
head(terios.data,15)
```

    ## # A tibble: 15 x 4
    ##    nama                                    harga lokasi                  id
    ##    <chr>                                   <dbl> <chr>                <int>
    ##  1 "2019 Daihatsu Terios TDP MULAI DR 21J…  245  "\nKota Jakarta Bar…     1
    ##  2 "2019 Daihatsu Terios "                  195  "\nKota Jakarta Bar…     2
    ##  3 "2019 Daihatsu Terios PROMO DAIHATSU A…  189  "\n Jakarta Timur "      3
    ##  4 "2013 Daihatsu Terios TX M/T "           120  "\nKota Jakarta Tim…     4
    ##  5 "2019 Daihatsu Terios PROMO TERMURAH D…  190  "\nKota Jkt Utara "      5
    ##  6 "2019 Daihatsu Terios cash kredit disk…  189  "\nJakarta Selatan "     6
    ##  7 "2019 Daihatsu Terios Prom... "          192. "\nKota Tgr. Sel. "      7
    ##  8 "2016 Daihatsu Terios X A/T KM23Rb "     155  "\nMalang "              8
    ##  9 "2007 Daihatsu Terios "                  100  "\nDepok "               9
    ## 10 "2012 Daihatsu Terios "                  120  "\nDepok "              10
    ## 11 "2016 Daihatsu Terios "                  157  "\nDepok "              11
    ## 12 "2016 Daihatsu Terios X M/T "            148  "\nSurabaya "           12
    ## 13 "2013 Daihatsu Terios TX M/T "           143  "\nMalang "             13
    ## 14 "2017 Daihatsu Terios R adventure mt "   184  "\nMalang "             14
    ## 15 "2018 Daihatsu Terios All New R Deluxe…  220  "\nMalang "             15

Nah, sekarang untuk mengekstrak `tahun` saya akan gunakan metode yang
sama untuk membuat *word cloud* atau *word counting*. Pandang variabel
`nama` sebagai satu kalimat utuh yang kemudian akan dipisah-pisah per
kata. Setiap angka yang muncul akan kita jadikan variabel `tahun`.

``` r
new = 
  terios.data %>% select(id,nama) %>%
  unnest_tokens('words',nama) %>% 
  mutate(words = as.numeric(words)) %>%
  filter(!is.na(words),words>2000)
```

    ## Warning: NAs introduced by coercion

``` r
terios.data = merge(terios.data,new)
colnames(terios.data)[5] = 'tahun'
head(terios.data,15)
```

    ##    id                                         nama harga
    ## 1   1 2019 Daihatsu Terios TDP MULAI DR 21JTAA...  245.0
    ## 2   2                        2019 Daihatsu Terios  195.0
    ## 3   3 2019 Daihatsu Terios PROMO DAIHATSU AKHI...  189.0
    ## 4   4                 2013 Daihatsu Terios TX M/T  120.0
    ## 5   5 2019 Daihatsu Terios PROMO TERMURAH DP D...  190.0
    ## 6   6 2019 Daihatsu Terios cash kredit diskon ...  189.0
    ## 7   7                2019 Daihatsu Terios Prom...  192.3
    ## 8   8           2016 Daihatsu Terios X A/T KM23Rb  155.0
    ## 9   9                        2007 Daihatsu Terios  100.0
    ## 10 10                        2012 Daihatsu Terios  120.0
    ## 11 11                        2016 Daihatsu Terios  157.0
    ## 12 12                  2016 Daihatsu Terios X M/T  148.0
    ## 13 13                 2013 Daihatsu Terios TX M/T  143.0
    ## 14 14         2017 Daihatsu Terios R adventure mt  184.0
    ## 15 15   2018 Daihatsu Terios All New R Deluxe A/T  220.0
    ##                   lokasi tahun
    ## 1  \nKota Jakarta Barat   2019
    ## 2  \nKota Jakarta Barat   2019
    ## 3      \n Jakarta Timur   2019
    ## 4  \nKota Jakarta Timur   2013
    ## 5      \nKota Jkt Utara   2019
    ## 6     \nJakarta Selatan   2019
    ## 7      \nKota Tgr. Sel.   2019
    ## 8              \nMalang   2016
    ## 9               \nDepok   2007
    ## 10              \nDepok   2012
    ## 11              \nDepok   2016
    ## 12           \nSurabaya   2016
    ## 13             \nMalang   2013
    ## 14             \nMalang   2017
    ## 15             \nMalang   2018

*Done\!\!\!* Selesai.

## Summary

*Nah*, saya sudah mendapatkan data yang saya butuhkan. Untuk memudahkan
saya memahami datanya, saya akan membuat *error bar* agar secara visual
lebih mudah dipahami.

    ## Loading required package: magrittr

![](blog-post-terios_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Sekarang saya jadi tahu, harus buka di harga berapa jika ingin menjual
mobil saya.
