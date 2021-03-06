setwd("~/ikanx101.github.io/_posts/Soapy NDSC/Shopee Code League 2021/week 1")

rm(list=ls())
library(jsonlite)
library(dplyr)
library(tidyr)
library(stringr)

load("all.rda")

n = length(data)

sample_n = sort(sample(n,20,replace = F))

id = c()
email = c()
phone = c()
contact = c()
order_id = c()

for(i in 1:n){
  temp = data[[i]]
  id[i] = temp$Id
  email[i] = temp$Email
  phone[i] = temp$Phone
  contact[i] = temp$Contacts
  order_id[i] = temp$OrderId
}

data_new = data.frame(id,email,phone,contact,order_id)

cek = function(i){
  email_find = data_new$email[i]
  n_email_find = str_length(email_find)
  if(n_email_find > 0){
    d_1 = data_new %>% filter(email == email_find)
  } else(d_1 = data.frame())
  
  phone_find = data_new$phone[i]
  n_phone_find = str_length(phone_find)
  if(n_phone_find > 0){
    d_2 = data_new %>% filter(phone == phone_find)
  } else(d_2 = data.frame())
  
  order_id_find = data_new$order_id[i]
  n_order_id_find = str_length(order_id_find)
  if(n_phone_find > 0){
    d_3 = data_new %>% filter(order_id == order_id_find)
  } else(d_3 = data.frame())
  
  final = rbind(d_1,d_2)
  final = rbind(final,d_3)
  final$ticket_id = i-1
  
  final = 
    final %>% 
    arrange(ticket_id) %>% 
    group_by(ticket_id) %>% 
    summarise(p1 = paste(id,collapse = "-"),
              p2 = sum(contact)) %>% 
    ungroup() %>% 
    mutate(`ticket_trace/contact` = paste(p1,p2,sep = ",")) %>% 
    select(-p1,-p2)
  
  return(final)
}

hasil_final = data.frame()

for(i in sample_n){
  temp_x = cek(i)
  hasil_final = rbind(temp_x,hasil_final)
  print(i)
}

all_d=ls()
save(all_d,file = "all.rda")