---
date: 2020-1-17T10:49:00-04:00
title: "Training R-Series: Day 1"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Training
---

![alt
text](https://bookdown.org/moh_rosidi2610/Metode_Numerik/images/r-icon.png
"logo")

# Untuk apa saya belajar **R**?

Di era digitalisasi ini, disadari atau tidak data tersebar di mana-mana.
Data juga dihasilkan dengan *volume* yang besar dalam waktu singkat.

> *Analoginya seperti ada sungai yang memiliki arus yang deras dan
> kencang.*

Seperti itulah kondisi saat ini.

*Tools* analisa data klasik seperti **Ms. Excel** dan **SPSS** sudah
tidak mampu lagi melakukan analisa *big data* yang seringkali berbentuk
*unstructured data*.

**R** tidak sendirian, ada juga *software* lain bernama **Python**.
Keduanya digunakan untuk membuat algoritma *artificial intelligence*
(bahasa keren dari *machine learning*. Bahasa kerennya dari
*computational science*).

> *So*, daripada ngomong *ngalor-ngidul* tentang *artificial
> intelligence* padahal *gak* tahu barangnya seperti apa, mending
> belajar **R** bareng biar *gak* gagal paham. *Heeee*

# 1\. Pendahuluan

**R** merupakan salah satu bahasa pemrograman yang biasa digunakan untuk
menyelesaikan permasalahan terkait dengan data. Kita bisa membuat model
prediksi (*machine learning*, *artificial intelligence*, dan *deep
learning*) sampai membuat algoritma automasi menggunakan **R**.

> Apa perbedaan R dan Python?

Salah satu kelebihan **R** adalah:

> R is made by statistician for statistician.

Setiap *package* atau *library* yang di-*launching* di **R** biasanya
disertakan dengan jurnal ilmiah sehingga kita bisa dengan yakin
memakainya.

**R** tersedia secara *open source* sehingga *software* ini gratis dan
dikembangkan secara massal oleh komunitas-komunitas di seluruh dunia.
Sehingga *package* atau *library* yang disediakan untuk analisis
statistika dan analisa numerik juga sangat lengkap dan terus bertambah
setiap saat.

Bagaimana dengan **Python**?

> Sejatinya Python digunakan untuk membangun aplikasi. Namun, belakangan
> ini ternayta Pyhton disadari bisa untuk melakukan pengolahan data.

Berbeda dengan **R** yang memang dibangun untuk kebutuhan *data
science*, **Python** membutuhkan *libraries* setiap kali melakukan
pengolahan data.

Materi *training* ini saya kumpulkan dari berbagai sumber dan saya
*customize* sesuai dengan kebutuhan **Nutrifood** berdasarkan pengalaman
selama ini berkutat dengan data yang ada (dari mulai data pabrik hingga
*finance*). Semoga menjadi manfaat bagi *Nutrifooders* semua. Terima
kasih kepada **Lenny Wibisana** dan **Teguh Prasetia** yang telah ikut
berkontribusi pada penyusunan materi ini.

## 1.1 Sejarah

**R** Merupakan bahasa yang digunakan dalam komputasi statistik yang
pertama kali dikembangkan oleh *Ross Ihaka* dan *Robert Gentlement* di
*University of Auckland New Zealand* yang merupakan akronim dari nama
depan kedua pembuatnya. Sebelum **R** dikenal ada **S** yang
dikembangkan oleh *John Chambers* dan rekan-rekan dari *Bell
Laboratories* yang memiliki fungsi yang sama untuk komputasi statistik.
Hal yang membedakan antara keduanya adalah **R** merupakan sistem
komputasi yang bersifat gratis.

## 1.2 Fitur dan Karakteristik

Sama halnya dengan bahasa pemograman lainnya. Berbeda bahasa berarti
berbeda peraturan / cara menulis *code* (algoritma). Tapi jangan
khawatir, dengan memanfaatkan *tidy principle* di **R**, kita bisa
menulis algoritma dengan mudah (bagi kita dan pembaca algoritmanya).

> Oleh karena itu, menurut saya **R** menawarkan *learning curve* yang
> jauh lebih baik dibandingkan *Python*.

Beberapa karakter dari **R** adalah sebagai berikut:

1.  Bahasa **R** bersifat *case sensitive*. Setiap perbedaan cara
    penulisan (kapital vs non kapital) akan membedakan suatu objek.
    Contoh:

<!-- end list -->

``` r
x = 'Nutrifood'
y = 'nutrifood'
x == y
```

    ## [1] FALSE

2.  Segala sesuatu yang ada pada program **R** akan diangap sebagai
    objek. konsep objek ini sama dengan bahasa pemrograman berbasis
    objek yang lain seperti *Java*, *C++*, *Python*, dll. Perbedaannya
    adalah bahasa **R** relatif lebih sederhana dibandingkan bahasa
    pemrograman berbasis objek yang lain.
3.  *Interpreted language* atau *script*. Bahasa **R** memungkinkan
    pengguna untuk melakukan kerja pada **R** tanpa perlu melakukan
    *compile* menjadi *executionable* file (.exe).
4.  Mendukung proses *loop*, *decision making*, dan menyediakan berbagai
    jenis operator (aritmatika, logika, dll).
5.  Mendukung *export* dan *import* berbagai *format file*, seperti:
    `.txt`, `.xlsx`, `.csv`, `.json`, `sql`, dll.
6.  Mudah ditingkatkan melalui penambahan fungsi atau *library*.
    Penambahan ini dapat dilakukan secara *online* melalui **CRAN** atau
    melalui sumber seperti **github**.
7.  Menyedikan berbagai fungsi untuk keperluan visualisasi data.
    Visualisasi data pada **R** dapat menggunakan *library* bawaan atau
    lainnya seperti `ggplot2`, `ggvis`, `plotly`, dll.

## 1.3 Kelebihan dan Kekurangan **R**

Selain karena **R** dapat digunakan secara gratis terdapat kelebihan
lain yang ditawarkan, antara lain:

1.  *Protability*, penggunaan *software* dapat digunakan kapanpun tanpa
    terikat oleh masa berakhirnya lisensi.
2.  *Multiplatform*, **R** bersifat *Multiplatform Operating Systems*,
    dimana **R** bisa dijalankan di OS manapun. Baik Windows, iOS,
    Linux, Raspbian, bahkan
    [Android](https://passingthroughresearcher.wordpress.com/2019/07/30/install-r-3-5-2-di-android/)\!
    Dengan fitur yang sama (tidak ada perbedaan fitur di semua OS).
3.  *Programable*, pengguna dapat membuat fungsi dan metode baru atau
    mengembangkan modifikasi dari analisis statistika yang telah ada
    pada sistem **R**.
4.  Fasiltas grafik yang lengkap.

Adapun kekurangan dari R antara lain:

  - *Point and Click GUI*, interaksi utama dengan **R** bersifat **CLI**
    (*Command Line Interface*), walaupun saat ini telah dikembangkan
    *library* yang memungkinkan kita berinteraksi dengan **R**
    menggunakan **GUI** (*Graphical User Interface*) sederhana
    menggunakan `library(R-Commander)` yang memiliki fungsi yang
    terbatas.

## 1.4 R vs R Studio

Pada dasarnya, *software* **R** bisa di-*download* dan di-*install*
langsung dari situs
[CRAN](https://cran.r-project.org/bin/windows/base/). *Software* **R**
ini bersifat **CLI**.

> Bayangkan Anda membuka aplikasi **notepad**. Putih dan bersih kan?

Seperti itulah *software* **R**.

Bagi Kamu yang kaget dan tidak terbiasa melihat tampilan yang
*intimidating* seperti itu, Kamu bisa meng-*install software* **R
Studio**. Sebuah *software* GUI yang bisa membuat **R** terlihat lebih
*user friendly*. **R Studio** bisa di-*download* [di
sini](https://rstudio.com/products/rstudio/download/).

> Tapi tolong diperhatikan bahwa **R Studio** hanya tambahan tampilan
> dari **R** standar. Jadi Kamu tetap harus meng- *install* **R** yah\!

Kelebihan R Studio antara lain:

1.  *Free*, kita bisa memilih versi gratis dari **R Studio** tanpa ada
    pengurangan fitur dasar dari **R**.
2.  *R Studio Cloud*, tersedia layanan *cloud* sehingga bisa diakses dan
    digunakan menggunakan *browser* di *gadget* manapun. Layanan *cloud*
    ini bisa diakses [di sini](https://rstudio.cloud) dan dikoneksikan
    ke akun **github** Kamu. Kira-kira seperti ini tampilannya jika
    dibuka di *Chrome for Android*: ![alt
    text](https://passingthroughresearcher.files.wordpress.com/2019/11/screenshot_20191113-045720_chrome8061063824617160210.jpg
    "chart")
3.  *Shiny Apps*, kita bisa membuat *apps* berbasis *web* dari **R**.
    *Apps* ini bisa dijadikan *dashboard* atau mesin kalkulasi otomatis.
    Tergantung seberapa jauh Kamu membuat *coding* algoritmanya.
4.  *R Markdown*, ini fitur yang paling saya sukai. Bahkan untuk menulis
    *web* ini, saya menggunakan *R Markdown*. Output files -nya beragam,
    mulai dari `docx`, `pptx`, `pdf`, `html`, `md`, dll. Bahkan kita
    bisa membuat [*e-book*](https://bookdown.org/) dengan memanfaatkan
    `library(bookdown)`.

Jadi, setelah membaca bagian ini pastikan Kamu sudah meng- *install*
**R** dan **R Studio** yah.

> Jangan sampai terbalik urutan instalasinya\!

## 1.5 Mengenal operator dasar

Beberapa operator dasar di **R** antara lain:

1.  `=` atau `<-`, digunakan untuk melakukan pendefinisian suatu objek.
    Contoh:

<!-- end list -->

``` r
a = 10
b <- 3
a + b
```

    ## [1] 13

2.  `' '` atau `" "`, digunakan untuk menandai tipe variabel berupa
    `character`. Lalu apa beda penggunaan `' '` dengan `" "`? `" "`
    digunakan saat `'` dibutuhkan dalam suatu `character`. Contoh:

<!-- end list -->

``` r
a = 'saya hendak pergi ke pasar'
b = "i don't want to buy it"
a
```

    ## [1] "saya hendak pergi ke pasar"

``` r
b
```

    ## [1] "i don't want to buy it"

3.  `==`, `<`, `>`, `<=`, atau `>=`, digunakan untuk mengecek apakah dua
    variabel itu memiliki kesamaan atau tidak. *Output* dari operator
    ini adalah `logic` (*TRUE or FALSE*). Contoh:

<!-- end list -->

``` r
a = 5
b = 3
a == b
```

    ## [1] FALSE

``` r
a > b
```

    ## [1] TRUE

4.  `;` atau *<enter>*, digunakan untuk memisahkan baris kode pada skrip
    algoritma. Contoh:

<!-- end list -->

``` r
a = 5;b = 3;a*b
```

    ## [1] 15

## 1.6 Working Directory

Apa itu *working directory*?

> *Working directory* adalah *folder path default* untuk **R** melakukan
> *import* dan *export* data.

Untuk mengetahui di mana *working directory* kita, bisa digunakan
perintah:

``` r
getwd()
```

    ## [1] "/cloud/project/Materi Training/Day 1 - R Series"

Secara *default*, **R** menggunakan `C:\\My Documents` sebagai *working
directory*.

### 1.6.1 Bagaimana mengubah *working directory*?

*Working directory* bisa diubah sesuai kemauan kita memanfaatkan
perintah `setwd()`, tanda dalam kurung diisi dengan *folder path* yang
diinginkan.

``` r
setwd('/cloud/project/Materi Training/Day 1 - R Series')
```

### 1.6.2 Apa keuntungan mengubah-ubah *working directory*?

Perubahan *working directory* akan sangat berguna saat kita ingin
memgambil data dari *folder path* tertentu dan menyimpan hasil analisa
kita ke *folder path* yang berbeda.

## 1.7 Mengenal *packages* atau *library*

`packages` atau `library` adalah sekumpulan fungsi yang telah dibuat dan
dibakukan untuk kemudian disertakan di halaman *web* CRAN atau github.
`library` bisa kita *install* dan gunakan dengan mudah.

Seperti yang sudah saya infokan di bagian pendahuluan. Banyak orang atau
komunitas yang mengembangkan berbagai macam `library` sehingga
memudahkan kita untuk menyelesaikan masalah di data kita. Kita tidak
perlu lagi membuat algoritma dari nol. Cukup memanfaatkan `library` yang
tepat saja.

Beberapa contoh `library` yang sering saya gunakan:

1.  `dplyr`: *data carpentry* menggunakan *tidy principle*.
2.  `ggplot2`: *data visualization*.
3.  `rvest`: *web scraping*.
4.  `tidytext`: *text analysis*.
5.  `reshape2`: *data manipulation*.
6.  `readxl` atau `openxlsx`: *export* dan *import* *excel files*.
7.  `officer`: membuat *Ms. Office files* seperti *excel*, *docx*, dan
    *powerpoint*.
8.  `expss`: **SPSS** di **R**.

### 1.7.1 Instalasi *Packages*

`library` di **R** bisa di-*install* dengan mudah dengan menggunakan
perintah `install.packages('nama packages')`. Tanda dalam kurung diisi
`character` nama `library`. Bisa menggunakan `" "` atau `' '`.

Proses instalasi `library` ini membutuhkan koneksi internet karena **R**
akan otomatis terhubung ke dalam situs *web* **CRAN**. Setelah proses
instalasi selesai, maka koneksi internet tidak diperlukan lagi (kecuali
untuk melakukan *web scraping*).

Contoh:

`install.packages('readxl')`

`install.packages("rvest")`

### 1.7.2 Mengaktifkan *Packages*

`library` yang sudah di-*install* bisa diaktifkan dengan menggunakan
perintah `library(nama packages)` tanpa menggunakan tanda `" "` atau `'
'`.

Pengaktifan `library` cukup dilakukan sekali saja di awal pengerjaan
*project* (tidak perlu dilakukan berulang kali). Contoh:

``` r
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

### 1.7.3 Serba-Serbi Tentang *Packages*

Untuk beberapa `library` ada kemungkinan (kecil) ditemukan kasus saat
mereka tidak kompatibel. Akibatnya beberapa fungsi perintah di `library`
tersebut akan menjadi kacau.

Misalnya pada saat kita memanggil `library(tidyverse)` dan
`library(plyr)`, maka perintah `filter()` yang dimiliki `tidyverse` akan
tidak berjalan dengan baik.

Ada beberapa solusi yang bisa kita lakukan:

1.  Selalu mengaktifkan `library` sesuai dengan urutannya. Biasanya
    setiap kali kita mengaktifkan `library` akan muncul *warnings*
    mengenai kompatibilitas `library` tersebut dengan `library` lain.
2.  Menonaktikan `library` yang sudah tidak perlu digunakan dengan
    perintah:

`detach("package:tidytext", unload = TRUE)`

3.  Memanggil `library` tanpa harus mengaktifkannya. Kita bisa
    melakukannya dengan menggunakan tanda `nama packages::`. Contoh:

`reshape2::melt(data)`

### 1.7.4 *Help*

Setiap `library` yang telah di-*install* dan aktif disertai dengan fitur
*help* yang berfungsi sebagai informasi kepada *user*. Jika kita ingin
mengetahui bagaimana isi dari perintah suatu fungsi, kita bisa gunakan
perintah `help(nama fungsi)` atau `?nama fungsi`. *Help* akan muncul
pada tab *help* di **R Studio**. Contoh:

``` r
help(sum)
```

atau

``` r
?sum
```

### 1.7.5 *Example*

Selain *help*, kita bisa melihat contoh pemakaian dari suatu fungsi di
**R** dengan menggunakan perintah `example()`. Contoh:

``` r
example(sum)
```

    ## 
    ## sum> ## Pass a vector to sum, and it will add the elements together.
    ## sum> sum(1:5)
    ## [1] 15
    ## 
    ## sum> ## Pass several numbers to sum, and it also adds the elements.
    ## sum> sum(1, 2, 3, 4, 5)
    ## [1] 15
    ## 
    ## sum> ## In fact, you can pass vectors into several arguments, and everything gets added.
    ## sum> sum(1:2, 3:5)
    ## [1] 15
    ## 
    ## sum> ## If there are missing values, the sum is unknown, i.e., also missing, ....
    ## sum> sum(1:5, NA)
    ## [1] NA
    ## 
    ## sum> ## ... unless  we exclude missing values explicitly:
    ## sum> sum(1:5, NA, na.rm = TRUE)
    ## [1] 15

-----

# 2\. Mulai Bekerja dengan **R**

## 2.1 Mengenal Data

Sebelum memulai bekerja dengan **R**, ada baiknya saya jelaskan dan
ingatkan kembali beberapa hal penting terkait data. Dengan demikian,
kita bisa memilih jenis analisa statistika apa yang tepat untuk
tipe-tipe data yang berbeda.

### 2.1.1 Tipe Data (statistika)

Secara statistika, berikut adalah pembagian data berdasarkan tipenya:

![alt
text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Materi%20Training/Day%201%20-%20R%20Series/tipe%20data.png
"tipe")

1.  Data kualitatif: adalah data yang tidak bisa dilakukan operasi
    aritmatika (penjumlahan, pengurangan, pembagian, dan perkalian).
    Data seperti ini, kita akan sebut sebagai **data kategorik**.

<!-- end list -->

  - **Nominal**; Representasi dari sesuatu. Contoh: `gender`, `1` saya
    tulis sebagai `pria` dan `2` saya tulis sebagai `wanita`.
  - **Ordinal**; Urutan dari data menjadi penting. Contoh: skala
    *likert* 1 - 6.

<!-- end list -->

2.  Data kuantitatif: adalah data yang bisa dilakukan operasi aritmatika
    (penjumlahan, pengurangan, pembagian, dan perkalian). Data seperti
    ini, kita akan sebut sebagai **data numerik**.

<!-- end list -->

  - **Diskrit**; bilangan bulat (*integer*).
  - **Kontinu**; bilangan *real* (mengandung koma).

### 2.1.2 Tipe Data di **R**

Di **R** ada beberapa tipe data yang sering digunakan. Secara hierarki,
bisa diurutkan sebagai berikut:

`character > numeric > integer > logical`

Oke, saya coba jelaskan satu persatu yah:

1.  `character`: merupakan tipe data berupa karakter atau `string`.
    Semua data bisa dilihat sebagai `character`. Oleh karena itu, secara
    hierarki tipe data ini ditempatkan di urutan paling atas. Namun,
    data tipe ini tidak bisa dilakukan operasi aritmatika *yah*.
2.  `numeric`: merupakan tipe data angka berupa bilangan *real*. Kalau
    saya boleh bilang, tipe data ini mirip dengan data numerik di poin
    **2.1.1**.
3.  `integer`: merupakan tipe data angka berupa bilangan bulat. Sekilas
    mirip dengan tipe data diskrit di poin **2.1.1**. Namun di beberapa
    kondisi, tipe data ini bisa dijadikan data **kategorik** sehingga
    kita bisa sebut tipenya menjadi `factor`.
4.  `logical`: merupakan tipe data *boolean*. Hanya berisi `TRUE` atau
    `FALSE`. Tipe data ini sangat berguna saat kita melakukan *if
    conditional*, *looping*, atau membuat *regex* (*reguler
    expression*).

### 2.1.3 Struktur Data di **R**

Ada beberapa bentuk struktur data di **R**, yakni:

1.  *Single value*; satu objek yang berisi satu *value* saja.
2.  *Vector*; kumpulan dari beberapa *single value(s)* yang menjadi satu
    objek. Bayangkan sebagai satu buah kolom di *file Ms. Excel*.
3.  *Data frame* atau *tibble*; merupakan kumpulan dari beberapa
    *vectors* yang memiliki ukuran sama. Bayangkan sebagai satu tabel di
    *Ms. Excel* yang banyaknya baris di setiap kolom sama.
4.  *List*; merupakan bentuk struktur data yang sangat kompleks. Berisi
    *multiple data* dengan struktur bermacam-macam.

### 2.1.4 Apa gunanya kita mengetahui jenis dan struktur data di **R**?

Beberapa algoritma yang tersedia di *library* mengharuskan kita memiliki
*input* yang ter-standar, baik dari segi jenis dan strukturnya.

Dengan mengetahui jenis dan struktur data, kita bisa lebih mudah bekerja
dengan algoritma yang ada di *library*.

Contoh:

> Algoritma analisa *simple linear regression* (`lm()`) memerlukan input
> berupa `data.frame()` dengan masing-masing *variables* yang ada di
> dalamnya berjenis *numeric*.

## 2.2 Tata Cara Memberikan Nama *Object* atau Variabel

Setiap *object* atau variabel di **R** bisa diberikan nama sesuai dengan
keinginan kita. Tidak ada aturan baku dalam memberikan nama.

> Tapi, dengan memberikan nama yang **tepat** kita bisa bekerja dengan
> ebih cepat dan efisien.

Berikut adalah tata cara pemberian nama yang akan membuat pekerjaan kita
lebih efisien:

1.  Seragamkan kapital atau non kapital dari nama variabel kita. Jika
    menggunakan *lowercase*, maka harus konsisten di setiap data yang
    ada di *environment* **R**.
2.  Hindari penggunaan spasi " “. Jika memang tidak bisa dihindari,
    gunakan tanda”." atau "\_".

<!-- end list -->

  - Contoh: variabel `tinggi badan` akan lebih baik ditulis dalam bentuk
    `tinggi.badan` atau `tinggi_badan`.

Jika sudah terlanjur memiliki nama variabel yang tidak seragam atau
mengandung spasi (biasanya terjadi saat kita meng- *import* data dari
sumber lain seperti: *excel*), kita bisa merapikannya dengan otomatis
dengan memanfaatkan `library(janitor)` fungsi `make_clean_names()`.

-----

# 3\. Memulai dengan **R**

Oke, kita akan memulai bekerja dengan **R**, dimulai dari fungsi-fungsi
awal sebagai berikut:

## 3.1 Fungsi Awal

### 3.1.1 Pendefinisian *object*

Setiap data yang akan kita masukkan ke dalam memori **R**, akan saya
sebut sebagai *object*. Setiap *object* yang ingin dimasukkan ke dalam
memori perlu didefinisikan terlebih dahulu menggunakan perintah `=` atau
`<-`.

Contoh:

``` r
a = 6
b <- 8

a
```

    ## [1] 6

``` r
b
```

    ## [1] 8

### 3.1.2 Operasi Aritmatika dan Matematika

Setiap *object* yang sudah masuk ke dalam memori **R** sudah bisa
dilakukan analisa atau dilakukan operasi aritmatika: `+`, `-`, `/`, dan
`*` ATAU diberikan fungsi matematika seperti **trigonometri**,
**logaritmik**, dan lain-lain.

Pada *section* `3.1.1` kita telah mendefinisikan *objects* `a` dan `b`,
maka kita bisa lakukan perintah sebagai berikut:

``` r
a + b
```

    ## [1] 14

``` r
a / b
```

    ## [1] 0.75

``` r
c = a * b
c
```

    ## [1] 48

``` r
sin(c)
```

    ## [1] -0.7682547

``` r
log(a+b/c)
```

    ## [1] 1.819158

### 3.1.3 Operasi Relasi dan *Logical* (*Boolean*)

Pada *section* **1.5** poin 3, kita telah mengetahui operator relasi
seperti `==`, `>`, `<`, `<=`, `>=`, dan `!=`. Hasil dari operator relasi
ini adalah *logical value* (**TRUE** atau **FALSE**).

*Logical value* yang dihasilkan memiliki sifat sebagai berikut:

1.  `TRUE`, berarti **benar**. Bisa disingkat menjadi `T`. Tidak bisa
    ditulis dalam huruf kecil (harus kapital).
2.  `FALSE`, berarti **salah**. Bisa disingkat menjadi `F`. Tidak bisa
    ditulis dalam huruf kecil (harus kapital).

*Operator logical* yang biasa digunakan di **R** antara lain:

1.  `&`: **AND**
2.  `|`: **OR**
3.  `!`: **NOT**

Contoh:

``` r
pernyataan_1 = T
pernyataan_2 = F

!pernyataan_1
```

    ## [1] FALSE

``` r
pernyataan_1 & pernyataan_2
```

    ## [1] FALSE

``` r
pernyataan_1 | pernyataan_2
```

    ## [1] TRUE

### 3.1.4 *If Conditional*

Mungkin teman-teman bertanya-tanya:

> Apa sih gunanya *logical value* dan *logical operator*?

*Logical value* merupakan unsur utama saat kita hendak membuat fungsi
*conditional* dan *looping*. Masih ingat fungsi di **Ms. Excel** untuk
membuat *conditional*? *Nah*, mirip pengerjaannya di **R**.

Setidaknya ada tiga fungsi *conditional* di **R**, yakni:

1.  `ifelse()`: bawaan dari *package* `base`.
2.  `if_else()`: fungsi dari *package* `dplyr` (perlu di- *install* dulu
    *package*-nya).
3.  `case_when()`: fungsi dari *package* `dplyr` (perlu di- *install*
    dulu *package*-nya).

Apa perbedaan ketiganya?

`ifelse()` dengan `if_else()` berdasarkan pengalaman saya tidak ada
perbedaannya. Selama ini saya cukup memilih salah satu saja.

Sedangkan `case_when()` digunakan bersamaan dengan *pipe* `%>%` pada
saat *tidying data*. Berguna saat kita hendak mem- *vector*-kan
*conditional*.

> Masih bingung?

Saya akan bahas fungsi `ifelse()` dulu *yah*. Pembahasan mengenai
`case_when()` akan saya jelaskan pada *section* khusus mengenai
`tidyverse`.

Contoh paling mudah untuk *conditional* seperti ini:

``` r
a = 10
b = 10 + sin(pi/3)

ifelse(a < b, 'hari ini cerah','hari ini mendung')
```

    ## [1] "hari ini cerah"

``` r
ifelse(a == b, 'sama-sama','tidak bersama')
```

    ## [1] "tidak bersama"

## 3.2 Bekerja dengan data

Pada *section* `2.1.2` telah dijelaskan beberapa struktur data di **R**,
sekarang kita akan melihat bagaimana bentuk *real*-nya di **R**.

Untuk data berbentuk `list`, akan saya jelaskan sekalian bersamaan
dengan materi `tidyverse` *yah*.

### 3.2.1 Single Value

Contoh:

``` r
a = 100
x = 50
z = 'Indonesia'
```

### 3.2.2 *Vector*

*Vector* didefinisikan dengan menggunakan perintah `c()`.

Contoh:

``` r
tinggi_badan = c(164,149,180,184,153,90,139,199,186,158,197)
tinggi_badan
```

    ##  [1] 164 149 180 184 153  90 139 199 186 158 197

#### 3.2.2.1 Elemen *Vector*

Ada yang sadar *gak* dengan tanda `[1]` setiap kali kita *running* suatu
skrip di **R**.

Apa *sih* artinya?

Itu adalah tanda posisi pertama dari *vector*. Tanda `[]` digunakan
untuk memanggil isi *vector* di posisi tertentu. Istilah kerennya adalah
*subset* dari suatu *vector*.

Contoh:

``` r
tinggi_badan[1]
```

    ## [1] 164

``` r
tinggi_badan[7]
```

    ## [1] 139

``` r
tinggi_badan[10]
```

    ## [1] 158

``` r
tinggi_badan[3:5]
```

    ## [1] 180 184 153

``` r
tinggi_badan[c(1,7,10)]
```

    ## [1] 164 139 158

``` r
tinggi_badan[-c(1,7,10)] #pengeculian
```

    ## [1] 149 180 184 153  90 199 186 197

#### 3.2.2.2 Operasi Aritmatika Pada *Vector*

*Vector* yang berupa numerik bisa dilakukan operasi aritmatik.

Contoh:

``` r
status = (tinggi_badan - 100)/50
status
```

    ##  [1]  1.28  0.98  1.60  1.68  1.06 -0.20  0.78  1.98  1.72  1.16  1.94

#### 3.2.2.3 Fungsi Pada *Vector*

*Vector* berupa numerik juga bisa dikenakan fungsi perhitungan seperti:

``` r
max(tinggi_badan) # memperoleh nilai maksimum x
```

    ## [1] 199

``` r
min(tinggi_badan) # memperoleh nilai minimum x
```

    ## [1] 90

``` r
range(tinggi_badan) # memperoleh range vektor x
```

    ## [1]  90 199

``` r
length(tinggi_badan) # memperoleh jumlah vektor x
```

    ## [1] 11

``` r
sum(tinggi_badan) # memperoleh total penjumlahan vektor x
```

    ## [1] 1799

``` r
mean(tinggi_badan) # memperoleh nilai mean vektor x
```

    ## [1] 163.5455

``` r
sd(tinggi_badan) # standar deviasi vektor x
```

    ## [1] 31.5194

``` r
var(tinggi_badan) # varian vektor x
```

    ## [1] 993.4727

``` r
sort(tinggi_badan) # mengurutkan elemen vektor x dari yang terbesar
```

    ##  [1]  90 139 149 153 158 164 180 184 186 197 199

#### 3.2.2.4 Fungsi Spesial Pada *Vector*

Ada satu fungsi khusus yang sering saya pakai, yakni: `summary()`.

``` r
summary(tinggi_badan)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    90.0   151.0   164.0   163.5   185.0   199.0

#### 3.2.2.5 *Generating Sequences*

*Sequences* atau deret bisa kita bangun menggunakan **R** dengan dua
cara:

1.  Menggunakan `:`.
2.  Menggunakan fungsi `seq()`.

Contoh:

``` r
nomor_1 = c(1:10)
nomor_1
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
nomor_2 = seq(1,10,0.4) # generating sequence dari 1 hingga 10 dengan jeda 0.4
nomor_2
```

    ##  [1] 1.0 1.4 1.8 2.2 2.6 3.0 3.4 3.8 4.2 4.6 5.0 5.4 5.8 6.2 6.6 7.0 7.4
    ## [18] 7.8 8.2 8.6 9.0 9.4 9.8

> Apa sih gunanya deret?

Percayalah, suatu saat nanti deret bisa digunakan untuk membantu
perhitungan atau analisa kita. Seolah-olah berperan sebagai **katalis**
pada reaksi kimia.

# _to be continued_
-----

# Referensi

1.  [Metode Numerik Menggunakan R Untuk Teknik
    Lingkungan](https://bookdown.org/moh_rosidi2610/Metode_Numerik/),
    Mohammad Rosidi: R bookdown.
2.  [Cara Install R di
    Android](https://passingthroughresearcher.wordpress.com/2019/07/30/install-r-3-5-2-di-android/),
    Ikang Fadhli personal blog.
3.  [Install R base for
    Windows](https://cran.r-project.org/bin/windows/base/).
4.  [Install R Studio](https://rstudio.com/products/rstudio/download/).
5.  [R Studio Cloud](https://rstudio.cloud/).
6.  [Bookdown, e-book from R Markdown](https://bookdown.org/).
7.  [Menggunakan R Studio Cloud di Android
    browser](https://passingthroughresearcher.wordpress.com/2019/11/13/oleh-oleh-pelatihan-hari-kedua-r-studio-cloud/).
8.  [NOMNOML: How to make diagram in
    R](https://cran.r-project.org/web/packages/nomnoml/index.html).
