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

### Iterasi Jacobi

Cara berikutnya adalah dengan membuat iterasi Jacobi berdasarkan formula
per variabel ![x,y,z](https://latex.codecogs.com/png.latex?x%2Cy%2Cz
"x,y,z"). Salah satu syarat agar bisa melakukan iterasi ini adalah
dengan membuat bentuk dominan diagonal. Yakni, masing-masing variabel
harus memiliki konstanta terbesar. Bentuk formulanya adalah sebagai
berikut:

  
![x = \\frac{7 + y -
z}{4}](https://latex.codecogs.com/png.latex?x%20%3D%20%5Cfrac%7B7%20%2B%20y%20-%20z%7D%7B4%7D
"x = \\frac{7 + y - z}{4}")  

  
![y = \\frac{21 + 4x +
z}{8}](https://latex.codecogs.com/png.latex?y%20%3D%20%5Cfrac%7B21%20%2B%204x%20%2B%20z%7D%7B8%7D
"y = \\frac{21 + 4x + z}{8}")  

  
![z = \\frac{15 + 2x -
y}{5}](https://latex.codecogs.com/png.latex?z%20%3D%20%5Cfrac%7B15%20%2B%202x%20-%20y%7D%7B5%7D
"z = \\frac{15 + 2x - y}{5}")  

Lantas bentuk iterasinya adalah sebagai berikut:

  
![x^{k+1} = \\frac{7 + y^k -
z^k}{4}](https://latex.codecogs.com/png.latex?x%5E%7Bk%2B1%7D%20%3D%20%5Cfrac%7B7%20%2B%20y%5Ek%20-%20z%5Ek%7D%7B4%7D
"x^{k+1} = \\frac{7 + y^k - z^k}{4}")  

  
![y^{k+1} = \\frac{21 + 4x^k +
z^k}{8}](https://latex.codecogs.com/png.latex?y%5E%7Bk%2B1%7D%20%3D%20%5Cfrac%7B21%20%2B%204x%5Ek%20%2B%20z%5Ek%7D%7B8%7D
"y^{k+1} = \\frac{21 + 4x^k + z^k}{8}")  

  
![z^{k+1} = \\frac{15 + 2x^k -
y^k}{5}](https://latex.codecogs.com/png.latex?z%5E%7Bk%2B1%7D%20%3D%20%5Cfrac%7B15%20%2B%202x%5Ek%20-%20y%5Ek%7D%7B5%7D
"z^{k+1} = \\frac{15 + 2x^k - y^k}{5}")  

Dengan mengambil sebarang nilai
![x,y,z](https://latex.codecogs.com/png.latex?x%2Cy%2Cz "x,y,z"),
diharapkan iterasi Jacobi akan mengantarkan kita ke nilai solusinya.

Misalkan kita gunakan nilai awal ![x\_0 = 10, y\_0 = 20, z\_0
= 30](https://latex.codecogs.com/png.latex?x_0%20%3D%2010%2C%20y_0%20%3D%2020%2C%20z_0%20%3D%2030
"x_0 = 10, y_0 = 20, z_0 = 30").

``` r
# set initial values
x = c(10)
y = c(20)
z = c(30)

# menentukan berapa iterasi maksimal
max_iter = 17

# melakukan iterasi
for(i in 2:max_iter){
  x[i] = (7 + y[i-1] - z[i-1])/(4)
  y[i] = (21 + 4 * x[i-1] + z[i-1])/(8)
  z[i] = 15 + 2 * x[i-1] - y[i-1]
}

data.frame(id = 1:max_iter,x,y,z)
```

    ##    id           x         y         z
    ## 1   1 10.00000000 20.000000 30.000000
    ## 2   2 -0.75000000 11.375000 15.000000
    ## 3   3  0.84375000  4.125000  2.125000
    ## 4   4  2.25000000  3.312500 12.562500
    ## 5   5 -0.56250000  5.320312 16.187500
    ## 6   6 -0.96679688  4.367188  8.554688
    ## 7   7  0.70312500  3.210938  8.699219
    ## 8   8  0.37792969  4.063965 13.195312
    ## 9   9 -0.53283691  4.463379 11.691895
    ## 10 10 -0.05712891  3.820068  9.470947
    ## 11 11  0.33728027  3.780304 11.065674
    ## 12 12 -0.07134247  4.176849 11.894257
    ## 13 13 -0.17935181  4.076111 10.680466
    ## 14 14  0.09891129  3.870382 10.565186
    ## 15 15  0.07629919  3.995104 11.327440
    ## 16 16 -0.08308411  4.079080 11.157495
    ## 17 17 -0.01960373  3.978145 10.754752
