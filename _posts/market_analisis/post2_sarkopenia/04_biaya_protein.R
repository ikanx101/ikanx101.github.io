# --- Fig 4: Biaya Protein per Gram ---
library(ggplot2)
library(dplyr)

# Harga pasar di Indonesia (perkiraan 2025)
harga <- data.frame(
  Sumber = c("Tahu Putih", "Tempe", "Ikan Kembung", "Telur Ayam", 
             "Susu HiLo (HP)", "Ayam Broiler", "Susu UHT Biasa", "Daging Sapi"),
  Harga_per_gram = c(250, 260, 195, 415, 400, 211, 480, 700),
  Kategori = c("Nabati", "Nabati", "Hewani (Ikan)", "Hewani", 
               "Hewani (Susu)", "Hewani (Unggas)", "Hewani (Susu)", "Hewani (Daging Merah)")
)

# Order by cost ascending
harga$Sumber <- factor(harga$Sumber, levels = harga$Sumber[order(harga$Harga_per_gram)])

warna_kategori <- c(
  "Nabati" = "#27AE60",
  "Hewani (Ikan)" = "#2980B9",
  "Hewani" = "#E74C3C",
  "Hewani (Unggas)" = "#F39C12",
  "Hewani (Susu)" = "#8E44AD",
  "Hewani (Daging Merah)" = "#C0392B"
)

p4 <- ggplot(harga, aes(x = Sumber, y = Harga_per_gram, fill = Kategori)) +
  geom_bar(stat = "identity", width = 0.65) +
  geom_text(aes(label = paste0("Rp ", Harga_per_gram, "/g")),
            hjust = -0.1, size = 4, fontface = "bold") +
  coord_flip() +
  scale_fill_manual(values = warna_kategori) +
  scale_y_continuous(limits = c(0, 800), expand = c(0, 0)) +
  labs(
    title = "Biaya per Gram Protein: Sumber Termurah vs Termahal",
    subtitle = "Perbandingan harga per gram protein di pasar Indonesia (estimasi 2025)",
    x = NULL,
    y = "Rupiah per gram protein (Rp/g)",
    fill = "Kategori",
    caption = "Estimasi: harga pasar Indonesia 2024-2025\nProtein content berdasarkan USDA FoodData Central & DKBM"
  ) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#2C3E50"),
    plot.subtitle = element_text(size = 10, color = "#7F8C8D"),
    axis.text.y = element_text(size = 11, face = "bold"),
    legend.position = "bottom",
    plot.caption = element_text(size = 8, color = "#95A5A6")
  )

ggsave("/home/ikanx101/Documents/sarkopenia/fig4_biaya_protein.png", 
       p4, width = 10, height = 6, dpi = 150)
cat("Fig 4 saved.\n")
