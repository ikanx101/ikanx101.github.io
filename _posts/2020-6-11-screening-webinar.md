---
date: 2020-6-11T10:08:00-04:00
title: "FAEDAH TIDYTEXT di R: Screening Peserta Webinar"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Tidytext
  - Matchmaking
  - Webinar
---

# *Preface*

Di suatu pagi yang cerah, sebelum memulai **WFH**, ponsel saya
berdering. Muncul pesan masuk dari kawan lama saya. Kalau dipikir-pikir
lagi, dunia saya dan dirinya sangat berbeda jauh. Hampir tidak ada
irisannya sama sekali. Dirinya bergerak di bidang *event organizer*
khusus *training webinar* yang lagi naik daun di masa **WFH** sekarang
dan saya bergerak di bidang data.

> Saya dengar dirimu ngasih *training* **R** yah? Kata si *xxx*, dirimu
> bisa melakukan *filtering* macem-macem di *excel* yah? Si *xxx* bilang
> ke saya, kayaknya dirimu bisa menyelesaikan masalah saya\!

Pertama agak kaget dan tersanjung atas kalimat yang dilontarkan rekan
saya tersebut. Kaget karena saya sebenarnya juga gak kenal dengan si
**xxx** dan tersanjung karena dari cerita singkatnya, *It is sounds like
I am a magician*.

Jadi begini ceritanya:

Teman saya tersebut membuat *scheduled webinar* untuk *targeted and
selected person*. Dia ingin membuat *webinar* untuk para *manager*
bidang tertentu dari beberapa perusahaan tertentu. Jadi sebenarnya yang
ditarget adalah nama-nama perusahaan tertentu. Dia menginformasikan
setidaknya ada `100` nama perusahaan. Namun, yang terjadi adalah jumlah
pendaftar meledak hingga `4.000` orang yang berasal dari perusahaan
lainnya dan universitas.

> Bisa bantu saya *filterin* siapa saja yang harus masuk ke webinarnya
> gak? Soalnya *form online* pendaftarannya itu semuanya dibuat dalam
> **input text**. Saya udah pusing nih ngefilternya…

Begitu keluh kesahnya.

Usut punya usut, ternyata *event* tersebut akan diadakan esok pagi. *Nah
lho…\!*

# *Challenge*

Tanpa berjanji yang muluk-muluk, saya sampaikan kepada kawan saya
tersebut untuk memberikan daftar perusahaan target dan data pendaftar
*webinar* yang dia miliki.

Dalam sekejap, *email* tersebut masuk dan saya coba lihat sekilas.

Ternyata benar, *input text* `nama perusahaan` dari data pendaftar
lumayan rumit.

> Gak bisa manual nih.

Pikir saya.

Jadi, kira-kira beginilah algoritma simpel yang saya kerjakan:

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Matchmaking%20Event/blog-post_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Jadi dengan memanfaatkan *function* `unnest_tokens()` di
`library(tidytext)`, saya memisahkan pasangan kata yang mungkin ada dari
nama perusahaan target. Lalu dengan memanfaatkan *reguler expression*
`grepl()` saya mengecek apakah pasangan kata tersebut muncul di
penulisan pendaftar.

# *Final*

Setelah saya berikan hasilnya dan diskusi lebih lanjut, kawan saya
tersebut puas dengan hasilnya. *Alhamdulillah*.

Catatan: untuk merahasiakan identitas pihak-pihak terkait, cerita ini
didramatisir secukupnya dan datanya tidak bisa saya sampaikan seutuhnya.
