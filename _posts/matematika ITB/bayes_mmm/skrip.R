setwd("~/ikanx101.github.io/_posts/matematika ITB/bayes_mmm")

# Load libraries
library(tidyverse)
library(brms)

rm(list=ls())

# 1. Generate Dummy Data
set.seed(123)
n <- 52 # 52 minggu data
data_mmm <- data.frame(
  tv_spend = runif(n, 100, 500),
  digital_spend = runif(n, 50, 300),
  social_spend = runif(n, 20, 150)
) %>%
  mutate(
    # Membuat sales dengan noise, asumsi digital paling efektif
    sales = 1000 + (1.2 * tv_spend) + (2.5 * digital_spend) + (0.8 * social_spend) + rnorm(n, 0, 50)
  )

# 2. Define Priors (Kunci dari Bayesian MMM)
# Kita paksa koefisien (b) bernilai positif dengan distribusi Lognormal
my_priors <- c(
  prior(normal(1000, 100), class = "Intercept"),
  prior(lognormal(0, 1), class = "b", lb = 0) 
)

# 3. Running Bayesian Model
model_mmm <- brm(
  formula = sales ~ tv_spend + digital_spend + social_spend,
  data = data_mmm,
  prior = my_priors,
  family = gaussian(),
  chains = 4, 
  iter = 2000,
  warmup = 1000,
  cores = 4,
  seed = 123
)

# 4. Visualisasi Hasil
plot(model_mmm)
summary(model_mmm)

# 5. Menghitung Probabilitas ROAS
posterior_samples <- as_draws_df(model_mmm)
# Contoh: Probabilitas Digital Spend lebih efektif dari TV Spend
prob_digital_vs_tv <- mean(posterior_samples$b_digital_spend > posterior_samples$b_tv_spend)
print(paste0("Probabilitas Digital lebih efektif dari TV: ", prob_digital_vs_tv * 100, "%"))




