---
date: 2026-09-11T09:57:00-01:00
title: "Bagaimana Cara Menganalisa Dua Data yang Berbeda Level dengan Metode Denton?"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Denton
  - Statistika
  - Korelasi
---

Sebagai _market researcher_, hampir tiap bulan saya menemui masalah yang sama, yaitu: 

> _Report brand awareness_ yang diberikan kepada manajemen angkanya didapatkan secara **tahunan** (hasil survei besar yang cuma dilakukan setahun sekali). Sementara itu, kami juga melakukan riset _advertising awareness_ di setiap kuartal. Selain itu, tim _sales_ juga punya angka penjualan **kuartalan** juga. 

__Tiga sumber data, tiga frekuensi, dan semuanya ingin "disambungkan" jadi satu cerita yang koheren: Apakah ada korelasi antara _awareness_ iklan dengan *sales value*?__

Hal yang menjadi masalah adalah angka _awareness_ tahunan ini lebih dipercaya karena sampelnya lebih besar, metodologinya lebih ketat tapi **terlalu kasar untuk dianalisis menjadi level bulan-ke-bulan atau kuartal-ke-kuartal**. Sementara data _ads awareness_ dalam kuartalan lebih granular tapi didapatkan dari sampel responden yang relatif kecil sehingga kurang bisa dipercaya secara absolut.

Lantas bagaimana caranya agar kita bisa membuat data _ads awareness_ menjadi lebih terpercaya dan bisa dikorelasikan dengan _sales value_?

Ada satu teknik statistik lama bernama **metode Denton** yang didesain khusus untuk masalah ini. Tulisan ini adalah rangkuman eksperimen saya belajar metode ini dari nol.

## Apa Itu Metode Denton?

Metode Denton pertama kali diperkenalkan oleh Frank Denton di tahun 1971, lalu disempurnakan oleh Cholette (jadi dikenal sebagai **Denton-Cholette**) untuk memperbaiki bias di titik awal data. Metode ini masuk kategori **temporal disaggregation**, yakni teknik untuk memecah data frekuensi rendah jadi frekuensi tinggi, dengan bantuan data lain yang lebih granular.

Konsepnya begini: Misalkan ada dua data:

1. **Benchmark**: data frekuensi rendah (misal tahunan) yang levelnya dipercaya akurat.
2. **Indicator**: data frekuensi tinggi (misal kuartalan) yang bentuk/pola pergerakannya masuk akal, tapi levelnya belum tentu presisi.

Tujuannya: menghasilkan data kuartalan yang:

- Kalau dirata-rata atau dijumlahkan per tahun, hasilnya sama persis dengan benchmark, dan
- Bentuk kurvanya mengikuti pola _indicator_ semirip mungkin.

Kenapa tidak pakai cara paling gampang? Saya bisa saja menghitung _pro-rata_ biasa. Cukup skalakan _indicator_ supaya rata-ratanya cocok dengan _benchmark_ di tahun itu.

Tapi masalahnya adalah jika kita melakukan _pro-rata_, akan muncul **"step problem"**: setiap tahun diskalakan sendiri-sendiri, jadi di titik pergantian tahun (Desember ke Januari) bisa muncul lompatan yang tidak natural, padahal secara bisnis tidak ada alasan _awareness_ tiba-tiba melompat cuma karena kalender berganti tahun. 

_Denton method_ menyelesaikan ini sebagai **masalah optimisasi**: meminimalkan selisih pergerakan periode-ke-periode antara hasil akhir dengan _indicator_, dengan syarat totalnya harus cocok dengan _benchmark_. Hasilnya kurva yang mulus, tanpa lompatan artifisial.

Ada dua pilihan penting yang harus ditentukan sebelum menjalankan Denton:

- **Additive vs Proportional**: _additive_ meminimalkan selisih level absolut, _proportional_ meminimalkan selisih rasio/persentase. _Proportional_ lebih disukai karena mempertahankan pola *growth rate* _indicator_, dan ini yang direkomendasikan IMF dan Eurostat untuk statistik resmi.
- **Conversion: `sum` vs `average`**: kalau datanya *flow* (misal penjualan, di mana total tahunan = jumlah 4 kuartal), pakai `sum`. Kalau datanya *stock/index* seperti persentase _awareness_ (di mana rata-rata 4 kuartal harus sama dengan angka tahunan, bukan dijumlahkan), pakai `average`.


## Studi Kasus: _Brand Awareness vs Sales_

Supaya rekan-rekan semua mendapatkan gambaran _real_, saya akan gunakan _case study_ yang terjadi di tempat saya kerja. Misalkan saya punya tiga _datasets_ sebagai berikut:

1. **Brand awareness TAHUNAN** (2021–2025), 5 titik data yang akan menjadi *benchmark*.
2. **Ad awareness survey KUARTALAN** (Q1 2021–Q4 2025), 20 titik data yang akan menjadi *indicator*.
3. **Sales KUARTALAN** (Q1 2021–Q4 2025), 20 titik data.

Berikut adalah data _benchmark_ tahunan:

| Tahun | Brand Awareness (%) |
|---|---|
| 2021 | 76.21 |
| 2022 | 70.36 |
| 2023 | 77.73 |
| 2024 | 82.72 |
| 2025 | 73.71 |

## Alur Pengerjaan

Biar gampang diikuti, begini alur analisisnya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post19_denton/plots/07_diagram_alur_denton.png)

Tiga data masuk di awal (_benchmark_ tahunan, _indicator_ kuartalan, _sales_ kuartalan). _Benchmark_ dan _indicator_ masuk ke mesin Denton-Cholette untuk menghasilkan _awareness_ kuartalan. Hasilnya lalu diuji korelasinya dengan _sales_ (dengan berbagai skenario _lag_), dan berujung ke _insight_ yang divisualisasikan.

## Menjalankan Denton-Cholette di __R__

_Package_ yang saya pakai adalah `tempdisagg` dengan fungsi `td()`. Karena _awareness_ itu persentase maka saya pakai `conversion = "average"` dan pakai `criterion = "proportional"` supaya pola pergerakan _indicator_ terjaga:

```r
library(tempdisagg)

denton_model <- td(
  annual_awareness_ts ~ 0 + ad_awareness_ts,
  conversion = "average",
  method     = "denton-cholette",
  criterion  = "proportional"
)

denton_result_ts <- predict(denton_model)
```

Berikut adalah gambaran data mentahnya, yakni _benchmark_ tahunan (garis putus merah) dan _indicator_ kuartalan (garis biru):

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post19_denton/plots/01_raw_benchmark_vs_indicator.png)

Sekarang bandingkan nilai persentasenya hasil perhitungan Denton-Cholette dengan metode _pro-rata_ naif (skala _indicator_ per tahun tanpa _smoothing_ lintas-tahun):

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post19_denton/plots/02_denton_vs_naive_prorate.png)

Di grafik ini keduanya kelihatan cukup mirip karena _indicator_ saya sendiri sudah relatif mulus, tapi kalau diperhatikan baik-baik di beberapa titik pergantian tahun, garis oranye (pro-rata naif) melompat sedikit lebih tajam dibanding garis biru (Denton). Hal ini bibit _"step problem"_ yang saya sebutkan di atas. Semakin kasar/musiman _indicator_-nya, semakin kelihatan bedanya.

Hasil akhirnya, _brand awareness_ kuartalan yang sudah direkonsiliasi dengan _benchmark_ tahunan:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post19_denton/plots/03_denton_final_result.png)

Saya cek juga konsistensinya. Rata-rata 4 titik kuartalan tiap tahun hasil final Denton harus sama persis dengan angka _benchmark_ tahunan:

| Tahun | Benchmark | Rata-rata Denton | Selisih |
|---|---|---|---|
| 2021 | 76.21 | 76.21 | 0 |
| 2022 | 70.36 | 70.36 | 0 |
| 2023 | 77.73 | 77.73 | 0 |
| 2024 | 82.72 | 82.72 | 0 |
| 2025 | 73.71 | 73.71 | 0 |

Cocok sampai angka desimal, _constraint_ ini yang membedakan Denton dari sekadar *smoothing* biasa.

## Menyambungkan ke _Sales_: Korelasi _Spearman_ dan Efek _Lag_

Ini adalah analisis lanjutan yang saya lakukan untuk lihat apakah hasil disagregasi _awareness_ ini "berbunyi" secara bisnis kalau dibandingkan dengan _sales value_. Saya pakai korelasi **Spearman** (bukan Pearson) karena:

1. Saya tidak mau asumsi hubungannya harus linear.
1. _Spearman_ cuma menguji apakah hubungannya monoton (naik-naik atau turun-turun bareng).
1. Lebih tahan terhadap _outlier_ di data kuartalan yang jumlah titiknya sedikit.

Lalu saya tambahkan beberapa skenario _lag_, mulai dari 0 _lag_ (serentak) hingga _lag = 3_ (mundur 3 kuartal).

Hasilnya:

| _Lag_ | _rho Spearman_ | _p-value_ | Signifikansi |
|---|---|---|---|
| 0 (serentak) | 0.18 | 0.448 | tidak signifikan |
| **1 kuartal** | **0.81** | **2.36e-05** | **signifikan** |
| 2 kuartal | 0.13 | 0.601 | tidak signifikan |
| 3 kuartal | 0.03 | 0.922 | tidak signifikan |

Berikut adalah visualisasi _scatter plot_ untuk keempat skenario _lag_:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post19_denton/plots/04_awareness_vs_sales.png)

Kalau distandardisasi (`z-score`) dan di-_plot_ sebagai _time series_, pola _lag_-nya kelihatan jelas. Puncak dan lembah garis merah (_sales value_) konsisten menyusul puncak atau lembah garis biru (_awareness_) satu kuartal kemudian:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post19_denton/plots/05_awareness_sales_timeseries_lag.png)

Dan kalau semua _rho_ itu diringkas jadi satu grafik _cross-correlation_, _lag_ optimalnya kelihatan sangat tajam di _lag = 1_:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post19_denton/plots/06_cross_correlation_by_lag.png)

Korelasi serentak (lag-0) lemah dan tidak signifikan (rho=0.18, p=0.448), kesimpulannya _"awareness tidak ada hubungannya sama sales"_. Untungnya diuji sampai _lag = 3_. Sehingga sinyalnya nongol jelas di _lag = 1_ (rho=0.81, p<0.0001), lalu meluruh lagi di _lag = 2_ dan _lag = 3_. 

> Ini pelajaran penting: **jangan berhenti di korelasi serentak saja** kalau menganalisis dua metrik _marketing_. Biasanya efeknya sering butuh waktu untuk terlihat.

## Apakah _Lag_ 1 Kuartal Ini Wajar di Dunia Nyata?

_Study case_ di atas adalah menggunakan data sintesis yang terinspirasi dari kejadian nyata di tempat saya bekerja saat ini. Hal yang paling menantang dari hasil analisa di atas adalah pertanyaan:

> _Apakah _lag = 1_ kuartal ini wajar di dunia nyata?_

Ini pertanyaan yang menurut saya lebih penting daripada nilai _rho_ dan _p-value_. Pada simulasi ini, + memang **sengaja saya rancang** saat saya membuat data sintetis. TAPI **kalau pola seperti ini muncul di data asli, apakah masuk akal secara bisnis, dan argumen apa yang bisa dipakai untuk menjelaskannya?**

### Argumen yang mendukung "wajar"

1. **Siklus pembelian kategori (purchase cycle).** Jika secara sifat produk ini tidak dibeli tiap hari/minggu tapi punya siklus _re-purchase_ 1–3 bulan, maka meskipun _awareness_ naik hari ini, transaksi baru terjadi di siklus beli berikutnya (satu kuartal kemudian).
2. **Considered purchase journey.** Untuk kategori dengan keterlibatan tinggi (elektronik, otomotif, produk finansial, B2B), perjalanan dari _awareness_ merek sampai keputusan beli memang bisa memakan waktu berminggu-minggu sampai berbulan-bulan.
3. **Kalender media dan _flighting_ kampanye.** Banyak _brand_ sengaja membangun _awareness_ satu kuartal sebelum periode penjualan besar. Misalkan mereka melakukan _campaign_ di Q3 untuk menyongsong lonjakan penjualan di akhir tahun. Di sini _lag_ bukan murni perilaku konsumen tapi memang **hasil desain perencanaan _marketing_**.
4. **_Lag_ operasional distribusi/retail.** _Awareness campaign_ sering berjalan sebelum stok dan _display_ tambahan benar-benar siap di toko. Penjualan _real_ baru terealisasi setelah eksekusi _trade marketing_ menyusul.
5. **Preseden dari *marketing science*.** Riset seperti IPA Databank (__Binet & Field__, _"The Long and the Short of It"_) dan __Ehrenberg-Bass Institute__ menunjukkan efek _brand-building_ terhadap _sales_ memang tidak instan. Selalu ada *lagged effect* yang bisa berlangsung dari beberapa minggu sampai beberapa kuartal, tergantung kategori.

### Argumen yang perlu diwaspadai

1. **Artefak agregasi kuartalan.** Kalau data aslinya cuma tersedia per kuartal, lag _real_ yang sebenarnya cuma 3–6 minggu bisa "kelihatan" seperti _lag_ satu kuartal penuh, tergantung kapan dalam kuartal kampanyenya berjalan.
2. **Artefak pencatatan sales, bukan perilaku konsumen.** Kalau _sales_ yang diukur adalah *sell-in* ke distributor (bukan *sell-out* ke konsumen akhir), _lag_ bisa murni soal siklus _invoicing/replenishment_ gudang. Tidak ada hubungannya dengan psikologi _brand awareness_ konsumen.
3. **Kebetulan sampel kecil.** Dengan n cuma ~17–19 pasangan kuartal, satu _lag_ yang "menonjol" bisa saja kebetulan statistik. Perlu direplikasi di beberapa _brand_/kategori/tahun berbeda sebelum dijadikan aturan umum.

**Kesimpulannya:** _lag_ 1 kuartal itu masih masuk akal tapi bukan hukum alam yang berlaku universal. 

## Limitasi dan Asumsi Metode Denton

Sebelum menutup, saya rasa penting untuk jujur soal batasan metode ini agar tidak dianggap solusi ajaib untuk semua masalah data _mismatch_ frekuensi:

1. **Kualitas hasil bergantung penuh pada kualitas _indicator_.** Denton cuma menjaga pola pergerakan _indicator_ sambil memaksa totalnya cocok dengan _benchmark_. Kalau _indicator_-nya jelek atau tidak relevan, hasilnya tetap mulus secara matematis tapi bisa saja salah secara substansi.
2. **_Benchmark_ dianggap akurat.** Metode ini tidak mengoreksi kesalahan di angka tahunan. Jadi jika data _benchmark_-nya sendiri _bias_ (misal metodologi survei berubah antar tahun), hasil kuartalannya ikut mewarisi _bias_ itu.
3. **Pilihan _additive/proportional_ dan _sum/average_ harus tepat.** Tidak ada cara otomatis untuk memilih ini dari data. Analis perlu memahami karakteristik variabel (_flow vs stock_) di awal. Salah pilih bisa mendistorsi hasil.
4. **Ini metode rekonsiliasi statistik, bukan model kausal.** Denton tidak menjelaskan _kenapa_ _awareness_ naik-turun. Ia cuma menjaga konsistensi angka antar frekuensi. Untuk mencari sebab-akibat kita tetap butuh analisis terpisah (seperti uji korelasi/_lag_ yang saya lakukan di atas).
5. **Butuh jumlah titik _benchmark_ yang cukup.** Di simulasi ini cuma 5 titik tahunan. Secara statistik ini tergolong sangat minim untuk memvalidasi kestabilan pola secara _robust_.
6. **Rawan revisi.** Begitu ada angka _benchmark_ tahunan baru (misal hasil survei tahun berikutnya keluar), seluruh hasil kuartalan historis bisa berubah karena _constraint_-nya menyesuaikan ulang ke angka baru.
7. **Korelasi dengan sales bukan bagian dari Denton itu sendiri.** Ini poin yang perlu saya ulangi lagi. Jangan sampai rekan-rekan mengira "akurasi korelasi antara _awareness dan sales_" itu jaminan dari metode Denton. Itu dua hal yang terpisah.

## _Epilog_

Hal yang saya suka dari metode Denton adalah dia menyelesaikan masalah yang sangat konkret dan sering diabaikan di kerjaan sehari-hari sebagai _market researcher_: Bagaimana caranya angka tahunan yang terpercaya dan angka kuartalan yang granular bisa hidup berdampingan tanpa saling kontradiksi. Buat rekan-rekan _market researcher_ atau _data scientist_ yang punya masalah serupa (data tahunan vs kuartalan), semoga tulisan ini bisa jadi titik awal yang berguna.

---

`if you find this article helpful, support this blog by clicking the ads.`
