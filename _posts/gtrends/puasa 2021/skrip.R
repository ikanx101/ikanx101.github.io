library(gtrendsR)

data = gtrends(c("puasa","ramadhan","sirup","marjan"),geo = "ID")

str(data)

data_int = data$interest_over_time
data_city = data$interest_by_city
data_query = data$related_queries

save(data_int,data_city,data_query,file = "bahan puasa.rda")