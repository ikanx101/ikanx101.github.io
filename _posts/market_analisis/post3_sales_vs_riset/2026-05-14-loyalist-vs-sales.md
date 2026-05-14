---
date: 2026-05-14T16:24:00-04:00
title: "Ketika Survey Bilang Loyalist Turun 27%, Tapi Sales Cuma -15%: Siapa yang Salah?"
categories:
  - Blog
tags:
  - Market research
  - Data analysis
  - Sales
  - Sales research
  - FMCG
  - Loyalist
---

Beberapa hari yang lalu, tim _marketing research_ menyampaikan hasil survey kuartal ini kepada tim _marketing_. Datanya cukup mengkhawatirkan: **basis loyalist produk kami turun 27%** dibanding tahun lalu.

Spontan, rapat jadi agak panas. Tim _marketing_ langsung bereaksi:

> *"Kok bisa? _Sales value_ kita cuma turun 15%, _loh_. Masa loyalisnya turun 27%? Pasti metode survey-nya yang kurang tepat."*

Saya hanya bisa tersenyum kecil di dalam hati. Fenomena ini sebenarnya **sangat wajar**. Bahkan fenomena ini bisa dijelaskan dengan matematika sederhana yang kita ketahui bersama. Sayangnya, di lapangan, banyak yang masih menganggap hubungan antara jumlah loyalist dan sales value itu **linear**.

__Padahal tidak demikian.__

Mari saya coba jelaskan dengan cara yang (semoga) mudah dipahami.

---

## Kenapa _Loyalist_ dan _Sales Value_ Tidak Bisa Dibandingkan Satu Lawan Satu?

Pertama-tama, kita harus paham dulu struktur dari _sales value_ itu sendiri. Secara matematis:

```
Sales Value = Jumlah Orang × Frekuensi Beli × Kuantitas per Beli × Harga per Unit
```

Atau kalau ditulis dalam notasi yang lebih rapi:

$$S = L \times F \times Q \times H$$

Di mana:
- **L** = jumlah _loyalist_ (atau pembeli secara umum)
- **F** = rata-rata frekuensi beli per periode
- **Q** = rata-rata kuantitas per transaksi
- **H** = rata-rata harga per unit

Nah, survey _loyalist_ yang di lakukan oleh tim _market research_ hanya mengukur **satu** variabel saja: yaitu **L**. Sedangkan _sales value_ adalah **hasil kali dari empat variabel sekaligus**.

Selama tiga variabel lainnya (_F, Q, H_) **tidak diam/diikat**, maka perubahan pada _L_ tidak akan pernah berbanding lurus dengan perubahan pada _S_. Ini matematika dasar, bukan masalah metode survey.

---

## Simulasi Sederhana

Biar lebih jelas, saya buatkan skenario dengan angka-angka.

### Skenario A: Semua Variabel Lain Tetap (Ilusi Linear)

Misalkan tahun lalu:

| Variabel | Nilai |
|---|---|
| L (_loyalist_) | 100 orang |
| F (frekuensi/kuartal) | 4 kali |
| Q (qty/transaksi) | 2 _pcs_ |
| H (harga/pcs) | Rp25.000 |

**Sales tahun lalu** = 100 × 4 × 2 × 25.000 = **Rp20.000.000**

Sekarang, loyalis turun 27%. _L_ baru = 73 orang. Jika _F, Q, H_ tetap:

**Sales tahun ini** = 73 × 4 × 2 × 25.000 = **Rp14.600.000**

Penurunan sales = (20jt - 14,6jt) / 20jt = **27%**. Nah, ini baru linear.

Tapi ini skenario **dunia ideal** yang hampir tidak pernah terjadi di pasar nyata.

---

### Skenario B: Yang Realistis (Ada Kompensasi dari Variabel Lain)

Di dunia nyata, ketika _loyalist_ berkurang, yang tersisa biasanya adalah **_hardcore loyalist_** — mereka yang paling setia. Dan mereka cenderung **berkompensasi** dengan membeli lebih sering atau lebih banyak.

Coba lihat skenario ini:

| Variabel | Tahun Lalu | Tahun Ini | Perubahan |
|---|---|---|---|
| L | 100 | 73 | **-27%** |
| F | 4 | 5 | **+25%** |
| Q | 2 | 2 | tetap |
| H | Rp25.000 | Rp25.000 | tetap |

**Sales tahun ini** = 73 × 5 × 2 × 25.000 = **Rp18.250.000**

Penurunan _sales_ = (20jt - 18,25jt) / 20jt = **8,75%**.

Lihat? **Loyalist turun 27%, tapi sales cuma turun 8,75%.** Dan ini belum memasukkan efek harga atau kuantitas.

---

### Skenario C: Efek Harga Naik (_Mix Shift_ ke Premium)

Kadang, _loyalist_ yang pergi adalah mereka yang membeli SKU murah. Sementara yang tersisa beralih ke varian premium.

| Variabel | Tahun Lalu | Tahun Ini | Perubahan |
|---|---|---|---|
| L | 100 | 73 | **-27%** |
| F | 4 | 4 | tetap |
| Q | 2 | 2 | tetap |
| H | Rp25.000 | **Rp30.000** | **+20%** |

**Sales tahun ini** = 73 × 4 × 2 × 30.000 = **Rp17.520.000**

Penurunan _sales_ = (20jt - 17,52jt) / 20jt = **12,4%**.

Lagi-lagi, _gap_ antara -27% dan -12,4%. Tanpa mengubah metode survey sama sekali.

---

### Skenario D: Kombinasi (Paling Mendekati Realita)

Sekarang kita gabungkan semuanya; karena di pasar nyata, semuanya bergerak simultan:

| Variabel | Perubahan |
|---|---|
| L | **-27%** |
| F | **+15%** (loyalist tersisa beli lebih sering) |
| Q | **+10%** (beli lebih banyak setiap kali) |
| H | **+5%** (mix shift ke SKU premium) |

**Sales tahun ini** = 73 × (4×1,15) × (2×1,10) × (25.000×1,05)
= 73 × 4,6 × 2,2 × 26.250
= **Rp19.399.725**

**Penurunan sales = (20jt - 19,4jt) / 20jt ≈ 3%.**

___Boom!___ 

**Loyalist ambles 27%, tapi _sales value_ hampir tidak bergerak.** Ini bukan rekayasa data tapi realita multivariat yang setiap hari terjadi di pasar FMCG.

---

## Lalu, Siapa yang Salah? Tim _Marketing_, Tim _Sales_ atau Tim Market Riset?

Jawabannya: **tidak ada yang salah.** 

Hal yang perlu diluruskan adalah **ekspektasi** tentang hubungan antara dua metrik yang secara dimensional berbeda.

Survey _loyalist_ mengukur **L** (jumlah _loyalist_). Itu adalah *attitudinal metric*, mengukur perilaku dan komitmen konsumen terhadap _brand_. Validitasnya tergantung pada metodologi _sampling_, instrumen kuesioner, sistem _quality control_, dan analisis yang digunakan. Dalam kasus kami, semua sudah melalui *quality control* yang ketat.

Sementara itu, _sales value_ mengukur **L × F × Q × H** — itu adalah *behavioral metric*, hasil akhir dari interaksi kompleks antara jumlah orang, kebiasaan beli, dan harga.

**Keduanya penting, tapi menjawab pertanyaan yang berbeda.**

- Survey _loyalist_ menjawab: *"Apakah hubungan emosional dan perilaku konsumen terhadap _brand_ kita mulai rapuh?"*
- _Sales value_ menjawab: *"Berapa banyak uang yang masuk ke kas perusahaan?"*

Dan yang lebih penting: **loyalist adalah leading indicator**, sedangkan _sales_ adalah **lagging indicator**. Penurunan _loyalist_ sebesar 27% adalah alarm yang berbunyi *sekarang*. Dampaknya ke _sales_ mungkin baru akan terasa penuh satu atau dua kuartal ke depan, yakni ketika _loyalist_ yang sudah pergi benar-benar tidak lagi membeli, dan tidak ada _loyalist_ baru yang menggantikan.

Kalau saya jadi tim _marketing_, saya justru akan berterima kasih pada tim riset karena sudah memberikan peringatan dini. Karena menunggu sampai _sales_ benar-benar turun 27% untuk bereaksi, __itu sudah terlambat__.

> Selain itu, perlu __dipahami bahwa omset di-*generate* tidak hanya dari *loyalist*!__. Masih ada _occasional user_ dan _new trialist_ yang sedikit banyak pembelian mereka pasti berdampak pada _sales value_.

---

## Data Market Riset vs Data _Sales_: Dua Dunia yang Berbeda

Diskusi kami dengan tim _marketing_ itu membuka mata saya akan satu hal: **masih banyak yang belum paham bahwa data market riset dan data _sales_ itu lahir dari filosofi yang berbeda.** Mereka memang sama-sama angka, tapi cara membaca, memaknai, dan menghubungkannya tidak bisa disamakan.

Mari saya bedah perbedaan mendasarnya.

### Sifat Data: _Attitudinal vs Behavioral_

| Dimensi | Data Market Riset | Data Sales |
|---|---|---|
| **Apa yang diukur?** | Sikap, persepsi, niat, kesadaran (*attitudinal*) | Perilaku aktual, transaksi riil (*behavioral*) |
| **Sumber data** | Sampel terpilih (survei, FGD, depth interview) | Populasi (seluruh transaksi yang tercatat) |
| **Arah waktu** | *Forward-looking* — bisa mendeteksi niat beli, loyalitas, preferensi ke depan | *Backward-looking* — mencatat apa yang *sudah* terjadi |
| **Struktur** | Diskrit, kategorik, skala Likert, proporsi | Kontinu, agregat, numerik (Rp, unit, qty) |
| **Galat/error** | Sampling error, non-sampling error, bias responden | Galat input data, missing SKU, double counting — relatif minimal |
| **Pertanyaan khas** | *"Apakah Anda akan membeli lagi?"* | *"Berapa banyak yang terjual?"* |

Dari tabel di atas, jelas bahwa **keduanya menjawab pertanyaan yang berbeda**. Satu bicara soal *mindset*, satu lagi bicara soal *outcome*. Dan dalam ilmu apapun baik psikologi, ekonomi, maupun statistik, *mindset* dan *outcome* tidak pernah bergerak bersisian secara linear.

Oke, kalau masih bingung saya coba jelaskan dengan analogi sederhana sebagai berikut:

### Analogi Sederhana: Cek Kesehatan vs Catatan Medis

Bayangkan kita periksa kesehatan ke dokter. Dokter melakukan serangkaian tes: cek gula darah, kolesterol, tekanan darah, dan EKG. Salah satu hasilnya menunjukkan bahwa **kadar gula Anda naik 27%** dibanding tahun lalu. Ini menjadi alarm pre-diabetes.

Dokter bilang: 

> *"Hati-hati, ini tanda awal. Kalau tidak diubah pola makannya, risiko diabetes Anda tinggi."*

Tapi Anda menjawab: 

> *"Ah, masa sih? Saya kan masih sehat, berat badan cuma naik 3 kg kok. Tes darah Anda pasti salah."*

Kedengarannya konyol, _kan?_

_Nah_, **data market riset itu ibarat tes kesehatan**. Data itu memberikan *early warning* tentang kondisi brand di benak konsumen. Sedangkan **data sales itu ibarat catatan medis**, ia mencatat apa yang sudah terjadi secara aktual. Dua-duanya penting, tapi tidak bisa saling menggantikan.

### Lalu Bagaimana Cara Menghubungkannya dengan Benar?

Ini yang jarang diajarkan di bangku kuliah, atau paling tidak, jarang dipraktikkan di dunia kerja. Berikut pendekatan yang bisa kita gunakan:

#### 1. Bangun _Model Bridging_, Bukan Korelasi Langsung

Jangan plot jumlah _loyalist vs sales value_ lalu hitung R²-nya sambil berharap tinggi. Itu _naif_. Yang benar: **bangun model yang menjembatani.**

Secara konseptual:

```
Attitudinal Metrics (survei)
        ↓
Brand Health Index / Loyalty Score
        ↓
Dimediasi oleh: distribusi, harga, promosi, musiman
        ↓
Behavioral Outcomes (sales)
```

Jadi _loyalist_ itu bukanlah *predictor langsung* dari _sales_ dalam seminggu atau sebulan. Tapi _loyalist_ adalah **fondasi** yang menentukan *resilience* _sales_ terhadap _shock_, misal saat ada kompetitor masuk, krisis, kenaikan harga, dsb.

#### 2. Gunakan _Time Lag Analysis_

_Loyalist_ adalah *leading indicator*. Efek perubahan _loyalist_ ke _sales_ biasanya punya **time lag**, bisa 1-2 kuartal, tergantung kategori produk dan siklus pembelian.

Cara ilmiahnya: jangan regresikan _sales_ Q1 dengan _loyalist_ Q1. Tapi regresikan **sales Q2 dan Q3** dengan _loyalist_ Q1. Cari *lag structure* yang paling signifikan secara statistik. Ini bisa dilakukan dengan *cross-correlation function* (CCF) atau *distributed lag models*.

#### 3. Kontrol Variabel Lain (_Ceteris Paribus_)

Kalau mau benar-benar mengisolasi efek loyalis ke _sales_, kita perlu **mengontrol** variabel-variabel lain:

- Aktivitas promosi & diskon
- Perubahan harga rata-rata (_price mix_)
- Distribusi & ketersediaan produk (_out of stock rate_)
- Aktivitas kompetitor
- Faktor musiman

Kalau semua itu tidak dikontrol, maka membandingkan persentase perubahan _loyalist_ dengan persentase perubahan _sales_ secara langsung adalah **kesalahan ilmiah yang fundamental**.

Teknik statistik seperti **regresi berganda**, **GLM**, atau **mixed models** bisa digunakan untuk ini.

#### 4. Triangulasi, Bukan Konfrontasi

Pada akhirnya, data market riset dan data _sales_ bukanlah dua hal yang harus dipertentangkan. Mereka adalah dua sisi mata uang yang sama.

**Triangulasi** adalah pendekatan ilmiah di mana kita menggunakan kedua sumber data secara komplementer:

| Temuan Market Riset | Cek dengan Data Sales | Kesimpulan |
|---|---|---|
| Loyalist turun | Sales turun lebih kecil | Ada kompensasi dari F, Q, H — cek mana yang naik |
| Loyalist turun | Sales ikut turun besar | Masalahnya sistemik — dari brand ke lini terdepan |
| Loyalist stabil | Sales turun | Bukan masalah brand image — cek distribusi, harga, atau stok |
| Loyalist naik | Sales belum naik | *Leading indicator* positif — pantau 1-2 kuartal ke depan |

Dengan pendekatan ini, tidak ada lagi budaya saling lempar tanggung jawab. Yang ada adalah budaya *sense-making*: memahami apa yang terjadi dari berbagai sudut pandang data, lalu mengambil keputusan berdasarkan gambaran utuh.

---

## _Epilog_

Fenomena _loyalist_ turun 27% tapi sales cuma -15% bukanlah anomali. Bukan juga akibat metode survey yang keliru. Ini adalah konsekuensi alami dari **sistem multivariat** dimana output (_sales_) adalah hasil perkalian dari beberapa _inputs_ yang bergerak independen.

Selama variabel frekuensi (F), kuantitas (Q), dan harga (H) tidak dikontrol, **tidak akan pernah ada hubungan linear antara jumlah _loyalist_ dan _sales value_**. Sesederhana itu.

Data market riset dan data _sales_ adalah dua jenis data yang **secara fundamental berbeda**. Satu *attitudinal* dan satu lainnya *behavioral*. Satu *forward-looking* dan satu lainnya *backward-looking*. Menghubungkan keduanya secara langsung tanpa kerangka ilmiah yang tepat adalah kesalahan yang masih sering terjadi di industri kita.

Yang perlu dilakukan sekarang bukan saling menyalahkan, tapi duduk bersama memahami *story* di balik angka-angka ini:

1. **Kenapa _loyalist_ berkurang?** Apakah ada masalah produk? Harga? Distribusi? Kompetitor?
2. **Apa yang membuat yang tersisa tetap bertahan dan bahkan membeli lebih banyak?**
3. **Berapa lama efek kompensasi dari F, Q, dan H ini bisa bertahan?**
4. **Model bridging apa yang perlu dibangun agar tim riset dan _marketing_ bicara dalam bahasa yang sama?**

Karena kalau hanya mengandalkan _sales value_ yang "masih OK", tanpa menyadari bahwa fondasi loyalist-nya sudah jebol, kita sedang membangun istana di atas pasir.

---

`if you find this article helpful, support this blog by clicking the ads.`