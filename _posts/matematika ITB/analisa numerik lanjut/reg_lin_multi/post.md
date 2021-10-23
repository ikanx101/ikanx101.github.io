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
