---
date: 2023-09-04T11:18:00-04:00
title: "Tutorial: Persiapan LLM (Sentiment Analysis) di Local Computer"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Home Tester
  - Market Research
  - Konsumen
  - Review Konsumen
  - Text Analysis
  - R Studio
  - Python
  - Deep Learning
---


Beberapa bulan yang lalu, saya menuliskan tentang komentar *netizen*
terhadap [susu oat Tropicana
Slim](https://ikanx101.com/blog/clustering-oat/). Dari dulu, saya
bercita-cita untuk melakukan *sentimen analysis* namun belum sempat
untuk membuat modelnya sendiri.

Kali ini, saya akan mencoba membuat *sentimen analysis* menggunakan
model yang sudah ada di *Huggingface*. Namun sebelum melakukannya, ada
beberapa persiapan yang harus dilakukan. *Oh iya*, sebagai pengingat
saya menggunakan Linux Ubuntu 20.04 LTS.

------------------------------------------------------------------------

# Langkah I

Saya akan melakukan *sentimen analysis* ini dengan **R**. Namun karena
model yang saya gunakan dari *Huggingface* merupakan *object*
*transformers* dari *Python*, maka perlu dipastikan bahwa komputer kita
memiliki Python yang ter-*install*.

Kemudian pastikan juga **R Studio** kita sudah di-*set* *Python*
*interpreter*-nya versi apa dan di *path folder* mana.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/tulisan%20keempat/Screenshot%20from%202023-09-04%2011-11-56.png" width="598" />

Di laptop saya, saya gunakan *Python* versi `3.10`.

# Langkah II

*Install transformers Huggingface*:

    pip install  huggingface transformers

# Langkah III

*Install pytorch*:

    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

------------------------------------------------------------------------

*Nah*, persiapan telah selesai. Kita sudah bisa membuat model dan
melakukan analisanya. Bagaimana caranya?

Bersambung…

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
