rm(list = ls())

library(dplyr)
library(tidyr)
library(rvest)

url = "https://fbref.com/en/comps/9/Premier-League-Stats"

tabelista =
  url |>
  read_html() |>
  html_table(fill = T)

ikanx = 2
df = tabelista[[ikanx]]
nama_1 = colnames(df)
nama_2 = df[1, ]
colnames(df) = paste(nama_1, nama_2)

df = df[-1, ]
df = df |> janitor::clean_names()

# oke kita bebersih dulu ya
df_clean = 
  df |>
  mutate(
    home_gd = gsub("\\+", "", home_gd),
    home_x_gd = gsub("\\+", "", home_x_gd),
    home_x_gd_90 = gsub("\\+", "", home_x_gd_90),
    away_gd = gsub("\\+", "", away_gd),
    away_x_gd = gsub("\\+", "", away_x_gd),
    away_x_gd_90 = gsub("\\+", "", away_x_gd_90)
  ) |> 
  select(-squad) |> 
  mutate_all(as.numeric) |> 
  mutate(tim = df$squad) |> 
  relocate(tim,.before = "rk")
