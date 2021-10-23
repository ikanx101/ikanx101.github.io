Belajar Membuat Model Regresi Linear - part 2 (Multivariat)
================

Pada tulisan [sebelumnya](https://ikanx101.com/blog/curve-linear/) saya
telah menjelaskan bagaimana caranya membuat persamaan regresi linear
sederhana dua peubah (![x](https://latex.codecogs.com/png.latex?x "x")
dan ![y](https://latex.codecogs.com/png.latex?y "y")) **dari nol**.
Sekarang kita akan “naik kelas” untuk membuat fungsi regresi linear
multivariat. Apa maksudnya?

> ***Regresi linear multivariat adalah suatu metode curve fitting yang
> melibatkan banyak peubah (minimal 3 peubah).***

Misalkan saya memiliki ![n](https://latex.codecogs.com/png.latex?n "n")
buah data sebagai berikut:
![(x\_1,x\_2,x\_3,y)](https://latex.codecogs.com/png.latex?%28x_1%2Cx_2%2Cx_3%2Cy%29
"(x_1,x_2,x_3,y)"), lalu kita hendak membuat persamaan regresi berikut
ini: ![f(x\_1,x\_2,x\_3) = y = a + b x\_1 + c x\_2 + d
x\_3](https://latex.codecogs.com/png.latex?f%28x_1%2Cx_2%2Cx_3%29%20%3D%20y%20%3D%20a%20%2B%20b%20x_1%20%2B%20c%20x_2%20%2B%20d%20x_3
"f(x_1,x_2,x_3) = y = a + b x_1 + c x_2 + d x_3").

Bagaimana cara kita melakukannya?

-----

Pada tulisan sebelumnya, saya mendefinisikan *error* sebagai **jarak**
antara nilai *real* dan nilai prediksi. Lantas bagaimana jika ada banyak
peubah yang terlibat?

Pada prinsipnya sama saja. Kita bisa menggunakan cara serupa. Namun saya
akan menuliskannya dalam bentuk aljabar yang **sudah pasti lebih
mudah**.

Oke, perhatikan baik-baik.

Misalkan saya memiliki ![n](https://latex.codecogs.com/png.latex?n "n")
buah data dengan ![m](https://latex.codecogs.com/png.latex?m "m") buah
peubah. Maka ekspektasi kita adalah:

  
![\\begin{bmatrix}
1 & x\_1 & x\_2 & .. & x\_n \\\\ 
1 & x\_1 & x\_2 & .. & x\_n \\\\ 
.. & .. & .. & .. & .. \\\\ 
1 & x\_1 & x\_2 & .. & x\_n \\\\ 
1 & x\_1 & x\_2 & .. & x\_n 
\\end{bmatrix} 
\\begin{bmatrix} a \\\\ b \\\\ c \\\\ d \\end{bmatrix} = 
\\begin{bmatrix} y\_1 \\\\ y\_2 \\\\ .. \\\\ y\_{n-1} \\\\ y\_n
\\end{bmatrix}](https://latex.codecogs.com/png.latex?%5Cbegin%7Bbmatrix%7D%0A1%20%26%20x_1%20%26%20x_2%20%26%20..%20%26%20x_n%20%5C%5C%20%0A1%20%26%20x_1%20%26%20x_2%20%26%20..%20%26%20x_n%20%5C%5C%20%0A..%20%26%20..%20%26%20..%20%26%20..%20%26%20..%20%5C%5C%20%0A1%20%26%20x_1%20%26%20x_2%20%26%20..%20%26%20x_n%20%5C%5C%20%0A1%20%26%20x_1%20%26%20x_2%20%26%20..%20%26%20x_n%20%0A%5Cend%7Bbmatrix%7D%20%0A%5Cbegin%7Bbmatrix%7D%20a%20%5C%5C%20b%20%5C%5C%20c%20%5C%5C%20d%20%5Cend%7Bbmatrix%7D%20%3D%20%0A%5Cbegin%7Bbmatrix%7D%20y_1%20%5C%5C%20y_2%20%5C%5C%20..%20%5C%5C%20y_%7Bn-1%7D%20%5C%5C%20y_n%20%5Cend%7Bbmatrix%7D
"\\begin{bmatrix}
1 & x_1 & x_2 & .. & x_n \\\\ 
1 & x_1 & x_2 & .. & x_n \\\\ 
.. & .. & .. & .. & .. \\\\ 
1 & x_1 & x_2 & .. & x_n \\\\ 
1 & x_1 & x_2 & .. & x_n 
\\end{bmatrix} 
\\begin{bmatrix} a \\\\ b \\\\ c \\\\ d \\end{bmatrix} = 
\\begin{bmatrix} y_1 \\\\ y_2 \\\\ .. \\\\ y_{n-1} \\\\ y_n \\end{bmatrix}")  

Saya akan menuliskannya dalam bentuk matriks berikut ini:

  
![X\_{n \\times m+1} C\_{m+1 \\times 1} = Y\_{m+1
\\times 1}](https://latex.codecogs.com/png.latex?X_%7Bn%20%5Ctimes%20m%2B1%7D%20C_%7Bm%2B1%20%5Ctimes%201%7D%20%3D%20Y_%7Bm%2B1%20%5Ctimes%201%7D
"X_{n \\times m+1} C_{m+1 \\times 1} = Y_{m+1 \\times 1}")  

Jika pada kasus sebelumnya bentuk matriks yang terlibat adalah ![2
\\times 2](https://latex.codecogs.com/png.latex?2%20%5Ctimes%202
"2 \\times 2") sehingga kita bisa dengan mudah mencari *inverse*-nya.
Kali ini bentuk matriksnya belum tentu *square*.

Lantas bagaimana caranya?

Saya akan lakukan *tweaks* seperti ini:

  
![X^T X C = X^T
Y](https://latex.codecogs.com/png.latex?X%5ET%20X%20C%20%3D%20X%5ET%20Y
"X^T X C = X^T Y")  

Sehingga ![C](https://latex.codecogs.com/png.latex?C "C") bisa
didapatkan dengan cara:

  
![C = (X^T X)^{-1} X^T
Y](https://latex.codecogs.com/png.latex?C%20%3D%20%28X%5ET%20X%29%5E%7B-1%7D%20X%5ET%20Y
"C = (X^T X)^{-1} X^T Y")  

Mudah kan?

-----

## Contoh Data

Mari kita uji dengan data sebagai berikut:

|       x1 |       x2 |       x3 |           y |
| -------: | -------: | -------: | ----------: |
| 8.829674 | 6.181745 | 7.659825 |   0.4520123 |
| 2.443080 | 8.661206 | 7.884343 |   7.7828454 |
| 3.857816 | 7.842289 | 3.418369 |   7.1217812 |
| 5.136328 | 8.015814 | 2.435919 |   6.1083784 |
| 6.516253 | 5.808617 | 6.520327 |  10.0330661 |
| 6.135791 | 6.883319 | 2.056926 | \-0.9324824 |
| 4.020639 | 5.725272 | 2.306214 | \-3.7245628 |
| 4.488901 | 8.126881 | 4.527751 |  11.3047224 |
| 2.803466 | 5.420912 | 5.729522 | \-3.6707495 |
| 5.628086 | 6.837829 | 7.055573 |   7.5280985 |

Pertama-tama kita akan buat matriks sebagai berikut:

``` r
n = length(x1)
x0 = rep(1,n)
X = cbind(x0,x1,x2,x3)
t_X = t(X)
Y = y

# matriks X
X
```

    ##       x0       x1       x2       x3
    ##  [1,]  1 8.829674 6.181745 7.659825
    ##  [2,]  1 2.443080 8.661206 7.884343
    ##  [3,]  1 3.857816 7.842289 3.418369
    ##  [4,]  1 5.136328 8.015814 2.435919
    ##  [5,]  1 6.516253 5.808617 6.520327
    ##  [6,]  1 6.135791 6.883319 2.056926
    ##  [7,]  1 4.020639 5.725272 2.306214
    ##  [8,]  1 4.488901 8.126881 4.527751
    ##  [9,]  1 2.803467 5.420912 5.729522
    ## [10,]  1 5.628086 6.837829 7.055573

Oke, kita akan cari nilai konstantanya sebagai berikut:

``` r
solve(t_X %*% X) %*% t_X %*% Y
```

    ##           [,1]
    ## x0 -25.9515908
    ## x1   0.5097218
    ## x2   3.4372744
    ## x3   0.7500860

Kita bandingkan dengan hasil *base* **R** sebagai berikut:

``` r
lm(y ~ x1 + x2 + x3)
```

    ## 
    ## Call:
    ## lm(formula = y ~ x1 + x2 + x3)
    ## 
    ## Coefficients:
    ## (Intercept)           x1           x2           x3  
    ##    -25.9516       0.5097       3.4373       0.7501
