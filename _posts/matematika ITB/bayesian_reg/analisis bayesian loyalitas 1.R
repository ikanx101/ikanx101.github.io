rm(list=ls())

# Set seed untuk reproduktibilitas
set.seed(123)

# Membuat data dummy tahun 2015-2023
tahun <- 2015:2023
n_tahun <- length(tahun)

# Membuat persentase loyal user dengan tren positif dan noise
true_intercept <- 40
true_slope <- 1.8
noise <- rnorm(n_tahun, mean = 0, sd = 1.5)

persentase <- true_intercept + true_slope * (tahun - 2015) + noise
persentase <- round(persentase, 1)

# Membuat dataframe
data_loyal <- data.frame(
  tahun = tahun,
  persentase = persentase
)

print(data_loyal)

# Plot data time series
library(ggplot2)

ggplot(data_loyal, aes(x = tahun, y = persentase)) +
  geom_point(size = 3, color = "steelblue") +
  geom_line(color = "steelblue", alpha = 0.7) +
  labs(title = "Persentase Loyal User (2015-2023)",
       x = "Tahun", 
       y = "Persentase (%)") +
  theme_minimal()

# Install package jika belum ada
# install.packages("rstanarm")
# install.packages("bayesplot")
# install.packages("tidybayes")

library(rstanarm)
library(bayesplot)
library(tidybayes)
library(dplyr)

# Standardisasi tahun untuk numerical stability
data_loyal$tahun_std <- data_loyal$tahun - mean(data_loyal$tahun)

# Model Bayesian Linear Regression
model_bayes <- stan_glm(
  persentase ~ tahun_std,
  data = data_loyal,
  family = gaussian(),
  prior = normal(location = 0, scale = 10),    # Prior untuk coefficients
  prior_intercept = normal(location = 50, scale = 10), # Prior untuk intercept
  prior_aux = exponential(rate = 1),           # Prior untuk standard deviation
  chains = 4,                                  # 4 rantai MCMC
  iter = 2000,                                 # Iterasi per rantai
  seed = 123
)

# Summary model
summary(model_bayes)

# Trace plot untuk mengecek konvergensi
mcmc_trace(model_bayes, pars = c("(Intercept)", "tahun_std"))

# Plot distribusi posterior
mcmc_areas(model_bayes, pars = c("(Intercept)", "tahun_std"), prob = 0.95)

# Posterior predictive check
pp_check(model_bayes) + 
  labs(title = "Posterior Predictive Check")

# Ekstraksi sampel posterior
posterior_samples <- as.data.frame(model_bayes)

# Analisis untuk slope (tren)
slope_samples <- posterior_samples$tahun_std

# Probabilitas bahwa tren positif
prob_positif <- mean(slope_samples > 0)
cat("Probabilitas tren positif:", round(prob_positif * 100, 2), "%\n")

# Interval kredibel 95% untuk slope
slope_ci <- quantile(slope_samples, probs = c(0.025, 0.5, 0.975))
cat("\nInterval kredibel 95% untuk tren tahunan:\n")
print(slope_ci)

# Konversi kembali ke skala asli
intercept_samples <- posterior_samples$`(Intercept)`
slope_original <- slope_samples  # Karena tahun sudah distandardisasi

cat("\nEstimasi tren tahunan (dalam persentase poin per tahun):\n")
cat("Rata-rata:", round(mean(slope_original), 3), "\n")
cat("SD:", round(sd(slope_original), 3), "\n")

# Prediksi untuk 2024
tahun_pred <- 2024
tahun_std_pred <- tahun_pred - mean(data_loyal$tahun)

# Membuat prediksi
prediksi_2024 <- posterior_predict(
  model_bayes, 
  newdata = data.frame(tahun_std = tahun_std_pred)
)

# Analisis distribusi prediktif
summary_pred <- quantile(prediksi_2024, probs = c(0.025, 0.25, 0.5, 0.75, 0.975))
cat("\nPrediksi untuk tahun 2024:\n")
print(summary_pred)

# Visualisasi prediksi
ggplot() +
  geom_histogram(aes(x = prediksi_2024), bins = 30, fill = "lightblue", 
                 color = "black", alpha = 0.7) +
  labs(title = "Distribusi Prediktif untuk Loyal User 2024",
       x = "Persentase Prediksi", 
       y = "Frekuensi") +
  theme_minimal()


# Membuat data untuk plot
plot_data <- data_loyal %>%
  mutate(tipe = "Data Aktual")

# Prediksi untuk plot
tahun_plot <- 2015:2024
tahun_std_plot <- tahun_plot - mean(data_loyal$tahun)

pred_matrix <- posterior_predict(
  model_bayes,
  newdata = data.frame(tahun_std = tahun_std_plot)
)

# Hitung interval kredibel
pred_summary <- data.frame(
  tahun = tahun_plot,
  mean = colMeans(pred_matrix),
  lower = apply(pred_matrix, 2, quantile, 0.025),
  upper = apply(pred_matrix, 2, quantile, 0.975)
)

# Plot final
ggplot() +
  # Data aktual
  geom_point(data = data_loyal, aes(x = tahun, y = persentase), 
             size = 3, color = "steelblue") +
  geom_line(data = data_loyal, aes(x = tahun, y = persentase), 
            color = "steelblue", alpha = 0.7) +
  
  # Prediksi mean
  geom_line(data = pred_summary, aes(x = tahun, y = mean), 
            color = "red", linetype = "dashed") +
  
  # Interval ketidakpastian
  geom_ribbon(data = pred_summary, aes(x = tahun, ymin = lower, ymax = upper),
              fill = "red", alpha = 0.2) +
  
  labs(title = "Analisis Bayesian: Tren Loyal User dengan Prediksi",
       subtitle = "Garis biru: data aktual, Garis merah: prediksi model, Area: interval kredibel 95%",
       x = "Tahun", 
       y = "Persentase Loyal User (%)") +
  theme_minimal()




# Misalkan target tahun 2024 adalah 56%
target_2024 <- 56
probabilitas_target <- mean(prediksi_2024 >= target_2024)

cat("\nProbabilitas mencapai target 56% di 2024:", 
    round(probabilitas_target * 100, 2), "%\n")

# Distribusi kumulatif untuk berbagai target
targets <- seq(50, 60, by = 1)
probabilitas <- sapply(targets, function(t) mean(prediksi_2024 >= t))

plot_data_target <- data.frame(
  target = targets,
  probabilitas = probabilitas
)

ggplot(plot_data_target, aes(x = target, y = probabilitas)) +
  geom_line(color = "purple", size = 1) +
  geom_point(color = "purple", size = 2) +
  labs(title = "Probabilitas Mencapai Berbagai Target di 2024",
       x = "Target Persentase", 
       y = "Probabilitas") +
  theme_minimal()



