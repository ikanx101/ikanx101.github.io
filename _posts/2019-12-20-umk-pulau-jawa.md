---
date: 2019-12-20T21:00:00-04:00
title: "Upah Minimum Kota/Kabupaten di Pulau Jawa"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Web Scraping
  - UMK
  - Tenaga Kerja
---

Upah Minimum Kota di Pulau Jawa
================

Sebagai seorang orang yang berkecimpung di dunia *recruitment* dan *HR*,
nyonya malam ini mengajak diskusi terkait dengan data hasil survey
mengenai **Indonesia Salary Benchmark** yang dilakukan oleh lembaga
bernama *Michael Page*.

> *Seharusnya gaji kamu itu segini lho…* Katanya sambil menunjuk ke
> hasil surveynya.

> *Oh begitu yah?* Jawab saya sambil tersenyum.

Pembahasan mengenai gaji memang tiada habisnya.

Berbicara soal gaji, ada satu topik yang biasanya selalu menjadi buah
bibir di akhir tahun. Yaitu mengenai upah minimum kota / kabupaten /
provinsi (saya singkat menjadi **UMK** yah). Di Pulau Jawa,
masing-masing provinsi dan kota memiliki cara perhitungan masing-masing
sehingga besarannya juga berbeda.

Ada yang masih menjadi polemik, ada yang tenang-tenang saja dan minim
pemberitaan.

Penasaran dengan besaran UMK tersebut, saya coba *Googling* sana-sini
untuk mendapatkan datanya.

> *Kalau nemu dalam bentuk tabel, enak banget nih scrap-nya* Pikir saya.

Tapi setelah mencari-cari kok tidak ketemu yah.

Akhirnya saya putuskan untuk mengambil datanya dari teks di [halaman
berita
ini](https://www.kompas.com/tren/read/2019/11/22/191520565/disahkan-berikut-rincian-ump-dan-umk-2020-di-dki-jakarta-jawa-barat-jawa?page=all).

Di *website* tersebut, hanya disebutkan **UMK** dari provinsi DKI
Jakarta, Jawa Barat, Jawa Tengah, dan Jawa Timur. Seagai informasi, DKI
Jakarta hanya memiliki satu nilai `umk` yakni sebesar: Rp 4.267.349,
maka saya hanya akan membahas data di provinsi lainnya yah.

## Scrap data

Saya mulai dengan scrap data menggunakan `library(rvest)` di **R**. Tapi
sayang sekali, formatnya masih *unstructured* sebagai berikut:

    ##  [1] "Kabupaten Karawang Rp 4.594.324"     
    ##  [2] "Kota Bekasi Rp 4.589.708"            
    ##  [3] "Kabupaten Bekasi Rp. 4.498.961"      
    ##  [4] "Kota Depok Rp 4.202.105"             
    ##  [5] "Kota Bogor Rp 4.169.806"             
    ##  [6] "Kabupaten Bogor Rp 4.083.670"        
    ##  [7] "Kabupaten Purwakarta Rp 4.039.067"   
    ##  [8] "Kota Bandung Rp 3.623.778"           
    ##  [9] "Kabupaten Bandung Barat Rp 3.145.427"
    ## [10] "Kabupaten Sumedang Rp 3.139.275"     
    ## [11] "Kabupaten Bandung Rp 3.139.275"      
    ## [12] "Kota Cimahi Rp 3.139.274"            
    ## [13] "Kabupaten Sukabumi Rp 3.028.531"     
    ## [14] "Kabupaten Subang Rp 2.965.468"       
    ## [15] "Kabupaten Cianjur Rp 2.534.798"

## Data carpentry

Bentuk data itu harus saya ubah dulu agar bisa dianalisa lebih lanjut.
Sebenarnya caranya simpel yah, jika diperhatikan baik - baik, saya bisa
melakukan `separate` dengan memanfaatkan pola adanya tanda **Rp** di
setiap baris data.

Setelah itu, saya akan tambahkan informasi mengenai nama provinsi
sebagai variabel. Sehingga didapatkan data sebagai berikut:

    ##      provinsi      tipe                 kota_kab     umk
    ## 1  Jawa Barat Kabupaten      Kabupaten Karawang  4594324
    ## 2  Jawa Barat      Kota             Kota Bekasi  4589708
    ## 3  Jawa Barat Kabupaten        Kabupaten Bekasi  4498961
    ## 4  Jawa Barat      Kota              Kota Depok  4202105
    ## 5  Jawa Barat      Kota              Kota Bogor  4169806
    ## 6  Jawa Barat Kabupaten         Kabupaten Bogor  4083670
    ## 7  Jawa Barat Kabupaten    Kabupaten Purwakarta  4039067
    ## 8  Jawa Barat      Kota            Kota Bandung  3623778
    ## 9  Jawa Barat Kabupaten Kabupaten Bandung Barat  3145427
    ## 10 Jawa Barat Kabupaten      Kabupaten Sumedang  3139275
    ## 11 Jawa Barat Kabupaten       Kabupaten Bandung  3139275
    ## 12 Jawa Barat      Kota             Kota Cimahi  3139274
    ## 13 Jawa Barat Kabupaten      Kabupaten Sukabumi  3028531
    ## 14 Jawa Barat Kabupaten        Kabupaten Subang  2965468
    ## 15 Jawa Barat Kabupaten       Kabupaten Cianjur  2534798

## Mulai oprek-oprek

Nah, berhubung datanya sudah rapih, mari kita lihat satu-persatu yah.

### Kota vs Kabupaten

Banyak orang (termasuk saya) tidak bisa membedakan apa itu kota dan
kabupaten. Apakah kota selalu lebih maju dibanding kabupaten? Untuk
urusan upah minimum ini, mari kita lihat perbandingan kota dan kabupaten
di Jawa Barat, Jawa Tengah, dan Jawa Timur.

    ## # A tibble: 2 x 4
    ##   tipe      mean_umk std_umk     n
    ##   <chr>        <dbl>   <dbl> <int>
    ## 1 Kabupaten 2339478. 746316.    76
    ## 2 Kota      2689935. 859071.    24

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Upah%20Minimum%20Kota/2019-12-20-umk-pulau-jawa_files/figure-gfm/unnamed-chunk-5-1.png "chart")

Dari informasi dan grafik di atas, kita bisa menyimpulkan sementara
bahwa upah minimum di kota lebih tinggi dibandingkan kabupaten. Apakah
perbedaan ini signifikan? Untuk mengeceknya, kita akan lakukan uji t (*t
test*).

> Tapi ingat ya, bahwa *t test* itu digunakan pada statistika
> parametrik\!

Untuk data UMK ini, berhubung saya malas untuk mengecek normalitasnya,
maka saya akan gunakan uji non parametrik pengganti *t test* yakni
**Wilcoxon test (rank sum test)**.

Sebagai informasi, statistika non parametrik adalah analisa statistika
yang tidak memperdulikan distribusi dari suatu data yang akan diuji.

Untuk menyelesaikannya, saya akan membuat hipotesis berikut:

1.  H0: `umk` di kota dan kabupaten tidak berbeda signifikan.
2.  H1: `umk` di kota dan kabupaten berbeda signifikan.

Mari kita uji hipotesis tersebùt dengan **Wilcoxon test**.

    ## 
    ##  Wilcoxon rank sum test with continuity correction
    ## 
    ## data:  umk by tipe
    ## W = 588, p-value = 0.008993
    ## alternative hypothesis: true location shift is not equal to 0

Dari hasil uji di atas, kita akan melihat berapa nilai **p-value** yang
didapatkan, yakni:

    ## [1] 0.008993401

Kita akan bandingkan nilai **p-value** tersebut dengan alpha=0.05.

> Karena **p-value** lebih kecil dari alpha, maka H0 ditolak.

Kita bisa menyimpulkan bahwa ada perbedaan nilai rata-rata `umk` di kota
dan kabupaten pada data ini.

### Provinsi vs Provinsi

Mari kita coba cek, apakah ada perbedaan nilai `umk` di ketiga provinsi
ini? Kita hitung nilai rata-rata dan standar deviasinya yah:

    ## # A tibble: 3 x 4
    ##   provinsi    mean_umk std_umk     n
    ##   <chr>          <dbl>   <dbl> <int>
    ## 1 Jawa Barat  2963496. 949951.    27
    ## 2 Jawa Tengah 1980785. 199966.    35
    ## 3 Jawa Timur  2447814. 760704.    38

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Upah%20Minimum%20Kota/2019-12-20-umk-pulau-jawa_files/figure-gfm/unnamed-chunk-9-1.png "chart")

Kalau kita lihat sekilas, sepertinya ketiga provinsi tersebut tidak
memiliki rata-rata `umk` yang sama.

> Mari kita konfirmasi dugaan tersebut dengan pengujian statistik.

Berhubung saya tidak ingin menggunakan **Annova** (*statistika
parametrik*), saya akan menggunakan metode *statistika non parametrik*
pengganti **Annova**, yakni: **Kruskal Wallis test**.

Seperti biasa, kita akan bangun hipotesis berikut ini:

1.  H0: `umk` di semua provinsi tidak berbeda signifikan.
2.  H1: terdapat perbedaan `umk` yang signifikan di antara ketiganya
    (minimal satu provinsi berbeda).

Kita dapatkan hasil sebagai berikut:

    ## 
    ##  Kruskal-Wallis rank sum test
    ## 
    ## data:  umk by provinsi
    ## Kruskal-Wallis chi-squared = 25.968, df = 2, p-value = 2.296e-06

Dari hasil uji di atas, kita akan melihat berapa nilai **p-value** yang
didapatkan, yakni:

    ## [1] 2.296457e-06

Kita akan bandingkan nilai **p-value** tersebut dengan alpha=0.05.

> Karena **p-value** lebih kecil dari alpha, maka H0 ditolak.

Kita bisa menyimpulkan bahwa ada perbedaan nilai rata-rata `umk` di tiga
provinsi ini.

-----

#### Provinsi mana yang memiliki `umk` lebih besar?

Lalu, apa bisa kita tentukan siapa yang memiliki rata-rata `umk`
terbesar? Secara visual kita bisa melihatnya sendiri dari grafik di
atas. Tapi jika ingin lebih pasti. Kita bisa gunakan uji statistik
bernama **multiple pairwise comparison using wilcox test**.

    ## 
    ##  Pairwise comparisons using Wilcoxon rank sum test 
    ## 
    ## data:  my_data$umk and my_data$provinsi 
    ## 
    ##             Jawa Barat Jawa Tengah
    ## Jawa Tengah 7.8e-06    -          
    ## Jawa Timur  0.04195    0.00048    
    ## 
    ## P value adjustment method: BH

Jika kita perhatikan tabel di atas. Nilai **p-value** yang didapatkan
semuanya lebih kecil daripada nilai alpha=0.05.

> Kita bisa simpulkan bahwa rata-rata `umk` di Jawa Barat \> Jawa Timur
> \> Jawa Tengah.

### Kota vs Kabupaten per Provinsi

Nah, di bagian terakhir ini. Saya ingin membuat visualisasi jika analisa
pertama (kota vs kabupaten) dilakukan untuk setiap provinsi.

Bagaimana
hasilnya?

![alt text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Upah%20Minimum%20Kota/2019-12-20-umk-pulau-jawa_files/figure-gfm/unnamed-chunk-13-1.png "x")

# Any comments?
