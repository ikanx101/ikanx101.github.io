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


# 1. LOAD PACKAGES YANG DIPERLUKAN
library(tidyverse)
library(osrm)
library(ggplot2)
library(ggrepel)
library(ggspatial)
library(sf)
library(spdep)
library(corrplot)
library(sp)

# 2. FUNGSI UTILITAS
# Fungsi untuk menghitung jarak Euclidean (sebagai pendekatan awal)

# lon1 = 112.7413
# lon2 = 112.7693
# lat1 = -7.251342
# lat2 = -7.267014


hitung_jarak_euclidean <- function(lon1, lat1, 
                                   lon2, lat2) {
  hasil = osrmRoute(src = c(lon1, lat1),
                    dst = c(lon2, lat2),
                    overview = FALSE,
                    osrm.profile = "foot")
  distance = hasil[2]*1000
  
  return(distance)
}

# 3. PREPROCESSING DATA
# Pastikan data sudah bersih
df_clean <- df_sel %>%
  filter(!is.na(rating), !is.na(long), !is.na(lat)) %>%
  mutate(id = row_number())  # Tambahkan ID unik

# 4. ANALISIS 1: APAKAH RESTORAN YANG BERDEKATAN MEMILIKI RATING YANG MIRIP?
# --------------------------------------------------------------
  
# 4.1 Hitung matriks jarak antar restoran
cat("Menghitung jarak antar restoran...\n")

# Gunakan pendekatan Euclidean untuk efisiensi (bisa diganti dengan OSRM jika perlu)
n <- nrow(df_clean)
# jarak_matrix <- matrix(0, n, n)

# for (i in 1:(n-1)) {
#   print(i)
#   for (j in (i+1):n) {
#     jarak <- hitung_jarak_euclidean(
#       df_clean$long[i], df_clean$lat[i],
#       df_clean$long[j], df_clean$lat[j]
#     )
#     jarak_matrix[i, j] <- jarak
#     jarak_matrix[j, i] <- jarak
#     cat(j)
#   }
# }

# save(jarak_matrix,file = "matrix_jarak.rda")
load("matrix_jarak.rda")

# 4.2 Identifikasi pasangan restoran yang dekat (< 50 meter)
threshold_jarak <- 50  # meter
pasangan_dekat <- data.frame()

for (i in 1:(n-1)) {
  for (j in (i+1):n) {
    if (jarak_matrix[i, j] <= threshold_jarak && 
        jarak_matrix[i, j] > 0) {
      pasangan_dekat <- rbind(pasangan_dekat, 
                              data.frame(
                                restoran1 = df_clean$nama[i],
                                restoran2 = df_clean$nama[j],
                                rating1 = df_clean$rating[i],
                                rating2 = df_clean$rating[j],
                                jarak = jarak_matrix[i, j],
                                selisih_rating = abs(df_clean$rating[i] - 
                                                       df_clean$rating[j])
                              ))
    }
  }
}

cat("Ditemukan", nrow(pasangan_dekat), "pasangan restoran yang berdekatan (< 50m)\n")

# 4.3 Analisis korelasi rating untuk restoran yang berdekatan
if (nrow(pasangan_dekat) > 0) {
  # Hitung korelasi antara rating restoran yang berdekatan
  korelasi_dekat <- cor(pasangan_dekat$rating1, 
                        pasangan_dekat$rating2)
  cat("Korelasi rating untuk restoran yang 
berdekatan (< 50m):", round(korelasi_dekat, 3), 
      "\n")
  
  # Uji statistik
  uji_korelasi <- cor.test(pasangan_dekat$rating1, 
                           pasangan_dekat$rating2)
  cat("P-value uji korelasi:", 
      format(uji_korelasi$p.value, scientific = TRUE), 
      "\n")
  
  # Hitung rata-rata selisih rating
  rata_selisih <- 
    mean(pasangan_dekat$selisih_rating)
  cat("Rata-rata selisih rating untuk restoran 
berdekatan:", round(rata_selisih, 3), "\n")
} else {
  cat("Tidak ada pasangan restoran yang berdekatan 
(< 50m)\n")
}

# 5. ANALISIS 2: APAKAH KUALITAS SUATU RESTORAN MENULAR KE SEBELAHNYA?
# --------------------------------------------------------------
  
  # 5.1 Analisis spatial autocorrelation menggunakan Moran's I
# Konversi data ke format spatial
coords <- cbind(df_clean$long, df_clean$lat)
rating_vector <- df_clean$rating

# Buat matriks bobot berdasarkan jarak
# Definisikan tetangga berdasarkan jarak < 50m
cat("\nAnalisis spatial autocorrelation...\n")

# Buat objek spatial points
sp_points <- SpatialPoints(coords, proj4string = CRS("+proj=longlat +datum=WGS84"))

# Buat matriks bobot berdasarkan jarak
# Gunakan threshold 50 meter
nb <- dnearneigh(sp_points, 0, 50/111320)  # Konversi 50m ke derajat (approx)

if (length(nb) > 0) {
  # Hitung Moran's I
nbw <- nb2listw(nb, style = "W", zero.policy = 
                  TRUE)
moran_test <- moran.test(rating_vector, nbw, 
                         zero.policy = TRUE)

cat("Moran's I statistic:", 
    round(moran_test$estimate[1], 4), "\n")
cat("Expected Moran's I:", 
    round(moran_test$estimate[2], 4), "\n")
cat("P-value:", format(moran_test$p.value, 
                       scientific = TRUE), "\n")

# Interpretasi
if (moran_test$p.value < 0.05) {
  if (moran_test$estimate[1] > 
      moran_test$estimate[2]) {
    cat("KESIMPULAN: Terdapat spatial 
autocorrelation POSITIF yang signifikan.\n")
    cat("Artinya: Restoran dengan rating tinggi 
cenderung berdekatan dengan restoran rating 
tinggi,\n")
    cat("         dan restoran dengan rating 
rendah cenderung berdekatan dengan restoran rating 
rendah.\n")
    cat("         Ini mendukung hipotesis 
'kualitas menular'.\n")
  } else {
    cat("KESIMPULAN: Terdapat spatial 
autocorrelation NEGATIF yang signifikan.\n")
    cat("Artinya: Restoran dengan rating tinggi 
cenderung berdekatan dengan restoran rating 
rendah.\n")
  }
} else {
  cat("KESIMPULAN: Tidak ada spatial 
autocorrelation yang signifikan.\n")
  cat("Artinya: Tidak ada pola spasial dalam 
distribusi rating restoran.\n")
}
} else {
  cat("Tidak ada tetangga dalam radius 50m untuk 
analisis Moran's I\n")
}

# 6. VISUALISASI
# --------------------------------------------------------------
  
  # 6.1 Visualisasi 1: Peta distribusi restoran berdasarkan rating
p1 <- ggplot(df_clean, aes(x = long, y = lat, color
                           = rating)) +
  geom_point(size = 2, alpha = 0.7) +
  scale_color_gradient2(
    low = "red", 
    mid = "yellow", 
    high = "green",
    midpoint = median(df_clean$rating),
    name = "Rating"
  ) +
  labs(
    title = "Distribusi Spasial Restoran 
Berdasarkan Rating",
    subtitle = paste("Total:", nrow(df_clean), 
                     "restoran"),
    x = "Longitude",
    y = "Latitude"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size =
                                14),
    plot.subtitle = element_text(size = 12),
    legend.position = "right"
  ) +
  annotation_scale(location = "br") +
  annotation_north_arrow(location = "tl", 
                         which_north = "true")

print(p1)

# 6.2 Visualisasi 2: Hubungan jarak vs selisih rating (jika ada pasangan dekat)
if (nrow(pasangan_dekat) > 0) {
  p2 <- ggplot(pasangan_dekat, aes(x = jarak, y = 
                                     selisih_rating)) +
    geom_point(alpha = 0.6, color = "steelblue") +
    geom_smooth(method = "lm", se = TRUE, color = 
                  "darkred", fill = "pink", alpha = 0.2) +
    labs(
      title = "Hubungan Jarak dan Selisih Rating 
Restoran",
      subtitle = paste("Pasangan restoran dengan 
jarak <", threshold_jarak, "meter"),
      x = "Jarak (meter)",
      y = "Selisih Rating",
      caption = paste("Korelasi:", 
                      round(korelasi_dekat, 3))
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(face = "bold", size
                                = 14),
      plot.subtitle = element_text(size = 12)
    )
  
  print(p2)
  
  # 6.3 Visualisasi 3: Density plot selisih rating
  p3 <- ggplot(pasangan_dekat, aes(x = 
                                     selisih_rating)) +
    geom_density(fill = "lightblue", alpha = 0.7) +
    geom_vline(xintercept = 
                 mean(pasangan_dekat$selisih_rating), 
               color = "red", linetype = "dashed", 
               size = 1) +
    annotate("text", 
             x = 
               mean(pasangan_dekat$selisih_rating) + 0.05,
             y = 1,
             label = paste("Rata-rata:", 
                           round(mean(pasangan_dekat$selisih_rating), 3)),
             color = "red") +
    labs(
      title = "Distribusi Selisih Rating Restoran 
Berdekatan",
      subtitle = paste("Rata-rata selisih:", 
                       round(mean(pasangan_dekat$selisih_rating), 3)),
      x = "Selisih Rating",
      y = "Density"
    ) +
    theme_minimal()
  
  print(p3)
}

# 6.4 Visualisasi 4: Scatter plot rating pasangan restoran
if (nrow(pasangan_dekat) > 0) {
  p4 <- ggplot(pasangan_dekat, aes(x = rating1, y =
                                     rating2)) +
    geom_point(alpha = 0.6, color = "darkgreen") +
    geom_abline(slope = 1, intercept = 0, linetype 
                = "dashed", color = "red") +
    geom_smooth(method = "lm", se = TRUE, color = 
                  "blue", fill = "lightblue", alpha = 0.2) +
    labs(
      title = "Korelasi Rating Antar Restoran 
Berdekatan",
      subtitle = paste("Korelasi =", 
                       round(korelasi_dekat, 3)),
      x = "Rating Restoran 1",
      y = "Rating Restoran 2"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(face = "bold", size
                                = 14)
    )
  
  print(p4)
}

save(p4,file = "analisa_4.rda")

# 6.5 Visualisasi 5: Heatmap kerapatan restoran
p5 <- ggplot(df_clean, aes(x = long, y = lat)) +
  stat_density_2d(aes(fill = ..level..), geom = 
                    "polygon", alpha = 0.7) +
  scale_fill_viridis_c(name = "Kerapatan") +
  geom_point(aes(color = rating), size = 1, alpha =
               0.5) +
  scale_color_gradient(low = "red", high = "green",
                       name = "Rating") +
  labs(
    title = "Heatmap Kerapatan Restoran dan 
Distribusi Rating",
    x = "Longitude",
    y = "Latitude"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size =
                                14)
  )

print(p5)

# 8. KESIMPULAN UMUM
# --------------------------------------------------------------
cat("KESIMPULAN ANALISIS HUBUNGAN JARAK DAN 
KUALITAS RESTORAN\n")
# cat(strrep("=", 60) + "\n\n")

if (nrow(pasangan_dekat) > 0) {
  cat("1. RESTORAN YANG BERDEKATAN (< 50m):\n")
  cat("   - Jumlah pasangan:", 
      nrow(pasangan_dekat), "\n")
  cat("   - Korelasi rating:", 
      round(korelasi_dekat, 3), "\n")
  cat("   - Rata-rata selisih rating:", 
      round(rata_selisih, 3), "\n")
  
  if (korelasi_dekat > 0.3) {
    cat("   - INTERPRETASI: Terdapat kecenderungan 
rating yang mirip\n")
    cat("     untuk restoran yang berdekatan.\n")
  } else if (korelasi_dekat > 0) {
    cat("   - INTERPRETASI: Ada sedikit 
kecenderungan rating mirip,\n")
    cat("     tetapi tidak kuat.\n")
  } else {
    cat("   - INTERPRETASI: Tidak ada kecenderungan
rating mirip\n")
    cat("     untuk restoran yang berdekatan.\n")
  }
} else {
  cat("1. Tidak ditemukan pasangan restoran yang 
berdekatan (< 50m)\n")
}

if (exists("moran_test") && moran_test$p.value < 
    0.05) {
  cat("\n2. ANALISIS SPATIAL AUTOCORRELATION 
(Moran's I):\n")
  cat("   - Moran's I:", 
      round(moran_test$estimate[1], 4), "\n")
  cat("   - P-value:", format(moran_test$p.value, 
                              scientific = TRUE), "\n")
  
  if (moran_test$estimate[1] > 0) {
    cat("   - INTERPRETASI: Terdapat 'penularan 
kualitas' yang signifikan.\n")
    cat("     Restoran dengan rating tinggi 
cenderung berkumpul,\n")
    cat("     begitu juga dengan restoran rating 
rendah.\n")
  } else {
    cat("   - INTERPRETASI: Restoran cenderung 
berbeda dengan tetangganya.\n")
  }
} else {
  cat("\n2. Tidak ditemukan pola spasial yang 
signifikan dalam distribusi rating.\n")
}

cat("\n3. REKOMENDASI:\n")
if (exists("moran_test") && moran_test$p.value < 
    0.05 && moran_test$estimate[1] > 0) {
  cat("   - Pertimbangkan untuk membuka restoran di
area dengan konsentrasi\n")
  cat("     restoran rating tinggi (efek kluster 
positif).\n")
  cat("   - Lakukan benchmarking dengan restoran 
terdekat yang sukses.\n")
} else {
  cat("   - Kualitas restoran tidak terlalu 
dipengaruhi oleh lokasi tetangga.\n")
  cat("   - Fokus pada kualitas layanan dan produk 
untuk meningkatkan rating.\n")
}


  