---
date: 2019-12-11T09:30:00-04:00
title: "Mencari Promo di Toko dari hemat.id"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - Promo
  - Supermarket
  - Minimarket
---

### WARNING: Tulisan ini berisi CURCOL!

Sebenarnya tulisan ini sudah pernah saya post di [blog saya yang
lama](https://wp.me/p6nlXw-lp). Awalnya saya _super happy_ karena
algoritma yang saya bikin bisa menghemat waktu tim sales di kantor dalam
merekap data promosi yang sedang berlangsung di toko (minimarket,
supermarket, hypermarket, dsb).

> *Dari proses manual yang memakan waktu berjam-jam, diubah menjadi
> proses otomatis yang hanya memakan waktu menit (tergantung koneksi
> internet yah)*. Begitu pikir saya waktu itu.

Materi ini pun saya jelaskan ke rekan-rekan mahasiswa saat saya menjadi
[dosen tamu di Universitas
Telkom](https://ikanx101.github.io/blog/kuliah-umum-tel-u/) beberapa
waktu lalu.

Selang beberapa waktu saat saya *launching* cara penggunaan algoritma
ini di *workplace* kantor. Saya baru menyadari bahwa saya mengubah
alamat pada *link* yang tertera di tulisan blog saya yang lama.
Akibatnya, algoritma tersebut pasti tidak akan bisa dijalankan.

> *TAPI kok email saya adem-adem saja yah?*

Berarti selama ini algoritma saya jangan-jangan gak dipakai? (**mulai
baper**).

Memang sih saya mengerjakannya di waktu iseng, tapi bukan berarti
keisengan itu gak berguna yah. *haha* (ketawa ala Joker)

Yasu deh, daripada makin *baper*, nanti jadi gak *ikhlas*, maka saya
putuskan untuk membuka semua kodingannya di sini. Barangkali ada yang
butuh data promo yang ada di toko yah.

# Kita mulai kodingnya

## Langkah 1

Kita panggil dulu semua `library` yang dibutuhkan yah\!

``` r
library(dplyr)
library(rvest)
library(tidyr)
library(tidytext)
library(openxlsx)
library(reshape2)
```

## Langkah 2

Kita definisikan dulu, alamat *url* dari situs **hemat.id** yang mau
kita ambil datanya.

``` r
url = c('https://www.hemat.id/katalog/makanan-minuman/',
        paste('https://www.hemat.id/katalog/makanan-minuman/?page=',
              c(2:3),sep=''))
head(url)
```

    ## [1] "https://www.hemat.id/katalog/makanan-minuman/"       
    ## [2] "https://www.hemat.id/katalog/makanan-minuman/?page=2"
    ## [3] "https://www.hemat.id/katalog/makanan-minuman/?page=3"

## Langkah 3

Kita buat fungsi untuk *scrap* *urls* dari masing-masing produk yang
tertera di 3 `url` yang ada di atas.

> *Kenapa cuma 3 saja?*

Sebenarnya ada 30 *url* pada kategori makanan / minuman di **hemat.id**.
Di algoritma asli yang saya buat juga 30, tapi karena untuk kebutuhan
demo di blog ini, saya buat 3 agar proses **knit** di **R**-nya lebih
cepat.

> *Maklum lagi agak emosi dan buru-buru. hehe*

``` r
scrap_links = function(url){
  link = read_html(url) %>% html_nodes('a') %>% html_attr('href')
  data = tibble(
    id = c(1:length(link)),
    url_produk = link
  ) %>% filter(grepl('harga',link,ignore.case = T))
  return(data)
}
```

## Langkah 4

Kita mulai *scrap* *urls* dari masing-masing produk yang ada di sana
yah. Saya tetap konsisten menggunakan *looping* di **R**. *hehe*

``` r
#mulai iterasi
i=1
data = scrap_links(url[i])
for(i in 2:3){
  temp = scrap_links(url[i])
  data = rbind(data,temp)
}

#ditambahkan alamat site awal
data = data %>% 
  mutate(url_produk = paste('https://www.hemat.id',
                            url_produk,
                            sep=''))
head(data,10)
```

    ## # A tibble: 10 x 2
    ##       id url_produk                                                        
    ##    <int> <chr>                                                             
    ##  1    63 https://www.hemat.id/harga-coca-cola-fanta-sprite-giant-369884/   
    ##  2    65 https://www.hemat.id/harga-hydro-coco-minuman-kelapa-original-lot…
    ##  3    67 https://www.hemat.id/harga-rose-brand-minyak-goreng-hypermart-369…
    ##  4    69 https://www.hemat.id/harga-nissin-mikuya-ramen-instan-noodles-all…
    ##  5    71 https://www.hemat.id/harga-sedaap-mie-goreng-ayam-krispi-alfamart…
    ##  6    73 https://www.hemat.id/harga-sasa-tepung-bumbu-bakwan-special-alfam…
    ##  7    90 https://www.hemat.id/harga-sus-gula-pasir-lottemart-368512/       
    ##  8    92 https://www.hemat.id/harga-bango-kecap-manis-alfamidi-364316/     
    ##  9    94 https://www.hemat.id/harga-sedaap-mie-soto-hypermart-369940/      
    ## 10    96 https://www.hemat.id/harga-filma-minyak-goreng-lottemart-368520/

## Langkah 5

Sekarang kita telah memiliki informasi *url* detail per produk pada
variabel `url_produk`.

Gilirannya untuk membuat fungsi untuk *scrap* semua informasi yang ada
di `url_produk` tersebut.

``` r
scrap_info_produk = function(url_dummy){
  new.data = read_html(url_dummy) %>% {
    tibble(
      toko = html_nodes(.,'em') %>% html_text(),
      produk = html_nodes(.,'.req .title') %>% html_text(),
      start.date = html_nodes(.,'.start .date') %>% html_text(),
      end.date = html_nodes(.,'.end .date') %>% html_text(),
      label = html_nodes(.,'.label:nth-child(1)') %>% html_text(),
      isi = html_nodes(.,'.req .desc') %>% html_text()
    )
  }
  return(new.data)
}
```

## Langkah 6

Kita sudah punya banyak `url_produk` dan fungsi `scrap_info_produk`. Yuk
kita mulai prosesnya\!

``` r
#mulai iterasi untuk url produk
i = 1
data_produk = scrap_info_produk(data$url_produk[i])
data_produk$id = i

for(i in 2:length(data$url_produk)){
  temp_produk = scrap_info_produk(data$url_produk[i])
  temp_produk$id = i
  data_produk = rbind(data_produk,temp_produk)
}
head(data_produk,10)
```

    ## # A tibble: 10 x 7
    ##    toko    produk        start.date end.date label  isi                  id
    ##    <chr>   <chr>         <chr>      <chr>    <chr>  <chr>             <dbl>
    ##  1 di Gia… Coca Cola/Fa… 10 Des 20… 15 Des … Berla… "\n             …     1
    ##  2 di Gia… Coca Cola/Fa… 10 Des 20… 15 Des … Promo… Kalimantan & Sul…     1
    ##  3 di Gia… Coca Cola/Fa… 10 Des 20… 15 Des … Berla… Giant Ekstra,Gia…     1
    ##  4 di Gia… Coca Cola/Fa… 10 Des 20… 15 Des … Harga… Rp 16.300             1
    ##  5 di Gia… Coca Cola/Fa… 10 Des 20… 15 Des … Harga… "\n             …     1
    ##  6 di Gia… Coca Cola/Fa… 10 Des 20… 15 Des … Diskon 23%                   1
    ##  7 di Lot… HYDRO COCO M… " 3 Des 2… 16 Des … Berla… "\n             …     2
    ##  8 di Lot… HYDRO COCO M… " 3 Des 2… 16 Des … Berla… Wholesale             2
    ##  9 di Lot… HYDRO COCO M… " 3 Des 2… 16 Des … Harga… Rp 28.800             2
    ## 10 di Lot… HYDRO COCO M… " 3 Des 2… 16 Des … Harga… "\n             …     2

## Langkah 7

Gimana? Sudah mulai terlihat datanya kayak gimana? Sekarang kita akan
beberes strukturnya yah. Agar bisa diproses\!

``` r
dummy = unique(data_produk$label)

rapihin = function(dummy){
  tes.fungsi = data_produk %>% filter(label %in% dummy) %>% mutate(label=NULL)
  colnames(tes.fungsi)[length(tes.fungsi)-1] = dummy
  return(tes.fungsi)
}

i=1
final_data = rapihin(dummy[i])

for(i in 2:length(dummy)){
  final_temp = rapihin(dummy[i])
  final_data = merge(final_data,final_temp,all=T)
}

final_data = final_data %>% distinct() %>% mutate(id=NULL)

#sekarang bebersih format
final_data = final_data %>% mutate(
  toko = gsub('di ','',toko,fixed = T),
  `Berlaku di` = gsub('\n','',`Berlaku di`,fixed = T),
  `Berlaku di` = gsub('  ','',`Berlaku di`,fixed = T),
  `Harga Promo` = gsub('\n','',`Harga Promo`,fixed = T),
  `Harga Promo` = gsub('  ','',`Harga Promo`,fixed = T)
)
head(final_data,10)
```

    ##        toko                                               produk
    ## 1  Alfamart                             BANGO Kecap Manis 220 ml
    ## 2  Alfamart                 CHIZMILL Wafer Cheddar Cheese 130 gr
    ## 3  Alfamart POCARI SWEAT Pocari Sweat & Soyjoy Almond Chocolate 
    ## 4  Alfamart              SASA Tepung Bumbu Bakwan Special 250 gr
    ## 5  Alfamart                  SEDAAP Mie Goreng Ayam Krispi 88 gr
    ## 6  Alfamidi    ARNOTT'S TIM TAM Biskuit Chocolate, Vanilla 81 gr
    ## 7  Alfamidi                             BANGO Kecap Manis 550 ml
    ## 8  Alfamidi                             BANGO Kecap Manis 550 ml
    ## 9  Alfamidi              BINTANG Radler Zero per 2 kaleng 330 ml
    ## 10 Alfamidi              CAP POCI Teh Celup Asli, Vanilla 25 pcs
    ##     start.date    end.date       Berlaku di
    ## 1   1 Des 2019 15 Des 2019    Area Nasional
    ## 2   1 Des 2019 15 Des 2019   Area Jabotabek
    ## 3   1 Des 2019 15 Des 2019   Area Jabotabek
    ## 4   1 Des 2019 15 Des 2019    Area Nasional
    ## 5   1 Des 2019 15 Des 2019    Area Nasional
    ## 6   1 Des 2019 15 Des 2019 Area Jabodetabek
    ## 7   9 Des 2019 15 Des 2019        Area Jawa
    ## 8  25 Nov 2019 28 Des 2019        Area Jawa
    ## 9   1 Des 2019 15 Des 2019    Area Nasional
    ## 10  1 Des 2019 15 Des 2019 Area Jabodetabek
    ##                                                                                                                  Promo Paket
    ## 1  Min transaksi Rp 10.000. Harga spesial max 1 pcs/transaksi. Harga berbeda di Pulau Jawa dan luar Pulau Jawa. S&K berlaku.
    ## 2                                                                                                            Beli 1 gratis 1
    ## 3                                                                                                                       <NA>
    ## 4  Tanpa minimal transaksi. Harga spesial max 1 pcs/transaksi. Harga berbeda di Pulau Jawa dan luar Pulau Jawa. S&K berlaku.
    ## 5  Min transaksi Rp 10.000. Harga spesial max 1 pcs/transaksi. Harga berbeda di Pulau Jawa dan luar Pulau Jawa. S&K berlaku.
    ## 6                                                                   Disertai Belanja Rp 50.000\n(Kecuali Pembelian Susu Bayi
    ## 7                                                                                                                       <NA>
    ## 8                                                                Ketik HAPLINE di Line Chat Alfamidi & dapatkan Kode Voucher
    ## 9  Min transaksi Rp 10.000. Harga spesial max 1 pcs/transaksi. Harga berbeda di Pulau Jawa dan luar Pulau Jawa. S&K berlaku.
    ## 10                                                                                                           Beli 2 Gratis 1
    ##    Berlaku untuk Harga Normal                     Harga Promo Diskon
    ## 1   Khusus GOPAY    Rp 12.200               Rp 9.900 (220 ml)    19%
    ## 2           <NA>         <NA>                            <NA>   <NA>
    ## 3           <NA>         <NA>                       Rp 11.700   <NA>
    ## 4   Khusus GOPAY     Rp 6.500               Rp 3.000 (250 gr)    54%
    ## 5   Khusus GOPAY     Rp 2.500                Rp 1.000 (88 gr)    60%
    ## 6           <NA>     Rp 8.500                Rp 5.000 (81 gr)    41%
    ## 7           <NA>    Rp 23.900              Rp 20.500 (550 ml)    14%
    ## 8           <NA>    Rp 23.900              Rp 20.900 (550 ml)    13%
    ## 9  Khusus GO-PAY    Rp 28.600 Rp 14.300 (per 2 kaleng 330 ml)    50%
    ## 10          <NA>         <NA>                            <NA>   <NA>

# DONE\!\!\!

Alhamdulillah, sudah selesai proses *scrap*-nya\!

Dari data yang ada tinggal di- *export* saja ke format yang diinginkan
atau mau langsung diproses lebih lanjut untuk analisa.

Datanya kalau dilihat masih *semi-unstructured*, tapi **receh** lah
*pre-processing* utk *next steps*-nya\!

-----

### Conclusion

Sebenarnya algoritma ini bisa menghemat waktu hingga 95% dibandingkan
mengerjakan rekap manual.

Tinggal masalah mau atau tidak mau memakainya saja. *Free* kok ini…
