rm(list=ls())

ceisya = 114
ahnaf = 139

laju_ceisya = 3
laju_ahnaf = 1

i = 0

while(ceisya < ahnaf){
  ceisya = ceisya + laju_ceisya
  ahnaf = ahnaf + laju_ahnaf
  i = i + 1
}

print(i * 4 / 12)
