---
date: 2020-11-05T08:00:00-04:00
title: "Image Recognition Menggunakan R dan Google Vision"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Google
  - Google Vision
  - OCR
  - Image
  - Image Recognition
---


# Prolog

Di blog yang
[lama](https://passingthroughresearcher.wordpress.com/2019/06/26/membaca-struk-belanja-optical-character-recognition/),
saya pernah menjelaskan bagaimana **R** dan *Google Vision* bisa
dijadikan suatu mesin otomasi untuk melakukan *data entry* struk belanja
yang *reliable*, cepat, murah, dan efisien.

Kali ini, dengan menggunakan *tools* yang sama (*Google Vision* dan
**R**) saya akan melakukan *image recognition* terhadap 9 *posts*
terakhir dari akun Instagram Presiden Jokowi (per 5 November pukul 07.10
WIB).

-----

> Apa sih yang mau saya kerjakan?

*Google Vision* memiliki satu fitur yang disebut dengan `label
detection` yang mampu mengetahui isi dari sebuah *image*.
Permasalahannya adalah label yang digunakan berasal dari *train dataset*
yang dimiliki oleh *Google*. Kita sebagai *user* tidak mengetahui
bagaimana datasetnya dan bagaimana cara *improving recognition
model*-nya.

> Percaya saja bahwa secara berkala Google terus memperbaiki modelnya.

-----

Gimana langkah kerjanya?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Google%20Image/blog-post_files/figure-gfm/unnamed-chunk-1-1.png" width="20%" />

Semuanya saya lakukan menggunakan **R** *yah*. *hehe*

## Langkah I: *download photos*

Dengan menggunakan *instagram scraper* yang berjalan di Python, saya
mengambil `9` *posts* terakhir dari akun IG official Presiden Jokowi.

## Langkah II: melempar poto-poto tersebut ke *Google Vision*

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Google%20Image/jokowi.png" width="1049" />

Setelah itu, dari semua poto yang ada, saya akan lempar ke *Google
Vision* untuk dianalisa.

> Label apa saja yang ada di dalam poto tersebut?

## Langkah III: merapikan dan visualisasi data

Dari data yang sudah terkumpul, saya akan membuat visualisasinya sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Google%20Image/blog-post_files/figure-gfm/unnamed-chunk-3-1.png" width="672" />

## *Kira-kira, hal ini bisa kita manfaatkan lebih lanjut gak yah?*
