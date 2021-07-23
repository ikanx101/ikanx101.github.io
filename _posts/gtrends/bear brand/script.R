library(gtrendsR)

data = gtrends(c("bakmi","mie ayam"),geo = "ID")

str(data)

data_int = data$interest_over_time
data_city = data$interest_by_city
data_query = data$related_queries

save(data,data_int,data_city,data_query,file = "bahan blog.rda")

library(ggplot2)
data_city %>% 
  filter(!is.na(hits)) %>% 
  ggplot(aes(y = reorder(location,hits),
             x = hits,
             fill = keyword)) +
  geom_col() +
  theme_minimal() +
  labs(title = "Trend Pencarian Bakmi dan Mie Ayam per Kota",
       subtitle = "source: Google Trends 9 Juli 2021 14:30 WIB") +
  theme(axis.title = element_blank())
