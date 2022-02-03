---
date: 2022-02-03T14:18:00-04:00
title: "TUTORIAL WEB SCRAPING: Kapasitas IGD COVID Rumah Sakit di Bekasi"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - rvest
  - SIRANAP
  - Rumah Sakit
---


Tahun lalu, saya menuliskan bagaimana kita bisa mengambil data
keterisian tempat tidur Rumah Sakit khusus pasien Covid dari
[SIRANAP](https://ikanx101.com/blog/siranap/).

Setelah saya coba cek pagi ini, ternyata ada perubahan dari versi
SIRANAP yang sudah menjadi `SIRANAP 3.0`.

Kali ini saya akan *share* cara membuat algoritma di **R** untuk
melakukan *web scrape* informasi IGD khusus COVID di Kota dan Kabupaten
Bekasi. *Libraries* yang saya gunakan adalah:

1.  `rvest` untuk melakukan `html parsing` dari halaman *web*.
2.  `dplyr` untuk *data carpentry*.
3.  `tidyr` untuk mengekstrak *numeric* dari *string*.
4.  `stringr` untuk melakukan *text trimming*.

Alurnya cukup mudah, yakni:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/siranap/post_files/figure-gfm/unnamed-chunk-1-1.png" width="40%" style="display: block; margin: auto;" />

Berikut adalah algoritmanya yang saya buat dalam bentuk *function* di
**R**

``` r
library(rvest)
library(dplyr)
library(stringr)
library(tidyr)

# function utk extract info rumah sakit
extractorizer = function(url){
  data = 
    url %>% 
    read_html() %>%                                                           # membaca html 
    {tibble(
      nama_RS = html_nodes(.,"h5") %>% html_text() %>% str_trim(),            # scrape nama rumah sakit
      bed = html_nodes(.,".mb-1+ .mb-0") %>% html_text() %>% str_trim()       # scrape jumlah bed
    )} %>% 
    mutate(bed = extract_numeric(bed),                                        # ambil numeric dari teks bed
           bed = ifelse(is.na(bed),0,bed)) %>%                                # mengubah kamar penuh jadi nol
    arrange(desc(bed))                                                        # arrange descending dari bed
  return(data)
}
```

Sebagai *input* dari *function* ini adalah *url* atau *link*. Saya akan
gunakan dua *links* dari Siranap, yakni *link* RS di Kota Bekasi dan
Kabupaten Bekasi.

``` r
url = c("https://yankes.kemkes.go.id/app/siranap/rumah_sakit?jenis=1&propinsi=32prop&kabkota=3275",
        "https://yankes.kemkes.go.id/app/siranap/rumah_sakit?jenis=1&propinsi=32prop&kabkota=3216")
```

Jika kalian ingin mencoba untuk kota atau kabupaten lain, silakan ya.

Berikut adalah proses scrapenya:

``` r
df_1 = extractorizer(url[1])
df_2 = extractorizer(url[2])

df_final = 
  rbind(df_1,df_2) %>% 
  arrange(desc(bed))
```

Berikut hasilnya:

| nama\_RS                                  | bed |
|:------------------------------------------|----:|
| RS Umum Daerah dr. Chasbullah Abdulmadjid |  15 |
| RS Umum Hermina Grand Wisata              |  12 |
| RS Umum Rawa Lumbu                        |   9 |
| RS Umum Hermina Bekasi                    |   7 |
| RS Siloam Bekasi Sepanjang Jaya           |   7 |
| RS Umum Daerah Pondokgede                 |   7 |
| RS Mitra Keluarga Pratama                 |   7 |
| RS Grha MM2100                            |   7 |
| RS Umum Bhakti Kartini                    |   6 |
| RS Umum Multazam Medika                   |   6 |
| RS Umum Mitra Keluarga Bekasi Barat       |   5 |
| RS Umum Sentra Medika                     |   5 |
| RS Umum Medirossa 2                       |   5 |
| RS Umum Cibitung Medika                   |   5 |
| RS Umum Citra Harapan                     |   4 |
| RS Umum Daerah Bantar Gebang              |   4 |
| RS Umum Permata Keluarga Jababeka         |   4 |
| Siloam Hospitals Lippo Cikarang           |   4 |
| RS Umum Permata Cibubur                   |   3 |
| RS Helsa                                  |   3 |
| RS EMC Pekayon                            |   3 |
| RS Umum Tiara                             |   3 |
| RS Umum Budi Asih                         |   3 |
| RS Umum Harapan Keluarga Jababeka         |   3 |
| RS Umum Jati Sampurna                     |   2 |
| RS Umum Anna Medika                       |   2 |
| RS Umum Masmitra                          |   2 |
| RS Umum Permata Bekasi                    |   2 |
| RS Umum Graha Juanda                      |   2 |
| RS Umum Anna                              |   2 |
| RS Primaya                                |   2 |
| RS Umum Mekar Sari Bekasi                 |   2 |
| RS Umum Satria Medika                     |   2 |
| RS Umum Mitra Keluarga Bekasi Timur       |   2 |
| RS Umum Mitra Keluarga Cikarang           |   2 |
| RS Umum Karya Medika II                   |   2 |
| RS Uni Medika Setu Bekasi                 |   2 |
| RS Umum Kartika Husada                    |   2 |
| RS Amanda Cikarang Selatan                |   2 |
| RS Mitra Medika Narom                     |   2 |
| RS Hermina Metland Cibitung               |   2 |
| RS Umum Asri Medika                       |   2 |
| RS Umum Bunda Mulia                       |   2 |
| RS Umum Bhakti Husada                     |   2 |
| RS Umum Karya Medika                      |   2 |
| RS Umum Bella                             |   1 |
| RS Seto Hasbadi                           |   1 |
| RS Umum Karya Medika Bantar Gebang        |   1 |
| RS Karunia Kasih                          |   1 |
| RS Eka Bekasi                             |   1 |
| RS Umum Daerah Kab.Bekasi                 |   1 |
| RS Umum Amanda                            |   1 |
| RS Cenka                                  |   1 |
| RS Umum Permata Keluarga Lippo Cikarang   |   1 |
| RS Siloam Sentosa                         |   0 |
| RS Umum Juwita                            |   0 |
| RS Primaya Bekasi Utara                   |   0 |
| RS Umum Islam dr. Subki Abdulkadir        |   0 |
| RS Ibu dan Anak Selasih Medika            |   0 |
| RS Mustika Medika Bekasi                  |   0 |
| RS Primaya                                |   0 |
| RS Umum Hermina Galaxy                    |   0 |
| RS Umum Kartika Husada                    |   0 |
| RS Umum St. Elisabeth                     |   0 |
| RS Umum Mitra Keluarga Cibubur            |   0 |
| RS Siloam Bekasi Timur                    |   0 |
| RS EMC Cikarang                           |   0 |
| RS Umum Tarumajaya                        |   0 |
| RS Umum Cikarang Medika                   |   0 |
| RS Umum Kasih Insani Sukatani             |   0 |
| RS Umum Daerah Cabangbungin               |   0 |
| RS Umum Harapan Mulia                     |   0 |
| RS Umum Pinna                             |   0 |
| RS Umum Ridhoka Salma                     |   0 |
| RS Umum Metro Hospitals                   |   0 |

## Mudah kan?

Catatan: *web scrape* ini saya lakukan pada 2022-02-03 14:15:03.
