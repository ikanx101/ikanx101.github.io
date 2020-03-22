---
date: 2020-3-21T5:30:00-04:00
title: "Updated: SIR Compartment Model"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Math Modelling
  - R
  - Corona Virus
  - Covid-19
  - Modelling
---

# Pendahuluan

Tulisan ini adalah *update* dari [tulisan saya
sebelumnya](https://ikanx101.github.io/blog/covid/) mengenai **SIS
Model** dalam penyebaran **COVID-19**.

Saya merasa ada beberapa yang harus diupdate terkait perkembangan yang
terjadi.

> Apa itu?

*Update* paling utama adalah penggunaan *SIR Model* yang menurut hemat
saya lebih tepat. Apa alasannya?

1.  Penjelasan virolog bahwa virus yang dilawan oleh antibodi akan
    menyisakan *cell memory* sehingga tubuh akan relatif kebal jika ada
    virus yang berusaha menginfeksi kembali.
2.  Tidak ada penambahan kasus baru di Wuhan karena *local transmission*
    sehingga rumah sakit di sana ditutup.

Oleh karena itu, saya akan mengubah model saya yang kemarin dengan **SIR
Model**. Penjelasan detailnya sudah saya tulis di tulisan kemarin *yah*.
Jika belum baca, saya sarankan untuk membacanya sehingga lebih cepat
*nyambung* dengan tulisan ini.

# SIR Model

Sekarang kita akan membangun SIR Model yang dimodifikasi *yah*.

Berikut adalah empat kelompok yang akan dibangun persamaannya?

  
![S(t), I(t), R(t),
D(t)](https://latex.codecogs.com/png.latex?S%28t%29%2C%20I%28t%29%2C%20R%28t%29%2C%20D%28t%29
"S(t), I(t), R(t), D(t)")  

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/SIR%20new.png" width="70%" />

## *Recovered* ![R(t)](https://latex.codecogs.com/png.latex?R%28t%29 "R(t)")

*Recovered* adalah kumpulan orang yang telah sembuh dari penyakit dan
dinilai telah resisten terhadap serang virus kembali.

Penambahannya hanya berasal dari **orang sakit yang telah sembuh**
karena belum ada vaksin yang bisa menangkal penyakit ini.

# Menaksir Parameter Model

Berdasarkan uraian di atas, maka persamaan diferensial untuk model saya
adalah sebagai berikut:

  
![dS(t) =
-\\beta\*S(t)\*I(t)](https://latex.codecogs.com/png.latex?dS%28t%29%20%3D%20-%5Cbeta%2AS%28t%29%2AI%28t%29
"dS(t) = -\\beta*S(t)*I(t)")  
  
![R(t) = \\gamma \*
I(t)](https://latex.codecogs.com/png.latex?R%28t%29%20%3D%20%5Cgamma%20%2A%20I%28t%29
"R(t) = \\gamma * I(t)")  
  
![dI(t) = \\beta\*S(t)\*I(t) - \\gamma \* I(t) - \\zeta \*
I(t)](https://latex.codecogs.com/png.latex?dI%28t%29%20%3D%20%5Cbeta%2AS%28t%29%2AI%28t%29%20-%20%5Cgamma%20%2A%20I%28t%29%20-%20%5Czeta%20%2A%20I%28t%29
"dI(t) = \\beta*S(t)*I(t) - \\gamma * I(t) - \\zeta * I(t)")  
  
![dD(t) = \\zeta \*
I(t)](https://latex.codecogs.com/png.latex?dD%28t%29%20%3D%20%5Czeta%20%2A%20I%28t%29
"dD(t) = \\zeta * I(t)")  

Untuk menaksir parameter, saya akan menggunakan data dan informasi
publik yang tersedia. Jika ada data yang berada dalam *range*, maka saya
akan gunakan *expected value* dari data *range* tersebut.

*Expected value* yang saya ambil adalah nilai tengah dari *range*
tersebut.

## Menaksir ![\\beta](https://latex.codecogs.com/png.latex?%5Cbeta "\\beta"), ![\\gamma](https://latex.codecogs.com/png.latex?%5Cgamma "\\gamma"), dan ![\\zeta](https://latex.codecogs.com/png.latex?%5Czeta "\\zeta")

Saya masih akan menggunakan **sumber data** yang sama dengan sebelumnya
untuk menaksir parameter yang ada.

  - ![\\gamma](https://latex.codecogs.com/png.latex?%5Cgamma "\\gamma")
    = **0.059**.
  - ![\\beta](https://latex.codecogs.com/png.latex?%5Cbeta "\\beta") =
    **0.156**.
  - ![\\zeta](https://latex.codecogs.com/png.latex?%5Czeta "\\zeta") =
    **8.0410^{-4}**.

# Menyelesaikan Model Persamaan Diferensial

Berdasarkan penaksiran parameter tersebut, untuk menyelesaikan persamaan
ini, saya menggunakan **R** dengan *packages* `deSolve`.

``` r
library(deSolve)
SIR.model <- function(N,I,t, b, g, z){
  require(deSolve)
  init <- c(S=(N-I)/N,I=I/N,D=0,R=0)
  parameters <- c(bet=b,gamm=g,zet=z)
  time <- seq(0,t,by=t/(2*length(1:t)))
  eqn <- function(time,state,parameters){
    with(as.list(c(state,parameters)),{
      dS <- -bet*(S)*I 
      dR <- gamm*I
      dI <- bet*S*I - gamm*I - zet*I 
      dD <- zet*I
      return(list(c(dS,dI,dD,dR)))})}
  out<-ode(y=init,times=time,eqn,parms=parameters)
  out.df<-as.data.frame(out)
  
  subtit <- bquote(list(beta==.(parameters[1]),
                        ~gamma==.(parameters[2]),
                        ~zeta==.(parameters[3])))
  
  ggplot(out.df,aes(x=time))+
    ggtitle(bquote(atop(bold(.(title)),atop(bold(.(subtit))))))+
    geom_line(aes(y=S,colour="Susceptible"),size=1.5)+
    geom_line(aes(y=I,colour="Infected"))+
    geom_line(aes(y=D,colour="Death"))+
    geom_line(aes(y=R,colour="Recovered"))+
    labs(x = 'Waktu dalam hari',
         y = 'Proporsi',
         title = 'Simple SIR Model',
         caption = 'Solved and Visualized\nusing R\nikanx101.github.io',
         subtitle = subtit) +
    theme(legend.position='bottom')+
    theme(legend.title=element_text(size=12,face="bold"),
          legend.background = element_rect(fill='#FFFFFF',
                                           size=0.5,linetype="solid"),
          legend.text=element_text(size=10),
          legend.key=element_rect(colour="#FFFFFF",
                                  fill='#C2C2C2',
                                  size=0.25,
                                  linetype="solid"))+
    scale_colour_manual("Compartments",
                        breaks=c("Susceptible","Infected",'Death','Recovered'),
                        values=c("blue","red",'black','green'))
}
```

Misalkan dalam satu lingkungan berisi `1000` orang dengan `999` orang
sehat dan `1` orang yang sakit, maka kondisinya dalam `200` hari menjadi
sebagai berikut:

``` r
SIR.model(1000,1,200,beta,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## Simulasi untuk Berbagai Nilai Parameter ![\\beta](https://latex.codecogs.com/png.latex?%5Cbeta "\\beta")

Kita tahu bahwa nilai **R0** berada pada range tertentu. Oleh karena
itu, saya akan coba simulasi untuk beberapa nilai **R0** tersebut.

### Simulasi pada saat **R0** `max`

``` r
beta_max = 3.9 * gamm
SIR.model(1000,1,200,beta_max,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

### Simulasi pada saat **R0** `min`

``` r
beta_min = 1.4 * gamm
SIR.model(1000,1,750,beta_min,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

# Simulasi saat ![I(0)](https://latex.codecogs.com/png.latex?I%280%29 "I(0)") berbeda-beda di ![\\beta](https://latex.codecogs.com/png.latex?%5Cbeta "\\beta") maximum

## Saat ![I(0) = 10](https://latex.codecogs.com/png.latex?I%280%29%20%3D%2010 "I(0) = 10")

``` r
SIR.model(1000,10,200,beta_max,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

## Saat ![I(0) = 15](https://latex.codecogs.com/png.latex?I%280%29%20%3D%2015 "I(0) = 15")

``` r
SIR.model(1000,15,200,beta_max,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

## Saat ![I(0) = 20](https://latex.codecogs.com/png.latex?I%280%29%20%3D%2020 "I(0) = 20")

``` r
SIR.model(1000,20,200,beta_max,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

## Saat ![I(0) = 25](https://latex.codecogs.com/png.latex?I%280%29%20%3D%2025 "I(0) = 25")

``` r
SIR.model(1000,25,200,beta_max,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

## Saat ![I(0) = 40](https://latex.codecogs.com/png.latex?I%280%29%20%3D%2040 "I(0) = 40")

``` r
SIR.model(1000,40,200,beta_max,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

## Saat ![I(0) = 100](https://latex.codecogs.com/png.latex?I%280%29%20%3D%20100 "I(0) = 100")

``` r
SIR.model(1000,100,200,beta_max,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

## Saat ![I(0) = 150](https://latex.codecogs.com/png.latex?I%280%29%20%3D%20150 "I(0) = 150")

``` r
SIR.model(1000,150,200,beta_max,gamm,zeta)
```

![](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/posting_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

> Perbedaan nilai ![I(0)](https://latex.codecogs.com/png.latex?I%280%29
> "I(0)") mempengaruhi seberapa cepat wabah menyebar tapi tidak
> menjadikan puncak semakin tinggi.

# Kesimpulan Sementara

*Update* model kali ini memberikan gambaran bahwa orang yang sakit akan
mencapai *peak position* di sekitar `40%` populasi.

> Tapi perlu diperhatikan bahwa semua orang sehat akan terinfeksi pada
> akhirnya dan menjadi resisten dengan waktu relatif cepat (sekitar `30`
> hari).

Dengan mempertimbangkan maksimum kapasitas fasilitas dan tenaga
kesehatan yang ada saat ini, saya tetap menghimbau agar kita harus
melakukan langkah konkrit untuk menurunkan
![\\beta](https://latex.codecogs.com/png.latex?%5Cbeta "\\beta") dengan
gerakan *social distancing* dan **WFH**.

-----

# Komentar Lainnya

## Persentase Bisa Menipu

Di awal-awal penanganan **COVID-19** di Indonesia, kita mendengar
beberapa pejabat dan politisi yang berkata bahwa tingkat kematian akibat
**COVID-19** ini relatif kecil, hanya `~3%` saja.

> Persentase itu masih lebih kecil dibandingkan SARS dan MERS.
> *katanya…*

Dengan data yang ada sampai saat ini, tentunya pernyataan tersebut tidak
salah tapi kurang bijak. Kenapa begitu? Secara psikologi, penyampaian
pernyataan tersebut tanpa disadari membuat sebagian masyarakat
meremehkan penyakit ini. *Gak* percaya? Lihat aja lokasi wisata di
Puncak dan Pantai Carita beberapa saat lalu.

Coba *deh* cari informasi berapa angka absolut kematian antara
**COVID-19**, SARS, dan MERS lalu coba kalian bandingkan.

Oleh karena itu, akan sangat bijak saat kita melihat nilai absolut dari
kasus kematian yang ada.

## Kenapa *Mortality Rate* di Indonesia Tinggi?

Ada hal yang cukup mencengangkan terjadi di Indonesia. *Mortality rate*
dari **COVID-19** sudah menembus angka `~10%`. Salah satu yang tertinggi
di dunia.

> Mengapa demikian?

Berdasarkan pendapat para ahli, **COVID-19** sendiri tidak bisa
menimbulkan kematian namun komplikasi yang menyertainya yang bisa
menimbulkan kematian.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/virus%20new.PNG" width="40%" />

Angka ini sendiri menurut saya menjadi cerminan buruknya kualitas
kesehatan bangsa Indonesia sebagai individual.

Ada yang bisa bantu carikan hasil Riskesdas terbaru terkait kondisi
kesehatan tersebut di atas?

## Bukan Terdistribusi Normal tapi Terdistribusi Pareto\!

Kita tahu bahwa **COVID-19** ini lebih berbahaya bagi warga senior.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/covid%20sir%20new/capture%202.PNG" width="60%" />

Saya menduga bahwa data ini terdistribusi pareto, tidak berbentuk *bell
curved*. Ini akan saya jadikan bahan tulisan di *blog* selanjutnya
*yah*.

*Stay safe* dan *stay healthy* yah.
