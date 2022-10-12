---
title: "Membuat Algoritma untuk Simulasi Automatic Replenishment"
date: 2022-10-11T18:51:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Optimization
  - Automation
  - Automatic Replenishment
  - Sales
  - Inventory Management
  - R
  - Algoritma
  - Simulation
  - Monte Carlo
---


Beberapa bulan silam, saya sempat menuliskan tentang bagaimana konsep
[*automatic replenishment* di suatu gudang *distributor* barang
tertentu](https://ikanx101.com/blog/auto-replenish/). Kali ini saya
hendak menuliskan algoritma yang bisa digunakan untuk melakukan simulasi
*automatic replenishment* di suatu depot pengisian galon air isi ulang.
Seperti biasa, saya menggunakan **R** untuk menulis algoritma dan
kemudian melakukan simulasi.

-----

Suatu ketika, di salah satu depot pengisian galon air isi ulang, proses
bisnis yang terjadi adalah sebagai berikut:

1.  Depot tersebut menjual air isi ulang untuk galon-galon kosong dari
    konsumen.
2.  Pengiriman bahan baku (air murni) dilakukan menggunakan satu truk
    tangki yang **harus terisi dengan penuh** dalam sekali pengiriman
    (misal: kapasitas tanki = 700 liter. Kelak nilai ini akan disebut
    dengan ***economic order quantity*** - EOQ). *Lead time* pengiriman
    bervariasi selama 1-2 hari dari hari pemesanan. Pemesanan dan
    pengiriman bisa dilakukan hari apa saja.
3.  Pemesanan baru dilakukan jika **stok air di tangki depot sudah
    kurang dari** ***reorder point*** (ROP) yang ditetapkan perusahaan.
    Cara perusahaan menghitung ***reorder point*** adalah: ![ss = 2
    \\times \\sigma
    D](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;ss%20%3D%202%20%5Ctimes%20%5Csigma%20D
    "ss = 2 \\times \\sigma D"). Dimana ![\\sigma
    D](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Csigma%20D
    "\\sigma D") adalah standar deviasi dari *demand* selama 30 hari ke
    depan.
4.  *Demand* selama 30 hari ke depan disimulasikan menggunakan data
    historikal pada bulan-bulan sebelumnya.
5.  Untuk melakukan pengiriman, biaya yang keluar adalah tetap sebesar
    `Rp500.000`.
6.  Kapasitas tangki penampungan air di depot tersebut sangat besar
    sehingga kita bisa abaikan faktor ini.
7.  Kualitas air yang tertampung dalam tangki depot akan menurun
    seiringnya waktu. Diperkirakan biaya yang timbul akibat penurunan
    kualitas air ini adalah `Rp1.500` per liter air. (Kelak kita akan
    sebut biaya ini sebagai *carrying cost*).
8.  Jika ada pelanggan datang untuk membeli air namun persediaan air
    habis. Maka akan dihitung sebagai *loss sales*. Besarannya adalah
    sebesar `Rp5.000` per liter air. (Kelak besaran ini akan dihitung
    sebagai biaya yang dinamakan *shortage cost*).
9.  Saldo air di tangki depot pada hari `1` adalah sebesar 20 liter air.
10. Jika *demand* pada hari tersebut lebih besar dari stok air di depot,
    maka depot hanya bisa memenuhi *demand* sebagian saja (tergantung
    stok air). Sisa *demand* yang tidak terpenuhi akan menjadi *loss
    sales*.

-----

Sekarang kita akan membuat algoritmanya.

**Pendefinisian beberapa parameter**

    leadtime_min = 1
    leadtime_max = 2
    carrying_cost_per_unit = 1500
    ordering_cost = 500000
    stock_out_cost = 5000

***Generate random number*** **untuk** ***demand***

Untuk kasus ini saya gunakan random number berdistribusi normal. Pada
*real condition* kita bisa dengan mudah melakukan *generate number*
berdasarkan data historikal yang ada.

    D = runif(30,0,5) * 10 
    D = round(D,0)

**Menghitung** ***safety stock***

    sigmaL = sd(D)
    ss = 2 * sigmaL

### Simulasi pada hari 1

Pada hari pertama ini, saya akan coba hitung:

1.  Berapa banyak *order* yang bisa dipenuhi (*fullfilled*).
2.  Stok di akhir hari (*ending stock*).
3.  Apakah ada *loss sales*? (*stock outage*).
4.  Apakah perlu melakukan pemesanan air dari *supplier*? (*place
    order*).
5.  Jika iya, kapan pesanan tersebut sampai? (*order arrive at days …*)

<!-- end list -->

    # initial condition
    days = 1:30
    begin_stok = c(20)
    order_recv = c(0)
    avail_stock = c(0)
    demand = D
    full_filled = rep(NA,30)
    ending_stock = rep(NA,30)
    stock_outage = rep(NA,30)
    place_order = rep(NA,30)
    lead_time = rep(NA,30)
    order_arrive_at = rep(NA,30)
    i = 1
    
    # ===========================
    # perhitungan
    
    # hitung saldo sekarang
    avail_stock[i] = begin_stok[i] + order_recv[i]
    
    # perhitungan demand berapa yang bisa dipenuhi
    # asumsi bisa dipenuhi sebagian
    full_filled[i] = ifelse(avail_stock[i] < demand[i],
                            avail_stock[i],
                            demand[i])
    # perhitungan ending stok
    ending_stock[i] = avail_stock[i] - full_filled[i]                     
    # outage atau tidak
    stock_outage[i] = demand[i] - full_filled[i]
    # perlu pesan lagi atau tidak?
    place_order[i] = ifelse(ending_stock[i] <= ss,
                            1,
                            0)
    # lead time pengiriman
    lead_time[i] = sample(leadtime_min:leadtime_max,1)
    # order akan datang kapan
    order_arrive_at[i] = ifelse(place_order[i] == 1,
                                i + lead_time[i],
                                0)

### Simulasi pada hari 2

Pada hari kedua ini, algoritma yang dilakukan sama dengan algoritma pada
hari pertama. Perbedaannya ada pada variabel `order`. Jika dijadwalkan
air datang hari ini, maka akan masuk sejumlah air masuk ke dalam depot.

    i = 2
    # stok hari i adalah stok hari i-1
    begin_stok[i] = ending_stock[i-1]
    
    # jika order arrive, maka order sama dengan eoq
    if(i == order_arrive_at[i-1]){order_recv[i] = eoq}
    if(i != order_arrive_at[i-1]){order_recv[i] = 0}

### Simulasi pada hari 3 hingga 30

Modifikasi hanya dilakukan pada variabel `order`. Jika pada hari `1`
didapatkan kondisi *leadtime* pengiriman `2` hari (maka air akan datang
pada hari ke `3`), maka pada hari ke `2` kita tidak boleh meminta
pengiriman lagi (harus bersabar hingga esok air datang).

    for i in 3 to 30
    
    # stok hari i adalah stok hari i-1
    begin_stok[i] = ending_stock[i-1]
    
    # jika order arrive, maka order sama dengan eoq
    if(i == order_arrive_at[i-1] | i == order_arrive_at[i-2]){order_recv[i] = eoq}
    else{order_recv[i] = 0}

-----

# Hasil Simulasi

Jika algoritma simulasi di atas di-*run* sekali, maka hasilnya adalah
sebagai berikut:

| days | begin\_stok | order\_recv | avail\_stock | demand | full\_filled | ending\_stock | stock\_outage | place\_order | lead\_time | order\_arrive\_at | carrying\_cost | ordering\_cost | stock\_outage\_cost | total\_cost |
| ---: | ----------: | ----------: | -----------: | -----: | -----------: | ------------: | ------------: | -----------: | ---------: | ----------------: | -------------: | -------------: | ------------------: | ----------: |
|    1 |          20 |           0 |           20 |     21 |           20 |             0 |             1 |            1 |          2 |                 3 |              0 |         500000 |                5000 |      505000 |
|    2 |           0 |           0 |            0 |     49 |            0 |             0 |            49 |            1 |          2 |                 0 |              0 |              0 |              245000 |      245000 |
|    3 |           0 |         700 |          700 |     42 |           42 |           658 |             0 |            0 |          1 |                 0 |         987000 |              0 |                   0 |      987000 |
|    4 |         658 |           0 |          658 |     34 |           34 |           624 |             0 |            0 |          2 |                 0 |         936000 |              0 |                   0 |      936000 |
|    5 |         624 |           0 |          624 |      8 |            8 |           616 |             0 |            0 |          2 |                 0 |         924000 |              0 |                   0 |      924000 |
|    6 |         616 |           0 |          616 |      2 |            2 |           614 |             0 |            0 |          1 |                 0 |         921000 |              0 |                   0 |      921000 |
|    7 |         614 |           0 |          614 |     15 |           15 |           599 |             0 |            0 |          1 |                 0 |         898500 |              0 |                   0 |      898500 |
|    8 |         599 |           0 |          599 |     17 |           17 |           582 |             0 |            0 |          1 |                 0 |         873000 |              0 |                   0 |      873000 |
|    9 |         582 |           0 |          582 |     16 |           16 |           566 |             0 |            0 |          2 |                 0 |         849000 |              0 |                   0 |      849000 |
|   10 |         566 |           0 |          566 |     11 |           11 |           555 |             0 |            0 |          1 |                 0 |         832500 |              0 |                   0 |      832500 |
|   11 |         555 |           0 |          555 |     31 |           31 |           524 |             0 |            0 |          2 |                 0 |         786000 |              0 |                   0 |      786000 |
|   12 |         524 |           0 |          524 |     41 |           41 |           483 |             0 |            0 |          2 |                 0 |         724500 |              0 |                   0 |      724500 |
|   13 |         483 |           0 |          483 |     41 |           41 |           442 |             0 |            0 |          1 |                 0 |         663000 |              0 |                   0 |      663000 |
|   14 |         442 |           0 |          442 |     14 |           14 |           428 |             0 |            0 |          1 |                 0 |         642000 |              0 |                   0 |      642000 |
|   15 |         428 |           0 |          428 |     33 |           33 |           395 |             0 |            0 |          2 |                 0 |         592500 |              0 |                   0 |      592500 |
|   16 |         395 |           0 |          395 |     24 |           24 |           371 |             0 |            0 |          1 |                 0 |         556500 |              0 |                   0 |      556500 |
|   17 |         371 |           0 |          371 |     42 |           42 |           329 |             0 |            0 |          1 |                 0 |         493500 |              0 |                   0 |      493500 |
|   18 |         329 |           0 |          329 |     31 |           31 |           298 |             0 |            0 |          2 |                 0 |         447000 |              0 |                   0 |      447000 |
|   19 |         298 |           0 |          298 |     12 |           12 |           286 |             0 |            0 |          1 |                 0 |         429000 |              0 |                   0 |      429000 |
|   20 |         286 |           0 |          286 |     15 |           15 |           271 |             0 |            0 |          2 |                 0 |         406500 |              0 |                   0 |      406500 |
|   21 |         271 |           0 |          271 |     11 |           11 |           260 |             0 |            0 |          1 |                 0 |         390000 |              0 |                   0 |      390000 |
|   22 |         260 |           0 |          260 |     16 |           16 |           244 |             0 |            0 |          2 |                 0 |         366000 |              0 |                   0 |      366000 |
|   23 |         244 |           0 |          244 |     32 |           32 |           212 |             0 |            0 |          2 |                 0 |         318000 |              0 |                   0 |      318000 |
|   24 |         212 |           0 |          212 |     22 |           22 |           190 |             0 |            0 |          1 |                 0 |         285000 |              0 |                   0 |      285000 |
|   25 |         190 |           0 |          190 |     30 |           30 |           160 |             0 |            0 |          1 |                 0 |         240000 |              0 |                   0 |      240000 |
|   26 |         160 |           0 |          160 |      1 |            1 |           159 |             0 |            0 |          1 |                 0 |         238500 |              0 |                   0 |      238500 |
|   27 |         159 |           0 |          159 |     13 |           13 |           146 |             0 |            0 |          1 |                 0 |         219000 |              0 |                   0 |      219000 |
|   28 |         146 |           0 |          146 |     28 |           28 |           118 |             0 |            0 |          2 |                 0 |         177000 |              0 |                   0 |      177000 |
|   29 |         118 |           0 |          118 |     15 |           15 |           103 |             0 |            0 |          1 |                 0 |         154500 |              0 |                   0 |      154500 |
|   30 |         103 |           0 |          103 |     31 |           31 |            72 |             0 |            0 |          1 |                 0 |         108000 |              0 |                   0 |      108000 |

    ## Total cost yang dikeluarkan saat EOQ = 700 adalah: Rp16.208 juta
    ## Reorder Point hasil perhitungan = 25

Jika kita *run* sekali lagi, maka hasilnya adalah sebagai berikut:

| days | begin\_stok | order\_recv | avail\_stock | demand | full\_filled | ending\_stock | stock\_outage | place\_order | lead\_time | order\_arrive\_at | carrying\_cost | ordering\_cost | stock\_outage\_cost | total\_cost |
| ---: | ----------: | ----------: | -----------: | -----: | -----------: | ------------: | ------------: | -----------: | ---------: | ----------------: | -------------: | -------------: | ------------------: | ----------: |
|    1 |          20 |           0 |           20 |     15 |           15 |             5 |             0 |            1 |          2 |                 3 |           7500 |         500000 |                   0 |      507500 |
|    2 |           5 |           0 |            5 |     47 |            5 |             0 |            42 |            1 |          1 |                 0 |              0 |              0 |              210000 |      210000 |
|    3 |           0 |         700 |          700 |      1 |            1 |           699 |             0 |            0 |          1 |                 0 |        1048500 |              0 |                   0 |     1048500 |
|    4 |         699 |           0 |          699 |     50 |           50 |           649 |             0 |            0 |          1 |                 0 |         973500 |              0 |                   0 |      973500 |
|    5 |         649 |           0 |          649 |     36 |           36 |           613 |             0 |            0 |          2 |                 0 |         919500 |              0 |                   0 |      919500 |
|    6 |         613 |           0 |          613 |     25 |           25 |           588 |             0 |            0 |          1 |                 0 |         882000 |              0 |                   0 |      882000 |
|    7 |         588 |           0 |          588 |     41 |           41 |           547 |             0 |            0 |          1 |                 0 |         820500 |              0 |                   0 |      820500 |
|    8 |         547 |           0 |          547 |     14 |           14 |           533 |             0 |            0 |          1 |                 0 |         799500 |              0 |                   0 |      799500 |
|    9 |         533 |           0 |          533 |     47 |           47 |           486 |             0 |            0 |          2 |                 0 |         729000 |              0 |                   0 |      729000 |
|   10 |         486 |           0 |          486 |     12 |           12 |           474 |             0 |            0 |          1 |                 0 |         711000 |              0 |                   0 |      711000 |
|   11 |         474 |           0 |          474 |     23 |           23 |           451 |             0 |            0 |          1 |                 0 |         676500 |              0 |                   0 |      676500 |
|   12 |         451 |           0 |          451 |     14 |           14 |           437 |             0 |            0 |          1 |                 0 |         655500 |              0 |                   0 |      655500 |
|   13 |         437 |           0 |          437 |     31 |           31 |           406 |             0 |            0 |          1 |                 0 |         609000 |              0 |                   0 |      609000 |
|   14 |         406 |           0 |          406 |      7 |            7 |           399 |             0 |            0 |          2 |                 0 |         598500 |              0 |                   0 |      598500 |
|   15 |         399 |           0 |          399 |      4 |            4 |           395 |             0 |            0 |          2 |                 0 |         592500 |              0 |                   0 |      592500 |
|   16 |         395 |           0 |          395 |     14 |           14 |           381 |             0 |            0 |          1 |                 0 |         571500 |              0 |                   0 |      571500 |
|   17 |         381 |           0 |          381 |     17 |           17 |           364 |             0 |            0 |          1 |                 0 |         546000 |              0 |                   0 |      546000 |
|   18 |         364 |           0 |          364 |     42 |           42 |           322 |             0 |            0 |          1 |                 0 |         483000 |              0 |                   0 |      483000 |
|   19 |         322 |           0 |          322 |     38 |           38 |           284 |             0 |            0 |          1 |                 0 |         426000 |              0 |                   0 |      426000 |
|   20 |         284 |           0 |          284 |     33 |           33 |           251 |             0 |            0 |          2 |                 0 |         376500 |              0 |                   0 |      376500 |
|   21 |         251 |           0 |          251 |      7 |            7 |           244 |             0 |            0 |          2 |                 0 |         366000 |              0 |                   0 |      366000 |
|   22 |         244 |           0 |          244 |     26 |           26 |           218 |             0 |            0 |          1 |                 0 |         327000 |              0 |                   0 |      327000 |
|   23 |         218 |           0 |          218 |     32 |           32 |           186 |             0 |            0 |          1 |                 0 |         279000 |              0 |                   0 |      279000 |
|   24 |         186 |           0 |          186 |     49 |           49 |           137 |             0 |            0 |          1 |                 0 |         205500 |              0 |                   0 |      205500 |
|   25 |         137 |           0 |          137 |     31 |           31 |           106 |             0 |            0 |          1 |                 0 |         159000 |              0 |                   0 |      159000 |
|   26 |         106 |           0 |          106 |     33 |           33 |            73 |             0 |            0 |          1 |                 0 |         109500 |              0 |                   0 |      109500 |
|   27 |          73 |           0 |           73 |     19 |           19 |            54 |             0 |            0 |          1 |                 0 |          81000 |              0 |                   0 |       81000 |
|   28 |          54 |           0 |           54 |     39 |           39 |            15 |             0 |            1 |          1 |                29 |          22500 |         500000 |                   0 |      522500 |
|   29 |          15 |         700 |          715 |     36 |           36 |           679 |             0 |            0 |          1 |                 0 |        1018500 |              0 |                   0 |     1018500 |
|   30 |         679 |           0 |          679 |     34 |           34 |           645 |             0 |            0 |          1 |                 0 |         967500 |              0 |                   0 |      967500 |

    ## Total cost yang dikeluarkan saat EOQ = 700 adalah: Rp17.172 juta
    ## Reorder Point hasil perhitungan = 29

Jika kita *run* sekali lagi, maka hasilnya adalah sebagai berikut:

| days | begin\_stok | order\_recv | avail\_stock | demand | full\_filled | ending\_stock | stock\_outage | place\_order | lead\_time | order\_arrive\_at | carrying\_cost | ordering\_cost | stock\_outage\_cost | total\_cost |
| ---: | ----------: | ----------: | -----------: | -----: | -----------: | ------------: | ------------: | -----------: | ---------: | ----------------: | -------------: | -------------: | ------------------: | ----------: |
|    1 |          20 |           0 |           20 |     44 |           20 |             0 |            24 |            1 |          1 |                 2 |              0 |         500000 |              120000 |      620000 |
|    2 |           0 |         700 |          700 |      1 |            1 |           699 |             0 |            0 |          2 |                 0 |        1048500 |              0 |                   0 |     1048500 |
|    3 |         699 |           0 |          699 |     17 |           17 |           682 |             0 |            0 |          1 |                 0 |        1023000 |              0 |                   0 |     1023000 |
|    4 |         682 |           0 |          682 |     30 |           30 |           652 |             0 |            0 |          1 |                 0 |         978000 |              0 |                   0 |      978000 |
|    5 |         652 |           0 |          652 |     43 |           43 |           609 |             0 |            0 |          2 |                 0 |         913500 |              0 |                   0 |      913500 |
|    6 |         609 |           0 |          609 |     39 |           39 |           570 |             0 |            0 |          2 |                 0 |         855000 |              0 |                   0 |      855000 |
|    7 |         570 |           0 |          570 |     40 |           40 |           530 |             0 |            0 |          1 |                 0 |         795000 |              0 |                   0 |      795000 |
|    8 |         530 |           0 |          530 |      6 |            6 |           524 |             0 |            0 |          2 |                 0 |         786000 |              0 |                   0 |      786000 |
|    9 |         524 |           0 |          524 |     25 |           25 |           499 |             0 |            0 |          2 |                 0 |         748500 |              0 |                   0 |      748500 |
|   10 |         499 |           0 |          499 |     49 |           49 |           450 |             0 |            0 |          2 |                 0 |         675000 |              0 |                   0 |      675000 |
|   11 |         450 |           0 |          450 |     40 |           40 |           410 |             0 |            0 |          2 |                 0 |         615000 |              0 |                   0 |      615000 |
|   12 |         410 |           0 |          410 |     11 |           11 |           399 |             0 |            0 |          1 |                 0 |         598500 |              0 |                   0 |      598500 |
|   13 |         399 |           0 |          399 |     17 |           17 |           382 |             0 |            0 |          2 |                 0 |         573000 |              0 |                   0 |      573000 |
|   14 |         382 |           0 |          382 |     48 |           48 |           334 |             0 |            0 |          1 |                 0 |         501000 |              0 |                   0 |      501000 |
|   15 |         334 |           0 |          334 |     24 |           24 |           310 |             0 |            0 |          2 |                 0 |         465000 |              0 |                   0 |      465000 |
|   16 |         310 |           0 |          310 |     20 |           20 |           290 |             0 |            0 |          1 |                 0 |         435000 |              0 |                   0 |      435000 |
|   17 |         290 |           0 |          290 |     36 |           36 |           254 |             0 |            0 |          1 |                 0 |         381000 |              0 |                   0 |      381000 |
|   18 |         254 |           0 |          254 |     11 |           11 |           243 |             0 |            0 |          2 |                 0 |         364500 |              0 |                   0 |      364500 |
|   19 |         243 |           0 |          243 |     40 |           40 |           203 |             0 |            0 |          2 |                 0 |         304500 |              0 |                   0 |      304500 |
|   20 |         203 |           0 |          203 |     27 |           27 |           176 |             0 |            0 |          2 |                 0 |         264000 |              0 |                   0 |      264000 |
|   21 |         176 |           0 |          176 |     47 |           47 |           129 |             0 |            0 |          2 |                 0 |         193500 |              0 |                   0 |      193500 |
|   22 |         129 |           0 |          129 |     15 |           15 |           114 |             0 |            0 |          1 |                 0 |         171000 |              0 |                   0 |      171000 |
|   23 |         114 |           0 |          114 |     34 |           34 |            80 |             0 |            0 |          2 |                 0 |         120000 |              0 |                   0 |      120000 |
|   24 |          80 |           0 |           80 |     27 |           27 |            53 |             0 |            0 |          1 |                 0 |          79500 |              0 |                   0 |       79500 |
|   25 |          53 |           0 |           53 |     34 |           34 |            19 |             0 |            1 |          1 |                26 |          28500 |         500000 |                   0 |      528500 |
|   26 |          19 |         700 |          719 |     22 |           22 |           697 |             0 |            0 |          2 |                 0 |        1045500 |              0 |                   0 |     1045500 |
|   27 |         697 |           0 |          697 |     39 |           39 |           658 |             0 |            0 |          1 |                 0 |         987000 |              0 |                   0 |      987000 |
|   28 |         658 |           0 |          658 |     27 |           27 |           631 |             0 |            0 |          1 |                 0 |         946500 |              0 |                   0 |      946500 |
|   29 |         631 |           0 |          631 |     49 |           49 |           582 |             0 |            0 |          1 |                 0 |         873000 |              0 |                   0 |      873000 |
|   30 |         582 |           0 |          582 |      4 |            4 |           578 |             0 |            0 |          2 |                 0 |         867000 |              0 |                   0 |      867000 |

    ## Total cost yang dikeluarkan saat EOQ = 700 adalah: Rp18.756 juta
    ## Reorder Point hasil perhitungan = 28

Jika kita *run* berulang-ulang sebanyak-banyaknya (inilah salah satu
kelebihan melakukan simulasi menggunakan *coding* seperti **R** atau
Python), maka akan kita dapatkan *expected total cost* berada di kisaran
Rp16 - Rp17 juta.

# Perbandingan dengan Hitungan Teoritis

Dari berbagai jurnal terkait *automatic replenishment*, saya mendapatkan
suatu istilah *economic order quantity* (EOQ), yakni suatu nilai
pemesanan bahan baku yang bisa meminimalkan semua biaya yang timbul
(*ordering cost* dan *carrying cost*). Secara teoritis, cara menghitung
EOQ yang optimal adalah sebagai berikut:

  
![eoq = \\sqrt{ \\frac{2 \\times D \\times
C\_0}{C\_h}}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;eoq%20%3D%20%5Csqrt%7B%20%5Cfrac%7B2%20%5Ctimes%20D%20%5Ctimes%20C_0%7D%7BC_h%7D%7D
"eoq = \\sqrt{ \\frac{2 \\times D \\times C_0}{C_h}}")  

Di mana:

  - *D* : *demand* pada 30 hari.
  - ![C\_0](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;C_0
    "C_0") : *ordering cost*.
  - ![C\_h](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;C_h
    "C_h") : *carrying cost*.

Hal yang dimaksud dengan optimal di sini adalah EOQ yang bisa
meminimalkan *ordering cost* dan *carrying cost*. Selain itu ROP juga
ada formula tersendiri. Biasanya ROP dihitung dengan cara:

  
![rop = \\hat{D} +
ss](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;rop%20%3D%20%5Chat%7BD%7D%20%2B%20ss
"rop = \\hat{D} + ss")  

Di mana:

  - ![\\hat{D}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7BD%7D
    "\\hat{D}") : *average demand during lead time*.
  - ![ss](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;ss
    "ss") : *safety stock*; dihitung dengan mengasumsikan *service
    level* terpenuhi.

*Service level* adalah persentase di mana *demand* diharapkan terpenuhi.
Formula untuk menghitung
![ss](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;ss
"ss") adalah:

  
![ss = normsinv(CSL) \* \\sigma
D](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;ss%20%3D%20normsinv%28CSL%29%20%2A%20%5Csigma%20D
"ss = normsinv(CSL) * \\sigma D")  

Di mana:

  - ![CSL](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;CSL
    "CSL") : *cycle service level* misalkan dipakai `95%`.
  - ![\\sigma
    D](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Csigma%20D
    "\\sigma D") : standar deviasi demand pada *lead time*.

Jika saya melakukan simulasi kembali dengan nilai EOQ dan ROP sesuai
dengan teoritis, maka kita dapatkan:

| days | begin\_stok | order\_recv | avail\_stock | demand | full\_filled | ending\_stock | stock\_outage | place\_order | lead\_time | order\_arrive\_at | carrying\_cost | ordering\_cost | stock\_outage\_cost | total\_cost |
| ---: | ----------: | ----------: | -----------: | -----: | -----------: | ------------: | ------------: | -----------: | ---------: | ----------------: | -------------: | -------------: | ------------------: | ----------: |
|    1 |          20 |           0 |           20 |     46 |           20 |             0 |            26 |            1 |          2 |                 3 |              0 |         500000 |              130000 |      630000 |
|    2 |           0 |           0 |            0 |     36 |            0 |             0 |            36 |            1 |          2 |                 0 |              0 |              0 |              180000 |      180000 |
|    3 |           0 |         644 |          644 |      1 |            1 |           643 |             0 |            0 |          1 |                 0 |         964500 |              0 |                   0 |      964500 |
|    4 |         643 |           0 |          643 |     36 |           36 |           607 |             0 |            0 |          1 |                 0 |         910500 |              0 |                   0 |      910500 |
|    5 |         607 |           0 |          607 |     41 |           41 |           566 |             0 |            0 |          1 |                 0 |         849000 |              0 |                   0 |      849000 |
|    6 |         566 |           0 |          566 |      7 |            7 |           559 |             0 |            0 |          1 |                 0 |         838500 |              0 |                   0 |      838500 |
|    7 |         559 |           0 |          559 |     34 |           34 |           525 |             0 |            0 |          2 |                 0 |         787500 |              0 |                   0 |      787500 |
|    8 |         525 |           0 |          525 |     10 |           10 |           515 |             0 |            0 |          1 |                 0 |         772500 |              0 |                   0 |      772500 |
|    9 |         515 |           0 |          515 |     12 |           12 |           503 |             0 |            0 |          2 |                 0 |         754500 |              0 |                   0 |      754500 |
|   10 |         503 |           0 |          503 |     44 |           44 |           459 |             0 |            0 |          1 |                 0 |         688500 |              0 |                   0 |      688500 |
|   11 |         459 |           0 |          459 |     43 |           43 |           416 |             0 |            0 |          2 |                 0 |         624000 |              0 |                   0 |      624000 |
|   12 |         416 |           0 |          416 |     22 |           22 |           394 |             0 |            0 |          1 |                 0 |         591000 |              0 |                   0 |      591000 |
|   13 |         394 |           0 |          394 |      3 |            3 |           391 |             0 |            0 |          2 |                 0 |         586500 |              0 |                   0 |      586500 |
|   14 |         391 |           0 |          391 |      1 |            1 |           390 |             0 |            0 |          2 |                 0 |         585000 |              0 |                   0 |      585000 |
|   15 |         390 |           0 |          390 |     44 |           44 |           346 |             0 |            0 |          1 |                 0 |         519000 |              0 |                   0 |      519000 |
|   16 |         346 |           0 |          346 |      1 |            1 |           345 |             0 |            0 |          2 |                 0 |         517500 |              0 |                   0 |      517500 |
|   17 |         345 |           0 |          345 |     37 |           37 |           308 |             0 |            0 |          1 |                 0 |         462000 |              0 |                   0 |      462000 |
|   18 |         308 |           0 |          308 |      6 |            6 |           302 |             0 |            0 |          2 |                 0 |         453000 |              0 |                   0 |      453000 |
|   19 |         302 |           0 |          302 |     13 |           13 |           289 |             0 |            0 |          1 |                 0 |         433500 |              0 |                   0 |      433500 |
|   20 |         289 |           0 |          289 |      5 |            5 |           284 |             0 |            0 |          2 |                 0 |         426000 |              0 |                   0 |      426000 |
|   21 |         284 |           0 |          284 |      7 |            7 |           277 |             0 |            0 |          1 |                 0 |         415500 |              0 |                   0 |      415500 |
|   22 |         277 |           0 |          277 |     33 |           33 |           244 |             0 |            0 |          2 |                 0 |         366000 |              0 |                   0 |      366000 |
|   23 |         244 |           0 |          244 |     27 |           27 |           217 |             0 |            0 |          2 |                 0 |         325500 |              0 |                   0 |      325500 |
|   24 |         217 |           0 |          217 |     16 |           16 |           201 |             0 |            0 |          2 |                 0 |         301500 |              0 |                   0 |      301500 |
|   25 |         201 |           0 |          201 |     18 |           18 |           183 |             0 |            0 |          1 |                 0 |         274500 |              0 |                   0 |      274500 |
|   26 |         183 |           0 |          183 |     20 |           20 |           163 |             0 |            0 |          1 |                 0 |         244500 |              0 |                   0 |      244500 |
|   27 |         163 |           0 |          163 |      5 |            5 |           158 |             0 |            0 |          1 |                 0 |         237000 |              0 |                   0 |      237000 |
|   28 |         158 |           0 |          158 |     20 |           20 |           138 |             0 |            0 |          2 |                 0 |         207000 |              0 |                   0 |      207000 |
|   29 |         138 |           0 |          138 |      5 |            5 |           133 |             0 |            0 |          1 |                 0 |         199500 |              0 |                   0 |      199500 |
|   30 |         133 |           0 |          133 |     29 |           29 |           104 |             0 |            0 |          1 |                 0 |         156000 |              0 |                   0 |      156000 |

    ## Total cost yang dikeluarkan saat EOQ = 644 adalah: Rp15.3 juta
    ## Reorder Point hasil perhitungan = 46

Dari sekali simulasi, kita dapatkan nilai EOQ yang lebih rendah tapi
nilai ROP yang lebih tinggi. Jika simulasi ini dilakukan berulang-ulang
kali sebanyak-banyaknya, kita dapatkan *expected* EOQ berada di kisaran
620 - 670 liter air dengan *expected total cost* berada di kisaran Rp15 - Rp16 juta.

> **Total cost yang dihasilkan relatif lebih rendah dibandingkan kondisi
> saat ini dimana EOQ diwajibkan sebesar 700 liter**

# Hasil Optimal dari Simulasi

Salah satu pertanyaan yang muncul di benak saya adalah, apakah EOQ yang
dihasilkan di atas sudah optimal? Salah satu *concern* saya adalah jika
EOQ yang digunakan bernilai besar, salah satu konsekuensinya adalah
*carrying cost*-nya juga meledak.

Lantas, saya mencoba melakukan simulasi dengan mencoba nilai EOQ = 200
dan nilai ROP masih sama sesuai dengan formulasi perhitungan sebelumnya.
Begini hasil simulasinya:

| days | begin\_stok | order\_recv | avail\_stock | demand | full\_filled | ending\_stock | stock\_outage | place\_order | lead\_time | order\_arrive\_at | carrying\_cost | ordering\_cost | stock\_outage\_cost | total\_cost |
| ---: | ----------: | ----------: | -----------: | -----: | -----------: | ------------: | ------------: | -----------: | ---------: | ----------------: | -------------: | -------------: | ------------------: | ----------: |
|    1 |          20 |           0 |           20 |     49 |           20 |             0 |            29 |            1 |          1 |                 2 |              0 |         500000 |              145000 |      645000 |
|    2 |           0 |         200 |          200 |     35 |           35 |           165 |             0 |            0 |          1 |                 0 |         247500 |              0 |                   0 |      247500 |
|    3 |         165 |           0 |          165 |     43 |           43 |           122 |             0 |            0 |          2 |                 0 |         183000 |              0 |                   0 |      183000 |
|    4 |         122 |           0 |          122 |     30 |           30 |            92 |             0 |            0 |          2 |                 0 |         138000 |              0 |                   0 |      138000 |
|    5 |          92 |           0 |           92 |     45 |           45 |            47 |             0 |            1 |          1 |                 6 |          70500 |         500000 |                   0 |      570500 |
|    6 |          47 |         200 |          247 |     43 |           43 |           204 |             0 |            0 |          2 |                 0 |         306000 |              0 |                   0 |      306000 |
|    7 |         204 |           0 |          204 |     23 |           23 |           181 |             0 |            0 |          2 |                 0 |         271500 |              0 |                   0 |      271500 |
|    8 |         181 |           0 |          181 |     14 |           14 |           167 |             0 |            0 |          1 |                 0 |         250500 |              0 |                   0 |      250500 |
|    9 |         167 |           0 |          167 |     30 |           30 |           137 |             0 |            0 |          2 |                 0 |         205500 |              0 |                   0 |      205500 |
|   10 |         137 |           0 |          137 |     40 |           40 |            97 |             0 |            0 |          2 |                 0 |         145500 |              0 |                   0 |      145500 |
|   11 |          97 |           0 |           97 |     39 |           39 |            58 |             0 |            0 |          1 |                 0 |          87000 |              0 |                   0 |       87000 |
|   12 |          58 |           0 |           58 |     47 |           47 |            11 |             0 |            1 |          2 |                14 |          16500 |         500000 |                   0 |      516500 |
|   13 |          11 |           0 |           11 |     31 |           11 |             0 |            20 |            1 |          2 |                 0 |              0 |              0 |              100000 |      100000 |
|   14 |           0 |         200 |          200 |     41 |           41 |           159 |             0 |            0 |          1 |                 0 |         238500 |              0 |                   0 |      238500 |
|   15 |         159 |           0 |          159 |     30 |           30 |           129 |             0 |            0 |          2 |                 0 |         193500 |              0 |                   0 |      193500 |
|   16 |         129 |           0 |          129 |     46 |           46 |            83 |             0 |            0 |          1 |                 0 |         124500 |              0 |                   0 |      124500 |
|   17 |          83 |           0 |           83 |      6 |            6 |            77 |             0 |            0 |          1 |                 0 |         115500 |              0 |                   0 |      115500 |
|   18 |          77 |           0 |           77 |      8 |            8 |            69 |             0 |            0 |          1 |                 0 |         103500 |              0 |                   0 |      103500 |
|   19 |          69 |           0 |           69 |     41 |           41 |            28 |             0 |            1 |          1 |                20 |          42000 |         500000 |                   0 |      542000 |
|   20 |          28 |         200 |          228 |     37 |           37 |           191 |             0 |            0 |          1 |                 0 |         286500 |              0 |                   0 |      286500 |
|   21 |         191 |           0 |          191 |     38 |           38 |           153 |             0 |            0 |          1 |                 0 |         229500 |              0 |                   0 |      229500 |
|   22 |         153 |           0 |          153 |      2 |            2 |           151 |             0 |            0 |          2 |                 0 |         226500 |              0 |                   0 |      226500 |
|   23 |         151 |           0 |          151 |     26 |           26 |           125 |             0 |            0 |          1 |                 0 |         187500 |              0 |                   0 |      187500 |
|   24 |         125 |           0 |          125 |     11 |           11 |           114 |             0 |            0 |          1 |                 0 |         171000 |              0 |                   0 |      171000 |
|   25 |         114 |           0 |          114 |     46 |           46 |            68 |             0 |            0 |          1 |                 0 |         102000 |              0 |                   0 |      102000 |
|   26 |          68 |           0 |           68 |      4 |            4 |            64 |             0 |            0 |          2 |                 0 |          96000 |              0 |                   0 |       96000 |
|   27 |          64 |           0 |           64 |     34 |           34 |            30 |             0 |            1 |          1 |                28 |          45000 |         500000 |                   0 |      545000 |
|   28 |          30 |         200 |          230 |      3 |            3 |           227 |             0 |            0 |          2 |                 0 |         340500 |              0 |                   0 |      340500 |
|   29 |         227 |           0 |          227 |     36 |           36 |           191 |             0 |            0 |          1 |                 0 |         286500 |              0 |                   0 |      286500 |
|   30 |         191 |           0 |          191 |     16 |           16 |           175 |             0 |            0 |          2 |                 0 |         262500 |              0 |                   0 |      262500 |

    ## Total cost yang dikeluarkan saat EOQ = 200 adalah: Rp7.718 juta
    ## Reorder Point hasil perhitungan = 54

Secara mengejutkan *total cost* yang dihasilkan jauh lebih menurun\!
Lalu kita bisa lihat, walaupun *stock outage cost* meningkat tapi
nilainya tetap terjaga akibat ROP yang tinggi.

Jika saya melakukan simulasi ini berulang kali, saya dapatkan *expected
total cost* sebesar Rp6 - Rp7 juta.

-----

# Kesimpulan

Nilai EOQ = 200 belum tentu merupakan solusi yang paling optimal karena
saya hanya melakukan coba-coba saja. Jika mau menemukan solusi yang
optimal berdasarkan algoritma simulasi ini, saya bisa memanfaatkan
[algoritma spiral](https://ikanx101.com/blog/spiral-rpubs/).

Penentuan ROP bisa jadi menjadi titik kritis karena akan menentukan
kapan bahan baku air harus dipesan sehingga bisa meminimalisir *loss
sales*.

Saya menduga dengan mengecilkan EOQ dan membuat ROP tinggi (sesuai
dengan formula yang ada) bisa meminimalisir *total cost* yang timbul.

-----

`if you find this article helpful, support this blog by clicking the
ads`
