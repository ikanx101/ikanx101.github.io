Optimization Story: Membuat Jadwal Tatap Muka Terbatas di Sekolah
================

Beberapa minggu ini, penambahan kasus positif harian Covid 19 semakin
menurun di Pulau Jawa. Akibatnya pemerintah mulai melonggarkan aturan
PPKM sehingga sekolah-sekolah mulai menggelar pengajaran tatap muka
terbatas (PTMT) untuk siswanya secara *offline*.

Hal ini juga berlaku di sekolah si sulung. Untuk bisa mengikuti PTMT,
kami sebagai orang tua harus mendaftar terlebih dahulu ke wali kelasnya.
Kemudian wali kelas membuat jadwal kunjungan untuk semua siswa yang
mendaftar. Walaupun terkesan hal yang remeh, tapi menyusun jadwal
merupakan pekerjaan yang melelahkan.

-----

Terinspirasi dari sekolah si sulung, saya hendak memberikan ilustrasi
bagaimana model optimisasi (baca: matematika alias ***artificial
intelligence***) bisa digunakan untuk membuat penjadwalan.

Suatu sekolah memiliki kelas berisi 20 orang siswa. Mereka hendak
menggelar PTMT dengana aturan sebagai berikut:

1.  PTMT digelar dari Senin hingga Jumat (5 hari).
2.  Dalam sehari, siswa yang boleh hadir dibatasi 4-8 orang saja.
3.  Dalam seminggu, diharapkan siswa bisa hadir 2-3 kali.
4.  Siswa yang hadir di selang sehari baru bisa hadir kembali.

Saat membuat jadwal berdasarkan aturan di atas, tiba-tiba beberapa orang
tua murid menelepon sang guru. Ternyata didapatkan:

1.  `3` orang siswa hanya bisa hadir di **Senin dan Jumat**.
2.  `2` orang siswa ingin hadir di **Rabu** dan hari lainnya bebas.

Berdasarkan semua kondisi yang ada ini, sang guru mulai pusing membuat
jadwalnya.

-----

Dari uraian di atas, kita bisa membuat model optimisasinya sebagai
berikut:

Saya definisikan ![x\_{i,j} \\in
(0,1)](https://latex.codecogs.com/png.latex?x_%7Bi%2Cj%7D%20%5Cin%20%280%2C1%29
"x_{i,j} \\in (0,1)") sebagai bilangan biner di mana ![i \\in
\\{1,2,..,20\\}](https://latex.codecogs.com/png.latex?i%20%5Cin%20%5C%7B1%2C2%2C..%2C20%5C%7D
"i \\in \\{1,2,..,20\\}") menandakan siswa dan ![j \\in
\\{1,2,..,5\\}](https://latex.codecogs.com/png.latex?j%20%5Cin%20%5C%7B1%2C2%2C..%2C5%5C%7D
"j \\in \\{1,2,..,5\\}") menandakan hari. Berlaku:

  
![x\_{i,j} = \\left\\{\\begin{matrix}
0, \\text{ siswa i tidak masuk di hari j}\\\\ 
1, \\text{ siswa i masuk di hari j}
\\end{matrix}\\right.](https://latex.codecogs.com/png.latex?x_%7Bi%2Cj%7D%20%3D%20%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%0A0%2C%20%5Ctext%7B%20siswa%20i%20tidak%20masuk%20di%20hari%20j%7D%5C%5C%20%0A1%2C%20%5Ctext%7B%20siswa%20i%20masuk%20di%20hari%20j%7D%0A%5Cend%7Bmatrix%7D%5Cright.
"x_{i,j} = \\left\\{\\begin{matrix}
0, \\text{ siswa i tidak masuk di hari j}\\\\ 
1, \\text{ siswa i masuk di hari j}
\\end{matrix}\\right.")  

***Objective Function***

Tujuan utama kita adalah memaksimalkan siswa yang hadir.

  
![\\max{\\sum\_{j=1}^5 \\sum\_{i=1}^{20} x\_{i,j}
}](https://latex.codecogs.com/png.latex?%5Cmax%7B%5Csum_%7Bj%3D1%7D%5E5%20%5Csum_%7Bi%3D1%7D%5E%7B20%7D%20x_%7Bi%2Cj%7D%20%7D
"\\max{\\sum_{j=1}^5 \\sum_{i=1}^{20} x_{i,j} }")  

***Constraints***

Dalam sehari, ada pembatasan jumlah siswa yang hadir.

  
![4 \\leq \\sum\_i x\_{i,j} \\leq 8, j \\in
\\{1,2,..,5\\}](https://latex.codecogs.com/png.latex?4%20%5Cleq%20%5Csum_i%20x_%7Bi%2Cj%7D%20%5Cleq%208%2C%20j%20%5Cin%20%5C%7B1%2C2%2C..%2C5%5C%7D
"4 \\leq \\sum_i x_{i,j} \\leq 8, j \\in \\{1,2,..,5\\}")  

Dalam seminggu, siswa hadir dalam frekuensi tertentu.

  
![2 \\leq \\sum\_j x\_{i,j} \\leq 3, i \\in
\\{1,2,..,20\\}](https://latex.codecogs.com/png.latex?2%20%5Cleq%20%5Csum_j%20x_%7Bi%2Cj%7D%20%5Cleq%203%2C%20i%20%5Cin%20%5C%7B1%2C2%2C..%2C20%5C%7D
"2 \\leq \\sum_j x_{i,j} \\leq 3, i \\in \\{1,2,..,20\\}")  

Ada jeda sehari agar siswa bisa masuk kembali.

  
![x\_{i,j} + x\_{i,j+1}
\\leq 1](https://latex.codecogs.com/png.latex?x_%7Bi%2Cj%7D%20%2B%20x_%7Bi%2Cj%2B1%7D%20%5Cleq%201
"x_{i,j} + x_{i,j+1} \\leq 1")  

Ada `3` orang yang hanya bisa masuk di hari Senin dan Jumat.

  
![x\_{i,1} + x\_{i,5} = 2, i
= 1,2,3](https://latex.codecogs.com/png.latex?x_%7Bi%2C1%7D%20%2B%20x_%7Bi%2C5%7D%20%3D%202%2C%20i%20%3D%201%2C2%2C3
"x_{i,1} + x_{i,5} = 2, i = 1,2,3")  

Ada `2` orang yang masuk di hari Rabu sedangkan hari lainnya bebas.

  
![x\_{i,3} = 1, i
= 5,6](https://latex.codecogs.com/png.latex?x_%7Bi%2C3%7D%20%3D%201%2C%20i%20%3D%205%2C6
"x_{i,3} = 1, i = 5,6")  

Jangan lupa bahwa ![x\_{i,j}
\\geq 0](https://latex.codecogs.com/png.latex?x_%7Bi%2Cj%7D%20%5Cgeq%200
"x_{i,j} \\geq 0").

Berikut adalah skrip di **R**-nya:

``` r
rm(list=ls())

library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

bin_prog = 
  MIPModel() %>%
  # menambah variabel
  add_variable(x[i,j],
           i = 1:20,
           j = 1:5,
           type = "binary",
           lb = 0) %>%
  # membuat objective function
  set_objective(sum_expr(x[i,j],
             i = 1:20,
             j = 1:5),
        "max") %>%
  # menambah constraints
  # max kapasitas kelas
  add_constraint(sum_expr(x[i,j],i = 1:20) >= 4,
         j = 1:5) %>%
  add_constraint(sum_expr(x[i,j],i = 1:20) <= 8,
         j = 1:5) %>%
  # frek kunjungan siswa
  add_constraint(sum_expr(x[i,j],j = 1:5) >= 2,
         i = 1:20) %>%
  add_constraint(sum_expr(x[i,j],j = 1:5) <= 3,
         i = 1:20) %>%
  # jeda sehari
  add_constraint(x[i,j] + x[i,j+1] <= 1,
         i = 1:20,
         j = 1:4)
```

    ## ```

## adding constraints \[==================\>———————–\] 46% eta 0s

## adding constraints \[===================\>———————-\] 48% eta 0s

## adding constraints \[===================\>———————-\] 49% eta 0s

## adding constraints \[====================\>———————\] 50% eta 0s

## adding constraints \[=====================\>——————–\] 51% eta 0s

## adding constraints \[=====================\>——————–\] 52% eta 0s

## adding constraints \[======================\>——————-\] 54% eta 0s

## adding constraints \[======================\>——————-\] 55% eta 0s

## adding constraints \[=======================\>——————\] 56% eta 0s

## adding constraints \[=======================\>——————\] 57% eta 0s

## adding constraints \[========================\>—————–\] 59% eta 0s

## adding constraints \[========================\>—————–\] 60% eta 0s

## adding constraints \[=========================\>—————-\] 61% eta 0s

## adding constraints \[=========================\>—————-\] 62% eta 0s

## adding constraints \[==========================\>—————\] 64% eta 0s

## adding constraints \[==========================\>—————\] 65% eta 0s

## adding constraints \[===========================\>————–\] 66% eta 0s

## adding constraints \[===========================\>————–\] 68% eta 0s

## adding constraints \[============================\>————-\] 69% eta 0s

## adding constraints \[============================\>————-\] 70% eta 0s

## adding constraints \[=============================\>————\] 71% eta 0s

## adding constraints \[=============================\>————\] 72% eta 0s

## adding constraints \[==============================\>———–\] 74% eta 0s

## adding constraints \[===============================\>———-\] 75% eta 0s

## adding constraints \[===============================\>———-\] 76% eta 0s

## adding constraints \[================================\>———\] 78% eta 0s

## adding constraints \[================================\>———\] 79% eta 0s

## adding constraints \[=================================\>——–\] 80% eta 0s

## adding constraints \[=================================\>——–\] 81% eta 0s

## adding constraints \[==================================\>——-\] 82% eta 0s

## adding constraints \[==================================\>——-\] 84% eta 0s

## adding constraints \[===================================\>——\] 85% eta 0s

## adding constraints \[===================================\>——\] 86% eta 0s

## adding constraints \[====================================\>—–\] 88% eta 0s

## adding constraints \[====================================\>—–\] 89% eta 0s

## adding constraints \[=====================================\>—-\] 90% eta 0s

## adding constraints \[=====================================\>—-\] 91% eta 0s

## adding constraints \[======================================\>—\] 92% eta 0s

## adding constraints \[======================================\>—\] 94% eta 0s

## adding constraints \[=======================================\>–\] 95% eta 0s

## adding constraints \[=======================================\>–\] 96% eta 0s

## adding constraints \[========================================\>-\] 98% eta 0s

## adding constraints \[========================================\>-\] 99% eta 0s

## adding constraints \[==========================================\] 100% eta 0s

\`\`\`

``` r
bin_prog 
```

    ## Mixed integer linear optimization problem
    ## Variables:
    ##   Continuous: 0 
    ##   Integer: 0 
    ##   Binary: 100 
    ## Model sense: maximize 
    ## Constraints: 130

Berikut adalah hasil dari algoritma di atas:

    ## <SOLVER MSG>  ----
    ## GLPK Simplex Optimizer, v4.65
    ## 130 rows, 100 columns, 560 non-zeros
    ##       0: obj =  -0.000000000e+00 inf =   6.000e+01 (25)
    ##      51: obj =   4.000000000e+01 inf =   0.000e+00 (0)
    ## *    53: obj =   4.000000000e+01 inf =   0.000e+00 (0)
    ## OPTIMAL LP SOLUTION FOUND
    ## GLPK Integer Optimizer, v4.65
    ## 130 rows, 100 columns, 560 non-zeros
    ## 100 integer variables, all of which are binary
    ## Integer optimization begins...
    ## Long-step dual simplex will be used
    ## +    53: mip =     not found yet <=              +inf        (1; 0)
    ## +    53: >>>>>   4.000000000e+01 <=   4.000000000e+01   0.0% (1; 0)
    ## +    53: mip =   4.000000000e+01 <=     tree is empty   0.0% (0; 1)
    ## INTEGER OPTIMAL SOLUTION FOUND
    ## <!SOLVER MSG> ----

| hari | presensi               |
| ---: | :--------------------- |
|    1 | 1,2,3,4,9,10,11,12     |
|    2 | 5,6,7,8,13,14,15,16    |
|    3 | 1,2,3,4,17,18,19,20    |
|    4 | 5,6,7,8,13,14,15,16    |
|    5 | 9,10,11,12,17,18,19,20 |

Jadwal Kunjungan Siswa

| siswa | jumlah kehadiran |
| ----: | ---------------: |
|     1 |                2 |
|     2 |                2 |
|     3 |                2 |
|     4 |                2 |
|     5 |                2 |
|     6 |                2 |
|     7 |                2 |
|     8 |                2 |
|     9 |                2 |
|    10 |                2 |
|    11 |                2 |
|    12 |                2 |
|    13 |                2 |
|    14 |                2 |
|    15 |                2 |
|    16 |                2 |
|    17 |                2 |
|    18 |                2 |
|    19 |                2 |
|    20 |                2 |

Rekap Presensi Siswa
