---
date: 2025-05-30T09:37:00-04:00
title: "Berbagai Macam Tampilan Tabel Menarik di R Menggunakan gtExtras"
categories:
  - Blog
tags:
  - Grafik
  - Visualisasi
  - Tabel
  - Ggplot2
---

Beberapa waktu yang lalu, saya sempat menuliskan bagaimana [menyajikan
data dalam berbagai bentuk](https://ikanx101.com/blog/3-waysgraph/),
salah satunya adalah dalam format tabel.

Walaupun terlihat sederhana, namun tabel sejatinya memiliki kelebihan
dibandingkan grafik dalam menyajikan data. Apa saja? Berikut
kelebihan-kelebihannya:

1.  **Presisi Data**
    - Tabel bisa menampilkan nilai/data secara akurat dan detail,
      termasuk desimal, sedangkan grafik biasanya membulatkan nilai
      (karena keterbatasan *space* grafik) atau hanya menunjukkan tren
      visual.  
    - Cocok untuk data yang memerlukan ketepatan, seperti laporan
      keuangan atau statistik teknis.
2.  **Menyajikan Banyak Variabel Sekaligus**
    - Tabel bisa menampilkan banyak kolom dan baris dalam satu tampilan,
      sementara grafik menjadi rumit jika terlalu banyak variabel
      (misalnya, garis atau batang yang tumpang-tindih).
3.  **Mudah Dibandingkan (Untuk Data Spesifik)**
    - Pembaca dapat langsung membandingkan angka antar sel tanpa
      interpretasi visual.  
    - Contoh: Membandingkan harga produk dalam daftar lebih mudah
      dilihat di tabel daripada di grafik batang.
4.  **Tidak Memerlukan Interpretasi Visual**
    - Grafik rentan terhadap kesalahan interpretasi (misalnya, skala
      sumbu yang tidak proporsional), sementara tabel bersifat objektif.
5.  **Efisien untuk Data Kategorikal atau Teks**
    - Jika data mengandung banyak kategori atau deskripsi (misalnya,
      nama, kode), tabel lebih praktis daripada grafik yang terbatas
      pada representasi visual.

Namun tentu saja grafik memiliki beberapa kekurangan seperti:

1.  **Sulit Menunjukkan Pola atau Tren**
    - Grafik (seperti garis atau batang) lebih cepat menunjukkan
      kenaikan/penurunan, sedangkan tren dalam tabel harus dianalisis
      manual.
2.  **Kurang Menarik Secara Visual**
    - Tabel cenderung monoton dan kurang menarik bagi audiens umum,
      sementara grafik lebih mudah dipahami sekilas.
3.  **Rentan Kebosanan untuk Data Besar**
    - Jika data sangat panjang (ratusan baris), tabel menjadi sulit
      dibaca, sedangkan grafik bisa meringkasnya dengan histogram atau
      box plot.
4.  **Tidak Efektif untuk Perbandingan Relatif**
    - Perbandingan proporsi (misalnya, 30% vs 70%) lebih jelas
      ditampilkan dalam pie chart atau bar chart daripada deretan angka
      di tabel.
5.  **Bergantung pada Literasi Numerik**
    - Pembaca harus paham angka, sementara grafik bisa dipahami oleh
      orang dengan literasi numerik rendah.

------------------------------------------------------------------------

Di **R** sendiri, ada berbagai macam format tabel dan cara penyajiannya
sehingga **kita bisa melakukan kustomisasi agar tampilan tabel menjadi
lebih menarik**. Kali ini saya akan coba *share* salah satu *library*
yang biasa digunakan untuk *formatting* tabel, yakni `gt` dan
`gtExtras`.

Data yang hendak saya gunakan adalah data `mtcars` yang saya modifikasi
sebagai berikut:

``` r
df_
```

    # A tibble: 10 × 12
       merek      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
       <chr>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
     1 AMC         15     8   304   150     3     3    17     0     0     3     2
     2 Cadillac    10     8   472   205     2     5    17     0     0     3     4
     3 Camaro      13     8   350   245     3     3    15     0     0     3     4
     4 Chrysler    14     8   440   230     3     5    17     0     0     3     4
     5 Datsun      22     4   108    93     3     2    18     1     1     4     1
     6 Dodge       15     8   318   150     2     3    16     0     0     3     2
     7 Duster      14     8   360   245     3     3    15     0     0     3     4
     8 Ferrari     19     6   145   175     3     2    15     0     1     5     6
     9 Fiat        29     4    78    66     4     2    19     1     1     4     1
    10 Ford        15     8   351   264     4     3    14     0     1     5     4

## `gt` dan `gtExtras`

Dalam `library(gtExtras)`, ada beberapa *custom themes* yang bisa kita
coba:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/macam_tabel/tb1.png) 
![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/macam_tabel/tb2.png) 
![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/macam_tabel/tb3.png) 
![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/macam_tabel/tb4.png) 
![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/macam_tabel/tb5.png)
![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/macam_tabel/tb6.png) 
![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/macam_tabel/tb7.png)

Selain itu, kita bisa membuat pewarnaan kolom bertema **Hulk (dari ungu
ke hijau)** berikut ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/macam_tabel/tb8.png)

Atau kita buat menjadi *custom colors* seperti ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/macam_tabel/tb9.png)

Selain itu, kita bisa menampilkan grafik *line* dan *density* untuk data
kategorik dalam tabel sebagai berikut:

<div id="ffodcfbrtt" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ffodcfbrtt table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#ffodcfbrtt thead, #ffodcfbrtt tbody, #ffodcfbrtt tfoot, #ffodcfbrtt tr, #ffodcfbrtt td, #ffodcfbrtt th {
  border-style: none;
}
&#10;#ffodcfbrtt p {
  margin: 0;
  padding: 0;
}
&#10;#ffodcfbrtt .gt_table {
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
  border-top-width: 2px;
  border-top-color: #A8A8A8;
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
&#10;#ffodcfbrtt .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#ffodcfbrtt .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#ffodcfbrtt .gt_subtitle {
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
&#10;#ffodcfbrtt .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#ffodcfbrtt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#ffodcfbrtt .gt_col_headings {
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
&#10;#ffodcfbrtt .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
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
&#10;#ffodcfbrtt .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#ffodcfbrtt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#ffodcfbrtt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#ffodcfbrtt .gt_column_spanner {
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
&#10;#ffodcfbrtt .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#ffodcfbrtt .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
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
&#10;#ffodcfbrtt .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#ffodcfbrtt .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#ffodcfbrtt .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#ffodcfbrtt .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#ffodcfbrtt .gt_stub {
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
}
&#10;#ffodcfbrtt .gt_stub_row_group {
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
&#10;#ffodcfbrtt .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#ffodcfbrtt .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#ffodcfbrtt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ffodcfbrtt .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#ffodcfbrtt .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#ffodcfbrtt .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#ffodcfbrtt .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ffodcfbrtt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#ffodcfbrtt .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#ffodcfbrtt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#ffodcfbrtt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#ffodcfbrtt .gt_footnotes {
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
&#10;#ffodcfbrtt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ffodcfbrtt .gt_sourcenotes {
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
&#10;#ffodcfbrtt .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ffodcfbrtt .gt_left {
  text-align: left;
}
&#10;#ffodcfbrtt .gt_center {
  text-align: center;
}
&#10;#ffodcfbrtt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#ffodcfbrtt .gt_font_normal {
  font-weight: normal;
}
&#10;#ffodcfbrtt .gt_font_bold {
  font-weight: bold;
}
&#10;#ffodcfbrtt .gt_font_italic {
  font-style: italic;
}
&#10;#ffodcfbrtt .gt_super {
  font-size: 65%;
}
&#10;#ffodcfbrtt .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#ffodcfbrtt .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#ffodcfbrtt .gt_indent_1 {
  text-indent: 5px;
}
&#10;#ffodcfbrtt .gt_indent_2 {
  text-indent: 10px;
}
&#10;#ffodcfbrtt .gt_indent_3 {
  text-indent: 15px;
}
&#10;#ffodcfbrtt .gt_indent_4 {
  text-indent: 20px;
}
&#10;#ffodcfbrtt .gt_indent_5 {
  text-indent: 25px;
}
&#10;#ffodcfbrtt .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#ffodcfbrtt div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

<table class="gt_table" data-quarto-postprocess="true"
data-quarto-disable-processing="false" data-quarto-bootstrap="false">
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="gt_col_headings">
<th id="cyl" class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">cyl</th>
<th id="mpg_data"
class="gt_col_heading gt_columns_bottom_border gt_center"
data-quarto-table-cell-role="th" scope="col">mpg_data</th>
</tr>
</thead>
<tbody class="gt_table_body">
<tr>
<td class="gt_row gt_right" headers="cyl">4</td>
<td class="gt_row gt_center"
headers="mpg_data"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="85.04pt" height="14.17pt" viewbox="0 0 85.04 14.17">
<g class="svglite"><defs>
<style type="text/css">    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  </style>
</defs><rect width="100%" height="100%" style="stroke: none; fill: none;"></rect><defs>
<clippath id="cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3">
<rect x="0.00" y="0.00" width="85.04" height="14.17"></rect>
</clippath></defs><g clip-path="url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)"><text x="68.58" y="9.02" style="font-size: 5.69px; font-family: &quot;Nimbus Mono PS&quot;;" textlength="13.62px" lengthadjust="spacingAndGlyphs">21.4</text><polyline points="8.16,6.80 13.89,6.08 19.61,6.80 25.34,2.51 31.07,3.40 36.79,1.84 42.52,7.38 48.25,4.79 53.97,5.37 59.70,3.40 65.43,7.42 " style="stroke-width: 1.07; stroke-linecap: butt;"></polyline><circle cx="65.43" cy="7.42" r="0.89" style="stroke-width: 0.71; fill: #000000;"></circle><circle cx="65.43" cy="7.42" r="0.89" style="stroke-width: 0.71; stroke: #A020F0; fill: #A020F0;"></circle><circle cx="36.79" cy="1.84" r="0.89" style="stroke-width: 0.71; stroke: #00FF00; fill: #00FF00;"></circle></g></g>
</svg></td>
</tr>
<tr>
<td class="gt_row gt_right" headers="cyl">6</td>
<td class="gt_row gt_center"
headers="mpg_data"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="85.04pt" height="14.17pt" viewbox="0 0 85.04 14.17">
<g class="svglite"><defs>
<style type="text/css">    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  </style>
</defs><rect width="100%" height="100%" style="stroke: none; fill: none;"></rect><defs>
<clippath id="cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3">
<rect x="0.00" y="0.00" width="85.04" height="14.17"></rect>
</clippath></defs><g clip-path="url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)"><text x="68.44" y="9.78" style="font-size: 5.69px; font-family: &quot;Nimbus Mono PS&quot;;" textlength="13.62px" lengthadjust="spacingAndGlyphs">19.7</text><polyline points="10.69,7.60 19.78,7.60 28.88,7.42 37.97,8.90 47.07,8.40 56.16,9.03 65.26,8.18 " style="stroke-width: 1.07; stroke-linecap: butt;"></polyline><circle cx="65.26" cy="8.18" r="0.89" style="stroke-width: 0.71; fill: #000000;"></circle><circle cx="56.16" cy="9.03" r="0.89" style="stroke-width: 0.71; stroke: #A020F0; fill: #A020F0;"></circle><circle cx="28.88" cy="7.42" r="0.89" style="stroke-width: 0.71; stroke: #00FF00; fill: #00FF00;"></circle></g></g>
</svg></td>
</tr>
<tr>
<td class="gt_row gt_right" headers="cyl">8</td>
<td class="gt_row gt_center"
headers="mpg_data"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="85.04pt" height="14.17pt" viewbox="0 0 85.04 14.17">
<g class="svglite"><defs>
<style type="text/css">    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  </style>
</defs><rect width="100%" height="100%" style="stroke: none; fill: none;"></rect><defs>
<clippath id="cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3">
<rect x="0.00" y="0.00" width="85.04" height="14.17"></rect>
</clippath></defs><g clip-path="url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)"><text x="68.63" y="11.88" style="font-size: 5.69px; font-family: &quot;Nimbus Mono PS&quot;;" textlength="13.62px" lengthadjust="spacingAndGlyphs">15.0</text><polyline points="7.23,8.63 11.71,10.59 16.19,9.66 20.67,9.25 25.15,10.19 29.63,12.34 34.12,12.34 38.60,10.42 43.08,10.06 47.56,10.19 52.04,11.04 56.52,8.40 61.01,9.92 65.49,10.28 " style="stroke-width: 1.07; stroke-linecap: butt;"></polyline><circle cx="65.49" cy="10.28" r="0.89" style="stroke-width: 0.71; fill: #000000;"></circle><circle cx="29.63" cy="12.34" r="0.89" style="stroke-width: 0.71; stroke: #A020F0; fill: #A020F0;"></circle><circle cx="34.12" cy="12.34" r="0.89" style="stroke-width: 0.71; stroke: #A020F0; fill: #A020F0;"></circle><circle cx="56.52" cy="8.40" r="0.89" style="stroke-width: 0.71; stroke: #00FF00; fill: #00FF00;"></circle></g></g>
</svg></td>
</tr>
</tbody>
</table>

</div>

<div id="tvtyqawigp" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#tvtyqawigp table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#tvtyqawigp thead, #tvtyqawigp tbody, #tvtyqawigp tfoot, #tvtyqawigp tr, #tvtyqawigp td, #tvtyqawigp th {
  border-style: none;
}
&#10;#tvtyqawigp p {
  margin: 0;
  padding: 0;
}
&#10;#tvtyqawigp .gt_table {
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
  border-top-width: 2px;
  border-top-color: #A8A8A8;
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
&#10;#tvtyqawigp .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#tvtyqawigp .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#tvtyqawigp .gt_subtitle {
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
&#10;#tvtyqawigp .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#tvtyqawigp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#tvtyqawigp .gt_col_headings {
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
&#10;#tvtyqawigp .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
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
&#10;#tvtyqawigp .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#tvtyqawigp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#tvtyqawigp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#tvtyqawigp .gt_column_spanner {
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
&#10;#tvtyqawigp .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#tvtyqawigp .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
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
&#10;#tvtyqawigp .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#tvtyqawigp .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#tvtyqawigp .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#tvtyqawigp .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#tvtyqawigp .gt_stub {
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
}
&#10;#tvtyqawigp .gt_stub_row_group {
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
&#10;#tvtyqawigp .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#tvtyqawigp .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#tvtyqawigp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#tvtyqawigp .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#tvtyqawigp .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#tvtyqawigp .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#tvtyqawigp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#tvtyqawigp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#tvtyqawigp .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#tvtyqawigp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#tvtyqawigp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#tvtyqawigp .gt_footnotes {
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
&#10;#tvtyqawigp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#tvtyqawigp .gt_sourcenotes {
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
&#10;#tvtyqawigp .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#tvtyqawigp .gt_left {
  text-align: left;
}
&#10;#tvtyqawigp .gt_center {
  text-align: center;
}
&#10;#tvtyqawigp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#tvtyqawigp .gt_font_normal {
  font-weight: normal;
}
&#10;#tvtyqawigp .gt_font_bold {
  font-weight: bold;
}
&#10;#tvtyqawigp .gt_font_italic {
  font-style: italic;
}
&#10;#tvtyqawigp .gt_super {
  font-size: 65%;
}
&#10;#tvtyqawigp .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#tvtyqawigp .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#tvtyqawigp .gt_indent_1 {
  text-indent: 5px;
}
&#10;#tvtyqawigp .gt_indent_2 {
  text-indent: 10px;
}
&#10;#tvtyqawigp .gt_indent_3 {
  text-indent: 15px;
}
&#10;#tvtyqawigp .gt_indent_4 {
  text-indent: 20px;
}
&#10;#tvtyqawigp .gt_indent_5 {
  text-indent: 25px;
}
&#10;#tvtyqawigp .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#tvtyqawigp div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

<table class="gt_table" data-quarto-postprocess="true"
data-quarto-disable-processing="false" data-quarto-bootstrap="false">
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="gt_col_headings">
<th id="cyl" class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">cyl</th>
<th id="mpg_data"
class="gt_col_heading gt_columns_bottom_border gt_center"
data-quarto-table-cell-role="th" scope="col">mpg_data</th>
</tr>
</thead>
<tbody class="gt_table_body">
<tr>
<td class="gt_row gt_right" headers="cyl">4</td>
<td class="gt_row gt_center"
headers="mpg_data"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="85.04pt" height="14.17pt" viewbox="0 0 85.04 14.17">
<g class="svglite"><defs>
<style type="text/css">    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  </style>
</defs><rect width="100%" height="100%" style="stroke: none; fill: none;"></rect><defs>
<clippath id="cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3">
<rect x="0.00" y="0.00" width="85.04" height="14.17"></rect>
</clippath></defs><g clip-path="url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)"><polygon points="26.03,13.47 26.07,13.47 26.11,13.47 26.14,13.46 26.18,13.46 26.21,13.46 26.25,13.46 26.29,13.46 26.32,13.46 26.36,13.46 26.39,13.45 26.43,13.45 26.47,13.45 26.50,13.45 26.54,13.45 26.57,13.44 26.61,13.44 26.65,13.44 26.68,13.44 26.72,13.44 26.75,13.44 26.79,13.43 26.83,13.43 26.86,13.43 26.90,13.43 26.93,13.42 26.97,13.42 27.01,13.42 27.04,13.42 27.08,13.42 27.11,13.41 27.15,13.41 27.19,13.41 27.22,13.41 27.26,13.40 27.29,13.40 27.33,13.40 27.36,13.40 27.40,13.39 27.44,13.39 27.47,13.39 27.51,13.38 27.54,13.38 27.58,13.38 27.62,13.37 27.65,13.37 27.69,13.37 27.72,13.36 27.76,13.36 27.80,13.36 27.83,13.35 27.87,13.35 27.90,13.35 27.94,13.34 27.98,13.34 28.01,13.34 28.05,13.33 28.08,13.33 28.12,13.33 28.16,13.32 28.19,13.32 28.23,13.31 28.26,13.31 28.30,13.30 28.34,13.30 28.37,13.30 28.41,13.29 28.44,13.29 28.48,13.28 28.52,13.28 28.55,13.27 28.59,13.27 28.62,13.26 28.66,13.26 28.70,13.25 28.73,13.25 28.77,13.24 28.80,13.24 28.84,13.23 28.88,13.23 28.91,13.22 28.95,13.21 28.98,13.21 29.02,13.20 29.06,13.20 29.09,13.19 29.13,13.18 29.16,13.18 29.20,13.17 29.24,13.16 29.27,13.16 29.31,13.15 29.34,13.14 29.38,13.14 29.42,13.13 29.45,13.12 29.49,13.12 29.52,13.11 29.56,13.10 29.60,13.09 29.63,13.09 29.67,13.08 29.70,13.07 29.74,13.06 29.77,13.05 29.81,13.05 29.85,13.04 29.88,13.03 29.92,13.02 29.95,13.01 29.99,13.00 30.03,12.99 30.06,12.98 30.10,12.98 30.13,12.97 30.17,12.96 30.21,12.95 30.24,12.94 30.28,12.93 30.31,12.92 30.35,12.91 30.39,12.90 30.42,12.89 30.46,12.88 30.49,12.87 30.53,12.85 30.57,12.84 30.60,12.83 30.64,12.82 30.67,12.81 30.71,12.80 30.75,12.79 30.78,12.77 30.82,12.76 30.85,12.75 30.89,12.74 30.93,12.72 30.96,12.71 31.00,12.70 31.03,12.69 31.07,12.67 31.11,12.66 31.14,12.65 31.18,12.63 31.21,12.62 31.25,12.60 31.29,12.59 31.32,12.58 31.36,12.56 31.39,12.55 31.43,12.53 31.47,12.52 31.50,12.50 31.54,12.49 31.57,12.47 31.61,12.45 31.65,12.44 31.68,12.42 31.72,12.41 31.75,12.39 31.79,12.37 31.83,12.36 31.86,12.34 31.90,12.32 31.93,12.30 31.97,12.29 32.00,12.27 32.04,12.25 32.08,12.23 32.11,12.21 32.15,12.19 32.18,12.18 32.22,12.16 32.26,12.14 32.29,12.12 32.33,12.10 32.36,12.08 32.40,12.06 32.44,12.04 32.47,12.02 32.51,12.00 32.54,11.98 32.58,11.95 32.62,11.93 32.65,11.91 32.69,11.89 32.72,11.87 32.76,11.84 32.80,11.82 32.83,11.80 32.87,11.78 32.90,11.75 32.94,11.73 32.98,11.71 33.01,11.68 33.05,11.66 33.08,11.63 33.12,11.61 33.16,11.59 33.19,11.56 33.23,11.54 33.26,11.51 33.30,11.48 33.34,11.46 33.37,11.43 33.41,11.41 33.44,11.38 33.48,11.35 33.52,11.33 33.55,11.30 33.59,11.27 33.62,11.24 33.66,11.22 33.70,11.19 33.73,11.16 33.77,11.13 33.80,11.10 33.84,11.07 33.88,11.04 33.91,11.01 33.95,10.98 33.98,10.95 34.02,10.92 34.06,10.89 34.09,10.86 34.13,10.83 34.16,10.80 34.20,10.77 34.23,10.74 34.27,10.71 34.31,10.67 34.34,10.64 34.38,10.61 34.41,10.58 34.45,10.54 34.49,10.51 34.52,10.48 34.56,10.44 34.59,10.41 34.63,10.37 34.67,10.34 34.70,10.31 34.74,10.27 34.77,10.24 34.81,10.20 34.85,10.17 34.88,10.13 34.92,10.09 34.95,10.06 34.99,10.02 35.03,9.98 35.06,9.95 35.10,9.91 35.13,9.87 35.17,9.84 35.21,9.80 35.24,9.76 35.28,9.72 35.31,9.68 35.35,9.65 35.39,9.61 35.42,9.57 35.46,9.53 35.49,9.49 35.53,9.45 35.57,9.41 35.60,9.37 35.64,9.33 35.67,9.29 35.71,9.25 35.75,9.21 35.78,9.17 35.82,9.13 35.85,9.08 35.89,9.04 35.93,9.00 35.96,8.96 36.00,8.92 36.03,8.87 36.07,8.83 36.11,8.79 36.14,8.75 36.18,8.70 36.21,8.66 36.25,8.62 36.29,8.57 36.32,8.53 36.36,8.49 36.39,8.44 36.43,8.40 36.47,8.35 36.50,8.31 36.54,8.27 36.57,8.22 36.61,8.18 36.64,8.13 36.68,8.09 36.72,8.04 36.75,8.00 36.79,7.95 36.82,7.90 36.86,7.86 36.90,7.81 36.93,7.77 36.97,7.72 37.00,7.67 37.04,7.63 37.08,7.58 37.11,7.54 37.15,7.49 37.18,7.44 37.22,7.40 37.26,7.35 37.29,7.30 37.33,7.25 37.36,7.21 37.40,7.16 37.44,7.11 37.47,7.07 37.51,7.02 37.54,6.97 37.58,6.92 37.62,6.87 37.65,6.83 37.69,6.78 37.72,6.73 37.76,6.68 37.80,6.64 37.83,6.59 37.87,6.54 37.90,6.49 37.94,6.44 37.98,6.40 38.01,6.35 38.05,6.30 38.08,6.25 38.12,6.20 38.16,6.16 38.19,6.11 38.23,6.06 38.26,6.01 38.30,5.96 38.34,5.91 38.37,5.87 38.41,5.82 38.44,5.77 38.48,5.72 38.52,5.67 38.55,5.63 38.59,5.58 38.62,5.53 38.66,5.48 38.70,5.44 38.73,5.39 38.77,5.34 38.80,5.29 38.84,5.25 38.87,5.20 38.91,5.15 38.95,5.10 38.98,5.06 39.02,5.01 39.05,4.96 39.09,4.91 39.13,4.87 39.16,4.82 39.20,4.77 39.23,4.73 39.27,4.68 39.31,4.63 39.34,4.59 39.38,4.54 39.41,4.50 39.45,4.45 39.49,4.41 39.52,4.36 39.56,4.31 39.59,4.27 39.63,4.22 39.67,4.18 39.70,4.13 39.74,4.09 39.77,4.04 39.81,4.00 39.85,3.96 39.88,3.91 39.92,3.87 39.95,3.82 39.99,3.78 40.03,3.74 40.06,3.70 40.10,3.65 40.13,3.61 40.17,3.57 40.21,3.53 40.24,3.48 40.28,3.44 40.31,3.40 40.35,3.36 40.39,3.32 40.42,3.28 40.46,3.24 40.49,3.19 40.53,3.15 40.57,3.12 40.60,3.08 40.64,3.04 40.67,3.00 40.71,2.96 40.75,2.92 40.78,2.88 40.82,2.84 40.85,2.80 40.89,2.77 40.93,2.73 40.96,2.69 41.00,2.66 41.03,2.62 41.07,2.58 41.10,2.55 41.14,2.51 41.18,2.48 41.21,2.44 41.25,2.40 41.28,2.37 41.32,2.34 41.36,2.30 41.39,2.27 41.43,2.24 41.46,2.20 41.50,2.17 41.54,2.14 41.57,2.10 41.61,2.07 41.64,2.04 41.68,2.01 41.72,1.98 41.75,1.95 41.79,1.92 41.82,1.89 41.86,1.86 41.90,1.83 41.93,1.80 41.97,1.77 42.00,1.75 42.04,1.72 42.08,1.69 42.11,1.66 42.15,1.64 42.18,1.61 42.22,1.58 42.26,1.56 42.29,1.53 42.33,1.51 42.36,1.48 42.40,1.46 42.44,1.43 42.47,1.41 42.51,1.39 42.54,1.36 42.58,1.34 42.62,1.32 42.65,1.30 42.69,1.28 42.72,1.26 42.76,1.23 42.80,1.21 42.83,1.19 42.87,1.17 42.90,1.16 42.94,1.14 42.98,1.12 43.01,1.10 43.05,1.08 43.08,1.06 43.12,1.05 43.16,1.03 43.19,1.01 43.23,1.00 43.26,0.98 43.30,0.97 43.34,0.95 43.37,0.94 43.41,0.92 43.44,0.91 43.48,0.90 43.51,0.88 43.55,0.87 43.59,0.86 43.62,0.84 43.66,0.83 43.69,0.82 43.73,0.81 43.77,0.80 43.80,0.79 43.84,0.78 43.87,0.77 43.91,0.76 43.95,0.75 43.98,0.74 44.02,0.74 44.05,0.73 44.09,0.72 44.13,0.71 44.16,0.71 44.20,0.70 44.23,0.70 44.27,0.69 44.31,0.68 44.34,0.68 44.38,0.67 44.41,0.67 44.45,0.67 44.49,0.66 44.52,0.66 44.56,0.66 44.59,0.65 44.63,0.65 44.67,0.65 44.70,0.65 44.74,0.65 44.77,0.65 44.81,0.64 44.85,0.64 44.88,0.64 44.92,0.64 44.95,0.65 44.99,0.65 45.03,0.65 45.06,0.65 45.10,0.65 45.13,0.65 45.17,0.65 45.21,0.66 45.24,0.66 45.28,0.66 45.31,0.67 45.35,0.67 45.39,0.68 45.42,0.68 45.46,0.68 45.49,0.69 45.53,0.70 45.57,0.70 45.60,0.71 45.64,0.71 45.67,0.72 45.71,0.73 45.74,0.73 45.78,0.74 45.82,0.75 45.85,0.75 45.89,0.76 45.92,0.77 45.96,0.78 46.00,0.79 46.03,0.80 46.07,0.81 46.10,0.81 46.14,0.82 46.18,0.83 46.21,0.84 46.25,0.86 46.28,0.87 46.32,0.88 46.36,0.89 46.39,0.90 46.43,0.91 46.46,0.92 46.50,0.93 46.54,0.95 46.57,0.96 46.61,0.97 46.64,0.98 46.68,1.00 46.72,1.01 46.75,1.02 46.79,1.03 46.82,1.05 46.86,1.06 46.90,1.08 46.93,1.09 46.97,1.10 47.00,1.12 47.04,1.13 47.08,1.15 47.11,1.16 47.15,1.18 47.18,1.19 47.22,1.21 47.26,1.22 47.29,1.24 47.33,1.25 47.36,1.27 47.40,1.29 47.44,1.30 47.47,1.32 47.51,1.34 47.54,1.35 47.58,1.37 47.62,1.39 47.65,1.40 47.69,1.42 47.72,1.44 47.76,1.45 47.80,1.47 47.83,1.49 47.87,1.51 47.90,1.52 47.94,1.54 47.97,1.56 48.01,1.58 48.05,1.59 48.08,1.61 48.12,1.63 48.15,1.65 48.19,1.67 48.23,1.69 48.26,1.70 48.30,1.72 48.33,1.74 48.37,1.76 48.41,1.78 48.44,1.80 48.48,1.81 48.51,1.83 48.55,1.85 48.59,1.87 48.62,1.89 48.66,1.91 48.69,1.93 48.73,1.95 48.77,1.97 48.80,1.99 48.84,2.00 48.87,2.02 48.91,2.04 48.95,2.06 48.98,2.08 49.02,2.10 49.05,2.12 49.09,2.14 49.13,2.16 49.16,2.18 49.20,2.20 49.23,2.21 49.27,2.23 49.31,2.25 49.34,2.27 49.38,2.29 49.41,2.31 49.45,2.33 49.49,2.35 49.52,2.37 49.56,2.39 49.59,2.41 49.63,2.43 49.67,2.44 49.70,2.46 49.74,2.48 49.77,2.50 49.81,2.52 49.85,2.54 49.88,2.56 49.92,2.58 49.95,2.59 49.99,2.61 50.03,2.63 50.06,2.65 50.10,2.67 50.13,2.69 50.17,2.71 50.21,2.72 50.24,2.74 50.28,2.76 50.31,2.78 50.35,2.80 50.38,2.81 50.42,2.83 50.46,2.85 50.49,2.87 50.53,2.89 50.56,2.90 50.60,2.92 50.64,2.94 50.67,2.96 50.71,2.97 50.74,2.99 50.78,3.01 50.82,3.02 50.85,3.04 50.89,3.06 50.92,3.08 50.96,3.09 51.00,3.11 51.03,3.12 51.07,3.14 51.10,3.16 51.14,3.17 51.18,3.19 51.21,3.21 51.25,3.22 51.28,3.24 51.32,3.25 51.36,3.27 51.39,3.28 51.43,3.30 51.46,3.31 51.50,3.33 51.54,3.34 51.57,3.36 51.61,3.37 51.64,3.39 51.68,3.40 51.72,3.42 51.75,3.43 51.79,3.45 51.82,3.46 51.86,3.47 51.90,3.49 51.93,3.50 51.97,3.52 52.00,3.53 52.04,3.54 52.08,3.56 52.11,3.57 52.15,3.58 52.18,3.59 52.22,3.61 52.26,3.62 52.29,3.63 52.33,3.64 52.36,3.66 52.40,3.67 52.44,3.68 52.47,3.69 52.51,3.70 52.54,3.72 52.58,3.73 52.61,3.74 52.65,3.75 52.69,3.76 52.72,3.77 52.76,3.78 52.79,3.79 52.83,3.80 52.87,3.81 52.90,3.82 52.94,3.83 52.97,3.84 53.01,3.85 53.05,3.86 53.08,3.87 53.12,3.88 53.15,3.89 53.19,3.90 53.23,3.91 53.26,3.92 53.30,3.93 53.33,3.93 53.37,3.94 53.41,3.95 53.44,3.96 53.48,3.97 53.51,3.97 53.55,3.98 53.59,3.99 53.62,4.00 53.66,4.00 53.69,4.01 53.73,4.02 53.77,4.02 53.80,4.03 53.84,4.04 53.87,4.04 53.91,4.05 53.95,4.06 53.98,4.06 54.02,4.07 54.05,4.07 54.09,4.08 54.13,4.08 54.16,4.09 54.20,4.10 54.23,4.10 54.27,4.10 54.31,4.11 54.34,4.11 54.38,4.12 54.41,4.12 54.45,4.13 54.49,4.13 54.52,4.14 54.56,4.14 54.59,4.14 54.63,4.15 54.67,4.15 54.70,4.15 54.74,4.16 54.77,4.16 54.81,4.16 54.84,4.17 54.88,4.17 54.92,4.17 54.95,4.17 54.99,4.18 55.02,4.18 55.06,4.18 55.10,4.18 55.13,4.19 55.17,4.19 55.20,4.19 55.24,4.19 55.28,4.19 55.31,4.19 55.35,4.20 55.38,4.20 55.42,4.20 55.46,4.20 55.49,4.20 55.53,4.20 55.56,4.20 55.60,4.20 55.64,4.20 55.67,4.20 55.71,4.20 55.74,4.21 55.78,4.21 55.82,4.21 55.85,4.21 55.89,4.21 55.92,4.21 55.96,4.21 56.00,4.21 56.03,4.21 56.07,4.20 56.10,4.20 56.14,4.20 56.18,4.20 56.21,4.20 56.25,4.20 56.28,4.20 56.32,4.20 56.36,4.20 56.39,4.20 56.43,4.20 56.46,4.20 56.50,4.20 56.54,4.20 56.57,4.19 56.61,4.19 56.64,4.19 56.68,4.19 56.72,4.19 56.75,4.19 56.79,4.19 56.82,4.18 56.86,4.18 56.90,4.18 56.93,4.18 56.97,4.18 57.00,4.18 57.04,4.18 57.08,4.17 57.11,4.17 57.15,4.17 57.18,4.17 57.22,4.17 57.25,4.17 57.29,4.16 57.33,4.16 57.36,4.16 57.40,4.16 57.43,4.16 57.47,4.15 57.51,4.15 57.54,4.15 57.58,4.15 57.61,4.15 57.65,4.15 57.69,4.14 57.72,4.14 57.76,4.14 57.79,4.14 57.83,4.14 57.87,4.14 57.90,4.13 57.94,4.13 57.97,4.13 58.01,4.13 58.05,4.13 58.08,4.13 58.12,4.13 58.15,4.12 58.19,4.12 58.23,4.12 58.26,4.12 58.30,4.12 58.33,4.12 58.37,4.12 58.41,4.12 58.44,4.12 58.48,4.11 58.51,4.11 58.55,4.11 58.59,4.11 58.62,4.11 58.66,4.11 58.69,4.11 58.73,4.11 58.77,4.11 58.80,4.11 58.84,4.11 58.87,4.11 58.91,4.11 58.95,4.11 58.98,4.11 59.02,4.11 59.05,4.11 59.09,4.11 59.13,4.11 59.16,4.11 59.20,4.11 59.23,4.11 59.27,4.11 59.31,4.11 59.34,4.11 59.38,4.12 59.41,4.12 59.45,4.12 59.48,4.12 59.52,4.12 59.56,4.12 59.59,4.12 59.63,4.13 59.66,4.13 59.70,4.13 59.74,4.13 59.77,4.14 59.81,4.14 59.84,4.14 59.88,4.14 59.92,4.15 59.95,4.15 59.99,4.15 60.02,4.16 60.06,4.16 60.10,4.16 60.13,4.17 60.17,4.17 60.20,4.17 60.24,4.18 60.28,4.18 60.31,4.19 60.35,4.19 60.38,4.20 60.42,4.20 60.46,4.21 60.49,4.21 60.53,4.22 60.56,4.22 60.60,4.23 60.64,4.23 60.67,4.24 60.71,4.24 60.74,4.25 60.78,4.26 60.82,4.26 60.85,4.27 60.89,4.28 60.92,4.28 60.96,4.29 61.00,4.30 61.03,4.31 61.07,4.31 61.10,4.32 61.14,4.33 61.18,4.34 61.21,4.35 61.25,4.35 61.28,4.36 61.32,4.37 61.36,4.38 61.39,4.39 61.43,4.40 61.46,4.41 61.50,4.42 61.54,4.43 61.57,4.44 61.61,4.45 61.64,4.46 61.68,4.47 61.71,4.48 61.75,4.49 61.79,4.50 61.82,4.51 61.86,4.52 61.89,4.54 61.93,4.55 61.97,4.56 62.00,4.57 62.04,4.58 62.07,4.60 62.11,4.61 62.15,4.62 62.18,4.64 62.22,4.65 62.25,4.66 62.29,4.68 62.33,4.69 62.36,4.70 62.40,4.72 62.43,4.73 62.47,4.75 62.51,4.76 62.54,4.78 62.58,4.79 62.61,4.81 62.65,4.82 62.69,4.84 62.72,4.85 62.76,4.87 62.79,4.89 62.83,4.90 62.87,4.92 62.90,4.94 62.94,4.95 62.97,4.97 63.01,4.99 63.05,5.00 63.08,5.02 63.12,5.04 63.15,5.06 63.19,5.08 63.23,5.09 63.26,5.11 63.30,5.13 63.33,5.15 63.37,5.17 63.41,5.19 63.44,5.21 63.48,5.23 63.51,5.25 63.55,5.27 63.59,5.29 63.62,5.31 63.66,5.33 63.69,5.35 63.73,5.37 63.77,5.39 63.80,5.41 63.84,5.43 63.87,5.45 63.91,5.47 63.95,5.49 63.98,5.52 64.02,5.54 64.05,5.56 64.09,5.58 64.12,5.61 64.16,5.63 64.20,5.65 64.23,5.67 64.27,5.70 64.30,5.72 64.34,5.74 64.38,5.77 64.41,5.79 64.45,5.81 64.48,5.84 64.52,5.86 64.56,5.89 64.59,5.91 64.63,5.93 64.66,5.96 64.70,5.98 64.74,6.01 64.77,6.03 64.81,6.06 64.84,6.08 64.88,6.11 64.92,6.14 64.95,6.16 64.99,6.19 65.02,6.21 65.06,6.24 65.10,6.27 65.13,6.29 65.17,6.32 65.20,6.34 65.24,6.37 65.28,6.40 65.31,6.42 65.35,6.45 65.38,6.48 65.42,6.51 65.46,6.53 65.49,6.56 65.53,6.59 65.56,6.62 65.60,6.64 65.64,6.67 65.67,6.70 65.71,6.73 65.74,6.76 65.78,6.78 65.82,6.81 65.85,6.84 65.89,6.87 65.92,6.90 65.96,6.93 66.00,6.95 66.03,6.98 66.07,7.01 66.10,7.04 66.14,7.07 66.18,7.10 66.21,7.13 66.25,7.16 66.28,7.19 66.32,7.22 66.35,7.25 66.39,7.27 66.43,7.30 66.46,7.33 66.50,7.36 66.53,7.39 66.57,7.42 66.61,7.45 66.64,7.48 66.68,7.51 66.71,7.54 66.75,7.57 66.79,7.60 66.82,7.63 66.86,7.66 66.89,7.69 66.93,7.72 66.97,7.75 67.00,7.78 67.04,7.81 67.07,7.84 67.11,7.87 67.15,7.90 67.18,7.94 67.22,7.97 67.25,8.00 67.29,8.03 67.33,8.06 67.36,8.09 67.40,8.12 67.43,8.15 67.47,8.18 67.51,8.21 67.54,8.24 67.58,8.27 67.61,8.30 67.65,8.33 67.69,8.36 67.72,8.39 67.76,8.42 67.79,8.45 67.83,8.48 67.87,8.52 67.90,8.55 67.94,8.58 67.97,8.61 68.01,8.64 68.05,8.67 68.08,8.70 68.12,8.73 68.15,8.76 68.19,8.79 68.23,8.82 68.26,8.85 68.30,8.88 68.33,8.91 68.37,8.94 68.41,8.97 68.44,9.00 68.48,9.03 68.51,9.06 68.55,9.09 68.58,9.12 68.62,9.15 68.66,9.18 68.69,9.21 68.73,9.24 68.76,9.27 68.80,9.30 68.84,9.33 68.87,9.36 68.91,9.39 68.94,9.42 68.98,9.45 69.02,9.48 69.05,9.51 69.09,9.53 69.12,9.56 69.16,9.59 69.20,9.62 69.23,9.65 69.27,9.68 69.30,9.71 69.34,9.74 69.38,9.77 69.41,9.79 69.45,9.82 69.48,9.85 69.52,9.88 69.56,9.91 69.59,9.94 69.63,9.96 69.66,9.99 69.70,10.02 69.74,10.05 69.77,10.08 69.81,10.10 69.84,10.13 69.88,10.16 69.92,10.19 69.95,10.21 69.99,10.24 70.02,10.27 70.06,10.29 70.10,10.32 70.13,10.35 70.17,10.37 70.20,10.40 70.24,10.43 70.28,10.45 70.31,10.48 70.35,10.51 70.38,10.53 70.42,10.56 70.46,10.58 70.49,10.61 70.53,10.64 70.56,10.66 70.60,10.69 70.64,10.71 70.67,10.74 70.71,10.76 70.74,10.79 70.78,10.81 70.81,10.84 70.85,10.86 70.89,10.88 70.92,10.91 70.96,10.93 70.99,10.96 71.03,10.98 71.07,11.01 71.10,11.03 71.14,11.05 71.17,11.08 71.21,11.10 71.25,11.12 71.28,11.15 71.32,11.17 71.35,11.19 71.39,11.21 71.43,11.24 71.46,11.26 71.50,11.28 71.53,11.30 71.57,11.33 71.61,11.35 71.64,11.37 71.68,11.39 71.71,11.41 71.75,11.43 71.79,11.46 71.82,11.48 71.86,11.50 71.89,11.52 71.93,11.54 71.97,11.56 72.00,11.58 72.04,11.60 72.07,11.62 72.11,11.64 72.15,11.66 72.18,11.68 72.22,11.70 72.25,11.72 72.29,11.74 72.33,11.76 72.36,11.78 72.40,11.80 72.43,11.82 72.47,11.83 72.51,11.85 72.54,11.87 72.58,11.89 72.61,11.91 72.65,11.93 72.69,11.94 72.72,11.96 72.76,11.98 72.79,12.00 72.83,12.01 72.87,12.03 72.90,12.05 72.94,12.07 72.97,12.08 73.01,12.10 73.05,12.12 73.08,12.13 73.12,12.15 73.15,12.17 73.19,12.18 73.22,12.20 73.26,12.21 73.30,12.23 73.33,12.24 73.37,12.26 73.40,12.28 73.44,12.29 73.48,12.30 73.51,12.32 73.55,12.33 73.58,12.35 73.62,12.36 73.66,12.38 73.69,12.39 73.73,12.41 73.76,12.42 73.80,12.43 73.84,12.45 73.87,12.46 73.91,12.48 73.94,12.49 73.98,12.50 74.02,12.51 74.05,12.53 74.09,12.54 74.12,12.55 74.16,12.57 74.20,12.58 74.23,12.59 74.27,12.60 74.30,12.62 74.34,12.63 74.38,12.64 74.41,12.65 74.45,12.66 74.48,12.67 74.52,12.69 74.56,12.70 74.59,12.71 74.63,12.72 74.66,12.73 74.70,12.74 74.74,12.75 74.77,12.76 74.81,12.77 74.84,12.78 74.88,12.79 74.92,12.80 74.95,12.81 74.99,12.82 75.02,12.83 75.06,12.84 75.10,12.85 75.13,12.86 75.17,12.87 75.20,12.88 75.24,12.89 75.28,12.90 75.31,12.91 75.35,12.92 75.38,12.93 75.42,12.94 75.45,12.94 75.49,12.95 75.53,12.96 75.56,12.97 75.60,12.98 75.63,12.99 75.67,12.99 75.71,13.00 75.74,13.01 75.78,13.02 75.81,13.03 75.85,13.03 75.89,13.04 75.92,13.05 75.96,13.05 75.99,13.06 76.03,13.07 76.07,13.08 76.10,13.08 76.14,13.09 76.17,13.10 76.21,13.10 76.25,13.11 76.28,13.12 76.32,13.12 76.35,13.13 76.39,13.14 76.43,13.14 76.46,13.15 76.50,13.15 76.53,13.16 76.57,13.17 76.61,13.17 76.64,13.18 76.68,13.18 76.71,13.19 76.75,13.19 76.79,13.20 76.82,13.20 76.86,13.21 76.89,13.22 76.93,13.22 76.97,13.23 77.00,13.23 77.04,13.24 77.07,13.24 77.11,13.25 77.15,13.25 77.18,13.25 77.22,13.26 77.25,13.26 77.29,13.27 77.33,13.27 77.36,13.28 77.40,13.28 77.43,13.29 77.47,13.29 77.51,13.29 77.54,13.30 77.58,13.30 77.61,13.31 77.65,13.31 77.68,13.31 77.72,13.32 77.76,13.32 77.79,13.32 77.83,13.33 77.86,13.33 77.90,13.34 77.94,13.34 77.97,13.34 78.01,13.35 78.04,13.35 78.08,13.35 78.12,13.35 78.15,13.36 78.19,13.36 78.22,13.36 78.26,13.37 78.30,13.37 78.33,13.37 78.37,13.38 78.40,13.38 78.44,13.38 78.48,13.38 78.51,13.39 78.55,13.39 78.58,13.39 78.62,13.39 78.66,13.40 78.69,13.40 78.73,13.40 78.76,13.40 78.80,13.41 78.84,13.41 78.87,13.41 78.91,13.41 78.94,13.42 78.98,13.42 79.02,13.42 79.05,13.42 79.09,13.42 79.12,13.43 79.16,13.43 79.20,13.43 79.23,13.43 79.27,13.43 79.30,13.44 79.34,13.44 79.38,13.44 79.41,13.44 79.45,13.44 79.48,13.44 79.52,13.45 79.56,13.45 79.59,13.45 79.63,13.45 79.66,13.45 79.70,13.45 79.74,13.46 79.77,13.46 79.81,13.46 79.84,13.46 79.88,13.46 79.92,13.46 79.95,13.46 79.99,13.47 80.02,13.47 80.06,13.47 80.09,13.47 80.13,13.47 80.17,13.47 80.20,13.47 80.24,13.47 80.27,13.48 80.31,13.48 80.35,13.48 80.38,13.48 80.42,13.48 80.45,13.48 80.49,13.48 80.53,13.48 80.56,13.48 80.60,13.48 80.63,13.49 80.67,13.49 80.71,13.49 80.74,13.49 80.78,13.49 80.81,13.49 80.85,13.49 80.89,13.49 80.92,13.49 80.96,13.49 80.99,13.49 81.03,13.49 81.07,13.50 81.10,13.50 81.14,13.50 81.17,13.50 81.17,13.53 81.14,13.53 81.10,13.53 81.07,13.53 81.03,13.53 80.99,13.53 80.96,13.53 80.92,13.53 80.89,13.53 80.85,13.53 80.81,13.53 80.78,13.53 80.74,13.53 80.71,13.53 80.67,13.53 80.63,13.53 80.60,13.53 80.56,13.53 80.53,13.53 80.49,13.53 80.45,13.53 80.42,13.53 80.38,13.53 80.35,13.53 80.31,13.53 80.27,13.53 80.24,13.53 80.20,13.53 80.17,13.53 80.13,13.53 80.09,13.53 80.06,13.53 80.02,13.53 79.99,13.53 79.95,13.53 79.92,13.53 79.88,13.53 79.84,13.53 79.81,13.53 79.77,13.53 79.74,13.53 79.70,13.53 79.66,13.53 79.63,13.53 79.59,13.53 79.56,13.53 79.52,13.53 79.48,13.53 79.45,13.53 79.41,13.53 79.38,13.53 79.34,13.53 79.30,13.53 79.27,13.53 79.23,13.53 79.20,13.53 79.16,13.53 79.12,13.53 79.09,13.53 79.05,13.53 79.02,13.53 78.98,13.53 78.94,13.53 78.91,13.53 78.87,13.53 78.84,13.53 78.80,13.53 78.76,13.53 78.73,13.53 78.69,13.53 78.66,13.53 78.62,13.53 78.58,13.53 78.55,13.53 78.51,13.53 78.48,13.53 78.44,13.53 78.40,13.53 78.37,13.53 78.33,13.53 78.30,13.53 78.26,13.53 78.22,13.53 78.19,13.53 78.15,13.53 78.12,13.53 78.08,13.53 78.04,13.53 78.01,13.53 77.97,13.53 77.94,13.53 77.90,13.53 77.86,13.53 77.83,13.53 77.79,13.53 77.76,13.53 77.72,13.53 77.68,13.53 77.65,13.53 77.61,13.53 77.58,13.53 77.54,13.53 77.51,13.53 77.47,13.53 77.43,13.53 77.40,13.53 77.36,13.53 77.33,13.53 77.29,13.53 77.25,13.53 77.22,13.53 77.18,13.53 77.15,13.53 77.11,13.53 77.07,13.53 77.04,13.53 77.00,13.53 76.97,13.53 76.93,13.53 76.89,13.53 76.86,13.53 76.82,13.53 76.79,13.53 76.75,13.53 76.71,13.53 76.68,13.53 76.64,13.53 76.61,13.53 76.57,13.53 76.53,13.53 76.50,13.53 76.46,13.53 76.43,13.53 76.39,13.53 76.35,13.53 76.32,13.53 76.28,13.53 76.25,13.53 76.21,13.53 76.17,13.53 76.14,13.53 76.10,13.53 76.07,13.53 76.03,13.53 75.99,13.53 75.96,13.53 75.92,13.53 75.89,13.53 75.85,13.53 75.81,13.53 75.78,13.53 75.74,13.53 75.71,13.53 75.67,13.53 75.63,13.53 75.60,13.53 75.56,13.53 75.53,13.53 75.49,13.53 75.45,13.53 75.42,13.53 75.38,13.53 75.35,13.53 75.31,13.53 75.28,13.53 75.24,13.53 75.20,13.53 75.17,13.53 75.13,13.53 75.10,13.53 75.06,13.53 75.02,13.53 74.99,13.53 74.95,13.53 74.92,13.53 74.88,13.53 74.84,13.53 74.81,13.53 74.77,13.53 74.74,13.53 74.70,13.53 74.66,13.53 74.63,13.53 74.59,13.53 74.56,13.53 74.52,13.53 74.48,13.53 74.45,13.53 74.41,13.53 74.38,13.53 74.34,13.53 74.30,13.53 74.27,13.53 74.23,13.53 74.20,13.53 74.16,13.53 74.12,13.53 74.09,13.53 74.05,13.53 74.02,13.53 73.98,13.53 73.94,13.53 73.91,13.53 73.87,13.53 73.84,13.53 73.80,13.53 73.76,13.53 73.73,13.53 73.69,13.53 73.66,13.53 73.62,13.53 73.58,13.53 73.55,13.53 73.51,13.53 73.48,13.53 73.44,13.53 73.40,13.53 73.37,13.53 73.33,13.53 73.30,13.53 73.26,13.53 73.22,13.53 73.19,13.53 73.15,13.53 73.12,13.53 73.08,13.53 73.05,13.53 73.01,13.53 72.97,13.53 72.94,13.53 72.90,13.53 72.87,13.53 72.83,13.53 72.79,13.53 72.76,13.53 72.72,13.53 72.69,13.53 72.65,13.53 72.61,13.53 72.58,13.53 72.54,13.53 72.51,13.53 72.47,13.53 72.43,13.53 72.40,13.53 72.36,13.53 72.33,13.53 72.29,13.53 72.25,13.53 72.22,13.53 72.18,13.53 72.15,13.53 72.11,13.53 72.07,13.53 72.04,13.53 72.00,13.53 71.97,13.53 71.93,13.53 71.89,13.53 71.86,13.53 71.82,13.53 71.79,13.53 71.75,13.53 71.71,13.53 71.68,13.53 71.64,13.53 71.61,13.53 71.57,13.53 71.53,13.53 71.50,13.53 71.46,13.53 71.43,13.53 71.39,13.53 71.35,13.53 71.32,13.53 71.28,13.53 71.25,13.53 71.21,13.53 71.17,13.53 71.14,13.53 71.10,13.53 71.07,13.53 71.03,13.53 70.99,13.53 70.96,13.53 70.92,13.53 70.89,13.53 70.85,13.53 70.81,13.53 70.78,13.53 70.74,13.53 70.71,13.53 70.67,13.53 70.64,13.53 70.60,13.53 70.56,13.53 70.53,13.53 70.49,13.53 70.46,13.53 70.42,13.53 70.38,13.53 70.35,13.53 70.31,13.53 70.28,13.53 70.24,13.53 70.20,13.53 70.17,13.53 70.13,13.53 70.10,13.53 70.06,13.53 70.02,13.53 69.99,13.53 69.95,13.53 69.92,13.53 69.88,13.53 69.84,13.53 69.81,13.53 69.77,13.53 69.74,13.53 69.70,13.53 69.66,13.53 69.63,13.53 69.59,13.53 69.56,13.53 69.52,13.53 69.48,13.53 69.45,13.53 69.41,13.53 69.38,13.53 69.34,13.53 69.30,13.53 69.27,13.53 69.23,13.53 69.20,13.53 69.16,13.53 69.12,13.53 69.09,13.53 69.05,13.53 69.02,13.53 68.98,13.53 68.94,13.53 68.91,13.53 68.87,13.53 68.84,13.53 68.80,13.53 68.76,13.53 68.73,13.53 68.69,13.53 68.66,13.53 68.62,13.53 68.58,13.53 68.55,13.53 68.51,13.53 68.48,13.53 68.44,13.53 68.41,13.53 68.37,13.53 68.33,13.53 68.30,13.53 68.26,13.53 68.23,13.53 68.19,13.53 68.15,13.53 68.12,13.53 68.08,13.53 68.05,13.53 68.01,13.53 67.97,13.53 67.94,13.53 67.90,13.53 67.87,13.53 67.83,13.53 67.79,13.53 67.76,13.53 67.72,13.53 67.69,13.53 67.65,13.53 67.61,13.53 67.58,13.53 67.54,13.53 67.51,13.53 67.47,13.53 67.43,13.53 67.40,13.53 67.36,13.53 67.33,13.53 67.29,13.53 67.25,13.53 67.22,13.53 67.18,13.53 67.15,13.53 67.11,13.53 67.07,13.53 67.04,13.53 67.00,13.53 66.97,13.53 66.93,13.53 66.89,13.53 66.86,13.53 66.82,13.53 66.79,13.53 66.75,13.53 66.71,13.53 66.68,13.53 66.64,13.53 66.61,13.53 66.57,13.53 66.53,13.53 66.50,13.53 66.46,13.53 66.43,13.53 66.39,13.53 66.35,13.53 66.32,13.53 66.28,13.53 66.25,13.53 66.21,13.53 66.18,13.53 66.14,13.53 66.10,13.53 66.07,13.53 66.03,13.53 66.00,13.53 65.96,13.53 65.92,13.53 65.89,13.53 65.85,13.53 65.82,13.53 65.78,13.53 65.74,13.53 65.71,13.53 65.67,13.53 65.64,13.53 65.60,13.53 65.56,13.53 65.53,13.53 65.49,13.53 65.46,13.53 65.42,13.53 65.38,13.53 65.35,13.53 65.31,13.53 65.28,13.53 65.24,13.53 65.20,13.53 65.17,13.53 65.13,13.53 65.10,13.53 65.06,13.53 65.02,13.53 64.99,13.53 64.95,13.53 64.92,13.53 64.88,13.53 64.84,13.53 64.81,13.53 64.77,13.53 64.74,13.53 64.70,13.53 64.66,13.53 64.63,13.53 64.59,13.53 64.56,13.53 64.52,13.53 64.48,13.53 64.45,13.53 64.41,13.53 64.38,13.53 64.34,13.53 64.30,13.53 64.27,13.53 64.23,13.53 64.20,13.53 64.16,13.53 64.12,13.53 64.09,13.53 64.05,13.53 64.02,13.53 63.98,13.53 63.95,13.53 63.91,13.53 63.87,13.53 63.84,13.53 63.80,13.53 63.77,13.53 63.73,13.53 63.69,13.53 63.66,13.53 63.62,13.53 63.59,13.53 63.55,13.53 63.51,13.53 63.48,13.53 63.44,13.53 63.41,13.53 63.37,13.53 63.33,13.53 63.30,13.53 63.26,13.53 63.23,13.53 63.19,13.53 63.15,13.53 63.12,13.53 63.08,13.53 63.05,13.53 63.01,13.53 62.97,13.53 62.94,13.53 62.90,13.53 62.87,13.53 62.83,13.53 62.79,13.53 62.76,13.53 62.72,13.53 62.69,13.53 62.65,13.53 62.61,13.53 62.58,13.53 62.54,13.53 62.51,13.53 62.47,13.53 62.43,13.53 62.40,13.53 62.36,13.53 62.33,13.53 62.29,13.53 62.25,13.53 62.22,13.53 62.18,13.53 62.15,13.53 62.11,13.53 62.07,13.53 62.04,13.53 62.00,13.53 61.97,13.53 61.93,13.53 61.89,13.53 61.86,13.53 61.82,13.53 61.79,13.53 61.75,13.53 61.71,13.53 61.68,13.53 61.64,13.53 61.61,13.53 61.57,13.53 61.54,13.53 61.50,13.53 61.46,13.53 61.43,13.53 61.39,13.53 61.36,13.53 61.32,13.53 61.28,13.53 61.25,13.53 61.21,13.53 61.18,13.53 61.14,13.53 61.10,13.53 61.07,13.53 61.03,13.53 61.00,13.53 60.96,13.53 60.92,13.53 60.89,13.53 60.85,13.53 60.82,13.53 60.78,13.53 60.74,13.53 60.71,13.53 60.67,13.53 60.64,13.53 60.60,13.53 60.56,13.53 60.53,13.53 60.49,13.53 60.46,13.53 60.42,13.53 60.38,13.53 60.35,13.53 60.31,13.53 60.28,13.53 60.24,13.53 60.20,13.53 60.17,13.53 60.13,13.53 60.10,13.53 60.06,13.53 60.02,13.53 59.99,13.53 59.95,13.53 59.92,13.53 59.88,13.53 59.84,13.53 59.81,13.53 59.77,13.53 59.74,13.53 59.70,13.53 59.66,13.53 59.63,13.53 59.59,13.53 59.56,13.53 59.52,13.53 59.48,13.53 59.45,13.53 59.41,13.53 59.38,13.53 59.34,13.53 59.31,13.53 59.27,13.53 59.23,13.53 59.20,13.53 59.16,13.53 59.13,13.53 59.09,13.53 59.05,13.53 59.02,13.53 58.98,13.53 58.95,13.53 58.91,13.53 58.87,13.53 58.84,13.53 58.80,13.53 58.77,13.53 58.73,13.53 58.69,13.53 58.66,13.53 58.62,13.53 58.59,13.53 58.55,13.53 58.51,13.53 58.48,13.53 58.44,13.53 58.41,13.53 58.37,13.53 58.33,13.53 58.30,13.53 58.26,13.53 58.23,13.53 58.19,13.53 58.15,13.53 58.12,13.53 58.08,13.53 58.05,13.53 58.01,13.53 57.97,13.53 57.94,13.53 57.90,13.53 57.87,13.53 57.83,13.53 57.79,13.53 57.76,13.53 57.72,13.53 57.69,13.53 57.65,13.53 57.61,13.53 57.58,13.53 57.54,13.53 57.51,13.53 57.47,13.53 57.43,13.53 57.40,13.53 57.36,13.53 57.33,13.53 57.29,13.53 57.25,13.53 57.22,13.53 57.18,13.53 57.15,13.53 57.11,13.53 57.08,13.53 57.04,13.53 57.00,13.53 56.97,13.53 56.93,13.53 56.90,13.53 56.86,13.53 56.82,13.53 56.79,13.53 56.75,13.53 56.72,13.53 56.68,13.53 56.64,13.53 56.61,13.53 56.57,13.53 56.54,13.53 56.50,13.53 56.46,13.53 56.43,13.53 56.39,13.53 56.36,13.53 56.32,13.53 56.28,13.53 56.25,13.53 56.21,13.53 56.18,13.53 56.14,13.53 56.10,13.53 56.07,13.53 56.03,13.53 56.00,13.53 55.96,13.53 55.92,13.53 55.89,13.53 55.85,13.53 55.82,13.53 55.78,13.53 55.74,13.53 55.71,13.53 55.67,13.53 55.64,13.53 55.60,13.53 55.56,13.53 55.53,13.53 55.49,13.53 55.46,13.53 55.42,13.53 55.38,13.53 55.35,13.53 55.31,13.53 55.28,13.53 55.24,13.53 55.20,13.53 55.17,13.53 55.13,13.53 55.10,13.53 55.06,13.53 55.02,13.53 54.99,13.53 54.95,13.53 54.92,13.53 54.88,13.53 54.84,13.53 54.81,13.53 54.77,13.53 54.74,13.53 54.70,13.53 54.67,13.53 54.63,13.53 54.59,13.53 54.56,13.53 54.52,13.53 54.49,13.53 54.45,13.53 54.41,13.53 54.38,13.53 54.34,13.53 54.31,13.53 54.27,13.53 54.23,13.53 54.20,13.53 54.16,13.53 54.13,13.53 54.09,13.53 54.05,13.53 54.02,13.53 53.98,13.53 53.95,13.53 53.91,13.53 53.87,13.53 53.84,13.53 53.80,13.53 53.77,13.53 53.73,13.53 53.69,13.53 53.66,13.53 53.62,13.53 53.59,13.53 53.55,13.53 53.51,13.53 53.48,13.53 53.44,13.53 53.41,13.53 53.37,13.53 53.33,13.53 53.30,13.53 53.26,13.53 53.23,13.53 53.19,13.53 53.15,13.53 53.12,13.53 53.08,13.53 53.05,13.53 53.01,13.53 52.97,13.53 52.94,13.53 52.90,13.53 52.87,13.53 52.83,13.53 52.79,13.53 52.76,13.53 52.72,13.53 52.69,13.53 52.65,13.53 52.61,13.53 52.58,13.53 52.54,13.53 52.51,13.53 52.47,13.53 52.44,13.53 52.40,13.53 52.36,13.53 52.33,13.53 52.29,13.53 52.26,13.53 52.22,13.53 52.18,13.53 52.15,13.53 52.11,13.53 52.08,13.53 52.04,13.53 52.00,13.53 51.97,13.53 51.93,13.53 51.90,13.53 51.86,13.53 51.82,13.53 51.79,13.53 51.75,13.53 51.72,13.53 51.68,13.53 51.64,13.53 51.61,13.53 51.57,13.53 51.54,13.53 51.50,13.53 51.46,13.53 51.43,13.53 51.39,13.53 51.36,13.53 51.32,13.53 51.28,13.53 51.25,13.53 51.21,13.53 51.18,13.53 51.14,13.53 51.10,13.53 51.07,13.53 51.03,13.53 51.00,13.53 50.96,13.53 50.92,13.53 50.89,13.53 50.85,13.53 50.82,13.53 50.78,13.53 50.74,13.53 50.71,13.53 50.67,13.53 50.64,13.53 50.60,13.53 50.56,13.53 50.53,13.53 50.49,13.53 50.46,13.53 50.42,13.53 50.38,13.53 50.35,13.53 50.31,13.53 50.28,13.53 50.24,13.53 50.21,13.53 50.17,13.53 50.13,13.53 50.10,13.53 50.06,13.53 50.03,13.53 49.99,13.53 49.95,13.53 49.92,13.53 49.88,13.53 49.85,13.53 49.81,13.53 49.77,13.53 49.74,13.53 49.70,13.53 49.67,13.53 49.63,13.53 49.59,13.53 49.56,13.53 49.52,13.53 49.49,13.53 49.45,13.53 49.41,13.53 49.38,13.53 49.34,13.53 49.31,13.53 49.27,13.53 49.23,13.53 49.20,13.53 49.16,13.53 49.13,13.53 49.09,13.53 49.05,13.53 49.02,13.53 48.98,13.53 48.95,13.53 48.91,13.53 48.87,13.53 48.84,13.53 48.80,13.53 48.77,13.53 48.73,13.53 48.69,13.53 48.66,13.53 48.62,13.53 48.59,13.53 48.55,13.53 48.51,13.53 48.48,13.53 48.44,13.53 48.41,13.53 48.37,13.53 48.33,13.53 48.30,13.53 48.26,13.53 48.23,13.53 48.19,13.53 48.15,13.53 48.12,13.53 48.08,13.53 48.05,13.53 48.01,13.53 47.97,13.53 47.94,13.53 47.90,13.53 47.87,13.53 47.83,13.53 47.80,13.53 47.76,13.53 47.72,13.53 47.69,13.53 47.65,13.53 47.62,13.53 47.58,13.53 47.54,13.53 47.51,13.53 47.47,13.53 47.44,13.53 47.40,13.53 47.36,13.53 47.33,13.53 47.29,13.53 47.26,13.53 47.22,13.53 47.18,13.53 47.15,13.53 47.11,13.53 47.08,13.53 47.04,13.53 47.00,13.53 46.97,13.53 46.93,13.53 46.90,13.53 46.86,13.53 46.82,13.53 46.79,13.53 46.75,13.53 46.72,13.53 46.68,13.53 46.64,13.53 46.61,13.53 46.57,13.53 46.54,13.53 46.50,13.53 46.46,13.53 46.43,13.53 46.39,13.53 46.36,13.53 46.32,13.53 46.28,13.53 46.25,13.53 46.21,13.53 46.18,13.53 46.14,13.53 46.10,13.53 46.07,13.53 46.03,13.53 46.00,13.53 45.96,13.53 45.92,13.53 45.89,13.53 45.85,13.53 45.82,13.53 45.78,13.53 45.74,13.53 45.71,13.53 45.67,13.53 45.64,13.53 45.60,13.53 45.57,13.53 45.53,13.53 45.49,13.53 45.46,13.53 45.42,13.53 45.39,13.53 45.35,13.53 45.31,13.53 45.28,13.53 45.24,13.53 45.21,13.53 45.17,13.53 45.13,13.53 45.10,13.53 45.06,13.53 45.03,13.53 44.99,13.53 44.95,13.53 44.92,13.53 44.88,13.53 44.85,13.53 44.81,13.53 44.77,13.53 44.74,13.53 44.70,13.53 44.67,13.53 44.63,13.53 44.59,13.53 44.56,13.53 44.52,13.53 44.49,13.53 44.45,13.53 44.41,13.53 44.38,13.53 44.34,13.53 44.31,13.53 44.27,13.53 44.23,13.53 44.20,13.53 44.16,13.53 44.13,13.53 44.09,13.53 44.05,13.53 44.02,13.53 43.98,13.53 43.95,13.53 43.91,13.53 43.87,13.53 43.84,13.53 43.80,13.53 43.77,13.53 43.73,13.53 43.69,13.53 43.66,13.53 43.62,13.53 43.59,13.53 43.55,13.53 43.51,13.53 43.48,13.53 43.44,13.53 43.41,13.53 43.37,13.53 43.34,13.53 43.30,13.53 43.26,13.53 43.23,13.53 43.19,13.53 43.16,13.53 43.12,13.53 43.08,13.53 43.05,13.53 43.01,13.53 42.98,13.53 42.94,13.53 42.90,13.53 42.87,13.53 42.83,13.53 42.80,13.53 42.76,13.53 42.72,13.53 42.69,13.53 42.65,13.53 42.62,13.53 42.58,13.53 42.54,13.53 42.51,13.53 42.47,13.53 42.44,13.53 42.40,13.53 42.36,13.53 42.33,13.53 42.29,13.53 42.26,13.53 42.22,13.53 42.18,13.53 42.15,13.53 42.11,13.53 42.08,13.53 42.04,13.53 42.00,13.53 41.97,13.53 41.93,13.53 41.90,13.53 41.86,13.53 41.82,13.53 41.79,13.53 41.75,13.53 41.72,13.53 41.68,13.53 41.64,13.53 41.61,13.53 41.57,13.53 41.54,13.53 41.50,13.53 41.46,13.53 41.43,13.53 41.39,13.53 41.36,13.53 41.32,13.53 41.28,13.53 41.25,13.53 41.21,13.53 41.18,13.53 41.14,13.53 41.10,13.53 41.07,13.53 41.03,13.53 41.00,13.53 40.96,13.53 40.93,13.53 40.89,13.53 40.85,13.53 40.82,13.53 40.78,13.53 40.75,13.53 40.71,13.53 40.67,13.53 40.64,13.53 40.60,13.53 40.57,13.53 40.53,13.53 40.49,13.53 40.46,13.53 40.42,13.53 40.39,13.53 40.35,13.53 40.31,13.53 40.28,13.53 40.24,13.53 40.21,13.53 40.17,13.53 40.13,13.53 40.10,13.53 40.06,13.53 40.03,13.53 39.99,13.53 39.95,13.53 39.92,13.53 39.88,13.53 39.85,13.53 39.81,13.53 39.77,13.53 39.74,13.53 39.70,13.53 39.67,13.53 39.63,13.53 39.59,13.53 39.56,13.53 39.52,13.53 39.49,13.53 39.45,13.53 39.41,13.53 39.38,13.53 39.34,13.53 39.31,13.53 39.27,13.53 39.23,13.53 39.20,13.53 39.16,13.53 39.13,13.53 39.09,13.53 39.05,13.53 39.02,13.53 38.98,13.53 38.95,13.53 38.91,13.53 38.87,13.53 38.84,13.53 38.80,13.53 38.77,13.53 38.73,13.53 38.70,13.53 38.66,13.53 38.62,13.53 38.59,13.53 38.55,13.53 38.52,13.53 38.48,13.53 38.44,13.53 38.41,13.53 38.37,13.53 38.34,13.53 38.30,13.53 38.26,13.53 38.23,13.53 38.19,13.53 38.16,13.53 38.12,13.53 38.08,13.53 38.05,13.53 38.01,13.53 37.98,13.53 37.94,13.53 37.90,13.53 37.87,13.53 37.83,13.53 37.80,13.53 37.76,13.53 37.72,13.53 37.69,13.53 37.65,13.53 37.62,13.53 37.58,13.53 37.54,13.53 37.51,13.53 37.47,13.53 37.44,13.53 37.40,13.53 37.36,13.53 37.33,13.53 37.29,13.53 37.26,13.53 37.22,13.53 37.18,13.53 37.15,13.53 37.11,13.53 37.08,13.53 37.04,13.53 37.00,13.53 36.97,13.53 36.93,13.53 36.90,13.53 36.86,13.53 36.82,13.53 36.79,13.53 36.75,13.53 36.72,13.53 36.68,13.53 36.64,13.53 36.61,13.53 36.57,13.53 36.54,13.53 36.50,13.53 36.47,13.53 36.43,13.53 36.39,13.53 36.36,13.53 36.32,13.53 36.29,13.53 36.25,13.53 36.21,13.53 36.18,13.53 36.14,13.53 36.11,13.53 36.07,13.53 36.03,13.53 36.00,13.53 35.96,13.53 35.93,13.53 35.89,13.53 35.85,13.53 35.82,13.53 35.78,13.53 35.75,13.53 35.71,13.53 35.67,13.53 35.64,13.53 35.60,13.53 35.57,13.53 35.53,13.53 35.49,13.53 35.46,13.53 35.42,13.53 35.39,13.53 35.35,13.53 35.31,13.53 35.28,13.53 35.24,13.53 35.21,13.53 35.17,13.53 35.13,13.53 35.10,13.53 35.06,13.53 35.03,13.53 34.99,13.53 34.95,13.53 34.92,13.53 34.88,13.53 34.85,13.53 34.81,13.53 34.77,13.53 34.74,13.53 34.70,13.53 34.67,13.53 34.63,13.53 34.59,13.53 34.56,13.53 34.52,13.53 34.49,13.53 34.45,13.53 34.41,13.53 34.38,13.53 34.34,13.53 34.31,13.53 34.27,13.53 34.23,13.53 34.20,13.53 34.16,13.53 34.13,13.53 34.09,13.53 34.06,13.53 34.02,13.53 33.98,13.53 33.95,13.53 33.91,13.53 33.88,13.53 33.84,13.53 33.80,13.53 33.77,13.53 33.73,13.53 33.70,13.53 33.66,13.53 33.62,13.53 33.59,13.53 33.55,13.53 33.52,13.53 33.48,13.53 33.44,13.53 33.41,13.53 33.37,13.53 33.34,13.53 33.30,13.53 33.26,13.53 33.23,13.53 33.19,13.53 33.16,13.53 33.12,13.53 33.08,13.53 33.05,13.53 33.01,13.53 32.98,13.53 32.94,13.53 32.90,13.53 32.87,13.53 32.83,13.53 32.80,13.53 32.76,13.53 32.72,13.53 32.69,13.53 32.65,13.53 32.62,13.53 32.58,13.53 32.54,13.53 32.51,13.53 32.47,13.53 32.44,13.53 32.40,13.53 32.36,13.53 32.33,13.53 32.29,13.53 32.26,13.53 32.22,13.53 32.18,13.53 32.15,13.53 32.11,13.53 32.08,13.53 32.04,13.53 32.00,13.53 31.97,13.53 31.93,13.53 31.90,13.53 31.86,13.53 31.83,13.53 31.79,13.53 31.75,13.53 31.72,13.53 31.68,13.53 31.65,13.53 31.61,13.53 31.57,13.53 31.54,13.53 31.50,13.53 31.47,13.53 31.43,13.53 31.39,13.53 31.36,13.53 31.32,13.53 31.29,13.53 31.25,13.53 31.21,13.53 31.18,13.53 31.14,13.53 31.11,13.53 31.07,13.53 31.03,13.53 31.00,13.53 30.96,13.53 30.93,13.53 30.89,13.53 30.85,13.53 30.82,13.53 30.78,13.53 30.75,13.53 30.71,13.53 30.67,13.53 30.64,13.53 30.60,13.53 30.57,13.53 30.53,13.53 30.49,13.53 30.46,13.53 30.42,13.53 30.39,13.53 30.35,13.53 30.31,13.53 30.28,13.53 30.24,13.53 30.21,13.53 30.17,13.53 30.13,13.53 30.10,13.53 30.06,13.53 30.03,13.53 29.99,13.53 29.95,13.53 29.92,13.53 29.88,13.53 29.85,13.53 29.81,13.53 29.77,13.53 29.74,13.53 29.70,13.53 29.67,13.53 29.63,13.53 29.60,13.53 29.56,13.53 29.52,13.53 29.49,13.53 29.45,13.53 29.42,13.53 29.38,13.53 29.34,13.53 29.31,13.53 29.27,13.53 29.24,13.53 29.20,13.53 29.16,13.53 29.13,13.53 29.09,13.53 29.06,13.53 29.02,13.53 28.98,13.53 28.95,13.53 28.91,13.53 28.88,13.53 28.84,13.53 28.80,13.53 28.77,13.53 28.73,13.53 28.70,13.53 28.66,13.53 28.62,13.53 28.59,13.53 28.55,13.53 28.52,13.53 28.48,13.53 28.44,13.53 28.41,13.53 28.37,13.53 28.34,13.53 28.30,13.53 28.26,13.53 28.23,13.53 28.19,13.53 28.16,13.53 28.12,13.53 28.08,13.53 28.05,13.53 28.01,13.53 27.98,13.53 27.94,13.53 27.90,13.53 27.87,13.53 27.83,13.53 27.80,13.53 27.76,13.53 27.72,13.53 27.69,13.53 27.65,13.53 27.62,13.53 27.58,13.53 27.54,13.53 27.51,13.53 27.47,13.53 27.44,13.53 27.40,13.53 27.36,13.53 27.33,13.53 27.29,13.53 27.26,13.53 27.22,13.53 27.19,13.53 27.15,13.53 27.11,13.53 27.08,13.53 27.04,13.53 27.01,13.53 26.97,13.53 26.93,13.53 26.90,13.53 26.86,13.53 26.83,13.53 26.79,13.53 26.75,13.53 26.72,13.53 26.68,13.53 26.65,13.53 26.61,13.53 26.57,13.53 26.54,13.53 26.50,13.53 26.47,13.53 26.43,13.53 26.39,13.53 26.36,13.53 26.32,13.53 26.29,13.53 26.25,13.53 26.21,13.53 26.18,13.53 26.14,13.53 26.11,13.53 26.07,13.53 26.03,13.53 " style="stroke-width: 0.00; stroke: none; stroke-linecap: butt; fill: #BEBEBE;"></polygon><polyline points="26.03,13.47 26.07,13.47 26.11,13.47 26.14,13.46 26.18,13.46 26.21,13.46 26.25,13.46 26.29,13.46 26.32,13.46 26.36,13.46 26.39,13.45 26.43,13.45 26.47,13.45 26.50,13.45 26.54,13.45 26.57,13.44 26.61,13.44 26.65,13.44 26.68,13.44 26.72,13.44 26.75,13.44 26.79,13.43 26.83,13.43 26.86,13.43 26.90,13.43 26.93,13.42 26.97,13.42 27.01,13.42 27.04,13.42 27.08,13.42 27.11,13.41 27.15,13.41 27.19,13.41 27.22,13.41 27.26,13.40 27.29,13.40 27.33,13.40 27.36,13.40 27.40,13.39 27.44,13.39 27.47,13.39 27.51,13.38 27.54,13.38 27.58,13.38 27.62,13.37 27.65,13.37 27.69,13.37 27.72,13.36 27.76,13.36 27.80,13.36 27.83,13.35 27.87,13.35 27.90,13.35 27.94,13.34 27.98,13.34 28.01,13.34 28.05,13.33 28.08,13.33 28.12,13.33 28.16,13.32 28.19,13.32 28.23,13.31 28.26,13.31 28.30,13.30 28.34,13.30 28.37,13.30 28.41,13.29 28.44,13.29 28.48,13.28 28.52,13.28 28.55,13.27 28.59,13.27 28.62,13.26 28.66,13.26 28.70,13.25 28.73,13.25 28.77,13.24 28.80,13.24 28.84,13.23 28.88,13.23 28.91,13.22 28.95,13.21 28.98,13.21 29.02,13.20 29.06,13.20 29.09,13.19 29.13,13.18 29.16,13.18 29.20,13.17 29.24,13.16 29.27,13.16 29.31,13.15 29.34,13.14 29.38,13.14 29.42,13.13 29.45,13.12 29.49,13.12 29.52,13.11 29.56,13.10 29.60,13.09 29.63,13.09 29.67,13.08 29.70,13.07 29.74,13.06 29.77,13.05 29.81,13.05 29.85,13.04 29.88,13.03 29.92,13.02 29.95,13.01 29.99,13.00 30.03,12.99 30.06,12.98 30.10,12.98 30.13,12.97 30.17,12.96 30.21,12.95 30.24,12.94 30.28,12.93 30.31,12.92 30.35,12.91 30.39,12.90 30.42,12.89 30.46,12.88 30.49,12.87 30.53,12.85 30.57,12.84 30.60,12.83 30.64,12.82 30.67,12.81 30.71,12.80 30.75,12.79 30.78,12.77 30.82,12.76 30.85,12.75 30.89,12.74 30.93,12.72 30.96,12.71 31.00,12.70 31.03,12.69 31.07,12.67 31.11,12.66 31.14,12.65 31.18,12.63 31.21,12.62 31.25,12.60 31.29,12.59 31.32,12.58 31.36,12.56 31.39,12.55 31.43,12.53 31.47,12.52 31.50,12.50 31.54,12.49 31.57,12.47 31.61,12.45 31.65,12.44 31.68,12.42 31.72,12.41 31.75,12.39 31.79,12.37 31.83,12.36 31.86,12.34 31.90,12.32 31.93,12.30 31.97,12.29 32.00,12.27 32.04,12.25 32.08,12.23 32.11,12.21 32.15,12.19 32.18,12.18 32.22,12.16 32.26,12.14 32.29,12.12 32.33,12.10 32.36,12.08 32.40,12.06 32.44,12.04 32.47,12.02 32.51,12.00 32.54,11.98 32.58,11.95 32.62,11.93 32.65,11.91 32.69,11.89 32.72,11.87 32.76,11.84 32.80,11.82 32.83,11.80 32.87,11.78 32.90,11.75 32.94,11.73 32.98,11.71 33.01,11.68 33.05,11.66 33.08,11.63 33.12,11.61 33.16,11.59 33.19,11.56 33.23,11.54 33.26,11.51 33.30,11.48 33.34,11.46 33.37,11.43 33.41,11.41 33.44,11.38 33.48,11.35 33.52,11.33 33.55,11.30 33.59,11.27 33.62,11.24 33.66,11.22 33.70,11.19 33.73,11.16 33.77,11.13 33.80,11.10 33.84,11.07 33.88,11.04 33.91,11.01 33.95,10.98 33.98,10.95 34.02,10.92 34.06,10.89 34.09,10.86 34.13,10.83 34.16,10.80 34.20,10.77 34.23,10.74 34.27,10.71 34.31,10.67 34.34,10.64 34.38,10.61 34.41,10.58 34.45,10.54 34.49,10.51 34.52,10.48 34.56,10.44 34.59,10.41 34.63,10.37 34.67,10.34 34.70,10.31 34.74,10.27 34.77,10.24 34.81,10.20 34.85,10.17 34.88,10.13 34.92,10.09 34.95,10.06 34.99,10.02 35.03,9.98 35.06,9.95 35.10,9.91 35.13,9.87 35.17,9.84 35.21,9.80 35.24,9.76 35.28,9.72 35.31,9.68 35.35,9.65 35.39,9.61 35.42,9.57 35.46,9.53 35.49,9.49 35.53,9.45 35.57,9.41 35.60,9.37 35.64,9.33 35.67,9.29 35.71,9.25 35.75,9.21 35.78,9.17 35.82,9.13 35.85,9.08 35.89,9.04 35.93,9.00 35.96,8.96 36.00,8.92 36.03,8.87 36.07,8.83 36.11,8.79 36.14,8.75 36.18,8.70 36.21,8.66 36.25,8.62 36.29,8.57 36.32,8.53 36.36,8.49 36.39,8.44 36.43,8.40 36.47,8.35 36.50,8.31 36.54,8.27 36.57,8.22 36.61,8.18 36.64,8.13 36.68,8.09 36.72,8.04 36.75,8.00 36.79,7.95 36.82,7.90 36.86,7.86 36.90,7.81 36.93,7.77 36.97,7.72 37.00,7.67 37.04,7.63 37.08,7.58 37.11,7.54 37.15,7.49 37.18,7.44 37.22,7.40 37.26,7.35 37.29,7.30 37.33,7.25 37.36,7.21 37.40,7.16 37.44,7.11 37.47,7.07 37.51,7.02 37.54,6.97 37.58,6.92 37.62,6.87 37.65,6.83 37.69,6.78 37.72,6.73 37.76,6.68 37.80,6.64 37.83,6.59 37.87,6.54 37.90,6.49 37.94,6.44 37.98,6.40 38.01,6.35 38.05,6.30 38.08,6.25 38.12,6.20 38.16,6.16 38.19,6.11 38.23,6.06 38.26,6.01 38.30,5.96 38.34,5.91 38.37,5.87 38.41,5.82 38.44,5.77 38.48,5.72 38.52,5.67 38.55,5.63 38.59,5.58 38.62,5.53 38.66,5.48 38.70,5.44 38.73,5.39 38.77,5.34 38.80,5.29 38.84,5.25 38.87,5.20 38.91,5.15 38.95,5.10 38.98,5.06 39.02,5.01 39.05,4.96 39.09,4.91 39.13,4.87 39.16,4.82 39.20,4.77 39.23,4.73 39.27,4.68 39.31,4.63 39.34,4.59 39.38,4.54 39.41,4.50 39.45,4.45 39.49,4.41 39.52,4.36 39.56,4.31 39.59,4.27 39.63,4.22 39.67,4.18 39.70,4.13 39.74,4.09 39.77,4.04 39.81,4.00 39.85,3.96 39.88,3.91 39.92,3.87 39.95,3.82 39.99,3.78 40.03,3.74 40.06,3.70 40.10,3.65 40.13,3.61 40.17,3.57 40.21,3.53 40.24,3.48 40.28,3.44 40.31,3.40 40.35,3.36 40.39,3.32 40.42,3.28 40.46,3.24 40.49,3.19 40.53,3.15 40.57,3.12 40.60,3.08 40.64,3.04 40.67,3.00 40.71,2.96 40.75,2.92 40.78,2.88 40.82,2.84 40.85,2.80 40.89,2.77 40.93,2.73 40.96,2.69 41.00,2.66 41.03,2.62 41.07,2.58 41.10,2.55 41.14,2.51 41.18,2.48 41.21,2.44 41.25,2.40 41.28,2.37 41.32,2.34 41.36,2.30 41.39,2.27 41.43,2.24 41.46,2.20 41.50,2.17 41.54,2.14 41.57,2.10 41.61,2.07 41.64,2.04 41.68,2.01 41.72,1.98 41.75,1.95 41.79,1.92 41.82,1.89 41.86,1.86 41.90,1.83 41.93,1.80 41.97,1.77 42.00,1.75 42.04,1.72 42.08,1.69 42.11,1.66 42.15,1.64 42.18,1.61 42.22,1.58 42.26,1.56 42.29,1.53 42.33,1.51 42.36,1.48 42.40,1.46 42.44,1.43 42.47,1.41 42.51,1.39 42.54,1.36 42.58,1.34 42.62,1.32 42.65,1.30 42.69,1.28 42.72,1.26 42.76,1.23 42.80,1.21 42.83,1.19 42.87,1.17 42.90,1.16 42.94,1.14 42.98,1.12 43.01,1.10 43.05,1.08 43.08,1.06 43.12,1.05 43.16,1.03 43.19,1.01 43.23,1.00 43.26,0.98 43.30,0.97 43.34,0.95 43.37,0.94 43.41,0.92 43.44,0.91 43.48,0.90 43.51,0.88 43.55,0.87 43.59,0.86 43.62,0.84 43.66,0.83 43.69,0.82 43.73,0.81 43.77,0.80 43.80,0.79 43.84,0.78 43.87,0.77 43.91,0.76 43.95,0.75 43.98,0.74 44.02,0.74 44.05,0.73 44.09,0.72 44.13,0.71 44.16,0.71 44.20,0.70 44.23,0.70 44.27,0.69 44.31,0.68 44.34,0.68 44.38,0.67 44.41,0.67 44.45,0.67 44.49,0.66 44.52,0.66 44.56,0.66 44.59,0.65 44.63,0.65 44.67,0.65 44.70,0.65 44.74,0.65 44.77,0.65 44.81,0.64 44.85,0.64 44.88,0.64 44.92,0.64 44.95,0.65 44.99,0.65 45.03,0.65 45.06,0.65 45.10,0.65 45.13,0.65 45.17,0.65 45.21,0.66 45.24,0.66 45.28,0.66 45.31,0.67 45.35,0.67 45.39,0.68 45.42,0.68 45.46,0.68 45.49,0.69 45.53,0.70 45.57,0.70 45.60,0.71 45.64,0.71 45.67,0.72 45.71,0.73 45.74,0.73 45.78,0.74 45.82,0.75 45.85,0.75 45.89,0.76 45.92,0.77 45.96,0.78 46.00,0.79 46.03,0.80 46.07,0.81 46.10,0.81 46.14,0.82 46.18,0.83 46.21,0.84 46.25,0.86 46.28,0.87 46.32,0.88 46.36,0.89 46.39,0.90 46.43,0.91 46.46,0.92 46.50,0.93 46.54,0.95 46.57,0.96 46.61,0.97 46.64,0.98 46.68,1.00 46.72,1.01 46.75,1.02 46.79,1.03 46.82,1.05 46.86,1.06 46.90,1.08 46.93,1.09 46.97,1.10 47.00,1.12 47.04,1.13 47.08,1.15 47.11,1.16 47.15,1.18 47.18,1.19 47.22,1.21 47.26,1.22 47.29,1.24 47.33,1.25 47.36,1.27 47.40,1.29 47.44,1.30 47.47,1.32 47.51,1.34 47.54,1.35 47.58,1.37 47.62,1.39 47.65,1.40 47.69,1.42 47.72,1.44 47.76,1.45 47.80,1.47 47.83,1.49 47.87,1.51 47.90,1.52 47.94,1.54 47.97,1.56 48.01,1.58 48.05,1.59 48.08,1.61 48.12,1.63 48.15,1.65 48.19,1.67 48.23,1.69 48.26,1.70 48.30,1.72 48.33,1.74 48.37,1.76 48.41,1.78 48.44,1.80 48.48,1.81 48.51,1.83 48.55,1.85 48.59,1.87 48.62,1.89 48.66,1.91 48.69,1.93 48.73,1.95 48.77,1.97 48.80,1.99 48.84,2.00 48.87,2.02 48.91,2.04 48.95,2.06 48.98,2.08 49.02,2.10 49.05,2.12 49.09,2.14 49.13,2.16 49.16,2.18 49.20,2.20 49.23,2.21 49.27,2.23 49.31,2.25 49.34,2.27 49.38,2.29 49.41,2.31 49.45,2.33 49.49,2.35 49.52,2.37 49.56,2.39 49.59,2.41 49.63,2.43 49.67,2.44 49.70,2.46 49.74,2.48 49.77,2.50 49.81,2.52 49.85,2.54 49.88,2.56 49.92,2.58 49.95,2.59 49.99,2.61 50.03,2.63 50.06,2.65 50.10,2.67 50.13,2.69 50.17,2.71 50.21,2.72 50.24,2.74 50.28,2.76 50.31,2.78 50.35,2.80 50.38,2.81 50.42,2.83 50.46,2.85 50.49,2.87 50.53,2.89 50.56,2.90 50.60,2.92 50.64,2.94 50.67,2.96 50.71,2.97 50.74,2.99 50.78,3.01 50.82,3.02 50.85,3.04 50.89,3.06 50.92,3.08 50.96,3.09 51.00,3.11 51.03,3.12 51.07,3.14 51.10,3.16 51.14,3.17 51.18,3.19 51.21,3.21 51.25,3.22 51.28,3.24 51.32,3.25 51.36,3.27 51.39,3.28 51.43,3.30 51.46,3.31 51.50,3.33 51.54,3.34 51.57,3.36 51.61,3.37 51.64,3.39 51.68,3.40 51.72,3.42 51.75,3.43 51.79,3.45 51.82,3.46 51.86,3.47 51.90,3.49 51.93,3.50 51.97,3.52 52.00,3.53 52.04,3.54 52.08,3.56 52.11,3.57 52.15,3.58 52.18,3.59 52.22,3.61 52.26,3.62 52.29,3.63 52.33,3.64 52.36,3.66 52.40,3.67 52.44,3.68 52.47,3.69 52.51,3.70 52.54,3.72 52.58,3.73 52.61,3.74 52.65,3.75 52.69,3.76 52.72,3.77 52.76,3.78 52.79,3.79 52.83,3.80 52.87,3.81 52.90,3.82 52.94,3.83 52.97,3.84 53.01,3.85 53.05,3.86 53.08,3.87 53.12,3.88 53.15,3.89 53.19,3.90 53.23,3.91 53.26,3.92 53.30,3.93 53.33,3.93 53.37,3.94 53.41,3.95 53.44,3.96 53.48,3.97 53.51,3.97 53.55,3.98 53.59,3.99 53.62,4.00 53.66,4.00 53.69,4.01 53.73,4.02 53.77,4.02 53.80,4.03 53.84,4.04 53.87,4.04 53.91,4.05 53.95,4.06 53.98,4.06 54.02,4.07 54.05,4.07 54.09,4.08 54.13,4.08 54.16,4.09 54.20,4.10 54.23,4.10 54.27,4.10 54.31,4.11 54.34,4.11 54.38,4.12 54.41,4.12 54.45,4.13 54.49,4.13 54.52,4.14 54.56,4.14 54.59,4.14 54.63,4.15 54.67,4.15 54.70,4.15 54.74,4.16 54.77,4.16 54.81,4.16 54.84,4.17 54.88,4.17 54.92,4.17 54.95,4.17 54.99,4.18 55.02,4.18 55.06,4.18 55.10,4.18 55.13,4.19 55.17,4.19 55.20,4.19 55.24,4.19 55.28,4.19 55.31,4.19 55.35,4.20 55.38,4.20 55.42,4.20 55.46,4.20 55.49,4.20 55.53,4.20 55.56,4.20 55.60,4.20 55.64,4.20 55.67,4.20 55.71,4.20 55.74,4.21 55.78,4.21 55.82,4.21 55.85,4.21 55.89,4.21 55.92,4.21 55.96,4.21 56.00,4.21 56.03,4.21 56.07,4.20 56.10,4.20 56.14,4.20 56.18,4.20 56.21,4.20 56.25,4.20 56.28,4.20 56.32,4.20 56.36,4.20 56.39,4.20 56.43,4.20 56.46,4.20 56.50,4.20 56.54,4.20 56.57,4.19 56.61,4.19 56.64,4.19 56.68,4.19 56.72,4.19 56.75,4.19 56.79,4.19 56.82,4.18 56.86,4.18 56.90,4.18 56.93,4.18 56.97,4.18 57.00,4.18 57.04,4.18 57.08,4.17 57.11,4.17 57.15,4.17 57.18,4.17 57.22,4.17 57.25,4.17 57.29,4.16 57.33,4.16 57.36,4.16 57.40,4.16 57.43,4.16 57.47,4.15 57.51,4.15 57.54,4.15 57.58,4.15 57.61,4.15 57.65,4.15 57.69,4.14 57.72,4.14 57.76,4.14 57.79,4.14 57.83,4.14 57.87,4.14 57.90,4.13 57.94,4.13 57.97,4.13 58.01,4.13 58.05,4.13 58.08,4.13 58.12,4.13 58.15,4.12 58.19,4.12 58.23,4.12 58.26,4.12 58.30,4.12 58.33,4.12 58.37,4.12 58.41,4.12 58.44,4.12 58.48,4.11 58.51,4.11 58.55,4.11 58.59,4.11 58.62,4.11 58.66,4.11 58.69,4.11 58.73,4.11 58.77,4.11 58.80,4.11 58.84,4.11 58.87,4.11 58.91,4.11 58.95,4.11 58.98,4.11 59.02,4.11 59.05,4.11 59.09,4.11 59.13,4.11 59.16,4.11 59.20,4.11 59.23,4.11 59.27,4.11 59.31,4.11 59.34,4.11 59.38,4.12 59.41,4.12 59.45,4.12 59.48,4.12 59.52,4.12 59.56,4.12 59.59,4.12 59.63,4.13 59.66,4.13 59.70,4.13 59.74,4.13 59.77,4.14 59.81,4.14 59.84,4.14 59.88,4.14 59.92,4.15 59.95,4.15 59.99,4.15 60.02,4.16 60.06,4.16 60.10,4.16 60.13,4.17 60.17,4.17 60.20,4.17 60.24,4.18 60.28,4.18 60.31,4.19 60.35,4.19 60.38,4.20 60.42,4.20 60.46,4.21 60.49,4.21 60.53,4.22 60.56,4.22 60.60,4.23 60.64,4.23 60.67,4.24 60.71,4.24 60.74,4.25 60.78,4.26 60.82,4.26 60.85,4.27 60.89,4.28 60.92,4.28 60.96,4.29 61.00,4.30 61.03,4.31 61.07,4.31 61.10,4.32 61.14,4.33 61.18,4.34 61.21,4.35 61.25,4.35 61.28,4.36 61.32,4.37 61.36,4.38 61.39,4.39 61.43,4.40 61.46,4.41 61.50,4.42 61.54,4.43 61.57,4.44 61.61,4.45 61.64,4.46 61.68,4.47 61.71,4.48 61.75,4.49 61.79,4.50 61.82,4.51 61.86,4.52 61.89,4.54 61.93,4.55 61.97,4.56 62.00,4.57 62.04,4.58 62.07,4.60 62.11,4.61 62.15,4.62 62.18,4.64 62.22,4.65 62.25,4.66 62.29,4.68 62.33,4.69 62.36,4.70 62.40,4.72 62.43,4.73 62.47,4.75 62.51,4.76 62.54,4.78 62.58,4.79 62.61,4.81 62.65,4.82 62.69,4.84 62.72,4.85 62.76,4.87 62.79,4.89 62.83,4.90 62.87,4.92 62.90,4.94 62.94,4.95 62.97,4.97 63.01,4.99 63.05,5.00 63.08,5.02 63.12,5.04 63.15,5.06 63.19,5.08 63.23,5.09 63.26,5.11 63.30,5.13 63.33,5.15 63.37,5.17 63.41,5.19 63.44,5.21 63.48,5.23 63.51,5.25 63.55,5.27 63.59,5.29 63.62,5.31 63.66,5.33 63.69,5.35 63.73,5.37 63.77,5.39 63.80,5.41 63.84,5.43 63.87,5.45 63.91,5.47 63.95,5.49 63.98,5.52 64.02,5.54 64.05,5.56 64.09,5.58 64.12,5.61 64.16,5.63 64.20,5.65 64.23,5.67 64.27,5.70 64.30,5.72 64.34,5.74 64.38,5.77 64.41,5.79 64.45,5.81 64.48,5.84 64.52,5.86 64.56,5.89 64.59,5.91 64.63,5.93 64.66,5.96 64.70,5.98 64.74,6.01 64.77,6.03 64.81,6.06 64.84,6.08 64.88,6.11 64.92,6.14 64.95,6.16 64.99,6.19 65.02,6.21 65.06,6.24 65.10,6.27 65.13,6.29 65.17,6.32 65.20,6.34 65.24,6.37 65.28,6.40 65.31,6.42 65.35,6.45 65.38,6.48 65.42,6.51 65.46,6.53 65.49,6.56 65.53,6.59 65.56,6.62 65.60,6.64 65.64,6.67 65.67,6.70 65.71,6.73 65.74,6.76 65.78,6.78 65.82,6.81 65.85,6.84 65.89,6.87 65.92,6.90 65.96,6.93 66.00,6.95 66.03,6.98 66.07,7.01 66.10,7.04 66.14,7.07 66.18,7.10 66.21,7.13 66.25,7.16 66.28,7.19 66.32,7.22 66.35,7.25 66.39,7.27 66.43,7.30 66.46,7.33 66.50,7.36 66.53,7.39 66.57,7.42 66.61,7.45 66.64,7.48 66.68,7.51 66.71,7.54 66.75,7.57 66.79,7.60 66.82,7.63 66.86,7.66 66.89,7.69 66.93,7.72 66.97,7.75 67.00,7.78 67.04,7.81 67.07,7.84 67.11,7.87 67.15,7.90 67.18,7.94 67.22,7.97 67.25,8.00 67.29,8.03 67.33,8.06 67.36,8.09 67.40,8.12 67.43,8.15 67.47,8.18 67.51,8.21 67.54,8.24 67.58,8.27 67.61,8.30 67.65,8.33 67.69,8.36 67.72,8.39 67.76,8.42 67.79,8.45 67.83,8.48 67.87,8.52 67.90,8.55 67.94,8.58 67.97,8.61 68.01,8.64 68.05,8.67 68.08,8.70 68.12,8.73 68.15,8.76 68.19,8.79 68.23,8.82 68.26,8.85 68.30,8.88 68.33,8.91 68.37,8.94 68.41,8.97 68.44,9.00 68.48,9.03 68.51,9.06 68.55,9.09 68.58,9.12 68.62,9.15 68.66,9.18 68.69,9.21 68.73,9.24 68.76,9.27 68.80,9.30 68.84,9.33 68.87,9.36 68.91,9.39 68.94,9.42 68.98,9.45 69.02,9.48 69.05,9.51 69.09,9.53 69.12,9.56 69.16,9.59 69.20,9.62 69.23,9.65 69.27,9.68 69.30,9.71 69.34,9.74 69.38,9.77 69.41,9.79 69.45,9.82 69.48,9.85 69.52,9.88 69.56,9.91 69.59,9.94 69.63,9.96 69.66,9.99 69.70,10.02 69.74,10.05 69.77,10.08 69.81,10.10 69.84,10.13 69.88,10.16 69.92,10.19 69.95,10.21 69.99,10.24 70.02,10.27 70.06,10.29 70.10,10.32 70.13,10.35 70.17,10.37 70.20,10.40 70.24,10.43 70.28,10.45 70.31,10.48 70.35,10.51 70.38,10.53 70.42,10.56 70.46,10.58 70.49,10.61 70.53,10.64 70.56,10.66 70.60,10.69 70.64,10.71 70.67,10.74 70.71,10.76 70.74,10.79 70.78,10.81 70.81,10.84 70.85,10.86 70.89,10.88 70.92,10.91 70.96,10.93 70.99,10.96 71.03,10.98 71.07,11.01 71.10,11.03 71.14,11.05 71.17,11.08 71.21,11.10 71.25,11.12 71.28,11.15 71.32,11.17 71.35,11.19 71.39,11.21 71.43,11.24 71.46,11.26 71.50,11.28 71.53,11.30 71.57,11.33 71.61,11.35 71.64,11.37 71.68,11.39 71.71,11.41 71.75,11.43 71.79,11.46 71.82,11.48 71.86,11.50 71.89,11.52 71.93,11.54 71.97,11.56 72.00,11.58 72.04,11.60 72.07,11.62 72.11,11.64 72.15,11.66 72.18,11.68 72.22,11.70 72.25,11.72 72.29,11.74 72.33,11.76 72.36,11.78 72.40,11.80 72.43,11.82 72.47,11.83 72.51,11.85 72.54,11.87 72.58,11.89 72.61,11.91 72.65,11.93 72.69,11.94 72.72,11.96 72.76,11.98 72.79,12.00 72.83,12.01 72.87,12.03 72.90,12.05 72.94,12.07 72.97,12.08 73.01,12.10 73.05,12.12 73.08,12.13 73.12,12.15 73.15,12.17 73.19,12.18 73.22,12.20 73.26,12.21 73.30,12.23 73.33,12.24 73.37,12.26 73.40,12.28 73.44,12.29 73.48,12.30 73.51,12.32 73.55,12.33 73.58,12.35 73.62,12.36 73.66,12.38 73.69,12.39 73.73,12.41 73.76,12.42 73.80,12.43 73.84,12.45 73.87,12.46 73.91,12.48 73.94,12.49 73.98,12.50 74.02,12.51 74.05,12.53 74.09,12.54 74.12,12.55 74.16,12.57 74.20,12.58 74.23,12.59 74.27,12.60 74.30,12.62 74.34,12.63 74.38,12.64 74.41,12.65 74.45,12.66 74.48,12.67 74.52,12.69 74.56,12.70 74.59,12.71 74.63,12.72 74.66,12.73 74.70,12.74 74.74,12.75 74.77,12.76 74.81,12.77 74.84,12.78 74.88,12.79 74.92,12.80 74.95,12.81 74.99,12.82 75.02,12.83 75.06,12.84 75.10,12.85 75.13,12.86 75.17,12.87 75.20,12.88 75.24,12.89 75.28,12.90 75.31,12.91 75.35,12.92 75.38,12.93 75.42,12.94 75.45,12.94 75.49,12.95 75.53,12.96 75.56,12.97 75.60,12.98 75.63,12.99 75.67,12.99 75.71,13.00 75.74,13.01 75.78,13.02 75.81,13.03 75.85,13.03 75.89,13.04 75.92,13.05 75.96,13.05 75.99,13.06 76.03,13.07 76.07,13.08 76.10,13.08 76.14,13.09 76.17,13.10 76.21,13.10 76.25,13.11 76.28,13.12 76.32,13.12 76.35,13.13 76.39,13.14 76.43,13.14 76.46,13.15 76.50,13.15 76.53,13.16 76.57,13.17 76.61,13.17 76.64,13.18 76.68,13.18 76.71,13.19 76.75,13.19 76.79,13.20 76.82,13.20 76.86,13.21 76.89,13.22 76.93,13.22 76.97,13.23 77.00,13.23 77.04,13.24 77.07,13.24 77.11,13.25 77.15,13.25 77.18,13.25 77.22,13.26 77.25,13.26 77.29,13.27 77.33,13.27 77.36,13.28 77.40,13.28 77.43,13.29 77.47,13.29 77.51,13.29 77.54,13.30 77.58,13.30 77.61,13.31 77.65,13.31 77.68,13.31 77.72,13.32 77.76,13.32 77.79,13.32 77.83,13.33 77.86,13.33 77.90,13.34 77.94,13.34 77.97,13.34 78.01,13.35 78.04,13.35 78.08,13.35 78.12,13.35 78.15,13.36 78.19,13.36 78.22,13.36 78.26,13.37 78.30,13.37 78.33,13.37 78.37,13.38 78.40,13.38 78.44,13.38 78.48,13.38 78.51,13.39 78.55,13.39 78.58,13.39 78.62,13.39 78.66,13.40 78.69,13.40 78.73,13.40 78.76,13.40 78.80,13.41 78.84,13.41 78.87,13.41 78.91,13.41 78.94,13.42 78.98,13.42 79.02,13.42 79.05,13.42 79.09,13.42 79.12,13.43 79.16,13.43 79.20,13.43 79.23,13.43 79.27,13.43 79.30,13.44 79.34,13.44 79.38,13.44 79.41,13.44 79.45,13.44 79.48,13.44 79.52,13.45 79.56,13.45 79.59,13.45 79.63,13.45 79.66,13.45 79.70,13.45 79.74,13.46 79.77,13.46 79.81,13.46 79.84,13.46 79.88,13.46 79.92,13.46 79.95,13.46 79.99,13.47 80.02,13.47 80.06,13.47 80.09,13.47 80.13,13.47 80.17,13.47 80.20,13.47 80.24,13.47 80.27,13.48 80.31,13.48 80.35,13.48 80.38,13.48 80.42,13.48 80.45,13.48 80.49,13.48 80.53,13.48 80.56,13.48 80.60,13.48 80.63,13.49 80.67,13.49 80.71,13.49 80.74,13.49 80.78,13.49 80.81,13.49 80.85,13.49 80.89,13.49 80.92,13.49 80.96,13.49 80.99,13.49 81.03,13.49 81.07,13.50 81.10,13.50 81.14,13.50 81.17,13.50 " style="stroke-width: 1.07; stroke-linecap: butt;"></polyline></g></g>
</svg></td>
</tr>
<tr>
<td class="gt_row gt_right" headers="cyl">6</td>
<td class="gt_row gt_center"
headers="mpg_data"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="85.04pt" height="14.17pt" viewbox="0 0 85.04 14.17">
<g class="svglite"><defs>
<style type="text/css">    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  </style>
</defs><rect width="100%" height="100%" style="stroke: none; fill: none;"></rect><defs>
<clippath id="cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3">
<rect x="0.00" y="0.00" width="85.04" height="14.17"></rect>
</clippath></defs><g clip-path="url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)"><polygon points="18.78,13.48 18.80,13.48 18.83,13.48 18.85,13.48 18.88,13.48 18.90,13.48 18.92,13.48 18.95,13.48 18.97,13.48 19.00,13.48 19.02,13.48 19.05,13.47 19.07,13.47 19.09,13.47 19.12,13.47 19.14,13.47 19.17,13.47 19.19,13.47 19.22,13.47 19.24,13.47 19.26,13.47 19.29,13.47 19.31,13.47 19.34,13.46 19.36,13.46 19.39,13.46 19.41,13.46 19.43,13.46 19.46,13.46 19.48,13.46 19.51,13.46 19.53,13.46 19.56,13.46 19.58,13.45 19.60,13.45 19.63,13.45 19.65,13.45 19.68,13.45 19.70,13.45 19.73,13.45 19.75,13.45 19.77,13.44 19.80,13.44 19.82,13.44 19.85,13.44 19.87,13.44 19.90,13.44 19.92,13.44 19.94,13.44 19.97,13.43 19.99,13.43 20.02,13.43 20.04,13.43 20.07,13.43 20.09,13.43 20.11,13.43 20.14,13.42 20.16,13.42 20.19,13.42 20.21,13.42 20.24,13.42 20.26,13.42 20.28,13.42 20.31,13.41 20.33,13.41 20.36,13.41 20.38,13.41 20.40,13.41 20.43,13.41 20.45,13.40 20.48,13.40 20.50,13.40 20.53,13.40 20.55,13.40 20.57,13.40 20.60,13.39 20.62,13.39 20.65,13.39 20.67,13.39 20.70,13.39 20.72,13.38 20.74,13.38 20.77,13.38 20.79,13.38 20.82,13.38 20.84,13.37 20.87,13.37 20.89,13.37 20.91,13.37 20.94,13.37 20.96,13.36 20.99,13.36 21.01,13.36 21.04,13.36 21.06,13.35 21.08,13.35 21.11,13.35 21.13,13.35 21.16,13.35 21.18,13.34 21.21,13.34 21.23,13.34 21.25,13.34 21.28,13.33 21.30,13.33 21.33,13.33 21.35,13.33 21.38,13.32 21.40,13.32 21.42,13.32 21.45,13.31 21.47,13.31 21.50,13.31 21.52,13.31 21.55,13.30 21.57,13.30 21.59,13.30 21.62,13.29 21.64,13.29 21.67,13.29 21.69,13.29 21.72,13.28 21.74,13.28 21.76,13.28 21.79,13.27 21.81,13.27 21.84,13.27 21.86,13.26 21.89,13.26 21.91,13.26 21.93,13.25 21.96,13.25 21.98,13.25 22.01,13.24 22.03,13.24 22.06,13.24 22.08,13.23 22.10,13.23 22.13,13.22 22.15,13.22 22.18,13.22 22.20,13.21 22.23,13.21 22.25,13.21 22.27,13.20 22.30,13.20 22.32,13.19 22.35,13.19 22.37,13.19 22.39,13.18 22.42,13.18 22.44,13.17 22.47,13.17 22.49,13.16 22.52,13.16 22.54,13.16 22.56,13.15 22.59,13.15 22.61,13.14 22.64,13.14 22.66,13.13 22.69,13.13 22.71,13.12 22.73,13.12 22.76,13.11 22.78,13.11 22.81,13.10 22.83,13.10 22.86,13.09 22.88,13.09 22.90,13.08 22.93,13.08 22.95,13.07 22.98,13.07 23.00,13.06 23.03,13.06 23.05,13.05 23.07,13.05 23.10,13.04 23.12,13.04 23.15,13.03 23.17,13.03 23.20,13.02 23.22,13.01 23.24,13.01 23.27,13.00 23.29,13.00 23.32,12.99 23.34,12.98 23.37,12.98 23.39,12.97 23.41,12.97 23.44,12.96 23.46,12.95 23.49,12.95 23.51,12.94 23.54,12.93 23.56,12.93 23.58,12.92 23.61,12.91 23.63,12.91 23.66,12.90 23.68,12.89 23.71,12.89 23.73,12.88 23.75,12.87 23.78,12.87 23.80,12.86 23.83,12.85 23.85,12.84 23.88,12.84 23.90,12.83 23.92,12.82 23.95,12.81 23.97,12.81 24.00,12.80 24.02,12.79 24.05,12.78 24.07,12.78 24.09,12.77 24.12,12.76 24.14,12.75 24.17,12.74 24.19,12.74 24.22,12.73 24.24,12.72 24.26,12.71 24.29,12.70 24.31,12.69 24.34,12.68 24.36,12.68 24.38,12.67 24.41,12.66 24.43,12.65 24.46,12.64 24.48,12.63 24.51,12.62 24.53,12.61 24.55,12.60 24.58,12.59 24.60,12.59 24.63,12.58 24.65,12.57 24.68,12.56 24.70,12.55 24.72,12.54 24.75,12.53 24.77,12.52 24.80,12.51 24.82,12.50 24.85,12.49 24.87,12.48 24.89,12.47 24.92,12.46 24.94,12.44 24.97,12.43 24.99,12.42 25.02,12.41 25.04,12.40 25.06,12.39 25.09,12.38 25.11,12.37 25.14,12.36 25.16,12.35 25.19,12.34 25.21,12.32 25.23,12.31 25.26,12.30 25.28,12.29 25.31,12.28 25.33,12.27 25.36,12.25 25.38,12.24 25.40,12.23 25.43,12.22 25.45,12.21 25.48,12.19 25.50,12.18 25.53,12.17 25.55,12.16 25.57,12.14 25.60,12.13 25.62,12.12 25.65,12.10 25.67,12.09 25.70,12.08 25.72,12.06 25.74,12.05 25.77,12.04 25.79,12.02 25.82,12.01 25.84,12.00 25.87,11.98 25.89,11.97 25.91,11.96 25.94,11.94 25.96,11.93 25.99,11.91 26.01,11.90 26.04,11.88 26.06,11.87 26.08,11.85 26.11,11.84 26.13,11.83 26.16,11.81 26.18,11.80 26.21,11.78 26.23,11.77 26.25,11.75 26.28,11.73 26.30,11.72 26.33,11.70 26.35,11.69 26.37,11.67 26.40,11.66 26.42,11.64 26.45,11.62 26.47,11.61 26.50,11.59 26.52,11.58 26.54,11.56 26.57,11.54 26.59,11.53 26.62,11.51 26.64,11.49 26.67,11.47 26.69,11.46 26.71,11.44 26.74,11.42 26.76,11.41 26.79,11.39 26.81,11.37 26.84,11.35 26.86,11.34 26.88,11.32 26.91,11.30 26.93,11.28 26.96,11.26 26.98,11.25 27.01,11.23 27.03,11.21 27.05,11.19 27.08,11.17 27.10,11.15 27.13,11.13 27.15,11.11 27.18,11.10 27.20,11.08 27.22,11.06 27.25,11.04 27.27,11.02 27.30,11.00 27.32,10.98 27.35,10.96 27.37,10.94 27.39,10.92 27.42,10.90 27.44,10.88 27.47,10.86 27.49,10.84 27.52,10.82 27.54,10.80 27.56,10.78 27.59,10.76 27.61,10.73 27.64,10.71 27.66,10.69 27.69,10.67 27.71,10.65 27.73,10.63 27.76,10.61 27.78,10.59 27.81,10.56 27.83,10.54 27.86,10.52 27.88,10.50 27.90,10.48 27.93,10.45 27.95,10.43 27.98,10.41 28.00,10.39 28.03,10.36 28.05,10.34 28.07,10.32 28.10,10.30 28.12,10.27 28.15,10.25 28.17,10.23 28.20,10.20 28.22,10.18 28.24,10.16 28.27,10.13 28.29,10.11 28.32,10.08 28.34,10.06 28.36,10.04 28.39,10.01 28.41,9.99 28.44,9.96 28.46,9.94 28.49,9.91 28.51,9.89 28.53,9.87 28.56,9.84 28.58,9.82 28.61,9.79 28.63,9.76 28.66,9.74 28.68,9.71 28.70,9.69 28.73,9.66 28.75,9.64 28.78,9.61 28.80,9.59 28.83,9.56 28.85,9.53 28.87,9.51 28.90,9.48 28.92,9.46 28.95,9.43 28.97,9.40 29.00,9.38 29.02,9.35 29.04,9.32 29.07,9.30 29.09,9.27 29.12,9.24 29.14,9.22 29.17,9.19 29.19,9.16 29.21,9.13 29.24,9.11 29.26,9.08 29.29,9.05 29.31,9.02 29.34,9.00 29.36,8.97 29.38,8.94 29.41,8.91 29.43,8.88 29.46,8.86 29.48,8.83 29.51,8.80 29.53,8.77 29.55,8.74 29.58,8.71 29.60,8.69 29.63,8.66 29.65,8.63 29.68,8.60 29.70,8.57 29.72,8.54 29.75,8.51 29.77,8.48 29.80,8.45 29.82,8.42 29.85,8.40 29.87,8.37 29.89,8.34 29.92,8.31 29.94,8.28 29.97,8.25 29.99,8.22 30.02,8.19 30.04,8.16 30.06,8.13 30.09,8.10 30.11,8.07 30.14,8.04 30.16,8.01 30.19,7.98 30.21,7.95 30.23,7.92 30.26,7.89 30.28,7.85 30.31,7.82 30.33,7.79 30.35,7.76 30.38,7.73 30.40,7.70 30.43,7.67 30.45,7.64 30.48,7.61 30.50,7.58 30.52,7.55 30.55,7.51 30.57,7.48 30.60,7.45 30.62,7.42 30.65,7.39 30.67,7.36 30.69,7.33 30.72,7.30 30.74,7.26 30.77,7.23 30.79,7.20 30.82,7.17 30.84,7.14 30.86,7.10 30.89,7.07 30.91,7.04 30.94,7.01 30.96,6.98 30.99,6.95 31.01,6.91 31.03,6.88 31.06,6.85 31.08,6.82 31.11,6.78 31.13,6.75 31.16,6.72 31.18,6.69 31.20,6.66 31.23,6.62 31.25,6.59 31.28,6.56 31.30,6.53 31.33,6.49 31.35,6.46 31.37,6.43 31.40,6.40 31.42,6.36 31.45,6.33 31.47,6.30 31.50,6.27 31.52,6.23 31.54,6.20 31.57,6.17 31.59,6.14 31.62,6.10 31.64,6.07 31.67,6.04 31.69,6.01 31.71,5.97 31.74,5.94 31.76,5.91 31.79,5.88 31.81,5.84 31.84,5.81 31.86,5.78 31.88,5.75 31.91,5.71 31.93,5.68 31.96,5.65 31.98,5.62 32.01,5.58 32.03,5.55 32.05,5.52 32.08,5.48 32.10,5.45 32.13,5.42 32.15,5.39 32.18,5.35 32.20,5.32 32.22,5.29 32.25,5.26 32.27,5.22 32.30,5.19 32.32,5.16 32.34,5.13 32.37,5.10 32.39,5.06 32.42,5.03 32.44,5.00 32.47,4.97 32.49,4.93 32.51,4.90 32.54,4.87 32.56,4.84 32.59,4.81 32.61,4.77 32.64,4.74 32.66,4.71 32.68,4.68 32.71,4.65 32.73,4.61 32.76,4.58 32.78,4.55 32.81,4.52 32.83,4.49 32.85,4.46 32.88,4.42 32.90,4.39 32.93,4.36 32.95,4.33 32.98,4.30 33.00,4.27 33.02,4.24 33.05,4.20 33.07,4.17 33.10,4.14 33.12,4.11 33.15,4.08 33.17,4.05 33.19,4.02 33.22,3.99 33.24,3.96 33.27,3.93 33.29,3.90 33.32,3.87 33.34,3.84 33.36,3.81 33.39,3.78 33.41,3.75 33.44,3.72 33.46,3.69 33.49,3.66 33.51,3.63 33.53,3.60 33.56,3.57 33.58,3.54 33.61,3.51 33.63,3.48 33.66,3.45 33.68,3.42 33.70,3.39 33.73,3.36 33.75,3.33 33.78,3.30 33.80,3.27 33.83,3.25 33.85,3.22 33.87,3.19 33.90,3.16 33.92,3.13 33.95,3.10 33.97,3.08 34.00,3.05 34.02,3.02 34.04,2.99 34.07,2.96 34.09,2.94 34.12,2.91 34.14,2.88 34.17,2.86 34.19,2.83 34.21,2.80 34.24,2.77 34.26,2.75 34.29,2.72 34.31,2.69 34.33,2.67 34.36,2.64 34.38,2.62 34.41,2.59 34.43,2.56 34.46,2.54 34.48,2.51 34.50,2.49 34.53,2.46 34.55,2.44 34.58,2.41 34.60,2.39 34.63,2.36 34.65,2.34 34.67,2.31 34.70,2.29 34.72,2.26 34.75,2.24 34.77,2.22 34.80,2.19 34.82,2.17 34.84,2.15 34.87,2.12 34.89,2.10 34.92,2.08 34.94,2.05 34.97,2.03 34.99,2.01 35.01,1.99 35.04,1.96 35.06,1.94 35.09,1.92 35.11,1.90 35.14,1.88 35.16,1.85 35.18,1.83 35.21,1.81 35.23,1.79 35.26,1.77 35.28,1.75 35.31,1.73 35.33,1.71 35.35,1.69 35.38,1.67 35.40,1.65 35.43,1.63 35.45,1.61 35.48,1.59 35.50,1.57 35.52,1.55 35.55,1.53 35.57,1.51 35.60,1.50 35.62,1.48 35.65,1.46 35.67,1.44 35.69,1.42 35.72,1.41 35.74,1.39 35.77,1.37 35.79,1.35 35.82,1.34 35.84,1.32 35.86,1.30 35.89,1.29 35.91,1.27 35.94,1.26 35.96,1.24 35.99,1.23 36.01,1.21 36.03,1.19 36.06,1.18 36.08,1.16 36.11,1.15 36.13,1.14 36.16,1.12 36.18,1.11 36.20,1.09 36.23,1.08 36.25,1.07 36.28,1.05 36.30,1.04 36.32,1.03 36.35,1.02 36.37,1.00 36.40,0.99 36.42,0.98 36.45,0.97 36.47,0.96 36.49,0.94 36.52,0.93 36.54,0.92 36.57,0.91 36.59,0.90 36.62,0.89 36.64,0.88 36.66,0.87 36.69,0.86 36.71,0.85 36.74,0.84 36.76,0.83 36.79,0.82 36.81,0.81 36.83,0.81 36.86,0.80 36.88,0.79 36.91,0.78 36.93,0.77 36.96,0.77 36.98,0.76 37.00,0.75 37.03,0.75 37.05,0.74 37.08,0.73 37.10,0.73 37.13,0.72 37.15,0.72 37.17,0.71 37.20,0.71 37.22,0.70 37.25,0.70 37.27,0.69 37.30,0.69 37.32,0.68 37.34,0.68 37.37,0.67 37.39,0.67 37.42,0.67 37.44,0.66 37.47,0.66 37.49,0.66 37.51,0.66 37.54,0.65 37.56,0.65 37.59,0.65 37.61,0.65 37.64,0.65 37.66,0.65 37.68,0.65 37.71,0.65 37.73,0.64 37.76,0.64 37.78,0.64 37.81,0.64 37.83,0.65 37.85,0.65 37.88,0.65 37.90,0.65 37.93,0.65 37.95,0.65 37.98,0.65 38.00,0.65 38.02,0.66 38.05,0.66 38.07,0.66 38.10,0.66 38.12,0.67 38.15,0.67 38.17,0.68 38.19,0.68 38.22,0.68 38.24,0.69 38.27,0.69 38.29,0.70 38.31,0.70 38.34,0.71 38.36,0.71 38.39,0.72 38.41,0.72 38.44,0.73 38.46,0.73 38.48,0.74 38.51,0.75 38.53,0.75 38.56,0.76 38.58,0.77 38.61,0.78 38.63,0.78 38.65,0.79 38.68,0.80 38.70,0.81 38.73,0.82 38.75,0.83 38.78,0.84 38.80,0.84 38.82,0.85 38.85,0.86 38.87,0.87 38.90,0.88 38.92,0.89 38.95,0.90 38.97,0.91 38.99,0.93 39.02,0.94 39.04,0.95 39.07,0.96 39.09,0.97 39.12,0.98 39.14,1.00 39.16,1.01 39.19,1.02 39.21,1.03 39.24,1.05 39.26,1.06 39.29,1.07 39.31,1.09 39.33,1.10 39.36,1.11 39.38,1.13 39.41,1.14 39.43,1.16 39.46,1.17 39.48,1.19 39.50,1.20 39.53,1.22 39.55,1.23 39.58,1.25 39.60,1.27 39.63,1.28 39.65,1.30 39.67,1.32 39.70,1.33 39.72,1.35 39.75,1.37 39.77,1.38 39.80,1.40 39.82,1.42 39.84,1.44 39.87,1.45 39.89,1.47 39.92,1.49 39.94,1.51 39.97,1.53 39.99,1.55 40.01,1.57 40.04,1.59 40.06,1.61 40.09,1.63 40.11,1.65 40.14,1.67 40.16,1.69 40.18,1.71 40.21,1.73 40.23,1.75 40.26,1.77 40.28,1.79 40.30,1.81 40.33,1.83 40.35,1.86 40.38,1.88 40.40,1.90 40.43,1.92 40.45,1.94 40.47,1.97 40.50,1.99 40.52,2.01 40.55,2.03 40.57,2.06 40.60,2.08 40.62,2.10 40.64,2.13 40.67,2.15 40.69,2.18 40.72,2.20 40.74,2.22 40.77,2.25 40.79,2.27 40.81,2.30 40.84,2.32 40.86,2.35 40.89,2.37 40.91,2.40 40.94,2.42 40.96,2.45 40.98,2.48 41.01,2.50 41.03,2.53 41.06,2.55 41.08,2.58 41.11,2.61 41.13,2.63 41.15,2.66 41.18,2.69 41.20,2.71 41.23,2.74 41.25,2.77 41.28,2.79 41.30,2.82 41.32,2.85 41.35,2.88 41.37,2.90 41.40,2.93 41.42,2.96 41.45,2.99 41.47,3.02 41.49,3.05 41.52,3.07 41.54,3.10 41.57,3.13 41.59,3.16 41.62,3.19 41.64,3.22 41.66,3.25 41.69,3.28 41.71,3.31 41.74,3.34 41.76,3.37 41.79,3.40 41.81,3.43 41.83,3.46 41.86,3.49 41.88,3.52 41.91,3.55 41.93,3.58 41.96,3.61 41.98,3.64 42.00,3.67 42.03,3.70 42.05,3.73 42.08,3.76 42.10,3.79 42.13,3.82 42.15,3.85 42.17,3.88 42.20,3.91 42.22,3.95 42.25,3.98 42.27,4.01 42.29,4.04 42.32,4.07 42.34,4.10 42.37,4.14 42.39,4.17 42.42,4.20 42.44,4.23 42.46,4.26 42.49,4.30 42.51,4.33 42.54,4.36 42.56,4.39 42.59,4.42 42.61,4.46 42.63,4.49 42.66,4.52 42.68,4.55 42.71,4.59 42.73,4.62 42.76,4.65 42.78,4.68 42.80,4.72 42.83,4.75 42.85,4.78 42.88,4.82 42.90,4.85 42.93,4.88 42.95,4.92 42.97,4.95 43.00,4.98 43.02,5.01 43.05,5.05 43.07,5.08 43.10,5.11 43.12,5.15 43.14,5.18 43.17,5.21 43.19,5.25 43.22,5.28 43.24,5.31 43.27,5.35 43.29,5.38 43.31,5.41 43.34,5.45 43.36,5.48 43.39,5.51 43.41,5.55 43.44,5.58 43.46,5.62 43.48,5.65 43.51,5.68 43.53,5.72 43.56,5.75 43.58,5.78 43.61,5.82 43.63,5.85 43.65,5.88 43.68,5.92 43.70,5.95 43.73,5.98 43.75,6.02 43.78,6.05 43.80,6.08 43.82,6.12 43.85,6.15 43.87,6.19 43.90,6.22 43.92,6.25 43.95,6.29 43.97,6.32 43.99,6.35 44.02,6.39 44.04,6.42 44.07,6.45 44.09,6.49 44.12,6.52 44.14,6.55 44.16,6.59 44.19,6.62 44.21,6.65 44.24,6.69 44.26,6.72 44.28,6.75 44.31,6.79 44.33,6.82 44.36,6.85 44.38,6.89 44.41,6.92 44.43,6.95 44.45,6.98 44.48,7.02 44.50,7.05 44.53,7.08 44.55,7.12 44.58,7.15 44.60,7.18 44.62,7.21 44.65,7.25 44.67,7.28 44.70,7.31 44.72,7.34 44.75,7.38 44.77,7.41 44.79,7.44 44.82,7.47 44.84,7.51 44.87,7.54 44.89,7.57 44.92,7.60 44.94,7.63 44.96,7.67 44.99,7.70 45.01,7.73 45.04,7.76 45.06,7.79 45.09,7.83 45.11,7.86 45.13,7.89 45.16,7.92 45.18,7.95 45.21,7.98 45.23,8.01 45.26,8.05 45.28,8.08 45.30,8.11 45.33,8.14 45.35,8.17 45.38,8.20 45.40,8.23 45.43,8.26 45.45,8.29 45.47,8.32 45.50,8.35 45.52,8.38 45.55,8.41 45.57,8.44 45.60,8.48 45.62,8.51 45.64,8.54 45.67,8.57 45.69,8.60 45.72,8.62 45.74,8.65 45.77,8.68 45.79,8.71 45.81,8.74 45.84,8.77 45.86,8.80 45.89,8.83 45.91,8.86 45.94,8.89 45.96,8.92 45.98,8.95 46.01,8.98 46.03,9.00 46.06,9.03 46.08,9.06 46.11,9.09 46.13,9.12 46.15,9.15 46.18,9.17 46.20,9.20 46.23,9.23 46.25,9.26 46.27,9.29 46.30,9.31 46.32,9.34 46.35,9.37 46.37,9.40 46.40,9.42 46.42,9.45 46.44,9.48 46.47,9.51 46.49,9.53 46.52,9.56 46.54,9.59 46.57,9.61 46.59,9.64 46.61,9.67 46.64,9.69 46.66,9.72 46.69,9.74 46.71,9.77 46.74,9.80 46.76,9.82 46.78,9.85 46.81,9.87 46.83,9.90 46.86,9.92 46.88,9.95 46.91,9.97 46.93,10.00 46.95,10.02 46.98,10.05 47.00,10.07 47.03,10.10 47.05,10.12 47.08,10.15 47.10,10.17 47.12,10.20 47.15,10.22 47.17,10.24 47.20,10.27 47.22,10.29 47.25,10.32 47.27,10.34 47.29,10.36 47.32,10.39 47.34,10.41 47.37,10.43 47.39,10.46 47.42,10.48 47.44,10.50 47.46,10.52 47.49,10.55 47.51,10.57 47.54,10.59 47.56,10.61 47.59,10.64 47.61,10.66 47.63,10.68 47.66,10.70 47.68,10.72 47.71,10.75 47.73,10.77 47.76,10.79 47.78,10.81 47.80,10.83 47.83,10.85 47.85,10.87 47.88,10.89 47.90,10.91 47.93,10.94 47.95,10.96 47.97,10.98 48.00,11.00 48.02,11.02 48.05,11.04 48.07,11.06 48.10,11.08 48.12,11.10 48.14,11.12 48.17,11.14 48.19,11.16 48.22,11.17 48.24,11.19 48.26,11.21 48.29,11.23 48.31,11.25 48.34,11.27 48.36,11.29 48.39,11.31 48.41,11.33 48.43,11.34 48.46,11.36 48.48,11.38 48.51,11.40 48.53,11.42 48.56,11.43 48.58,11.45 48.60,11.47 48.63,11.49 48.65,11.50 48.68,11.52 48.70,11.54 48.73,11.56 48.75,11.57 48.77,11.59 48.80,11.61 48.82,11.62 48.85,11.64 48.87,11.66 48.90,11.67 48.92,11.69 48.94,11.71 48.97,11.72 48.99,11.74 49.02,11.75 49.04,11.77 49.07,11.78 49.09,11.80 49.11,11.82 49.14,11.83 49.16,11.85 49.19,11.86 49.21,11.88 49.24,11.89 49.26,11.91 49.28,11.92 49.31,11.94 49.33,11.95 49.36,11.96 49.38,11.98 49.41,11.99 49.43,12.01 49.45,12.02 49.48,12.04 49.50,12.05 49.53,12.06 49.55,12.08 49.58,12.09 49.60,12.10 49.62,12.12 49.65,12.13 49.67,12.14 49.70,12.16 49.72,12.17 49.75,12.18 49.77,12.20 49.79,12.21 49.82,12.22 49.84,12.23 49.87,12.25 49.89,12.26 49.92,12.27 49.94,12.28 49.96,12.29 49.99,12.31 50.01,12.32 50.04,12.33 50.06,12.34 50.09,12.35 50.11,12.36 50.13,12.38 50.16,12.39 50.18,12.40 50.21,12.41 50.23,12.42 50.25,12.43 50.28,12.44 50.30,12.45 50.33,12.46 50.35,12.48 50.38,12.49 50.40,12.50 50.42,12.51 50.45,12.52 50.47,12.53 50.50,12.54 50.52,12.55 50.55,12.56 50.57,12.57 50.59,12.58 50.62,12.59 50.64,12.60 50.67,12.61 50.69,12.62 50.72,12.63 50.74,12.63 50.76,12.64 50.79,12.65 50.81,12.66 50.84,12.67 50.86,12.68 50.89,12.69 50.91,12.70 50.93,12.71 50.96,12.72 50.98,12.72 51.01,12.73 51.03,12.74 51.06,12.75 51.08,12.76 51.10,12.77 51.13,12.77 51.15,12.78 51.18,12.79 51.20,12.80 51.23,12.81 51.25,12.81 51.27,12.82 51.30,12.83 51.32,12.84 51.35,12.84 51.37,12.85 51.40,12.86 51.42,12.87 51.44,12.87 51.47,12.88 51.49,12.89 51.52,12.90 51.54,12.90 51.57,12.91 51.59,12.92 51.61,12.92 51.64,12.93 51.66,12.94 51.69,12.94 51.71,12.95 51.74,12.96 51.76,12.96 51.78,12.97 51.81,12.98 51.83,12.98 51.86,12.99 51.88,12.99 51.91,13.00 51.93,13.01 51.95,13.01 51.98,13.02 52.00,13.02 52.03,13.03 52.05,13.04 52.08,13.04 52.10,13.05 52.12,13.05 52.15,13.06 52.17,13.06 52.20,13.07 52.22,13.07 52.24,13.08 52.27,13.09 52.29,13.09 52.32,13.10 52.34,13.10 52.37,13.11 52.39,13.11 52.41,13.12 52.44,13.12 52.46,13.13 52.49,13.13 52.51,13.13 52.54,13.14 52.56,13.14 52.58,13.15 52.61,13.15 52.63,13.16 52.66,13.16 52.68,13.17 52.71,13.17 52.73,13.18 52.75,13.18 52.78,13.18 52.80,13.19 52.83,13.19 52.85,13.20 52.88,13.20 52.90,13.20 52.92,13.21 52.95,13.21 52.97,13.22 53.00,13.22 53.02,13.22 53.05,13.23 53.07,13.23 53.09,13.24 53.12,13.24 53.14,13.24 53.17,13.25 53.19,13.25 53.22,13.25 53.24,13.26 53.26,13.26 53.29,13.26 53.31,13.27 53.34,13.27 53.36,13.27 53.39,13.28 53.41,13.28 53.43,13.28 53.46,13.29 53.48,13.29 53.51,13.29 53.53,13.30 53.56,13.30 53.58,13.30 53.60,13.30 53.63,13.31 53.65,13.31 53.68,13.31 53.70,13.32 53.73,13.32 53.75,13.32 53.77,13.32 53.80,13.33 53.82,13.33 53.85,13.33 53.87,13.34 53.90,13.34 53.92,13.34 53.94,13.34 53.97,13.35 53.99,13.35 54.02,13.35 54.04,13.35 54.07,13.35 54.09,13.36 54.11,13.36 54.14,13.36 54.16,13.36 54.19,13.37 54.21,13.37 54.23,13.37 54.26,13.37 54.28,13.37 54.31,13.38 54.33,13.38 54.36,13.38 54.38,13.38 54.40,13.38 54.43,13.39 54.45,13.39 54.48,13.39 54.50,13.39 54.53,13.39 54.55,13.40 54.57,13.40 54.60,13.40 54.62,13.40 54.65,13.40 54.67,13.41 54.70,13.41 54.72,13.41 54.74,13.41 54.77,13.41 54.79,13.41 54.82,13.42 54.84,13.42 54.87,13.42 54.89,13.42 54.91,13.42 54.94,13.42 54.96,13.42 54.99,13.43 55.01,13.43 55.04,13.43 55.06,13.43 55.08,13.43 55.11,13.43 55.13,13.43 55.16,13.44 55.18,13.44 55.21,13.44 55.23,13.44 55.25,13.44 55.28,13.44 55.30,13.44 55.33,13.45 55.35,13.45 55.38,13.45 55.40,13.45 55.42,13.45 55.45,13.45 55.47,13.45 55.50,13.45 55.52,13.45 55.55,13.46 55.57,13.46 55.59,13.46 55.62,13.46 55.64,13.46 55.67,13.46 55.69,13.46 55.72,13.46 55.74,13.46 55.76,13.46 55.79,13.47 55.81,13.47 55.84,13.47 55.86,13.47 55.89,13.47 55.91,13.47 55.93,13.47 55.96,13.47 55.98,13.47 55.98,13.53 55.96,13.53 55.93,13.53 55.91,13.53 55.89,13.53 55.86,13.53 55.84,13.53 55.81,13.53 55.79,13.53 55.76,13.53 55.74,13.53 55.72,13.53 55.69,13.53 55.67,13.53 55.64,13.53 55.62,13.53 55.59,13.53 55.57,13.53 55.55,13.53 55.52,13.53 55.50,13.53 55.47,13.53 55.45,13.53 55.42,13.53 55.40,13.53 55.38,13.53 55.35,13.53 55.33,13.53 55.30,13.53 55.28,13.53 55.25,13.53 55.23,13.53 55.21,13.53 55.18,13.53 55.16,13.53 55.13,13.53 55.11,13.53 55.08,13.53 55.06,13.53 55.04,13.53 55.01,13.53 54.99,13.53 54.96,13.53 54.94,13.53 54.91,13.53 54.89,13.53 54.87,13.53 54.84,13.53 54.82,13.53 54.79,13.53 54.77,13.53 54.74,13.53 54.72,13.53 54.70,13.53 54.67,13.53 54.65,13.53 54.62,13.53 54.60,13.53 54.57,13.53 54.55,13.53 54.53,13.53 54.50,13.53 54.48,13.53 54.45,13.53 54.43,13.53 54.40,13.53 54.38,13.53 54.36,13.53 54.33,13.53 54.31,13.53 54.28,13.53 54.26,13.53 54.23,13.53 54.21,13.53 54.19,13.53 54.16,13.53 54.14,13.53 54.11,13.53 54.09,13.53 54.07,13.53 54.04,13.53 54.02,13.53 53.99,13.53 53.97,13.53 53.94,13.53 53.92,13.53 53.90,13.53 53.87,13.53 53.85,13.53 53.82,13.53 53.80,13.53 53.77,13.53 53.75,13.53 53.73,13.53 53.70,13.53 53.68,13.53 53.65,13.53 53.63,13.53 53.60,13.53 53.58,13.53 53.56,13.53 53.53,13.53 53.51,13.53 53.48,13.53 53.46,13.53 53.43,13.53 53.41,13.53 53.39,13.53 53.36,13.53 53.34,13.53 53.31,13.53 53.29,13.53 53.26,13.53 53.24,13.53 53.22,13.53 53.19,13.53 53.17,13.53 53.14,13.53 53.12,13.53 53.09,13.53 53.07,13.53 53.05,13.53 53.02,13.53 53.00,13.53 52.97,13.53 52.95,13.53 52.92,13.53 52.90,13.53 52.88,13.53 52.85,13.53 52.83,13.53 52.80,13.53 52.78,13.53 52.75,13.53 52.73,13.53 52.71,13.53 52.68,13.53 52.66,13.53 52.63,13.53 52.61,13.53 52.58,13.53 52.56,13.53 52.54,13.53 52.51,13.53 52.49,13.53 52.46,13.53 52.44,13.53 52.41,13.53 52.39,13.53 52.37,13.53 52.34,13.53 52.32,13.53 52.29,13.53 52.27,13.53 52.24,13.53 52.22,13.53 52.20,13.53 52.17,13.53 52.15,13.53 52.12,13.53 52.10,13.53 52.08,13.53 52.05,13.53 52.03,13.53 52.00,13.53 51.98,13.53 51.95,13.53 51.93,13.53 51.91,13.53 51.88,13.53 51.86,13.53 51.83,13.53 51.81,13.53 51.78,13.53 51.76,13.53 51.74,13.53 51.71,13.53 51.69,13.53 51.66,13.53 51.64,13.53 51.61,13.53 51.59,13.53 51.57,13.53 51.54,13.53 51.52,13.53 51.49,13.53 51.47,13.53 51.44,13.53 51.42,13.53 51.40,13.53 51.37,13.53 51.35,13.53 51.32,13.53 51.30,13.53 51.27,13.53 51.25,13.53 51.23,13.53 51.20,13.53 51.18,13.53 51.15,13.53 51.13,13.53 51.10,13.53 51.08,13.53 51.06,13.53 51.03,13.53 51.01,13.53 50.98,13.53 50.96,13.53 50.93,13.53 50.91,13.53 50.89,13.53 50.86,13.53 50.84,13.53 50.81,13.53 50.79,13.53 50.76,13.53 50.74,13.53 50.72,13.53 50.69,13.53 50.67,13.53 50.64,13.53 50.62,13.53 50.59,13.53 50.57,13.53 50.55,13.53 50.52,13.53 50.50,13.53 50.47,13.53 50.45,13.53 50.42,13.53 50.40,13.53 50.38,13.53 50.35,13.53 50.33,13.53 50.30,13.53 50.28,13.53 50.25,13.53 50.23,13.53 50.21,13.53 50.18,13.53 50.16,13.53 50.13,13.53 50.11,13.53 50.09,13.53 50.06,13.53 50.04,13.53 50.01,13.53 49.99,13.53 49.96,13.53 49.94,13.53 49.92,13.53 49.89,13.53 49.87,13.53 49.84,13.53 49.82,13.53 49.79,13.53 49.77,13.53 49.75,13.53 49.72,13.53 49.70,13.53 49.67,13.53 49.65,13.53 49.62,13.53 49.60,13.53 49.58,13.53 49.55,13.53 49.53,13.53 49.50,13.53 49.48,13.53 49.45,13.53 49.43,13.53 49.41,13.53 49.38,13.53 49.36,13.53 49.33,13.53 49.31,13.53 49.28,13.53 49.26,13.53 49.24,13.53 49.21,13.53 49.19,13.53 49.16,13.53 49.14,13.53 49.11,13.53 49.09,13.53 49.07,13.53 49.04,13.53 49.02,13.53 48.99,13.53 48.97,13.53 48.94,13.53 48.92,13.53 48.90,13.53 48.87,13.53 48.85,13.53 48.82,13.53 48.80,13.53 48.77,13.53 48.75,13.53 48.73,13.53 48.70,13.53 48.68,13.53 48.65,13.53 48.63,13.53 48.60,13.53 48.58,13.53 48.56,13.53 48.53,13.53 48.51,13.53 48.48,13.53 48.46,13.53 48.43,13.53 48.41,13.53 48.39,13.53 48.36,13.53 48.34,13.53 48.31,13.53 48.29,13.53 48.26,13.53 48.24,13.53 48.22,13.53 48.19,13.53 48.17,13.53 48.14,13.53 48.12,13.53 48.10,13.53 48.07,13.53 48.05,13.53 48.02,13.53 48.00,13.53 47.97,13.53 47.95,13.53 47.93,13.53 47.90,13.53 47.88,13.53 47.85,13.53 47.83,13.53 47.80,13.53 47.78,13.53 47.76,13.53 47.73,13.53 47.71,13.53 47.68,13.53 47.66,13.53 47.63,13.53 47.61,13.53 47.59,13.53 47.56,13.53 47.54,13.53 47.51,13.53 47.49,13.53 47.46,13.53 47.44,13.53 47.42,13.53 47.39,13.53 47.37,13.53 47.34,13.53 47.32,13.53 47.29,13.53 47.27,13.53 47.25,13.53 47.22,13.53 47.20,13.53 47.17,13.53 47.15,13.53 47.12,13.53 47.10,13.53 47.08,13.53 47.05,13.53 47.03,13.53 47.00,13.53 46.98,13.53 46.95,13.53 46.93,13.53 46.91,13.53 46.88,13.53 46.86,13.53 46.83,13.53 46.81,13.53 46.78,13.53 46.76,13.53 46.74,13.53 46.71,13.53 46.69,13.53 46.66,13.53 46.64,13.53 46.61,13.53 46.59,13.53 46.57,13.53 46.54,13.53 46.52,13.53 46.49,13.53 46.47,13.53 46.44,13.53 46.42,13.53 46.40,13.53 46.37,13.53 46.35,13.53 46.32,13.53 46.30,13.53 46.27,13.53 46.25,13.53 46.23,13.53 46.20,13.53 46.18,13.53 46.15,13.53 46.13,13.53 46.11,13.53 46.08,13.53 46.06,13.53 46.03,13.53 46.01,13.53 45.98,13.53 45.96,13.53 45.94,13.53 45.91,13.53 45.89,13.53 45.86,13.53 45.84,13.53 45.81,13.53 45.79,13.53 45.77,13.53 45.74,13.53 45.72,13.53 45.69,13.53 45.67,13.53 45.64,13.53 45.62,13.53 45.60,13.53 45.57,13.53 45.55,13.53 45.52,13.53 45.50,13.53 45.47,13.53 45.45,13.53 45.43,13.53 45.40,13.53 45.38,13.53 45.35,13.53 45.33,13.53 45.30,13.53 45.28,13.53 45.26,13.53 45.23,13.53 45.21,13.53 45.18,13.53 45.16,13.53 45.13,13.53 45.11,13.53 45.09,13.53 45.06,13.53 45.04,13.53 45.01,13.53 44.99,13.53 44.96,13.53 44.94,13.53 44.92,13.53 44.89,13.53 44.87,13.53 44.84,13.53 44.82,13.53 44.79,13.53 44.77,13.53 44.75,13.53 44.72,13.53 44.70,13.53 44.67,13.53 44.65,13.53 44.62,13.53 44.60,13.53 44.58,13.53 44.55,13.53 44.53,13.53 44.50,13.53 44.48,13.53 44.45,13.53 44.43,13.53 44.41,13.53 44.38,13.53 44.36,13.53 44.33,13.53 44.31,13.53 44.28,13.53 44.26,13.53 44.24,13.53 44.21,13.53 44.19,13.53 44.16,13.53 44.14,13.53 44.12,13.53 44.09,13.53 44.07,13.53 44.04,13.53 44.02,13.53 43.99,13.53 43.97,13.53 43.95,13.53 43.92,13.53 43.90,13.53 43.87,13.53 43.85,13.53 43.82,13.53 43.80,13.53 43.78,13.53 43.75,13.53 43.73,13.53 43.70,13.53 43.68,13.53 43.65,13.53 43.63,13.53 43.61,13.53 43.58,13.53 43.56,13.53 43.53,13.53 43.51,13.53 43.48,13.53 43.46,13.53 43.44,13.53 43.41,13.53 43.39,13.53 43.36,13.53 43.34,13.53 43.31,13.53 43.29,13.53 43.27,13.53 43.24,13.53 43.22,13.53 43.19,13.53 43.17,13.53 43.14,13.53 43.12,13.53 43.10,13.53 43.07,13.53 43.05,13.53 43.02,13.53 43.00,13.53 42.97,13.53 42.95,13.53 42.93,13.53 42.90,13.53 42.88,13.53 42.85,13.53 42.83,13.53 42.80,13.53 42.78,13.53 42.76,13.53 42.73,13.53 42.71,13.53 42.68,13.53 42.66,13.53 42.63,13.53 42.61,13.53 42.59,13.53 42.56,13.53 42.54,13.53 42.51,13.53 42.49,13.53 42.46,13.53 42.44,13.53 42.42,13.53 42.39,13.53 42.37,13.53 42.34,13.53 42.32,13.53 42.29,13.53 42.27,13.53 42.25,13.53 42.22,13.53 42.20,13.53 42.17,13.53 42.15,13.53 42.13,13.53 42.10,13.53 42.08,13.53 42.05,13.53 42.03,13.53 42.00,13.53 41.98,13.53 41.96,13.53 41.93,13.53 41.91,13.53 41.88,13.53 41.86,13.53 41.83,13.53 41.81,13.53 41.79,13.53 41.76,13.53 41.74,13.53 41.71,13.53 41.69,13.53 41.66,13.53 41.64,13.53 41.62,13.53 41.59,13.53 41.57,13.53 41.54,13.53 41.52,13.53 41.49,13.53 41.47,13.53 41.45,13.53 41.42,13.53 41.40,13.53 41.37,13.53 41.35,13.53 41.32,13.53 41.30,13.53 41.28,13.53 41.25,13.53 41.23,13.53 41.20,13.53 41.18,13.53 41.15,13.53 41.13,13.53 41.11,13.53 41.08,13.53 41.06,13.53 41.03,13.53 41.01,13.53 40.98,13.53 40.96,13.53 40.94,13.53 40.91,13.53 40.89,13.53 40.86,13.53 40.84,13.53 40.81,13.53 40.79,13.53 40.77,13.53 40.74,13.53 40.72,13.53 40.69,13.53 40.67,13.53 40.64,13.53 40.62,13.53 40.60,13.53 40.57,13.53 40.55,13.53 40.52,13.53 40.50,13.53 40.47,13.53 40.45,13.53 40.43,13.53 40.40,13.53 40.38,13.53 40.35,13.53 40.33,13.53 40.30,13.53 40.28,13.53 40.26,13.53 40.23,13.53 40.21,13.53 40.18,13.53 40.16,13.53 40.14,13.53 40.11,13.53 40.09,13.53 40.06,13.53 40.04,13.53 40.01,13.53 39.99,13.53 39.97,13.53 39.94,13.53 39.92,13.53 39.89,13.53 39.87,13.53 39.84,13.53 39.82,13.53 39.80,13.53 39.77,13.53 39.75,13.53 39.72,13.53 39.70,13.53 39.67,13.53 39.65,13.53 39.63,13.53 39.60,13.53 39.58,13.53 39.55,13.53 39.53,13.53 39.50,13.53 39.48,13.53 39.46,13.53 39.43,13.53 39.41,13.53 39.38,13.53 39.36,13.53 39.33,13.53 39.31,13.53 39.29,13.53 39.26,13.53 39.24,13.53 39.21,13.53 39.19,13.53 39.16,13.53 39.14,13.53 39.12,13.53 39.09,13.53 39.07,13.53 39.04,13.53 39.02,13.53 38.99,13.53 38.97,13.53 38.95,13.53 38.92,13.53 38.90,13.53 38.87,13.53 38.85,13.53 38.82,13.53 38.80,13.53 38.78,13.53 38.75,13.53 38.73,13.53 38.70,13.53 38.68,13.53 38.65,13.53 38.63,13.53 38.61,13.53 38.58,13.53 38.56,13.53 38.53,13.53 38.51,13.53 38.48,13.53 38.46,13.53 38.44,13.53 38.41,13.53 38.39,13.53 38.36,13.53 38.34,13.53 38.31,13.53 38.29,13.53 38.27,13.53 38.24,13.53 38.22,13.53 38.19,13.53 38.17,13.53 38.15,13.53 38.12,13.53 38.10,13.53 38.07,13.53 38.05,13.53 38.02,13.53 38.00,13.53 37.98,13.53 37.95,13.53 37.93,13.53 37.90,13.53 37.88,13.53 37.85,13.53 37.83,13.53 37.81,13.53 37.78,13.53 37.76,13.53 37.73,13.53 37.71,13.53 37.68,13.53 37.66,13.53 37.64,13.53 37.61,13.53 37.59,13.53 37.56,13.53 37.54,13.53 37.51,13.53 37.49,13.53 37.47,13.53 37.44,13.53 37.42,13.53 37.39,13.53 37.37,13.53 37.34,13.53 37.32,13.53 37.30,13.53 37.27,13.53 37.25,13.53 37.22,13.53 37.20,13.53 37.17,13.53 37.15,13.53 37.13,13.53 37.10,13.53 37.08,13.53 37.05,13.53 37.03,13.53 37.00,13.53 36.98,13.53 36.96,13.53 36.93,13.53 36.91,13.53 36.88,13.53 36.86,13.53 36.83,13.53 36.81,13.53 36.79,13.53 36.76,13.53 36.74,13.53 36.71,13.53 36.69,13.53 36.66,13.53 36.64,13.53 36.62,13.53 36.59,13.53 36.57,13.53 36.54,13.53 36.52,13.53 36.49,13.53 36.47,13.53 36.45,13.53 36.42,13.53 36.40,13.53 36.37,13.53 36.35,13.53 36.32,13.53 36.30,13.53 36.28,13.53 36.25,13.53 36.23,13.53 36.20,13.53 36.18,13.53 36.16,13.53 36.13,13.53 36.11,13.53 36.08,13.53 36.06,13.53 36.03,13.53 36.01,13.53 35.99,13.53 35.96,13.53 35.94,13.53 35.91,13.53 35.89,13.53 35.86,13.53 35.84,13.53 35.82,13.53 35.79,13.53 35.77,13.53 35.74,13.53 35.72,13.53 35.69,13.53 35.67,13.53 35.65,13.53 35.62,13.53 35.60,13.53 35.57,13.53 35.55,13.53 35.52,13.53 35.50,13.53 35.48,13.53 35.45,13.53 35.43,13.53 35.40,13.53 35.38,13.53 35.35,13.53 35.33,13.53 35.31,13.53 35.28,13.53 35.26,13.53 35.23,13.53 35.21,13.53 35.18,13.53 35.16,13.53 35.14,13.53 35.11,13.53 35.09,13.53 35.06,13.53 35.04,13.53 35.01,13.53 34.99,13.53 34.97,13.53 34.94,13.53 34.92,13.53 34.89,13.53 34.87,13.53 34.84,13.53 34.82,13.53 34.80,13.53 34.77,13.53 34.75,13.53 34.72,13.53 34.70,13.53 34.67,13.53 34.65,13.53 34.63,13.53 34.60,13.53 34.58,13.53 34.55,13.53 34.53,13.53 34.50,13.53 34.48,13.53 34.46,13.53 34.43,13.53 34.41,13.53 34.38,13.53 34.36,13.53 34.33,13.53 34.31,13.53 34.29,13.53 34.26,13.53 34.24,13.53 34.21,13.53 34.19,13.53 34.17,13.53 34.14,13.53 34.12,13.53 34.09,13.53 34.07,13.53 34.04,13.53 34.02,13.53 34.00,13.53 33.97,13.53 33.95,13.53 33.92,13.53 33.90,13.53 33.87,13.53 33.85,13.53 33.83,13.53 33.80,13.53 33.78,13.53 33.75,13.53 33.73,13.53 33.70,13.53 33.68,13.53 33.66,13.53 33.63,13.53 33.61,13.53 33.58,13.53 33.56,13.53 33.53,13.53 33.51,13.53 33.49,13.53 33.46,13.53 33.44,13.53 33.41,13.53 33.39,13.53 33.36,13.53 33.34,13.53 33.32,13.53 33.29,13.53 33.27,13.53 33.24,13.53 33.22,13.53 33.19,13.53 33.17,13.53 33.15,13.53 33.12,13.53 33.10,13.53 33.07,13.53 33.05,13.53 33.02,13.53 33.00,13.53 32.98,13.53 32.95,13.53 32.93,13.53 32.90,13.53 32.88,13.53 32.85,13.53 32.83,13.53 32.81,13.53 32.78,13.53 32.76,13.53 32.73,13.53 32.71,13.53 32.68,13.53 32.66,13.53 32.64,13.53 32.61,13.53 32.59,13.53 32.56,13.53 32.54,13.53 32.51,13.53 32.49,13.53 32.47,13.53 32.44,13.53 32.42,13.53 32.39,13.53 32.37,13.53 32.34,13.53 32.32,13.53 32.30,13.53 32.27,13.53 32.25,13.53 32.22,13.53 32.20,13.53 32.18,13.53 32.15,13.53 32.13,13.53 32.10,13.53 32.08,13.53 32.05,13.53 32.03,13.53 32.01,13.53 31.98,13.53 31.96,13.53 31.93,13.53 31.91,13.53 31.88,13.53 31.86,13.53 31.84,13.53 31.81,13.53 31.79,13.53 31.76,13.53 31.74,13.53 31.71,13.53 31.69,13.53 31.67,13.53 31.64,13.53 31.62,13.53 31.59,13.53 31.57,13.53 31.54,13.53 31.52,13.53 31.50,13.53 31.47,13.53 31.45,13.53 31.42,13.53 31.40,13.53 31.37,13.53 31.35,13.53 31.33,13.53 31.30,13.53 31.28,13.53 31.25,13.53 31.23,13.53 31.20,13.53 31.18,13.53 31.16,13.53 31.13,13.53 31.11,13.53 31.08,13.53 31.06,13.53 31.03,13.53 31.01,13.53 30.99,13.53 30.96,13.53 30.94,13.53 30.91,13.53 30.89,13.53 30.86,13.53 30.84,13.53 30.82,13.53 30.79,13.53 30.77,13.53 30.74,13.53 30.72,13.53 30.69,13.53 30.67,13.53 30.65,13.53 30.62,13.53 30.60,13.53 30.57,13.53 30.55,13.53 30.52,13.53 30.50,13.53 30.48,13.53 30.45,13.53 30.43,13.53 30.40,13.53 30.38,13.53 30.35,13.53 30.33,13.53 30.31,13.53 30.28,13.53 30.26,13.53 30.23,13.53 30.21,13.53 30.19,13.53 30.16,13.53 30.14,13.53 30.11,13.53 30.09,13.53 30.06,13.53 30.04,13.53 30.02,13.53 29.99,13.53 29.97,13.53 29.94,13.53 29.92,13.53 29.89,13.53 29.87,13.53 29.85,13.53 29.82,13.53 29.80,13.53 29.77,13.53 29.75,13.53 29.72,13.53 29.70,13.53 29.68,13.53 29.65,13.53 29.63,13.53 29.60,13.53 29.58,13.53 29.55,13.53 29.53,13.53 29.51,13.53 29.48,13.53 29.46,13.53 29.43,13.53 29.41,13.53 29.38,13.53 29.36,13.53 29.34,13.53 29.31,13.53 29.29,13.53 29.26,13.53 29.24,13.53 29.21,13.53 29.19,13.53 29.17,13.53 29.14,13.53 29.12,13.53 29.09,13.53 29.07,13.53 29.04,13.53 29.02,13.53 29.00,13.53 28.97,13.53 28.95,13.53 28.92,13.53 28.90,13.53 28.87,13.53 28.85,13.53 28.83,13.53 28.80,13.53 28.78,13.53 28.75,13.53 28.73,13.53 28.70,13.53 28.68,13.53 28.66,13.53 28.63,13.53 28.61,13.53 28.58,13.53 28.56,13.53 28.53,13.53 28.51,13.53 28.49,13.53 28.46,13.53 28.44,13.53 28.41,13.53 28.39,13.53 28.36,13.53 28.34,13.53 28.32,13.53 28.29,13.53 28.27,13.53 28.24,13.53 28.22,13.53 28.20,13.53 28.17,13.53 28.15,13.53 28.12,13.53 28.10,13.53 28.07,13.53 28.05,13.53 28.03,13.53 28.00,13.53 27.98,13.53 27.95,13.53 27.93,13.53 27.90,13.53 27.88,13.53 27.86,13.53 27.83,13.53 27.81,13.53 27.78,13.53 27.76,13.53 27.73,13.53 27.71,13.53 27.69,13.53 27.66,13.53 27.64,13.53 27.61,13.53 27.59,13.53 27.56,13.53 27.54,13.53 27.52,13.53 27.49,13.53 27.47,13.53 27.44,13.53 27.42,13.53 27.39,13.53 27.37,13.53 27.35,13.53 27.32,13.53 27.30,13.53 27.27,13.53 27.25,13.53 27.22,13.53 27.20,13.53 27.18,13.53 27.15,13.53 27.13,13.53 27.10,13.53 27.08,13.53 27.05,13.53 27.03,13.53 27.01,13.53 26.98,13.53 26.96,13.53 26.93,13.53 26.91,13.53 26.88,13.53 26.86,13.53 26.84,13.53 26.81,13.53 26.79,13.53 26.76,13.53 26.74,13.53 26.71,13.53 26.69,13.53 26.67,13.53 26.64,13.53 26.62,13.53 26.59,13.53 26.57,13.53 26.54,13.53 26.52,13.53 26.50,13.53 26.47,13.53 26.45,13.53 26.42,13.53 26.40,13.53 26.37,13.53 26.35,13.53 26.33,13.53 26.30,13.53 26.28,13.53 26.25,13.53 26.23,13.53 26.21,13.53 26.18,13.53 26.16,13.53 26.13,13.53 26.11,13.53 26.08,13.53 26.06,13.53 26.04,13.53 26.01,13.53 25.99,13.53 25.96,13.53 25.94,13.53 25.91,13.53 25.89,13.53 25.87,13.53 25.84,13.53 25.82,13.53 25.79,13.53 25.77,13.53 25.74,13.53 25.72,13.53 25.70,13.53 25.67,13.53 25.65,13.53 25.62,13.53 25.60,13.53 25.57,13.53 25.55,13.53 25.53,13.53 25.50,13.53 25.48,13.53 25.45,13.53 25.43,13.53 25.40,13.53 25.38,13.53 25.36,13.53 25.33,13.53 25.31,13.53 25.28,13.53 25.26,13.53 25.23,13.53 25.21,13.53 25.19,13.53 25.16,13.53 25.14,13.53 25.11,13.53 25.09,13.53 25.06,13.53 25.04,13.53 25.02,13.53 24.99,13.53 24.97,13.53 24.94,13.53 24.92,13.53 24.89,13.53 24.87,13.53 24.85,13.53 24.82,13.53 24.80,13.53 24.77,13.53 24.75,13.53 24.72,13.53 24.70,13.53 24.68,13.53 24.65,13.53 24.63,13.53 24.60,13.53 24.58,13.53 24.55,13.53 24.53,13.53 24.51,13.53 24.48,13.53 24.46,13.53 24.43,13.53 24.41,13.53 24.38,13.53 24.36,13.53 24.34,13.53 24.31,13.53 24.29,13.53 24.26,13.53 24.24,13.53 24.22,13.53 24.19,13.53 24.17,13.53 24.14,13.53 24.12,13.53 24.09,13.53 24.07,13.53 24.05,13.53 24.02,13.53 24.00,13.53 23.97,13.53 23.95,13.53 23.92,13.53 23.90,13.53 23.88,13.53 23.85,13.53 23.83,13.53 23.80,13.53 23.78,13.53 23.75,13.53 23.73,13.53 23.71,13.53 23.68,13.53 23.66,13.53 23.63,13.53 23.61,13.53 23.58,13.53 23.56,13.53 23.54,13.53 23.51,13.53 23.49,13.53 23.46,13.53 23.44,13.53 23.41,13.53 23.39,13.53 23.37,13.53 23.34,13.53 23.32,13.53 23.29,13.53 23.27,13.53 23.24,13.53 23.22,13.53 23.20,13.53 23.17,13.53 23.15,13.53 23.12,13.53 23.10,13.53 23.07,13.53 23.05,13.53 23.03,13.53 23.00,13.53 22.98,13.53 22.95,13.53 22.93,13.53 22.90,13.53 22.88,13.53 22.86,13.53 22.83,13.53 22.81,13.53 22.78,13.53 22.76,13.53 22.73,13.53 22.71,13.53 22.69,13.53 22.66,13.53 22.64,13.53 22.61,13.53 22.59,13.53 22.56,13.53 22.54,13.53 22.52,13.53 22.49,13.53 22.47,13.53 22.44,13.53 22.42,13.53 22.39,13.53 22.37,13.53 22.35,13.53 22.32,13.53 22.30,13.53 22.27,13.53 22.25,13.53 22.23,13.53 22.20,13.53 22.18,13.53 22.15,13.53 22.13,13.53 22.10,13.53 22.08,13.53 22.06,13.53 22.03,13.53 22.01,13.53 21.98,13.53 21.96,13.53 21.93,13.53 21.91,13.53 21.89,13.53 21.86,13.53 21.84,13.53 21.81,13.53 21.79,13.53 21.76,13.53 21.74,13.53 21.72,13.53 21.69,13.53 21.67,13.53 21.64,13.53 21.62,13.53 21.59,13.53 21.57,13.53 21.55,13.53 21.52,13.53 21.50,13.53 21.47,13.53 21.45,13.53 21.42,13.53 21.40,13.53 21.38,13.53 21.35,13.53 21.33,13.53 21.30,13.53 21.28,13.53 21.25,13.53 21.23,13.53 21.21,13.53 21.18,13.53 21.16,13.53 21.13,13.53 21.11,13.53 21.08,13.53 21.06,13.53 21.04,13.53 21.01,13.53 20.99,13.53 20.96,13.53 20.94,13.53 20.91,13.53 20.89,13.53 20.87,13.53 20.84,13.53 20.82,13.53 20.79,13.53 20.77,13.53 20.74,13.53 20.72,13.53 20.70,13.53 20.67,13.53 20.65,13.53 20.62,13.53 20.60,13.53 20.57,13.53 20.55,13.53 20.53,13.53 20.50,13.53 20.48,13.53 20.45,13.53 20.43,13.53 20.40,13.53 20.38,13.53 20.36,13.53 20.33,13.53 20.31,13.53 20.28,13.53 20.26,13.53 20.24,13.53 20.21,13.53 20.19,13.53 20.16,13.53 20.14,13.53 20.11,13.53 20.09,13.53 20.07,13.53 20.04,13.53 20.02,13.53 19.99,13.53 19.97,13.53 19.94,13.53 19.92,13.53 19.90,13.53 19.87,13.53 19.85,13.53 19.82,13.53 19.80,13.53 19.77,13.53 19.75,13.53 19.73,13.53 19.70,13.53 19.68,13.53 19.65,13.53 19.63,13.53 19.60,13.53 19.58,13.53 19.56,13.53 19.53,13.53 19.51,13.53 19.48,13.53 19.46,13.53 19.43,13.53 19.41,13.53 19.39,13.53 19.36,13.53 19.34,13.53 19.31,13.53 19.29,13.53 19.26,13.53 19.24,13.53 19.22,13.53 19.19,13.53 19.17,13.53 19.14,13.53 19.12,13.53 19.09,13.53 19.07,13.53 19.05,13.53 19.02,13.53 19.00,13.53 18.97,13.53 18.95,13.53 18.92,13.53 18.90,13.53 18.88,13.53 18.85,13.53 18.83,13.53 18.80,13.53 18.78,13.53 " style="stroke-width: 0.00; stroke: none; stroke-linecap: butt; fill: #BEBEBE;"></polygon><polyline points="18.78,13.48 18.80,13.48 18.83,13.48 18.85,13.48 18.88,13.48 18.90,13.48 18.92,13.48 18.95,13.48 18.97,13.48 19.00,13.48 19.02,13.48 19.05,13.47 19.07,13.47 19.09,13.47 19.12,13.47 19.14,13.47 19.17,13.47 19.19,13.47 19.22,13.47 19.24,13.47 19.26,13.47 19.29,13.47 19.31,13.47 19.34,13.46 19.36,13.46 19.39,13.46 19.41,13.46 19.43,13.46 19.46,13.46 19.48,13.46 19.51,13.46 19.53,13.46 19.56,13.46 19.58,13.45 19.60,13.45 19.63,13.45 19.65,13.45 19.68,13.45 19.70,13.45 19.73,13.45 19.75,13.45 19.77,13.44 19.80,13.44 19.82,13.44 19.85,13.44 19.87,13.44 19.90,13.44 19.92,13.44 19.94,13.44 19.97,13.43 19.99,13.43 20.02,13.43 20.04,13.43 20.07,13.43 20.09,13.43 20.11,13.43 20.14,13.42 20.16,13.42 20.19,13.42 20.21,13.42 20.24,13.42 20.26,13.42 20.28,13.42 20.31,13.41 20.33,13.41 20.36,13.41 20.38,13.41 20.40,13.41 20.43,13.41 20.45,13.40 20.48,13.40 20.50,13.40 20.53,13.40 20.55,13.40 20.57,13.40 20.60,13.39 20.62,13.39 20.65,13.39 20.67,13.39 20.70,13.39 20.72,13.38 20.74,13.38 20.77,13.38 20.79,13.38 20.82,13.38 20.84,13.37 20.87,13.37 20.89,13.37 20.91,13.37 20.94,13.37 20.96,13.36 20.99,13.36 21.01,13.36 21.04,13.36 21.06,13.35 21.08,13.35 21.11,13.35 21.13,13.35 21.16,13.35 21.18,13.34 21.21,13.34 21.23,13.34 21.25,13.34 21.28,13.33 21.30,13.33 21.33,13.33 21.35,13.33 21.38,13.32 21.40,13.32 21.42,13.32 21.45,13.31 21.47,13.31 21.50,13.31 21.52,13.31 21.55,13.30 21.57,13.30 21.59,13.30 21.62,13.29 21.64,13.29 21.67,13.29 21.69,13.29 21.72,13.28 21.74,13.28 21.76,13.28 21.79,13.27 21.81,13.27 21.84,13.27 21.86,13.26 21.89,13.26 21.91,13.26 21.93,13.25 21.96,13.25 21.98,13.25 22.01,13.24 22.03,13.24 22.06,13.24 22.08,13.23 22.10,13.23 22.13,13.22 22.15,13.22 22.18,13.22 22.20,13.21 22.23,13.21 22.25,13.21 22.27,13.20 22.30,13.20 22.32,13.19 22.35,13.19 22.37,13.19 22.39,13.18 22.42,13.18 22.44,13.17 22.47,13.17 22.49,13.16 22.52,13.16 22.54,13.16 22.56,13.15 22.59,13.15 22.61,13.14 22.64,13.14 22.66,13.13 22.69,13.13 22.71,13.12 22.73,13.12 22.76,13.11 22.78,13.11 22.81,13.10 22.83,13.10 22.86,13.09 22.88,13.09 22.90,13.08 22.93,13.08 22.95,13.07 22.98,13.07 23.00,13.06 23.03,13.06 23.05,13.05 23.07,13.05 23.10,13.04 23.12,13.04 23.15,13.03 23.17,13.03 23.20,13.02 23.22,13.01 23.24,13.01 23.27,13.00 23.29,13.00 23.32,12.99 23.34,12.98 23.37,12.98 23.39,12.97 23.41,12.97 23.44,12.96 23.46,12.95 23.49,12.95 23.51,12.94 23.54,12.93 23.56,12.93 23.58,12.92 23.61,12.91 23.63,12.91 23.66,12.90 23.68,12.89 23.71,12.89 23.73,12.88 23.75,12.87 23.78,12.87 23.80,12.86 23.83,12.85 23.85,12.84 23.88,12.84 23.90,12.83 23.92,12.82 23.95,12.81 23.97,12.81 24.00,12.80 24.02,12.79 24.05,12.78 24.07,12.78 24.09,12.77 24.12,12.76 24.14,12.75 24.17,12.74 24.19,12.74 24.22,12.73 24.24,12.72 24.26,12.71 24.29,12.70 24.31,12.69 24.34,12.68 24.36,12.68 24.38,12.67 24.41,12.66 24.43,12.65 24.46,12.64 24.48,12.63 24.51,12.62 24.53,12.61 24.55,12.60 24.58,12.59 24.60,12.59 24.63,12.58 24.65,12.57 24.68,12.56 24.70,12.55 24.72,12.54 24.75,12.53 24.77,12.52 24.80,12.51 24.82,12.50 24.85,12.49 24.87,12.48 24.89,12.47 24.92,12.46 24.94,12.44 24.97,12.43 24.99,12.42 25.02,12.41 25.04,12.40 25.06,12.39 25.09,12.38 25.11,12.37 25.14,12.36 25.16,12.35 25.19,12.34 25.21,12.32 25.23,12.31 25.26,12.30 25.28,12.29 25.31,12.28 25.33,12.27 25.36,12.25 25.38,12.24 25.40,12.23 25.43,12.22 25.45,12.21 25.48,12.19 25.50,12.18 25.53,12.17 25.55,12.16 25.57,12.14 25.60,12.13 25.62,12.12 25.65,12.10 25.67,12.09 25.70,12.08 25.72,12.06 25.74,12.05 25.77,12.04 25.79,12.02 25.82,12.01 25.84,12.00 25.87,11.98 25.89,11.97 25.91,11.96 25.94,11.94 25.96,11.93 25.99,11.91 26.01,11.90 26.04,11.88 26.06,11.87 26.08,11.85 26.11,11.84 26.13,11.83 26.16,11.81 26.18,11.80 26.21,11.78 26.23,11.77 26.25,11.75 26.28,11.73 26.30,11.72 26.33,11.70 26.35,11.69 26.37,11.67 26.40,11.66 26.42,11.64 26.45,11.62 26.47,11.61 26.50,11.59 26.52,11.58 26.54,11.56 26.57,11.54 26.59,11.53 26.62,11.51 26.64,11.49 26.67,11.47 26.69,11.46 26.71,11.44 26.74,11.42 26.76,11.41 26.79,11.39 26.81,11.37 26.84,11.35 26.86,11.34 26.88,11.32 26.91,11.30 26.93,11.28 26.96,11.26 26.98,11.25 27.01,11.23 27.03,11.21 27.05,11.19 27.08,11.17 27.10,11.15 27.13,11.13 27.15,11.11 27.18,11.10 27.20,11.08 27.22,11.06 27.25,11.04 27.27,11.02 27.30,11.00 27.32,10.98 27.35,10.96 27.37,10.94 27.39,10.92 27.42,10.90 27.44,10.88 27.47,10.86 27.49,10.84 27.52,10.82 27.54,10.80 27.56,10.78 27.59,10.76 27.61,10.73 27.64,10.71 27.66,10.69 27.69,10.67 27.71,10.65 27.73,10.63 27.76,10.61 27.78,10.59 27.81,10.56 27.83,10.54 27.86,10.52 27.88,10.50 27.90,10.48 27.93,10.45 27.95,10.43 27.98,10.41 28.00,10.39 28.03,10.36 28.05,10.34 28.07,10.32 28.10,10.30 28.12,10.27 28.15,10.25 28.17,10.23 28.20,10.20 28.22,10.18 28.24,10.16 28.27,10.13 28.29,10.11 28.32,10.08 28.34,10.06 28.36,10.04 28.39,10.01 28.41,9.99 28.44,9.96 28.46,9.94 28.49,9.91 28.51,9.89 28.53,9.87 28.56,9.84 28.58,9.82 28.61,9.79 28.63,9.76 28.66,9.74 28.68,9.71 28.70,9.69 28.73,9.66 28.75,9.64 28.78,9.61 28.80,9.59 28.83,9.56 28.85,9.53 28.87,9.51 28.90,9.48 28.92,9.46 28.95,9.43 28.97,9.40 29.00,9.38 29.02,9.35 29.04,9.32 29.07,9.30 29.09,9.27 29.12,9.24 29.14,9.22 29.17,9.19 29.19,9.16 29.21,9.13 29.24,9.11 29.26,9.08 29.29,9.05 29.31,9.02 29.34,9.00 29.36,8.97 29.38,8.94 29.41,8.91 29.43,8.88 29.46,8.86 29.48,8.83 29.51,8.80 29.53,8.77 29.55,8.74 29.58,8.71 29.60,8.69 29.63,8.66 29.65,8.63 29.68,8.60 29.70,8.57 29.72,8.54 29.75,8.51 29.77,8.48 29.80,8.45 29.82,8.42 29.85,8.40 29.87,8.37 29.89,8.34 29.92,8.31 29.94,8.28 29.97,8.25 29.99,8.22 30.02,8.19 30.04,8.16 30.06,8.13 30.09,8.10 30.11,8.07 30.14,8.04 30.16,8.01 30.19,7.98 30.21,7.95 30.23,7.92 30.26,7.89 30.28,7.85 30.31,7.82 30.33,7.79 30.35,7.76 30.38,7.73 30.40,7.70 30.43,7.67 30.45,7.64 30.48,7.61 30.50,7.58 30.52,7.55 30.55,7.51 30.57,7.48 30.60,7.45 30.62,7.42 30.65,7.39 30.67,7.36 30.69,7.33 30.72,7.30 30.74,7.26 30.77,7.23 30.79,7.20 30.82,7.17 30.84,7.14 30.86,7.10 30.89,7.07 30.91,7.04 30.94,7.01 30.96,6.98 30.99,6.95 31.01,6.91 31.03,6.88 31.06,6.85 31.08,6.82 31.11,6.78 31.13,6.75 31.16,6.72 31.18,6.69 31.20,6.66 31.23,6.62 31.25,6.59 31.28,6.56 31.30,6.53 31.33,6.49 31.35,6.46 31.37,6.43 31.40,6.40 31.42,6.36 31.45,6.33 31.47,6.30 31.50,6.27 31.52,6.23 31.54,6.20 31.57,6.17 31.59,6.14 31.62,6.10 31.64,6.07 31.67,6.04 31.69,6.01 31.71,5.97 31.74,5.94 31.76,5.91 31.79,5.88 31.81,5.84 31.84,5.81 31.86,5.78 31.88,5.75 31.91,5.71 31.93,5.68 31.96,5.65 31.98,5.62 32.01,5.58 32.03,5.55 32.05,5.52 32.08,5.48 32.10,5.45 32.13,5.42 32.15,5.39 32.18,5.35 32.20,5.32 32.22,5.29 32.25,5.26 32.27,5.22 32.30,5.19 32.32,5.16 32.34,5.13 32.37,5.10 32.39,5.06 32.42,5.03 32.44,5.00 32.47,4.97 32.49,4.93 32.51,4.90 32.54,4.87 32.56,4.84 32.59,4.81 32.61,4.77 32.64,4.74 32.66,4.71 32.68,4.68 32.71,4.65 32.73,4.61 32.76,4.58 32.78,4.55 32.81,4.52 32.83,4.49 32.85,4.46 32.88,4.42 32.90,4.39 32.93,4.36 32.95,4.33 32.98,4.30 33.00,4.27 33.02,4.24 33.05,4.20 33.07,4.17 33.10,4.14 33.12,4.11 33.15,4.08 33.17,4.05 33.19,4.02 33.22,3.99 33.24,3.96 33.27,3.93 33.29,3.90 33.32,3.87 33.34,3.84 33.36,3.81 33.39,3.78 33.41,3.75 33.44,3.72 33.46,3.69 33.49,3.66 33.51,3.63 33.53,3.60 33.56,3.57 33.58,3.54 33.61,3.51 33.63,3.48 33.66,3.45 33.68,3.42 33.70,3.39 33.73,3.36 33.75,3.33 33.78,3.30 33.80,3.27 33.83,3.25 33.85,3.22 33.87,3.19 33.90,3.16 33.92,3.13 33.95,3.10 33.97,3.08 34.00,3.05 34.02,3.02 34.04,2.99 34.07,2.96 34.09,2.94 34.12,2.91 34.14,2.88 34.17,2.86 34.19,2.83 34.21,2.80 34.24,2.77 34.26,2.75 34.29,2.72 34.31,2.69 34.33,2.67 34.36,2.64 34.38,2.62 34.41,2.59 34.43,2.56 34.46,2.54 34.48,2.51 34.50,2.49 34.53,2.46 34.55,2.44 34.58,2.41 34.60,2.39 34.63,2.36 34.65,2.34 34.67,2.31 34.70,2.29 34.72,2.26 34.75,2.24 34.77,2.22 34.80,2.19 34.82,2.17 34.84,2.15 34.87,2.12 34.89,2.10 34.92,2.08 34.94,2.05 34.97,2.03 34.99,2.01 35.01,1.99 35.04,1.96 35.06,1.94 35.09,1.92 35.11,1.90 35.14,1.88 35.16,1.85 35.18,1.83 35.21,1.81 35.23,1.79 35.26,1.77 35.28,1.75 35.31,1.73 35.33,1.71 35.35,1.69 35.38,1.67 35.40,1.65 35.43,1.63 35.45,1.61 35.48,1.59 35.50,1.57 35.52,1.55 35.55,1.53 35.57,1.51 35.60,1.50 35.62,1.48 35.65,1.46 35.67,1.44 35.69,1.42 35.72,1.41 35.74,1.39 35.77,1.37 35.79,1.35 35.82,1.34 35.84,1.32 35.86,1.30 35.89,1.29 35.91,1.27 35.94,1.26 35.96,1.24 35.99,1.23 36.01,1.21 36.03,1.19 36.06,1.18 36.08,1.16 36.11,1.15 36.13,1.14 36.16,1.12 36.18,1.11 36.20,1.09 36.23,1.08 36.25,1.07 36.28,1.05 36.30,1.04 36.32,1.03 36.35,1.02 36.37,1.00 36.40,0.99 36.42,0.98 36.45,0.97 36.47,0.96 36.49,0.94 36.52,0.93 36.54,0.92 36.57,0.91 36.59,0.90 36.62,0.89 36.64,0.88 36.66,0.87 36.69,0.86 36.71,0.85 36.74,0.84 36.76,0.83 36.79,0.82 36.81,0.81 36.83,0.81 36.86,0.80 36.88,0.79 36.91,0.78 36.93,0.77 36.96,0.77 36.98,0.76 37.00,0.75 37.03,0.75 37.05,0.74 37.08,0.73 37.10,0.73 37.13,0.72 37.15,0.72 37.17,0.71 37.20,0.71 37.22,0.70 37.25,0.70 37.27,0.69 37.30,0.69 37.32,0.68 37.34,0.68 37.37,0.67 37.39,0.67 37.42,0.67 37.44,0.66 37.47,0.66 37.49,0.66 37.51,0.66 37.54,0.65 37.56,0.65 37.59,0.65 37.61,0.65 37.64,0.65 37.66,0.65 37.68,0.65 37.71,0.65 37.73,0.64 37.76,0.64 37.78,0.64 37.81,0.64 37.83,0.65 37.85,0.65 37.88,0.65 37.90,0.65 37.93,0.65 37.95,0.65 37.98,0.65 38.00,0.65 38.02,0.66 38.05,0.66 38.07,0.66 38.10,0.66 38.12,0.67 38.15,0.67 38.17,0.68 38.19,0.68 38.22,0.68 38.24,0.69 38.27,0.69 38.29,0.70 38.31,0.70 38.34,0.71 38.36,0.71 38.39,0.72 38.41,0.72 38.44,0.73 38.46,0.73 38.48,0.74 38.51,0.75 38.53,0.75 38.56,0.76 38.58,0.77 38.61,0.78 38.63,0.78 38.65,0.79 38.68,0.80 38.70,0.81 38.73,0.82 38.75,0.83 38.78,0.84 38.80,0.84 38.82,0.85 38.85,0.86 38.87,0.87 38.90,0.88 38.92,0.89 38.95,0.90 38.97,0.91 38.99,0.93 39.02,0.94 39.04,0.95 39.07,0.96 39.09,0.97 39.12,0.98 39.14,1.00 39.16,1.01 39.19,1.02 39.21,1.03 39.24,1.05 39.26,1.06 39.29,1.07 39.31,1.09 39.33,1.10 39.36,1.11 39.38,1.13 39.41,1.14 39.43,1.16 39.46,1.17 39.48,1.19 39.50,1.20 39.53,1.22 39.55,1.23 39.58,1.25 39.60,1.27 39.63,1.28 39.65,1.30 39.67,1.32 39.70,1.33 39.72,1.35 39.75,1.37 39.77,1.38 39.80,1.40 39.82,1.42 39.84,1.44 39.87,1.45 39.89,1.47 39.92,1.49 39.94,1.51 39.97,1.53 39.99,1.55 40.01,1.57 40.04,1.59 40.06,1.61 40.09,1.63 40.11,1.65 40.14,1.67 40.16,1.69 40.18,1.71 40.21,1.73 40.23,1.75 40.26,1.77 40.28,1.79 40.30,1.81 40.33,1.83 40.35,1.86 40.38,1.88 40.40,1.90 40.43,1.92 40.45,1.94 40.47,1.97 40.50,1.99 40.52,2.01 40.55,2.03 40.57,2.06 40.60,2.08 40.62,2.10 40.64,2.13 40.67,2.15 40.69,2.18 40.72,2.20 40.74,2.22 40.77,2.25 40.79,2.27 40.81,2.30 40.84,2.32 40.86,2.35 40.89,2.37 40.91,2.40 40.94,2.42 40.96,2.45 40.98,2.48 41.01,2.50 41.03,2.53 41.06,2.55 41.08,2.58 41.11,2.61 41.13,2.63 41.15,2.66 41.18,2.69 41.20,2.71 41.23,2.74 41.25,2.77 41.28,2.79 41.30,2.82 41.32,2.85 41.35,2.88 41.37,2.90 41.40,2.93 41.42,2.96 41.45,2.99 41.47,3.02 41.49,3.05 41.52,3.07 41.54,3.10 41.57,3.13 41.59,3.16 41.62,3.19 41.64,3.22 41.66,3.25 41.69,3.28 41.71,3.31 41.74,3.34 41.76,3.37 41.79,3.40 41.81,3.43 41.83,3.46 41.86,3.49 41.88,3.52 41.91,3.55 41.93,3.58 41.96,3.61 41.98,3.64 42.00,3.67 42.03,3.70 42.05,3.73 42.08,3.76 42.10,3.79 42.13,3.82 42.15,3.85 42.17,3.88 42.20,3.91 42.22,3.95 42.25,3.98 42.27,4.01 42.29,4.04 42.32,4.07 42.34,4.10 42.37,4.14 42.39,4.17 42.42,4.20 42.44,4.23 42.46,4.26 42.49,4.30 42.51,4.33 42.54,4.36 42.56,4.39 42.59,4.42 42.61,4.46 42.63,4.49 42.66,4.52 42.68,4.55 42.71,4.59 42.73,4.62 42.76,4.65 42.78,4.68 42.80,4.72 42.83,4.75 42.85,4.78 42.88,4.82 42.90,4.85 42.93,4.88 42.95,4.92 42.97,4.95 43.00,4.98 43.02,5.01 43.05,5.05 43.07,5.08 43.10,5.11 43.12,5.15 43.14,5.18 43.17,5.21 43.19,5.25 43.22,5.28 43.24,5.31 43.27,5.35 43.29,5.38 43.31,5.41 43.34,5.45 43.36,5.48 43.39,5.51 43.41,5.55 43.44,5.58 43.46,5.62 43.48,5.65 43.51,5.68 43.53,5.72 43.56,5.75 43.58,5.78 43.61,5.82 43.63,5.85 43.65,5.88 43.68,5.92 43.70,5.95 43.73,5.98 43.75,6.02 43.78,6.05 43.80,6.08 43.82,6.12 43.85,6.15 43.87,6.19 43.90,6.22 43.92,6.25 43.95,6.29 43.97,6.32 43.99,6.35 44.02,6.39 44.04,6.42 44.07,6.45 44.09,6.49 44.12,6.52 44.14,6.55 44.16,6.59 44.19,6.62 44.21,6.65 44.24,6.69 44.26,6.72 44.28,6.75 44.31,6.79 44.33,6.82 44.36,6.85 44.38,6.89 44.41,6.92 44.43,6.95 44.45,6.98 44.48,7.02 44.50,7.05 44.53,7.08 44.55,7.12 44.58,7.15 44.60,7.18 44.62,7.21 44.65,7.25 44.67,7.28 44.70,7.31 44.72,7.34 44.75,7.38 44.77,7.41 44.79,7.44 44.82,7.47 44.84,7.51 44.87,7.54 44.89,7.57 44.92,7.60 44.94,7.63 44.96,7.67 44.99,7.70 45.01,7.73 45.04,7.76 45.06,7.79 45.09,7.83 45.11,7.86 45.13,7.89 45.16,7.92 45.18,7.95 45.21,7.98 45.23,8.01 45.26,8.05 45.28,8.08 45.30,8.11 45.33,8.14 45.35,8.17 45.38,8.20 45.40,8.23 45.43,8.26 45.45,8.29 45.47,8.32 45.50,8.35 45.52,8.38 45.55,8.41 45.57,8.44 45.60,8.48 45.62,8.51 45.64,8.54 45.67,8.57 45.69,8.60 45.72,8.62 45.74,8.65 45.77,8.68 45.79,8.71 45.81,8.74 45.84,8.77 45.86,8.80 45.89,8.83 45.91,8.86 45.94,8.89 45.96,8.92 45.98,8.95 46.01,8.98 46.03,9.00 46.06,9.03 46.08,9.06 46.11,9.09 46.13,9.12 46.15,9.15 46.18,9.17 46.20,9.20 46.23,9.23 46.25,9.26 46.27,9.29 46.30,9.31 46.32,9.34 46.35,9.37 46.37,9.40 46.40,9.42 46.42,9.45 46.44,9.48 46.47,9.51 46.49,9.53 46.52,9.56 46.54,9.59 46.57,9.61 46.59,9.64 46.61,9.67 46.64,9.69 46.66,9.72 46.69,9.74 46.71,9.77 46.74,9.80 46.76,9.82 46.78,9.85 46.81,9.87 46.83,9.90 46.86,9.92 46.88,9.95 46.91,9.97 46.93,10.00 46.95,10.02 46.98,10.05 47.00,10.07 47.03,10.10 47.05,10.12 47.08,10.15 47.10,10.17 47.12,10.20 47.15,10.22 47.17,10.24 47.20,10.27 47.22,10.29 47.25,10.32 47.27,10.34 47.29,10.36 47.32,10.39 47.34,10.41 47.37,10.43 47.39,10.46 47.42,10.48 47.44,10.50 47.46,10.52 47.49,10.55 47.51,10.57 47.54,10.59 47.56,10.61 47.59,10.64 47.61,10.66 47.63,10.68 47.66,10.70 47.68,10.72 47.71,10.75 47.73,10.77 47.76,10.79 47.78,10.81 47.80,10.83 47.83,10.85 47.85,10.87 47.88,10.89 47.90,10.91 47.93,10.94 47.95,10.96 47.97,10.98 48.00,11.00 48.02,11.02 48.05,11.04 48.07,11.06 48.10,11.08 48.12,11.10 48.14,11.12 48.17,11.14 48.19,11.16 48.22,11.17 48.24,11.19 48.26,11.21 48.29,11.23 48.31,11.25 48.34,11.27 48.36,11.29 48.39,11.31 48.41,11.33 48.43,11.34 48.46,11.36 48.48,11.38 48.51,11.40 48.53,11.42 48.56,11.43 48.58,11.45 48.60,11.47 48.63,11.49 48.65,11.50 48.68,11.52 48.70,11.54 48.73,11.56 48.75,11.57 48.77,11.59 48.80,11.61 48.82,11.62 48.85,11.64 48.87,11.66 48.90,11.67 48.92,11.69 48.94,11.71 48.97,11.72 48.99,11.74 49.02,11.75 49.04,11.77 49.07,11.78 49.09,11.80 49.11,11.82 49.14,11.83 49.16,11.85 49.19,11.86 49.21,11.88 49.24,11.89 49.26,11.91 49.28,11.92 49.31,11.94 49.33,11.95 49.36,11.96 49.38,11.98 49.41,11.99 49.43,12.01 49.45,12.02 49.48,12.04 49.50,12.05 49.53,12.06 49.55,12.08 49.58,12.09 49.60,12.10 49.62,12.12 49.65,12.13 49.67,12.14 49.70,12.16 49.72,12.17 49.75,12.18 49.77,12.20 49.79,12.21 49.82,12.22 49.84,12.23 49.87,12.25 49.89,12.26 49.92,12.27 49.94,12.28 49.96,12.29 49.99,12.31 50.01,12.32 50.04,12.33 50.06,12.34 50.09,12.35 50.11,12.36 50.13,12.38 50.16,12.39 50.18,12.40 50.21,12.41 50.23,12.42 50.25,12.43 50.28,12.44 50.30,12.45 50.33,12.46 50.35,12.48 50.38,12.49 50.40,12.50 50.42,12.51 50.45,12.52 50.47,12.53 50.50,12.54 50.52,12.55 50.55,12.56 50.57,12.57 50.59,12.58 50.62,12.59 50.64,12.60 50.67,12.61 50.69,12.62 50.72,12.63 50.74,12.63 50.76,12.64 50.79,12.65 50.81,12.66 50.84,12.67 50.86,12.68 50.89,12.69 50.91,12.70 50.93,12.71 50.96,12.72 50.98,12.72 51.01,12.73 51.03,12.74 51.06,12.75 51.08,12.76 51.10,12.77 51.13,12.77 51.15,12.78 51.18,12.79 51.20,12.80 51.23,12.81 51.25,12.81 51.27,12.82 51.30,12.83 51.32,12.84 51.35,12.84 51.37,12.85 51.40,12.86 51.42,12.87 51.44,12.87 51.47,12.88 51.49,12.89 51.52,12.90 51.54,12.90 51.57,12.91 51.59,12.92 51.61,12.92 51.64,12.93 51.66,12.94 51.69,12.94 51.71,12.95 51.74,12.96 51.76,12.96 51.78,12.97 51.81,12.98 51.83,12.98 51.86,12.99 51.88,12.99 51.91,13.00 51.93,13.01 51.95,13.01 51.98,13.02 52.00,13.02 52.03,13.03 52.05,13.04 52.08,13.04 52.10,13.05 52.12,13.05 52.15,13.06 52.17,13.06 52.20,13.07 52.22,13.07 52.24,13.08 52.27,13.09 52.29,13.09 52.32,13.10 52.34,13.10 52.37,13.11 52.39,13.11 52.41,13.12 52.44,13.12 52.46,13.13 52.49,13.13 52.51,13.13 52.54,13.14 52.56,13.14 52.58,13.15 52.61,13.15 52.63,13.16 52.66,13.16 52.68,13.17 52.71,13.17 52.73,13.18 52.75,13.18 52.78,13.18 52.80,13.19 52.83,13.19 52.85,13.20 52.88,13.20 52.90,13.20 52.92,13.21 52.95,13.21 52.97,13.22 53.00,13.22 53.02,13.22 53.05,13.23 53.07,13.23 53.09,13.24 53.12,13.24 53.14,13.24 53.17,13.25 53.19,13.25 53.22,13.25 53.24,13.26 53.26,13.26 53.29,13.26 53.31,13.27 53.34,13.27 53.36,13.27 53.39,13.28 53.41,13.28 53.43,13.28 53.46,13.29 53.48,13.29 53.51,13.29 53.53,13.30 53.56,13.30 53.58,13.30 53.60,13.30 53.63,13.31 53.65,13.31 53.68,13.31 53.70,13.32 53.73,13.32 53.75,13.32 53.77,13.32 53.80,13.33 53.82,13.33 53.85,13.33 53.87,13.34 53.90,13.34 53.92,13.34 53.94,13.34 53.97,13.35 53.99,13.35 54.02,13.35 54.04,13.35 54.07,13.35 54.09,13.36 54.11,13.36 54.14,13.36 54.16,13.36 54.19,13.37 54.21,13.37 54.23,13.37 54.26,13.37 54.28,13.37 54.31,13.38 54.33,13.38 54.36,13.38 54.38,13.38 54.40,13.38 54.43,13.39 54.45,13.39 54.48,13.39 54.50,13.39 54.53,13.39 54.55,13.40 54.57,13.40 54.60,13.40 54.62,13.40 54.65,13.40 54.67,13.41 54.70,13.41 54.72,13.41 54.74,13.41 54.77,13.41 54.79,13.41 54.82,13.42 54.84,13.42 54.87,13.42 54.89,13.42 54.91,13.42 54.94,13.42 54.96,13.42 54.99,13.43 55.01,13.43 55.04,13.43 55.06,13.43 55.08,13.43 55.11,13.43 55.13,13.43 55.16,13.44 55.18,13.44 55.21,13.44 55.23,13.44 55.25,13.44 55.28,13.44 55.30,13.44 55.33,13.45 55.35,13.45 55.38,13.45 55.40,13.45 55.42,13.45 55.45,13.45 55.47,13.45 55.50,13.45 55.52,13.45 55.55,13.46 55.57,13.46 55.59,13.46 55.62,13.46 55.64,13.46 55.67,13.46 55.69,13.46 55.72,13.46 55.74,13.46 55.76,13.46 55.79,13.47 55.81,13.47 55.84,13.47 55.86,13.47 55.89,13.47 55.91,13.47 55.93,13.47 55.96,13.47 55.98,13.47 " style="stroke-width: 1.07; stroke-linecap: butt;"></polyline></g></g>
</svg></td>
</tr>
<tr>
<td class="gt_row gt_right" headers="cyl">8</td>
<td class="gt_row gt_center"
headers="mpg_data"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="85.04pt" height="14.17pt" viewbox="0 0 85.04 14.17">
<g class="svglite"><defs>
<style type="text/css">    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  </style>
</defs><rect width="100%" height="100%" style="stroke: none; fill: none;"></rect><defs>
<clippath id="cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3">
<rect x="0.00" y="0.00" width="85.04" height="14.17"></rect>
</clippath></defs><g clip-path="url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)"><polygon points="3.87,13.50 3.90,13.50 3.93,13.50 3.96,13.50 3.99,13.50 4.02,13.50 4.05,13.50 4.08,13.50 4.11,13.50 4.15,13.50 4.18,13.49 4.21,13.49 4.24,13.49 4.27,13.49 4.30,13.49 4.33,13.49 4.36,13.49 4.39,13.49 4.43,13.49 4.46,13.49 4.49,13.49 4.52,13.49 4.55,13.49 4.58,13.49 4.61,13.48 4.64,13.48 4.67,13.48 4.71,13.48 4.74,13.48 4.77,13.48 4.80,13.48 4.83,13.48 4.86,13.48 4.89,13.48 4.92,13.48 4.95,13.48 4.99,13.47 5.02,13.47 5.05,13.47 5.08,13.47 5.11,13.47 5.14,13.47 5.17,13.47 5.20,13.47 5.23,13.47 5.27,13.47 5.30,13.46 5.33,13.46 5.36,13.46 5.39,13.46 5.42,13.46 5.45,13.46 5.48,13.46 5.51,13.46 5.55,13.45 5.58,13.45 5.61,13.45 5.64,13.45 5.67,13.45 5.70,13.45 5.73,13.45 5.76,13.45 5.79,13.44 5.83,13.44 5.86,13.44 5.89,13.44 5.92,13.44 5.95,13.44 5.98,13.44 6.01,13.43 6.04,13.43 6.07,13.43 6.10,13.43 6.14,13.43 6.17,13.43 6.20,13.42 6.23,13.42 6.26,13.42 6.29,13.42 6.32,13.42 6.35,13.42 6.38,13.41 6.42,13.41 6.45,13.41 6.48,13.41 6.51,13.41 6.54,13.40 6.57,13.40 6.60,13.40 6.63,13.40 6.66,13.40 6.70,13.39 6.73,13.39 6.76,13.39 6.79,13.39 6.82,13.39 6.85,13.38 6.88,13.38 6.91,13.38 6.94,13.38 6.98,13.37 7.01,13.37 7.04,13.37 7.07,13.37 7.10,13.37 7.13,13.36 7.16,13.36 7.19,13.36 7.22,13.36 7.26,13.35 7.29,13.35 7.32,13.35 7.35,13.35 7.38,13.34 7.41,13.34 7.44,13.34 7.47,13.33 7.50,13.33 7.54,13.33 7.57,13.33 7.60,13.32 7.63,13.32 7.66,13.32 7.69,13.31 7.72,13.31 7.75,13.31 7.78,13.30 7.82,13.30 7.85,13.30 7.88,13.29 7.91,13.29 7.94,13.29 7.97,13.28 8.00,13.28 8.03,13.28 8.06,13.27 8.10,13.27 8.13,13.27 8.16,13.26 8.19,13.26 8.22,13.26 8.25,13.25 8.28,13.25 8.31,13.25 8.34,13.24 8.38,13.24 8.41,13.23 8.44,13.23 8.47,13.23 8.50,13.22 8.53,13.22 8.56,13.21 8.59,13.21 8.62,13.20 8.66,13.20 8.69,13.20 8.72,13.19 8.75,13.19 8.78,13.18 8.81,13.18 8.84,13.17 8.87,13.17 8.90,13.17 8.94,13.16 8.97,13.16 9.00,13.15 9.03,13.15 9.06,13.14 9.09,13.14 9.12,13.13 9.15,13.13 9.18,13.12 9.22,13.12 9.25,13.11 9.28,13.11 9.31,13.10 9.34,13.10 9.37,13.09 9.40,13.08 9.43,13.08 9.46,13.07 9.50,13.07 9.53,13.06 9.56,13.06 9.59,13.05 9.62,13.05 9.65,13.04 9.68,13.03 9.71,13.03 9.74,13.02 9.78,13.02 9.81,13.01 9.84,13.00 9.87,13.00 9.90,12.99 9.93,12.99 9.96,12.98 9.99,12.97 10.02,12.97 10.06,12.96 10.09,12.95 10.12,12.95 10.15,12.94 10.18,12.93 10.21,12.93 10.24,12.92 10.27,12.91 10.30,12.91 10.34,12.90 10.37,12.89 10.40,12.88 10.43,12.88 10.46,12.87 10.49,12.86 10.52,12.86 10.55,12.85 10.58,12.84 10.62,12.83 10.65,12.83 10.68,12.82 10.71,12.81 10.74,12.80 10.77,12.79 10.80,12.79 10.83,12.78 10.86,12.77 10.90,12.76 10.93,12.75 10.96,12.75 10.99,12.74 11.02,12.73 11.05,12.72 11.08,12.71 11.11,12.70 11.14,12.70 11.17,12.69 11.21,12.68 11.24,12.67 11.27,12.66 11.30,12.65 11.33,12.64 11.36,12.63 11.39,12.63 11.42,12.62 11.45,12.61 11.49,12.60 11.52,12.59 11.55,12.58 11.58,12.57 11.61,12.56 11.64,12.55 11.67,12.54 11.70,12.53 11.73,12.52 11.77,12.51 11.80,12.50 11.83,12.49 11.86,12.48 11.89,12.47 11.92,12.46 11.95,12.45 11.98,12.44 12.01,12.43 12.05,12.42 12.08,12.41 12.11,12.40 12.14,12.39 12.17,12.38 12.20,12.37 12.23,12.36 12.26,12.35 12.29,12.34 12.33,12.33 12.36,12.32 12.39,12.30 12.42,12.29 12.45,12.28 12.48,12.27 12.51,12.26 12.54,12.25 12.57,12.24 12.61,12.23 12.64,12.21 12.67,12.20 12.70,12.19 12.73,12.18 12.76,12.17 12.79,12.16 12.82,12.14 12.85,12.13 12.89,12.12 12.92,12.11 12.95,12.10 12.98,12.08 13.01,12.07 13.04,12.06 13.07,12.05 13.10,12.03 13.13,12.02 13.17,12.01 13.20,12.00 13.23,11.98 13.26,11.97 13.29,11.96 13.32,11.94 13.35,11.93 13.38,11.92 13.41,11.91 13.45,11.89 13.48,11.88 13.51,11.87 13.54,11.85 13.57,11.84 13.60,11.83 13.63,11.81 13.66,11.80 13.69,11.79 13.73,11.77 13.76,11.76 13.79,11.74 13.82,11.73 13.85,11.72 13.88,11.70 13.91,11.69 13.94,11.67 13.97,11.66 14.01,11.65 14.04,11.63 14.07,11.62 14.10,11.60 14.13,11.59 14.16,11.57 14.19,11.56 14.22,11.55 14.25,11.53 14.29,11.52 14.32,11.50 14.35,11.49 14.38,11.47 14.41,11.46 14.44,11.44 14.47,11.43 14.50,11.41 14.53,11.40 14.57,11.38 14.60,11.37 14.63,11.35 14.66,11.33 14.69,11.32 14.72,11.30 14.75,11.29 14.78,11.27 14.81,11.26 14.85,11.24 14.88,11.22 14.91,11.21 14.94,11.19 14.97,11.18 15.00,11.16 15.03,11.14 15.06,11.13 15.09,11.11 15.13,11.10 15.16,11.08 15.19,11.06 15.22,11.05 15.25,11.03 15.28,11.01 15.31,11.00 15.34,10.98 15.37,10.96 15.41,10.95 15.44,10.93 15.47,10.91 15.50,10.90 15.53,10.88 15.56,10.86 15.59,10.85 15.62,10.83 15.65,10.81 15.69,10.79 15.72,10.78 15.75,10.76 15.78,10.74 15.81,10.72 15.84,10.71 15.87,10.69 15.90,10.67 15.93,10.65 15.97,10.64 16.00,10.62 16.03,10.60 16.06,10.58 16.09,10.56 16.12,10.55 16.15,10.53 16.18,10.51 16.21,10.49 16.24,10.47 16.28,10.45 16.31,10.44 16.34,10.42 16.37,10.40 16.40,10.38 16.43,10.36 16.46,10.34 16.49,10.32 16.52,10.31 16.56,10.29 16.59,10.27 16.62,10.25 16.65,10.23 16.68,10.21 16.71,10.19 16.74,10.17 16.77,10.15 16.80,10.13 16.84,10.11 16.87,10.09 16.90,10.08 16.93,10.06 16.96,10.04 16.99,10.02 17.02,10.00 17.05,9.98 17.08,9.96 17.12,9.94 17.15,9.92 17.18,9.90 17.21,9.88 17.24,9.86 17.27,9.84 17.30,9.82 17.33,9.80 17.36,9.77 17.40,9.75 17.43,9.73 17.46,9.71 17.49,9.69 17.52,9.67 17.55,9.65 17.58,9.63 17.61,9.61 17.64,9.59 17.68,9.57 17.71,9.55 17.74,9.52 17.77,9.50 17.80,9.48 17.83,9.46 17.86,9.44 17.89,9.42 17.92,9.40 17.96,9.37 17.99,9.35 18.02,9.33 18.05,9.31 18.08,9.29 18.11,9.27 18.14,9.24 18.17,9.22 18.20,9.20 18.24,9.18 18.27,9.15 18.30,9.13 18.33,9.11 18.36,9.09 18.39,9.06 18.42,9.04 18.45,9.02 18.48,9.00 18.52,8.97 18.55,8.95 18.58,8.93 18.61,8.90 18.64,8.88 18.67,8.86 18.70,8.83 18.73,8.81 18.76,8.79 18.80,8.76 18.83,8.74 18.86,8.72 18.89,8.69 18.92,8.67 18.95,8.64 18.98,8.62 19.01,8.60 19.04,8.57 19.08,8.55 19.11,8.52 19.14,8.50 19.17,8.47 19.20,8.45 19.23,8.42 19.26,8.40 19.29,8.38 19.32,8.35 19.36,8.33 19.39,8.30 19.42,8.27 19.45,8.25 19.48,8.22 19.51,8.20 19.54,8.17 19.57,8.15 19.60,8.12 19.64,8.10 19.67,8.07 19.70,8.05 19.73,8.02 19.76,7.99 19.79,7.97 19.82,7.94 19.85,7.91 19.88,7.89 19.92,7.86 19.95,7.84 19.98,7.81 20.01,7.78 20.04,7.76 20.07,7.73 20.10,7.70 20.13,7.67 20.16,7.65 20.20,7.62 20.23,7.59 20.26,7.57 20.29,7.54 20.32,7.51 20.35,7.48 20.38,7.46 20.41,7.43 20.44,7.40 20.48,7.37 20.51,7.34 20.54,7.32 20.57,7.29 20.60,7.26 20.63,7.23 20.66,7.20 20.69,7.17 20.72,7.15 20.76,7.12 20.79,7.09 20.82,7.06 20.85,7.03 20.88,7.00 20.91,6.97 20.94,6.94 20.97,6.91 21.00,6.89 21.04,6.86 21.07,6.83 21.10,6.80 21.13,6.77 21.16,6.74 21.19,6.71 21.22,6.68 21.25,6.65 21.28,6.62 21.31,6.59 21.35,6.56 21.38,6.53 21.41,6.50 21.44,6.47 21.47,6.44 21.50,6.41 21.53,6.38 21.56,6.35 21.59,6.32 21.63,6.28 21.66,6.25 21.69,6.22 21.72,6.19 21.75,6.16 21.78,6.13 21.81,6.10 21.84,6.07 21.87,6.04 21.91,6.01 21.94,5.97 21.97,5.94 22.00,5.91 22.03,5.88 22.06,5.85 22.09,5.82 22.12,5.78 22.15,5.75 22.19,5.72 22.22,5.69 22.25,5.66 22.28,5.63 22.31,5.59 22.34,5.56 22.37,5.53 22.40,5.50 22.43,5.47 22.47,5.43 22.50,5.40 22.53,5.37 22.56,5.34 22.59,5.30 22.62,5.27 22.65,5.24 22.68,5.21 22.71,5.17 22.75,5.14 22.78,5.11 22.81,5.08 22.84,5.04 22.87,5.01 22.90,4.98 22.93,4.95 22.96,4.91 22.99,4.88 23.03,4.85 23.06,4.82 23.09,4.78 23.12,4.75 23.15,4.72 23.18,4.68 23.21,4.65 23.24,4.62 23.27,4.59 23.31,4.55 23.34,4.52 23.37,4.49 23.40,4.45 23.43,4.42 23.46,4.39 23.49,4.36 23.52,4.32 23.55,4.29 23.59,4.26 23.62,4.23 23.65,4.19 23.68,4.16 23.71,4.13 23.74,4.10 23.77,4.06 23.80,4.03 23.83,4.00 23.87,3.96 23.90,3.93 23.93,3.90 23.96,3.87 23.99,3.84 24.02,3.80 24.05,3.77 24.08,3.74 24.11,3.71 24.15,3.67 24.18,3.64 24.21,3.61 24.24,3.58 24.27,3.55 24.30,3.51 24.33,3.48 24.36,3.45 24.39,3.42 24.43,3.39 24.46,3.36 24.49,3.32 24.52,3.29 24.55,3.26 24.58,3.23 24.61,3.20 24.64,3.17 24.67,3.14 24.71,3.11 24.74,3.08 24.77,3.05 24.80,3.01 24.83,2.98 24.86,2.95 24.89,2.92 24.92,2.89 24.95,2.86 24.99,2.83 25.02,2.80 25.05,2.77 25.08,2.74 25.11,2.71 25.14,2.69 25.17,2.66 25.20,2.63 25.23,2.60 25.27,2.57 25.30,2.54 25.33,2.51 25.36,2.48 25.39,2.45 25.42,2.43 25.45,2.40 25.48,2.37 25.51,2.34 25.55,2.32 25.58,2.29 25.61,2.26 25.64,2.23 25.67,2.21 25.70,2.18 25.73,2.15 25.76,2.13 25.79,2.10 25.83,2.07 25.86,2.05 25.89,2.02 25.92,2.00 25.95,1.97 25.98,1.95 26.01,1.92 26.04,1.90 26.07,1.87 26.11,1.85 26.14,1.82 26.17,1.80 26.20,1.77 26.23,1.75 26.26,1.73 26.29,1.70 26.32,1.68 26.35,1.66 26.39,1.63 26.42,1.61 26.45,1.59 26.48,1.57 26.51,1.55 26.54,1.52 26.57,1.50 26.60,1.48 26.63,1.46 26.66,1.44 26.70,1.42 26.73,1.40 26.76,1.38 26.79,1.36 26.82,1.34 26.85,1.32 26.88,1.30 26.91,1.28 26.94,1.26 26.98,1.25 27.01,1.23 27.04,1.21 27.07,1.19 27.10,1.17 27.13,1.16 27.16,1.14 27.19,1.12 27.22,1.11 27.26,1.09 27.29,1.08 27.32,1.06 27.35,1.05 27.38,1.03 27.41,1.02 27.44,1.00 27.47,0.99 27.50,0.97 27.54,0.96 27.57,0.95 27.60,0.93 27.63,0.92 27.66,0.91 27.69,0.90 27.72,0.88 27.75,0.87 27.78,0.86 27.82,0.85 27.85,0.84 27.88,0.83 27.91,0.82 27.94,0.81 27.97,0.80 28.00,0.79 28.03,0.78 28.06,0.77 28.10,0.76 28.13,0.75 28.16,0.75 28.19,0.74 28.22,0.73 28.25,0.72 28.28,0.72 28.31,0.71 28.34,0.70 28.38,0.70 28.41,0.69 28.44,0.69 28.47,0.68 28.50,0.68 28.53,0.67 28.56,0.67 28.59,0.67 28.62,0.66 28.66,0.66 28.69,0.66 28.72,0.65 28.75,0.65 28.78,0.65 28.81,0.65 28.84,0.65 28.87,0.65 28.90,0.65 28.94,0.64 28.97,0.64 29.00,0.64 29.03,0.65 29.06,0.65 29.09,0.65 29.12,0.65 29.15,0.65 29.18,0.65 29.22,0.66 29.25,0.66 29.28,0.66 29.31,0.66 29.34,0.67 29.37,0.67 29.40,0.68 29.43,0.68 29.46,0.69 29.50,0.69 29.53,0.70 29.56,0.70 29.59,0.71 29.62,0.71 29.65,0.72 29.68,0.73 29.71,0.73 29.74,0.74 29.78,0.75 29.81,0.76 29.84,0.77 29.87,0.78 29.90,0.78 29.93,0.79 29.96,0.80 29.99,0.81 30.02,0.82 30.06,0.83 30.09,0.85 30.12,0.86 30.15,0.87 30.18,0.88 30.21,0.89 30.24,0.90 30.27,0.92 30.30,0.93 30.34,0.94 30.37,0.95 30.40,0.97 30.43,0.98 30.46,1.00 30.49,1.01 30.52,1.03 30.55,1.04 30.58,1.06 30.62,1.07 30.65,1.09 30.68,1.11 30.71,1.12 30.74,1.14 30.77,1.16 30.80,1.17 30.83,1.19 30.86,1.21 30.90,1.23 30.93,1.24 30.96,1.26 30.99,1.28 31.02,1.30 31.05,1.32 31.08,1.34 31.11,1.36 31.14,1.38 31.18,1.40 31.21,1.42 31.24,1.44 31.27,1.46 31.30,1.48 31.33,1.50 31.36,1.53 31.39,1.55 31.42,1.57 31.46,1.59 31.49,1.62 31.52,1.64 31.55,1.66 31.58,1.69 31.61,1.71 31.64,1.73 31.67,1.76 31.70,1.78 31.73,1.81 31.77,1.83 31.80,1.86 31.83,1.88 31.86,1.91 31.89,1.93 31.92,1.96 31.95,1.98 31.98,2.01 32.01,2.04 32.05,2.06 32.08,2.09 32.11,2.12 32.14,2.14 32.17,2.17 32.20,2.20 32.23,2.23 32.26,2.25 32.29,2.28 32.33,2.31 32.36,2.34 32.39,2.37 32.42,2.40 32.45,2.42 32.48,2.45 32.51,2.48 32.54,2.51 32.57,2.54 32.61,2.57 32.64,2.60 32.67,2.63 32.70,2.66 32.73,2.69 32.76,2.72 32.79,2.75 32.82,2.79 32.85,2.82 32.89,2.85 32.92,2.88 32.95,2.91 32.98,2.94 33.01,2.97 33.04,3.01 33.07,3.04 33.10,3.07 33.13,3.10 33.17,3.13 33.20,3.17 33.23,3.20 33.26,3.23 33.29,3.26 33.32,3.30 33.35,3.33 33.38,3.36 33.41,3.40 33.45,3.43 33.48,3.46 33.51,3.50 33.54,3.53 33.57,3.56 33.60,3.60 33.63,3.63 33.66,3.67 33.69,3.70 33.73,3.74 33.76,3.77 33.79,3.80 33.82,3.84 33.85,3.87 33.88,3.91 33.91,3.94 33.94,3.98 33.97,4.01 34.01,4.05 34.04,4.08 34.07,4.12 34.10,4.15 34.13,4.19 34.16,4.22 34.19,4.26 34.22,4.29 34.25,4.33 34.29,4.37 34.32,4.40 34.35,4.44 34.38,4.47 34.41,4.51 34.44,4.54 34.47,4.58 34.50,4.62 34.53,4.65 34.57,4.69 34.60,4.72 34.63,4.76 34.66,4.80 34.69,4.83 34.72,4.87 34.75,4.90 34.78,4.94 34.81,4.98 34.85,5.01 34.88,5.05 34.91,5.08 34.94,5.12 34.97,5.16 35.00,5.19 35.03,5.23 35.06,5.27 35.09,5.30 35.13,5.34 35.16,5.38 35.19,5.41 35.22,5.45 35.25,5.48 35.28,5.52 35.31,5.56 35.34,5.59 35.37,5.63 35.41,5.67 35.44,5.70 35.47,5.74 35.50,5.78 35.53,5.81 35.56,5.85 35.59,5.88 35.62,5.92 35.65,5.96 35.69,5.99 35.72,6.03 35.75,6.07 35.78,6.10 35.81,6.14 35.84,6.17 35.87,6.21 35.90,6.25 35.93,6.28 35.97,6.32 36.00,6.35 36.03,6.39 36.06,6.43 36.09,6.46 36.12,6.50 36.15,6.53 36.18,6.57 36.21,6.60 36.25,6.64 36.28,6.68 36.31,6.71 36.34,6.75 36.37,6.78 36.40,6.82 36.43,6.85 36.46,6.89 36.49,6.92 36.53,6.96 36.56,6.99 36.59,7.03 36.62,7.06 36.65,7.10 36.68,7.13 36.71,7.17 36.74,7.20 36.77,7.24 36.80,7.27 36.84,7.31 36.87,7.34 36.90,7.38 36.93,7.41 36.96,7.45 36.99,7.48 37.02,7.51 37.05,7.55 37.08,7.58 37.12,7.62 37.15,7.65 37.18,7.68 37.21,7.72 37.24,7.75 37.27,7.79 37.30,7.82 37.33,7.85 37.36,7.89 37.40,7.92 37.43,7.95 37.46,7.99 37.49,8.02 37.52,8.05 37.55,8.08 37.58,8.12 37.61,8.15 37.64,8.18 37.68,8.22 37.71,8.25 37.74,8.28 37.77,8.31 37.80,8.34 37.83,8.38 37.86,8.41 37.89,8.44 37.92,8.47 37.96,8.50 37.99,8.54 38.02,8.57 38.05,8.60 38.08,8.63 38.11,8.66 38.14,8.69 38.17,8.72 38.20,8.76 38.24,8.79 38.27,8.82 38.30,8.85 38.33,8.88 38.36,8.91 38.39,8.94 38.42,8.97 38.45,9.00 38.48,9.03 38.52,9.06 38.55,9.09 38.58,9.12 38.61,9.15 38.64,9.18 38.67,9.21 38.70,9.24 38.73,9.27 38.76,9.30 38.80,9.33 38.83,9.35 38.86,9.38 38.89,9.41 38.92,9.44 38.95,9.47 38.98,9.50 39.01,9.53 39.04,9.55 39.08,9.58 39.11,9.61 39.14,9.64 39.17,9.67 39.20,9.69 39.23,9.72 39.26,9.75 39.29,9.78 39.32,9.80 39.36,9.83 39.39,9.86 39.42,9.88 39.45,9.91 39.48,9.94 39.51,9.96 39.54,9.99 39.57,10.02 39.60,10.04 39.64,10.07 39.67,10.09 39.70,10.12 39.73,10.15 39.76,10.17 39.79,10.20 39.82,10.22 39.85,10.25 39.88,10.27 39.92,10.30 39.95,10.32 39.98,10.35 40.01,10.37 40.04,10.40 40.07,10.42 40.10,10.45 40.13,10.47 40.16,10.49 40.20,10.52 40.23,10.54 40.26,10.57 40.29,10.59 40.32,10.61 40.35,10.64 40.38,10.66 40.41,10.68 40.44,10.71 40.48,10.73 40.51,10.75 40.54,10.77 40.57,10.80 40.60,10.82 40.63,10.84 40.66,10.86 40.69,10.89 40.72,10.91 40.76,10.93 40.79,10.95 40.82,10.97 40.85,10.99 40.88,11.02 40.91,11.04 40.94,11.06 40.97,11.08 41.00,11.10 41.04,11.12 41.07,11.14 41.10,11.16 41.13,11.18 41.16,11.20 41.19,11.22 41.22,11.24 41.25,11.26 41.28,11.28 41.32,11.30 41.35,11.32 41.38,11.34 41.41,11.36 41.44,11.38 41.47,11.40 41.50,11.42 41.53,11.44 41.56,11.46 41.60,11.47 41.63,11.49 41.66,11.51 41.69,11.53 41.72,11.55 41.75,11.57 41.78,11.58 41.81,11.60 41.84,11.62 41.88,11.64 41.91,11.66 41.94,11.67 41.97,11.69 42.00,11.71 42.03,11.73 42.06,11.74 42.09,11.76 42.12,11.78 42.15,11.79 42.19,11.81 42.22,11.83 42.25,11.84 42.28,11.86 42.31,11.87 42.34,11.89 42.37,11.91 42.40,11.92 42.43,11.94 42.47,11.95 42.50,11.97 42.53,11.98 42.56,12.00 42.59,12.01 42.62,12.03 42.65,12.04 42.68,12.06 42.71,12.07 42.75,12.09 42.78,12.10 42.81,12.12 42.84,12.13 42.87,12.15 42.90,12.16 42.93,12.17 42.96,12.19 42.99,12.20 43.03,12.21 43.06,12.23 43.09,12.24 43.12,12.25 43.15,12.27 43.18,12.28 43.21,12.29 43.24,12.31 43.27,12.32 43.31,12.33 43.34,12.35 43.37,12.36 43.40,12.37 43.43,12.38 43.46,12.39 43.49,12.41 43.52,12.42 43.55,12.43 43.59,12.44 43.62,12.45 43.65,12.47 43.68,12.48 43.71,12.49 43.74,12.50 43.77,12.51 43.80,12.52 43.83,12.53 43.87,12.55 43.90,12.56 43.93,12.57 43.96,12.58 43.99,12.59 44.02,12.60 44.05,12.61 44.08,12.62 44.11,12.63 44.15,12.64 44.18,12.65 44.21,12.66 44.24,12.67 44.27,12.68 44.30,12.69 44.33,12.70 44.36,12.71 44.39,12.72 44.43,12.73 44.46,12.74 44.49,12.75 44.52,12.76 44.55,12.76 44.58,12.77 44.61,12.78 44.64,12.79 44.67,12.80 44.71,12.81 44.74,12.82 44.77,12.83 44.80,12.83 44.83,12.84 44.86,12.85 44.89,12.86 44.92,12.87 44.95,12.87 44.99,12.88 45.02,12.89 45.05,12.90 45.08,12.91 45.11,12.91 45.14,12.92 45.17,12.93 45.20,12.94 45.23,12.94 45.27,12.95 45.30,12.96 45.33,12.97 45.36,12.97 45.39,12.98 45.42,12.99 45.45,12.99 45.48,13.00 45.51,13.01 45.55,13.01 45.58,13.02 45.61,13.03 45.64,13.03 45.67,13.04 45.70,13.05 45.73,13.05 45.76,13.06 45.79,13.06 45.83,13.07 45.86,13.08 45.89,13.08 45.92,13.09 45.95,13.09 45.98,13.10 46.01,13.10 46.04,13.11 46.07,13.12 46.11,13.12 46.14,13.13 46.17,13.13 46.20,13.14 46.23,13.14 46.26,13.15 46.29,13.15 46.32,13.16 46.35,13.16 46.39,13.17 46.42,13.17 46.45,13.18 46.48,13.18 46.51,13.19 46.54,13.19 46.57,13.20 46.60,13.20 46.63,13.21 46.67,13.21 46.70,13.21 46.73,13.22 46.76,13.22 46.79,13.23 46.82,13.23 46.85,13.24 46.88,13.24 46.91,13.24 46.95,13.25 46.98,13.25 47.01,13.26 47.04,13.26 47.07,13.26 47.10,13.27 47.13,13.27 47.16,13.28 47.19,13.28 47.22,13.28 47.26,13.29 47.29,13.29 47.32,13.29 47.35,13.30 47.38,13.30 47.41,13.30 47.44,13.31 47.47,13.31 47.50,13.31 47.54,13.32 47.57,13.32 47.60,13.32 47.63,13.33 47.66,13.33 47.69,13.33 47.72,13.33 47.75,13.34 47.78,13.34 47.82,13.34 47.85,13.35 47.88,13.35 47.91,13.35 47.94,13.35 47.97,13.36 48.00,13.36 48.03,13.36 48.06,13.36 48.10,13.37 48.13,13.37 48.16,13.37 48.19,13.37 48.22,13.38 48.25,13.38 48.28,13.38 48.31,13.38 48.34,13.39 48.38,13.39 48.41,13.39 48.44,13.39 48.47,13.40 48.50,13.40 48.53,13.40 48.56,13.40 48.59,13.40 48.62,13.41 48.66,13.41 48.69,13.41 48.72,13.41 48.75,13.41 48.78,13.42 48.81,13.42 48.84,13.42 48.87,13.42 48.90,13.42 48.94,13.42 48.97,13.43 49.00,13.43 49.03,13.43 49.06,13.43 49.09,13.43 49.12,13.43 49.15,13.44 49.18,13.44 49.22,13.44 49.25,13.44 49.28,13.44 49.31,13.44 49.34,13.44 49.37,13.45 49.40,13.45 49.43,13.45 49.46,13.45 49.50,13.45 49.53,13.45 49.56,13.45 49.59,13.46 49.62,13.46 49.65,13.46 49.68,13.46 49.71,13.46 49.74,13.46 49.78,13.46 49.81,13.46 49.84,13.46 49.87,13.47 49.90,13.47 49.93,13.47 49.96,13.47 49.99,13.47 50.02,13.47 50.06,13.47 50.09,13.47 50.12,13.47 50.15,13.48 50.18,13.48 50.21,13.48 50.24,13.48 50.27,13.48 50.30,13.48 50.34,13.48 50.37,13.48 50.40,13.48 50.43,13.48 50.46,13.48 50.49,13.48 50.52,13.49 50.55,13.49 50.58,13.49 50.62,13.49 50.65,13.49 50.68,13.49 50.71,13.49 50.74,13.49 50.77,13.49 50.80,13.49 50.83,13.49 50.86,13.49 50.90,13.49 50.93,13.50 50.96,13.50 50.99,13.50 51.02,13.50 51.05,13.50 51.08,13.50 51.11,13.50 51.14,13.50 51.18,13.50 51.21,13.50 51.24,13.50 51.27,13.50 51.30,13.50 51.33,13.50 51.36,13.50 51.39,13.50 51.42,13.50 51.46,13.50 51.49,13.50 51.52,13.51 51.55,13.51 51.55,13.53 51.52,13.53 51.49,13.53 51.46,13.53 51.42,13.53 51.39,13.53 51.36,13.53 51.33,13.53 51.30,13.53 51.27,13.53 51.24,13.53 51.21,13.53 51.18,13.53 51.14,13.53 51.11,13.53 51.08,13.53 51.05,13.53 51.02,13.53 50.99,13.53 50.96,13.53 50.93,13.53 50.90,13.53 50.86,13.53 50.83,13.53 50.80,13.53 50.77,13.53 50.74,13.53 50.71,13.53 50.68,13.53 50.65,13.53 50.62,13.53 50.58,13.53 50.55,13.53 50.52,13.53 50.49,13.53 50.46,13.53 50.43,13.53 50.40,13.53 50.37,13.53 50.34,13.53 50.30,13.53 50.27,13.53 50.24,13.53 50.21,13.53 50.18,13.53 50.15,13.53 50.12,13.53 50.09,13.53 50.06,13.53 50.02,13.53 49.99,13.53 49.96,13.53 49.93,13.53 49.90,13.53 49.87,13.53 49.84,13.53 49.81,13.53 49.78,13.53 49.74,13.53 49.71,13.53 49.68,13.53 49.65,13.53 49.62,13.53 49.59,13.53 49.56,13.53 49.53,13.53 49.50,13.53 49.46,13.53 49.43,13.53 49.40,13.53 49.37,13.53 49.34,13.53 49.31,13.53 49.28,13.53 49.25,13.53 49.22,13.53 49.18,13.53 49.15,13.53 49.12,13.53 49.09,13.53 49.06,13.53 49.03,13.53 49.00,13.53 48.97,13.53 48.94,13.53 48.90,13.53 48.87,13.53 48.84,13.53 48.81,13.53 48.78,13.53 48.75,13.53 48.72,13.53 48.69,13.53 48.66,13.53 48.62,13.53 48.59,13.53 48.56,13.53 48.53,13.53 48.50,13.53 48.47,13.53 48.44,13.53 48.41,13.53 48.38,13.53 48.34,13.53 48.31,13.53 48.28,13.53 48.25,13.53 48.22,13.53 48.19,13.53 48.16,13.53 48.13,13.53 48.10,13.53 48.06,13.53 48.03,13.53 48.00,13.53 47.97,13.53 47.94,13.53 47.91,13.53 47.88,13.53 47.85,13.53 47.82,13.53 47.78,13.53 47.75,13.53 47.72,13.53 47.69,13.53 47.66,13.53 47.63,13.53 47.60,13.53 47.57,13.53 47.54,13.53 47.50,13.53 47.47,13.53 47.44,13.53 47.41,13.53 47.38,13.53 47.35,13.53 47.32,13.53 47.29,13.53 47.26,13.53 47.22,13.53 47.19,13.53 47.16,13.53 47.13,13.53 47.10,13.53 47.07,13.53 47.04,13.53 47.01,13.53 46.98,13.53 46.95,13.53 46.91,13.53 46.88,13.53 46.85,13.53 46.82,13.53 46.79,13.53 46.76,13.53 46.73,13.53 46.70,13.53 46.67,13.53 46.63,13.53 46.60,13.53 46.57,13.53 46.54,13.53 46.51,13.53 46.48,13.53 46.45,13.53 46.42,13.53 46.39,13.53 46.35,13.53 46.32,13.53 46.29,13.53 46.26,13.53 46.23,13.53 46.20,13.53 46.17,13.53 46.14,13.53 46.11,13.53 46.07,13.53 46.04,13.53 46.01,13.53 45.98,13.53 45.95,13.53 45.92,13.53 45.89,13.53 45.86,13.53 45.83,13.53 45.79,13.53 45.76,13.53 45.73,13.53 45.70,13.53 45.67,13.53 45.64,13.53 45.61,13.53 45.58,13.53 45.55,13.53 45.51,13.53 45.48,13.53 45.45,13.53 45.42,13.53 45.39,13.53 45.36,13.53 45.33,13.53 45.30,13.53 45.27,13.53 45.23,13.53 45.20,13.53 45.17,13.53 45.14,13.53 45.11,13.53 45.08,13.53 45.05,13.53 45.02,13.53 44.99,13.53 44.95,13.53 44.92,13.53 44.89,13.53 44.86,13.53 44.83,13.53 44.80,13.53 44.77,13.53 44.74,13.53 44.71,13.53 44.67,13.53 44.64,13.53 44.61,13.53 44.58,13.53 44.55,13.53 44.52,13.53 44.49,13.53 44.46,13.53 44.43,13.53 44.39,13.53 44.36,13.53 44.33,13.53 44.30,13.53 44.27,13.53 44.24,13.53 44.21,13.53 44.18,13.53 44.15,13.53 44.11,13.53 44.08,13.53 44.05,13.53 44.02,13.53 43.99,13.53 43.96,13.53 43.93,13.53 43.90,13.53 43.87,13.53 43.83,13.53 43.80,13.53 43.77,13.53 43.74,13.53 43.71,13.53 43.68,13.53 43.65,13.53 43.62,13.53 43.59,13.53 43.55,13.53 43.52,13.53 43.49,13.53 43.46,13.53 43.43,13.53 43.40,13.53 43.37,13.53 43.34,13.53 43.31,13.53 43.27,13.53 43.24,13.53 43.21,13.53 43.18,13.53 43.15,13.53 43.12,13.53 43.09,13.53 43.06,13.53 43.03,13.53 42.99,13.53 42.96,13.53 42.93,13.53 42.90,13.53 42.87,13.53 42.84,13.53 42.81,13.53 42.78,13.53 42.75,13.53 42.71,13.53 42.68,13.53 42.65,13.53 42.62,13.53 42.59,13.53 42.56,13.53 42.53,13.53 42.50,13.53 42.47,13.53 42.43,13.53 42.40,13.53 42.37,13.53 42.34,13.53 42.31,13.53 42.28,13.53 42.25,13.53 42.22,13.53 42.19,13.53 42.15,13.53 42.12,13.53 42.09,13.53 42.06,13.53 42.03,13.53 42.00,13.53 41.97,13.53 41.94,13.53 41.91,13.53 41.88,13.53 41.84,13.53 41.81,13.53 41.78,13.53 41.75,13.53 41.72,13.53 41.69,13.53 41.66,13.53 41.63,13.53 41.60,13.53 41.56,13.53 41.53,13.53 41.50,13.53 41.47,13.53 41.44,13.53 41.41,13.53 41.38,13.53 41.35,13.53 41.32,13.53 41.28,13.53 41.25,13.53 41.22,13.53 41.19,13.53 41.16,13.53 41.13,13.53 41.10,13.53 41.07,13.53 41.04,13.53 41.00,13.53 40.97,13.53 40.94,13.53 40.91,13.53 40.88,13.53 40.85,13.53 40.82,13.53 40.79,13.53 40.76,13.53 40.72,13.53 40.69,13.53 40.66,13.53 40.63,13.53 40.60,13.53 40.57,13.53 40.54,13.53 40.51,13.53 40.48,13.53 40.44,13.53 40.41,13.53 40.38,13.53 40.35,13.53 40.32,13.53 40.29,13.53 40.26,13.53 40.23,13.53 40.20,13.53 40.16,13.53 40.13,13.53 40.10,13.53 40.07,13.53 40.04,13.53 40.01,13.53 39.98,13.53 39.95,13.53 39.92,13.53 39.88,13.53 39.85,13.53 39.82,13.53 39.79,13.53 39.76,13.53 39.73,13.53 39.70,13.53 39.67,13.53 39.64,13.53 39.60,13.53 39.57,13.53 39.54,13.53 39.51,13.53 39.48,13.53 39.45,13.53 39.42,13.53 39.39,13.53 39.36,13.53 39.32,13.53 39.29,13.53 39.26,13.53 39.23,13.53 39.20,13.53 39.17,13.53 39.14,13.53 39.11,13.53 39.08,13.53 39.04,13.53 39.01,13.53 38.98,13.53 38.95,13.53 38.92,13.53 38.89,13.53 38.86,13.53 38.83,13.53 38.80,13.53 38.76,13.53 38.73,13.53 38.70,13.53 38.67,13.53 38.64,13.53 38.61,13.53 38.58,13.53 38.55,13.53 38.52,13.53 38.48,13.53 38.45,13.53 38.42,13.53 38.39,13.53 38.36,13.53 38.33,13.53 38.30,13.53 38.27,13.53 38.24,13.53 38.20,13.53 38.17,13.53 38.14,13.53 38.11,13.53 38.08,13.53 38.05,13.53 38.02,13.53 37.99,13.53 37.96,13.53 37.92,13.53 37.89,13.53 37.86,13.53 37.83,13.53 37.80,13.53 37.77,13.53 37.74,13.53 37.71,13.53 37.68,13.53 37.64,13.53 37.61,13.53 37.58,13.53 37.55,13.53 37.52,13.53 37.49,13.53 37.46,13.53 37.43,13.53 37.40,13.53 37.36,13.53 37.33,13.53 37.30,13.53 37.27,13.53 37.24,13.53 37.21,13.53 37.18,13.53 37.15,13.53 37.12,13.53 37.08,13.53 37.05,13.53 37.02,13.53 36.99,13.53 36.96,13.53 36.93,13.53 36.90,13.53 36.87,13.53 36.84,13.53 36.80,13.53 36.77,13.53 36.74,13.53 36.71,13.53 36.68,13.53 36.65,13.53 36.62,13.53 36.59,13.53 36.56,13.53 36.53,13.53 36.49,13.53 36.46,13.53 36.43,13.53 36.40,13.53 36.37,13.53 36.34,13.53 36.31,13.53 36.28,13.53 36.25,13.53 36.21,13.53 36.18,13.53 36.15,13.53 36.12,13.53 36.09,13.53 36.06,13.53 36.03,13.53 36.00,13.53 35.97,13.53 35.93,13.53 35.90,13.53 35.87,13.53 35.84,13.53 35.81,13.53 35.78,13.53 35.75,13.53 35.72,13.53 35.69,13.53 35.65,13.53 35.62,13.53 35.59,13.53 35.56,13.53 35.53,13.53 35.50,13.53 35.47,13.53 35.44,13.53 35.41,13.53 35.37,13.53 35.34,13.53 35.31,13.53 35.28,13.53 35.25,13.53 35.22,13.53 35.19,13.53 35.16,13.53 35.13,13.53 35.09,13.53 35.06,13.53 35.03,13.53 35.00,13.53 34.97,13.53 34.94,13.53 34.91,13.53 34.88,13.53 34.85,13.53 34.81,13.53 34.78,13.53 34.75,13.53 34.72,13.53 34.69,13.53 34.66,13.53 34.63,13.53 34.60,13.53 34.57,13.53 34.53,13.53 34.50,13.53 34.47,13.53 34.44,13.53 34.41,13.53 34.38,13.53 34.35,13.53 34.32,13.53 34.29,13.53 34.25,13.53 34.22,13.53 34.19,13.53 34.16,13.53 34.13,13.53 34.10,13.53 34.07,13.53 34.04,13.53 34.01,13.53 33.97,13.53 33.94,13.53 33.91,13.53 33.88,13.53 33.85,13.53 33.82,13.53 33.79,13.53 33.76,13.53 33.73,13.53 33.69,13.53 33.66,13.53 33.63,13.53 33.60,13.53 33.57,13.53 33.54,13.53 33.51,13.53 33.48,13.53 33.45,13.53 33.41,13.53 33.38,13.53 33.35,13.53 33.32,13.53 33.29,13.53 33.26,13.53 33.23,13.53 33.20,13.53 33.17,13.53 33.13,13.53 33.10,13.53 33.07,13.53 33.04,13.53 33.01,13.53 32.98,13.53 32.95,13.53 32.92,13.53 32.89,13.53 32.85,13.53 32.82,13.53 32.79,13.53 32.76,13.53 32.73,13.53 32.70,13.53 32.67,13.53 32.64,13.53 32.61,13.53 32.57,13.53 32.54,13.53 32.51,13.53 32.48,13.53 32.45,13.53 32.42,13.53 32.39,13.53 32.36,13.53 32.33,13.53 32.29,13.53 32.26,13.53 32.23,13.53 32.20,13.53 32.17,13.53 32.14,13.53 32.11,13.53 32.08,13.53 32.05,13.53 32.01,13.53 31.98,13.53 31.95,13.53 31.92,13.53 31.89,13.53 31.86,13.53 31.83,13.53 31.80,13.53 31.77,13.53 31.73,13.53 31.70,13.53 31.67,13.53 31.64,13.53 31.61,13.53 31.58,13.53 31.55,13.53 31.52,13.53 31.49,13.53 31.46,13.53 31.42,13.53 31.39,13.53 31.36,13.53 31.33,13.53 31.30,13.53 31.27,13.53 31.24,13.53 31.21,13.53 31.18,13.53 31.14,13.53 31.11,13.53 31.08,13.53 31.05,13.53 31.02,13.53 30.99,13.53 30.96,13.53 30.93,13.53 30.90,13.53 30.86,13.53 30.83,13.53 30.80,13.53 30.77,13.53 30.74,13.53 30.71,13.53 30.68,13.53 30.65,13.53 30.62,13.53 30.58,13.53 30.55,13.53 30.52,13.53 30.49,13.53 30.46,13.53 30.43,13.53 30.40,13.53 30.37,13.53 30.34,13.53 30.30,13.53 30.27,13.53 30.24,13.53 30.21,13.53 30.18,13.53 30.15,13.53 30.12,13.53 30.09,13.53 30.06,13.53 30.02,13.53 29.99,13.53 29.96,13.53 29.93,13.53 29.90,13.53 29.87,13.53 29.84,13.53 29.81,13.53 29.78,13.53 29.74,13.53 29.71,13.53 29.68,13.53 29.65,13.53 29.62,13.53 29.59,13.53 29.56,13.53 29.53,13.53 29.50,13.53 29.46,13.53 29.43,13.53 29.40,13.53 29.37,13.53 29.34,13.53 29.31,13.53 29.28,13.53 29.25,13.53 29.22,13.53 29.18,13.53 29.15,13.53 29.12,13.53 29.09,13.53 29.06,13.53 29.03,13.53 29.00,13.53 28.97,13.53 28.94,13.53 28.90,13.53 28.87,13.53 28.84,13.53 28.81,13.53 28.78,13.53 28.75,13.53 28.72,13.53 28.69,13.53 28.66,13.53 28.62,13.53 28.59,13.53 28.56,13.53 28.53,13.53 28.50,13.53 28.47,13.53 28.44,13.53 28.41,13.53 28.38,13.53 28.34,13.53 28.31,13.53 28.28,13.53 28.25,13.53 28.22,13.53 28.19,13.53 28.16,13.53 28.13,13.53 28.10,13.53 28.06,13.53 28.03,13.53 28.00,13.53 27.97,13.53 27.94,13.53 27.91,13.53 27.88,13.53 27.85,13.53 27.82,13.53 27.78,13.53 27.75,13.53 27.72,13.53 27.69,13.53 27.66,13.53 27.63,13.53 27.60,13.53 27.57,13.53 27.54,13.53 27.50,13.53 27.47,13.53 27.44,13.53 27.41,13.53 27.38,13.53 27.35,13.53 27.32,13.53 27.29,13.53 27.26,13.53 27.22,13.53 27.19,13.53 27.16,13.53 27.13,13.53 27.10,13.53 27.07,13.53 27.04,13.53 27.01,13.53 26.98,13.53 26.94,13.53 26.91,13.53 26.88,13.53 26.85,13.53 26.82,13.53 26.79,13.53 26.76,13.53 26.73,13.53 26.70,13.53 26.66,13.53 26.63,13.53 26.60,13.53 26.57,13.53 26.54,13.53 26.51,13.53 26.48,13.53 26.45,13.53 26.42,13.53 26.39,13.53 26.35,13.53 26.32,13.53 26.29,13.53 26.26,13.53 26.23,13.53 26.20,13.53 26.17,13.53 26.14,13.53 26.11,13.53 26.07,13.53 26.04,13.53 26.01,13.53 25.98,13.53 25.95,13.53 25.92,13.53 25.89,13.53 25.86,13.53 25.83,13.53 25.79,13.53 25.76,13.53 25.73,13.53 25.70,13.53 25.67,13.53 25.64,13.53 25.61,13.53 25.58,13.53 25.55,13.53 25.51,13.53 25.48,13.53 25.45,13.53 25.42,13.53 25.39,13.53 25.36,13.53 25.33,13.53 25.30,13.53 25.27,13.53 25.23,13.53 25.20,13.53 25.17,13.53 25.14,13.53 25.11,13.53 25.08,13.53 25.05,13.53 25.02,13.53 24.99,13.53 24.95,13.53 24.92,13.53 24.89,13.53 24.86,13.53 24.83,13.53 24.80,13.53 24.77,13.53 24.74,13.53 24.71,13.53 24.67,13.53 24.64,13.53 24.61,13.53 24.58,13.53 24.55,13.53 24.52,13.53 24.49,13.53 24.46,13.53 24.43,13.53 24.39,13.53 24.36,13.53 24.33,13.53 24.30,13.53 24.27,13.53 24.24,13.53 24.21,13.53 24.18,13.53 24.15,13.53 24.11,13.53 24.08,13.53 24.05,13.53 24.02,13.53 23.99,13.53 23.96,13.53 23.93,13.53 23.90,13.53 23.87,13.53 23.83,13.53 23.80,13.53 23.77,13.53 23.74,13.53 23.71,13.53 23.68,13.53 23.65,13.53 23.62,13.53 23.59,13.53 23.55,13.53 23.52,13.53 23.49,13.53 23.46,13.53 23.43,13.53 23.40,13.53 23.37,13.53 23.34,13.53 23.31,13.53 23.27,13.53 23.24,13.53 23.21,13.53 23.18,13.53 23.15,13.53 23.12,13.53 23.09,13.53 23.06,13.53 23.03,13.53 22.99,13.53 22.96,13.53 22.93,13.53 22.90,13.53 22.87,13.53 22.84,13.53 22.81,13.53 22.78,13.53 22.75,13.53 22.71,13.53 22.68,13.53 22.65,13.53 22.62,13.53 22.59,13.53 22.56,13.53 22.53,13.53 22.50,13.53 22.47,13.53 22.43,13.53 22.40,13.53 22.37,13.53 22.34,13.53 22.31,13.53 22.28,13.53 22.25,13.53 22.22,13.53 22.19,13.53 22.15,13.53 22.12,13.53 22.09,13.53 22.06,13.53 22.03,13.53 22.00,13.53 21.97,13.53 21.94,13.53 21.91,13.53 21.87,13.53 21.84,13.53 21.81,13.53 21.78,13.53 21.75,13.53 21.72,13.53 21.69,13.53 21.66,13.53 21.63,13.53 21.59,13.53 21.56,13.53 21.53,13.53 21.50,13.53 21.47,13.53 21.44,13.53 21.41,13.53 21.38,13.53 21.35,13.53 21.31,13.53 21.28,13.53 21.25,13.53 21.22,13.53 21.19,13.53 21.16,13.53 21.13,13.53 21.10,13.53 21.07,13.53 21.04,13.53 21.00,13.53 20.97,13.53 20.94,13.53 20.91,13.53 20.88,13.53 20.85,13.53 20.82,13.53 20.79,13.53 20.76,13.53 20.72,13.53 20.69,13.53 20.66,13.53 20.63,13.53 20.60,13.53 20.57,13.53 20.54,13.53 20.51,13.53 20.48,13.53 20.44,13.53 20.41,13.53 20.38,13.53 20.35,13.53 20.32,13.53 20.29,13.53 20.26,13.53 20.23,13.53 20.20,13.53 20.16,13.53 20.13,13.53 20.10,13.53 20.07,13.53 20.04,13.53 20.01,13.53 19.98,13.53 19.95,13.53 19.92,13.53 19.88,13.53 19.85,13.53 19.82,13.53 19.79,13.53 19.76,13.53 19.73,13.53 19.70,13.53 19.67,13.53 19.64,13.53 19.60,13.53 19.57,13.53 19.54,13.53 19.51,13.53 19.48,13.53 19.45,13.53 19.42,13.53 19.39,13.53 19.36,13.53 19.32,13.53 19.29,13.53 19.26,13.53 19.23,13.53 19.20,13.53 19.17,13.53 19.14,13.53 19.11,13.53 19.08,13.53 19.04,13.53 19.01,13.53 18.98,13.53 18.95,13.53 18.92,13.53 18.89,13.53 18.86,13.53 18.83,13.53 18.80,13.53 18.76,13.53 18.73,13.53 18.70,13.53 18.67,13.53 18.64,13.53 18.61,13.53 18.58,13.53 18.55,13.53 18.52,13.53 18.48,13.53 18.45,13.53 18.42,13.53 18.39,13.53 18.36,13.53 18.33,13.53 18.30,13.53 18.27,13.53 18.24,13.53 18.20,13.53 18.17,13.53 18.14,13.53 18.11,13.53 18.08,13.53 18.05,13.53 18.02,13.53 17.99,13.53 17.96,13.53 17.92,13.53 17.89,13.53 17.86,13.53 17.83,13.53 17.80,13.53 17.77,13.53 17.74,13.53 17.71,13.53 17.68,13.53 17.64,13.53 17.61,13.53 17.58,13.53 17.55,13.53 17.52,13.53 17.49,13.53 17.46,13.53 17.43,13.53 17.40,13.53 17.36,13.53 17.33,13.53 17.30,13.53 17.27,13.53 17.24,13.53 17.21,13.53 17.18,13.53 17.15,13.53 17.12,13.53 17.08,13.53 17.05,13.53 17.02,13.53 16.99,13.53 16.96,13.53 16.93,13.53 16.90,13.53 16.87,13.53 16.84,13.53 16.80,13.53 16.77,13.53 16.74,13.53 16.71,13.53 16.68,13.53 16.65,13.53 16.62,13.53 16.59,13.53 16.56,13.53 16.52,13.53 16.49,13.53 16.46,13.53 16.43,13.53 16.40,13.53 16.37,13.53 16.34,13.53 16.31,13.53 16.28,13.53 16.24,13.53 16.21,13.53 16.18,13.53 16.15,13.53 16.12,13.53 16.09,13.53 16.06,13.53 16.03,13.53 16.00,13.53 15.97,13.53 15.93,13.53 15.90,13.53 15.87,13.53 15.84,13.53 15.81,13.53 15.78,13.53 15.75,13.53 15.72,13.53 15.69,13.53 15.65,13.53 15.62,13.53 15.59,13.53 15.56,13.53 15.53,13.53 15.50,13.53 15.47,13.53 15.44,13.53 15.41,13.53 15.37,13.53 15.34,13.53 15.31,13.53 15.28,13.53 15.25,13.53 15.22,13.53 15.19,13.53 15.16,13.53 15.13,13.53 15.09,13.53 15.06,13.53 15.03,13.53 15.00,13.53 14.97,13.53 14.94,13.53 14.91,13.53 14.88,13.53 14.85,13.53 14.81,13.53 14.78,13.53 14.75,13.53 14.72,13.53 14.69,13.53 14.66,13.53 14.63,13.53 14.60,13.53 14.57,13.53 14.53,13.53 14.50,13.53 14.47,13.53 14.44,13.53 14.41,13.53 14.38,13.53 14.35,13.53 14.32,13.53 14.29,13.53 14.25,13.53 14.22,13.53 14.19,13.53 14.16,13.53 14.13,13.53 14.10,13.53 14.07,13.53 14.04,13.53 14.01,13.53 13.97,13.53 13.94,13.53 13.91,13.53 13.88,13.53 13.85,13.53 13.82,13.53 13.79,13.53 13.76,13.53 13.73,13.53 13.69,13.53 13.66,13.53 13.63,13.53 13.60,13.53 13.57,13.53 13.54,13.53 13.51,13.53 13.48,13.53 13.45,13.53 13.41,13.53 13.38,13.53 13.35,13.53 13.32,13.53 13.29,13.53 13.26,13.53 13.23,13.53 13.20,13.53 13.17,13.53 13.13,13.53 13.10,13.53 13.07,13.53 13.04,13.53 13.01,13.53 12.98,13.53 12.95,13.53 12.92,13.53 12.89,13.53 12.85,13.53 12.82,13.53 12.79,13.53 12.76,13.53 12.73,13.53 12.70,13.53 12.67,13.53 12.64,13.53 12.61,13.53 12.57,13.53 12.54,13.53 12.51,13.53 12.48,13.53 12.45,13.53 12.42,13.53 12.39,13.53 12.36,13.53 12.33,13.53 12.29,13.53 12.26,13.53 12.23,13.53 12.20,13.53 12.17,13.53 12.14,13.53 12.11,13.53 12.08,13.53 12.05,13.53 12.01,13.53 11.98,13.53 11.95,13.53 11.92,13.53 11.89,13.53 11.86,13.53 11.83,13.53 11.80,13.53 11.77,13.53 11.73,13.53 11.70,13.53 11.67,13.53 11.64,13.53 11.61,13.53 11.58,13.53 11.55,13.53 11.52,13.53 11.49,13.53 11.45,13.53 11.42,13.53 11.39,13.53 11.36,13.53 11.33,13.53 11.30,13.53 11.27,13.53 11.24,13.53 11.21,13.53 11.17,13.53 11.14,13.53 11.11,13.53 11.08,13.53 11.05,13.53 11.02,13.53 10.99,13.53 10.96,13.53 10.93,13.53 10.90,13.53 10.86,13.53 10.83,13.53 10.80,13.53 10.77,13.53 10.74,13.53 10.71,13.53 10.68,13.53 10.65,13.53 10.62,13.53 10.58,13.53 10.55,13.53 10.52,13.53 10.49,13.53 10.46,13.53 10.43,13.53 10.40,13.53 10.37,13.53 10.34,13.53 10.30,13.53 10.27,13.53 10.24,13.53 10.21,13.53 10.18,13.53 10.15,13.53 10.12,13.53 10.09,13.53 10.06,13.53 10.02,13.53 9.99,13.53 9.96,13.53 9.93,13.53 9.90,13.53 9.87,13.53 9.84,13.53 9.81,13.53 9.78,13.53 9.74,13.53 9.71,13.53 9.68,13.53 9.65,13.53 9.62,13.53 9.59,13.53 9.56,13.53 9.53,13.53 9.50,13.53 9.46,13.53 9.43,13.53 9.40,13.53 9.37,13.53 9.34,13.53 9.31,13.53 9.28,13.53 9.25,13.53 9.22,13.53 9.18,13.53 9.15,13.53 9.12,13.53 9.09,13.53 9.06,13.53 9.03,13.53 9.00,13.53 8.97,13.53 8.94,13.53 8.90,13.53 8.87,13.53 8.84,13.53 8.81,13.53 8.78,13.53 8.75,13.53 8.72,13.53 8.69,13.53 8.66,13.53 8.62,13.53 8.59,13.53 8.56,13.53 8.53,13.53 8.50,13.53 8.47,13.53 8.44,13.53 8.41,13.53 8.38,13.53 8.34,13.53 8.31,13.53 8.28,13.53 8.25,13.53 8.22,13.53 8.19,13.53 8.16,13.53 8.13,13.53 8.10,13.53 8.06,13.53 8.03,13.53 8.00,13.53 7.97,13.53 7.94,13.53 7.91,13.53 7.88,13.53 7.85,13.53 7.82,13.53 7.78,13.53 7.75,13.53 7.72,13.53 7.69,13.53 7.66,13.53 7.63,13.53 7.60,13.53 7.57,13.53 7.54,13.53 7.50,13.53 7.47,13.53 7.44,13.53 7.41,13.53 7.38,13.53 7.35,13.53 7.32,13.53 7.29,13.53 7.26,13.53 7.22,13.53 7.19,13.53 7.16,13.53 7.13,13.53 7.10,13.53 7.07,13.53 7.04,13.53 7.01,13.53 6.98,13.53 6.94,13.53 6.91,13.53 6.88,13.53 6.85,13.53 6.82,13.53 6.79,13.53 6.76,13.53 6.73,13.53 6.70,13.53 6.66,13.53 6.63,13.53 6.60,13.53 6.57,13.53 6.54,13.53 6.51,13.53 6.48,13.53 6.45,13.53 6.42,13.53 6.38,13.53 6.35,13.53 6.32,13.53 6.29,13.53 6.26,13.53 6.23,13.53 6.20,13.53 6.17,13.53 6.14,13.53 6.10,13.53 6.07,13.53 6.04,13.53 6.01,13.53 5.98,13.53 5.95,13.53 5.92,13.53 5.89,13.53 5.86,13.53 5.83,13.53 5.79,13.53 5.76,13.53 5.73,13.53 5.70,13.53 5.67,13.53 5.64,13.53 5.61,13.53 5.58,13.53 5.55,13.53 5.51,13.53 5.48,13.53 5.45,13.53 5.42,13.53 5.39,13.53 5.36,13.53 5.33,13.53 5.30,13.53 5.27,13.53 5.23,13.53 5.20,13.53 5.17,13.53 5.14,13.53 5.11,13.53 5.08,13.53 5.05,13.53 5.02,13.53 4.99,13.53 4.95,13.53 4.92,13.53 4.89,13.53 4.86,13.53 4.83,13.53 4.80,13.53 4.77,13.53 4.74,13.53 4.71,13.53 4.67,13.53 4.64,13.53 4.61,13.53 4.58,13.53 4.55,13.53 4.52,13.53 4.49,13.53 4.46,13.53 4.43,13.53 4.39,13.53 4.36,13.53 4.33,13.53 4.30,13.53 4.27,13.53 4.24,13.53 4.21,13.53 4.18,13.53 4.15,13.53 4.11,13.53 4.08,13.53 4.05,13.53 4.02,13.53 3.99,13.53 3.96,13.53 3.93,13.53 3.90,13.53 3.87,13.53 " style="stroke-width: 0.00; stroke: none; stroke-linecap: butt; fill: #BEBEBE;"></polygon><polyline points="3.87,13.50 3.90,13.50 3.93,13.50 3.96,13.50 3.99,13.50 4.02,13.50 4.05,13.50 4.08,13.50 4.11,13.50 4.15,13.50 4.18,13.49 4.21,13.49 4.24,13.49 4.27,13.49 4.30,13.49 4.33,13.49 4.36,13.49 4.39,13.49 4.43,13.49 4.46,13.49 4.49,13.49 4.52,13.49 4.55,13.49 4.58,13.49 4.61,13.48 4.64,13.48 4.67,13.48 4.71,13.48 4.74,13.48 4.77,13.48 4.80,13.48 4.83,13.48 4.86,13.48 4.89,13.48 4.92,13.48 4.95,13.48 4.99,13.47 5.02,13.47 5.05,13.47 5.08,13.47 5.11,13.47 5.14,13.47 5.17,13.47 5.20,13.47 5.23,13.47 5.27,13.47 5.30,13.46 5.33,13.46 5.36,13.46 5.39,13.46 5.42,13.46 5.45,13.46 5.48,13.46 5.51,13.46 5.55,13.45 5.58,13.45 5.61,13.45 5.64,13.45 5.67,13.45 5.70,13.45 5.73,13.45 5.76,13.45 5.79,13.44 5.83,13.44 5.86,13.44 5.89,13.44 5.92,13.44 5.95,13.44 5.98,13.44 6.01,13.43 6.04,13.43 6.07,13.43 6.10,13.43 6.14,13.43 6.17,13.43 6.20,13.42 6.23,13.42 6.26,13.42 6.29,13.42 6.32,13.42 6.35,13.42 6.38,13.41 6.42,13.41 6.45,13.41 6.48,13.41 6.51,13.41 6.54,13.40 6.57,13.40 6.60,13.40 6.63,13.40 6.66,13.40 6.70,13.39 6.73,13.39 6.76,13.39 6.79,13.39 6.82,13.39 6.85,13.38 6.88,13.38 6.91,13.38 6.94,13.38 6.98,13.37 7.01,13.37 7.04,13.37 7.07,13.37 7.10,13.37 7.13,13.36 7.16,13.36 7.19,13.36 7.22,13.36 7.26,13.35 7.29,13.35 7.32,13.35 7.35,13.35 7.38,13.34 7.41,13.34 7.44,13.34 7.47,13.33 7.50,13.33 7.54,13.33 7.57,13.33 7.60,13.32 7.63,13.32 7.66,13.32 7.69,13.31 7.72,13.31 7.75,13.31 7.78,13.30 7.82,13.30 7.85,13.30 7.88,13.29 7.91,13.29 7.94,13.29 7.97,13.28 8.00,13.28 8.03,13.28 8.06,13.27 8.10,13.27 8.13,13.27 8.16,13.26 8.19,13.26 8.22,13.26 8.25,13.25 8.28,13.25 8.31,13.25 8.34,13.24 8.38,13.24 8.41,13.23 8.44,13.23 8.47,13.23 8.50,13.22 8.53,13.22 8.56,13.21 8.59,13.21 8.62,13.20 8.66,13.20 8.69,13.20 8.72,13.19 8.75,13.19 8.78,13.18 8.81,13.18 8.84,13.17 8.87,13.17 8.90,13.17 8.94,13.16 8.97,13.16 9.00,13.15 9.03,13.15 9.06,13.14 9.09,13.14 9.12,13.13 9.15,13.13 9.18,13.12 9.22,13.12 9.25,13.11 9.28,13.11 9.31,13.10 9.34,13.10 9.37,13.09 9.40,13.08 9.43,13.08 9.46,13.07 9.50,13.07 9.53,13.06 9.56,13.06 9.59,13.05 9.62,13.05 9.65,13.04 9.68,13.03 9.71,13.03 9.74,13.02 9.78,13.02 9.81,13.01 9.84,13.00 9.87,13.00 9.90,12.99 9.93,12.99 9.96,12.98 9.99,12.97 10.02,12.97 10.06,12.96 10.09,12.95 10.12,12.95 10.15,12.94 10.18,12.93 10.21,12.93 10.24,12.92 10.27,12.91 10.30,12.91 10.34,12.90 10.37,12.89 10.40,12.88 10.43,12.88 10.46,12.87 10.49,12.86 10.52,12.86 10.55,12.85 10.58,12.84 10.62,12.83 10.65,12.83 10.68,12.82 10.71,12.81 10.74,12.80 10.77,12.79 10.80,12.79 10.83,12.78 10.86,12.77 10.90,12.76 10.93,12.75 10.96,12.75 10.99,12.74 11.02,12.73 11.05,12.72 11.08,12.71 11.11,12.70 11.14,12.70 11.17,12.69 11.21,12.68 11.24,12.67 11.27,12.66 11.30,12.65 11.33,12.64 11.36,12.63 11.39,12.63 11.42,12.62 11.45,12.61 11.49,12.60 11.52,12.59 11.55,12.58 11.58,12.57 11.61,12.56 11.64,12.55 11.67,12.54 11.70,12.53 11.73,12.52 11.77,12.51 11.80,12.50 11.83,12.49 11.86,12.48 11.89,12.47 11.92,12.46 11.95,12.45 11.98,12.44 12.01,12.43 12.05,12.42 12.08,12.41 12.11,12.40 12.14,12.39 12.17,12.38 12.20,12.37 12.23,12.36 12.26,12.35 12.29,12.34 12.33,12.33 12.36,12.32 12.39,12.30 12.42,12.29 12.45,12.28 12.48,12.27 12.51,12.26 12.54,12.25 12.57,12.24 12.61,12.23 12.64,12.21 12.67,12.20 12.70,12.19 12.73,12.18 12.76,12.17 12.79,12.16 12.82,12.14 12.85,12.13 12.89,12.12 12.92,12.11 12.95,12.10 12.98,12.08 13.01,12.07 13.04,12.06 13.07,12.05 13.10,12.03 13.13,12.02 13.17,12.01 13.20,12.00 13.23,11.98 13.26,11.97 13.29,11.96 13.32,11.94 13.35,11.93 13.38,11.92 13.41,11.91 13.45,11.89 13.48,11.88 13.51,11.87 13.54,11.85 13.57,11.84 13.60,11.83 13.63,11.81 13.66,11.80 13.69,11.79 13.73,11.77 13.76,11.76 13.79,11.74 13.82,11.73 13.85,11.72 13.88,11.70 13.91,11.69 13.94,11.67 13.97,11.66 14.01,11.65 14.04,11.63 14.07,11.62 14.10,11.60 14.13,11.59 14.16,11.57 14.19,11.56 14.22,11.55 14.25,11.53 14.29,11.52 14.32,11.50 14.35,11.49 14.38,11.47 14.41,11.46 14.44,11.44 14.47,11.43 14.50,11.41 14.53,11.40 14.57,11.38 14.60,11.37 14.63,11.35 14.66,11.33 14.69,11.32 14.72,11.30 14.75,11.29 14.78,11.27 14.81,11.26 14.85,11.24 14.88,11.22 14.91,11.21 14.94,11.19 14.97,11.18 15.00,11.16 15.03,11.14 15.06,11.13 15.09,11.11 15.13,11.10 15.16,11.08 15.19,11.06 15.22,11.05 15.25,11.03 15.28,11.01 15.31,11.00 15.34,10.98 15.37,10.96 15.41,10.95 15.44,10.93 15.47,10.91 15.50,10.90 15.53,10.88 15.56,10.86 15.59,10.85 15.62,10.83 15.65,10.81 15.69,10.79 15.72,10.78 15.75,10.76 15.78,10.74 15.81,10.72 15.84,10.71 15.87,10.69 15.90,10.67 15.93,10.65 15.97,10.64 16.00,10.62 16.03,10.60 16.06,10.58 16.09,10.56 16.12,10.55 16.15,10.53 16.18,10.51 16.21,10.49 16.24,10.47 16.28,10.45 16.31,10.44 16.34,10.42 16.37,10.40 16.40,10.38 16.43,10.36 16.46,10.34 16.49,10.32 16.52,10.31 16.56,10.29 16.59,10.27 16.62,10.25 16.65,10.23 16.68,10.21 16.71,10.19 16.74,10.17 16.77,10.15 16.80,10.13 16.84,10.11 16.87,10.09 16.90,10.08 16.93,10.06 16.96,10.04 16.99,10.02 17.02,10.00 17.05,9.98 17.08,9.96 17.12,9.94 17.15,9.92 17.18,9.90 17.21,9.88 17.24,9.86 17.27,9.84 17.30,9.82 17.33,9.80 17.36,9.77 17.40,9.75 17.43,9.73 17.46,9.71 17.49,9.69 17.52,9.67 17.55,9.65 17.58,9.63 17.61,9.61 17.64,9.59 17.68,9.57 17.71,9.55 17.74,9.52 17.77,9.50 17.80,9.48 17.83,9.46 17.86,9.44 17.89,9.42 17.92,9.40 17.96,9.37 17.99,9.35 18.02,9.33 18.05,9.31 18.08,9.29 18.11,9.27 18.14,9.24 18.17,9.22 18.20,9.20 18.24,9.18 18.27,9.15 18.30,9.13 18.33,9.11 18.36,9.09 18.39,9.06 18.42,9.04 18.45,9.02 18.48,9.00 18.52,8.97 18.55,8.95 18.58,8.93 18.61,8.90 18.64,8.88 18.67,8.86 18.70,8.83 18.73,8.81 18.76,8.79 18.80,8.76 18.83,8.74 18.86,8.72 18.89,8.69 18.92,8.67 18.95,8.64 18.98,8.62 19.01,8.60 19.04,8.57 19.08,8.55 19.11,8.52 19.14,8.50 19.17,8.47 19.20,8.45 19.23,8.42 19.26,8.40 19.29,8.38 19.32,8.35 19.36,8.33 19.39,8.30 19.42,8.27 19.45,8.25 19.48,8.22 19.51,8.20 19.54,8.17 19.57,8.15 19.60,8.12 19.64,8.10 19.67,8.07 19.70,8.05 19.73,8.02 19.76,7.99 19.79,7.97 19.82,7.94 19.85,7.91 19.88,7.89 19.92,7.86 19.95,7.84 19.98,7.81 20.01,7.78 20.04,7.76 20.07,7.73 20.10,7.70 20.13,7.67 20.16,7.65 20.20,7.62 20.23,7.59 20.26,7.57 20.29,7.54 20.32,7.51 20.35,7.48 20.38,7.46 20.41,7.43 20.44,7.40 20.48,7.37 20.51,7.34 20.54,7.32 20.57,7.29 20.60,7.26 20.63,7.23 20.66,7.20 20.69,7.17 20.72,7.15 20.76,7.12 20.79,7.09 20.82,7.06 20.85,7.03 20.88,7.00 20.91,6.97 20.94,6.94 20.97,6.91 21.00,6.89 21.04,6.86 21.07,6.83 21.10,6.80 21.13,6.77 21.16,6.74 21.19,6.71 21.22,6.68 21.25,6.65 21.28,6.62 21.31,6.59 21.35,6.56 21.38,6.53 21.41,6.50 21.44,6.47 21.47,6.44 21.50,6.41 21.53,6.38 21.56,6.35 21.59,6.32 21.63,6.28 21.66,6.25 21.69,6.22 21.72,6.19 21.75,6.16 21.78,6.13 21.81,6.10 21.84,6.07 21.87,6.04 21.91,6.01 21.94,5.97 21.97,5.94 22.00,5.91 22.03,5.88 22.06,5.85 22.09,5.82 22.12,5.78 22.15,5.75 22.19,5.72 22.22,5.69 22.25,5.66 22.28,5.63 22.31,5.59 22.34,5.56 22.37,5.53 22.40,5.50 22.43,5.47 22.47,5.43 22.50,5.40 22.53,5.37 22.56,5.34 22.59,5.30 22.62,5.27 22.65,5.24 22.68,5.21 22.71,5.17 22.75,5.14 22.78,5.11 22.81,5.08 22.84,5.04 22.87,5.01 22.90,4.98 22.93,4.95 22.96,4.91 22.99,4.88 23.03,4.85 23.06,4.82 23.09,4.78 23.12,4.75 23.15,4.72 23.18,4.68 23.21,4.65 23.24,4.62 23.27,4.59 23.31,4.55 23.34,4.52 23.37,4.49 23.40,4.45 23.43,4.42 23.46,4.39 23.49,4.36 23.52,4.32 23.55,4.29 23.59,4.26 23.62,4.23 23.65,4.19 23.68,4.16 23.71,4.13 23.74,4.10 23.77,4.06 23.80,4.03 23.83,4.00 23.87,3.96 23.90,3.93 23.93,3.90 23.96,3.87 23.99,3.84 24.02,3.80 24.05,3.77 24.08,3.74 24.11,3.71 24.15,3.67 24.18,3.64 24.21,3.61 24.24,3.58 24.27,3.55 24.30,3.51 24.33,3.48 24.36,3.45 24.39,3.42 24.43,3.39 24.46,3.36 24.49,3.32 24.52,3.29 24.55,3.26 24.58,3.23 24.61,3.20 24.64,3.17 24.67,3.14 24.71,3.11 24.74,3.08 24.77,3.05 24.80,3.01 24.83,2.98 24.86,2.95 24.89,2.92 24.92,2.89 24.95,2.86 24.99,2.83 25.02,2.80 25.05,2.77 25.08,2.74 25.11,2.71 25.14,2.69 25.17,2.66 25.20,2.63 25.23,2.60 25.27,2.57 25.30,2.54 25.33,2.51 25.36,2.48 25.39,2.45 25.42,2.43 25.45,2.40 25.48,2.37 25.51,2.34 25.55,2.32 25.58,2.29 25.61,2.26 25.64,2.23 25.67,2.21 25.70,2.18 25.73,2.15 25.76,2.13 25.79,2.10 25.83,2.07 25.86,2.05 25.89,2.02 25.92,2.00 25.95,1.97 25.98,1.95 26.01,1.92 26.04,1.90 26.07,1.87 26.11,1.85 26.14,1.82 26.17,1.80 26.20,1.77 26.23,1.75 26.26,1.73 26.29,1.70 26.32,1.68 26.35,1.66 26.39,1.63 26.42,1.61 26.45,1.59 26.48,1.57 26.51,1.55 26.54,1.52 26.57,1.50 26.60,1.48 26.63,1.46 26.66,1.44 26.70,1.42 26.73,1.40 26.76,1.38 26.79,1.36 26.82,1.34 26.85,1.32 26.88,1.30 26.91,1.28 26.94,1.26 26.98,1.25 27.01,1.23 27.04,1.21 27.07,1.19 27.10,1.17 27.13,1.16 27.16,1.14 27.19,1.12 27.22,1.11 27.26,1.09 27.29,1.08 27.32,1.06 27.35,1.05 27.38,1.03 27.41,1.02 27.44,1.00 27.47,0.99 27.50,0.97 27.54,0.96 27.57,0.95 27.60,0.93 27.63,0.92 27.66,0.91 27.69,0.90 27.72,0.88 27.75,0.87 27.78,0.86 27.82,0.85 27.85,0.84 27.88,0.83 27.91,0.82 27.94,0.81 27.97,0.80 28.00,0.79 28.03,0.78 28.06,0.77 28.10,0.76 28.13,0.75 28.16,0.75 28.19,0.74 28.22,0.73 28.25,0.72 28.28,0.72 28.31,0.71 28.34,0.70 28.38,0.70 28.41,0.69 28.44,0.69 28.47,0.68 28.50,0.68 28.53,0.67 28.56,0.67 28.59,0.67 28.62,0.66 28.66,0.66 28.69,0.66 28.72,0.65 28.75,0.65 28.78,0.65 28.81,0.65 28.84,0.65 28.87,0.65 28.90,0.65 28.94,0.64 28.97,0.64 29.00,0.64 29.03,0.65 29.06,0.65 29.09,0.65 29.12,0.65 29.15,0.65 29.18,0.65 29.22,0.66 29.25,0.66 29.28,0.66 29.31,0.66 29.34,0.67 29.37,0.67 29.40,0.68 29.43,0.68 29.46,0.69 29.50,0.69 29.53,0.70 29.56,0.70 29.59,0.71 29.62,0.71 29.65,0.72 29.68,0.73 29.71,0.73 29.74,0.74 29.78,0.75 29.81,0.76 29.84,0.77 29.87,0.78 29.90,0.78 29.93,0.79 29.96,0.80 29.99,0.81 30.02,0.82 30.06,0.83 30.09,0.85 30.12,0.86 30.15,0.87 30.18,0.88 30.21,0.89 30.24,0.90 30.27,0.92 30.30,0.93 30.34,0.94 30.37,0.95 30.40,0.97 30.43,0.98 30.46,1.00 30.49,1.01 30.52,1.03 30.55,1.04 30.58,1.06 30.62,1.07 30.65,1.09 30.68,1.11 30.71,1.12 30.74,1.14 30.77,1.16 30.80,1.17 30.83,1.19 30.86,1.21 30.90,1.23 30.93,1.24 30.96,1.26 30.99,1.28 31.02,1.30 31.05,1.32 31.08,1.34 31.11,1.36 31.14,1.38 31.18,1.40 31.21,1.42 31.24,1.44 31.27,1.46 31.30,1.48 31.33,1.50 31.36,1.53 31.39,1.55 31.42,1.57 31.46,1.59 31.49,1.62 31.52,1.64 31.55,1.66 31.58,1.69 31.61,1.71 31.64,1.73 31.67,1.76 31.70,1.78 31.73,1.81 31.77,1.83 31.80,1.86 31.83,1.88 31.86,1.91 31.89,1.93 31.92,1.96 31.95,1.98 31.98,2.01 32.01,2.04 32.05,2.06 32.08,2.09 32.11,2.12 32.14,2.14 32.17,2.17 32.20,2.20 32.23,2.23 32.26,2.25 32.29,2.28 32.33,2.31 32.36,2.34 32.39,2.37 32.42,2.40 32.45,2.42 32.48,2.45 32.51,2.48 32.54,2.51 32.57,2.54 32.61,2.57 32.64,2.60 32.67,2.63 32.70,2.66 32.73,2.69 32.76,2.72 32.79,2.75 32.82,2.79 32.85,2.82 32.89,2.85 32.92,2.88 32.95,2.91 32.98,2.94 33.01,2.97 33.04,3.01 33.07,3.04 33.10,3.07 33.13,3.10 33.17,3.13 33.20,3.17 33.23,3.20 33.26,3.23 33.29,3.26 33.32,3.30 33.35,3.33 33.38,3.36 33.41,3.40 33.45,3.43 33.48,3.46 33.51,3.50 33.54,3.53 33.57,3.56 33.60,3.60 33.63,3.63 33.66,3.67 33.69,3.70 33.73,3.74 33.76,3.77 33.79,3.80 33.82,3.84 33.85,3.87 33.88,3.91 33.91,3.94 33.94,3.98 33.97,4.01 34.01,4.05 34.04,4.08 34.07,4.12 34.10,4.15 34.13,4.19 34.16,4.22 34.19,4.26 34.22,4.29 34.25,4.33 34.29,4.37 34.32,4.40 34.35,4.44 34.38,4.47 34.41,4.51 34.44,4.54 34.47,4.58 34.50,4.62 34.53,4.65 34.57,4.69 34.60,4.72 34.63,4.76 34.66,4.80 34.69,4.83 34.72,4.87 34.75,4.90 34.78,4.94 34.81,4.98 34.85,5.01 34.88,5.05 34.91,5.08 34.94,5.12 34.97,5.16 35.00,5.19 35.03,5.23 35.06,5.27 35.09,5.30 35.13,5.34 35.16,5.38 35.19,5.41 35.22,5.45 35.25,5.48 35.28,5.52 35.31,5.56 35.34,5.59 35.37,5.63 35.41,5.67 35.44,5.70 35.47,5.74 35.50,5.78 35.53,5.81 35.56,5.85 35.59,5.88 35.62,5.92 35.65,5.96 35.69,5.99 35.72,6.03 35.75,6.07 35.78,6.10 35.81,6.14 35.84,6.17 35.87,6.21 35.90,6.25 35.93,6.28 35.97,6.32 36.00,6.35 36.03,6.39 36.06,6.43 36.09,6.46 36.12,6.50 36.15,6.53 36.18,6.57 36.21,6.60 36.25,6.64 36.28,6.68 36.31,6.71 36.34,6.75 36.37,6.78 36.40,6.82 36.43,6.85 36.46,6.89 36.49,6.92 36.53,6.96 36.56,6.99 36.59,7.03 36.62,7.06 36.65,7.10 36.68,7.13 36.71,7.17 36.74,7.20 36.77,7.24 36.80,7.27 36.84,7.31 36.87,7.34 36.90,7.38 36.93,7.41 36.96,7.45 36.99,7.48 37.02,7.51 37.05,7.55 37.08,7.58 37.12,7.62 37.15,7.65 37.18,7.68 37.21,7.72 37.24,7.75 37.27,7.79 37.30,7.82 37.33,7.85 37.36,7.89 37.40,7.92 37.43,7.95 37.46,7.99 37.49,8.02 37.52,8.05 37.55,8.08 37.58,8.12 37.61,8.15 37.64,8.18 37.68,8.22 37.71,8.25 37.74,8.28 37.77,8.31 37.80,8.34 37.83,8.38 37.86,8.41 37.89,8.44 37.92,8.47 37.96,8.50 37.99,8.54 38.02,8.57 38.05,8.60 38.08,8.63 38.11,8.66 38.14,8.69 38.17,8.72 38.20,8.76 38.24,8.79 38.27,8.82 38.30,8.85 38.33,8.88 38.36,8.91 38.39,8.94 38.42,8.97 38.45,9.00 38.48,9.03 38.52,9.06 38.55,9.09 38.58,9.12 38.61,9.15 38.64,9.18 38.67,9.21 38.70,9.24 38.73,9.27 38.76,9.30 38.80,9.33 38.83,9.35 38.86,9.38 38.89,9.41 38.92,9.44 38.95,9.47 38.98,9.50 39.01,9.53 39.04,9.55 39.08,9.58 39.11,9.61 39.14,9.64 39.17,9.67 39.20,9.69 39.23,9.72 39.26,9.75 39.29,9.78 39.32,9.80 39.36,9.83 39.39,9.86 39.42,9.88 39.45,9.91 39.48,9.94 39.51,9.96 39.54,9.99 39.57,10.02 39.60,10.04 39.64,10.07 39.67,10.09 39.70,10.12 39.73,10.15 39.76,10.17 39.79,10.20 39.82,10.22 39.85,10.25 39.88,10.27 39.92,10.30 39.95,10.32 39.98,10.35 40.01,10.37 40.04,10.40 40.07,10.42 40.10,10.45 40.13,10.47 40.16,10.49 40.20,10.52 40.23,10.54 40.26,10.57 40.29,10.59 40.32,10.61 40.35,10.64 40.38,10.66 40.41,10.68 40.44,10.71 40.48,10.73 40.51,10.75 40.54,10.77 40.57,10.80 40.60,10.82 40.63,10.84 40.66,10.86 40.69,10.89 40.72,10.91 40.76,10.93 40.79,10.95 40.82,10.97 40.85,10.99 40.88,11.02 40.91,11.04 40.94,11.06 40.97,11.08 41.00,11.10 41.04,11.12 41.07,11.14 41.10,11.16 41.13,11.18 41.16,11.20 41.19,11.22 41.22,11.24 41.25,11.26 41.28,11.28 41.32,11.30 41.35,11.32 41.38,11.34 41.41,11.36 41.44,11.38 41.47,11.40 41.50,11.42 41.53,11.44 41.56,11.46 41.60,11.47 41.63,11.49 41.66,11.51 41.69,11.53 41.72,11.55 41.75,11.57 41.78,11.58 41.81,11.60 41.84,11.62 41.88,11.64 41.91,11.66 41.94,11.67 41.97,11.69 42.00,11.71 42.03,11.73 42.06,11.74 42.09,11.76 42.12,11.78 42.15,11.79 42.19,11.81 42.22,11.83 42.25,11.84 42.28,11.86 42.31,11.87 42.34,11.89 42.37,11.91 42.40,11.92 42.43,11.94 42.47,11.95 42.50,11.97 42.53,11.98 42.56,12.00 42.59,12.01 42.62,12.03 42.65,12.04 42.68,12.06 42.71,12.07 42.75,12.09 42.78,12.10 42.81,12.12 42.84,12.13 42.87,12.15 42.90,12.16 42.93,12.17 42.96,12.19 42.99,12.20 43.03,12.21 43.06,12.23 43.09,12.24 43.12,12.25 43.15,12.27 43.18,12.28 43.21,12.29 43.24,12.31 43.27,12.32 43.31,12.33 43.34,12.35 43.37,12.36 43.40,12.37 43.43,12.38 43.46,12.39 43.49,12.41 43.52,12.42 43.55,12.43 43.59,12.44 43.62,12.45 43.65,12.47 43.68,12.48 43.71,12.49 43.74,12.50 43.77,12.51 43.80,12.52 43.83,12.53 43.87,12.55 43.90,12.56 43.93,12.57 43.96,12.58 43.99,12.59 44.02,12.60 44.05,12.61 44.08,12.62 44.11,12.63 44.15,12.64 44.18,12.65 44.21,12.66 44.24,12.67 44.27,12.68 44.30,12.69 44.33,12.70 44.36,12.71 44.39,12.72 44.43,12.73 44.46,12.74 44.49,12.75 44.52,12.76 44.55,12.76 44.58,12.77 44.61,12.78 44.64,12.79 44.67,12.80 44.71,12.81 44.74,12.82 44.77,12.83 44.80,12.83 44.83,12.84 44.86,12.85 44.89,12.86 44.92,12.87 44.95,12.87 44.99,12.88 45.02,12.89 45.05,12.90 45.08,12.91 45.11,12.91 45.14,12.92 45.17,12.93 45.20,12.94 45.23,12.94 45.27,12.95 45.30,12.96 45.33,12.97 45.36,12.97 45.39,12.98 45.42,12.99 45.45,12.99 45.48,13.00 45.51,13.01 45.55,13.01 45.58,13.02 45.61,13.03 45.64,13.03 45.67,13.04 45.70,13.05 45.73,13.05 45.76,13.06 45.79,13.06 45.83,13.07 45.86,13.08 45.89,13.08 45.92,13.09 45.95,13.09 45.98,13.10 46.01,13.10 46.04,13.11 46.07,13.12 46.11,13.12 46.14,13.13 46.17,13.13 46.20,13.14 46.23,13.14 46.26,13.15 46.29,13.15 46.32,13.16 46.35,13.16 46.39,13.17 46.42,13.17 46.45,13.18 46.48,13.18 46.51,13.19 46.54,13.19 46.57,13.20 46.60,13.20 46.63,13.21 46.67,13.21 46.70,13.21 46.73,13.22 46.76,13.22 46.79,13.23 46.82,13.23 46.85,13.24 46.88,13.24 46.91,13.24 46.95,13.25 46.98,13.25 47.01,13.26 47.04,13.26 47.07,13.26 47.10,13.27 47.13,13.27 47.16,13.28 47.19,13.28 47.22,13.28 47.26,13.29 47.29,13.29 47.32,13.29 47.35,13.30 47.38,13.30 47.41,13.30 47.44,13.31 47.47,13.31 47.50,13.31 47.54,13.32 47.57,13.32 47.60,13.32 47.63,13.33 47.66,13.33 47.69,13.33 47.72,13.33 47.75,13.34 47.78,13.34 47.82,13.34 47.85,13.35 47.88,13.35 47.91,13.35 47.94,13.35 47.97,13.36 48.00,13.36 48.03,13.36 48.06,13.36 48.10,13.37 48.13,13.37 48.16,13.37 48.19,13.37 48.22,13.38 48.25,13.38 48.28,13.38 48.31,13.38 48.34,13.39 48.38,13.39 48.41,13.39 48.44,13.39 48.47,13.40 48.50,13.40 48.53,13.40 48.56,13.40 48.59,13.40 48.62,13.41 48.66,13.41 48.69,13.41 48.72,13.41 48.75,13.41 48.78,13.42 48.81,13.42 48.84,13.42 48.87,13.42 48.90,13.42 48.94,13.42 48.97,13.43 49.00,13.43 49.03,13.43 49.06,13.43 49.09,13.43 49.12,13.43 49.15,13.44 49.18,13.44 49.22,13.44 49.25,13.44 49.28,13.44 49.31,13.44 49.34,13.44 49.37,13.45 49.40,13.45 49.43,13.45 49.46,13.45 49.50,13.45 49.53,13.45 49.56,13.45 49.59,13.46 49.62,13.46 49.65,13.46 49.68,13.46 49.71,13.46 49.74,13.46 49.78,13.46 49.81,13.46 49.84,13.46 49.87,13.47 49.90,13.47 49.93,13.47 49.96,13.47 49.99,13.47 50.02,13.47 50.06,13.47 50.09,13.47 50.12,13.47 50.15,13.48 50.18,13.48 50.21,13.48 50.24,13.48 50.27,13.48 50.30,13.48 50.34,13.48 50.37,13.48 50.40,13.48 50.43,13.48 50.46,13.48 50.49,13.48 50.52,13.49 50.55,13.49 50.58,13.49 50.62,13.49 50.65,13.49 50.68,13.49 50.71,13.49 50.74,13.49 50.77,13.49 50.80,13.49 50.83,13.49 50.86,13.49 50.90,13.49 50.93,13.50 50.96,13.50 50.99,13.50 51.02,13.50 51.05,13.50 51.08,13.50 51.11,13.50 51.14,13.50 51.18,13.50 51.21,13.50 51.24,13.50 51.27,13.50 51.30,13.50 51.33,13.50 51.36,13.50 51.39,13.50 51.42,13.50 51.46,13.50 51.49,13.50 51.52,13.51 51.55,13.51 " style="stroke-width: 1.07; stroke-linecap: butt;"></polyline></g></g>
</svg></td>
</tr>
</tbody>
</table>

</div>

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
