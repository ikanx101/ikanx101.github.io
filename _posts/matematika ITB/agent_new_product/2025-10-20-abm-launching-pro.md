---
date: 2025-10-20T09:39:00-04:00
title: "Agent Based Modelling untuk Memodelkan Konsumen Saat Launching Produk"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Marketing
  - Sales
  - Agent Based Modelling
  - Product Launching
  - Smartphone
---

Beberapa malam yang lalu, saya melihat kembali video presentasi Steve
Jobs saat pertama kali memperkenalkan iPhone. Saya bertanya-tanya,
apakah pada saat itu Apple sudah memprediksi bahwa kemunculan iPhone
ternyata mengubah *landscape* pasar *smartphone*. Setiap kali produk
baru *launching* di *market*, salah satu analisa yang biasa dilakukan
adalah memprediksi apakah produk tersebut akan laku atau tidak. Ada
berbagai pendekatan dan metode untuk melakukan analisa ini. Namun
berdasarkan pengalaman saya, [*agent based
modelling*](https://ikanx101.com/blog/simple-economy/) sangat jarang
digunakan.

*Nah*, kali ini saya hendak menggunakan *agent based modelling* untuk
memodelkan perilaku konsumen saat suatu produk *launching*. Untuk
memudahkan penjelasan, saya akan membuat beberapa asumsi dan kondisi
tertentu.

------------------------------------------------------------------------

## Simulasi *Launching* Produk Baru

Misalkan suatu produk *smartphone* dengan harga *high-end* hendak
*launching* di pasaran. Di *market* ada 10.000 orang konsumen dengan
profil yang berbeda-beda. Konsumen memutuskan untuk membeli *smartphone*
tersebut berdasarkan pengaruh sosial, preferensi pribadi, dan strategi
pemasaran.

### Desain Agen

Setiap agen merepresentasikan satu konsumen dengan atribut:

- **Preferensi konsumen terhadap produk**: tinggi, sedang, rendah.
- **Daya beli**: mampu beli atau tidak.
- **Pengaruh sosial**: seberapa besar dipengaruhi oleh agen lain.
- **Status adopsi**: belum beli, tertarik, sudah beli.

### *Environment* Simulasi

- **Jumlah konsumen (agen)**: 10.000 orang.
- **Interaksi sosial**: agen bisa melihat keputusan 10 agen lainnya
  (seperti teman-teman pada dunia nyata). Jika konsumen melihat 10
  temannya membeli, maka akan meningkatkan peluang konsumen tersebut
  untuk ikut membeli *smartphone*.
- **Waktu simulasi**: 30 hari.
- **Strategi pemasaran**: Akan dilakukan diskon pada tiga hari
  berturut-turut pada hari ke 10, 11, dan 12. Diharapkan diskon tersebut
  akan meningkatkan peluang konsumen membeli *smartphone*.

### Aturan Simulasi

1.  Agen dengan preferensi tinggi dan daya beli cenderung membeli lebih
    cepat.
2.  Agen yang melihat \> 10 tetangga sudah membeli akan lebih tertarik.
3.  Diskon meningkatkan kemungkinan beli sebesar 10 - 20%.

Hal yang akan saya amati dari simulasi ini adalah:

- Jumlah agen yang membeli per hari.
- Efek diskon dan iklan terhadap lonjakan pembelian.
- Visualisasi jaringan pengaruh sosial.

------------------------------------------------------------------------

## Implementasi di **R**

Saya akan membuat kode **R** untuk melakukan simulasi ini. Pertama-tama
saya akan definisikan berapa banyak agen dan hari.

``` r
# Jumlah agen dan hari simulasi
num_agents <- 10000
num_days   <- 30
```

Sekarang saya akan mendefinisikan beberapa atribut untuk semua agen.

``` r
# Inisialisasi atribut agen
preferensi      <- sample(c("tinggi", "sedang", "rendah"), 
                          num_agents, 
                          replace = TRUE, 
                          prob = c(0.1, 0.5, 0.4))
daya_beli       <- sample(c(TRUE, FALSE), num_agents, replace = TRUE, prob = c(.9,.1))
pengaruh_sosial <- runif(num_agents, 0.01, 0.5)
status          <- rep("belum_beli", num_agents)

# Data frame untuk menyimpan data pengaruh sosial
pengaruh_data <- data.frame(
  Hari = integer(),
  Rata_rata_Pengaruh = numeric(),
  SD_Pengaruh = numeric(),
  Min_Pengaruh = numeric(),
  Max_Pengaruh = numeric(),
  Total_Pembeli = integer(),
  Pembelian_Hari = integer()
)

# Fungsi probabilitas beli
probabilitas_beli <- function(pref, pengaruh, tetangga_beli, hari) {
  base_prob <- switch(pref,
                      "tinggi" = runif(1,.2,.3),
                      "sedang" = runif(1,.1,.2),
                      "rendah" = runif(1,.05,.1))
  base_prob <- base_prob + pengaruh * (tetangga_beli / 10)
  if (hari == 10) base_prob <- base_prob + runif(1,.1,.2)
  if (hari == 11) base_prob <- base_prob + runif(1,.1,.2)
  if (hari == 12) base_prob <- base_prob + runif(1,.1,.2)
  return(min(base_prob, 1))
}
```

Saatnya saya *run* simulasinya!

``` r
# Simulasi dengan penyimpanan data pengaruh
pembelian_per_hari <- numeric(num_days)
pengaruh_pembeli_harian <- list()

for (hari in 1:num_days) {
  pembelian_hari_ini <- 0
  pengaruh_pembeli <- numeric(0)
  
  for (i in 1:num_agents) {
    if (status[i] == "belum_beli" && daya_beli[i]) {
      tetangga <- sample(1:num_agents, 10)
      tetangga_beli <- sum(status[tetangga] == "sudah_beli")
      prob <- probabilitas_beli(preferensi[i], pengaruh_sosial[i], tetangga_beli, hari)
      
      if (runif(1) < prob) {
        status[i] <- "sudah_beli"
        pembelian_hari_ini <- pembelian_hari_ini + 1
        pengaruh_pembeli <- c(pengaruh_pembeli, pengaruh_sosial[i])
      }
    }
  }
  
  pembelian_per_hari[hari] <- pembelian_hari_ini
  pengaruh_pembeli_harian[[hari]] <- pengaruh_pembeli
  
  # Simpan statistik pengaruh sosial
  if (length(pengaruh_pembeli) > 0) {
    pengaruh_data <- rbind(pengaruh_data, data.frame(
      Hari = hari,
      Rata_rata_Pengaruh = mean(pengaruh_pembeli),
      SD_Pengaruh = sd(pengaruh_pembeli),
      Min_Pengaruh = min(pengaruh_pembeli),
      Max_Pengaruh = max(pengaruh_pembeli),
      Total_Pembeli = sum(status == "sudah_beli"),
      Pembelian_Hari = pembelian_hari_ini
    ))
  } else {
    pengaruh_data <- rbind(pengaruh_data, data.frame(
      Hari = hari,
      Rata_rata_Pengaruh = 0,
      SD_Pengaruh = 0,
      Min_Pengaruh = 0,
      Max_Pengaruh = 0,
      Total_Pembeli = sum(status == "sudah_beli"),
      Pembelian_Hari = pembelian_hari_ini
    ))
  }
}
```

Simulasi sudah selesai. Sekarang saya akan lakukan beberapa analisa
sebagai berikut:

Pertama-tama saya akan melihat berapa banyak agen yang akhirnya membeli:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent_new_product/post_files/figure-commonmark/unnamed-chunk-5-1.png)

Sekitar **`90%`** dari agen akhirnya membeli *smartphone* tersebut
sementara **10%** lainnya belum membeli hingga pada hari ke 30. Kita
bisa meihat pembagian konsumen yang saya *generate* sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent_new_product/post_files/figure-commonmark/unnamed-chunk-6-1.png)

Ternyata **972** agen tidak membeli *smartphone* karena memang bukan
merupakan target marketnya. Alasannya adalah agen-agen tersebut **tidak
memiliki daya beli**. Sementara ada **12** agen yang termasuk *late
adapter* belum sempat membeli *smartphone*. Sekarang saya akan membuat
grafik berapa banyak agen yang membeli *smartphone* per hari.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent_new_product/post_files/figure-commonmark/unnamed-chunk-7-1.png)

Terlihat dari grafik di atas bahwa pembelian terbanyak terjadi pada saat
3 hari pertama. Setelah itu pembelian mulai melambat. Periode diskon
pada hari ke 10-12 sedikit mendongkrak pembelian kemudian melambat lagi.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent_new_product/post_files/figure-commonmark/unnamed-chunk-8-1.png)

Grafik di atas memperlihatkan kumulatif banyaknya agen yang membeli
*smartphone* selama periode 30 hari. Banyaknya agen yang membeli mulai
*saturated* pada hari ke 13 - 14. Sekarang saya akan memperlihatkan
berapa besar pengaruh orang lain terhadap keputusan pembelian si agen.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent_new_product/post_files/figure-commonmark/unnamed-chunk-9-1.png)

Jika dilihat, pengaruh sosial terbesar terjadi pada 10 hari pertama
*launching*. Setelah itu, karena **pembeli sudah *saturated*, maka
pengaruh sosial menjadi turun dan hilang**.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent_new_product/post_files/figure-commonmark/unnamed-chunk-10-1.png)

## Kesimpulan

*Agent based modelling* bisa menjadi salah satu *tools* untuk memetakan
strategi *marketing sales* saat produk pertama kali *launching*. Model
di atas bisa disempurnakan lagi dengan menambahkan beberapa asumsi dan
interaksi yang ada.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
