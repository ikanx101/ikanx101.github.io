Simulasi MonteCarlo: Peluang Menang Lotere atau Togel
================

> Di dalam islam, judi termasuk salah satu kegiatan yang diharamkan\!

Konon katanya, judi juga dilarang oleh agama apapun di muka bumi ini.

Ketika kecil dulu, saya pernah bertanya kepada ibu saya.

> *“Kenapa judi itu haram?”*

Seperti lirik [Judi-nya Bang
Oma](https://www.kompas.com/hype/read/2020/07/03/223000566/lirik-dan-chord-lagu-judi-dari-rhoma-irama),
ibu saya menjawab:

> *“Judi membuat orang jadi malas berusaha dan hanya ingin kaya dengan
> cara instan.”*

Saya bukanlah *ustadz* yang berkompeten membahas judi dari segi agama.
Tapi saya akan coba membahasnya dari segi hitung-hitungan matematika.
Bagi saya, judi itu cenderung lebih dekat kepada *fraud* atau *scam*.
Kenapa? Ketidakpastian yang terjadi sebenarnya bisa diaproksimasi. Lalu
setelah kita tahu hasil aproksimasinya, kita akan kaget melihat betapa
tidak adilnya judi itu.

> Ya mungkin pencipta judi memang tidak bertujuan untuk adil juga sih.

Tapi ada ilmu statistika yang saya tahu lahir dari dunia judi. Salah
satu contohnya simulasi MonteCarlo yang diberi nama sesuai dengan nama
kasino.

-----

> Kemarin saya melihat salah satu adegan di drakor dimana sang tokoh
> utamanya ingin membeli nomor lotere. Tokoh tersebut mendapatkan nomor
> yang diramalkan akan menang oleh dewa pelindungnya.

Di Indonesia sendiri mungkin kita tidak akan mendapati lotere secara
legal. Namun kita seringkali melihat situs-situs iklan terkait lotere
*online* atau togel *online* tersebar di mana-mana.

Lotere dan togel merupakan salah satu contoh judi yang dekat dengan
masyarakat. Keduanya serupa namun tak sama.

## Bagaimana cara kerja lotere?

Dari beberapa sumber yang saya ketahui, lotere dimainkan dengan cara
pemain membeli 6 buah angka tertentu. Angka tersebut berkisar antara 1
sampai 50. Kemudian secara berkala (biasanya mingguan) bandar akan
mengundi 6 nomor pemenang.

Aturan permainannya pun beragam. Salah satu yang paling umum digunakan
adalah sebagai berikut:

  - Jika nomor pilihan pemain cocok seluruhnya (6 nomor semuanya cocok)
    maka pemain akan mendapatkan hadiah utama. Misalkan `1.000.000` USD.
  - Jika 5 nomor pilihan pemain cocok dengan nomor yang diundi, maka
    pemain akan mendapatkan hadiah kedua. Misalkan `10.000` USD.
  - Jika 4 nomor pilihan pemain cocok dengan nomor yang diundi, maka
    pemain akan mendapatkan hadiah ketiga. Misalkan `100` USD.
  - Jika 3 nomor pilihan pemain cocok dengan nomor yang diundi, maka
    pemain akan mendapatkan hadiah sebesar `10` USD.
  - Selain itu, pemain tidak akan mendapatkan hadiah apapun.

Urutan nomor tidak menjadi masalah dalam kasus ini.

### Perhitungan Peluang

Jika saya ilustrasikan, bentuknya seperti ini ya:

<img src="nomnoml.png" width="1120" style="display: block; margin: auto;" />

Maka dengan mudah kita bisa hitung ada \(50^6\) kemungkinan angka yang
ada. Jadi sudah terbayang *yah* seberapa tidak mungkinnya mendapatkan
angka yang cocok.

### Simulasi Lotere

Sekarang agar lebih mudah dibayangkan, saya akan membuat simulasi dari
kasus ini. Misalkan harga satu tiket lotere adalah `10` USD.
Pertanyaannya:

> Jika setiap minggu saya membeli tiket lotere, berapa **expected
> return** yang akan saya dapatkan selama setahun?

Jika setahun sama dengan 52 minggu, maka **expected cost** yang saya
keluarkan selama setahun adalah sebesar `520` USD. Sekarang saya akan
buat *function* untuk simulasinya:

``` r
lotere = function(){
  pemain = sort(sample(50,6,replace = T))
  undian = sort(sample(50,6,replace = T))
  cocok = sum(pemain == undian)
  if(cocok == 6){
    hadiah = 1000000
  } else if(cocok == 5){
    hadiah = 10000
  } else if(cocok == 4){
    hadiah = 100
  } else if(cocok == 3){
    hadiah = 10
  } else if(cocok < 3){
    hadiah = 0
  }
  cost = 10
  return(hadiah - cost)
}
```

Sekarang saatnya simulasi untuk 52 minggu ke depan. Saya akan lakukan
`1.000` kali simulasi\!

<img src="post_files/figure-gfm/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

Dari grafik di atas, dari `1.000` kali simulasi saya ternyata **tidak
pernah balik modal**. Secara kumulatif uang yang saya keluarkan jauh
lebih besar dibandingkan apa yang saya dapatkan dari lotere.

Coba cek sebaran *expected return* selama setahun dari `1.000` kali
simulasi berikut ini:

<img src="post_files/figure-gfm/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

Terlihat dari grafik di atas. Bahwa tidak pernah akan ada *expected
return* yang memberikan nilai positif. Jika angka yang dipilih oleh
pemain semakin lebar *range*-nya, bisa dipastikan peluang menang akan
semakin kecil.

-----

## Bagaimana dengan togel?

Togel atau toto gelap sejatinya mirip dengan lotere. Namun kesamaan
urutan menjadi penting. Tentunya dengan adanya aturan urutan yang sama
harus dipenuhi, peluang menang juga semakin kecil.

-----

# Kesimpulan

Sudah terlihat bahwa judi lotere dengan berbagai macam bentuknya
sejatinya memang didesain agar menguntungkan pihak bandar saja.
