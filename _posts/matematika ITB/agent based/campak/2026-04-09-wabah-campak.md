---
date: 2026-04-09T11:11:00-04:00
title: "Melihat Penyebaran Wabah Campak Melalui Kacamata Data Science dan Agent-Based Modelling"
categories:
  - Blog
tags:
  - Simulasi
  - Wabah
  - Epidemiologi
  - Campak
  - Data
  - Agent Based Modelling
  - ABM
  - SIR
  - Modelling
  - Influenza
---

## Campak Kembali dan Ini Bukan Hal Sepele

Awal 2026, berita tentang wabah campak kembali muncul di berbagai media
Indonesia. Beberapa provinsi melaporkan lonjakan kasus. Banyak di
antaranya menyerang anak-anak yang belum mendapat vaksinasi lengkap.
Padahal, campak adalah penyakit yang sebenarnya sudah sangat bisa
dicegah dengan vaksin yang sudah ada sejak 1960-an.

Sebagai seseorang yang berkecimpung di dunia data, saya jadi
bertanya-tanya:

> *Bagaimana sebenarnya penyakit ini menyebar? Mengapa ia bisa menjadi
> wabah dengan begitu cepat? Dan apa yang angka-angka di balik campak
> ini ceritakan kepada kita?*

Untuk itu, saya akan coba melakukan simulasi untuk memahami dinamika
penyebaran campak secara matematis. Akan ada dua pendekatan yang mau
saya coba, yakni:

1.  Memodelkan dengan [*SIR*](https://ikanx101.com/blog/sir-covid/),
2.  Menggunakan [*Agent Based
    Modelling*](https://ikanx101.com/blog/simple-economy/).

Dari kedua pendekatan tersebut, saya akan melihat seberapa berbahaya
penyebaran campak ini dibandingkan dengan penyakit virus lainnya.

Oh iya, perlu saya tekankan bahwa saya bukan dokter dan tulisan ini
bersifat edukatif. Saya menggunakan data serta parameter yang bersumber
dari literatur epidemiologi. Simulasi yang disajikan adalah
penyederhanaan untuk tujuan pemahaman, bukan model prediksi resmi. Untuk
informasi kesehatan, selalu rujuk ke Kementerian Kesehatan RI dan tenaga
medis profesional.

------------------------------------------------------------------------

## Apa itu campak?

Campak (*Measles*) disebabkan oleh **Measles Morbillivirus**. Virus
tersebut menyebar lewat udara, yakni melalui tetesan pernapasan dan
partikel aerosol yang bisa bertahan di udara sampai dua jam setelah
penderita meninggalkan ruangan. Inilah yang membuatnya sangat berbeda
dari banyak penyakit menular lain. Gejala khasnya:

- Demam tinggi,
- Batuk,
- Pilek,
- Mata merah, dan
- Ruam merah yang menyebar dari wajah ke seluruh tubuh.

Komplikasi yang menyertai campak bisa serius: *pneumonia*, *ensefalitis*
(radang otak), bahkan kematian — terutama pada anak-anak di bawah 5
tahun dengan gizi buruk.

Dalam epidemiologi, kita mengenal angka **R0**. Saya sudah pernah
menjelaskannya pada tulisan [model Covid saya yang pertama
kali](https://ikanx101.com/blog/covid/). **R0** adalah satu angka yang
paling menentukan seberapa ‘berbahaya’ sebuah penyakit. **R0** (dibaca
*R-naught*) bisa kita sebut dengan *basic reproduction number*.

> **R0** adalah rata-rata jumlah orang yang akan tertular dari SATU
> penderita, dalam populasi yang sepenuhnya rentan (belum kebal). R0 \>
> 1 berarti wabah bisa terjadi. Semakin besar R0, semakin agresif
> penyebarannya.

Tabel berikut inilah yang membuat campak luar biasa:

| Penyakit | R0 (estimasi) | Masa infeksius | Berapa persen cakupan vaksin agar tercapai *Herd Immunity* |
|----|----|----|----|
| Campak | 12-18 | ~ 8 hari | ~ 95% |
| Cacar air | 8-10 | ~ 7 hari | ~ 90% |
| Gondongan | 4-7 | ~ 7 hari | ~ 85% |
| Influenza musiman | 2-3 | ~ 5 hari | ~ 50% |
| Covid-19 | 2-3 | ~ 10 hari | ~ 60-70% |
| Ebola | 1.5-2.5 | ~ 10 hari | ~ 50-60% |
| SARS | 2-5 | ~ 10 hari | ~ 50-80% |

Dengan **R0** antara **12 hingga 18**, campak adalah salah satu penyakit
menular paling infeksius yang dikenal manusia. Artinya: satu orang yang
terinfeksi, dalam populasi tanpa imunitas, rata-rata bisa menginfeksi 12
sampai 18 orang lain. Bandingkan dengan influenza yang hanya 2-3.
Implikasi langsungnya sangat mengejutkan: untuk mencapai *herd immunity*
dari campak, setidaknya 95% populasi harus kebal. Kalau cakupan
vaksinasi turun di bawah angka itu karena hoaks, keengganan, atau
kesulitan akses terhadap vaksin maka wabah bisa meledak dengan cepat.

## Mengapa Wabah Bisa Terjadi Meski Vaksin Ada?

Fenomena ini dikenal sebagai *immunity gap*. Selama beberapa tahun
terakhir, cakupan vaksinasi MMR (*Measles*, *Mumps*, dan *Rubella*) di
Indonesia mengalami penurunan, salah satu penyebabnya adalah disrupsi
layanan kesehatan saat pandemi COVID-19 dan meningkatnya gerakan
anti-vaksin di berbagai daerah. Ketika cakupan vaksinasi turun dari 95%
ke, katakanlah menjadi 85% maka ada *gap* 10% populasi yang tiba-tiba
menjadi rentan. Dalam populasi besar seperti Indonesia dengan 280 juta
jiwa, 10% itu berarti 28 juta orang yang tidak terlindungi. Dengan
**R0** campak yang setinggi 12-18, celah sekecil itu sudah cukup untuk
memicu wabah.

# Model SIR: Fondasi Matematika dalam Epidemi

## Memahami Model SIR

Sebelum masuk ke simulasi *Agent Based Modelling*, kita perlu memahami
model SIR. Yakni suatu model yang merupakan fondasi matematis dalam
epidemiologi. Ini adalah model kompartemen klasik yang dikembangkan oleh
Kermack dan McKendrick pada 1927 dan masih menjadi tulang punggung
epidemiologi modern. Dalam Model SIR, setiap individu berada di salah
satu dari tiga kompartemen:

- **S** (*Susceptible*): Rentan yakni kumpulan orang-orang yang belum
  terinfeksi dan belum kebal.
- **I** (*Infectious*): Infeksius yakni kumpulan orang-orang yang sedang
  terinfeksi dan bisa menularkan.
- **R** (*Recovered*): Pulih yakni kumpulan orang-orang yang sudah
  sembuh dan kini kebal, atau meninggal.

Pergerakan antar kompartemen diatur oleh dua parameter utama:

- *Beta* (β): Laju transmisi, yakni seberapa cepat penyakit menyebar
  dari **I** ke **S**.
- *Gamma* (γ): Laju *recovery*, yakni seberapa cepat individu pindah
  dari **I** ke **R**.

Dari kedua parameter ini, kita bisa menghitung **R0 = β / γ**.

## Simulasi Model SIR dengan **R**

Untuk bisa melihat penyebaran penyakit, saya akan membuat *function*
dari model SIR sebagai berikut:

``` r
# ── Fungsi Model SIR deterministik ───────────────────────────────
# Menggunakan persamaan diferensial biasa (ODE) diskret

simulasi_SIR <- function(N,          # Ukuran populasi
                          I0,         # Kasus awal
                          beta,       # Laju transmisi
                          gamma,      # Laju recovery
                          vaksinasi,  # Proporsi yang sudah divaksin (0-1)
                          n_hari = 365) {
  # Populasi awal: yang sudah divaksin langsung masuk R
  S <- N * (1 - vaksinasi) - I0
  I <- I0
  R <- N * vaksinasi

  hasil <- data.frame(
    hari = 0, S = S, I = I, R = R,
    kasus_baru = I0
  )

  for (t in 1:n_hari) {
    # Persamaan SIR diskret
    dS <- -beta * S * I / N
    dI <-  beta * S * I / N - gamma * I
    dR <-  gamma * I

    S <- max(0, S + dS)
    I <- max(0, I + dI)
    R <- R + dR

    hasil <- rbind(hasil, data.frame(
      hari = t, S = S, I = I, R = R,
      kasus_baru = beta * (hasil$S[nrow(hasil)]) * I / N
    ))

    if (I < 0.5) break  # Wabah padam
  }
  hasil
}
```

Berikutnya saya akan membandingkan penyakit campak dengan influenza dan
cacar air. Berikut adalah beberapa parameter dari ketiga penyakit ini
yang kelak akan saya masukkan ke dalam model:

``` r
# ── Parameter penyakit dari literatur ────────────────────────────
#
# Campak: R0 = 15, masa infeksius = 8 hari -> gamma = 1/8
#         beta = R0 * gamma = 15 * (1/8) = 1.875
#
# Cacar Air: R0 = 9, masa infeksius = 7 hari
#
# Influenza: R0 = 2.5, masa infeksius = 5 hari

penyakit <- list(
  Campak = list(
    beta  = 15 * (1/8),   # R0=15, gamma=1/8
    gamma = 1/8,
    R0    = 15,
    warna = '#C0392B'
  ),
  `Cacar Air` = list(
    beta  = 9 * (1/7),    # R0=9, gamma=1/7
    gamma = 1/7,
    R0    = 9,
    warna = '#E67E22'
  ),
  Influenza = list(
    beta  = 2.5 * (1/5),  # R0=2.5, gamma=1/5
    gamma = 1/5,
    R0    = 2.5,
    warna = '#2980B9'
  )
)
```

Saya juga akan membuat kondisi awal sebagai berikut:

1.  Populasi awal: 10.000 orang.
2.  Kasus awal: 5 orang.
3.  Cakupan vaksin: 80% (di bawah angka persentasi *herd immunity*
    campak yang disarankan literatur).

Oke, sekarang saya akan jalankan simulasinya:

``` r
# ── Jalankan SIR untuk ketiga penyakit ───────────────────────────
df_SIR_all <- lapply(names(penyakit), function(nm) {
  p <- penyakit[[nm]]
  sim <- simulasi_SIR(
    N          = N_pop,
    I0         = kasus_awal,
    beta       = p$beta,
    gamma      = p$gamma,
    vaksinasi  = cakupan_vaksin,
    n_hari     = 365
  )
  sim$penyakit <- nm
  sim
}) %>% bind_rows()

# Ringkasan puncak wabah
df_puncak <- df_SIR_all %>%
  group_by(penyakit) %>%
  summarise(
    hari_puncak    = hari[which.max(I)],
    puncak_kasus   = round(max(I)),
    total_terinfeksi = round(max(R) - N_pop * cakupan_vaksin),
    .groups = 'drop'
  )
```

Berikut adalah visualisasi dari simulasi yang telah dijalankan.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent%20based/campak/draft_files/figure-commonmark/unnamed-chunk-6-1.png)

    === RINGKASAN PUNCAK WABAH ===

    # A tibble: 3 × 4
      penyakit  hari_puncak puncak_kasus total_terinfeksi
      <chr>           <dbl>        <dbl>            <dbl>
    1 Cacar Air          50          246             1481
    2 Campak             29          633             1896
    3 Influenza           0            5                9

Analisis data dari ketiga penyakit:

1.  Cacar Air
    - Interpretasi: Penyebaran relatif lambat, mencapai puncak setelah
      50 hari, tetapi memiliki dampak yang cukup signifikan dengan total
      1.481 kasus.
2.  Campak
    - Interpretasi: Penyebaran sangat cepat dan agresif! Mencapai puncak
      hanya dalam 29 hari dengan jumlah kasus puncak tertinggi (633
      orang). Total kasus juga paling tinggi di antara ketiga penyakit.
3.  Influenza
    - Interpretasi: Penyebaran sangat terbatas. Kemungkinan ini
      menunjukkan penyakit dengan tingkat penularan rendah atau populasi
      yang sudah sebagian besar kebal.

# *Agent Based Modelling*: Simulasi yang Lebih Realistis

## Mengapa ABM Lebih Menarik dari SIR Biasa?

Model SIR di atas mengasumsikan populasi yang *perfectly mixed* dimana
setiap orang punya peluang yang sama untuk bertemu orang lain. Di dunia
nyata, ini tidak terjadi. Kita berinteraksi dalam jaringan sosial:
keluarga, tetangga, teman sekolah, rekan kerja. *Agent Based Modelling*
(ABM) mensimulasikan setiap individu sebagai ‘agen’ yang bergerak,
berinteraksi, dan berubah statusnya secara mandiri. Hasilnya jauh lebih
kaya, yakni:

1.  Kita bisa melihat cluster wabah,
2.  Efek jaringan sosial, dan
3.  Bagaimana kebijakan seperti karantina atau vaksinasi massal
    berpengaruh.

> Berbeda dengan model SIR, Dalam ABM “penyakit” tidak dimodelkan secara
> langsung. Yang dimodelkan adalah PERILAKU setiap individu: bergerak,
> berinteraksi, menulari, sembuh. Pola wabah yang muncul adalah hasil
> *emergent* dari interaksi ribuan agen sehingga persis seperti yang
> terjadi di dunia nyata.

## Membangun ABM Campak di **R**

Kita akan membangun ABM sederhana dengan 500 agen yang bergerak di ruang
dua dimensi. Setiap agen mewakili satu individu dengan status **S**,
**I**, atau **R.** Agen bergerak secara acak dan bisa menulari agen lain
yang berada dalam jarak tertentu.

Pertama-tama, saya akan membuat data awal sebagai berikut:

``` r
# ══════════════════════════════════════════════════════════════════
# AGENT-BASED MODEL — Penyebaran Campak
# ══════════════════════════════════════════════════════════════════

# ── Inisialisasi populasi agen ────────────────────────────────────
buat_populasi <- function(n_agen     = 500,
                           pct_vaksin = 0.80,
                           n_infeksi_awal = 5) {
  data.frame(
    id      = 1:n_agen,
    x       = runif(n_agen, 0, 100),   # Posisi x (0-100)
    y       = runif(n_agen, 0, 100),   # Posisi y (0-100)
    # Status: S=Susceptible, I=Infectious, R=Recovered, V=Vaccinated
    status  = c(
      rep('V', round(n_agen * pct_vaksin)),
      rep('I', n_infeksi_awal),
      rep('S', n_agen - round(n_agen * pct_vaksin) - n_infeksi_awal)
    ) %>% sample(),  # Acak posisi status
    hari_infeksi = ifelse(
      sample(c(TRUE, FALSE), n_agen, replace = TRUE,
             prob = c(n_infeksi_awal/n_agen, 1 - n_infeksi_awal/n_agen)),
      0, NA
    ),
    # Kecepatan gerak acak per agen
    vx = rnorm(n_agen, 0, 0.8),
    vy = rnorm(n_agen, 0, 0.8)
  )
}
```

Untuk **sekali langkah** (atau sekali iterasi waktu), saya akan buat
*function* berikut ini:

``` r
# ── Satu langkah simulasi ABM ─────────────────────────────────────
langkah_ABM <- function(pop, hari,
                         radius_infeksi = 3,    # Jarak menular (unit)
                         prob_infeksi   = 0.35, # Prob menular per kontak
                         masa_infeksius = 8) {  # Hari infeksius

  # 1. Gerakkan semua agen (dengan boundary reflection)
  pop$x <- pop$x + pop$vx + rnorm(nrow(pop), 0, 0.3)
  pop$y <- pop$y + pop$vy + rnorm(nrow(pop), 0, 0.3)

  # Pantulkan di batas
  pop$x <- pmax(0, pmin(100, pop$x))
  pop$y <- pmax(0, pmin(100, pop$y))
  pop$vx <- ifelse(pop$x <= 0 | pop$x >= 100, -pop$vx, pop$vx)
  pop$vy <- ifelse(pop$y <= 0 | pop$y >= 100, -pop$vy, pop$vy)

  # 2. Proses penularan: cek agen I ke agen S di sekitarnya
  agen_I <- which(pop$status == 'I')
  agen_S <- which(pop$status == 'S')

  if (length(agen_I) > 0 && length(agen_S) > 0) {
    for (i in agen_I) {
      # Hitung jarak ke semua agen S
      dx <- pop$x[agen_S] - pop$x[i]
      dy <- pop$y[agen_S] - pop$y[i]
      jarak <- sqrt(dx^2 + dy^2)

      # Agen S dalam radius infeksi
      dalam_radius <- agen_S[jarak <= radius_infeksi]

      # Tularkan dengan probabilitas prob_infeksi
      if (length(dalam_radius) > 0) {
        tertular <- dalam_radius[runif(length(dalam_radius)) < prob_infeksi]
        if (length(tertular) > 0) {
          pop$status[tertular]       <- 'I'
          pop$hari_infeksi[tertular] <- hari
        }
      }
    }
  }

  # 3. Recovery: agen I yang sudah melewati masa infeksius
  sudah_waktunya <- !is.na(pop$hari_infeksi) &
                    (hari - pop$hari_infeksi) >= masa_infeksius
  pop$status[pop$status == 'I' & sudah_waktunya] <- 'R'

  pop
}
```

Sekarang saya akan jalankan modelnya untuk 120 hari dan berikut adalah
hasilnya:

## Visualisasi Hasil Simulasi ABM

Plot pertama akan memperlihatkan kurva epidemi antara ketiga penyakit:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent%20based/campak/draft_files/figure-commonmark/unnamed-chunk-10-1.png)

Berikut adalah perbandingan lainnya:


    === PERBANDINGAN HASIL ABM ===

    # A tibble: 3 × 6
      penyakit  puncak_kasus hari_puncak durasi_wabah total_terinfeksi attack_rate
      <chr>            <int>       <int>        <int>            <int>       <dbl>
    1 Cacar Air           11           6          120               36          36
    2 Campak              12           6          120               53          53
    3 Influenza           10           0          120               19          19

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent%20based/campak/draft_files/figure-commonmark/unnamed-chunk-11-1.png)

### Analisa Mendalam tentang Campak

Plot berikutnya akan menampilkan di mana wabah campak terjadi dalam
ruang dua dimensi:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent%20based/campak/draft_files/figure-commonmark/unnamed-chunk-12-1.png)

Plot berikutnya akan menampilkan komposisi populasi sepanjang waktu:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent%20based/campak/draft_files/figure-commonmark/unnamed-chunk-13-1.png)

### Simulasi Intervensi: Apa yang Terjadi Kalau Kita Bertindak?

Model yang kita bentuk di atas bukan hanya bisa digunakan untuk melihat
penyebaran tapi juga untuk menguji pertanyaan:

> *Bagaimana kalau kita melakukan sesuatu?*

Kita akan simulasikan empat skenario vaksinasi berbeda untuk campak.

Berikut adalah perbandingannya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent%20based/campak/draft_files/figure-commonmark/unnamed-chunk-15-1.png)

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/agent%20based/campak/draft_files/figure-commonmark/unnamed-chunk-15-2.png)

Terlihat bahwa perbedaan imunitas komunal membentuk penyebaran yang
berbeda-beda.

## Apa yang Bisa Kita Pelajari dari Simulasi Ini?

- Pelajaran 1: **Campak Bergerak Lebih Cepat dari yang Kita Bayangkan**
  - Dari simulasi ABM, campak mencapai puncak wabah jauh lebih cepat
    dari cacar air atau influenza. Dalam kondisi cakupan vaksin 80%,
    puncak kasus aktif campak muncul dalam hitungan beberapa minggu
    (lebih cepat) dibandingkan influenza yang butuh lebih lama karena
    **R0**-nya lebih rendah.
  - Ini berarti *window of opportunity* untuk intervensi dini sangat
    sempit. Ketika otoritas kesehatan baru menyadari ada klaster wabah,
    boleh jadi sudah ada puluhan atau ratusan kasus baru yang sedang
    dalam masa inkubasi.
- Pelajaran 2: **5% Perbedaan Vaksinasi = Ratusan Nyawa**
  - Dari simulasi skenario intervensi, perbedaan cakupan vaksin 80% vs
    95% menghasilkan perbedaan korban yang sangat signifikan dalam
    populasi kecil 500 orang. Bayangkan skala ini diperbesar ke kota
    dengan 500 ribu atau 5 juta penduduk.
  - Pada 95% vaksinasi (*herd immunity threshold* campak), wabah padam
    sendiri dengan sangat cepat walaupun ada kasus awal. Ini karena
    setiap penderita tidak berhasil menemukan cukup orang rentan untuk
    ditulari. Inilah esensi dari *herd immunity*, yakni melindungi yang
    tidak bisa divaksin (bayi, *immunocompromised*) melalui perlindungan
    kolektif.
- Pelajaran 3: **Pola Spasial Penting**
  - Dari *snapshot* spasial ABM, kita bisa melihat sesuatu yang tidak
    tertangkap oleh model SIR biasa: wabah tidak menyebar merata. Ia
    bermula dari klaster, yakni sekelompok agen rentan yang berdekatan
    kemudian **meledak** dari sana.
  - Di dunia nyata, klaster ini adalah sekolah, pesantren, pasar
    tradisional, atau kampung dengan cakupan vaksin rendah. Inilah
    mengapa surveilans berbasis geografis dan respon cepat di tingkat
    klaster sangat krusial.

## Keterbatasan Model yang Perlu Diingat

1.  Populasi kecil dan homogen. Model ini menggunakan 500 agen di ruang
    dua dimensi yang **homogen**. Populasi nyata ratusan ribu jiwa,
    dengan struktur usia, jaringan sosial, dan kepadatan yang sangat
    beragam.
2.  Tidak ada struktur umur. Campak paling mematikan pada bayi dan
    balita. Model ini tidak membedakan agen berdasarkan umur, sehingga
    tidak menangkap vulnerability yang berbeda per kelompok usia.
3.  Gerak acak vs gerak terstruktur. Manusia tidak bergerak acak. Kita
    pergi ke tempat yang sama berulang kali (rumah, kantor, sekolah).
    Model dengan *network structure* akan lebih realistis tapi jauh
    lebih kompleks.
4.  Parameter dari literatur. Nilai *beta*, *gamma*, dan **R0** yang
    digunakan adalah estimasi dari berbagai studi (**bukan data spesifik
    Indonesia 2026**). Konteks lokal (kepadatan, nutrisi, akses
    kesehatan) bisa mengubah parameter ini secara signifikan.
5.  Tidak ada re-introduksi. Model ini tidak memodelkan kasus impor dari
    daerah lain. Di Indonesia dengan mobilitas antardaerah yang tinggi,
    re-introduksi kasus bisa terus memicu wabah baru.

# *Epilog*

Campak bukan penyakit masa lalu. Penyakit ini masih ada, masih
berbahaya, dan dengan **R0** antara 12-18, penyakit tersebut adalah
salah satu patogen paling agresif yang pernah kita hadapi. Hal yang
membuat frustrasi adalah: kita punya alat untuk mengalahkannya (vaksin
MMR yang sudah terbukti aman dan sudah sangat efektif selama lebih dari
enam dekade) namun cakupan vaksinasinya masih belum maksimal.

Simulasi di atas, walau sederhana tapi bisa menunjukkan dengan jelas
bahwa **perbedaan antara wabah yang meledak dan wabah yang padam sendiri
hanyalah beberapa persen cakupan vaksin**.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
