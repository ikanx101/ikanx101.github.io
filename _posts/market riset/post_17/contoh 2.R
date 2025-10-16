rm(list=ls())

# Data A/B testing
ab_data <- data.frame(
  versi = c("A", "B"),
  pembelian = c(15, 25),
  pengunjung = c(500, 500)
)

# Parameter posterior untuk masing-masing versi
alpha_A <- 1 + ab_data$pembelian[1]
beta_A <- 1 + (ab_data$pengunjung[1] - ab_data$pembelian[1])

alpha_B <- 1 + ab_data$pembelian[2]  
beta_B <- 1 + (ab_data$pengunjung[2] - ab_data$pembelian[2])

cat("\nParameter Posterior A/B Test:\n")
cat("Versi A: Beta(", alpha_A, ",", beta_A, ")\n")
cat("Versi B: Beta(", alpha_B, ",", beta_B, ")\n")

# Simulasi untuk menghitung probabilitas B > A
set.seed(123)  # untuk reproducible results
n_simulations <- 100000

samples_A <- rbeta(n_simulations, alpha_A, beta_A)
samples_B <- rbeta(n_simulations, alpha_B, beta_B)

prob_B_better_A <- mean(samples_B > samples_A)
lift <- (samples_B - samples_A) / samples_A
expected_lift <- mean(lift)

cat("\nHasil A/B Testing Bayesian:\n")
cat("Probabilitas B lebih baik daripada A:", round(prob_B_better_A, 4), "\n")
cat("Expected lift:", round(expected_lift, 4), "\n")
cat("Confidence level:", round(prob_B_better_A * 100, 2), "%\n")

# Data untuk plotting A/B test
ab_samples <- data.frame(
  conversion_rate = c(samples_A, samples_B),
  versi = rep(c("A", "B"), each = n_simulations)
)

ggplot(ab_samples, aes(x = conversion_rate, fill = versi)) +
  geom_density(alpha = 0.6) +
  labs(
    title = "Distribusi Posterior Conversion Rate A/B Test",
    x = "Conversion Rate",
    y = "Density",
    fill = "Versi"
  ) +
  theme_minimal()








