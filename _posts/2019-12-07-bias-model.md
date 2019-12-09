---
date: 2019-12-07T21:00:00-04:00
title: "Your Model is Just As Good As Your Training Data"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Prediction
  - Modelling
---

Sudah baca tulisan saya yang [ini](https://ikanx101.github.io/blog/no-intelligence-in-AI/)? Kalau belum dibaca dulu semuanya yah (termasuk link ke [tulisan di blog saya yang lama](https://passingthroughresearcher.wordpress.com/2019/08/22/summary-event-indonesian-artificial-intelligence-summit-2019-day-1-keynote-speaker-1/)). _hehe_

Sekarang saya mau bahas lebih detail tentang bias di __Artificial Intelligence__.

> Banyak orang berkata bahwa __AI__ tak akan bisa salah. __AI__ bisa menjadi _leader_ atau _decision maker_ yang lebih baik dibanding manusia karena murni mengedepankan logika dibandingkan faktor emosional.

_Benarkah seperti itu Ferguso?_ Oke, mari kita bedah bersama yah.

> Saat kita berbicara mengenai __AI__, biasanya kita biasa membicarakan kemampuan __AI__ dalam membuat _decision_ yang mengandalkan suatu model prediksi atau klasifikasi.

Pada dasarnya __AI__ itu dibangun atas kumpulan model matematika dan model statistika. Dengan bantuan komputer, proses kalkulasi menjadi cepat dan efisien. 

Untuk membangun model prediksi atau klasifikasi di __AI__ (sekarang saya akan menggunakan istilah __Machine Learning__), kita mengetahui ada tiga jenis cara membangun modelnya. Yakni:

1. _Supervised Learning_.
2. _Unsupervised Learning_.
3. _Semi-supervised Learning_.

Biasanya _Supervised Learning_ adalah jenis model yang paling sering digunakan karena __kita ingin AI bisa "berpikir" dan "bertindak" seperti layaknya manusia__. Tapi apakah kita tahu cara membangun model _Supervised Learning_?

_Supervised Learning_ berarti membangun model prediksi atau klasifikasi berdasarkan _training dataset_ yang sudah kita berikan label pada _variabel target_ sebagai basis bagi mesin dalam membangun model. 

> Oleh karena itu, memilih _training dataset_ menjadi hal yang paling krusial untuk membangun model prediksi atau klasifikasi. 

Jika dalam _training dataset_ ada bias yang tidak kita sadari, maka yakinlah model kita akan juga menjadi bias. 

#### Contoh sederhana:

Misalkan, kita ingin membuat model yang bisa memprediksi apakah seseorang layak diberi pinjaman oleh bank atau tidak. Kita akan membuat model berdasarkan _training dataset_ yang berisi variabel-variabel sebagai berikut:

1. `gender`
2. `etnis`
3. `usia`
4. `pekerjaan`
5. `income_per_month`
6. `marital_status`
7. `banyak_tanggungan`
8. `status_pekerjaan`
9. `tagihan_kartu_kredit`
10. `area_tempat_tinggal`
11. dll.
12. `layak_atau_tidak` --> _Variabel target_ yang menyatakan seseorang layak atau tidak diberikan pinjaman oleh bank.

Ada yang sadar _gak_ bahwa variabel-variabel di atas __bisa berpotensi menimbulkan bias__?

Jika pada _training dataset_ tersebut ternyata mayoritas orang yang diberikan pinjaman berjenis kelamin lelaki, maka saat nanti mesin mendapatkan data real seseorang berjenis kelamin wanita ingin mengajukan pinjaman, bisa jadi orang tersebut akan ditolak.

ATAU,

Jika pada _training dataset_ tersebut ternyata mayoritas orang yang diberikan pinjaman bertempat tinggal di suatu area tertentu, maka hampir bisa dipastikan jika ada seseorang dari area tempat tinggal tertentu akan sulit mendapatkan _approval_ pinjaman.

Sekarang sudah kebayang potensi-potensi bias yang ada?

Ada gak _sih_ cara untuk meminimalisir biasnya?

Cara paling mudah adalah melakukan pemilihan variabel pada _training dataset_ yang tidak menimbulkan bias. Variabel yang berhubungan dengan SARA bisa dihilangkan beserta variabel lainnya yang dikira bisa menimbulkan bias.

> Untuk melakukan itu, dibutuhkan __human intelligence__ sebagai _backbone_ dari __AI__.

_Btw_, inget kejadian dimana seorang penumpang pesawat [United Express Flight 3411](https://en.wikipedia.org/wiki/United_Express_Flight_3411_incident) diusir paksa dari pesawat? Kejadian ini sempat viral di Amerika sana.

Saat _event_ __Indonesia AI Summit__ di Nusa Dua tahun lalu, [__Prof. Terence Tse__](https://en.wikipedia.org/wiki/Terence_Tse) pada _keynote speak_-nya sempat menyinggung bagaimana algoritma _United Express_ memegang peranan penting bagaimana penumpang tersebut dipaksa turun dari pesawat.

Saya mencoba mencari artikel terkait itu, tidak ada yang spesifik membenarkan pernyataan __Prof. Tse__, tapi ada yang setidaknya mirip dengan pernyataan [tersebut](https://www.nbcnews.com/storyline/airplane-mode/united-fiasco-how-do-airlines-select-who-remove-overbooked-flights-n746331).

#### Kesimpulan:

* _Rubbish in, rubbish out!_

# _Yakin masih mau dipimpin oleh AI?_
