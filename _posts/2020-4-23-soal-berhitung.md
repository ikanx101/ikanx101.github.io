---
date: 2020-4-23T15:08:00-04:00
title: "kReativitas saat PSBB: soal latihan berhitung"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
  - Berhitung
---

Pada saat **PSBB** ini, tidak hanya saya yang *work from home* tapi si sulung juga harus *school from home*.

> Kedua hal ini saat bergabung menjadi hal yang sangat rumit. **Trust me it is!**

Setelah beberapa hari mengajari si sulung, ternyata saya merasa dia harus dilatih banyak terkait soal hitung-hitungan. Agar konsep berhitung yang benar semakin tertanam di benaknya.

Untuk itu, saya perlu membuat soal hitung-hitungan yang banyak. *Nah*, oleh karena itu saya akan membuat *function* di **R** yang bisa membuat berapapun banyaknya soal hitung-hitungan. *heeee*.

------------------------------------------------------------------------

Soal Tipe Pertama
=================

Soal tipe ini adalah tipikal soal termudah, yakni:

*a* + *b* = ...

atau

*a* − *b* = ...

Berikut *function*-nya:

``` r
# bikin soal penambahan
soal_tambah = function(n){
  n
  a = sample(c(1:100),1)
  b = sample(c(1:100),1)
  soal = paste0(a,' + ',b,' = ______')
  return(soal)
}

# bikin soal pengurangan
soal_kurang = function(n){
  n
  a = sample(c(1:100),1)
  b = sample(c(1:100),1)
  c = a + b
  soal = paste0(c,' - ',b,' = ______')
  return(soal)
}

# kita buat 10 soal penambahan
ujian_1 = data.frame(nomor = c(1:10))
ujian_1$soal = sapply(ujian_1$nomor,soal_tambah)
ujian_1
```

    ##    nomor              soal
    ## 1      1 100 + 59 = ______
    ## 2      2  30 + 78 = ______
    ## 3      3  57 + 23 = ______
    ## 4      4  33 + 90 = ______
    ## 5      5  88 + 79 = ______
    ## 6      6  89 + 44 = ______
    ## 7      7   6 + 24 = ______
    ## 8      8  55 + 52 = ______
    ## 9      9  55 + 53 = ______
    ## 10    10  26 + 32 = ______

``` r
# kita buat 10 soal pengurangan
ujian_2 = data.frame(nomor = c(1:10))
ujian_2$soal = sapply(ujian_2$nomor,soal_kurang)
ujian_2
```

    ##    nomor              soal
    ## 1      1 107 - 89 = ______
    ## 2      2  30 - 25 = ______
    ## 3      3 130 - 67 = ______
    ## 4      4 128 - 43 = ______
    ## 5      5 104 - 88 = ______
    ## 6      6  94 - 82 = ______
    ## 7      7  76 - 43 = ______
    ## 8      8   53 - 9 = ______
    ## 9      9  62 - 60 = ______
    ## 10    10  61 - 31 = ______

Soal Tipe Kedua
===============

Soal tipe ini adalah tipikal soal yang cukup rumit bagi anak-anak, yakni:

*a* + ... = *c*

atau

*a* − ... = *c*

Berikut adalah *function*-nya:

``` r
# bikin soal penambahan
soal_tambah = function(n){
  n
  a = sample(c(1:100),1)
  b = sample(c(1:100),1)
  c = a + b
  soal = paste0(a,' + _____ = ',c)
  return(soal)
}

# bikin soal pengurangan
soal_kurang = function(n){
  n
  a = sample(c(1:100),1)
  b = sample(c(1:100),1)
  c = a + b
  soal = paste0(c,' - ____ = ',b)
  return(soal)
}

# kita buat 10 soal penambahan
ujian_1 = data.frame(nomor = c(1:10))
ujian_1$soal = sapply(ujian_1$nomor,soal_tambah)
ujian_1
```

    ##    nomor             soal
    ## 1      1 21 + _____ = 113
    ## 2      2 67 + _____ = 167
    ## 3      3  39 + _____ = 49
    ## 4      4  27 + _____ = 67
    ## 5      5 72 + _____ = 111
    ## 6      6 54 + _____ = 100
    ## 7      7  25 + _____ = 69
    ## 8      8 81 + _____ = 112
    ## 9      9  15 + _____ = 89
    ## 10    10   5 + _____ = 87

``` r
# kita buat 10 soal pengurangan
ujian_2 = data.frame(nomor = c(1:10))
ujian_2$soal = sapply(ujian_2$nomor,soal_kurang)
ujian_2
```

    ##    nomor            soal
    ## 1      1  43 - ____ = 29
    ## 2      2   65 - ____ = 5
    ## 3      3  84 - ____ = 55
    ## 4      4 113 - ____ = 71
    ## 5      5 108 - ____ = 11
    ## 6      6  95 - ____ = 42
    ## 7      7 153 - ____ = 69
    ## 8      8  73 - ____ = 42
    ## 9      9 158 - ____ = 74
    ## 10    10  75 - ____ = 31

------------------------------------------------------------------------

Soal Tipe Ketiga
================

*Nah*, soal yang ini meliputi penambahan atau pengurangan `3` bilangan. Ini *function*-nya:

``` r
soal_tambah = function(n){
  a = sample(c(1:100),1)
  b = sample(c(1:100),1)
  c = sample(c(1:100),1)
  soal = paste0(a,' + ',b," + ",c,' = ___')
  return(soal)
}

soal_kurang = function(n){
  a = sample(c(1:100),1)
  b = sample(c(1:100),1)
  c = sample(c(1:100),1)
  d = a+b+c
  soal = paste0(d,' - ',a,' - ',b,' = ____')
  return(soal)
}

# kita buat 10 soal penambahan
ujian_1 = data.frame(nomor = c(1:10))
ujian_1$soal = sapply(ujian_1$nomor,soal_tambah)
ujian_1
```

    ##    nomor               soal
    ## 1      1 44 + 68 + 95 = ___
    ## 2      2 32 + 59 + 26 = ___
    ## 3      3  80 + 88 + 4 = ___
    ## 4      4 32 + 65 + 43 = ___
    ## 5      5 93 + 10 + 38 = ___
    ## 6      6 62 + 98 + 43 = ___
    ## 7      7 100 + 1 + 35 = ___
    ## 8      8 76 + 97 + 23 = ___
    ## 9      9 37 + 54 + 40 = ___
    ## 10    10  72 + 82 + 8 = ___

``` r
# kita buat 10 soal pengurangan
ujian_2 = data.frame(nomor = c(1:10))
ujian_2$soal = sapply(ujian_2$nomor,soal_kurang)
ujian_2
```

    ##    nomor                 soal
    ## 1      1 145 - 39 - 97 = ____
    ## 2      2  93 - 17 - 69 = ____
    ## 3      3 165 - 76 - 19 = ____
    ## 4      4  121 - 6 - 80 = ____
    ## 5      5 237 - 87 - 82 = ____
    ## 6      6 101 - 17 - 12 = ____
    ## 7      7  79 - 54 - 13 = ____
    ## 8      8 177 - 25 - 90 = ____
    ## 9      9   46 - 14 - 3 = ____
    ## 10    10 160 - 57 - 65 = ____

Lumayan membantu sih bagi saya. Setidaknya bisa melatih si sulung berhitung.
