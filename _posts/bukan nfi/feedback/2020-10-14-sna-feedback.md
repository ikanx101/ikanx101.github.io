---
date: 2020-10-14T08:38:00-04:00
title: "Social Network Analysis: Melihat Dinamika dari Suatu Tim"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Social Network Analysis
  - Graf
  - Graph
  - Centrality
  - HR
---

Suatu waktu di perusahaan Otomotif `PT. Botol Kecap Mobilindo` (**PT. BKM**) sedang
dilakukan uji coba program *feedback* karyawan secara *360 degrees*.
Maksudnya *gimana*?

> Setiap karyawan memberikan *feedback* kepada sesamanya. Apapun level
> karyawan mereka.

Secara teknis, aturan cara pemberian *feedback*-nya adalah sebagai
berikut:

1.  Setiap karyawan memberikan beberapa nama orang rekan mereka (boleh
    atasan atau bawahan) yang bisa memberikan *feedback* terhadap
    mereka.
2.  Minimal banyaknya nama orang yang diberikan adalah `1` orang.
    Sedangkan tidak ada maksimal banyaknya nama orang yang harus
    diberikan.
3.  Orang yang memberikan *feedback* harus benar-benar bisa memberikan
    *feedback* kepada rekan kerjanya tersebut. Oleh karena itu,
    pemilihan orang harus dilakukan secara matang oleh masing-masing
    karyawan.
4.  Setiap karyawan diperkenankan untuk memilih rekan kerja dari
    *workcenter* yang berbeda (boleh *cross function*).

-----

Setelah satu minggu, data *feedback* tersebut telah terkumpul. Setiap
orang *happy* dengan *feedback* yang diberikan dan diterima. Namun ada
satu pertanyaan yang mengganjal di kepala seorang *manager* dari
departemen **X**.

> Sebenarnya, bagaimana sih dinamika yang terjadi di departemen saya?
> Siapa sosok yang paling berpengaruh?

-----

Jika diasumsikan karyawan yang saling memberikan dan menerima *feedback*
berarti memiliki kedekatan secara profesional (serta saling paham apa
yang dikerjakan), maka si *manager* akan melakukan analisa relasi yang
ada di antara mereka.

Pertama-tama, dia mengumpulkan data absensi siapa saja yang ada di
departemen dia beserta jabatannya. Dia cukup kaget melihat beberapa anak
buah di departemennya meminta dan diminta memberikan *feedback* ke
karyawan di luar departemennya.

| no | nama       | jabatan    | ket          |
| -: | :--------- | :--------- | :----------- |
|  1 | Saleet     | Supervisor | Dept sendiri |
|  2 | Timothy    | Supervisor | Dept sendiri |
|  3 | Kali       | Supervisor | Dept sendiri |
|  4 | Rebecca    | Supervisor | Dept sendiri |
|  5 | Corey      | Supervisor | Dept sendiri |
|  6 | Joey       | Admin      | Dept sendiri |
|  7 | Angelic    | Supervisor | Dept sendiri |
|  8 | Zheng      | Supervisor | Dept sendiri |
|  9 | Saadiq     | Admin      | Dept sendiri |
| 10 | Long       | Supervisor | Dept sendiri |
| 11 | Jodan      | Admin      | Dept sendiri |
| 12 | Ameen      | Supervisor | Dept sendiri |
| 13 | Hafsa      | Supervisor | Dept sendiri |
| 14 | Barima     | Admin      | Dept lain    |
| 15 | Mufeeda    | Admin      | Dept lain    |
| 16 | William    | Admin      | Dept sendiri |
| 17 | Alim       | Admin      | Dept sendiri |
| 18 | Sawada     | Manager    | Dept sendiri |
| 19 | Jasra      | Admin      | Dept sendiri |
| 20 | Katie      | Admin      | Dept lain    |
| 21 | Anasthasia | Admin      | Dept sendiri |
| 22 | Alondra    | Supervisor | Dept lain    |
| 23 | Paul       | Admin      | Dept sendiri |
| 24 | Alexander  | Supervisor | Dept sendiri |
| 25 | Stephen    | Supervisor | Dept lain    |
| 26 | Aldale     | Admin      | Dept sendiri |
| 27 | Nakheel    | Supervisor | Dept lain    |
| 28 | Jaiel      | Admin      | Dept lain    |
| 29 | Alexias    | Admin      | Dept sendiri |
| 30 | Janet      | Admin      | Dept lain    |
| 31 | Santa      | Admin      | Dept lain    |
| 32 | Xavier     | Admin      | Dept lain    |
| 33 | Zaahir     | Supervisor | Dept lain    |
| 34 | Carlos     | Admin      | Dept sendiri |
| 35 | Damion     | Admin      | Dept lain    |

Setelah itu, si *manager* membuat graf (*node*\~titik dan *edge*\~garis)
yang melambangkan relasi antara karyawan tersebut.

Oh iya, bagi yang belum mengetahui apa itu graf. Graf merupakan salah
satu materi di `matematika diskrit`.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/bukan%20nfi/feedback/post_files/figure-gfm/unnamed-chunk-3-1.png" width="672" />

> Dari graf di atas, pasti ada titik (orang) yang menjadi pusatnya\!

Begitu pikir si *manager*.

Lantas ia mengingat, ada beberapa cara menentukan pusat dari graf.

1.  *Degree*: *For finding very connected individuals, popular
    individuals, individuals who are likely to hold most information or
    individuals who can quickly connect with the wider network.*
2.  *Betweenness*: *For finding the individuals who influence the flow
    around a system.*

Maka dia menghitung kedua parameter tersebut.

| nama       | degree |    between | jabatan    | ket          |
| :--------- | -----: | ---------: | :--------- | :----------- |
| Rebecca    |     13 | 173.833333 | Supervisor | Dept sendiri |
| Zheng      |     11 |  48.416667 | Supervisor | Dept sendiri |
| Angelic    |      9 |  50.416667 | Supervisor | Dept sendiri |
| Ameen      |      9 |  25.500000 | Supervisor | Dept sendiri |
| William    |      9 | 152.500000 | Admin      | Dept sendiri |
| Long       |      8 |  21.166667 | Supervisor | Dept sendiri |
| Sawada     |      8 |   0.000000 | Manager    | Dept sendiri |
| Saadiq     |      7 | 159.250000 | Admin      | Dept sendiri |
| Jodan      |      7 |  47.166667 | Admin      | Dept sendiri |
| Hafsa      |      7 | 131.000000 | Supervisor | Dept sendiri |
| Jasra      |      7 |  22.083333 | Admin      | Dept sendiri |
| Saleet     |      6 |  54.000000 | Supervisor | Dept sendiri |
| Alim       |      6 |  27.333333 | Admin      | Dept sendiri |
| Timothy    |      5 | 135.000000 | Supervisor | Dept sendiri |
| Kali       |      5 |   2.500000 | Supervisor | Dept sendiri |
| Mufeeda    |      5 |   1.000000 | Admin      | Dept lain    |
| Corey      |      4 |  22.000000 | Supervisor | Dept sendiri |
| Joey       |      4 |   6.833333 | Admin      | Dept sendiri |
| Barima     |      4 |  13.000000 | Admin      | Dept lain    |
| Paul       |      2 |   0.000000 | Admin      | Dept sendiri |
| Alexander  |      2 |   0.000000 | Supervisor | Dept sendiri |
| Stephen    |      2 |   0.000000 | Supervisor | Dept lain    |
| Jaiel      |      2 |   0.000000 | Admin      | Dept lain    |
| Katie      |      1 |   0.000000 | Admin      | Dept lain    |
| Anasthasia |      1 |   0.000000 | Admin      | Dept sendiri |
| Alondra    |      1 |   0.000000 | Supervisor | Dept lain    |
| Aldale     |      1 |   0.000000 | Admin      | Dept sendiri |
| Nakheel    |      1 |   0.000000 | Supervisor | Dept lain    |
| Alexias    |      1 |   0.000000 | Admin      | Dept sendiri |
| Janet      |      1 |   0.000000 | Admin      | Dept lain    |
| Santa      |      1 |   0.000000 | Admin      | Dept lain    |
| Xavier     |      1 |   0.000000 | Admin      | Dept lain    |
| Zaahir     |      1 |   0.000000 | Supervisor | Dept lain    |
| Carlos     |      1 |   0.000000 | Admin      | Dept sendiri |
| Damion     |      1 |   0.000000 | Admin      | Dept lain    |

Ternyata dia mendapatkan salah seorang supervisornya memiliki `degree`
dan `between` yang terbesar. Lebih tinggi dibandingkan si *manager*
sendiri. Artinya selain orang tersebut `populer` (terkait kerjaan *yah*)
dia juga menjadi *influencer* dalam timnya.

*Kok bisa?*

> Setelah si *manager* merenung, ternyata hal ini terjadi gara-gara si
> orang itu biasa menjadi *caretaker* bagi para anak-anak baru. Selain
> itu orangnya memang bisa *grooming* rekan kerjanya yang lain.

## Degree

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/bukan%20nfi/feedback/post_files/figure-gfm/unnamed-chunk-5-1.png" width="768" />

## Between

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/bukan%20nfi/feedback/post_files/figure-gfm/unnamed-chunk-6-1.png" width="768" />

-----

Setelah dibuat grafnya kembali berdasarkan `degree` dan `between`, si
*manager* lalu membandingkan keduanya. Sekarang dia sudah tahu,
bagaimana dinamika dari tim tersebut dan bagaimana cara menggerakkan tim
tersebut ke depannya.

### Analisanya Belum Selesai

Si *manager* lalu ingin melakukan suatu hal lain. Sepengetahuannya [graf
bisa
dikelompokkan](https://passingthroughresearcher.wordpress.com/2019/11/15/social-network-analysis-meramu-tim-interviewer-terkompak-di-market-research/).
Oleh karena itu, dia akan mencoba membuat *clusters* dari graf tersebut.

Didapatkan ada `4` buah *clusters* di kelompoknya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/bukan%20nfi/feedback/post_files/figure-gfm/unnamed-chunk-7-1.png" width="768" />

Setelah dipecah lagi grafnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/bukan%20nfi/feedback/post_files/figure-gfm/unnamed-chunk-8-1.png" width="768" />

Si *manager* mendapati bahwa *cluster* `4` berisi seorang timnya yang
justru berkelompok dengan rekan kerja dari tim lain.

> *Menariquee*, pikirnya.

Lalu setelah melihat kembali, si *manager* tersenyum dan jadi tahu apa
yang harus dia lakukan untuk timnya.
