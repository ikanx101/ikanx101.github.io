Belajar Membuat Model Regresi Linear - part 3 (Polinomial)
================

Pada tulisan [sebelumnya](https://ikanx101.com/blog/multi-linear/) saya
telah menjelaskan bagaimana caranya membuat persamaan regresi linear
banyak peubah peubah (![x\_i,i
= 1,2,..,n](https://latex.codecogs.com/png.latex?x_i%2Ci%20%3D%201%2C2%2C..%2Cn
"x_i,i = 1,2,..,n") dan ![y](https://latex.codecogs.com/png.latex?y
"y")) **dari nol**. Sekarang kita akan “naik kelas” lagi untuk membuat
fungsi regresi polinomial untuk satu peubah. Apa maksudnya?

> Kita akan membuat fungsi curve fitting yang nonlinear.

Misalkan saya memiliki ![n](https://latex.codecogs.com/png.latex?n "n")
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

Misalkan saya memiliki ![n](https://latex.codecogs.com/png.latex?n "n")
buah data dengan ![m](https://latex.codecogs.com/png.latex?m "m") banyak
pangkat polinom. Maka ekspektasi kita adalah:

  
![\\begin{bmatrix}
1 & x & x^2 & .. & x^n \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
.. & .. & .. & .. & .. \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
\\end{bmatrix} 
\\begin{bmatrix} a0 \\\\ a1 \\\\ a2 \\\\ .. \\\\ an \\end{bmatrix} = 
\\begin{bmatrix} y\_1 \\\\ y\_2 \\\\ .. \\\\ y\_n
\\end{bmatrix}](https://latex.codecogs.com/png.latex?%5Cbegin%7Bbmatrix%7D%0A1%20%26%20x%20%26%20x%5E2%20%26%20..%20%26%20x%5En%20%5C%5C%20%0A1%20%26%20x%20%26%20x%5E2%20%26%20..%20%26%20x%5En%20%5C%5C%20%0A..%20%26%20..%20%26%20..%20%26%20..%20%26%20..%20%5C%5C%20%0A1%20%26%20x%20%26%20x%5E2%20%26%20..%20%26%20x%5En%20%5C%5C%20%0A1%20%26%20x%20%26%20x%5E2%20%26%20..%20%26%20x%5En%20%5C%5C%20%20%0A%5Cend%7Bbmatrix%7D%20%0A%5Cbegin%7Bbmatrix%7D%20a0%20%5C%5C%20a1%20%5C%5C%20a2%20%5C%5C%20..%20%5C%5C%20an%20%5Cend%7Bbmatrix%7D%20%3D%20%0A%5Cbegin%7Bbmatrix%7D%20y_1%20%5C%5C%20y_2%20%5C%5C%20..%20%5C%5C%20y_n%20%5Cend%7Bbmatrix%7D
"\\begin{bmatrix}
1 & x & x^2 & .. & x^n \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
.. & .. & .. & .. & .. \\\\ 
1 & x & x^2 & .. & x^n \\\\ 
1 & x & x^2 & .. & x^n \\\\  
\\end{bmatrix} 
\\begin{bmatrix} a0 \\\\ a1 \\\\ a2 \\\\ .. \\\\ an \\end{bmatrix} = 
\\begin{bmatrix} y_1 \\\\ y_2 \\\\ .. \\\\ y_n \\end{bmatrix}")  

Dengan prinsip yang sama dengan sebelumnya, saya akan tuliskan sebagai:

  
![X^T X C = X^T
Y](https://latex.codecogs.com/png.latex?X%5ET%20X%20C%20%3D%20X%5ET%20Y
"X^T X C = X^T Y")  

Bentuk di atas adalah **bentuk standar** yang sama dengan penjelasan di
regresi linear pada *post* sebelumnya. Saya akan menuliskannya dalam
bentuk matriks berikut ini:

  
![X\_{n \\times m+1} C\_{m+1 \\times 1} = Y\_{m+1
\\times 1}](https://latex.codecogs.com/png.latex?X_%7Bn%20%5Ctimes%20m%2B1%7D%20C_%7Bm%2B1%20%5Ctimes%201%7D%20%3D%20Y_%7Bm%2B1%20%5Ctimes%201%7D
"X_{n \\times m+1} C_{m+1 \\times 1} = Y_{m+1 \\times 1}")  

Jika pada kasus sebelumnya bentuk matriks yang terlibat adalah ![2
\\times 2](https://latex.codecogs.com/png.latex?2%20%5Ctimes%202
"2 \\times 2") sehingga kita bisa dengan mudah mencari *inverse*-nya.
Kali ini bentuk matriksnya belum tentu *square*.

Dengan menggunakan definisi *error* yang sama dengan sebelumnya:

  
![error = \\sum\_{i=1}^n di^2 = \\sum\_{i=1}^n (y\_i -
f(x\_{1i},x\_{2i},x\_{3i})^2)](https://latex.codecogs.com/png.latex?error%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20di%5E2%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20%28y_i%20-%20f%28x_%7B1i%7D%2Cx_%7B2i%7D%2Cx_%7B3i%7D%29%5E2%29
"error = \\sum_{i=1}^n di^2 = \\sum_{i=1}^n (y_i - f(x_{1i},x_{2i},x_{3i})^2)")  

Lantas bagaimana caranya jika banyak sekali
![n](https://latex.codecogs.com/png.latex?n "n") baris datanya?

Saya akan lakukan *tweaks* seperti ini:

Lalu ![C](https://latex.codecogs.com/png.latex?C "C") bisa didapatkan
dengan cara:

  
![C = (X^T X)^{-1} X^T
Y](https://latex.codecogs.com/png.latex?C%20%3D%20%28X%5ET%20X%29%5E%7B-1%7D%20X%5ET%20Y
"C = (X^T X)^{-1} X^T Y")  

Mudah kan?

-----

## Contoh Data

Mari kita uji dengan data sebagai berikut:

|        x |          y |
| -------: | ---------: |
| 5.272508 |  87.541046 |
| 6.628300 |  82.100657 |
| 6.137938 | 231.399892 |
| 4.001729 |  68.721771 |
| 3.509921 |  18.823964 |
| 2.435650 |  10.386268 |
| 6.844512 | 187.824428 |
| 6.971316 | 290.538068 |
| 6.441203 | 127.699133 |
| 3.037840 |   9.674683 |

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

    ##       x0       x1        x2        x3
    ##  [1,]  1 5.272508 27.799337 146.57222
    ##  [2,]  1 6.628300 43.934367 291.21018
    ##  [3,]  1 6.137938 37.674285 231.24244
    ##  [4,]  1 4.001729 16.013832  64.08301
    ##  [5,]  1 3.509921 12.319546  43.24063
    ##  [6,]  1 2.435650  5.932393  14.44923
    ##  [7,]  1 6.844512 46.847340 320.64717
    ##  [8,]  1 6.971316 48.599240 338.80064
    ##  [9,]  1 6.441203 41.489093 267.23966
    ## [10,]  1 3.037840  9.228474  28.03463

Oke, kita akan cari nilai konstantanya sebagai berikut:

``` r
solve(t_X %*% X) %*% t_X %*% Y
```

    ##           [,1]
    ## x0 -207.657297
    ## x1  143.562336
    ## x2  -30.466182
    ## x3    2.669422

Maka kita dapatkan persamaan sebagai berikut:

y = -207.657 + (143.562) x + (-30.466) x^2 + (2.669 x^3)

Mari kita prediksi nilai ![y](https://latex.codecogs.com/png.latex?y
"y") dan kita hitung *error*-nya.

|        x |          y | prediksi\_y |     error |
| -------: | ---------: | ----------: | --------: |
| 5.272508 |  87.541046 |  93.5413919 |   \-6.000 |
| 6.628300 |  82.100657 | 182.6506276 | \-100.550 |
| 6.137938 | 231.399892 | 142.9189668 |    88.481 |
| 4.001729 |  68.721771 |  49.9993133 |    18.722 |
| 3.509921 |  18.823964 |  36.3162552 |  \-17.492 |
| 2.435650 |  10.386268 | \-0.1614325 |    10.548 |
| 6.844512 | 187.824428 | 203.5110089 |  \-15.687 |
| 6.971316 | 290.538068 | 216.7934498 |    73.745 |
| 6.441203 | 127.699133 | 166.3108982 |  \-38.612 |
| 3.037840 |   9.674683 |  22.1311784 |  \-12.456 |

-----

## *What’s Next?*

Sebagaimana yang telah saya sampaikan pada tulisan sebelumnya, metode
matriks seperti ini akan memudahkan kita saat membuat model-model
regresi (baik linear atau tidak) yang tidak umum. Saya akan tunjukkan
contoh lainnya di tulisan berikutnya.

-----

`if you find this article helpful, support this blog by clicking the
ads.`
