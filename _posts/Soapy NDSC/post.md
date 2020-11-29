---
date: 2020-11-28T20:00:00-04:00
title: "Belajar Banyak Dari Shopee National Data Science Competition 2020"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Image Processing
  - Image Classifier
  - TensorFlow
  - Image
  - Image Recognition
  - KERAS
  - Neural Network
  - Deep Learning
  - Machine Learning
  - Shopee
  - NDSC
  - Kaggle
---


Sore ini adalah akhir dari rangkaian acara **Shopee National Data
Science Competition 2020**. Suatu kompetisi yang sangat seru dan berbeda
dengan [kompetisi *data science* yang
dulu](https://passingthroughresearcher.wordpress.com/2018/11/15/belajar-dari-finhacks-id-2018/)
pernah saya ikuti. Walaupun *gak* menang dan hanya mendapatkan peringkat
yang *gak* sebegitu bagusnya, saya ingin bercerita mengenai pengalaman
seru ini.

-----

# Pendaftaran

Di awal tahun 2020, ada salah seorang teman kuliah saya dulu di
Matematika ITB 2004 mengirimkan pesan *WhatsApp*. Ia menginformasikan
bahwa ada kompetisi *data science* yang akan diselenggarakan oleh Shopee
pada bulan Maret 2020. Kompetisi itu bertajuk *National Data Science
Competition* (NDSC). Ada `2` kelas yang dipertandingkan:

1.  *Beginner*.
2.  *Advance*.

Kompetisi itu bisa diikuti secara perorangan dan tim. Sebagaimana
pengalaman saya di kompetisi sebelumnya, alangkah lebih baik jika
mengikutinya secara tim. Oleh karena itu, kami coba mencari lagi siapa
yang bisa diajak kolaborasi bareng. Dapatlah `2` orang tambahan:

1.  Satu orang merupakan teman seangkatan kami dulu.
2.  Satu orang lainnya merupakan rekan kerja teman saya yang
    menginformasikan adanya kompetisi.

Setelah membentuk tim, kami mendaftar. Awalnya, kami kira bisa mendaftar
di kelas *beginner*, ternyata pada saat pendaftaran, tim panitia dari
Shopee benar-benar menyeleksi peserta dengan ketat. Singkat cerita, kami
(terpaksa) mendaftar di kelas *advance*.

> Tenang saja, rekan kerja saya yang satu ini jago banget kok.

Ujar teman saya itu. *Hehe*

-----

# Pandemi Covid

Tidak disangka pada bulan Maret 2020, negara api (baca: pandemi Covid
19) menyerang Indonesia. Perhelatan yang awalnya akan dilakukan dengan
cara `karantina` peserta di suatu tempat selama seharian penuh ternyata
diundur ke waktu yang tidak bisa ditentukan.

Sampai akhirnya pada awal bulan November 2020, *email* surat cinta
itupun datang.

Kompetisi akan tetap digelar secara *online* menggunakan platform
**Kaggle** pada `28 November 2020`. Lalu semua tim diharapkan untuk bisa
mendaftar ulang jika ada perubahan komposisi anggota.

Nah, pada waktu ini, rekan kerja teman saya itu tiba-tiba menghilang
dari grup *WhatsApp* yang kami bentuk.

> *But the show must go on(line)\!*

*Bismillah*, kami tetap maju dengan komposisi yang ada. *Toh* niat kita
awalnya bukan untuk menang tapi untuk mencari pengalaman saja.

-----

# *Pre Competition*: 22 November 2020

Seminggu tepat sebelum hari kompetisi, ada *email* surat cinta lagi.
Setiap tim diwajibkan mengikuti *pre competition* yang diadakan di
**Kaggle**. Apa itu?

## *Problem Statement*

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

*Shopee* mengedepankan *fairness* terhadap semua barang yang dijual oleh
*seller*-nya. Bisa jadi sepasang barang memiliki *title* berbeda dan
poto yang sedikit berbeda TAPI pada kenyataannya merupakan sepasang
barang yang sama.

> Mungkin selama ini kita hanya mengetahui *fraud* berupa penipuan yang
> ada di *marketplace*. Bisa jadi *fraud* dilakukan dengan cara yang
> halus semacam ini.

Jadi tujuan *pre competition* kali ini adalah membuat model *machine
learning* yang bisa memprediksi apakah sepasang barang merupakan barang
yang sama atau beda dengan bermodalkan informasi:

1.  Sepasang *titles* barang.
2.  Sepasang *images* barang.

Data yang digunakan murni hanya `6` variabel saja\!

    ## [1] "Contoh dataset yang diberikan:"

    ##   X
    ## 1 0
    ## 2 1
    ## 3 2
    ## 4 3
    ## 5 4
    ##                                                                                          title_1
    ## 1                                                  Johnson’s ® Top to Toe Hair & Body Bath 500ml
    ## 2                                                                                  Sandal Humble
    ## 3                                PROMO LIKUID LIKUIT LIQUIT BABY POD LIQUID SALT POD 15ML 10RASA
    ## 4 6 Pasang / Set Anting Tusuk Bentuk Lingkaran Aksen Mutiara + Rumbai Gaya Bohemian untuk Wanita
    ## 5   ROREC NATURAL SKIN CARE MASK ROREC SHEET MASK MASKER WAJAH MASK SHEET MASKER TOPENG SKINCARE
    ##                                image_1
    ## 1 fdff8b9b8229da091dd7d070aae05f81.jpg
    ## 2 906cc44f0be72d4e767669b5b63e3a17.jpg
    ## 3 475c26635de18b9f93032400732ff336.jpg
    ## 4 e630997f6217555d6026547ad1c15f0b.jpg
    ## 5 a27d11700a7902febd039dc3a96f10f2.jpg
    ##                                                                                             title_2
    ## 1                                     Johnson's cottontouch top to toe hair & body baby bath 500 ml
    ## 2                                                                    Sandal Humble Glass - Glanzton
    ## 3   Voporizer Liquit - Likuit - Likuid - Liquid Premium Berry Banana Mochi 60ML 3MG - Bananalicious
    ## 4 Subei 6 Pasang / Set Anting Tusuk Boho Bohemia Desain Geometri Hias Kristal / Rumbai untuk Wanita
    ## 5                                                 Rorec 86 Natural Skin Care Shert Mask All Variant
    ##                                image_2 Label
    ## 1 41e191742760932598c7bd201e5dad47.jpg     0
    ## 2 7a556b836bfdd08ea592216440524a34.jpg     0
    ## 3 ace93bec689f3f1565800c500a8341fa.jpg     0
    ## 4 31abbc176b09f5bd1728cfc3ecbbfb9c.jpg     0
    ## 5 813ad9dd638c10f1765db9dde20c9e42.jpg     1

Dataset di atas ada `10.181` baris. Sedangkan data *images* melebihi 1
GB ukurannya.

### Bagaimana cara menyelesaikannya?

Melihat data di atas, kami murni menghadapi *unstructured data*. Jadi
langkah awal yang harus kami lakukan adalah mengekstrak *features*
variabel *titles* dan *images*. Tentunya variabel *titles* harus
dibersihkan dulu dari tanda baca yang tidak diperlukan.

Setelah berdiskusi, maka ada beberapa *features* yang akan kami ekstrak:

  - *Titles*
      - Berapa banyak kata dari dua *titles* barang?
      - Berapa banyak karakter dari dua *titles* barang?
      - Berapa banyak kata yang sama dari dua *titles* barang?
      - Berapa banyak *n-grams* dari dua *titles* barang? Terkait
        *n-grams* ini, kami sampai menghitung kesamaan **bigrams**
        hingga **7-grams**.
      - Berapa banyak angka yang sama dari dua *titles* barang?
      - Berapa banyak huruf yang sama dari dua *titles* barang? Ini kami
        hitung dari huruf **a** sampai **z**.
      - Berapa jarak relatif antara dua vektor *character* dari dua
        *titles* barang?
      - Berapa jarak relatif antara dua vektor *character* dari dua
        *titles* barang (setelah dihilangkan semua angka)?
  - *Images*. Ternyata apa yang saya lakukan [beberapa waktu
    lalu](https://ikanx101.com/blog/comparison-improvement/) saat
    *ngoprek* data *images* sangat berguna sekali.
      - Menghitung korelasi dari dua matriks *images*.
      - Menghitung proporsi kesamaan dua matriks *images* untuk berbagai
        nilai sensitivitas.

Jadi kami fokus untuk mengekstrak semua informasi yang bisa diekstrak
dari hari Minggu sampai Kamis (26 November 2020).

Singkat cerita, dari 4 variabel penting (2 *titles* dan 2 *images*),
kami berhasil mendapatkan `48` *features*.

> *Features* itu apa sih? Secara simpel, *features* bisa saya katakan
> sebagai variabel numerik.

Oh iya, untuk mengekstrak *features* dari `10.181` pasang *images*, saya
membutuhkan waktu `1` jam penuh.

### Membuat model *machine learning*

Ada hal yang menarik saat kami mulai mengerjakan *pre competition* ini.
Pihak *Shopee* merekomendasikan para peserta untuk menggunakan
**Phyton** daripada bahasa *data science* lainnya.

Kami sebagai *R User* garis keras merasa tertantang untuk tetap
mengerjakannya dengan **R**. Ada satu dugaan dari saya:

> Jangan-jangan solusinya menggunakan deep learning.

Kenapa? Karena [*TensorFlow*](https://ikanx101.com/blog/deep-nutrisari/)
yang digunakan untuk *Artificial Neural Network* dibangun berbasis
*Phyton*.

Harusnya tidak masalah, karena *TensorFlow* bisa digunakan di **R**
juga.

Saya akhirnya mencoba membuat model *deep learning*, sementara teman
saya yang lain *ngoprek* *Support Vector Machine* dan *XGBLinear*.

Hasilnya bagaimana?

Kami masih belum puas dengan *score* yang dihasilkan saat dilakukan
validasi.

### *Submission* Jawaban Pertama: 26 November 2020

Di Kamis pagi, saya coba iseng membuat model *machine learning*
menggunakan *Random Forest Algorithm*. Tanpa disangka, *validation
score* yang saya dapatkan lebih tinggi dibandingkan model *deep
learning* yang saya buat sebelumnya.

Saat saya coba masukkan `data test pre competition` ke dalam model, lalu
saya *submit* ke *Kaggle*, saya terkejut karena mendapatkan nilai yang
cukup tinggi: `0.89583` (max nilai = 1).

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Walaupun tidak termasuk ke dalam `10` besar, tapi *score* `0.89583`
masuk ke dalam **TOP 5** *score* teratas.

Kok bisa?

> Jadi ada beberapa tim yang memiliki *score* yang sama.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-4-1.png" width="672" />

Pada *pre competition* ini, ada 121 buah tim yang berkompetisi.

Sebagai orang yang biasa berkutat terkait otomasi di **R**, mendapatkan
*prediction score* segitu sudah membahagiakan bagi saya pribadi.

Analoginya seperti seorang tukang gado-gado yang memasak *beef
wellington* dan diberikan pujian *good effort* oleh **Gordon Ramsay**.
*hehe*.

-----

# *Competition Day*: 28 November 2020

Akhirnya hari yang dinanti datang juga. Acara dimulai pada pukul 10.00
WIB dengan sambutan-sambutan dari pihak *Shopee* dan Menristek
(Prof. Bambang Brodjonegoro).

Seperti biasa, saat dibuka forum *QnA* di *live chat* *Zoom*, ada saja
pertanyaan-pertanyaan kocak yang ditanyakan para peserta iseng. Berikut
skrinsutnya:

    ## [1] "Boleh pakai excel?"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

    ## [1] "Boleh telepon rekan setim?"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

    ## [1] "Apakah perlu kirim installernya?"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-5-3.png)<!-- -->

    ## [1] "Mimin apa kabar?"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-5-4.png)<!-- -->

Pada sesi *QnA* ini, ternyata *Shopee* memperbolehkan penggunaan bahasa
lain seperti **R** dan *Matlab*.

Setiap tim hanya diperbolehkan melakukan `5` kali *submission* jawaban.

### Pukul 11.00 WIB

Kompetisi kelas dimulai tepat pukul 11.00 WIB via *Kaggle*. Ternyata
masalah yang dihadapi masih sama seperti masalah di *pre competition*.

Berikut adalah data yang digunakan pada kompetisi tadi siang:

    ##    pair_index
    ## 1           0
    ## 2           1
    ## 3           2
    ## 4           3
    ## 5           4
    ## 6           5
    ## 7           6
    ## 8           7
    ## 9           8
    ## 10          9
    ##                                                                           title_1
    ## 1                                              Celana Chino Panjang Original Motz
    ## 2                                     [BISA COD] Tas LOL Boneka Flash Anak Ransel
    ## 3                                           KOYO AJAIB KINOKI GOLD paket Standard
    ## 4                    Zwitsal Natural Aloe Vera Baby Bath 2 In 1 Hair & Body 300Ml
    ## 5  TAS IMPORT JAKARTA CLASSIC DIAMOND JELLY MATTE UK18 TSMD18D FREE BONEKA + SYAL
    ## 6                               Celana Pendek SPA / pinggang karet / banyak warna
    ## 7  BL - RINGER Baju Atasan Kaos T-Shirt Polos Lengan Pendek Murah Wanita Kekinian
    ## 8                                  Bella Square "warna part 1" || hijab segiempat
    ## 9                            Kaos Polos Lengan Panjang 100%ASLI Cotton Combed 30S
    ## 10     [Luckymama] Refill Tinta Pen Isi Ulang 2.65 Diameter Dalam Ketebalan 0.5mm
    ##                                 image_1
    ## 1  6985a78ebd6b7d9f120f852b412bba5b.jpg
    ## 2  4d6f929847cbe632b15baa556646a414.jpg
    ## 3  e21056441f03442737a2c074a4ab232d.jpg
    ## 4  3ac880adf8ffbcf23846554efc052694.jpg
    ## 5  4ddd79c9d601bd25c1a56e0a10fb5708.jpg
    ## 6  0725bd15d097baa9b255048fc5e5f35e.jpg
    ## 7  55ab1f8ce557dd6ac09731be7c4ba8f9.jpg
    ## 8  21edf3f9682e7a768eb58633accf491a.jpg
    ## 9  18be8c0268e525e0824af2b5ff30554f.jpg
    ## 10 53a3e400e80fc5ac36e8b586150c4306.jpg
    ##                                                                                              title_2
    ## 1                                                                 Celana Chino Panjang Original Motz
    ## 2                                   Bisa Cod Tas Lol Boneka Mewah Anak Ransel Tas Troli Paud 10 Inch
    ## 3          BL - V.PJG Baju Kaos Vneck Polos Lengan Panjang T-Shirt Basic Murah Wanita/Cewek Kekinian
    ## 4                                          ZWITSAL Natural Baby Bath 2 in 1 Hair & Body bottle 300ml
    ## 5                    TAS IMPORT JAKARTA CLASSIC DIAMOND JELLY MATTE UK18 TSMD18D FREEE BONEKA + SYAL
    ## 6                          [Bayar Di Tempat]Kacamata Baca Frame Metal Gaya Retro untuk Pria / Wanita
    ## 7   Pengiriman Cepat RINGER Baju Polos Basic Wanita Lengan Pendek Ukuran Jumbo XXL - Hitam L ON SALE
    ## 8                                                                              Bella Square "Part 1"
    ## 9                                              kaos polos lengan panjang cotton combed 30s ASLI 100%
    ## 10 [Bayar Di Tempat] 20 Pcs Gel Pena Isi Ulang Tinta Jarum Tubing 0.5mm Penpoint Perlengkapan Kantor
    ##                                 image_2
    ## 1  81f8fab965d009483d004af0c697dd97.jpg
    ## 2  1e2facde94db9de3037741ec4a5313c8.jpg
    ## 3  7b91ab6c71c6e9ed432201f12379509c.jpg
    ## 4  46b00a7c6a869e00cad8cc08fb56a2f7.jpg
    ## 5  10a97ae389e298f72bc455aa4cb4fba7.jpg
    ## 6  534a3b33ee6be1fb2decd0a37d138314.jpg
    ## 7  13861e21510f93b63119ca31ec98e3e4.jpg
    ## 8  29ce011415b276b0ed0831f53dedbaec.jpg
    ## 9  45099648d9cb8530bf47de39be6e1a5e.jpg
    ## 10 3c0a9e9c20c55e524f6ae4159ea869cd.jpg

Ada `32.580` baris pasang data beserta 2 GB *images* yang harus
diselesaikan selama `3` jam.

Awalnya kami akan menggunakan model *random forest* dan *XGBLinear*
kemarin yang sudah jadi dengan beberapa modifikasi penambahan beberapa
*features* pada variabel *character*.

Jadi ada dua hal yang kami kerjakan terkait variabel *titles*:

1.  Menghapus *stopwords* (Indonesia dan *English*).
2.  Menghitung `tf_idf`.

Secara paralel, saya mengekstrak *features* dari `32.580` pasang
*images*.

### Pukul 12.46

Saya sudah selesai menyelesaikan masalah *stopwords*, sementara rekan
saya yang lain telah menyelesaikan masalah `tf_idf`.

Namun saya baru menyadari suatu hal penting:

> Kemarin, untuk mengekstrak 10 ribu pasang *images* saya butuh waktu
> sejam.

Kini dengan banyaknya pasang *images* yang tiga kali lipat, maka akan
dibutuhkan waktu `3` jam.

**Bisa jadi kami tidak akan menyelesaikan kompetisi ini tepat waktu\!**

    ## [1] "Chat insecure di grup WA"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

### Pukul 13.21 WIB

Ternyata benar, sampai tersisa 40 menit lagi saya masih belum selesai
mengekstrak *features* dari *images* tersebut. Laptop saya hanya sempat
menghitung matriks korelasi dari pasangan *images*.

> Cuma 1 *feature* dari total 7 *features* yang direncanakan.

Akhirnya kami membuat keputusan untuk menggunakan *features* seadanya
saja dan membuat model kembali dari *scratch*.

Karena saya sempat panik, akibatnya *training dataset* yang jadi acuan
antara saya dan rekan-rekan satu tim putus.

Akibatnya saya dan rekan akhirnya `berpisah` untuk membuat model
sendiri-sendiri. Siapa yang tercepat dan percaya bahwa modelnya
memberikan *validation score* terbaik dipersilakan untuk *submit*
jawaban.

Saya coba buat kembali model *machine learning* menggunakan *Random
Forest Algorithm*. Pede dengan *validation score*-nya,saya coba *submit*
jawaban.

    ## [1] "Chat insecure di grup WA"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

Hasilnya tim kami mendapatkan score `0.37905`.

Beberapa menit berselang, rekan setim saya yang lain mencoba submit
jawaban dan hasilnya tetap sama-sama buruk `0.37106`.

> *Hopeless*…

Walaupun tidak ada niatan untuk menang TAPI tidak juga gugur dengan
nilai yang buruk seperti ini.

### Pukul 13.42 WIB

Setelah beristirahat sejenak, saya mulai berpikir.

> Kenapa *gak* pakai *deep learning* saja *yah*? Barangkali bagus.

Dalam waktu seadanya, saya coba *build deep learning* model di
**TensorFlow**. Saking *ngasal*-nya, saya hanya buat `3` *layers*:

1.  *Layer* pertama berisi *nodes* sebanyak tahun kelahiran saya.
2.  *Layer* kedua berisi *nodes* sebanyak tanggal lahir saya.
3.  *Layer* ketiga berisi *nodes* sebanyak tanggal lahir istri saya.

Lalu saya set *epoch* (iterasi) sebanyak `20` kali saja. Lalu hasil
prediksinya saya *submit*.

> Hasilnya ternyata menggembirakan\!

*Score* kami naik jadi `0.66994`.

    ## [1] "Chat insecure di grup WA"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

### Pukul 13.57 WIB

Mendekati menit-menit akhir, setelah saya mengetahui bahwa *deep
learning* model memberikan *score* yang lebih baik, saya coba *fine
tuning* kembali beberapa parameternya.

Sementara, rekan tim saya juga sudah berhasil membuat model lain dengan
*XGBoost Algorithm*.

Dalam waktu yang relatif sama, kami sama-sama *submit* jawaban final.

Keduanya memiliki *score* yang mirip-mirip, sekitar `0.73`.

    ## [1] "Kenaikan score di akhir waktu"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

### Pukul 14.00 WIB ENDING

Akhirnya waktu menunjukkan pukul 14.00 WIB. Panitia mengumumkan bahwa
*submission* telah berakhir.

Kini,posisi tim saya adalah sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Soapy%20NDSC/post_files/figure-gfm/unnamed-chunk-11-1.png" width="672" />

Dari total 137 buah tim yang berkompetisi di hari ini.

-----

# Summary

## *Key take points*

1.  Kami tidak pernah berpikir bahwa kompetisi kali ini tetap melibatkan
    data *images* dengan jumlah yang sangat besar. Jika mengetahuinya,
    mungkin kami bisa memodifikasi *function* pembacaan *images*
    sehingga secara komputasi bisa lebih cepat.
2.  Tanpa disengaja saya *build* dan *fine tune* *deep learning model*
    secepat kilat dengan hasil yang tidak mengecewakan. Tentunya ini
    akan menjadi bahasan yang bisa diulik di kemudian hari.
3.  Walaupun diadakan secara virtual (dimana banyak distraksi di
    sana-sini), tapi keseruan dan greget kompetisi ini *dapet banget*.

> It is such a great experience for us\!
