rm(list=ls())

# kita akan mulai induksinya dari sini

tes = readLines("input.txt")
#tes = "bvwbjplbgvbhsrlpgdmjqwftvncz"

temp = strsplit(tes,split = "") %>% unlist()

# kita akan pisah per-empat
iter = length(temp)
k = 1
marker = ""
kesimpulan = 0
while(marker != "OK"){
  uji = temp[k:(k+13)] %>% unique() %>% length()
  if(uji != 14){marker = "Not OK";kesimpulan = NA}
  if(uji == 14){marker = "OK";kesimpulan = k + 13}
  k = k + 1
}

print(paste(k,marker,kesimpulan))
