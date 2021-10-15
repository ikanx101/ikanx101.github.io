Membandingkan Tinggi Dua Anak
================

``` r
ceisya = 114
ahnaf = 139

laju_ceisya = 3
laju_ahnaf = 1

i = 0

while(ceisya < ahnaf){
  ceisya = ceisya + laju_ceisya
  ahnaf = ahnaf + laju_ahnaf
  i = i + 1
  print(ceisya)
  print(ahnaf)
}
```

    ## [1] 117
    ## [1] 140
    ## [1] 120
    ## [1] 141
    ## [1] 123
    ## [1] 142
    ## [1] 126
    ## [1] 143
    ## [1] 129
    ## [1] 144
    ## [1] 132
    ## [1] 145
    ## [1] 135
    ## [1] 146
    ## [1] 138
    ## [1] 147
    ## [1] 141
    ## [1] 148
    ## [1] 144
    ## [1] 149
    ## [1] 147
    ## [1] 150
    ## [1] 150
    ## [1] 151
    ## [1] 153
    ## [1] 152

``` r
print(i * 4 / 12)
```

    ## [1] 4.333333
