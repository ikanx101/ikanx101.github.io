---
date: 2025-09-12T21:51:00-04:00
title: "Seandainya AI Agents Menjadi Data Analyst I"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Agentic AI
  - GenAI
  - DeepSeek
  - Survey
  - Market Research
---

Beberapa hari ini, saya masih penasaran *ngoprek* *AI agents*
menggunakan `ellmer`. Jika pada tulisan sebelumnya, saya sempat
menjelaskan bagaimana *AI agents* bisa dilengkapi dengan [*custom
function* untuk melakukan *web
scraping*](https://ikanx101.com/blog/agent-film-ai/). *Nah*, kali ini
saya mencoba untuk melengkapi *AI agents* dengan data.

Prinsip kerjanya masih sama dengan [tulisan
sebelumnya](https://ikanx101.com/blog/agentic-ellmer/), jadi saya akan
*inject* data ke dalam *AI agents*.

Sebagai contoh, saya akan membuat *AI agent* berbasis *DeepSeek* yang
di-*inject* data survey yang dulu pernah saya pakai saat menjelaskan
[*Simpson Paradox*](https://ikanx101.com/blog/simpson-paradox/).

Kemudian, saya akan tanyakan tiga *business questions* sebagai berikut:

- **PERTANYAAN I**: *Buat analisa profil responden meliputi gender,
  usia, dan ses (sosial ekonomi status)*.
- **PERTANYAAN II**: *Buat analisa tentang kolom awareness! Buat juga
  crosstabulasinya dengan profil responden!*
- **PERTANYAAN III**: *Jika saya hendak meningkatkan awareness,
  responden tipe apa yang harus saya jadikan target marketing campaign?*

Berikut adalah jawaban dari *AI agent* tanpa saya edit sama sekali:

# JAWABAN PERTANYAAN I

Berdasarkan data survey yang telah dimasukkan, berikut analisis profil
responden:

## ANALISIS PROFIL RESPONDEN

### 1. DISTRIBUSI GENDER

- **Pria**: 51.2% (187 responden)
- **Wanita**: 48.8% (178 responden)
- **Total**: 365 responden

### 2. DISTRIBUSI USIA

- **\< 15 th**: 12.9% (47 responden)
- **16 - 20 th**: 9.6% (35 responden)
- **21 - 25 th**: 42.2% (154 responden)
- **26 - 30 th**: 25.8% (94 responden)
- **\> 30 th**: 9.6% (35 responden)

### 3. DISTRIBUSI SOSIAL EKONOMI STATUS (SES)

- **Low**: 27.4% (100 responden)
- **Mid**: 53.4% (195 responden)
- **Up**: 19.2% (70 responden)

### KESIMPULAN:

- Responden didominasi oleh kelompok usia muda (21-25 tahun)
- Distribusi gender hampir seimbang dengan sedikit dominasi pria
- Mayoritas responden berasal dari status sosial ekonomi menengah (Mid)
- Kelompok usia produktif (21-30 tahun) merupakan mayoritas responden
  (68%)

# JAWABAN PERTANYAAN II

## ANALISIS AWARENESS

### DISTRIBUSI AWARENESS

- **Ya**: 49.3% (180 responden)
- **Tidak**: 50.7% (185 responden)

### CROSSTABULASI AWARENESS DENGAN PROFIL RESPONDEN

**1. Awareness vs Gender:**

              Ya   Tidak
    Pria      94    93
    Wanita    86    92

**2. Awareness vs Usia:**

              Ya   Tidak
    < 15 th   22    25
    16 - 20 th 19    16
    21 - 25 th 77    77
    26 - 30 th 46    48
    > 30 th    16    19

**3. Awareness vs SES:**

          Ya   Tidak
    Low   45    55
    Mid   95    100
    Up    40    30

### TEMUAN UTAMA:

- Awareness hampir seimbang (49.3% vs 50.7%)
- Tidak ada perbedaan signifikan awareness berdasarkan gender
- Kelompok usia 21-25 tahun memiliki awareness tertinggi secara absolut
- Status sosial ekonomi “Up” menunjukkan tingkat awareness tertinggi
  (57.1%) dibandingkan “Low” (45%) dan “Mid” (48.7%)

# JAWABAN PERTANYAAN III

Berdasarkan analisis data, untuk meningkatkan awareness, **target
marketing campaign** sebaiknya difokuskan pada:

## TARGET UTAMA:

**Responden dengan SES “Low”** - karena memiliki tingkat awareness
terendah (45%) dibanding kelompok SES lainnya

## TARGET SEKUNDER:

**Responden wanita** - meskipun perbedaannya kecil, wanita memiliki
awareness sedikit lebih rendah (48.3%) dibanding pria (50.3%)

**Responden usia \> 30 tahun** - memiliki awareness terendah (45.7%)
dibanding kelompok usia lainnya

## ALASAN:

- Gap awareness terbesar ada pada SES “Low” vs “Up” (12.1% difference)
- Investasi marketing pada kelompok SES “Low” akan memberikan ROI
  tertinggi dalam hal peningkatan awareness
- Kelompok ini mungkin memiliki akses informasi yang lebih terbatas
  sehingga membutuhkan pendekatan khusus

# *Conclusion*

Secara mudah, saya bisa simpulkan bahwa hasil analisa *AI agent* cukup
menjawab pertanyaan bisnis pertama dan kedua. Sedangkan untuk pertanyaan
bisnis ketiga, saya merasa jawaban yang dihasilkan masih ***kureng***.
Namun jika diberikan perintah yang lebih detail *step by step*-nya, kita
bisa mendapatkan jawaban yang lebih baik lagi.

Seperti ini hasilnya:

## ANALISIS KORELASI DAN CLUSTERING UNTUK TARGET MARKETING

### 1. ANALISIS KORELASI

**Korelasi Awareness dengan Variabel:** - **SES**: Korelasi positif
kuat - SES “Up” memiliki awareness 57.1% vs SES “Low” 45.0% - **Usia**:
Korelasi negatif lemah - usia \>30 tahun memiliki awareness terendah
(45.7%) - **Gender**: Korelasi sangat lemah - perbedaan hanya 2% antara
pria dan wanita

### 2. ANALISIS CLUSTERING

**Cluster 1: High Awareness Group (57.1%)** - SES: Up - Usia: 21-25
tahun dominan - Gender: Pria sedikit lebih tinggi

**Cluster 2: Medium Awareness Group (48.7%)** - SES: Mid  
- Usia: Beragam, dominan 21-30 tahun - Gender: Seimbang

**Cluster 3: Low Awareness Group (45.0%)** - SES: Low - Usia: \>30 tahun
dan \<15 tahun - Gender: Wanita sedikit lebih tinggi

### 3. REKOMENDASI TARGET MARKETING

**PRIORITAS 1: Cluster Low Awareness (SES Low)** - **Target**: Responden
SES “Low” terutama usia \>30 tahun - **Alasan**: Gap awareness terbesar
(12.1% dibanding SES Up) - **Strategi**: Pendekatan edukasi intensif,
channel komunikasi sederhana

**PRIORITAS 2: Sub-group Tertentu dalam Cluster Medium** - **Target**:
Wanita usia \>30 tahun dari SES Mid/Low - **Alasan**: Kombinasi faktor
risiko rendah awareness - **Strategi**: Program khusus perempuan, konten
relatable

**PRIORITAS 3: Preventive Targeting** - **Target**: Remaja (\<15 tahun)
dari semua SES - **Alasan**: Membangun awareness sejak dini -
**Strategi**: Konten edukasi menarik untuk generasi muda

**KESIMPULAN**: Fokus utama pada **SES “Low”** karena memberikan ROI
tertinggi untuk peningkatan awareness, dengan pendekatan yang
disesuaikan untuk sub-group usia tertentu dalam cluster ini.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
