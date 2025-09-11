---
date: 2025-09-11T17:16:00-04:00
title: "Tutorial R: Bagaimana Ellmer (bisa) Mengubah Cara Saya Bekerja"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Agentic AI
  - GenAI
  - DeepSeek
  - Cuaca
  - Berita
  - Web Scraping
---

Sejak 2017, saya memulai menggunakan **R** dan tak henti-hentinya
mendapatkan momen **AHA** dengan cara menemukan *libraries* atau
*frameworks* yang mengubah sejarah hidup saya. *Lebay ya, hehe*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_1/IMG_1167.png" width="650" />

Belakangan ini, saya mendapatkan momen **AHA** kembali saat mengoprek
`ellmer` di **R**. Keberadaan `ellmer` cukup banyak mengubah cara saya
melakukan *coding* di **R**. Saya pribadi seperti merasa punya *partner*
dalam membuat algoritma dan *codes*. Selain itu, saya sekarang suka
membuat *AI agents* *based on* `ellmer` untuk beberapa *tasks*.

Sebagai contoh, saya membuat [*AI-powered data viz
tools*](https://www.linkedin.com/posts/ikanx_dataviz-shiny-r-activity-7371748198941569024-6UYl?utm_source=share&utm_medium=member_ios&rcm=ACoAAAY-arwBGNEgGLwtDEtTOyOXFvbV_TIWE70)
dengan *framework* seperti ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ellmer/post_1/IMG_1164.png" width="450" />

Pada tulisan ini, saya akan coba *share* beberapa *functions* di
`ellmer` yang saya gunakan sehari-hari. Dari *functions* ini,
rekan-rekan bisa berkreasi sedemikian sehingga pekerjaan sehari-hari
bisa dilakukan dengan lebih cepat, tepat, dan akurat. Saya sudah
mencobanya untuk suatu pekerjaan yang pada tahun lalu membutuhkan waktu
3-4 hari kerja tapi dengan bantuan `ellmer` bisa selesai kurang dari
satu jam saja.

Oh iya, pastikan kalian sudah memiliki `API Key` dari salah satu ***AI
provider*** *ya*. Saya pribadi menggunakan DeepSeek sebagai basis model
saya.

Oke, kita mulai:

## Membuat *object* AI

Jika rekan-rekan membaca tulisan saya terkait [responden
survey](https://ikanx101.com/blog/agen-responden-survey/) dan [anggota
DPR](https://ikanx101.com/blog/agen-DPR/) kemarin, *object* AI
(selanjutnya akan saya sebut sebagai *AI agent*) dibuat berdasarkan
persona tertentu. Persona ini yang disebut dengan *system prompt*.
*System prompt* ini yang sebaiknya kita *inject* di awal kita membuat
*object* AI.

``` r
si_prompt = glue::glue(
  "Kamu adalah asisten yang menjawab pertanyaan sesingkat mungkin."
)

model = "deepseek-chat"

chat = chat_deepseek(system_prompt = si_prompt,
                     model         = model)
```

## *Programming* dengan `ellmer`

*Agent* bernama `chat` ini kemudian akan kita berikan informasi seperti
ini:

``` r
chat$chat("Perkenalkan saya Roberto Hongo dan saya seorang pemain sepak bola asal Brazil.")
```

    Halo, Roberto Hongo. Senang berkenalan dengan pemain sepak bola dari Brazil.

Kemudian kita akan tanya sebagai berikut:

``` r
chat$chat("Siapakah saya?")
```

    Anda adalah Roberto Hongo, pemain sepak bola asal Brazil.

*Agent* telah mengenali saya.

### *Cloning an Agent*

Misalkan kita hendak meng-*cloning* *agent* `chat` yang sudah diberikan
informasi sebelumnya menjadi `chat_2`.

``` r
chat_2 = chat$clone()
```

Sekarang saya akan tanyakan kepada `chat_2` hal sebagai berikut:

``` r
chat_2$chat("apa profesi saya??")
```

    Pemain sepak bola.

### *Resetting an Agent*

Misalkan saya ingin menghilangkan informasi (atau *reset*) dari
`chat_2`, saya lakukan hal berikut ini:

``` r
chat_2$set_turns(list())
chat_2$chat("siapa saya?")
```

    Saya tidak tahu siapa Anda.

Terlihat bahwa `chat_2` sudah tak mengenali informasi sebelumnya.

### Melihat *History* dari *Agent*

Kita bisa menggunakan *function* `get_turns()` untuk melihat *history*
dari suatu *agent*.

``` r
chat$get_turns()
```

    [[1]]
    <Turn: user>
    Perkenalkan saya Roberto Hongo dan saya seorang pemain sepak bola asal Brazil.

    [[2]]
    <Turn: assistant>
    Halo, Roberto Hongo. Senang berkenalan dengan pemain sepak bola dari Brazil.

    [[3]]
    <Turn: user>
    Siapakah saya?

    [[4]]
    <Turn: assistant>
    Anda adalah Roberto Hongo, pemain sepak bola asal Brazil.

``` r
chat_2$get_turns()
```

    [[1]]
    <Turn: user>
    siapa saya?

    [[2]]
    <Turn: assistant>
    Saya tidak tahu siapa Anda.

### Menambahkan *Custom Functions* pada *Agent*

Sebagai sebuah *agent*, sebenarnya `chat` sudah cukup *powerful* untuk
menjawab dan memberikan *assist*. Namun ada saatnya kita perlu
memperkaya *agent* dengan *custom function*.

Beberapa minggu yang lalu, saya membuat sistem RAG sederhana (videonya
bisa dilihat [di
sini](https://youtu.be/WZwdS35iPBA?si=QlhIRKm7QGC69RJG)). Prinsip
*custom function* ini yang dimanfaatkan sedemikian sehingga *agent* bisa
membaca *local source* yang diberikan.

Nah, kali ini saya akan tunjukan satu *custom function* sederhana untuk
mendapatkan informasi cuaca dari situs [*open
weather*](https://ikanx101.com/blog/cuaca-action/). Karena secara
*default* `chat` tidak memiliki informasi cuaca. Misalkan:

``` r
chat$chat("Bagaimana cuaca di Bandung saat ini?")
```

    Saya tidak dapat mengakses informasi cuaca real-time. Untuk mengetahui kondisi 
    terkini di Bandung, silakan cek sumber cuaca terpercaya atau aplikasi seperti 
    BMKG.

Sekarang saya akan buatkan *custom function* untuk mendapatkan cuaca
*realtime* sebagai berikut:

``` r
cuaca_kota = function(city){
  # tempel kota dan api key ke dalam link API
    api = paste0("http://api.openweathermap.org/data/2.5/weather?q=",
                 city,
                 "&appid=",
                 API_key,
                 "&units=metric")
    
    # baca data
    data = fromJSON(api)

    # kita akan buat datanya
    suhu      = data$main$temp
    humidity  = data$main$humidity
    feel_like = data$main$feels_like
    kota      = data$name
    pressure  = data$main$pressure
    wind_spd  = data$wind$speed
    kondisi   = data$weather$main
    kondisi_d = data$weather$description
    
    # kita buat outputnya
    output = data.frame(kota,kondisi,detail_kondisi = kondisi_d,
                        suhu,feel_like,
                        pressure,wind_spd,
                        humidity)

    return(output)
}
```

Kita coba dulu dengan memasukkan **Bandung** sebagai *input*:

``` r
cuaca_kota("Bandung") |> knitr::kable()
```

| kota    | kondisi | detail_kondisi  |  suhu | feel_like | pressure | wind_spd | humidity |
|:--------|:--------|:----------------|------:|----------:|---------:|---------:|---------:|
| Bandung | Clouds  | overcast clouds | 25.03 |     25.91 |     1011 |     1.48 |       89 |

*Function* sudah bekerja, sekarang kita tinggal me-*register*-kan
*function* tersebut *as a tool* kepada *agent* `chat`.

``` r
# membuat as a tool
get_cuaca = tool(
  cuaca_kota,
  name = "cuaca_kota",
  description = "Mendapatkan informasi cuaca real time dari suatu kota",
  arguments = list(
    city = type_string(
      "Nama kota",
      required = T
    )
  )
)

# register ke chat
chat$register_tool(get_cuaca)
```

Sekarang kita akan cek apakah `chat` bisa mengenali cuaca *realtime* di
Bandung saat ini atau tidak.

``` r
chat$chat("Bagaimana cuaca di Bandung saat ini?")
```

    Cuaca di Bandung saat ini:
    - Suhu: 25°C (terasa seperti 26°C)
    - Kondisi: Berawan tebal
    - Kelembaban: 89%
    - Angin: 1.48 m/s
    - Tekanan: 1011 hPa

Kita coba dengan kota lainnya:

``` r
chat$chat("Carikan saya informasi cuaca di Bekasi!")
```

    Cuaca di Bekasi:
    - Suhu: 27°C (terasa seperti 29°C)
    - Kondisi: Berawan tebal
    - Kelembaban: 78%
    - Angin: 2.31 m/s
    - Tekanan: 1010 hPa

#### Membuat *Tools* *Webscrape* untuk *Agent*

Sebagaimana yang saya informasikan sebelumnya: *agent* memang pintar
tapi belum tentu tahu hal-hal yang sifatnya *real time*. Oleh karena
itu, kita harus memasukkan *custom function*.

Sebagai contoh saya akan tanyakan berita kepada *agent*:

``` r
chat$chat("Ada berita apa pada sore hari ini?")
```

    Saya tidak memiliki akses untuk mencari berita terbaru. Untuk informasi berita 
    terkini pada sore hari ini, silakan cek sumber berita terpercaya atau aplikasi 
    berita online.

Kali ini saya akan membuat *function* yang berfungsi untuk mencari
***top 7 updated news*** dari situs detik.com.

``` r
cari_berita = function(){
  berita = url |> read_html() |> html_nodes("a") |> html_text()
  link   = url |> read_html() |> html_nodes("a") |> html_attr("href")

  data.frame(berita,link) |> 
    filter(grepl("news.detik.com/berita",link,fixed = T)) |> 
    mutate(berita = stringr::str_squish(berita)) |> 
    filter(stringr::str_length(berita) > 3) |> 
    head(7) |> 
    pull(berita)
}
```

Berbeda dengan *function* sebelumnya, `cari_berita()` tidak memiliki
*input* sama sekali.

``` r
# membuat as a tool
get_detik = tool(
  cari_berita,
  name = "cari_berita",
  description = "Mendapatkan lima berita terupdate dari situs portal detik.com"
)

# register ke chat
chat$register_tool(get_detik)
```

Sekarang kita akan coba kepada *agent*:

``` r
chat$chat("Ada berita apa pada sore hari ini?")
```

    Berita terbaru hari ini:
    1. Prabowo undang tokoh Gerakan Nurani Bangsa ke Istana
    2. Penculik kacab bank ajukan jadi justice collaborator
    3. Kubu RK tuding cari sensasi soal tes DNA ulang
    4. Eks Wamenaker Noel pakai peci saat diperiksa KPK
    5. Warung di Ciputat diminta 'jatah preman'
    6. Gerindra sebut spekulasi Sara Mundur terlalu jauh
    7. Lisa Mariana menangis dan akui anaknya dari RK

Mari kita coba dengan pertanyaan lain:

``` r
chat$chat("apakah ada berita tentang korupsi sore hari ini?")
```

    Ya, ada berita terkait korupsi:
    - **Eks Wamenaker Noel pakai peci saat diperiksa KPK** (dari berita sebelumnya)
    - **Penculik kacab bank ajukan jadi justice collaborator** - terkait kasus 
    korupsi/kriminal perbankan

    Berita terbaru lainnya lebih fokus pada politik dan infrastruktur.

**Menarik ya hasilnya**.

## *Conclusion*

Dari paparan yang saya buat di atas, *agent* yang saya buat dengan
`ellmer` berpotensi menjadi *one stop solution* untuk meningkatkan
produktivitas tergantung seberapa kreatif kitanya.
