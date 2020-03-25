---
date: 2020-3-25T10:30:00-04:00
title: "Bagaimana Membedakan Flu dengan COVID-19?"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Math Modelling
  - R
  - Corona Virus
  - Covid-19
  - Modelling
  - Differential Equations
---

Kemarin teman saya bercerita bahwa ketika orang tuanya pulang dari
Eropa beberapa minggu yang lalu, mereka tiba-tiba batuk-batuk dan
demam. Dalam waktu yang relatif singkat, seisi rumah menjadi tertular
dan memiliki gejala yang sama.

Namun sekarang kondisi mereka sudah lebih baik dan beberapa sudah sembuh
seperti sediakala.

Pernah kah kalian berpikir bahwa apa yang dialami oleh teman saya tersebut mungkin saja juga dialami oleh banyak orang lain di Indonesia yang baru saja pulang dari luar negeri?

Karena disadari atau tidak, kasus 01 dan 02 sejatinya bukan kasus pertama COVID-19 di Indonesia.

Pertanyaannya:

# Apa sih perbedaan antara COVID-19 dengan flu lainnya?

Sebagai orang yang tidak memiliki latar belakang medis sama sekali, saya
tentu tidak bisa menjawab pertanyaan ini.

Sama jika Anda tidak memiliki latar belakang medis. Jangan sekali-kali
mencoba menjawab sesuatu yang bukan merupakan bidang keahlian atau
keilmuan Anda.

**TAPI…**

Setidaknya ada satu hal yang saya bisa lakukan untuk menjawab pertanyaan
ini.

> Bagaimana?

Menggunakan model matematika yang pernah saya bikin sebelumnya.

Kita bisa membandingkan seberapa cepat penyebaran **COVID-19**,
**seasonal flu**, dan **2009 flu** berdasarkan informasi **R0**-nya.

Mari kita mulai analisanya *yah* \!

# Data **R0**

Dari informasi yang dihimpun di wikipedia.org, saya mendapatkan data
terkait **R0** sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/nrc%20corona/posting_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Berdasarkan tulisan saya sebelumnya, seberapa besar **R0** ini akan
mempengaruhi ![\\beta](https://latex.codecogs.com/png.latex?%5Cbeta
"\\beta"), yakni seberapa cepat wabah menyebar.

Mari kita hitung seberapa cepat wabah penyakit ini menyebar menggunakan
**R0** untuk masing-masing penyakit.

# Simulasi Parameter dengan Monte Carlo

## Kenapa sih harus pakai simulasi Monte Carlo?

Ada masukan yang sangat berharga dari senior saya di Matematika ITB.
Beliau menyatakan bahwa pendekatan deterministik belum cukup baik untuk
memodelkan keadaan sebenarnya. Oleh karena itu, kali ini saya akan
menambahkan faktor ketidakpastian dari model deterministik yang sudah
saya bangun sebelumnya.

## Ketidakpastian yang Seperti Apa?

Pada kehidupan *real*, kita tidak tahu pasti apakah penyebarannya itu
cepat atau lambat di beberapa kondisi. Kita juga tidak tahu apsti
seberapa cepat seseorang bisa sembuh dari penyakit.

## Parameter yang Akan Disimulasikan

Dari data di atas, kita tahu bahwa nilai **R0** berada dalam *range*
tertentu. Kali ini saya akan menggunakan simulasi Monte Carlo untuk
*generate various number of* **R0** agar didapat selang estimasi dari
model yang ada.

Selain itu, kecepatan seseorang bisa menjadi sehat juga akan dilakukan
simulasi Monte Carlo.

Akan dilakukan simulasi sebanyak `5000` kali untuk ketiga tipe penyakit
di atas.

*Goals* dari model ini adalah menghitung **berapa lama wabah menyebar
sehingga semua orang sehat tertular**.

## Asumsi yang digunakan

Saya akan menggunakan contoh kondisi di tempat kerja saya agar bisa
lebih mudah bagi kalian membayangkannya.

1.  Misalnya di suatu ruangan kantor ada total `18` orang. Pada hari ke
    `0`, salah seorang dari kami sakit.
2.  Oleh karena semua penyakit ini adalah berasal dari varian virus flu,
    maka semua orang akan sembuh dengan sendirinya pada *range* hari ke
    `14` - `21`. *Notes*: parameter ini juga akan dilakukan simulasi
    Monte Carlo.
3.  Tidak ada orang sakit yang meninggal.
4.  Semua orang dalam populasi berinteraksi seperti biasa (tidak ada
    karantina, orang sakit tidak mengenakan masker, dan orang sakit
    masih masuk kerja).

### **COVID-19**

``` r
covid = function(n){
  n
  r_nol = seq(1.4,3.9,by=.1)
  r_nol = sample(r_nol,1)
  gamm = sample(c(14:21),1)
  gamm = 1/gamm
  beta = r_nol * gamm
  temp = sir_model(18,1,14,beta,gamm)
  hari = temp %>% filter(S<0.5) %>% summarise(min(time))
  hari = as.numeric(hari)
  return(hari)
}

simulasi = data.frame(id=c(1:5000))
simulasi$hari_covid = sapply(simulasi$id,covid)
```

### **Seasonal Flu**

``` r
seasonal = function(n){
  n
  r_nol = seq(.9,2.1,by=.1)
  r_nol = sample(r_nol,1)
  gamm = sample(c(14:21),1)
  gamm = 1/gamm
  beta = r_nol * gamm
  temp = sir_model(18,1,14,beta,gamm)
  hari = temp %>% filter(S<0.5) %>% summarise(min(time))
  hari = as.numeric(hari)
  return(hari)
}

simulasi$hari_seasonal = sapply(simulasi$id,seasonal)
```

### **Swine Flu**

``` r
flu = function(n){
  n
  r_nol = seq(1.4,1.6,by=.1)
  r_nol = sample(r_nol,1)
  gamm = sample(c(14:21),1)
  gamm = 1/gamm
  beta = r_nol * gamm
  temp = sir_model(18,1,14,beta,gamm)
  hari = temp %>% filter(S<0.5) %>% summarise(min(time))
  hari = as.numeric(hari)
  return(hari)
}

simulasi$hari_flu = sapply(simulasi$id,flu)
```

## Hasil Simulasi

Dari simulasi yang dilakukan di atas, berikut adalah hasilnya:

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/nrc%20corona/posting_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

# Kesimpulan

Hasil grafik di atas seiring sejalan dengan *range* nilai **R0** yang
ada.

  - **COVID-19** lebih cepat menyebar dibandingkan dua jenis flu
    lainnya.
      - Pada hari ketiga dan keempat, peluang kumulatif-nya sudah hampir
        mencapai angka hampir `70%`. Semua orang berpeluang besar sudah
        terkena penyakit ini.
  - Sedangkan varian flu lainnya relatif lebih lambat penyebarannya.

Apakah dari uraian di atas kita bisa menyimpulkan sesuatu?
