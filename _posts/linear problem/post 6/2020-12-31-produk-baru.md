---
date: 2020-12-31T07:58:00-04:00
title: "Optimization Story: Memilih dan Menentukan Produksi yang Optimal dengan MILP"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Linear Programming
  - Binary Linear Programming
  - MILP
  - Mixed Integer Linear Programming
---

Menyambut tahun 2021, saya rasa tema analisa yang akan sering saya temui
di pekerjaan tahun depan adalah *optimization*. Jadi ada baiknya saya
bersiap dengan *ngoprek* lebih jaub terkait ini.

Setidaknya sudah ada empat metode yang sudah pernah saya lakukan dan
tulis di blog ini terkait dengan *optimization*, yakni:

1.  Simulasi Monte Carlo,
2.  Visual (grafik),
3.  *Aljabar-based framework* menggunakan `library(lpSolve)`,
4.  Formulasi model matematis menggunakan `ompr`.

Berdasarkan kasus-kasus yang pernah saya bahas, kasus *optimization*
yang sifatnya **sukar** hingga **sukar sekali** bisa diselesaikan dengan
lebih mudah dengan `ompr` karena saya tidak perlu membangun matriks.
Namun *tricky parts*-nya adalah saya harus menuliskan model
matematikanya.

Sekarang saya akan berikan contoh satu kasus dimana *optimization* bisa
dilakukan untuk kasus yang relatif rumit.

-----

# *Problem*

Suatu pabrik makanan/minuman sedang berencana untuk membuat `3` produk
baru yang rencananya akan diproduksi di `2` *plant* yang berbeda.

    ## Tabel Keterangan Produksi

|       keterangan        | produk\_1 | produk\_2 | produk\_3 | limit\_production\_time\_per\_plant\_per\_day |
| :---------------------: | :-------: | :-------: | :-------: | :-------------------------------------------: |
|      Plant 1, jam       |     3     |     4     |     2     |                      30                       |
|      Plant 2, jam       |     4     |     6     |     2     |                      40                       |
|     Profit per ton      |     5     |     7     |     3     |                                               |
| Sales Potential per ton |     7     |     5     |     9     |                                               |

Masalah timbul saat mereka harus memilih maksimal `2` dari `3` produk
baru yang harus diproduksi. Selain itu, mereka juga harus memilih hanya
`1` dari `2` *plant* yang memproduksi produk-produk tersebut.

> Bagaimana cara mereka memilihnya? Lalu berapa ton yang harus
> diproduksi dari produk yang dipilih tersebut?

-----

# Formulasi Matematika

Oke, sekarang saya akan membuat formulasi matematika dari masalah di
atas. Berbeda dengan masalah *optimization* yang telah saya [tulis
sebelumnya](https://ikanx101.com/tags/#linear-programming), masalah ini
merupakan kombinasi dari *binary integer* dan *continuous*.

> Maksudnya *gimana yah*?

  - Kita harus memilih maksimal `2` produk: *binary integer*.
  - Kita harus menentukan berapa ton yang harus di produksi:
    *continuous*.
  - Kita harus memilih `1` *plant*: *binary integer*.

Sudah mulai terbayang? Oke, saya mulai *yah*.

## Definisi awal

Misalkan:

  - ![x\[i\]
    \\geq 0](https://latex.codecogs.com/png.latex?x%5Bi%5D%20%5Cgeq%200
    "x[i] \\geq 0") untuk ![i
    = 1,2,3](https://latex.codecogs.com/png.latex?i%20%3D%201%2C2%2C3
    "i = 1,2,3") menandakan berapa ton yang harus diproduksi dari produk
    ke ![i](https://latex.codecogs.com/png.latex?i "i").
  - ![y\[i\] =
    \[0,1\]](https://latex.codecogs.com/png.latex?y%5Bi%5D%20%3D%20%5B0%2C1%5D
    "y[i] = [0,1]") untuk ![i
    = 1,2,3](https://latex.codecogs.com/png.latex?i%20%3D%201%2C2%2C3
    "i = 1,2,3") menandakan produk apa saja yang akan dipilih.
      - Nilai `1` menandakan produk ke
        ![i](https://latex.codecogs.com/png.latex?i "i") dipilih.
      - Nilai `0` menandakan produk ke
        ![i](https://latex.codecogs.com/png.latex?i "i") tidak dipilih.
  - ![z\[j\] =
    \[0,1\]](https://latex.codecogs.com/png.latex?z%5Bj%5D%20%3D%20%5B0%2C1%5D
    "z[j] = [0,1]") untuk
    ![j=1](https://latex.codecogs.com/png.latex?j%3D1 "j=1") menandakan
    *plant* mana yang akan dipilih.
      - Nilai `0` menandakan *plant* pertama akan dipilih.
      - Nilai `1` menandakan *plant* kedua akan dipilih.

Saya akan definisikan suatu angka *dummy*: ![M
= 9999](https://latex.codecogs.com/png.latex?M%20%3D%209999 "M = 9999").
Bernilai angka yang **besar** sebagai *reinforce* model *optimization*
agar bisa memilih produk dan *plant* secara bersamaan.

## *Decision Variable*

### *Objective Function*

Tujuan utama dari model *optimization* ini adalah memaksimalkan profit
yang akan didapatkan oleh perusahaan:

  
![MAX \\sum\_{i=1}^{3}
x\[i\]\*profit\[i\]](https://latex.codecogs.com/png.latex?MAX%20%5Csum_%7Bi%3D1%7D%5E%7B3%7D%20x%5Bi%5D%2Aprofit%5Bi%5D
"MAX \\sum_{i=1}^{3} x[i]*profit[i]")  

## *Constraints*

Berikut adalah *constraints* dari model ini:

Tonase produksi per produk tidak boleh melebihi tonase *sales
potential*:

  
![x\[i\] \\leq salespotential\[i\], i
= 1,2,3](https://latex.codecogs.com/png.latex?x%5Bi%5D%20%5Cleq%20salespotential%5Bi%5D%2C%20i%20%3D%201%2C2%2C3
"x[i] \\leq salespotential[i], i = 1,2,3")  

Sekarang saya harus memilih maksimal `2` dari `3` produk sekalian
menghitung tonase:

  
![x\[i\] - y\[i\] \* M \\leq 0, i
= 1,2,3](https://latex.codecogs.com/png.latex?x%5Bi%5D%20-%20y%5Bi%5D%20%2A%20M%20%5Cleq%200%2C%20i%20%3D%201%2C2%2C3
"x[i] - y[i] * M \\leq 0, i = 1,2,3")  
  
![\\sum\_{i = 1}^{3} y\[i\]
\\leq 2](https://latex.codecogs.com/png.latex?%5Csum_%7Bi%20%3D%201%7D%5E%7B3%7D%20y%5Bi%5D%20%5Cleq%202
"\\sum_{i = 1}^{3} y[i] \\leq 2")  

Sekarang saya harus memilih `1` dari `2` *plant* berdasarkan jam
produksi:

  
![3\*x\[1\] + 4\*x\[2\] + 2\*x\[3\] - M \* z\[1\]
\\leq 30](https://latex.codecogs.com/png.latex?3%2Ax%5B1%5D%20%2B%204%2Ax%5B2%5D%20%2B%202%2Ax%5B3%5D%20-%20M%20%2A%20z%5B1%5D%20%5Cleq%2030
"3*x[1] + 4*x[2] + 2*x[3] - M * z[1] \\leq 30")  
  
![4\*x\[1\] + 6\*x\[2\] + 2\*x\[3\] + M \* z\[1\] \\leq 40 +
M](https://latex.codecogs.com/png.latex?4%2Ax%5B1%5D%20%2B%206%2Ax%5B2%5D%20%2B%202%2Ax%5B3%5D%20%2B%20M%20%2A%20z%5B1%5D%20%5Cleq%2040%20%2B%20M
"4*x[1] + 6*x[2] + 2*x[3] + M * z[1] \\leq 40 + M")  

-----

# Solusi

Solusi yang saya dapatkan dari model di atas adalah:

  - ![x\[1\]
    = 5.5](https://latex.codecogs.com/png.latex?x%5B1%5D%20%3D%205.5
    "x[1] = 5.5")
  - ![x\[2\]
    = 0](https://latex.codecogs.com/png.latex?x%5B2%5D%20%3D%200
    "x[2] = 0")
  - ![x\[3\]
    = 9](https://latex.codecogs.com/png.latex?x%5B3%5D%20%3D%209
    "x[3] = 9")
  - ![y\[1\]
    = 1](https://latex.codecogs.com/png.latex?y%5B1%5D%20%3D%201
    "y[1] = 1")
  - ![y\[2\]
    = 0](https://latex.codecogs.com/png.latex?y%5B2%5D%20%3D%200
    "y[2] = 0")
  - ![y\[3\]
    = 1](https://latex.codecogs.com/png.latex?y%5B3%5D%20%3D%201
    "y[3] = 1")
  - ![z\[1\]
    = 1](https://latex.codecogs.com/png.latex?z%5B1%5D%20%3D%201
    "z[1] = 1")

# Kesimpulan

  - Dari ketiga produk baru, perusahaan bisa memilih produk `1` dan `3`
    dengan konfigurasi produk `1` sebanyak `5.5` ton dan produk `3`
    sebanyak `9` ton.
  - Dari *plant* yang ada, perusahaan bisa memilih *plant* `2` agar bisa
    menyelesaikan tonase produksi tersebut tanpa melanggar *limit* jam
    produksi.
  - Profit yang bisa diraih adalah sebesar `54.5`.
