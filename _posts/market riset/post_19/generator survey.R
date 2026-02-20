rm(list=ls())
gc()

setwd("~/ikanx101.github.io/_posts/market riset/post_19")

library(dplyr)
library(tidyr)
library(parallel)
library(janitor)

ncore = detectCores()

generate = function(dummy){
  prop_gender = sample(c("Pria","Wanita"),1,prob = c(.5,.5))
  prop_ses    = sample(c("Up","Mid","Low"),1,prob = c(.2,.3,.2))
  usia        = sample(c("< 15 th","16 - 20 th","21 - 25 th","26 - 30 th","> 30 th"),
                       1,prob = c(.1,.15,.35,.2,.1))
  prob_       = ifelse(prop_ses == "Up",.7,
                       ifelse(prop_ses == "Mid",.5,.3))
  prob_       = c(prob_,1-prob_)
  prop_tom    = sample(c("ya","tidak"),1,prob = prob_)
  output = data.frame(gender = prop_gender,
                      ses    = prop_ses,
                      usia   = usia,
                      aware  = prop_tom)
  return(output)
}

id   = 1:365
temp = mclapply(id,generate,mc.cores = ncore)

df_survey = 
  data.table::rbindlist(temp) %>% 
  as.data.frame() %>% 
  mutate_all(as.factor)

df_survey %>% tabyl(aware) %>% adorn_pct_formatting()
df_survey %>% tabyl(ses,aware) %>% adorn_percentages("row") %>% adorn_pct_formatting()
df_survey %>% tabyl(usia,aware) %>% adorn_percentages("row") %>% adorn_pct_formatting()
df_survey %>% tabyl(gender,aware) %>% adorn_percentages("row") %>% adorn_pct_formatting()

# save(df_survey,file = "data_survey.rda")



summary(df_survey)
codebook.syn(df_survey)$tab 

mysyn <- syn(df_survey)

summary(mysyn)
compare(mysyn, df_survey, stat = "counts")


# Well done for getting to here
# Now some extra exploration of mysyn
names(mysyn)
mysyn$method
mysyn$predictor.matrix
mysyn$visit.sequence
mysyn$cont.na

multi.compare(mysyn, df_survey, var = "ses", by = "gender")









  
