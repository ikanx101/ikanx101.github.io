
install.packages("olsrr")

library(tidyverse)
model <- lm(Ozone ~ ., data = airquality)

olsrr::ols_step_all_possible(model) %>% 
  as_tibble()

