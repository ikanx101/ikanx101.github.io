---
date: 2021-05-17T5:25:53-04:00
title: "Fenomena Matematis: BENFORD’S LAW"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Science
---

Setidaknya ada tiga fenomena matematis - statistik yang saya selalu
kagumi di dunia ini:

1.  **Distribusi Normal**; Konon katanya **hampir semua data di dunia
    ini** berdistribusi normal (berbentuk *bell curved*). Di beberapa
    kesempatan saya sempat membuktikan bahwa:
    1.  Mayoritas data statistik ***FIFA World Cup*** lalu berdistribusi
        normal.
    2.  Data rekapitulasi pemilu lalu berdistribusi normal.
    3.  Data [selisih gol di Premier
        League](https://ikanx101.com/blog/EPL-home-away/#bell-curve-pada-data-selisih-goal)
        berdistribusi normal.
    4.  Data kejadian alamiah seperti berat badan dan tinggi badan di
        suatu populasi penduduk berdistribusi normal.
2.  **Distribusi Pareto**; Jika distribusi normal saya temukan di
    kejadian-kejadian alamiah, maka data yang melibatkan suatu perlakuan
    atau *effort* berdistribusi pareto. Maksudnya bagaimana? Suatu
    ketika saya sempat menganalisa data performa karyawan di suatu
    perusahaan. Alih-alih berdistribusi normal, justru data tersebut
    berdistribusi pareto. Salah satu dugaan saya dulu adalah karena
    karyawan yang bekerja sudah benar-benar terseleksi dengan baik.
3.  ***Golden Ratio***; Konon semua keindahan yang ada di dunia ini
    mengikuti *golden ratio* sehingga orang berlomba-lomba untuk
    mengikutinya. Mulai dari ukuran televisi, kartu debit/kredit, dst.

------------------------------------------------------------------------

Pada saat sahur di hari terakhir puasa kemarin, saya menonton
*Docuseries* di **Netflix** berjudul ***Connected***. Pada salah satu
episode berjudul ***Digits***, saya dikenalkan kepada salah satu fenomena
matematis lainnya bernama: **Benford’s Law** atau yang biasa dikenal
sebagai ***First-Digit Law***.

> Ini bukanlah sebuah cocoklogi karena statusnya adalah LAW alias hukum
> dalam science.

Jadi setara dengan hukum-hukum lainnya seperti Hukum Newton, Hukum
Keppler, Hukum Gravitasi, dst.

Apa sih isinya?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/advance%20analysis/benford%20law/post_files/figure-gfm/unnamed-chunk-1-1.png" width="672" style="display: block; margin: auto;" />

Jadi jika kita memiliki suatu kumpulan data angka dan mengambil hanya
*digit* pertamanya saja, maka sebaran dari frekuensi digit pertama
tersebut akan mengikuti **Benford’s Law**.

Lantas apa kegunaan dari hukum ini? Mulai dari menemukan *fraud* di
perpajakan sampai mengecek keaslian suatu gambar.

Penasaran dengan hukum tersebut, sekarang saya akan mengecek dengan
data-data yang tersedia di publik. Apakah benar **Benford’s Law**
berlaku atau tidak.

Bagaimana caranya?

> Simpel, saya cukup menghitung frekuensi dari ***first digit*** saja.

------------------------------------------------------------------------

## Data Populasi Penduduk di Dunia 2020

Pertama-tama, saya mengambil data populasi penduduk per negara di dunia
dari situs
[*worldometers*](https://www.worldometers.info/world-population/population-by-country/).
Ada 235 negara yang ada pada data tersebut. Berikut adalah contoh 20
data negara dengan populasi terbanyak:

|  \# | Country (or dependency) | Population (2020) | Yearly Change | Net Change | Density (P/Km²) | Land Area (Km²) | Migrants (net) | Fert. Rate | Med. Age | Urban Pop % | World Share |
|----:|:------------------------|:------------------|:--------------|:-----------|:----------------|:----------------|:---------------|:-----------|:---------|:------------|:------------|
|   1 | China                   | 1,439,323,776     | 0.39 %        | 5,540,090  | 153             | 9,388,211       | -348,399       | 1.7        | 38       | 61 %        | 18.47 %     |
|   2 | India                   | 1,380,004,385     | 0.99 %        | 13,586,631 | 464             | 2,973,190       | -532,687       | 2.2        | 28       | 35 %        | 17.70 %     |
|   3 | United States           | 331,002,651       | 0.59 %        | 1,937,734  | 36              | 9,147,420       | 954,806        | 1.8        | 38       | 83 %        | 4.25 %      |
|   4 | Indonesia               | 273,523,615       | 1.07 %        | 2,898,047  | 151             | 1,811,570       | -98,955        | 2.3        | 30       | 56 %        | 3.51 %      |
|   5 | Pakistan                | 220,892,340       | 2.00 %        | 4,327,022  | 287             | 770,880         | -233,379       | 3.6        | 23       | 35 %        | 2.83 %      |
|   6 | Brazil                  | 212,559,417       | 0.72 %        | 1,509,890  | 25              | 8,358,140       | 21,200         | 1.7        | 33       | 88 %        | 2.73 %      |
|   7 | Nigeria                 | 206,139,589       | 2.58 %        | 5,175,990  | 226             | 910,770         | -60,000        | 5.4        | 18       | 52 %        | 2.64 %      |
|   8 | Bangladesh              | 164,689,383       | 1.01 %        | 1,643,222  | 1,265           | 130,170         | -369,501       | 2.1        | 28       | 39 %        | 2.11 %      |
|   9 | Russia                  | 145,934,462       | 0.04 %        | 62,206     | 9               | 16,376,870      | 182,456        | 1.8        | 40       | 74 %        | 1.87 %      |
|  10 | Mexico                  | 128,932,753       | 1.06 %        | 1,357,224  | 66              | 1,943,950       | -60,000        | 2.1        | 29       | 84 %        | 1.65 %      |
|  11 | Japan                   | 126,476,461       | -0.30 %       | -383,840   | 347             | 364,555         | 71,560         | 1.4        | 48       | 92 %        | 1.62 %      |
|  12 | Ethiopia                | 114,963,588       | 2.57 %        | 2,884,858  | 115             | 1,000,000       | 30,000         | 4.3        | 19       | 21 %        | 1.47 %      |
|  13 | Philippines             | 109,581,078       | 1.35 %        | 1,464,463  | 368             | 298,170         | -67,152        | 2.6        | 26       | 47 %        | 1.41 %      |
|  14 | Egypt                   | 102,334,404       | 1.94 %        | 1,946,331  | 103             | 995,450         | -38,033        | 3.3        | 25       | 43 %        | 1.31 %      |
|  15 | Vietnam                 | 97,338,579        | 0.91 %        | 876,473    | 314             | 310,070         | -80,000        | 2.1        | 32       | 38 %        | 1.25 %      |
|  16 | DR Congo                | 89,561,403        | 3.19 %        | 2,770,836  | 40              | 2,267,050       | 23,861         | 6.0        | 17       | 46 %        | 1.15 %      |
|  17 | Turkey                  | 84,339,067        | 1.09 %        | 909,452    | 110             | 769,630         | 283,922        | 2.1        | 32       | 76 %        | 1.08 %      |
|  18 | Iran                    | 83,992,949        | 1.30 %        | 1,079,043  | 52              | 1,628,550       | -55,000        | 2.2        | 32       | 76 %        | 1.08 %      |
|  19 | Germany                 | 83,783,942        | 0.32 %        | 266,897    | 240             | 348,560         | 543,822        | 1.6        | 46       | 76 %        | 1.07 %      |
|  20 | Thailand                | 69,799,978        | 0.25 %        | 174,396    | 137             | 510,890         | 19,444         | 1.5        | 40       | 51 %        | 0.90 %      |

20 Data Negara dengan Populasi Terbanyak

Jika saya hitung *first digit* dari angka populasi pernegara, lalu saya
hitung frekuensinya. Saya dapatkan grafik sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/advance%20analysis/benford%20law/post_files/figure-gfm/unnamed-chunk-3-1.png" width="672" style="display: block; margin: auto;" />

Ternyata hasilnya mengagetkan! Temuan saya tersebut hampir menyerupai
**Benford’s Law**.

## Luas Area Negara (dalam km<sup>2</sup>)

Sekarang saya coba iseng menggunakan data luas area setiap negara yang
ada di atas. Jika saya hitung *first digit* dari angka populasi
pernegara, lalu saya hitung frekuensinya. Saya dapatkan grafik sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/advance%20analysis/benford%20law/post_files/figure-gfm/unnamed-chunk-4-1.png" width="672" style="display: block; margin: auto;" />

Ternyata data luas area setiap negara mengikuti **Benford’s Law**.

## Data COVID 19

Saya masih penasaran, kenapa kedua data di atas mengikuti **Benford’s
Law**? Apakah ini kesengajaan? *Hehehe*.

Sekarang saya akan gunakan data Covid 19 yang dihimpun di situs
[Wikipedia
berikut](https://en.wikipedia.org/wiki/Template:COVID-19_pandemic_data).
Per 16 Mei 2021 pukul 11:00 WIB, ada 242 baris data per negara.

Saya akan mencoba mengecek apakah data *confirmed case* per negara
mengikuti **Benford’s Law**?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/advance%20analysis/benford%20law/post_files/figure-gfm/unnamed-chunk-5-1.png" width="672" style="display: block; margin: auto;" />

Ternyata data Covid 19 *confirmed cases* hampir mengikuti **Benford’s
Law**.

Bagaimana dengan data kematian akibat Covid 19?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/advance%20analysis/benford%20law/post_files/figure-gfm/unnamed-chunk-6-1.png" width="672" style="display: block; margin: auto;" />

Ternyata data Covid 19 *deaths* hampir mengikuti **Benford’s Law**.

## Data Hasil Pemilu Presiden 2019

Kali ini saya mau menggunakan data lokal di Indonesia, yakni data hasil
pemilu presiden 2019 yang direkap di [situs
KPU](https://pemilu2019.kpu.go.id/#/ppwp/hitung-suara/).

Saya akan menggunakan data hitung suara untuk kedua pasangan calon
presiden yang berkontestasi pada saat itu. Bagaimana hasilnya?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/advance%20analysis/benford%20law/post_files/figure-gfm/unnamed-chunk-7-1.png" width="672" style="display: block; margin: auto;" />

Ternyata hasilnya juga mendekati **Benford’s Law**.

## Data *Sales Retailer*

Tahun lalu, saya sempat mendapatkan [data *sales* produk-produk yang
dijual di salah satu
*retail*](https://ikanx101.com/blog/minimarket-bekasi/) yang dimiliki
bersama oleh beberapa teman saya. Karena penasaran, saya coba cek data
harga semua barang-barang yang ditransaksikan selama bulan Januari 2020.
Apakah memenuhi **Benford’s Law** atau tidak?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/advance%20analysis/benford%20law/post_files/figure-gfm/unnamed-chunk-8-1.png" width="672" style="display: block; margin: auto;" />

Sekali lagi, data harga ternyata hampir mengikuti **Benford’s Law**.

Begitu pula dengan data total transaksi per konsumen, saya dapatkan:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/advance%20analysis/benford%20law/post_files/figure-gfm/unnamed-chunk-9-1.png" width="672" style="display: block; margin: auto;" />

------------------------------------------------------------------------

## *So what?*

Dari penjelasan yang saya dapatkan, jika kita memiliki suatu data yang
tidak mengikuti **Benford’s Law**, maka bisa jadi data tersebut sudah
pernah dimodifikasi sebelumnya. Kelak ini yang akan dijadikan salah satu
indikasi terjadinya *fraud*.

Bagaimana cara melihat indikasinya? Teman-teman coba tonton saja
*docuseries*-nya di **Netflix** lalu perhatikan saat sang narasumber
menjelaskan bagaimana menentukan foto *fake* menggunakan **Benford’s
Law**.

------------------------------------------------------------------------

## ***Updates***: Jumlah Ayat dalam Setiap Surat di Al Qur’an

Sebagai penutup rasa penasaran saya, saya mau mencoba apakah jumlah ayat
dalam Al Qur’an juga memenuhi **Benford’s Law**?

Mengambil sumber dari rekapan [blog
berikut](https://blog.miftahussalam.com/jumlah-ayat-dalam-alquran/) ini,
saya coba menghitungnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/advance%20analysis/benford%20law/post_files/figure-gfm/unnamed-chunk-10-1.png" width="672" style="display: block; margin: auto;" />

***MasyaAllah*** ternyata hampir mengikuti **Benford’s Law**.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
