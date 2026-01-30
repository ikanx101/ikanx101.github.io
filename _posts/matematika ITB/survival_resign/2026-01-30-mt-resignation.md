---
date: 2026-01-30T15:29:00-04:00
title: "Analisa Resignation Management Trainee di Perusahaan Tertentu"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Human Resources
  - Industri
  - Perusahaan
---

Beberapa tahun yang lalu, saya sempat diajak berdiskusi oleh salah
seorang rekan saya yang berprofesi di bidang *human resources*. Salah
satu topik diskusinya adalah *bagaimana mengukur keberhasilan program
**management trainee** yang ada di perusahaannya*.

> Rekan saya bercerita bahwa *MT* merupakan rekrutan *fresh graduate*
> yang kemudian diberikan kesempatan “berkeliling” area kerja yang ada
> di perusahaannya. Mulai dari *head office*, *plant* (pabrik), hingga
> ke *area* (luar kota sebagai *sales* atau *promotion*). Proses
> “keliling” ini berdurasi tiga bulan yang kemudian akan dievaluasi.
> Bisa jadi *MT* tersebut dipindahkan ke tempat lain atau dibiarkan
> menetap di sana. *MT* kemudian bisa diangkat menjadi karyawan tetap
> setelah dilakukan evaluasi atas kinerjanya selama setahun.

Rekan saya juga bercerita bahwa sebagian karyawan *ex-MT* kemudian
*resign* sebelum 4 tahun bekerja. Tentu dia sudah melakukan studi
kualitatif dengan melakukan *exit interview* kepada semua *MT* yang
*resign*. Namun dia ingin mendapatkan *insights* lain dengan pendekatan
lain.

Berhubung tema beberapa tulisan terakhir saya adalah tentang *survival
analysis*, maka saya akan coba lakukan analisa ini terhadap masalah
rekan saya tersebut.

------------------------------------------------------------------------

Pertama-tama, saya memiliki data 400 orang karyawan yang masuk sebagai
*MT* dari berbagai *batches*. Setiap orang di-*track* datanya selama 48
bulan dan akan dilihat berapa bulan sampai akhirnya orang tersebut
*resign*. Berikut ini adalah sampel datanya:

| id | nama | salary | dept | rotation | asal | masa_kerja | status_resign |
|---:|:---|:---|:---|---:|:---|---:|:---|
| 1 | Hernandez, Erick | Low | HQ | 3 | Kota | 9.830242 | Stay |
| 2 | Davis, Chloe | Low | Plant | 3 | Kota | 1.897667 | Stay |
| 3 | Tanabe, Michael | High | HQ | 2 | Luar kota | 48.000000 | Stay |
| 4 | Portillo, Allyvanessa | Low | Plant | 2 | Luar kota | 32.294057 | Stay |
| 5 | King, Wyatt | High | HQ | 1 | Kota | 48.000000 | Stay |
| 6 | Zerna, Danielle | High | Area | 2 | Kota | 20.356864 | Stay |
| 7 | Lesperance, Brian | High | Area | 3 | Luar kota | 36.601011 | Stay |
| 8 | Babcock, Brandon | High | Area | 1 | Luar kota | 34.891620 | Stay |
| 9 | al-Baig, Hasana | Low | HQ | 2 | Kota | 30.576687 | Stay |
| 10 | Amen, Sarah | High | Plant | 2 | Kota | 48.000000 | Stay |

Berikut adalah penjelasan setiap kolom dari data di atas:

1.  `salary` menandakan tingkat gaji bulanan karyawan tersebut. Hanya
    ada dua kategori `salary`, yakni `low` dan `high`.
2.  `dept` menandakan lokasi kerja terakhir si karyawan. Bisa jadi di
    `HQ` (*headquarter*), `plant` (pabrik), atau di `area`.
3.  `rotation` menandakan berapa kali si karyawan dirotasi lokasi kerja.
4.  `asal` menandakan asal domisili si karyawan. Apakah berasal dari
    `kota` yang sama dengan *headquarter* atau `luar kota`?
5.  `masa kerja` menandakan berapa bulan hingga si karyawan ***resign***
    atau ***stay***.

## Analisa Deskriptif

Sekarang kita akan lihat beberapa analisa deskriptif penting:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-3-1.png)

Karyawan yang saat ini di-*assign* di `area` memiliki proporsi terbesar
untuk *resign* dibandingkan lokasi kerja lainnya.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-4-1.png)

Karyawan dengan kategori *low salary* juga memiliki proporsi *resign*
besar.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-5-1.png)

Karyawan yang berasal dari kota yang sama dengan *headquarter* memiliki
kecenderungan *resign* lebih tinggi.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-6-1.png)

Semakin banyak dirotasi, karyawan akan berpeluang *resign* lebih tinggi.

Perhatikan bahwa analisa-analisa di atas adalah analisa jika setiap
variabel di-*cross* dengan *status resign*.

Saya sekarang akan mencoba menghubungkan 3 variabel sebagai berikut
sesuai dengan hipotesis dari rekan saya.

## Hipotesis I

*MT* yang berasal dari dalam `kota` dan ditempatkan di `area` punya
kecenderungan untuk *resign*.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-7-1.png)

Berdasarkan grafik di atas, kita dapatkan bahwa **semua *MT* yang
berasal dari kota dan ditempatkan di `area` (85 orang) akhirnya
*resign***.

## Hipotesis II

*MT* yang terlalu banyak dirotasi dengan *low salary* akan *resign*.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-8-1.png)

Berdasarkan grafik di atas, kita dapatkan bahwa **semua MT yang dirotasi
3 kali dengan *low salary* (sebanyak 21 orang) akhirnya *resign***.

# *Survival Analysis*

Pertama-tama, saya akan membuat model untuk semua data:

    Call: survfit(formula = surv_emp ~ 1, data = df_hr)

           n events median 0.95LCL 0.95UCL
    [1,] 400    319   26.1    22.6    29.4

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-9-1.png)

Dari analisa di atas, *median survival time* untuk *MT* adalah sekitar
26 bulan atau sekitar 2 tahun saja.

Berikut akan saya coba buat model berdasarkan kategori *salary*.

    Call: survfit(formula = surv_emp ~ salary, data = df_hr)

                  n events median 0.95LCL 0.95UCL
    salary=High 214    154   31.4      29    36.7
    salary=Low  186    165   18.3      15    21.4

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-10-1.png)

*Median survival time* untuk *MT* dengan *low salary* jauh lebih pendek
dibandingkan *higher salary*. Berikut adalah model untuk rotasi:

    Call: survfit(formula = surv_emp ~ rotation, data = df_hr)

                 n events median 0.95LCL 0.95UCL
    rotation=1 212    160   28.7    25.3    32.4
    rotation=2 133    109   24.2    20.6    30.6
    rotation=3  55     50   19.6    16.2    27.3

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-11-1.png)

*Median survival time* dari *MT* yang lebih sering dirotasi lebih
pendek. Berikut adalah model untuk asal domisili:

    Call: survfit(formula = surv_emp ~ asal, data = df_hr)

                     n events median 0.95LCL 0.95UCL
    asal=Kota      291    238   24.0    20.8    28.0
    asal=Luar kota 109     81   31.2    25.3    34.9

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/survival_resign/Draft_files/figure-commonmark/unnamed-chunk-12-1.png)

*MT* yang berasal dari kota memiliki *median survival time* terpendek.

## Faktor Penentu *Resign*

Dari data tersebut, saya akan membuat model *regresi Cox* untuk
menentukan variabel mana saja yang berpengaruh terhadap *resign* dari
*MT*.

    Call:
    coxph(formula = surv_emp ~ salary + dept + rotation + asal, data = df_hr)

      n= 400, number of events= 319 

                     coef exp(coef) se(coef)      z Pr(>|z|)    
    salaryLow      0.7303    2.0758   0.1141  6.400 1.55e-10 ***
    deptHQ        -0.8108    0.4445   0.1442 -5.622 1.89e-08 ***
    deptPlant     -0.9773    0.3763   0.1429 -6.838 8.03e-12 ***
    rotation       0.2472    1.2804   0.0810  3.052 0.002275 ** 
    asalLuar kota -0.4630    0.6294   0.1339 -3.457 0.000545 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

                  exp(coef) exp(-coef) lower .95 upper .95
    salaryLow        2.0757     0.4818    1.6598    2.5960
    deptHQ           0.4445     2.2497    0.3350    0.5897
    deptPlant        0.3763     2.6572    0.2844    0.4980
    rotation         1.2804     0.7810    1.0925    1.5007
    asalLuar kota    0.6294     1.5888    0.4841    0.8183

    Concordance= 0.655  (se = 0.015 )
    Likelihood ratio test= 93.44  on 5 df,   p=<2e-16
    Wald test            = 94.53  on 5 df,   p=<2e-16
    Score (logrank) test = 96.96  on 5 df,   p=<2e-16

Beberapa temuan dari model tersebut:

1.  **Likelihood ratio test**: 93.44 dengan 5 derajat kebebasan, dan
    *p-value* sangat kecil. Kita bisa simpulkan bahwa model secara
    keseluruhan *statistically significant*.
2.  **Variabel yang signifikan (catatan: yang memiliki *p-value* \<
    0.05):**
    1.  **salaryLow** (HR = 2.08, p = 1.55e-10)
        - *MT* dengan *low salary* memiliki risiko keluar 2.08 kali
          lebih tinggi dibanding *MT* dengan *higher salary*.
    2.  **Lokasi HQ** (HR = 0.44, p = 1.89e-08)
        - Karyawan di *headquarter* memiliki risiko keluar 56% lebih
          rendah.
    3.  **Lokasi Plant** (HR = 0.38, p = 8.03e-12)
        - Karyawan di *plant* memiliki risiko keluar 62% lebih rendah.
    4.  **Rotasi** (HR = 1.28, p = 0.0023)
        - Setiap peningkatan 1 unit rotasi meningkatkan risiko keluar
          sebesar 28%.
    5.  **Asal Luar kota** (HR = 0.63, p = 0.0005)
        - *MT* yang berasal dari luar kota memiliki risiko keluar 37%
          lebih rendah.

# *Epilog*

**Menurut keyakinan saya**, *resign* merupakan hak setiap karyawan dan
alasan yang diberikan tidak selalu harus bisa dijelaskan.


------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
