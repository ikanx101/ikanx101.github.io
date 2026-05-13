# --- Fig 6: Konsumsi Daging per Jenis di ASEAN (2023) ---
library(ggplot2)
library(dplyr)
library(tidyr)

meat_data <- data.frame(
  Negara = c("Indonesia", "Malaysia", "Thailand", "Vietnam", "Filipina", "Myanmar"),
  Unggas = c(15.95, 51.90, 10.23, 19.65, 15.75, 12.09),
  Sapi = c(3.01, 8.75, 1.45, 5.92, 3.36, 2.65),
  Babi = c(0.56, 7.24, 12.67, 34.37, 14.11, 5.91),
  `Domba/Kambing` = c(0.41, 1.17, 0.04, 0.24, 0.26, 0.22)
)

meat_long <- meat_data %>%
  pivot_longer(cols = -Negara, names_to = "Jenis", values_to = "Konsumsi")

negara_order <- meat_data %>% 
  mutate(Total = Unggas + Sapi + Babi + Domba.Kambing) %>%
  arrange(Total) %>% pull(Negara)
meat_long$Negara <- factor(meat_long$Negara, levels = negara_order)

warna_daging <- c("Unggas" = "#F39C12", "Sapi" = "#E74C3C", 
                  "Babi" = "#9B59B6", "Domba/Kambing" = "#1ABC9C")

p6 <- ggplot(meat_long, aes(x = Negara, y = Konsumsi, fill = Jenis)) +
  geom_bar(stat = "identity", width = 0.7) +
  geom_text(data = meat_data %>%
              mutate(Total = Unggas + Sapi + Babi + Domba.Kambing) %>%
              pivot_longer(cols = c(Unggas, Sapi, Babi, Domba.Kambing), 
                           names_to = "Jenis", values_to = "Konsumsi"),
            aes(label = ifelse(Konsumsi > 2, round(Konsumsi, 1), "")),
            position = position_stack(vjust = 0.5),
            color = "white", size = 3.2, fontface = "bold") +
  # Total labels
  geom_text(data = meat_data %>%
              mutate(Total = Unggas + Sapi + Babi + Domba.Kambing),
            aes(x = Negara, y = Total + 2.5, 
                label = paste0(round(Total, 0), " kg/thn")),
            inherit.aes = FALSE, size = 3.5, fontface = "bold", color = "#2C3E50") +
  coord_flip() +
  scale_fill_manual(values = warna_daging) +
  labs(
    title = "Konsumsi Daging per Kapita di ASEAN",
    subtitle = "Kilogram per tahun — 2023",
    x = NULL,
    y = "Konsumsi (kg/kapita/tahun)",
    fill = "Jenis Daging",
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

ggsave("/home/ikanx101/Documents/sarkopenia/fig6_konsumsi_daging_asean.png", 
       p6, width = 11, height = 6, dpi = 150)
cat("Fig 6 saved.\n")
