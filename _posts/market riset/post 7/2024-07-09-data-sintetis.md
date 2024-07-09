---
date: 2024-07-09T09:04:00-04:00
title: "Membuat Data Survey Sintetis Menggunakan R"
categories:
  - Blog
tags:
  - Market Riset
  - Quantitative
  - R
  - Artificial Intelligence
  - Data Analysis
  - Training
---

Salah satu *jobdesk* saya di kantor adalah memberikan *training* ke tim
market riset tentang berbagai macam hal. Kadang saya menggunakan data
*real* dari berbagai survey yang pernah kami lakukan. Namun lebih
seringnya saya memerlukan suatu data *dummy* yang bersifat universal.

Oleh karena itu, saya biasa membuat data sintetis tersebut. Caranya
bagaimana? Tentunya dengan memanfaatkan **R**. Mudah kok, *check this
out!*

------------------------------------------------------------------------

## *Libraries* yang Diperlukan

**R** *libraries* yang digunakan pada *lefo* kali ini adalah *libraries*
yang memang sudah biasa digunakan sehari-hari, yakni:

1.  `dplyr`, `tidyr`, dan `data.table` untuk *data carpentry*.
2.  `parallel` untuk *parallel computing*.

*Library* `parallel` bersifat opsional ya. Rekan-rekan ber-OS Windows
bisa mengganti proses komputasi paralel dengan menggunakan *looping*
(`for()`) atau *vectorization* (`sapply()` atau `lapply()`).

## Data yang Akan Dibuat

Saya akan membuat data sederhana yang memuat informasi sebagai berikut:

1.  Lokasi tempat riset,
2.  *Gender*,
3.  Kelompok usia,
4.  SES (*Social Economy Status*),
5.  TOM (*Top of Mind*),
6.  *Aided awareness*,
7.  *Trial*,
8.  *Repeat*,
9.  *Last Usage*, dan
10. *Future intention*.

Saya akan membuat data survey satu per satu responden hingga sebanyak
1000 orang responden.

Untuk itu saya memerlukan *conditions* berikut ini:

- Ada **enam lokasi survey** yang memiliki proporsi merata.
- Proporsi *gender* merata (pria : wanita = 50% : 50%)
- Proporsi usia dibuat sebagai berikut:
  - `< 15 th` = 10%,
  - `16 - 20 th` = 15%,
  - `21 - 25 th` = 35%,
  - `26 - 30 th` = 20%
  - `> 30 th` = 10%
- Ada dua jenis kategori SES, yakni: *upper* dan *middle* dengan
  proporsi merata.
- TOM bagi responden *upper* memiliki peluang lebih tinggi dibandingkan
  responden *middle*.
- Hampir semua responden *upper* memiliki *aided awareness*. Sedangkan
  ada sebagian kecil responden *middle* yang tidak memiliki *aided
  awareness*.
- *Trial* bagi responden *upper* lebih tinggi dibandingkan responden
  *middle*. Tapi perlu diperhatikan bahwa ada konsistensi jawaban ke
  pertanyaan *aided awareness*. Maksudnya, jika responden tidak *aided
  awareness*, maka sudah pasti responden tersebut tidak *trial*.
- *Repeat* bagi responden *upper* lebih rendah dibandingkan responden
  *middle*. Tapi perlu diperhatikan bahwa ada konsistensi jawaban ke
  pertanyaan *trial*. Maksudnya, jika responden tidak *trial*, maka
  sudah pasti responden tersebut tidak *repeat*.
- *Last usage* bagi responden *upper* lebih tinggi dibandingkan
  responden *middle*. Tapi perlu diperhatikan bahwa ada konsistensi
  jawaban ke pertanyaan *trial*. Maksudnya, jika responden tidak
  *trial*, maka sudah pasti responden tersebut tidak *last usage*.
- *Future intention* bagi responden *upper* lebih rendah dibandingkan
  responden *middle*. Tapi perlu diperhatikan bahwa ada konsistensi
  jawaban ke pertanyaan *trial*. Maksudnya, jika responden tidak
  *trial*, maka sudah pasti responden tersebut tidak *future intention*.

*Nah*, berdasarkan *rules* di atas, kita akan buat *function* di **R**
sebagai berikut:

``` r
# dimulai dari nol
rm(list=ls())

# ambil semua library yang diperlukan
library(dplyr)
library(tidyr)
library(parallel)

# berapa banyak cores?
n_core = 7

# kita buat dulu data surveynya
# function untuk men-generate data survey per orang
survey_donk = function(dummy){
  lokasi = sample(c("a","b","c","d","e","f"),1)
  gender = sample(c("pria","wanita"),
                  1,prob = c(.5,.5))
  usia   = sample(c("< 15 th","16 - 20 th","21 - 25 th","26 - 30 th","> 30 th"),
                  1,prob = c(.1,.15,.35,.2,.1))
  ses    = sample(c("upper","middle"),1,prob = c(.5,.5),replace = T)

  # kita akan buat conditional
  # seandainya ses nya up, makan peluang tom semakin tinggi
  prob_  = ifelse(ses == "upper",.9,.6)
  prob_  = c(prob_,1-prob_)
  tom    = sample(c("ya","tidak"),1,prob = prob_)

  # kita akan buat conditional
  # seandainya ses nya up, makan peluang aided semakin tinggi
  # selain itu, jika pada tom == ya, jangan sampai aidednya menjadi tidak
  prob_  = ifelse(ses == "upper",.99,.8)
  prob_  = c(prob_,1-prob_)
  aided  = ifelse(tom == "ya","ya",
                  sample(c("ya","tidak"),1,prob = prob_))

  # kita akan buat conditional
  # seandainya ses nya up, makan peluang trial semakin tinggi
  # tapi harus inline dengan aided
  # jangan sampai dia trial tapi aided == tidak
  prob_  = ifelse(ses == "upper",.8,.5)
  prob_  = c(prob_,1-prob_)
  trial  = ifelse(aided == "tidak","tidak",
                  sample(c("ya","tidak"),1,prob = prob_))

  # kita akan buat conditional
  # seandainya ses nya up, makan peluang repeat semakin rendah
  # tapi harus inline dengan trial
  # jangan sampai dia repeat tapi trial == tidak
  prob_  = ifelse(ses == "upper",.5,.8)
  prob_  = c(prob_,1-prob_)
  repe   = ifelse(trial == "tidak","tidak",
                  sample(c("ya","tidak"),1,prob = prob_))

  # kita akan buat conditional
  # seandainya ses nya up, makan peluang last usage semakin tinggi
  # tapi harus inline dengan trial
  # jangan sampai dia last usage tapi trial == tidak
  prob_  = ifelse(ses == "upper",.8,.7)
  prob_  = c(prob_,1-prob_)
  last   = ifelse(trial == "tidak","tidak",
                  sample(c("ya","tidak"),1,prob = prob_))

  # kita akan buat conditional
  # seandainya ses nya up, makan peluang future intention semakin tinggi
  # tapi harus inline dengan trial
  # jangan sampai dia future intention tapi trial == tidak
  prob_  = ifelse(ses == "upper",.3,.9)
  prob_  = c(prob_,1-prob_)
  futur  = ifelse(trial == "tidak","tidak",
                  sample(c("ya","tidak"),1,prob = prob_))
  
  # mengeluarkan output dari function
  return(
    data.frame(lokasi,gender,usia,ses,tom,aided,trial,repe,last,futur)
  )
}
```

Setelah selesai membuat *function*-nya, mari kita *run* dan simulasikan
untuk `1000` orang responden dengan cara sebagai berikut:

``` r
# berapa banyak responden
n_resp    = 1000

# proses komputasi paralel
df_survey = mclapply(1:n_resp,survey_donk,mc.cores = n_core)

# kita gabung dalam bentuk data frame
df_survey = data.table::rbindlist(df_survey)
```

Perhatikan bahwa saya membentuk `df_survey` dengan cara melakukan
komputasi paralel dari *function* `survey_donk()`. Jika rekan-rekan
tidak bisa menggunakan komputasi paralel karena memakai OS Windows,
kalian bisa menggantinya dengan perintah:

    df_survey = lapply(1:n_resp,survey_donk)

## Hasil Simulasi

Berikut adalah sampel data hasil simulasinya:

``` r
df_survey %>% head(10) %>% knitr::kable()
```

| lokasi | gender | usia       | ses    | tom   | aided | trial | repe  | last  | futur |
|:-------|:-------|:-----------|:-------|:------|:------|:------|:------|:------|:------|
| b      | pria   | \> 30 th   | upper  | tidak | ya    | ya    | ya    | ya    | tidak |
| c      | wanita | 26 - 30 th | upper  | tidak | ya    | ya    | ya    | ya    | ya    |
| d      | pria   | 16 - 20 th | middle | ya    | ya    | ya    | ya    | ya    | ya    |
| f      | pria   | 26 - 30 th | upper  | ya    | ya    | ya    | tidak | ya    | tidak |
| e      | pria   | \< 15 th   | middle | tidak | ya    | tidak | tidak | tidak | tidak |
| e      | wanita | 21 - 25 th | upper  | ya    | ya    | tidak | tidak | tidak | tidak |
| d      | wanita | 16 - 20 th | middle | ya    | ya    | tidak | tidak | tidak | tidak |
| f      | pria   | \< 15 th   | middle | ya    | ya    | tidak | tidak | tidak | tidak |
| e      | wanita | 21 - 25 th | upper  | ya    | ya    | ya    | ya    | ya    | tidak |
| f      | wanita | 26 - 30 th | upper  | ya    | ya    | ya    | tidak | ya    | tidak |

*Bagaimana? Mudah kan?*

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
