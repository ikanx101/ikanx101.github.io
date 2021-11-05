---
date: 2021-03-28T08:43:00-04:00
title: "Optimization Story: Penjadwalan Perawat di Rumah Sakit"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Linear Programming
  - Binary Linear Programming
  - Optimization Story
  - Mixed Integer Linear Programming
---

Beberapa waktu yang lalu, saya sempat menuliskan bagaimana *linear
programming* bisa digunakan untuk menyelesaikan permasalahan
[penjadwalan tenaga kesehatan dengan
optimal](https://ikanx101.com/blog/jadwal-optimal/). Namun jika
rekan-rekan membaca tulisan saya tersebut, *final result* yang ada
adalah hanyalah konfigurasi banyaknya tenaga kesehatan yang bekerja di
hari-hari tersebut.

> ***Belum ada detail jadwal siapa masuk ke hari apa di shift ke
> berapa.***

Kali ini saya akan mencoba menyelesaikan permasalahan penjadwalan yang
relatif lebih rumit dibandingkan dengan permasalahan yang kemarin.

-----

# *Nurse Schedulling*

## Latar Belakang

Di suatu rumah sakit, ada satu lantai berisi kamar rawat inap kelas VIP
dengan total ada 30 orang perawat yang ditugaskan di sana. Para perawat
bekerja dengan sistem *shift* dengan peraturan sebagai berikut:

  - Terdapat `3` shift kerja yaitu:
      - *day shift* (8.00 - 16.00),
      - *evening shift* (16.00 - 24.00), dan
      - *night shift* (24.00 - 8.00)
  - Pada setiap shift dibutuhkan minimal 5 orang perawat.

Selain itu, terdapat beberapa **aturan kerja** yang harus dipenuhi,
yakni:

1.  Setiap perawat dalam satu hari hanya boleh ditugaskan ke dalam satu
    *shift*.
2.  Jika seorang perawat ditugaskan pada *shift* malam, maka dia tidak
    dapat ditugaskan di *shift* pagi di hari berikutnya.
3.  Jika seorang perawat ditugaskan dalam `4` hari berturut-turut, maka
    hari ke-`5` harus diberi libur.
4.  Jika seorang perawat ditugaskan pada suatu *shift* di *weekend*,
    maka dia tidak dapat ditugaskan di *weekend* berikutnya.
5.  *Workload* (banyaknya penugasan) setiap perawat harus **sama**.

## Masalah

Bagaimana menentukan jadwal yang optimal?

## Model Matematika

### Membangun Model Matematika

#### *Time Frame*

Untuk memudahkan membuat model matematika *nurse schedulling*, saya akan
mendefinisikan terlebih dahulu *time frame* yang hendak digunakan.
Apakah akan dibuat jadwal selama seminggu, sebulan, atau periode
tertentu.

Untuk itu, saya akan melihat **aturan kerja ke-4**, yakni:

> Jika seorang perawat ditugaskan pada suatu *shift* di *weekend*, maka
> dia tidak dapat ditugaskan di *weekend* berikutnya.

Dari kasus di atas, setidaknya *time frame* penjadwalan **tersingkat**
yang bisa buat adalah dalam waktu `2` minggu.

### Parameter

Dari penjelasan-penjelasan di atas, saya akan mendefinisikan beberapa
hal, yakni:

  - ![H =
    \\{1,2,...,13,14\\}](https://latex.codecogs.com/png.latex?H%20%3D%20%5C%7B1%2C2%2C...%2C13%2C14%5C%7D
    "H = \\{1,2,...,13,14\\}") adalah himpunan hari dalam *time frame*
    `2` minggu. Saya tuliskan `1` sebagai Senin. *Weekend* terjadi pada
    ![H\_w =
    \\{6,7,13,14\\}](https://latex.codecogs.com/png.latex?H_w%20%3D%20%5C%7B6%2C7%2C13%2C14%5C%7D
    "H_w = \\{6,7,13,14\\}").
  - ![S =
    \\{1,2,3\\}](https://latex.codecogs.com/png.latex?S%20%3D%20%5C%7B1%2C2%2C3%5C%7D
    "S = \\{1,2,3\\}") adalah himpunan *shift* kerja harian perawat.
  - ![N =
    \\{1,2,3,4,...,30\\}](https://latex.codecogs.com/png.latex?N%20%3D%20%5C%7B1%2C2%2C3%2C4%2C...%2C30%5C%7D
    "N = \\{1,2,3,4,...,30\\}") adalah himpunan banyaknya perawat yang
    dibutuhkan.

### *Decision Variable*

Saya definisikan:

  
![x\_{n,h,s} = \\begin{cases} 1,& \\text{ jika di perawat ke } n \\text{
bekerja di hari } h \\text{ pada shift ke }s\\\\ 0, & \\text{
lainnya.}\\end{cases}](https://latex.codecogs.com/png.latex?x_%7Bn%2Ch%2Cs%7D%20%3D%20%5Cbegin%7Bcases%7D%201%2C%26%20%5Ctext%7B%20jika%20di%20perawat%20ke%20%7D%20n%20%5Ctext%7B%20bekerja%20di%20hari%20%7D%20h%20%5Ctext%7B%20pada%20shift%20ke%20%7Ds%5C%5C%200%2C%20%26%20%5Ctext%7B%20lainnya.%7D%5Cend%7Bcases%7D
"x_{n,h,s} = \\begin{cases} 1,& \\text{ jika di perawat ke } n \\text{ bekerja di hari } h \\text{ pada shift ke }s\\\\ 0, & \\text{ lainnya.}\\end{cases}")  

### *Constraints*

Sekarang kita akan menuliskan *constraints* dalam bahasa matematika.

#### Aturan Dasar

Pada setiap shift dibutuhkan minimal 5 orang perawat.

  
![\\sum\_{n \\in N} x\_{n,h,s} \\geq 5 \\text{, untuk } h \\in H,
\\text{ dan } s \\in
S](https://latex.codecogs.com/png.latex?%5Csum_%7Bn%20%5Cin%20N%7D%20x_%7Bn%2Ch%2Cs%7D%20%5Cgeq%205%20%5Ctext%7B%2C%20untuk%20%7D%20h%20%5Cin%20H%2C%20%20%5Ctext%7B%20dan%20%7D%20s%20%5Cin%20S
"\\sum_{n \\in N} x_{n,h,s} \\geq 5 \\text{, untuk } h \\in H,  \\text{ dan } s \\in S")  

#### *Constraint* I

Setiap perawat dalam satu hari hanya boleh ditugaskan ke dalam satu
*shift*.

  
![\\sum\_{s \\in S}x\_{n,h,s} \\leq 1 \\text{, untuk } n \\in N \\text{
dan } h \\in
H](https://latex.codecogs.com/png.latex?%5Csum_%7Bs%20%5Cin%20S%7Dx_%7Bn%2Ch%2Cs%7D%20%5Cleq%201%20%5Ctext%7B%2C%20untuk%20%7D%20n%20%5Cin%20N%20%5Ctext%7B%20dan%20%7D%20h%20%5Cin%20H
"\\sum_{s \\in S}x_{n,h,s} \\leq 1 \\text{, untuk } n \\in N \\text{ dan } h \\in H")  

Ekspresi matematika di atas memastikan bahwa seorang perawat hanya bisa
ditugaskan dalam **satu shift** per hari **atau** tidak ditugaskan sama
sekali.

#### *Constraint* II

Jika seorang perawat ditugaskan pada *shift* malam, maka dia tidak dapat
ditugaskan di *shift* pagi.

  
![x\_{n,h,3} + x\_{n,h+1,1} \\leq 1 \\text{, untuk } n \\in N \\text{
dan } h \\in
\\{1,2,..,13\\}](https://latex.codecogs.com/png.latex?x_%7Bn%2Ch%2C3%7D%20%2B%20x_%7Bn%2Ch%2B1%2C1%7D%20%5Cleq%201%20%5Ctext%7B%2C%20untuk%20%7D%20n%20%5Cin%20N%20%5Ctext%7B%20dan%20%7D%20h%20%5Cin%20%5C%7B1%2C2%2C..%2C13%5C%7D
"x_{n,h,3} + x_{n,h+1,1} \\leq 1 \\text{, untuk } n \\in N \\text{ dan } h \\in \\{1,2,..,13\\}")  

Ekspresi matematika di atas memastikan bahwa seorang perawat yang
bertugas *night shift* pada hari
![h](https://latex.codecogs.com/png.latex?h "h") tidak boleh bertugas
pada *shift* pagi esok harinya
(![h+1](https://latex.codecogs.com/png.latex?h%2B1 "h+1")) **atau**
perawat tersebut tidak ditugaskan sama sekali.

#### *Constraint* III

Jika seorang perawat ditugaskan dalam `4` hari berturut-turut, maka hari
ke-`5` harus diberi libur.

Jadi seorang perawat bisa saja bertugas di berbagai *shift* selama 4
hari berturut-turut tapi **tidak diperbolehkan** untuk bertugas di hari
ke-`5`.

  
![\\sum\_{s \\in S} x\_{n,h,s} + \\sum\_{s \\in S} x\_{n,h+1,s} +
\\sum\_{s \\in S} x\_{n,h+2,s} + \\sum\_{s \\in S} x\_{n,h+3,s} +
\\sum\_{s \\in S} x\_{n,h+4,s} \\leq 4 \\text{, untuk } n \\in N \\text{
dan } h \\in
\\{1,..,10\\}](https://latex.codecogs.com/png.latex?%5Csum_%7Bs%20%5Cin%20S%7D%20x_%7Bn%2Ch%2Cs%7D%20%2B%20%5Csum_%7Bs%20%5Cin%20S%7D%20x_%7Bn%2Ch%2B1%2Cs%7D%20%2B%20%5Csum_%7Bs%20%5Cin%20S%7D%20x_%7Bn%2Ch%2B2%2Cs%7D%20%2B%20%5Csum_%7Bs%20%5Cin%20S%7D%20x_%7Bn%2Ch%2B3%2Cs%7D%20%2B%20%5Csum_%7Bs%20%5Cin%20S%7D%20x_%7Bn%2Ch%2B4%2Cs%7D%20%5Cleq%204%20%5Ctext%7B%2C%20untuk%20%7D%20n%20%5Cin%20N%20%5Ctext%7B%20dan%20%7D%20h%20%5Cin%20%5C%7B1%2C..%2C10%5C%7D
"\\sum_{s \\in S} x_{n,h,s} + \\sum_{s \\in S} x_{n,h+1,s} + \\sum_{s \\in S} x_{n,h+2,s} + \\sum_{s \\in S} x_{n,h+3,s} + \\sum_{s \\in S} x_{n,h+4,s} \\leq 4 \\text{, untuk } n \\in N \\text{ dan } h \\in \\{1,..,10\\}")  

#### *Constraint* IV

Jika seorang perawat ditugaskan pada suatu *shift* di *weekend*, maka
dia tidak dapat ditugaskan di *weekend* berikutnya.

Saya telah menuliskan *weekend* terjadi saat ![H \\in
\\{6,7,13,14\\}](https://latex.codecogs.com/png.latex?H%20%5Cin%20%5C%7B6%2C7%2C13%2C14%5C%7D
"H \\in \\{6,7,13,14\\}").

Bagi saya, *constraint* IV merupakan *constraint* yang tersulit untuk
dituliskan model matematikanya. Oleh karena itu, saya akan gunakan
induksi sebagai berikut:

##### Tanggal `6`

Jika seorang perawat bertugas di hari `6` (*shift* apapun), dia tidak
boleh bertugas di hari `13` dan `14`. Tapi jika dia tidak bertugas di
hari `6`, maka dia diperbolehkan bertugas di hari `13` **dan atau**
`14`. Akibatnya:

  - Jika ![x\_{n,6,s}
    = 1](https://latex.codecogs.com/png.latex?x_%7Bn%2C6%2Cs%7D%20%3D%201
    "x_{n,6,s} = 1") maka ![x\_{n,13,s} + x\_{n,14,s}
    = 0](https://latex.codecogs.com/png.latex?x_%7Bn%2C13%2Cs%7D%20%2B%20x_%7Bn%2C14%2Cs%7D%20%3D%200
    "x_{n,13,s} + x_{n,14,s} = 0")
  - Jika ![x\_{n,6,s}
    = 0](https://latex.codecogs.com/png.latex?x_%7Bn%2C6%2Cs%7D%20%3D%200
    "x_{n,6,s} = 0") maka ![x\_{n,13,s} + x\_{n,14,s}
    \\leq 2](https://latex.codecogs.com/png.latex?x_%7Bn%2C13%2Cs%7D%20%2B%20x_%7Bn%2C14%2Cs%7D%20%5Cleq%202
    "x_{n,13,s} + x_{n,14,s} \\leq 2") karena perawat tersebut bisa
    bertugas di tanggal `13` **dan atau** `14`.

Maka model matematika pada *constraint* tanggal `6` adalah sebagai
berikut:

  
![ 2\\sum\_{s \\in S} x\_{n,6,s} + \\sum\_{s \\in S}x\_{n,13,s} +
\\sum\_{s \\in S}x\_{n,14,s} \\leq 2 &#10;\\text{, untuk } n \\in N
](https://latex.codecogs.com/png.latex?%202%5Csum_%7Bs%20%5Cin%20S%7D%20x_%7Bn%2C6%2Cs%7D%20%2B%20%5Csum_%7Bs%20%5Cin%20S%7Dx_%7Bn%2C13%2Cs%7D%20%2B%20%5Csum_%7Bs%20%5Cin%20S%7Dx_%7Bn%2C14%2Cs%7D%20%5Cleq%202%20%0A%5Ctext%7B%2C%20untuk%20%7D%20n%20%5Cin%20N%20
" 2\\sum_{s \\in S} x_{n,6,s} + \\sum_{s \\in S}x_{n,13,s} + \\sum_{s \\in S}x_{n,14,s} \\leq 2 
\\text{, untuk } n \\in N ")  

##### Tanggal `7`

Dengan prinsip yang sama dengan tanggal `6`, saya bisa dapatkan model
matematika pada *constraint* tanggal `7` adalah sebagai berikut:

  
![ 2\\sum\_{s \\in S} x\_{n,7,s} + \\sum\_{s \\in S}x\_{n,13,s} +
\\sum\_{s \\in S}x\_{n,14,s} \\leq 2 &#10;\\text{, untuk } n \\in N
](https://latex.codecogs.com/png.latex?%202%5Csum_%7Bs%20%5Cin%20S%7D%20x_%7Bn%2C7%2Cs%7D%20%2B%20%5Csum_%7Bs%20%5Cin%20S%7Dx_%7Bn%2C13%2Cs%7D%20%2B%20%5Csum_%7Bs%20%5Cin%20S%7Dx_%7Bn%2C14%2Cs%7D%20%5Cleq%202%20%0A%5Ctext%7B%2C%20untuk%20%7D%20n%20%5Cin%20N%20
" 2\\sum_{s \\in S} x_{n,7,s} + \\sum_{s \\in S}x_{n,13,s} + \\sum_{s \\in S}x_{n,14,s} \\leq 2 
\\text{, untuk } n \\in N ")  

#### *Constraint* V

*Workload* (banyaknya penugasan) setiap perawat harus **sama**.

Pertama-tama, mari kita hitung. Berapa banyak shift yang ideal per
perawat.

  
![\\text{banyak shift ideal} = \\frac{hari\*shift\*min(\\text{perawat
per shift})}{\\text{total perawat}}
](https://latex.codecogs.com/png.latex?%5Ctext%7Bbanyak%20shift%20ideal%7D%20%3D%20%5Cfrac%7Bhari%2Ashift%2Amin%28%5Ctext%7Bperawat%20per%20shift%7D%29%7D%7B%5Ctext%7Btotal%20perawat%7D%7D%20
"\\text{banyak shift ideal} = \\frac{hari*shift*min(\\text{perawat per shift})}{\\text{total perawat}} ")  
Yakni:

  
![\\text{banyak shift ideal} = \\frac{14\*3\*5}{30} = \\frac{210}{30}
= 7](https://latex.codecogs.com/png.latex?%5Ctext%7Bbanyak%20shift%20ideal%7D%20%3D%20%5Cfrac%7B14%2A3%2A5%7D%7B30%7D%20%3D%20%5Cfrac%7B210%7D%7B30%7D%20%3D%207
"\\text{banyak shift ideal} = \\frac{14*3*5}{30} = \\frac{210}{30} = 7")  

Jadi diharapkan setiap perawat mendapatkan banyak *shift* yang sama,
yakni sebanyak `7` *shifts*.

Maka model matematika dari *constraint* ini adalah:

  
![\\sum\_{h \\in H} \\sum\_{s \\in S} x\_{h,n,s} = 7, \\text{untuk } n
\\in
N](https://latex.codecogs.com/png.latex?%5Csum_%7Bh%20%5Cin%20H%7D%20%5Csum_%7Bs%20%5Cin%20S%7D%20x_%7Bh%2Cn%2Cs%7D%20%3D%207%2C%20%5Ctext%7Buntuk%20%7D%20n%20%5Cin%20N
"\\sum_{h \\in H} \\sum_{s \\in S} x_{h,n,s} = 7, \\text{untuk } n \\in N")  

### *Objective Function*

Tujuan utama dari masalah *schedulling* ini adalah meminimalisir
banyaknya perawat yang ditugaskan per hari per *shift* sehingga tetap
memenuhi *constraints* yang ada.

  
![min \\sum\_{n \\in N} \\sum\_{h \\in H} \\sum\_{s \\in S} x\_{n,h,s}
](https://latex.codecogs.com/png.latex?min%20%5Csum_%7Bn%20%5Cin%20N%7D%20%5Csum_%7Bh%20%5Cin%20H%7D%20%5Csum_%7Bs%20%5Cin%20S%7D%20x_%7Bn%2Ch%2Cs%7D%20
"min \\sum_{n \\in N} \\sum_{h \\in H} \\sum_{s \\in S} x_{n,h,s} ")  

## *Solver* **R**

### Penulisan Model Matematika di **R**

Berikut adalah penulisan model matematika di **R**:

``` r
# memanggil libraries
library(dplyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

# membuat model
model = 
  MIPModel() %>%
  # add variables
  # non negative integers
  add_variable(x[n,h,s],
               n = 1:n_per,
               h = 1:14,
               s = 1:3,
               type = "binary",
               lb = 0) %>%
  # set obj function
  set_objective(sum_expr(x[n,h,s],
                         n = 1:n_per,
                         h = 1:14,
                         s = 1:3),
                "min") %>%
  # Syarat Minimal per Shift
  add_constraint(sum_expr(x[n,h,s],
                          n = 1:n_per) >= min_per,
                 h = 1:14,
                 s = 1:3) %>% 
  # add constraints
  # constraint I
  add_constraint(x[n,h,1] + x[n,h,2] + x[n,h,3] <= 1, 
                 n = 1:n_per,
                 h = 1:14) %>% 
  # constraint II
  add_constraint(x[n,h,3] + x[n,h+1,1] <= 1,
                 n = 1:n_per,
                 h = 1:13) %>% 
  # constraint III
  add_constraint(x[n,h,1] + x[n,h+1,1] + x[n,h+2,1] + x[n,h+3,1] + x[n,h+4,1] + 
                 x[n,h,2] + x[n,h+1,2] + x[n,h+2,2] + x[n,h+3,2] + x[n,h+4,2] + 
                 x[n,h,3] + x[n,h+1,3] + x[n,h+2,3] + x[n,h+3,3] + x[n,h+4,3] <= 4,
                 n = 1:n_per,
                 h = 1:9) %>% 
  # constraint IV tanggal 6
  add_constraint(2*(x[n,6,1] + x[n,6,2] + x[n,6,3]) + 
                 sum_expr(x[n,13,s],
                          s = 1:3) + 
                 sum_expr(x[n,14,s],
                          s = 1:3) <= 2,
                 n = 1:n_per) %>% 
  # constraint IV tanggal 7
  add_constraint(2*(x[n,7,1] + x[n,7,2] + x[n,7,3]) + 
                 sum_expr(x[n,13,s],
                          s = 1:3) + 
                 sum_expr(x[n,14,s],
                          s = 1:3) <= 2,
                 n = 1:n_per) %>% 
  # contraint V
  add_constraint(sum_expr(x[n,h,s],
                          h = 1:14,
                          s = 1:3) == ideal,
                 n = 1:n_per)
  
model
```

    ## Mixed integer linear optimization problem
    ## Variables:
    ##   Continuous: 0 
    ##   Integer: 0 
    ##   Binary: 1260 
    ## Model sense: minimize 
    ## Constraints: 1212

### *Solving*

Kemudian saya *solve* dengan **R**:

``` r
result = solve_model(model, with_ROI(solver = "glpk", verbose = TRUE))
```

    ## <SOLVER MSG>  ----
    ## GLPK Simplex Optimizer, v4.65
    ## 1212 rows, 1260 columns, 9150 non-zeros
    ##       0: obj =   0.000000000e+00 inf =   4.200e+02 (72)
    ##     416: obj =   2.100000000e+02 inf =   0.000e+00 (0) 1
    ## OPTIMAL LP SOLUTION FOUND
    ## GLPK Integer Optimizer, v4.65
    ## 1212 rows, 1260 columns, 9150 non-zeros
    ## 1260 integer variables, all of which are binary
    ## Integer optimization begins...
    ## Long-step dual simplex will be used
    ## +   416: mip =     not found yet >=              -inf        (1; 0)
    ## +   630: >>>>>   2.100000000e+02 >=   2.100000000e+02   0.0% (37; 0)
    ## +   630: mip =   2.100000000e+02 >=     tree is empty   0.0% (0; 73)
    ## INTEGER OPTIMAL SOLUTION FOUND
    ## <!SOLVER MSG> ----

## Solusi Optimal

### Jadwal Optimal

Berikut adalah jadwal optimal dalam kasus ini:

    ## Jadwal Perawat: Angka Pada Tanggal Menunjukkan id Perawat

| tanggal |     Pagi      |     Siang      |     Malam      |
| :-----: | :-----------: | :------------: | :------------: |
|    1    |   1,2,3,4,5   |  7,8,9,10,29   | 16,17,18,19,20 |
|    2    |  2,3,4,5,30   | 11,12,13,14,15 | 18,19,20,21,22 |
|    3    |  1,3,4,5,30   | 11,12,13,14,15 | 6,21,22,23,26  |
|    4    |  2,4,5,27,28  | 11,12,13,14,15 | 6,21,22,23,25  |
|    5    |  1,3,9,10,27  | 11,12,13,14,15 | 21,22,23,24,25 |
|    6    |   2,3,4,5,7   | 6,16,17,18,19  | 8,20,27,28,29  |
|    7    |   2,3,4,5,6   | 8,16,17,18,19  | 7,20,27,28,29  |
|    8    |   1,2,3,4,5   | 12,13,14,15,26 | 21,22,23,24,25 |
|    9    |   1,6,7,8,9   | 11,16,17,28,29 | 23,24,25,26,27 |
|   10    |  2,7,8,10,30  | 16,17,18,19,20 | 24,25,26,28,29 |
|   11    |  6,7,8,9,10   | 16,17,18,19,20 | 26,27,28,29,30 |
|   12    |  7,8,9,10,24  | 16,17,18,19,20 | 6,27,28,29,30  |
|   13    | 9,10,13,15,26 | 21,22,23,24,25 | 1,11,12,14,30  |
|   14    | 9,10,13,15,26 | 21,22,23,24,25 | 1,11,12,14,30  |

Sedangkan ini adalah rekapan banyaknya *shift* yang ditugaskan kepada
masing-masing perawat:

    ## Rekapan Berapa Kali Perawat Bertugas

| id\_perawat | Pagi | Siang | Malam |
| :---------: | :--: | :---: | :---: |
|      1      |  5   |  \-   |   2   |
|      2      |  7   |  \-   |  \-   |
|      3      |  7   |  \-   |  \-   |
|      4      |  7   |  \-   |  \-   |
|      5      |  7   |  \-   |  \-   |
|      6      |  3   |   1   |   3   |
|      7      |  5   |   1   |   1   |
|      8      |  4   |   2   |   1   |
|      9      |  6   |   1   |  \-   |
|     10      |  6   |   1   |  \-   |
|     11      |  \-  |   5   |   2   |
|     12      |  \-  |   5   |   2   |
|     13      |  2   |   5   |  \-   |
|     14      |  \-  |   5   |   2   |
|     15      |  2   |   5   |  \-   |
|     16      |  \-  |   6   |   1   |
|     17      |  \-  |   6   |   1   |
|     18      |  \-  |   5   |   2   |
|     19      |  \-  |   5   |   2   |
|     20      |  \-  |   3   |   4   |
|     21      |  \-  |   2   |   5   |
|     22      |  \-  |   2   |   5   |
|     23      |  \-  |   2   |   5   |
|     24      |  1   |   2   |   4   |
|     25      |  \-  |   2   |   5   |
|     26      |  2   |   1   |   4   |
|     27      |  2   |  \-   |   5   |
|     28      |  1   |   1   |   5   |
|     29      |  \-  |   2   |   5   |
|     30      |  3   |  \-   |   4   |

Dari rekapan di atas, semua perawat mendapatkan jatah *shift* yang sama.

-----

# *Discussion*

Mungkin rekan-rekan berpikir bahwa dari `14` hari yang ada, kenapa
masing-masing perawat mendapatkan *workload* **hanya** `7` hari saja?

Saya sudah mencoba menaikkan batas `ideal` menjadi `10` *shifts* per
perawat namun jadwal yang dihasilkan justru terlihat buruk. Beberapa
*shift* ditemukan terjadi penumpukan perawat sehingga terkesan tidak
efektif untuk dilakukan. Artinya, dari aturan-aturan *existing* yang ada
secara tidak langsung membatasi *workload* dari perawat.

-----

`if you find this article helpful, support this blog by clicking the
ads.`
