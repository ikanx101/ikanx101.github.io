Menyelesaikan Soal Aljabar dari Instagram
================

<img src="wag.jpeg" width="35%" style="display: block; margin: auto;" />

Kemarin siang di salah satu grup WA, seorang teman mengirimkan gambar
seperti di atas. Seketika naluri saya tergerak untuk memecahkan *puzzle*
tersebut. *hehe*

Simpel kok, gak serumit yang dibayangkan.

------------------------------------------------------------------------

Caranya cukup tuliskan gambar di atas ke dalam bentuk ini:

*x*<sub>1</sub> + *x*<sub>2</sub> = 8

*x*<sub>2</sub> + *x*<sub>3</sub> = 8

 − *x*<sub>3</sub> + *x*<sub>4</sub> = 6

*x*<sub>1</sub> + *x*<sub>4</sub> = 13

Jika rekan-rekan membaca tulisan saya yang
[ini](https://ikanx101.com/blog/aljabar-rpubs/), kita bisa dengan mudah
menyelesaikan sistem persamaan linear ini dengan cara:

*A**x* = *b*

*x* = *A*<sup> − 1</sup>*b*

Yuk, kita selesaikan:

``` r
# dalam bentuk matriks
A = matrix(c(1,1,0,0,
             0,1,1,0,
             0,0,-1,1,
             1,0,0,1),
           byrow = T,
           ncol = 4)
b = c(8,8,6,13)

# jawaban eksak
matlib::inv(A) %*% b
```

    ##      [,1]
    ## [1,]  3.5
    ## [2,]  4.5
    ## [3,]  3.5
    ## [4,]  9.5

Selesai *deh*.

Gampang kan?
