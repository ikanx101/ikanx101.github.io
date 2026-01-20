---
date: 2026-01-20T09:32:00-04:00
title: "Memodelkan Customer Churn Menggunakan Survival Analysis"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Statistika
  - Prediksi
  - Survival Analysis
  - Analysis
  - Analyst
  - Survival
  - Customer
  - Customer Churn
  - Sales
  - Marketing
  - Streaming
---

Pada tulisan kali ini saya akan melanjutkan satu topik yang sama dengan
[tulisan sebelumnya](https://ikanx101.com/blog/surv-lamp/), yakni
*survival analysis*. Saya akan memberikan satu contoh bagaimana
*survival analysis* bisa digunakan untuk memodelkan *customer churn*
untuk suatu *platform* layanan *streaming*. Untuk menyederhanakan
masalah (tanpa mengurangi kompleksitas), saya akan buat data *dummy*
yang punya batasan-batasan tertentu.

------------------------------------------------------------------------

## *Study Case* *Platform Layanan Streaming*

Misalkan saya membuat suatu layanan *platform* *streaming* film dan
hendak mencari tahu kapan *customer* saya akan “hilang” (berhenti
berlangganan) dan apa penyebabnya. Data yang saya miliki adalah seperti
ini:

Saya mengumpulkan 100 data bulanan *customer* sejak Januari 2023 hingga
Desember 2025. Pada rentang tersebut, saya mengambil:

1.  ***Usage***; rata-rata jam menonton per bulan.
2.  **Umur** *customer*,
3.  **Promo**; apakah saat pertama kali *customer* berlangganan
    dikarenakan promo diskon atau harga normal.
4.  **Komplain**; apakah *customer* pernah komplain atau tidak selama
    rentang waktu tersebut.
5.  ***Tenure***; pada bulan ke berapa *customer* berhenti berlangganan.
    Jika sampai Desember 2025 *customer* tetap bertahan, maka nilainya
    diisi **24**.
6.  ***Churn***; status akhir *customer*. Apakah *churn* (`1`) atau
    tidak *churn* (`2`).

Berikut ini adalah sampel data yang saya kumpulkan:

|     | umur | usage | promo        | komplain            |    tenure | churn |
|:----|-----:|------:|:-------------|:--------------------|----------:|------:|
| 65  |   39 |    34 | Harga_Normal | Tak_Pernah_Komplain | 19.538152 |     1 |
| 87  |   39 |     9 | Harga_Normal | Pernah_Komplain     |  1.750255 |     1 |
| 26  |   52 |    47 | Harga_Normal | Tak_Pernah_Komplain | 12.372338 |     1 |
| 2   |   40 |    25 | Diskon       | Tak_Pernah_Komplain |  4.688223 |     1 |
| 81  |   38 |    31 | Harga_Normal | Pernah_Komplain     | 12.017675 |     1 |
| 78  |   35 |    10 | Diskon       | Tak_Pernah_Komplain |  1.201922 |     1 |
| 74  |   24 |    10 | Harga_Normal | Tak_Pernah_Komplain |  1.238411 |     1 |
| 57  |   23 |    36 | Diskon       | Tak_Pernah_Komplain |  9.698184 |     1 |
| 3   |   54 |     8 | Diskon       | Tak_Pernah_Komplain |  4.077117 |     1 |
| 93  |   31 |    35 | Diskon       | Tak_Pernah_Komplain |  1.047004 |     1 |
| 50  |   58 |    46 | Diskon       | Tak_Pernah_Komplain |  7.264625 |     1 |
| 28  |   26 |    43 | Diskon       | Pernah_Komplain     |  4.788013 |     1 |
| 10  |   29 |    19 | Harga_Normal | Tak_Pernah_Komplain | 16.460707 |     1 |
| 1   |   55 |    27 | Diskon       | Tak_Pernah_Komplain | 18.562601 |     1 |
| 47  |   25 |    48 | Harga_Normal | Tak_Pernah_Komplain | 15.274502 |     1 |

Sekarang saya akan membuat kurva *survival* sebagai berikut:

    Call: survfit(formula = surv_obj ~ 1, data = data_marketing)

           n events median 0.95LCL 0.95UCL
    [1,] 100     89    7.3    5.92     9.7

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_stream/draft_files/figure-commonmark/unnamed-chunk-4-1.png)

Saya dapatkan *median survival time* sebesar **7.3 bulan**. Artinya pada
waktu median tersebut, 50% dari *customer* mulai berhenti berlangganan.

Sekarang dari variabel-variabel yang ada, saya akan tentukan variabel
mana saja yang paling berpengaruh untuk *customer churn*. Saya
menggunakan **regresi Cox** dan menghitung ***hazard ratio***.

> ***Hazard ratio*** (HR) adalah ukuran efek yang digunakan dalam
> analisis regresi Cox untuk membandingkan risiko kegagalan (atau
> kejadian tertentu) antara kelompok independen pada titik waktu
> tertentu.

Secara matematis, **HR** merupakan eksponensial dari koefisien regresi
yang dihasilkan. Interpretasi nilai **HR** adalah sebagai berikut:

- HR = 1: Prediktor tidak mempengaruhi *survival* (tidak ada perbedaan
  risiko antar kelompok).
- HR \> 1: Prediktor dikaitkan dengan peningkatan risiko kejadian atau
  penurunan peluang *survival*.
- HR \< 1: Prediktor bersifat protektif, yang berarti dikaitkan dengan
  peningkatan peluang *survival* atau penurunan risiko kejadian.

Berikut adalah hasil regresinya:

``` r
fit_cox <- coxph(surv_obj ~ promo + umur + usage + komplain, data = data_marketing)
broom::tidy(fit_cox,exponentiate = T) %>% knitr::kable()
```

| term                        |  estimate | std.error | statistic |   p.value |
|:----------------------------|----------:|----------:|----------:|----------:|
| promoHarga_Normal           | 0.5852611 | 0.2238590 | -2.393012 | 0.0167107 |
| umur                        | 1.0135940 | 0.0087016 |  1.551726 | 0.1207279 |
| usage                       | 1.0282483 | 0.0088355 |  3.152813 | 0.0016171 |
| komplainTak_Pernah_Komplain | 0.6254627 | 0.2880846 | -1.628909 | 0.1033322 |

Berdasarkan hasil regresi di atas, saya dapatkan dua variabel memiliki
koefisien yang **signifikan**. Terlihat dari nilai *p-value* yang
dibawah **0.05**. Kedua variabel tersebut adalah:

1.  Promo **harga normal** dengan **HR** sebesar **0.585**. Artinya
    variabel ini merupakan variabel **protektif** yang meningkatkan
    peluang *survival* dari *customer*.
    - *Customer* dengan harga normal memiliki risiko *churn* **41.5%**
      lebih rendah dibandingkan dengan *customer* diskon
2.  ***Usage*** dengan **HR** sebesar **1.028**.
    - Setiap peningkatan 1 unit dalam *usage* meningkatkan risiko
      *churn* sebesar 2.8%.
    - Strategi yang harus saya lakukan adalah fokus pada *customer*
      dengan *usage* tinggi.

Sebagai analisa lebih lanjut, saya akan *cross* kurva *survival* dengan
variabel **promo** dan variabel **komplain**.

``` r
surv_obj <- Surv(time = data_marketing$tenure, event = data_marketing$churn)
fit_km <- survfit(surv_obj ~ promo, data = data_marketing)
ggsurvplot(fit_km, 
           data = data_marketing,
           pval = TRUE,             # P-value Log-rank test [15, 16]
           conf.int = TRUE, 
           risk.table = TRUE,
           xlab = "Bulan Berlangganan",
           ylab = "Probabilitas Retensi Customer",
           title = "Kurva Retensi: Diskon vs Harga Normal")
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_stream/draft_files/figure-commonmark/unnamed-chunk-6-1.png)

Dari grafik di atas, kita bisa lihat bahwa *customer* yang berlangganan
berasal dari promo diskon memiliki waktu *survival* yang lebih singkat
dibandingkan *customer* yang berasal dari harga normal.

``` r
fit_km <- survfit(surv_obj ~ komplain, data = data_marketing)
ggsurvplot(fit_km, 
           data = data_marketing,
           pval = TRUE,             # P-value Log-rank test [15, 16]
           conf.int = TRUE, 
           risk.table = TRUE,
           xlab = "Bulan Berlangganan",
           ylab = "Probabilitas Retensi Customer",
           title = "Kurva Retensi: Pernah vs Tidak pernah komplain")
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_stream/draft_files/figure-commonmark/unnamed-chunk-7-1.png)

Dari grafik di atas, kita bisa dapatkan *customer* yang pernah komplain
memiliki waktu *survival* yang lebih singkat dibandingkan *customer*
yang tidak pernah komplain. Oke, sekarang saya akan coba membuat
beberapa langkah strategis untuk menurunkan *customer churn*.

## Langkah Strategis untuk Menurunkan *Customer Churn*

### Segmentasi Pelanggan Berisiko Tinggi

Salah satu kelebihan *regresi cox*, kita bisa menghitung *risk score*
dari masing-masing *customer*. Akibatnya kita bisa membagi *customer*
berdasarkan sebaran *risk score* tersebut.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_stream/draft_files/figure-commonmark/unnamed-chunk-8-1.png)

    # A tibble: 3 × 5
      risk_category     n avg_usage promo_discount_pct churn_rate
      <chr>         <int>     <dbl>              <dbl>      <dbl>
    1 Low Risk         50      19.2                 24         80
    2 Medium Risk      25      31.0                 60         96
    3 High Risk        25      41.1                 68        100

*Customer* yang memiliki masuk ke dalam kelompok *high risk* memiliki
rata-rata *usage* tinggi dan berasal dari promo diskon. Maka khusus
*customer* selanjutnya (di masa depan) dengan karakteristik seperti ini,
saya bisa membuat program retensi khusus.

- **Program *Loyalty***: Konversi dari diskon sementara ke program
  loyalitas permanen.
- ***Upselling***: Tawarkan produk/layanan tambahan dengan nilai lebih.
- ***Personalized Engagement***: Kontak proaktif sebelum masa diskon
  berakhir.
- Untuk pengguna dengan *usage* tinggi:
  - ***Onboarding* Intensif**: Pastikan mereka memahami semua fitur
    produk.
  - **Success Management**: *Assign customer success manager* untuk
    pengguna berat.
  - **Feedback Loop**: Kumpulkan *feedback* untuk meningkatkan
    pengalaman.

Setelah itu, kita perlu mengetahui *timing* yang pas untuk melakukan
intervensi kepada *customer*. Dari *survival curve* yang ada di atas,
saya bisa dapatkan *survival median time* berikut:

    # A tibble: 2 × 3
      promo        median_survival q25_survival
      <chr>                  <dbl>        <dbl>
    1 Diskon                  4.69         1.14
    2 Harga_Normal            8.16         3.22

Dari sini saya membuat program pencegahan proaktif yang disesuaikan
dengan *survival time*:

1.  **Bulan 1-3** (*Tenure* rendah) *onboarding* intensif.
2.  **Bulan 3-6**: *Check-in* pertama, tawarkan bantuan.
3.  **Bulan 6-12**: Program loyalitas untuk pelanggan diskon.
4.  **\>12 bulan**: Program retensi untuk pengguna berat.

## **Kesimpulan Strategis:**

Berdasarkan analisis *regresi Cox*, **fokus utama harus pada**:

1.  **Pelanggan diskon dengan usage tinggi** - *Segment* paling
    berisiko.
2.  **Intervensi pada bulan 3-6** - Periode kritis berdasarkan *tenure*.
3.  **Konversi dari diskon ke program loyalitas** - Kurangi
    ketergantungan pada diskon.

**Actionable Insight**: Setiap peningkatan 10 unit dalam *usage*
meningkatkan risiko *churn* sebesar 28%. Prioritaskan pengguna dengan
*usage* \> 30 untuk program retensi khusus.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
