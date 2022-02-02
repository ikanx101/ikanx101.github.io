---
date: 2021-12-02T12:35:00-04:00
title: "Menyelesaikan Persamaan Diophantine Menggunakan Simulasi Monte Carlo"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
  - Kalkulus
  - Matematika
  - Diophantine
---


Beberapa waktu lalu, di suatu mata kuliah, saya diberi tugas untuk
menyelesaikan persamaan *diophantine* berikut ini:

-   Cari solusi dari:
    1.  ![x^2 + y^2 = 625, 0 \\leq x,y \\leq 25](https://latex.codecogs.com/png.latex?x%5E2%20%2B%20y%5E2%20%3D%20625%2C%200%20%5Cleq%20x%2Cy%20%5Cleq%2025 "x^2 + y^2 = 625, 0 \leq x,y \leq 25").
    2.  ![x^3 + y^3 = 1008, 0 \\leq x,y \\leq 50](https://latex.codecogs.com/png.latex?x%5E3%20%2B%20y%5E3%20%3D%201008%2C%200%20%5Cleq%20x%2Cy%20%5Cleq%2050 "x^3 + y^3 = 1008, 0 \leq x,y \leq 50").
    3.  ![x^3 - 3x y^2 - y^3 = 1, -10 \\leq x,y \\leq 10](https://latex.codecogs.com/png.latex?x%5E3%20-%203x%20y%5E2%20-%20y%5E3%20%3D%201%2C%20-10%20%5Cleq%20x%2Cy%20%5Cleq%2010 "x^3 - 3x y^2 - y^3 = 1, -10 \leq x,y \leq 10").
    4.  ![x^2 + y^2 + z^2 = 2445, 0 \\leq x,y,z \\leq 50](https://latex.codecogs.com/png.latex?x%5E2%20%2B%20y%5E2%20%2B%20z%5E2%20%3D%202445%2C%200%20%5Cleq%20x%2Cy%2Cz%20%5Cleq%2050 "x^2 + y^2 + z^2 = 2445, 0 \leq x,y,z \leq 50").

Menggunakan suatu [algoritma optimisasi
spiral](https://en.wikipedia.org/wiki/Spiral_optimization_algorithm).
Suatu saat nanti, saya akan membahas banyak terkait algoritma optimisasi
spiral ini *yah*. Karena algoritma ini tergolong algoritma *meta
heuristic* yang baru dikembangkan, saya butuh satu metode lain untuk
mengecek apakah jawaban saya sudah benar atau belum.

*Top of mind* saya langsung menuju **simulasi Monte Carlo**. Simulasi
sangat *powerful* untuk menyelesaikan berbagai macam masalah matematis
(tentunya dengan *advantages* dan *disadvantages* tersendiri).

------------------------------------------------------------------------

## Persamaan *Diophantine*

Definisi:

> Persamaan diophantine adalah persamaan suku banyak yang masing-masing
> sukunya berupa bilangan bulat (*integer*).

------------------------------------------------------------------------

## Alur Simulasi Monte Carlo

Untuk menyelesaikan persamaan-persamaan di atas dengan simulasi Monte
Carlo, caranya sangat mudah. Berikut adalah *flowchart*-nya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/diophantine/dio_files/figure-gfm/unnamed-chunk-1-1.png" width="672" style="display: block; margin: auto;" />

> Simpel kan?

Ayo, kita akan coba untuk menyelesaikan empat soal di atas.

------------------------------------------------------------------------

## Soal I

![x^2 + y^2 = 625, 0 \\leq x,y \\leq 25](https://latex.codecogs.com/png.latex?x%5E2%20%2B%20y%5E2%20%3D%20625%2C%200%20%5Cleq%20x%2Cy%20%5Cleq%2025 "x^2 + y^2 = 625, 0 \leq x,y \leq 25")

Berikut algoritmanya:

``` r
rm(list=ls())
f = function(x,y) {x^2 + y^2}
iter_max = 4000
solusi = data.frame(x = 1,y = 1)
k = 0
for(i in 1:iter_max){
  X = sample(0:25,2,replace=T)
  if(f(X[1],X[2]) == 625){
    solusi[k+1,] = list(X[1],X[2])
    k = k + 1
    }
}

solusi %>% distinct() %>% arrange(x)
```

    ##    x  y
    ## 1  0 25
    ## 2  7 24
    ## 3 15 20
    ## 4 20 15
    ## 5 24  7
    ## 6 25  0

## Soal II

![x^3 + y^3 = 1008, 0 \\leq x,y \\leq 50](https://latex.codecogs.com/png.latex?x%5E3%20%2B%20y%5E3%20%3D%201008%2C%200%20%5Cleq%20x%2Cy%20%5Cleq%2050 "x^3 + y^3 = 1008, 0 \leq x,y \leq 50")

``` r
rm(list=ls())
f = function(x,y) {x^3 + y^3}
iter_max = 4000
solusi = data.frame(x = 1,y = 1)
k = 0
for(i in 1:iter_max){
  X = sample(0:50,2,replace=T)
  if(f(X[1],X[2]) == 1008){
    solusi[k+1,] = list(X[1],X[2])
    k = k + 1
    }
}

solusi %>% distinct() %>% arrange(x)
```

    ##   x  y
    ## 1 2 10

## Soal III

![x^3 - 3x y^2 - y^3 = 1, -10 \\leq x,y \\leq 10](https://latex.codecogs.com/png.latex?x%5E3%20-%203x%20y%5E2%20-%20y%5E3%20%3D%201%2C%20-10%20%5Cleq%20x%2Cy%20%5Cleq%2010 "x^3 - 3x y^2 - y^3 = 1, -10 \leq x,y \leq 10")

``` r
rm(list=ls())
f = function(x,y) {x^3 - 3*x*y^2 - y^3}
iter_max = 4000
solusi = data.frame(x = 1,y = 1)
k = 0
for(i in 1:iter_max){
  X = sample(-10:10,2,replace=T)
  if(f(X[1],X[2]) == 1){
    solusi[k+1,] = list(X[1],X[2])
    k = k + 1
    }
}

solusi %>% distinct() %>% arrange(x)
```

    ##    x  y
    ## 1 -3  2
    ## 2 -1  1
    ## 3  0 -1
    ## 4  1 -3
    ## 5  1  0
    ## 6  2  1

## Soal IV

![x^2 + y^2 + z^2 = 2445, 0 \\leq x,y,z \\leq 50](https://latex.codecogs.com/png.latex?x%5E2%20%2B%20y%5E2%20%2B%20z%5E2%20%3D%202445%2C%200%20%5Cleq%20x%2Cy%2Cz%20%5Cleq%2050 "x^2 + y^2 + z^2 = 2445, 0 \leq x,y,z \leq 50")

``` r
rm(list=ls())
f = function(x,y,z) {x^2 + y^2 + z^2}
iter_max = 90000
solusi = data.frame(x = 1,y = 1, z = 1)
k = 0
for(i in 1:iter_max){
  X = sample(0:50,3,replace=T)
  if(f(X[1],X[2],X[3]) == 2445){
    solusi[k+1,] = list(X[1],X[2],X[3])
    k = k + 1
    }
}

solusi %>% distinct() %>% arrange(x)
```

    ##     x  y  z
    ## 1   2 29 40
    ## 2   5 22 44
    ## 3   5 44 22
    ## 4   8 34 35
    ## 5  14 32 35
    ## 6  14 43 20
    ## 7  14 20 43
    ## 8  19 22 40
    ## 9  20 43 14
    ## 10 20 37 26
    ## 11 20 26 37
    ## 12 22  5 44
    ## 13 22 44  5
    ## 14 26 13 40
    ## 15 26 37 20
    ## 16 26 40 13
    ## 17 26 20 37
    ## 18 29 40  2
    ## 19 29  2 40
    ## 20 34 35  8
    ## 21 35 32 14
    ## 22 35 14 32
    ## 23 35 34  8
    ## 24 37 20 26
    ## 25 40 22 19
    ## 26 40  2 29
    ## 27 43 14 20
    ## 28 44 22  5


---

`if you find this article helpful, support this blog by clicking the ads.`
