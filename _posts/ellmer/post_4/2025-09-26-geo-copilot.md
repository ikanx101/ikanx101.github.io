---
date: 2025-09-26T07:58:00-04:00
title: "Tutorial: Cara Mengekstrak Informasi Google Maps Menggunakan AI"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Agentic AI
  - GenAI
  - Copilot
  - Microsoft
  - Market Research
  - Google Maps
  - Geocoding
  - Web Scrape
---

Belakangan ini saya sedang banyak meng-eksplor GenAI dan *Ai agents*
menggunakan `ellmer` dan `btw` di **R** sampai-sampai saya lupa bahwa
perusahaan tempat saya bekerja saat ini memiliki *subscription*
**Microsoft 365** yang sudah *include* dengan GenAI-nya sendiri, yakni
**Microsoft Copilot**.

> Secara tak sengaja, saya menemukan satu cara yang simpel untuk
> melakukan ekstraksi informasi dari Google Maps menggunakan Copilot.

Biasanya untuk melakukan hal ini, saya perlu *develop custom algorithm*
menggunakan **R** dan *Selenium*. Tapi menggunakan Copilot, prosesnya
cukup mudah. Saya membuat video terkait ini di [*link* Youtube berikut
ini](https://youtu.be/q_XYig1bWRM). Bahkan saya hanya menggunakan **iPad
*9th gen*** untuk melakukan hal ini.

Nah, saya akan jelaskan langkah-langkahnya juga di *blog* ini:

## Langkah I

Buka situs *Google Maps* dari *Safari* dan saya akan mencari *cafe* dari
area tertentu.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_4/IMG_1230.png" width="450" />

## Langkah II

Kemudian saya akan *copy-paste* satu-persatu *link* dari masing-masing
*cafe* yang hendak diambil datanya. Saya akan simpan *links* tersebut
dalam *notes*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_4/IMG_1232.png" width="450" />

Jika saya menggunakan PC / laptop, saya bisa melakukan hal ini secara
otomatis menggunakan *extensions* yang ada di **Google Chrome** atau
**Mozilla Firefox**.

## Langkah III

Buka *Copilot* dan saya berikan *prompts* berisi *links* yang tadi saya
simpan.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_4/IMG_1234.png" width="450" />

Tunggu beberapa saat, hasilnya akan seperti ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_4/IMG_1235.png" width="450" />

## Langkah IV

Selanjutnya saya akan tambahnya *prompts* untuk menambahkan beberapa
kolom seperti *longlat*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_4/IMG_1236.png" width="450" />

Kita bisa dengan mudah menyimpan hasilnya dalam format `.xlsx`. Berikut
adalah tabel finalnya:

| Nama Kafe | Alamat | Jam Buka | Kisaran Harga | Highlight | Rating | Fasilitas | Longitude | Latitude |
|:---|:---|:---|:---|:---|:---|:---|---:|---:|
| Rangkopi Duren Jaya | Duren Jaya, Bekasi Timur | Tidak tersedia | Tidak tersedia | Hadir di GoFood, fokus pada kopi dan makanan ringan | 4.0 | Indoor, Outdoor, GoFood | 107.0289 | -6.232591 |
| Grio Coffee | Jl. Kusuma Barat Raya No.10, Duren Jaya, Bekasi Timur | 09:00 - 23:00 | 40rb - 100rb | Kafe estetik milik keluarga arsitek, cocok untuk nugas, banyak pilihan snack | 4.6 | Indoor, Outdoor, WiFi, AC, Spot Instagramable, Musholla, Colokan | 107.0306 | -6.234014 |
| Tempat Diskusi | Bekasi Timur | Tidak tersedia | Tidak tersedia | Tempat untuk berdiskusi dan nongkrong, informasi terbatas | 4.7 | Indoor, Outdoor | 107.0326 | -6.229721 |
| Prefektur Coffee | Jl. Agus Salim, Bekasi Timur | 14:00 - 23:00 | \< Rp. 50.000 | Kafe ala Jepang, suasana tenang, kopi susu sakura, udon, snack platter | 4.1 | WiFi, Stop Kontak, Parkir, Musholla, Toilet | 107.0258 | -6.224389 |
| MAHACAFE | Jl. Raya Karang Satria, Duren Jaya, Bekasi Timur | Senin-Jumat: 09:00-21:00, Sabtu-Minggu: 09:00-23:00 | Tidak tersedia | Konsep minimalis modern, menu comfort food dan kopi pilihan | 4.5 | Indoor AC, Outdoor, Live Music, WiFi, Spot Foto | 107.0301 | -6.227974 |
| Cafe Mang Uka | Bekasi | Tidak tersedia | Tidak tersedia | Kafe lokal dengan ulasan positif, informasi terbatas | 4.3 | Indoor, Outdoor | 107.0310 | -6.234373 |
| Dose Coffee Shop | Bekasi | Tidak tersedia | Tidak tersedia | Kafe modern dengan kopi dan makanan enak | 4.0 | Indoor, Outdoor, WiFi, Musholla, Parkir Motor | 107.0267 | -6.236590 |
| The Connecting Dots | Jl. Wisma Raya No. 31, Bekasi Timur | Tidak tersedia | Tidak tersedia | Kafe baru di Wisma Jaya, menu diperbarui secara berkala | 4.5 | Indoor, Outdoor, WiFi, Spot Foto, Live Music | 107.0272 | -6.238351 |

## *Remarks*

Untuk melakukan hal seperti ini di Copilot, rekan-rekan harus memiliki
akun di Microsoft 365. Namun, saya sempat coba menggunakan GenAI lain
seperti Gemini dan bisa mengeluarkan *output* yang sama.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
