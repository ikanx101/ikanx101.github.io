---
date: 2026-03-30T14:25:00-04:00
title: "Conjoint Analysis untuk Develop Produk Minuman Baru"
categories:
  - Blog
tags:
  - Market Riset
  - Artificial Intelligence
  - Machine Learning
  - Conjoint Analysis
  - Conjoint
  - New Product Development
  - FMCG
  - Teh
---

Pada tahun 2021 lalu, saya sempat menuliskan suatu teknik analisa
bernama [*Conjoint Analysis* yang sangat berguna di bidang *market
research*](https://ikanx101.com/blog/conjoint/). Kali ini, saya hendak
menulis ulang tentang analisa ini dengan suatu studi kasus terbaru.

------------------------------------------------------------------------

Misalkan suatu waktu perusahaan saya hendak meluncurkan suatu produk
minuman teh kemasan. Sebelum *launching*, saya ingin tahu preferensi
konsumen dengan cara membuat survey market riset. Cara yang paling mudah
adalah dengan membuat satu pertanyaan klasik sebagai berikut:

**“Seberapa penting bagi Anda bahwa minuman teh ini:**

- menggunakan bahan alami 100%?
- dikemas dalam botol ramah lingkungan?
- harganya terjangkau?
- rasanya enak?

Pertanyaan tersebut dijawab menggunakan skala *likert* 1 - 6 dimana 1
adalah sangat tidak penting dan 6 adalah sangat penting.

Untuk orang Indonesia, hasil survey ini sudah bisa ditebak: bisa
dipastikan hampir semua responden menjawab 5 atau 6 untuk semua atribut.

> Tentu saja — siapa yang mau bilang harga tidak penting, atau rasa
> boleh biasa-biasa saja?

Inilah yang disebut *social desirability bias* dan *acquiescence bias*
dalam survei. Responden cenderung memberikan jawaban yang ‘benar’ secara
norma sosial, bukan jawaban yang mencerminkan perilaku nyata mereka.

*Conjoint Analysis* hadir untuk memecahkan masalah ini. Alih-alih
bertanya langsung ‘apa yang penting?’, *conjoint* memaksa responden
untuk membuat pilihan nyata di antara produk-produk hipotetis — persis
seperti yang mereka lakukan di toko. Dari pola pilihan itu, kita bisa
menghitung secara matematika: atribut mana yang paling menentukan
keputusan beli, dan seberapa besar bobotnya.

# Konsep Dasar *Conjoint Analysis*

## Apa itu *Conjoint Analysis*?

*Conjoint Analysis* adalah teknik statistik dalam market riset yang
digunakan untuk mengukur preferensi konsumen terhadap atribut-atribut
produk. Nama ‘*conjoint*’ berasal dari frasa ‘*considered jointly*’,
yakni konsumen menilai kombinasi atribut secara bersamaan, bukan satu
per satu.

Teknik ini pertama kali dikembangkan oleh psikolog matematika Paul Green
dan Vithala Rao pada tahun 1971 dan sejak itu menjadi salah satu metode
paling banyak digunakan dalam market riset profesional, mulai dari riset
produk FMCG, otomotif, hingga *financial services*.

## Konsep Kunci: *Part-Worth Utility*

Inti dari *conjoint analysis* adalah konsep *utility* (kegunaan). Setiap
level dari setiap atribut produk memiliki ‘*part-worth utility*’, yakni
nilai numerik yang merepresentasikan seberapa besar level tersebut
berkontribusi pada preferensi konsumen secara keseluruhan.

**Analogi sederhananya sebagai berikut:**

Bayangkan sebuah gelas minuman teh. Total **nilai** di mata konsumen =
(*utility* rasa manis) + (*utility* ukuran sedang) + (*utility* harga
Rp5.000) + (*utility* kemasan botol).

*Conjoint analysis* menghitung masing-masing angka tersebut dari data
pilihan konsumen.

## Tiga Jenis *Conjoint Analysis*

| Jenis | Cara Kerja | Kapan Digunakan? |
|----|----|----|
| Traditional / Rating-Based | Responden menilai setiap profil produk dengan skor (misal 1–10) | Ketika atribut sedikit (≤6) dan level sedikit (≤3) |
| Choice-Based (CBC) | Responden memilih satu dari beberapa alternatif produk (termasuk opsi ‘tidak membeli’) | Paling umum di market research modern, paling mendekati perilaku nyata |
| Adaptive (ACBC) | Pertanyaan beradaptasi berdasarkan jawaban sebelumnya | Ketika atribut sangat banyak (\>8) atau banyak variasi level |

Untuk tulisan ini, saya akan membahas *Traditional Conjoint* terlebih
dahulu karena paling mudah dipahami secara matematis.

## Merancang Studi Conjoint: Produk Minuman Teh Kemasan

Kita akan mensimulasikan riset untuk *brand* minuman teh kemasan yang
ingin memahami preferensi konsumen usia remaja - aktif (18–35 tahun) di
kota besar Indonesia. Ada empat pertanyaan utama, yakni:

1.  Atribut mana yang paling menentukan keputusan beli?
2.  Berapa harga optimal yang masih bisa diterima konsumen?
3.  Apakah konsumen benar-benar peduli dengan klaim ‘bahan alami’?
4.  Profil produk mana yang paling kompetitif di pasar?

### Langkah 1: Mendefinisikan Atribut dan Level

Langkah pertama dan terpenting dalam *conjoint* adalah memilih atribut
yang relevan dan levelnya. **Terlalu banyak atribut akan membuat
responden kelelahan** karena pertanyaan yang perlu dijawab sangat
banyak. Namun **terlalu sedikit atribut tidak menangkap realita pasar**.

Berikut adalah atribut dan level yang saya definisikan:

|  |  |  |
|----|----|----|
| **Atribut** | **Level-Level** | **Alasan** |
| Rasa | Manis, Sedikit Manis, Tidak Manis | Tren kesehatan membuat ‘tidak manis’ makin populer |
| Ukuran | 250ml, 500ml, 1000ml | Mewakili segmen minum langsung, sekali makan, dan keluarga |
| Klaim Bahan | Alami 100%, Tanpa Pengawet, Reguler | Mengukur seberapa besar premium untuk klaim health |
| Kemasan | Botol Plastik, Botol Kaca, Kotak Karton | Aspek sustainability & portabilitas |
| Harga | Rp4.000, Rp7.000, Rp12.000, Rp18.000 | 4 level harga untuk menangkap price sensitivity |

### Langkah 2: Membuat *Fractional Factorial Design* di R

Langkah krusial pada *Conjoint Analysis* adalah membuat *factorial
design* yang bersifat *orthogonal*. *Orthogonal design* dalam *conjoint
analysis* adalah metode untuk membuat kombinasi produk yang efisien
dengan memilih *subset* atribut dan level yang saling independen secara
statistik, sehingga setiap atribut berkontribusi secara unik terhadap
preferensi konsumen tanpa adanya korelasi atau bias yang tumpang tindih.
Pendekatan ini memungkinkan peneliti untuk mengestimasi utilitas setiap
level atribut secara akurat dengan jumlah kombinasi produk yang jauh
lebih sedikit dibandingkan dengan semua kemungkinan kombinasi, karena
menggunakan prinsip desain eksperimental yang memastikan setiap level
atribut muncul dengan frekuensi yang seimbang dan berpasangan secara
proporsional dengan level atribut lainnya, sehingga menghasilkan data
yang optimal untuk analisis regresi dan pengukuran preferensi yang
valid.

Jika kita menggunakan semua kombinasi, ada
![3 \times 3 \times 3 \times 3 \times 4 = 324](https://latex.codecogs.com/svg.latex?3%20%5Ctimes%203%20%5Ctimes%203%20%5Ctimes%203%20%5Ctimes%204%20%3D%20324 "3 \times 3 \times 3 \times 3 \times 4 = 324")
buah pilihan produk yang ada. Namun dengan *orthogonal design*, kita
hanya mendapatkan **22 pilihan produk saja**.

|     | Rasa          | Ukuran | Klaim          | Kemasan       | Harga    |
|:----|:--------------|:-------|:---------------|:--------------|:---------|
| 17  | Sedikit_Manis | 1000ml | Tanpa_Pengawet | Botol_Plastik | Rp4000   |
| 27  | Tidak_Manis   | 1000ml | Reguler        | Botol_Plastik | Rp4000   |
| 30  | Tidak_Manis   | 250ml  | Alami_100pct   | Botol_Kaca    | Rp4000   |
| 46  | Manis         | 250ml  | Reguler        | Botol_Kaca    | Rp4000   |
| 58  | Manis         | 500ml  | Alami_100pct   | Kotak_Karton  | Rp4000   |
| 86  | Sedikit_Manis | 500ml  | Alami_100pct   | Botol_Plastik | Rp7000   |
| 103 | Manis         | 500ml  | Reguler        | Botol_Plastik | Rp7000   |
| 111 | Tidak_Manis   | 250ml  | Alami_100pct   | Botol_Kaca    | Rp7000   |
| 124 | Manis         | 1000ml | Tanpa_Pengawet | Botol_Kaca    | Rp7000   |
| 146 | Sedikit_Manis | 250ml  | Tanpa_Pengawet | Kotak_Karton  | Rp7000   |
| 162 | Tidak_Manis   | 1000ml | Reguler        | Kotak_Karton  | Rp7000   |
| 172 | Manis         | 250ml  | Tanpa_Pengawet | Botol_Plastik | Rp12000  |
| 183 | Tidak_Manis   | 250ml  | Reguler        | Botol_Plastik | Rp12000  |
| 197 | Sedikit_Manis | 1000ml | Alami_100pct   | Botol_Kaca    | Rp12000  |
| 212 | Sedikit_Manis | 500ml  | Reguler        | Botol_Kaca    | Rp12000  |
| 223 | Manis         | 1000ml | Alami_100pct   | Kotak_Karton  | Rp12000  |
| 231 | Tidak_Manis   | 500ml  | Tanpa_Pengawet | Kotak_Karton  | Rp12000  |
| 244 | Manis         | 250ml  | Alami_100pct   | Botol_Plastik | Rp18.000 |
| 252 | Tidak_Manis   | 1000ml | Alami_100pct   | Botol_Plastik | Rp18.000 |
| 285 | Tidak_Manis   | 500ml  | Tanpa_Pengawet | Botol_Kaca    | Rp18.000 |
| 295 | Manis         | 1000ml | Reguler        | Botol_Kaca    | Rp18.000 |
| 317 | Sedikit_Manis | 250ml  | Reguler        | Kotak_Karton  | Rp18.000 |

### Langkah 3: Tampilan Kartu Survei

Setiap pilihan produk akan saya sebut sebagai **profil** dan akan
disajikan kepada responden sebagai sebuah ‘kartu produk’. Contoh satu
kartu:

|         | 17             |
|:--------|:---------------|
| Rasa    | Sedikit_Manis  |
| Ukuran  | 1000ml         |
| Klaim   | Tanpa_Pengawet |
| Kemasan | Botol_Plastik  |
| Harga   | Rp4000         |

Kemudian responden akan disuruh untuk memberikan *rating* (misalkan
1-10) di masing-masing kartu *survey*.

### Langkah 4: Membuat Data Responden Simulasi

Selanjutnya saya akan mensimulasikan 150 responden.

|  | Rasa | Ukuran | Klaim | Kemasan | Harga | X1 | X2 | X3 | X4 | X5 | X6 | X7 | X8 | X9 | X10 | X11 | X12 | X13 | X14 | X15 | X16 | X17 | X18 | X19 | X20 | X21 | X22 | X23 | X24 | X25 | X26 | X27 | X28 | X29 | X30 | X31 | X32 | X33 | X34 | X35 | X36 | X37 | X38 | X39 | X40 | X41 | X42 | X43 | X44 | X45 | X46 | X47 | X48 | X49 | X50 | X51 | X52 | X53 | X54 | X55 | X56 | X57 | X58 | X59 | X60 | X61 | X62 | X63 | X64 | X65 | X66 | X67 | X68 | X69 | X70 | X71 | X72 | X73 | X74 | X75 | X76 | X77 | X78 | X79 | X80 | X81 | X82 | X83 | X84 | X85 | X86 | X87 | X88 | X89 | X90 | X91 | X92 | X93 | X94 | X95 | X96 | X97 | X98 | X99 | X100 | X101 | X102 | X103 | X104 | X105 | X106 | X107 | X108 | X109 | X110 | X111 | X112 | X113 | X114 | X115 | X116 | X117 | X118 | X119 | X120 | X121 | X122 | X123 | X124 | X125 | X126 | X127 | X128 | X129 | X130 | X131 | X132 | X133 | X134 | X135 | X136 | X137 | X138 | X139 | X140 | X141 | X142 | X143 | X144 | X145 | X146 | X147 | X148 | X149 | X150 |
|:---|:---|:---|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 17 | Sedikit_Manis | 1000ml | Tanpa_Pengawet | Botol_Plastik | Rp4000 | 7 | 5 | 10 | 1 | 6 | 10 | 10 | 7 | 7 | 1 | 6 | 7 | 6 | 6 | 2 | 7 | 8 | 1 | 6 | 9 | 9 | 10 | 8 | 9 | 2 | 6 | 4 | 1 | 9 | 10 | 10 | 10 | 6 | 5 | 3 | 4 | 4 | 3 | 3 | 10 | 5 | 6 | 2 | 4 | 5 | 6 | 7 | 9 | 8 | 5 | 7 | 10 | 9 | 2 | 10 | 8 | 9 | 10 | 4 | 5 | 7 | 8 | 1 | 5 | 10 | 4 | 10 | 1 | 3 | 4 | 10 | 4 | 8 | 4 | 7 | 3 | 6 | 7 | 9 | 1 | 10 | 1 | 6 | 7 | 8 | 2 | 1 | 4 | 10 | 4 | 5 | 7 | 8 | 4 | 5 | 10 | 1 | 4 | 1 | 1 | 3 | 9 | 6 | 5 | 6 | 9 | 7 | 7 | 10 | 4 | 5 | 4 | 9 | 7 | 3 | 8 | 7 | 7 | 10 | 8 | 1 | 10 | 10 | 7 | 9 | 3 | 10 | 10 | 4 | 10 | 5 | 10 | 1 | 6 | 8 | 10 | 5 | 5 | 10 | 2 | 6 | 5 | 6 | 2 | 6 | 8 | 3 | 6 | 7 | 2 |
| 27 | Tidak_Manis | 1000ml | Reguler | Botol_Plastik | Rp4000 | 2 | 2 | 5 | 1 | 2 | 5 | 3 | 1 | 1 | 1 | 2 | 1 | 3 | 1 | 2 | 4 | 10 | 2 | 1 | 3 | 7 | 1 | 1 | 1 | 1 | 1 | 1 | 3 | 3 | 1 | 1 | 6 | 10 | 4 | 5 | 1 | 5 | 6 | 9 | 2 | 6 | 3 | 1 | 5 | 5 | 1 | 1 | 1 | 3 | 2 | 1 | 1 | 6 | 4 | 3 | 1 | 1 | 3 | 1 | 5 | 1 | 1 | 1 | 5 | 2 | 1 | 1 | 1 | 2 | 5 | 10 | 1 | 2 | 10 | 1 | 1 | 4 | 1 | 1 | 7 | 7 | 1 | 10 | 1 | 1 | 4 | 1 | 10 | 2 | 9 | 5 | 1 | 1 | 7 | 1 | 4 | 3 | 1 | 2 | 2 | 4 | 1 | 6 | 2 | 2 | 4 | 3 | 6 | 8 | 5 | 3 | 5 | 1 | 3 | 8 | 7 | 5 | 1 | 1 | 1 | 2 | 4 | 4 | 9 | 5 | 2 | 1 | 6 | 2 | 8 | 1 | 4 | 1 | 1 | 4 | 5 | 10 | 1 | 3 | 4 | 4 | 1 | 4 | 4 | 1 | 3 | 6 | 1 | 5 | 10 |
| 30 | Tidak_Manis | 250ml | Alami_100pct | Botol_Kaca | Rp4000 | 10 | 7 | 9 | 10 | 10 | 9 | 9 | 10 | 10 | 5 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 7 | 9 | 10 | 7 | 10 | 10 | 10 | 8 | 10 | 9 | 10 | 9 | 8 | 8 | 10 | 10 | 10 | 9 | 10 | 5 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 8 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 6 | 10 | 9 | 10 | 10 | 10 | 8 | 10 | 10 | 7 | 10 | 5 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 8 | 10 | 10 | 6 | 10 | 10 | 10 | 10 | 10 | 2 | 5 | 10 | 10 | 10 | 8 | 10 | 10 | 10 | 8 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 8 | 10 | 10 | 8 | 10 | 7 | 10 | 10 | 6 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 8 | 10 | 10 | 6 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 7 | 10 | 10 | 10 |
| 46 | Manis | 250ml | Reguler | Botol_Kaca | Rp4000 | 7 | 3 | 4 | 8 | 8 | 9 | 7 | 2 | 3 | 4 | 8 | 3 | 3 | 6 | 7 | 7 | 8 | 2 | 8 | 2 | 7 | 10 | 7 | 1 | 10 | 8 | 5 | 9 | 1 | 7 | 3 | 10 | 5 | 9 | 6 | 1 | 9 | 3 | 8 | 8 | 2 | 10 | 3 | 9 | 2 | 4 | 4 | 3 | 9 | 5 | 8 | 4 | 5 | 1 | 10 | 10 | 9 | 5 | 7 | 8 | 8 | 10 | 6 | 7 | 10 | 1 | 1 | 5 | 8 | 4 | 10 | 5 | 5 | 3 | 6 | 9 | 6 | 3 | 7 | 8 | 7 | 4 | 4 | 7 | 6 | 1 | 8 | 10 | 6 | 8 | 3 | 5 | 7 | 8 | 7 | 3 | 8 | 9 | 8 | 6 | 8 | 8 | 10 | 4 | 10 | 6 | 1 | 7 | 8 | 7 | 9 | 6 | 2 | 6 | 10 | 10 | 7 | 9 | 7 | 10 | 1 | 2 | 9 | 8 | 8 | 10 | 4 | 5 | 6 | 1 | 5 | 3 | 9 | 6 | 6 | 7 | 4 | 2 | 6 | 8 | 6 | 10 | 3 | 10 | 10 | 4 | 8 | 9 | 6 | 10 |
| 58 | Manis | 500ml | Alami_100pct | Kotak_Karton | Rp4000 | 10 | 8 | 10 | 8 | 9 | 10 | 10 | 10 | 9 | 9 | 9 | 6 | 10 | 6 | 10 | 10 | 10 | 10 | 9 | 10 | 8 | 10 | 10 | 10 | 7 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 5 | 10 | 2 | 10 | 10 | 10 | 2 | 10 | 10 | 7 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 7 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 6 | 10 | 9 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 8 | 10 | 9 | 10 | 10 | 8 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 5 | 10 | 10 | 4 | 10 | 7 | 10 | 6 | 10 | 9 | 9 | 9 | 10 | 10 | 10 | 10 | 8 | 3 | 8 | 10 | 10 | 10 | 7 | 10 | 10 | 10 | 10 | 8 | 10 | 10 | 5 | 10 | 9 | 6 | 7 | 10 | 10 | 10 | 10 | 9 | 10 | 1 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 5 | 9 | 9 | 10 | 10 |
| 86 | Sedikit_Manis | 500ml | Alami_100pct | Botol_Plastik | Rp7000 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 7 | 10 | 10 | 7 | 10 | 10 | 8 | 10 | 8 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 2 | 10 | 9 | 7 | 10 | 10 | 10 | 10 | 4 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 10 | 10 | 8 | 8 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 9 | 10 | 6 | 10 | 10 | 10 | 10 | 6 | 10 | 10 | 10 | 10 | 10 | 10 | 7 | 10 | 9 | 10 | 10 | 10 | 10 | 7 | 10 | 10 | 4 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 6 | 10 | 10 | 4 | 10 | 10 | 10 | 10 | 7 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 10 | 9 |
| 103 | Manis | 500ml | Reguler | Botol_Plastik | Rp7000 | 4 | 9 | 4 | 6 | 10 | 8 | 3 | 5 | 7 | 6 | 3 | 3 | 2 | 4 | 1 | 10 | 8 | 7 | 8 | 6 | 10 | 10 | 6 | 5 | 10 | 7 | 1 | 6 | 1 | 1 | 1 | 2 | 5 | 5 | 8 | 10 | 6 | 10 | 10 | 7 | 1 | 9 | 6 | 7 | 4 | 2 | 10 | 8 | 10 | 1 | 6 | 4 | 1 | 6 | 7 | 9 | 10 | 7 | 6 | 2 | 2 | 8 | 5 | 2 | 2 | 6 | 5 | 4 | 4 | 10 | 7 | 2 | 9 | 4 | 10 | 10 | 4 | 8 | 1 | 6 | 4 | 9 | 10 | 7 | 9 | 6 | 9 | 6 | 3 | 4 | 10 | 5 | 9 | 10 | 4 | 10 | 7 | 9 | 9 | 2 | 3 | 6 | 2 | 10 | 5 | 5 | 1 | 1 | 10 | 1 | 10 | 7 | 5 | 9 | 2 | 3 | 2 | 1 | 4 | 6 | 1 | 5 | 10 | 6 | 5 | 10 | 3 | 10 | 7 | 4 | 6 | 5 | 6 | 7 | 2 | 1 | 6 | 4 | 4 | 7 | 7 | 3 | 4 | 7 | 1 | 7 | 7 | 10 | 7 | 7 |
| 111 | Tidak_Manis | 250ml | Alami_100pct | Botol_Kaca | Rp7000 | 10 | 10 | 10 | 10 | 10 | 10 | 6 | 9 | 10 | 9 | 8 | 6 | 8 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 10 | 10 | 7 | 10 | 10 | 10 | 3 | 9 | 9 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 5 | 10 | 10 | 2 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 6 | 8 | 10 | 6 | 8 | 7 | 10 | 10 | 8 | 7 | 8 | 10 | 10 | 10 | 10 | 6 | 10 | 9 | 10 | 10 | 9 | 10 | 8 | 10 | 4 | 4 | 8 | 10 | 6 | 10 | 10 | 7 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 3 | 10 | 10 | 10 | 8 | 10 | 9 | 9 | 10 | 10 | 3 | 7 | 10 | 8 | 8 | 10 | 10 | 10 | 8 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 7 | 10 | 4 | 4 | 10 | 10 | 10 | 10 | 10 | 9 | 8 | 10 | 7 | 8 | 6 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 6 |
| 124 | Manis | 1000ml | Tanpa_Pengawet | Botol_Kaca | Rp7000 | 2 | 1 | 4 | 1 | 7 | 2 | 1 | 1 | 1 | 6 | 1 | 1 | 10 | 1 | 1 | 3 | 1 | 6 | 10 | 1 | 6 | 1 | 10 | 1 | 5 | 1 | 4 | 5 | 3 | 10 | 10 | 2 | 4 | 5 | 10 | 1 | 1 | 1 | 1 | 9 | 4 | 1 | 4 | 4 | 10 | 7 | 5 | 1 | 3 | 3 | 1 | 1 | 5 | 1 | 1 | 7 | 5 | 3 | 3 | 4 | 1 | 2 | 2 | 8 | 5 | 2 | 4 | 8 | 1 | 2 | 5 | 3 | 10 | 8 | 3 | 6 | 1 | 4 | 1 | 7 | 3 | 1 | 6 | 1 | 10 | 3 | 1 | 3 | 2 | 3 | 9 | 7 | 4 | 1 | 5 | 6 | 6 | 5 | 10 | 1 | 1 | 7 | 5 | 7 | 8 | 1 | 8 | 1 | 5 | 1 | 4 | 5 | 4 | 6 | 5 | 1 | 1 | 4 | 1 | 6 | 6 | 8 | 1 | 4 | 3 | 1 | 1 | 7 | 1 | 3 | 9 | 7 | 10 | 1 | 1 | 4 | 1 | 4 | 7 | 4 | 9 | 1 | 2 | 8 | 4 | 3 | 2 | 1 | 1 | 1 |
| 146 | Sedikit_Manis | 250ml | Tanpa_Pengawet | Kotak_Karton | Rp7000 | 4 | 10 | 5 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 5 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 6 | 8 | 10 | 6 | 10 | 10 | 10 | 10 | 10 | 7 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 5 | 10 | 10 | 10 | 10 | 10 | 9 | 6 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 5 | 7 | 4 | 10 | 10 | 10 | 6 | 5 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 8 | 10 | 10 | 8 | 10 | 10 | 10 | 10 | 10 | 6 | 10 | 8 | 10 | 10 | 10 | 10 | 8 | 10 | 10 | 9 | 8 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 10 | 10 |
| 162 | Tidak_Manis | 1000ml | Reguler | Kotak_Karton | Rp7000 | 5 | 6 | 8 | 4 | 8 | 3 | 1 | 2 | 4 | 2 | 1 | 4 | 2 | 1 | 1 | 2 | 4 | 1 | 4 | 2 | 3 | 6 | 1 | 5 | 1 | 1 | 1 | 1 | 1 | 8 | 1 | 7 | 5 | 8 | 1 | 5 | 1 | 4 | 1 | 2 | 1 | 5 | 10 | 2 | 1 | 5 | 5 | 2 | 5 | 3 | 1 | 5 | 5 | 3 | 9 | 1 | 5 | 3 | 5 | 1 | 4 | 1 | 2 | 1 | 7 | 4 | 1 | 1 | 1 | 8 | 9 | 6 | 7 | 1 | 1 | 6 | 2 | 1 | 4 | 7 | 7 | 1 | 4 | 8 | 1 | 1 | 1 | 4 | 5 | 1 | 1 | 8 | 2 | 5 | 6 | 2 | 1 | 2 | 2 | 2 | 1 | 2 | 5 | 5 | 6 | 4 | 4 | 2 | 1 | 1 | 3 | 9 | 6 | 1 | 1 | 1 | 1 | 2 | 9 | 1 | 1 | 4 | 7 | 1 | 4 | 1 | 5 | 1 | 6 | 3 | 4 | 1 | 1 | 1 | 7 | 5 | 1 | 3 | 7 | 3 | 1 | 5 | 10 | 3 | 9 | 1 | 1 | 5 | 5 | 1 |
| 172 | Manis | 250ml | Tanpa_Pengawet | Botol_Plastik | Rp12000 | 1 | 2 | 2 | 1 | 2 | 1 | 5 | 1 | 7 | 1 | 5 | 2 | 1 | 2 | 3 | 5 | 1 | 5 | 3 | 1 | 6 | 1 | 6 | 10 | 3 | 6 | 4 | 5 | 1 | 1 | 1 | 5 | 8 | 5 | 1 | 4 | 3 | 1 | 1 | 9 | 1 | 1 | 1 | 1 | 8 | 7 | 5 | 2 | 8 | 3 | 1 | 1 | 1 | 4 | 7 | 1 | 5 | 1 | 1 | 1 | 3 | 4 | 3 | 3 | 3 | 10 | 3 | 5 | 2 | 7 | 6 | 1 | 7 | 7 | 8 | 1 | 1 | 1 | 1 | 2 | 7 | 1 | 7 | 2 | 5 | 3 | 9 | 1 | 6 | 4 | 4 | 8 | 1 | 6 | 7 | 1 | 1 | 1 | 3 | 5 | 10 | 8 | 1 | 2 | 5 | 2 | 4 | 8 | 7 | 5 | 1 | 7 | 1 | 3 | 2 | 1 | 10 | 1 | 1 | 1 | 3 | 5 | 4 | 5 | 1 | 6 | 1 | 6 | 10 | 8 | 5 | 8 | 5 | 1 | 6 | 6 | 4 | 3 | 1 | 8 | 2 | 1 | 1 | 2 | 1 | 5 | 6 | 5 | 3 | 5 |
| 183 | Tidak_Manis | 250ml | Reguler | Botol_Plastik | Rp12000 | 1 | 3 | 7 | 10 | 1 | 1 | 1 | 4 | 1 | 1 | 1 | 3 | 4 | 1 | 6 | 3 | 1 | 1 | 6 | 4 | 3 | 7 | 4 | 1 | 1 | 1 | 10 | 1 | 4 | 1 | 9 | 6 | 3 | 3 | 1 | 3 | 1 | 1 | 5 | 1 | 5 | 5 | 1 | 1 | 5 | 6 | 8 | 3 | 1 | 1 | 3 | 1 | 1 | 4 | 6 | 6 | 6 | 6 | 10 | 10 | 6 | 1 | 2 | 6 | 6 | 10 | 1 | 3 | 1 | 8 | 2 | 3 | 4 | 8 | 6 | 6 | 2 | 2 | 5 | 1 | 1 | 5 | 1 | 5 | 1 | 1 | 1 | 1 | 2 | 2 | 9 | 2 | 5 | 1 | 5 | 4 | 4 | 5 | 5 | 1 | 6 | 10 | 3 | 3 | 7 | 5 | 3 | 2 | 1 | 7 | 1 | 1 | 1 | 1 | 3 | 2 | 4 | 4 | 9 | 9 | 1 | 5 | 5 | 1 | 1 | 7 | 5 | 4 | 1 | 4 | 2 | 1 | 1 | 1 | 3 | 1 | 5 | 1 | 7 | 1 | 2 | 6 | 2 | 1 | 4 | 1 | 2 | 1 | 2 | 9 |
| 197 | Sedikit_Manis | 1000ml | Alami_100pct | Botol_Kaca | Rp12000 | 5 | 10 | 4 | 5 | 3 | 2 | 8 | 7 | 5 | 10 | 1 | 7 | 4 | 10 | 1 | 1 | 8 | 1 | 5 | 4 | 7 | 7 | 4 | 8 | 5 | 1 | 1 | 8 | 6 | 9 | 1 | 6 | 2 | 9 | 2 | 6 | 3 | 3 | 9 | 8 | 9 | 7 | 3 | 5 | 4 | 6 | 4 | 2 | 10 | 6 | 1 | 5 | 5 | 10 | 6 | 3 | 9 | 8 | 7 | 6 | 8 | 3 | 7 | 4 | 5 | 2 | 8 | 9 | 1 | 2 | 3 | 6 | 6 | 1 | 10 | 6 | 3 | 3 | 1 | 10 | 10 | 1 | 1 | 10 | 5 | 1 | 3 | 1 | 1 | 4 | 5 | 4 | 8 | 5 | 1 | 2 | 2 | 4 | 1 | 6 | 8 | 7 | 1 | 7 | 3 | 6 | 1 | 9 | 5 | 1 | 7 | 4 | 3 | 3 | 6 | 1 | 4 | 10 | 1 | 4 | 3 | 5 | 4 | 2 | 3 | 9 | 4 | 6 | 6 | 2 | 8 | 6 | 3 | 1 | 7 | 5 | 5 | 2 | 6 | 1 | 2 | 5 | 5 | 5 | 2 | 1 | 3 | 1 | 4 | 8 |
| 212 | Sedikit_Manis | 500ml | Reguler | Botol_Kaca | Rp12000 | 9 | 9 | 3 | 8 | 10 | 5 | 7 | 10 | 5 | 5 | 4 | 7 | 6 | 3 | 7 | 10 | 5 | 10 | 9 | 10 | 6 | 10 | 6 | 5 | 10 | 5 | 5 | 3 | 4 | 7 | 8 | 3 | 4 | 8 | 7 | 4 | 10 | 6 | 6 | 5 | 3 | 9 | 10 | 6 | 8 | 5 | 9 | 10 | 4 | 8 | 10 | 10 | 9 | 5 | 4 | 10 | 1 | 10 | 10 | 8 | 10 | 2 | 10 | 7 | 6 | 7 | 5 | 6 | 4 | 7 | 7 | 2 | 10 | 7 | 1 | 4 | 5 | 1 | 1 | 10 | 1 | 2 | 10 | 8 | 9 | 7 | 4 | 3 | 6 | 5 | 8 | 1 | 4 | 10 | 5 | 7 | 5 | 5 | 3 | 9 | 7 | 8 | 4 | 7 | 7 | 6 | 4 | 1 | 5 | 5 | 3 | 5 | 5 | 9 | 9 | 7 | 8 | 7 | 2 | 1 | 1 | 10 | 8 | 3 | 2 | 8 | 5 | 8 | 3 | 10 | 6 | 1 | 9 | 5 | 6 | 10 | 5 | 8 | 10 | 1 | 6 | 5 | 6 | 7 | 3 | 9 | 3 | 10 | 7 | 7 |
| 223 | Manis | 1000ml | Alami_100pct | Kotak_Karton | Rp12000 | 4 | 1 | 3 | 1 | 2 | 1 | 4 | 1 | 3 | 5 | 1 | 4 | 1 | 1 | 1 | 2 | 1 | 1 | 2 | 1 | 6 | 4 | 1 | 1 | 8 | 1 | 1 | 1 | 1 | 3 | 2 | 3 | 3 | 1 | 1 | 1 | 1 | 6 | 1 | 1 | 1 | 8 | 1 | 1 | 1 | 1 | 2 | 2 | 1 | 9 | 1 | 1 | 3 | 1 | 1 | 1 | 1 | 7 | 1 | 2 | 1 | 3 | 1 | 2 | 1 | 1 | 1 | 1 | 5 | 4 | 8 | 1 | 1 | 7 | 1 | 5 | 5 | 9 | 1 | 1 | 3 | 5 | 2 | 4 | 4 | 4 | 1 | 1 | 5 | 6 | 3 | 9 | 1 | 1 | 1 | 2 | 6 | 5 | 8 | 2 | 4 | 4 | 1 | 2 | 2 | 1 | 1 | 1 | 5 | 1 | 2 | 1 | 3 | 5 | 1 | 2 | 4 | 5 | 1 | 1 | 1 | 2 | 1 | 1 | 5 | 1 | 1 | 5 | 1 | 1 | 1 | 4 | 4 | 1 | 1 | 3 | 1 | 6 | 1 | 1 | 1 | 1 | 3 | 1 | 10 | 4 | 2 | 1 | 1 | 1 |
| 231 | Tidak_Manis | 500ml | Tanpa_Pengawet | Kotak_Karton | Rp12000 | 3 | 4 | 4 | 8 | 8 | 8 | 9 | 4 | 10 | 3 | 10 | 4 | 5 | 1 | 7 | 7 | 7 | 1 | 9 | 10 | 10 | 2 | 2 | 9 | 10 | 7 | 10 | 5 | 8 | 9 | 6 | 5 | 5 | 8 | 6 | 8 | 7 | 4 | 9 | 9 | 9 | 6 | 6 | 1 | 8 | 4 | 8 | 7 | 8 | 6 | 5 | 6 | 8 | 9 | 10 | 2 | 4 | 4 | 10 | 10 | 6 | 8 | 5 | 10 | 10 | 10 | 7 | 9 | 7 | 10 | 6 | 10 | 8 | 3 | 10 | 7 | 5 | 8 | 10 | 6 | 1 | 8 | 10 | 1 | 10 | 9 | 6 | 10 | 4 | 3 | 5 | 10 | 5 | 10 | 6 | 10 | 3 | 10 | 10 | 7 | 7 | 8 | 9 | 10 | 10 | 7 | 1 | 8 | 8 | 5 | 5 | 7 | 4 | 5 | 7 | 10 | 5 | 10 | 6 | 7 | 7 | 8 | 8 | 10 | 10 | 1 | 10 | 10 | 8 | 8 | 5 | 10 | 1 | 10 | 6 | 7 | 7 | 10 | 10 | 10 | 10 | 9 | 8 | 9 | 10 | 10 | 5 | 6 | 3 | 6 |
| 244 | Manis | 250ml | Alami_100pct | Botol_Plastik | Rp18.000 | 5 | 5 | 1 | 1 | 1 | 1 | 4 | 5 | 5 | 5 | 4 | 3 | 9 | 9 | 1 | 1 | 3 | 1 | 4 | 6 | 5 | 7 | 8 | 7 | 1 | 1 | 4 | 6 | 7 | 8 | 3 | 2 | 4 | 10 | 5 | 8 | 9 | 8 | 10 | 8 | 1 | 2 | 10 | 9 | 7 | 5 | 6 | 2 | 1 | 10 | 1 | 7 | 10 | 8 | 3 | 7 | 7 | 4 | 4 | 1 | 1 | 4 | 10 | 5 | 4 | 7 | 1 | 9 | 1 | 5 | 5 | 4 | 10 | 8 | 9 | 7 | 10 | 7 | 5 | 1 | 6 | 7 | 2 | 8 | 10 | 8 | 10 | 1 | 7 | 1 | 10 | 8 | 1 | 3 | 5 | 2 | 4 | 2 | 8 | 8 | 4 | 9 | 7 | 7 | 7 | 6 | 6 | 1 | 10 | 1 | 9 | 10 | 5 | 1 | 8 | 4 | 8 | 6 | 6 | 2 | 1 | 7 | 1 | 5 | 10 | 1 | 3 | 10 | 6 | 6 | 7 | 1 | 6 | 4 | 7 | 1 | 5 | 5 | 1 | 1 | 6 | 3 | 7 | 8 | 9 | 2 | 1 | 10 | 9 | 8 |
| 252 | Tidak_Manis | 1000ml | Alami_100pct | Botol_Plastik | Rp18.000 | 6 | 10 | 1 | 1 | 4 | 5 | 1 | 4 | 2 | 4 | 3 | 2 | 4 | 8 | 1 | 2 | 3 | 2 | 3 | 2 | 5 | 1 | 2 | 2 | 10 | 9 | 3 | 3 | 7 | 6 | 6 | 7 | 1 | 1 | 1 | 2 | 3 | 3 | 1 | 1 | 4 | 8 | 1 | 7 | 6 | 2 | 1 | 6 | 4 | 9 | 5 | 6 | 4 | 5 | 1 | 1 | 4 | 1 | 8 | 1 | 1 | 1 | 4 | 6 | 1 | 2 | 10 | 1 | 5 | 1 | 3 | 8 | 7 | 10 | 1 | 1 | 5 | 9 | 1 | 6 | 2 | 1 | 3 | 1 | 1 | 4 | 1 | 3 | 10 | 2 | 1 | 3 | 1 | 1 | 1 | 4 | 2 | 5 | 10 | 7 | 1 | 1 | 10 | 5 | 1 | 1 | 3 | 5 | 5 | 1 | 4 | 2 | 9 | 1 | 1 | 6 | 5 | 1 | 4 | 1 | 1 | 1 | 1 | 4 | 1 | 3 | 2 | 6 | 1 | 5 | 9 | 1 | 4 | 1 | 1 | 3 | 3 | 1 | 4 | 4 | 10 | 8 | 1 | 8 | 1 | 7 | 3 | 1 | 5 | 4 |
| 285 | Tidak_Manis | 500ml | Tanpa_Pengawet | Botol_Kaca | Rp18.000 | 6 | 5 | 5 | 7 | 10 | 5 | 10 | 7 | 10 | 6 | 4 | 10 | 4 | 9 | 3 | 10 | 9 | 9 | 7 | 4 | 4 | 10 | 10 | 10 | 6 | 1 | 8 | 10 | 5 | 6 | 10 | 4 | 3 | 10 | 10 | 6 | 4 | 5 | 10 | 10 | 5 | 1 | 3 | 3 | 10 | 10 | 10 | 8 | 9 | 4 | 10 | 6 | 10 | 4 | 3 | 3 | 10 | 9 | 10 | 10 | 3 | 4 | 9 | 10 | 7 | 10 | 1 | 7 | 10 | 5 | 7 | 6 | 4 | 4 | 5 | 3 | 10 | 9 | 8 | 10 | 10 | 8 | 8 | 5 | 10 | 8 | 10 | 9 | 10 | 5 | 7 | 10 | 7 | 9 | 10 | 3 | 8 | 4 | 7 | 2 | 6 | 5 | 7 | 7 | 5 | 10 | 10 | 4 | 4 | 10 | 10 | 10 | 10 | 10 | 9 | 10 | 10 | 5 | 10 | 9 | 10 | 8 | 10 | 4 | 7 | 10 | 10 | 10 | 10 | 3 | 10 | 5 | 2 | 5 | 10 | 8 | 10 | 4 | 10 | 2 | 8 | 10 | 7 | 6 | 1 | 7 | 10 | 6 | 4 | 10 |
| 295 | Manis | 1000ml | Reguler | Botol_Kaca | Rp18.000 | 1 | 1 | 1 | 2 | 1 | 1 | 1 | 2 | 1 | 1 | 3 | 1 | 4 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 8 | 1 | 1 | 1 | 2 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 7 | 1 | 1 | 1 | 1 | 2 | 1 | 1 | 1 | 1 | 6 | 2 | 4 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 2 | 1 | 1 | 1 | 5 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 2 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 8 | 4 | 1 | 1 | 6 | 1 | 2 | 1 | 4 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 5 | 1 | 1 | 9 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 3 | 1 | 1 | 1 | 1 | 4 | 4 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 5 | 3 | 1 | 1 | 1 | 1 | 1 | 2 | 1 | 1 | 1 | 1 | 1 | 1 |
| 317 | Sedikit_Manis | 250ml | Reguler | Kotak_Karton | Rp18.000 | 1 | 10 | 6 | 10 | 10 | 8 | 4 | 7 | 6 | 7 | 10 | 10 | 10 | 7 | 8 | 4 | 4 | 4 | 1 | 1 | 4 | 10 | 10 | 3 | 2 | 8 | 9 | 4 | 4 | 9 | 7 | 8 | 3 | 4 | 1 | 7 | 8 | 6 | 7 | 7 | 5 | 10 | 8 | 1 | 4 | 2 | 8 | 7 | 8 | 5 | 8 | 10 | 6 | 10 | 6 | 4 | 5 | 9 | 8 | 1 | 6 | 10 | 6 | 6 | 7 | 1 | 10 | 10 | 10 | 10 | 7 | 7 | 7 | 8 | 3 | 9 | 5 | 10 | 4 | 2 | 2 | 1 | 10 | 9 | 6 | 8 | 10 | 10 | 7 | 5 | 5 | 9 | 9 | 10 | 8 | 3 | 6 | 1 | 1 | 10 | 1 | 4 | 10 | 9 | 10 | 6 | 10 | 7 | 1 | 6 | 10 | 5 | 5 | 10 | 9 | 2 | 8 | 8 | 8 | 9 | 3 | 8 | 10 | 2 | 10 | 10 | 10 | 3 | 7 | 6 | 5 | 9 | 2 | 6 | 10 | 1 | 5 | 10 | 6 | 10 | 5 | 8 | 2 | 10 | 6 | 9 | 3 | 1 | 3 | 10 |

Berikut adalah hasil analisanya.

## Visualisasi Hasil *Conjoint Analysis*

### Utilitas per Atribut

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market%20riset/post_20/draft_files/figure-commonmark/unnamed-chunk-4-1.png)

Atribut **Harga** merupakan faktor paling penting bagi konsumen dengan
nilai utilisasi **27.53%**. Ini menunjukkan bahwa konsumen sangat
sensitif terhadap harga produk teh.

Urutan kepentingan atribut dari yang paling penting:

1.  **Harga** (27.53%) - **Paling Penting**
    - **Harga** mendominasi dengan selisih cukup signifikan (8.17% lebih
      tinggi dari Rasa).
2.  **Rasa** (19.36%)
3.  **Ukuran** (19.27%)
4.  **Kemasan** (18.10%)
    - **Rasa, Ukuran, dan Kemasan** memiliki tingkat kepentingan yang
      relatif seimbang (berkisar 18-19%).
5.  **Klaim** (15.75%) - **Paling Tidak Penting**
    - **Klaim** memiliki kepentingan terendah, menunjukkan konsumen
      mungkin kurang memperhatikan klaim kesehatan atau *marketing
      claims* yang lain.
    - Perusahaan bisa mengoptimalkan klaim sebagai diferensiasi
      sekunder.

### Utilitas per Level untuk Masing-masing Atribut

Berikut adalah visualisasi utilitas per level untuk masing-masing
atribut:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market%20riset/post_20/draft_files/figure-commonmark/unnamed-chunk-5-1.png)

Dari skor utilitas masing-masing level, berikut adalah beberapa
temuannya:

**HARGA (Faktor Terpenting):**

- Konsumen **sangat menghindari** harga termurah (Rp4,000) dengan skor
  negatif terbesar (-0.0882).
- Harga **Rp12,000** menjadi **pilihan terbaik** dengan skor utilitas
  tertinggi (+0.1055).
- Harga Rp7,000 juga diterima dengan baik (+0.0389).
- Harga premium Rp18,000 kurang disukai (-0.0562).

**UKURAN:**

- Ukuran **1000ml** paling disukai (+0.0832).
- Ukuran 250ml netral (-0.0035).
- Ukuran 500ml kurang disukai (-0.0796).

**RASA:**

- Rasa **Manis** paling disukai (+0.0639).
- Rasa Sedikit Manis kurang disukai (-0.0519).
- Rasa Tidak Manis netral (-0.0120).

**KLAIM:**

- Klaim **“Alami 100%”** paling menarik (+0.0357).
- Klaim “Reguler” netral (+0.0173).
- Klaim “Tanpa Pengawet” kurang menarik (-0.0530).

**KEMASAN:**

- Semua jenis kemasan memiliki pengaruh minimal.
- Botol Plastik sedikit lebih disukai (+0.0025).

Berikut ini adalah rekomendasi strategis untuk brand minuman teh dalam
kemasan yang bisa dilakukan dari hasil *conjoint analysis* di atas:

**A. STRATEGI HARGA sebagai priorita utama:**

1.  **Target harga optimal: Rp12,000** - Posisikanproduk di segmen
    menengah-atas.
2.  **Hindari harga terlalu murah (Rp4,000)** - Konsumen mengasosiasikan
    dengan kualitas rendah.
3.  **Pertimbangkan Rp7,000** sebagai alternatif *entry-level*.
4.  **Tunda harga premium (Rp18,000)** kecuali dengan *value
    proposition* yang kuat

**B. STRATEGI PRODUK:**

1.  **Fokus pada ukuran 1000ml** sebagai produk utama.
2.  **Pertahankan rasa manis** sebagai varian *flagship*.
3.  **Gunakan klaim “Alami 100%”** sebagai *positioning* utama.
4.  **Kurangi penekanan pada “Tanpa Pengawet”** - kurang menarik bagi
    konsumen.

**C. STRATEGI PORTOFOLIO PRODUK:**

1.  **Produk Utama**: Teh manis 1000ml dengan klaim alami 100%, harga
    Rp12,000.
2.  **Produk Sekunder**: Teh manis 250ml, harga Rp7,000 (untuk
    *trial/single serve*).
3.  **Hindari**: Ukuran 500ml dan harga Rp4,000.

**D. STRATEGI PEMASARAN & KOMUNIKASI:**

1.  **Highlight naturalness**: “100% Alami” sebagai *value proposition*
    utama.
2.  **Value for money**: Tekankan rasio harga-volume untuk ukuran
    1000ml.
3.  **Taste leadership**: Posisikan sebagai teh dengan rasa manis yang
    pas.
4.  **Segmentasi**: Targetkan konsumen yang mencari kualitas dengan
    harga wajar.

**E. STRATEGI DISTRIBUSI & PENEMPATAN:**

1.  **Fokus pada modern trade** untuk harga Rp12,000.
2.  **Traditional trade** untuk varian Rp7,000.
3.  **On-premise** (restoran/kafe) untuk varian premium jika
    dikembangkan.

**F. ROADMAP PENGEMBANGAN PRODUK:**

**Fase 1 (0-6 bulan):**

- *Launch* produk utama: Teh Manis 1000ml, Alami 100%, Rp12,000.
- *Packaging*: Botol plastik (paling ekonomis).

**Fase 2 (6-12 bulan):**

- Introduksi varian 250ml untuk *single serve*.
- Eksplorasi kemasan alternatif jika ada permintaan.

**Fase 3 (12+ bulan):**

- Evaluasi penerimaan varian premium.
- Pengembangan line extension jika diperlukan.

**Kesimpulan Utama:** Konsumen minuman teh dalam kemasan mencari
**keseimbangan antara kualitas dan harga**. Mereka bersedia membayar
lebih untuk produk yang dirasakan berkualitas (natural, ukuran besar)
tetapi menghindari harga terlalu murah (dianggap rendah kualitas) maupun
terlalu mahal (dianggap tidak worth it). **Posisi optimal adalah di
segmen menengah-atas dengan *value proposition* “alami dan bernilai”.**

# Keterbatasan yang Perlu Diperhatikan

Walaupun memiliki temuan yang lebih banyak dibandingkan pertanyaan
langsung pada survey, tapi kita tetap perlu melihat beberapa limitasi
dari *conjoint analysis* sebagai berikut:

1.  *Hypothetical bias*, responden mungkin berperilaku berbeda dalam
    survei vs di toko nyata.
2.  Atribut yang tidak dimasukkan. *Conjoint* hanya mengukur atribut
    yang sudah kita tentukan. Faktor seperti *brand awareness*,
    rekomendasi teman, atau tampilan toko tidak tertangkap.
3.  Interaksi antar atribut. Model dasar *conjoint* mengasumsikan efek
    atribut independen. Padahal, kombinasi antara ‘Botol Kaca + Alami
    100%’ mungkin memberikan efek sinergistis lebih besar dari keduanya.
4.  Heterogenitas preferensi. Rata-rata *part-worth* menyembunyikan
    variasi antar segmen. Sebaiknya lakukan analisis per segmen (misal:
    usia, kota, frekuensi konsumsi). Lihat tulisan saya sebelumnya
    tentang [*Simpson
    Paradox*](https://ikanx101.com/blog/simpson-paradox/).
5.  *Sample size*. Untuk traditional *conjoint* dibutuhkan minimal 50
    orang responden.

# Epilog

Pertanyaan survei yang langsung *‘Seberapa penting harga bagi Anda?’*
hampir selalu menghasilkan jawaban yang tidak berguna. Semua penting,
semua dapat skor 5. Sementara itu *conjoint analysis* memecahkan masalah
ini dengan cara yang elegan yakni dengan memaksa konsumen untuk membuat
*trade-off*, lalu hitung sendiri berapa nilai implisit setiap atribut
dari pola pilihan mereka. Hasilnya jauh lebih *actionable*: bukan
‘konsumen menyukai rasa enak dan harga murah’, tapi ‘konsumen bersedia
membayar Rp3.500 lebih mahal jika kemasannya botol kaca, dan klaim Alami
100% berkontribusi 35% dari keputusan beli mereka’.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
