---
date: 2020-09-08T05:00:00-04:00
title: "Membuat Prediksi Pertandingan English Premier League"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Sport Science
  - Soccer
  - Football
  - Poisson
  - Prediction
  - Premier League
  - R
---

**English Premier League** musim 2020/2021 akan segera dimulai dalam
beberapa hari lagi. Menarik jika kita melihat beberapa geliat di bursa
transfer. Walaupun pertandingan nanti tidak akan disaksikan oleh
penonton dalam waktu dekat, tapi tensi pertandingannya saya rasa masih
tetap sama.

Sejak kuliah di Matematika dulu, ada satu pertanyaan yang muncul:

> Apakah bisa saya membuat prediksi hasil akhir pertandingan di *Premier
> League*? Kalau bisa, bagaimana caranya?

Sampai akhirnya saya mendarat di suatu *website* yang membahas tentang
statistika di dunia judi. Berbekal `ilmu` yang saya dapatkan ini, saya
akan coba membuat prediksi dari pertandingan *English Premier League*
musim 2020/2021.

-----

## Bagaimana cara kerjanya?

Sebenarnya membuat prediksinya relatif cukup mudah. Pendekatan yang
dilakukan adalah dengan memanfaatkan distribusi
[**Poisson**](https://en.wikipedia.org/wiki/Poisson_distribution).
Walaupun masih ada pro dan kontra, tapi kebanyakan *scientist* setuju
bahwa **banyaknya gol dalam suatu pertandingan pertandingan sepakbola**
itu memenuhi asumsi distribusi Poisson.

-----

Apa saja asumsinya?

  - ![k](https://latex.codecogs.com/png.latex?k "k") is the number of
    times an event occurs in an interval and
    ![k](https://latex.codecogs.com/png.latex?k "k") can take values 0,
    1, 2, ….
  - The occurrence of one event does not affect the probability that a
    second event will occur. That is, events occur independently.
  - The average rate at which events occur is independent of any
    occurrences. For simplicity, this is usually assumed to be constant,
    but may in practice vary with time.
  - Two events cannot occur at exactly the same instant; instead, at
    each very small sub-interval exactly one event either occurs or does
    not occur.

-----

Jadi saya akan memprediksi banyak gol yang tercipta oleh **tim home**
dan **tim away** dalam suatu pertandingan menggunakan distribusi
Poisson\!

Dalam distribusi Poisson, parameter yang perlu diketahui adalah
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda").

Apakah arti dari
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda")?

Pada distribusi Poisson, salah satu sifatnya adalah ![\\lambda =
\\overline{x} =
\\sigma^2](https://latex.codecogs.com/png.latex?%5Clambda%20%3D%20%5Coverline%7Bx%7D%20%3D%20%5Csigma%5E2
"\\lambda = \\overline{x} = \\sigma^2").

  - ![\\overline{x}](https://latex.codecogs.com/png.latex?%5Coverline%7Bx%7D
    "\\overline{x}") berarti *mean* atau *expected value*.
  - ![\\sigma^2](https://latex.codecogs.com/png.latex?%5Csigma%5E2
    "\\sigma^2") berarti *variansi*.

Jadi pada distribusi Poisson, nilai *mean* dan variansinya adalah sama,
yakni sebesar ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda
"\\lambda").

Kalau teman-teman membaca tulisan saya sebelumnya terkait [**mitos home
vs away**](https://ikanx101.com/blog/EPL-home-away/), sebenarnya ada
*easter eggs* di salah satu tabel bahwa nilai
![\\overline{x}](https://latex.codecogs.com/png.latex?%5Coverline%7Bx%7D
"\\overline{x}") hampir mirip dengan nilai
![\\sigma^2](https://latex.codecogs.com/png.latex?%5Csigma%5E2
"\\sigma^2").

> Dengan mengetahui nilai *expected value* (dalam hal ini adalah
> **expected goals**) setiap tim pada saat laga home dan away, saya bisa
> menghitung peluang gol yang tercipta dalam suatu pertandingan\!

Berikut adalah alur pengerjaannya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/poisson/prediksi_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

-----

## Data Mentah

Data yang digunakan adalah statistik pertandingan EPL pada musim lalu.
Variabel yang akan masuk kedalam perhitungan adalah:

1.  Nama `tim_home`
2.  Nama `tim_away`
3.  Goal yang dicetak `tim_home`
4.  Goal yang dicetak `tim_away`

Berikut adalah sampel data dari musim lalu:

| date       | home\_team     | away\_team       | home\_goals | away\_goals |
| :--------- | :------------- | :--------------- | ----------: | ----------: |
| 09/08/2019 | Liverpool      | Norwich          |           4 |           1 |
| 10/08/2019 | West Ham       | Man City         |           0 |           5 |
| 10/08/2019 | Bournemouth    | Sheffield United |           1 |           1 |
| 10/08/2019 | Burnley        | Southampton      |           3 |           0 |
| 10/08/2019 | Crystal Palace | Everton          |           0 |           0 |
| 10/08/2019 | Watford        | Brighton         |           0 |           3 |
| 10/08/2019 | Tottenham      | Aston Villa      |           3 |           1 |
| 11/08/2019 | Leicester      | Wolves           |           0 |           0 |
| 11/08/2019 | Newcastle      | Arsenal          |           0 |           1 |
| 11/08/2019 | Man United     | Chelsea          |           4 |           0 |

## Pecah Menjadi Data `home` dan `away`

Sebagaimana yang telah saya sampaikan, bahwa ada perbedaan antara tim
`home` dan tim `away` dalam hal ketajaman mencetak goal. Oleh karena
itu, saya akan bagi dua datanya menjadi data tim `home` dan data tim
`away`.

Apa sih gunanya? Kelak saya akan menghitung skor `attack` dan `defense`
masing-masing tim pada laga `home` dan `away`.

Begini caranya:

Misalkan tim `Man United` selama berlaga di `home` pada musim lalu
(misalkan ada `40` laga) berhasil mencetak gol sebanyak `100` kali dan
kebobolan `50` kali.

Apabila rata-rata gol yang dicetak semua tim pada laga `home` adalah
`1.7` dan rata-rata kebobolan semua tim pada laga `home` adalah `0.8`,
maka:

  - `Attack` tim `Man United` pada laga `home` adalah:
    ![\\frac{\\frac{100}{40}}{1.7}
    =](https://latex.codecogs.com/png.latex?%5Cfrac%7B%5Cfrac%7B100%7D%7B40%7D%7D%7B1.7%7D%20%3D
    "\\frac{\\frac{100}{40}}{1.7} =") 1.4705882.
  - `Defense` tim `Man United` pada laga `home` adalah:
    ![\\frac{\\frac{50}{40}}{0.8}
    =](https://latex.codecogs.com/png.latex?%5Cfrac%7B%5Cfrac%7B50%7D%7B40%7D%7D%7B0.8%7D%20%3D
    "\\frac{\\frac{50}{40}}{0.8} =") 1.5625.
  - `Overall` tim `Man United` pada laga `home` adalah selisih antara
    `Attack` dan `Defense` = -0.0919118

Perhitungan ini diulang kembali saat `Man United` berlaga di `away`
dengan nilai `attack` dan `defense` yang terbalik dengan laga `home`.

<table>

<caption>

Contoh Data Home

</caption>

<thead>

<tr>

<th style="text-align:left;">

home\_team

</th>

<th style="text-align:right;">

home\_attack

</th>

<th style="text-align:right;">

home\_defense

</th>

<th style="text-align:right;">

overall\_home

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Arsenal

</td>

<td style="text-align:right;">

1.2500000

</td>

<td style="text-align:right;">

1.048035

</td>

<td style="text-align:right;">

0.2019651

</td>

</tr>

<tr>

<td style="text-align:left;">

Aston Villa

</td>

<td style="text-align:right;">

0.7638889

</td>

<td style="text-align:right;">

1.310044

</td>

<td style="text-align:right;">

\-0.5461548

</td>

</tr>

<tr>

<td style="text-align:left;">

Bournemouth

</td>

<td style="text-align:right;">

0.7638889

</td>

<td style="text-align:right;">

1.310044

</td>

<td style="text-align:right;">

\-0.5461548

</td>

</tr>

<tr>

<td style="text-align:left;">

Brighton

</td>

<td style="text-align:right;">

0.6944444

</td>

<td style="text-align:right;">

1.179039

</td>

<td style="text-align:right;">

\-0.4845949

</td>

</tr>

<tr>

<td style="text-align:left;">

Burnley

</td>

<td style="text-align:right;">

0.8333333

</td>

<td style="text-align:right;">

1.004367

</td>

<td style="text-align:right;">

\-0.1710335

</td>

</tr>

<tr>

<td style="text-align:left;">

Chelsea

</td>

<td style="text-align:right;">

1.0416667

</td>

<td style="text-align:right;">

0.698690

</td>

<td style="text-align:right;">

0.3429767

</td>

</tr>

</tbody>

</table>

<table>

<caption>

Contoh Data Away

</caption>

<thead>

<tr>

<th style="text-align:left;">

away\_team

</th>

<th style="text-align:right;">

away\_attack

</th>

<th style="text-align:right;">

away\_defense

</th>

<th style="text-align:right;">

overall\_away

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Arsenal

</td>

<td style="text-align:right;">

0.8733624

</td>

<td style="text-align:right;">

0.8333333

</td>

<td style="text-align:right;">

0.0400291

</td>

</tr>

<tr>

<td style="text-align:left;">

Aston Villa

</td>

<td style="text-align:right;">

0.8296943

</td>

<td style="text-align:right;">

1.2847222

</td>

<td style="text-align:right;">

\-0.4550279

</td>

</tr>

<tr>

<td style="text-align:left;">

Bournemouth

</td>

<td style="text-align:right;">

0.7860262

</td>

<td style="text-align:right;">

1.2152778

</td>

<td style="text-align:right;">

\-0.4292516

</td>

</tr>

<tr>

<td style="text-align:left;">

Brighton

</td>

<td style="text-align:right;">

0.8296943

</td>

<td style="text-align:right;">

0.9375000

</td>

<td style="text-align:right;">

\-0.1078057

</td>

</tr>

<tr>

<td style="text-align:left;">

Burnley

</td>

<td style="text-align:right;">

0.8296943

</td>

<td style="text-align:right;">

0.9375000

</td>

<td style="text-align:right;">

\-0.1078057

</td>

</tr>

<tr>

<td style="text-align:left;">

Chelsea

</td>

<td style="text-align:right;">

1.7030568

</td>

<td style="text-align:right;">

1.3194444

</td>

<td style="text-align:right;">

0.3836123

</td>

</tr>

</tbody>

</table>

## Menghitung `expected goals`

Sekarang saatnya saya menghitung *expected goals* masing-masing tim yang
berlaga. Bagaimana caranya?

Misalkan saya ambil contoh pertandingan *Community Shield* yang digelar
pekan lalu: `Arsenal` vs `Liverpool`. Meskipun pertandingan ini bukan
pertandingan `home` vs `away`, tapi akan saya asumsikan demikian untuk
mempermudah penjelasan.

Dari sini, saya definisikan:

  - `tim_home` = `Arsenal`
  - `tim_away` = `Liverpool`

Maka *expected goals* masing-masing tim adalah:

  
![Xgoal\_{Arsenal} =
Attack\_{Arsenal}\*Defense\_{Liverpool}\*\\overline{goal}\_{home}](https://latex.codecogs.com/png.latex?Xgoal_%7BArsenal%7D%20%3D%20Attack_%7BArsenal%7D%2ADefense_%7BLiverpool%7D%2A%5Coverline%7Bgoal%7D_%7Bhome%7D
"Xgoal_{Arsenal} = Attack_{Arsenal}*Defense_{Liverpool}*\\overline{goal}_{home}")  
  
![Xgoal\_{Liverpool} =
Attack\_{Liverpool}\*Defense\_{Arsenal}\*\\overline{goal}\_{away}](https://latex.codecogs.com/png.latex?Xgoal_%7BLiverpool%7D%20%3D%20Attack_%7BLiverpool%7D%2ADefense_%7BArsenal%7D%2A%5Coverline%7Bgoal%7D_%7Baway%7D
"Xgoal_{Liverpool} = Attack_{Liverpool}*Defense_{Arsenal}*\\overline{goal}_{away}")  

Yakni 1.1184211 untuk `Arsenal` dan 1.8202712 untuk `Liverpool`.

## Menghitung Peluang Terjadinya Gol

Berbekal informasi di atas, kita akan menghitung peluang gol yang
tercipta pada pertandingan.

Misalkan, saya ingin menghitung peluang pertandingan berakhir dengan
skor `0 - 2`, maka caranya adalah:

![P(skor = 0 - 2) =
P(home=0)\*P(away=2)](https://latex.codecogs.com/png.latex?P%28skor%20%3D%200%20-%202%29%20%3D%20P%28home%3D0%29%2AP%28away%3D2%29
"P(skor = 0 - 2) = P(home=0)*P(away=2)")

Maka untuk menghitung semua kombinasi skor yang mungkin, saya akan
membuat matrix peluang sebagai berikut:

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]   NA   NA   NA   NA   NA
    ## [2,]   NA   NA   NA   NA   NA
    ## [3,]   NA   NA   NA   NA   NA
    ## [4,]   NA   NA   NA   NA   NA
    ## [5,]   NA   NA   NA   NA   NA

Nantinya sumbu x menandakan tim `home` dan sumbu y menandakan tim
`away`.

Jadi, hasil perhitungan untuk laga `Arsenal`kontra `Liverpool` adalah
sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/poisson/prediksi_files/figure-gfm/unnamed-chunk-6-1.png" width="672" />

Menarik yah, ternyata peluang terbesar itu terjadi pada saat skor: `1-1`
lalu `1-2`.

Jika saya *summary*-kan hasil akhir dari berbagai kemungkinan skor
tersebut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/poisson/prediksi_files/figure-gfm/unnamed-chunk-7-1.png" width="672" />

`Liverpool` masih dijagokan untuk menang.

## Faktanya:

Hasil pertandingan berakhir seri `1-1`, namun ada saat *penalty
shootout* `Arsenal` berhasil menang.

## What’s next?

Wajar saja jika perhitungan di atas *miss* pada pertandingan semacam
*community shield*, tapi nanti pada saat laga resmi bergulir akan saya
coba pantau kinerja dari model perhitungan ini secara berkala dengan
menambahkan data pertandingan terbaru.

## Laga Pembuka EPL 2020/2021

Sebagai penutup, saya akan coba memprediksi laga pembuka Premier League
2020/2021 untuk 2 tim: `Man United` dan `Chelsea`. Untuk `Man City`
mohon maaf, kalian hitung sendiri saja ya. *haha*

Sedangkan `Liverpool` melawan `Leeds` belum bisa dihitung karena `Leeds`
baru saja promosi musim ini. Sama juga dengan `Fulham` kontra `Arsenal`
belum bisa dihitung karena `Fulham` baru promosi musim ini.

### Man United vs Crystal Palace

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/poisson/prediksi_files/figure-gfm/unnamed-chunk-8-1.png" width="672" /><img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/poisson/prediksi_files/figure-gfm/unnamed-chunk-8-2.png" width="672" />

### Brighton vs Chelsea

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/poisson/prediksi_files/figure-gfm/unnamed-chunk-9-1.png" width="672" /><img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/poisson/prediksi_files/figure-gfm/unnamed-chunk-9-2.png" width="672" />
