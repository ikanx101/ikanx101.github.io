---
date: 2020-10-22T5:30:00-04:00
title: "OSINT: Investigasi Video Viral di TikTok SetinggiBintang"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Web Scrap
  - R
  - Web Scrap
---


Pada tulisan yang [lalu](https://ikanx101.com/blog/tiki-taka/), saya
telah menelaah secara umum, data terkait *hashtag* **\#SetinggiBintang**
yang viral di *Youtube*.

Pertanggal saya *scrape* data, setidaknya semua video dengan *hashtag*
demikian sudah ditonton sebanyak *2.4 billion views*.

> Billion yah\! Billion\!

Saya penasaran, bagaimana bisa aktivasi digital ini menjadi sangat masif
di **TikTok**.

Saya akan mulai penelusuran ini dengan melihat *post timeline* berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/blog-post_files/figure-gfm/unnamed-chunk-5-1.png" width="100%" />

Pertama kali video dengan *hashtag* **\#SetinggiBintang** muncul pada
tanggal `18 September 2020` pukul `15:45:32 WIB` oleh
[phoebe.mulyana](https://www.tiktok.com/@phoebe.mulyana/video/6873746081885375745).

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/Bagian%202/vibi.png" width="70%" />

Selepas video tersebut di-*post*, butuh waktu `65` menit sampai seorang
*user* bernama
[stanleyhao](https://www.tiktok.com/@stanleyhao/video/6873763084222106882?lang=en)
melakukan *post* kedua. Butuh waktu `62` menit lagi sampai ada *post*
ketiga. Butuh waktu `40` menit lagi sampai ada *post* keempat.

Berikut adalah data kapan *post*, siapa, dan jeda (dalam menit) antar
*post* pada `23` *post* pertama.

<table>

<caption>

23 Post Pertama #SetinggiBintang

</caption>

<thead>

<tr>

<th style="text-align:left;">

tanggal_post

</th>

<th style="text-align:left;">

user

</th>

<th style="text-align:right;">

jeda_menit

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

2020-09-18 15:45:32

</td>

<td style="text-align:left;">

phoebe.mulyana

</td>

<td style="text-align:right;">

0.000000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 16:51:29

</td>

<td style="text-align:left;">

stanleyhao

</td>

<td style="text-align:right;">

65.950000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 17:53:50

</td>

<td style="text-align:left;">

lutfialmsyh

</td>

<td style="text-align:right;">

62.350000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 18:34:23

</td>

<td style="text-align:left;">

lisa90\_br

</td>

<td style="text-align:right;">

40.550000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 19:04:42

</td>

<td style="text-align:left;">

dinda\_ans

</td>

<td style="text-align:right;">

30.316667

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 19:42:27

</td>

<td style="text-align:left;">

igleon\_

</td>

<td style="text-align:right;">

37.750000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 19:44:44

</td>

<td style="text-align:left;">

fachriwildan19

</td>

<td style="text-align:right;">

2.283333

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 19:47:49

</td>

<td style="text-align:left;">

aira\_syifa\_agustin

</td>

<td style="text-align:right;">

3.083333

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 19:52:59

</td>

<td style="text-align:left;">

ayurahayu567

</td>

<td style="text-align:right;">

5.166667

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 20:55:24

</td>

<td style="text-align:left;">

p.u.t.170

</td>

<td style="text-align:right;">

62.416667

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-18 21:17:06

</td>

<td style="text-align:left;">

lauzaula

</td>

<td style="text-align:right;">

21.700000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 00:23:21

</td>

<td style="text-align:left;">

queensi08

</td>

<td style="text-align:right;">

186.250000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 07:06:26

</td>

<td style="text-align:left;">

venasitorus

</td>

<td style="text-align:right;">

403.083333

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 07:22:32

</td>

<td style="text-align:left;">

ciwiksipit

</td>

<td style="text-align:right;">

16.100000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 08:36:06

</td>

<td style="text-align:left;">

celinesoegiardjo

</td>

<td style="text-align:right;">

73.566667

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 08:58:03

</td>

<td style="text-align:left;">

tofikseti\_

</td>

<td style="text-align:right;">

21.950000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 09:39:44

</td>

<td style="text-align:left;">

angellia\_icha\_

</td>

<td style="text-align:right;">

41.683333

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 11:12:59

</td>

<td style="text-align:left;">

nursiama2

</td>

<td style="text-align:right;">

93.250000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 11:23:43

</td>

<td style="text-align:left;">

nurkhoiriahnasution0

</td>

<td style="text-align:right;">

10.733333

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 15:15:46

</td>

<td style="text-align:left;">

sewen15

</td>

<td style="text-align:right;">

232.050000

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 18:52:39

</td>

<td style="text-align:left;">

azka.cantik

</td>

<td style="text-align:right;">

216.883333

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 19:01:53

</td>

<td style="text-align:left;">

tiaradewi354

</td>

<td style="text-align:right;">

9.233333

</td>

</tr>

<tr>

<td style="text-align:left;">

2020-09-19 21:03:56

</td>

<td style="text-align:left;">

user1765866227834

</td>

<td style="text-align:right;">

122.050000

</td>

</tr>

</tbody>

</table>

Kenapa saya pilih `23` *post* pertama?

> Perhatikan grafik paling atas\! Pada hari pertama dan kedua ada `23`
> buah *post*. Setelah itu pada hari ketiga langsung melejit ada `115`
> buah *post*.

Maka, `23` *post* ini sepertinya krusial menurut saya.

Mari kita lihat visualisasi berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/Bagian%202/OSINT-Toktok_files/figure-gfm/unnamed-chunk-4-1.png" width="672" />

Kita bisa lihat kurva yang awalnya landai pada dua hari pertama,
tiba-tiba melejit di hari ketiga.

Sayangnya saya tidak memiliki data jumlah *view* per posting per hari
yang dilakukan oleh para *user* tersebut. Satu-satunya hal yang bisa
saya lakukan adalah dengan menjumlahkan banyaknya *followers* dari pada
*user* tersebut.

Tentunya dengan asumsi:

1.  Saya menghiraukan adanya irisan *followers* antar *user*.
2.  *Followers* *notice* dengan *post* yang dilakukan *user*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/tiktoks/Bagian%202/OSINT-Toktok_files/figure-gfm/unnamed-chunk-5-1.png" width="672" />

> Tuh bener kan dugaan saya\!

Kuncinya berada di post awal ini. Penentuan `siapa` yang memulai menjadi poin utama kenapa _hashtag_ ini bisa menjadi viral. Tentunya di luar konten video _yah_.

-----

## *Another Key Points*

Dari dua grafik di atas, kita bisa melihat kapan titik jenuh di mana
tidak ada lagi penambahan post dengan hashtag **\#SetinggiBintang**.

Ada yang mau menebak pas di _timeline_ ke berapa?

-----

### *Udah ah segitu dulu…*
