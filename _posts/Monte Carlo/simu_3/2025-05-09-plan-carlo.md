---
date: 2025-05-09T14:40:00-04:00
title: "Math and Computational Science for Business part 3: Simulasi Monte Carlo untuk Perencanaan Marketing Activites"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Simulasi
  - Monte Carlo
  - Simulasi Monte Carlo
  - Omset
  - Planning
  - Marketing
  - Brand
---

Beberapa pekan ini saya mendapat *request* pekerjaan yang agak *riweuh*.
Yakni untuk membuat simulasi Monte Carlo yang berguna untuk basis
pembuatan dan perencanaan *marketing activities* di tahun depan.
Sebenarnya ini bukan hal pertama buat saya karena saya pernah menuliskan
pekerjaan yang mirip-mirip untuk [usaha cafe / restoran teman saya
dulu](https://ikanx101.com/blog/planning-omset-mc/).

Jadi bagaimana caranya? Saya akan coba berikan satu *case* yang bisa
menggambarkan prosesnya. *Cekidot*.

------------------------------------------------------------------------

# Latar Belakang

Suatu *brand* telah melakukan survey dan memetakan target marketnya
menjadi dua kelompok utama, yakni:

1.  Kelompok *loyal user*, yang kemudian dipecah menjadi:
    - *High-medium user*.
    - *Low-medium user*.
2.  Kelompok *non user*, yang kemudian dipecah menjadi:
    - *Potential non user-to-trialist*.
    - *No potential at all*.

Berdasarkan peta tersebut, maka *brand* tersebut hendak merencanakan
tiga *marketing activities* yang ditujukan kepada tiga kelompok *target
market*:

1.  *High-medium user*.
2.  *Low-medium user*.
3.  *Potential non user-to-trialist*.

## *Marketing Activity I*

*Marketing activity* pertama ditujukan kepada *high-medium user*. Tujuan
dari *activity* ini adalah untuk menaikkan frekuensi dan *quantity*
pembelian *user*.

## *Marketing Activity II*

*Marketing activity* kedua ditujukan kepada *low-medium user*. Tujuan
dari *activity* ini adalah untuk menjaga persentase *user* ini tidak
berubah signifikan (jika memungkinkan tidak berkurang).

## *Marketing Activity III*

*Marketing activity* ketiga ditujukan kepada *non user* yang potensial
menjadi *trialist*. Caranya dengan melakukan program khusus.

------------------------------------------------------------------------

# Membuat Simulasi

Tujuan utama dari simulasi ini adalah menghitung berapa omset yang bisa
dihasilkan dari ketiga *marketing activities* tersebut. Oleh karena itu,
cara kita menghitung omset menjadi **krusial**.

Dasar perhitungan omset yang digunakan cukup mudah, yakni:

![\text{omset} = \sum{(\text{freq} \times \text{qty} \times {harga})}\_{i = 1}^N](https://latex.codecogs.com/svg.latex?%5Ctext%7Bomset%7D%20%3D%20%5Csum%7B%28%5Ctext%7Bfreq%7D%20%5Ctimes%20%5Ctext%7Bqty%7D%20%5Ctimes%20%7Bharga%7D%29%7D_%7Bi%20%3D%201%7D%5EN "\text{omset} = \sum{(\text{freq} \times \text{qty} \times {harga})}_{i = 1}^N")

> **Total pembelian yang dilakukan oleh semua konsumen.**

Berdasarkan formula di atas, maka titik kritis pada simulasi ini adalah:

1.  Penentuan ![N](https://latex.codecogs.com/svg.latex?N "N") atau
    seberapa banyak konsumen (per kelompok *target market*) yang membeli
    produk tersebut.
2.  Berapa frekuensi dan *quantity* pembelian per kelompok *target
    market*?
3.  Berapa harga per unit pembelian?

Untuk menyelesaikan ketiga titik kritis ini, tim *brand* sudah memiliki
**data-data survey untuk kelompok *high-medium user* dan *low-medium
user***.

Masalah yang saya hadapi adalah saya tidak punya data yang cukup untuk
kelompok *potential non user-to-trialist*. Maka dari itu, saya bisa
membuat beberapa asumsi atau tebakan. Inilah kelebihan dari simulasi
Monte Carlo di mana kita bisa memberikan “tebakan” kita ke dalam
simulasi yang kemudian akan divalidasi seiring dengan waktu sehingga
simulasi yang dihasilkan akan semakin mendekati realita yang ada.

## *Flow* Simulasi

Berikut adalah *flow* simulasi dari ketiga *marketing activites*:

![Flow Monte Carlo](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/simu_3/nomnoml%205.png)

Simulasi Monte Carlo memiliki dua jenis *input*, yakni:

1.  Parameter *certain*: merupakan parameter-parameter simulasi yang
    memiliki nilai pasti.
2.  Parameter *uncertain*: merupakan parameter-parameter simulasi yang
    memiliki nilai tak pasti. Parameter-parameter ini akan di-*input*
    berupa *range* (bisa berupa **min-max** ATAU **mean dan standar
    deviasinya**).

Sebagai catatan simulasi ini akan dilakukan untuk perhitungan omset
bulanan. Maka besaran nilai frekuensi pembelian merupakan frekuensi
pembelian bulanan.

Asumsi harga yang digunakan Rp1.500 per unit produk.

# Skrip Simulasi di **R**

Berikut adalah skrip yang saya gunakan untuk membuat simulasi ini:

    # Menghapus semua objek dari lingkungan kerja saat ini
    rm(list = ls())
    # Memaksa pengumpulan sampah (garbage collection) untuk membebaskan memori
    gc()

    # Memuat paket dplyr untuk manipulasi data
    library(dplyr)
    # Memuat paket tidyr untuk merapikan data
    library(tidyr)
    # Memuat paket ggplot2 untuk membuat grafik
    library(ggplot2)
    # Memuat paket ggpubr untuk membuat grafik siap publikasi
    library(ggpubr)

    # Menentukan jumlah iterasi untuk simulasi, diatur menjadi 1 juta
    n_simulasi  = 10^6
    # Menentukan ukuran populasi total
    populasi    = 10^8
    # Menentukan probabilitas status sosial ekonomi (SES) dalam persen
    prob_ses    = 60
    # Menentukan persentase populasi dalam rentang usia tertentu
    persen_usia = 73
    # Menentukan harga produk
    harga       = 1500

    # Menghitung target pasar berdasarkan populasi, probabilitas SES, dan persentase usia
    target_market = populasi * (prob_ses / 100) * (persen_usia / 100)

    # Menentukan rentang persentase pengguna (minimal dan maksimal)
    persen_user = c(65,70)

    # Menghasilkan sejumlah pengguna secara acak untuk setiap simulasi
    # Angka acak diambil dari distribusi uniform antara persentase pengguna minimal dan maksimal,
    # kemudian dikalikan dengan populasi total
    n_user     = (runif(n_simulasi,
                        min = persen_user[1],
                        max = persen_user[2]) / 100) * populasi
    # Menghitung jumlah non-pengguna dengan mengurangkan jumlah pengguna dari populasi total
    n_non_user = populasi - n_user

    # Menentukan rentang persentase pengguna kategori heavy dan medium (minimal dan maksimal)
    persen_heavy_medium = c(25,35)

    # Menghasilkan sejumlah pengguna kategori heavy dan medium secara acak untuk setiap simulasi
    # Angka acak diambil dari distribusi uniform antara persentase pengguna heavy/medium minimal dan maksimal,
    # kemudian dikalikan dengan jumlah pengguna total (n_user)
    n_heavy_medium = (runif(n_simulasi,
                             min = persen_heavy_medium[1],
                             max = persen_heavy_medium[2])/100) * n_user
    # Menghitung jumlah pengguna kategori low dan medium dengan mengurangkan jumlah pengguna heavy/medium dari jumlah pengguna total
    n_low_medium   = n_user - n_heavy_medium

    # marketing I
    # Menentukan rentang frekuensi pembelian (minimal dan maksimal) berdasarkan data survei, marketing I bertujuan menaikkan 1 kali beli
    freq_beli = c(4,6)
    # Menentukan rentang kuantitas pembelian (minimal dan maksimal) berdasarkan data survei, marketing I bertujuan menaikkan 1 unit produk
    qty_beli  = c(5,7)

    # Membuat dataframe bernama df_act_1 untuk simulasi marketing I
    df_act_1 =
      # Memulai dengan data frame yang berisi jumlah pengguna heavy/medium dan harga
      data.frame(n_heavy_medium,harga) %>%
      # Menambahkan kolom freq_beli dengan nilai acak dari distribusi uniform
      # berdasarkan rentang freq_beli yang telah ditentukan untuk setiap simulasi
      mutate(freq_beli = runif(n_simulasi,
                               min = freq_beli[1],
                               max = freq_beli[2])) %>%
      # Menambahkan kolom qty_beli dengan nilai acak dari distribusi uniform
      # berdasarkan rentang qty_beli yang telah ditentukan untuk setiap simulasi
      mutate(qty_beli = runif(n_simulasi,
                              min = qty_beli[1],
                              max = qty_beli[2])) %>%
      # Menambahkan kolom omset yang dihitung dari perkalian jumlah pengguna heavy/medium,
      # frekuensi beli, kuantitas beli, dan harga
      mutate(omset = n_heavy_medium * freq_beli * qty_beli * harga) %>%
      # Menambahkan kolom 'ket' untuk menandai bahwa ini adalah hasil dari "marketing 1"
      mutate(ket = "marketing 1")

    # marketing II
    # Menentukan rentang frekuensi pembelian (minimal dan maksimal) berdasarkan data survei
    freq_beli = c(1,4)
    # Menentukan rentang kuantitas pembelian (minimal dan maksimal) berdasarkan data survei
    qty_beli  = c(1,3)

    # Menghasilkan kembali jumlah pengguna low/medium dari distribusi normal
    # dengan rata-rata dari n_low_medium sebelumnya dan standar deviasi 10^6.
    # Marketing II bertujuan untuk mengecilkan deviasi (kode ini tampaknya menghasilkan ulang nilai n_low_medium dengan deviasi tertentu).
    n_low_medium = rnorm(n_simulasi,
                         mean = mean(n_low_medium),
                         sd   = 10^6)

    # Membuat dataframe bernama df_act_2 untuk simulasi marketing II
    df_act_2 =
      # Memulai dengan data frame yang berisi jumlah pengguna low/medium (yang baru dihasilkan) dan harga
      data.frame(n_low_medium,harga) %>%
      # Menambahkan kolom freq_beli dengan nilai acak dari distribusi uniform
      # berdasarkan rentang freq_beli yang telah ditentukan untuk setiap simulasi
      mutate(freq_beli = runif(n_simulasi,
                               min = freq_beli[1],
                               max = freq_beli[2])) %>%
      # Menambahkan kolom qty_beli dengan nilai acak dari distribusi uniform
      # berdasarkan rentang qty_beli yang telah ditentukan untuk setiap simulasi
      mutate(qty_beli = runif(n_simulasi,
                              min = qty_beli[1],
                              max = qty_beli[2])) %>%
      # Menambahkan kolom omset yang dihitung dari perkalian jumlah pengguna low/medium,
      # frekuensi beli, kuantitas beli, dan harga
      mutate(omset = n_low_medium * freq_beli * qty_beli * harga) %>%
      # Menambahkan kolom 'ket' untuk menandai bahwa ini adalah hasil dari "marketing 2"
      mutate(ket = "marketing 2")

    # marketing III
    # Menentukan rentang probabilitas konversi (minimal dan maksimal) yang diusahakan pada marketing III
    prob_conversion = c(.05,.2)
    # Menentukan rentang frekuensi pembelian (minimal dan maksimal) yang diusahakan pada marketing III
    freq_beli       = c(1,2)
    # Menentukan rentang kuantitas pembelian (minimal dan maksimal) yang diusahakan pada marketing III
    qty_beli        = c(1,2)

    # Membuat dataframe bernama df_act_3 untuk simulasi marketing III
    df_act_3 =
      # Memulai dengan data frame yang berisi jumlah non-pengguna dan harga
      data.frame(n_non_user,harga) %>%
      # Menambahkan kolom conver_rate (tingkat konversi) dengan nilai acak dari distribusi uniform
      # berdasarkan rentang prob_conversion yang telah ditentukan untuk setiap simulasi
      mutate(conver_rate = runif(n_simulasi,
                                 min = prob_conversion[1],
                                 max = prob_conversion[2])) %>%
      # Menambahkan kolom freq_beli dengan nilai acak dari distribusi uniform
      # berdasarkan rentang freq_beli yang telah ditentukan untuk setiap simulasi
      mutate(freq_beli = runif(n_simulasi,
                               min = freq_beli[1],
                               max = freq_beli[2])) %>%
      # Menambahkan kolom qty_beli dengan nilai acak dari distribusi uniform
      # berdasarkan rentang qty_beli yang telah ditentukan untuk setiap simulasi
      mutate(qty_beli = runif(n_simulasi,
                              min = qty_beli[1],
                              max = qty_beli[2])) %>%
      # Menambahkan kolom omset yang dihitung dari perkalian jumlah non-pengguna,
      # tingkat konversi, frekuensi beli, kuantitas beli, dan harga
      mutate(omset = n_non_user * conver_rate * freq_beli * qty_beli * harga) %>%
      # Menambahkan kolom 'ket' untuk menandai bahwa ini adalah hasil dari "marketing 3"
      mutate(ket = "marketing 3")

    # Menggabungkan hasil dari ketiga data frame (df_act_1, df_act_2, df_act_3) ke dalam satu list
    hasil  = list(df_act_1,df_act_2,df_act_3)
    # Menggabungkan list dari data frame menjadi satu data frame besar menggunakan rbindlist dari paket data.table
    # Parameter fill = T memastikan kolom yang tidak ada di semua data frame diisi dengan NA
    # Kemudian dikonversi kembali menjadi data frame standar R
    df_sim = data.table::rbindlist(hasil,fill = T) %>% as.data.frame()

# *Result* Simulasi

Berikut ini adalah visualisasi dari simulasinya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/simu_3/Post_files/figure-commonmark/unnamed-chunk-2-1.png)

Dari ketiga *marketing activities*, kita bisa lihat bahwa *marketing
activity* I memiliki hasil omset yang tertinggi baru setelah itu
*marketing activity* II. Sedangkan *marketing activity* III memiliki
hasil omset yang terendah.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/simu_3/Post_files/figure-commonmark/unnamed-chunk-3-1.png)

grafik di atas memberikan gambaran terkait *range* omset yang bisa
diraih. kedua grafik ini bisa dijadikan perhatian oleh tim *brand*
tentang bagaimana *effort* yang akan dilakukan kelak.

> **Oleh karena marketing III memiliki hasil yang terendah, kita bisa
> saja melakukan simulasi ulang untuk mencoba mengubah *prob
> conversion*. Akibatnya tim *brand* bisa mengukur *effort* yang kelak
> dilakukan. Jika *effort* yang dilakukan tak sebanding, sebaiknya tim
> *brand* mencari dan mencoba titik optimal di setiap *marketing
> activities*.**

Dari simulasi di atas, saya akan coba hitung 3 hal berikut ini:

1.  ***p80 omset*** : merupakan nilai omset yang punya peluang 80% akan
    terpenuhi. Artinya, saya bisa memandang nilai ini sebagai **nilai
    optimis omset bisa diraih**.
2.  ***expected omset*** : merupakan nilai omset rata-rata hasil
    simulasi.
3.  ***p20 omset*** : merupakan nilai omset yang punya peluang 20% akan
    terpenuhi. Artinya, saya bisa memandang nilai ini sebagai **nilai
    target atas jika diusahakan se-maksimal mungkin**.

Berikut adalah tabelnya:

| marketing activity | p80_omset        | expected_omset    | p20_omset         |
|:-------------------|:-----------------|:------------------|:------------------|
| marketing 1        | Rp76,714,157,557 | Rp91,314,417,173  | Rp105,550,522,460 |
| marketing 2        | Rp19,399,654,538 | Rp35,880,229,633  | Rp51,073,959,643  |
| marketing 3        | Rp816,012,808    | Rp1,366,933,335   | Rp1,876,077,388   |
| Total              | Rp96,929,824,902 | Rp128,561,580,141 | Rp158,500,559,491 |

Sekarang saya akan bahas tentang **p20 omset**. Apakah memungkinkan bagi
tim *brand* untuk mencapai nilai tersebut?

Misalkan saya mengisolasi hasil simulasi agar minimal omsetnya itu
senilai **p20 omset**. Saya buatkan visualisasi seperti ini lagi:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/simu_3/Post_files/figure-commonmark/unnamed-chunk-5-1.png)

Untuk memenuhi **p20 omset** (`Rp158,500,559,491`), ternyata omset hasil
*marketing activity* I tidak bisa berdiri sendiri. Harus dibantu dengan
dorongan omset hasil *marketing activity* II. Sedangkan *marketing
activity* III menjadi **tidak signifikan**.

Tim *brand* bisa fokus untuk mengusahakan *marketing activities* I dan
II dengan berbagai macam cara agar menaikkan frekuensi pembelian dan
*quantity* pembelian menjadi seperti ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/simu_3/Post_files/figure-commonmark/unnamed-chunk-6-1.png)

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
