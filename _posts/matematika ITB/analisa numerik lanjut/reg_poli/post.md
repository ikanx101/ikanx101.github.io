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

|         x |           y |
| --------: | ----------: |
| 0.3351502 |   0.2036132 |
| 2.7272613 |  21.5726159 |
| 1.2506605 |   2.8272006 |
| 4.8731393 |  78.4055491 |
| 4.9549792 | 111.5346550 |
| 1.8568006 |   4.7785320 |
| 0.7190542 |   0.5214829 |
| 4.1751332 |  23.7914419 |
| 1.0248584 |   1.8954666 |
| 2.8593316 |  14.6924435 |

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

    ##       x0        x1         x2           x3
    ##  [1,]  1 0.3351502  0.1123256   0.03764595
    ##  [2,]  1 2.7272613  7.4379544  20.28524536
    ##  [3,]  1 1.2506605  1.5641517   1.95622270
    ##  [4,]  1 4.8731393 23.7474866 115.72481022
    ##  [5,]  1 4.9549792 24.5518184 121.65374828
    ##  [6,]  1 1.8568006  3.4477085   6.40170727
    ##  [7,]  1 0.7190542  0.5170389   0.37177895
    ##  [8,]  1 4.1751332 17.4317373  72.77982532
    ##  [9,]  1 1.0248584  1.0503347   1.07644432
    ## [10,]  1 2.8593316  8.1757771  23.37725755

Oke, kita akan cari nilai konstantanya sebagai berikut:

``` r
solve(t_X %*% X) %*% t_X %*% Y
```

    ##          [,1]
    ## x0 -19.304850
    ## x1  45.572233
    ## x2 -23.533086
    ## x3   3.838491

-----

## *What’s Next?*

Sebagaimana yang telah saya sampaikan pada tulisan sebelumnya, metode
matriks seperti ini akan memudahkan kita saat membuat model-model
regresi (baik linear atau tidak) yang tidak umum. Saya akan tunjukkan
contoh lainnya di tulisan berikutnya.

-----

`if you find this article helpful, support this blog by clicking the
ads.`
