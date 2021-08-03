---
date: 2021-08-03T10:18:00-04:00
title: "Tutorial Web Scraping: Mengambil Data Tabel dari Wikipedia"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - rvest
  - Wikipedia
  - Table
---


Bagi kebanyakan orang,
[Wikipedia](https://en.wikipedia.org/wiki/Main_Page) adalah sebuah
anugerah. Bagaimana konsep *open source* bisa diterapkan dalam ilmu
pengetahuan. Setiap orang bisa menuliskan artikel dan keilmuannya secara
bebas dan bertanggung jawab di sana. Namun, beberapa institusi
pendidikan melarang penggunaan **Wikipedia** sebagai sumber sitasi
penelitiannya.

------------------------------------------------------------------------

Sebagai salah satu sumber informasi yang aktual, terpercaya, dan bisa
divalidasi, bagi saya **Wikipedia** adalah salah satu sumber data
termudah di internet yang bisa saya *web scrape*. Apalagi jika bentuknya
berupa tabel.

Sebagai contoh saya akan coba melakukan *web scrape* dari halaman
Wikipedia tentang data Covid 19 di Indonesia [berikut
ini](https://en.wikipedia.org/wiki/Statistics_of_the_COVID-19_pandemic_in_Indonesia).

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post%20wikipedia/tabel_1.png" alt="Contoh Salah Satu Tabel dari Situs Wikipedia" width="1920" />
<p class="caption">
Contoh Salah Satu Tabel dari Situs Wikipedia
</p>

</div>

Tabel di atas adalah satu dari beberapa tabel data yang ada dari halaman
tersebut.

Mari saya tunjukkan caranya melakukan *web scrape* tabel seperti ini:

## Langkah I

Siapkan *url* dari Wikipedia tersebut:

``` r
url = "https://en.wikipedia.org/wiki/Statistics_of_the_COVID-19_pandemic_in_Indonesia"
```

## Langkah II

Kita akan ambil semua tabel yang ada di halaman tersebut dengan
*function* `html_table()` dari `library(rvest)`. Tambahkan parameter
`fill = T` pada *function* tersebut.

``` r
hasil = url %>% read_html() %>% html_table(fill = T)
```

## Langkah III

Data hasil *web scrape* bernama `hasil` memiliki struktur *list* karena
*function* di atas mengambil semua tabel yang mungkin ada di halaman
tersebut.

Mari kita lihat dulu bagaimana hasilnya:

``` r
str(hasil)
```

    ## List of 9
    ##  $ : tibble [1 × 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ X1: chr "Active cases by province as of 31 July 2021\n\n.mw-parser-output .legend{page-break-inside:avoid;break-inside:a"| __truncated__
    ##   ..$ X2: chr "Confirmed cases by province as of 2 August 2021\n\n  Jakarta (23.64%)  West Java (17.74%)  Central Java (11.24%"| __truncated__
    ##   ..$ X3: chr "Recoveries by province as of 2 August 2021\n\n  Jakarta (27.84%)  West Java (17.08%)  Central Java (10.98%)  Ea"| __truncated__
    ##   ..$ X4: chr "Deaths by province as of 2 August 2021\n\n  East Java (21.60%)  Central Java (20.58%)  Jakarta (12.74%)  West J"| __truncated__
    ##  $ : tibble [37 × 9] (S3: tbl_df/tbl/data.frame)
    ##   ..$ COVID-19 cases in Indonesia[a][b]: chr [1:37] "Province" "Aceh" "Bali" "Bangka Belitung Islands" ...
    ##   ..$ COVID-19 cases in Indonesia[a][b]: chr [1:37] "Cases" "23,249" "77,465" "33,823" ...
    ##   ..$ COVID-19 cases in Indonesia[a][b]: chr [1:37] "Recoveries" "16,968" "62,591" "27,386" ...
    ##   ..$ COVID-19 cases in Indonesia[a][b]: chr [1:37] "Deaths" "994" "2,184" "688" ...
    ##   ..$ COVID-19 cases in Indonesia[a][b]: chr [1:37] "Active[c]" "5,287" "12,690" "5,749" ...
    ##   ..$ COVID-19 cases in Indonesia[a][b]: chr [1:37] "Cases per100,000 population[d]" "441" "1,794" "2,324" ...
    ##   ..$ COVID-19 cases in Indonesia[a][b]: chr [1:37] "Recoveryrate" "72.98%" "80.8%" "80.97%" ...
    ##   ..$ COVID-19 cases in Indonesia[a][b]: chr [1:37] "Fatalityrate" "4.28%" "2.82%" "2.03%" ...
    ##   ..$ COVID-19 cases in Indonesia[a][b]: chr [1:37] "Official website" "covid19.acehprov.go.id" "infocorona.baliprov.go.id" "covid19.babelprov.go.id" ...
    ##  $ : tibble [1 × 1] (S3: tbl_df/tbl/data.frame)
    ##   ..$ X1: chr "Java   \n  Other regions   \n\n\n\n\n@media all and (max-width:720px){body.skin-minerva .mw-parser-output .mw-g"| __truncated__
    ##  $ : tibble [1 × 1] (S3: tbl_df/tbl/data.frame)
    ##   ..$ X1: chr "Sumatra   \n  Lesser Sunda Islands   \n  Kalimantan   \n  Sulawesi   \n  Moluccas   \n  Western New Guinea   \n"| __truncated__
    ##  $ : tibble [1 × 1] (S3: tbl_df/tbl/data.frame)
    ##   ..$ X1: chr "Sumatra   \n  Java   \n  Lesser Sunda Islands   \n  Kalimantan   \n  Sulawesi   \n  Moluccas   \n  Western New Guinea"
    ##  $ : tibble [1 × 1] (S3: tbl_df/tbl/data.frame)
    ##   ..$ X1: chr "Total confirmed cases   \n  Active cases   \n  Total deaths   \n  Total recoveries\n\n\n\n\n\n\nShow linear sca"| __truncated__
    ##  $ : tibble [9 × 6] (S3: tbl_df/tbl/data.frame)
    ##   ..$ Vaccination numbers by group: chr [1:9] "Group" "Group" "Health professionals" "Public officers" ...
    ##   ..$ Vaccination numbers by group: chr [1:9] "Target" "Target" "1,468,764" "17,327,167" ...
    ##   ..$ Vaccination numbers by group: chr [1:9] "First dose" "Total" "1,598,537" "26,026,898" ...
    ##   ..$ Vaccination numbers by group: chr [1:9] "First dose" "Percentage" "108.84%" "150.21%" ...
    ##   ..$ Vaccination numbers by group: chr [1:9] "Second dose" "Total" "1,458,707" "11,695,815" ...
    ##   ..$ Vaccination numbers by group: chr [1:9] "Second dose" "Percentage" "99.32%" "67.5%" ...
    ##  $ : tibble [38 × 7] (S3: tbl_df/tbl/data.frame)
    ##   ..$ Vaccination numbers by province: chr [1:38] "Province" "Province" "Aceh" "Bali" ...
    ##   ..$ Vaccination numbers by province: chr [1:38] "Target" "Target" "4,028,891" "3,405,130" ...
    ##   ..$ Vaccination numbers by province: chr [1:38] "First dose" "Total" "679,478" "3,068,969" ...
    ##   ..$ Vaccination numbers by province: chr [1:38] "First dose" "Percentage" "16.87%" "90.13%" ...
    ##   ..$ Vaccination numbers by province: chr [1:38] "Second dose" "Total" "272,740" "874,896" ...
    ##   ..$ Vaccination numbers by province: chr [1:38] "Second dose" "Percentage" "6.77%" "25.69%" ...
    ##   ..$ Vaccination numbers by province: chr [1:38] "Percentage of  population fully  vaccinated[a][b]" "Percentage of  population fully  vaccinated[a][b]" "5.17%" "20.26%" ...
    ##  $ : tibble [99 × 5] (S3: tbl_df/tbl/data.frame)
    ##   ..$ Confirmed cases of Indonesian nationals abroad: chr [1:99] "Country or territory" "Afghanistan" "Albania" "Algeria" ...
    ##   ..$ Confirmed cases of Indonesian nationals abroad: chr [1:99] "Cases" "24" "2" "12" ...
    ##   ..$ Confirmed cases of Indonesian nationals abroad: chr [1:99] "Recoveries" "23" "2" "12" ...
    ##   ..$ Confirmed cases of Indonesian nationals abroad: chr [1:99] "Deaths" "0" "0" "0" ...
    ##   ..$ Confirmed cases of Indonesian nationals abroad: chr [1:99] "Active" "1" "0" "0" ...

Terlihat ada `9` elemen tabel pada `hasil`.

## Langkah IV

Untuk mengambil salah satu tabel, kita cukup memanggil salah satu elemen
dari *list* tersebut. Sebagai contoh, jika saya ingin mengambil data
dari tabel seperti gambar sebelumnya, saya akan lakukan:

``` r
data_indonesia = hasil[[2]] %>% as.data.frame()
data_indonesia
```

| COVID-19 cases in Indonesia\[a\]\[b\] | COVID-19 cases in Indonesia\[a\]\[b\] | COVID-19 cases in Indonesia\[a\]\[b\] | COVID-19 cases in Indonesia\[a\]\[b\] | COVID-19 cases in Indonesia\[a\]\[b\] | COVID-19 cases in Indonesia\[a\]\[b\] | COVID-19 cases in Indonesia\[a\]\[b\] | COVID-19 cases in Indonesia\[a\]\[b\] |   COVID-19 cases in Indonesia\[a\]\[b\]    |
|:-------------------------------------:|:-------------------------------------:|:-------------------------------------:|:-------------------------------------:|:-------------------------------------:|:-------------------------------------:|:-------------------------------------:|:-------------------------------------:|:------------------------------------------:|
|               Province                |                 Cases                 |              Recoveries               |                Deaths                 |              Active\[c\]              |   Cases per100,000 population\[d\]    |             Recoveryrate              |             Fatalityrate              |              Official website              |
|                 Aceh                  |                23,249                 |                16,968                 |                  994                  |                 5,287                 |                  441                  |                72.98%                 |                 4.28%                 |           covid19.acehprov.go.id           |
|                 Bali                  |                77,465                 |                62,591                 |                 2,184                 |                12,690                 |                 1,794                 |                 80.8%                 |                 2.82%                 |         infocorona.baliprov.go.id          |
|        Bangka Belitung Islands        |                33,823                 |                27,386                 |                  688                  |                 5,749                 |                 2,324                 |                80.97%                 |                 2.03%                 |          covid19.babelprov.go.id           |
|                Banten                 |                114,057                |                81,469                 |                 1,995                 |                30,593                 |                  958                  |                71.43%                 |                 1.75%                 |        infocorona.bantenprov.go.id         |
|               Bengkulu                |                18,128                 |                13,192                 |                  286                  |                 4,650                 |                  902                  |                72.77%                 |                 1.58%                 |         covid19.bengkuluprov.go.id         |
|             Central Java              |                386,121                |                309,784                |                19,688                 |                56,649                 |                 1,057                 |                80.23%                 |                 5.1%                  |          corona.jatengprov.go.id           |
|          Central Kalimantan           |                35,054                 |                29,043                 |                  873                  |                 5,138                 |                 1,313                 |                82.85%                 |                 2.49%                 |            corona.kalteng.go.id            |
|           Central Sulawesi            |                23,454                 |                16,304                 |                  668                  |                 6,482                 |                  786                  |                69.51%                 |                 2.85%                 | dinkes.sultengprov.go.id/category/covid-19 |
|               East Java               |                312,103                |                237,896                |                20,660                 |                53,547                 |                  767                  |                76.22%                 |                 6.62%                 |        infocovid19.jatimprov.go.id         |
|            East Kalimantan            |                119,223                |                92,608                 |                 3,423                 |                23,192                 |                 3,166                 |                77.68%                 |                 2.87%                 |          covid19.kaltimprov.go.id          |
|          East Nusa Tenggara           |                39,994                 |                27,123                 |                  730                  |                12,141                 |                  751                  |                67.82%                 |                 1.83%                 |           covid19.nttprov.go.id            |
|               Gorontalo               |                 8,121                 |                 6,599                 |                  231                  |                 1,291                 |                  693                  |                81.26%                 |                 2.84%                 |        covid-19.gorontaloprov.go.id        |
|                Jakarta                |                817,354                |                789,226                |                12,244                 |                15,884                 |                 7,739                 |                96.56%                 |                 1.5%                  |            corona.jakarta.go.id            |
|                 Jambi                 |                20,667                 |                14,995                 |                  432                  |                 5,240                 |                  582                  |                72.56%                 |                 2.09%                 |           corona.jambiprov.go.id           |
|                Lampung                |                35,348                 |                25,570                 |                 2,081                 |                 7,697                 |                  392                  |                72.34%                 |                 5.89%                 |         covid19.lampungprov.go.id          |
|                Maluku                 |                13,432                 |                 9,710                 |                  226                  |                 3,496                 |                  726                  |                72.29%                 |                 1.68%                 |          corona.malukuprov.go.id           |
|           North Kalimantan            |                21,952                 |                15,736                 |                  358                  |                 5,858                 |                 3,128                 |                71.68%                 |                 1.63%                 |        coronainfo.kaltaraprov.go.id        |
|             North Maluku              |                10,060                 |                 7,341                 |                  240                  |                 2,479                 |                  784                  |                72.97%                 |                 2.39%                 |           corona.malutprov.go.id           |
|            North Sulawesi             |                24,840                 |                18,668                 |                  724                  |                 5,448                 |                  947                  |                75.15%                 |                 2.91%                 |           corona.sulutprov.go.id           |
|             North Sumatra             |                61,696                 |                40,901                 |                 1,496                 |                19,299                 |                  417                  |                66.29%                 |                 2.42%                 |          covid19.sumutprov.go.id           |
|                 Papua                 |                27,223                 |                12,690                 |                  271                  |                14,262                 |                  633                  |                46.61%                 |                  1%                   |            covid19.papua.go.id             |
|                 Riau                  |                98,539                 |                82,052                 |                 2,625                 |                13,862                 |                 1,541                 |                83.27%                 |                 2.66%                 |             corona.riau.go.id              |
|             Riau Islands              |                45,145                 |                37,269                 |                 1,184                 |                 6,692                 |                 2,187                 |                82.55%                 |                 2.62%                 |           corona.kepriprov.go.id           |
|           South Kalimantan            |                48,666                 |                38,820                 |                 1,376                 |                 8,470                 |                 1,195                 |                79.77%                 |                 2.83%                 |          corona.kalselprov.go.id           |
|            South Sulawesi             |                84,509                 |                71,926                 |                 1,366                 |                11,217                 |                  931                  |                85.11%                 |                 1.62%                 |          covid19.sulselprov.go.id          |
|             South Sumatra             |                47,572                 |                35,283                 |                 2,099                 |                10,190                 |                  562                  |                74.17%                 |                 4.41%                 |          corona.sumselprov.go.id           |
|          Southeast Sulawesi           |                16,500                 |                13,021                 |                  364                  |                 3,115                 |                  629                  |                78.92%                 |                 2.21%                 |          dinkes.sultraprov.go.id           |
|     Special Region of Yogyakarta      |                119,136                |                78,658                 |                 3,459                 |                37,019                 |                 3,247                 |                66.02%                 |                 2.9%                  |           corona.jogjaprov.go.id           |
|               West Java               |                611,796                |                479,279                |                 9,552                 |                122,965                |                 1,267                 |                78.34%                 |                 1.56%                 |          pikobar.jabarprov.go.id           |
|            West Kalimantan            |                26,315                 |                20,669                 |                  660                  |                 4,986                 |                  486                  |                78.54%                 |                 2.51%                 |          covid19.kalbarprov.go.id          |
|          West Nusa Tenggara           |                19,960                 |                17,295                 |                  571                  |                 2,094                 |                  375                  |                86.65%                 |                 2.86%                 |            corona.ntbprov.go.id            |
|              West Papua               |                18,782                 |                15,517                 |                  287                  |                 2,978                 |                 1,656                 |                82.62%                 |                 1.53%                 |        dinkes.papuabaratprov.go.id         |
|             West Sulawesi             |                 8,525                 |                 6,728                 |                  173                  |                 1,624                 |                  601                  |                78.92%                 |                 2.03%                 |          dinkes.sulbarprov.go.id           |
|             West Sumatra              |                71,587                 |                57,221                 |                 1,515                 |                12,851                 |                 1,293                 |                79.93%                 |                 2.12%                 |          corona.sumbarprov.go.id           |
|                 Total                 |               3,462,800               |               2,842,345               |                97,291                 |                523,164                |                 1,282                 |                82.08%                 |                 2.81%                 |               covid19.go.id                |

------------------------------------------------------------------------

> ***Bagaimana? Mudah kan?***

`if you find this article helpful, support this blog by clicking the ads.`
