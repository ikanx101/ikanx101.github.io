---
date: 2020-12-24T14:25:00-04:00
title: "Optimization Story: Masalah Penjadwalan Tenaga Kesehatan di Rumah Sakit"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Linear Programming
  - Aljabar
  - Simulasi
  - Binary Linear Programming
  - Montecarlo
  - Optimization Story
---


Gara-gara tulisan saya terakhir terkait [*Linear
Programming*](https://ikanx101.com/blog/linear-r/) untuk menyelesaikan
masalah [*product portofolio* di
*marketplace*](https://ikanx101.com/blog/binary-marketplace/) yang lalu,
saya jadi *gak* mau lepas untuk *ngoprek* lebih lanjut terkait hal ini.

Setelah membaca jurnal ini itu dan tulisan ini itu, saya mendapati salah
satu faedah dari *linear programming* adalah bisa untuk menyelesaikan
*schedulling problem*. Mulai dari yang simpel hingga yang rumit.

> Salah satu teknik yang saya ketahui bisa menyelesaikan *schedulling
> problem* adalah dengan memanfaatkan algoritma *travelling salesman
> problem* dengan memodifikasi matriks jarak sehingga bisa *applied*
> dengan masalah jadwal. Topik ini akan saya simpan untuk tulisan di
> kemudian hari *yah*.

*Nah* kali ini, saya akan memberikan contoh bagaimana *linear
programming* bisa digunakan untuk menyelesaikan *schedulling problem*
sederhana di rumah sakit.

> Ingat *yah*, ini masih case yang sederhana. Kalau rumit gimana?
> Percayalah, masalah rumit bisa dipecah menjadi masalah-masalah yang
> sederhana. Jadi secara algoritma, bisa kita pecah-pecah menjadi
> beberapa algoritma yang saling terhubung.

-----

# *Problem*

Pada masa pandemi ini, suatu rumah sakit membutuhkan tenaga kesehatan
yang siap sedia setiap hari. Di setiap harinya, mereka membutuhkan
minimal nakes tertentu agar pelayanan bisa dilakukan secara maksimal.
Tapi mereka tidak bisa mempekerjakan terlalu banyak nakes karena alasan
ruang dan *budget* yang terbatas.

Berikut adalah tabel kebutuhan nakes di rumah sakit tersebut setiap
harinya:

|  hari  | min\_nakes\_required | max\_nakes\_required |
| :----: | :------------------: | :------------------: |
| Senin  |          24          |          29          |
| Selasa |          22          |          27          |
|  Rabu  |          23          |          28          |
| Kamis  |          11          |          16          |
| Jumat  |          16          |          21          |
| Sabtu  |          20          |          25          |
| Minggu |          12          |          17          |

Jika berlaku kondisi sebagai berikut:

1.  Setiap nakes yang bekerja hanya diperbolehkan bekerja 5 hari secara
    berturut-turut dan harus istirahat (libur) secara 2 hari
    berturut-turut.
2.  *Shift* atau jam kerja kita abaikan dulu sementara.

Pertanyaannya:

> Berapa banyak nakes yang harus dipekerjakan oleh rumah sakit tersebut?

-----

# Mencari Solusi

Untuk memudahkan saya membuat formulasi matematika dari *problem* di
atas, saya akan buat terlebih dahulu tabel jadwal berikut:

|  hari  | x1 | x2 | x3 | x4 | x5 | x6 | x7 | min\_nakes\_required | max\_nakes\_required |
| :----: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :------------------: | :------------------: |
| Senin  | v  |    |    | v  | v  | v  | v  |          24          |          29          |
| Selasa | v  | v  |    |    | v  | v  | v  |          22          |          27          |
|  Rabu  | v  | v  | v  |    |    | v  | v  |          23          |          28          |
| Kamis  | v  | v  | v  | v  |    |    | v  |          11          |          16          |
| Jumat  | v  | v  | v  | v  | v  |    |    |          16          |          21          |
| Sabtu  |    | v  | v  | v  | v  | v  |    |          20          |          25          |
| Minggu |    |    | v  | v  | v  | v  | v  |          12          |          17          |

Keterangan:

  - ![x\_1,x\_2,x\_3,x\_4,x\_5,x\_6,x\_7](https://latex.codecogs.com/png.latex?x_1%2Cx_2%2Cx_3%2Cx_4%2Cx_5%2Cx_6%2Cx_7
    "x_1,x_2,x_3,x_4,x_5,x_6,x_7") menandakan kelompok nakes yang perlu
    dipekerjakan.
  - Nilai ![x](https://latex.codecogs.com/png.latex?x "x") berupa
    bilangan bulat positif: ![x \\geq 0,x \\in
    integer](https://latex.codecogs.com/png.latex?x%20%5Cgeq%200%2Cx%20%5Cin%20integer
    "x \\geq 0,x \\in integer").
  - `v` menandakan hari saat kelompok nakes harus masuk kerja.

## Formulasi Matematika

Dari tabel di atas, kita akan buat formulasi matematikanya berikut:

### *Objective Function*

Tujuan kita kali ini adalah menentukan jumlah nakes seminimal mungkin
yang bisa memenuhi tabel di atas:

  
![MIN(x\_1+x\_2+x\_3+x\_4+x\_5+x\_6+x\_7)](https://latex.codecogs.com/png.latex?MIN%28x_1%2Bx_2%2Bx_3%2Bx_4%2Bx_5%2Bx_6%2Bx_7%29
"MIN(x_1+x_2+x_3+x_4+x_5+x_6+x_7)")  

## *Constraint*

Dari tabel, kita bisa tuliskan *constraints* sebagai berikut:

  - Hari Senin: ![min\_{required} \\leq x\_1+x\_4+x\_5+x\_6+x\_7 \\leq
    max\_{required}](https://latex.codecogs.com/png.latex?min_%7Brequired%7D%20%5Cleq%20x_1%2Bx_4%2Bx_5%2Bx_6%2Bx_7%20%5Cleq%20max_%7Brequired%7D
    "min_{required} \\leq x_1+x_4+x_5+x_6+x_7 \\leq max_{required}")
  - Hari Selasa: ![min\_{required} \\leq x\_1+x\_2+x\_5+x\_6+x\_7 \\leq
    max\_{required}](https://latex.codecogs.com/png.latex?min_%7Brequired%7D%20%5Cleq%20x_1%2Bx_2%2Bx_5%2Bx_6%2Bx_7%20%5Cleq%20max_%7Brequired%7D
    "min_{required} \\leq x_1+x_2+x_5+x_6+x_7 \\leq max_{required}")
  - Hari Rabu: ![min\_{required} \\leq x\_1+x\_2+x\_3+x\_6+x\_7 \\leq
    max\_{required}](https://latex.codecogs.com/png.latex?min_%7Brequired%7D%20%5Cleq%20x_1%2Bx_2%2Bx_3%2Bx_6%2Bx_7%20%5Cleq%20max_%7Brequired%7D
    "min_{required} \\leq x_1+x_2+x_3+x_6+x_7 \\leq max_{required}")
  - Hari Kamis: ![min\_{required} \\leq x\_1+x\_2+x\_3+x\_4+x\_7 \\leq
    max\_{required}](https://latex.codecogs.com/png.latex?min_%7Brequired%7D%20%5Cleq%20x_1%2Bx_2%2Bx_3%2Bx_4%2Bx_7%20%5Cleq%20max_%7Brequired%7D
    "min_{required} \\leq x_1+x_2+x_3+x_4+x_7 \\leq max_{required}")
  - Hari Jumat: ![min\_{required} \\leq x\_1+x\_2+x\_3+x\_4+x\_5 \\leq
    max\_{required}](https://latex.codecogs.com/png.latex?min_%7Brequired%7D%20%5Cleq%20x_1%2Bx_2%2Bx_3%2Bx_4%2Bx_5%20%5Cleq%20max_%7Brequired%7D
    "min_{required} \\leq x_1+x_2+x_3+x_4+x_5 \\leq max_{required}")
  - Hari Sabtu: ![min\_{required} \\leq x\_2+x\_3+x\_4+x\_5+x\_6 \\leq
    max\_{required}](https://latex.codecogs.com/png.latex?min_%7Brequired%7D%20%5Cleq%20x_2%2Bx_3%2Bx_4%2Bx_5%2Bx_6%20%5Cleq%20max_%7Brequired%7D
    "min_{required} \\leq x_2+x_3+x_4+x_5+x_6 \\leq max_{required}")
  - Hari Minggu: ![min\_{required} \\leq x\_3+x\_4+x\_5+x\_6+x\_7 \\leq
    max\_{required}](https://latex.codecogs.com/png.latex?min_%7Brequired%7D%20%5Cleq%20x_3%2Bx_4%2Bx_5%2Bx_6%2Bx_7%20%5Cleq%20max_%7Brequired%7D
    "min_{required} \\leq x_3+x_4+x_5+x_6+x_7 \\leq max_{required}")

## Saatnya mencari solusi\!

Jika kita buat matriks dari persamaan di atas:

    ## Constraint minimum required

    ##      x1  x2  x3  x4  x5  x6  x7  min 
    ## [1,] "1" "0" "0" "1" "1" "1" "1" "24"
    ## [2,] "1" "1" "0" "0" "1" "1" "1" "22"
    ## [3,] "1" "1" "1" "0" "0" "1" "1" "23"
    ## [4,] "1" "1" "1" "1" "0" "0" "1" "11"
    ## [5,] "1" "1" "1" "1" "1" "0" "0" "16"
    ## [6,] "0" "1" "1" "1" "1" "1" "0" "20"
    ## [7,] "0" "0" "1" "1" "1" "1" "1" "12"

    ## Constraint maximum required

    ##      x1  x2  x3  x4  x5  x6  x7  max 
    ## [1,] "1" "0" "0" "1" "1" "1" "1" "29"
    ## [2,] "1" "1" "0" "0" "1" "1" "1" "27"
    ## [3,] "1" "1" "1" "0" "0" "1" "1" "28"
    ## [4,] "1" "1" "1" "1" "0" "0" "1" "16"
    ## [5,] "1" "1" "1" "1" "1" "0" "0" "21"
    ## [6,] "0" "1" "1" "1" "1" "1" "0" "25"
    ## [7,] "0" "0" "1" "1" "1" "1" "1" "17"

Saat saya hitung dengan `library(lpSolve)`, saya dapatkan

    ## Success: the objective function is 28

Kita cukup memerlukan 28 orang nakes untuk memenuhi kebutuhan rumah
sakit tersebut. Bagaimana konfigurasi nakesnya?

    ## Konfigurasi Nakes per Kelompok Kerja

| kelompok\_nakes | banyak\_nakes |
| :-------------: | :-----------: |
|       x1        |       8       |
|       x2        |       3       |
|       x3        |       0       |
|       x4        |       5       |
|       x5        |       0       |
|       x6        |      12       |
|       x7        |       0       |

Oke, biar tidak bingung, saya kembalikan ke tabel di atas.

    ## Konfigurasi Final Solusi

|  hari  | x1 | x2 | x3 | x4 | x5 | x6 | x7 | min\_required | max\_required | rekomendasi\_pekerja |
| :----: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-----------: | :-----------: | :------------------: |
| Senin  | 8  | 0  | 0  | 5  | 0  | 12 | 0  |      24       |      29       |          25          |
| Selasa | 8  | 3  | 0  | 0  | 0  | 12 | 0  |      22       |      27       |          23          |
|  Rabu  | 8  | 3  | 0  | 0  | 0  | 12 | 0  |      23       |      28       |          23          |
| Kamis  | 8  | 3  | 0  | 5  | 0  | 0  | 0  |      11       |      16       |          16          |
| Jumat  | 8  | 3  | 0  | 5  | 0  | 0  | 0  |      16       |      21       |          16          |
| Sabtu  | 0  | 3  | 0  | 5  | 0  | 12 | 0  |      20       |      25       |          20          |
| Minggu | 0  | 0  | 0  | 5  | 0  | 12 | 0  |      12       |      17       |          17          |

-----

# *Summary*

Dari kasus ini, saya bisa mendapatkan konfigurasi terbaik berapa banyak
nakes yang harus dipekerjakan setiap harinya.

Jika mau dibuat lebih detail, misalkan:

1.  Detail *shift*.
2.  Tambahan *constraint* *wages* dan syarat-syarat per nakes.

Saya tinggal membuat formulasi matematika yang lebih detail lagi.
