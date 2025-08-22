---
date: 2025-08-22T09:37:00-04:00
title: "Optimization Story: Perencanaan Produksi pada Industri Mebel"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Linear Programming
  - Optimization Story
  - Mixed Integer Linear Programming
  - Mebel
  - Produksi
  - Planning
---

## Masalah

Suatu industri UMKM “Mebel Jaya Selalu” memproduksi dua jenis produk
unggulan:

1.  Meja Belajar dan
2.  Rak Buku.

Untuk memproduksi kedua *items* tersebut, mereka membutuhkan tiga sumber
daya utama yang terbatas:

- Kayu mahoni,
- Kayu pinus, dan
- Jam kerja tukang kayu.

Pemilik UMKM ingin menentukan berapa banyak meja dan rak yang harus
diproduksi **dalam satu minggu** untuk memaksimalkan total keuntungan.

Masalah ini termasuk ke dalam *Mixed Integer Linear Programming*
(*MILP*) karena untuk memulai produksi salah satu jenis produk (meja
atau rak), ada biaya persiapan (*setup cost*). Biaya ini hanya muncul
satu kali jika produk tersebut diputuskan untuk diproduksi, tidak peduli
berapa banyak unit yang dibuat. Misalnya, biaya untuk menyiapkan mesin
potong khusus, membeli mata bor ukuran tertentu, dan lainnya.

Jika UMKM memutuskan tidak memproduksi meja sama sekali, maka biaya
persiapan untuk meja tidak perlu dikeluarkan.

## Data dan Asumsi

Berikut adalah data yang dimiliki oleh UMKM “Mebel Jaya Selalu”:

| Keterangan | Meja Belajar | Rak Buku | Ketersediaan Sumber Daya (per minggu) |
|----|----|----|----|
| **Keuntungan per Unit** | Rp 400.000 | Rp 250.000 | \- |
| **Kebutuhan Kayu Mahoni** | 4 meter | 2 meter | 100 meter |
| **Kebutuhan Kayu Pinus** | 2 meter | 3 meter | 90 meter |
| **Kebutuhan Jam Kerja** | 5 jam | 3 jam | 120 jam |
| **Biaya Persiapan (Setup Cost)** | Rp 500.000 | Rp 300.000 | \- |

Data Kebutuhan dan Persiapan Produksi

Tujuannya adalah untuk memaksimalkan **(Total Keuntungan dari
Penjualan) - (Total Biaya Persiapan)**.

## Perumusan Model Matematika *MILP*

Untuk menyelesaikan masalah ini, kita perlu merumuskannya ke dalam model
matematika.

**Variabel Keputusan**; kita membutuhkan dua jenis variabel:

- Variabel Kontinu/Integer (untuk jumlah produksi):
  - ![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1") = Jumlah Meja
    Belajar yang akan diproduksi.
  - ![x_2](https://latex.codecogs.com/svg.latex?x_2 "x_2") = Jumlah Rak
    Buku yang akan diproduksi. (Kita asumsikan
    ![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1") dan
    ![x_2](https://latex.codecogs.com/svg.latex?x_2 "x_2") harus
    bilangan bulat, karena tidak mungkin memproduksi setengah meja).
- Variabel Biner (untuk keputusan produksi “ya/tidak”):
  - ![y_1](https://latex.codecogs.com/svg.latex?y_1 "y_1") = Variabel
    keputusan untuk Meja Belajar.
    - ![y_1 = 1](https://latex.codecogs.com/svg.latex?y_1%20%3D%201 "y_1 = 1")
      jika Meja Belajar diproduksi
      (![x_1 \> 0](https://latex.codecogs.com/svg.latex?x_1%20%3E%200 "x_1 > 0")).
    - ![y_1 = 0](https://latex.codecogs.com/svg.latex?y_1%20%3D%200 "y_1 = 0")
      jika Meja Belajar tidak diproduksi
      (![x_1 = 0](https://latex.codecogs.com/svg.latex?x_1%20%3D%200 "x_1 = 0")).
  - ![y_2](https://latex.codecogs.com/svg.latex?y_2 "y_2") = Variabel
    keputusan untuk Rak Buku.
    - ![y_2 = 1](https://latex.codecogs.com/svg.latex?y_2%20%3D%201 "y_2 = 1")
      jika Rak Buku diproduksi
      (![x_2 \> 0](https://latex.codecogs.com/svg.latex?x_2%20%3E%200 "x_2 > 0")).
    - ![y_2 = 0](https://latex.codecogs.com/svg.latex?y_2%20%3D%200 "y_2 = 0")
      jika Rak Buku tidak diproduksi
      (![x_2 = 0](https://latex.codecogs.com/svg.latex?x_2%20%3D%200 "x_2 = 0")).

**Fungsi Tujuan**; Tujuannya adalah memaksimalkan keuntungan total
(![Z](https://latex.codecogs.com/svg.latex?Z "Z")). Keuntungan total
dihitung dari keuntungan penjualan dikurangi biaya persiapan.

![\text{Maksimalkan } Z = (400000 \cdot x_1 + 250000 \cdot x_2) - (500000 \cdot y_1 + 300000 \cdot y_2)](https://latex.codecogs.com/svg.latex?%5Ctext%7BMaksimalkan%20%7D%20Z%20%3D%20%28400000%20%5Ccdot%20x_1%20%2B%20250000%20%5Ccdot%20x_2%29%20-%20%28500000%20%5Ccdot%20y_1%20%2B%20300000%20%5Ccdot%20y_2%29 "\text{Maksimalkan } Z = (400000 \cdot x_1 + 250000 \cdot x_2) - (500000 \cdot y_1 + 300000 \cdot y_2)")

**Fungsi Kendala**; Kendala adalah batasan-batasan sumber daya yang ada.

- Kendala Kayu Mahoni: Total kayu mahoni yang digunakan tidak boleh
  melebihi yang tersedia.
  - ![4x_1 + 2x_2 \le 100](https://latex.codecogs.com/svg.latex?4x_1%20%2B%202x_2%20%5Cle%20100 "4x_1 + 2x_2 \le 100")
- Kendala Kayu Pinus: Total kayu pinus yang digunakan tidak boleh
  melebihi yang tersedia.
  - ![2x_1 + 3x_2 \le 90](https://latex.codecogs.com/svg.latex?2x_1%20%2B%203x_2%20%5Cle%2090 "2x_1 + 3x_2 \le 90")
- Kendala Jam Kerja: Total jam kerja yang digunakan tidak boleh melebihi
  yang tersedia.
  - ![5x_1 + 3x_2 \le 120](https://latex.codecogs.com/svg.latex?5x_1%20%2B%203x_2%20%5Cle%20120 "5x_1 + 3x_2 \le 120")
- Kendala Penghubung (*Linking Constraints*): Ini adalah bagian
  terpenting yang menghubungkan jumlah produksi
  (![x](https://latex.codecogs.com/svg.latex?x "x")) dengan keputusan
  produksi (![y](https://latex.codecogs.com/svg.latex?y "y")).
  - Kita perlu memastikan jika
    ![x_1 \> 0](https://latex.codecogs.com/svg.latex?x_1%20%3E%200 "x_1 > 0"),
    maka ![y_1](https://latex.codecogs.com/svg.latex?y_1 "y_1") harus
    bernilai 1. Caranya adalah dengan menggunakan **Big M Method**.
    - ![x_1 \le M \cdot y_1](https://latex.codecogs.com/svg.latex?x_1%20%5Cle%20M%20%5Ccdot%20y_1 "x_1 \le M \cdot y_1")
    - ![x_2 \le M \cdot y_2](https://latex.codecogs.com/svg.latex?x_2%20%5Cle%20M%20%5Ccdot%20y_2 "x_2 \le M \cdot y_2")
  - Penjelasan: ![M](https://latex.codecogs.com/svg.latex?M "M") adalah
    angka yang sangat besar (misalnya 1000, yang jelas lebih besar dari
    jumlah meja atau rak yang mungkin diproduksi).
    - Jika
      ![y_1 = 0](https://latex.codecogs.com/svg.latex?y_1%20%3D%200 "y_1 = 0"),
      maka kendala menjadi
      ![x_1 \le 0](https://latex.codecogs.com/svg.latex?x_1%20%5Cle%200 "x_1 \le 0").
      Karena ![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1")
      tidak bisa negatif, ini memaksa
      ![x_1 = 0](https://latex.codecogs.com/svg.latex?x_1%20%3D%200 "x_1 = 0").
      Artinya, tidak ada meja yang diproduksi.
    - Jika
      ![y_1 = 1](https://latex.codecogs.com/svg.latex?y_1%20%3D%201 "y_1 = 1"),
      maka kendala menjadi
      ![x_1 \le M](https://latex.codecogs.com/svg.latex?x_1%20%5Cle%20M "x_1 \le M").
      Ini menjadi kendala yang tidak mengikat (*redundant*), sehingga
      ![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1") bisa
      mengambil nilai berapapun selama masih memenuhi kendala sumber
      daya lain.
- Kendala Non-Negatif dan Tipe Variabel:
  - ![x_1, x_2 \ge 0 \text{ dan merupakan bilangan bulat (integer)}](https://latex.codecogs.com/svg.latex?x_1%2C%20x_2%20%5Cge%200%20%5Ctext%7B%20dan%20merupakan%20bilangan%20bulat%20%28integer%29%7D "x_1, x_2 \ge 0 \text{ dan merupakan bilangan bulat (integer)}")
  - ![y_1, y_2 \text{ adalah biner (0 atau 1)}](https://latex.codecogs.com/svg.latex?y_1%2C%20y_2%20%5Ctext%7B%20adalah%20biner%20%280%20atau%201%29%7D "y_1, y_2 \text{ adalah biner (0 atau 1)}")

## Model Optimisasi

![\text{Maksimalkan } Z = (400000 \cdot x_1 + 250000 \cdot x_2) - (500000 \cdot y_1 + 300000 \cdot y_2)](https://latex.codecogs.com/svg.latex?%5Ctext%7BMaksimalkan%20%7D%20Z%20%3D%20%28400000%20%5Ccdot%20x_1%20%2B%20250000%20%5Ccdot%20x_2%29%20-%20%28500000%20%5Ccdot%20y_1%20%2B%20300000%20%5Ccdot%20y_2%29 "\text{Maksimalkan } Z = (400000 \cdot x_1 + 250000 \cdot x_2) - (500000 \cdot y_1 + 300000 \cdot y_2)")

*Subject to*:

- ![4x_1 + 2x_2 \le 100](https://latex.codecogs.com/svg.latex?4x_1%20%2B%202x_2%20%5Cle%20100 "4x_1 + 2x_2 \le 100")
  (Kayu Mahoni).
- ![2x_1 + 3x_2 \le 90](https://latex.codecogs.com/svg.latex?2x_1%20%2B%203x_2%20%5Cle%2090 "2x_1 + 3x_2 \le 90")
  (Kayu Pinus).
- ![5x_1 + 3x_2 \le 120](https://latex.codecogs.com/svg.latex?5x_1%20%2B%203x_2%20%5Cle%20120 "5x_1 + 3x_2 \le 120")
  (Jam Kerja).
- ![x_1 \le 1000y_1](https://latex.codecogs.com/svg.latex?x_1%20%5Cle%201000y_1 "x_1 \le 1000y_1")
  (Kendala penghubung Meja).
- ![x_2 \le 1000y_2](https://latex.codecogs.com/svg.latex?x_2%20%5Cle%201000y_2 "x_2 \le 1000y_2")
  (Kendala penghubung Rak).
- ![x_1, x_2 \ge 0](https://latex.codecogs.com/svg.latex?x_1%2C%20x_2%20%5Cge%200 "x_1, x_2 \ge 0")
  dan integer.
- ![y_1, y_2 biner](https://latex.codecogs.com/svg.latex?y_1%2C%20y_2%20biner "y_1, y_2 biner")
  (0 atau 1).

**Solusi dari model** ini akan memberi tahu pemilik UMKM secara pasti:

1.  Apakah mereka harus memproduksi meja belajar? (nilai
    ![y_1](https://latex.codecogs.com/svg.latex?y_1 "y_1")).
2.  Apakah mereka harus memproduksi rak buku? (nilai
    ![y_2](https://latex.codecogs.com/svg.latex?y_2 "y_2")).
3.  Jika ya, berapa unit masing-masing yang harus diproduksi? (nilai
    ![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1") dan
    ![x_2](https://latex.codecogs.com/svg.latex?x_2 "x_2")).
4.  Berapa keuntungan maksimal yang bisa didapat? (nilai
    ![Z](https://latex.codecogs.com/svg.latex?Z "Z")).

## Menyelesaikan Model

Untuk menyelesaikan model di atas, kita akan menggunakan dua pendekatan
yakni `ompr` dengan **R** dan `or tools` dengan **Python**.

### `ompr` di **R**

Berikut adalah skripnya:

``` r
library(dplyr)
library(tidyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

bin_prog = 
  MIPModel() %>%
  # menambah variabel
  add_variable(x[i],i = 1:2,type = "integer",lb = 0) %>%
  add_variable(y[i],i = 1:2,type = "binary")  |> 
  # membuat objective function
  set_objective((400000*x[1]) + (250000*x[2]) - (500000*y[1]) - (300000*y[2]), 
                "max") |> 
  # menambah constraints
  add_constraint((4*x[1]) + (2*x[2]) <= 100) |> 
  add_constraint((2*x[1]) + (3*x[2]) <= 90) |> 
  add_constraint((5*x[1]) + (3*x[2]) <= 120) |> 
  add_constraint(x[1] <= 1000*y[1]) |> 
  add_constraint(x[2] <= 1000*y[2])
```

Berikut adalah hasilnya:

| jenis | produksi |
|:------|---------:|
| Meja  |        1 |
| Rak   |        0 |

| jenis | unit |
|:------|-----:|
| Meja  |   24 |
| Rak   |    0 |

Ternyata dengan memproduksi meja sebanyak **24 unit** akan memaksimalkan
keuntungan UMKM tersebut.

### `or tools` di **Python**

**OR-Tools** (***Operations Research Tools***) adalah *library*
*open-source* buatan Google yang dikembangkan untuk menyelesaikan
masalah optimasi kombinatorial dan pemrograman matematika. Diluncurkan
sekitar tahun 2010, *library* ini dirancang untuk menjadi alat yang
*scalable* dan efisien dalam menyelesaikan masalah kompleks seperti
*routing* kendaraan, penjadwalan, penugasan, dan optimasi linear.
**OR-Tools** dibangun berdasarkan pengalaman internal Google dalam
menangani masalah optimasi skala besar dan menggabungkan berbagai
*state-of-the-art solver* serta algoritma heuristik.

Yang membuat **OR-Tools** istimewa adalah dukungannya terhadap *multiple
programming* *languages* (C++, Python, Java, C#), fleksibilitas dalam
pemodelan masalah, dan kemampuan untuk menangani berbagai tipe masalah
optimasi seperti *linear programming*, *constraint programming*, dan
*mixed-integer programming*. *Library* ini tidak hanya menyediakan
*solver* internal yang powerful tetapi juga dapat terintegrasi dengan
*solver* eksternal seperti `SCIP`, `GLPK`, dan `CP-SAT`, menjadikannya
pilihan populer baik untuk penelitian akademis maupun aplikasi industri
skala enterprise.

Jangan lupa untuk menginstall `ortools` di `terminal`:

    pip install ortools

Berikut adalah skrip di **Python** nya:

    from ortools.linear_solver import pywraplp

    def solve_milp():
        # Membuat solver
        solver = pywraplp.Solver.CreateSolver('SCIP')
        
        # Membuat variabel
        x = {}
        y = {}
        for i in range(1, 3):
            x[i] = solver.IntVar(0, solver.infinity(), f'x_{i}')
            y[i] = solver.BoolVar(f'y_{i}')
        
        # Membuat objective function
        objective = solver.Objective()
        objective.SetCoefficient(x[1], 400000)
        objective.SetCoefficient(x[2], 250000)
        objective.SetCoefficient(y[1], -500000)
        objective.SetCoefficient(y[2], -300000)
        objective.SetMaximization()
        
        # Menambah constraints
        # Constraint 1: 4*x1 + 2*x2 <= 100
        constraint1 = solver.Constraint(-solver.infinity(), 100)
        constraint1.SetCoefficient(x[1], 4)
        constraint1.SetCoefficient(x[2], 2)
        
        # Constraint 2: 2*x1 + 3*x2 <= 90
        constraint2 = solver.Constraint(-solver.infinity(), 90)
        constraint2.SetCoefficient(x[1], 2)
        constraint2.SetCoefficient(x[2], 3)
        
        # Constraint 3: 5*x1 + 3*x2 <= 120
        constraint3 = solver.Constraint(-solver.infinity(), 120)
        constraint3.SetCoefficient(x[1], 5)
        constraint3.SetCoefficient(x[2], 3)
        
        # Constraint 4: x1 <= 1000*y1
        constraint4 = solver.Constraint(-solver.infinity(), 0)
        constraint4.SetCoefficient(x[1], 1)
        constraint4.SetCoefficient(y[1], -1000)
        
        # Constraint 5: x2 <= 1000*y2
        constraint5 = solver.Constraint(-solver.infinity(), 0)
        constraint5.SetCoefficient(x[2], 1)
        constraint5.SetCoefficient(y[2], -1000)
        
        # Solve the problem
        status = solver.Solve()
        
        # Print results
        if status == pywraplp.Solver.OPTIMAL:
            print('Solution:')
            print('Objective value =', solver.Objective().Value())
            for i in range(1, 3):
                print(f'x[{i}] =', x[i].solution_value())
            for i in range(1, 3):
                print(f'y[{i}] =', int(y[i].solution_value()))
        else:
            print('The problem does not have an optimal solution.')

    # Run the solver
    solve_milp()

Kita dapatkan hasil yang sama, yakni:

    Solution:
    Objective value = 9100000.000000002
    x[1] = 24.0
    x[2] = 0.0
    y[1] = 1
    y[2] = 0


---
  
`if you find this article helpful, support this blog by clicking the ads.`

