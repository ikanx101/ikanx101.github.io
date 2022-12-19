setwd("~/Ikanx 101 Blog/_posts/advent code 2022/Day 4")

rm(list=ls())

library(dplyr)
library(tidyr)

df = readLines("input.txt")
sum_hasil = rep(0,length(df))

for(i in 1:length(df)){
  hasil = 0
  tes = df[i]
  temp = strsplit(tes,split = "\\,") %>% unlist()
  elf_1 = strsplit(temp[1],split = "\\-") %>% unlist()
  elf_2 = strsplit(temp[2],split = "\\-") %>% unlist()
  
  elf_1_number = elf_1[1] : elf_1[2]
  elf_2_number = elf_2[1] : elf_2[2]
  
  marker_1 = sum(elf_1_number %in% elf_2_number) == length(elf_1_number)
  marker_2 = sum(elf_2_number %in% elf_1_number) == length(elf_2_number)
  
  if(marker_1 | marker_2){hasil = 1}
  
  sum_hasil[i] = hasil
}


sum_hasil %>% sum()
