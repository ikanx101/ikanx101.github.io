---
date: 2026-05-29T09:40:00-04:00
title: "Apa yang Benar-benar Membuat Tim Menang Premier League?"
categories:
  - Blog
tags:
  - R
  - Premier League
  - Analisis Data
  - Sepakbola
  - ggplot2
  - Data Visualization
  - Football Analytics
  - Sports Science
  - Premier League
  - Arsenal
  - Manchester City
  - Manchester United
  - Liverpool
---

Di kepala saya, entah dari mana datangnya, selalu teringat satu klaim berikut ini: **Jose Mourinho pernah menyatakan bahwa sebuah klub harus mencetak minimal 100 gol dalam satu musim untuk bisa juara Liga Inggris.**

Klaim ini terdengar masuk akal. Mourinho adalah salah satu pelatih yang sukses di Premier League. Kata-katanya punya bobot (namanya juga _the Special One_). Tapi sebagai seseorang yang terbiasa bekerja dengan data, saya punya satu kebiasaan buruk: saya susah menerima sesuatu begitu saja tanpa melihat buktinya.

Jadi saya coba verifikasi, berikut adalah penelusuran saya...

---

## Mourinho dan "100 Gol": Mitos yang Tidak Terbukti

Setelah menelusuri berbagai sumber, termasuk transkrip konferensi pers pertama Mourinho di Chelsea pada 2 Juni 2004, arsip media berbahasa Inggris, Portugis, hingga Spanyol, tidak ada satu pun catatan yang mengkonfirmasi bahwa Mourinho pernah mengucapkan klaim tersebut.

> _Ternyata saya halu... hehe_

Namun ada satu hal yang lebih menarik lagi, jika kita melihat tim Chelsea paling ikonik yang pernah ia latih yaitu musim 2004-05, timnya justru menang liga dengan filosofi yang **berlawanan** dari klaim itu.

| Statistik | Chelsea 2004-05 |
|---|---|
| Gol dicetak | 72 |
| Gol kebobolan | **15** (rekor Premier League, masih bertahan) |
| Clean sheet | 24 |
| Poin | 95 |

Chelsea menang liga bukan karena produktif mencetak gol, tapi karena hampir tidak bisa ditembus. __Tujuh puluh dua gol__ adalah angka yang biasa-biasa saja untuk sebuah tim juara. 

> __TAPI Mencetak 72 gol tapi hanya kebobolan 15 kali dalam 38 pertandingan itu yang luar biasa.__

Klaim "100 gol" kemungkinan besar adalah **mitos yang salah dinisbatkan** kepada Mourinho. Sebuah konsep yang mungkin beredar di komunitas sepakbola lalu melekat pada namanya tanpa sumber yang jelas.

---

## Lalu, Siapa yang Pernah Juara dengan 100+ Gol?

Meski klaim Mourinho tidak terbukti, pertanyaan berikutnya tetap menarik: apakah ada klub yang benar-benar juara _Premier League_ dengan torehan 100 gol atau lebih?

Jawabannya: **ada, tapi tidak banyak.**

Dari seluruh sejarah _Premier League_ sejak musim 1992-93 hingga musim 2025-26, hanya tiga kali sebuah tim juara dengan mencetak 100 gol atau lebih dalam satu musim.

| Musim | Klub | Gol | Manajer |
|---|---|---|---|
| 2009-10 | **Chelsea** | **103** | Carlo Ancelotti |
| 2013-14 | **Manchester City** | **102** | Manuel Pellegrini |
| 2017-18 | **Manchester City** | **106** | Pep Guardiola |

Manchester City musim 2017-18 memegang rekor tertinggi dengan 106 gol sekaligus 100 poin dalam satu musim, yang hingga kini belum pernah diulang oleh siapapun. Sementara itu, ada dua tim yang mencetak 100+ gol tapi **tidak** berhasil juara: Liverpool dengan 101 gol di musim 2013-14 (kalah tipis 2 poin dari City) dan Manchester City sendiri dengan 102 gol di musim 2019-20 (kalah telak 18 poin dari Liverpool).

> __Artinya, 100 gol bukan jaminan juara dan bukan syarat mutlak untuk juara.__

Lalu muncul pertanyaan yang lebih fundamental: **kalau bukan soal 100 gol, apa sebenarnya yang menjadi DNA para juara Premier League?**

---

## Memotret Semua Juara dalam Satu Kanvas

Sebelum masuk ke analisis yang lebih dalam, saya merasa perlu melihat gambaran besarnya terlebih dahulu. Berikut adalah visualisasi gol yang dicetak oleh setiap juara _Premier League_ dari musim 1992-93 hingga 2025-26.

![Gol Juara Premier League Setiap Musim](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post6_arsenal/pl_champions_goals.png)

Dari grafik ini terlihat jelas bahwa sebagian besar juara mencetak gol di kisaran 70 hingga 99 gol per musim. Garis kuning putus-putus di angka 100 menunjukkan betapa jarangnya sebuah tim juara melampaui ambang tersebut.

Dan kemudian ada Arsenal musim 2003-04 dengan label _"Invincibles"_ di sana. Mereka juara tanpa terkalahkan satu kali pun sepanjang musim, dengan torehan 73 gol. Salah satu tim terbaik dalam sejarah sepakbola Inggris meraih gelar dengan angka yang sebenarnya _"biasa saja"_.

---

## Kalau Bukan Gol, Lalu Apa?

Pertanyaan inilah yang kemudian mendorong saya untuk melakukan analisis yang lebih serius. Saya mengumpulkan data _standings_ lengkap semua tim dari 34 musim _Premier League_ melalui Wikipedia, lalu menghitung di mana posisi _ranking_ para juara untuk setiap metrik statistik.

Hasilnya cukup mencerahkan.

![Distribusi Ranking Juara per Metrik](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post6_arsenal/analisis_juara_ranking.png)

Ada satu metrik yang sudah _obvious_, yakni **jumlah kemenangan**. Seluruh 34 juara _Premier League_ sepanjang sejarah, tanpa terkecuali, adalah tim dengan kemenangan terbanyak di musim itu. Tidak ada satu pun pengecualian.

> "Tentu saja ini _obvious_ karena poin adalah produk dari kemenangan. Tapi yang menarik adalah seberapa konsistennya: dari 34 musim, tidak ada satu pun juara yang menang lebih sedikit dari tim lain lalu 'menebusnya' dengan seri."

Sementara untuk metrik lainnya:

| Metrik | Persentase Juara Jadi #1 | Persentase Juara Masuk Top 3 |
|---|---|---|
| Jumlah Kemenangan (W) | **100%** | **100%** |
| Selisih Gol (GD) | 73% | **100%** |
| Gol Dicetak (GF) | 67% | **100%** |
| Gol Kebobolan (GA) | 45% | 85% |

Pola yang muncul sangat konsisten: juara selalu masuk top 3 di tiga metrik pertama. Tapi untuk gol kebobolan, 55% juara ternyata **bukan tim dengan pertahanan terkokoh di musim itu**. Ini berarti juara tidak harus punya pertahanan terbaik, **tapi juara hampir pasti menyerang dengan sangat baik**.

![Timeline Ranking Juara per Musim](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post6_arsenal/analisis_juara_timeline.png)

Grafik _timeline_ di atas memperlihatkan bagaimana garis kemenangan (kuning) hampir tidak pernah turun dari posisi teratas, sementara garis gol kebobolan (biru) bergerak jauh lebih liar ke bawah.

---

## Menggali Lebih Dalam: Faktor yang Tidak Terpikirkan

Setelah menemukan bahwa kemenangan adalah faktor paling absolut, saya penasaran dengan hal-hal lain yang mungkin tersembunyi di balik data. Kali ini saya menyingkirkan faktor menang dan gol dari analisis, dan fokus pada sesuatu yang lebih tidak terduga.

![Ranking Kekalahan dan Seri](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post6_arsenal/faktor_kalah_seri.png)

**Soal kekalahan**, hasilnya sangat kuat: 79% juara adalah tim dengan kekalahan tersedikit di liga, dan 97% masuk top 3. Hampir sama absolutnya dengan faktor kemenangan.

**Soal hasil seri** justru berbeda cerita. Hanya 30% juara yang merupakan tim paling jarang seri. Ini angka yang kecil, tapi ada pola menarik di baliknya.

| | Juara | Rata-rata Tim Liga |
|---|---|---|
| Median jumlah seri | **7 kali** | **10 kali** |

Juara tidak harus paling jarang seri, tapi mereka secara konsisten **mengonversi pertandingan yang biasanya berakhir imbang menjadi kemenangan**. Itu bedanya.

### Kejutan Terbesar: Kekuatan Bermain Tandang

Ini yang paling mengejutkan dari seluruh analisis. Saya tidak menyangka bahwa performa tandang akan menjadi salah satu pembeda paling kuat antara juara dan bukan juara.

![Win Rate Kandang vs Tandang](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post6_arsenal/faktor_home_away.png)

Lihat angka ini:

| | Juara | Rata-rata Tim Liga |
|---|---|---|
| Win rate kandang | **80,5%** | 45,8% |
| Win rate tandang | **59,3%** | 28,7% |

Rata-rata tim _Premier League_ hanya menang 28,7% saat bermain di kandang lawan. Para juara? Hampir 60%. Selisihnya lebih dari dua kali lipat. Lalu ketika saya cek _ranking_ poin tandang para juara, hasilnya juga sangat jelas:

![Ranking Poin Tandang Juara](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post6_arsenal/faktor_away_rank.png)

Sebanyak 73% juara adalah tim dengan poin tandang terbanyak di liga, dan 97% masuk top 3. Ini hampir setara dengan kekuatan faktor kemenangan.

> *Analoginya begini: semua tim bisa tampil baik di depan pendukung sendiri. Tapi hanya tim terbaik yang bisa datang ke kandang lawan, dengan penonton yang memusuhi, dengan tekanan dan atmosfer yang berbeda, dan tetap pulang dengan poin.*

---

## Tentang Poin Gap dan Dominasi

Selain itu, saya juga menganalisis seberapa jauh para juara memimpin dari _runner-up_ setiap musimnya.

![Jarak Poin Juara ke Runner-Up](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post6_arsenal/faktor_poin_gap.png)

Rata-rata juara unggul **7 poin** dari _runner-up_. Tapi rentangnya sangat lebar: 

- Mulai dari 0 poin (musim 2011-12 antara Manchester City dan Manchester United, selesai lewat selisih gol).
- Hingga 19 poin (musim 2017-18, _Guardiola's City_ yang benar-benar mendominasi).

---

## Faktor yang Sering Diabaikan

Setelah membahas statistik pertandingan, saya ingin melihat dua hal lain yang jarang masuk dalam percakapan tentang gelar juara: **apakah juara selalu punya _top scorer_ liga, dan apakah juara selalu punya kiper _clean sheet_ terbanyak?**

Hasilnya cukup mengejutkan untuk yang pertama.

Hanya **17%** dari musim yang ada, juara _Premier League_ memiliki _top scorer_ liga di klubnya. Delapan puluh tiga persen sisanya meraih gelar juara tanpa perlu mengandalkan pencetak gol terbanyak di liga.

Untuk _clean sheet_, angkanya sedikit lebih tinggi: **42%** juara memiliki kiper dengan _clean sheet_ terbanyak. Tapi ini tetap berarti lebih dari separuh juara **tidak** punya penjaga gawang terbaik versi statistik.

Kemudian soal poin total, pertanyaannya: seberapa banyak poin yang dibutuhkan untuk juara?

| | Poin |
|---|---|
| Minimum poin juara | **75** (Manchester United, 1996-97) |
| Median poin juara | **88** |
| Maksimum poin juara | **100** (Manchester City, 2017-18) |

Distribusi ini memberikan gambaran yang realistis: tidak ada formula ajaib, tapi ada ambang batas yang cukup konsisten di kisaran 80-an hingga 90-an poin.

---

## Arsenal 2025-26: Juara yang Berbeda dari Rata-rata

Musim ini Arsenal akhirnya memecah penantian 22 tahun. Sejak terakhir kali juara sebagai _"The Invincibles"_ di 2003-04, _The Gunners_ kembali mengangkat trofi _Premier League_ pada musim 2025-26 dengan catatan 26 menang, 7 seri, 5 kalah dan total 85 poin.

Satu hal yang menarik perhatian saya adalah bagaimana **profil Arsenal sebagai juara ini berbeda dari rata-rata juara historis.**

![Arsenal 2025-26 vs Rata-rata Juara Historis](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post6_arsenal/arsenal_vs_avg_champions.png)

Secara statistik kuantitatif, Arsenal musim ini berada di bawah rata-rata historis di hampir semua metrik.

| Metrik | Rata-rata Juara | Arsenal 2025-26 |
|---|---|---|
| Poin Total | 87,7 | **85** |
| Gol Dicetak (GF) | 82,8 | **78** |
| Gol Kebobolan (GA) | 32,3 | **34** |
| Selisih Gol (GD) | 50,5 | **44** |
| Kemenangan (W) | 26,8 | **26** |
| Kekalahan (L) | 4,3 | **5** |

Menariknya, jika dibandingkan dengan juara Arsenal sebelumnya (_"The Invincibles"_ pada 2003-04), profilnya terlihat sangat kontras.

| Metrik | Arsenal 2003-04 | Arsenal 2025-26 |
|---|---|---|
| Poin | 90 | **85** |
| Menang | 26 | **26** |
| Seri | 12 | **7** |
| Kalah | **0** | 5 |
| Gol Dicetak (GF) | 73 | **78** |
| Gol Kebobolan (GA) | **26** | 34 |
| Selisih Gol (GD) | **47** | 44 |

Dua tim yang sama-sama bernama Arsenal, sama-sama meraih 26 kemenangan, tapi dengan "DNA" yang berbeda. Arsenal 2003-04 adalah benteng yang tak tertembus, tak sekali pun kalah. Arsenal 2025-26 lebih manusiawi dalam hal angka, tapi menemukan cara berbeda untuk menjadi tangguh.

Di atas kertas, Arsenal 2025-26 bukan juara yang paling impresif secara statistik. 85 poin, misalnya, masuk di **53% terbawah** dari semua juara historis _Premier League_. Gol dicetak dan selisih gol juga di bawah rata-rata.

Tapi inilah yang membuat musim ini istimewa. Yang membedakan Arsenal bukan angka-angka di atas, melainkan sesuatu yang lebih sulit diukur.

**David Raya** memenangkan _Golden Glove_ dengan 19 _clean sheet_ dan meraihnya untuk ketiga kali berturut-turut, menyamai rekor __David Seaman__. Arsenal menjadi tim pertama dalam sejarah _Premier League_ yang menjalani satu musim penuh **tanpa satu pun kartu merah**. Yang juga luar biasa, sepanjang 38 pertandingan tidak ada satu pun wasit yang mengacungkan jari ke titik putih melawan Arsenal, artinya tidak ada pelanggaran di kotak penalti sendiri yang berbuah hukuman penalti bagi lawan. Ini bukan soal __Raya__ yang sibuk menggagalkan tendangan penalti, melainkan soal **kedisiplinan taktis seluruh tim** yang begitu ketat sehingga situasi itu bahkan tidak pernah terjadi. Sebuah pencapaian yang juga belum pernah dicatat oleh siapapun dalam sejarah _Premier League_. Kemudian dengan 19 gol dari tendangan sudut, Arsenal memecahkan rekor liga yang sebelumnya berdiri di angka 16.

Arsenal 2025-26 adalah contoh tim yang menang bukan dengan cara yang paling spektakuler, tapi dengan cara yang paling **disiplin**.

Kisah Arsenal ini bukan anomali. Ia justru memperjelas sesuatu yang sudah tersembunyi di balik data selama 34 musim. Tidak ada satu pun profil tunggal seorang juara. Ada yang menang dengan gol banjir seperti City 2017-18. Ada yang menang dengan pertahanan besi seperti Chelsea 2004-05. Ada yang menang tanpa kekalahan seperti Arsenal 2003-04. Dan kini ada yang __menang dengan disiplin tak terlihat__ seperti Arsenal 2025-26. Yang menyatukan mereka bukan caranya, tapi hasilnya: menang lebih banyak, kalah lebih sedikit, dan tampil luar biasa di tempat yang paling susah untuk tampil baik.

---

## Apa yang Benar-benar Membuat Juara Premier League?

Setelah menelusuri data dari 34 musim Premier League, dari verifikasi klaim Mourinho hingga debut Arsenal sebagai juara musim ini, pola yang muncul cukup konsisten.

Para juara _Premier League_ hampir selalu merupakan tim yang paling banyak menang dan paling sedikit kalah. Mereka hampir selalu masuk top 3 dalam hal selisih gol dan gol dicetak. Dan yang paling mengejutkan, mereka hampir selalu menjadi tim terkuat saat bermain di kandang lawan, sebuah indikator ketangguhan mental dan kualitas skuad yang jauh lebih jujur dibandingkan statistik kandang.

Sementara itu, hal-hal yang sering diasosiasikan dengan kehebatan tim, seperti memiliki _top scorer_ liga atau punya pertahanan paling rapat, ternyata bukan prasyarat mutlak.

Arsenal musim 2025-26 membuktikan poin ini dengan sempurna. Mereka juara bukan karena paling produktif, bukan karena paling dominan, tapi karena paling konsisten dalam hal-hal yang tidak terlihat di _highlight reel_: tidak melanggar, tidak kebobolan penalti, menjaga clean sheet, dan menang di tempat-tempat yang paling susah untuk menang.

Kalau boleh saya simpulkan dalam satu kalimat: **menjadi juara Premier League bukan soal menjadi yang paling mencolok di atas kertas, tapi soal menjadi yang paling susah untuk dikalahkan di lapangan manapun.**

Kalau menurut Anda, kira-kira musim depan apakah ada tim yang bisa mematahkan pola ini? Atau mungkin Anda punya metrik lain yang lebih akurat untuk memprediksi juara? Silakan cek data dan skrip-nya, siapa tahu Anda menemukan sesuatu yang saya lewatkan.

---

*Data bersumber dari Wikipedia (standings semua tim, semua musim Premier League 1992-2026), Arsenal.com, dan Premier League official. Seluruh analisis dan visualisasi dibuat menggunakan R dan ggplot2. Data dan skrip tersedia untuk direplikasi.*

---
  
`if you find this article helpful, support this blog by clicking the ads.`
