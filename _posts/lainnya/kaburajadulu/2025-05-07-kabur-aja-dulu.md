---
title: "#KaburAjaDulu dalam Data"
date: 2025-05-07T10:35:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Big Data
  - Visualisasi
  - Imigrasi
  - Emigrasi
  - KaburAjaDulu
  - Viral
---

Beberapa bulan belakangan ini, saya seringkali melihat tagar
**\#KaburAjaDulu** berseliweran di semua sosial media yang saya ikuti.
Jika saya coba lakukan *mini research* di *Google*, tagar
**\#KaburAjaDulu** pertama kali muncul dan diangkat oleh akun
`@hrdbacot` di platform **X** pada tanggal 14 Januari 2025. Namun, tagar
ini mulai menjadi viral dan tren setelah diangkat oleh akun tersebut.
Ismail Fahmi, pendiri Drone Emprit, juga turut menyebutkan bahwa tagar
ini muncul sejak September 2023.

Bahkan tagar ini sudah memiliki halaman Wikipedia-nya sendiri. Saya bisa
mengutip satu paragraf dari halaman berikut:

> Tagar ini digunakan oleh warganet Indonesia untuk mengekspresikan
> keinginan meninggalkan Indonesia demi mencari peluang kerja,
> pendidikan, atau kehidupan yang lebih baik di luar negeri. Fenomena
> ini mencerminkan keresahan terhadap kondisi sosial dan ekonomi dalam
> negeri, seperti tingginya biaya pendidikan, minimnya lapangan kerja,
> serta upah yang dianggap rendah. Melalui \#KaburAjaDulu, banyak
> pengguna berbagi informasi tentang lowongan kerja, beasiswa, dan
> kesempatan berkarier di luar negeri.

Saya sendiri memiliki beberapa teman SMA dan kuliah yang saat ini sedang
bekerja dan menetap di luar negeri. Saya sempat penasaran apakah saya
bisa mendapatkan data terkait hal ini?

Untuk “mendekati”-nya, saya mendapatkan data dari situs [*Our World in
Data*](https://ourworldindata.org/explorers/migration-flows?tab=table&country=~IDN&Country=Indonesia&Metric=Emigrants%3A+People+moving+away+from+country&Gender=All+migrants)
terkait ke mana emigran asal Indonesia pergi?

Definisi dari data emigran ini adalah:

> ***The number of people who were born in Indonesia and now live
> abroad. This is a measure of emigrant stocks at mid-year, not the
> annual flow of emigrants.***

Seharusnya dari definisi tersebut, saya bisa “mendekati” berapa banyak
orang yang **\#KaburAjaDulu**.

Untuk mengawali analisa sederhana ini, saya akan coba hitung berapa
banyak emigran Indonesia pada tahun 2024 di masing-masing area di semua
benua yang ada.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-2-1.png)

Ternyata kita dapatkan hal menarik.

- Empat area teratas berasal dari Asia sedangkan sisanya baru berasal
  dari Afrika, Eropa, dan Amerika.
- Area *South-Eastern Asia* memiliki jumlah emigran terbanyak di
  tahun 2024. Hal ini mungkin cukup *obvious* karena Indonesia masih
  serumpun dengan beberapa negara di Asia Tenggara (ASEAN) sehingga
  tidak perlu banyak *effort* bagi WNI untuk beradaptasi.
  - Angkanya sendiri sangat tinggi dan mungkin tidak akan bisa disalip
    oleh area lain dalam waktu dekat.
  - Jika saya *deep dive*, berikut adalah jumlah emigran di
    negara-negara *South-Eastern Asia*:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-3-1.png)

Grafik-grafik di atas merupakan kondisi saat ini. Sekarang saya akan
coba melihat tren banyaknya emigran Indonesia di *top 5 area* tersebut
sejak tahun 1990 hingga 2024.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-4-1.png)

Ternyata laju penambahan / pengurangan untuk masing-masing area di atas
cukup berbeda. Misalnya pada area *Western Europe* yang punya
kecenderungan menurun. Sedangkan area lainnya punya kecenderungan naik
walau berbeda-beda tingkatnya.

Berbicara mengenai laju perubahan, saya akan coba hitung perubahan atau
*growth* jumlah emigran dari tahun 2020 dan 2024. Grafik berikut ini
memperlihatkan berapa persen *growth* emigran Indonesia per area dari
tahun 2020 ke 2024:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-5-1.png)

Saat kita melihat persen *growth*, kita bisa dapatkan:

- Walaupun pada grafik pertama area *South-Eastern Asia* memiliki jumlah
  emigran terbanyak pada 2024, tapi ternyata *growth*-nya tidak setinggi
  itu. Dari grafik berikut ini, *growth* per negara berkisar antara 4-7%
  saja.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-6-1.png)

- Area dengan persen *growth* terbanyak adalah area *Southern Asia*.
  Kemudian disusul oleh *Central America*, *Eastern Asia*, *Eastern
  Europe*, dan *Northern Europe*. Mari kita lihat jika saya detailkan
  *growth* negara-negara di *Southern Asia* berikut ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-7-1.png)

*Surprisingly*, *growth* terbesar di *Southern Asia* disumbangkan dari
Bangladesh.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-8-1.png)

> ***Namun perlu saya tekankan sekali lagi bahwa persentase bisa saja
> menipu saat pembaginya kecil sehingga seolah-olah nilainya besar.***

Maka dari itu, saya akan coba hitung
![\Delta](https://latex.codecogs.com/svg.latex?%5CDelta "\Delta")
emigran dari 2020 ke 2024. Berikut hasilnya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-9-1.png)

Empat area dengan
![\Delta](https://latex.codecogs.com/svg.latex?%5CDelta "\Delta")
tertinggi adalah *Eastern Asia*, *South-eastern* *Asia*, *Southern
Asia*, dan *Western Asia*. Sedangkan penurunan terjadi pada *Western
Europe*.

Pada bagian sebelumnya, kita sudah membahas *South-eastern* *Asia* dan
*Southern Asia*. Sekarang saya akan keluarkan detail
![\Delta](https://latex.codecogs.com/svg.latex?%5CDelta "\Delta") pada
negara-negara *Eastern Asia* dan *Western Asia*.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-10-1.png)

Ternyata ada beberapa hal menarik:

- Ternyata ada penurunan emigran di Saudi Arabia dan Korea Selatan.
  Awalnya saya menduga
  ![\Delta](https://latex.codecogs.com/svg.latex?%5CDelta "\Delta") di
  kedua negara ini tinggi tapi malah sebaliknya.
- Justru
  ![\Delta](https://latex.codecogs.com/svg.latex?%5CDelta "\Delta")
  tertinggi dimiliki oleh Jepang. Hipotesis penyebabnya:
  - Jepang mengalami penurunan populasi yang signifikan. Pada Oktober
    2024, populasi warga negara Jepang turun menjadi 120,3 juta jiwa,
    mengalami penurunan rekor sebanyak 898.000 orang dibandingkan tahun
    sebelumnya. Penurunan ini disebabkan oleh angka kelahiran yang
    rendah, yang termasuk yang terendah di dunia.
  - Akibatnya Jepang mulai “terbuka” dengan warga asing terutama WNI.
- UAE dan Taiwan memiliki
  ![\Delta](https://latex.codecogs.com/svg.latex?%5CDelta "\Delta") yang
  serupa.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/kaburajadulu/draft_files/figure-commonmark/unnamed-chunk-11-1.png)

Lonjakan di Jepang baru terjadi beberapa tahun ini sedangkan lonjakan
yang sama pernah terjadi di Taiwan dan UAE sudah terjadi sejak lama.

*So*, apa yang bisa kita simpulkan dari paparan analisa data ini?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
