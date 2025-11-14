setwd("~/ikanx101.github.io/_posts/matematika ITB/bayesian_gold")

rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(readxl)

file = "harga_emas_2_bulan_lengkap.xlsx"

df = 
  read_excel(file) |> 
  janitor::clean_names() |> 
  rename(date = tanggal,
         price = harga_rp_gram)

# Konversi kolom date ke format yang benar
df_clean <- df %>%
  mutate(
    date = as.Date(date),
    day_of_week = wday(date, label = TRUE),
    day_num = as.numeric(date - min(date)),
    log_price = log(price)
  )

# 2. Analisis Eksploratori
cat("=== STATISTIK DESKRIPTIF ===\n")
summary(df_clean$price)

# Visualisasi data
ggplot(df_clean, aes(x = date, y = price)) +
  geom_line(color = "gold", size = 1) +
  geom_point(color = "darkorange", size = 2) +
  labs(title = "Trend Harga Emas", 
       x = "Tanggal", 
       y = "Harga (IDR)") +
  theme_minimal()

# 3. Model Bayesian Linear Regression dengan rstan
library(rstan)

# Persiapan data untuk Stan
stan_data <- list(
  N = nrow(df_clean),
  x = df_clean$day_num,
  y = df_clean$price,
  # Prior untuk intercept dan slope
  alpha_prior = mean(df_clean$price),
  beta_prior = 0,
  sigma_prior = sd(df_clean$price)
)

# Kode model Stan
stan_model_code <- "
data {
  int<lower=0> N;
  vector[N] x;
  vector[N] y;
  real alpha_prior;
  real beta_prior;
  real sigma_prior;
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}
model {
  // Priors
  alpha ~ normal(alpha_prior, 100000);
  beta ~ normal(beta_prior, 10000);
  sigma ~ exponential(1/sigma_prior);
  
  // Likelihood
  y ~ normal(alpha + beta * x, sigma);
}
generated quantities {
  vector[N] y_rep;
  for (i in 1:N) {
    y_rep[i] = normal_rng(alpha + beta * x[i], 
sigma);
  }
}
"

# 4. Fitting Model Bayesian
cat("=== MEMULAI FITTING MODEL BAYESIAN ===\n")
set.seed(123)
bayesian_fit <- stan(
  model_code = stan_model_code,
  data = stan_data,
  chains = 4,
  iter = 2000,
  warmup = 1000,
  cores = 2
)

# 5. Analisis Hasil
cat("=== HASIL MODEL BAYESIAN ===\n")
print(bayesian_fit, pars = c("alpha", "beta", 
                             "sigma"))

# Ekstraksi posterior samples
posterior_samples <- extract(bayesian_fit)

# 6. Prediksi untuk 7 hari ke depan
future_days <- data.frame(
  day_num = max(df_clean$day_num) + 1:7
)

# Prediksi menggunakan posterior samples
n_samples <- length(posterior_samples$alpha)
future_predictions <- matrix(NA, nrow = n_samples, 
                             ncol = 7)

for (i in 1:7) {
  future_predictions[, i] <- posterior_samples$alpha
  + 
    posterior_samples$beta *
    future_days$day_num[i] +
    rnorm(n_samples, 0, 
          posterior_samples$sigma)
}

# Ringkasan prediksi
prediction_summary <- data.frame(
  Day = 1:7,
  Predicted_Date = max(df_clean$date) + 1:7,
  Mean_Price = apply(future_predictions, 2, mean),
  Lower_95 = apply(future_predictions, 2, quantile, 
                   probs = 0.025),
  Upper_95 = apply(future_predictions, 2, quantile, 
                   probs = 0.975)
)

cat("=== PREDIKSI 7 HARI KE DEPAN ===\n")
print(prediction_summary)

# 7. Visualisasi Prediksi
library(tidyr)

# Gabungkan data aktual dan prediksi
actual_data <- df_clean %>%
  select(date, price) %>%
  mutate(Type = "Aktual")

prediction_data <- prediction_summary %>%
  select(Predicted_Date, Mean_Price) %>%
  rename(date = Predicted_Date, price = Mean_Price) %>%
  mutate(Type = "Prediksi")

combined_data <- bind_rows(actual_data, 
                           prediction_data)

ggplot(combined_data, aes(x = date, y = price, color
                          = Type)) +
  geom_line(data = filter(combined_data, Type == 
                            "Aktual"), size = 1) +
  geom_point(data = filter(combined_data, Type == 
                             "Prediksi"), size = 3) +
  geom_ribbon(data = data.frame(
    date = prediction_summary$Predicted_Date,
    ymin = prediction_summary$Lower_95,
    ymax = prediction_summary$Upper_95
  ), aes(x = date, ymin = ymin, ymax = ymax, y = 
           NULL, color = NULL),
  fill = "orange", alpha = 0.3) +
  scale_color_manual(values = c("Aktual" = "blue", 
                                "Prediksi" = "red")) +
  labs(title = "Prediksi Harga Emas 7 Hari ke Depan 
(Bayesian)",
       x = "Tanggal", 
       y = "Harga (IDR)",
       caption = "Area oranye menunjukkan interval 
kepercayaan 95%") +
  theme_minimal()

# 8. Evaluasi Model
# Hitung RMSE pada data training
y_pred_train <- apply(posterior_samples$y_rep, 2, 
                      mean)
rmse <- sqrt(mean((df_clean$price - 
                     y_pred_train)^2))

cat("=== EVALUASI MODEL ===\n")
cat("RMSE pada data training:", round(rmse, 2), 
    "\n")
cat("MAPE:", round(mean(abs((df_clean$price - 
                               y_pred_train)/df_clean$price)) * 100, 2), "%\n")

# 9. Simpan Hasil Prediksi
write.csv(prediction_summary, 
          "prediksi_harga_emas_bayesian.csv", row.names = 
            FALSE)
cat("Hasil prediksi telah disimpan ke 
'prediksi_harga_emas_bayesian.csv'\n")

# 10. Diagnostik Model
# Trace plots untuk konvergensi
if ("bayesplot" %in% installed.packages()) {
  library(bayesplot)
  mcmc_trace(bayesian_fit, pars = c("alpha", "beta",
                                    "sigma"))
} else {
  cat("Instal paket 'bayesplot' untuk visualisasi 
diagnostik yang lebih lengkap\n")
}
