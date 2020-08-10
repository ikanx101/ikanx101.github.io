---
date: 2020-06-20T05:00:00-04:00
title: "Membuat Alat Rapid Test COVID-19"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Innovation
  - R
  - Covid-19
  - Covid 19
  - Corona Virus
---

Beberapa orang peneliti sedang mengembangkan dua alat pendeteksi cepat
COVID-19. Cara kerja alat ini adalah untuk mendeteksi kadar *biomarker*
dalam darah.

Apa sih *biomarker* itu?

> *Biomarker is a measurable substance in an organism whose presence is
> indicative of some phenomenon such as disease, infection, or
> enviromental exposure.*

Diharapkan salah satu dari kedua *biomarker* tersebut bisa dengan akurat
menentukan seseorang terkena COVID-19.

Berikut adalah datanya:

| id | diagnosis | biomarker1 | biomarker2 |
| -: | :-------- | ---------: | ---------: |
|  1 | Tidak     |     11.656 |     20.140 |
|  2 | Tidak     |     12.039 |     20.077 |
|  3 | Tidak     |     11.272 |     18.537 |
|  4 | Ya        |     34.551 |     34.563 |
|  5 | Ya        |      8.746 |     16.688 |
|  6 | Tidak     |      9.643 |     15.163 |
|  7 | Ya        |     18.953 |     31.041 |
|  8 | Tidak     |      8.413 |     12.487 |
|  9 | Ya        |     10.428 |     16.930 |
| 10 | Ya        |      6.740 |     11.335 |

10 Data Pertama dari Data Biomarker

### *Problem Statements*

1.  Berapa *cut off points* dari masing-masing *biomarker*? Maksudnya
    pada level berapa kadar *biomarker* bisa mengatakan positif
    COVID-19? Pada level berapa kadar *biomarker* bisa mengatakan
    negatif COVID-19? Misalkan jika kadar `biomarker1`
    ![\\geq 10](https://latex.codecogs.com/png.latex?%5Cgeq%2010
    "\\geq 10") maka pasien disebut positif COVID-19 sedangkan
    kebalikannya negatif.
2.  *Biomarker* mana yang lebih bagus?
3.  Apakah kedua atau salah satu *biomarker* ini sudah baik untuk
    menggantikan diagnosis yang sebelumnya dilakukan?

Untuk semua pertanyaan di atas, mari kita lakukan analisa berikut ini:

### Analisa ROC

Definisi
[ROC](https://en.wikipedia.org/wiki/Receiver_operating_characteristic)
itu?

> *A receiver operating characteristic curve, or ROC curve, is a
> graphical plot that illustrates the diagnostic ability of a binary
> classifier system as its discrimination threshold is varied.*

Menggunakan ROC ini, ada dua informasi yang bisa saya dapatkan:

1.  Menentukan *cut off points* untuk masing - masing *biomarker*.
2.  Membuat **ROC Curve** lalu menghitung *Area Under Curve* (AUC).
    **AUC** ini adalah nilai yang memberikan indikasi *goodness of fit*
    apakah suatu variabel bisa digunakan untuk menebak variabel lain.
    **AUC** ini juga yang biasa dijadikan acuan dalam setiap kompetisi
    *data science*. Semakin nilainya menuju `1`, maka akan semakin bagus
    hasil prediksinya.

### `biomarker1`

    ##                            
    ##  Method used: empirical    
    ##  Number of positive(s): 229
    ##  Number of negative(s): 454
    ##  Area under curve: 0.7735

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2020-06-20-kesehatan-ro_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

### `biomarker2`

    ##                            
    ##  Method used: empirical    
    ##  Number of positive(s): 229
    ##  Number of negative(s): 454
    ##  Area under curve: 0.8375

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2020-06-20-kesehatan-ro_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

### Kesimpulan dari nilai AUC

Dari nilai `AUC` kedua **ROC Curve** di atas, `biomarker2` menunjukkan
angka yang terbaik dibandingkan `biomarker1`. Oleh karena itu, dugaan
awal saya: `biomarker2` memiliki kemampuan lebih baik untuk mendiagnosis
penyakit dibandingkan `biomarker1`.

### *Cut Off Points*

Dari data numerik `biomarker1` dan `biomarker2`, saya akan menentukan
batas berapa kadar bisa dibilang `positif` dan `negatif`. Untuk itu,
saya akan menggunakan [Youden’s J
statsitic](https://en.wikipedia.org/wiki/Youden%27s_J_statistic), yakni:

  
![J=sensitivity+specificity-1](https://latex.codecogs.com/png.latex?J%3Dsensitivity%2Bspecificity-1
"J=sensitivity+specificity-1")  

*Cut off points* akan dipilih saat nilai
![J](https://latex.codecogs.com/png.latex?J "J") mencapai maksimum.

### `biomarker1`

    ##                            
    ##  Method used: empirical    
    ##  Number of positive(s): 229
    ##  Number of negative(s): 454
    ##  Area under curve: 0.7735

*Cut off points* untuk `biomarker1` terjadi pada 9.147, saat **TPR** =
0.8165939; **FPR** = 0.407489 sehingga menghasilkan
![J=](https://latex.codecogs.com/png.latex?J%3D "J=") 0.4091.

### `biomarker2`

    ##                            
    ##  Method used: empirical    
    ##  Number of positive(s): 229
    ##  Number of negative(s): 454
    ##  Area under curve: 0.8375

*Cut off points* untuk `biomarker2` terjadi pada 16.981, saat **TPR** =
0.7510917; **FPR** = 0.2202643 sehingga menghasilkan
![J=](https://latex.codecogs.com/png.latex?J%3D "J=") 0.5308.

Dari *cut off points* tersebut, saya membuat *rules* yakni jika kadar
`biomarker` ![\\geq](https://latex.codecogs.com/png.latex?%5Cgeq
"\\geq") *cut off points* maka akan ditulis `sakit`. Sedangkan jika
kadar `biomarker` \< *cut off points* maka akan ditulis `tidak sakit`.

### *Confusion Matrix*

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

### `biomarker1`

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

### `biomarker2`

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

### Kesimpulan *Confusion Matrix*

1.  `biomarker1` memberikan
    ![precision=](https://latex.codecogs.com/png.latex?precision%3D
    "precision=") 50.27 `%` dan
    ![recall=](https://latex.codecogs.com/png.latex?recall%3D "recall=")
    81.66 `%`.
2.  `biomarker2` memberikan
    ![precision=](https://latex.codecogs.com/png.latex?precision%3D
    "precision=") 63.24 `%` dan
    ![recall=](https://latex.codecogs.com/png.latex?recall%3D "recall=")
    75.11 `%`.

### KESIMPULAN Final

Melihat dari **AUC**, sebenarnya `biomarker2` cukup bagus dibandingkan
dengan `biomarker1`. Tapi dari nilai *precision* dan *recall* saya tidak
merekomendasikan sama sekali kedua `biomarker` untuk digunakan.
