---
date: 2022-10-25T11:28:00-04:00
title: "Mencari Tahu Versi Chrome Webdriver Saat Menggunakan Selenium"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - Selenium
  - Chrome
  - Webdriver
---


Di berbagai tulisan saya sebelumnya [terkait *web
scraping*](https://ikanx101.com/blog/selenium-rvest/), saya telah
menjelaskan bagaimana `library(RSelenium)` bisa digunakan untuk
mengekstrak berbagai informasi yang ada di suatu situs *web*.

Salah satu *browser* yang bisa digunakan pada `RSelenium` adalah *Google
Chrome*. Salah satu masalah saat menggunakan *Google Chrome* di
`RSelenium` adalah me-*matching*-kan dua versi *Google Chrome*, yakni:

1.  Versi *Google Chrome* yang ter-*install* di komputer.
2.  Versi *Google Chrome webdriver* yang akan digunakan di `RSelenium`.

Pada saat pertama kali saya mencoba `RSelenium`, pemilihan versi *Google
Chrome webdriver* saya lakukan dengan cara *trial and error*. Biasanya
saya akan menuliskan sembarang versi *Google Chrome webdriver* di
*codes* saya. Jika terjadi *error*, `RSelenium` akan memberikan saran
beberapa versi *Google Chrome webdriver* yang bisa digunakan.

Tapi ada cara lain yang lebih cepat dan pasti untuk memasangkan kedua
versi *Chrome* tersebut. Berikut adalah tabel panduannya:

| Chrome yang terinstall di komputer | Chrome Webdriver |
|:----------------------------------:|:----------------:|
|                107                 |  107.0.5304.18   |
|                106                 |  106.0.5249.61   |
|                105                 |  105.0.5195.52   |

Kita cukup mengetahui versi *Chrome* yang ter-*install* di komputer kita
dan mengembalikannya ke tabel panduan di atas.

*Update* terkait panduan ini bisa dilihat di [*link* berikut
ini](https://chromedriver.chromium.org/downloads).

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads`
