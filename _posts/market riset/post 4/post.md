Tutorial: Membandingkan Dua Data Kategorik dengan Uji Beda Proporsi
================

# Pendahuluan

Beberapa waktu yang lalu, saya sempat menjelaskan mengenai jenis-jenis
data di tulisan berikut ini. Kalau kita perhatikan dengan seksama, uji
hipotesis seperti *annova*, uji *t*, uji *z*, korelasi, dan regresi
digunakan untuk menyelesaikan permasalahan dengan data bertipe numerik
(kuantitatif).

> Bagaimana jika data yang kita miliki adalah data kategorik
> (kualitatif)?

Sebenarnya ada satu metode statistik yang jarang banget dibicarakan
terkait data kategorik, yaitu **uji beda dua proporsi**.

-----

## Aplikasinya di *Market Research*

Bagi saya seorang *market researcher*, **uji beda dua proporsi** adalah
salah satu uji statistik yang **paling sering digunakan**. Hampir bisa
dipastikan bahwa dalam satu *slide* berisi grafik di *market research
report* berisi setidaknya satu pengujian beda dua proporsi. Biar *gak*
bingung, saya akan jelaskan dengan contoh sebagai berikut:

### Contoh

Suatu perusahaan FMCG hendak mengiklankan produknya di TV. Untuk
mengetahui di stasiun TV mana mereka harus beriklan, mereka melakukan
survey kepada *target market*-nya. Didapatkan data sebagai berikut:

  - 45 orang dari 100 orang *target market* menonton stasiun TV ABC.
  - 60 orang dari 125 orang *target market* menonton stasiun TV XYZ.

Di manakah perusahaan tersebut harus beriklan?

### Jawab

Data di atas sejatinya adalah data berbentuk kategorik (berisi hanya
jawaban `YA` atau `TIDAK`) untuk masing-masing stasiun TV.

| stasiun | nonton | n  |
| :-----: | :----: | :-: |
|   ABC   |   Ya   | 45 |
|   ABC   | Tidak  | 55 |
|   XYZ   |   Ya   | 60 |
|   XYZ   | Tidak  | 65 |
