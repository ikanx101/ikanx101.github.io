---
date: 2021-10-24T16:46:00-04:00
title: "Belajar Membuat Model Regresi Linear - part 3 (Polinomial)"
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
  - Polinom
---

Pada tulisan [sebelumnya](https://ikanx101.com/blog/multi-linear/) saya
telah menjelaskan bagaimana caranya membuat persamaan regresi linear
banyak peubah peubah (![x\_i,i
= 1,2,..,n](https://latex.codecogs.com/png.latex?x_i%2Ci%20%3D%201%2C2%2C..%2Cn
"x_i,i = 1,2,..,n") dan ![y](https://latex.codecogs.com/png.latex?y
"y")) **dari nol**. Sekarang kita akan “naik kelas” lagi untuk membuat
fungsi regresi polinomial untuk satu peubah. Apa maksudnya?

> Kita akan membuat fungsi curve fitting yang nonlinear.

Misalkan saya memiliki ![m](https://latex.codecogs.com/png.latex?m "m")
buah pasang data sebagai berikut:
![(x,y)](https://latex.codecogs.com/png.latex?%28x%2Cy%29 "(x,y)"), lalu
kita hendak membuat persamaan regresi berikut ini: ![f(x) = y = a\_0 +
a\_1 x + a\_2 x^2 + a\_3 x^3 + .. + a\_n
x^n](https://latex.codecogs.com/png.latex?f%28x%29%20%3D%20y%20%3D%20a_0%20%2B%20a_1%20x%20%2B%20a_2%20x%5E2%20%2B%20a_3%20x%5E3%20%2B%20..%20%2B%20a_n%20x%5En
"f(x) = y = a_0 + a_1 x + a_2 x^2 + a_3 x^3 + .. + a_n x^n").

Bagaimana cara kita melakukannya?

-----

Pada tulisan sebelumnya, saya mendefinisikan *error* sebagai **jarak**
antara nilai *real* dan nilai prediksi. Kali ini sama saja. Kita
menggunakan definisi dan cara perhitungan yang sama.

Misalkan saya memiliki ![m](https://latex.codecogs.com/png.latex?m "m")
buah data dengan ![n](https://latex.codecogs.com/png.latex?n "n") banyak
pangkat polinom. Maka ekspektasi kita adalah:

  
![\\begin{bmatrix}
1 & x & x^2 & .. & x^n \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
.. & .. & .. & .. & .. \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
\\end{bmatrix} 
\\begin{bmatrix} a0 \\\\ a1 \\\\ a2 \\\\ .. \\\\ an \\end{bmatrix} = 
\\begin{bmatrix} y\_1 \\\\ y\_2 \\\\ .. \\\\ y\_m
\\end{bmatrix}](https://latex.codecogs.com/png.latex?%5Cbegin%7Bbmatrix%7D%0A1%20%26%20x%20%26%20x%5E2%20%26%20..%20%26%20x%5En%20%5C%5C%20%0A1%20%26%20x%20%26%20x%5E2%20%26%20..%20%26%20x%5En%20%5C%5C%20%0A..%20%26%20..%20%26%20..%20%26%20..%20%26%20..%20%5C%5C%20%0A1%20%26%20x%20%26%20x%5E2%20%26%20..%20%26%20x%5En%20%5C%5C%20%0A1%20%26%20x%20%26%20x%5E2%20%26%20..%20%26%20x%5En%20%5C%5C%20%20%0A%5Cend%7Bbmatrix%7D%20%0A%5Cbegin%7Bbmatrix%7D%20a0%20%5C%5C%20a1%20%5C%5C%20a2%20%5C%5C%20..%20%5C%5C%20an%20%5Cend%7Bbmatrix%7D%20%3D%20%0A%5Cbegin%7Bbmatrix%7D%20y_1%20%5C%5C%20y_2%20%5C%5C%20..%20%5C%5C%20y_m%20%5Cend%7Bbmatrix%7D
"\\begin{bmatrix}
1 & x & x^2 & .. & x^n \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
.. & .. & .. & .. & .. \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
1 & x & x^2 & .. & x^n \\\\  
\\end{bmatrix} 
\\begin{bmatrix} a0 \\\\ a1 \\\\ a2 \\\\ .. \\\\ an \\end{bmatrix} = 
\\begin{bmatrix} y_1 \\\\ y_2 \\\\ .. \\\\ y_m \\end{bmatrix}")  

Dengan prinsip yang sama dengan sebelumnya, saya akan tuliskan sebagai:

  
![X^T X C = X^T
Y](https://latex.codecogs.com/png.latex?X%5ET%20X%20C%20%3D%20X%5ET%20Y
"X^T X C = X^T Y")  

Dengan menggunakan definisi *error* yang sama dengan sebelumnya:

  
![error = \\sum\_{i=1}^n di^2 = \\sum\_{i=1}^n (y\_i -
f(x))^2](https://latex.codecogs.com/png.latex?error%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20di%5E2%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20%28y_i%20-%20f%28x%29%29%5E2
"error = \\sum_{i=1}^n di^2 = \\sum_{i=1}^n (y_i - f(x))^2")  

Lantas bagaimana caranya jika banyak sekali
![n](https://latex.codecogs.com/png.latex?n "n") baris datanya?

Saya akan lakukan *tweaks* seperti berikut sehingga
![C](https://latex.codecogs.com/png.latex?C "C") bisa didapatkan dengan
cara:

  
![C = (X^T X)^{-1} X^T
Y](https://latex.codecogs.com/png.latex?C%20%3D%20%28X%5ET%20X%29%5E%7B-1%7D%20X%5ET%20Y
"C = (X^T X)^{-1} X^T Y")  

Sama persis dengan kasus sebelumnya.

-----

## Contoh Data

Mari kita uji dengan data sebagai berikut:

|         x |         y |
| --------: | --------: |
| 0.1030594 |  10.03643 |
| 6.6158269 | 108.52542 |
| 6.6398528 |  58.55689 |
| 5.9707812 |  36.79973 |
| 6.0138707 |  82.08803 |
| 6.1532501 | 128.75940 |
| 1.7079283 |  12.43348 |
| 4.0524876 |  42.71331 |
| 5.2412899 |  55.77129 |
| 3.2658923 |  27.75798 |

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika ITB/analisa numerik lanjut/reg_poli/post_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

dan saya akan membuat fungsi regresi polinm orde 3 berikut: ![y = a\_0 +
a\_1 x + a\_2 x^2 + a\_3
x^3](https://latex.codecogs.com/png.latex?y%20%3D%20a_0%20%2B%20a_1%20x%20%2B%20a_2%20x%5E2%20%2B%20a_3%20x%5E3
"y = a_0 + a_1 x + a_2 x^2 + a_3 x^3").

Pertama-tama kita akan buat matriks sebagai berikut:

``` r
n = length(x)
x0 = rep(1,n)
X = cbind(x0,x1 = x,x2 = x^2,x3 = x^3)
t_X = t(X)
Y = y

# matriks X
X
```

    ##       x0        x1          x2           x3
    ##  [1,]  1 0.1030594  0.01062125   0.00109462
    ##  [2,]  1 6.6158269 43.76916561 289.56922339
    ##  [3,]  1 6.6398528 44.08764554 292.73547778
    ##  [4,]  1 5.9707812 35.65022847 212.85971489
    ##  [5,]  1 6.0138707 36.16664115 217.50150461
    ##  [6,]  1 6.1532501 37.86248731 232.97735542
    ##  [7,]  1 1.7079283  2.91701910   4.98205950
    ##  [8,]  1 4.0524876 16.42265599  66.55261024
    ##  [9,]  1 5.2412899 27.47111992 143.98410361
    ## [10,]  1 3.2658923 10.66605234  34.83417790

Oke, kita akan cari nilai konstantanya sebagai berikut:

``` r
solve(t_X %*% X) %*% t_X %*% Y
```

    ##         [,1]
    ## x0 10.752155
    ## x1 -5.219467
    ## x2  3.831712
    ## x3 -0.188765

Maka kita dapatkan persamaan sebagai berikut:

y = 10.752 + (-5.219) x + (3.832) x^2 + (-0.189 x^3)

Mari kita prediksi nilai ![y](https://latex.codecogs.com/png.latex?y
"y") dan kita hitung *error*-nya.

|         x |         y | prediksi\_y |    error |
| --------: | --------: | ----------: | -------: |
| 0.1030594 |  10.03643 |    10.25463 |  \-0.218 |
| 6.6158269 | 108.52542 |    89.21886 |   19.307 |
| 6.6398528 |  58.55689 |    89.71546 | \-31.159 |
| 5.9707812 |  36.79973 |    75.97168 | \-39.172 |
| 6.0138707 |  82.08803 |    76.84839 |    5.240 |
| 6.1532501 | 128.75940 |    79.69452 |   49.065 |
| 1.7079283 |  12.43348 |    12.07473 |    0.359 |
| 4.0524876 |  42.71331 |    39.95524 |    2.758 |
| 5.2412899 |  55.77129 |    61.45404 |  \-5.683 |
| 3.2658923 |  27.75798 |    27.99596 |  \-0.238 |

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika ITB/analisa numerik lanjut/reg_poli/post_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

-----

## *What’s Next?*

Sebagaimana yang telah saya sampaikan pada tulisan sebelumnya, metode
matriks seperti ini akan memudahkan kita saat membuat model-model
regresi (baik linear atau tidak) yang tidak umum. Saya akan tunjukkan
contoh lainnya di tulisan berikutnya.

-----

`if you find this article helpful, support this blog by clicking the
ads.`
