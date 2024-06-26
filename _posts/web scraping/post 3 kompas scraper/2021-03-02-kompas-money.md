---
date: 2021-03-02T12:09:00-04:00
title: "Media Monitoring Menggunakan R: Berita Pajak Mobil"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - rvest
  - kompas
  - mobil
  - pajak
---

Pada 2010 - 2012 lalu, saya sempat bekerja di salah satu *multinational
market research agency* di kawasan Sudirman. Sepengetahuan saya waktu
itu, salah satu tim riset *business to consumer* (**B2C**) biasa
melakukan studi *media monitoring*.

> Apa yang mereka lakukan?

Mereka memantau berita-berita yang ada di beberapa portal dan
obrolan-obrolan yang ada di forum digital terkait beberapa hal yang
penting untuk diketahui oleh klien. Proses pemantauan sendiri dilakukan
sangat manual saat itu.

## Kompas Money

Beberapa pekan yang lalu, saya mengobrol dengan salah seorang teman saya
yang ternyata sedang berinisiasi untuk melakukan *media monitoring* di
kantornya. Tidak serumit apa yang kami lakukan dulu di *market research
agency*. Teman saya hanya ingin melakukan *media monitoring* secara
spesifik dari situs *kompas.com* bagian finansial ([Kompas
Money](https://money.kompas.com/)).

Salah satu ide yang saya kemukakan adalah penggunaan **R** untuk
melakukan *web scraping* secara berkala terhadap semua berita yang
muncul di **Kompas Money**. Jadi teman saya cukup membuat satu algoritma
sederhana untuk *web scraping* semua berita yang ada di sana.

> Iya! Semua berita di Kompas Money!

Setelah itu, tinggal dilakukan analisa yang dibutuhkan dari hasil
*scrape*-nya.

### Kompas Scraper *Function*

Di saat santai saya coba bantu membuatkan satu *function* di **R** yang
berguna untuk mengambil beberapa informasi berikut di **Kompas Money**:

1.  Siapa jurnalis penulis beritanya.
2.  *Timestamp* berita di-*publish*.
3.  Judul berita.
4.  Isi berita.

Berikut adalah *function*-nya:

``` r
kompasin_donk = function(url){
  scrape = read_html(url) %>% html_nodes("p") %>% html_text()
  penulis = read_html(url) %>% html_nodes("#penulis a") %>% html_text()
  penulis = ifelse(length(penulis) == 0,NA,penulis)
  waktu = read_html(url) %>% html_nodes(".read__time") %>% html_text()
  judul = scrape[1]
  n = length(scrape) - 1
  isi = scrape[2:n]
  isi = paste(isi,collapse = " ")
  data = data.frame(jurnalis = penulis,
                    timestamp = waktu,
                    headline = judul,
                    berita = isi)
  return(data)
}
```

Ingat *yah*, *function* di atas adalah untuk melakukan *web scraping*
dari satu alamat situs dari *Kompas Money*. Jika ingin melakukan *web
scraping* untuk semua berita yang ada, kita cukup *scrape* terlebih
dahulu semua *links* berita yang ada.

> Caranya Bagaimana?

Gunakan saja cara berikut ini:

``` r
#global = c(paste0("https://money.kompas.com/whatsnew/",1:10))
#links = c()
#for(i in 1:10){
#  temp = read_html(global[i]) %>% html_nodes("a") %>% html_attr("href")
#  links = c(links,temp)
#}
#links = links[grepl("money",links)]
#links = links[grepl("read",links)]
#links_1 = unique(links)
#links_2 = paste0(links_1,"?page=2")
#links = c(links_1,links_2)
```

### Data Hasil *Web Scraping*

Per `2 Maret 2021` pukul `8.40 WIB`, tercatat ada `154` berita yang
berhasil saya ambil dari *Kompas Money*. Berikut adalah contoh sampel
data yang saya dapatkan:

| jurnalis            | headline                                                                                          | timestamp                          | berita                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|:--------------------|:--------------------------------------------------------------------------------------------------|:-----------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Ade Miranti Karunia | Indonesia-China “Lengket”, Luhut: Tidak Ada Mereka yang Atur                                      | Kompas.com - 25/02/2021, 17:11 WIB | Tulis komentar dengan menyertakan tagar \#JernihBerkomentar dan \#MelihatHarapan di kolom komentar artikel Kompas.com. Menangkan E-Voucher senilai Jutaan Rupiah dan 1 unit Smartphone. Indonesia-China “Lengket”, Luhut: Tidak Ada Mereka yang Atur JAKARTA, KOMPAS.com - Menteri Koordinator Bidang Kemaritiman dan Investasi (Menko Marves) Luhut Binsar Pandjaitan tak menepis kedekatan Pemerintah Indonesia dengan Pemerintah China. “Kalau kita (pemerintah disebut) dekat dengan China, iya,”  ujarnya dalam CNBC Economic Outlook yang ditayangkan secara virtual, Kamis (25/2/2021). Seperti diketahui, Indonesia menjalin kerja sama dengan China untuk pengadaan jutaan vaksin Covid-19. Bahkan, China juga mengirim bahan baku vaksin ke Indonesia yang kemudian diproduksi oleh Bio Farma. Selain itu, pemerintah juga menggaet China untuk investasi di berbagai sektor. Teranyar, Indonesia dan China menandatangani nota kesepahaman (MoU) kerja sama pengembangan sektor pariwisata, salah satunya di Danau Toba, Sumatera Utara. Baca juga: Muncul Julukan Luhut Lagi, Luhut Lagi, Ini Respons Luhut Meski begitu Luhut menekankan, seperti negara lain, saat China ingin berinvestasi di Indonesia, ada syarat yang harus dipatuhi. “Nah kenapa dengan China? Mungkin China ini ingin cari teman juga. Dia (China) lihat kita (Indonesia) enak, kita lihat (China) enak juga. Tapi, ada tapinya, semua mau dia investasi di sini harus memenuhi kriteria,” ucapnya. “Tidak ada mereka yang atur. Semua teknologi yang masuk ke sini harus first technology, dan harus B to B (business to business), enggak mau G to B (government to business),” sambung Luhut. Namun, Luhut juga mengatakan Pemerintah Indonesia dekat dengan sejumlah negara lain. Misalnya dengan Uni Emirat Arab (UEA) dan Amerika Serikat (AS). Selain dengan China, Luhut juga mengatakan Pemerintah Indonesia dekat dengan Uni Emirat Arab (UEA) dan Amerika Serikat (AS). “Kalau kita (disebut) dekat dengan Abu Dhabi (UEA), super iya juga. Karena hubungan pribadi Pak Jokowi dengan crown prince (Putra Mahkota Raja UEA) itu bagus. Kita juga dekat dengan Amerika, cukup bagus, bagus sekali,” ucap Luhut. Bahkan kata Luhut, kedekatan Presiden Jokowi dengan Putra Mahkota Raja Abu Dhabi menghasilkan suatu komitmen kesepakatan investasi yang nilainya mencapai 19 miliar dollar AS atau setara Rp 266 triliun. Baca juga: Tesla Pilih Bangun Pabrik di India, Luhut: Future-nya Ada di Sini                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Ade Miranti Karunia | Kemenperin: Mobil Gunakan 70 Persen Komponen Dalam Negeri Dapat Pembebasan PPnBM                  | Kompas.com - 01/03/2021, 14:18 WIB | Tulis komentar dengan menyertakan tagar \#JernihBerkomentar dan \#MelihatHarapan di kolom komentar artikel Kompas.com. Menangkan E-Voucher senilai Jutaan Rupiah dan 1 unit Smartphone. Kemenperin: Mobil Gunakan 70 Persen Komponen Dalam Negeri Dapat Pembebasan PPnBM JAKARTA, KOMPAS.com - Menteri Perindustrian (Menperin) Agus Gumiwang Kartasasmita menyebutkan, terdapat 21 tipe mobil yang bisa memanfaatkan diskon tarif Pajak Penjualan atas Barang Mewah ( PPnBM). Varian kendaraan tersebut meliputi dari enam perusahaan, yakni PT Toyota Motor Manufacturing Indonesia, PT Astra Daihatsu Motor, PT Mitsubishi Motors Krama Yudha Indonesia, PT Honda Prospect Motor, PT Suzuki Motor Indonesia, dan PT SGMW Motor Indonesia. Selain itu, kendaraan bermotor yang bisa menikmati insentif PPnBM ini harus memenuhi kandungan komponen buatan lokal. Artinya, pembebasan sementara PPnBM ini diberikan untuk segmen Sedan 4x2 dengan kapasitas mesin di bawah 1500 cc dan diproduksi di dalam negeri. Baca juga: BPS: Inflasi Februari Melambat, Permintaan Domestik Masih Lemah Segmen tersebut dipilih karena produk dalam negeri telah menguasai lebih dari 91 persen pasar Indonesia dan memiliki Tingkat Kandungan Dalam Negeri (TKDN) lebih dari 80 persen. “Harus memenuhi persyaratan pembelian lokal yang meliputi pemenuhan jumlah penggunaan komponen yang berasal dari hasil produksi dalam negeri yang dimanfaatkan dalam kegiatan produksi kendaraan bermotor paling sedikit 70 persen,” ujarnya melalui keterangan tertulis, Senin (1/3/2021). Di dalam Kepmenperin No.169/2021 ini juga menyebutkan, terdapat 115 jenis komponen yang bisa masuk dalam perhitungan kandungan lokal. “Dalam Kepmen, disebutkan bahwa perusahaan industri wajib menyampaikan rencana pembelian lokal (local purchase) dan surat pernyataan pemanfaatan hasil pembelian lokal (local purchase) dalam kegiatan produksi,” lanjutnya. Di samping itu, perusahaan juga wajib menyampaikan faktur pajak sesuai dengan ketentuan peraturan perundang-undangan, laporan realisasi PPnBM DTP, dan kinerja penjualan triwulan. “Pelaksanaan pengawasan dan evaluasi dapat dilakukan dengan bekerja sama dengan instansi pemerintah di bidang perpajakan dan/atau melibatkan lembaga verifikasi independen,” kata dia. Baca juga: Token Listrik Gratis Maret Sudah Bisa Diklaim, Simak Caranya Bagi perusahaan yang tidak melaksanakan pembelian lokal, Kemenperin mengusulkan pengenaan sanksi administratif sesuai dengan ketentuan peraturan perundang-undangan dan penghapusan sebagai kendaraan bermotor penerima fasilitas PPnBM DTP. Dirinya optimistis, stimulus tersebut akan menurunkan harga kendaraan bermotor produksi dalam negeri sehingga lebih terjangkau di masyarakat, meningkatkan daya saing terhadap kendaraan impor, serta dapat meningkatkan kinerja produksi kendaraan bermotor roda empat atau lebih menjadi di atas 1 juta unit pada tahun 2021 atau sama dengan kinerja produksi tahun 2019. Stimulus perpajakan berupa insentif PPnBM DTP ini berlaku selama 9 bulan, terhitung pada Maret 2021 yang dibagi dalam tiga tahap, yaitu pengurangan 100 persen untuk tiga bulan tahap pertama, pengurangan 50 persen untuk tiga bulan tahap kedua, dan pengurangan 25 persen untuk tiga bulan tahap ketiga. “Implementasinya akan dilakukan evaluasi setiap tiga bulan,” pungkas dia. |
| Ade Miranti Karunia | Luhut Sebut 2 Juta Vaksin Covid-19 untuk Mandiri Masuk ke Indonesia pada Maret 2021               | Kompas.com - 25/02/2021, 13:16 WIB | Tulis komentar dengan menyertakan tagar \#JernihBerkomentar dan \#MelihatHarapan di kolom komentar artikel Kompas.com. Menangkan E-Voucher senilai Jutaan Rupiah dan 1 unit Smartphone. Luhut Sebut 2 Juta Vaksin Covid-19 untuk Mandiri Masuk ke Indonesia pada Maret 2021 JAKARTA, KOMPAS.com - Menteri Koordinator Bidang Kemaritiman dan Investasi (Menko Marves) Luhut Binsar Pandjaitan menargetkan 2 juta vaksin Covid-19 jalur mandiri jenis Sinopharm akan masuk ke Indonesia, pada Maret 2021. Vaksin Sinopharm merupakan kerja sama antara China National Biotech Group (CNBG) dan perusahaan teknologi UEA G42 serta dinas kesehatan Abu Dhabi. “Sebanyak 2 juta (vaksin Covid-19), Maret ini masuk. Dan 3 juta harapan kita,” ujar Luhut secara virtual, Kamis (25/2/2021).   Baca juga: Erick Thohir: Vaksinasi Mandiri Butuh 7,5 Juta Dosis Vaksin Covid-19 Kepada UEA, Luhut meminta agar vaksin Sinopharm bisa disediakan sebanyak 30 juta dosis. Sebab, saat ini UEA hanya mampu menyediakan maksimal 15 juta dosis untuk Indonesia. “Kita dijanjikan tahap pertama 100.000, 5 juta, kemudian 15 juta. Terus saya bilang sama dia, bisa enggak jangan dikasih 5 juta, tapi jadi 15 juta sampai 30 juta (dosis)? Dan harus selesai sampai Juli,” kata Luhut. “Mereka bilang, oke brother, nanti saya lihat apa yang saya bisa buat. Tapi angka yang Anda minta mungkin tidak bisa 15 juta jadi 30 juta. Tapi yang pasti angka itu bisa kami dapatkan,” sambung dia. Selain itu, pemerintah optimistis, pelaksanaan pemberian vaksin Covid-19 kepada masyarakat hingga Juli 2021 mencapai 70 juta orang. Baca juga: Tak Hanya Vaksin, Ini Kunci Pemulihan Ekonomi Bisa Lebih Cepat Menurut Kemenkeu “Apa yang kita lihat ini, dari confidence, Juli-Agustus kita sudah dapat 70 juta disuntikkan (vaksin). Karena dari 34 provinsi, hanya 13 provinsi yang berkontribusi 83 persen Covid-19 di Indonesia,” ucap Luhut. Tiap harinya saja, Luhut menyebutkan, pemberian vaksin Covid-19 telah mencapai 500.000 orang.    Ia berharap, jumlah orang yang divaksin per hari bisa mencapai 700.000 orang. “Tapi saya lihat sekarang dengan Pak Budi Gunadi Sadikin, jumlah yang divaksin sudah sampai ratusan ribu per hari. Tapi kita berharap, mungkin akhir Maret ini sudah bisa 500.000 per hari. Kalau angka ini kita pelihara mendekati 700.000 sampai bulan April per hari,” ujar Luhut.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Ade Miranti Karunia | Luhut: Presiden Ingin APBN Itu Buat Urusin Rakyat, Seperti Kemiskinan…                            | Kompas.com - 25/02/2021, 15:38 WIB | Tulis komentar dengan menyertakan tagar \#JernihBerkomentar dan \#MelihatHarapan di kolom komentar artikel Kompas.com. Menangkan E-Voucher senilai Jutaan Rupiah dan 1 unit Smartphone. Luhut: Presiden Ingin APBN Itu Buat Urusin Rakyat, Seperti Kemiskinan… JAKARTA, KOMPAS.com - Menteri Koordinator Bidang Kemaritiman dan Investasi (Menko Marves) Luhut Binsar Pandjaitan mengatakan, Presiden Joko Widodo (Jokowi) menginginkan dana APBN dimanfaatkan untuk penyaluran bantuan sosial untuk atasi kemiskinan. Sementara, untuk pembangunan infrastruktur digunakan dana di Lembaga Pengelola Investasi ( LPI) atau Indonesia Investment Authority (INA). “Presiden ingin APBN itu buat urusin rakyat-rakyat kayak kemiskinan. Infrastruktur apa segala macam lahir dari sini (SWF/LPI),” ujarnya dalam CNBC Economic Outlook, Kamis (25/2/2021). Baca juga: Soal Tesla, Luhut: Saya Tidak Pernah Bicara Pabrik Mobil! Luhut menyebutkan, telah ada kepastian dana yang akan dikelola LPI senilai 9,5 miliar dollar AS. Ditambah juga, alokasi dana dari pemerintah sebesar 5 miliar dollar AS. “Sudah ada komitmen 9,5 miliar dollar AS. Ada dari pemerintah 5 miliar dollar AS. Kita cut untuk tollroad, sea port (pelabuhan), airport, tiga ini dulu. Tapi banyak di BUMN ini aset-aset bagus,” katanya. Menurut Luhut, komitmen dana dari luar negeri untuk LPI antara lain datang dari Uni Emirat Arab (UEA). Terkait hal itu, sebut dia, pekan depan Menteri ESDM UES Suhail Al Mazrroui bakal berkunjung ke Indonesia. “Saya telepon Mister Suhail dari Abu Dhabi, minggu depan dia datang kemari, nanti kita bicara. Terus kemudian, nanti mereka taruh duit di situ,” ujarnya. Sebelumnya, Presiden Joko Widodo (Jokowi) telah melantik Dewan Pengawas untuk mengurus LPI tersebut. Dua diantaranya merupakan unsur dari pemerintah yakni Menteri Keuangan Sri Mulyani Indrawati dan Menteri BUMN Erick Thohir. Sedangkan dari unsur profesional, Dewan Pengawas LPI terdiri dari Haryanto Sahari, Darwin Cyril Noerhadi, dan Yozua Makes. Baca juga: Luhut Sebut 2 Juta Vaksin Covid-19 untuk Mandiri Masuk ke Indonesia pada Maret 2021                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Ade Miranti Karunia | Menperin Sebut Toyota Siapkan Rp 28 Triliun untuk Produksi Mobil Hibrida dan Listrik di Indonesia | Kompas.com - 01/03/2021, 07:39 WIB | Tulis komentar dengan menyertakan tagar \#JernihBerkomentar dan \#MelihatHarapan di kolom komentar artikel Kompas.com. Menangkan E-Voucher senilai Jutaan Rupiah dan 1 unit Smartphone. Menperin Sebut Toyota Siapkan Rp 28 Triliun untuk Produksi Mobil Hibrida dan Listrik di Indonesia JAKARTA, KOMPAS.com - Menteri Perindustrian (Menperin) Agus Gumiwang Kartasasmita mendorong agar pelaku industri di Jepang terus berinvestasi di Indonesia. Hal itu disampaikannya ketika melakukan pertemuan dengan Duta Besar Jepang untuk Indonesia, Kanasugi Kenji. Dalam pertemuan itu, Menperin menyebutkan bahwa salah satu perusahaan ternama asal Negeri Sakura, Toyota Group, berencana akan berinvestasi di Indonesia sebesar 2 miliar dollar AS atau sekitar Rp 28 triliun (kurs Rp 14.000 per dollar AS) dalam mengurangi emisi karbon dengan memproduksi mobil hibrida dan listrik. “Kami mendorong agar para pelaku industri Jepang dapat aktif berinvestasi di Indonesia. Apalagi, Pemerintah Indonesia bertekad menciptakan iklim usaha yang kondusif dengan memberikan kemudahan izin dan berbagai insentif yang menarik,” kata dia melalui keterangan tertulis, dikutip pada Senin (1/3/2021). Baca juga: Bidik Ekspor Mobil ke Australia, Mendag Rayu Produsen Jepang Selain itu, dari total tujuh perusahaan multinasional, terdapat tiga perusahaan Jepang yang akan merelokasi pabriknya dari China ke Indonesia, yaitu Panasonic Manufacturing dengan nilai investasi sebesar 30 juta dollar AS, Denso investasi senilai 138 juta dollar AS, dan Sagami Indonesia senilai 50 juta dollar AS. Pada tahun 2019, nilai investasi Jepang di Indonesia sebesar 4,31 miliar dollar AS. Sedangkan pada periode Januari-November 2020 mencapai 2,58 miliar dollar AS. Sementara itu, ekspor sektor nonmigas Indonesia ke Jepang sepanjang tahun 2014-2019 mengalami pertumbuhan positif sebesar 3,23 persen. Pada 2019, nilai pengapalan Indonesia ke Jepang untuk sektor nonmigas mencapai 13,8 miliar dollar AS. Sementara itu, Direktur Jenderal Ketahanan, Perwilayahan, dan Akses Industri Internasional (KPAII) Kementerian Perindustrian, Eko SA Cahyanto mengemukakan, Indonesia dan Jepang sepakat melakukan kerja sama di bidang pengembangan sektor industri melalui program New Manufacturing Industry Development Center (New MIDEC). Program itu berisikan kerangka proyek kerja sama yang meliputi enam sektor strategis, yaitu industri otomotif, elektronik, kimia, tekstil, makanan dan minuman, serta logam. Program New MIDEC akan dilaksanakan pada tujuh bidang lintas sektor yang meliputi metal working, mold dan dies, welding, energy conservation, SME development, export promotion, dan policy reforms. “Menindaklanjuti hal tersebut, Kemenperin telah mengusulkan sektor otomotif untuk menjadi sektor pertama (quick win program) pada proyek kerja sama dengan pihak Jepang, melalui dua pilot project, yaitu SME Development dan Mold dan Dies,” kata Eko. Baca juga: Ini 21 Jenis Mobil yang Dapat Insentif PPnBM Nol Persen                                                                                                                                                                                                                                                                                                                                        |

Lantas analisa apa yang bisa dilakukan?

Sebenarnya banyak yang bisa dilakukan. Contohnya, teman saya ingin
melakukan *sentimen analysis* terkait beberapa topik berita yang ada.
Kita juga bisa melihat apakah ada perbedaan gaya penulisan dari
masing-masing jurnalis di *Kompas.com*.

Kali ini saya ingin melakukan sesuatu yang sederhana. Apa itu?

### *Preparation* dan *Cleaning*

Sebelum jauh melakukan analisa, saya akan bersihkan terlebih dahulu data
di atas sehingga menjadi berikut ini:

    ## # A tibble: 5 x 4
    ##   jurnalis     tgl        judul                      berita                     
    ##   <chr>        <date>     <chr>                      <chr>                      
    ## 1 Ade Miranti… 2021-02-25 indonesia china lengket l… "Menteri Koordinator Bidan…
    ## 2 Ade Miranti… 2021-03-01 kemenperin mobil gunakan … "Menteri Perindustrian (Me…
    ## 3 Ade Miranti… 2021-02-25 luhut sebut 2 juta vaksin… "Menteri Koordinator Bidan…
    ## 4 Ade Miranti… 2021-02-25 luhut presiden ingin apbn… "Menteri Koordinator Bidan…
    ## 5 Ade Miranti… 2021-03-01 menperin sebut toyota sia… "Menteri Perindustrian (Me…

### Berita Terkait Pajak Mobil di Kompas Money

Misalkan saya ingin mengetahui semua berita terkait sebuah topik
`pajak mobil` yang sedang hangat diperbincangkan.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post%203%20kompas%20scraper/kompost_files/figure-gfm/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

Berita terbanyak muncul pada Senin, `1 Maret 2021` kemarin. Apa saja
judul beritanya?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post%203%20kompas%20scraper/kompost_files/figure-gfm/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

Dari *wordcloud* di atas kira-kira sudah ketebak *lah* ya?

Sekarang saya akan melihat *bigrams* yang muncul dari berita-berita
tersebut.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post%203%20kompas%20scraper/kompost_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

------------------------------------------------------------------------

# *Summary*

Dengan **R** saya bisa melakukan *media monitoring* dengan relatif
mudah. Mulai dari proses *web scraping*, analisa, hingga *reporting*
dapat dilakukan di dalam **R**.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking on the ads shown.`
