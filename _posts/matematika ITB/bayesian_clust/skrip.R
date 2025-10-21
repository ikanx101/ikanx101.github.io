# Load required libraries
library(mclust)
library(ggplot2)
library(bayesm)
library(mvtnorm)
library(coda)

# Set seed untuk reproduktibilitas
set.seed(123)

# Fungsi untuk membuat data dummy
create_dummy_data <- function(n_samples = 300) {
  # Parameter untuk tiga cluster
  mu1 <- c(2, 2)
  mu2 <- c(8, 8)
  mu3 <- c(5, 2)
  
  sigma1 <- matrix(c(1, 0.5, 0.5, 1), nrow = 2)
  sigma2 <- matrix(c(1, -0.3, -0.3, 1), nrow = 2)
  sigma3 <- matrix(c(0.8, 0, 0, 0.8), nrow = 2)
  
  # Generate data dari distribusi normal multivariat
  cluster1 <- rmvnorm(n_samples/3, mean = mu1, sigma = sigma1)
  cluster2 <- rmvnorm(n_samples/3, mean = mu2, sigma = sigma2)
  cluster3 <- rmvnorm(n_samples/3, mean = mu3, sigma = sigma3)
  
  # Gabungkan data
  data <- rbind(cluster1, cluster2, cluster3)
  true_clusters <- rep(1:3, each = n_samples/3)
  
  return(list(data = data, true_clusters = true_clusters))
}

# Create dummy data
dummy_data <- create_dummy_data()
X <- dummy_data$data
true_clusters <- dummy_data$true_clusters

# Visualisasi data asli
df_original <- data.frame(X1 = X[,1], X2 = X[,2], Cluster = as.factor(true_clusters))
ggplot(df_original, aes(x = X1, y = X2, color = Cluster)) +
  geom_point(alpha = 0.7, size = 2) +
  ggtitle("Data Asli dengan True Clusters") +
  theme_minimal()


# Menggunakan mclust untuk Bayesian GMM
fit_mclust <- Mclust(X, G = 1:5, modelNames = "VVV")

# Hasil clustering
mclust_clusters <- fit_mclust$classification
mclust_uncertainty <- fit_mclust$uncertainty

# Summary model
summary(fit_mclust)


# Visualisasi hasil clustering
df_results <- data.frame(X1 = X[,1], X2 = X[,2], 
                         Cluster = as.factor(mclust_clusters),
                         Uncertainty = mclust_uncertainty)

# Plot clusters
p1 <- ggplot(df_results, aes(x = X1, y = X2, color = Cluster)) +
  geom_point(alpha = 0.7, size = 2) +
  ggtitle("Bayesian GMM Clustering (mclust)") +
  theme_minimal()

# Plot uncertainty
p2 <- ggplot(df_results, aes(x = X1, y = X2, color = Uncertainty)) +
  geom_point(alpha = 0.7, size = 2) +
  scale_color_gradient(low = "blue", high = "red") +
  ggtitle("Uncertainty in Cluster Assignment") +
  theme_minimal()

# Tampilkan plots
library(gridExtra)
grid.arrange(p1, p2, ncol = 2)

# Evaluasi performa
library(mclust)
adjusted_rand_index <- adjustedRandIndex(true_clusters, mclust_clusters)
cat("Adjusted Rand Index:", round(adjusted_rand_index, 3), "\n")

# Probabilitas keanggotaan cluster
cluster_probs <- fit_mclust$z
head(cluster_probs)

# Plot BIC untuk pemilihan model
plot(fit_mclust, what = "BIC")




