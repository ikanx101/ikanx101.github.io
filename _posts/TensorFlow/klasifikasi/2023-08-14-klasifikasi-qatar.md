---
date: 2023-08-14T10:08:00-04:00
title: "Belajar Klasifikasi dengan Deep Learning menggunakan TensorFlow di Google Colab"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - TensorFlow
  - KERAS
  - Neural Network
  - Deep Learning
  - Klasifikasi
  - FIFA
  - World Cup
---


Saat piala dunia tahun lalu, saya sempat menuliskan bagaimana [saya
mengambil data dan melakukan prediksi pemenang piala dunia di
Qatar](https://ikanx101.com/blog/pil-dun/). Saat itu, saya membuat model
prediksi berbasis *machine learning* “biasa”.

Nah, kali ini saya ingin membuat model prediksi berbasis *deep learning*
menggunakan TensorFlow di Google Colab. Model ini akan memprediksi `win`
vs `not win` dari data statistik pertandingan piala dunia Qatar 2022.

Bagaimana caranya? *Cekidot!*

------------------------------------------------------------------------

## Tahap I

Sama dengan membuat model regresi dengan *deep learning* pada [tulisan
saya sebelumnya](https://ikanx101.com/blog/coba-regresi/). Tahapan yang
dilakukan adalah sama, yakni mengubah data *train* dan target menjadi
matriks. Harap diperhatikan bahwa semua variabel dalam data *train*
harusnya bertipe numerik.

Syukurnya, data statistik di piala dunia yang lalu adalah numerik.

Berikut adalah tahapan pengambilan datanya:

``` r
# dimulai dari hati yang bersih
rm(list=ls())

# memanggil semua libraries yang diperlukan
library(dplyr)
library(tidyr)
library(caret)
library(keras)
library(tensorflow)

# kita akan ambil datanya
urls = "https://raw.githubusercontent.com/ikanx101/Live-Session-Nutrifood-R/master/Kaggle%20Data/WC%20Qatar%202022/rekapan%20all/data%20WC.csv"

# mengambil data dan menghilangkan id dan negara
df   = read.csv(urls) |> select(-X,-negara) |>
                         # mengubah win vs not win
                         mutate(status = ifelse(status == "win",1,0))

# kita intip datanya kembali
head(df,5)
```

    ##   distance_high_speed_running total_distance distance_walking distance_jogging
    ## 1                    13492.72       111602.3         42308.43         47509.09
    ## 2                    16370.20       120991.9         39044.08         56660.50
    ## 3                    12636.21       105126.5         40547.31         44436.99
    ## 4                    11487.60       104909.6         42593.30         42939.50
    ## 5                    13813.16       112210.9         44267.18         44300.85
    ##   distance_high_speed_sprinting distance_low_speed_sprinting
    ## 1                      2008.841                     6283.209
    ## 2                      1947.969                     6981.232
    ## 3                      1839.714                     5655.808
    ## 4                      2517.831                     5371.372
    ## 5                      2951.146                     6867.305
    ##   linebreaks_attempted_attacking_line_completed linebreaks_attempted_completed
    ## 1                                            63                            135
    ## 2                                            48                             92
    ## 3                                            30                             66
    ## 4                                            48                            100
    ## 5                                            29                             68
    ##   linebreaks_attempted_defensive_line
    ## 1                                  16
    ## 2                                  12
    ## 3                                  13
    ## 4                                  10
    ## 5                                  15
    ##   final_third_entries_reception_central_channel possession
    ## 1                                            11  0.5319009
    ## 2                                             2  0.3584827
    ## 3                                             1  0.3692534
    ## 4                                             2  0.5098438
    ## 5                                             3  0.2473850
    ##   linebreaks_completed_attacking_and_midfield_line
    ## 1                                               23
    ## 2                                               28
    ## 3                                               17
    ## 4                                               21
    ## 5                                               32
    ##   linebreaks_attempted_all_lines phase_aggregate_low_press
    ## 1                              6                 0.2473010
    ## 2                              9                 1.1452711
    ## 3                              6                 2.3330911
    ## 4                              4                 1.0353753
    ## 5                              3                 0.5930452
    ##   completed_ball_progressions linebreaks_attempted_midfield_line
    ## 1                          19                                 85
    ## 2                          11                                 62
    ## 3                           5                                 63
    ## 4                          23                                 74
    ## 5                          19                                 68
    ##   receptions_in_behind attempted_ball_progressions offers_to_receive_in_behind
    ## 1                    8                          22                         131
    ## 2                    8                          15                         105
    ## 3                    5                          10                          78
    ## 4                    2                          26                         103
    ## 5                    9                          26                          69
    ##   take_ons_completed final_third_entries_reception_inside_left_channel
    ## 1                  7                                                 6
    ## 2                  3                                                 1
    ## 3                  0                                                 1
    ## 4                  4                                                 6
    ## 5                  5                                                 2
    ##   receptions_between_midfield_and_defensive_line distributions_under_pressure
    ## 1                                            127                          412
    ## 2                                             60                          239
    ## 3                                             52                          181
    ## 4                                             89                          324
    ## 5                                             78                          165
    ##   linebreaks_completed_under_pressure offers_to_receive_outside
    ## 1                                  79                       472
    ## 2                                  52                       291
    ## 3                                  32                       200
    ## 4                                  60                       297
    ## 5                                  36                       136
    ##   offers_to_receive_inside offers_to_receive_in_front offers_to_receive_total
    ## 1                      397                        401                     869
    ## 2                      247                        249                     538
    ## 3                      173                        144                     373
    ## 4                      272                        222                     569
    ## 5                      132                         68                     268
    ##   final_third_entries_reception_left_channel
    ## 1                                         15
    ## 2                                          8
    ## 3                                          8
    ## 4                                         10
    ## 5                                          3
    ##   linebreaks_attempted_defensive_line_completed phase_aggregate_recovery
    ## 1                                             8                 1.185981
    ## 2                                             7                 2.274480
    ## 3                                             5                 2.660047
    ## 4                                             5                 1.358930
    ## 5                                             7                 4.586216
    ##   phase_aggregate_build_up_opposed phase_aggregate_build_up_unopposed
    ## 1                        22.401054                           34.46897
    ## 2                        14.077541                           42.83758
    ## 3                        14.147048                           35.66498
    ## 4                        19.653669                           35.52212
    ## 5                         8.156798                           23.00989
    ##   linebreaks_completed_midfield_and_defensive_line phase_aggregate_long_ball
    ## 1                                                4                  1.994988
    ## 2                                                5                  5.241185
    ## 3                                                1                  5.836312
    ## 4                                                2                  2.587390
    ## 5                                                2                  7.808894
    ##   linebreaks_attempted_attacking_line linebreaks_attempted
    ## 1                                  80                  181
    ## 2                                  72                  146
    ## 3                                  51                  127
    ## 4                                  66                  150
    ## 5                                  54                  137
    ##   linebreaks_attempted_under_pressure phase_aggregate_mid_block
    ## 1                                 112                  26.92921
    ## 2                                  83                  26.40549
    ## 3                                  64                  23.05441
    ## 4                                  95                  21.65044
    ## 5                                  61                  35.64381
    ##   phase_aggregate_progression phase_aggregate_final_third
    ## 1                          22                    21.67502
    ## 2                          15                    12.76658
    ## 3                          10                    16.56909
    ## 4                          26                    19.59312
    ## 5                          26                    21.23936
    ##   phase_aggregate_set_pieces phase_aggregate_mid_press
    ## 1                   5.389039                  3.845131
    ## 2                   8.329788                  6.959972
    ## 3                   9.689696                  9.733995
    ## 4                   7.765197                  5.491187
    ## 5                   7.934622                  5.741756
    ##   phase_aggregate_high_press phase_aggregate_high_block
    ## 1                  10.296229                   6.775515
    ## 2                   9.825559                   4.759381
    ## 3                   4.970937                   3.713571
    ## 4                   4.178479                   3.281770
    ## 5                   3.844011                   3.482793
    ##   linebreaks_attempted_midfield_and_defensive_line receptions_under_pressure
    ## 1                                               10                       228
    ## 2                                                9                       166
    ## 3                                                8                       124
    ## 4                                                4                       197
    ## 5                                                4                       125
    ##   distributions_completed_under_pressure
    ## 1                                    322
    ## 2                                    166
    ## 3                                    113
    ## 4                                    237
    ## 5                                     91
    ##   final_third_entries_reception_right_channel offers_to_receive_in_between
    ## 1                                          17                          337
    ## 2                                           9                          184
    ## 3                                          11                          151
    ## 4                                          12                          244
    ## 5                                           8                          131
    ##   completed_switches_of_play attempted_switches_of_play
    ## 1                          5                          5
    ## 2                          8                          9
    ## 3                          2                          2
    ## 4                          3                          4
    ## 5                          7                          7
    ##   goalkeeper_defensive_actions_outside_penalty_area
    ## 1                                                 0
    ## 2                                                 0
    ## 3                                                 0
    ## 4                                                 1
    ## 5                                                 0
    ##   phase_aggregate_defensive_transition phase_aggregate_attacking_transition
    ## 1                             11.56996                             11.45030
    ## 2                             11.45030                             11.56996
    ## 3                             11.08016                             15.08844
    ## 4                             15.08844                             11.07613
    ## 5                             10.85273                             27.77031
    ##   phase_aggregate_low_block linebreaks_attempted_attacking_and_midfield_line
    ## 1                  11.55135                                               23
    ## 2                  21.64611                                               28
    ## 3                  26.65496                                               17
    ## 4                  22.24824                                               21
    ## 5                  17.66556                                               32
    ##   phase_aggregate_counterattack phase_aggregate_counter_press
    ## 1                     0.9219995                      8.642238
    ## 2                     0.8349731                      6.998522
    ## 3                     1.3650931                      6.884233
    ## 4                     1.4793735                     11.293603
    ## 5                     1.9358617                      7.750921
    ##   linebreaks_completed_all_lines receptions_under_no_pressure
    ## 1                              4                          488
    ## 2                              5                          288
    ## 3                              1                          240
    ## 4                              2                          337
    ## 5                              1                          150
    ##   goalkeeper_defensive_actions_inside_penalty_area
    ## 1                                               14
    ## 2                                               18
    ## 3                                                7
    ## 4                                               12
    ## 5                                               29
    ##   receptions_under_indirect_pressure goalkeeper_goal_preventions
    ## 1                                210                           5
    ## 2                                145                          14
    ## 3                                112                           5
    ## 4                                185                           4
    ## 5                                112                          14
    ##   received_offers_to_receive receptions_under_direct_pressure forced_turnovers
    ## 1                        347                               18               67
    ## 2                        188                               21               73
    ## 3                        112                               12               79
    ## 4                        213                               12               63
    ## 5                         94                               13               80
    ##   defensive_pressures_applied direct_defensive_pressures_applied
    ## 1                         240                                 34
    ## 2                         453                                 64
    ## 3                         327                                 63
    ## 4                         220                                 43
    ## 5                         361                                 48
    ##   final_third_entries_reception_inside_right_channel
    ## 1                                                  2
    ## 2                                                  6
    ## 3                                                  2
    ## 4                                                  4
    ## 5                                                  3
    ##   linebreaks_attempted_midfield_line_completed attempt_at_goal_off_target
    ## 1                                           64                          7
    ## 2                                           37                          2
    ## 3                                           31                          2
    ## 4                                           47                          3
    ## 5                                           32                          0
    ##   passes attempt_at_goal_blocked attempt_at_goal_on_target attempt_at_goal
    ## 1    711                       2                         5              14
    ## 2    450                       1                         2               5
    ## 3    356                       1                         1               4
    ## 4    533                       0                         2               5
    ## 5    267                       1                         2               3
    ##   assists crosses_completed crosses passes_completed goals_conceded goals
    ## 1       1                 1       6              635              1     2
    ## 2       0                 2      15              381              2     1
    ## 3       0                 4      17              287              2     0
    ## 4       2                 2      14              464              0     2
    ## 5       1                 2       9              190              1     2
    ##   goals_from_direct_free_kicks
    ## 1                            0
    ## 2                            0
    ## 3                            0
    ## 4                            0
    ## 5                            0
    ##   attempt_at_goal_outside_the_penalty_area_on_target
    ## 1                                                  1
    ## 2                                                  1
    ## 3                                                  1
    ## 4                                                  1
    ## 5                                                  0
    ##   goals_outside_the_penalty_area headed_attempt_at_goal fouls_against
    ## 1                              0                      0             8
    ## 2                              0                      1            15
    ## 3                              0                      0            19
    ## 4                              1                      1            15
    ## 5                              0                      0            21
    ##   penalties_scored penalties throw_ins direct_free_kicks indirect_free_kicks
    ## 1                0         0        24                15                   0
    ## 2                0         0        24                 7                   4
    ## 3                0         0        19                15                   2
    ## 4                0         0        21                20                   3
    ## 5                0         0        13                 6                  10
    ##   free_kicks corners goal_kicks attempt_at_goal_outside_the_penalty_area
    ## 1         15       1          4                                        3
    ## 2         11       3         10                                        2
    ## 3         17       2          8                                        3
    ## 4         23       4          6                                        3
    ## 5         16       2          9                                        0
    ##   goals_inside_the_penalty_area
    ## 1                             2
    ## 2                             0
    ## 3                             0
    ## 4                             1
    ## 5                             2
    ##   attempt_at_goal_inside_the_penalty_area_on_target
    ## 1                                                 4
    ## 2                                                 1
    ## 3                                                 0
    ## 4                                                 1
    ## 5                                                 2
    ##   attempt_at_goal_inside_the_penalty_area attempt_at_goal_against
    ## 1                                      11                       5
    ## 2                                       3                      14
    ## 3                                       1                       5
    ## 4                                       2                       4
    ## 5                                       3                      14
    ##   goals_conceded_from_attempt_at_goal_against own_goals time_played
    ## 1                                           0         1          94
    ## 2                                           0         0          94
    ## 3                                           0         0         100
    ## 4                                           0         0         100
    ## 5                                           0         0         100
    ##   substitutions_in substitutions_out red_cards attempt_at_goal_from_free_kicks
    ## 1                5                 5         0                               0
    ## 2                5                 5         0                               0
    ## 3                4                 4         0                               1
    ## 4                5                 5         0                               1
    ## 5                5                 5         0                               0
    ##   fouls_for offsides yellow_cards status
    ## 1        14        4            0      1
    ## 2         7        0            2      0
    ## 3        14        4            4      0
    ## 4        17        2            1      1
    ## 5         6        1            6      1

Mari kita pisahkan target dari data awalnya. Pemisahan ini saya lakukan
karena hendak melakukan *pre-processing* pada data. Jadi jangan sampai
si variabel target malah ikutan ter-*pre-processed* ya.

``` r
# sekarang kita akan buat input utk tensorflow
# jadi sebelum dipisah kita akan pre-process dulu

# kita save dulu variabel targetnya
target = df$status

# lalu kita hilangkan dari data awalnya
df     = df |> select(-status)
```

## Tahap II

Kali ini data yang ada akan saya *pre-process* terlebih dahulu dengan
`library caret`. *Pre-processing* yang dilakukan cukup sederhana, yakni
me-*rescale* data dengan metode *scale*. Di `caret` sendiri ada beberapa
metode *rescaling* yang bisa digunakan, seperti *center*, *range*, dll.

``` r
# tahapan preprocessing
preProcess_range_model = preProcess(df, method='scale')
df                     = predict(preProcess_range_model, newdata = df) # variabel targetnya hilang di sini

# kita kembalikan variabel target ke dalam data
df$status              = target
```

## Tahap III

Pada tahap ini, saya akan pisahkan data *train* dan *test*. Untuk itu,
saya perlu cek terlebih dahulu, apakah ada *imbalance* atau tidak.

``` r
# kita lihat apakah data yang ada imbalance atau tidak
table(df$status)
```

    ## 
    ##  0  1 
    ## 73 45

Ternyata kita dapatkan data yang ada *imbalance*. Oleh sebab itu, saya
akan bangun data *train* dengan komposisi variabel target yang
*balance*. Pada kasus ini, saya akan pilih `28 x 2` baris data sebagai
*train*.

``` r
# pemisahan data berdasarkan targetnya
df_0 = df |> filter(status == 0)
df_1 = df |> filter(status == 1)

# kita akan acak id nya
# jangan lupa set seed dulu
set.seed(123)
id_0 = sample(nrow(df_0),28,replace = F)
id_1 = sample(nrow(df_1),28,replace = F)

# data train
train_0 = df_0[id_0,]
train_1 = df_1[id_1,]
train   = rbind(train_1,train_0)

# kita cek kembali balance dari train
table(train$status)
```

    ## 
    ##  0  1 
    ## 28 28

Setelah *balance*, sisa data yang tidak terpakai akan menjadi data
*test* berikut:

``` r
# sekarang kita akan buat test data
test_0 = df_0[-id_0,]
test_1 = df_1[-id_1,]
test   = rbind(test_0,test_1)

# kita cek kembali balance dari test
table(test$status)
```

    ## 
    ##  0  1 
    ## 45 17

## Tahap IV

Sekarang kita akan ubah data *train*, *test*, serta target menjadi
matriks.

``` r
# kita ubah targetnya ke bentuk matriks
train_label_raw   = train$status
train_label_clean = to_categorical(train_label_raw)
train_matrix      = as.matrix(train[-ncol(train)])

# test
test_label_raw    = test$status
test_label_clean  = to_categorical(test_label_raw)
test_matrix       = as.matrix(test[-ncol(train)])
```

## Tahap V

Sekarang kita akan buat model *deep learning* menggunakan `keras`.
Berikut adalah skripnya:

``` r
# membuat modelnya
model = keras_model_sequential()
# menentukan 
  # berapa banyak layer
  # berapa banyak nodes
  # activation function-nya apa
model %>%
  layer_dense(units       = 100,activation = 'sigmoid',
              input_shape = c(ncol(train_matrix))) %>%
  layer_dense(units       = 86, activation = 'sigmoid') %>%
  layer_dense(units       = 21, activation = 'sigmoid') %>%
  layer_dense(units       = 12, activation = 'softmax') %>%
  layer_dense(units       = 2, activation = 'softmax')

# summary modelnya
summary(model)
```

    ## Model: "sequential"
    ## ________________________________________________________________________________
    ##  Layer (type)                       Output Shape                    Param #     
    ## ================================================================================
    ##  dense_4 (Dense)                    (None, 100)                     11100       
    ##  dense_3 (Dense)                    (None, 86)                      8686        
    ##  dense_2 (Dense)                    (None, 21)                      1827        
    ##  dense_1 (Dense)                    (None, 12)                      264         
    ##  dense (Dense)                      (None, 2)                       26          
    ## ================================================================================
    ## Total params: 21,903
    ## Trainable params: 21,903
    ## Non-trainable params: 0
    ## ________________________________________________________________________________

Kita buat *optimizer*-nya:

``` r
model %>% compile(
  loss='binary_crossentropy',
  optimizer='adam',
  metrics=c('accuracy')
)
```

## Tahap VI

Kita *train* modelnya sebagai berikut:

``` r
fitModel =
  model %>%
  fit(train_matrix,
      train_label_clean,
      epochs           = 90,
      batch_size       = 15,
      validation_split = 0.1)

plot(fitModel)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/TensorFlow/klasifikasi/klasifikasi_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

Di atas, saya buat *epochs*-nya sebanyak 90 kali.

## Tahap VII

Kita lihat evaluasinya, berikut adalah akurasi dengan *train* dan
*test*.

``` r
# evaluasi dengan train
model %>% evaluate(train_matrix, train_label_clean, verbose = 0)
```

    ##      loss  accuracy 
    ## 0.3666315 0.9821429

``` r
# evaluasi dengan test
model %>% evaluate(test_matrix, test_label_clean, verbose = 0)
```

    ##      loss  accuracy 
    ## 0.5015263 0.8548387

## Tahap VIII

Sekarang kita buat *confusion matrix* dari data *train* dan data *test*
sebagai berikut:

``` r
# confusion matrix
# train dataset
pred_train = predict(model, train_matrix) %>% k_argmax() %>% as.vector()
table(pred_train,train_label_raw)
```

    ##           train_label_raw
    ## pred_train  0  1
    ##          0 27  0
    ##          1  1 28

``` r
mean(train_label_raw == pred_train)
```

    ## [1] 0.9821429

``` r
# confusion matrix
# test dataset
pred_test = predict(model, test_matrix) %>% k_argmax() %>% as.vector()
table(pred_test,test_label_raw)
```

    ##          test_label_raw
    ## pred_test  0  1
    ##         0 37  1
    ##         1  8 16

``` r
mean(test_label_raw == pred_test)
```

    ## [1] 0.8548387

Ternyata walau data yang kita gunakan untuk membuat model sedikit,
hasilnya lumayan bagus.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
