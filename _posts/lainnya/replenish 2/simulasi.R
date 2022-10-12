rm(list=ls())
setwd("/mnt/chromeos/removable/Workstation/ikanx101.github.io/_posts/lainnya/replenish 2/")

# skrip untuk learning forum

library(dplyr)
library(ggplot2)

# auto replenishment
# asumsi:
    # kapasitas gudang diabaikan
    # ordering cost sudah fix berapapun item dikirim
# langkah kerja
    # fase 1: 
        # analisa demand utk finished goods.
        # analisa pembelian bahan baku.
        # mulai membuat model inventori dengan catatan:
            # inventory cost berisi:
                # ordering cost (termasuk transportation cost and communication cost). 
                # carrying cost; dihitung dengan dari deteriorating value dari bahan baku jika disimpan di gudang sebagai inventori. sbg contoh, berat bawang merah akan susut sebesar 15% - 20% di suhu ruang dalam seminggu.
                # shortage cost; dihitung dari potensi loss of income saat stok finished good habis.
    # economic order quantity pada periode tertentu didefinisikan sebagai:
        # eoq = sqrt(2 * D * C0) / Ch
        # D = demand 
        # C0 = ordering cost
        # Ch = carrying cost
    # reorder point dihitung dari:
        # rop = dL + ss
        # dL = average demand during lead time
        # ss = safety stock; dihitung dengan mengasumsikan service level terpenuhi. service level adalah persentase di mana demand terpenuhi.
            # rumus ss adalah:
            # ss = normsinv(CSL) * sigmaL
                # CSL = cycle service level
                # sigmaL = standar deviasi demand pada lead time
    # fase 2:
        # membuat simulasi dari model di atas untuk berbagai nilai.

# parameter yang dibutuhkan
CSL = 95/100
leadtime_min = 1
leadtime_max = 2
carrying_cost_per_unit = 1500
ordering_cost = 500000
stock_out_cost = 5000

# misalkan demand
D = runif(30,0,5) * 10 
D = round(D,0)

# hitung ROP
# ss = normsinv(CSL) * sigmaL
sigmaL = sd(D)
# salah satu modifikasinya adalah dengan mengubah ss dengan menggunakan range alih2 standar deviasi
# sigmaL = diff(range(D))

nomrs_inv = qnorm(CSL)
ss = nomrs_inv * sigmaL
# rop = dL + ss
dL = mean(D)
rop = dL + ss

# kita akan hitung EOQ
Ch = carrying_cost_per_unit
C0 = ordering_cost
Dx = sum(D)
eoq = sqrt(2 * Dx * C0 / Ch)
eoq = round(eoq,0)

# summary
rop 
eoq = 200
ss


# kita mulai simulasinya
days = 1:30
begin_stok = c(20)
order_recv = c(0)
avail_stock = c(0)
demand = D
# bikin rumah utk variabel dependen
full_filled = rep(NA,30)
ending_stock = rep(NA,30)
stock_outage = rep(NA,30)
place_order = rep(NA,30)
lead_time = rep(NA,30)
order_arrive_at = rep(NA,30)

# untuk hari 1
i = 1

# hitung saldo sekarang
avail_stock[i] = begin_stok[i] + order_recv[i]
    
# perhitungan demand berapa yang bisa dipenuhi
# asumsi bisa dipenuhi sebagian
full_filled[i] = ifelse(avail_stock[i] < demand[i],
                        avail_stock[i],
                        demand[i])
# perhitungan ending stok
ending_stock[i] = avail_stock[i] - full_filled[i]                     
# outage atau tidak
stock_outage[i] = demand[i] - full_filled[i]
# perlu pesan lagi atau tidak?
place_order[i] = ifelse(ending_stock[i] <= rop,
                        1,
                        0)
# lead time pengiriman
lead_time[i] = sample(leadtime_min:leadtime_max,1)
# order akan datang kapan
order_arrive_at[i] = ifelse(place_order[i] == 1,
                            i + lead_time[i],
                            0)

# kita mulai looping hari kedua
for(i in 2:2){
    # stok hari i adalah stok hari i-1
    begin_stok[i] = ending_stock[i-1]
    # jika order arrive, maka order sama dengan eoq
    if(i == order_arrive_at[i-1]){order_recv[i] = eoq}
    if(i != order_arrive_at[i-1]){order_recv[i] = 0}
    
    # hitung saldo sekarang
    avail_stock[i] = begin_stok[i] + order_recv[i]
    
    # perhitungan demand berapa yang bisa dipenuhi
    full_filled[i] = ifelse(avail_stock[i] < demand[i],
                            avail_stock[i],
                            demand[i])
    # perhitungan ending stok
    ending_stock[i] = avail_stock[i] - full_filled[i]                     
    # outage atau tidak
    stock_outage[i] = demand[i] - full_filled[i]
    # perlu pesan lagi atau tidak?
    place_order[i] = ifelse(ending_stock[i] <= rop,
                            1,
                            0)
    # lead time pengiriman
    lead_time[i] = sample(leadtime_min:leadtime_max,1)
    # order akan datang kapan
    order_arrive_at[i] = ifelse(place_order[i] == 1 & order_arrive_at[i-1] == 0,
                                i + lead_time[i],
                                0)
                                
}


# kita mulai looping hari ketiga dan seterusnya
for(i in 3:30){
    # stok hari i adalah stok hari i-1
    begin_stok[i] = ending_stock[i-1]
    # jika order arrive, maka order sama dengan eoq
    if(i == order_arrive_at[i-1] | i == order_arrive_at[i-2]){order_recv[i] = eoq}
    else{order_recv[i] = 0}
    
    # hitung saldo sekarang
    avail_stock[i] = begin_stok[i] + order_recv[i]
    
    # perhitungan demand berapa yang bisa dipenuhi
    full_filled[i] = ifelse(avail_stock[i] < demand[i],
                            avail_stock[i],
                            demand[i])
    # perhitungan ending stok
    ending_stock[i] = avail_stock[i] - full_filled[i]                     
    # outage atau tidak
    stock_outage[i] = demand[i] - full_filled[i]
    # perlu pesan lagi atau tidak?
    place_order[i] = ifelse(ending_stock[i] <= rop,
                            1,
                            0)
    # lead time pengiriman
    lead_time[i] = sample(leadtime_min:leadtime_max,1)
    # order akan datang kapan
    order_arrive_at[i] = ifelse(place_order[i] == 1 & order_arrive_at[i-1] == 0,
                                i + lead_time[i],
                                0)
                                
}


df = data.frame(
    days,begin_stok,order_recv,avail_stock,
    demand,full_filled,ending_stock,
    stock_outage,place_order,
    lead_time,order_arrive_at)

df = 
    df %>%
    mutate(carrying_cost = ending_stock * carrying_cost_per_unit,
           ordering_cost = ifelse(place_order == 1 & order_arrive_at != 0,
                                  place_order * ordering_cost,
                                  0),
           stock_outage_cost = stock_outage * stock_out_cost
          ) %>%
    mutate(total_cost = carrying_cost + ordering_cost + stock_outage_cost)

# Kesimpulan
  # 1. ROP teoritis tidak berpengaruh.
  # 2. EOQ teoritis tidak selamanya memberikan cost yang minimal.
  # 3. Safety stock menjadi hal krusial.
# Rekomendasi
  # Jika dihendaki EOQ menjadi flexibel dan wajib dilakukan saat ROP, maka perlu dibuat simulasi lebih lanjut.

cost_semua = sum(df$total_cost) / 1000000
cost_semua = round(cost_semua,3)
pesan = paste0("Total cost yang dikeluarkan saat EOQ = ",eoq," adalah: Rp",cost_semua," juta",
               "\nReorder Point hasil perhitungan = ",round(rop,0))
cat(pesan)
View(df)

save(pesan,df,file = "sim_5.rda")
