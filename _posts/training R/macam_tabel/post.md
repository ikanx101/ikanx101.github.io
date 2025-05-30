# Berbagai Format Tabel di R Menggunakan gtExtras


Beberapa waktu yang lalu, saya sempat menuliskan bagaimana [menyajikan
data dalam berbagai bentuk](https://ikanx101.com/blog/3-waysgraph/),
salah satunya adalah dalam format tabel. Di **R** sendiri, ada berbagai
macam format tabel dan cara penyajiannya. Kali ini saya akan coba
*share* salah satu *library* yang biasa digunakan untuk *formatting*
tabel, yakni `gt` dan `gtExtras`.

Data yang hendak saya gunakan adalah data `mtcars` yang saya modifikasi
sebagai berikut:

``` r
df_
```

    # A tibble: 22 × 12
       merek      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
       <chr>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
     1 AMC         15     8   304   150     3     3    17     0     0     3     2
     2 Cadillac    10     8   472   205     2     5    17     0     0     3     4
     3 Camaro      13     8   350   245     3     3    15     0     0     3     4
     4 Chrysler    14     8   440   230     3     5    17     0     0     3     4
     5 Datsun      22     4   108    93     3     2    18     1     1     4     1
     6 Dodge       15     8   318   150     2     3    16     0     0     3     2
     7 Duster      14     8   360   245     3     3    15     0     0     3     4
     8 Ferrari     19     6   145   175     3     2    15     0     1     5     6
     9 Fiat        29     4    78    66     4     2    19     1     1     4     1
    10 Ford        15     8   351   264     4     3    14     0     1     5     4
    # ℹ 12 more rows
