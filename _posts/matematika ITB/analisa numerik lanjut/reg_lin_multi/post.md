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
| 1.649215 | 7.521153 | 6.029216 | \-1.3149105 |
| 3.741852 | 5.885577 | 7.333196 | \-0.0050467 |
| 6.983047 | 7.125881 | 7.469309 |   8.2287595 |
| 1.530833 | 8.507353 | 7.932905 | \-2.4123850 |
| 4.087629 | 8.578137 | 7.211916 | \-7.8442179 |
| 3.456282 | 7.140203 | 6.012548 |  12.5187457 |
| 9.581227 | 8.112684 | 2.457265 |   6.4383974 |
| 3.697187 | 5.865884 | 6.576142 |   3.5650626 |
| 6.483510 | 7.940257 | 2.178899 |  10.3849366 |
| 8.422693 | 6.325759 | 7.758225 |   8.5803755 |

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
    ##  [1,]  1 1.649215 7.521153 6.029216
    ##  [2,]  1 3.741852 5.885577 7.333196
    ##  [3,]  1 6.983047 7.125881 7.469309
    ##  [4,]  1 1.530833 8.507353 7.932905
    ##  [5,]  1 4.087629 8.578137 7.211916
    ##  [6,]  1 3.456282 7.140203 6.012548
    ##  [7,]  1 9.581227 8.112684 2.457265
    ##  [8,]  1 3.697187 5.865884 6.576142
    ##  [9,]  1 6.483510 7.940257 2.178899
    ## [10,]  1 8.422693 6.325759 7.758225

Oke, kita akan cari nilai konstantanya sebagai berikut:

``` r
solve(t_X %*% X) %*% t_X %*% Y
```

    ##         [,1]
    ## x0 26.563936
    ## x1  0.823424
    ## x2 -2.662613
    ## x3 -1.213764

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
    ##     26.5639       0.8234      -2.6626      -1.2138

Bagaimana? Sama kan hasilnya?

-----

## *What’s Next?*

Sebagaimana yang telah saya sampaikan pada tulisan sebelumnya, metode
matriks seperti ini akan memudahkan kita saat membuat model-model
regresi (baik linear atau tidak) yang tidak umum. Saya akan tunjukkan
contoh lainnya di tulisan berikutnya.

-----

`if you find this article helpful, support this blog by clicking the
ads.`
