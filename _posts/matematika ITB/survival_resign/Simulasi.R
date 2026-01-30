rm(list=ls())
gc()

# Persiapan Paket
if(!require(survival)) install.packages("survival")
if(!require(survminer)) install.packages("survminer")
library(survival)
library(survminer)
library(dplyr)
library(janitor)

set.seed(123)
n <- 400

# 2. Membuat Data Simulasi
# Variabel: Masa kerja (bulan), Status Resign (1=Resign, 0=Masih Aktif)
# Covariates: Gaji (High/Low), Departemen (Sales, IT, Ops)
salary <- sample(c("High","Low"), n, replace = TRUE)
dept <- sample(c("Area", "HQ", "Plant"), n, replace = TRUE)
rotation = sample(1:4,n,replace = T,prob = c(.5,.3,.1,.2))
asal = sample(c("Kota","Luar kota"),n,replace = T,prob = c(.7,.3))

# Simulasi hazard: Sales dan Gaji Low punya risiko resign lebih tinggi
# Menggunakan distribusi Weibull untuk memodelkan kegagalan/attrition [20, 21]
linear_pred <- 0.9 * (dept == "Area" & asal == "Kota") + .3 * (rotation >= 3) - 0.5 * (salary == "High")
masa_kerja <- rweibull(n, shape = 1.5, scale = exp(3.5 - linear_pred))

summary(masa_kerja)

# Sensor Administratif: Studi berakhir pada bulan ke-48
status_resign <- ifelse(masa_kerja > 48, 0, 1)
masa_kerja <- pmin(masa_kerja, 48)

tabyl(status_resign)
tabyl(salary)

df_hr <- data.frame(id = 1:n, masa_kerja, status_resign, salary, dept,rotation,asal)

df_hr %>% tabyl(salary,status_resign)

# 3. Membangun Objek Survival [22, 23]
surv_emp <- Surv(time = df_hr$masa_kerja, event = df_hr$status_resign)

# 4. Estimasi Kaplan-Meier (Keseluruhan & Per Gaji) [8, 24]
fit_overall <- survfit(surv_emp ~ 1, data = df_hr)
fit_salary <- survfit(surv_emp ~ salary, data = df_hr)
fit_rotation = survfit(surv_emp ~ rotation, data = df_hr)
fit_asal = survfit(surv_emp ~ asal, data = df_hr)

# Menampilkan Median Masa Kerja [25, 26]
print(fit_overall)
print(fit_salary)
print(fit_rotation)
print(fit_asal)

# 5. Visualisasi Kurva [27-29]
ggsurvplot(fit_salary, data = df_hr, 
           pval = TRUE,             # Menampilkan hasil Log-rank test [30, 31]
           conf.int = TRUE, 
           risk.table = TRUE, 
           xlab = "Bulan Masa Kerja",
           ylab = "Probabilitas Tetap Bertahan",
           title = "Kurva Retensi Karyawan: Gaji Tinggi vs Rendah")

# 6. Regresi Cox untuk Menemukan Faktor Penentu [32-34]
fit_cox <- coxph(surv_emp ~ salary + dept + rotation + asal, data = df_hr)
summary(fit_cox)

save(df_hr,surv_emp,fit_overall,fit_salary,fit_rotation,fit_asal,fit_cox,file = "ready.rda")

# Bagus! Saya bisa melihat model 
# regresi Cox Anda. Mari saya analisis
# kualitas model ini berdasarkan 
# beberapa metrik penting:
#   
#   ## **Evaluasi Model Regresi Cox Anda
#   (`fit_cox`)**
#   
#   ### **1. Signifikansi Statistik 
#   Model**
#   - **Likelihood ratio test**: 93.44 
# dengan 5 derajat kebebasan, p-value 
# < 2.2e-16
# - **Kesimpulan**: Model secara 
# keseluruhan sangat signifikan secara
# statistik (p-value < 0.001)
# 
# ### **2. Koefisien dan Signifikansi 
# Variabel**
#   
#   **Variabel yang signifikan (semua 
#                               p-value < 0.05):**
#   1. **salaryLow** (HR = 2.08, p = 
#                       1.55e-10)
# - Karyawan dengan gaji rendah 
# memiliki risiko keluar 2.08 kali 
# lebih tinggi dibanding gaji tinggi
# - **Sangat signifikan**
#   
#   2. **deptHQ** (HR = 0.44, p = 
#                    1.89e-08)
# - Karyawan di departemen HQ 
# memiliki risiko keluar 56% lebih 
# rendah (1 - 0.44)
# - **Sangat signifikan**
#   
#   3. **deptPlant** (HR = 0.38, p = 
#                       8.03e-12)
# - Karyawan di departemen Plant 
# memiliki risiko keluar 62% lebih 
# rendah
# - **Sangat signifikan**
#   
#   4. **rotation** (HR = 1.28, p = 
#                      0.0023)
# - Setiap peningkatan 1 unit 
# rotation meningkatkan risiko keluar 
# 28%
# - **Signifikan**
#   
#   5. **asalLuar kota** (HR = 0.63, p =
#                           0.0005)
# - Karyawan dari luar kota 
# memiliki risiko keluar 37% lebih 
# rendah
# - **Sangat signifikan**
#   
#   ### **3. Ukuran Sampel dan Event**
#   - **Total observasi (n)**: 400 
# karyawan
# - **Number of events**: 319 (79.75% 
#                              mengalami event keluar)
# - **Rasio events per variabel**: 
#   319/5 = 63.8 events per variabel
# - **Kesimpulan**: Ukuran sampel 
# cukup baik dengan rasio events per 
# variabel yang memadai (>10-20 events
#                        per variabel direkomendasikan)
# 
# ### **4. Asumsi Proportional 
# Hazards**
#   Untuk mengevaluasi lebih lanjut, 
# saya perlu memeriksa asumsi 
# proportional hazards. Bisakah Anda 
# beri tahu:
#   1. Apakah Anda sudah melakukan uji 
# proportional hazards (misal dengan 
#                       `cox.zph()`)?
#   2. Apakah ada interaksi waktu yang 
# perlu dipertimbangkan?
#   
#   ### **5. Goodness of Fit**
#   Untuk mengevaluasi lebih 
# komprehensif, kita bisa melihat:
#   - **Concordance index (C-index)**: 
#   Mengukur kemampuan prediktif model
# - **Calibration plots**: Bagaimana 
# prediksi model sesuai dengan 
# observasi
# - **Residual analysis**: Untuk 
# mendeteksi outliers dan influential 
# observations
# 
# ### **Rekomendasi untuk Evaluasi 
# Lebih Lanjut:**
#   
#   ```r
# # 1. Uji proportional hazards
# library(survival)
# ph_test <- cox.zph(fit_cox)
# print(ph_test)
# plot(ph_test)
# 
# # 2. Hitung concordance index
# concordance(fit_cox)
# 
# # 3. Plot survival curves untuk 
# kelompok tertentu
# # Contoh: untuk kategori gaji
# plot(survfit(fit_cox), 
#      xlab = "Waktu", 
#      ylab = "Survival Probability",
#      main = "Survival Curves by 
# Salary Level")
# 
# # 4. Validasi internal dengan 
# bootstrap
# # (jika paket rms tersedia)
# ```
# 
# ### **Kesimpulan Awal:**
# Model Anda **cukup bagus** 
#   berdasarkan:
#   1. **Semua variabel signifikan** 
#   secara statistik
# 2. **Model keseluruhan sangat 
# signifikan** (p < 0.001)
# 3. **Ukuran efek masuk akal** dan 
# interpretable
# 4. **Ukuran sampel memadai** untuk 
# jumlah variabel
# 
# **Area untuk validasi lebih 
# lanjut:**
#   1. Periksa asumsi proportional 
# hazards
# 2. Evaluasi kemampuan prediktif 
# dengan C-index
# 3. Periksa multicollinearity antar 
# variabel
# 4. Pertimbangkan interaksi jika 
# relevan
# 
# Apakah Anda ingin saya bantu 
# melakukan analisis lebih lanjut 
# untuk poin-poin di atas?








