---
date: 2023-09-04T12:41:00-04:00
title: "Sentiment Analysis: Komentar Netizen Terhadap Produk Susu Oat"
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
  - Tropicana Slim
  - Oat Drink
---


Dari persiapan yang telah saya [lakukan
sebelumnya](https://ikanx101.com/blog/install-huggingface/), sekarang
saya lakukan *sentiment analysis* untuk komentar-komentar *netizen*
terkait produk susu *oat* yang sudah [saya ambil
sebelumnya](https://ikanx101.com/blog/clustering-oat/).

Berikut adalah data komentar yang digunakan:

    ##  [1] "Rasanya kurang berasa oatnya,lebih ke hambar bgt sih.."                                                                                                                                                                                                                                                                                                        
    ##  [2] "enakkk bangett, manisnya pas menurut aku. tipikal kaya oatmilk pada umumnya tapi rasa vanilla dan lumayan bikin kenyang. "                                                                                                                                                                                                                                     
    ##  [3] "Produk sangat baik kualitas terjamin dan lembut waktu di buat bikin kue sangat memuaskan produk ini dan selalu di buat buat usaha jualan apa buat di jual di warung2 hargga yerjamin dan murah"                                                                                                                                                                
    ##  [4] "Sesuai dengan labelnya less sugar, rasanya tidak terlalu manis jadi tidak bikin eneg, rasa susunya terasa dan bikin kenyang. Semoga ada varian rasa lainnya ya"                                                                                                                                                                                                
    ##  [5] "Bikin kenyang cocok untuk diet\nRasanya enak, g bikin eneg"                                                                                                                                                                                                                                                                                                    
    ##  [6] "Manisnya pas ga bikin eneg,cocok buat yang ga sempet sarapan ga bikin sakit perut juga.buat yang lagi diet tapi pengen minum susu bisa dialihkan minum ini. Recommend buat yang mau diet dan ga sempat bikin sarapan"                                                                                                                                          
    ##  [7] "Buat aku anak kosan praktis banget buat sarapan karena bikinnya mudah, ga ribet, dan ternyata bisa buat mendukung program diet karena kenyangnya tahan lama, rasanya juga enak, ngga bikin eneg"                                                                                                                                                               
    ##  [8] "Minuman ini bukan cuman bikin kenyang tapi sehat sangat cocok untuk diet..apalagi rasanya yang menurut aku pas g terlalu manis, kemasan praktis mudah dibawa"                                                                                                                                                                                                  
    ##  [9] "Enak ajasi berasa kek minum oats dikasih air putih gitusi sayangnya manisnya beda, cocok buat lapar dikondisi macet ngenyangin juga kok, yang suka vanila dan lagi diet mungkin sukak sama minuman rasa ini"                                                                                                                                                   
    ## [10] "Untuk rasanaya pertama kali saya minum itu rasanya enak , tidak terlalu manis, saya suka minuman ini kaya akan serat dan juga penting itu rendah lemak dan bebas gula dong. tetapi untuk harganya cukup mahal skelas minuman kotak ini. tetapi dnegan melihat manfaat di deskripsi produknya sebanding sih ini bukan sekedar minuman biasa."                   
    ## [11] "Membantu acara diet kaum hawa... Aku pakai ini hasilnya ga gampang lapar dan lemak ga nambah"                                                                                                                                                                                                                                                                  
    ## [12] "Terbiasa dengan rasa susu oat produk lain, menurut saya kurang untuk minuman yang mengklaim helathy drink, masih berasa manis dan terlalu encer. Dan after tastenya agak mengganggu."                                                                                                                                                                          
    ## [13] "tekstur creamy, rasa enak dan menyehatkan. cocok bagi yang memiliki laktosa intoleran. merupakan alternatif bagi susu sapi, mengandung banyak vitamin yang diperlukan oleh tubuh.\nternyata rasanya pun creamy namun ringan, tidak membuat mual. mengandung glukosa yang lebih rendah sehingga agak tawar, namun itu yang saya sukai."                         
    ## [14] "Enak rasa manisnya pas yang paling penting less guilty pas makan. Sering nyetok di kulkas apalagi ini lumayan sering promo di supermarket. Hihi rekomendasi pokoknya untuk oat milk\n"                                                                                                                                                                         
    ## [15] "Rendah gula dan lemak itu bikin sehat di badan sehingga aman di konsumsi.saya sering minum nya"                                                                                                                                                                                                                                                                
    ## [16] "ini pilihan yang lebih sehat bagi yang sedang diet ataupun ada riwayat penyakit gula sih, tapi secara personal kurang suka rasanya terlalu encer dan agak hambar"                                                                                                                                                                                              
    ## [17] "Aku pribadi agak kurang suka rasanya hambar, tapi memang pada dasarnya aku gak terlalu suka oat.\nTapi ini baik buat badan, minum dikit aja langsung kenyang lama, rekomendasi buat cemilan yang lagi diet"                                                                                                                                                    
    ## [18] "Honestly, untuk yang sedang mengurangi asupan gula, minuman ini bisa jadi opsi ditambah ada oat sebagai asupan fiber. Harga lumayan mahal menurut saya, tapi ini penilaian secara personal ya."                                                                                                                                                                
    ## [19] "Kurang terlalu manis.. Mungkin blm terbiasa minum yg sehat2, tpi enak ko buat yg mau diet"                                                                                                                                                                                                                                                                     
    ## [20] "Klaim produk tanpa gula tapi tetep enak, tetap asa rasa manis yg nggak eneg. Cocok untuk sarapan, ganjel perut, harga merakyat, enak pula. Rekomendasi buat kalian.. buruan dicoba guys"                                                                                                                                                                       
    ## [21] "Klaim produk tanpa gula tapi tetep enak, tetap asa rasa manis yg nggak eneg. Dibuat campuran kopi juga enak banget. Cocok banget buat yg ngurangin gula tapi pengen tetp konsumsi susu kemasan"                                                                                                                                                                
    ## [22] "Jujur ini rasanya enak gak bikin eneg. Manisnya tuh pas gituuuu bener bener worth to buy tapi buat ku agak mahal kalo buat sekali minum hahaha"                                                                                                                                                                                                                
    ## [23] "Susu dnegan rasa yg gk bikin enek, manisnya sangat pas sekali"                                                                                                                                                                                                                                                                                                 
    ## [24] "Susu favorit, karena ga terlalu enek dan enak banget"                                                                                                                                                                                                                                                                                                          
    ## [25] "rasanya enak, manisnya pas, favorit klu lagi pingin susu yang non-dairy"                                                                                                                                                                                                                                                                                       
    ## [26] "Rasanya enak banget, ga terasa seperti oats... Manisnya pas, ga eneg"                                                                                                                                                                                                                                                                                          
    ## [27] "Enak dan cocok bagi yg ingin diet,,sebagai pengganti makan pagi ataupun sebagai Snack"                                                                                                                                                                                                                                                                         
    ## [28] "Pilihan tepat kala diet, rasanya enak gak bikin eneg, manisnya pas dan porsinya cocok untuk snacking menjelang makan besar\n"                                                                                                                                                                                                                                  
    ## [29] "Teman selama defisit kalori, rasanya ga terlalu manis ya tapi masih oke kok, isinya banyakk 190ml but kalorinya cuma 80kkal aja, abis minum ini rasanya bisa kenyang lebih laama"                                                                                                                                                                              
    ## [30] "Rasanya enak, tidak bikin eneg, dan tentunya tidak kawatir dengan gula dan lemak ketika mengkonsumsi"                                                                                                                                                                                                                                                          
    ## [31] "Enak dan cocok buat yang lagi diet. Karena kalorinya keucil.\nRasanya enak dan manisnya light, pas sih klo diselera aku. Mungkin yang suka muanis ya terasa kurang manis.\nUntuk yang diet, dan butuh defisit kalori , bisa banget cobain Tropicana Slim Oat Drink ini untuk rekreasi rasa yah!...."                                                           
    ## [32] "Sangat amat membantu untuk yang sedang menjalani program diet, karna cukup efektif untuk menahan lapar"                                                                                                                                                                                                                                                        
    ## [33] "ini bener bener oat dijadiin susu, dari baunya juga khas oat, rasanya enak manisnya pas kalau buat saya ga eneg sama sekali"                                                                                                                                                                                                                                   
    ## [34] "Untuk manfaat memang oke, baik utk kesehatan pencernaan, namun jujur utk rasa saya kurang suka, namun itu balik ke selera masing2 orang. Worth to try lah"                                                                                                                                                                                                     
    ## [35] "Sangat enak, namun untuk saya yang tidak suka manis masih agak terlalu manis"                                                                                                                                                                                                                                                                                  
    ## [36] "Mungkin saya saja yang kurang menyukai produk oat atau soya. Suatu hari saya membeli dan mencoba karena produk baru berada di etalase minimart. Ditambah saya konsumsi tidak pada suhu dingin, jadi menurut saya rasanya kurang, ini menurut penilaian saya sih. tapi saya akan mencoba kembali dikonsumsi dengan suhu dingin."                                
    ## [37] "Saya sangat suka karena tidak perlu lagi membeli oat dan mencampurkannya dengan susu karena oatmilk ini sudah lengkap, dan sangat cocok untuk yang ingin diet karena minuman ini mengenyangkan"                                                                                                                                                                
    ## [38] "Oat milk, dengan rasa oat yg khas dari susunya. Terasa lebih segar. Plain taste but it is make the oat milk feel healthyer. Mungkin bisa ada rasa lain seperti oat choco/strawberry!"                                                                                                                                                                          
    ## [39] "Cocok untuk yg suka susu low fat dan tidak manis. Rasa vanilanya tidak terlalu terasa, tapi oat nya bisa terasa."                                                                                                                                                                                                                                              
    ## [40] "Membantu banget yang mau diet, tinggal sat set langsung minum, dan bikin kenyang."                                                                                                                                                                                                                                                                             
    ## [41] "Minuman segar menyehatkan dari brand khusus diabetes,yang terbuat dari bulitran oats yg cocok sebagai pengganjal perut saat lapar.."                                                                                                                                                                                                                           
    ## [42] "Manisnya pas, kekentalan pas, perasa vanilla tidak berlebihan."                                                                                                                                                                                                                                                                                                
    ## [43] "Produk yang praktis, karena siap minum. Bisa jadi alternatif pengganti minuman berkalori lainnya. Rasa manisnya pas. Kalori dalam minuman lumayan. Untuk yang lagi diet, saya kira itu bagus"                                                                                                                                                                  
    ## [44] "Oat drink ini menurut aku tidak ada rasanya, tapi dilain sisi oat drink ini dapat membuat perut kenyang. Susu yang ada di oat ini tidak terlalu kental dan oat yang ada berbentuk pipih dan kecil-kecil. Wajib coba minuman sehat di era milenial seperti ini, yuk mari kita menjaga tubuh tetap sehat dengan mengkonsumsi makanan dan minuman yang sehat juga"
    ## [45] "Jika anda ingin diet praktis ini salah satu solusinya, karena kemasan praktis dan bisa diminum dimana saja, untuk saya rasanya masih terlalu manis, tp tidak berlebihan"

Jika kita lihat sekilas, komentar netizen pertama memiliki sentimen yang
**negatif**. Oke, nanti akan kita lihat apakah model LLM yang saya
gunakan benar-benar akan menghasilkan hasil yang sama-sama negatif untuk
komentar pertama? *Cekidot!*

------------------------------------------------------------------------

Model yang saya gunakan bernama `indonesia bert sentiment analysis` yang
dibuat oleh *user* bernama `mdhugol`. Dokumentasi dan cara menggunakan
model tersebut bisa dilihat di [*link* berikut
ini](https://huggingface.co/mdhugol/indonesia-bert-sentiment-classification).

Perlu saya informasikan bahwa model ini memerlukan *Pytorch* dan
berjalan di *local computer* (data hanya ada di laptop saya saja).

------------------------------------------------------------------------

# Hasil *Sentiment Analysis*

Setelah di-*run*, berikut adalah hasilnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/Tulisan%20kelima/post_files/figure-gfm/unnamed-chunk-2-1.png" width="672" style="display: block; margin: auto;" />

Ternyata kita dapatkan ada **tiga komentar yang mendapatkan sentimen
negatif** dan **mayoritas komentar mendapatkan sentimen positif**.

------------------------------------------------------------------------

# Sentimen Negatif

Berikut ini adalah tabel detail hasilnya:

|                                                                                       Komentar                                                                                       | Sentimen | Probability |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------:|:-----------:|
|                                                                Rasanya kurang berasa oatnya,lebih ke hambar bgt sih..                                                                | Negative |   99.6675   |
| Terbiasa dengan rasa susu oat produk lain, menurut saya kurang untuk minuman yang mengklaim helathy drink, masih berasa manis dan terlalu encer. Dan after tastenya agak mengganggu. | Negative |   90.2223   |
|           ini pilihan yang lebih sehat bagi yang sedang diet ataupun ada riwayat penyakit gula sih, tapi secara personal kurang suka rasanya terlalu encer dan agak hambar           | Negative |   75.4578   |

# Sentimen Positif

Berikut ini adalah tabel detail 15 komentar teratas hasilnya:

|                                                                                            Komentar                                                                                             | Sentimen | Probability |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------:|:-----------:|
|       Enak rasa manisnya pas yang paling penting less guilty pas makan. Sering nyetok di kulkas apalagi ini lumayan sering promo di supermarket. Hihi rekomendasi pokoknya untuk oat milk       | Positive |   99.8222   |
| Buat aku anak kosan praktis banget buat sarapan karena bikinnya mudah, ga ribet, dan ternyata bisa buat mendukung program diet karena kenyangnya tahan lama, rasanya juga enak, ngga bikin eneg | Positive |   99.8192   |
| Klaim produk tanpa gula tapi tetep enak, tetap asa rasa manis yg nggak eneg. Dibuat campuran kopi juga enak banget. Cocok banget buat yg ngurangin gula tapi pengen tetp konsumsi susu kemasan  | Positive |   99.8107   |
|                                   Pilihan tepat kala diet, rasanya enak gak bikin eneg, manisnya pas dan porsinya cocok untuk snacking menjelang makan besar                                    | Positive |   99.8075   |
|     Klaim produk tanpa gula tapi tetep enak, tetap asa rasa manis yg nggak eneg. Cocok untuk sarapan, ganjel perut, harga merakyat, enak pula. Rekomendasi buat kalian.. buruan dicoba guys     | Positive |   99.8065   |
|                                    enakkk bangett, manisnya pas menurut aku. tipikal kaya oatmilk pada umumnya tapi rasa vanilla dan lumayan bikin kenyang.                                     | Positive |   99.8051   |
|  Produk yang praktis, karena siap minum. Bisa jadi alternatif pengganti minuman berkalori lainnya. Rasa manisnya pas. Kalori dalam minuman lumayan. Untuk yang lagi diet, saya kira itu bagus   | Positive |   99.7969   |
|                                                                      Susu favorit, karena ga terlalu enek dan enak banget                                                                       | Positive |   99.7931   |
| Saya sangat suka karena tidak perlu lagi membeli oat dan mencampurkannya dengan susu karena oatmilk ini sudah lengkap, dan sangat cocok untuk yang ingin diet karena minuman ini mengenyangkan  | Positive |   99.7930   |
|                  Minuman ini bukan cuman bikin kenyang tapi sehat sangat cocok untuk diet..apalagi rasanya yang menurut aku pas g terlalu manis, kemasan praktis mudah dibawa                   | Positive |   99.7876   |
|                                   ini bener bener oat dijadiin susu, dari baunya juga khas oat, rasanya enak manisnya pas kalau buat saya ga eneg sama sekali                                   | Positive |   99.7837   |
|        tekstur creamy, rasa enak dan menyehatkan. cocok bagi yang memiliki laktosa intoleran. merupakan alternatif bagi susu sapi, mengandung banyak vitamin yang diperlukan oleh tubuh.        |          |             |
|                       ternyata rasanya pun creamy namun ringan, tidak membuat mual. mengandung glukosa yang lebih rendah sehingga agak tawar, namun itu yang saya sukai.                        | Positive |   99.7807   |
|                                                                                 Bikin kenyang cocok untuk diet                                                                                  |          |             |
|                                                                                   Rasanya enak, g bikin eneg                                                                                    | Positive |   99.7772   |
| Produk sangat baik kualitas terjamin dan lembut waktu di buat bikin kue sangat memuaskan produk ini dan selalu di buat buat usaha jualan apa buat di jual di warung2 hargga yerjamin dan murah  | Positive |   99.7528   |
|                                                      Enak dan cocok bagi yg ingin diet,,sebagai pengganti makan pagi ataupun sebagai Snack                                                      | Positive |   99.7506   |

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
