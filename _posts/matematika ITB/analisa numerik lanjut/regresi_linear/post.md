Belajar Membuat Model Regresi Linear - part 1
================

Kita pasti sudah sering mendengar, melihat, bahkan membuat model regresi
linear ![y = ax +
b](https://latex.codecogs.com/png.latex?y%20%3D%20ax%20%2B%20b
"y = ax + b"). Setidaknya saya pernah menulis tiga *posts* terkait
regresi linear:

1.  Bagaimana membuat model regresi linear di **R** dan menguji
    asumsinya di [sini](https://ikanx101.com/blog/belajar-regresi/).
2.  Aplikasi regresi linear pada perhitungan *price elasticity* di
    [sini](https://ikanx101.com/blog/blog-posting-regresi/).
3.  Menentukan apa yang berpengaruh terhadap kebahagiaan di suatu negara
    berdasarkan *World Happiness Index* di
    [sini](https://ikanx101.com/blog/bahagia-survey/).

> ***Tapi belum ada sama sekali tulisan yang menjelaskan bagaimana cara
> menentukan nilai a dan b pada persamaan regresi linear tersebut.***

Nah, kali ini saya akan menjelaskan bagaimana cara kita menentukan nilai
![a](https://latex.codecogs.com/png.latex?a "a") dan
![b](https://latex.codecogs.com/png.latex?b "b") pada persamaan regresi
![y = ax +
b](https://latex.codecogs.com/png.latex?y%20%3D%20ax%20%2B%20b
"y = ax + b").

-----

Misalkan saya memiliki ![n](https://latex.codecogs.com/png.latex?n "n")
pasang data
![(x\_1,y\_1),(x\_2,y\_2),..,(x\_n,y\_n)](https://latex.codecogs.com/png.latex?%28x_1%2Cy_1%29%2C%28x_2%2Cy_2%29%2C..%2C%28x_n%2Cy_n%29
"(x_1,y_1),(x_2,y_2),..,(x_n,y_n)") yang akan saya buat menjadi
persamaan ![f(x) = y =
ax+b](https://latex.codecogs.com/png.latex?f%28x%29%20%3D%20y%20%3D%20ax%2Bb
"f(x) = y = ax+b").

Cita-cita saya adalah memiliki persamaan
![f(x)](https://latex.codecogs.com/png.latex?f%28x%29 "f(x)") yang
**dekat** dengan ![y](https://latex.codecogs.com/png.latex?y "y")
aslinya sehingga menghasilkan prediksi yang **akurat**.

Misalkan saya definisikan *error* sebagai:

  
![error = \\sum\_{i=1}^n
d\_i^2](https://latex.codecogs.com/png.latex?error%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20d_i%5E2
"error = \\sum_{i=1}^n d_i^2")  

di mana ![d\_i](https://latex.codecogs.com/png.latex?d_i "d_i") adalah
**jarak** antara hasil prediksi
![x\_i](https://latex.codecogs.com/png.latex?x_i "x_i") terhadap nilai
*real* ![y\_i](https://latex.codecogs.com/png.latex?y_i "y_i").

Saya bisa menuliskan:

  
![d\_i = y\_i -
f(x\_i)](https://latex.codecogs.com/png.latex?d_i%20%3D%20y_i%20-%20f%28x_i%29
"d_i = y_i - f(x_i)")  

Kita substitusikan kembali nilai
![d\_i](https://latex.codecogs.com/png.latex?d_i "d_i") ke definisi
*error*, sehingga:

  
![error = \\sum\_{i=1}^n ( y\_i - f(x\_i)
)^2](https://latex.codecogs.com/png.latex?error%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20%28%20y_i%20-%20f%28x_i%29%20%29%5E2
"error = \\sum_{i=1}^n ( y_i - f(x_i) )^2")  

  
![error = \\sum\_{i=1}^n ( y\_i - (a x\_i + b)
)^2](https://latex.codecogs.com/png.latex?error%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20%28%20y_i%20-%20%28a%20x_i%20%2B%20b%29%20%29%5E2
"error = \\sum_{i=1}^n ( y_i - (a x_i + b) )^2")  

  
![error = \\sum\_{i=1}^n ( y\_i - a x\_i - b
)^2](https://latex.codecogs.com/png.latex?error%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20%28%20y_i%20-%20a%20x_i%20-%20b%20%29%5E2
"error = \\sum_{i=1}^n ( y_i - a x_i - b )^2")  

-----

Ingat kembali bahwa tujuan mulia saya adalah **meminimumkan error**.
Untuk itu perlu nilai ![a](https://latex.codecogs.com/png.latex?a "a")
dan ![b](https://latex.codecogs.com/png.latex?b "b") yang tepat. Oleh
karena semua data
![(x\_i,y\_i)](https://latex.codecogs.com/png.latex?%28x_i%2Cy_i%29
"(x_i,y_i)") diketahui, maka kita bisa melakukan turunan parsial
terhadap ![a](https://latex.codecogs.com/png.latex?a "a") dan
![b](https://latex.codecogs.com/png.latex?b "b") yang memenuhi:

  
![\\frac{\\delta error}{\\delta a}
= 0](https://latex.codecogs.com/png.latex?%5Cfrac%7B%5Cdelta%20error%7D%7B%5Cdelta%20a%7D%20%3D%200
"\\frac{\\delta error}{\\delta a} = 0")  

  
![\\frac{\\delta error}{\\delta b}
= 0](https://latex.codecogs.com/png.latex?%5Cfrac%7B%5Cdelta%20error%7D%7B%5Cdelta%20b%7D%20%3D%200
"\\frac{\\delta error}{\\delta b} = 0")  

Kita dapatkan:

  
![\\frac{\\delta error}{\\delta a} = -2 \\sum\_{i=1}^n x\_i (y\_i - a
x\_i - b)
= 0](https://latex.codecogs.com/png.latex?%5Cfrac%7B%5Cdelta%20error%7D%7B%5Cdelta%20a%7D%20%3D%20-2%20%5Csum_%7Bi%3D1%7D%5En%20x_i%20%28y_i%20-%20a%20x_i%20-%20b%29%20%3D%200
"\\frac{\\delta error}{\\delta a} = -2 \\sum_{i=1}^n x_i (y_i - a x_i - b) = 0")  

atau bisa ditulis sebagai:

  
![a \\sum\_{i=1}^n x\_i^2 + b \\sum\_{i=1}^n x\_i = \\sum\_{i=1}^n (x\_i
y\_i)](https://latex.codecogs.com/png.latex?a%20%5Csum_%7Bi%3D1%7D%5En%20x_i%5E2%20%2B%20b%20%5Csum_%7Bi%3D1%7D%5En%20x_i%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20%28x_i%20y_i%29
"a \\sum_{i=1}^n x_i^2 + b \\sum_{i=1}^n x_i = \\sum_{i=1}^n (x_i y_i)")  

Kita juga dapatkan:

  
![\\frac{\\delta error}{\\delta b} = -2 \\sum\_{i=1}^n (y\_i - a x\_i -
b)
= 0](https://latex.codecogs.com/png.latex?%5Cfrac%7B%5Cdelta%20error%7D%7B%5Cdelta%20b%7D%20%3D%20-2%20%5Csum_%7Bi%3D1%7D%5En%20%28y_i%20-%20a%20x_i%20-%20b%29%20%3D%200
"\\frac{\\delta error}{\\delta b} = -2 \\sum_{i=1}^n (y_i - a x_i - b) = 0")  

atau bisa ditulis sebagai:

  
![a \\sum\_{i=1}^n x\_i^2 + b n = \\sum\_{i=1}^n
y\_i](https://latex.codecogs.com/png.latex?a%20%5Csum_%7Bi%3D1%7D%5En%20x_i%5E2%20%2B%20b%20n%20%3D%20%5Csum_%7Bi%3D1%7D%5En%20y_i
"a \\sum_{i=1}^n x_i^2 + b n = \\sum_{i=1}^n y_i")  

  
![\\begin{bmatrix}
& \\\\ 
& 
\\end{bmatrix}](https://latex.codecogs.com/png.latex?%5Cbegin%7Bbmatrix%7D%0A%20%26%20%5C%5C%20%0A%20%26%20%0A%5Cend%7Bbmatrix%7D
"\\begin{bmatrix}
 & \\\\ 
 & 
\\end{bmatrix}")
