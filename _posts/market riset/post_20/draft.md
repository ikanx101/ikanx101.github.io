# xxx


Pada tahun 2021 lalu, saya sempat menuliskan suatu teknik analisa
bernama [*Conjoint Analysis* yang sangat berguna di bidang *market
research*](https://ikanx101.com/blog/conjoint/). Kali ini, saya hendak
menulis ulang tentang analisa ini dengan suatu studi kasus terbaru.

------------------------------------------------------------------------

Misalkan suatu waktu perusahaan saya hendak meluncurkan suatu produk
minuman teh kemasan. Sebelum *launching*, saya ingin tahu preferensi
konsumen dengan cara membuat survey market riset. Cara yang paling mudah
adalah dengan membuat satu pertanyaan klasik sebagai berikut:

**“Seberapa penting bagi Anda bahwa minuman teh ini:**

- 1)  menggunakan bahan alami 100%?
- 2)  dikemas dalam botol ramah lingkungan?
- 3)  harganya terjangkau?
- 4)  rasanya enak?

Pertanyaan tersebut dijawab menggunakan skala *likert* 1 - 6 dimana 1
adalah sangat tidak penting dan 6 adalah sangat penting.

Untuk orang Indonesia, hasil survey ini sudah bisa ditebak: bisa
dipastikan hampir semua responden menjawab 5 atau 6 untuk semua atribut.

> Tentu saja — siapa yang mau bilang harga tidak penting, atau rasa
> boleh biasa-biasa saja?

Inilah yang disebut *social desirability bias* dan *acquiescence bias*
dalam survei. Responden cenderung memberikan jawaban yang ‘benar’ secara
norma sosial, bukan jawaban yang mencerminkan perilaku nyata mereka.

*Conjoint Analysis* hadir untuk memecahkan masalah ini. Alih-alih
bertanya langsung ‘apa yang penting?’, *conjoint* memaksa responden
untuk membuat pilihan nyata di antara produk-produk hipotetis — persis
seperti yang mereka lakukan di toko. Dari pola pilihan itu, kita bisa
menghitung secara matematika: atribut mana yang paling menentukan
keputusan beli, dan seberapa besar bobotnya.

# Konsep Dasar *Conjoint Analysis*

## Apa itu *Conjoint Analysis*?

*Conjoint Analysis* adalah teknik statistik dalam market riset yang
digunakan untuk mengukur preferensi konsumen terhadap atribut-atribut
produk. Nama ‘*conjoint*’ berasal dari frasa ‘*considered jointly*’,
yakni konsumen menilai kombinasi atribut secara bersamaan, bukan satu
per satu.

Teknik ini pertama kali dikembangkan oleh psikolog matematika Paul Green
dan Vithala Rao pada tahun 1971 dan sejak itu menjadi salah satu metode
paling banyak digunakan dalam market riset profesional, mulai dari riset
produk FMCG, otomotif, hingga *financial services*.

## Konsep Kunci: *Part-Worth Utility*

Inti dari *conjoint analysis* adalah konsep *utility* (kegunaan). Setiap
level dari setiap atribut produk memiliki ‘*part-worth utility*’, yakni
nilai numerik yang merepresentasikan seberapa besar level tersebut
berkontribusi pada preferensi konsumen secara keseluruhan.

**Analogi sederhananya sebagai berikut:**

Bayangkan sebuah gelas minuman teh. Total **nilai** di mata konsumen =
(*utility* rasa manis) + (*utility* ukuran sedang) + (*utility* harga
Rp5.000) + (*utility* kemasan botol).

*Conjoint analysis* menghitung masing-masing angka tersebut dari data
pilihan konsumen.

## Tiga Jenis *Conjoint Analysis*

| Jenis | Cara Kerja | Kapan Digunakan? |
|----|----|----|
| Traditional / Rating-Based | Responden menilai setiap profil produk dengan skor (misal 1–10) | Ketika atribut sedikit (≤6) dan level sedikit (≤3) |
| Choice-Based (CBC) | Responden memilih satu dari beberapa alternatif produk (termasuk opsi ‘tidak membeli’) | Paling umum di market research modern, paling mendekati perilaku nyata |
| Adaptive (ACBC) | Pertanyaan beradaptasi berdasarkan jawaban sebelumnya | Ketika atribut sangat banyak (\>8) atau banyak variasi level |

Untuk tulisan ini, saya akan membahas *Traditional Conjoint* terlebih
dahulu karena paling mudah dipahami secara matematis.

## Merancang Studi Conjoint: Produk Minuman Teh Kemasan

Kita akan mensimulasikan riset untuk *brand* minuman teh kemasan yang
ingin memahami preferensi konsumen usia remaja - aktif (18–35 tahun) di
kota besar Indonesia. Ada empat pertanyaan utama, yakni:

1.  Atribut mana yang paling menentukan keputusan beli?
2.  Berapa harga optimal yang masih bisa diterima konsumen?
3.  Apakah konsumen benar-benar peduli dengan klaim ‘bahan alami’?
4.  Profil produk mana yang paling kompetitif di pasar?

### Langkah 1: Mendefinisikan Atribut dan Level

Langkah pertama dan terpenting dalam *conjoint* adalah memilih atribut
yang relevan dan levelnya. **Terlalu banyak atribut akan membuat
responden kelelahan** karena pertanyaan yang perlu dijawab sangat
banyak. Namun **terlalu sedikit atribut tidak menangkap realita pasar**.

Berikut adalah atribut dan level yang saya definisikan:

|  |  |  |
|----|----|----|
| **Atribut** | **Level-Level** | **Alasan** |
| Rasa | Manis, Sedikit Manis, Tidak Manis | Tren kesehatan membuat ‘tidak manis’ makin populer |
| Ukuran | 250ml, 500ml, 1000ml | Mewakili segmen minum langsung, sekali makan, dan keluarga |
| Klaim Bahan | Alami 100%, Tanpa Pengawet, Reguler | Mengukur seberapa besar premium untuk klaim health |
| Kemasan | Botol Plastik, Botol Kaca, Kotak Karton | Aspek sustainability & portabilitas |
| Harga | Rp4.000, Rp7.000, Rp12.000, Rp18.000 | 4 level harga untuk menangkap price sensitivity |

### Langkah 2: Membuat *Fractional Factorial Design* di R

Langkah krusial pada *Conjoint Analysis* adalah membuat *factorial
design* yang bersifat *orthogonal*. *Orthogonal design* dalam *conjoint
analysis* adalah metode untuk membuat kombinasi produk yang efisien
dengan memilih *subset* atribut dan level yang saling independen secara
statistik, sehingga setiap atribut berkontribusi secara unik terhadap
preferensi konsumen tanpa adanya korelasi atau bias yang tumpang tindih.
Pendekatan ini memungkinkan peneliti untuk mengestimasi utilitas setiap
level atribut secara akurat dengan jumlah kombinasi produk yang jauh
lebih sedikit dibandingkan dengan semua kemungkinan kombinasi, karena
menggunakan prinsip desain eksperimental yang memastikan setiap level
atribut muncul dengan frekuensi yang seimbang dan berpasangan secara
proporsional dengan level atribut lainnya, sehingga menghasilkan data
yang optimal untuk analisis regresi dan pengukuran preferensi yang
valid.

Jika kita menggunakan semua kombinasi, ada
![3 \times 3 \times 3 \times 3 \times 4 = 324](https://latex.codecogs.com/svg.latex?3%20%5Ctimes%203%20%5Ctimes%203%20%5Ctimes%203%20%5Ctimes%204%20%3D%20324 "3 \times 3 \times 3 \times 3 \times 4 = 324")
buah pilihan produk yang ada. Namun dengan *orthogonal design*, kita
hanya mendapatkan **22 pilihan produk saja**.

|     | Rasa          | Ukuran | Klaim          | Kemasan       | Harga    |
|:----|:--------------|:-------|:---------------|:--------------|:---------|
| 17  | Sedikit_Manis | 1000ml | Tanpa_Pengawet | Botol_Plastik | Rp4000   |
| 27  | Tidak_Manis   | 1000ml | Reguler        | Botol_Plastik | Rp4000   |
| 30  | Tidak_Manis   | 250ml  | Alami_100pct   | Botol_Kaca    | Rp4000   |
| 46  | Manis         | 250ml  | Reguler        | Botol_Kaca    | Rp4000   |
| 58  | Manis         | 500ml  | Alami_100pct   | Kotak_Karton  | Rp4000   |
| 86  | Sedikit_Manis | 500ml  | Alami_100pct   | Botol_Plastik | Rp7000   |
| 103 | Manis         | 500ml  | Reguler        | Botol_Plastik | Rp7000   |
| 111 | Tidak_Manis   | 250ml  | Alami_100pct   | Botol_Kaca    | Rp7000   |
| 124 | Manis         | 1000ml | Tanpa_Pengawet | Botol_Kaca    | Rp7000   |
| 146 | Sedikit_Manis | 250ml  | Tanpa_Pengawet | Kotak_Karton  | Rp7000   |
| 162 | Tidak_Manis   | 1000ml | Reguler        | Kotak_Karton  | Rp7000   |
| 172 | Manis         | 250ml  | Tanpa_Pengawet | Botol_Plastik | Rp12000  |
| 183 | Tidak_Manis   | 250ml  | Reguler        | Botol_Plastik | Rp12000  |
| 197 | Sedikit_Manis | 1000ml | Alami_100pct   | Botol_Kaca    | Rp12000  |
| 212 | Sedikit_Manis | 500ml  | Reguler        | Botol_Kaca    | Rp12000  |
| 223 | Manis         | 1000ml | Alami_100pct   | Kotak_Karton  | Rp12000  |
| 231 | Tidak_Manis   | 500ml  | Tanpa_Pengawet | Kotak_Karton  | Rp12000  |
| 244 | Manis         | 250ml  | Alami_100pct   | Botol_Plastik | Rp18.000 |
| 252 | Tidak_Manis   | 1000ml | Alami_100pct   | Botol_Plastik | Rp18.000 |
| 285 | Tidak_Manis   | 500ml  | Tanpa_Pengawet | Botol_Kaca    | Rp18.000 |
| 295 | Manis         | 1000ml | Reguler        | Botol_Kaca    | Rp18.000 |
| 317 | Sedikit_Manis | 250ml  | Reguler        | Kotak_Karton  | Rp18.000 |

### Langkah 3: Tampilan Kartu Survei

Setiap pilihan produk akan saya sebut sebagai **profil** dan akan
disajikan kepada responden sebagai sebuah ‘kartu produk’. Contoh satu
kartu:

|         | 17             |
|:--------|:---------------|
| Rasa    | Sedikit_Manis  |
| Ukuran  | 1000ml         |
| Klaim   | Tanpa_Pengawet |
| Kemasan | Botol_Plastik  |
| Harga   | Rp4000         |

Kemudian responden akan disuruh untuk memberikan *rating* (misalkan
1-10) di masing-masing kartu *survey*.

### Langkah 4: Membuat Data Responden Simulasi

Selanjutnya saya akan mensimulasikan 150 responden.


    Call:
    lm(formula = frml)

    Residuals:
        Min      1Q  Median      3Q     Max 
    -5,0386 -3,6561  0,1915  3,9614  4,4514 

    Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
    (Intercept)         5,751140   0,062438  92,110   <2e-16 ***
    factor(x$Rasa)1     0,063852   0,083769   0,762    0,446    
    factor(x$Rasa)2    -0,051871   0,091196  -0,569    0,570    
    factor(x$Ukuran)1  -0,003509   0,083769  -0,042    0,967    
    factor(x$Ukuran)2  -0,079649   0,091196  -0,873    0,383    
    factor(x$Klaim)1    0,035658   0,083769   0,426    0,670    
    factor(x$Klaim)2   -0,052982   0,091196  -0,581    0,561    
    factor(x$Kemasan)1  0,002463   0,083769   0,029    0,977    
    factor(x$Kemasan)2 -0,001703   0,083769  -0,020    0,984    
    factor(x$Harga)1   -0,088193   0,108625  -0,812    0,417    
    factor(x$Harga)2    0,038860   0,102384   0,380    0,704    
    factor(x$Harga)3    0,105526   0,102384   1,031    0,303    
    ---
    Signif. codes:  0 '***' 0,001 '**' 0,01 '*' 0,05 '.' 0,1 ' ' 1

    Residual standard error: 3,443 on 3288 degrees of freedom
    Multiple R-squared:  0,001001,  Adjusted R-squared:  -0,002341 
    F-statistic: 0,2996 on 11 and 3288 DF,  p-value: 0,9862

    [1] "Part worths (utilities) of levels (model parameters for whole sample):"
               levnms    utls
    1       intercept  5,7511
    2           Manis  0,0639
    3   Sedikit_Manis -0,0519
    4     Tidak_Manis  -0,012
    5           250ml -0,0035
    6           500ml -0,0796
    7          1000ml  0,0832
    8    Alami_100pct  0,0357
    9  Tanpa_Pengawet  -0,053
    10        Reguler  0,0173
    11  Botol_Plastik  0,0025
    12     Botol_Kaca -0,0017
    13   Kotak_Karton  -8e-04
    14         Rp4000 -0,0882
    15         Rp7000  0,0389
    16        Rp12000  0,1055
    17       Rp18.000 -0,0562
    [1] "Average importance of factors (attributes):"
    [1] 19,36 19,27 15,75 18,10 27,53
    [1] Sum of average importance:  100,01
    [1] "Chart of average factors importance"

## Visualisasi Hasil Conjoint

Keterbatasan yang Perlu Diperhatikan 1. Hypothetical bias. Responden
mungkin berperilaku berbeda dalam survei vs di toko nyata. CBC lebih
baik dari rating-based dalam hal ini, tapi gap tetap ada. 2. Atribut
yang tidak dimasukkan. Conjoint hanya mengukur atribut yang sudah kita
tentukan. Faktor seperti brand awareness, rekomendasi teman, atau
tampilan toko tidak tertangkap. 3. Interaksi antar atribut. Model dasar
conjoint mengasumsikan efek atribut independen (additive). Padahal,
‘Botol Kaca + Alami 100%’ mungkin memberikan efek sinergistis lebih
besar dari keduanya dijumlah. Perlu model interaction term. 4.
Heterogenitas preferensi. Rata-rata part-worth menyembunyikan variasi
antar segmen. Sebaiknya lakukan analisis per segmen (misal: usia, kota,
frekuensi konsumsi) atau gunakan Latent Class Conjoint. 5. Sample size.
Untuk traditional conjoint: minimal 50 responden. Untuk CBC: minimal
150-200 per segmen yang ingin dianalisis secara terpisah.

Penutup: Paksa Konsumen untuk Jujur Pertanyaan survei yang langsung —
‘Seberapa penting harga bagi Anda?’ — hampir selalu menghasilkan jawaban
yang tidak berguna. Semua penting, semua dapat skor 5. Conjoint Analysis
memecahkan masalah ini dengan cara yang elegan: paksa konsumen untuk
membuat trade-off, lalu hitung sendiri berapa nilai implisit setiap
atribut dari pola pilihan mereka. Hasilnya jauh lebih actionable: bukan
‘konsumen menyukai rasa enak dan harga murah’, tapi ‘konsumen bersedia
membayar Rp3.500 lebih mahal jika kemasannya botol kaca, dan klaim Alami
100% berkontribusi 35% dari keputusan beli mereka’. Dengan R dan
beberapa package yang sudah tersedia, analisis yang dulu hanya bisa
dilakukan oleh firma riset besar dengan software mahal kini bisa
dilakukan sendiri — dengan kontrol penuh atas desain, data, dan
interpretasi.
