---
date: 2020-12-07T20:51:00-04:00
title: "Failure Formulas: 3 Case Studies Menarik Seputar Prediksi"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Prediction
  - Modelling
  - Bias
---

# Case 1: *Overfitting the Earthquake*

<img src="https://passingthroughresearcher.files.wordpress.com/2015/06/fukushima-meltdown-prevailing-winds1.jpg" width="60%" style="display: block; margin: auto;" />

Alkisah sebelum membangun reaktor nuklir Fukushima, para ilmuwan di
Jepang mengumpulkan data historikal frekuensi gempa dan kekuatannya
sebagai basis untuk menentukan seberapa kuat pondasi reaktor tersebut
dibangun.

Setelah mengumpukan data – data yang diperlukan, mereka membuat suatu
model sebagai berikut:

    ## [1] "Model A – sumbu X menandakan kekuatan gempa, sumbu Y menandakan frekuensi gempa"

<img src="https://passingthroughresearcher.files.wordpress.com/2015/06/fuku-1.png" width="50%" style="display: block; margin: auto;" />

Dari model yang didapatkan, mereka tampak tidak puas karena menurut
mereka model tersebut tidak fit. masih ada titik – titik yang tidak
dilalui oleh garis model. Oleh karena itu, mereka membuat ulang modelnya
menjadi seperti ini:

    ## [1] "Model B"

<img src="https://passingthroughresearcher.files.wordpress.com/2015/06/fuku-2.png" width="50%" style="display: block; margin: auto;" />

Kali ini, mereka puas dengan model baru. Titik – titik data tampak
sangat fit dengan garis model yang dibentuk.

Berdasarkan model ini, mereka membangun pondasi reaktor Fukushima agar
kuat menghadapi gempa berkekuatan 8 – 8.5 skala Richter. Namun apa yang
terjadi, Maret 2011, Jepang dhantam gempat dahsyat berkekuatan 9 skala
Richter. Akibatnya, reaktor ini jebol. Lalu apa yang salah dengan model
yang dibuat?

Jika kita bandingkan kedua model yang dibuat, model A (yang dianggap
tidak fit) masih memperhitungkan peluang terjadinya gempa berkekuatan 9
skala Richter. Sedangkan model B justru sebaliknya. Peluang terjadinya
gempa berkekuatan 9 skala Richter sangat sedikit sekali.

> Overfit model will score better according to most statistical test. It
> is fitting the noise rather than signal hence it actually worse
> explaining the real world. It is good in paper, but worse in real
> world.

<img src="https://passingthroughresearcher.files.wordpress.com/2015/06/fit.png" width="70%" style="display: block; margin: auto;" />

> Pesan moralnya adalah, seringkali kita mencoba membuat model yang
> sangat fit. Misal dalam regresi, kita selalu mencoba mendapatkan R
> square yang hampir 1. pada kenyataannya, mungkin kita tidak perlu
> sangat sempurna untuk itu.

[Sumber](https://mpra.ub.uni-muenchen.de/69383/1/MPRA_paper_69383.pdf).

-----

# Case 2: *Butterfly Effect*

> The flap of a butterfly’s wings in Brazil can set off a tornado in
> Texas.

<img src="https://passingthroughresearcher.files.wordpress.com/2015/06/bfly.jpg" width="30%" style="display: block; margin: auto;" />

Sudah pernah menonton film **Butterfly Effect**? Alkisah seorang pria
bernama Evan (diperankan oleh Ashton Kutcher) memiliki kemampuan untuk
kembali ke masa lalu. Singkat cerita, sedikit saja perubahan yang ia
lakukan di masa lalu ternyata mengubah total masa depannya.

> In chaos theory, the butterfly effect is the sensitive dependence on
> initial conditions in which a small change in one state of a
> deterministic nonlinear system can result in large differences in a
> later state.

Istilah ini populer setelah matematikawan MIT **Edward Lorenz** (yang
juga seorang meteorologis *US Air Force*) sedang mengembangkan suatu
model *weather forecasting* di tahun 1972.

<img src="https://passingthroughresearcher.files.wordpress.com/2015/06/lorents.png" width="20%" style="display: block; margin: auto;" />

Saat melakukan *first trial*, cuaca di Kansas disebutkan *clear sky*.
Namun pada *second trial*, cuaca di Kansas berubah menjadi
*thunderstorm*.

Saat ditelusuri, ternyata pada saat *first trial*, *engineer* memasukkan
data konstanta `29,5168` pada model.

Sedangkan pada *second trial*, *engineer* memasukkan data konstanta
`29,517`.

Suatu pembulatan yang biasanya kita remehkan (akibat terlalu kecil)
justru mengubah keseluruhan *output* pada model atau sistem. Beruntung
sekarang ini, untuk melakukan perhitungan yang rumit, kita sudah tidak
menggunakan hitungan manual kalkulator dan kertas lagi.

> Pesan moralnya adalah, perhatikan baik – baik data Anda jika bekerja
> pada suatu model. Sekecil apapun perubahan yang ada bisa jadi
> berdampak besar.

-----

# Case 3: *The Role of The Range*

<img src="https://passingthroughresearcher.files.wordpress.com/2015/06/north-dakota.png" width="40%" style="display: block; margin: auto;" />

Gambar di atas adalah kondisi **North Dakota** pada tahun 1997. Sebelum
dan pasca banjir besar yang melanda. Konon katanya banjir terparah sejak
1826.

Apa sebenarnya yang terjadi pada saat itu?

Banjir terjadi karena **Red River Valley** meluap. *National Weather
Forecast* memberikan prediksi bahwa akibat curah hujan pada saat itu,
sungai akan meluap setinggi `49` *feet*. Namun mereka tidak memberikan
informasi bahwa ada range sebesar `+- 9` *feet*.

Oleh karena itu, dibuatlah tanggul setinggi `51` *feet*, `2` *feet*
lebih tinggi dibanding angka yang telah diinformasikan sebelumnya.

<img src="https://passingthroughresearcher.files.wordpress.com/2015/06/banjir.png" width="70%" style="display: block; margin: auto;" />

Ternyata curah hujan pada saat itu mengakibatkan sungai meluap hingga
`54` *feet*. Akibatnya, terjadi banjir yang merendam wilayah tersebut.

<img src="https://passingthroughresearcher.files.wordpress.com/2015/06/north-dakota-lagi.png" width="70%" style="display: block; margin: auto;" />

> Pesan moralnya adalah, komunikasikan dengan jelas prediksi yang kita
> lakukan beserta dengan tingkat kesalahan atau range yang mungkin
> terjadi.


---

> Jika Kamu merasa tulisan ini berguna, dukung selalu blog ini agar bisa terus bertumbuh dengan cara klik iklan selepas Kamu membaca tulisan ini yah.
