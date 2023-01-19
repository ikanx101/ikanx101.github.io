---
title: "Sisi Gelap OpenAI"
date: 2023-01-19T10:38:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - OpenAI
  - Deep Learning
---

Beberapa hari yang lalu, salah seorang rekan kantor memiliki pertanyaan yang unik:

> _Untuk meng-apply CV ke kantor kita, kandidat kan harus mengisi essay tentang alasan mau bergabung. Bagaimana jika essay tersebut dia buat dengan bantuan OpenAI?_

Pertanyaan tersebut mungkin terkesan "remeh", tapi hal ini wajib menjadi perhatian dari tim HR karena hal ini sangat mungkin terjadi.

Saya akan coba untuk membuat essay dengan pertanyaan:

> _Buatlah essay: kenapa kamu mau bergabung dengan Pertamina?_

Berikut adalah _output_ dari OpenAI:

```
Pertamina merupakan salah satu perusahaan energi terbesar di Indonesia yang telah berdiri sejak tahun 1957. Perusahaan ini telah berkembang secara signifikan selama lebih dari 60 tahun dan terus berkontribusi untuk pembangunan dan kesejahteraan masyarakat Indonesia.

Bergabung dengan Pertamina adalah sebuah kehormatan dan peluang bagi saya untuk berkembang dan berbagi keahlian saya. Sebagai perusahaan yang bergerak dalam bidang energi, Pertamina memiliki berbagai peluang untuk mengembangkan karier dan berbagi pengetahuan. Pertamina juga telah mengembangkan berbagai teknologi untuk meningkatkan produktivitas dan efisiensi, yang merupakan aset yang berharga bagi perusahaan.

Selain itu, Pertamina juga menawarkan lingkungan kerja yang mendukung. Dengan pelatihan dan perkembangan karier yang tersedia, saya dapat mengembangkan dan meningkatkan keahlian dan pengetahuan saya. Saya juga dapat berbagi pengalaman dan pengetahuan saya dengan rekan kerja dan menjadi bagian dari tim yang berdedikasi untuk mencapai tujuan bersama.

Kemudian, bergabung dengan Pertamina juga memberikan kesempatan bagi saya untuk berkontribusi terhadap pembangunan Indonesia. Pertamina adalah perusahaan energi yang berperan penting dalam pembangunan Indonesia dan menyediakan energi yang dibutuhkan oleh masyarakat. Saya dapat membantu Pertamina dalam mencapai tujuannya dengan berbagi pengalaman dan kemampuan saya.

Bergabung dengan Pertamina adalah sebuah peluang yang menarik bagi saya, karena saya dapat berbagi pengalaman dan kemampuan saya, belajar dan berkembang, serta berkontribusi terhadap pembangunan Indonesia. Dengan semua peluang yang ditawarkan, saya yakin bahwa bergabung dengan Pertamina akan menjadi pengalaman yang menarik dan menguntungkan.
```

Terlihat essay yang dihasilkan sudah sangat baik _yah_.

Lantas pertanyaan selanjutnya:

> _Bagaimana cara kita mendeteksi apakah essay yang ditulis adalah karya AI atau karya manusia?_

Saya menawarkan dua solusi:

### Solusi Pertama

Kita bisa melakukan uji kesamaan antar dua tulisan menggunakan prinsip yang sudah pernah saya tuliskan di _blog_ saya [ini](https://ikanx101.com/blog/artikel-HBR/), yakni dengan:

1. _Crossword analysis_ dan
1. _Log odds ratio_.

### Solusi Kedua

Membuat model _machine learning_ untuk memprediksi essay tersebut hasil `AI` atau `human` dengan metode _Naive Bayes_ atau _ANN_.

---

Namun persamaan antara kedua solusi tersebut adalah kita harus sudah memiliki banyak data contoh hasil karya AI dan hasil karya _human_ untuk _feeding_ model perhitungan.

---

Bagaimana menurut kalian?