rm(list=ls())
gc()

library(dplyr)
library(datarium)
library(PerformanceAnalytics)
library(forecast)
library(DALEX)
library(ggfortify)
par(mfrow=c(1,1)) # reset to 1 chart per page

data(marketing)
sampledf = marketing
str(sampledf)

sampledf %>% head(10)

ts_sales = ts(sampledf$sales, start = 1, frequency = 52)

ts_sales_comp = decompose(ts_sales)

seasonal = ts_sales_comp$seasonal %>% as.numeric()
tren     = ts_sales_comp$trend %>% as.numeric()

tren[is.na(tren)] = 0

# set adstock youtube rate
power_youtube       = .9
set_rate_yt         = 0.25
set_memory          = 2
get_adstock_youtube = rep(set_rate_yt, set_memory+1) ^ c(0:set_memory)

# adstocked youtube
sampledf$youtube = sampledf$youtube ^ power_youtube
ads_youtube = stats::filter(c(rep(0, set_memory), 
                              sampledf$youtube), 
                            get_adstock_youtube, 
                            method="convolution")
ads_youtube = ads_youtube[!is.na(ads_youtube)]

# set adstock fb rate
power_fb       = .8
set_rate_fb    = 0.15
set_memory     = 3
get_adstock_fb = rep(set_rate_fb, set_memory+1) ^ c(0:set_memory)

# adstocked fb
sampledf$facebook = sampledf$facebook ^ power_fb
ads_fb = stats::filter(c(rep(0, set_memory), sampledf$facebook), 
                       get_adstock_fb,
                       method="convolution")
ads_fb = ads_fb[!is.na(ads_fb)]

# set adstock koran
power_news       = .6
set_rate_news    = 0.2
set_memory       = 1
get_adstock_news = rep(set_rate_news, set_memory+1) ^ c(0:set_memory)

#adstocked newpaper
sampledf$newspaper = sampledf$newspaper ^ power_news
ads_news = stats::filter(c(rep(0, set_memory), sampledf$newspaper), 
                         get_adstock_news, 
                         method="convolution")
ads_news = ads_news[!is.na(ads_news)]

df_input = data.frame(sales = sampledf$sales,
                      tren,seasonal,ads_youtube,ads_fb,ads_news)

mmm_model = lm(sales ~ ads_youtube + ads_fb + ads_news,data = df_input,x=TRUE)

# mmm_model = lm(sales ~ poly(tren,3) + poly(seasonal,3) + poly(ads_youtube,3) + 
#                  poly(ads_fb,3) + poly(ads_news,3),data = df_input,x=TRUE)

summary(mmm_model)

library(mctest)
imcdiag(mmm_model, method = "VIF")

par(mfrow=c(2,2)) 
plot(mmm_model)

library(lmtest)
lmtest::bptest(mmm_model)

library(car)
car::ncvTest(mmm_model)

explainer_mmm = DALEX::explain(model = mmm_model,
                               data  = df_input,
                               y     = df_input$sales,
                               type  = "regression",
                               label = "MMM Regression",
                               colorize = FALSE)

performa_model = model_performance(explainer_mmm)
performa_model

var_importante  = model_parts(explainer_mmm)
plot_importance = plot(var_importante,show_boxplots = FALSE)
plot_importance

mp_mmm = model_profile(explainer_mmm, 
                       variable =  c("ads_youtube","ads_fb","ads_news"), 
                       type = "accumulated")
plot(mp_mmm)

ronaldo = 
  df_input %>% 
  filter(sales == max(sales)) %>% 
  select(-sales)
ronaldo = predict_parts(explainer_mmm, ronaldo)
plot(ronaldo)

new = df_input
