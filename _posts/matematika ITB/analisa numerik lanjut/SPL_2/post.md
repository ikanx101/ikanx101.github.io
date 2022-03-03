Menyelesaikan Sistem Persamaan Linear dengan Metode Eksak dan Meta
Heuristic
================

Tahun lalu, saya sempat menulis tentang bagaimana [menyelesaikan suatu
sistem persamaan linear (SPL) dengan mudah dengan
**R**](https://ikanx101.com/blog/ig-spl/).

Saya baru menyadari bahwa saya belum pernah sama sekali membahas terkait
SPL pada blog saya ini. Oleh karena itu, saya akan coba ulas secara
simpel bagaimana kita mencari solusi dari SPL dengan berbagai macam
cara.

Misalkan saya memiliki suatu SPL sebagai berikut:

  
![4x - y + z
= 7](https://latex.codecogs.com/png.latex?4x%20-%20y%20%2B%20z%20%3D%207
"4x - y + z = 7")  

  
![4x - 8y + z =
-21](https://latex.codecogs.com/png.latex?4x%20-%208y%20%2B%20z%20%3D%20-21
"4x - 8y + z = -21")  

  
![-2x + y + 5z
= 15](https://latex.codecogs.com/png.latex?-2x%20%2B%20y%20%2B%205z%20%3D%2015
"-2x + y + 5z = 15")  

Kita akan mencari solusi
![x,y,z](https://latex.codecogs.com/png.latex?x%2Cy%2Cz "x,y,z") yang
memenuhi SPL di atas.

Setidaknya ada dua metode atau pendekatan yang bisa dilakukan untuk
mencari solusi dari SPL, yakni:

1.  Metode eksak, dan
2.  Metode *meta heuristic*.

Metode eksak adalah metode yang berdasarkan pendekatan matematis
sedangkan metode *meta heuristic* berdasarkan pendekatan yang
terinspirasi dari *natural events* seperti yang saya bahas pada tulisan
sebelumnya (*black hole* dan *spiral dynamic*).

## Metode Eksak

Untuk menyelesaikan SPL dengan metode eksak, ada banyak sekali caranya.
Kali ini saya akan membahas dua cara, yakni:

1.  Invers matriks, dan
2.  Iterasi Jacobi.

### Invers Matriks

Cara ini adalah cara yang paling populer diketahui oleh banyak orang.
Suatu SPL bisa dibuat dalam bentuk perkalian matriks dengan vektor
sebagai berikut:

  
![Ax = b](https://latex.codecogs.com/png.latex?Ax%20%3D%20b "Ax = b")  

Maka untuk mencari ![x](https://latex.codecogs.com/png.latex?x "x") kita
cukup mencari invers dari matriks
![A](https://latex.codecogs.com/png.latex?A "A"), sehingga:

  
![x =
A^{-1}b](https://latex.codecogs.com/png.latex?x%20%3D%20A%5E%7B-1%7Db
"x = A^{-1}b")  

Maka untuk contoh soal di atas, kita bisa melakukan hal berikut di
**R**:

``` r
A = matrix(c(4,-1,1,4,-8,1,-2,1,5),byrow = T,nrow = 3)
b = c(7,-21,15)

A_inv = solve(A)

# solusi
A_inv %*% b
```

    ##      [,1]
    ## [1,]    2
    ## [2,]    4
    ## [3,]    3
