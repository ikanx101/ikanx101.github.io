---
date: 2025-05-13T11:08:00-04:00
title: "Membuat Algoritma Cluster Sampling di R"
categories:
  - Blog
tags:
  - Market Riset
  - Marketing
  - Statistik
  - Sampling
  - Analisa
  - Cluster Sampling
  - R
---

Melanjutkan tulisan saya sebelumnya terkait [teknik
*sampling*](https://ikanx101.com/blog/sist-samp/) di market riset, kali
ini saya akan membahas tentang teknik *sampling* bernama *cluster
sampling*. Berdasarkan pengalaman saya sampai saat ini di industri
market riset, saya sebenarnya sangat jarang sekali menggunakan teknik
*sampling* ini.

------------------------------------------------------------------------

Misalkan kita ingin meneliti pendapat siswa SMA di seluruh Jakarta
tentang kurikulum baru. Akan sangat sulit dan mahal jika kita harus
mendatangi setiap sekolah dan memilih siswa secara acak satu per satu.

*Nah*, *cluster sampling* hadir sebagai solusi yang lebih praktis.
Caranya adalah dengan membagi populasi besar (seluruh siswa SMA di
Jakarta) menjadi kelompok-kelompok kecil yang disebut *cluster*.
*Cluster* ini biasanya sudah terbentuk secara alami, misalnya
berdasarkan sekolah.

**Langkah-langkahnya begini:**

1.  **Bagi Populasi menjadi *Cluster*:** Pertama, kamu bagi seluruh
    populasi penelitianmu menjadi beberapa *cluster* yang berbeda. Dalam
    contoh kita, setiap SMA di Jakarta adalah satu *cluster*. Sehingga
    kita dapatkan banyaknya *cluster* adalah sebanyak SMA yang ada di
    Jakarta.

2.  **Pilih Beberapa *Cluster* Secara Acak:** Kemudian, kamu tidak
    memilih siswa secara acak dari *semua* sekolah, tapi kamu memilih
    *beberapa* sekolah (*cluster*) secara acak. Misalnya, dari ratusan
    SMA di Jakarta, kamu memilih 10 *cluster* (sekolah) secara acak.

3.  **Ambil Sampel dari Klaster yang Terpilih:** Setelah *cluster*
    (sekolah) terpilih, kamu bisa melakukan salah satu dari dua hal:

    - **Mengambil sampel acak dari setiap *cluster* terpilih:** Di
      setiap 10 sekolah yang terpilih tadi, kamu bisa memilih beberapa
      siswa secara acak untuk menjadi sampelmu. **ATAU**
    - **Mengambil semua anggota dari klaster terpilih:** Kamu bisa
      menjadikan **semua** siswa di 10 sekolah yang terpilih sebagai
      sampel penelitianmu. Cara ini lebih sederhana tapi mungkin kurang
      efisien jika ukuran *cluster*-nya sangat besar.

**Sederhananya, kamu memilih beberapa kelompok secara acak, lalu
mengambil sampel dari kelompok-kelompok yang terpilih tersebut.**

**Kelebihan *Cluster Sampling*:**

- **Lebih efisien dan murah** terutama untuk populasi yang tersebar
  geografis. Kamu tidak perlu menjangkau setiap individu, tapi cukup
  beberapa kelompok saja.
- **Lebih praktis** ketika sulit untuk mendapatkan daftar lengkap
  seluruh anggota populasi, tapi daftar kelompoknya tersedia.

**Kekurangan *Cluster Sampling*:**

- **Potensi *sampling error* lebih besar** dibandingkan *simple random
  sampling* jika antar *cluster* memiliki perbedaan yang signifikan.
  Jika sekolah-sekolah yang kamu pilih secara kebetulan memiliki
  karakteristik siswa yang sangat berbeda dari rata-rata, maka hasil
  penelitianmu bisa *bias*.

## Algoritma *Cluster Sampling* di **R**

Berdasarkan penjelasan di atas, kita bisa membuat algoritma sederhananya
dengan `library(dplyr)` di **R** sebagai berikut:

``` r
# panggil library(dplyr)
library(dplyr)

# total semua murid di jakarta
N_murid = 10^4

# total semua sekolah di jakarta
N_skul  = 80

# berapa banyak cluster yang akan dipilih
selected_skul = 5

# pemilihan cluster
selected_cluster = sample(1:N_skul,selected_skul) %>% sort()
selected_cluster
```

    [1] 14 44 52 67 78

Terlihat di atas adalah lima *clusters* (sekolah-sekolah) yang terpilih.
Kita bisa lihat sampel data siswa yang terpilih sebagai berikut:

``` r
# kita buat data frame nya
id_murid = 1:N_murid
id_skul  = sample(1:N_skul,N_murid,replace = T)


df_sel = data.frame(id_murid,id_skul,
           nama_skul = paste0("Sekolah ",id_skul)) %>% 
  filter(id_skul %in% selected_cluster)

head(df_sel,20)
```

       id_murid id_skul  nama_skul
    1         2      52 Sekolah 52
    2        26      67 Sekolah 67
    3        37      52 Sekolah 52
    4        59      67 Sekolah 67
    5        87      67 Sekolah 67
    6       121      44 Sekolah 44
    7       125      52 Sekolah 52
    8       128      44 Sekolah 44
    9       145      52 Sekolah 52
    10      152      67 Sekolah 67
    11      157      52 Sekolah 52
    12      197      78 Sekolah 78
    13      217      67 Sekolah 67
    14      231      52 Sekolah 52
    15      232      14 Sekolah 14
    16      246      67 Sekolah 67
    17      247      14 Sekolah 14
    18      261      14 Sekolah 14
    19      263      78 Sekolah 78
    20      287      44 Sekolah 44

Berikut adalah *summary*-nya:

``` r
df_sel %>% 
  group_by(nama_skul) %>% 
  tally() %>% 
  ungroup() %>% 
  arrange(nama_skul) %>% 
  rename("n siswa" = n)
```

    # A tibble: 5 × 2
      nama_skul  `n siswa`
      <chr>          <int>
    1 Sekolah 14       112
    2 Sekolah 44       126
    3 Sekolah 52       147
    4 Sekolah 67       122
    5 Sekolah 78       116

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
