kReativitas saat PSBB: CHATBOT SEGALA ADA
================

Tahun lalu, saya pernah membuat [*chatbot* sederhana menggunakan R](https://passingthroughresearcher.wordpress.com/2019/08/28/membuat-chatbot-sederhana-di-telegram/). Awalnya saya ingin membuat *chatbot* yang benar-benar berfungsi sebagai ajang edukasi atau *QnA* dari teman-teman semua terkait matematika, statistika, dan *machine learning*.

Kalian bisa langsung cek ke Telegram dan *search* **ikanx.bot**.

Tapi ternyata membuat algoritma **NLP** lumayan susah untuk bahasa Indonesia *yah*.

Akhirnya *chatbot* ini saya berdayakan untuk melakukan hal-hal lainnya. Apa saja? *Cekidot yah*.

------------------------------------------------------------------------

Harga Emas
----------

Ini adalah algoritma yang cukup mudah untuk di-*embed* ke *chatbot* di **R**. Flownya juga sangat mudah, yakni:

![](2020-04-29-chatbot-new_files/figure-markdown_github/unnamed-chunk-1-1.png)

Contohnya ini *yah*:

<img src="emas.PNG" width="50%" />

------------------------------------------------------------------------

Kurs Rupiah
-----------

Algoritma ini sama dengan algoritma harga emas. *Flow*-nya seperti ini:

![](2020-04-29-chatbot-new_files/figure-markdown_github/unnamed-chunk-3-1.png)

Contohnya ini *yah*:

<img src="rupiah.PNG" width="50%" />

------------------------------------------------------------------------

Data Karhutla
-------------

Algoritma karhutla ini saya buat saat terjadi kebakaran hutan yang sempat heboh tahun 2019 lalu. *Flow*-nya juga relatif mudah, hanya ada tambahan membuat *chart* atau grafik untuk *sender*.

![](2020-04-29-chatbot-new_files/figure-markdown_github/unnamed-chunk-5-1.png)

Contohnya ini *yah*:

<img src="karhutla.PNG" width="50%" />

<img src="D:/Project_R/TelegramBOT/sipongi.png" width="70%" />

------------------------------------------------------------------------

Kurasi Berita Terkait CORONA dari [detik.com](https://www.detik.com/)
---------------------------------------------------------------------

Bisa gak sih baca berita dari [detik.com](https://www.detik.com/) tanpa harus membuka *browser* atau aplikasinya?

Dengan menggunakan chatbot saya, tentu bisa! *hehe*

Saya membuat algoritma yang bisa menampilkan lima berita ter-*update* (*real time*) dari detik.com terkait **corona** langsung di chat.

*Flow*-nya sebagai berikut:

![](2020-04-29-chatbot-new_files/figure-markdown_github/unnamed-chunk-8-1.png)

Contohnya ini *yah*:

<img src="corona.PNG" width="70%" />

------------------------------------------------------------------------

Grafik *Real-Time* Data COVID-19 dari [worldometers.info](https://www.worldometers.info/coronavirus/)
-----------------------------------------------------------------------------------------------------

Sekali lagi, tampaknya *chatbot* ini bisa digunakan untuk mengambil dan menganalisa data secara *real-time* hanya dengan pemantik perintah yang diberikan via *chat* telegram.

Dengan menggunakan perintah `/covid`, maka secara otomatis algoritma akan melakukan *scraping* dan *visualising* data berikut ini:

<img src="D:/Project_R/TelegramBOT/covid 19 1.png" width="70%" /><img src="D:/Project_R/TelegramBOT/covid 19 2.png" width="70%" /><img src="D:/Project_R/TelegramBOT/covid 19 3.png" width="70%" /><img src="D:/Project_R/TelegramBOT/covid 19 4.png" width="70%" />
