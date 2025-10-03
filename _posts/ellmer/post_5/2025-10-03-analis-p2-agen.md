---
date: 2025-10-03T07:58:00-04:00
title: "Seandainya AI Agents Menjadi Data Analyst (part II)"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Agentic AI
  - GenAI
  - Analysis
  - Marketing Activities
  - Revenue
  - Growth
  - Sales Marketing
---

Beberapa waktu yang lalu, saya menuliskan bagaimana saya membuat *AI
agents* menggunakan `ellmer` untuk [menganalisa data
survey](https://ikanx101.com/blog/agent-analis-survey/). Kali ini saya
akan menambahkan *function* dari `library(btw)` untuk menyempurnakan *AI
agents* ini. Rekan-rekan bisa melihat dokumentasi `library(btw)` di
[*link* ini](https://posit-dev.github.io/btw/).

Proses kerjanya adalah seperti ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_5/Blank%20diagram.png" width="450" />

Saya akan menggunakan data yang berasal dari `library(Robyn)` yang
pernah saya jelaskan tentang [Mixed Marketing
Model](https://ikanx101.com/blog/practical-mmm/).

Data tersebut berisi **208 baris data mingguan yang berisi *revenue* dan
*marketing activities spending* dari suatu perusahaan**. Di sana juga
diberikan data *competitor sales value*. Berikut adalah gambaran dari
data yang saya gunakan.

## Statistika Deskriptif

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_5/draft_files/figure-commonmark/unnamed-chunk-2-1.png)

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_5/draft_files/figure-commonmark/unnamed-chunk-2-2.png)

Kita bisa melihat bahwa hampir semua *marketing activities spending*
memiliki korelasi positif dengan kekuatan **lemah - sedang**. Sedangkan
*competitor sales value* ternyata berkorelasi positif dan sangat kuat.

## *Business Question*

Sekarang saya akan membuat *AI agent* yang kemudian diberikan wewenang
untuk membaca data tersebut. Pertanyaan bisnis yang saya berikan adalah:

***Dari data yang ada bagaimana cara meningkatkan revenue?***

## Jawaban *AI Agent* (tanpa *edit* sama sekali)

Untuk bisa menjawab pertanyaan tersebut, *AI agent* membuat beberapa
analisa berikut ini secara otomatis:

### Korelasi terhadap *Revenue*

    internet_ads_spending       tv_ads_spending            newsletter 
               0.44277364            0.41986942            0.40609935 
    facebook_ads_spending    print_ads_spending  out_of_home_spending 
               0.31759430            0.23041537            0.09527928 

### Analisa Keberadaan *Events*

| events | avg_revenue | count | total_revenue |
|:-------|------------:|------:|--------------:|
| event1 |     2601602 |     1 |       2601602 |
| event2 |     2303595 |     1 |       2303595 |
| na     |     1816022 |   206 |     374100500 |

### Analisa ROI *Marketing Activities*

    $tv_ads_spending
    [1] 6078.614

    $out_of_home_spending
    [1] 1689.215

    $print_ads_spending
    [1] 22531.14

    $internet_ads_spending
    [1] 25866.65

    $facebook_ads_spending
    [1] 47674.47

    $newsletter
    [1] 8039.463

### Analisa Kompetitor

    $correlation
    [1] 0.9164541

    $summary
    # A tibble: 5 × 3
      competitor_quartile avg_revenue count
      <fct>                     <dbl> <int>
    1 Q1                     1068793.    51
    2 Q2                     1410206.    52
    3 Q3                     2119862.    52
    4 Q4                     2697336.    52
    5 <NA>                    672250      1

### Analisa *Budget Optimization*

          tv_ads_spending  out_of_home_spending    print_ads_spending 
              0.059353396           0.008120626           0.112208802 
    internet_ads_spending facebook_ads_spending            newsletter 
              0.343231894           0.425885379           0.051199902 

Dari semua analisa yang dilakukan oleh *AI agent*, kini ia akan
men-sintesa jawaban finalnya seperti ini:

### Jawaban FINAL Hasil Sintesa dari Analisa-Analisa di Atas

Berdasarkan analisis data yang tersedia, berikut adalah rekomendasi
strategis untuk meningkatkan revenue:

## **Rekomendasi Utama untuk Meningkatkan Revenue:**

### 1. **Optimasi Alokasi Budget Iklan**

Berdasarkan analisis ROI dan korelasi, prioritaskan channel dengan ROI
tertinggi: - **Facebook Ads**: ROI **47,674** (tertinggi) - alokasikan
**42.6%** budget - **Internet Ads**: ROI **25,867** - alokasikan
**34.3%** budget  
- **Print Ads**: ROI **22,531** - alokasikan **11.2%** budget

### 2. **Fokus pada Channel Digital**

- **Facebook Ads** dan **Internet Ads** menunjukkan korelasi positif
  tertinggi dengan revenue (0.318 dan 0.443)
- Kurangi alokasi untuk **Out-of-Home** (ROI hanya 1,689) dan **TV Ads**
  (ROI 6,079) yang kurang efektif

### 3. **Leverage Events**

- **Event1** menghasilkan revenue rata-rata **2,601,602** (tertinggi)
- **Event2** menghasilkan **2,303,595**
- Tingkatkan frekuensi dan skala events untuk mendongkrak revenue

### 4. **Strategi Kompetitif**

- Korelasi tinggi dengan competitor sales (0.916) menunjukkan pasar yang
  kompetitif
- Revenue meningkat seiring dengan quartile kompetitor:
  - Q1: 1,068,793
  - Q4: 2,697,336
- Fokus pada diferensiasi produk/layanan untuk bersaing di pasar tinggi

### 5. **Optimasi Newsletter**

- ROI newsletter **8,039** dengan korelasi 0.406
- Tingkatkan engagement newsletter untuk meningkatkan konversi

## **Action Plan Prioritas:**

1.  **Realokasi Budget**: Pindahkan budget dari TV dan Out-of-Home ke
    Facebook & Internet Ads
2.  **Scale Events**: Tingkatkan frekuensi events dari 2 kali menjadi
    4-6 kali per tahun
3.  **Digital Transformation**: Fokus pada kampanye digital yang lebih
    terukur dan efektif
4.  **Competitive Positioning**: Kembangkan strategi untuk bersaing di
    segmen pasar tinggi (Q3-Q4)

Dengan implementasi strategi ini, revenue dapat meningkat signifikan
mengingat potensi ROI yang tinggi dari channel digital dan events.

## *Remarks*

Bagaimana menurut kalian?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
