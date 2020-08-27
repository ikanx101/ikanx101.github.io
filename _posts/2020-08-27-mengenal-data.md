---
date: 2020-08-27T09:10:00-04:00
title: "Mengenal Data dan Pengelompokannya"
categories:
  - Blog
tags:
  - Data
  - Quantitative
  - Qualitative
  - Primer
  - Sekunder
  - Survey
  - R
---

Mungkin istilah **data** menjadi sangat populer belakangan ini. Tapi,
sebenarnya apa *sih* data itu? Salah satu definisi yang paling sering
saya gunakan adalah:

> Data adalah *representasi faktual dari suatu observasi*.

Data itu sendiri bisa dikelompokkan sesuai dengan tipe atau
karakteristiknya. Kali ini saya akan coba membahas 3 pengelompokkan data
sesuai dengan cara kita berinteraksi dengan data.

## Pengelompokan Pertama

Secara statistika, kita bisa mengelompokan data berdasarkan tipenya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2020-08-27-mengenal-data_files/figure-gfm/unnamed-chunk-1-1.png" width="60%" style="display: block; margin: auto;" />

1.  Data kualitatif: adalah data yang tidak bisa dilakukan operasi
    aritmatika (penjumlahan, pengurangan, pembagian, dan perkalian).
    Data seperti ini bisa juga disebut sebagai **data kategorik**.

<!-- end list -->

  - **Nominal**; Representasi dari sesuatu. Contoh: data seperti
    `gender`. Misalkan angka `1` saya tulis sebagai representasi dari
    `pria` dan `2` sebagai `wanita`.
  - **Ordinal**; Urutan dari data menjadi penting. Contoh: skala
    *likert*, misalkan angka `1 - 6` sebagai representasi dari tingkat
    kesukaan atau kesetujuan (sangat suka sampai sangat tidak suka).

<!-- end list -->

2.  Data kuantitatif: adalah data yang bisa dilakukan operasi aritmatika
    (penjumlahan, pengurangan, pembagian, dan perkalian). Data seperti
    ini, kita akan sebut sebagai **data numerik**.

<!-- end list -->

  - **Diskrit**; bilangan bulat (*integer*). Contoh: banyaknya anak,
    banyaknya karyawan, dll.
  - **Kontinu**; bilangan *real* (mengandung koma). Contoh: tinggi
    badan, berat badan, dll.

### Apa sih gunanya kita mengetahui suatu data termasuk ke dalam kualitatif atau kuantitatif?

Dengan mengetahui tipe data yang kita miliki, kita bisa dengan lebih
baik memahami dan memilih analisa yang tepat bagi data tersebut.

Contoh: Suatu waktu rekan saya pernah berujar bahwa: `rata-rata peserta
webinar hari ini adalah laki-laki`.

Percaya atau tidak, sebenarnya pernyataan teman saya tersebut adalah
pernyataan yang salah.

*Kok bisa?*

Data berupa `gender` termasuk ke dalam data kualitatif yakni nominal.
Ingat kembali bahwa data bentuk kualitatif tidak bisa kita lakukan
operasi aritmatika\! Sedangkan dalam menghitung rata-rata, kita
melakukan penambahan dan pembagian.

  
![rata-rata =
\\frac{\\sum{x\_i}}{n}](https://latex.codecogs.com/png.latex?rata-rata%20%3D%20%5Cfrac%7B%5Csum%7Bx_i%7D%7D%7Bn%7D
"rata-rata = \\frac{\\sum{x_i}}{n}")  

Masih belum paham? Oke, saya berikan ilustrasi *yah*. Misalkan dalam
suatu webinar ada `7` orang laki-laki dan `4` orang perempuan. Jika saya
menuliskan `1` untuk laki-laki dan `2` untuk perempuan, maka kalau saya
(paksakan) untuk menghitung rata-ratanya:

  
![rata-rata = \\frac{(7\*1) + (4\*2)}{7+4} = \\frac{7+8}{11}
\\approx 1.36](https://latex.codecogs.com/png.latex?rata-rata%20%3D%20%5Cfrac%7B%287%2A1%29%20%2B%20%284%2A2%29%7D%7B7%2B4%7D%20%3D%20%5Cfrac%7B7%2B8%7D%7B11%7D%20%5Capprox%201.36
"rata-rata = \\frac{(7*1) + (4*2)}{7+4} = \\frac{7+8}{11} \\approx 1.36")  

Didapatkan rata-rata sebesar `1.36`. Jika saya kembalikan ke data
aslinya dimana `1` untuk laki-laki dan `2` untuk perempuan, lalu apa
arti dari nilai `1.36`?

> Apakah laki-laki yang agak ke-perempuan-an atau perempuan yang terlalu
> ke-laki-laki-an?

Oleh karena itu menghitung rata-rata dari data kualitatif tidak akan ada
artinya. Pun hal yang sama dengan menghitung rata-rata dari skala
*likert*. Hasil yang berupa angka yang mengandung koma tidak bisa
diinterpretasikan secara langsung.

Oleh karena itu, data kualitatif akan lebih baik jika dihitung modusnya.
Istilah sehari-harinya adalah menghitung siapa yang menjadi mayoritas
dari data tersebut.

> Jadi, yang benar adalah **mayoritas** peserta webinar adalah
> laki-laki.

-----

## Pengelompokan Kedua

Berikutnya adalah pengelompokan data berdasarkan sumbernya.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2020-08-27-mengenal-data_files/figure-gfm/unnamed-chunk-2-1.png" width="60%" style="display: block; margin: auto;" />

Data primer adalah data yang berasal dari sumber pertama. Sebagai contoh
adalah data yang kita himpun sendiri dari hasil interview menggunakan
quesioner (survey), data yang kita ambil dari mesin atau data hasil *web
scrape*.

Data sekunder adalah data yang berasal dari sumber data lain yang sudah
pernah diolah (atau minimal sudah dibersihkan - *pre-processing*).
Contohnya adalah data kependudukan hasil sensus BPS, laporan absensi
karyawan, atau data Covid-19 yang tersedia di *website* resmi
pemerintah.

### Pertanyaannya: Kapan kita menggunakan data primer? Kapan kita menggunakan data sekunder?

Mungkin pertanyaan ini simpel tapi percayalah setiap kali saya
memberikan *training* *basic statistics* hanya sedikit sekali *trainee*
yang bisa menjawabnya.

*Lalu apa jawabannya?*

> Kita akan menggunakan data primer saat data sekunder tidak ada\!

*Nah lho\!? Kok gitu?*

Sejujurnya mencari data primer itu relatif sulit. Setidaknya kita
membutuhkan waktu, tenaga, dan biaya untuk mencari data langsung dari
sumbernya. Contoh, saya ingin mencari tahu berapa banyak orang yang
teridentifikasi COVID-19 di Bekasi. Alih-alih saya datang ke semua RS
yang ada di Bekasi, saya cukup cek saja *website* [Pikobar Jawa
Barat](https://pikobar.jabarprov.go.id/).

Jadi, jika data sekundernya sudah tersedia kita bisa
**mempertimbangkan** untuk memakai data tersebut daripada mengambil data
primer. **TAPI** jika ternyata karakteristik data yang kita mau cari
tersebut `sangat dinamis dan cepat berubah` **ATAU** `ada perbedaan
kondisi, situasi atau limitasi` maka kita harus **mempertimbangkan**
untuk mencari data primer dan tidak menggunakan data sekunder.

Keputusan ada di tangan kita sebagai peneliti *yah*\!

-----

## Pengelompokan Ketiga

Di dalam dunia *data science* (setidaknya saat kita bekerja dengan
**R**), ada beberapa tipe data yang sering digunakan. Secara hierarki,
bisa diurutkan sebagai berikut:

  
![character \> numeric \> integer \>
logical](https://latex.codecogs.com/png.latex?character%20%3E%20numeric%20%3E%20integer%20%3E%20logical
"character \> numeric \> integer \> logical")  
Saya coba jelaskan satu persatu *yah*:

1.  `character`: merupakan tipe data berupa karakter atau `string`.
    Semua data bisa dilihat sebagai `character`. Oleh karena itu, secara
    hierarki tipe data ini ditempatkan di urutan paling atas. Namun,
    data tipe ini tidak bisa dilakukan operasi aritmatika *yah*.
2.  `numeric`: merupakan tipe data angka berupa bilangan *real*. Kalau
    saya boleh bilang, tipe data ini mirip dengan data kuantitatif
    kontinu.
3.  `integer`: merupakan tipe data angka berupa bilangan bulat. Sekilas
    mirip dengan tipe data diskrit pada data kuantitatif. Namun di
    beberapa kondisi, tipe data ini bisa dijadikan data **kategorik**
    sehingga kita bisa sebut tipenya menjadi `factor`.
4.  `logical`: merupakan tipe data *boolean*. Hanya berisi `TRUE` atau
    `FALSE`. Tipe data ini sangat berguna saat kita melakukan *if
    conditional*, *looping*, atau membuat *regex* (*reguler
    expression*).

Selain tipe data, ada juga namanya struktur data, yakni dalam bentuk apa
data itu berwujud, yakni:

1.  *Single value*; satu objek yang berisi satu *value* saja.
2.  *Vector*; kumpulan dari beberapa *single value(s)* yang menjadi satu
    objek. Bayangkan sebagai satu buah kolom di *file Ms. Excel*.
3.  *Data frame* atau *tibble*; merupakan kumpulan dari beberapa
    *vectors* yang memiliki ukuran sama. Bayangkan sebagai satu tabel di
    *Ms. Excel* yang banyaknya baris di setiap kolom sama.
4.  *List*; merupakan bentuk struktur data yang sangat kompleks. Berisi
    *multiple data* dengan struktur bermacam-macam. Biasanya data dengan
    format `.json` memiliki struktur berupa *list*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2020-08-27-mengenal-data_files/figure-gfm/unnamed-chunk-3-1.png" width="60%" style="display: block; margin: auto;" />

### Apa gunanya kita mengetahui jenis dan struktur data di **R**?

Beberapa algoritma yang tersedia di *library* mengharuskan kita memiliki
*input* yang ter-standar, baik dari segi jenis dan strukturnya.

Dengan mengetahui jenis dan struktur data, kita bisa lebih mudah bekerja
dengan algoritma yang ada di *library*.

Contoh: algoritma analisa *simple linear regression* `lm()` memerlukan
input berupa `data.frame()` dengan masing-masing *variables* yang ada di
dalamnya berjenis *numeric*.
