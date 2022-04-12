rm(list=ls())

library(dplyr)
library(rvest)

url = "https://dapo.kemdikbud.go.id/sp"

url %>%
  read_html() %>%
  html_table(fill = T)

