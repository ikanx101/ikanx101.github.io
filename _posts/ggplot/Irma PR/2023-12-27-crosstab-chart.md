---
date: 2023-12-27T12:00:00-04:00
title: "Tutorial Visualisasi di R: Membuat Grafik Cross Tabulasi Sederhana dengan ggplot2"
categories:
  - Blog
tags:
  - ggplot2
  - Cross Tabulasi
  - Cross Tabulasi Chart
  - R
  - Machine Learning
  - Artificial Intelligence
  - Data Viz
---

Beberapa waktu yang lalu, salah seorang rekan saya yang sedang menempuh
studi *Master Overseas* di bidang MBA yang bersinggungan dengan data
menghubungi saya untuk berdiskusi. Salah satu tugas kuliahnya adalah
membuat model prediksi dari data *HR Employee Attrition*. *Dataset*-nya
bisa rekan-rekan dapatkan di situs *Kaggle* karena merupakan data yang
lazim digunakan di berbagai universitas sebagai bahan pembahasan.

Singkat cerita, tidak ada masalah yang berarti bagi rekan saya tersebut
dalam membuat model prediksinya.

> *Jujurly*, memang membuat model prediksi berbasis *machine learning*
> dengan **R** atau **Py** memang tidak terlalu sulit.

Namun ada satu ganjalan yang rekan saya hadapi yakni membuat visualisasi
dari cross tabulasi data tersebut.

> Visualisasi data jauh justru lebih menantang dibandingkan membuat
> model prediksi berbasis *machine learning*!

Menurut Saya.

------------------------------------------------------------------------

## Crosstabulasi

Berikut adalah data crosstabulasi yang dimaksud:

| job_role                  | Attrition: No | Attrition: Yes |
|:--------------------------|:--------------|:---------------|
| Healthcare Representative | 93.13%        | 6.87%          |
| Human Resources           | 76.92%        | 23.08%         |
| Laboratory Technician     | 76.06%        | 23.94%         |
| Manager                   | 95.1%         | 4.9%           |
| Manufacturing Director    | 93.1%         | 6.9%           |
| Research Director         | 97.5%         | 2.5%           |
| Research Scientist        | 83.9%         | 16.1%          |
| Sales Executive           | 82.52%        | 17.48%         |
| Sales Representative      | 60.24%        | 39.76%         |

Agar data tersebut bisa dijadikan grafik dengan `ggplot2`, kita ubah
dulu bentuknya menjadi sebagai berikut:

| job_role                  | attrition | persen | label  |
|:--------------------------|:----------|-------:|:-------|
| Healthcare Representative | No        | -93.13 | 93.13% |
| Healthcare Representative | Yes       |   6.87 | 6.87%  |
| Human Resources           | No        | -76.92 | 76.92% |
| Human Resources           | Yes       |  23.08 | 23.08% |
| Laboratory Technician     | No        | -76.06 | 76.06% |
| Laboratory Technician     | Yes       |  23.94 | 23.94% |
| Manager                   | No        | -95.10 | 95.1%  |
| Manager                   | Yes       |   4.90 | 4.9%   |
| Manufacturing Director    | No        | -93.10 | 93.1%  |
| Manufacturing Director    | Yes       |   6.90 | 6.9%   |
| Research Director         | No        | -97.50 | 97.5%  |
| Research Director         | Yes       |   2.50 | 2.5%   |
| Research Scientist        | No        | -83.90 | 83.9%  |
| Research Scientist        | Yes       |  16.10 | 16.1%  |
| Sales Executive           | No        | -82.52 | 82.52% |
| Sales Executive           | Yes       |  17.48 | 17.48% |
| Sales Representative      | No        | -60.24 | 60.24% |
| Sales Representative      | Yes       |  39.76 | 39.76% |

Jika diperhatikan bentuk `data.frame`-nya menjadi *tabular*. Saya
asumsikan kalian bisa mengubah bentuk `data.frame` tersebut. Perhatikan
bahwa variabel `persen` saya buat berlawanan tanda (positif dan negatif)
agar bisa disandingkan sedemikian rupa pada grafiknya kelak per
`job_role`.

Untuk membuat visualisasi dan mengubah bentuk tabular saya menggunakan
`library(dplyr)` dan `library(ggplot2)`.

Berikut adalah skrip yang sudah saya beri komentar untuk membuat
visualisasinya:

``` r
# kita panggil data cross tabulasi tabularnya
cross %>% 
  # kita buat object ggplotnya
  # definisikan axis x dan y-nya apa
  ggplot(aes(x = job_role,
             y = persen)) +
  # kita buat grafik dalam bentuk bar
  # definisikan warna garis dan warna isi bar-nya 
  geom_col(color = "black",
           aes(fill = attrition)) +
  # kita putar axis x dan y-nya
  coord_flip() +
  # berikan label pada masing-masing bar
  geom_label(aes(label = label)) +
  # kita pilih theme minimal
  # silakan ganti theme sesuai dengan keinginan
  theme_minimal() +
  # berikan title untuk masing-masing object pada grafik
  labs(title = "Attrition by Job Role",
       subtitle = "Data source: Kaggle.com",
       caption = "Created using R\nikanx101.com",
       y = "Job Role",
       x = "Percentage",
       fill = "Attrition types") +
  # kita hapus tulisan di axis x
  theme(axis.text.x = element_blank()) +
  # kita perluas range agar tidak ada label yang terpotong
  ylim(-110,50)
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ggplot/Irma%20PR/post_files/figure-gfm/unnamed-chunk-3-1.png" width="672" style="display: block; margin: auto;" />

Sekian, mudah kan?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
