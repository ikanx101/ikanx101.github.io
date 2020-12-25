---
date: 2020-12-25T14:55:00-04:00
title: "Optimization Story: Pemilahan Peserta Training dengan Mixed Integer Linear Programming"
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
---


Pada tahun ini, saya dan beberapa rekan di kantor mengadakan [*training*
**R**](https://ikanx101.com/blog/training-replikasi/) secara online di
kantor. Ternyata animonya luar biasa.

> Ibarat kata jualan gorengan, dagangan kami laku keras.

Saking banyaknya pendaftar, tim *training* HR harus membagi para peserta
menjadi beberapa *batches*.

Saat itu, ada 57 orang yang mendaftar. Sementara kapasitas para
*trainers* untuk satu *batch* hanya bisa mengajar 12-16 orang saja. Oleh
karena itu dibagilah para peserta menjadi 5 *batches*.

Saat itu, secara manual kami membagi para peserta ke dalam *batches*
tersebut. Para peserta dipilih dan dipilah berdasarkan skor urgensi yang
kami nilai secara subjektif sesuai dengan *roles* pekerjaan
masing-masing.

Ternyata menentukan jadwal memang tidak semudah yang dibayangkan.

-----

Pada tulisan sebelumnya, saya telah membahas bagaimana *linear
programming* bisa digunakan untuk menentukan jadwal yang optimal.

Kini, saya akan mengggunakan *mixed integer linear programming*
(**MILP**) untuk membuat jadwal *training*. Kasusnya tidak akan mirip
persis dengan pengalaman saya tapi akan saya *twist* agar lebih seru.

-----

# *Problem*

Pada tahun 2021 nanti, tim HR akan melakukan *full day training* kepada
sebagian karyawan. *Training* ini akan disebar di 4 tanggal di Q1 2021.
*Training* ini cukup diikuti sekali per *trainee*. Karyawan yang
tertarik bisa mendaftar dan memilih sendiri pada tanggal berapa dia bisa
mengikuti *training* tersebut.

  - Sampai detik ini, ada 87 orang karyawan yang mendaftar.
  - Satu kali *training* hanya bisa diikuti maksimal 22 orang *trainee*.
  - Ada 4 pilihan tanggal *training*.
  - Calon *trainee* bisa memilih 3 dari 4 tanggal yang tersedia. Namun
    hanya akan dimasukkan ke dalam satu kelas saja.
      - Tanggal pilihan pertama memiliki bobot terbesar. Ini adalah
        tanggal pilihan utama *trainee*. Jika jumlah *trainee* di
        tanggal ini masih kosong atau mencukupi, maka *trainee* akan
        dimasukkan ke dalam kelas tersebut.
      - Tanggal pilihan kedua sebagai alternatif berikutnya.
      - Tanggal pilihan ketiga sebagai alternatif terakhir jika
        *trainee* tidak bisa masuk ke dalam tanggal pilihan pertama dan
        kedua.

Bagaimana cara kita menyusun *trainee* mana saja yang masuk ke tanggal
berapa dari pilihan yang mereka berikan?

-----

# *a little bit of math*

Oke, ini adalah bagian serunya jika kita menyelesaikan *linear
programming* yakni membuat formulasi matematika dari masalah yang ada.
Misalkan saya telah mendapatkan data pilihan dari 87 orang tersebut.

    ## Cuplikan 10 data pilihan trainee

    ## [[1]]
    ## [1] 1 4 2
    ## 
    ## [[2]]
    ## [1] 3 4 1
    ## 
    ## [[3]]
    ## [1] 2 3 1
    ## 
    ## [[4]]
    ## [1] 4 3 2
    ## 
    ## [[5]]
    ## [1] 3 4 2
    ## 
    ## [[6]]
    ## [1] 1 3 4
    ## 
    ## [[7]]
    ## [1] 2 3 4
    ## 
    ## [[8]]
    ## [1] 3 1 4
    ## 
    ## [[9]]
    ## [1] 1 2 3
    ## 
    ## [[10]]
    ## [1] 1 4 3

Kita lihat bahwa *trainee* pertama memberikan pilihan 1, 4, 2. Kita
harus memberikan bobot terbesar terhadap pilihan pertama, kedua, dan
ketiga. Sementara tanggal yang tidak terpilih, akan saya berikan bobot
yang sangat kecil.

> Apa gunanya?

Agar kita bisa menjadikan pilihan-pilihan ini menjadi *objective
function* yang harus kita **maksimalkan**.

Berikut adalah formulasi matematikanya:

![n](https://latex.codecogs.com/png.latex?n "n") menandakan banyaknya
*trainee*.

  
![n
= 1,2,3...,87](https://latex.codecogs.com/png.latex?n%20%3D%201%2C2%2C3...%2C87
"n = 1,2,3...,87")  

![m](https://latex.codecogs.com/png.latex?m "m") menandakan banyaknya
kelas *training*.

  
![m
= 1,2,3,4](https://latex.codecogs.com/png.latex?m%20%3D%201%2C2%2C3%2C4
"m = 1,2,3,4")  

Misalkan saya notasikan
![x\_{i,j}](https://latex.codecogs.com/png.latex?x_%7Bi%2Cj%7D
"x_{i,j}") adalah bilangan biner (0,1) yang menandakan:

  - `1` jika *trainee* ![i](https://latex.codecogs.com/png.latex?i "i")
    mengikuti *training* di tanggal ke
    ![j](https://latex.codecogs.com/png.latex?j "j").
  - `0` jika *trainee* ![i](https://latex.codecogs.com/png.latex?i "i")
    tidak mengikuti *training* di tanggal ke
    ![j](https://latex.codecogs.com/png.latex?j "j").

Misalkan saya notasikan
![w\_{i,j}](https://latex.codecogs.com/png.latex?w_%7Bi%2Cj%7D
"w_{i,j}") adalah bobot *trainee*
![i](https://latex.codecogs.com/png.latex?i "i") terhadap training
tanggal ke ![j](https://latex.codecogs.com/png.latex?j "j"). Nilai
![w\_{i,j}](https://latex.codecogs.com/png.latex?w_%7Bi%2Cj%7D
"w_{i,j}") akan besar saat tanggal yang dipilih merupakah pilihan
pertama dan seterusnya.

## *Objective Function*

Kita harus memaksimalkan fungsi berikut:

  
![MAX \\sum\_{i=1}^{n} \\sum\_{j=1}^{m} w\_{i,j} \*
x\_{i,j}](https://latex.codecogs.com/png.latex?MAX%20%5Csum_%7Bi%3D1%7D%5E%7Bn%7D%20%5Csum_%7Bj%3D1%7D%5E%7Bm%7D%20w_%7Bi%2Cj%7D%20%2A%20x_%7Bi%2Cj%7D
"MAX \\sum_{i=1}^{n} \\sum_{j=1}^{m} w_{i,j} * x_{i,j}")  

## *Constraints*

*Constraint* kapasitas per kelas yang maksimal 22 orang.

![\\sum\_{i=1}^{n} x\_{i,j}
\\leq 22](https://latex.codecogs.com/png.latex?%5Csum_%7Bi%3D1%7D%5E%7Bn%7D%20x_%7Bi%2Cj%7D%20%5Cleq%2022
"\\sum_{i=1}^{n} x_{i,j} \\leq 22") dengan ![j
= 1,2,3,4](https://latex.codecogs.com/png.latex?j%20%3D%201%2C2%2C3%2C4
"j = 1,2,3,4").

*Constraint* seorang *trainee* harus terpasang ke satu kelas saja.

![\\sum\_{j=1}^{m} x\_{i,j}
= 1](https://latex.codecogs.com/png.latex?%5Csum_%7Bj%3D1%7D%5E%7Bm%7D%20x_%7Bi%2Cj%7D%20%3D%201
"\\sum_{j=1}^{m} x_{i,j} = 1") dengan ![i
= 1,2,3,...,87](https://latex.codecogs.com/png.latex?i%20%3D%201%2C2%2C3%2C...%2C87
"i = 1,2,3,...,87").

*Constraint* nilai ![x\_{i,j} \\in
(0,1)](https://latex.codecogs.com/png.latex?x_%7Bi%2Cj%7D%20%5Cin%20%280%2C1%29
"x_{i,j} \\in (0,1)") dengan ![i
= 1,2,3,...,87](https://latex.codecogs.com/png.latex?i%20%3D%201%2C2%2C3%2C...%2C87
"i = 1,2,3,...,87") dan ![j
= 1,2,3,4](https://latex.codecogs.com/png.latex?j%20%3D%201%2C2%2C3%2C4
"j = 1,2,3,4").

## Solusi

Kali ini saya tidak akan menggunakan `library(lpSolve)` untuk
menyelesaikan masalah ini. Saya akan menggunakan **OMPR** (*Optimization
Modelling Package in R*).

Jadi alih-alih membentuk beberapa matriks, saya akan langsung
menggunakan persamaan-persamaan di atas.

``` r
# model = MIPModel() %>%
  
  # Definisi x[i,j]: bernilai 1 jika trainee dimasukkan ke training bulan j
#  add_variable(x[i, j], i = 1:n, j = 1:m, type = "binary") %>%
  
  # Maksimalkan objective function
#  set_objective(sum_expr(bobot(pilihan[i], j) * x[i, j], i = 1:n, j = 1:m),
#                "max") %>%
  
  # Constraint kapasitas kelas
#  add_constraint(sum_expr(x[i, j], i = 1:n) <= capacity[j], j = 1:m) %>% 
  
  # Constraint satu trainee hanya boleh masuk ke dalam satu training saja
#  add_constraint(sum_expr(x[i, j], j = 1:m) == 1, i = 1:n)
```

Setelah saya selesaikan, saya dapatkan konfigurasi sebagai berikut:

| training\_tanggal\_ke | banyak\_trainee |
| --------------------: | --------------: |
|                     1 |              22 |
|                     2 |              22 |
|                     3 |              21 |
|                     4 |              22 |

Melihat hasil optimal di atas, tidak ada satupun *constraint* yang
dilanggar.

Jika dilihat detailnya, saya akan cek apakah *trainee* memang dimasukkan
ke dalam tanggal sesuai dengan pilihan mereka sendiri atau tidak:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/linear%20problem/post%204/Post_files/figure-gfm/unnamed-chunk-4-1.png" width="672" style="display: block; margin: auto;" />

Ternyata ada sebagian kecil dari *trainee* yang dimasukkan ke dalam
*training* tanggal tertentu bukan berdasarkan pilihan dari mereka.

Hal ini dimungkinkan karena algoritma akan memasukkan *trainees* yang
lebih bisa memaksimalkan *objective function* sehingga *trainee* `sisa`
ini dimasukkan ke dalam tanggal tertentu yang tidak melanggar
*constraints* dan tetap memaksimalkan *objective function* yang ada.
