rm(list=ls())

library(dplyr)
library(tidyr)

# Data 30 hari terakhir
data_dummy <- data.frame(
  periode = c("Hari 1-10", "Hari 11-20", "Hari 21-30"),
  pembelian = c(2, 3, 5),
  pengunjung = c(100, 100, 100),
  conversion_rate = c(0.02, 0.03, 0.05)
)

print(data_dummy)

# Prior Non-informatif
alpha_prior_noninfo <- 1
beta_prior_noninfo <- 1

# Prior Informatif (berdasarkan benchmark industri)
alpha_prior <- 3    # setara dengan 3 success
beta_prior <- 97    # setara dengan 97 failures

# Data observasi
successes <- 10
failures <- 290
total_visitors <- successes + failures

# Maximum Likelihood Estimate (frequentist)
mle <- successes / total_visitors

print(mle)

# Parameter posterior
alpha_posterior <- alpha_prior + successes
beta_posterior <- beta_prior + failures

cat("Parameter Posterior:\n")
cat("Alpha posterior:", alpha_posterior, "\n")
cat("Beta posterior:", beta_posterior, "\n")
cat("Distribusi Posterior: Beta(", alpha_posterior, ",", beta_posterior, ")\n")


library(ggplot2)
library(dplyr)

# Membuat sequence untuk conversion rate
x <- seq(0, 0.1, length.out = 1000)

# Data frame untuk plotting
plot_data <- data.frame(
  conversion_rate = x,
  prior = dbeta(x, alpha_prior, beta_prior),
  posterior = dbeta(x, alpha_posterior, beta_posterior)
)

# Plot
ggplot(plot_data, aes(x = conversion_rate)) +
  geom_line(aes(y = prior, color = "Prior"), size = 1.2, linetype = "dashed") +
  geom_line(aes(y = posterior, color = "Posterior"), size = 1.2) +
  geom_vline(xintercept = mle, color = "darkgreen", linetype = "dotted", size = 1) +
  labs(
    title = "Bayesian Update: Prior → Posterior",
    x = "Conversion Rate",
    y = "Density",
    color = "Distribusi"
  ) +
  scale_color_manual(values = c("Prior" = "red", "Posterior" = "blue")) +
  annotate("text", x = mle + 0.005, y = 15, 
           label = paste("MLE =", round(mle, 4)), color = "darkgreen") +
  theme_minimal() +
  theme(legend.position = "top")


# Menghitung interval kredibel
ci_95 <- qbeta(c(0.025, 0.975), alpha_posterior, beta_posterior)
mean_posterior <- alpha_posterior / (alpha_posterior + beta_posterior)
mode_posterior <- (alpha_posterior - 1) / (alpha_posterior + beta_posterior - 2)

cat("\nHasil Analisis Bayesian:\n")
cat("95% Credible Interval: (", round(ci_95[1], 4), ",", round(ci_95[2], 4), ")\n")
cat("Mean Posterior:", round(mean_posterior, 4), "\n")
cat("Mode Posterior:", round(mode_posterior, 4), "\n")
cat("MLE (Frequentist):", round(mle, 4), "\n")

