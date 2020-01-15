---
date: 2020-1-14T5:30:00-04:00
title: "Automation Youtube Downloader Algorithm using R"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Youtube
  - Download
---

Alhamdulillah si *Magma Grey* sudah datang. Sesuatu yang sangat seru adalah *head unit* **JVC** bawaannya bisa dipakai untuk menonton
*Youtube*. Jadi sangat menguntungkan kalau lagi bawa bocah-bocah.

> Biar gak *cranky* di jalan, saya bisa menyetelkan acara *Youtube* favorit para bocah itu.

Tapi ternyata koneksi **XL** saya lemot kalau dipakai untuk menonton
*Youtube* di jalan. Jadi, salah satu solusi terbaik yang bisa saya
lakukan adalah dengan mendownload video *Youtube* ke dalam format `.mp4`
untuk kemudian diputar menggunakan *flashdisk* di *head unit*.

-----

# Bagaimana caranya?

Cara paling mudah adalah menggunakan situs seperti
[ssyoutube.com](www.ssyoutube.com) lalu biarkan konversi bekerja.
Setelah proses konversi selesai, kita bisa men- *download* video
tersebut.

Untuk menyelesaikan proses ini, butuh waktu hingga satu menit pervideo.

-----

# Apakah memungkinkan jika proses ini dibuat otomatis?

Itu pertanyaan saya dari dulu. Apakah bisa **R** digunakan untuk men-
*download* video dari *Youtube*?

> **Ternyata bisa\!**

Jadi kita membutuhkan tiga bahan, yakni:

1.  **R**, untuk *running automation download algorithm*.
2.  *Google Chrome* atau *browser* lainnya, untuk *download* video.
3.  Koneksi internet.

Gimana skrip algoritmanya?

``` r
donlot = function(url){
  url = gsub("https://www.youtube.com/watch?v=",
             "https://clipmega.com/watch?v=",
             url,fixed = T)
  tes = read_html(url) %>% html_nodes('a') %>% html_attr('href')
  browseURL(tes[6])
}
```

Untuk men- *download*-nya, kita butuh *link* dari video yang akan di-
*download*.

Contoh:

`link = https://www.youtube.com/watch?v=eEhrkjDPqhU`

Lalu tinggal di- *run* saja *function*-nya:

`donlot(link)`

Bisa juga untuk *multiple links*, tinggal dibikin *vector* saja ya. Lalu
bisa dibuat *looping* atau `apply()`.

____

# Cara Lain

Ada acara lain untuk melakukannya, menggunakan aplikasi [Python yang dibuat oleh seseorang di luar sana](https://github.com/ytdl-org/youtube-dl).

Setelah `.exe` _file_-nya sudah dimasukkan ke dalam _working directory_, kita tinggal _execute_ kode di __R__-nya sebagai berikut:

`system('youtube-dl https://www.youtube.com/watch?v=eEhrkjDPqhU')`
