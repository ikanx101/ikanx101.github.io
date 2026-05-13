# --- Fig 1: Paradoks Protein ASEAN ---
library(ggplot2)
library(dplyr)
library(tidyr)

# Data: Total, Animal, Plant Protein (g/capita/day, 2023)
protein_data <- data.frame(
  Negara = c("Indonesia", "Malaysia", "Thailand", "Vietnam", "Filipina", "Myanmar"),
  Total = c(77.8, 93.33, 68.63, 102.2, 77.49, 78.39),
  Hewani = c(29.97, 54.65, 27.18, 43.23, 28.56, 23.06),
  Nabati = c(47.83, 38.68, 41.45, 58.97, 48.93, 55.32)
)

# Reshape for ggplot
protein_long <- protein_data %>%
  select(Negara, Hewani, Nabati) %>%
  pivot_longer(cols = c(Hewani, Nabati), names_to = "Sumber", values_to = "Protein")

# Order negara by total protein descending
negara_order <- protein_data %>% arrange(desc(Total)) %>% pull(Negara)
protein_long$Negara <- factor(protein_long$Negara, levels = rev(negara_order))

# Colors
warna <- c("Hewani" = "#E74C3C", "Nabati" = "#27AE60")

p1 <- ggplot(protein_long, aes(x = Negara, y = Protein, fill = Sumber)) +
  geom_bar(stat = "identity", width = 0.7) +
  geom_text(data = protein_data %>% pivot_longer(cols = c(Hewani, Nabati), names_to = "Sumber", values_to = "Protein"),
            aes(label = paste0(round(Protein, 0), "g")),
            position = position_stack(vjust = 0.5),
            color = "white", size = 3.5, fontface = "bold") +
  # Add total labels at top
  geom_text(data = protein_data,
            aes(x = Negara, y = Total + 3, label = paste0("Total: ", Total, " g")),
            inherit.aes = FALSE, size = 3, color = "#2C3E50", fontface = "bold") +
  coord_flip() +
  scale_fill_manual(values = warna, labels = c("Hewani", "Nabati")) +
  labs(
    title = "Paradoks Protein Indonesia",
    subtitle = "Pasokan Protein per Kapita per Hari (gram) — ASEAN, 2023",
    x = NULL,
    y = "Protein (gram/hari)",
    fill = "Sumber Protein",
    caption = "Sumber: FAO via Our World in Data (2023)"
  ) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#2C3E50"),
    plot.subtitle = element_text(size = 10, color = "#7F8C8D"),
    axis.text.y = element_text(size = 11, face = "bold"),
    legend.position = "bottom",
    plot.caption = element_text(size = 8, color = "#95A5A6")
  )

ggsave("/home/ikanx101/Documents/sarkopenia/fig1_paradoks_protein.png", 
       p1, width = 10, height = 6, dpi = 150)
cat("Fig 1 saved.\n")
