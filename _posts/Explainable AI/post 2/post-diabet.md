Exploratory Model Analysis: Model Prediksi Diabetes
================

Tulisan ini mengambil tema yang sama terkait *eXplainable Artificial
Intelligence* yang [pernah saya tulis
sebelumnya](https://ikanx101.com/blog/EMA-FIFA/).

Entah kenapa saya selalu merasa bahwa data medis di Indonesia tidak bisa
diakses publik. Padahal menurut saya data tersebut bisa dijadikan bahan
penelitian bersama baik akademisi ataupun praktisi.

Suatu ketika saya sedang menjelajahi situs
[Kaggle](https://www.kaggle.com/) sampai saya menemukan data [***Pima
Indians Diabetes
Database***](https://www.kaggle.com/uciml/pima-indians-diabetes-database).
Berikut adalah deskripsi dari data tersebut:

-----

## *Context*

*This dataset is originally from the National Institute of Diabetes and
Digestive and Kidney Diseases. The objective of the dataset is to
diagnostically predict whether or not a patient has diabetes, based on
certain diagnostic measurements included in the dataset. Several
constraints were placed on the selection of these instances from a
larger database. In particular, all patients here are females at least
21 years old of Pima Indian heritage.*

## *Content*

*The datasets consists of several medical predictor variables and one
target variable, Outcome. Predictor variables includes the number of
pregnancies the patient has had, their BMI, insulin level, age, and so
on.*

-----

Kali ini saya akan mencoba membuat model prediksi berdasarkan data
tersebut kemudian melakukan analisa eksplorasi terhadap model prediksi
tersebut.

> Faktor apa saja yang bisa menjadikan seorang wanita India terkena
> diabetes?

## Data

Berikut adalah struktur *dataset* yang saya gunakan:

    ## 'data.frame':    768 obs. of  9 variables:
    ##  $ pregnancies               : int  6 1 8 1 0 5 3 10 2 8 ...
    ##  $ glucose                   : int  148 85 183 89 137 116 78 115 197 125 ...
    ##  $ blood_pressure            : int  72 66 64 66 40 74 50 0 70 96 ...
    ##  $ skin_thickness            : int  35 29 0 23 35 0 32 0 45 0 ...
    ##  $ insulin                   : int  0 0 0 94 168 0 88 0 543 0 ...
    ##  $ bmi                       : num  33.6 26.6 23.3 28.1 43.1 25.6 31 35.3 30.5 0 ...
    ##  $ diabetes_pedigree_function: num  0.627 0.351 0.672 0.167 2.288 ...
    ##  $ age                       : int  50 31 32 21 33 30 26 29 53 54 ...
    ##  $ outcome                   : int  1 0 1 0 1 0 1 0 1 1 ...

Dari semua *variables* yang ada, saya tidak menggunakan semuanya sebagai
*predictor*. Berikut adalah *variables* yang saya tidak masukkan ke
dalam model yang saya buat:

  - `blood_pressure`,
  - `skin_thickness`, dan
  - `insulin`.

*Target variable* dari model saya adalah `outcome`, yakni:

  - `0` untuk non diabetes.
  - `1` untuk diabetes.

Ternyata setelah saya cek, saya berhadapan dengan *imbalance dataset*.

|   outcome    | freq |
| :----------: | :--: |
|   Diabetes   | 268  |
| Non Diabetes | 500  |
