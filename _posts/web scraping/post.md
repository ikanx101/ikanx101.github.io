Full Guide: Dasar-Dasar Web Scraping di R
================

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
    ## [2] "\r\n                Disdik Sulbar Bangun Tenda Pembelajaran di Sekolah Rusak Terdampak Gempa\r\n            "   
    ## [3] "\r\n                Korban Banjir Kalsel Butuh Sembako hingga Air Bersih\r\n            "                       
    ## [4] "\r\n                PKB soal Banjir Kalsel: Kerusakan Alam dan Hutan Terlalu Masif\r\n            "             
    ## [5] "\r\n                Soal Banjir Kalsel, PKS Minta Pemerintah Tindak Perkebunan-Penambang Ilegal\r\n            "
    ## [6] "\r\n                Banjir di Kalsel Rendam 11 Kantor Pemerintah, Negara Rugi Rp 35 M\r\n            "          
    ## [7] "\r\n                Bangunan-Infrastruktur Rusak Dampak Gempa Sulbar, Kerugian Rp 900 M\r\n            "        
    ## [8] "\r\n                Korban Gempa Sulbar Dapat Bantuan Perbaikan Rumah hingga Rp 50 Juta\r\n            "        
    ## [9] "\r\n                2 Jembatan Terdampak Banjir Kalsel Bisa Dipakai Lagi Sore Ini\r\n            "

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

-----

`if you like this article, please support by clicking the ads, thanks.`
