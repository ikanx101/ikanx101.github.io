---
date: 2025-06-25T15:27:00-04:00
title: "Perang Diskon E-commerce (Seller vs Platform) dalam Konteks Game Theory"
categories:
  - Blog
tags:
  - Market Riset
  - E-Commerce
  - Diskon
  - Game Theory
  - Matematika
  - Algoritma
  - Strategi
  - Online shopping
---

Hampir setiap hari, saya mendapatkan notifikasi dari salah satu
*e-commerce* di *smartphone* bahwa ada diskon spesial yang sedang
berlangsung saat ini. Dari [informasi yang saya ketahui dari rekan
saya](https://ikanx101.com/blog/binary-marketplace/), ada dua jenis
diskon yang ada di *e-commerce*, yakni:

1.  Diskon yang diberikan oleh *platform ecommerce*,
2.  Diskon yang diberikan langsung oleh *seller*.

Baik pihak *platform e-commerce* dan *seller* memiliki tujuan untuk
mendapatkan keuntungan dalam pemberian diskon tersebut.

> **Diskon** (menarik pembeli, tetapi rugi) atau **Tidak Diskon**
> (margin terjaga, tapi risiko sepi pembeli).

------------------------------------------------------------------------

Bayangkan kita adalah *seller* yang memiliki toko *online* yang menjual
produk di *platform e-commerce*. Kita dan *platform* (tentunya)
sama-sama mau untung, tapi pemilihan strategi diskon bisa membuat
“konflik”.

Bagi *seller*, alternatif strategi diskon yang bisa diambil adalah:

- **Memberikan diskon** yang diharapkan produk menjadi lebih murah
  sehingga produk laris. Namun konsekuensinya adalah *margin* relatif
  lebih tipis (untung sedikit) dibandingkan saat harga produk normal.  
- **Tidak memberikan diskon**, berarti harga produk normal sehingga
  keuntungan relatif lebih besar, tapi risiko sepi pembeli.

Sedangkan bagi *platform e-commerce*, alternatif strategi diskon yang
bisa diambil adalah:

- **Memberikan diskon tambahan** yakni memberikan subsidi diskon bagi
  *seller* sehingga *seller* dan pembeli senang. Diharapkan produk laris
  sehingga *platform* makin ramai. Namun karena *budget* diskon diambil
  dari kantongnya *platform*, maka otomatis ada *cost* di sana.  
- **Membiarkan tanpa diskon** sehingga *seller* bebas mengatur harga.
  Ada kemungkinan *platform e-commerce* tak ramai dan hanya mendapat
  *service fee* normal.

Kita bisa gambarkan hubungan keduanya menjadi matriks berikut ini:

|  | **Platform Diskon** | **Platform Tidak Diskon** |
|----|----|----|
| **Seller Diskon** | Seller rugi, Platform untung | Seller rugi besar, Platform untung besar |
| **Seller Tidak Diskon** | Seller aman, Platform rugi | Seller untung, Platform biasa saja |

Kasus di atas bisa dipandang sebagai salah satu contoh kasus *Game
Theory*. Apa itu *game theory*? Simak penjelasannya berikut ini:

### **Penjelasan Sederhana tentang *Game Theory***

Apakah kamu pernah menonton film [**A Beautiful
Mind**](https://en.wikipedia.org/wiki/A_Beautiful_Mind_(film))? Film ini
menceritakan perjalanan hidup seorang matematikawan bernama [John
Nash](https://en.wikipedia.org/wiki/John_Forbes_Nash_Jr.) saat beliau
menemukan **game theory**.

**Game Theory** adalah cabang matematika dan ekonomi yang mempelajari
**pengambilan keputusan** oleh pemain (individu, perusahaan, atau pihak
lain) dalam situasi di mana hasilnya tergantung pada **aksi semua pihak
yang terlibat**. Konsep dasar dari *game theory*:

1.  **Pemain (Players):** Pihak yang terlibat (misalnya: *seller* vs
    *platform e-commerce*).
2.  **Strategi (Strategies):** Pilihan yang tersedia untuk setiap pemain
    (misalnya: “diskon” vs “tidak diskon”).  
3.  **Payoff (Hasil):** Keuntungan/kerugian yang didapat berdasarkan
    kombinasi strategi.  
4.  **Nash Equilibrium:** Situasi di mana **tidak ada pemain yang bisa
    dapat hasil lebih baik dengan mengubah strategi sendiri**, jika
    pemain lain tetap pada strateginya.

Ada satu contoh legendaris yang biasa digunakan saat menjelaskan *game
theory*. Contoh tersebut bernama **The Prisoner’s Dilemma**.

Dua penjahat (A dan B) ditangkap polisi. Mereka dipisahkan satu sama
lain dan diberi pilihan:

- **Mengaku (Berkhianat terhadap penjahat lain)**.
  - Jika salah seorang penjahat tersebut berkhianat (mengakui
    kejahatannya), dia bisa dibebaskan asalkan rekannya tak berkhianat.
    Sedangkan rekannya yang tak berkhianat akan mendapatkan hukuman
    maksimal.
  - Jika keduanya saling mengkhianati, maka keduanya akan diberikan
    hukuman.
- **Diam (Tetap setia kawan terhadap penjahat lain)**.
  - Jika keduanya diam, polisi tak punya bukti apapun untuk menahan
    mereka.
- Masalahnya kedua penjahat ini dipisahkan ruangannya sehingga **tak
  saling mengetahui keputusan apa yang diambil oleh rekannya yang
  lain**.

Saya bisa tampilkan *Payoff Matrix*-nya sebagai berikut:

|               | **B Diam**             | **B Mengaku**          |
|---------------|------------------------|------------------------|
| **A Diam**    | A: 1 tahun, B: 1 tahun | A: 10 tahun, B: Bebas  |
| **A Mengaku** | A: Bebas, B: 10 tahun  | A: 5 tahun, B: 5 tahun |

- Jika **keduanya diam (setia kawan)**, hukuman minimal (1 tahun).  
- Jika **satu berkhianat dan satu diam**, yang mengaku bebas, yang diam
  kena hukuman maksimal.  
- **Nash Equilibrium:** Keduanya memilih **berkhianat** (masing-masing 5
  tahun), karena:
  - Jika A memilih diam, B lebih untung mengaku (bebas vs 1 tahun).  
  - Jika A memilih mengaku, B lebih baik mengaku (5 tahun vs 10 tahun).

------------------------------------------------------------------------

Kita kembali kepada kasus diskon *seller* vs *platform e-commerce*. Saya
bisa membuat *Payoff Matrix* sebagai berikut:

                          Platform: Diskon   Platform: Tidak Diskon
    Seller: Diskon          (-5, 10)                 (-15, 20)         
    Seller: Tidak Diskon    (0, -5)                  (10, 0)          

- *Seller* Diskon + *Platform* Diskon (D, D):
  - *Seller* rugi 5 (karena *margin* berkurang).
  - *Platform* untung 10 (karena *traffic* meningkat).
- Seller *Diskon* + *Platform* TD (D, TD):
  - *Seller* rugi besar 15 (karena diskon tidak didukung *platform*,
    jadi kurang efektif).
  - *Platform* untung besar 20 (karena *seller* diskon, tapi *platform*
    tidak berbagi biaya).
- *Seller* TD + *Platform* Diskon (TD, D):
  - *Seller* untung 0 (tidak ada diskon, tapi *platform* diskon menarik
    pembeli).
  - *Platform* rugi 5 (biaya diskon tidak tertutup).
- *Seller* TD + *Platform* TD (TD, TD):
  - *Seller* untung 10 (tanpa diskon, *margin* tinggi).
  - *Platform* untung 0 (tidak ada diskon, *traffic* biasa).

Perhatikan bahwa saya membuat nilai pada matriks di atas berdasarkan
pendapat dan asumsi saya saja *ya*. Jika tak setuju dan ingin
mengubahnya, dipersilakan saja.

Analisis Nash Equilibrium:

- Strategi Dominan:
  - *Seller* selalu lebih memilih Tidak Diskon (TD) (*payoff* lebih
    tinggi: 0 \> -5 dan 10 \> -15).
  - *Platform* selalu lebih memilih Tidak Diskon (TD) (*payoff* lebih
    tinggi: 20 \> 10 dan 0 \> -5).
- *Equilibrium* terjadi saat *seller* dan *platform* (TD, TD) dengan
  *payoff* (10, 0).

> **Nash Equilibrium** terjadi saat \[Tak diskon, Tak diskon\], yakni
> saat *seller* dan *platform* sama-sama tidak memberikan diskon.

Meskipun strategi (D, D) bisa lebih menguntungkan secara kolektif tapi
secara *payoff* individu membuat kedua pihak memilih **tidak diskon**.
Seandainya kedua pihak bisa bekerja sama bisa jadi *payoff* menjadi
lebih optimal.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
