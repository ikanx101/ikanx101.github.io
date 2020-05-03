---
date: 2020-4-27T15:08:00-04:00
title: "kReativitas saat PSBB: CHATBOT SEGALA ADA"
categories:
  - Blog
tags:
  - R
  - Socialpreneur
  - Telegram
  - Chatbot
  - NLP
  - Text to Dataframe converter
  - Machine Learning
  - Artificial Intelligence
---

Tahun lalu, saya pernah membuat [*chatbot* sederhana menggunakan
R](https://passingthroughresearcher.wordpress.com/2019/08/28/membuat-chatbot-sederhana-di-telegram/).
Awalnya saya ingin membuat *chatbot* yang benar-benar berfungsi sebagai
ajang edukasi atau *QnA* dari teman-teman semua terkait matematika,
statistika, dan *machine learning*.

Kalian bisa langsung cek ke Telegram dan *search* **ikanx.bot**.

Tapi ternyata membuat algoritma **NLP** lumayan susah untuk bahasa
Indonesia *yah*.

Di masa pemberlakuan PSBB ini, saya memiliki waktu yang cukup untuk
membuat beberapa algoritma lain yang bisa di-*embed* ke dalam *chatbot*
ini. Apa saja itu? *Cekidot yah*.

-----

## Harga Emas

Ini adalah algoritma yang cukup mudah untuk di-*embed* ke *chatbot* di
**R**. Flownya juga sangat mudah,
yakni:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/chunk/unnamed-chunk-1-1.png" width="100%" />

Contohnya ini
*yah*:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/emas.PNG" width="50%" />

-----

## Kurs Rupiah

Algoritma ini sama dengan algoritma harga emas. *Flow*-nya seperti
ini:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/chunk/unnamed-chunk-3-1.png" width="100%" />

Contohnya ini
*yah*:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/rupiah.PNG" width="50%" />

-----

## Data Karhutla

Algoritma karhutla ini saya buat saat terjadi kebakaran hutan yang
sempat heboh tahun 2019 lalu. *Flow*-nya juga relatif mudah, hanya ada
tambahan membuat *chart* atau grafik untuk
*sender*.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/chunk/unnamed-chunk-5-1.png" width="100%" />

Contohnya ini
*yah*:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/karhutla.PNG" width="50%" />

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/sipongi.png" width="70%" />

-----

## Kurasi Berita Terkait CORONA dari [detik.com](https://www.detik.com/)

Bisa gak sih baca berita dari [detik.com](https://www.detik.com/) tanpa
harus membuka *browser* atau aplikasinya?

Dengan menggunakan chatbot saya, tentu bisa\! *hehe*

Saya membuat algoritma yang bisa menampilkan lima berita ter-*update*
(*real time*) dari detik.com terkait **corona** langsung di chat.

*Flow*-nya sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/chunk/unnamed-chunk-8-1.png" width="100%" />

Contohnya ini
*yah*:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/corona.PNG" width="70%" />

-----

## Grafik *Real-Time* Data COVID-19 dari [worldometers.info](https://www.worldometers.info/coronavirus/)

Sekali lagi, tampaknya *chatbot* ini bisa digunakan untuk mengambil dan
menganalisa data secara *real-time* hanya dengan pemantik perintah yang
diberikan via *chat* telegram.

Dengan menggunakan perintah `/covid`, maka secara otomatis algoritma
akan melakukan *scraping* dan *visualising* data berikut
ini:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/covid 19 1.png" width="100%" /><img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/covid 19 2.png" width="100%" /><img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/covid 19 3.png" width="100%" /><img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/covid 19 4.png" width="100%" />

-----

## *SurveyBot*

Seharusnya dalam beberapa minggu ini, saya sedang melakukan suatu
project survey. Namun akibat wabah ini, tidak mungkin bagi tim
*interviewer* untuk berkeliling melakukan survey. Oleh karena itu
diperlukan cara lain untuk melakukan survey.

Entah kenapa survey dengan menggunakan *online form* terlihat
membosankan dan tidak cukup interaktif. Sekarang saya ingin mencoba
membuat algoritma yang memungkinkan *chatbot* digunakan untuk melakukan
survey.

Jadi seolah-olah responden sedang ditanya-tanya oleh orang melalui
*chat*.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/survey bot.PNG" width="70%" />

Nanti hasilnya akan direkap secara otomatis di *log files* dengan format
**.xlsx**. Ini lebih baik daripada *online forms*, karena kita bisa
memberikan sentuhan humanis dan responden bisa menyelesaikan kuesioner
kapanpun dia sempat tanpa harus khawatir *form*-nya hilang karena
jaringan terputus.

-----

## *Text to Data Frame Converter*

Pada [tulisan sebelumnya](https://ikanx101.github.io/blog/pas-banget/),
saya pernah bercerita bahwa teman saya membuat layanan jual-beli antar
sebagai pemberdayaan masyarakat.

Waktu itu, ia menggunakan pesan WA untuk menerima order dari pelanggan
dan meneruskannya kepada seller dan kurir.

Kira-kira seperti ini
bentuknya:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/pas banget.PNG" width="30%" />

Dari pesan WA tersebut, secara manual tim yang terlibat merekapnya dalam
bentuk format **Excel**.

*Nah*, saya berpikir apakah ada cara otomatis untuk melakukan itu?

Saya membuat algoritma yang bisa merekap data teks tersebut ke dalam
tabel excel secara otomatis. Teman saya itu tinggal memforward saja
pesan tersebut ke *chatbot* telegram saya, maka dalam hitungan
*miliseconds*, *chatbot* saya akan mengembalikannya dalam bentuk file
**Excel**.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Chatbot%20Segala%20Ada/resources/rekap pas.PNG" width="70%" />

-----

# Ya begitulah kira-kira… Ada pertanyaan?
