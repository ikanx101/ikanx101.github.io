rm(list=ls())
gc()

library(dplyr)
library(tidyr)

setwd("~/ikanx101.github.io/_posts/geo marketing/post_9")

load("all_data.rda")

colnames(df_final)

df_sel = 
  df_final %>% 
  filter(kota == "Surabaya") %>% 
  filter(kecamatan %in% c("Gubeng","Genteng")) %>% 
  filter(!is.na(rating)) %>% 
  filter(user_rating > 0) %>% 
  select(nama,rating,long,lat)

save(df_sel,file = "data_awal.rda")

# Load required libraries
library(ggplot2)
library(dplyr)
library(scales)

# 1. Visualisasi dengan nilai asli
p1 <- ggplot(df_sel, aes(x = user_rating, y = rating)) +
  geom_point(alpha = 0.6, size = 2, color = "#2E86AB") +
  geom_smooth(method = "lm", se = FALSE, color = "#A23B72", linetype 
              = "dashed") +
  geom_hline(yintercept = median(df_sel$rating, na.rm = TRUE), 
             color = "#F18F01", linetype = "dashed", size = 0.8) +
  geom_vline(xintercept = median(df_sel$user_rating, na.rm = TRUE), 
             color = "#F18F01", linetype = "dashed", size = 0.8) +
  scale_x_continuous(labels = comma) +
  labs(
    title = "Kuadran Rating vs Jumlah User (Nilai Asli)",
    subtitle = "Analisis Hubungan antara Popularitas dan Kualitas 
Tempat Makan",
    x = "Jumlah User yang Memberikan Rating",
    y = "Rating Tempat Makan (0-5)",
    caption = "Garis putus-putus menunjukkan median rating dan jumlah
user\nikanx101.com"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = 
                                   "gray40"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(size = 9, color = "gray50", hjust = 
                                  1),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# 2. Visualisasi dengan transformasi logaritmik pada user_rating
p2 <- ggplot(df_sel, aes(x = log10(user_rating + 1), y = rating)) +
  geom_point(alpha = 0.6, size = 2, color = "#3D5A80") +
  geom_smooth(method = "lm", se = FALSE, color = "#EE6C4D", linetype 
              = "dashed") +
  geom_hline(yintercept = median(df_sel$rating, na.rm = TRUE), 
             color = "#98C1D9", linetype = "dashed", size = 0.8) +
  geom_vline(xintercept = median(log10(df_sel$user_rating + 1), na.rm
                                 = TRUE), 
             color = "#98C1D9", linetype = "dashed", size = 0.8) +
  scale_x_continuous(
    labels = function(x) format(10^x, scientific = FALSE, big.mark = 
                                  ",")
  ) +
  labs(
    title = "Kuadran Rating vs Jumlah User (Transformasi 
Logaritmik)",
    subtitle = "Transformasi logaritmik",
    x = "Jumlah User (skala logaritmik)",
    y = "Rating Tempat Makan (0-5)",
    caption = "Transformasi log membantu menangani distribusi data 
yang skewed\nikanx101.com"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = 
                                   "gray40"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(size = 9, color = "gray50", hjust = 
                                  1),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# 3. Visualisasi dengan kuadran berwarna
# Hitung kuadran berdasarkan median
df_sel <- df_sel %>%
  mutate(
    kuadran = case_when(
      rating >= median(rating, na.rm = TRUE) & user_rating >= 
        median(user_rating, na.rm = TRUE) ~ "High Rating & High Users",
      rating >= median(rating, na.rm = TRUE) & user_rating < 
        median(user_rating, na.rm = TRUE) ~ "High Rating & Low Users",
      rating < median(rating, na.rm = TRUE) & user_rating >= 
        median(user_rating, na.rm = TRUE) ~ "Low Rating & High Users",
      rating < median(rating, na.rm = TRUE) & user_rating < 
        median(user_rating, na.rm = TRUE) ~ "Low Rating & Low Users"
    )
  )

# Warna untuk kuadran
kuadran_colors <- c(
  "High Rating & High Users" = "#2A9D8F",
  "High Rating & Low Users" = "#E9C46A",
  "Low Rating & High Users" = "#E76F51",
  "Low Rating & Low Users" = "#264653"
)

p3 <- ggplot(df_sel, aes(x = log10(user_rating + 1), y = rating, 
                         color = kuadran)) +
  geom_point(alpha = 0.7, size = 2.5) +
  geom_hline(yintercept = median(df_sel$rating, na.rm = TRUE), 
             color = "gray40", linetype = "dashed", size = 0.8) +
  geom_vline(xintercept = median(log10(df_sel$user_rating + 1), na.rm
                                 = TRUE), 
             color = "gray40", linetype = "dashed", size = 0.8) +
  scale_color_manual(values = kuadran_colors) +
  scale_x_continuous(
    labels = function(x) format(10^x, scientific = FALSE, big.mark = 
                                  ",")
  ) +
  labs(
    title = "Analisis Kuadran Tempat Makan",
    subtitle = "Segmentasi berdasarkan Rating dan Popularitas",
    x = "Jumlah User (skala logaritmik)",
    y = "Rating Tempat Makan (0-5)",
    color = "Kuadran",
    caption = "Setiap kuadran merepresentasikan strategi berbeda 
untuk Tempat Makan\nikanx101.com"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = 
                                   "gray40"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.title = element_text(face = "bold"),
    legend.position = "bottom",
    legend.box = "horizontal",
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(size = 9, color = "gray50", hjust = 
                                  1),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  ) +
  guides(color = guide_legend(nrow = 2, byrow = TRUE))

# 4. Tambahan: Density plot untuk melihat distribusi
p4 <- ggplot(df_sel, aes(x = log10(user_rating + 1), y = rating)) +
  geom_point(alpha = 0.3, size = 1.5, color = "#6A0572") +
  geom_density_2d_filled(alpha = 0.5) +
  geom_density_2d(color = "white", size = 0.3) +
  scale_x_continuous(
    labels = function(x) format(10^x, scientific = FALSE, big.mark = 
                                  ",")
  ) +
  labs(
    title = "Distribusi Density Rating vs User",
    subtitle = "Kepadatan data menunjukkan pola konsentrasi",
    x = "Jumlah User (skala logaritmik)",
    y = "Rating Tempat Makan (0-5)",
    caption = "ikanx101.com"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = 
                                   "gray40"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.position = "none",
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# Tampilkan plot
print(p1)
print(p2)
print(p3)
print(p4)

save(p1,p2,p3,p4,df_sel,file = "analisa_1.rda")

# Statistik deskriptif untuk interpretasi
cat("\n=== STATISTIK DESKRIPTIF ===\n")
cat("Median Rating:", median(df_sel$rating, na.rm = TRUE), "\n")
cat("Median User Rating:", median(df_sel$user_rating, na.rm = TRUE), 
    "\n")
cat("Mean Rating:", mean(df_sel$rating, na.rm = TRUE), "\n")
cat("Mean User Rating:", mean(df_sel$user_rating, na.rm = TRUE), 
    "\n\n")

cat("Distribusi Kuadran:\n")
table(df_sel$kuadran)
