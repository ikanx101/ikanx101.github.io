MATERI TRAINING R: Memulai dengan Google Colab
================

# *Google Colab*

Pada beberapa *posting* terdahulu, saya sempat menginformasikan bahwa
kita bisa Bekerja dengan **R** di [*Google
Colab*](https://ikanx101.com/blog/google-colab/). Kini melanjutkan
materi [training sebelumnya](https://ikanx101.com/blog/train-r-1/) saya
akan memulai menjelaskan bagaimana *basic skill* di **R** dengan
menggunakan Google Colab.

Tampilan awal *Google Colab* adalah sebagai berikut:

[![Alt text](https://img.youtube.com/vi/MBvNjh_mWrQ/0.jpg)](https://www.youtube.com/watch?v=MBvNjh_mWrQ)


## Mengenal operator dasar

Beberapa operator dasar di **R** antara lain:

1.  `=` atau `<-`, digunakan untuk melakukan pendefinisian suatu objek.
    Contoh:

<!-- end list -->

``` r
a = 10
b <- 3
a + b
```

    ## [1] 13

2.  `' '` atau `" "`, digunakan untuk menandai tipe variabel berupa
    `character`. Lalu apa beda penggunaan `' '` dengan `" "`? `" "`
    digunakan saat `'` dibutuhkan dalam suatu `character`. Contoh:

<!-- end list -->

``` r
a = 'saya hendak pergi ke pasar'
b = "i don't want to buy it"
a
```

    ## [1] "saya hendak pergi ke pasar"

``` r
b
```

    ## [1] "i don't want to buy it"

3.  `==`, `<`, `>`, `<=`, atau `>=`, digunakan untuk mengecek apakah dua
    variabel itu memiliki kesamaan atau tidak. *Output* dari operator
    ini adalah `logic` (*TRUE or FALSE*). Contoh:

<!-- end list -->

``` r
a = 5
b = 3
a == b
```

    ## [1] FALSE

``` r
a > b
```

    ## [1] TRUE

4.  `;` atau *<enter>*, digunakan untuk memisahkan baris kode pada skrip
    algoritma. Contoh:

<!-- end list -->

``` r
a = 5;b = 3;a*b
```

    ## [1] 15
