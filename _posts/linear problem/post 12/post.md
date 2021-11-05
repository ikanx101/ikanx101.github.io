Optimization Story: Sport Science - Menentukan Konfigurasi Pelari
Estafet
================

Salah satu kegunaan *artificial intelligence* dan *data science* di
bidang olahraga adalah melakukan
[prediksi](https://ikanx101.com/blog/prediksi-EPL/) terhadap suatu
kejadian. Tapi ada satu *field* lagi yang mungkin jarang orang ketahui,
yakni: ***optimization***.

Saya akan berikan contoh simpel penerapan *optimization* di bidang
olahraga, khususnya di cabang lari estafet.

-----

## Masalah

Seorang pelatih estafet hendak mendaftarkan timnya untuk mengikuti
kompetisi di suatu waktu. Pelatih tersebut harus memilih **4 dari 6**
orang pelari anak didiknya. Untuk itu, dia melakukan beberapa kali
simulasi dan mencatatkan waktunya sebagai berikut:

``` r
data
```

    ##       Pelari Fraction 1 Fraction 2 Fraction 3 Fraction 4
    ## 1 Sprinter 1      12.27      11.57      11.54      12.07
    ## 2 Sprinter 2      11.34      11.45      12.45      12.34
    ## 3 Sprinter 3      11.29      11.50      11.45      11.52
    ## 4 Sprinter 4      12.54      12.34      12.32      11.57
    ## 5 Sprinter 5      12.20      11.22      12.07      12.03
    ## 6 Sprinter 6      11.54      11.48      11.56      12.30
