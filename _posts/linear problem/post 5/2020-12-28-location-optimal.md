---
date: 2020-12-28T09:19:00-04:00
title: "Optimization Story: Menentukan Letak Pool Taxi dengan Mixed Integer Linear Programming"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Linear Programming
  - Aljabar
  - Binary Linear Programming
  - MILP
  - Mixed Integer Linear Programming
  - Location
  - Longlat
  - Spasial
---


Beberapa waktu lalu, saya dan beberapa rekan di kantor berdiskusi ringan
mengenai data spasial (*longlat location*).

> Apa sih faedahnya jika kita memiliki data spasial?

Ada beberapa hal yang bisa kita lakukan. Salah satunya adalah menentukan
rute terbaik dengan algoritma TSP. Tapi ada satu hal yang belum pernah
lakukan. Apa itu?

> Sekarang saya akan mengawinkan antara optimisasi *mixed integer linear
> programming* dengan analisa spasial.

Optimisasi ini bisa digunakan untuk berbagai macam kasus, tapi kali ini
saya akan menggunakan kasus yang umum terjadi saja *yah*. Nanti jika ada
kasus berbeda tapi mirip-mirip cara berpikirnya, kita tinggal mengubah
formulasi matematikanya saja.

-----

# *Problem*

Suatu perusahaan taxi sedang mempertimbangkan untuk membangun beberapa
*pool taxi* untuk mendekatkan mereka kepada konsumen-konsumennya. Mereka
memiliki data lokasi-lokasi mana saja memiliki *high demand* terhadap
taxi mereka.

Tercatat ada 200 buah lokasi yang memiliki *high demand*. Mereka juga
telah melakukan survey terhadap 40 buah calon lokasi *pool* taxi.
Masing-masing calon lokasi *pool* taxi tersebut memiliki harga sewa yang
beragam.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/linear%20problem/post%205/post_files/figure-gfm/unnamed-chunk-1-1.png" width="672" style="display: block; margin: auto;" />

Berikut adalah biaya yang dibutuhkan untuk menyewa dan me-*maintain*
masing-masing calon lokasi *pool* taxi tersebut:

    ## Tabel Biaya yang Akan Dikeluarkan

| id\_calon\_pool | total\_biaya |
| --------------: | -----------: |
|               1 |          320 |
|               2 |          450 |
|               3 |          390 |
|               4 |          300 |
|               5 |          380 |
|               6 |          420 |
|               7 |          430 |
|               8 |          430 |
|               9 |          450 |
|              10 |          340 |
|              11 |          340 |
|              12 |          450 |
|              13 |          430 |
|              14 |          450 |
|              15 |          350 |
|              16 |          450 |
|              17 |          400 |
|              18 |          310 |
|              19 |          340 |
|              20 |          430 |
|              21 |          340 |
|              22 |          430 |
|              23 |          370 |
|              24 |          380 |
|              25 |          390 |
|              26 |          400 |
|              27 |          440 |
|              28 |          310 |
|              29 |          430 |
|              30 |          310 |
|              31 |          410 |
|              32 |          380 |
|              33 |          340 |
|              34 |          440 |
|              35 |          310 |
|              36 |          390 |
|              37 |          430 |
|              38 |          330 |
|              39 |          370 |
|              40 |          420 |

Permasalahannya:

Perusahaan taxi tersebut memiliki *budget* dan sumber daya terbatas.
Oleh karena itu mereka perlu mencari berapa jumlah *pool* taxi yang
seminimum mungkin tapi tetap *covering* area-area *high demand*
tersebut.

# Formulasi Matematika

Oke, sekarang saya mulai bagian serunya. Inti permasalahan ini
sebenarnya adalah:

> Memasangkan lokasi-lokasi *high demand* secara optimal dengan beberapa
> calon lokasi *pool taxi*.

Misalkan ![i](https://latex.codecogs.com/png.latex?i "i") menandakan
banyaknya lokasi *high demand*, ![i
= 1,2,...,200](https://latex.codecogs.com/png.latex?i%20%3D%201%2C2%2C...%2C200
"i = 1,2,...,200").

Sedangkan ![j](https://latex.codecogs.com/png.latex?j "j") menandakan
berapa banyak calon lokasi *pool* taxi ![j
= 1,2,...,40](https://latex.codecogs.com/png.latex?j%20%3D%201%2C2%2C...%2C40
"j = 1,2,...,40").

Lalu ![x\[i,j\]](https://latex.codecogs.com/png.latex?x%5Bi%2Cj%5D
"x[i,j]") merupakan bilangan biner (0,1) yang menandakan:

  - `0` jika lokasi *high demand* ke
    ![i](https://latex.codecogs.com/png.latex?i "i") tidak dipasangkan
    dengan calon lokasi *pool* taxi ke
    ![j](https://latex.codecogs.com/png.latex?j "j").
  - `1` jika lokasi *high demand* ke
    ![i](https://latex.codecogs.com/png.latex?i "i") dipasangkan dengan
    calon lokasi *pool* taxi ke
    ![j](https://latex.codecogs.com/png.latex?j "j").

Lalu ![y\[j\]](https://latex.codecogs.com/png.latex?y%5Bj%5D "y[j]")
merupakan bilangan biner (0,1) yang menandakan:

  - `0` jika calon lokasi *pool* taxi ke
    ![j](https://latex.codecogs.com/png.latex?j "j") tidak perlu disewa.
  - `1` jika calon lokasi *pool* taxi ke
    ![j](https://latex.codecogs.com/png.latex?j "j") perlu disewa.

## *Constraints*

Kita ketahui bahwa satu lokasi *high demand* hanya boleh di-*cover* oleh
satu *pool* taxi saja.

  
![\\sum\_{j=1}^{40} x\[i,j\]
= 1](https://latex.codecogs.com/png.latex?%5Csum_%7Bj%3D1%7D%5E%7B40%7D%20x%5Bi%2Cj%5D%20%3D%201
"\\sum_{j=1}^{40} x[i,j] = 1")  

untuk
![i=1,2,..,200](https://latex.codecogs.com/png.latex?i%3D1%2C2%2C..%2C200
"i=1,2,..,200").

Lalu saat ada lokasi *high demand*
![i](https://latex.codecogs.com/png.latex?i "i") yang di-*cover* oleh
*pool* ![j](https://latex.codecogs.com/png.latex?j "j")
(![x\[i,j\]=1](https://latex.codecogs.com/png.latex?x%5Bi%2Cj%5D%3D1
"x[i,j]=1")), maka *pool* ![j](https://latex.codecogs.com/png.latex?j
"j") harus dibangun
(![y\[j\]=1](https://latex.codecogs.com/png.latex?y%5Bj%5D%3D1
"y[j]=1")).

  
![x\[i,j\] \\leq
y\[j\]](https://latex.codecogs.com/png.latex?x%5Bi%2Cj%5D%20%5Cleq%20y%5Bj%5D
"x[i,j] \\leq y[j]")  

## *Objective Functions*

Setidaknya ada dua kondisi yang kita wajibkan agar pemilihan *pool* ini
optimal:

1.  Total jarak antara *pool* dan lokasi-lokasi *high demand* yang
    di-*cover* olehnya harus terpendek. Kenapa? Semakin jauh, maka
    *transportation cost* yang dikeluarkan juga semakin besar.
2.  Total biaya sewa yang dikeluarkan untuk *pool* harus paling minimum.

Maka saya tuliskan *objective functions* sebagai berikut:

  
![MIN \\sum\_{i=1}^{200} \\sum\_{j=1}^{40}
transportcost\[i,j\]\*x\[i,j\] + \\sum\_{j=1}^{40} sewa\_j \*
y\[j\]](https://latex.codecogs.com/png.latex?MIN%20%5Csum_%7Bi%3D1%7D%5E%7B200%7D%20%5Csum_%7Bj%3D1%7D%5E%7B40%7D%20transportcost%5Bi%2Cj%5D%2Ax%5Bi%2Cj%5D%20%2B%20%5Csum_%7Bj%3D1%7D%5E%7B40%7D%20sewa_j%20%2A%20y%5Bj%5D
"MIN \\sum_{i=1}^{200} \\sum_{j=1}^{40} transportcost[i,j]*x[i,j] + \\sum_{j=1}^{40} sewa_j * y[j]")  

*Transportation cost* saya definisikan sebagai jarak antara calon lokasi
*pool* dengan lokasi *high demand* dikalikan suatu konstanta tertentu.

  
![transportcost\[i,j\] = jarak\[i,j\] \*
C](https://latex.codecogs.com/png.latex?transportcost%5Bi%2Cj%5D%20%3D%20jarak%5Bi%2Cj%5D%20%2A%20C
"transportcost[i,j] = jarak[i,j] * C")  

# Solusi

Solusi dari formula matematika di atas adalah sebagai berikut:

    ## Solusi Optimisasi

| pool\_id | banyak\_high\_demand\_covered | cost\_sewa | total\_transport\_cost |
| -------: | ----------------------------: | ---------: | ---------------------: |
|        1 |                             7 |        320 |                1290.03 |
|        3 |                             5 |        390 |                 409.31 |
|        7 |                            13 |        430 |                2371.28 |
|        8 |                            12 |        430 |                1847.07 |
|       10 |                            11 |        340 |                2113.65 |
|       11 |                             7 |        340 |                 828.82 |
|       14 |                             7 |        450 |                 658.13 |
|       15 |                             8 |        350 |                1088.55 |
|       16 |                            12 |        450 |                1984.10 |
|       18 |                             6 |        310 |                1011.67 |
|       22 |                             7 |        430 |                 819.03 |
|       23 |                             4 |        370 |                 320.77 |
|       24 |                            11 |        380 |                1626.81 |
|       25 |                             8 |        390 |                 752.31 |
|       26 |                             6 |        400 |                 539.92 |
|       30 |                             6 |        310 |                 833.44 |
|       36 |                            13 |        390 |                1927.21 |
|       37 |                             8 |        430 |                1002.10 |
|       39 |                             9 |        370 |                1233.63 |

Ternyata cukup dibutuhkan `19` calon *pool* taxi saja yang harus disewa
dengan total *cost* sebagai berikut:

  - Total *cost* sewa: 62160.
  - Total *transportation cost*: 22657.83.

Mari kita lihat peta finalnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/linear%20problem/post%205/post_files/figure-gfm/unnamed-chunk-4-1.png" width="672" style="display: block; margin: auto;" />

-----

# *What’s next?*

Kita bisa melakukan *another tweaks* jika diperlukan. Misalkan kita
tambahkan syarat agar satu *pool* taxi wajib meng-*cover* sejumlah
minimal lokasi *high demand*.
