---
date: 2020-07-23T09:10:00-04:00
title: "Data Science di Bidang Kesehatan"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Data Science
  - Kesehatan
  - Penyakit
  - Health
  - ROC
  - AUC
  - Prediction
  - Prediksi
  - Confusion Matrix
---

# 12 July 2020

Saat mengisi webinar di @urun.id, ada salah seorang peserta yang
bertanya mengenai aplikasi *data science* di bidang kesehatan. Saya
menjawab dengan beberapa contoh yang saya ketahui dari artikel, jurnal,
dan tulisan rekan-rekan *data scientist* lainnya.

> Mmh, kalau dipikir-pikir, baru sekali saya bersinggungan dengan data
> kesehatan. Itu pun hanya terkait perapihan data saja. Tanpa analisa
> apa-apa.

# 22 July 2020

Mendekati adzan maghrib, muncul notifikasi di WhatsApp saya dari nomor
yang tidak dikenal. Nomor ini beririsan dengan saya di grup alumni SMA.

> Wah, teman SMA nih.

Sang pengirim pesan memperkenalkan dirinya (sebut saja Mawar). Dia
sekarang bekerja di bidang kesehatan dan sedang melakukan penelitian
terkait biomarker untuk mendeteksi suatu penyakit. Entah kenapa saya
yang dihubungi oleh dirinya.

Saya sempat bertanya ke nyonya (kebetulan saya dan nyonya dulu satu SMA
juga). Ternyata nyonya gak kenal juga ama Mawar ini. *Hahaha*.

Mawar bercerita, bahwa saat ini dia sedang mengembangkan dua biomarker.
Apa sih biomarker itu?

> Biomarker is a measurable substance in an organism whose presence is
> indicative of some phenomenon such as disease, infection, or
> enviromental exposure.

Diharapkan salah satu dari kedua biomarker tersebut bisa dengan akurat
memprediksi seseorang terkena suatu penyakit atau tidak. Konon katanya
pengukuran biomarker ini jauh lebih mudah, murah, dan cepat dibandingkan
diagnosis pada umumnya.

## Ini menguji atau murni bertanya?

Mengingat latar belakang dari teman saya ini, lantas saya bertanya dalam
hati.

> Jangan-jangan teman saya ini hanya menguji saya aja nih… *Hahaha*

Singkat cerita, dia memberikan saya data seperti ini:

| diagnosis | biomarker1 | biomarker2 |
| :-------: | :--------: | :--------: |
|   Tidak   |    5.79    |   20.25    |
|   Tidak   |    8.43    |   33.45    |
|   Tidak   |    7.70    |   32.35    |
|   Tidak   |    5.73    |   21.95    |
|   Tidak   |   10.29    |   56.15    |
|   Tidak   |   12.58    |   43.25    |
|   Tidak   |    3.36    |    9.75    |
|   Tidak   |    3.80    |   13.25    |
|   Tidak   |    4.01    |   13.95    |
|   Tidak   |    4.23    |   16.95    |

Contoh Data Biomarker (10 Data Teratas)

Kemudian dia memberikan pertanyaan:

> Kalau pakai analisa **ROC**, berapa *cut off points* dari
> masing-masing biomarker? Biomarker mana yang lebih bagus? Apakah
> biomarker ini sudah baik untuk menggantikan diagnosis yang sebelumnya
> dilakukan?

## Analisa ROC

Menarik bahwa yang dilakukan adalah *straight to the point* langsung ke
**ROC**. Awalnya saya membayangkan untuk membuat model terlebih dahulu
yang menggambarkan hubungan antara `biomarker ~ diagnosis` dengan
*loglinear regression* atau model lainnya.

Tapi karena pertanyaannya adalah langsung menusuk menuju **ROC**
yasudahlah.

### Apa sih [ROC](https://en.wikipedia.org/wiki/Receiver_operating_characteristic) itu?

> A receiver operating characteristic curve, or ROC curve, is a
> graphical plot that illustrates the diagnostic ability of a binary
> classifier system as its discrimination threshold is varied.

Contoh:

![](https://upload.wikimedia.org/wikipedia/commons/6/6b/Roccurves.png)<!-- -->

# Bahasa Manusianya Gimana?

Oke, mungkin penjelasan saya sebelumnya agak sulit untuk dimengerti.
Saya coba jelaskan dengan simpel *yah*:

Jadi coba kita lagi datanya:

| diagnosis | biomarker1 | biomarker2 |
| :-------: | :--------: | :--------: |
|   Tidak   |    5.79    |   20.25    |
|   Tidak   |    8.43    |   33.45    |
|   Tidak   |    7.70    |   32.35    |
|   Tidak   |    5.73    |   21.95    |
|   Tidak   |   10.29    |   56.15    |
|   Tidak   |   12.58    |   43.25    |
|   Tidak   |    3.36    |    9.75    |
|   Tidak   |    3.80    |   13.25    |
|   Tidak   |    4.01    |   13.95    |
|   Tidak   |    4.23    |   16.95    |

Contoh Data Biomarker (10 Data Teratas)

Menggunakan analisa **ROC**, tujuan analisa ini adalah:

1.  Bagaimana caranya dari data numerik berupa kadar `biomarker1` dan
    `biomarker2` bisa digunakan untuk menebak diagnosis penyakit?
2.  Pada kadar berapa `biomarker1` dan `biomarker2` bisa untuk
    memisahkan pasien tersebut `sakit` atau `tidak`?

## Oke, saya coba jawab yah\!

Hal pertama yang akan saya lakukan adalah membuat **ROC Curve** lalu
menghitung *Area Under Curve* (AUC). **AUC** ini adalah nilai yang
memberikan indikasi \_goodness of fit\_\_ apakah suatu variabel bisa
digunakan untuk menebak variabel lain. **AUC** ini juga yang biasa
dijadikan acuan dalam setiap kompetisi *data science*. Semakin nilainya
menuju `1`, maka akan semakin bagus hasil prediksinya.

### `Biomarker1`

    ##                            
    ##  Method used: empirical    
    ##  Number of positive(s): 229
    ##  Number of negative(s): 454
    ##  Area under curve: 0.7735

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/kesehatan%20ROC/2020-07-23-kesehatan-ro_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

### `Biomarker2`

    ##                            
    ##  Method used: empirical    
    ##  Number of positive(s): 229
    ##  Number of negative(s): 454
    ##  Area under curve: 0.8375

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/kesehatan%20ROC/2020-07-23-kesehatan-ro_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

#### Kesimpulan dari nilai AUC

Dari nilai `AUC` kedua **ROC Curve** di atas, `biomarker2` menunjukkan
angka yang terbaik dibandingkan `biomarker1`. Oleh karena itu, dugaan
saya: `biomarker2` memiliki kemampuan lebih baik untuk mendiagnosis
penyakit dibandingkan `biomarker1`.

### *Cut Off Points*

Dari data numerik `biomarker1` dan `biomarker2`, saya akan menentukan
batas berapa kadar bisa dibilang `sakit` dan `tidak sakit`. Untuk itu,
saya akan menggunakan [Youden’s J
statsitic](https://en.wikipedia.org/wiki/Youden%27s_J_statistic), yakni:

  
![J=sensitivity+specificity-1](https://latex.codecogs.com/png.latex?J%3Dsensitivity%2Bspecificity-1
"J=sensitivity+specificity-1")  

*Cut off points* akan dipilih saat nilai
![J](https://latex.codecogs.com/png.latex?J "J") mencapai maksimum.

### Biomarker1

    ##                            
    ##  Method used: empirical    
    ##  Number of positive(s): 229
    ##  Number of negative(s): 454
    ##  Area under curve: 0.7735

*Cut off points* untuk `biomarker1` terjadi pada 6.23, saat **TPR** =
0.8165939; **FPR** = 0.407489 sehingga menghasilkan
![J=](https://latex.codecogs.com/png.latex?J%3D "J=") 0.4091.

### Biomarker2

    ##                            
    ##  Method used: empirical    
    ##  Number of positive(s): 229
    ##  Number of negative(s): 454
    ##  Area under curve: 0.8375

*Cut off points* untuk `biomarker2` terjadi pada 29.85, saat **TPR** =
0.7510917; **FPR** = 0.2202643 sehingga menghasilkan
![J=](https://latex.codecogs.com/png.latex?J%3D "J=") 0.5308.

Dari *cut off points* tersebut, saya membuat *rules* yakni jika kadar
`biomarker` ![\\geq](https://latex.codecogs.com/png.latex?%5Cgeq
"\\geq") *cut off points* maka akan ditulis `sakit`. Sedangkan jika
kadar `biomarker` \< *cut off points* maka akan ditulis `tidak sakit`.

## *Confusion Matrix*

Sekarang saya akan buat *confusion matrix* dari hasil transformasi
tersebut lalu kita komparasi nilai
![precision](https://latex.codecogs.com/png.latex?precision "precision")
dan ![recall](https://latex.codecogs.com/png.latex?recall "recall").

Misalkan ![precision](https://latex.codecogs.com/png.latex?precision
"precision") saya definisikan sebagai:

  
![precision=\\frac{jumlah.pasien.diprediksi.sakit.benar}{jumlah.pasien.diprediksi.sakit}](https://latex.codecogs.com/png.latex?precision%3D%5Cfrac%7Bjumlah.pasien.diprediksi.sakit.benar%7D%7Bjumlah.pasien.diprediksi.sakit%7D
"precision=\\frac{jumlah.pasien.diprediksi.sakit.benar}{jumlah.pasien.diprediksi.sakit}")  

Sedangkan ![recall](https://latex.codecogs.com/png.latex?recall
"recall") saya definisikan sebagai:

  
![recall=\\frac{jumlah.pasien.diprediksi.sakit.benar}{jumlah.pasien.sakit}](https://latex.codecogs.com/png.latex?recall%3D%5Cfrac%7Bjumlah.pasien.diprediksi.sakit.benar%7D%7Bjumlah.pasien.sakit%7D
"recall=\\frac{jumlah.pasien.diprediksi.sakit.benar}{jumlah.pasien.sakit}")  

### `Biomarker1`

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction Tidak  Ya
    ##      Tidak   269  42
    ##      Ya      185 187
    ##                                           
    ##                Accuracy : 0.6676          
    ##                  95% CI : (0.6309, 0.7029)
    ##     No Information Rate : 0.6647          
    ##     P-Value [Acc > NIR] : 0.4534          
    ##                                           
    ##                   Kappa : 0.3543          
    ##                                           
    ##  Mcnemar's Test P-Value : <2e-16          
    ##                                           
    ##             Sensitivity : 0.5925          
    ##             Specificity : 0.8166          
    ##          Pos Pred Value : 0.8650          
    ##          Neg Pred Value : 0.5027          
    ##              Prevalence : 0.6647          
    ##          Detection Rate : 0.3939          
    ##    Detection Prevalence : 0.4553          
    ##       Balanced Accuracy : 0.7046          
    ##                                           
    ##        'Positive' Class : Tidak           
    ## 

### `Biomarker2`

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction Tidak  Ya
    ##      Tidak   354  57
    ##      Ya      100 172
    ##                                           
    ##                Accuracy : 0.7701          
    ##                  95% CI : (0.7367, 0.8012)
    ##     No Information Rate : 0.6647          
    ##     P-Value [Acc > NIR] : 1.125e-09       
    ##                                           
    ##                   Kappa : 0.5072          
    ##                                           
    ##  Mcnemar's Test P-Value : 0.0008024       
    ##                                           
    ##             Sensitivity : 0.7797          
    ##             Specificity : 0.7511          
    ##          Pos Pred Value : 0.8613          
    ##          Neg Pred Value : 0.6324          
    ##              Prevalence : 0.6647          
    ##          Detection Rate : 0.5183          
    ##    Detection Prevalence : 0.6018          
    ##       Balanced Accuracy : 0.7654          
    ##                                           
    ##        'Positive' Class : Tidak           
    ## 

#### Kesimpulan *Confusion Matrix*

`Biomarker1` memberikan
![precision=](https://latex.codecogs.com/png.latex?precision%3D
"precision=") 50.27 dan
![recall=](https://latex.codecogs.com/png.latex?recall%3D "recall=")
81.66.

`Biomarker2` memberikan
![precision=](https://latex.codecogs.com/png.latex?precision%3D
"precision=") 63.24 dan
![recall=](https://latex.codecogs.com/png.latex?recall%3D "recall=")
75.11.

# Opini Final

Melihat dari **AUC**, sebenarnya `biomarker2` cukup bagus dibandingkan
dengan `biomarker1`. Tapi dari nilai *precision* dan *recall* saya tidak
merekomendasikan sama sekali kedua `biomarker` untuk digunakan.

> Saya gak mau ada misklasifikasi dari hasil `biomarker` ini. Kalau cuma
> sakit panu sih gapapa, tapi untuk **penyakit** yang satu ini, *enggak
> lah yah*.
