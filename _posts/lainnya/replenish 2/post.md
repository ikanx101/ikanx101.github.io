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

Di mana:

  - *D* : *demand* pada 30 hari.
  - ![C\_0](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;C_0
    "C_0") : *ordering cost*.
  - ![C\_h](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;C_h
    "C_h") : *carrying cost*.

Jika kita melakukan simulasi kembali dengan nilai EOQ sesuai dengan
teoritis, maka kita dapatkan:

| days | begin\_stok | order\_recv | avail\_stock | demand | full\_filled | ending\_stock | stock\_outage | place\_order | lead\_time | order\_arrive\_at | carrying\_cost | ordering\_cost | stock\_outage\_cost | total\_cost |
| ---: | ----------: | ----------: | -----------: | -----: | -----------: | ------------: | ------------: | -----------: | ---------: | ----------------: | -------------: | -------------: | ------------------: | ----------: |
|    1 |          10 |           0 |            0 |     12 |            0 |             0 |            12 |            1 |          1 |                 2 |              0 |         500000 |               60000 |      560000 |
|    2 |           0 |         677 |          677 |     14 |           14 |           663 |             0 |            0 |          1 |                 0 |         994500 |              0 |                   0 |      994500 |
|    3 |         663 |           0 |          663 |     28 |           28 |           635 |             0 |            0 |          1 |                 0 |         952500 |              0 |                   0 |      952500 |
|    4 |         635 |           0 |          635 |     11 |           11 |           624 |             0 |            0 |          1 |                 0 |         936000 |              0 |                   0 |      936000 |
|    5 |         624 |           0 |          624 |     36 |           36 |           588 |             0 |            0 |          2 |                 0 |         882000 |              0 |                   0 |      882000 |
|    6 |         588 |           0 |          588 |     15 |           15 |           573 |             0 |            0 |          2 |                 0 |         859500 |              0 |                   0 |      859500 |
|    7 |         573 |           0 |          573 |     15 |           15 |           558 |             0 |            0 |          2 |                 0 |         837000 |              0 |                   0 |      837000 |
|    8 |         558 |           0 |          558 |     47 |           47 |           511 |             0 |            0 |          1 |                 0 |         766500 |              0 |                   0 |      766500 |
|    9 |         511 |           0 |          511 |     16 |           16 |           495 |             0 |            0 |          2 |                 0 |         742500 |              0 |                   0 |      742500 |
|   10 |         495 |           0 |          495 |     10 |           10 |           485 |             0 |            0 |          2 |                 0 |         727500 |              0 |                   0 |      727500 |
|   11 |         485 |           0 |          485 |     32 |           32 |           453 |             0 |            0 |          1 |                 0 |         679500 |              0 |                   0 |      679500 |
|   12 |         453 |           0 |          453 |     23 |           23 |           430 |             0 |            0 |          2 |                 0 |         645000 |              0 |                   0 |      645000 |
|   13 |         430 |           0 |          430 |      6 |            6 |           424 |             0 |            0 |          2 |                 0 |         636000 |              0 |                   0 |      636000 |
|   14 |         424 |           0 |          424 |     10 |           10 |           414 |             0 |            0 |          1 |                 0 |         621000 |              0 |                   0 |      621000 |
|   15 |         414 |           0 |          414 |     32 |           32 |           382 |             0 |            0 |          2 |                 0 |         573000 |              0 |                   0 |      573000 |
|   16 |         382 |           0 |          382 |     41 |           41 |           341 |             0 |            0 |          1 |                 0 |         511500 |              0 |                   0 |      511500 |
|   17 |         341 |           0 |          341 |     44 |           44 |           297 |             0 |            0 |          2 |                 0 |         445500 |              0 |                   0 |      445500 |
|   18 |         297 |           0 |          297 |     38 |           38 |           259 |             0 |            0 |          2 |                 0 |         388500 |              0 |                   0 |      388500 |
|   19 |         259 |           0 |          259 |     49 |           49 |           210 |             0 |            0 |          2 |                 0 |         315000 |              0 |                   0 |      315000 |
|   20 |         210 |           0 |          210 |     42 |           42 |           168 |             0 |            0 |          2 |                 0 |         252000 |              0 |                   0 |      252000 |
|   21 |         168 |           0 |          168 |     16 |           16 |           152 |             0 |            0 |          1 |                 0 |         228000 |              0 |                   0 |      228000 |
|   22 |         152 |           0 |          152 |      5 |            5 |           147 |             0 |            0 |          1 |                 0 |         220500 |              0 |                   0 |      220500 |
|   23 |         147 |           0 |          147 |     19 |           19 |           128 |             0 |            0 |          1 |                 0 |         192000 |              0 |                   0 |      192000 |
|   24 |         128 |           0 |          128 |      6 |            6 |           122 |             0 |            0 |          1 |                 0 |         183000 |              0 |                   0 |      183000 |
|   25 |         122 |           0 |          122 |      6 |            6 |           116 |             0 |            0 |          1 |                 0 |         174000 |              0 |                   0 |      174000 |
|   26 |         116 |           0 |          116 |      4 |            4 |           112 |             0 |            0 |          1 |                 0 |         168000 |              0 |                   0 |      168000 |
|   27 |         112 |           0 |          112 |     38 |           38 |            74 |             0 |            0 |          1 |                 0 |         111000 |              0 |                   0 |      111000 |
|   28 |          74 |           0 |           74 |     14 |           14 |            60 |             0 |            0 |          2 |                 0 |          90000 |              0 |                   0 |       90000 |
|   29 |          60 |           0 |           60 |     32 |           32 |            28 |             0 |            1 |          2 |                31 |          42000 |         500000 |                   0 |      542000 |
|   30 |          28 |           0 |           28 |     26 |           26 |             2 |             0 |            1 |          1 |                 0 |           3000 |              0 |                   0 |        3000 |

    ## Total cost yang dikeluarkan saat EOQ = 677 adalah: Rp15.236 juta
    ## Safety stock hasil perhitungan = 28

Jika simulasi dilakukan berulang-ulang kali sebanyak-banyaknya, kita
dapatkan *expected* EOQ berada di kisaran 620 - 670 liter air dengan
*expected total cost* berada di kisaran Rp15 - Rp16 juta.

> **Lebih rendah dibandingkan kondisi saat ini dimana EOQ diwajibkan
> sebesar 700 liter**

# Hasil Optimal dari Simulasi

Salah satu pertanyaan yang muncul di benak saya adalah, apakah EOQ yang
dihasilkan di atas sudah optimal? Salah satu *concern* saya adalah jika
EOQ yang digunakan bernilai besar, salah satu konsekuensinya adalah
*carrying cost*-nya juga meledak.

Lantas, saya mencoba melakukan simulasi dengan mencoba nilai EOQ = 200.
Begini hasil simulasinya:

| days | begin\_stok | order\_recv | avail\_stock | demand | full\_filled | ending\_stock | stock\_outage | place\_order | lead\_time | order\_arrive\_at | carrying\_cost | ordering\_cost | stock\_outage\_cost | total\_cost |
| ---: | ----------: | ----------: | -----------: | -----: | -----------: | ------------: | ------------: | -----------: | ---------: | ----------------: | -------------: | -------------: | ------------------: | ----------: |
|    1 |          10 |           0 |            0 |      8 |            0 |             0 |             8 |            1 |          2 |                 3 |              0 |         500000 |               40000 |      540000 |
|    2 |           0 |           0 |            0 |     43 |            0 |             0 |            43 |            1 |          2 |                 0 |              0 |              0 |              215000 |      215000 |
|    3 |           0 |         200 |          200 |     22 |           22 |           178 |             0 |            0 |          2 |                 0 |         267000 |              0 |                   0 |      267000 |
|    4 |         178 |           0 |          178 |      2 |            2 |           176 |             0 |            0 |          1 |                 0 |         264000 |              0 |                   0 |      264000 |
|    5 |         176 |           0 |          176 |     27 |           27 |           149 |             0 |            0 |          2 |                 0 |         223500 |              0 |                   0 |      223500 |
|    6 |         149 |           0 |          149 |     11 |           11 |           138 |             0 |            0 |          1 |                 0 |         207000 |              0 |                   0 |      207000 |
|    7 |         138 |           0 |          138 |      6 |            6 |           132 |             0 |            0 |          1 |                 0 |         198000 |              0 |                   0 |      198000 |
|    8 |         132 |           0 |          132 |     16 |           16 |           116 |             0 |            0 |          1 |                 0 |         174000 |              0 |                   0 |      174000 |
|    9 |         116 |           0 |          116 |     32 |           32 |            84 |             0 |            0 |          2 |                 0 |         126000 |              0 |                   0 |      126000 |
|   10 |          84 |           0 |           84 |     44 |           44 |            40 |             0 |            0 |          1 |                 0 |          60000 |              0 |                   0 |       60000 |
|   11 |          40 |           0 |           40 |     19 |           19 |            21 |             0 |            1 |          2 |                13 |          31500 |         500000 |                   0 |      531500 |
|   12 |          21 |           0 |           21 |     18 |           18 |             3 |             0 |            1 |          1 |                 0 |           4500 |              0 |                   0 |        4500 |
|   13 |           3 |         200 |          203 |     21 |           21 |           182 |             0 |            0 |          1 |                 0 |         273000 |              0 |                   0 |      273000 |
|   14 |         182 |           0 |          182 |     35 |           35 |           147 |             0 |            0 |          2 |                 0 |         220500 |              0 |                   0 |      220500 |
|   15 |         147 |           0 |          147 |     27 |           27 |           120 |             0 |            0 |          2 |                 0 |         180000 |              0 |                   0 |      180000 |
|   16 |         120 |           0 |          120 |     14 |           14 |           106 |             0 |            0 |          1 |                 0 |         159000 |              0 |                   0 |      159000 |
|   17 |         106 |           0 |          106 |      2 |            2 |           104 |             0 |            0 |          2 |                 0 |         156000 |              0 |                   0 |      156000 |
|   18 |         104 |           0 |          104 |     21 |           21 |            83 |             0 |            0 |          1 |                 0 |         124500 |              0 |                   0 |      124500 |
|   19 |          83 |           0 |           83 |     28 |           28 |            55 |             0 |            0 |          1 |                 0 |          82500 |              0 |                   0 |       82500 |
|   20 |          55 |           0 |           55 |     48 |           48 |             7 |             0 |            1 |          1 |                21 |          10500 |         500000 |                   0 |      510500 |
|   21 |           7 |         200 |          207 |     24 |           24 |           183 |             0 |            0 |          1 |                 0 |         274500 |              0 |                   0 |      274500 |
|   22 |         183 |           0 |          183 |     47 |           47 |           136 |             0 |            0 |          1 |                 0 |         204000 |              0 |                   0 |      204000 |
|   23 |         136 |           0 |          136 |     14 |           14 |           122 |             0 |            0 |          2 |                 0 |         183000 |              0 |                   0 |      183000 |
|   24 |         122 |           0 |          122 |     19 |           19 |           103 |             0 |            0 |          1 |                 0 |         154500 |              0 |                   0 |      154500 |
|   25 |         103 |           0 |          103 |     38 |           38 |            65 |             0 |            0 |          1 |                 0 |          97500 |              0 |                   0 |       97500 |
|   26 |          65 |           0 |           65 |      4 |            4 |            61 |             0 |            0 |          1 |                 0 |          91500 |              0 |                   0 |       91500 |
|   27 |          61 |           0 |           61 |      1 |            1 |            60 |             0 |            0 |          2 |                 0 |          90000 |              0 |                   0 |       90000 |
|   28 |          60 |           0 |           60 |     16 |           16 |            44 |             0 |            0 |          2 |                 0 |          66000 |              0 |                   0 |       66000 |
|   29 |          44 |           0 |           44 |     40 |           40 |             4 |             0 |            1 |          2 |                31 |           6000 |         500000 |                   0 |      506000 |
|   30 |           4 |           0 |            4 |      7 |            4 |             0 |             3 |            1 |          2 |                 0 |              0 |              0 |               15000 |       15000 |

    ## Total cost yang dikeluarkan saat EOQ = 200 adalah: Rp6.198 juta
    ## Safety stock hasil perhitungan = 28

Secara mengejutkan *total cost* yang dihasilkan jauh lebih menurun\!
