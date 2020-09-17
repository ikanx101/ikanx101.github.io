---
date: 2020-3-12T5:30:00-04:00
title: "Tutorial Data Carpentry: Filling in NA’s data"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Web Scrap
  - R
  - Data Bolong
  - Data Carpentry
  - Tutorial
---

Salah satu kegunaan **R** yang paling saya rasakan adalah kita bisa
membuat algoritma otomasi dalam melakukan *data cleaning*.

Pada [tulisan yang
lalu](https://ikanx101.github.io/blog/data-carpentry-carmudi/), saya
sudah mencontohkan bagaimana membuat algoritma yang bisa melakukan *web
scraping* sekaligus membersihkannya agar siap dianalisa.

Sekarang saya ingin mencontohkan proses *data cleaning* yang terlihat
sepele tapi bisa jadi *painful* saat dilakukan secara manual dan
berulang-ulang.

## Apa itu?

Mengisi data bolong\!

-----

# Contoh Kasus I

Suatu waktu saya berhadapan dengan data **Excel** seperti berikut ini:

    ##      id nama_karyawan urutan_ceklis
    ## 1     1         Ikang             1
    ## 2     2          <NA>             1
    ## 3     3          <NA>             1
    ## 4     4        Gagnon             2
    ## 5     5          <NA>             2
    ## 6     6          <NA>             2
    ## 7     7         Rader             3
    ## 8     8          <NA>             3
    ## 9     9          <NA>             3
    ## 10   10          <NA>             3
    ## 11   11          <NA>             3
    ## 12   12          <NA>             3
    ## 13   13          <NA>             3
    ## 14   14          <NA>             3
    ## 15   15          <NA>             3
    ## 16   16          <NA>             3
    ## 17   17          <NA>             3
    ## 18   18          <NA>             3
    ## 19   19          <NA>             3
    ## 20   20          <NA>             3
    ## 21   21          <NA>             3
    ## 22   22          <NA>             3
    ## 23   23          <NA>             3
    ## 24   24        Ortega             4
    ## 25   25          <NA>             4
    ## 26   26          <NA>             4
    ## 27   27          <NA>             4
    ## 28   28          <NA>             4
    ## 29   29          <NA>             4
    ## 30   30          <NA>             4
    ## 31   31          <NA>             4
    ## 32   32          <NA>             4
    ## 33   33          <NA>             4
    ## 34   34          <NA>             4
    ## 35   35        Griego             5
    ## 36   36          <NA>             5
    ## 37   37           Kim             6
    ## 38   38          Knox             7
    ## 39   39          <NA>             7
    ## 40   40          <NA>             7
    ## 41   41          <NA>             7
    ## 42   42          <NA>             7
    ## 43   43          <NA>             7
    ## 44   44          <NA>             7
    ## 45   45          <NA>             7
    ## 46   46          <NA>             7
    ## 47   47          <NA>             7
    ## 48   48          <NA>             7
    ## 49   49          <NA>             7
    ## 50   50          <NA>             7
    ## 51   51          <NA>             7
    ## 52   52          <NA>             7
    ## 53   53          <NA>             7
    ## 54   54          <NA>             7
    ## 55   55          <NA>             7
    ## 56   56          <NA>             7
    ## 57   57          <NA>             7
    ## 58   58          <NA>             7
    ## 59   59          <NA>             7
    ## 60   60          <NA>             7
    ## 61   61          <NA>             7
    ## 62   62          <NA>             7
    ## 63   63          <NA>             7
    ## 64   64          <NA>             7
    ## 65   65         Cloud             8
    ## 66   66          <NA>             8
    ## 67   67          <NA>             8
    ## 68   68          <NA>             8
    ## 69   69          <NA>             8
    ## 70   70          <NA>             8
    ## 71   71          <NA>             8
    ## 72   72          <NA>             8
    ## 73   73          <NA>             8
    ## 74   74          <NA>             8
    ## 75   75          <NA>             8
    ## 76   76          <NA>             8
    ## 77   77          <NA>             8
    ## 78   78          <NA>             8
    ## 79   79         Cantu             9
    ## 80   80          <NA>             9
    ## 81   81          <NA>             9
    ## 82   82          <NA>             9
    ## 83   83          <NA>             9
    ## 84   84          <NA>             9
    ## 85   85          <NA>             9
    ## 86   86          <NA>             9
    ## 87   87          <NA>             9
    ## 88   88      Sandoval            10
    ## 89   89          <NA>            10
    ## 90   90          <NA>            10
    ## 91   91          <NA>            10
    ## 92   92          <NA>            10
    ## 93   93          Holm            11
    ## 94   94          <NA>            11
    ## 95   95          <NA>            11
    ## 96   96          <NA>            11
    ## 97   97          <NA>            11
    ## 98   98          <NA>            11
    ## 99   99          <NA>            11
    ## 100 100          <NA>            11

Saya harus mengisi data pada variabel `nama_karyawan` yang kosong dengan
isi atasnya. Hal ini sepertinya sepele, tapi jika variabel yang harus
diisi ada banyak dan baris datanya juga banyak, saya jamin akan lumayan
mengerjakannya.

Oleh karena itu, saya akan contohkan algoritma pengerjaannya di **R**.

Cara pengerjaannya sebenarnya simpel, yakni dengan menggunakan
*conditional* sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Materi%20Training/Kamis%20Data%20Nutrifood/Data%20Bolong/algoritma.png" width="80%" />

Kemudian akan dilakukan *looping* hingga baris data terakhir.

``` r
for(i in 2:100){
  data$nama_karyawan[i] = ifelse(is.na(data$nama_karyawan[i]),
                                 data$nama_karyawan[i-1],
                                 data$nama_karyawan[i])
}
```

    ##      id nama_karyawan urutan_ceklis
    ## 1     1         Ikang             1
    ## 2     2         Ikang             1
    ## 3     3         Ikang             1
    ## 4     4        Gagnon             2
    ## 5     5        Gagnon             2
    ## 6     6        Gagnon             2
    ## 7     7         Rader             3
    ## 8     8         Rader             3
    ## 9     9         Rader             3
    ## 10   10         Rader             3
    ## 11   11         Rader             3
    ## 12   12         Rader             3
    ## 13   13         Rader             3
    ## 14   14         Rader             3
    ## 15   15         Rader             3
    ## 16   16         Rader             3
    ## 17   17         Rader             3
    ## 18   18         Rader             3
    ## 19   19         Rader             3
    ## 20   20         Rader             3
    ## 21   21         Rader             3
    ## 22   22         Rader             3
    ## 23   23         Rader             3
    ## 24   24        Ortega             4
    ## 25   25        Ortega             4
    ## 26   26        Ortega             4
    ## 27   27        Ortega             4
    ## 28   28        Ortega             4
    ## 29   29        Ortega             4
    ## 30   30        Ortega             4
    ## 31   31        Ortega             4
    ## 32   32        Ortega             4
    ## 33   33        Ortega             4
    ## 34   34        Ortega             4
    ## 35   35        Griego             5
    ## 36   36        Griego             5
    ## 37   37           Kim             6
    ## 38   38          Knox             7
    ## 39   39          Knox             7
    ## 40   40          Knox             7
    ## 41   41          Knox             7
    ## 42   42          Knox             7
    ## 43   43          Knox             7
    ## 44   44          Knox             7
    ## 45   45          Knox             7
    ## 46   46          Knox             7
    ## 47   47          Knox             7
    ## 48   48          Knox             7
    ## 49   49          Knox             7
    ## 50   50          Knox             7
    ## 51   51          Knox             7
    ## 52   52          Knox             7
    ## 53   53          Knox             7
    ## 54   54          Knox             7
    ## 55   55          Knox             7
    ## 56   56          Knox             7
    ## 57   57          Knox             7
    ## 58   58          Knox             7
    ## 59   59          Knox             7
    ## 60   60          Knox             7
    ## 61   61          Knox             7
    ## 62   62          Knox             7
    ## 63   63          Knox             7
    ## 64   64          Knox             7
    ## 65   65         Cloud             8
    ## 66   66         Cloud             8
    ## 67   67         Cloud             8
    ## 68   68         Cloud             8
    ## 69   69         Cloud             8
    ## 70   70         Cloud             8
    ## 71   71         Cloud             8
    ## 72   72         Cloud             8
    ## 73   73         Cloud             8
    ## 74   74         Cloud             8
    ## 75   75         Cloud             8
    ## 76   76         Cloud             8
    ## 77   77         Cloud             8
    ## 78   78         Cloud             8
    ## 79   79         Cantu             9
    ## 80   80         Cantu             9
    ## 81   81         Cantu             9
    ## 82   82         Cantu             9
    ## 83   83         Cantu             9
    ## 84   84         Cantu             9
    ## 85   85         Cantu             9
    ## 86   86         Cantu             9
    ## 87   87         Cantu             9
    ## 88   88      Sandoval            10
    ## 89   89      Sandoval            10
    ## 90   90      Sandoval            10
    ## 91   91      Sandoval            10
    ## 92   92      Sandoval            10
    ## 93   93          Holm            11
    ## 94   94          Holm            11
    ## 95   95          Holm            11
    ## 96   96          Holm            11
    ## 97   97          Holm            11
    ## 98   98          Holm            11
    ## 99   99          Holm            11
    ## 100 100          Holm            11

-----

# Contoh Kasus II

Suatu waktu saya berhadapan dengan data **Excel** seperti berikut ini:

    ##      id          nama tinggi_badan
    ## 1     1           Cly          135
    ## 2     2 Kraybill-Voth          165
    ## 3     3        Lovato          160
    ## 4     4       Maurice          134
    ## 5     5          Tang          167
    ## 6     6           Few           NA
    ## 7     7         Allen          138
    ## 8     8        Chaney          142
    ## 9     9        Carter           NA
    ## 10   10       Tekrony          163
    ## 11   11           Cha           NA
    ## 12   12           Uhl          185
    ## 13   13   Hodge-Adams          168
    ## 14   14           Nln          158
    ## 15   15       Whitney           NA
    ## 16   16          Reed          137
    ## 17   17       Aguilar          178
    ## 18   18      Thompson          124
    ## 19   19        Elwood          178
    ## 20   20      Mckenzie          171
    ## 21   21       Kabotie          160
    ## 22   22      Banuelos          151
    ## 23   23    Richardson          175
    ## 24   24      el-Javid          162
    ## 25   25       Melonas          164
    ## 26   26        Taplin          178
    ## 27   27         James           NA
    ## 28   28         Giday           NA
    ## 29   29        Nelson          147
    ## 30   30           Cox          129
    ## 31   31          Doan          169
    ## 32   32        Willis          178
    ## 33   33        Anding          116
    ## 34   34      Robinson          126
    ## 35   35      Morrisey          183
    ## 36   36         Huynh          120
    ## 37   37        Nguyen          177
    ## 38   38          Barr          156
    ## 39   39        Bunyan           NA
    ## 40   40         Allen          137
    ## 41   41        Lavaka          130
    ## 42   42    Berkholder           NA
    ## 43   43 Micha-Deyling           NA
    ## 44   44      Williams          133
    ## 45   45          Tufo          144
    ## 46   46      Buchanan          173
    ## 47   47         Wertz          135
    ## 48   48     el-Madani          152
    ## 49   49        Ardito          160
    ## 50   50      el-Ishak          144
    ## 51   51        Maulin          178
    ## 52   52    el-Khalili          133
    ## 53   53     Steinbach          136
    ## 54   54     al-Hashem           NA
    ## 55   55       Garrett          137
    ## 56   56       Hancock           NA
    ## 57   57          Reid          146
    ## 58   58      Escobedo          122
    ## 59   59         Jones          186
    ## 60   60         Leung           NA
    ## 61   61       Pedraza          167
    ## 62   62         Eltom           NA
    ## 63   63           Kha          104
    ## 64   64          Tran          148
    ## 65   65          Park          194
    ## 66   66      Lasserre           NA
    ## 67   67       Johnsen          121
    ## 68   68       el-Riaz          157
    ## 69   69           Lor          132
    ## 70   70         Brock           NA
    ## 71   71         Cronk           NA
    ## 72   72          Ross          149
    ## 73   73        Landis          120
    ## 74   74       Erekson          130
    ## 75   75        Taylor           NA
    ## 76   76      Thompson          134
    ## 77   77       Britton          155
    ## 78   78      Figueroa          172
    ## 79   79    al-Mahmood          147
    ## 80   80          Reed          161
    ## 81   81         Busby          155
    ## 82   82        Sparks          146
    ## 83   83  Cartahena Jr          152
    ## 84   84       Brillar           NA
    ## 85   85     Cervantes          154
    ## 86   86       Francis          145
    ## 87   87        Leming          157
    ## 88   88     el-Yassin           NA
    ## 89   89         Walsh          152
    ## 90   90     al-Sharif          111
    ## 91   91         Duran          150
    ## 92   92        Dilley          136
    ## 93   93          Love          147
    ## 94   94        Warren          169
    ## 95   95       Johnson           NA
    ## 96   96     el-Khalil          144
    ## 97   97      el-Sylla          148
    ## 98   98        el-Dia          135
    ## 99   99       el-Diab          160
    ## 100 100        Yazzie          182

Ada `20` baris data `tinggi_badan` yang kosong tidak ada nilainya. Salah
satu cara untuk menghadapi nilai kosong seperti ini adalah dengan
mengisinya dengan `mean`, `median`, atau `modus` dari data.

Untuk kasus ini, saya akan mencoba mengisi `tinggi_badan` yang kosong
dengan `mean` yah.

``` r
library(dplyr)
mean = data %>% filter(!is.na(tinggi_badan)) %>% mutate(mean = mean(tinggi_badan)) %>% select(mean) %>% distinct()
mean = as.numeric(mean)
```

Saat menghitung `mean` jangan sampai kita mengikutsertakan data yang
bolong *yah*. Pastikan data yang bolong tersebut sudah kita *exclude*.

Kita dapatkan `mean` sebesar **150.925**.

Untuk mengisi data yang bolong dengan `mean`, kita bisa lakukan hal
simpel seperti
ini:

``` r
data$tinggi_badan = ifelse(is.na(data$tinggi_badan),mean,data$tinggi_badan)
data
```

    ##      id          nama tinggi_badan
    ## 1     1           Cly      135.000
    ## 2     2 Kraybill-Voth      165.000
    ## 3     3        Lovato      160.000
    ## 4     4       Maurice      134.000
    ## 5     5          Tang      167.000
    ## 6     6           Few      150.925
    ## 7     7         Allen      138.000
    ## 8     8        Chaney      142.000
    ## 9     9        Carter      150.925
    ## 10   10       Tekrony      163.000
    ## 11   11           Cha      150.925
    ## 12   12           Uhl      185.000
    ## 13   13   Hodge-Adams      168.000
    ## 14   14           Nln      158.000
    ## 15   15       Whitney      150.925
    ## 16   16          Reed      137.000
    ## 17   17       Aguilar      178.000
    ## 18   18      Thompson      124.000
    ## 19   19        Elwood      178.000
    ## 20   20      Mckenzie      171.000
    ## 21   21       Kabotie      160.000
    ## 22   22      Banuelos      151.000
    ## 23   23    Richardson      175.000
    ## 24   24      el-Javid      162.000
    ## 25   25       Melonas      164.000
    ## 26   26        Taplin      178.000
    ## 27   27         James      150.925
    ## 28   28         Giday      150.925
    ## 29   29        Nelson      147.000
    ## 30   30           Cox      129.000
    ## 31   31          Doan      169.000
    ## 32   32        Willis      178.000
    ## 33   33        Anding      116.000
    ## 34   34      Robinson      126.000
    ## 35   35      Morrisey      183.000
    ## 36   36         Huynh      120.000
    ## 37   37        Nguyen      177.000
    ## 38   38          Barr      156.000
    ## 39   39        Bunyan      150.925
    ## 40   40         Allen      137.000
    ## 41   41        Lavaka      130.000
    ## 42   42    Berkholder      150.925
    ## 43   43 Micha-Deyling      150.925
    ## 44   44      Williams      133.000
    ## 45   45          Tufo      144.000
    ## 46   46      Buchanan      173.000
    ## 47   47         Wertz      135.000
    ## 48   48     el-Madani      152.000
    ## 49   49        Ardito      160.000
    ## 50   50      el-Ishak      144.000
    ## 51   51        Maulin      178.000
    ## 52   52    el-Khalili      133.000
    ## 53   53     Steinbach      136.000
    ## 54   54     al-Hashem      150.925
    ## 55   55       Garrett      137.000
    ## 56   56       Hancock      150.925
    ## 57   57          Reid      146.000
    ## 58   58      Escobedo      122.000
    ## 59   59         Jones      186.000
    ## 60   60         Leung      150.925
    ## 61   61       Pedraza      167.000
    ## 62   62         Eltom      150.925
    ## 63   63           Kha      104.000
    ## 64   64          Tran      148.000
    ## 65   65          Park      194.000
    ## 66   66      Lasserre      150.925
    ## 67   67       Johnsen      121.000
    ## 68   68       el-Riaz      157.000
    ## 69   69           Lor      132.000
    ## 70   70         Brock      150.925
    ## 71   71         Cronk      150.925
    ## 72   72          Ross      149.000
    ## 73   73        Landis      120.000
    ## 74   74       Erekson      130.000
    ## 75   75        Taylor      150.925
    ## 76   76      Thompson      134.000
    ## 77   77       Britton      155.000
    ## 78   78      Figueroa      172.000
    ## 79   79    al-Mahmood      147.000
    ## 80   80          Reed      161.000
    ## 81   81         Busby      155.000
    ## 82   82        Sparks      146.000
    ## 83   83  Cartahena Jr      152.000
    ## 84   84       Brillar      150.925
    ## 85   85     Cervantes      154.000
    ## 86   86       Francis      145.000
    ## 87   87        Leming      157.000
    ## 88   88     el-Yassin      150.925
    ## 89   89         Walsh      152.000
    ## 90   90     al-Sharif      111.000
    ## 91   91         Duran      150.000
    ## 92   92        Dilley      136.000
    ## 93   93          Love      147.000
    ## 94   94        Warren      169.000
    ## 95   95       Johnson      150.925
    ## 96   96     el-Khalil      144.000
    ## 97   97      el-Sylla      148.000
    ## 98   98        el-Dia      135.000
    ## 99   99       el-Diab      160.000
    ## 100 100        Yazzie      182.000

# *Gimana*? Mudah *kan*?
