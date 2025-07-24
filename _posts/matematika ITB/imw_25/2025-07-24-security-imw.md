---
date: 2025-07-24T14:24:00-04:00
title: "Optimization Story: Optimisasi Antrian Lane Security Checking di Bandara"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Linear Programming
  - Integer Linear Programming
  - Optimization Story
  - Security
  - Airport
  - Security checking
---

## Pendahuluan

Pada pertengahan Juli 2025 ini, saya berkesempatan mengikuti *event*
***Industrial Mathematics Week 2025*** (IMW 2025) di program studi
Matematika ITB. *Event* ini berlangsung selama 5 hari di mana 2 hari
pertama diisi dengan seminar dan 3 hari sisanya diisi dengan *workshop*
menyelesaikan masalah *real*. Topik IMW pada tahun ini menitikberatkan
pada optimisasi, *vector-borne desease*, dan *deep learning*.

Ada tiga masalah yang bisa dipilih untuk dikerjakan secara berkelompok
selama *workshop*, yakni:

1.  Optimisasi portofolio saham,
2.  Penanganan penyebaran penyakit *vector-borne*, dan
3.  Optimisasi antrian *lane security checking* di bandara.

Saya pribadi memilih *problem* ketiga karena lebih dekat dengan
pekerjaan saya sehari-hari. Singkat cerita, kelompok saya lebih memilih
mengerjakan dengan metode *deep learning* tapi saya coba membuat satu
model lain menggunakan *linear programming* sederhana.

Model ini sempat saya presentasikan di hari terakhir IMW dan mendapatkan
sambutan baik dari si empunya *problem* sehingga diskusi berlangsung
setelah *event* berakhir secara *online*.

Begini masalahnya:

------------------------------------------------------------------------

## Masalah

Di suatu bandara, setiap kali *passengers* hendak masuk ke *waiting
lounge*, mereka harus melewati *security checking*. Petugas *security*
terbatas sehingga *lane* yang tersedia hanya ada 17 *lanes* saja.
Masing-masing *security* memiliki *service rate* tertentu.

*Service rate* didefinisikan sebagai berapa banyak *passengers* yang
bisa diproses oleh seorang petugas *security* selama rentang waktu
tertentu.

Perhatikan ilustrasi ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/imw_25/IMG_1061.jpeg)

Setiap baris menandakan rentang waktu per 5 menit.

Pada rentang waktu 1, ada 100 orang *passengers* yang masuk ke area
*security checking*. Oleh karena *service rate*-nya adalah 15 dan *lane*
yang buka ada 3, maka *processed passengers* maksimum adalah sebesar 45
orang. Di akhir, akan ada sisa 55 orang *unprocessed passengers*.

Kemudian pada rentang waktu 2, ada 90 orang *passengers* yang masuk ke
area plus 55 orang *unprocessed passengers* dari rentang waktu 1.
Sehingga total *passengers* yang harus diproses adalah sebesar 145
orang. Oleh karena *service rate*-nya adalah 15 dan *lane* yang buka ada
2, maka *processed passengers* maksimum adalah sebesar 30 orang. Di
akhir, akan ada sisa 115 orang *unprocessed passengers*.

Kemudian pada rentang waktu 3, ada 212 orang *passengers* yang masuk ke
area plus 115 orang *unprocessed passengers* dari rentang waktu 2.
Sehingga total *passengers* yang harus diproses adalah sebesar 327
orang. Oleh karena *service rate*-nya adalah 15 dan *lane* yang buka ada
5, maka *processed passengers* maksimum adalah sebesar 75 orang. Di
akhir, akan ada sisa 252 orang *unprocessed passengers*.

Begitu seterusnya hingga baris ke 12.

> Oleh karena antrian bersifat **FIFO** (***first in - first out***),
> artinya jika saya bisa mengoptimalkan berapa banyak lane yang terbuka,
> maka saya bisa **meminimumkan** *unprocessed passenger* sehingga waktu
> tunggu antrian akan kurang dari dua rentang waktu (kurang dari 10
> menit).

## *Modelling*

Pertama-tama saya akan definisikan *decision variables* dan beberapa
parameter berikut ini:

- ![i \in \mathbb{Z}^+, 1 \leq i \leq 12](https://latex.codecogs.com/svg.latex?i%20%5Cin%20%5Cmathbb%7BZ%7D%5E%2B%2C%201%20%5Cleq%20i%20%5Cleq%2012 "i \in \mathbb{Z}^+, 1 \leq i \leq 12")
  menandakan rentang waktu satu jam yang dibagi per 5 menit sehingga ada
  12 belas kelas.
- ![l_i \in \mathbb{Z}^+, 1 \leq i \leq 17](https://latex.codecogs.com/svg.latex?l_i%20%5Cin%20%5Cmathbb%7BZ%7D%5E%2B%2C%201%20%5Cleq%20i%20%5Cleq%2017 "l_i \in \mathbb{Z}^+, 1 \leq i \leq 17")
  menandakan berapa banyak *lane* dibuka pada waktu
  ![i](https://latex.codecogs.com/svg.latex?i "i").
- ![sr_i \in \mathbb{Z}^+](https://latex.codecogs.com/svg.latex?sr_i%20%5Cin%20%5Cmathbb%7BZ%7D%5E%2B "sr_i \in \mathbb{Z}^+")
  menandakan *mean service rate* semua *lane* pada waktu
  ![i](https://latex.codecogs.com/svg.latex?i "i").
  - Artinya: **rata-rata banyaknya penumpang yang bisa diperiksa oleh
    satu orang petugas selama rentang waktu 5 menit**.
  - *Service rate* ini akan dicari dari data yang diberikan.
- ![N_i \in \mathbb{Z}^+](https://latex.codecogs.com/svg.latex?N_i%20%5Cin%20%5Cmathbb%7BZ%7D%5E%2B "N_i \in \mathbb{Z}^+")
  menandakan berapa banyak penumpang yang datang ke *security check*
  pada waktu ![i](https://latex.codecogs.com/svg.latex?i "i").
- ![p_i \in \mathbb{Z}^+](https://latex.codecogs.com/svg.latex?p_i%20%5Cin%20%5Cmathbb%7BZ%7D%5E%2B "p_i \in \mathbb{Z}^+")
  menandakan berapa banyak penumpang yang **bisa dan selesai diproses**
  pada waktu ![i](https://latex.codecogs.com/svg.latex?i "i").
- ![u_i \in \mathbb{Z}^+](https://latex.codecogs.com/svg.latex?u_i%20%5Cin%20%5Cmathbb%7BZ%7D%5E%2B "u_i \in \mathbb{Z}^+")
  menandakan berapa banyak penumpang yang **tidak bisa diproses** pada
  waktu ![i](https://latex.codecogs.com/svg.latex?i "i").
  - Akibatnya jika
    ![u_i \> 0](https://latex.codecogs.com/svg.latex?u_i%20%3E%200 "u_i > 0")
    akan menambahkan banyaknya penumpang pada
    ![i+1](https://latex.codecogs.com/svg.latex?i%2B1 "i+1").
- ![\hat{N}\_i \in \mathbb{Z}^+](https://latex.codecogs.com/svg.latex?%5Chat%7BN%7D_i%20%5Cin%20%5Cmathbb%7BZ%7D%5E%2B "\hat{N}_i \in \mathbb{Z}^+")
  pada
  ![i \in \[2,12\]](https://latex.codecogs.com/svg.latex?i%20%5Cin%20%5B2%2C12%5D "i \in [2,12]")
  menandakan banyaknya penumpang *real* yang dilayani pada waktu
  ![i](https://latex.codecogs.com/svg.latex?i "i").
  - Perhatikan bahwa saat
    ![i=1](https://latex.codecogs.com/svg.latex?i%3D1 "i=1") kita
    dapatkan
    ![\hat{N}\_1 = N_1](https://latex.codecogs.com/svg.latex?%5Chat%7BN%7D_1%20%3D%20N_1 "\hat{N}_1 = N_1").
  - Sedangkan pada
    ![i \in \[2,12\]](https://latex.codecogs.com/svg.latex?i%20%5Cin%20%5B2%2C12%5D "i \in [2,12]"),
    jika
    ![u\_{i-1}\>0](https://latex.codecogs.com/svg.latex?u_%7Bi-1%7D%3E0 "u_{i-1}>0")
    maka
    ![\hat{N}\_i = N_i + u\_{i-1}](https://latex.codecogs.com/svg.latex?%5Chat%7BN%7D_i%20%3D%20N_i%20%2B%20u_%7Bi-1%7D "\hat{N}_i = N_i + u_{i-1}").

## Tujuan Optimisasi

Tujuan dari model optimisasi ini adalah **meminimalkan *lane* yang
dibuka dan *unprocessed passengers***.

Kelak akan dicoba beberapa *objective functions* dan akan dibandingkan
hasilnya.

## *Constraints*

Maksimal *lane* yang bisa dibuka setiap waktu
![i](https://latex.codecogs.com/svg.latex?i "i") adalah 17.

![l_i \leq 17, \space \forall i \in \[1,12\]](https://latex.codecogs.com/svg.latex?l_i%20%5Cleq%2017%2C%20%5Cspace%20%5Cforall%20i%20%5Cin%20%5B1%2C12%5D "l_i \leq 17, \space \forall i \in [1,12]")

Banyaknya *processed passengers* bisa jadi **kurang dari atau setara
dengan** *service rate* dikalikan dengan *lane* yang dibuka.

![p_i \leq sr_i \times l_i, \space \forall i \in \[1,12\]](https://latex.codecogs.com/svg.latex?p_i%20%5Cleq%20sr_i%20%5Ctimes%20l_i%2C%20%5Cspace%20%5Cforall%20i%20%5Cin%20%5B1%2C12%5D "p_i \leq sr_i \times l_i, \space \forall i \in [1,12]")

Banyaknya *unprocessed passengers* itu adalah banyaknya *passengers*
masuk dikurangi dengan *processed passengers*.

![u_i = \hat{N}\_i - p_i , \space \forall i \in \[1,12\]](https://latex.codecogs.com/svg.latex?u_i%20%3D%20%5Chat%7BN%7D_i%20-%20p_i%20%2C%20%5Cspace%20%5Cforall%20i%20%5Cin%20%5B1%2C12%5D "u_i = \hat{N}_i - p_i , \space \forall i \in [1,12]")

## Pencarian *Service Rate* (![sr_i](https://latex.codecogs.com/svg.latex?sr_i "sr_i"))

Salah satu pertanyaan terbesar pada masalah ini adalah bagaimana
mendekati nilai
![sr_i](https://latex.codecogs.com/svg.latex?sr_i "sr_i").

- Apakah ![sr_i](https://latex.codecogs.com/svg.latex?sr_i "sr_i")
  tergantung dari jam berapa petugas *lane* bekerja?
- Apakah ![sr_i](https://latex.codecogs.com/svg.latex?sr_i "sr_i")
  tergantung dari berapa banyak orang *passengers* yang datang?

Untuk menjawabnya, saya coba analisa sederhana *service rate* dari data
yang diberikan dan buat visualisasi sebagai berikut:

**Sebaran *Service Rate***

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/imw_25/draft_files/figure-commonmark/unnamed-chunk-2-1.png)

Berikut adalah hubungan antara *Service Rate* dan total *passengers*
yang masuk:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/imw_25/draft_files/figure-commonmark/unnamed-chunk-3-1.png)

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/imw_25/draft_files/figure-commonmark/unnamed-chunk-4-1.png)

Dari dua grafik yang ditampilkan di atas, kita melihat bahwa ada pola
yang mirip antara *service rate* dengan *total passengers* jika
disajikan dalam *timeline* yang sama. Dari sini kita bisa mengeliminasi
faktor *timeline* dan bisa menghubungkan langsung antara *service rate*
dan *total passengers*.

> Saat *passengers* yang masuk antrian membludak, *security manager*
> akan memaksa para petugas *lane* “mempercepat” pekerjaannya
> (meningkatkan *service rate*-nya). Namun *service rate* akan
> **mentok** di suatu nilai tertentu dan tak akan bisa naik lagi
> (manusiawi).

### Hubungan *Service Rate* dengan *Total Passengers*

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/imw_25/draft_files/figure-commonmark/unnamed-chunk-5-1.png)

Saya bisa membuat model *machine learning* prediksinya sebagai berikut:

### Model Hubungan *Service Rate* dengan *Total Passengers*

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/imw_25/draft_files/figure-commonmark/unnamed-chunk-6-1.png)

Model ini menghasilkan *mean absolute error* sebesar 0.409766.

## Dua *Objective Functions* yang Dicoba

Ada dua skenario yang mungkin terjadi:

### Skenario I

*Security manager* berkata:

> Jangan sampai ada antrian yang panjang. ***Atur saja*** berapa *lane*
> yang dibuka atau ditutup!

![\min{\sum\_{i=1}^{12}{ u_i }}](https://latex.codecogs.com/svg.latex?%5Cmin%7B%5Csum_%7Bi%3D1%7D%5E%7B12%7D%7B%20u_i%20%7D%7D "\min{\sum_{i=1}^{12}{ u_i }}")

### Skenario II

*Security manager* berkata:

> Dengan petugas seminimal mungkin, ***pokoknya saya tidak mau tahu***,
> antrian yang ada tidak boleh panjang!

![\min{\sum\_{i=1}^{12}{ (u_i + 11 \times l_i) }}](https://latex.codecogs.com/svg.latex?%5Cmin%7B%5Csum_%7Bi%3D1%7D%5E%7B12%7D%7B%20%28u_i%20%2B%2011%20%5Ctimes%20l_i%29%20%7D%7D "\min{\sum_{i=1}^{12}{ (u_i + 11 \times l_i) }}")

<div style="font-size: 90%;">

Nilai 11 adalah bobot: **seorang petugas *lane* setara dengan 11 orang
*passengers* dalam selang waktu
![i](https://latex.codecogs.com/svg.latex?i "i")**.

Nilai ini diambil dari *expected service rate* data.

### Semua *Constraints* yang Ada

![l_i \leq 17, \space \forall i \in \[1,12\]](https://latex.codecogs.com/svg.latex?l_i%20%5Cleq%2017%2C%20%5Cspace%20%5Cforall%20i%20%5Cin%20%5B1%2C12%5D "l_i \leq 17, \space \forall i \in [1,12]")

![p_i \leq sr_i \times l_i, \space \forall i \in \[1,12\]](https://latex.codecogs.com/svg.latex?p_i%20%5Cleq%20sr_i%20%5Ctimes%20l_i%2C%20%5Cspace%20%5Cforall%20i%20%5Cin%20%5B1%2C12%5D "p_i \leq sr_i \times l_i, \space \forall i \in [1,12]")

![u_i = \hat{N}\_i - p_i , \space \forall i \in \[1,12\]](https://latex.codecogs.com/svg.latex?u_i%20%3D%20%5Chat%7BN%7D_i%20-%20p_i%20%2C%20%5Cspace%20%5Cforall%20i%20%5Cin%20%5B1%2C12%5D "u_i = \hat{N}_i - p_i , \space \forall i \in [1,12]")

## *Solving the Model*

Pencarian solusi optimal dari model menggunakan **R** dengan metode
*simplex* di `library(ompr)`:

    To cite package 'ompr' in publications use:

      Schumacher D (2023). _ompr: Model and Solve Mixed Integer Linear
      Programs_. R package version 1.0.4,
      <https://github.com/dirkschumacher/ompr>.

    A BibTeX entry for LaTeX users is

      @Manual{,
        title = {ompr: Model and Solve Mixed Integer Linear Programs},
        author = {Dirk Schumacher},
        year = {2023},
        note = {R package version 1.0.4},
        url = {https://github.com/dirkschumacher/ompr},
      }

## Hasil Model Skenario I

<div id="juvsqfccbe" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#juvsqfccbe table {
  font-family: Lato, system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#juvsqfccbe thead, #juvsqfccbe tbody, #juvsqfccbe tfoot, #juvsqfccbe tr, #juvsqfccbe td, #juvsqfccbe th {
  border-style: none;
}
&#10;#juvsqfccbe p {
  margin: 0;
  padding: 0;
}
&#10;#juvsqfccbe .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 3px;
  border-top-color: #FFFFFF;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#juvsqfccbe .gt_title {
  color: #333333;
  font-size: 24px;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#juvsqfccbe .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#juvsqfccbe .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#juvsqfccbe .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#juvsqfccbe .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#juvsqfccbe .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#juvsqfccbe .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#juvsqfccbe .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#juvsqfccbe .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#juvsqfccbe .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#juvsqfccbe .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#juvsqfccbe .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#juvsqfccbe .gt_row {
  padding-top: 7px;
  padding-bottom: 7px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #F6F7F7;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#juvsqfccbe .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#juvsqfccbe .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#juvsqfccbe .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#juvsqfccbe .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#juvsqfccbe .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#juvsqfccbe .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#juvsqfccbe .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#juvsqfccbe .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_striped {
  background-color: #FAFAFA;
}
&#10;#juvsqfccbe .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#juvsqfccbe .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#juvsqfccbe .gt_sourcenote {
  font-size: 12px;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#juvsqfccbe .gt_left {
  text-align: left;
}
&#10;#juvsqfccbe .gt_center {
  text-align: center;
}
&#10;#juvsqfccbe .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#juvsqfccbe .gt_font_normal {
  font-weight: normal;
}
&#10;#juvsqfccbe .gt_font_bold {
  font-weight: bold;
}
&#10;#juvsqfccbe .gt_font_italic {
  font-style: italic;
}
&#10;#juvsqfccbe .gt_super {
  font-size: 65%;
}
&#10;#juvsqfccbe .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#juvsqfccbe .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#juvsqfccbe .gt_indent_1 {
  text-indent: 5px;
}
&#10;#juvsqfccbe .gt_indent_2 {
  text-indent: 10px;
}
&#10;#juvsqfccbe .gt_indent_3 {
  text-indent: 15px;
}
&#10;#juvsqfccbe .gt_indent_4 {
  text-indent: 20px;
}
&#10;#juvsqfccbe .gt_indent_5 {
  text-indent: 25px;
}
&#10;#juvsqfccbe .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#juvsqfccbe div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

| <em>Optimized Lane Planning</em> |         |           |      |           |             |
|----------------------------------|---------|-----------|------|-----------|-------------|
| <em>Objective function I</em>    |         |           |      |           |             |
| n_real                           | n_total | s_rate    | lane | processed | unprocessed |
| 100                              | 100     | 10.841956 | 10   | 100       | 0           |
| 90                               | 90      | 10.059110 | 9    | 90        | 0           |
| 212                              | 212     | 14.722498 | 15   | 212       | 0           |
| 43                               | 43      | 5.955611  | 8    | 43        | 0           |
| 111                              | 111     | 11.577131 | 10   | 111       | 0           |
| 65                               | 65      | 7.764831  | 9    | 65        | 0           |
| 34                               | 34      | 5.449367  | 7    | 34        | 0           |
| 143                              | 143     | 13.087148 | 11   | 143       | 0           |
| 98                               | 98      | 10.694036 | 10   | 98        | 0           |
| 45                               | 45      | 6.088485  | 8    | 45        | 0           |
| 65                               | 65      | 7.764831  | 9    | 65        | 0           |
| 32                               | 32      | 5.353371  | 6    | 32        | 0           |

</div>

                     [,1]
    min_lane     6.000000
    max_lane    15.000000
    mean_lane    9.333333
    total_antri  0.000000

## Hasil Model Skenario II

<div id="twhtbmafnk" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#twhtbmafnk table {
  font-family: Lato, system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#twhtbmafnk thead, #twhtbmafnk tbody, #twhtbmafnk tfoot, #twhtbmafnk tr, #twhtbmafnk td, #twhtbmafnk th {
  border-style: none;
}
&#10;#twhtbmafnk p {
  margin: 0;
  padding: 0;
}
&#10;#twhtbmafnk .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 3px;
  border-top-color: #FFFFFF;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#twhtbmafnk .gt_title {
  color: #333333;
  font-size: 24px;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#twhtbmafnk .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#twhtbmafnk .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#twhtbmafnk .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#twhtbmafnk .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#twhtbmafnk .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#twhtbmafnk .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#twhtbmafnk .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#twhtbmafnk .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#twhtbmafnk .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#twhtbmafnk .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#twhtbmafnk .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#twhtbmafnk .gt_row {
  padding-top: 7px;
  padding-bottom: 7px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #F6F7F7;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#twhtbmafnk .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#twhtbmafnk .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#twhtbmafnk .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#twhtbmafnk .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#twhtbmafnk .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#twhtbmafnk .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#twhtbmafnk .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#twhtbmafnk .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_striped {
  background-color: #FAFAFA;
}
&#10;#twhtbmafnk .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#twhtbmafnk .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#twhtbmafnk .gt_sourcenote {
  font-size: 12px;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#twhtbmafnk .gt_left {
  text-align: left;
}
&#10;#twhtbmafnk .gt_center {
  text-align: center;
}
&#10;#twhtbmafnk .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#twhtbmafnk .gt_font_normal {
  font-weight: normal;
}
&#10;#twhtbmafnk .gt_font_bold {
  font-weight: bold;
}
&#10;#twhtbmafnk .gt_font_italic {
  font-style: italic;
}
&#10;#twhtbmafnk .gt_super {
  font-size: 65%;
}
&#10;#twhtbmafnk .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#twhtbmafnk .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#twhtbmafnk .gt_indent_1 {
  text-indent: 5px;
}
&#10;#twhtbmafnk .gt_indent_2 {
  text-indent: 10px;
}
&#10;#twhtbmafnk .gt_indent_3 {
  text-indent: 15px;
}
&#10;#twhtbmafnk .gt_indent_4 {
  text-indent: 20px;
}
&#10;#twhtbmafnk .gt_indent_5 {
  text-indent: 25px;
}
&#10;#twhtbmafnk .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#twhtbmafnk div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

| <em>Optimized Lane Planning</em> |         |           |      |           |             |
|----------------------------------|---------|-----------|------|-----------|-------------|
| <em>Objective function II</em>   |         |           |      |           |             |
| n_real                           | n_total | s_rate    | lane | processed | unprocessed |
| 100                              | 100     | 10.814056 | 9    | 97        | 3           |
| 90                               | 93      | 10.106861 | 9    | 90        | 3           |
| 212                              | 215     | 14.687097 | 15   | 215       | 0           |
| 43                               | 43      | 5.925740  | 7    | 41        | 2           |
| 111                              | 113     | 11.507915 | 10   | 113       | 0           |
| 65                               | 65      | 8.034616  | 8    | 64        | 1           |
| 34                               | 35      | 5.023391  | 2    | 10        | 25          |
| 143                              | 168     | 13.052182 | 13   | 168       | 0           |
| 98                               | 98      | 10.678441 | 9    | 96        | 2           |
| 45                               | 47      | 6.124587  | 8    | 47        | 0           |
| 65                               | 65      | 8.034616  | 8    | 64        | 1           |
| 32                               | 33      | 4.822358  | 1    | 4         | 29          |

</div>

                 [,1]
    min_lane     1.00
    max_lane    15.00
    mean_lane    8.25
    total_antri 66.00

## *Further Discussion: Sensitivity Analysis*

Dari paparan model di atas, kita bisa melakukan *sensitivity analysis*
untuk beberapa variabel yang bisa diatur oleh sang *security manager*.

- Menurunkan atau menaikkan berapa **maksimal *lane*** agar didapatkan
  nilai optimal secara bisnis.
  - Contoh: tak semua hari petugas yang bertugas bisa lengkap 17
    *lanes*. Barangkali ada yang cuti atau izin bekerja sehingga
    ![\leq 17](https://latex.codecogs.com/svg.latex?%5Cleq%2017 "\leq 17")
    orang.
- Menyeragamkan atau membuat standar *range* nilai *service rate*
  sehingga lebih seragam dan “tinggi”.
- Definisikan berapa banyak *unprocessed* yang masih diperbolehkan
  sehingga *lane* yang digunakan bisa lebih “sedikit”.
- Menambahkan *multi objective optimization* sehingga menemukan
  *balance* antara *lane* dan *unprocessed*.
  - Misalkan mengubah *minimize lane* menjadi
    ![\epsilon - constraint](https://latex.codecogs.com/svg.latex?%5Cepsilon%20-%20constraint "\epsilon - constraint").

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`

</div>
