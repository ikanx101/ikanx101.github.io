# Langkah 1: Memuat Library yang Dibutuhkan
library(dplyr)      # Untuk manipulasi data yang lebih mudah
library(caret)      # Untuk one-hot encoding dan pemrosesan data
library(ggplot2)    # Untuk visualisasi (opsional)

rm(list=ls())
gc()

load("data_survey.rda")

prediktor_kategorik <- c("gender", "ses","usia")

# Langkah 4: Melakukan One-Hot Encoding
# Menggunakan fungsi dummyVars dari package 'caret'
dmy <- dummyVars(" ~ gender + ses + usia", data = df_survey)
data_encoded <- data.frame(predict(dmy, newdata = df_survey))

# Menggabungkan kembali dengan kolom numerik dan variabel respons
data_final <- data_encoded %>% mutate(aware = df_survey$aware,
                                      aware = ifelse(aware == "ya",1,0))


# Langkah 5: Melakukan Regresi Logistik
# Formula untuk regresi logistik
formula_regresi <- aware ~ . - genderWanita - sesUp - usia26...30.th# '.' berarti semua prediktor lainnya

# Melatih model regresi logistik
model_logistik <- glm(formula = formula_regresi, data = data_final, family = "binomial")

# Menampilkan ringkasan model
summary(model_logistik)

save(model_logistik,file = "model.rda")

# Apa itu multikolinearitas? Multikolinearitas terjadi ketika ada hubungan linier yang kuat antara dua atau lebih prediktor dalam model Anda. Multikolinearitas sempurna adalah kasus ekstrem di mana satu prediktor dapat diprediksi secara sempurna dari prediktor lain (atau kombinasi prediktor lain).
# Bagaimana kaitannya dengan one-hot encoding? Ketika Anda melakukan one-hot encoding untuk variabel kategorik, Anda menciptakan beberapa kolom baru (variabel dummy). Jika Anda tidak berhati-hati, Anda dapat memperkenalkan multikolinearitas sempurna.
# Contoh: Misalkan Anda memiliki variabel kategorik "Warna" dengan kategori "Merah", "Biru", dan "Hijau". Jika Anda melakukan one-hot encoding dan membuat variabel dummy untuk setiap kategori (misalnya, Warna_Biru, Warna_Hijau, Warna_Merah), dan Anda juga menyertakan intercept dalam model regresi Anda, Anda akan mengalami multikolinearitas sempurna. Ini karena, untuk setiap observasi, jika Warna_Biru=0 dan Warna_Hijau=0, maka secara otomatis Warna_Merah=1 (jika diasumsikan hanya ada tiga warna tersebut), atau sebaliknya, jumlah dari variabel dummy ini akan selalu konstan (atau dapat diprediksi dari intercept). Dengan kata lain, salah satu variabel dummy menjadi redundant atau dapat diprediksi dari yang lain dan intercept.