---
date: 2025-10-03T15:55:00-04:00
title: "Menangkap Kecemasan dan Kebingungan Netizen Seputar Diabetes"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Agentic AI
  - GenAI
  - Web Scrape
  - Kesehatan
  - Healthy
  - Alodokter
  - Diabetes
  - Text
  - Text Analysis
---

Tahun lalu, saya pernah menulis tentang [analisa teks
pertanyaan-pertanyaan *netizen* seputar diabetes yang saya ambil dari
situs alodokter](https://ikanx101.com/blog/wd-d/). Pagi ini saya
terpikir untuk melakukan satu analisa psikologi publik terhadap diabetes
secara sederhana.

Bagaimana caranya? Yakni dengan menilai semua pertanyaan yang saya ambil
tersebut apakah termasuk ke dalam **bingung**, **cemas**, atau
**optimis**. Untuk melakukan ini, saya akan menggunakan *AI agent* untuk
menilai semua pertanyaan tersebut. Setelah itu dengan bantuan *AI agent*
lainnya saya akan buat strategi *health campaign* dari informasi yang
ada.

Bagaimana hasilnya?

## Penilaian Psikologi Publik

dari **453 pertanyaan** *netizen*, berikut adalah penilaian
psikologisnya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_6/draft_files/figure-commonmark/unnamed-chunk-2-1.png)

Kita dapatkan **59.2%** pertanyaan *netizen* bernada bingung dan sisanya
bernada cemas. Menggunakan fitur *extraction*, saya akan coba gali
*keywords* dan alasan kecemasan atau kebingungan *netizen*.

## Analisa Kecemasan

### Alasan dan *Keywords* Kecemasan

Berdasarkan analisis pertanyaan-pertanyaan yang diajukan, berikut 5 tema
dominan yang mencerminkan kecemasan pengguna:

1.  **Ketakutan akan komplikasi diabetes** - Kekhawatiran mendalam
    terhadap luka yang tidak kunjung sembuh, risiko amputasi, dan
    kerusakan organ tubuh akibat diabetes.

2.  **Kepanikan terhadap diagnosis diabetes** - Kecemasan berlebihan
    saat mengalami gejala seperti sering haus, sering buang air kecil,
    atau hasil tes gula darah tinggi.

3.  **Keterbatasan akses pengobatan** - Rasa cemas karena biaya
    pengobatan yang mahal, ketidakpatuhan minum obat, dan ketakutan
    terhadap penggunaan insulin jangka panjang.

4.  **Kekhawatiran akan penularan genetik** - Rasa was-was yang kuat
    bahwa diabetes akan diturunkan kepada anak dan keturunan meskipun
    sudah berusaha mencegah.

5.  **Ketidakpastian penanganan luka diabetes** - Kepanikan karena luka
    yang membusuk, bernanah, dan tidak kunjung sembuh meski sudah
    dirawat sesuai anjuran.

### *Health Campaign* dari Kecemasan

Dari informasi di atas, berikut adalah *health campaign* yang bisa
dilakukan:

Berdasarkan analisis kecemasan target market, berikut 5 strategi
kampanye kesehatan diabetes:

1.  **Kampanye “Deteksi Dini, Cegah Komplikasi”** - Fokus pada edukasi
    pencegahan komplikasi dengan kontrol gula darah teratur, perawatan
    kaki harian, dan pemeriksaan mata/kesehatan berkala

2.  **Program “Tenang Hadapi Diabetes”** - Buat konten yang
    menormalisasi diagnosis diabetes, tunjukkan kisah sukses pasien, dan
    berikan panduan langkah demi langkah menghadapi diagnosis baru

3.  **Layanan “Diabetes Terjangkau”** - Kembangkan kemitraan dengan
    puskesmas/apotek untuk konsultasi gratis, diskon obat, dan edukasi
    penggunaan insulin yang tepat

4.  **Kampanye “Putus Rantai Diabetes Keluarga”** - Tekankan pentingnya
    pola hidup sehat sejak dini sebagai investasi kesehatan generasi
    berikutnya dengan testimoni keluarga yang berhasil

5.  **Gerakan “Luka Diabetes Sembuh Total”** - Demonstrasi visual
    perawatan luka yang benar, dari pembersihan hingga penutupan,
    dilengkapi hotline konsultasi perawatan luka 24 jam

## Analisa Kebingungan

### Alasan dan *Keywords* Kebingungan

Berdasarkan analisis pertanyaan-pertanyaan tentang diabetes, berikut 5
tema dominan yang membuat pengguna merasa **bingung**:

1.  **Konsep diabetes “kering vs basah”** - Mayoritas bertanya tentang
    perbedaan dan makna kedua istilah ini yang tidak ada dalam
    terminologi medis resmi.

2.  **Pemilihan nutrisi yang tepat** - Kebingungan memilih susu, roti,
    buah, dan makanan lain yang aman untuk penderita diabetes dengan
    berbagai kondisi komorbid.

3.  **Pengobatan herbal vs medis** - Keraguan antara efektivitas
    pengobatan tradisional (daun salam, pare, kayu manis) dibandingkan
    obat resep dokter.

4.  **Tata laksana luka diabetes** - Ketidaktahuan cara merawat luka
    bernanah di kaki dan mencegah komplikasi lebih lanjut.

5.  **Klasifikasi dan diagnosis** - Kebingungan membedakan tipe diabetes
    (1 vs 2), interpretasi hasil lab, serta kriteria prediabetes vs
    diabetes.

### *Health Campaign* dari Kebingungan

Dari informasi di atas, berikut adalah *health campaign* yang bisa
dilakukan:

Berdasarkan analisis kebingungan target market, berikut 5 strategi
kampanye edukasi diabetes:

1.  **Kampanye “Mitos vs Fakta Diabetes”** - Buat konten visual yang
    jelas membedakan terminologi medis vs persepsi masyarakat, khususnya
    tentang diabetes “kering-basah” dengan bahasa yang mudah dipahami

2.  **Program “Piring Sehat Diabetes”** - Demonstrasi praktis penyusunan
    menu harian dengan contoh konkret porsi, jenis makanan, dan
    alternatif pengganti yang aman untuk berbagai kondisi komorbid

3.  **Edukasi “Integrasi Pengobatan Modern & Herbal”** - Jelaskan peran
    obat medis sebagai terapi utama dan herbal sebagai pendukung, dengan
    penekanan pada konsultasi dokter sebelum mengonsumsi herbal

4.  **Video Tutorial “Perawatan Luka Step by Step”** - Buat panduan
    visual lengkap dari pembersihan, pemilihan dressing, hingga tanda
    bahaya yang harus segera ke dokter

5.  **Kampanye “Kenali Jenis Diabetes-mu”** - Infografis sederhana yang
    menjelaskan perbedaan tipe diabetes, interpretasi hasil lab, dan
    langkah yang harus diambil berdasarkan klasifikasi diagnosis

## *Remarks*

Bagaimana menurut kalian?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
