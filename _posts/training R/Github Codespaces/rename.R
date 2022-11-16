setwd("/workspaces/ikanx101.github.io/_posts/training R/Github Codespaces")

rm(list=ls())
files = list.files(pattern = "*png")

n_file = length(files)

for(i in 1:11){
    file.rename(files[i],
                paste0("tahap_",i,".png"))
    print(i)
}