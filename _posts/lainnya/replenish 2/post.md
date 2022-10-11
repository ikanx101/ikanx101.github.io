Membuat Algoritma untuk Simulasi Automatic Replenishment
================

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
    (misal: kapasitas tanki = 700 liter). *Lead time* pengiriman
    bervariasi selama 1-2 hari dari hari pemesanan. Pemesanan dan
    pengiriman bisa dilakukan hari apa saja.
3.  Pemesanan baru dilakukan jika **stok air di tangki depot sudah
    kurang dari** ***safety stock*** yang ditetapkan perusahaan. Cara
    perusahaan menghitung ***safety stock*** adalah: ![ss = 2 \\times
    \\sigma
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
9.  Saldo air di tangki depot pada hari `1` adalah sebesar 10 liter air.
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
    stock_out_cost = 500000

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
    begin_stok = c(10)
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
|    1 |          10 |           0 |            0 |      0 |            0 |             0 |             0 |            1 |          2 |                 3 |              0 |         500000 |                   0 |      500000 |
|    2 |           0 |           0 |            0 |      8 |            0 |             0 |             8 |            1 |          1 |                 0 |              0 |              0 |               40000 |       40000 |
|    3 |           0 |         700 |          700 |      5 |            5 |           695 |             0 |            0 |          1 |                 0 |        1042500 |              0 |                   0 |     1042500 |
|    4 |         695 |           0 |          695 |     36 |           36 |           659 |             0 |            0 |          1 |                 0 |         988500 |              0 |                   0 |      988500 |
|    5 |         659 |           0 |          659 |      8 |            8 |           651 |             0 |            0 |          1 |                 0 |         976500 |              0 |                   0 |      976500 |
|    6 |         651 |           0 |          651 |     34 |           34 |           617 |             0 |            0 |          2 |                 0 |         925500 |              0 |                   0 |      925500 |
|    7 |         617 |           0 |          617 |      5 |            5 |           612 |             0 |            0 |          1 |                 0 |         918000 |              0 |                   0 |      918000 |
|    8 |         612 |           0 |          612 |     33 |           33 |           579 |             0 |            0 |          2 |                 0 |         868500 |              0 |                   0 |      868500 |
|    9 |         579 |           0 |          579 |     30 |           30 |           549 |             0 |            0 |          1 |                 0 |         823500 |              0 |                   0 |      823500 |
|   10 |         549 |           0 |          549 |     20 |           20 |           529 |             0 |            0 |          2 |                 0 |         793500 |              0 |                   0 |      793500 |
|   11 |         529 |           0 |          529 |     23 |           23 |           506 |             0 |            0 |          2 |                 0 |         759000 |              0 |                   0 |      759000 |
|   12 |         506 |           0 |          506 |      1 |            1 |           505 |             0 |            0 |          2 |                 0 |         757500 |              0 |                   0 |      757500 |
|   13 |         505 |           0 |          505 |     35 |           35 |           470 |             0 |            0 |          2 |                 0 |         705000 |              0 |                   0 |      705000 |
|   14 |         470 |           0 |          470 |     41 |           41 |           429 |             0 |            0 |          2 |                 0 |         643500 |              0 |                   0 |      643500 |
|   15 |         429 |           0 |          429 |     31 |           31 |           398 |             0 |            0 |          1 |                 0 |         597000 |              0 |                   0 |      597000 |
|   16 |         398 |           0 |          398 |     42 |           42 |           356 |             0 |            0 |          1 |                 0 |         534000 |              0 |                   0 |      534000 |
|   17 |         356 |           0 |          356 |     14 |           14 |           342 |             0 |            0 |          2 |                 0 |         513000 |              0 |                   0 |      513000 |
|   18 |         342 |           0 |          342 |     42 |           42 |           300 |             0 |            0 |          2 |                 0 |         450000 |              0 |                   0 |      450000 |
|   19 |         300 |           0 |          300 |     45 |           45 |           255 |             0 |            0 |          1 |                 0 |         382500 |              0 |                   0 |      382500 |
|   20 |         255 |           0 |          255 |     13 |           13 |           242 |             0 |            0 |          2 |                 0 |         363000 |              0 |                   0 |      363000 |
|   21 |         242 |           0 |          242 |     44 |           44 |           198 |             0 |            0 |          1 |                 0 |         297000 |              0 |                   0 |      297000 |
|   22 |         198 |           0 |          198 |     17 |           17 |           181 |             0 |            0 |          1 |                 0 |         271500 |              0 |                   0 |      271500 |
|   23 |         181 |           0 |          181 |     13 |           13 |           168 |             0 |            0 |          2 |                 0 |         252000 |              0 |                   0 |      252000 |
|   24 |         168 |           0 |          168 |     42 |           42 |           126 |             0 |            0 |          1 |                 0 |         189000 |              0 |                   0 |      189000 |
|   25 |         126 |           0 |          126 |      3 |            3 |           123 |             0 |            0 |          1 |                 0 |         184500 |              0 |                   0 |      184500 |
|   26 |         123 |           0 |          123 |     49 |           49 |            74 |             0 |            0 |          2 |                 0 |         111000 |              0 |                   0 |      111000 |
|   27 |          74 |           0 |           74 |     49 |           49 |            25 |             0 |            1 |          1 |                28 |          37500 |         500000 |                   0 |      537500 |
|   28 |          25 |         700 |          725 |     46 |           46 |           679 |             0 |            0 |          2 |                 0 |        1018500 |              0 |                   0 |     1018500 |
|   29 |         679 |           0 |          679 |     18 |           18 |           661 |             0 |            0 |          2 |                 0 |         991500 |              0 |                   0 |      991500 |
|   30 |         661 |           0 |          661 |     24 |           24 |           637 |             0 |            0 |          2 |                 0 |         955500 |              0 |                   0 |      955500 |

    ## Total cost yang dikeluarkan saat EOQ = 700 adalah: Rp18.389 juta
    ## Safety stock hasil perhitungan = 32

Jika kita *run* sekali lagi, maka hasilnya adalah sebagai berikut:

| days | begin\_stok | order\_recv | avail\_stock | demand | full\_filled | ending\_stock | stock\_outage | place\_order | lead\_time | order\_arrive\_at | carrying\_cost | ordering\_cost | stock\_outage\_cost | total\_cost |
| ---: | ----------: | ----------: | -----------: | -----: | -----------: | ------------: | ------------: | -----------: | ---------: | ----------------: | -------------: | -------------: | ------------------: | ----------: |
|    1 |          10 |           0 |            0 |     27 |            0 |             0 |            27 |            1 |          2 |                 3 |              0 |         500000 |              135000 |      635000 |
|    2 |           0 |           0 |            0 |     27 |            0 |             0 |            27 |            1 |          2 |                 0 |              0 |              0 |              135000 |      135000 |
|    3 |           0 |         700 |          700 |     31 |           31 |           669 |             0 |            0 |          2 |                 0 |        1003500 |              0 |                   0 |     1003500 |
|    4 |         669 |           0 |          669 |     33 |           33 |           636 |             0 |            0 |          2 |                 0 |         954000 |              0 |                   0 |      954000 |
|    5 |         636 |           0 |          636 |     39 |           39 |           597 |             0 |            0 |          2 |                 0 |         895500 |              0 |                   0 |      895500 |
|    6 |         597 |           0 |          597 |     11 |           11 |           586 |             0 |            0 |          1 |                 0 |         879000 |              0 |                   0 |      879000 |
|    7 |         586 |           0 |          586 |     35 |           35 |           551 |             0 |            0 |          1 |                 0 |         826500 |              0 |                   0 |      826500 |
|    8 |         551 |           0 |          551 |     33 |           33 |           518 |             0 |            0 |          2 |                 0 |         777000 |              0 |                   0 |      777000 |
|    9 |         518 |           0 |          518 |      8 |            8 |           510 |             0 |            0 |          2 |                 0 |         765000 |              0 |                   0 |      765000 |
|   10 |         510 |           0 |          510 |     16 |           16 |           494 |             0 |            0 |          2 |                 0 |         741000 |              0 |                   0 |      741000 |
|   11 |         494 |           0 |          494 |     24 |           24 |           470 |             0 |            0 |          1 |                 0 |         705000 |              0 |                   0 |      705000 |
|   12 |         470 |           0 |          470 |     31 |           31 |           439 |             0 |            0 |          1 |                 0 |         658500 |              0 |                   0 |      658500 |
|   13 |         439 |           0 |          439 |     17 |           17 |           422 |             0 |            0 |          2 |                 0 |         633000 |              0 |                   0 |      633000 |
|   14 |         422 |           0 |          422 |      0 |            0 |           422 |             0 |            0 |          1 |                 0 |         633000 |              0 |                   0 |      633000 |
|   15 |         422 |           0 |          422 |     31 |           31 |           391 |             0 |            0 |          2 |                 0 |         586500 |              0 |                   0 |      586500 |
|   16 |         391 |           0 |          391 |     20 |           20 |           371 |             0 |            0 |          1 |                 0 |         556500 |              0 |                   0 |      556500 |
|   17 |         371 |           0 |          371 |     20 |           20 |           351 |             0 |            0 |          1 |                 0 |         526500 |              0 |                   0 |      526500 |
|   18 |         351 |           0 |          351 |     38 |           38 |           313 |             0 |            0 |          1 |                 0 |         469500 |              0 |                   0 |      469500 |
|   19 |         313 |           0 |          313 |      1 |            1 |           312 |             0 |            0 |          1 |                 0 |         468000 |              0 |                   0 |      468000 |
|   20 |         312 |           0 |          312 |     20 |           20 |           292 |             0 |            0 |          1 |                 0 |         438000 |              0 |                   0 |      438000 |
|   21 |         292 |           0 |          292 |     50 |           50 |           242 |             0 |            0 |          1 |                 0 |         363000 |              0 |                   0 |      363000 |
|   22 |         242 |           0 |          242 |     13 |           13 |           229 |             0 |            0 |          1 |                 0 |         343500 |              0 |                   0 |      343500 |
|   23 |         229 |           0 |          229 |     27 |           27 |           202 |             0 |            0 |          2 |                 0 |         303000 |              0 |                   0 |      303000 |
|   24 |         202 |           0 |          202 |     21 |           21 |           181 |             0 |            0 |          2 |                 0 |         271500 |              0 |                   0 |      271500 |
|   25 |         181 |           0 |          181 |      7 |            7 |           174 |             0 |            0 |          2 |                 0 |         261000 |              0 |                   0 |      261000 |
|   26 |         174 |           0 |          174 |     16 |           16 |           158 |             0 |            0 |          2 |                 0 |         237000 |              0 |                   0 |      237000 |
|   27 |         158 |           0 |          158 |     26 |           26 |           132 |             0 |            0 |          2 |                 0 |         198000 |              0 |                   0 |      198000 |
|   28 |         132 |           0 |          132 |     36 |           36 |            96 |             0 |            0 |          2 |                 0 |         144000 |              0 |                   0 |      144000 |
|   29 |          96 |           0 |           96 |     42 |           42 |            54 |             0 |            0 |          2 |                 0 |          81000 |              0 |                   0 |       81000 |
|   30 |          54 |           0 |           54 |      9 |            9 |            45 |             0 |            0 |          2 |                 0 |          67500 |              0 |                   0 |       67500 |

    ## Total cost yang dikeluarkan saat EOQ = 700 adalah: Rp15.556 juta
    ## Safety stock hasil perhitungan = 25

Jika kita *run* berulang-ulang sebanyak-banyaknya (inilah salah satu
kelebihan melakukan simulasi menggunakan *coding* seperti **R** atau
Python), maka akan kita dapatkan *expected total cost* berada di kisaran
Rp16 - Rp17 juta.

# Perbandingan dengan Hitungan Teoritis

Dari berbagai literatur terkait optimisasi *automatic replenishment*,
saya mendapatkan suatu istilah *economic order quantity* (EOQ), yakni
suatu nilai pemesanan bahan baku yang bisa meminimalkan semua biaya yang
timbul (*ordering cost* dan *carrying cost*). Secara teoritis, cara
menghitung EOQ adalah sebagai berikut:

  
![eoq = \\sqrt{ \\frac{2 \\times D \\times
C\_0}{C\_h}}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;eoq%20%3D%20%5Csqrt%7B%20%5Cfrac%7B2%20%5Ctimes%20D%20%5Ctimes%20C_0%7D%7BC_h%7D%7D
"eoq = \\sqrt{ \\frac{2 \\times D \\times C_0}{C_h}}")  

``` 
    # D = demand 
    # C0 = ordering cost
    # Ch = carrying cost
```

# Hasil Optimal dari Simulasi
