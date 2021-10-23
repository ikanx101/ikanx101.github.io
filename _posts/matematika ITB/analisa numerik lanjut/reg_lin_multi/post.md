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
| 2.858129 | 6.562128 | 7.937261 |   3.0864408 |
| 9.708492 | 5.821518 | 4.216646 |  12.6394032 |
| 4.604466 | 5.591855 | 6.080872 |   7.1563515 |
| 4.871235 | 7.896336 | 4.502112 |   3.5494688 |
| 2.360323 | 6.833700 | 4.791829 |   1.3594765 |
| 8.179789 | 5.948629 | 6.941546 |  10.9744725 |
| 5.450309 | 5.423869 | 6.062742 |   4.2036685 |
| 7.686010 | 6.302933 | 5.228647 | \-0.0614269 |
| 8.981859 | 5.615117 | 3.125266 |   3.7140627 |
| 6.387418 | 7.403743 | 4.305106 | \-3.2419350 |
