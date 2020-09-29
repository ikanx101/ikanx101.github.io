---
date: 2020-09-29T0:30:00-04:00
title: "Seberapa Merata Keberadaan Dokter di Indonesia?"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Web Scrap
  - R
  - Dokter
  - Kemenkes
  - Kesehatan
---


Banyak orang bilang bahwa keberadaan dokter di kota dan kabupaten di
Indonesia tidak merata. Bahkan sebagian orang menyebutkan bahwa ada
ketimpangan jumlah dokter di kota-kota besar dengan kabupaten atau kota
lainnya. Padahal di saat pandemi seperti ini, hal yang berbahaya adalah
saat pandemi sudah mencapai wilayah dengan keberadaan dokter yang minim.

Saya justru memiliki dugaan lain:

> Jangan-jangan sebenarnya keberadaan dokter sudah merata. Hanya
> sebagian kecil dari kabupaten kota yang memiliki dokter yang menumpuk.

Analoginya seperti ini:

> Bayangkan ada `100` orang berkumpul di suatu aula. `90` orang bertubuh
> kurus sedangkan `10` orang lainnya bertubuh gemuk.

Apakah kita bisa menyatakan bahwa ada ketimpangan? Apakah kita akan
menyebut kondisi di atas adalah ketidakmerataan?

Menurut saya tidak\!

Berbekal data yang saya [ambil](https://ikanx101.com/blog/nakes-part-2/)
dari situs
[Kemenkes](http://bppsdmk.kemkes.go.id/info_sdmk/info/index?rumpun=101),
saya akan lihat bagaimana sebaran datanya.

-----

# Data Jumlah Dokter per Kabupaten dan Kota

Dari data di situs Kemenkes, ada `514` kabupaten dan kota yang
dicantumkan secara detail jumlah dokter berdasarkan jenisnya, yakni:

    ## [1] "Dokter Umum"                            
    ## [2] "Dokter Gigi"                            
    ## [3] "Dokter Spesialis"                       
    ## [4] "Dokter Sub Spesialis"                   
    ## [5] "Dokter Gigi Spesialis Dan Sub Spesialis"

Saya hanya akan menganalisa data `Dokter Umum` dan `Dokter Gigi` saja
*yah*. Untuk melihat persebaran dari data tersebut, saya akan membuat
[*density
plot*](https://en.wikipedia.org/wiki/Probability_density_function)
sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/nakes%20data/Bagian%203/dokter_files/figure-gfm/unnamed-chunk-2-1.png" width="864" style="display: block; margin: auto;" />

-----

Jika dilihat sekilas, banyak data berkumpul di kiri. Hanya sedikit yang
menjadi pencilan di sebelah kanan grafik. Dugaan awal saya sepertinya
ada benarnya.

> Mayoritas kabupaten dan kota di Indonesia berada di *range* jumlah
> dokter yang relatif sama.

Yuk kita lihat visualisasi berikut ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/nakes%20data/Bagian%203/dokter_files/figure-gfm/unnamed-chunk-3-1.png" width="672" style="display: block; margin: auto;" />

-----

Jika digambarkan dengan grafik di atas, terlihat sebenarnya mayoritas
kabupaten dan kota di Indonesia berkumpul di kiri bawah. Hanya
segelintir kabupaten dan kota saja yang memiliki dokter yang banyak.

Jadi menurut saya, ini bukan ketidakmerataan *yah*.

-----

# Lampiran

## Dokter Umum

Dokter umum seharusnya menjadi tenaga kesehatan yang memiliki jumlah
cukup di masing-masing kabupaten dan kota. Mari kita lihat *top* `30`
dan *bottom* `30` kabupaten dan kota berdasarkan jumlah dokter umum
sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/nakes%20data/Bagian%203/dokter_files/figure-gfm/unnamed-chunk-4-1.png" width="672" style="display: block; margin: auto;" />

## Dokter Gigi

Sama halnya dengan dokter umum, seharusnya keberadaan dokter gigi bisa
lebih merata. Mari kita lihat *top* `30` dan *bottom* `30` kabupaten dan
kota berdasarkan jumlah dokter gigi sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/nakes%20data/Bagian%203/dokter_files/figure-gfm/unnamed-chunk-5-1.png" width="672" style="display: block; margin: auto;" />
