rm(list=ls())
gc()

library(tidyverse)
library(ellmer)
library(jsonlite)
library(rvest)
library(getwiki)
library(btw)


sistem = "Generate tabular data based on the user's request. Limit the data to 300 rows unless the user specifically requests more.

Generate the data in a format that is readable by the R function `readr::read_csv()`. For example:

TransactionID, Make, Model, Year, Price, Salesperson
001, Toyota, Camry, 2020, 24000, John Smith
002, Honda, Accord, 2019, 22000, Jane Doe
003, Ford, Explorer, 2021, 32000, Emily Johnson
004, Chevrolet, Malibu, 2020, 23000, Michael Brown
005, Nissan, Altima, 2021, 25000, Sarah Davis
006, Hyundai, Elantra, 2019, 19000, David Wilson
007, BMW, X3, 2020, 42000, Mary White
008, Audi, A4, 2021, 38000, Robert Martinez
009, Subaru, Outback, 2020, 27000, James Lee
010, Kia, Soul, 2021, 21000, Linda Thompson

Do not include any text formatting in the data (e.g., no backticks).

Do not include any other information with the dataset. "

model_1 = "deepseek-chat"

generate_data <- function(data_description) {
  chat = chat_deepseek(system_prompt = sistem,
                       model         = model_1)
  
  csv_string <- chat$chat(data_description, echo = FALSE) 
  
  readr::read_csv(csv_string, show_col_types = FALSE)
}

df = generate_data("Data survey 300 baris orang berisi demografi (usia, tingkat ekonomi, tingkat pendidikan, gender), nilai tes kemampuan akademis (skala 1-100), dan nilai tes kemampuan berbahasa inggris (skala 1-100). Kaitkan nilai tes ini dengan tingkat pendidikan dan tingkat ekonomi setiap orang.")

save(df,file = "data.rda")
