# ==============================================================================
setwd("~/ikanx101.github.io/_posts/linear problem/post 18 - training")

rm(list=ls())

library(readxl)
library(janitor)
library(parallel)
library(dplyr)
library(tidyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

n_core = detectCores()
# ==============================================================================

# ==============================================================================
# ambil data dulu
file = "save.xlsx"

df = read_excel(file) %>% janitor::clean_names()

df = 
  df %>% 
  mutate(gol_select = ifelse(golongan %in% c("MGR","ASM","SPC"),
                             "manager",
                             "non manager"),
         work_select = ifelse(work_location %in% c("Rawabali","Jakarta"),
                              "Head office",
                              "Other")
         )


id_sel = sample(284,100) %>% sort()

df = df[id_sel,]
df$id = 1:100
df$nama = NULL
save(df,file = "saved data.rda")

df %>% tabyl(gol_select,work_select)
