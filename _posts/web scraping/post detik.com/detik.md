Tutorial Web Scraping detik.com dengan R
================

*Weekend* kemarin salah seorang pembaca *blog* saya ini menghubungi saya
untuk menanyakan bagaimana cara melakukan *web scraping* situs
[detik.com](https://www.detik.com/).

Tujuan dia simpel, bagaimana mengambil data:

1.  Judul atau *headline*,
2.  Tanggal berita di-*publish*,
3.  Isi berita.

> Bagaimana caranya?

Yuk saya mulai caranya.

------------------------------------------------------------------------

## Langkah I

Pertama, saya akan ambil satu contoh *url* beritanya terlebih dahulu.
Jika saya berhasil membuat *function* untuk melakukan *scrape*, berarti
saya akan bisa melakukannya untuk semua *url* yang ada.

``` r
url = "https://finance.detik.com/berita-ekonomi-bisnis/d-5641707/menkes-jamin-vaksin-berbayar-bukan-dari-hibah?tag_from=news_mostpop"
```

## Langkah II

Kita panggil terlebih dahulu *libraries*-nya:

``` r
library(rvest)
library(dplyr)
library(stringr)
```

``` r
data = 
  url %>% 
  read_html() %>% 
  {tibble(
    headline = html_nodes(.,".detail__title") %>% html_text() %>% str_squish(),
    tanggal = html_nodes(.,".detail__date") %>% html_text() %>% str_squish(),
    teks = html_nodes(.,"p") %>% html_text() %>% str_squish() %>% paste(collapse = " ")
  )}

data %>% knitr::kable()
```

| headline                                      | tanggal                       | teks                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|:----------------------------------------------|:------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Menkes Jamin Vaksin Berbayar Bukan dari Hibah | Selasa, 13 Jul 2021 13:54 WIB | Menteri Kesehatan (Menkes) Budi Gunadi Sadikin memastikan 500 ribu vaksin hibah yang diterima Presiden Joko Widodo (Jokowi) dari Pemerintah Uni Emirat Arab (UEA) tidak digunakan dalam program vaksinasi berbayar. “Saya ingin memastikan bahwa 500 ribu Sinopharm dan akan tambah lagi 250 ribu hibah pribadi dari raja UEA ke Presiden Jokowi tidak dijual oleh Bio Farma,” katanya dalam rapat kerja bersama Komisi IX DPR RI, Selasa (13/7/2021). Budi Gunadi menjelaskan pihaknya sangat hati-hati menggunakan vaksin hibah itu dan selalu meminta arahan Jokowi. Menurutnya, vaksin hibah Sinopharm dari UEA akan digunakan untuk kelompok difabel. “Arahannya tadinya mau dipakai untuk haji supaya cepat. Bapak Presiden bilang ‘sudah jangan dikasih ke mana-mana siapkan untuk haji’. Tapi karena hajinya sekarang tidak jadi, diarahkan untuk ke difabel, orang-orang yang jadi masalahnya mungkin tuli, bisu, atau cacat. Orang-orang yang cacat ini diberikan sebagai jatah pribadi, ke difabel-difabel yang ada di zona-zona merah,” jelasnya. Budi Gunadi menjelaskan asal-usul sampai adanya kebijakan vaksin berbayar. Hal itu dikarenakan cakupan vaksinasi gotong royong yang selama ini gratis masih di bawah target. “26 Juni itu ada rapat di Kemenko Perekonomian atas inisiatif KPC-PEN, melihat bahwa vaksinasi gotong royong itu speed-nya sangat perlu ditingkatkan. Sekarang 10-15 ribu per hari dari target 1,5 juta baru 300 ribu, jadi memang ada concern ini kok lamban yang vaksin gotong royong,” katanya. “Sehingga keluar hasil diskusi beberapa inisiatif apakah itu mau dibuka juga ke RS yang sama dengan vaksin program, atau buat anak, ibu hamil, menyusui, termasuk individu,” tambahnya. |
