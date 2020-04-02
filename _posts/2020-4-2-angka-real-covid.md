---
date: 2020-4-2T5:30:00-04:00
title: "Menemukan Angka Real Infected Person COVID-19"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Math Modelling
  - R
  - Corona Virus
  - Covid-19
  - Modelling
  - Differential Equations
---

Tulisan ini masih bertemakan COVID-19, karena banyak sekali sisi yang
bisa dibahas terkait dengan fenomena wabah ini secara matematis.

Kali ini saya mencoba untuk menjawab beberapa pertanyaan yang sering ada
di WAG kita semuanya. Apa saja?

1.  [Wabah ini kapan
    selesainya](https://ikanx101.github.io/blog/covid/#pertanyaan-yang-sering-muncul)?
    Akan *peak* saat *infected person* berapa persen dari populasi
    Indonesia (atau Jakarta)?
2.  [Kenapa banyak korban jiwa COVID-19 di
    Indonesia](https://ikanx101.github.io/blog/sir-covid/#kenapa-mortality-rate-di-indonesia-tinggi)?

# Pertanyaan Pertama

Saya pernah menyinggung mengenai pertanyaan ini di tulisan saya yang
pertama terkait [SIS model](https://ikanx101.github.io/blog/covid/)
untuk COVID-19. Saya sarankan untuk bisa membacanya terlebih dahulu agar
bisa lebih cepat *catch-up* dengan pembahasan saya ini.

Banyak pihak (baca: matematikawan lain) telah membuat berbagai macam
model dengan berbagai macam cara. Mulai dari pendekatan deterministik
seperti yang saya buat hingga pendekatan statistik. Namun perlu
diperhatikan bahwa [setiap model memiliki
batasan](https://passingthroughresearcher.wordpress.com/2018/04/08/kenapa-sih-harus-belajar-sains/)
walau itu adalah *tools* terbaik yang dimiliki kita saat ini untuk
menggambarkan kondisi dan bahkan membuat prediksi.

Namun ada yang perlu saya garis bawahi. Khusus di Indonesia, saya
berpikir bahwa membangun model berdasarkan *curve fitting* tidak bisa
dilakukan. Kalaupun dilakukan bisa jadi akan cenderung bias.

**Kenapa?**

Pada awal penanganan COVID-19, pemerintah pusat [hanya mampu melakukan
tes sebanyak 1.700 tes dalam
sehari](https://tirto.id/siapkah-pemerintah-hadapi-pandemi-corona-covid-19-eFqf).
Setelah [beberapa lembaga diperbolehkan untuk melakukan
tes](https://katadata.co.id/berita/2020/03/16/unair-dan-eijkman-jadi-laboratorium-corona-berapa-lama-hasil-tesnya),
kapasitas tersebut sudah naik. Apalagi dengan tambahan pemeriksaan
dengan metode *rapid test*.

> KONSEKUENSInya adalah terjadi lonjakan kasus positif setelah kapasitas
> pemeriksaan ditambah\!

Jadi penambahan tinggi itu sejatinya adalah penambahan *new reported
cases* bukan *new infected cases*.

Dari data yang saya ambil dari situs
[kawalcovid19](https://kawalcovid19.blob.core.windows.net/viz/statistik_harian.html),
pada 1 April 2020 pukul 09.24 WIB kita bisa melihat grafiknya sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/covid-real_files/figure-gfm/unnamed-chunk-1-1.png" width="672" />

Jika diperhatikan, lonjakan *new reported cases* terjadi setelah
pemerintah mengizinkan lembaga lain untuk melakukan tes COVID-19
(setelah 16 Maret 2020). Lonjakan tinggi terjadi kembali [saat *rapid
test* mulai dilakukan sekitar seminggu yang
lalu](https://katadata.co.id/berita/2020/03/20/deteksi-corona-pemerintah-mulai-lakukan-rapid-test-hari-ini).

Salah satu alasan saya membuat model adalah ingin [menggambarkan situasi
dan mencoba memberikan
solusi](https://ikanx101.github.io/blog/covid/#kesimpulan) dari kondisi
saat ini. Tidak untuk membuat prediksi karena ada [satu hal yang paling
penting untuk diketahui tapi tidak kita
ketahui](https://ikanx101.github.io/blog/covid/#mengetahui-angka-pasti-)
sampai saat ini.

**Apa itu?**

Berapa banyak `I0`?

**Kenapa menjadi penting?**

COVID-19 merupakan penyakit yang berasal dari Wuhan, China. Jika
sekarang wabah tersebut ada di Indonesia, berarti ada orang sakit yang
masuk ke Indonesia.

Masalahnya adalah, saat terjadi epidemi di China, kita tidak melakukan
pembatasan penerbangan dan alur manusia masuk dari negara lain yang
sudah terjangkit wabah tersebut.

Sudah lihat [video
penelusuran](https://www.narasi.tv/buka-mata/ceroboh-di-cianjur-jejak-buram-pemerintah-menangani-pandemi-covid-19)
pasien positif asal Bekasi yang meninggal di Cianjur?

Hal ini menunjukkan bahwa COVID-19 bisa jadi sudah ada di Indonesia
sebelum kasus `01` dan `02` diumumkan oleh presiden.

Dengan mengetahui `I0`, kita bisa melihat seberapa cepat penyebaran
wabah ini. Oleh karena kita tidak tahu ada berapa banyak `I0` yang ada
di masyarakat. Akibatnya, kita tidak tahu posisi Indonesia sekarang di
mana.

> Apakah berada di awal kurva?

Baru mulai naik.

> Apakah berada di tengah?

Mulai naik eksponensial.

> Atau berada di akhir kurva?

Akan landai sebentar lagi.

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

Tanpa informasi `I0` yang tepat (atau mendekati), kita akan sulit
menghitung kecepatan penyebaran wabah. Namun demikian, kita masih bisa
menghitung pada persentase berapa *infected person* ada di *peak
position* dengan mengandalkan `R0`.

Saya coba lihat, hampir semua perhitungan model rekan-rekan
matematikawan berada di kisaran `40%` - `65%` untuk *peak position* dari
*infected person* (perhitungan model tanpa ada karantina atau *physical
distancing*).

# Jawaban Pertanyaan Kedua

Sebelum memulai pembahasan kedua ini, saya perlu nyatakan bahwa setiap
korban jiwa ini memiliki nama, memiliki keluarga, memiliki kehidupannya
sendiri. Jadi *put your empathy please, this is not about number and
statistics \!*. Kita sama-sama doakan agar para korban tersebut
mendapatkan tempat terbaik dari Allah dan keluarga yang ditinggalkan
diberikan kesehatan dan kesabaran. *Aamiin*

*Oke, saya mulai yah:*

Di Indonesia, banyak korban jiwa yang berjatuhan. Sebagaimana yang kita
ketahui, hal yang membunuh adalah [kondisi dan komplikasi yang datang
bersamaan](https://www.kompas.com/sains/read/2020/03/28/180000523/angka-kematian-akibat-virus-corona-di-indonesia-tinggi-apa-sebabnya-?page=all#page3)
dengan COVID-19 ini.

Berdasarkan data yang saya ambil dari
[worldometers](https://www.worldometers.info/coronavirus/coronavirus-age-sex-demographics/#pre-existing-conditions),
*death rates* yang tinggi terjadi saat pasien telah memiliki kondisi
kesehatan yang kurang baik.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/covid-real_files/figure-gfm/unnamed-chunk-3-1.png" width="672" />

Mari kita lihat data *death rates* per pagi ini pukul 07.00 WIB yang
dihimpun di situs
[wordometers](https://www.worldometers.info/coronavirus/) berikut:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/covid-real_files/figure-gfm/unnamed-chunk-4-1.png" width="672" />

Indonesia memiliki persentase tertinggi ketiga sekarang.

Jika kita lihat kembali di atas, kematian akibat COVID-19 disebabkan
oleh kondisi dan komplikasi yang dimiliki oleh pasien.

Lalu, kenapa di Indonesia bisa setinggi itu?

Setidaknya ada dua hipotesa saya:

## Hipotesa Pertama

Kualitas kesehatan individual di Indonesia relatif buruk.

Oleh karena COVID-19 menyerang sistem pernafasan, saya jadi menduga
kondisi seperti TBC jadi hal yang berpengaruh. Sebagaimana yang kita
tahu, bahwa angka penderita TBC di [Indonesia cukup tinggi di
dunia](https://databoks.katadata.co.id/datapublish/2019/10/09/who-kasus-tbc-indonesia-2017-terbesar-ketiga-dunia).

Beberapa tahun lalu, istri saya divonis menderita TBC sehingga harus
diobati selama 9 bulan padahal tidak ada gejala klinis sama sekali yang
terlihat. Tapi hasil *rontgen* dan pemeriksaan oleh beberapa dokter
spesialis paru menyatakan demikian.

Oleh karena itu, saya jadi berpikir mungkin ini adalah dugaan yang
tepat. Bisa jadi banyak juga penderita TBC yang tidak mengetahui dirinya
terjangkit TBC sehingga saat terpapar COVID-19 kondisinya jadi memburuk.

Ini baru TBC saja, belum kondisi lainnya seperti kardiovaskular, kanker,
dan diabetes.

Tapi jika saya ambil data dari
[WorldBank](https://www.google.com/publicdata/explore?ds=d5bncppjof8f9_&ctype=l&met_y=sh_xpd_publ#!ctype=l&strail=false&bcs=d&nselm=h&met_y=sh_tbs_incd&scale_y=lin&ind_y=false&rdim=region&idim=country:IDN:ITA:ESP:NLD:FRA&ifdim=region&hl=en_US&dl=en_US&ind=false):

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/TBC.jpg)<!-- -->

Kita bisa lihat bersama, angka insiden TBC di Indonesia relatif sangat
tinggi dibandingkan negara lain yang memiliki korban COVID-19 \> 100
jiwa.

Tapi jika ini berkorelasi, seharusnya hal ini tidak akan terjadi untuk
negara-negara Eropa yang relatif lebih sehat dan siap secara fasilitas.

Oke, sekarang kita lihat data lain terkait faskes dan tenaga kesehatan,
didapatkan data sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/faskes1.jpg)<!-- -->

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/faskes2.jpg)<!-- -->

Sayangnya saya tidak menemukan angka perbandingan kardiovaskular,
diabetes, kanker, dan kondisi lainnya yang berbahaya bagi penderita
COVID-19.

Berdasarkan informasi terbatas di atas, mungkin hipotesa pertama saya
menjadi lemah.

Lalu saya berpikir kembali, jangan-jangan korban jiwa di Indonesia ini
dikarenakan oleh usia.

Kita tahu bahwa virus ini lebih berbahaya bagi orang yang sudah tua.
Berdasarkan data yang dihimpun di
[webm.net](https://www.cebm.net/covid-19/global-covid-19-case-fatality-rates/)
saya dapatkan informasi bahwa semakin tua usia pasien COVID-19, maka
peluang penyakit ini berbahaya juga semakin tinggi.

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/cfr.jpg)<!-- -->

Mari kita bandingkan dengan kejadian di Indonesia berikut ini. Data saya
dapatkan dari
[kawalcovid19](https://kawalcovid19.blob.core.windows.net/viz/statistik_harian.html)
per 2 April 2020 pukul 11.00.

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/demografi.jpg)<!-- -->

Pada rentang usia 50-59 tahun, ada 9 orang yang meninggal dari 115 kasus
yang tercatat. Artinya *case fatality rate* (CFR) pada rentang usia ini
adalah 7.83% lebih tinggi dibandingkan angka di webm.net tersebut.

Hal yang sama pun terjadi di rentang usia 60-69 tahun, ada 5 orang yang
meninggal dari 55 kasus yang tercatat. Artinya CFR pada rentang usia ini
adalah 9.09% masih relatif lebih tinggi dibandingkan angka di webm.net
tersebut.

Indonesia masih memiliki angka *rate* yang lebih tinggi. Saya jadi
mempertanyakan pertanyaan saya ini. Jangan-jangan bukan KENAPA RATE DI
INDONESIA TINGGI? tapi:

> Apakah kita sudah benar menghitung death rate di Indonesia?

Oleh karena itu, *this new question lead me to a new hypothesis*.

## Hipotesa Kedua

Hipotesa kedua ini mungkin lebih provokatif tapi menurut saya masuk
akal.

Berdasarkan [informasi dan kalkulasi dari
WHO](https://www.worldometers.info/coronavirus/coronavirus-death-rate/),
*mortality rate* COVID-19 adalah `3.4%`. Sedangkan beberapa studi
lainnya, secara *nationwide* di China menunjukkan angka sebesar `3.8%`.

Coba kita lihat kembali *density plot* dari sebaran data *mortality
rate* semua negara yang ada.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/covid-real_files/figure-gfm/unnamed-chunk-9-1.png" width="672" />

Distribusinya terlihat mirip *pareto distribution* atau *lognormal
distribution* dimana hampir semua data berkumpul di sebelah kiri.

Kalau saya hitung,78% negara-negara yang ada di data tersebut memiliki
*rate* berada di bawah angka WHO (`3.4%`).

-----

### Catatan terkait pembuktian distribusi lognormal atau pareto:

Saya bisa saja melakukan pengecekan apakah memang data *rate* ini
memiliki distribusi pareto atau lognormal. Tapi dengan catatan *lower
bound* dari data harus sangat kecil tapi tidak `nol` (*near zero*).
Sedangkan data *real*-nya banyak negara yang memiliki *mortality rate* =
`0%`.

Pembuktiannya bisa dilakukan dengan menggunakan [**Cullen Frey
Diagram**](https://passingthroughresearcher.wordpress.com/2019/08/09/mencari-peluang-kegagalan-dari-data-yang-tak-pernah-gagal/),
contohnya:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/covid-real_files/figure-gfm/unnamed-chunk-11-1.png" width="672" />

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/covid-real_files/figure-gfm/unnamed-chunk-11-2.png" width="672" />

-----

Oke, kita kembali ke pembahasan hipotesa saya.

Saya jadi berpikir menggunakan argumen di **jawaban pertanyaan pertama**
dimana ada keterbatasan-keterbatasan yang dilakukan pemerintah dalam
melakukan tes sehingga angka yang didapatkan adalah *reported cases*
bukan *real infected person*.

> Jadi berapa real infected person di Indonesia?

Per 2 April 2020, ada `157` orang yang meninggal akibat COVID-19.

Jika saya asumsikan *death rates* milik WHO bisa dijadikan acuan, maka
angka *real infected* di Indonesia seharusnya:

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/formula1.jpg)<!-- -->

Jadi *expected infected person* COVID-19 ada sekitar `4.617` orang.

> Besar juga *yah*…

Sekarang kita coba lakukan simulasi menggunakan rentang *rate* disebelah
kiri garis merah (Indonesia) pada *density plot*.

Saya gunakan prinsip simullasi MonteCarlo dengan `9.000` kali
pengulangan

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20angka%20real/covid-real_files/figure-gfm/unnamed-chunk-13-1.png" width="672" />

Dari grafik di atas, saya memperkirakan bahwa *real infected person* di
Indonesia berada di rentang antara 7202 sampai 12159 orang.

Jadi ada selisih ribuan orang yang belum dilaporkan ke pemerintah. Bisa
jadi tidak dilaporkan karena gejala yang dialami sangat ringan sehingga
bisa sembuh sendiri atau tidak perlu ke faskes atau tidak terdeteksi di
faskes tingkat pertama.

Wallahu a’lam.

Jika ada yang mau didiskusikan, silakan *drop me a message* yah.
