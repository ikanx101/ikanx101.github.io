rm(list=ls())
gc()

setwd("~/ikanx101.github.io/_posts/matematika ITB/meta robyn/part 2")

library(dplyr)
library(tidyr)
library(datarium)
library(Robyn)

Sys.setenv(R_FUTURE_FORK_ENABLE = "true")
options(future.fork.enable = TRUE)

packageVersion("Robyn")

data(marketing)
sampledf = marketing

Sys.setenv(R_FUTURE_FORK_ENABLE = "true")
options(future.fork.enable = TRUE)

start_date       = as.Date("2021-01-01")
week_start_dates = seq(from = start_date, by = "week", length.out = 200)
sampledf$date    = week_start_dates

data("dt_prophet_holidays")
head(dt_prophet_holidays)

# Directory where you want to export results to (will create new folders)
robyn_directory <- "~/ikanx101.github.io/_posts/matematika ITB/meta robyn/part 2/output"

InputCollect <- robyn_inputs(
  dt_input = sampledf,
  dt_holidays = dt_prophet_holidays,
  date_var = "date", # date format must be "2020-01-01"
  dep_var = "sales", # currently one dependent variable allowed
  dep_var_type = "revenue", # "revenue" or "conversion" allowed
  prophet_vars = c("trend", "season", "holiday"), # "trend","season", "weekday" & "holiday" allowed
  prophet_country = "ID", # 123 countries included in dt_prophet_holidays
  paid_media_spends = c("youtube","facebook","newspaper"), # mandatory input
  window_start = "2021-01-01",
  window_end = "2024-10-25",
  adstock = "geometric" # geometric or weibull_pdf
)
print(InputCollect)

hyper_limits()

hyper_names(adstock = InputCollect$adstock, all_media = InputCollect$all_media)

hyperparameters <- list(
  facebook_alphas = c(0.1, 2),
  facebook_gammas = c(0.1, 0.4),
  facebook_thetas = c(0.1, 0.5),
  newspaper_alphas = c(0.1, 2),
  newspaper_gammas = c(0.1, 0.4),
  newspaper_thetas = c(0.1, 0.5),
  youtube_alphas = c(0.1, 2),
  youtube_gammas = c(0.1, 0.4),
  youtube_thetas = c(0.1, 0.5),
  train_size = c(0.5, 0.8)
)

InputCollect <- robyn_inputs(InputCollect = InputCollect, hyperparameters = hyperparameters)
print(InputCollect)

OutputModels <- robyn_run(
  InputCollect = InputCollect, # feed in all model specification
  cores = NULL, # NULL defaults to (max available - 1)
  iterations = 2000, # 2000 recommended for the dummy dataset with no calibration
  trials = 5, # 5 recommended for the dummy dataset
  ts_validation = FALSE, # 3-way-split time series for NRMSE validation.
  add_penalty_factor = FALSE # Experimental feature to add more flexibility
)
print(OutputModels)

OutputCollect <- robyn_outputs(
  InputCollect, OutputModels,
  pareto_fronts = "auto", # automatically pick how many pareto-fronts to fill min_candidates (100)
  # min_candidates = 100, # top pareto models for clustering. Default to 100
  # calibration_constraint = 0.1, # range c(0.01, 0.1) & default at 0.1
  csv_out = "pareto", # "pareto", "all", or NULL (for none)
  clusters = TRUE, # Set to TRUE to cluster similar models by ROAS. See ?robyn_clusters
  export = TRUE, # this will create files locally
  plot_folder = robyn_directory, # path for plots exports and files creation
  plot_pareto = TRUE # Set to FALSE to deactivate plotting and saving model one-pagers
)
print(OutputCollect)

save(sampledf,file = "ready.rda")




select_model <- "2_34_6"
ExportedModel <- robyn_write(InputCollect, OutputCollect, select_model, export = TRUE)
print(ExportedModel)
myOnePager <- robyn_onepagers(InputCollect, OutputCollect, select_model, export = FALSE)


myOnePager$`2_34_6`
myOnePager[[select_model]]$patches$plots[[1]]
myOnePager[[select_model]]$patches$plots[[2]]
myOnePager[[select_model]]$patches$plots[[3]]
myOnePager[[select_model]]$patches$plots[[4]]


AllocatorCollect3 <- robyn_allocator(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  #channel_constr_low = 0.1,
  #channel_constr_up = 10,
  # date_range = NULL, # Default: "all" available dates
  scenario = "max_response",
  # target_value = 5 # Customize target ROAS or CPA value
)
print(AllocatorCollect3)
plot(AllocatorCollect3)


