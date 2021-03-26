setwd("~/Documents/ikanx101/_posts/Explainable AI/post 2")

# all is set
rm(list=ls())
library(dplyr)
library(keras)
library(tensorflow)
library(DALEX)
library(caret)
library(pROC)
set.seed(211286)

data = read.csv("diabetes.csv") %>% janitor::clean_names() 

# preparation
save_dulu = data$outcome
data =
  data %>%
  select(-blood_pressure,-skin_thickness,-outcome,-insulin)

preProcess_range_model = preProcess(data, method='range')
data = predict(preProcess_range_model, newdata = data) #variabel targetnya hilang di sini
data$outcome = save_dulu

# kita pisah pecah dua
data_0 = 
  data %>% 
  filter(outcome == 0)
data_1 = 
  data %>% 
  filter(outcome == 1)

# set minimal n for train data
set.seed(10104074)
n = 180

id_0 = sample(nrow(data_0),n,replace = F)
data_0_1 = data_0[id_0,]
data_0_2 = data_0[-id_0,]

id_1 = sample(nrow(data_1),n,replace = F)
data_1_1 = data_1[id_1,]
data_1_2 = data_1[-id_1,]

# set train and test
train_df = rbind(data_0_1,data_1_1)
test_df = rbind(data_0_2,data_1_2)

# let's see
# train
train_label_raw = train_df$outcome
train_label_clean = to_categorical(train_label_raw)
train_matrix = as.matrix(train_df[-ncol(train_df)])

# test
test_label_raw = test_df$outcome
test_label_clean = to_categorical(test_label_raw)
test_matrix = as.matrix(test_df[-ncol(train_df)])


model = keras_model_sequential()
model %>%
  layer_dense(units = 400,activation = 'relu',
              input_shape = c(ncol(train_matrix))) %>%
  layer_dense(units = 200, activation = 'sigmoid') %>%
  layer_dense(units = 100, activation = 'sigmoid') %>%
  layer_dense(units = 50, activation = 'relu') %>%
  layer_dense(units = 2, activation = 'sigmoid')

summary(model)

model %>% compile(
  loss='binary_crossentropy',
  optimizer='adam',
  metrics=c('accuracy')
)

fitModel =
  model %>%
  fit(train_matrix,
      train_label_clean,
      epochs = 300,
      batch_size = 75,
      validation_split = 0.35)

# Pakai train
pred_train = model %>% predict_classes(train_matrix)
table(pred_train,train_label_raw)
mean(train_label_raw == pred_train)

# Pakai test
pred_test = model %>% predict_classes(test_matrix)
table(pred_test,test_label_raw)
mean(test_label_raw == pred_test)

roc_obj = roc(as.numeric(test_label_raw), as.numeric(pred_test))
auc(roc_obj)

# range - 71.34
# range 0.7511 n = 180
# model
#model %>% save_model_tf("model final")
#model <- load_model_tf("model 1")

# =======================================
# DALEX mode: on
# create explainer
explainer_model_keras <- DALEX::explain(model = model,
                                        data = test_matrix,
                                        y = test_label_raw,
                                        type = "classification",
                                        label = "Keras Prediction",
                                        colorize = FALSE)

# model explainer
performa_model = model_performance(explainer_model_keras)
performa_model

# variable importance
var_importante = model_parts(explainer_model_keras)
plot_importance = plot(var_importante,show_boxplots = FALSE)

# model profile
mp_ball = model_profile(explainer_model_keras, 
                        variable =  c("pregnancies","age","bmi",
                                      "glucose"), 
                        type = "accumulated")


save(performa_model,
     plot_importance,
     explainer_model_keras,
     mp_ball,
     file = "bahan blog.rda")
