---
date: 2021-10-24T11:02:00-04:00
title: "Belajar Membuat Model Regresi Linear - part 2 (Multivariat)"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Computational Science
  - Sains Komputasi
  - Matematika
  - Kuliah
  - ITB
  - Analisa Numerik Lanjut
  - Komputasi
  - Aproksimasi
  - Regresi Linear
  - Curve Fitting
---

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
![(x\_1,x\_2,x\_3,y)](https://latex.codecogs.com/png.latex?%28x_1%2Cx_2%2Cx_3%2Cy%29 "(x_1,x_2,x_3,y)"),
lalu kita hendak membuat persamaan regresi berikut ini:
![f(x\_1,x\_2,x\_3) = y = a + b x\_1 + c x\_2 + d x\_3](https://latex.codecogs.com/png.latex?f%28x_1%2Cx_2%2Cx_3%29%20%3D%20y%20%3D%20a%20%2B%20b%20x_1%20%2B%20c%20x_2%20%2B%20d%20x_3 "f(x_1,x_2,x_3) = y = a + b x_1 + c x_2 + d x_3").

Bagaimana cara kita melakukannya?

------------------------------------------------------------------------

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
\\begin{bmatrix} y\_1 \\\\ y\_2 \\\\ .. \\\\ y\_{n-1} \\\\ y\_n \\end{bmatrix}](https://latex.codecogs.com/png.latex?%5Cbegin%7Bbmatrix%7D%0A1%20%26%20x_1%20%26%20x_2%20%26%20..%20%26%20x_n%20%5C%5C%20%0A1%20%26%20x_1%20%26%20x_2%20%26%20..%20%26%20x_n%20%5C%5C%20%0A..%20%26%20..%20%26%20..%20%26%20..%20%26%20..%20%5C%5C%20%0A1%20%26%20x_1%20%26%20x_2%20%26%20..%20%26%20x_n%20%5C%5C%20%0A1%20%26%20x_1%20%26%20x_2%20%26%20..%20%26%20x_n%20%0A%5Cend%7Bbmatrix%7D%20%0A%5Cbegin%7Bbmatrix%7D%20a%20%5C%5C%20b%20%5C%5C%20c%20%5C%5C%20d%20%5Cend%7Bbmatrix%7D%20%3D%20%0A%5Cbegin%7Bbmatrix%7D%20y_1%20%5C%5C%20y_2%20%5C%5C%20..%20%5C%5C%20y_%7Bn-1%7D%20%5C%5C%20y_n%20%5Cend%7Bbmatrix%7D "\begin{bmatrix}
1 & x_1 & x_2 & .. & x_n \\ 
1 & x_1 & x_2 & .. & x_n \\ 
.. & .. & .. & .. & .. \\ 
1 & x_1 & x_2 & .. & x_n \\ 
1 & x_1 & x_2 & .. & x_n 
\end{bmatrix} 
\begin{bmatrix} a \\ b \\ c \\ d \end{bmatrix} = 
\begin{bmatrix} y_1 \\ y_2 \\ .. \\ y_{n-1} \\ y_n \end{bmatrix}")

Saya akan menuliskannya dalam bentuk matriks berikut ini:

![X\_{n \\times m+1} C\_{m+1 \\times 1} = Y\_{m+1 \\times 1}](https://latex.codecogs.com/png.latex?X_%7Bn%20%5Ctimes%20m%2B1%7D%20C_%7Bm%2B1%20%5Ctimes%201%7D%20%3D%20Y_%7Bm%2B1%20%5Ctimes%201%7D "X_{n \times m+1} C_{m+1 \times 1} = Y_{m+1 \times 1}")

Jika pada kasus sebelumnya bentuk matriks yang terlibat adalah
![2 \\times 2](https://latex.codecogs.com/png.latex?2%20%5Ctimes%202 "2 \times 2")
sehingga kita bisa dengan mudah mencari *inverse*-nya. Kali ini bentuk
matriksnya belum tentu *square*.

Dengan menggunakan definisi *error* yang sama dengan sebelumnya:

![error = \\sum\_{i=1}^n di^2 = \\sum\_{i=1}^n (y\_i - f(x\_{1i},x\_{2i},x\_{3i})^2)](https://latex.codecogs.com/png.latex?error%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20di%5E2%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20%28y_i%20-%20f%28x_%7B1i%7D%2Cx_%7B2i%7D%2Cx_%7B3i%7D%29%5E2%29 "error = \sum_{i=1}^n di^2 = \sum_{i=1}^n (y_i - f(x_{1i},x_{2i},x_{3i})^2)")

Lantas bagaimana caranya jika banyak sekali
![n](https://latex.codecogs.com/png.latex?n "n") baris datanya?

Saya akan lakukan *tweaks* seperti ini:

![X^T X C = X^T Y](https://latex.codecogs.com/png.latex?X%5ET%20X%20C%20%3D%20X%5ET%20Y "X^T X C = X^T Y")

Bentuk di atas adalah **bentuk standar** yang sama dengan penjelasan di
regresi linear pada *post* sebelumnya.

Lalu ![C](https://latex.codecogs.com/png.latex?C "C") bisa didapatkan
dengan cara:

![C = (X^T X)^{-1} X^T Y](https://latex.codecogs.com/png.latex?C%20%3D%20%28X%5ET%20X%29%5E%7B-1%7D%20X%5ET%20Y "C = (X^T X)^{-1} X^T Y")

Mudah kan?

------------------------------------------------------------------------

## Contoh Data

Mari kita uji dengan data sebagai berikut:

|        x1 |       x2 |       x3 |          y |
|----------:|---------:|---------:|-----------:|
| 9.4613622 | 5.728766 | 5.613302 |  4.8671258 |
| 4.7552507 | 7.256177 | 3.844687 | -4.9219371 |
| 0.4248520 | 5.805974 | 7.641063 | -1.3056084 |
| 0.8551548 | 5.034001 | 2.932985 |  0.8666642 |
| 4.6697967 | 7.814850 | 5.191525 | -3.1814307 |
| 8.0950196 | 6.993034 | 2.132023 | -0.6851769 |
| 3.0362108 | 5.147998 | 6.680297 | -0.2432966 |
| 3.9336177 | 7.221097 | 6.474840 | -1.3675767 |
| 9.6568974 | 8.365813 | 2.419801 | -8.1331265 |
| 3.7773536 | 5.778266 | 5.588382 | -0.9119664 |

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

    ##       x0        x1       x2       x3
    ##  [1,]  1 9.4613622 5.728766 5.613302
    ##  [2,]  1 4.7552507 7.256177 3.844687
    ##  [3,]  1 0.4248520 5.805974 7.641063
    ##  [4,]  1 0.8551548 5.034001 2.932985
    ##  [5,]  1 4.6697967 7.814850 5.191525
    ##  [6,]  1 8.0950196 6.993034 2.132022
    ##  [7,]  1 3.0362108 5.147998 6.680297
    ##  [8,]  1 3.9336177 7.221097 6.474840
    ##  [9,]  1 9.6568974 8.365813 2.419801
    ## [10,]  1 3.7773536 5.778266 5.588382

Oke, kita akan cari nilai konstantanya sebagai berikut:

``` r
solve(t_X %*% X) %*% t_X %*% Y
```

    ##          [,1]
    ## x0 12.1226798
    ## x1  0.5049704
    ## x2 -2.7614293
    ## x3  0.3932123

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
    ##     12.1227       0.5050      -2.7614       0.3932

Bagaimana? Sama kan hasilnya?

------------------------------------------------------------------------

## *What’s Next?*

Sebagaimana yang telah saya sampaikan pada tulisan sebelumnya, metode
matriks seperti ini akan memudahkan kita saat membuat model-model
regresi (baik linear atau tidak) yang tidak umum. Saya akan tunjukkan
contoh lainnya di tulisan berikutnya.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
