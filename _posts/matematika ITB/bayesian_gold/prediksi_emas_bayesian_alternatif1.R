# ALTERNATIF 1: BAYESIAN STRUCTURAL TIME SERIES (BSTS)
# Menggunakan model state-space untuk time series

setwd("~/ikanx101.github.io/_posts/matematika ITB/bayesian_gold")

rm(list=ls())
gc()

library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(readxl)

# kita ambil datanya
file = "harga_emas_bullion_rates_IDR_6bulan.xlsx"
df =
  read_excel(file) |>
  janitor::clean_names() |>
  rename(date = tanggal, price = harga_gram_idr) |>
  select(date, price)

# Persiapan data
df_clean <- df %>%
  mutate(
    date = as.Date(date),
    day_num = as.numeric(date - min(date)),
    log_price = log(price)
  )

# Konversi ke time series object
price_ts <- ts(df_clean$price, frequency = 7)  # Asumsi weekly pattern

# Model Bayesian Structural Time Series dengan bsts
if (!require("bsts")) {
  install.packages("bsts")
  library(bsts)
}

# Spesifikasi model dengan komponen:
# - Local level trend
# - Seasonal component (weekly)
# - Regression component
ss <- list()
ss <- AddLocalLevel(ss, price_ts)
ss <- AddSeasonal(ss, price_ts, nseasons = 7)

# Fitting model Bayesian
set.seed(123)
bsts_model <- bsts(price_ts,
                   state.specification = ss,
                   niter = 3000,
                   ping = 1000,
                   seed = 10104074)

# Prediksi 7 hari ke depan
horizon <- 7
bsts_pred <- predict(bsts_model, horizon = horizon, burn = 1000)

# Ringkasan prediksi
prediction_summary <- data.frame(
  Day = 1:horizon,
  Predicted_Date = max(df_clean$date) + 1:horizon,
  Mean_Price = bsts_pred$mean,
  Median_Price = bsts_pred$median,
  Lower_95 = bsts_pred$interval[1,],
  Upper_95 = bsts_pred$interval[2,]
)

save(bsts_pred,
     prediction_summary,
     bsts_model,
     file = "for_blog.rda")

# Visualisasi
plot(bsts_model, main = "Bayesian Structural Time Series - Komponen Model")
plot(bsts_pred, main = "Prediksi 7 Hari ke Depan")

# Simpan hasil
# write.csv(prediction_summary, "prediksi_bsts_emas.csv", row.names = FALSE)

cat("=== PREDIKSI BSTS SELESAI ===\n")
print(prediction_summary)

# Diagnostik model
summary(bsts_model)

# Plot komponen state
if (require("ggplot2")) {
  # Plot trend komponen
  burn <- SuggestBurn(0.1, bsts_model)
  trends <- bsts_model$state.contributions
  
  # Plot prediksi vs aktual
  fitted_values <- fitted(bsts_model, burn = burn)
  
  plot_data <- data.frame(
    Date = df_clean$date,
    Actual = df_clean$price,
    Fitted = colMeans(fitted_values)
  )
  
  ggplot(plot_data, aes(x = Date)) +
    geom_line(aes(y = Actual, color = "Aktual"), size = 1) +
    geom_line(aes(y = Fitted, color = "Fitted"), size = 1, linetype = "dashed") +
    scale_color_manual(values = c("Aktual" = "blue", "Fitted" = "red")) +
    labs(title = "Model BSTS: Aktual vs Fitted Values",
         y = "Harga Emas", color = "") +
    theme_minimal()
}
