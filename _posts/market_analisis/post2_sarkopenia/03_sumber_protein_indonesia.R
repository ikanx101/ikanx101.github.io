# --- Fig 3: Sumber Protein Indonesia donut chart ---
library(ggplot2)
library(dplyr)

# Sumber protein Indonesia detail
protein_detail <- data.frame(
  Sumber = c("Ikan & Seafood", "Unggas", "Telur", "Susu", "Sapi", "Babi", "Domba", "Lainnya Hewani", 
             "Nabati (Tahu, Tempe, Beras, dll)"),
  Protein_g = c(12.8, 8.5, 2.8, 2.5, 1.8, 0.3, 0.2, 1.07, 47.83)
)

warna_detail <- c(
  "Ikan & Seafood" = "#2980B9",
  "Unggas" = "#F39C12",
  "Telur" = "#F1C40F",
  "Susu" = "#ECF0F1",
  "Sapi" = "#E74C3C",
  "Babi" = "#9B59B6",
  "Domba" = "#1ABC9C",
  "Lainnya Hewani" = "#95A5A6",
  "Nabati (Tahu, Tempe, Beras, dll)" = "#27AE60"
)

# Add category
protein_detail$Kategori <- ifelse(protein_detail$Sumber == "Nabati (Tahu, Tempe, Beras, dll)", 
                                   "Nabati", "Hewani")

# Donut chart - first group by kategori
kategori_sum <- protein_detail %>%
  group_by(Kategori) %>%
  summarise(Protein = sum(Protein_g)) %>%
  mutate(
    prop = Protein / sum(Protein) * 100,
    ymax = cumsum(prop),
    ymin = c(0, head(ymax, n = -1)),
    label_pos = (ymin + ymax) / 2,
    label = paste0(Kategori, "\n", round(prop, 1), "%\n(", round(Protein, 1), " g)")
  )

p3 <- ggplot(kategori_sum, aes(x = 2, y = prop, fill = Kategori)) +
  geom_bar(stat = "identity", width = 0.8, color = "white") +
  geom_text(aes(y = label_pos, label = label), size = 4.5, fontface = "bold") +
  coord_polar(theta = "y", start = 0) +
  xlim(0.5, 2.5) +
  scale_fill_manual(values = c("Hewani" = "#E74C3C", "Nabati" = "#27AE60")) +
  labs(
    title = "Komposisi Sumber Protein Indonesia",
    subtitle = "Pasokan Protein per Kapita per Hari — 2023",
    fill = NULL,
    caption = "Sumber: FAO via Our World in Data (2023)\n*Hewani: ikan, unggas, telur, susu, daging"
  ) +
  theme_void(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#2C3E50", hjust = 0.5),
    plot.subtitle = element_text(size = 10, color = "#7F8C8D", hjust = 0.5),
    legend.position = "none",
    plot.caption = element_text(size = 8, color = "#95A5A6", hjust = 0.5)
  )

ggsave("/home/ikanx101/Documents/sarkopenia/fig3_sumber_protein_indonesia.png", 
       p3, width = 8, height = 7, dpi = 150)
cat("Fig 3 saved.\n")
