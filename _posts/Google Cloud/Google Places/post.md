Cara Mengambil Data dari Google Maps dengan R
================

Pada tahun 2018, pertama kali saya menggunakan layanan [*Google
Geocoding*](https://passingthroughresearcher.wordpress.com/2018/09/24/geocoding-with-r-and-google-geocoding-api/)
menggunakan **R**. Waktu itu saya memiliki ribuan alamat toko untuk
dicari koordinat *longlat*-nya. Setelah menyelesaikan tugas tersebut,
praktis saya tidak lagi menggunakan layanan *Google Cloud Console* yang
berbasis *geolocation* secara masif.

Namun beberapa hari belakangan ini, saya tertarik untuk mengoprek
layanan tersebut kembali namun bukan dalam hal *geocoding*.

> ***Kali ini saya berniat untuk mengambil data lokasi yang ada di
> Google Maps!***

------------------------------------------------------------------------

Sebagaimana yang kita ketahui bersama, *Google Maps* menggunakan prinsip
*crowdsourcing* pada layanannya. Setiap *user* memiliki kesempatan untuk
[meng-*edit*, menambah, atau bahkan
menghapus](https://passingthroughresearcher.wordpress.com/2015/11/27/tips-improving-google-maps/)
suatu lokasi yang ada di *Google Maps*. Tentunya tim *Google Maps* akan
melakukan verifikasi dan validasi atas masukan setiap *user*. Walaupun
tentunya kita tidak bisa juga mempercayai 100% semua informasi yang
tertera di *Google Maps*.

Sebagai contoh, saya pernah mencari suatu lokasi di *Google Maps*, namun
setelah ditelusuri langsung lokasi tersebut tidak ada karena
informasinya *out of date*.

Lantas bagaimana cara kita mengambil data dari *Google Maps*?

> ***Kita bisa menggunakan layanan Google Places API di Google Cloud
> Console!***

### Apa itu *Google Cloud Console*?

Saya mendefinisikan **GCC** sebagai *marketplace* bagi layanan Google
dan mitranya dalam hal data, komputasi, dan *artificial intelligence*.
Saya sendiri bisa mendapatkan banyak layanan yang berguna bagi pekerjaan
saya sebagai *market researcher* di sana.

Kali ini kita perlu mendaftar atau *enabling* layanan *Google Places*.

<img src="api.png" width="485" style="display: block; margin: auto;" />

Setelah itu, kita memerlukan **API** *key* untuk mendapatkan data yang
hendak kita ambil.

### Data apa saja yang bisa diambil?

Kita bisa mendapatkan data `nama tempat`, koordinat `longlat`, `rating`
lokasi, `jam buka-tutup`, `review` lokasi, `alamat lengkap`, `photo`
lokasi, dan lain-lain.

*Google Places* memberikan gambaran tipe-tipe tempat apa saja yang bisa
kita ambil datanya sebagai berikut:

<img src="r1.png" width="545" style="display: block; margin: auto;" /><img src="r2.png" width="561" style="display: block; margin: auto;" /><img src="r3.png" width="496" style="display: block; margin: auto;" />

### Bagaimana cara mengambil datanya?

> ***Sebenarnya cukup mudah!***

Kalian hanya perlu menggunakan *function* `google_places()` pada
`library(googleway)` di **R**. Berikut saya berikan langkah-langkahnya:

1.  *Enable* layanan *Google Places API* di **GCC**.
2.  Buat **API** *key* pada halaman *credential*. Catat untuk kemudian
    dimasukkan ke dalam **R** *environment*.
3.  Tentukan titik pusat tempat kita akan mencari dalam format koordinat
    `longlat`.
4.  Tentukan `radius` (dalam meter) pencarian kita.
5.  Tentukan tipe lokasi yang hendak dicari.

> ***Mudah kan?***

Oke, begini *script*-nya:

### Masukkan **API** *Key*

``` r
library(googleway)
key = xxxxx # masukkan API key kalian di sini.
```

### Tentukan Titik Pusat Pencarian dan Tipe Lokasi

Misalkan saya ingin mencari `laundry` di sekitar **Summarecon Bekasi**.
Saya bisa dengan mudah mendapatkan koordinat `longlat` dari **Summarecon
Bekasi**, yakni (-6.2270906,106.9997416).

### Tentukan Radius Pencarian

Misalkan `radius` pencariannya adalah 1 km (1.000 m).

Maka skripnya menjadi sebagai berikut:

``` r
hasil = google_places(location = c(-6.2270906,106.9997416),
                       keyword = "laundry",
                       radius = 1000,
                       key = key)
```

Hasil pencariannya saya simpan bernama `hasil` berstruktur ***list***.

``` r
str(hasil)
```

    ## List of 4
    ##  $ html_attributions: list()
    ##  $ next_page_token  : chr "Aap_uEBUpm_8t6Keqc8kgNFbCbaFBRBh0bQ3e6m3N-ry1XsKVR03SL1FNdHYw7Dqb33l1KbDBa-Q-IUy6n6jB-RHKdy6CmnE0LWmGM91jiqOIWM"| __truncated__
    ##  $ results          :'data.frame':   20 obs. of  16 variables:
    ##   ..$ business_status      : chr [1:20] "OPERATIONAL" "OPERATIONAL" "OPERATIONAL" "OPERATIONAL" ...
    ##   ..$ geometry             :'data.frame':    20 obs. of  2 variables:
    ##   .. ..$ location:'data.frame':  20 obs. of  2 variables:
    ##   .. .. ..$ lat: num [1:20] -6.22 -6.22 -6.22 -6.23 -6.22 ...
    ##   .. .. ..$ lng: num [1:20] 107 107 107 107 107 ...
    ##   .. ..$ viewport:'data.frame':  20 obs. of  2 variables:
    ##   .. .. ..$ northeast:'data.frame':  20 obs. of  2 variables:
    ##   .. .. .. ..$ lat: num [1:20] -6.22 -6.22 -6.22 -6.23 -6.22 ...
    ##   .. .. .. ..$ lng: num [1:20] 107 107 107 107 107 ...
    ##   .. .. ..$ southwest:'data.frame':  20 obs. of  2 variables:
    ##   .. .. .. ..$ lat: num [1:20] -6.22 -6.22 -6.22 -6.23 -6.22 ...
    ##   .. .. .. ..$ lng: num [1:20] 107 107 107 107 107 ...
    ##   ..$ icon                 : chr [1:20] "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png" "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png" "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png" "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png" ...
    ##   ..$ icon_background_color: chr [1:20] "#7B9EB0" "#7B9EB0" "#7B9EB0" "#7B9EB0" ...
    ##   ..$ icon_mask_base_uri   : chr [1:20] "https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet" "https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet" "https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet" "https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet" ...
    ##   ..$ name                 : chr [1:20] "Wish Laundry" "Fresh & Clean Laundry" "washstation.id Laundry Sepatu Bekasi Jakarta | Jasa Cuci & Vakum Sofa, Springbed, Karpet, Stroller Bekasi Jakarta" "Violetta Laundry" ...
    ##   ..$ opening_hours        :'data.frame':    20 obs. of  1 variable:
    ##   .. ..$ open_now: logi [1:20] TRUE TRUE TRUE TRUE TRUE TRUE ...
    ##   ..$ photos               :List of 20
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 720
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/113402918209827530454\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEBIhlGET--OZfC65lvcnag9gyap6HaBRLSkMc73Gtf9d3MASuuNSWgah9csE-y_Xc0Q_sYt1f30g8819oaFw720K31n27z3c2pivbb9Jx-"| __truncated__
    ##   .. .. ..$ width            : int 1280
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 1280
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/107722790111869263059\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEAfzrYZ24OaeuxH9CIEKT0UeYvROLOt_msrzhGLjrRxig00QRTqWd6I8O4mZURXXrpVM4k7dzZkfvUZlZpbyWjxoTrxQ00xyvkzEtbc7OC"| __truncated__
    ##   .. .. ..$ width            : int 590
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 1040
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/111302418054548970623\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEDU-UfzlCc34otqgDWloLRkZS-Z7KSAD8cfG3tXcsm1Ir3MSWmiitchFUMVnSPVjHKOnA1GaX4Lisx6wzYBAvbWZ0VIBxihI3FU4ugHYkn"| __truncated__
    ##   .. .. ..$ width            : int 780
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 3000
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/117377491194941440869\">great king</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uED7YebpSJT3Dl6_zoMowBwW7N-_uhVVplUF8xQz69t0Fl9AcIEr1N29srWwwYiy7FVZU_xtq-u42ARu5Up4b-9o8YI_Y-jOnCok63lIr7v"| __truncated__
    ##   .. .. ..$ width            : int 4000
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 1080
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/104446770951814802526\">Petruse Online</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uECtr8Nd5hxfAidzcwHjxQf49rzEt43oahBVndXEonwHEMZMc50kMryvuGlANcoX32ooJ8ar8ED6PBrc5nqtxoRkEuKXTVDt74K1KyTm5NB"| __truncated__
    ##   .. .. ..$ width            : int 1920
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 4128
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/109945841297258353263\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEDrxddAG2C3TqpxSx6LP-Y6AV5AoxbTJ8RpZ90kXgL9HbwMH5JiGYsbYvbcDIJuXUq9wfk7LtV-XFPUk4hFpd4BNXVwF9J4Yt5CIjmM2Yi"| __truncated__
    ##   .. .. ..$ width            : int 3096
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 810
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/114785963617572483717\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEBqsSjTCHV99OqvFsIjKNgNITMKTVy-MspmoWRa-G0O4tct_jkTqbu-9MXO2zyQlgRuD2jbp0SwB5tTSI7Zf_j9vb10LiXQmcTMxiQwKU9"| __truncated__
    ##   .. .. ..$ width            : int 1440
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 1920
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/109721773506554636683\">Sonny Prabowo</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEB_ub0rW0H-Z1JbTdKumhcopgY-q0gaqZNJGhR3R-_022JY59JQvq9yfOdGCuGuz-ZXBg9PNQ7GqBPk8NBpVyhbIXyZkQUKlq7464EXwpY"| __truncated__
    ##   .. .. ..$ width            : int 1080
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 3264
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/109907237626830792353\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uECgNvNk1nCQl558u4ydbF7O8LaTy3hOgXDIOmKCqEZHmvA5R9b_DxdW-Xt0IeuhiAs2lE_p74suaP5GP9RKbySzmejLZqKb-KSEJknTh6a"| __truncated__
    ##   .. .. ..$ width            : int 2448
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 540
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/109146000608510373231\">dhani akbar</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uECShWXm83RX0_pOI4O4Q55r7xeKHNeVyx3s7WczvTuvWAmEww_y9ookZJYhVRFrN7XTe9uNbo0EiQXo0bri4Tcxm1sQYC4ME6xspn1x1L8"| __truncated__
    ##   .. .. ..$ width            : int 960
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 1091
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/106805958741738780279\">Refzu Assegaf</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEAMptaY70ZOwG-fDSDqy5uBQy2qBaPU27XimhrEAltbhrz2jGKKVzrw7RsTd4iOWwqTm9pov-ehlToFJbxjG4Jyvq1u6HMni-tJhcLtSAX"| __truncated__
    ##   .. .. ..$ width            : int 778
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 1280
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/104359940442640367133\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEB4ToONcHP6th1JNk7vNL-_uHIhup5GtCAP8pKvdkbD-ulDO9idVBndcHl9Vp1P1tbcoz6_EXLnumcHm-jZlufkPnPmB4jOrhnECdu1jCy"| __truncated__
    ##   .. .. ..$ width            : int 960
    ##   .. ..$ : NULL
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 3000
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/108624814593734123707\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEAyYwq_94ljo5tFlDrM2c15pSJXe1eMghXA9fbWPLXLHfLC-t8vscwwlwoLXNXgIbGcVgyeBsCS4lRREaEtO7vYQ41KpW-74lUPAaK4qG1"| __truncated__
    ##   .. .. ..$ width            : int 4000
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 810
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/104577197955239441359\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEA3--sVd8d4je75pIfy20O6s9jfLDUOFN33TibdlxHBgQKGtrusQNoiaKM-DKqFIZuXUiJ4p8Uq9Z8f8WFHoWQMiIh99eAn_Bt4EyVcVqi"| __truncated__
    ##   .. .. ..$ width            : int 1440
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 3411
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/112896224682708035151\">A Google User</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEBXKzo8TXP4XhGHMgZAsaF-n9npm55KsKWC1OBdDSN2S1LkfVEpjbYR5XS4wuqxv4G0sW6n05KCiZf-KX82gTy2nFOIuIWbPdrnynZ6roe"| __truncated__
    ##   .. .. ..$ width            : int 2899
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 1439
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/106805958741738780279\">Refzu Assegaf</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEAUGcwIGzsQWW3-XLe5_zNKwj1a3YejjXX5BTELddldsyu2sRDUOaO_58h7nff9McS_dfr6j03Fqzx3Zhwo3p3ayiBQ72nfSqviQhaAiWs"| __truncated__
    ##   .. .. ..$ width            : int 1080
    ##   .. ..$ :'data.frame':  1 obs. of  4 variables:
    ##   .. .. ..$ height           : int 4160
    ##   .. .. ..$ html_attributions:List of 1
    ##   .. .. .. ..$ : chr "<a href=\"https://maps.google.com/maps/contrib/103737421083047787609\">Boy Tampubolon</a>"
    ##   .. .. ..$ photo_reference  : chr "Aap_uEAPA6kEno-Ygv7udjJDwmshgKvFS3z5qTSbc7j1gKx0uTAAg9s1EcLYjeJkUC89zcWJrAyX-zGrBzrRfzO_ARDbt08umoYarJ_-z02u4kS"| __truncated__
    ##   .. .. ..$ width            : int 3120
    ##   .. ..$ : NULL
    ##   .. ..$ : NULL
    ##   ..$ place_id             : chr [1:20] "ChIJlXCISdSNaS4RSVYfabrI-nc" "ChIJbwCgwuWNaS4Rrue6KL_L5Qo" "ChIJ1yD_PAqNaS4R0xY1Ar3buKc" "ChIJ0wJw_vWNaS4R2N2xOsSe9lE" ...
    ##   ..$ plus_code            :'data.frame':    20 obs. of  2 variables:
    ##   .. ..$ compound_code: chr [1:20] "QXJR+CW Harapan Jaya, Bekasi City, West Java" "QXHW+9P Marga Mulya, Bekasi City, West Java" "QXHW+XQ Marga Mulya, Bekasi City, West Java" "QX9X+89 Harapan Mulya, Bekasi City, West Java" ...
    ##   .. ..$ global_code  : chr [1:20] "6P58QXJR+CW" "6P58QXHW+9P" "6P58QXHW+XQ" "6P58QX9X+89" ...
    ##   ..$ rating               : num [1:20] 4.9 5 5 5 5 5 4.9 5 5 4.7 ...
    ##   ..$ reference            : chr [1:20] "ChIJlXCISdSNaS4RSVYfabrI-nc" "ChIJbwCgwuWNaS4Rrue6KL_L5Qo" "ChIJ1yD_PAqNaS4R0xY1Ar3buKc" "ChIJ0wJw_vWNaS4R2N2xOsSe9lE" ...
    ##   ..$ scope                : chr [1:20] "GOOGLE" "GOOGLE" "GOOGLE" "GOOGLE" ...
    ##   ..$ types                :List of 20
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   .. ..$ : chr [1:3] "laundry" "point_of_interest" "establishment"
    ##   ..$ user_ratings_total   : int [1:20] 10 8 30 9 10 5 59 15 12 6 ...
    ##   ..$ vicinity             : chr [1:20] "Jl. Kapuas Raya No.88B, RT.008/RW.019, Harapan Jaya, Kota Bks" "Jl. Rw. Bugel, RT.002/RW.003, Marga Mulya, Kota Bks" "Jl. Segar wana No.35, RT.003/RW.003, Marga Mulya, Kota Bks" "Jl. Pintu Air, RT.003/RW.001, Harapan Mulya, Kota Bks" ...
    ##  $ status           : chr "OK"

> ***Bingung bacanya?***

Tenang saja, kita hanya akan ekstrak informasi yang dibutuhkan:

``` r
data.frame(
  nama = hasil$results$name,
  alamat = hasil$results$vicinity,
  rating = hasil$results$rating,
  buka_sekarang = hasil$results$opening_hours$open_now,
  long = hasil$results$geometry$location$lng,
  lat = hasil$results$geometry$location$lat
) %>% 
  knitr::kable(align = "c")
```

|                                                        nama                                                        |                                            alamat                                             | rating | buka\_sekarang |   long   |    lat    |
|:------------------------------------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------------:|:------:|:--------------:|:--------:|:---------:|
|                                                    Wish Laundry                                                    |                 Jl. Kapuas Raya No.88B, RT.008/RW.019, Harapan Jaya, Kota Bks                 |  4.9   |      TRUE      | 106.9923 | -6.218925 |
|                                               Fresh & Clean Laundry                                                |                      Jl. Rw. Bugel, RT.002/RW.003, Marga Mulya, Kota Bks                      |  5.0   |      TRUE      | 106.9968 | -6.221552 |
| washstation.id Laundry Sepatu Bekasi Jakarta \| Jasa Cuci & Vakum Sofa, Springbed, Karpet, Stroller Bekasi Jakarta |                  Jl. Segar wana No.35, RT.003/RW.003, Marga Mulya, Kota Bks                   |  5.0   |      TRUE      | 106.9969 | -6.220054 |
|                                                  Violetta Laundry                                                  |                     Jl. Pintu Air, RT.003/RW.001, Harapan Mulya, Kota Bks                     |  5.0   |      TRUE      | 106.9984 | -6.231643 |
|                                                     Oy laundry                                                     |                   Jl. Rw. Bugel No.7, RT.003/RW.003, Marga Mulya, Kota Bks                    |  5.0   |      TRUE      | 106.9966 | -6.219567 |
|                                             Laundry Kiloan, ZN Laundry                                             |           Jalan Kampung Jl. Pintu Air Raya, RT.003/RW.007, Harapan Mulya, Kota Bks            |  5.0   |      TRUE      | 106.9972 | -6.234622 |
|                                                    Laundry 150                                                     |               Jl. KH. Agus Salim No.150 E, RT.008/RW.007, Bekasi Jaya, Kota Bks               |  4.9   |      TRUE      | 107.0103 | -6.230912 |
|                                               Jenics Laundry Premium                                               |                 Jl. KH. Muchtar Tabrani No.7, RT.4/RW.001, Perwira, Kota Bks                  |  5.0   |      TRUE      | 107.0031 | -6.221009 |
|                                                   Amanah Laundry                                                   |                   Jl. Rw. Bugel No.04, RT.002/RW.003, Marga Mulya, Kota Bks                   |  5.0   |      TRUE      | 106.9968 | -6.221731 |
|                                                    Babe Laundry                                                    |                   Jl. Rw. Bugel No.1, RT.006/RW.002, Marga Mulya, Kota Bks                    |  4.7   |      TRUE      | 107.0029 | -6.221938 |
|                                         LAUNDRY ( ZUE LAUNDRY SUMMARECON )                                         |                  Gg. Assyifa II No.156, RT.004/RW.002, Marga Mulya, Kota Bks                  |  5.0   |      TRUE      | 107.0056 | -6.226212 |
|                                                    Mama Laundry                                                    |      Kecamatan:, Jl. Perjuangan No.28, RT.001/RW.009, Kelurahan:, Marga Mulya, Kota Bks       |  5.0   |      TRUE      | 107.0062 | -6.227744 |
|                                                   QWASH LAUNDRY                                                    |                Jl. KH. Agus Salim No.50, RT.007/RW.006, Bekasi Jaya, Kota Bks                 |  5.0   |      TRUE      | 107.0072 | -6.235443 |
|                                                  Bamboe Laundry 6                                                  |                 Jl. Kapuas Raya No.180, RT.006/RW.019, Harapan Jaya, Kota Bks                 |  5.0   |      TRUE      | 106.9930 | -6.219090 |
|                                                   Wakib Laundry                                                    | Jl.family 1 Kp.Rawa Bugel Kav.A No.27 Rt.1/Rw.10 kel, RT.002/RW.010, Marga Mulya, Bekasi City |  5.0   |      TRUE      | 106.9956 | -6.220332 |
|                                                   TSABIT LAUNDRY                                                   |                Jl. KH. Muchtar Tabrani No.29, RT.003/RW.001, Perwira, Kota Bks                |  4.2   |      TRUE      | 107.0028 | -6.219695 |
|                                       LAUNDRY ( ZUE LAUNDRY JL AGUS SALIM )                                        |               Jl. KH. Agus Salim No.130d, RT.002/RW.007, Bekasi Jaya, Kota Bks                |  5.0   |      TRUE      | 107.0084 | -6.233695 |
|                                                  Shasya’s Laundry                                                  |                 Jl. Perjuangan No.36-14, RT.001/RW.001, Marga Mulya, Kota Bks                 |  0.0   |      TRUE      | 107.0005 | -6.235163 |
|                                                star laundry bekasi                                                 |                       QXJX+3Q5, RT.006/RW.003, Marga Mulya, Bekasi City                       |  3.7   |       NA       | 106.9995 | -6.219861 |
|                                                    A’la Laundry                                                    |                     Harapan jaya 2, RT.009/RW.019, Harapan Jaya, Kota Bks                     |  5.0   |      TRUE      | 106.9933 | -6.219125 |

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
