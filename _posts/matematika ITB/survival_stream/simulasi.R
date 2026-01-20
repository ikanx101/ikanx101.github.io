rm(list=ls())
gc()

library(dplyr)
library(tidyr)

# 1. Persiapan Paket
if(!require(survival)) install.packages("survival")
if(!require(survminer)) install.packages("survminer")
library(survival)
library(survminer)

# 2. Membuat Data Simulasi (100 pelanggan)
set.seed(42)
n <- 100

# Variabel Pendukung (Covariates)
promo <- sample(c("Diskon", "Harga_Normal"), n, replace = TRUE)
komplain <- sample(c("Pernah_Komplain", "Tak_Pernah_Komplain"), n, replace = TRUE,prob = c(.2,.8))
umur <- round(runif(n, 18, 60))
usage <- round(runif(n, 5, 50)) # Jam menonton per bulan

# Simulasi waktu churn (menggunakan distribusi Weibull)
# Risiko churn lebih rendah untuk mereka yang sering menonton dan lebih tua
linear_pred <- -0.5 * (promo == "Diskon") - 0.02 * umur - 0.03 * usage - .2 * (komplain == "Pernah_Komplain")
tenure <- rweibull(n, shape = 1, scale = exp(4 + linear_pred))

# Status: 1 = Churn, 0 = Masih Berlangganan (Tersensor)
# Pelanggan dengan tenure > 24 bulan dianggap masih aktif (admin censoring)
churn <- ifelse(tenure > 24, 0, 1)
tenure <- pmin(tenure, 24)

data_marketing <- data.frame(umur, usage, promo, komplain, tenure, churn)

save(data_marketing,file = "sample_data.rda")

# 3. Membangun Objek Survival [10-12]
surv_obj <- Surv(time = data_marketing$tenure, event = data_marketing$churn)

# 4. Analisis Kaplan-Meier (Visualisasi Churn berdasarkan Promo) [7, 13, 14]
fit_km <- survfit(surv_obj ~ promo, data = data_marketing)

ggsurvplot(fit_km, 
           data = data_marketing,
           pval = TRUE,             # P-value Log-rank test [15, 16]
           conf.int = TRUE, 
           risk.table = TRUE,
           xlab = "Bulan Berlangganan",
           ylab = "Probabilitas Retensi Pelanggan",
           title = "Kurva Retensi: Diskon vs Harga Penuh")

# 5. Regresi Cox untuk Menentukan Faktor Penentu [8, 17, 18]
fit_cox <- coxph(surv_obj ~ promo + umur + usage, data = data_marketing)
summary(fit_cox)

broom::tidy(fit_cox,exponentiate = T)

gtsummary::tbl_regression(fit_cox, exp = TRUE)

