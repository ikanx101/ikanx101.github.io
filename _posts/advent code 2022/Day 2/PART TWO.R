# dimulai dari hati yang suci
rm(list=ls())
# libraries
library(dplyr)
library(tidyr)
# import data
df = readLines("input.txt")

# perubahan yang terjadi:
 # X means you need to lose, 
 # Y means you need to end the round in a draw, 
 # and Z means you need to win. 

# kita ubah ke data frame ya
df = 
  data.frame(dummy = df) %>%
  separate(dummy,into = c("oppo","status"),sep = " ") %>%
  # kita akan ubah status sesuai dengan perkataan elf
  mutate(status = case_when(
    status == "X" ~ "lost",
    status == "Y" ~ "draw",
    status == "Z" ~ "win"
  )) %>% 
  mutate(our = case_when(
    status == "draw" ~ oppo,
    oppo == "A" & status == "lost" ~ "C", # scissor
    oppo == "A" & status == "win" ~ "B", # paper
    oppo == "B" & status == "lost" ~ "A", # rock
    oppo == "B" & status == "win" ~ "C", # scissor
    oppo == "C" & status == "lost" ~ "B", # paper
    oppo == "C" & status == "win" ~ "A" # rock
  )) %>% 

  # hitung skor dari hand sign
  mutate(skor_1 = case_when(
    our == "A" ~ 1,
    our == "B" ~ 2,
    our == "C" ~ 3
  )) %>%
  # menentukan menang atau tidak
  mutate(status = case_when(
    # A for Rock, B for Paper, and C for Scissors
    our == oppo ~ "Draw",
    our == "A" & oppo == "C" ~ "Win",
    our == "B" & oppo == "A" ~ "Win",
    our == "C" & oppo == "B" ~ "Win"
  )) %>%
  mutate(status = ifelse(is.na(status),"Lost",status)) %>%
  # hitung skor hasil pertandingan
  mutate(skor_2 = case_when(
    # 0 if you lost, 3 if the round was a draw, and 6 if you won
    status == "Lost" ~ 0,
    status == "Draw" ~ 3,
    status == "Win" ~ 6
  )) %>%
  mutate(skor_total = skor_1 + skor_2)

# moment of truth
sum(df$skor_total)