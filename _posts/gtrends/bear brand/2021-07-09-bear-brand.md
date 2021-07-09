---
date: 2021-07-09T14:02:00-04:00
title: "Mengintip Fenomena Bear Brand di Twitter dan Google Trends"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Data
  - Google
  - Google Trends
  - Wordcloud
  - Web Scraping
  - Twitter
  - Covid 19
  - Bear Brand
---


Ada hal yang *viral* belakangan ini di masa **PPKM Darurat** di
Jabodetabek, yakni fenomena masyarakat memborong Susu *Bear Brand*.

> Susu Bear Brand diyakini ampuh untuk membantu penyembuhan dan
> pencegahan Covid 19.

Harga susu tersebut di beberapa *marketplaces* juga meningkat tajam.
Sampai-sampai terjadi kelangkaan dan pembatasan pembelian di toko dan
*retailers* di beberapa daerah.

Mitos seputar **susu beruang** ini sudah pernah saya dengar ketika SMP
lalu. Saat itu, beberapa teman saya yang menjadi perokok sengaja meminum
**susu beruang** saat hendak mengikuti seleksi masuk suatu SMA. Gunanya
agar susu tersebut bisa **membersihkan paru-paru** saat pemeriksaan
kesehatan di SMA tersebut.

------------------------------------------------------------------------

## *Google Trends*

*Google Trends* adalah salah satu layanan yang sering saya pakai untuk
melihat seberapa antusiasme warganet Indonesia seputar isu-isu atau
*keywords* tertentu.

Kali ini saya mencoba mengambil data *trend* pencarian warganet terhadap
*keywords*:

1.  **Bear Brand**
2.  **Susu Beruang**

Jika saya buatkan *timeline chart*, hasilnya sebagai berikut:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/gtrends/bear%20brand/bear-brand_files/figure-gfm/unnamed-chunk-1-1.png" alt="fig1. Timeline Chart" width="672" />
<p class="caption">
fig1. Timeline Chart
</p>

</div>

Terlihat bahwa beberapa saat sebelum **PPKM darurat** diberlakukan,
*trend* pencarian terhadap **Bear Brand** dan **susu beruang** sudah
mulai meningkat tajam.

Salah seorang teman saya berujar:

> Coba lihat *suggestion*-nya Google deh saat kamu menuliskan
> `bear brand` di kolom pencarian!

Benar saja. Saat saya mencoba menuliskannya, saya mendapatkan
*suggestion* berikut ini:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/gtrends/bear%20brand/related.png" alt="fig2. Suggestion Google" width="90%" />
<p class="caption">
fig2. Suggestion Google
</p>

</div>

Sekarang saya akan coba cek data *related queries* dari dua *keywords*
tersebut berdasarkan *Google Trend*:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/gtrends/bear%20brand/bear-brand_files/figure-gfm/unnamed-chunk-3-1.png" alt="fig2. Suggestion Google" width="90%" />
<p class="caption">
fig3. Suggestion Google
</p>

</div>

Dari semua *related queries* yang ada, tidak secara eksplisit ada
pencarian yang ke arah **covid** atau **corona**. Setelah saya telaah
kembali datanya, saya temukan bahwa:

| Status | Related Queries              | Keyword    | Geo |
|:-------|:-----------------------------|:-----------|:----|
| rising | bear brand covid             | bear brand | ID  |
| rising | bear brand untuk covid       | bear brand | ID  |
| rising | susu bear brand untuk corona | bear brand | ID  |

Pencarian dengan penambahan *keyword* **covid** dan **corona** baru
berstatus ***rising***. Mungkin baru akan muncul detail datanya dalam
beberapa hari kemudian.

------------------------------------------------------------------------

## Twitter

Selain data dari *Google Trends*, saya juga mengambil data warganet di
Twitter. Siang ini saya mendapatkan 526 buah twit ber-*hashtag*
**\#bearbrand**. Ini adalah twit asli (buka merupakan *retweet* dari
*user* lain).

Saya ingin tahu, siapa *user* yang mendapatkan *favorites* atau *likes*
terbanyak pada *hashtag* ini:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/gtrends/bear%20brand/bear-brand_files/figure-gfm/unnamed-chunk-5-1.png" alt="fig3. User Twitter" width="90%" />
<p class="caption">
fig4. User Twitter
</p>

</div>

Sekarang kita lihat, apa saja isi twit dari `3` *users* dengan
*favourites* terbanyak:

    ## # A tibble: 10 x 3
    ##    screen_name    text                                          favourites_count
    ##    <chr>          <chr>                                                    <int>
    ##  1 herlambang_tan "Ada logikanya doc\n\n#BEARBRAND\n#netizenin…           127674
    ##  2 yangyangbesti… "@ttyyoonnaa Coba lihat di hastag #BEARBRAND…            55390
    ##  3 yangyangbesti… "ohh ternyata sekarang trendnya panic buying…            55390
    ##  4 totoagungcom   "Pengeluaran Togel Sydneyballs, tanggal 03 J…            16197
    ##  5 totoagungcom   "Pengeluaran Togel HAHN, tanggal 04  Juli 20…            16197
    ##  6 totoagungcom   "Pengeluaran Togel MCL, tanggal 04  Juli 202…            16197
    ##  7 totoagungcom   "Pengeluaran Togel Macedonia, tanggal 03 Jul…            16197
    ##  8 totoagungcom   "Pengeluaran Togel Lacoruna, tanggal 04  Jul…            16197
    ##  9 totoagungcom   "Pengeluaran Togel Jamaica, tanggal 03 Juli …            16197
    ## 10 totoagungcom   "Pengeluaran Togel SLOVAKIA, tanggal 04  Jul…            16197

Ternyata *user* **totoagungcom** adalah sebuah *bot* judi yang
menggunakan *hashtag* ini.

Oke, kita lihat ada topik pembicaraan apa saja yang ada di twitter:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/gtrends/bear%20brand/bear-brand_files/figure-gfm/unnamed-chunk-7-1.png" alt="fig4. Twit" width="90%" />
<p class="caption">
fig5. Twit
</p>

</div>

Di luar *bot* yang memberikan informasi pemenang judi, kita bisa
dapatkan beberapa informasi secara kualitatif seperti ***panic
buying***, ***harga susu beruang naik***, dan ***rebutan***.

Di luar benar atau tidaknya manfaat Bear Brand, ada baiknya kita tetap
menjaga kesehatan agar terhindar dari penyakit apapun.

*Stay safe* semuanya.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
