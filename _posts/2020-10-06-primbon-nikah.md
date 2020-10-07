---
date: 2020-10-06T09:00:00-04:00
title: "Primbon ala Data Science: Tanggal Pernikahan Terbaik di 2021"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Calendar
  - R
  - Primbon
  - Pernikahan
  - 2021
---

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/primbon%20nikah/primbon.jpeg" width="300" />

Bagi sebagian suku di Indonesia, penentuan tanggal nikahan bisa menjadi
hal yang rumit. Banyak teman saya bercerita betapa *syulitnya* proses
`perhitungan` yang dilakukan keluarga mereka untuk mendapatkan tanggal
nikahan yang **bagus**.

Percaya atau tidak, kalau hanya menghitung tanggal nikahan yang
**bagus**, saya juga bisa kok\!

> Gak pakai primbon, saya akan pakai *data science* untuk menemukan
> tanggal nikahan terbaik di 2021\!

Lho kok bisa? *Bisa donk\!*

-----

Pertama-tama, saya akan definisikan dulu masalahnya:

1.  Biasanya orang memilih tanggal pernikahan yang jatuh di hari `Sabtu`
    atau `Minggu`. Kadang sebagian orang memilih hari lain yang
    bertepatan dengan hari libur tapi karena sangat jarang, jadi saya
    hanya akan *narrow down* pemilihan tanggal di tahun `2021` yang
    jatuh di hari `Sabtu` atau `Minggu` saja.
2.  Tanggal nikahan **terbaik** adalah tanggal yang akan jatuh di hari
    yang sama saat hari pernikahan di tahun-tahun berikutnya. Misal,
    saya menikah di tanggal `x` yang jatuh di hari `Sabtu`, jika di
    tahun-tahun berikutnya saya selalu mendapati tanggal `x` sering
    jatuh di hari `Sabtu` maka tanggal tersebut saya bilang **terbaik**.

Jadi, saya akan memilih tanggal terbaik yang bisa memenuhi kedua
persyaratan di atas.

-----

## Langkah I

Saya akan kumpulkan terlebih dahulu semua tanggal di `2021` yang jatuh
di hari `Sabtu` atau `Minggu`. Ternyata ada `104` hari di tahun 2021
yang memenuhi kriteria tersebut. Berikut adalah `15` contohnya:

| tanggal    | hari |
| :--------- | :--- |
| 2021-02-21 | Min  |
| 2021-02-27 | Sab  |
| 2021-02-28 | Min  |
| 2021-03-06 | Sab  |
| 2021-03-07 | Min  |
| 2021-03-13 | Sab  |
| 2021-03-14 | Min  |
| 2021-03-20 | Sab  |
| 2021-03-21 | Min  |
| 2021-03-27 | Sab  |
| 2021-03-28 | Min  |
| 2021-04-03 | Sab  |
| 2021-04-04 | Min  |
| 2021-04-10 | Sab  |
| 2021-04-11 | Min  |

## Langkah II

Selanjutnya saya akan membuat proyeksi ke `50` tahun mendatang, lalu
menghitung dari `104` tanggal tersebut, tanggal mana saja yang paling
banyak jatuh di hari yang sama dengan hari pernikahan:

> Kenapa `50` tahun? *Simply*, karena angka tersebut adalah *golden year
> of marriage*.

<table>

<thead>

<tr>

<th style="text-align:left;">

Tanggal Pilihan di 2021

</th>

<th style="text-align:right;">

Freq Jatuh di Hari yang Sama dengan Hari Pernikahan

</th>

<th style="text-align:left;">

Tahun saat Terjadi

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

06-Mar

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

07-Mar

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

13-Mar

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

14-Mar

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

20-Mar

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

21-Mar

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

27-Mar

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

28-Mar

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

03-Apr

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

04-Apr

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

10-Apr

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

11-Apr

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

17-Apr

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

18-Apr

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

24-Apr

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

25-Apr

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

01-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

02-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

08-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

09-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

15-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

16-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

22-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

23-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

29-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

30-Mei

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

05-Jun

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

06-Jun

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

12-Jun

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

13-Jun

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

19-Jun

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

20-Jun

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

26-Jun

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

27-Jun

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

03-Jul

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

04-Jul

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

10-Jul

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

11-Jul

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

17-Jul

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

18-Jul

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

24-Jul

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

25-Jul

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

31-Jul

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

01-Agt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

07-Agt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

08-Agt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

14-Agt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

15-Agt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

21-Agt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

22-Agt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

28-Agt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

29-Agt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

04-Sep

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

05-Sep

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

11-Sep

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

12-Sep

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

18-Sep

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

19-Sep

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

25-Sep

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

26-Sep

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

02-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

03-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

09-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

10-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

16-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

17-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

23-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

24-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

30-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

31-Okt

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

06-Nov

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

07-Nov

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

13-Nov

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

14-Nov

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

20-Nov

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

21-Nov

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

27-Nov

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

28-Nov

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

04-Des

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

05-Des

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

11-Des

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

12-Des

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

18-Des

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

19-Des

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

25-Des

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

<tr>

<td style="text-align:left;">

26-Des

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

2027,2032,2038,2049,2055,2060,2066

</td>

</tr>

</tbody>

</table>

Ternyata ada `86` pilihan tanggal yang memenuhi kriteria saya.

-----

# Kesimpulan

Setelah saya cek kembali, sepertinya `86` pilihan masih terlalu banyak
*yah*. Tiba-tiba saya merasa gagal.

> Jangan-jangan perhitungan menggunakan *primbon* lebih baik *yah*.
> *haha*

Lalu jika dilihat, semua tanggal ini memiliki kesamaan di tahun
kejadiannya. Ini adalah hal yang menarik bagi saya dimana ternyata hari
bisa berulang setelah beberapa tahun.

Keputusan jadi saya kembalikan ke tangan kalian:

1.  Percaya bahwa semua hari itu baik? Atau
2.  Balik lagi pakai hitungan *primbon*?
