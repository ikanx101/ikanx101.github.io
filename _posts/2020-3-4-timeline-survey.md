---
date: 2020-3-4T10:09:00-04:00
title: "Menghitung Timeline Fieldwork Survey"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
  - Survey
  - Market Research
  - Random
  - Fieldwork
---

Seperti yang saya sempat bahas di [tulisan
sebelumnya](https://ikanx101.github.io/blog/monte-lagi/), kali ini saya
akan mencoba menghitung *timeline* dari suatu survey dengan memanfaatkan
simulasi **Monte Carlo**.

> *Gimana sih maksudnya?*

Oke, sekarang saya coba bahas **market research 101** dulu yah terkait
dengan *workflow* menjalankan survey *market research*.

# **Workflow Market Research**

Berikut ini adalah proses yang *proper* dalam menjalankan suatu
survey:

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/puzzles/Timeline%20Survey/proses%20riset.png
"gbr")

Saya pribadi membagi *flow* di atas menjadi tiga titik kritis yang tidak
boleh salah sama sekali, yakni:

1.  *Formulate problem*; Jika salah dalam memformulasikan masalah, maka
    keseluruhan *cycle* akan menjadi percuma.
2.  *Design research* dan *collect data*; Bayangkan jika kita sudah
    melakukan survey ke 200 orang dan ternyata ada kesalahan sehingga
    harus diulang\!
3.  *Analyze data*; Jangan sampai salah menganalisa yang mengakibatkan
    salah dalam mengambil kesimpulan. Sesuaikan dengan tujuan dan
    masalah yang ingin diselesaikan.

-----

# Proses *Fieldwork*

*Fieldwork* dalam dunia survey adalah suatu proses pekerjaan lapangan
dimana *interviewer* sedang mencari-cari responden yang sesuai dengan
target untuk kemudian diwawancarai sesuai dengan kuesioner yang telah
dibuat sebelumnya.

Lama atau tidaknya suatu proses *fieldwork* tergantung dari berbagai
macam hal, biasanya yang sering terjadi:

1.  **Tingkat kesulitan dan kompleksitas kriteria target responden**.
    Kadangkala kita harus mencari responden yang memiliki kriteria yang
    cukup kompleks. Apalagi jika kriteria tersebut tidak ada patokan
    data sekundernya (di BPS atau AC Nielsen). Contohnya: mencari
    perempuan usia 30 - 45 tahun yang rutin berolahraga dan memiliki
    riwayat penyakit tertentu.
2.  **Keengganan calon responden diwawancara**. Ini juga salah satu
    faktor yang penting. Tidak semua orang mau diwawancarai.
3.  **Area pelaksanaan riset**.
4.  **Force majeure**. Contohnya: kondisi musim hujan (banjir) atau
    kerusuhan (pasca pemilu kemarin).

-----

# *Yuk Simulasi\!*

Sekarang saya akan memberikan contoh bagaimana simulasi bisa digunakan
untuk menghitung berapa lama *fieldwork* suatu survey bisa diselesaikan.

## Jadi begini ceritanya:

-----

> Saya hendak melaksanakan survey di kota **X**. Menurut **AC Nielsen**,
> ada empat kelas sosial ekonomi yang ada di kota itu dengan proporsi
> sebagai berikut: kelas A `3.1%`, kelas B `21.0%`, kelas C `52.4%`, dan
> kelas D `23.4%`.

> Sedangkan saya harus mendapatkan responden dari keempat kelas tersebut
> dengan minimal jumlah tertentu, yakni: kelas A minimal `70` orang,
> kelas B minimal `100` orang, kelas C minimal `150` orang dan kelas D
> minimal `180` orang.

> Menurut BPS, ada sekitar `350.000` orang di kota tersebut.

> Ada `5` orang interviewer yang bertugas mencari dan mewawancara
> responden. Biasanya, setiap interviewer mampu mewawancarai `4` sampai
> `9` orang responden.

Asumsi yang digunakan:

1.  Setiap orang yang hendak diwawancarai punya peluang `50 - 50` untuk
    mau diwawancarai sampai selesai.
2.  Survey dilakukan secara *random*.

-----

## Pertanyaan:

1.  Butuh berapa banyak calon responden yang ditemui agar terpenuhi
    jumlah minimal responden?
2.  Dari jumlah tersebut (dibandingkan dengan populasi BPS), apakah
    memungkinkan dilakukan survey di kota itu?
3.  Jika iya, butuh berapa hari hingga survey bisa selesai?

-----

## Simulasi Responden

Saya akan buat fungsi-fungsi simulasinya yah. Bisa jaid ini bukan fungsi
yang paling *tidy* tapi seharusnya mudah untuk dipahami *yah*.

Pertama-tama, mari kita buat fungsi untuk menebak kelas ekonomi dari
calon responden yang ditemui:

``` r
# bikin fungsi pertama
proporsi = c(3.1/100,21.0/100,52.4/100,23.4/100)
ses = c('A','B','C','D')

orang = function(){
  sample(ses,1,prob = proporsi)
}
orang()
```

    ## [1] "C"

Berikutnya kita kembangkan fungsi pertama dengan memasukkan asumsi
pertama.

``` r
# bikin fungsi kedua
siapa = function(){
  hitung = orang()
  A = ifelse(hitung == 'A',1,0)
  B = ifelse(hitung == 'B',1,0)
  C = ifelse(hitung == 'C',1,0)
  D = ifelse(hitung == 'D',1,0)
  data = data.frame(A,B,C,D) # calon responden yang ditemui memiliki kelas ekonomi apa?
  mau = sample(c(1,0),1,prob = c(.5,.5)) # apakah calon responden mau diwawancarai atau tidak?
  data = data*mau # kelas ekonomi responden yang diwawancarai. Apakah ada atau tidak ada?
  return(data)
}
siapa()
```

    ##   A B C D
    ## 1 0 0 0 0

Berikutnya kita akan mencari butuh berapa banyak calon responden yang
dibutuhkan agar target responden saya terpenuhi.

> Bagaimana caranya?

Jika dilihat, responden pada kelas sosial ekonomi A memiliki proporsi
terkecil di populasi. Maka dari itu, secara logika, jika kita mencari
sebanyak-banyaknya calon responden secara *random* maka yang paling
terakhir bisa *fulfill* adalah responden kelas A.

> Nanti bisa dibuktikan yah logika ini.

Kita akan membangun suatu fungsi menggunakan *looping* menggunakan
`while()` dan menghitung berapa banyak calon responden yang dibutuhkan.

``` r
# bikin fungsi ketiga
berapa_calon_responden = function(n){
  n+100 #dummy aja biar bisa masuk ke sapply
  data_1 = siapa()
  i = 1
  while(sum(data_1$A)<70 && data_1$B<100){ # kelas sosial ekonomi A harus minimal 70
    data_fi = siapa()
    data_1 = rbind(data_1,data_fi)
    i = i + 1
  }
  return(i) # berapa banyak calon responden yang ditemui sampai terpenuhi banyak minimal responden
}
```

Contohnya, dalam sekali iterasi untuk memenuhi minimal responden,
dibutuhkan calon responden sebanyak **4051**.

Nah, sekarang kita bikin deh simulasinya dalam `500`-an iterasi.

``` r
# simulasi dimulai dari mari
hasil = data.frame(id = c(1:2)) # untuk keperluan visual di blog ini, saya set di dua dulu
# Data hasil simulasi 500 kali ada di github yah

hasil$banyak_calon_resp = sapply(hasil$id,berapa_calon_responden)
```

Berapa *expected value* banyaknya calon responden dari simulasi ini:
**4440**.

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/puzzles/Timeline%20Survey/blog-post_files/figure-gfm/unnamed-chunk-6-1.png)

Berikut adalah `summary` statistik dari hasil simulasinya:

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    3205    4170    4454    4493    4838    6240

Sekarang kita sudah mendapatkan berapa banyak calon responden yang harus
dicari agar target minimal banyaknya responden per kelas sosial ekonomi
tercukupi.

Jika kita bandingkan dengan populasi di kota tersebut, angka ini relatif
masih mungkin untuk dilaksanakan riset. Perbandingannya sekitar `1:77`
(*expected value* dari simulasi : populasi).

-----

## Simulasi Responden dan Interviewer

Berdasarkan *function* di atas, kita akan kembangkan simulasi untuk
menghitung berapa waktu yang ditempuh para *interviewer* untuk bisa
mewawancarai semua calon responden
tersebut.

``` r
# dalam sehari, berapa banyak responden yang bisa diwawancarai oleh lima orang interviewer
interviewer = function(n){
  n
  int = 0
  for(i in 1:5){
    int = int + sample(c(4:9),1)
  }
  return(int)
}

# sekarang kita akan hitung butuh berapa hari yah
berapa_hari = function(n_resp){
  i = 0
  while(n_resp>0){
    n_resp = n_resp - interviewer(1)
    i = i+1
  }
  return(i)
}

hasil$berapa_hari = sapply(hasil$banyak_calon_resp,berapa_hari)
```

*Expected value* untuk `berapa_hari` *interviewer* bisa menyelesaikan
wawancara ini adalah 139 hari alias 20 minggu.

Mari kita lihat `summary` statistik dari `berapa_hari` yang harus
ditempuh:

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   100.0   129.0   137.0   138.8   150.0   191.0

Berikut adalah sebaran `berapa_hari` hasil simulasi:

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/puzzles/Timeline%20Survey/blog-post_files/figure-gfm/unnamed-chunk-11-1.png)

## Kesimpulan:

Dari simulasi di atas, kita bisa melaksanakan survey di kota tersebut
walau waktu yang dibutuhkan relatif lebih lama.

-----

**Notes:**

File `csv` hasil simulasi bisa dilihat di
[sini](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/puzzles/Timeline%20Survey/Hasil%20Simulasi%20FINAL.csv).
