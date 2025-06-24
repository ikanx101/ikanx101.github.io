library(simmer)
library(simmer.plot)
library(ggplot2)

rm(list=ls())

# Parameter simulasi
lambda <- 4 # tingkat kedatangan (pelanggan/jam)
mu <- 4 # tingkat pelayanan rata-rata (pelanggan/jam per server)
c <- 2 # jumlah server
K <- 5 # kapasitas sistem (antrian + pelayanan)
sim_time <- 200 # jam simulasi
seed <- 123 # seed untuk reproduktibilitas

# Setup lingkungan simulasi
set.seed(seed)
env <- simmer("M/G/c/K Queue Simulation")

# Definisi trajektori pelanggan
customer <- trajectory("Customer's path") %>%
  seize("server", 1) %>% # meminta server
  timeout(function() rnorm(1, mean = 1/mu, sd = 0.2)) %>% # waktu pelayanan
  release("server", 1) # melepaskan server

# Setup sumber daya sistem
env %>%
  add_resource("server", 
               capacity = c, # jumlah server
               queue_size = K - c) %>% # ukuran antrian (K - c)
  add_generator("Customer", 
                customer, 
                function() rexp(1, lambda), # interval kedatangan
                mon = 2) # monitoring level 2

# Jalankan simulasi
env %>% run(until = sim_time)

# Analisis hasil
## Data kedatangan dan keberangkatan
arrivals <- get_mon_arrivals(env)
resources <- get_mon_resources(env)

## Hitung probabilitas blocking
n_total <- nrow(arrivals)
n_blocked <- sum(arrivals$finished == FALSE)
p_block <- n_blocked/n_total

## Hitung metrik kinerja
served <- arrivals[arrivals$finished == TRUE, ]
avg_wait <- mean(served$end_time - served$start_time - served$activity_time)
avg_queue <- mean(resources$queue)
utilization <- mean(resources$server / c)

# Visualisasi
## Plot utilisasi resources
# plot(resources, "usage", "server", items = "server") +
#   ggtitle("Utilisasi Server")

## Plot panjang antrian
# plot(resources, "queue", "server") +
#   ggtitle("Panjang Antrian")

# Hasil
cat("=== Hasil Simulasi M/G/", c, "/", K, " dengan simmer ===\n", sep="")
cat("Total kedatangan:", n_total, "\n")
cat("Total dilayani:", n_total - n_blocked, "\n")
cat("Total blocked:", n_blocked, "\n")
cat("Probabilitas blocking:", round(p_block, 3), "\n")
cat("Rata-rata waktu tunggu:", round(avg_wait, 3), "jam\n")
cat("Rata-rata panjang antrian:", round(avg_queue, 2), "\n")
cat("Utilisasi server:", round(utilization, 3), "\n")

# Waktu respon sistem
hist(served$end_time - served$start_time, 
     main = "Distribusi Waktu Respon Sistem",
     xlab = "Waktu (jam)")

# Hubungan waktu tunggu vs waktu pelayanan
ggplot(served, aes(x = activity_time, y = end_time - start_time - activity_time)) +
  geom_point() +
  labs(title = "Waktu Tunggu vs Waktu Pelayanan",
       x = "Waktu Pelayanan",
       y = "Waktu Tunggu")
