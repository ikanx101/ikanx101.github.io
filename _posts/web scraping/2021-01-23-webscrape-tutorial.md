---
date: 2021-01-23T11:55:00-04:00
title: "Tutorial: Web Scraping di R dengan ralger dan jsonlite"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - Tutorial
  - ralger
  - rvest
  - selenium
---


*Web scraping* adalah proses pengambilan data atau informasi dari
internet. Sebagaimana kita ketahui bersama, semua yang ada di internet
bisa dengan `mudah`-nya kita ambil (tentu dengan teknik yang tepat
*yah*).

Berdasarkan pengalaman saya selama ini, ada beberapa teknik *web
scraping* yang bisa dilakukan. Yakni:

1.  *Parsing html* dengan cara **membaca** *page source* `.html` dari
    situs yang dituju.
    1.  Kelebihan:
        1.  Proses relatif cepat (walau tergantung koneksi juga).
        2.  Bisa untuk kebanyakan situs, seperti: wikipedia, portal
            berita, blog, dst.
    2.  Kelemahan:
        1.  Harus menentukan target `css` dari situs terlebih dahulu.
        2.  Untuk beberapa situs, proses mencari objek `css` bisa jadi
            menyulitkan.
        3.  Tidak bisa digunakan untuk situs dinamis yang menggunakan
            `javascript`.
        4.  Untuk situs yang menggunakan *login*, prosesnya agak rumit.
2.  *Mimicking browser* dengan cara membuat *bot* yang seolah-olah
    membuka *browser* tertentu dan berinteraksi seperti layaknya
    manusia.
    1.  Kelebihan:
        1.  Bisa untuk (hampir) semua situs. Termasuk *social media*
            atau situs dengan *login* yang memiliki beberapa *steps
            authetification*.
        2.  Bisa mengambil situs dinamis atau mengandung `javascript`.
    2.  Kelemahan:
        1.  Proses relatif lambat. Karena bertindak seolah-olah layaknya
            manusia membuka *browser*.
        2.  Secara *coding* lebih rumit karena harus membuat dua bagian
            algoritma: algoritma *mimick* dan algoritma *scraper* `css`.
3.  Mengambil data menggunakan **API**.
    1.  Kelebihan:
        1.  Lebih mudah dan relatif cepat.
    2.  Kelemahan:
        1.  Proses mendapatkan **API** kadang cukup rumit. Kadang
            didapatkan dengan cara mendaftar *as developer* seperti di
            *Twitter* atau mencari sendiri saat `inspect` **network**.
        2.  Biasanya data hasil *scrape* memiliki format `.json` yang
            jarang dikenal orang awam.

-----

# *Libraries* **R** yang Digunakan

Setidaknya ada beberapa *libraries* yang saya gunakan untuk ketiga
teknik di atas:

1.  *Parsing html*: `rvest` atau `ralger`.
2.  *Mimicking browser*: `RSelenium`.
3.  **API**: `jsonlite` untuk membaca *file* `.json`.

Kali ini saya akan membahas teknik pertama dan ketiga. Selamat membaca
dan mecoba *yah*.

-----

# Tutorial *Parsing html*

Sekarang saya akan menunjukkan satu teknik yang sering saya gunakan
untuk *web scrape*, yakni *parsing html* menggunakan `library(ralger)`.

Kenapa menggunakan `ralger`?

> Jujur, saya lebih suka dan lebih sering menggunakan `library(rvest)`.
> Tapi `ralger` menawarkan kemudahan dan kepraktisan yang lebih baik
> bagi *scraper* pemula yang masih belum paham mengenai `.css` *object*.

Untuk kasus yang rumit seperti *webscraping* halaman *marketplace* tidak
akan saya bahas di sini *ya*.

## *Scrape* Isi *Body* Halaman

Sebagai contoh, saya akan mencoba untuk *scrape* berita di situs
[Detikcom](https://www.detik.com/) terkait gempa.

Berikut
[*link*](https://news.detik.com/berita/d-5344336/tni-ad-kirim-3-kapal-angkut-bantuan-untuk-korban-bencana-alam-kalsel-sulbar?_ga=2.212703508.1474967536.1611281806-371647059.1593093917)
yang digunakan.

``` r
url = "https://news.detik.com/berita/d-5344336/tni-ad-kirim-3-kapal-angkut-bantuan-untuk-korban-bencana-alam-kalsel-sulbar?_ga=2.212703508.1474967536.1611281806-371647059.1593093917"
```

Sekarang bagaimana melakukannya?

``` r
library(ralger)
judul = titles_scrap(url)
judul
```

    ## [1] "\n        TNI AD Kirim 3 Kapal Angkut Bantuan untuk Korban Bencana Alam Kalsel-Sulbar    "
    ## [2] "\n Kemnaker Buka Posko Dapur Umum untuk Korban Gempa di Sulbar\n "                        
    ## [3] "\n KNKT Akan Lanjutkan Operasi SAR SJ182 Senin Besok, Fokus Cari CVR\n "                  
    ## [4] "\n TNI AL: Kemungkinan CVR Pesawat Sriwijaya Air SJ182 Tertancap di Lumpur\n "            
    ## [5] "\n 2 Prajurit Gugur Ditembak KKB, TNI Akan Ganti Pasukan Tugas di Papua\n "               
    ## [6] "\n Cara Pakai KIS buat Cek Bansos Rp 300 Ribu\n "                                         
    ## [7] "\n Denny Indrayana: Ramah Investasi Jangan Lupa Ramah Lingkungan\n "                      
    ## [8] "\n Banjir di Kalsel Rendam 11 Kantor Pemerintah, Negara Rugi Rp 35 M\n "                  
    ## [9] "\n Bangunan-Infrastruktur Rusak Dampak Gempa Sulbar, Kerugian Rp 900 M\n "

Ternyata tidak hanya judul beritanya saja yang terambil tapi beberapa
judul *headlines* berita lain yang terambil. Kelak saya hanya akan
mengambil *first entry* saja.

``` r
body = paragraphs_scrap(url)
body
```

    ## [1] "TNI AD mengerahkan tiga kapal yakni ADRI 50, ADRI 51, dan ADRI 52. Kapal tersebut mengangkut personel, bahan-bahan logistik, peralatan Rumah Sakit (RS) Lapangan, serta alat berat guna membantu korban bencana alam di Kalimantan Selatan (Kalsel) dan Sulawesi Barat (Sulbar)."                                                                                                                          
    ## [2] "Kadispenad Brigjen TNI Nefra Firdaus menyampaikan, total bantuan logistik maupun perlengkapan dan peralatan penunjang lainnya yang terdiri dari beras 74,6 ton, mie instan 14.109 dus, minyak goreng 1214 dus, sarden atau makanan kaleng 134 dus, biskuit 801 dus, susu 654 dus, vitamin 25 dus, dan air mineral 967 dus."                                                                                
    ## [3] "\"Tenda 28 unit, terpal 61 lembar, alas tidur atau matras 251 lembar, masker medis 57 boks, perlengkapan ibadah 639 dus, sanitizer 144 dus, alat mandi 52 dus, pampers dan pembalut 224 dus, selimut 696 lembar, kopi 11 dus, gula 556 kg, kecap 50 dus, obat 4 dus, botol susu 1 dus, makanan bayi 255 dus, serta handuk 2 koli,\" kata Nefra dalam keterangan yang diterima detikcom, Jumat (22/1/2021)."
    ## [4] "Selain itu, ada pula bantuan paket sembako. TNI AD juga mengirimkan bantuan alat kesehatan hingga peralatan dapur."                                                                                                                                                                                                                                                                                        
    ## [5] "\"Paket sembako 1122 paket, APD 9 koli, tissue 1 dus, sandal 1 dus, alat pertukangan dan genset 18 unit, sarung bantal 1 dus, jaket loreng 2 koli, aneka minuman 26 dus dan toren air kapasitas 1005 liter 4 buah,\" jelas dia."                                                                                                                                                                           
    ## [6] "Selain itu, barang maupun kendaraan yang diangkut berupa alat kesehatan 111 koli, peralatan perhubungan 28 koli, peralatan dapur lapangan 56 Koli, tenda serba guna 2 Koli, pemanas Naraga 11 koli, Naraga 312 Koli, Truk Fuso 5 Ton 1 unit, Truk NPS 2,5 Ton 3 unit, Dump Truck Hino 2 unit (berisi jembatan bailey), Crane Cargo 2 Unit, dan Truk Trado 1 Unit (berisi jembatan bailey)."                
    ## [7] "TNI AD juga menyiapkan alat komunikasi pendukung lainnya. Nefra menyebut tim juga menyiapkan bantuan selimut dan kursi lapangan."                                                                                                                                                                                                                                                                          
    ## [8] "\"Peralatan pendukung lain yang juga dikirim adalah HT Icom 100 buah, repeater link icom 2 set, radio SSB 2 set, accu 120 ah 10 buah, solar cell 1000 watt 6 buah, solar cell arjuna 25 buah, veldbed alumunium dan selimut 1.000 set, meja lapangan 120 buah, kursi lapangan 60 buah, tenda serba guna 8 set, dan kompor T-50 12 set,\" kata dia."

Jika dirapikan, maka akan kita dapatkan hasil seperti ini:

``` r
judul = trimws(judul[1])
body = paste(trimws(body),collapse = "\n")
cat(judul,body)
```

    ## TNI AD Kirim 3 Kapal Angkut Bantuan untuk Korban Bencana Alam Kalsel-Sulbar TNI AD mengerahkan tiga kapal yakni ADRI 50, ADRI 51, dan ADRI 52. Kapal tersebut mengangkut personel, bahan-bahan logistik, peralatan Rumah Sakit (RS) Lapangan, serta alat berat guna membantu korban bencana alam di Kalimantan Selatan (Kalsel) dan Sulawesi Barat (Sulbar).
    ## Kadispenad Brigjen TNI Nefra Firdaus menyampaikan, total bantuan logistik maupun perlengkapan dan peralatan penunjang lainnya yang terdiri dari beras 74,6 ton, mie instan 14.109 dus, minyak goreng 1214 dus, sarden atau makanan kaleng 134 dus, biskuit 801 dus, susu 654 dus, vitamin 25 dus, dan air mineral 967 dus.
    ## "Tenda 28 unit, terpal 61 lembar, alas tidur atau matras 251 lembar, masker medis 57 boks, perlengkapan ibadah 639 dus, sanitizer 144 dus, alat mandi 52 dus, pampers dan pembalut 224 dus, selimut 696 lembar, kopi 11 dus, gula 556 kg, kecap 50 dus, obat 4 dus, botol susu 1 dus, makanan bayi 255 dus, serta handuk 2 koli," kata Nefra dalam keterangan yang diterima detikcom, Jumat (22/1/2021).
    ## Selain itu, ada pula bantuan paket sembako. TNI AD juga mengirimkan bantuan alat kesehatan hingga peralatan dapur.
    ## "Paket sembako 1122 paket, APD 9 koli, tissue 1 dus, sandal 1 dus, alat pertukangan dan genset 18 unit, sarung bantal 1 dus, jaket loreng 2 koli, aneka minuman 26 dus dan toren air kapasitas 1005 liter 4 buah," jelas dia.
    ## Selain itu, barang maupun kendaraan yang diangkut berupa alat kesehatan 111 koli, peralatan perhubungan 28 koli, peralatan dapur lapangan 56 Koli, tenda serba guna 2 Koli, pemanas Naraga 11 koli, Naraga 312 Koli, Truk Fuso 5 Ton 1 unit, Truk NPS 2,5 Ton 3 unit, Dump Truck Hino 2 unit (berisi jembatan bailey), Crane Cargo 2 Unit, dan Truk Trado 1 Unit (berisi jembatan bailey).
    ## TNI AD juga menyiapkan alat komunikasi pendukung lainnya. Nefra menyebut tim juga menyiapkan bantuan selimut dan kursi lapangan.
    ## "Peralatan pendukung lain yang juga dikirim adalah HT Icom 100 buah, repeater link icom 2 set, radio SSB 2 set, accu 120 ah 10 buah, solar cell 1000 watt 6 buah, solar cell arjuna 25 buah, veldbed alumunium dan selimut 1.000 set, meja lapangan 120 buah, kursi lapangan 60 buah, tenda serba guna 8 set, dan kompor T-50 12 set," kata dia.

## *Scrape* Tabel dari *Body* Halaman

Salah satu jenis data yang paling sering dicari di internet adalah data
bentuk tabel. Data bentuk seperti ini adalah data yang paling mudah
di-*scrape*.

> Lebih mudah dibandingkan dengan *copy* dari *browser* dan *paste* ke
> dalam `excel sheet`.

Sebagai contoh saya akan *scrape* data kecelakaan pesawat pada tahun
2021 yang disajikan di situs
[*aviation-safety.net*](https://aviation-safety.net/wikibase/dblist.php?Year=2021)

Bagaimana caranya?

``` r
url = "https://aviation-safety.net/wikibase/dblist.php?Year=2021"
tabel_hasil = table_scrap(url)
```

Karena datanya cukup banyak (`100` baris per 22 Januari 2020 16:18 WIB),
saya akan tampilkan top 10 data teratas saja.

``` r
knitr::kable(head(tabel_hasil))
```

| acc. date   | type                  | reg.   | operator                      | fat. | location                                             | dmg |
| :---------- | :-------------------- | :----- | :---------------------------- | :--- | :--------------------------------------------------- | :-- |
| 01-JAN-2021 | Bell 47D1             | N74823 | Private                       | 0    | Marana Regional Airport (AVQ/KAVQ), Marana, AZ       | sub |
| 01-JAN-2021 | Airbus A321-271NX     | T7-ME3 | Middle East Airlines          | 0    | Beirut International Airport (BEY)                   | sub |
| 01-JAN-2021 | Honda HA-420 HondaJet | N104HJ | Honda Aviation Service Co Inc | 0    | East Texas Regional Airport (GGG/KGGG), Longview, TX | non |
| 01-JAN-2021 | Robinson R66 Turbine  | 9M-SAW | My Heli Club                  | 0    | Jalan, Port Klang Free Zone, Pulau Indah, Selangor   | sub |
| 01-JAN-2021 | Paraglider            |        |                               | 0    | Washington County west of St George, UT              | sub |
| 01-JAN-2021 | Robinson R44 Raven II | C-FBGT | Bar 71 Land and Livestock Ltd | 4    | Birch Hills County, 10 nm SW of Eaglesham, AB        | w/o |

## *Scrape* `css` Object dari Halaman

Sekarang adalah bagian paling asik saat melakukan *web scraping*, yakni
mengambil data yang *scattered* di dalam suatu *webpage*.

Sebagai contoh saya hendak mengambil data dari situs jual beli mobil
[**Carmudi**](https://www.carmudi.co.id/).

Perhatikan *screenshot* dari salah satu
[*page*](https://www.carmudi.co.id/2020-suzuki-ertiga-dp-murah-angsuran-murah-1916271.html)
berikut ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/carmudi.png" width="616" style="display: block; margin: auto;" />

Sekarang saya hendak mengambil informasi seperti:

1.  Merek mobil (judul).
2.  Harga mobil.
3.  Informasi lain seperti: kilometer, transmisi, bahan bakar, dan
    kapasitas mesin.

Untuk mendapatkannya, saya perlu mencari tahu dulu letak `css` *object*
dari informasi-informasi tersebut. Untuk itu, saya menggunakan *chrome
extension* bernama **SelectorGadget**.

Setelah mengetahuinya, berikut langkah di **R**-nya:

``` r
url = "https://www.carmudi.co.id/2020-suzuki-ertiga-dp-murah-angsuran-murah-1916271.html"
scrap(url,".c-listing-price")
```

    ## [1] "166.6 Juta" "166.6 Juta"

``` r
scrap(url,".truncated")
```

    ## [1] "\n2020 Suzuki Ertiga DP MURAH ANGSURAN MURAH "
    ## [2] "\n2020 Suzuki Ertiga DP MURAH ANGSURAN MURAH "

``` r
scrap(url,".justify-content-center .font-weight-bold")
```

    ## [1] "1 Km"     "Otomatis" "Bensin"   "1500 cc"  "1 Km"     "Otomatis" "Bensin"  
    ## [8] "1500 cc"

Dari data-data di atas, saya tinggal merapikannya saja ke dalam bentuk
tabel yang rapih sebagai berikut:

``` r
harga = scrap(url,".c-listing-price")[1]
judul = scrap(url,".truncated")[1]
kilometer = scrap(url,".justify-content-center .font-weight-bold")[1]
transmisi = scrap(url,".justify-content-center .font-weight-bold")[2]
bbm = scrap(url,".justify-content-center .font-weight-bold")[3]
cc = scrap(url,".justify-content-center .font-weight-bold")[4]
hasil = data.frame(judul,harga,transmisi,cc,bbm,kilometer)

knitr::kable(hasil)
```

| judul                                      | harga      | transmisi | cc      | bbm    | kilometer |
| :----------------------------------------- | :--------- | :-------- | :------ | :----- | :-------- |
| 2020 Suzuki Ertiga DP MURAH ANGSURAN MURAH | 166.6 Juta | Otomatis  | 1500 cc | Bensin | 1 Km      |

Contoh di atas adalah saat saya *scrape* dari *page* yang menampilkan
satu *listing* mobil saja.

Bagaimana jika saya ingin *scrape* informasi harga mobil dari
[halaman](https://www.carmudi.co.id/cars/suzuki/ertiga/) berikut ini?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/carmudi2.png" width="427" style="display: block; margin: auto;" />

`library(ralger)` menawarkan satu cara lain yang simpel untuk *scraping*
informasi *scattered* dari satu *page* dan langsung menjadikannya dalam
bentuk tabel. Yakni dengan *function* `tidy_scrap()`.

Contoh:

``` r
url_new = "https://www.carmudi.co.id/cars/suzuki/ertiga/"

hasil = 
  tidy_scrap(url_new,
             c(".item-title",".price",".icon-gearshift+ span",".catalog-listing-item-location span"),
             c("judul","harga","transmisi","lokasi"))

knitr::kable(hasil)
```

| judul                                     | harga      | transmisi | lokasi               |
| :---------------------------------------- | :--------- | :-------- | :------------------- |
| 2020 Suzuki Ertiga PROMO AKHIR TAHUN DIS… | 155 Juta   | Otomatis  | Jakarta Timur        |
| 2020 Suzuki Ertiga DP 15 JUTAAN MURAH     | 165 Juta   | Manual    | Jakarta Barat        |
| 2020 Suzuki Ertiga PROMO …                | 153.5 Juta | Manual    | Depok                |
| 2020 Suzuki Ertiga Sport 2020 PROMO MURA… | 197 Juta   | Otomatis  | Tangerang Selatan    |
| 2020 Suzuki Ertiga PROMO …                | 159.5 Juta | Otomatis  | Kota Bks             |
| 2020 Suzuki Ertiga 2020 PROMO MURAH SUZU… | 152 Juta   | Otomatis  | Bekasi               |
| 2021 Suzuki Ertiga PROMO SUZUKI ALL NEW … | 195 Juta   | Manual    | Depok                |
| 2020 Suzuki Ertiga PROMO SUZUKI MURAH DI… | 175 Juta   | Otomatis  | Bekasi               |
| 2020 Suzuki Ertiga PROMO AKHIR TAHUN SUZ… | 155 Juta   | Manual    | Bekasi               |
| 2020 Suzuki Ertiga DP MUR…                | 166.6 Juta | Otomatis  | Kota Jakarta Selatan |
| 2020 Suzuki Ertiga HARGA …                | 203.5 Juta | Manual    | Bandung              |
| 2020 Suzuki Ertiga SUZUKI XL7 DISCOUNT 3… | 170 Juta   | Otomatis  | Depok                |
| 2013 Suzuki Ertiga 1.4 GX Manual          | 113 Juta   | Manual    | Tangerang Selatan    |
| 2016 Suzuki Ertiga GL                     | 127 Juta   | Manual    | Sidoarjo             |
| 2018 Suzuki Ertiga GL                     | 135 Juta   | Manual    | Sidoarjo             |
| 2016 Suzuki Ertiga GL Manual              | 127 Juta   | Manual    | Sidoarjo             |
| 2018 Suzuki Ertiga GL                     | 160 Juta   | Manual    | Sidoarjo             |
| 2019 Suzuki Ertiga                        | 166 Juta   | Manual    | Sidoarjo             |
| 2019 Suzuki Ertiga Sport                  | 202 Juta   | Manual    | Sidoarjo             |
| 2018 Suzuki Ertiga GL                     | 143 Juta   | Manual    | Sidoarjo             |
| 2017 Suzuki Ertiga                        | 143 Juta   | Otomatis  | Bekasi               |
| 2020 Suzuki Ertiga DP 25JT, NEGO SAMPE D… | 217 Juta   | Otomatis  | Jakarta Barat        |
| 2018 Suzuki Ertiga                        | 130 Juta   | Manual    | Bantul               |
| 2013 Suzuki Ertiga GX                     | 120 Juta   | Otomatis  | Jakarta Timur        |
| 2020 Suzuki Ertiga PROMO ALL NEW ERTIGA … | 155 Juta   | Manual    | Indonesia            |
| 2020 Suzuki Ertiga PROMO SUZUKI ERTIGA S… | 155 Juta   | Manual    | Bekasi               |
| 2017 Suzuki Ertiga tdp 10jt tipe GL       | 119 Juta   | Manual    | Kota Jakarta Timur   |
| 2016 Suzuki Ertiga                        | 125 Juta   | Manual    | Jakarta Timur        |
| 2017 Suzuki Ertiga                        | 150 Juta   | Manual    | Indonesia            |
| 2014 Suzuki Ertiga GL                     | 109 Juta   | Otomatis  | ID                   |

-----

# Tutorial *Web Scraping* dengan Memanfaatkan **API**

Sekarang saya akan memberikan satu contoh bagaimana kita melakukan web\_
scraping\_ menggunakan **API** yang tersedia di situs yang hendak kita
*scrape*.

Sebagai contoh, saya akan *scrape* terjemahan dari Quran Surat Alfatihah
yang tersedia di situs [Kementrian
Agama](https://quran.kemenag.go.id/sura/1).

Untuk mengambil terjemah dan tulisan arabnya, kita bisa mengecek
keberadaan **API** dari situs tersebut dengan cara melakukan *inspect
source* di *tab* `network`.

Setelah itu, kita hanya **tinggal** membaca `.json` dari **API**
tersebut.

``` r
url_new = "https://quran.kemenag.go.id/sura/1"

library(jsonlite)
data = read_json("https://quran.kemenag.go.id/api/v1/ayatweb/1/0/0/10")
str(data)
```

    ## List of 1
    ##  $ data:List of 7
    ##   ..$ :List of 7
    ##   .. ..$ aya_id              : int 1
    ##   .. ..$ aya_number          : int 1
    ##   .. ..$ aya_text            : chr "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ"
    ##   .. ..$ sura_id             : int 1
    ##   .. ..$ juz_id              : int 1
    ##   .. ..$ page_number         : int 1
    ##   .. ..$ translation_aya_text: chr "<p>Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.</p>"
    ##   ..$ :List of 7
    ##   .. ..$ aya_id              : int 2
    ##   .. ..$ aya_number          : int 2
    ##   .. ..$ aya_text            : chr "اَلْحَمْدُ لِلّٰهِ رَبِّ الْعٰلَمِيْنَۙ"
    ##   .. ..$ sura_id             : int 1
    ##   .. ..$ juz_id              : int 1
    ##   .. ..$ page_number         : int 1
    ##   .. ..$ translation_aya_text: chr "Segala puji bagi Allah, Tuhan seluruh alam,"
    ##   ..$ :List of 7
    ##   .. ..$ aya_id              : int 3
    ##   .. ..$ aya_number          : int 3
    ##   .. ..$ aya_text            : chr "الرَّحْمٰنِ الرَّحِيْمِۙ"
    ##   .. ..$ sura_id             : int 1
    ##   .. ..$ juz_id              : int 1
    ##   .. ..$ page_number         : int 1
    ##   .. ..$ translation_aya_text: chr "Yang Maha Pengasih, Maha Penyayang,"
    ##   ..$ :List of 7
    ##   .. ..$ aya_id              : int 4
    ##   .. ..$ aya_number          : int 4
    ##   .. ..$ aya_text            : chr "مٰلِكِ يَوْمِ الدِّيْنِۗ"
    ##   .. ..$ sura_id             : int 1
    ##   .. ..$ juz_id              : int 1
    ##   .. ..$ page_number         : int 1
    ##   .. ..$ translation_aya_text: chr "Pemilik hari pembalasan."
    ##   ..$ :List of 7
    ##   .. ..$ aya_id              : int 5
    ##   .. ..$ aya_number          : int 5
    ##   .. ..$ aya_text            : chr "اِيَّاكَ نَعْبُدُ وَاِيَّاكَ نَسْتَعِيْنُۗ"
    ##   .. ..$ sura_id             : int 1
    ##   .. ..$ juz_id              : int 1
    ##   .. ..$ page_number         : int 1
    ##   .. ..$ translation_aya_text: chr "Hanya kepada Engkaulah kami menyembah dan hanya kepada Engkaulah kami mohon pertolongan."
    ##   ..$ :List of 7
    ##   .. ..$ aya_id              : int 6
    ##   .. ..$ aya_number          : int 6
    ##   .. ..$ aya_text            : chr "اِهْدِنَا الصِّرَاطَ الْمُسْتَقِيْمَ ۙ"
    ##   .. ..$ sura_id             : int 1
    ##   .. ..$ juz_id              : int 1
    ##   .. ..$ page_number         : int 1
    ##   .. ..$ translation_aya_text: chr "Tunjukilah kami jalan yang lurus,"
    ##   ..$ :List of 7
    ##   .. ..$ aya_id              : int 7
    ##   .. ..$ aya_number          : int 7
    ##   .. ..$ aya_text            : chr "صِرَاطَ الَّذِيْنَ اَنْعَمْتَ عَلَيْهِمْ ەۙ غَيْرِ الْمَغْضُوْبِ عَلَيْهِمْ وَلَا الضَّاۤلِّيْنَ ࣖ"
    ##   .. ..$ sura_id             : int 1
    ##   .. ..$ juz_id              : int 1
    ##   .. ..$ page_number         : int 1
    ##   .. ..$ translation_aya_text: chr "(yaitu) jalan orang-orang yang telah Engkau beri nikmat kepadanya; bukan (jalan) mereka yang dimurkai, dan buka"| __truncated__

Sekarang tinggal merapikan hasilnya saja sebagai berikut:

    ## بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِاَلْحَمْدُ لِلّٰهِ رَبِّ الْعٰلَمِيْنَۙالرَّحْمٰنِ الرَّحِيْمِۙمٰلِكِ يَوْمِ الدِّيْنِۗاِيَّاكَ نَعْبُدُ وَاِيَّاكَ نَسْتَعِيْنُۗاِهْدِنَا الصِّرَاطَ الْمُسْتَقِيْمَ ۙصِرَاطَ الَّذِيْنَ اَنْعَمْتَ عَلَيْهِمْ ەۙ غَيْرِ الْمَغْضُوْبِ عَلَيْهِمْ وَلَا الضَّاۤلِّيْنَ ࣖ

    ## <p>Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.</p>Segala puji bagi Allah, Tuhan seluruh alam,Yang Maha Pengasih, Maha Penyayang,Pemilik hari pembalasan.Hanya kepada Engkaulah kami menyembah dan hanya kepada Engkaulah kami mohon pertolongan.Tunjukilah kami jalan yang lurus,(yaitu) jalan orang-orang yang telah Engkau beri nikmat kepadanya; bukan (jalan) mereka yang dimurkai, dan bukan (pula jalan) mereka yang sesat.

-----

# *Summary*

*Web scraping* sebenarnya bukan perkara yang terlalu sulit. Justru saya
lebih sering mendapatkan tantangan saat merapikan data hasil *scraping*
tersebut.

-----

`if you like this article, please support by clicking the ads, thanks.`
