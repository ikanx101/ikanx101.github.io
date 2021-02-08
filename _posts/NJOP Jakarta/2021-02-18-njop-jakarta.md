---
date: 2021-02-18T5:30:00-04:00
title: "Tutorial Data Carpentry: Ekstrak Informasi NJOP DKI Jakarta"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - PDF
  - R
  - Data Carpentry
  - Tutorial
  - Data
---

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/NJOP%20Jakarta/pdf_njop.png" width="504" style="display: block; margin: auto;" />

Suatu ketika saya disuruh mencari **Nilai Jual Objek Pajak** (**NJOP**)
per kelurahan di provinsi DKI Jakarta.

> Jangan tanya ini untuk apa ya… *hehe*

Singkat cerita, setelah mencari sana sini, saya tidak menemukan rekapan
lengkapnya di internet. Salah satu sumber paling lengkap adalah file
*pdf* Pergub Nomor 260 Tahun 2015 yang saya dapatkan dari situs resmi
Pemprov DKI Jakarta.

Masalahnya adalah file tersebut bukan *pdf* hasil *export* dari *file
digital* seperti *Ms. Words* tapi berasal dari *scan* dokumen fisik.

Pertanyaannya:

> Bisakah saya mengambil data tabel dari file `pdf` tersebut?

-----

# Ide untuk Pengambilan Data

Pada Pergub tersebut, ada `3741` halaman dengan `3734` halaman berisi
tabel rekapan **NJOP**. Bukan pilihan yang bijak untuk kita melakukan
*copy-paste* manual dari sekian banyak halaman tersebut.

Nah, sekarang saya akan berikan contoh cara mengambil data tersebut
dengan memanfaatkan `library(pdftools)` di **R**.

Saya akan tunjukkan cara mengambil satu tabel dari satu halaman. Dari
cara tersebut, kita nantinya tinggal melakukan *looping* untuk semua
halaman yang dibutuhkan.

-----

# Proses Pengambilan Data

## Import `.pdf` ke dalam **R** *Environment*

Pertama-tama, kita akan *import file* `.pdf` ke dalam **R**
*environment* menggunakan `library(pdftools)`:

``` r
hasil = pdftools::pdf_text(nama_file)
```

Kita lihat struktur datanya:

``` r
str(hasil)
```

    ##  chr [1:3741] "                                                                I SALINANI\n                GUBERNUR PROVINSI D"| __truncated__ ...

Data tersebut berbentuk *vector* `character`. Satu *element vector*
menandakan `1` halaman.

Tabel pertama yang akan saya jadikan contoh adalah pada halaman ke `6`.

``` r
hasil[6]
```

    ## [1] "                                              Lampiran I : Peraturan Gubernur Provinsi\n                                                           Daerah Khusus Ibukota Jakarta\n                                                           Nomor\n                                                           Tanggal\n              KLASIFIKASI DAN BESARNYA NJOP PERMUKAAN BUMI BERUPA TANAH TAHUN 2016\nPROPINSI : 31 ­ DKI JAKARTA                        KECAMATAN : 060 ­ CAKUNG\nKOTA/KAB. : 72 ­ JAKARTA TIMUR                     KELURAHAN : 001 ­ JATINEGARA\n================================================================================================\nBLK NAMA JALAN                         KODE KELAS           PENGGOLONGAN             KET NILAI JUAL\n                                       ZNT   BUMI          NILAI JUAL BUMI         OBJEK PAJAK BUMI\n                                                            ( Rupiah/M2 )             ( Rupiah/M2 )\n================================================================================================\n001 GG RT/RW                            AF     153     2,091,000 s/d     2,261,000        2,176,000\n001 GG RT/RW                            CY     152     2,261,000 s/d     2,444,000        2,352,000\n001 GG RT/RW                            CZ     152     2,261,000 s/d     2,444,000        2,352,000\n001 GG RT/RW                            DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 GG TARUNA I                         DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 GG TARUNA II                        CZ     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL MHT                              DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL BEKASI TIMUR KM 18               DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL JATINEGARA                       AD     145     3,550,000 s/d     3,745,000        3,745,000\n001 JL JATINEGARA LIO                   AE     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL LIO                              DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL LIO I                            DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL LIO II                           AE     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL LIO II                           DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL PULO KAMBING                     AD     145     3,550,000 s/d     3,745,000        3,745,000\n001 JL PULO KAMBING II                  AA     134     6,195,000 s/d     6,490,000        6,343,000\n001 JL PULO KAMBING II                  AB     138     5,095,000 s/d     5,350,000        5,223,000\n001 JL PULO LIO                         AB     138     5,095,000 s/d     5,350,000        5,223,000\n001 JL PULO LIO                         CY     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL PULO LIO                         DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL PULO LIO 6                       CY     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL PULO LIO KM 18                   CY     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL RAYA BEKASI                      AA     134     6,195,000 s/d     6,490,000        6,343,000\n001 JL RAYA BEKASI                      AD     145     3,550,000 s/d     3,745,000        3,745,000\n001 JL RAYA BEKASI                      AE     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL RAYA BEKASI                      CY     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL RAYA BEKASI                      DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL RAYA BEKASI KM 30                AA     134     6,195,000 s/d     6,490,000        6,343,000\n001 JL RAYA BEKASI TIMUR                AA     134     6,195,000 s/d     6,490,000        6,343,000\n001 JL RAYA BEKASI TIMUR                AB     138     5,095,000 s/d     5,350,000        5,223,000\n001 JL RAYA BEKASI TIMUR                CY     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL RAYA BEKASI TIMUR KM 18          AA     134     6,195,000 s/d     6,490,000        6,343,000\n001 JL RAYA BEKASI TIMUR KM 18          AD     145     3,550,000 s/d     3,745,000        3,745,000\n001 JL RAYA BEKASI TIMUR KM 18          CY     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL TARUNA                           AB     138     5,095,000 s/d     5,350,000        5,223,000\n001 JL TARUNA                           AD     145     3,550,000 s/d     3,745,000        3,745,000\n001 JL TARUNA                           CZ     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL TARUNA                           DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL TARUNA 11                        AF     153     2,091,000 s/d     2,261,000        2,176,000\n001 JL TARUNA I                         AD     145     3,550,000 s/d     3,745,000        3,745,000\n001 JL TARUNA I                         AF     153     2,091,000 s/d     2,261,000        2,176,000\n001 JL TARUNA I                         DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL TARUNA I/I                       DA     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL TARUNA II                        AD     145     3,550,000 s/d     3,745,000        3,745,000\n001 JL TARUNA II                        AF     153     2,091,000 s/d     2,261,000        2,176,000\n001 JL TARUNA II                        CY     152     2,261,000 s/d     2,444,000        2,352,000\n001 JL TARUNA II                        CZ     152     2,261,000 s/d     2,444,000        2,352,000\n001 KP BEKASI TIMUR                     CZ     152     2,261,000 s/d     2,444,000        2,352,000\n001 KP LIO                              AE     152     2,261,000 s/d     2,444,000        2,352,000\n001 KP LIO JL ANGKASA                   DA     152     2,261,000 s/d     2,444,000        2,352,000\n"

Bentuknya masih sangat berantakan *yah*. Sekarang kita harus
merapikannya.

## Proses Perapihan

### *Trim White Spaces*

Langkah pertama adalah menghapus semua *whitespaces* yang ada dalam
*vector* tersebut. Ada banyak cara untuk melakukannya tapi saya ingin
melakukannya dengan membuat *looping* (alih-alih menggunakan `library`
seperti `stringr`).

``` r
tes_lagi = hasil[[6]]
for(i in 1:10){
  tes_lagi = gsub("  "," ",tes_lagi)
}
```

### *Exporting* ke Dalam `.txt` *Files*

Langkah berikutnya adalah mengekspor *vector* tersebut ke `.txt` *file*.
Gunanya apa? Agar bisa kita baca dengan `readLines()`, sehingga terlihat
dengan jelas data perbarisnya kelak.

``` r
sink("tes.txt")
writeLines(tes_lagi)
sink()
```

### *Importing* `.txt` *Files* Kembali ke **R** *Environment*

Sekarang kita akan `readLines()` *file* tersebut, lalu kita lihat
bagaimana hasilnya:

``` r
atas = readLines('tes.txt')
atas
```

    ##  [1] " Lampiran I : Peraturan Gubernur Provinsi"                                                       
    ##  [2] " Daerah Khusus Ibukota Jakarta"                                                                  
    ##  [3] " Nomor"                                                                                          
    ##  [4] " Tanggal"                                                                                        
    ##  [5] " KLASIFIKASI DAN BESARNYA NJOP PERMUKAAN BUMI BERUPA TANAH TAHUN 2016"                           
    ##  [6] "PROPINSI : 31 ­ DKI JAKARTA KECAMATAN : 060 ­ CAKUNG"                                            
    ##  [7] "KOTA/KAB. : 72 ­ JAKARTA TIMUR KELURAHAN : 001 ­ JATINEGARA"                                     
    ##  [8] "================================================================================================"
    ##  [9] "BLK NAMA JALAN KODE KELAS PENGGOLONGAN KET NILAI JUAL"                                           
    ## [10] " ZNT BUMI NILAI JUAL BUMI OBJEK PAJAK BUMI"                                                      
    ## [11] " ( Rupiah/M2 ) ( Rupiah/M2 )"                                                                    
    ## [12] "================================================================================================"
    ## [13] "001 GG RT/RW AF 153 2,091,000 s/d 2,261,000 2,176,000"                                           
    ## [14] "001 GG RT/RW CY 152 2,261,000 s/d 2,444,000 2,352,000"                                           
    ## [15] "001 GG RT/RW CZ 152 2,261,000 s/d 2,444,000 2,352,000"                                           
    ## [16] "001 GG RT/RW DA 152 2,261,000 s/d 2,444,000 2,352,000"                                           
    ## [17] "001 GG TARUNA I DA 152 2,261,000 s/d 2,444,000 2,352,000"                                        
    ## [18] "001 GG TARUNA II CZ 152 2,261,000 s/d 2,444,000 2,352,000"                                       
    ## [19] "001 JL MHT DA 152 2,261,000 s/d 2,444,000 2,352,000"                                             
    ## [20] "001 JL BEKASI TIMUR KM 18 DA 152 2,261,000 s/d 2,444,000 2,352,000"                              
    ## [21] "001 JL JATINEGARA AD 145 3,550,000 s/d 3,745,000 3,745,000"                                      
    ## [22] "001 JL JATINEGARA LIO AE 152 2,261,000 s/d 2,444,000 2,352,000"                                  
    ## [23] "001 JL LIO DA 152 2,261,000 s/d 2,444,000 2,352,000"                                             
    ## [24] "001 JL LIO I DA 152 2,261,000 s/d 2,444,000 2,352,000"                                           
    ## [25] "001 JL LIO II AE 152 2,261,000 s/d 2,444,000 2,352,000"                                          
    ## [26] "001 JL LIO II DA 152 2,261,000 s/d 2,444,000 2,352,000"                                          
    ## [27] "001 JL PULO KAMBING AD 145 3,550,000 s/d 3,745,000 3,745,000"                                    
    ## [28] "001 JL PULO KAMBING II AA 134 6,195,000 s/d 6,490,000 6,343,000"                                 
    ## [29] "001 JL PULO KAMBING II AB 138 5,095,000 s/d 5,350,000 5,223,000"                                 
    ## [30] "001 JL PULO LIO AB 138 5,095,000 s/d 5,350,000 5,223,000"                                        
    ## [31] "001 JL PULO LIO CY 152 2,261,000 s/d 2,444,000 2,352,000"                                        
    ## [32] "001 JL PULO LIO DA 152 2,261,000 s/d 2,444,000 2,352,000"                                        
    ## [33] "001 JL PULO LIO 6 CY 152 2,261,000 s/d 2,444,000 2,352,000"                                      
    ## [34] "001 JL PULO LIO KM 18 CY 152 2,261,000 s/d 2,444,000 2,352,000"                                  
    ## [35] "001 JL RAYA BEKASI AA 134 6,195,000 s/d 6,490,000 6,343,000"                                     
    ## [36] "001 JL RAYA BEKASI AD 145 3,550,000 s/d 3,745,000 3,745,000"                                     
    ## [37] "001 JL RAYA BEKASI AE 152 2,261,000 s/d 2,444,000 2,352,000"                                     
    ## [38] "001 JL RAYA BEKASI CY 152 2,261,000 s/d 2,444,000 2,352,000"                                     
    ## [39] "001 JL RAYA BEKASI DA 152 2,261,000 s/d 2,444,000 2,352,000"                                     
    ## [40] "001 JL RAYA BEKASI KM 30 AA 134 6,195,000 s/d 6,490,000 6,343,000"                               
    ## [41] "001 JL RAYA BEKASI TIMUR AA 134 6,195,000 s/d 6,490,000 6,343,000"                               
    ## [42] "001 JL RAYA BEKASI TIMUR AB 138 5,095,000 s/d 5,350,000 5,223,000"                               
    ## [43] "001 JL RAYA BEKASI TIMUR CY 152 2,261,000 s/d 2,444,000 2,352,000"                               
    ## [44] "001 JL RAYA BEKASI TIMUR KM 18 AA 134 6,195,000 s/d 6,490,000 6,343,000"                         
    ## [45] "001 JL RAYA BEKASI TIMUR KM 18 AD 145 3,550,000 s/d 3,745,000 3,745,000"                         
    ## [46] "001 JL RAYA BEKASI TIMUR KM 18 CY 152 2,261,000 s/d 2,444,000 2,352,000"                         
    ## [47] "001 JL TARUNA AB 138 5,095,000 s/d 5,350,000 5,223,000"                                          
    ## [48] "001 JL TARUNA AD 145 3,550,000 s/d 3,745,000 3,745,000"                                          
    ## [49] "001 JL TARUNA CZ 152 2,261,000 s/d 2,444,000 2,352,000"                                          
    ## [50] "001 JL TARUNA DA 152 2,261,000 s/d 2,444,000 2,352,000"                                          
    ## [51] "001 JL TARUNA 11 AF 153 2,091,000 s/d 2,261,000 2,176,000"                                       
    ## [52] "001 JL TARUNA I AD 145 3,550,000 s/d 3,745,000 3,745,000"                                        
    ## [53] "001 JL TARUNA I AF 153 2,091,000 s/d 2,261,000 2,176,000"                                        
    ## [54] "001 JL TARUNA I DA 152 2,261,000 s/d 2,444,000 2,352,000"                                        
    ## [55] "001 JL TARUNA I/I DA 152 2,261,000 s/d 2,444,000 2,352,000"                                      
    ## [56] "001 JL TARUNA II AD 145 3,550,000 s/d 3,745,000 3,745,000"                                       
    ## [57] "001 JL TARUNA II AF 153 2,091,000 s/d 2,261,000 2,176,000"                                       
    ## [58] "001 JL TARUNA II CY 152 2,261,000 s/d 2,444,000 2,352,000"                                       
    ## [59] "001 JL TARUNA II CZ 152 2,261,000 s/d 2,444,000 2,352,000"                                       
    ## [60] "001 KP BEKASI TIMUR CZ 152 2,261,000 s/d 2,444,000 2,352,000"                                    
    ## [61] "001 KP LIO AE 152 2,261,000 s/d 2,444,000 2,352,000"                                             
    ## [62] "001 KP LIO JL ANGKASA DA 152 2,261,000 s/d 2,444,000 2,352,000"                                  
    ## [63] ""

Sekarang bentuknya sudah mulai terlihat kan yah?

Walaupun masih berisi vector, tapi setidaknya kita bisa melihat ada `63`
baris data.

Tugas selanjutnya adalah tinggal memilih, data apa saja yang akan kita
ambil.

### Mengambil Data yang Diperlukan

#### Data Kota, Kecamatan, dan Kelurahan

``` r
kecamatan = atas[grepl("propinsi",atas,ignore.case = T)]
kecamatan
```

    ## [1] "PROPINSI : 31 ­ DKI JAKARTA KECAMATAN : 060 ­ CAKUNG"

``` r
kota_kelurahan = atas[grepl("kota/kab",atas,ignore.case = T)]
kota_kelurahan
```

    ## [1] "KOTA/KAB. : 72 ­ JAKARTA TIMUR KELURAHAN : 001 ­ JATINEGARA"

Dari *single object* tersebut, kita akan rapikan dan bentuk ke dalam
*data frame*.

Saya akan menggunakan *function* `separate()` dari `library(tidyr)`
dalam prinsip *tidy* tentunya.

``` r
dummy = 
    data.frame(kecamatan,kota_kelurahan) %>% 
    separate(kecamatan,
             into = c("provinsi","kecamatan"),
             sep = "KECAMATAN") %>% 
    select(-provinsi) %>% 
    mutate(kecamatan = gsub("[0-9]","",kecamatan),
           kecamatan = gsub("\\:","",kecamatan),
           kecamatan = stringr::str_trim(kecamatan)) %>% 
    separate(kota_kelurahan,
             into = c("hapus","kota","kelurahan"),
             sep = "\\:") %>% 
    mutate(kelurahan = gsub("[0-9]","",kelurahan),
           kelurahan = gsub("\\:","",kelurahan),
           kelurahan = stringr::str_trim(kelurahan),
           hapus = NULL,
           kota = gsub("[0-9]","",kota),
           kota = gsub("KELURAHAN","",kota),
           kota = stringr::str_trim(kota)) %>% 
    mutate(kecamatan = trimws(kecamatan),
           kota = trimws(kota),
           kelurahan = trimws(kelurahan))
dummy
```

    ##   kecamatan            kota    kelurahan
    ## 1  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA

#### Data NJOP

Sekarang bagian pamungkasnya adalah mengambil nilai NJOP per baris dari
*vector* `atas`.

Saya harus memastikan bahwa saya mengambil baris yang tepat dan hanya
akan mengambil `character` di ujung kanan saja.

``` r
harga_t = atas[grepl("s/d",atas,ignore.case = T)]
harga = substr(harga_t,stringr::str_length(harga_t)-11,stringr::str_length(harga_t))
```

Kita lihat bentuknya seperti apa sekarang:

``` r
data = data.frame(dummy,harga)
data
```

    ##    kecamatan            kota    kelurahan        harga
    ## 1   ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,176,000
    ## 2   ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 3   ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 4   ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 5   ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 6   ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 7   ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 8   ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 9   ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 3,745,000
    ## 10  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 11  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 12  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 13  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 14  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 15  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 3,745,000
    ## 16  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 6,343,000
    ## 17  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 5,223,000
    ## 18  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 5,223,000
    ## 19  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 20  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 21  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 22  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 23  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 6,343,000
    ## 24  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 3,745,000
    ## 25  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 26  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 27  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 28  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 6,343,000
    ## 29  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 6,343,000
    ## 30  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 5,223,000
    ## 31  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 32  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 6,343,000
    ## 33  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 3,745,000
    ## 34  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 35  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 5,223,000
    ## 36  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 3,745,000
    ## 37  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 38  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 39  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,176,000
    ## 40  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 3,745,000
    ## 41  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,176,000
    ## 42  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 43  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 44  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 3,745,000
    ## 45  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,176,000
    ## 46  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 47  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 48  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 49  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000
    ## 50  ­ CAKUNG ­ JAKARTA TIMUR ­ JATINEGARA 00 2,352,000

Sudah mulai terlihat dengan jelas datanya kan?

Tinggal *final touch* saja dengan merapikan variabel `harga` pada *data
frame* tersebut.

### *Final Touch*

``` r
final = 
  data %>% 
  mutate(harga = gsub("\\,","",harga)) %>% 
  separate(harga,
           into = c("hapus","harga"),
           sep = " ") %>% 
  select(-hapus) %>% 
  mutate(harga = as.numeric(harga))
```

    ## Hasil Ambil Data Halaman 6

| kecamatan | kota            | kelurahan    |   harga |
| :-------- | :-------------- | :----------- | ------: |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2176000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 3745000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 3745000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 6343000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 5223000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 5223000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 6343000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 3745000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 6343000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 6343000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 5223000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 6343000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 3745000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 5223000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 3745000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2176000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 3745000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2176000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 3745000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2176000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |
| ­ CAKUNG  | ­ JAKARTA TIMUR | ­ JATINEGARA | 2352000 |

-----

# Kesimpulan

Dari algoritma di atas, saya tinggal melakukan *looping* untuk `3733`an
halaman tersisa dari `.pdf` tersebut. Prosesnya sendiri relatif singkat,
tidak sampai `5` menit.

Berikut adalah summarynya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/NJOP%20Jakarta/post_files/figure-gfm/unnamed-chunk-14-1.png" style="display: block; margin: auto;" />

-----

`if you find this article helpful, support this blog by clicking the ads.`
