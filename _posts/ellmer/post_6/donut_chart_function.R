# Function untuk membuat donut chart dari data tabulasi
# Data harus memiliki kolom: kategori, frekuensi (n), dan persentase (percent)

create_donut_chart <- function(data, 
                              category_col = "psikologi", 
                              value_col = "n", 
                              percent_col = "percent",
                              title = "Donut Chart",
                              subtitle = NULL,
                              colors = c("#FF6B6B", "#4ECDC4", "#45B7D1", "#96CEB4", "#FFEAA7"),
                              show_labels = TRUE,
                              label_size = 4,
                              legend_position = "right") {
  
  # Load required packages
  if (!require(ggplot2)) {
    stop("Package ggplot2 is required. Please install it using install.packages('ggplot2')")
  }
  
  # Validasi data
  if (!all(c(category_col, value_col, percent_col) %in% names(data))) {
    stop("Data harus memiliki kolom kategori, nilai, dan persentase")
  }
  
  # Hitung posisi untuk label
  data <- data %>%
    dplyr::arrange(dplyr::desc(!!sym(category_col))) %>%
    dplyr::mutate(
      ymax = cumsum(!!sym(percent_col)),
      ymin = c(0, head(ymax, n = -1)),
      label_position = (ymax + ymin) / 2,
      label_text = paste0(!!sym(category_col), "\n", 
                         round(!!sym(percent_col) * 100, 1), "%\n", 
                         "(", !!sym(value_col), ")")
    )
  
  # Buat donut chart
  p <- ggplot(data, aes(ymax = ymax, ymin = ymin, 
                       xmax = 4, xmin = 3, 
                       fill = !!sym(category_col))) +
    geom_rect() +
    coord_polar(theta = "y") +
    xlim(c(2, 4)) +
    theme_void() +
    labs(title = title, subtitle = subtitle) +
    scale_fill_manual(values = colors[1:nrow(data)]) +
    theme(
      legend.position = legend_position,
      plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
      plot.subtitle = element_text(hjust = 0.5, size = 12),
      legend.title = element_blank()
    )
  
  # Tambahkan label jika diminta
  if (show_labels) {
    p <- p + 
      geom_text(aes(x = 3.5, y = label_position, 
                   label = label_text), 
               size = label_size, 
               color = "white",
               fontface = "bold")
  }
  
  return(p)
}

# Contoh penggunaan dengan data df_new:
# donut_plot <- create_donut_chart(df_new)
# print(donut_plot)

# Opsi tambahan:
# donut_plot <- create_donut_chart(
#   data = df_new,
#   title = "Distribusi Kondisi Psikologi",
#   subtitle = "Berdasarkan Survey",
#   colors = c("#E74C3C", "#3498DB"),
#   show_labels = TRUE,
#   label_size = 5
# )
