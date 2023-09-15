# mulai dari awal
setwd("~/ikanx101.github.io/_posts/huggingface/summarization")
rm(list=ls())

# libraries
library(dplyr)
library(tidytext)
library(stringdist)
library(TSP)

data = "After helping Bruce Wayne / Batman and Diana Prince / Wonder Woman stop a robbery in Gotham City, Barry Allen revisits his childhood home, where he lived with his parents Nora and Henry, before Henry’s wrongful imprisonment for Nora’s murder. On the day of her death, Nora sent Henry to the grocery store for a can of tomatoes that she forgot to buy, leaving her alone in the kitchen, resulting in her being killed by an unidentified assailant. Overcome by emotions, Barry accidentally uses the Speed Force to form a Chronobowl and travel back in time earlier in the day. Despite Bruce’s warnings of time travel’s unintended consequences, Barry time travels and places the can of tomatoes in Nora’s cart at the store, so that his father will not have to leave the house. As he returns to the present, Barry is knocked out of the Chronobowl by an unknown speedster and ends up in a 2013 where Nora is alive. He encounters his parents, his past self, and realizes this is the day he originally obtained his powers.
In order to make sure his past self gains superpowers, the two Barrys go to the Central City Police Department, where Barry re-enacts the event for 2013-Barry to be struck by lightning. Both end up getting struck by the lightning, giving 2013-Barry powers, but causing Barry to lose his own. As Barry struggles to train 2013-Barry on properly using his powers, they learn that General Zod is preparing to invade Earth.[c] In an effort to fight Zod, the Barrys attempt to assemble the Justice League but are unsuccessful; in their timeline, they cannot locate Diana, Victor Stone has not gained his abilities yet, and Arthur Curry was never born. They travel to Wayne Manor, hoping to find Bruce, but instead find an alternate variant who has long retired. Bruce theorizes that using time travel to alter history affects events both prior to and after the alteration. They convince Bruce to return as Batman and help them find Kal-El / Superman.
The Barrys and Batman locate a Kryptonian pod discovered in Siberia. Upon arrival, they instead find Kal-El’s cousin, Kara Zor-El, imprisoned in the facility. They rescue Kara and return to Wayne mansion. Barry enlists Bruce’s help to regain his power once more. The first two attempts fail, prompting Kara to fly Barry into a storm, where he regains his powers. Kara and Batman join the Barrys to fight Zod and his forces. During the battle, Kara learns that Zod had intercepted Kal-El’s escape pod and killed him in the process of extracting the Codex needed to repopulate the Kryptonian species. The Codex is actually within Kara. Zod subdues and kills her, then extracts the Codex from her blood; meanwhile, Batman sacrifices himself in an unsuccessful attempt to destroy Zod’s ship.
The Barrys repeatedly time travel to save Batman and Kara but keep failing. Barry realizes that this sequence of events cannot be changed, but 2013-Barry keeps trying. As 2013-Barry travels, the multiverse starts to implode. The unknown speedster who initially knocked Barry out of the Speed Force returns and is revealed to be an older, future version of 2013-Barry who still believes he can defeat Zod and save his Earth. He becomes angry when Barry reveals his intention to reverse the changes he made to the timeline by letting Nora die. The elder 2013-Barry attempts to kill Barry, but instead impales young 2013-Barry, who sacrifices himself to save Barry and wipe his future self from the timeline.
Barry reverts the timeline and comes to terms with his mother’s death; however, he subtly alters the past by moving the tomato cans to a higher shelf. Returning to the present day, Barry attends Henry’s court hearing, where the security footage now reveals Henry looking up to grab the tomato can, allowing for his exoneration. After returning to the present, Barry is contacted by Bruce, whose appearance has changed once again as a result of the timeline alteration."

# data awal
data = data.frame(id_paragraf = c(1:length(data)),
                  paragraf = trimws(data))

# data referensi
referensi = 
  data %>% 
  unnest_tokens(kalimat,paragraf,token = "regex",pattern = "\\.") %>% 
  mutate(id_kalimat = c(1:length(kalimat)),
         kalimat = trimws(kalimat))

# ===================================
# hitung score
# stop words
stop = stop_words$word

# fungsi stemming
stem_ikanx = function(kata){
  hasil = tm::stemDocument(kata)
  return(hasil)
}

# process hitung score
stem_data = 
  referensi %>% 
  mutate(kalimat = janitor::make_clean_names(kalimat),
         kalimat = gsub("\\_"," ",kalimat)) %>% 
  unnest_tokens(kata,kalimat,"words") %>% 
  filter(!kata %in% stop) %>% 
  mutate(penanda = as.numeric(kata)) %>% 
  filter(is.na(penanda)) %>% 
  select(-penanda)
# stemming
stem_data$word_stemmed = sapply(stem_data$kata,stem_ikanx)  
# hitung score
dbase_score = 
  stem_data %>% 
  filter(!is.na(word_stemmed)) %>% 
  group_by(word_stemmed) %>% 
  count(sort = T) %>% 
  ungroup() %>% 
  mutate(score = n/sum(n))

# kita kembalikan dan hitung score dari kalimat
hasil = 
  stem_data %>% 
  filter(!is.na(word_stemmed)) %>% 
  merge(dbase_score) %>% 
  group_by(id_paragraf,id_kalimat) %>% 
  summarise(kalimat = paste(word_stemmed,collapse = " "),
            score = sum(score)/n()) %>% 
  ungroup()

# hanya mengambil kalimat dengan nilai terbaik 
hasil_importance = hasil
matrix           = stringdist::stringsimmatrix(hasil_importance$kalimat,
                                               method = "cosine")

# perhitungan degree
hasil_importance$degree_kalimat = sna::evcent(matrix)

hasil_new = 
  hasil_importance %>% 
  group_by(id_paragraf) %>% 
  mutate(mean_degree = median(degree_kalimat),
         mean_score  = median(score)) %>% 
  ungroup() %>%
  rowwise() %>% 
  filter(degree_kalimat > mean_degree & score > mean_score) %>% 
  ungroup()

summary_all = 
  referensi %>% 
  filter(id_kalimat %in% hasil_new$id_kalimat) %>% 
  summarise(all = paste(kalimat,collapse = ". "))

kesimpulan = trimws(summary_all$all)
kesimpulan = gsub('\\[([0-9]+)\\]', '', kesimpulan)

sink("hasil_summarizing.txt")
print(kesimpulan)
sink()