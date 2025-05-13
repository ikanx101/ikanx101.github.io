---
title: "Crowd Wisdom Principle: Sebuah Penjelasan Sederhana tentang Kepintaran/Kebodohan Kolektif"
date: 2025-05-13T10:06:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Crowd Wisdom
  - Kebodohan
  - Kepintaran
  - Intelejensia
  - Law of Large Number
  - Statistika
---

# Sejarah

## Penemuan *Crowd Wisdom* di Pameran Ternak

Pada tahun 1906, seorang ilmuwan Inggris bernama **Francis Galton**
menemukan fenomena yang kemudian dikenal sebagai *Crowd Wisdom* atau
Kebijaksanaan Kerumunan. Penemuan ini terjadi secara tidak sengaja
ketika Galton mengunjungi sebuah pameran ternak di *West of England Fat
Stock and Poultry Exhibition* di **Plymouth**. Di sana, diadakan sebuah
kompetisi di mana para pengunjung mencoba menebak berat seekor sapi yang
telah disembelih dan dibersihkan ([berat
karkas](https://ikanx101.com/blog/qurban-ccr/)).

Galton, yang awalnya skeptis terhadap kemampuan orang awam dalam membuat
tebakan yang akurat, mengumpulkan **787 tiket tebakan** dari para
pengunjung. Setelah menganalisis data tersebut, ia mengurutkan semua
tebakan dan menemukan bahwa nilai tengah (**median**) dari
tebakan-tebakan tersebut, yaitu 1207 *pounds*, sangat mendekati berat
sebenarnya lembu tersebut, yaitu 1198 *pounds*.

Lebih lanjut, Galton menghitung rata-rata dari semua tebakan dan
hasilnya lebih mengejutkan lagi. Rata-rata tebakan kerumunan adalah 1197
*pounds*, hanya selisih satu *pounds* atau sekitar setengah kilogram
dari berat sebenarnya. Temuan ini menunjukkan bahwa penilaian kolektif
dari banyak orang, meskipun masing-masing individu mungkin tidak ahli,
bisa jadi luar biasa akurat, bahkan lebih akurat daripada kebanyakan
tebakan individu. Eksperimen sederhana di pameran ternak inilah yang
menjadi dasar dari konsep *Crowd Wisdom*.

# Tiga Prinsip *Crowd Wisdom*

**1. Prinsip Pertama: Penilaian Kolektif Umumnya Lebih Cerdas Daripada
Kebanyakan Penilaian Individu**

- **Penjelasan Sederhana:** Bayangkan ada sebuah kuis tebak jumlah
  kelereng dalam toples. Jika banyak orang menebak, dan kita ambil
  rata-rata dari semua tebakan itu, hasilnya seringkali akan jauh lebih
  mendekati jumlah kelereng yang sebenarnya dibandingkan tebakan satu
  orang saja, bahkan tebakan orang yang paling pintar sekalipun.
- **Mengapa Bisa Begitu?** Setiap orang mungkin memiliki sedikit
  informasi yang benar dan juga sedikit kesalahan dalam tebakannya.
  Ketika banyak tebakan digabungkan:
  - **Informasi yang beragam saling melengkapi:** Orang yang berbeda
    mungkin memperhatikan aspek yang berbeda, dan gabungan dari
    pengamatan ini menciptakan gambaran yang lebih lengkap.
  - **Kesalahan individu cenderung saling meniadakan:** Beberapa orang
    mungkin menebak terlalu tinggi, sementara yang lain menebak terlalu
    rendah. Ketika dirata-ratakan, kesalahan-kesalahan ekstrem ini bisa
    saling mengimbangi.

**2. Prinsip Kedua: Ukuran Kerumunan Penting, Kerumunan yang Lebih Besar
Lebih Cerdas**

- **Penjelasan Sederhana:** Semakin banyak orang yang berpartisipasi
  dalam memberikan tebakan atau pendapat, kemungkinan besar rata-rata
  dari semua tebakan itu akan semakin akurat. Jadi, kerumunan dengan 500
  orang biasanya akan memberikan perkiraan yang lebih baik daripada
  kerumunan dengan hanya 50 orang.
- **Mengapa Bisa Begitu?** Dengan lebih banyak orang, ada lebih banyak
  perspektif dan potongan informasi yang masuk. Selain itu, secara
  statistik, sampel yang lebih besar cenderung memberikan rata-rata yang
  lebih stabil dan mewakili populasi atau kenyataan yang sebenarnya.
  Semakin banyak data (tebakan), semakin besar kemungkinan kesalahan
  acak untuk saling meniadakan.

**3. Prinsip Ketiga: Kurva *Crowd Wisdom* Menunjukkan Tak Ada
Peningkatan Signifikan (*Saturated*) Saat Anda Meningkatkan Ukuran
Kerumunan yang Lebih Besar Lagi**

- **Penjelasan Sederhana:** Meskipun kerumunan yang lebih besar itu
  lebih baik, penambahan setiap orang baru tidak selalu memberikan
  peningkatan akurasi yang sama besarnya. Misalnya, menambah jumlah
  penebak dari 10 menjadi 100 orang mungkin akan meningkatkan akurasi
  secara drastis. Tapi, menambah dari 1000 menjadi 1100 orang mungkin
  hanya akan memberikan sedikit sekali peningkatan akurasi.
- **Mengapa Bisa Begitu?** Pada awalnya, setiap individu baru
  kemungkinan besar membawa informasi atau perspektif unik yang
  signifikan. Namun, setelah banyak orang berpartisipasi, informasi baru
  yang dibawa oleh orang tambahan berikutnya cenderung sudah terwakili
  oleh anggota kerumunan yang ada. Jadi, manfaat tambahan dari setiap
  orang baru menjadi semakin kecil. Ada titik di mana upaya untuk
  mengumpulkan lebih banyak pendapat mungkin tidak sebanding dengan
  peningkatan akurasi yang didapat (*saturated*).

> Secara ringkas, *crowd wisdom* bekerja paling baik ketika ada banyak
> orang memberikan penilaian secara independen, dan meskipun lebih
> banyak lebih baik, ada batas di mana manfaat penambahan orang baru
> mulai berkurang.

# Matematika di Balik *Crowd Wisdom*

*Crowd Wisdom* bekerja karena hukum rata-rata pada *law of large
numbers* dan pembatalan kesalahan (*error cancellation*). Berikut
penjelasannya:

Misalkan setiap individu dalam kelompok membuat tebakan
(![X_i](https://latex.codecogs.com/svg.latex?X_i "X_i")) tentang suatu
nilai sebenarnya
(![X\_{true}](https://latex.codecogs.com/svg.latex?X_%7Btrue%7D "X_{true}")).
Kita bisa tuliskan tebakan ini dalam formula berikut:

![X_i = X\_{true} + \epsilon_i](https://latex.codecogs.com/svg.latex?X_i%20%3D%20X_%7Btrue%7D%20%2B%20%5Cepsilon_i "X_i = X_{true} + \epsilon_i")

Di mana
![\epsilon_i](https://latex.codecogs.com/svg.latex?%5Cepsilon_i "\epsilon_i")
merupakan komponen *eror* acak yang bersifat independen dan
terdistribusi normal dengan *mean* nol.

Jika kita mengambil rata-rata tebakan dari
![N](https://latex.codecogs.com/svg.latex?N "N") orang, maka formulasi
matematisnya:

![\hat{X} = \frac{1}{N} \sum\_{i=1}^N{X_i} = X\_{true} + \sum\_{i=1}^N\epsilon_i](https://latex.codecogs.com/svg.latex?%5Chat%7BX%7D%20%3D%20%5Cfrac%7B1%7D%7BN%7D%20%5Csum_%7Bi%3D1%7D%5EN%7BX_i%7D%20%3D%20X_%7Btrue%7D%20%2B%20%5Csum_%7Bi%3D1%7D%5EN%5Cepsilon_i "\hat{X} = \frac{1}{N} \sum_{i=1}^N{X_i} = X_{true} + \sum_{i=1}^N\epsilon_i")

Oleh karena
![\epsilon_i](https://latex.codecogs.com/svg.latex?%5Cepsilon_i "\epsilon_i")
acak dan independen, maka hasil akhirnya akan saling meniadakan (*error
cancellation*). Akibatnya **semakin besar**
![N](https://latex.codecogs.com/svg.latex?N "N"), **semakin dekat**
![\hat{X}](https://latex.codecogs.com/svg.latex?%5Chat%7BX%7D "\hat{X}")
**ke**
![X\_{true}](https://latex.codecogs.com/svg.latex?X_%7Btrue%7D "X_{true}")
**(sesuai hukum bilangan besar)**.

Sesuai dengan prinsip matematika di atas, maka agar *crowd wisdom*
bekerja dengan baik dan akurat, kelompok harus memenuhi:

1.  Keanekaragaman pendapat (setiap orang punya perspektif unik).
2.  Independensi (tebakan tidak dipengaruhi orang lain).
3.  Desentralisasi (tidak ada otoritas tunggal yang mendominasi).
4.  Agregasi yang tepat (ada mekanisme untuk menggabungkan pendapat,
    seperti rata-rata, median, modus, atau lainnya).

------------------------------------------------------------------------

# Kebodohan Kolektif

Pada uraian di atas, kita telah mendapatkan contoh bagaimana kerumunan
bisa memiliki penilaian yang **lebih pintar dibandingkan penilaian
individu**.

> **Namun, celakanya kerumunan bisa juga menghasilkan kebodohan
> kolektif. Kebodohan kolektif terjadi ketika kerumunan membuat
> keputusan yang lebih buruk daripada individu, biasanya karena gagalnya
> syarat *crowd wisdom*.**

Berikut adalah beberapa penyebabnya:

1.  *Herd Behavior* (Perilaku Kawanan)
    - Jika orang mulai meniru satu sama lain (bukan independen),
      kesalahan tidak lagi saling meniadakan.
    - Contoh: Gelembung pasar saham ketika semua orang ikut-ikutan
      membeli aset *overvalued*.
2.  Informasi Terpusat (*Groupthink*)
    - Ketika kelompok terlalu homogen atau dipengaruhi pemimpin dominan,
      keragaman hilang.
    - Contoh: Keputusan politik yang buruk karena tekanan kesepakatan
      (seperti kasus *Bay of Pigs*).
3.  Media Sosial dan *Echo Chambers*
    - Platform seperti *Twitter/X* atau *Facebook* memperkuat suara
      mayoritas dan menyaring informasi yang tidak sesuai, menghancurkan
      independensi.

Kita bisa tuliskan juga fenomena kebodohan kolektif ini dengan formula
matematika sebagai berikut:

![X_i = X\_{true} + \text{bias}\_i](https://latex.codecogs.com/svg.latex?X_i%20%3D%20X_%7Btrue%7D%20%2B%20%5Ctext%7Bbias%7D_i "X_i = X_{true} + \text{bias}_i")

Jika bias tersebut terakumulasi sebanyak
![N](https://latex.codecogs.com/svg.latex?N "N") orang, maka
![\hat{X}](https://latex.codecogs.com/svg.latex?%5Chat%7BX%7D "\hat{X}")
**akan sangat jauh dari**
![X\_{true}](https://latex.codecogs.com/svg.latex?X_%7Btrue%7D "X_{true}")
gara-gara akumulasi bias
(![\sum\_{i=1}^N\text{bias}\_i](https://latex.codecogs.com/svg.latex?%5Csum_%7Bi%3D1%7D%5EN%5Ctext%7Bbias%7D_i "\sum_{i=1}^N\text{bias}_i")).

## Agar Tidak Jatuh ke Dalam Kebodohan Kolektif

Penting untuk secara aktif mempromosikan independensi, mendorong
keberagaman pemikiran, dan menerapkan mekanisme agregasi yang efektif
untuk memaksimalkan peluang kebijaksanaan kolektif dan meminimalkan
risiko kebodohan kolektif.

> **Kelompok bisa lebih bijak daripada individu, tetapi hanya jika
> strukturnya tepat. Jika tidak, justru lebih bodoh.**

------------------------------------------------------------------------

# *Appendix*

## Mengenal Francis Galton (1822 – 1911)

Sir Francis Galton adalah seorang *polymath* Inggris yang memiliki
kontribusi signifikan di berbagai bidang ilmu pengetahuan. Lahir pada 16
Februari 1822 di Birmingham, Inggris, Galton dikenal sebagai seorang
antropolog, ahli eugenika, penjelajah, ahli geografi, penemu, ahli
meteorologi, ahli proto-genetika, psikometri, dan statistikawan. Ia
adalah sepupu dari naturalis terkenal, Charles Darwin.

Galton memiliki produktivitas intelektual yang tinggi, menghasilkan
lebih dari 340 makalah dan buku sepanjang hidupnya. Dalam bidang
statistik, ia mengembangkan konsep korelasi dan regresi, serta merupakan
orang pertama yang menerapkan metode statistik untuk mempelajari
perbedaan manusia dan pewarisan kecerdasan. Ia juga memperkenalkan
penggunaan kuesioner dan survei untuk mengumpulkan data tentang
komunitas manusia.

Sebagai seorang penjelajah, Galton melakukan perjalanan ke berbagai
wilayah, termasuk Afrika dan Timur Tengah. Pengalaman ini turut
memengaruhi pandangannya mengenai keragaman manusia. Di bidang
meteorologi, ia merancang peta cuaca pertama dan mengusulkan teori
antisiklon. Galton juga menciptakan “Peluit Galton” yang digunakan untuk
menguji kemampuan pendengaran diferensial.

Meskipun banyak kontribusinya yang diakui, beberapa gagasan Galton,
terutama terkait eugenika (studi tentang bagaimana meningkatkan kualitas
genetik populasi manusia), kini dianggap kontroversial karena berpotensi
menimbulkan diskriminasi. Ia dianugerahi gelar kebangsawanan pada tahun
1909 atas kontribusinya pada ilmu pengetahuan dan meninggal pada 17
Januari 1911.

Warisan Galton dalam dunia ilmiah sangatlah luas, dan penemuannya
mengenai *Crowd Wisdom* tetap menjadi konsep yang relevan dan dipelajari
hingga saat ini dalam berbagai disiplin ilmu, mulai dari ekonomi, ilmu
politik, hingga ilmu komputer.

## Kasus *Bay of Pigs* (Kasus Invasi Teluk Babi)

Invasi Teluk Babi (*Bay of Pigs Invasion*) adalah operasi militer
rahasia yang didukung oleh Amerika Serikat pada April 1961. Tujuannya
adalah untuk menggulingkan pemerintahan komunis Fidel Castro di Kuba.
Operasi ini melibatkan sekitar 1.400 paramiliter Kuba anti-Castro yang
dilatih oleh CIA. Mereka mendarat di Teluk Babi (Bahía de Cochinos) di
pantai selatan Kuba.

Namun, operasi ini berakhir dengan kegagalan total dalam waktu kurang
dari tiga hari. Pasukan invasi dengan cepat dihadapi oleh militer Kuba
yang jauh lebih besar dan lebih siap. Dukungan udara yang dijanjikan
oleh AS tidak terwujud sepenuhnya, dan pemberontakan rakyat yang
diharapkan tidak terjadi. Ratusan anggota brigade tewas, dan lebih dari
seribu lainnya ditangkap. Kegagalan ini menjadi pukulan telak bagi
pemerintahan Presiden John F. Kennedy dan mencoreng reputasi AS di mata
dunia internasional.

Kegagalan telak Invasi Teluk Babi sering kali dijadikan studi kasus
klasik untuk menjelaskan fenomena psikologis yang disebut *groupthink*
(pemikiran kelompok). Konsep ini dipopulerkan oleh psikolog sosial
Irving Janis, yang mempelajari proses pengambilan keputusan yang
mengarah pada bencana.

> *Groupthink* adalah sebuah fenomena di mana sekelompok orang membuat
> keputusan yang irasional atau disfungsional karena adanya tekanan
> kelompok dan keinginan untuk mencapai kesepakatan (konsensus) daripada
> mengevaluasi pilihan secara kritis. Dalam kondisi *groupthink*,
> anggota kelompok cenderung menekan keraguan individu, mengabaikan
> informasi yang bertentangan dengan pandangan mayoritas, dan
> menciptakan ilusi kebulatan suara.

Dalam konteks Invasi Teluk Babi, beberapa ciri *groupthink* terlihat
jelas dalam proses pengambilan keputusan di kalangan penasihat Presiden
Kennedy dan para perencana CIA:

1.  **Ilusi Ketidakrentanan (Illusion of Invulnerability):** Ada
    keyakinan yang berlebihan di antara para perencana bahwa operasi ini
    pasti akan berhasil dan bahwa Kuba tidak akan mampu memberikan
    perlawanan efektif. Mereka meremehkan kekuatan militer Castro dan
    dukungan rakyat terhadapnya.
2.  **Rasionalisasi Kolektif (Collective Rationalization):** Anggota
    kelompok cenderung merasionalisasi keputusan mereka dan mengabaikan
    tanda-tanda peringatan atau keraguan yang muncul. Misalnya, mereka
    mengabaikan laporan intelijen yang menunjukkan bahwa invasi
    diketahui oleh pihak Kuba dan bahwa dukungan lokal terhadap Castro
    kuat.
3.  **Keyakinan pada Moralitas yang Melekat (Belief in Inherent
    Morality):** Ada keyakinan bahwa tujuan mereka menggulingkan Castro
    adalah benar secara moral, yang membuat mereka kurang
    mempertimbangkan implikasi etis dari tindakan mereka.
4.  **Stereotip terhadap Kelompok Luar (Stereotyping Outsiders):** Pihak
    Kuba dan pendukung Castro distereotipkan sebagai lemah, tidak
    terorganisir, dan tidak akan melawan secara efektif. Hal ini
    menghalangi penilaian yang realistis terhadap kemampuan musuh.
5.  **Sensor Diri (Self-Censorship):** Anggota kelompok yang memiliki
    keraguan atau pandangan berbeda cenderung menahan diri untuk
    menyampaikannya agar tidak mengganggu keharmonisan kelompok atau
    dianggap tidak loyal.
6.  **Ilusi Kebulatan Suara (Illusion of Unanimity):** Anggota kelompok
    salah mengira bahwa semua orang dalam kelompok memiliki pandangan
    yang sama karena kurangnya perbedaan pendapat yang diungkapkan
    secara terbuka.
7.  **Tekanan terhadap Perbedaan Pendapat (Pressure on Dissent):**
    Anggota yang menyuarakan keraguan atau kritik mungkin diberi tekanan
    untuk menyesuaikan diri dengan pandangan mayoritas.
8.  **Penjaga Pikiran (*Mindguards*):** Beberapa anggota mungkin
    bertindak sebagai “penjaga pikiran” yang melindungi kelompok dan
    pemimpin dari informasi yang bertentangan atau pandangan yang dapat
    mengganggu konsensus kelompok.

Dalam kasus Invasi Teluk Babi, kombinasi faktor-faktor ini menyebabkan
sekelompok individu yang cerdas dan berpengalaman membuat keputusan yang
sangat buruk dan tidak mempertimbangkan risiko serta alternatif lain
dengan matang. Keinginan untuk mencapai kesepakatan dalam kelompok kecil
penasihat Kennedy, ditambah dengan kerahasiaan operasi dan kurangnya
masukan dari para ahli di luar lingkaran dalam, menciptakan lingkungan
yang kondusif bagi *groupthink*.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
