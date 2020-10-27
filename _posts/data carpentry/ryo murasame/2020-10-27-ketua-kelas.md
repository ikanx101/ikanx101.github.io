---
date: 2020-10-27T5:30:00-04:00
title: "Tutorial Data Carpentry: Mencari Ketua Kelas dengan R"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Data Carpentry
  - Tutorial
---


Suatu sore HP saya berdering. Salah seorang teman saya nun jauh di sana
bertanya:

> Kamu bisa bantu aku gak? Aku punya data anak-anak. Aku mau nentuin
> siapa yang jadi ketua kelasnya\!

*Begitu katanya.*

Kenapa ke saya yah? Pikir saya kemudian. *hehe*

-----

Ceritanya, teman saya bertugas sebagai panitia jambore anak-anak. Sampai
saat ini, terdaftar 800 orang anak yang akan dibagi menjadi `20` kelas.

Teman saya berujar, penunjukan ketua kelasnya dilakukan dengan *rules*
berikut ini:

1.  Dari `20` kelas yang ada, akan ditunjuk anak yang memiliki `berat
    badan` terbesar.
2.  Jika ada lebih dari satu anak yang memiliki `berat badan` terbesar
    yang sama, maka akan dipilih berdasarkan `tinggi badan` yang
    tertinggi.
3.  Jika masih ada yang sama, maka akan dipilih berdasarkan tanggal
    lahir yang tertua.

-----

Sekarang saya akan menyelesaikan masalah teman saya tersebut dengan
menggunakan prinsip *tidy* di **R**.

Oh iya, datanya saya simpan di
[sini](https://github.com/ikanx101/ikanx101.github.io/blob/master/_posts/data%20carpentry/ryo%20murasame/kelas%20anak.csv).
Silakan jika teman-teman ingin ikut praktek *yah*.

-----

Pertama-tama, saya akan *load* datanya ke dalam *environment* di **R**
lalu saya akan lihat dulu struktur datanya. Oh iya, jangan lupa untuk
memanggil `library(dplyr)` *yah*.

``` r
str(data)
```

    ## 'data.frame':    800 obs. of  5 variables:
    ##  $ nama         : chr  "John-Baptiste, Naimo" "Hudson, Aason" "el-Allam, Silmi" "Prout, Daniel" ...
    ##  $ tanggal_lahir: Date, format: "2012-06-12" "2014-04-21" ...
    ##  $ berat_badan  : num  38 28 28 19 32 40 16 31 39 33 ...
    ##  $ tinggi_badan : num  103 105 120 112 143 116 119 123 111 120 ...
    ##  $ kelas        : chr  "L" "A" "O" "J" ...

Berikut 10 data teratas:

| nama                 | tanggal\_lahir | berat\_badan | tinggi\_badan | kelas |
| :------------------- | :------------- | -----------: | ------------: | :---- |
| John-Baptiste, Naimo | 2012-06-12     |           38 |           103 | L     |
| Hudson, Aason        | 2014-04-21     |           28 |           105 | A     |
| el-Allam, Silmi      | 2013-05-05     |           28 |           120 | O     |
| Prout, Daniel        | 2014-01-10     |           19 |           112 | J     |
| Nylund, Christopher  | 2014-10-10     |           32 |           143 | T     |
| Brinkmann, Joseph    | 2013-10-25     |           40 |           116 | S     |
| al-Arafat, Rasheeda  | 2014-02-13     |           16 |           119 | N     |
| Vasquez, Bryan       | 2014-09-26     |           31 |           123 | E     |
| al-Wahba, Saamiqa    | 2014-01-09     |           39 |           111 | L     |
| el-Younan, Zainab    | 2012-01-04     |           33 |           120 | F     |

Karena struktur datanya sudah *pas* dan tidak ada masalah (data sudah
bersih), maka saya langsung saja membuat algoritma yang disesuaikan
dengan *rules* teman saya tersebut:

``` r
data %>% 
  group_by(kelas) %>% 
  filter(berat_badan == max(berat_badan)) %>% 
  filter(tinggi_badan == max(tinggi_badan)) %>% 
  filter(tanggal_lahir == min(tanggal_lahir)) %>% 
  arrange(kelas)
```

    ## # A tibble: 20 x 5
    ## # Groups:   kelas [20]
    ##    nama                    tanggal_lahir berat_badan tinggi_badan kelas
    ##    <chr>                   <date>              <dbl>        <dbl> <chr>
    ##  1 Kramer, Ellie           2013-06-03             46          115 A    
    ##  2 Vigil, Karli            2014-06-10             47          136 B    
    ##  3 Vanstraten, Christopher 2012-05-20             50          124 C    
    ##  4 Hatzenbihler, Lauren    2014-01-07             50          109 D    
    ##  5 Najar, Miranda          2012-02-24             47          142 E    
    ##  6 Phillips, Briana        2012-04-12             51          129 F    
    ##  7 al-Farag, Kawkab        2014-04-10             41          138 G    
    ##  8 Vue, Summer             2012-09-22             51          106 H    
    ##  9 Nguyen, Shannon         2012-09-03             42          117 I    
    ## 10 el-Rahimi, Aasima       2012-08-10             51          147 J    
    ## 11 Mazza, Jeffrey          2012-09-04             49          125 K    
    ## 12 Moua, Zheng             2013-03-26             52          130 L    
    ## 13 Ciarlotta, Kane         2012-11-08             44          128 M    
    ## 14 Valdez, Tyler           2012-06-22             51          118 N    
    ## 15 Sanistevan, Jordan      2012-02-10             46          129 O    
    ## 16 Robles-Nunez, Miguel    2012-04-23             52          139 P    
    ## 17 Wilson, Mouneek         2013-08-23             56          127 Q    
    ## 18 al-Faraj, Waleed        2012-03-11             50          122 R    
    ## 19 Law, Erica              2014-05-05             54          116 S    
    ## 20 Epps, Anezshe           2014-02-03             52          103 T

-----

**Gampang kan?**
