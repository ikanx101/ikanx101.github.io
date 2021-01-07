# set working directory
setwd("~/Documents/ikanx101/_posts/Explainable AI/post 1")

# all is set
rm(list=ls())
library(dplyr)
library(keras)
library(tensorflow)
library(DALEX)
library(caret)

# importir data
raw_data = read.csv("FIFA_data.csv") %>% janitor::clean_names()

# cleaning
data = 
  raw_data %>% 
  select(name,age,position,value,crossing,finishing,
         dribbling,ball_control,acceleration,agility,reactions,balance,shot_power,
         stamina,strength,positioning,vision) %>% 
  rename(target = value) %>% 
  filter(position != "GK") %>% 
  filter(!grepl("B",position)) %>% 
  filter(grepl("M",target)) %>% 
  mutate(target = gsub("€|M","",target),
         target = as.numeric(target)) %>% 
  select(-position) %>% 
  filter(target >= 15)

# set the target
nama = data$name
data_1 = data %>% select(-name)

# preparation
preProcess_range_model = preProcess(data_1, method='range')
data_1_new = predict(preProcess_range_model, newdata = data_1) 
data_2 = data_1_new %>% mutate(nama = nama) %>% relocate(target,.before = nama)
target = data_2$target

# kita bagi dua dataset
set.seed(10104074)
id = sample(341,290,replace = F)
train_df = data_2[id,]
test_df = data_2[-id,]

# membuat matrix agar siap jadi neural net
# train matrix
train_label_raw = train_df$target
train_matrix = as.matrix(train_df[-15:-16])
# test matrix
test_label_raw = test_df$target
test_matrix = as.matrix(test_df[-15:-16])

# model KERAS
model = keras_model_sequential()
model %>%
  layer_dense(units = 86,activation = 'relu',
              input_shape = c(ncol(train_matrix))) %>%
  layer_dense(units = 21, activation = 'sigmoid') %>%
  layer_dense(units = 19, activation = 'sigmoid') %>%
  layer_dense(units = 12, activation = 'relu') %>%
  layer_dense(units = 1)
summary(model)

# optimizer
model %>% compile(
  loss='mse',
  optimizer = optimizer_rmsprop(),
  metrics =  list("mean_absolute_error")
)

# training epoch
fitModel =
  model %>%
  fit(train_matrix,
      train_label_raw,
      epochs = 150,
      batch_size = 15,
      validation_split = 0.15)

plot_model_keras = plot(fitModel)

# prediction
# train
train_predictions <- model %>% predict(train_matrix)
train_predictions = train_predictions[,1]
#test
test_predictions = model %>% predict(test_matrix)
test_predictions = test_predictions[,1]

# =======================================
# DALEX mode: on
# create explainer
explainer_model_keras <- DALEX::explain(model = model,
                                        data = test_matrix,
                                        y = test_label_raw,
                                        type = "regression",
                                        label = "Keras Regression",
                                        colorize = FALSE)

# model explainer
performa_model = model_performance(explainer_model_keras)
performa_model

# variable importance
var_importante = model_parts(explainer_model_keras)
plot_importance = plot(var_importante,show_boxplots = FALSE)

# model profile
mp_ball = model_profile(explainer_model_keras, 
                        variable =  c("reactions","ball_control","finishing","vision","age"), 
                        type = "accumulated")
plot(mp_ball)

# cek with new data
ronaldo = 
  data_2 %>% 
  filter(nama == "Cristiano Ronaldo") %>% 
  select(-nama,-target)
ronaldo = as.matrix(ronaldo)
ronaldo = predict_parts(explainer_model_keras, ronaldo)
plot(ronaldo)

# cek with new data
messi = 
  data_2 %>% 
  filter(nama == "L. Messi") %>% 
  select(-nama,-target)
messi = as.matrix(messi)
messi = predict_parts(explainer_model_keras, messi)
plot(messi)

# cek with new data
bruno = 
  data_2 %>% 
  filter(nama == "Bruno Fernandes") %>% 
  select(-nama,-target)
bruno = as.matrix(bruno)
bruno = predict_parts(explainer_model_keras, bruno)
plot(bruno)

save(data,
     data_2,
     plot_model_keras,
     performa_model,
     plot_importance,
     explainer_model_keras,
     mp_ball,
     ronaldo,messi,bruno,
     file = "bahan blog.rda")