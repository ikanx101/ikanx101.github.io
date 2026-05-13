# --- Fig 5: Prevalensi Sarcopenia di Indonesia ---
library(ggplot2)
library(dplyr)

# Data dari studi
sarc_data <- data.frame(
  Studi = c("ILAS 2023\n(Halilintar et al.)", 
            "Systematic Review\n(Setiati et al.)",
            "West Jakarta\n(PMC12051965)",
            "Global Rata-rata\n(Meta-analysis)"),
  Prevalensi = c(51.1, 31.0, 45.5, 24.5),
  Kategori = c("Indonesia", "Indonesia", "Indonesia", "Global")
)

warna_sarc <- c("Indonesia" = "#E74C3C", "Global" = "#3498DB")

p5 <- ggplot(sarc_data, aes(x = Studi, y = Prevalensi, fill = Kategori)) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_text(aes(label = paste0(round(Prevalensi, 1), "%")),
            vjust = -0.5, size = 5, fontface = "bold") +
  scale_fill_manual(values = warna_sarc) +
  scale_y_continuous(limits = c(0, 60), expand = c(0, 0)) +
  labs(
    title = "Prevalensi Sarcopenia pada Lansia (≥60 Tahun)",
    subtitle = "Indonesia vs Global — Perbandingan Antar Studi",
    x = NULL,
    y = "Prevalensi (%)",
    fill = NULL,
    caption = "Sumber: Halilintar et al. (ILAS 2023); Setiati et al. (Systematic Review); PMC12051965 (2024); Petermann-Rocha et al. (Global Meta-analysis, 2022)"
  ) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#2C3E50"),
    plot.subtitle = element_text(size = 10, color = "#7F8C8D"),
    axis.text.x = element_text(size = 10, face = "bold"),
    legend.position = "bottom",
    plot.caption = element_text(size = 7.5, color = "#95A5A6")
  )

ggsave("/home/ikanx101/Documents/sarkopenia/fig5_prevalensi_sarcopenia.png", 
       p5, width = 10, height = 6.5, dpi = 150)
cat("Fig 5 saved.\n")
