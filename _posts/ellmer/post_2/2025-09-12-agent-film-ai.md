---
date: 2025-09-12T21:51:00-04:00
title: "Mengekstrak Informasi Plot Film Menggunakan AI Agent dari Ellmer (DeepSeek dan OpenAI)"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Agentic AI
  - GenAI
  - DeepSeek
  - Film
  - Superman
  - Web Scraping
---

Tulisan ini masih lanjutan dari tulisan saya sebelumnya tentang
bagaimana `ellmer` bisa [mengubah cara saya
bekerja](https://ikanx101.com/blog/agentic-ellmer/). Kali ini saya akan
memberikan satu tutorial membuat *AI agents* yang bertugas untuk
mengekstrak informasi dari suatu *plot* film. Sebagai contoh, saya akan
menggunakan *plot* film [Superman 2025 yang saya ambil dari halaman
Wikipedia-nya](https://en.wikipedia.org/wiki/Superman_(2025_film)).

Saya akan mencari dua data berikut ini:

1.  Tabel pertama berisi:
    - Karakter utama,
    - Karakter pendukung, dan
    - Rangkuman jalan cerita.
2.  Tabel kedua berisi:
    - Nama karakter, dan
    - Deskripsi kepribadian karakter.

Seperti biasa, saya akan membuat *AI agents* dengan basis **DeepSeek**.

## Tabel Pertama

Saya akan membuat satu *agent* dengan *system prompt* berikut:

\`Kamu adalah extractor AI. User akan memberikan cerita plot dari film.
Berikan informasi dari cerita tersebut berupa:

1.  peran utama: nama tokoh utama dalam film.
2.  peran lain: nama-nama supporting character dalam film. Gunakan koma
    sebagai pembatas.
3.  rangkum: rangkuman jalan cerita film dalam 1 kalimat padat dan
    jelas.

Buat output dalam struktur list terpisah antar ketiga informasi yang
didapatkan.\`

``` r
chat_1 = chat_deepseek(system_prompt = prompt_viz,
                      model          = model_1)
```

Sekarang kita akan lihat hasilnya:

``` r
tbl_1 = chat_1$chat(txt_cerita,echo = "none")
tbl_1
```

    1. peran utama: Clark Kent / Superman
    2. peran lain: Vasil Ghurkos, Angela Spica / The Engineer, Lex Luthor, Lois 
    Lane, Ultraman, Green Lantern, Mister Terrific, Hawkgirl, Metamorpho, Joey, 
    Malik Ali, Jonathan Kent, Martha Kent, Eve Teschmacher, Jimmy Olsen, Kara 
    Zor-El
    3. rangkum: Superman menghadapi konspirasi Lex Luthor yang memanipulasi pesan 
    warisan Kryptoniannya untuk menjatuhkannya, sebelum akhirnya berhasil 
    membongkar rencana jahat Luthor dan memulihkan namanya.

*Nah*, *output* dari **Deepseek** itu masih berupa *character*.
Bagaimana mengubahnya menjadi tabel? Saya akan buat *function* berikut
ini:

``` r
# fungsi yang merapikan
buat_df = function(input){
  data.frame(ket = input) |> 
    separate(ket,
             into = c("utama","support","rangkum"),
             sep = "\\\n") |> 
    mutate(utama = gsub("1. peran utama: ","",utama,fixed = T),
           support = gsub("2. peran lain: ","",support,fixed = T),
           rangkum = gsub("3. rangkum: ","",rangkum,fixed = T))
}
```

``` r
buat_df(tbl_1) |> knitr::kable()
```

| utama | support | rangkum |
|:---|:---|:---|
| Clark Kent / Superman | Vasil Ghurkos, Angela Spica / The Engineer, Lex Luthor, Lois Lane, Ultraman, Green Lantern, Mister Terrific, Hawkgirl, Metamorpho, Joey, Malik Ali, Jonathan Kent, Martha Kent, Eve Teschmacher, Jimmy Olsen, Kara Zor-El | Superman menghadapi konspirasi Lex Luthor yang memanipulasi pesan warisan Kryptoniannya untuk menjatuhkannya, sebelum akhirnya berhasil membongkar rencana jahat Luthor dan memulihkan namanya. |

## Tabel Kedua

Untuk mengekstrak tabel kedua, saya akan buat satu *agent* lagi dengan
*system prompt* sebagai berikut:

\`Kamu ada extractor AI. User akan memberikan plot film. Tugas kamu
adalah memberikan rangkuman informasi berikut ini:

1.  nama karakter = nama-nama karakter yang ada pada plot.
2.  kepribadian = kepribadian karakter tersebut yang dijelaskan dalam
    satu kalimat.

buat output dalam bentuk list.\`

``` r
chat_2 = chat_deepseek(system_prompt = sis_prom,
                       model          = model_1)
```

Berikut adalah hasilnya:

``` r
tbl_2 = chat_2$chat(txt_cerita,echo = "none")
tbl_2
```

    [
      {"nama karakter": "Clark Kent / Superman", "kepribadian": "Pahlawan yang 
    berprinsip dan berbelas kasih, selalu berjuang untuk melindungi manusia 
    meskipun menghadapi pengkhianatan dan keraguan diri."},
      {"nama karakter": "Vasil Ghurkos", "kepribadian": "Pemimpin Boravia yang 
    agresif dan ekspansionis, bersedia menyerang negara tetangga untuk kepentingan 
    nasional."},
      {"nama karakter": "Krypto", "kepribadian": "Anjing super setia yang selalu 
    mendukung dan melindungi Superman dalam situasi berbahaya."},
      {"nama karakter": "Angela Spica / The Engineer", "kepribadian": "Sekutu Lex 
    Luthor yang cerdas dan teknologis, menggunakan kemampuannya untuk tujuan 
    jahat."},
      {"nama karakter": "Lex Luthor", "kepribadian": "Billionaire licik dan 
    manipulatif yang didorong oleh kecemburuan terhadap Superman dan keinginan 
    untuk kekuasaan."},
      {"nama karakter": "Jor-El dan Lara Lor-Van", "kepribadian": "Orang tua 
    Kryptonian Superman yang awalnya bermaksud menyelamatkannya tetapi memiliki 
    rencana tersembunyi untuk penaklukan Bumi."},
      {"nama karakter": "Lois Lane", "kepribadian": "Wartawan pemberani dan penuh 
    integritas yang mendukung Superman secara emosional dan profesional."},
      {"nama karakter": "Green Lantern", "kepribadian": "Pahlawan yang bertindak 
    sebagai bagian dari tim, membantu melindungi masyarakat dari ancaman."},
      {"nama karakter": "Mister Terrific", "kepribadian": "Pahlawan pragmatis yang 
    terkadang mengambil keputusan keras untuk kebaikan yang lebih besar."},
      {"nama karakter": "Hawkgirl", "kepribadian": "Pahlawan tegas yang tidak ragu 
    untuk menggunakan kekuatan mematikan ketika diperlukan."},
      {"nama karakter": "Metamorpho", "kepribadian": "Individu dengan kemampuan 
    metamorfosis yang awalnya dipaksa bekerja untuk Luthor tetapi akhirnya memilih 
    sisi baik untuk menyelamatkan anaknya."},
      {"nama karakter": "Joey", "kepribadian": "Bayi yang tidak bersalah digunakan 
    sebagai alat tekanan oleh Luthor terhadap Metamorpho."},
      {"nama karakter": "Malik Ali", "kepribadian": "Pendukung Superman yang 
    menjadi korban kekejaman Luthor selama interogasi."},
      {"nama karakter": "Jonathan dan Martha Kent", "kepribadian": "Orang tua 
    angkat Superman yang penuh kasih dan kebijaksanaan, selalu mengingatkannya 
    tentang nilai-nilai kemanusiaan."},
      {"nama karakter": "Eve Teschmacher", "kepribadian": "Kekasih Luthor yang 
    akhirnya berbalik melawannya karena ketertarikan pada Jimmy Olsen dan hati 
    nurani."},
      {"nama karakter": "Jimmy Olsen", "kepribadian": "Fotografer Daily Planet yang
    membantu mengungkap kebenaran dengan keberanian dan ketekunan."},
      {"nama karakter": "Ultraman", "kepribadian": "Kloning Superman yang 
    diciptakan oleh Luthor, digunakan sebagai senjata untuk melawan dan meniru 
    pahlawan asli."},
      {"nama karakter": "Kara Zor-El", "kepribadian": "Sepupu Superman dari Krypton
    yang memiliki kepribadian santai dan sedikit tidak bertanggung jawab, terlihat 
    dari kedatangannya yang mabuk."}
    ]

Format *output* yang dihasilkan masih sangat jelek. Oleh karena itu saya
akan rapikan menjadi seperti ini:

``` r
data.frame(all = tbl_2) |> 
  separate_rows(all,sep = "\\\n") |> 
  separate(all,
           into = c("a1","a2","a3","a4"),
           sep = "\\:") |> 
  select(a2,a3) |> 
  mutate(a2 = gsub('", "kepribadian"','',a2,fixed = T),
         a2 = gsub('\\"','',a2),
         a3 = gsub('\\"','',a3),
         a3 = gsub("},","",a3)) |> 
  filter(!is.na(a2)) |> 
  mutate(a2 = stringr::str_squish(a2),
         a3 = stringr::str_squish(a3)) |> 
  rename(karakter = a2,
         kepribadian = a3) |> 
  knitr::kable()
```

| karakter | kepribadian |
|:---|:---|
| Clark Kent / Superman | Pahlawan yang berprinsip dan berbelas kasih, selalu berjuang untuk melindungi manusia meskipun menghadapi pengkhianatan dan keraguan diri. |
| Vasil Ghurkos | Pemimpin Boravia yang agresif dan ekspansionis, bersedia menyerang negara tetangga untuk kepentingan nasional. |
| Krypto | Anjing super setia yang selalu mendukung dan melindungi Superman dalam situasi berbahaya. |
| Angela Spica / The Engineer | Sekutu Lex Luthor yang cerdas dan teknologis, menggunakan kemampuannya untuk tujuan jahat. |
| Lex Luthor | Billionaire licik dan manipulatif yang didorong oleh kecemburuan terhadap Superman dan keinginan untuk kekuasaan. |
| Jor-El dan Lara Lor-Van | Orang tua Kryptonian Superman yang awalnya bermaksud menyelamatkannya tetapi memiliki rencana tersembunyi untuk penaklukan Bumi. |
| Lois Lane | Wartawan pemberani dan penuh integritas yang mendukung Superman secara emosional dan profesional. |
| Green Lantern | Pahlawan yang bertindak sebagai bagian dari tim, membantu melindungi masyarakat dari ancaman. |
| Mister Terrific | Pahlawan pragmatis yang terkadang mengambil keputusan keras untuk kebaikan yang lebih besar. |
| Hawkgirl | Pahlawan tegas yang tidak ragu untuk menggunakan kekuatan mematikan ketika diperlukan. |
| Metamorpho | Individu dengan kemampuan metamorfosis yang awalnya dipaksa bekerja untuk Luthor tetapi akhirnya memilih sisi baik untuk menyelamatkan anaknya. |
| Joey | Bayi yang tidak bersalah digunakan sebagai alat tekanan oleh Luthor terhadap Metamorpho. |
| Malik Ali | Pendukung Superman yang menjadi korban kekejaman Luthor selama interogasi. |
| Jonathan dan Martha Kent | Orang tua angkat Superman yang penuh kasih dan kebijaksanaan, selalu mengingatkannya tentang nilai-nilai kemanusiaan. |
| Eve Teschmacher | Kekasih Luthor yang akhirnya berbalik melawannya karena ketertarikan pada Jimmy Olsen dan hati nurani. |
| Jimmy Olsen | Fotografer Daily Planet yang membantu mengungkap kebenaran dengan keberanian dan ketekunan. |
| Ultraman | Kloning Superman yang diciptakan oleh Luthor, digunakan sebagai senjata untuk melawan dan meniru pahlawan asli. |
| Kara Zor-El | Sepupu Superman dari Krypton yang memiliki kepribadian santai dan sedikit tidak bertanggung jawab, terlihat dari kedatangannya yang mabuk.} |

Bagaimana hasilnya? Cukup bagus dan tepat *yah*. Sebagai informasi, data
ini didapatkan dalam waktu *under 30 seconds*.

## *Bonus part: AI Agents* Menggunakan OpenAI

Jika pada skrip di atas, saya membuat *agent based on* **DeepSeek**.
Maka kali ini saya akan membuat *agents* berbasis **OpenAI**. Lantas apa
perbedaannya? Pada **OpenAI**, kita bisa melakukan ekstraksi data ke
dalam bentuk *data frame* dengan sangat mudah.

Saya mulai dengan membuat *agent* berikut:

``` r
# pake open ai itu bisa langsung otomatis
prompt_viz =
  stringr::str_squish("Kamu adalah extractor AI.
                      User akan memberikan cerita plot dari film.
                      Berikan informasi dari cerita tersebut menggunakan bahasa Indonesia
                      ")
chat_2 = chat_openai(system_prompt = prompt_viz)
```

### Tabel Pertama

Berikut adalah hasil untuk tabel pertama:

``` r
output_struktur = type_object(
  peran_utama = type_string(description = "Nama tokoh utama"),
  peran_support = type_string(description = "Nama-nama supporting character, gunakan koma sebagai pembatas"),
  cerita = type_string(description = "rangkuman jalan cerita film dalam 1 kalimat padat dan jelas.")
)

tes_2 = chat_2$chat_structured(txt_cerita,type = output_struktur)

tes_2 |> as_tibble() |> knitr::kable()
```

| peran_utama | peran_support | cerita |
|:---|:---|:---|
| Clark Kent / Superman | Krypto, Angela Spica / The Engineer, Lex Luthor, Lois Lane, Ultraman, Mister Terrific, Green Lantern, Hawkgirl, Metamorpho, Malik Ali, Joey (anak Metamorpho), Jonathan Kent, Martha Kent, Eve Teschmacher, Jimmy Olsen, Vasil Ghurkos, Kara Zor-El | Superman menghadapi ancaman politik dan metahuman ketika Lex Luthor mencoba menjatuhkan reputasinya dengan menuduhnya sebagai penakluk, hingga akhirnya kebenaran terungkap, Luthor dikalahkan, dan nama Superman dipulihkan. |

### Tabel Kedua

Berikut adalah hasil tabel kedua:

``` r
tabel_2_struktur = type_object(
  nama_karakter = type_string(description = "nama-nama karakter yang ada pada plot cerita film"),
  kepribadian = type_string(description = "kepribadian karakter tersebut yang dijelaskan dalam satu kalimat")
)

tes_3 = chat_2$chat_structured(txt_cerita,
                               type = type_array(items = tabel_2_struktur))

tes_3 |> as_tibble() |> knitr::kable()
```

| nama_karakter | kepribadian |
|:---|:---|
| Clark Kent / Superman | Berjiwa kepahlawanan, penuh konflik moral, sangat peduli terhadap manusia, namun terkadang mudah terpancing emosinya dan mengalami krisis identitas. |
| Lois Lane | Cerdas, kritis, penuh kasih, setia, dan tidak ragu bertanya mengenai aspek etika dan hukum. |
| Lex Luthor | Manipulatif, ambisius, sangat cerdas, punya rasa iri kuat terhadap Superman, dan rela melakukan apapun demi tujuannya. |
| Krypto | Setia, berani, serta sangat berbakti pada Superman. |
| Angela Spica / The Engineer | Cerdik, loyal pada Luthor, punya kemampuan teknis tinggi, dan sangat pragmatis. |
| Jor-El dan Lara Lor-Van | Orangtua yang penyayang, berwawasan jauh ke depan, namun pesan mereka pada Superman bisa disalahartikan. |
| Ultraman | Kejam, kuat, mudah disetir, dan merupakan hasil manipulasi. |
| Vasil Ghurkos | Pemimpin otoriter dan agresif yang haus kekuasaan. |
| Mister Terrific | Rasional, tegas, cerdas, dan rela melakukan tindakan ekstrem demi kebaikan yang lebih besar. |
| Green Lantern | Pemberani, tegas, dan mau bekerja dalam tim demi keadilan. |
| Hawkgirl | Tegas, berani, dan mampu mengambil keputusan sulit. |
| Metamorpho | Loyal, berjuang demi keluarga, dan berani berkorban. |
| Joey (anak Metamorpho) | Masih bayi, tidak banyak berperan, menjadi motivasi ayahnya. |
| Malik Ali | Setia mendukung Superman, menjadi korban akibat kesetiaannya. |
| Jonathan dan Martha Kent | Penuh kasih, mendidik dan memberi moral yang kuat pada Superman. |
| Eve Teschmacher | Cinta buta pada Jimmy Olsen, awalnya setia pada Luthor tapi akhirnya berani mengkhianati demi kebenaran. |
| Jimmy Olsen | Loyal, penasaran, dan sangat setia pada kebenaran serta teman-temannya. |
| Kara Zor-El | Santai, kadang sembrono, dan punya hubungan dekat dengan Superman. |

# *Conclusion*

- *AI agents* bisa digunakan untuk mengubah *unstructured data* menjadi
  *structured data*.
- *AI agents* dengan basis **OpenAI** memiliki *function* yang berfungsi
  langsung untuk mengambil struktur dalam data dibandingkan **DeepSeek**
  yang harus dibuat sendiri *function*-nya.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
