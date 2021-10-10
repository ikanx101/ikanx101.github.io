Kondisi Terkini Pandemi Covid 19 per Negara di Dunia
================

Tidak terasa sudah lebih dari satu setengah tahun kita melalui pandemi
Covid 19. Sejak tulisan pertama saya terkait [model matematika
penyebaran covid](https://ikanx101.com/blog/covid/), kini angka
pertambahan kasus positif relatif sudah mulai terkendali. Sampai bisa
seperti sekarang ini, Indonesia harus melalui jalan terjal dan berliku.
Mulai dari hantaman gelombang pertama dan gelombang kedua (varian delta)
pada kuartal I dan II tahun ini. Namun menurut saya, Indonesia belum
bisa dikatakan menang melawan Covid 19. Masih ada PR yang harus kita
selesaikan bersama sebagai negara. Selain itu korban yang berjatuhan
sampai saat ini **tidak menjadikan kita pantas** untuk berbangga hati.

Jika kita pantau dari berbagai sumber berita yang ada, sebenarnya ada
beberapa negara yang sudah jauh lebih dulu “terbebas” dari Covid 19.
Sementara sebagian lainnya masih berusaha keluar.

Sekarang mari kita lihat kondisi terkini Covid 19 per negara seperti
yang saya himpun dari situs <https://www.worldometers.info/coronavirus/>
per 2021-10-10 11:34:28. Saya akan membuat analisa deskriptif sederhana
dari data yang saya
dapatkan.

    ## Contoh 10 Data Teratas yang Didapatkan

| number | country\_other | population | active\_cases | total\_cases | total\_recovered | total\_deaths |
| -----: | :------------- | ---------: | ------------: | -----------: | ---------------: | ------------: |
|      1 | USA            |  333468970 |       9815497 |     45179209 |         34630654 |        733058 |
|      2 | India          | 1397235287 |        230939 |     33953475 |         33271915 |        450621 |
|      3 | Brazil         |  214479029 |        295953 |     21567181 |         20670348 |        600880 |
|      4 | UK             |   68339166 |       1363398 |      8120713 |          6619618 |        137697 |
|      5 | Russia         |  146014021 |        700831 |      7775365 |          6858119 |        216415 |
|      6 | Turkey         |   85491480 |        482494 |      7416182 |          6867704 |         65984 |
|      7 | France         |   65457114 |         97187 |      7052520 |          6838289 |        117044 |
|      8 | Iran           |   85357709 |        367749 |      5691634 |          5201515 |        122370 |
|      9 | Argentina      |   45722524 |         18791 |      5265528 |          5131279 |        115458 |
|     10 | Spain          |   46777803 |         86148 |      4973619 |          4800693 |         86778 |

Dari data tersebut, saya akan menghitung beberapa *ratio* seperti:

1.  `ratio_sakit`: rasio antara *total cases* dengan populasi.
2.  `ratio_aktif`: rasio antara *active cases* dengan *total cases*.
3.  `ratio_cured`: rasio antara *total recovered* dengan *total cases*.
4.  `ratio_death`: rasio antara *total death* dengan *total
cases*.

<!-- end list -->

    ## Contoh 10 Data Teratas Hasil Perhitungan Rasio

| country\_other | ratio\_sakit | ratio\_aktif | ratio\_death | ratio\_cured |
| :------------- | -----------: | -----------: | -----------: | -----------: |
| USA            |    0.1354825 |    0.2172569 |    0.0162256 |    0.7665175 |
| India          |    0.0243005 |    0.0068016 |    0.0132717 |    0.9799266 |
| Brazil         |    0.1005561 |    0.0137224 |    0.0278609 |    0.9584168 |
| UK             |    0.1188296 |    0.1678914 |    0.0169563 |    0.8151523 |
| Russia         |    0.0532508 |    0.0901348 |    0.0278334 |    0.8820318 |
| Turkey         |    0.0867476 |    0.0650596 |    0.0088973 |    0.9260431 |
| France         |    0.1077426 |    0.0137805 |    0.0165961 |    0.9696235 |
| Iran           |    0.0666798 |    0.0646122 |    0.0215000 |    0.9138878 |
| Argentina      |    0.1151627 |    0.0035687 |    0.0219271 |    0.9745042 |
| Spain          |    0.1063243 |    0.0173210 |    0.0174477 |    0.9652314 |

-----

## *Total Cases*

*Total cases* adalah angka *real infected person* di suatu negara.
Secara total dunia, sampai saat data ini saya *scrape*, sudah ada 238.43
juta orang yang terinfeksi Covid 19. Jika kita lihat sebaran
`ratio_sakit` semua negara, kita bisa
melihat:

<img src="covid_ending_files/figure-gfm/unnamed-chunk-4-1.png" width="672" /><img src="covid_ending_files/figure-gfm/unnamed-chunk-4-2.png" width="672" />

xxx
