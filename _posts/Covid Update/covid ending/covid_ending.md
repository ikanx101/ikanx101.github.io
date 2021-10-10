Hasil Akhir Pandemi Covid 19 per Negara di Dunia
================

Tidak terasa sudah lebih dari satu setengah tahun kita melalui pandemi
Covid 19. Sejak tulisan pertama saya terkait [model matematika
penyebaran covid](https://ikanx101.com/blog/covid/), kini angka
pertambahan kasus positif relatif sudah mulai terkendali. Sampai bisa
seperti sekarang ini, Indonesia harus melalui jalan terjal dan berliku.
Mulai dari hantaman gelombang pertama dan gelombang kedua (varian delta)
pada kuartal I dan II tahun ini. Namun menurut saya, Indonesia belum
bisa dikatakan menang melawan Covid 19. Masih ada PR yang harus kita
selesaikan bersama sebagai negara. Selain itu korban yang berjatuhan
sampai saat ini **tidak menjadikan kita pantas** untuk berbangga hati.

Jika kita pantau dari berbagai sumber berita yang ada, sebenarnya ada
beberapa negara yang sudah jauh lebih dulu “terbebas” dari Covid 19.
Sementara sebagian lainnya masih berusaha keluar.

Sekarang mari kita lihat **hantaman** Covid 19 per negara seperti yang
saya himpun dari situs <https://www.worldometers.info/coronavirus/> per
2021-10-10 10:15:44. Berikut adalah data yang saya akan gunakan:

    ## Contoh 10 Data Teratas

    ## # A tibble: 10 x 22
    ##    number country_other   total_cases new_cases total_deaths new_deaths
    ##     <int> <chr>           <chr>       <chr>     <chr>        <chr>     
    ##  1     NA "North America" 54,319,935  "+6,247"  1,104,288    "+353"    
    ##  2     NA "Asia"          77,035,959  "+24,564" 1,137,766    "+278"    
    ##  3     NA "South America" 38,016,658  "+303"    1,160,705    "+6"      
    ##  4     NA "Europe"        60,327,326  "+50,396" 1,244,009    "+1,180"  
    ##  5     NA "Africa"        8,458,661   "+4"      214,229      ""        
    ##  6     NA "Oceania"       255,819     "+2,517"  3,192        "+15"     
    ##  7     NA ""              721         ""        15           ""        
    ##  8     NA "World"         238,415,079 "+84,031" 4,864,204    "+1,832"  
    ##  9      1 "USA"           45,179,209  ""        733,058      ""        
    ## 10      2 "India"         33,953,475  "+1,200"  450,621      ""        
    ## # ... with 16 more variables: total_recovered <chr>, new_recovered <chr>,
    ## #   active_cases <chr>, serious_critical <chr>, tot_cases_1m_pop <chr>,
    ## #   deaths_1m_pop <chr>, total_tests <chr>, tests_1m_pop <chr>,
    ## #   population <chr>, continent <chr>, x1_caseevery_x_ppl <chr>,
    ## #   x1_deathevery_x_ppl <chr>, x1_testevery_x_ppl <int>,
    ## #   new_cases_1m_pop <dbl>, new_deaths_1m_pop <dbl>, active_cases_1m_pop <chr>

    ## Contoh 10 Data Terbawah

    ## # A tibble: 10 x 22
    ##    number country_other total_cases new_cases total_deaths new_deaths
    ##     <int> <chr>         <chr>       <chr>     <chr>        <chr>     
    ##  1    222 Micronesia    1           ""        ""           ""        
    ##  2    223 China         96,398      "+24"     "4,636"      ""        
    ##  3     NA Total:        54,319,935  "+6,247"  "1,104,288"  "+353"    
    ##  4     NA Total:        77,035,959  "+24,564" "1,137,766"  "+278"    
    ##  5     NA Total:        38,016,658  "+303"    "1,160,705"  "+6"      
    ##  6     NA Total:        60,327,326  "+50,396" "1,244,009"  "+1,180"  
    ##  7     NA Total:        8,458,661   "+4"      "214,229"    ""        
    ##  8     NA Total:        255,819     "+2,517"  "3,192"      "+15"     
    ##  9     NA Total:        721         ""        "15"         ""        
    ## 10     NA Total:        238,415,079 "+84,031" "4,864,204"  "+1,832"  
    ## # ... with 16 more variables: total_recovered <chr>, new_recovered <chr>,
    ## #   active_cases <chr>, serious_critical <chr>, tot_cases_1m_pop <chr>,
    ## #   deaths_1m_pop <chr>, total_tests <chr>, tests_1m_pop <chr>,
    ## #   population <chr>, continent <chr>, x1_caseevery_x_ppl <chr>,
    ## #   x1_deathevery_x_ppl <chr>, x1_testevery_x_ppl <int>,
    ## #   new_cases_1m_pop <dbl>, new_deaths_1m_pop <dbl>, active_cases_1m_pop <chr>

-----
