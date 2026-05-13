# --- Fig 2: Konsumsi Daging vs Protein Hewani + Total Daging per Jenis ---
library(ggplot2)
library(dplyr)
library(tidyr)

# Meat consumption by type (kg/capita/year, 2023)
meat_data <- data.frame(
  Negara = c("Indonesia", "Malaysia", "Thailand", "Vietnam", "Filipina", "Myanmar"),
  Unggas = c(15.95, 51.90, 10.23, 19.65, 15.75, 12.09),
  Sapi = c(3.01, 8.75, 1.45, 5.92, 3.36, 2.65),
  Babi = c(0.56, 7.24, 12.67, 34.37, 14.11, 5.91),
  Domba = c(0.41, 1.17, 0.04, 0.24, 0.26, 0.22),
  Lainnya = c(0.01, 0.02, 0.09, 0.29, 0.16, 0)
)

meat_data$Total_Daging <- rowSums(meat_data[,2:6])

# Animal protein (g/day)
animal_protein <- data.frame(
  Negara = c("Indonesia", "Malaysia", "Thailand", "Vietnam", "Filipina", "Myanmar"),
  Protein_Hewani = c(29.97, 54.65, 27.18, 43.23, 28.56, 23.06)
)

# Merge
combined <- merge(meat_data, animal_protein, by = "Negara")

# Reshape meat for stacked bar
meat_long <- meat_data %>%
  select(Negara, Unggas, Sapi, Babi, Domba) %>%
  pivot_longer(cols = c(Unggas, Sapi, Babi, Domba), names_to = "Jenis", values_to = "Konsumsi")

negara_order <- combined %>% arrange(Total_Daging) %>% pull(Negara)
meat_long$Negara <- factor(meat_long$Negara, levels = negara_order)
combined$Negara <- factor(combined$Negara, levels = negara_order)

warna_daging <- c("Unggas" = "#F39C12", "Sapi" = "#E74C3C", "Babi" = "#9B59B6", "Domba" = "#1ABC9C")

p2 <- ggplot() +
  # Stacked bar for meat consumption
  geom_bar(data = meat_long, 
           aes(x = Negara, y = Konsumsi, fill = Jenis),
           stat = "identity", width = 0.65, alpha = 0.85) +
  # Point + line for animal protein
  geom_point(data = combined,
             aes(x = Negara, y = Protein_Hewani * 1.5, color = "Protein Hewani (g/hari)"),
             size = 4) +
  geom_line(data = combined,
            aes(x = Negara, y = Protein_Hewani * 1.5, color = "Protein Hewani (g/hari)", group = 1),
            linewidth = 1.2) +
  # Labels for animal protein
  geom_text(data = combined,
            aes(x = Negara, y = Protein_Hewani * 1.5 + 3, 
                label = paste0(round(Protein_Hewani, 0), " g")),
            size = 3.2, color = "#2C3E50", fontface = "bold") +
  # Dual axis
  scale_y_continuous(
    name = "Konsumsi Daging (kg/kapita/tahun)",
    sec.axis = sec_axis(~ ./1.5, name = "Protein Hewani (g/hari)")
  ) +
  scale_fill_manual(values = warna_daging) +
  scale_color_manual(values = c("Protein Hewani (g/hari)" = "#2980B9")) +
  labs(
    title = "Konsumsi Daging vs Protein Hewani",
    subtitle = "Negara ASEAN — 2023",
    x = NULL,
    y = "Konsumsi Daging (kg/kapita/tahun)",
    fill = "Jenis Daging",
    color = NULL,
    caption = "Sumber: FAO via Our World in Data (2023)"
  ) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#2C3E50"),
    plot.subtitle = element_text(size = 10, color = "#7F8C8D"),
    axis.text.x = element_text(size = 11, face = "bold"),
    axis.title.y.left = element_text(color = "#2C3E50"),
    axis.title.y.right = element_text(color = "#2980B9"),
    legend.position = "bottom",
    plot.caption = element_text(size = 8, color = "#95A5A6")
  )

ggsave("/home/ikanx101/Documents/sarkopenia/fig2_konsumsi_daging_vs_protein.png", 
       p2, width = 11, height = 6.5, dpi = 150)
cat("Fig 2 saved.\n")
