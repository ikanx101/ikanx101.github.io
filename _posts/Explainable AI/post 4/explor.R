setwd("~/ikanx101 BLOG/_posts/Explainable AI/post 4")

rm(list=ls())

library(tidyr)
library(dplyr)

data = read.csv("dbase.csv") %>% janitor::clean_names()

str(data)

data_sel = 
  data %>% 
  select(country_name,
         regional_indicator,
         ladder_score,
         logged_gdp_per_capita,
         social_support,
         healthy_life_expectancy,
         freedom_to_make_life_choices,
         generosity,
         perceptions_of_corruption)

# by region happiness
by_region_happiness = 
  data_sel %>% 
  group_by(regional_indicator) %>% 
  summarise(mean = mean(ladder_score)) %>% 
  ungroup() %>% 
  arrange(desc(mean))

# by country happiness
by_country_happiness = 
  data_sel %>% 
  select(country_name,ladder_score) %>% 
  arrange(desc(ladder_score))

# by country generosity
by_country_generosity = 
  data_sel %>% 
  select(country_name,generosity) %>% 
  arrange(desc(generosity))

# regression
data_reg = 
  data_sel %>% 
  select(-country_name,-regional_indicator)

# model regresi 1
model_1 = lm(formula = "ladder_score ~ . - generosity", data_reg)
summary(model_1)
rmse = caret::RMSE(model_1$fitted.values,data_reg$ladder_score)

# save hasil kerjaan dulu
save(data,
     by_country_happiness,
     by_country_generosity,
     by_region_happiness,
     data_reg,
     data_sel,
     model_1,
     file = "bahan_blog.rda")