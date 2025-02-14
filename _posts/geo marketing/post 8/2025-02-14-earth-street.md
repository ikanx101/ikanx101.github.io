---
date: 2025-02-14T14:03:00-04:00
title: "Mengambil Data Longlat dari Google Earth dan OpenStreetMap"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Geocoding
  - Google
  - Geomarketing
  - Google Earth
  - OpenStreetMap
  - kml
  - kmz
---

Pada 2022 lalu, saya membuat suatu algoritma untuk bisa melakukan *web
scraping* dari **Google Maps** dengan mengandalkan `library(RSelenium)`
dan `library(rvest)` di **R**. Sampai saat ini, algoritma tersebut
menjadi andalan dalam mengambil data-data *point of interest*
(tempat-tempat keramaian) sebagai bahan analisa *geomarketing* di
kantor.

Proses kerjanya sederhana. Saya butuh *input* berupa:

1.  Nama kota atau area target.
2.  *Keywords* pencarian tempat.

Secara otomatis algoritma tersebut akan mencari tempat sesuai *keywords*
di kota atau area tersebut sampai selesai.

------------------------------------------------------------------------

Beberapa rekan yang tidak terlalu paham *ngoding* juga ingin melakukan
*web scraping* dengan skala yang lebih kecil dan ringkas dari **Google
Maps**. Misalkan mereka ingin mencari para pedagang bakso dari suatu
kecamatan. Biasanya rekan-rekan saya ini langsung menggunakan layanan
**Apify**. Salah satu keunggulannya adalah mereka tidak perlu *ngoding*.
Namun, hasil yang didapatkan biasanya masih terbatas.

*Nah* kali ini saya akan memberikan cara alternatif **bagaimana cara
mengambil data POI dari Google Earth dan OpenStreetMap**.

Cara yang hendak saya share ini bersifat semi otomatis. Maksudnya adalah
ada beberapa hal yang harus kita kerjakan secara manual tapi ada
beberapa hal yang bisa dipercepat dengan **R**.

> **Prinsip sederhananya adalah dengan mengekspor data Google Earth atau
> OpenStreetMap ke dalam format** `.kml` **untuk kemudian
> [dibaca](https://ikanx101.com/blog/kml-kmz/)**.

Berikut ini adalah tabel perbedaan data yang bisa diambil dari kedua
situs tersebut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%208/perbedaan.png" data-fig-align="center" />

Dari hasil oprekan saya, saya memiliki hipotesis sebagai berikut:

1.  *Google Earth* bisa digunakan untuk mendapatkan data **POI** yang
    bersifat umum dan bebas. Misalkan: mencari pedagang bakso, warung,
    mie ayam, dll.
2.  *OpenStreetMap* bisa digunakan untuk mendapatkan data **POI**
    berdasarkan *list amenities* yang sudah tersedia.

Oke, saya mulai yang pertama ya.

## *Google Earth*

### Profil Singkat

*Google Earth* adalah program perangkat lunak dan layanan peta berbasis
*web* yang memungkinkan pengguna untuk menjelajahi dunia secara
*virtual* melalui gambar satelit, peta, dan data geografis 3D.
Diluncurkan oleh Google pada tahun 2001, awalnya bernama *Earth Viewer
3D*, *Google Earth* telah berkembang menjadi alat yang sangat populer
untuk visualisasi bumi dan analisis geografis. Pengguna dapat terbang
secara virtual ke lokasi mana pun di planet ini, melihat lanskap,
bangunan 3D, dan fitur geografis lainnya dengan detail yang menakjubkan.
Selain tampilan bumi, *Google Earth* juga menyediakan akses ke data
astronomi untuk menjelajahi langit malam dan planet lain.

Fitur utama *Google Earth* termasuk citra satelit resolusi tinggi yang
diperbarui secara berkala, yang memungkinkan pengguna melihat perubahan
di permukaan bumi dari waktu ke waktu. Fitur 3D memungkinkan visualisasi
lanskap dan bangunan dalam tiga dimensi, memberikan perspektif yang
lebih realistis. Street View, yang terintegrasi dengan *Google Earth*,
memungkinkan pengguna untuk melihat gambar panorama 360 derajat dari
jalan-jalan di berbagai lokasi di seluruh dunia. Selain itu, Google
Earth menyediakan fitur untuk mengukur jarak dan area, menambahkan
anotasi, membuat tur virtual, dan mengakses data historis untuk melihat
perubahan lingkungan dari waktu ke waktu.

*Google Earth* memiliki berbagai aplikasi praktis dan edukatif. Dalam
pendidikan, alat ini digunakan untuk mempelajari geografi, lingkungan,
dan budaya di seluruh dunia. Untuk perjalanan dan pariwisata, Google
Earth membantu pengguna merencanakan rute perjalanan, mencari lokasi
menarik, dan mendapatkan gambaran visual tentang tujuan mereka sebelum
berkunjung. Profesional di bidang perencanaan kota, konservasi
lingkungan, dan penelitian ilmiah juga memanfaatkan *Google Earth* untuk
analisis spasial, pemantauan perubahan lahan, dan visualisasi data
geografis. Dengan antarmuka yang intuitif dan akses ke data global yang
luas, Google Earth terus menjadi alat yang berharga bagi berbagai
kalangan untuk eksplorasi dan pemahaman tentang dunia kita.

### Cara Mengambil Data

Pertama-tama, kita buka situs *Google Earth* \>\> *Create New Project*.
Lalu kita buka peta yang ada. Kita bisa langsung mencari **POI** sesuai
kebutuhan di area yang kita inginkan. Sebagai contoh, saya hendak
mencari **bakso** di area sekitar Jakarta Timur.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%208/earth1.png" data-fig-align="center" width="750" />

Kita bisa memilih **POI** yang diinginkan dari *search box*. Lalu kita
pilih ***Save to Project***. Jika sudah memilih dan *save*, contohnya
sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%208/earth2.png" data-fig-align="center" width="750" />

Selain titik **POI**, kita juga bisa menambahkan *path* atau *polygon*
dari peta tersebut.

Setelah itu, kita akan *export* menjadi format `.kml` berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%208/earth3.png" data-fig-align="center" width="750" />

Dari data `.kml` itu, kita bisa ekstrak informasinya sebagai berikut:

``` r
library(dplyr)
library(sf)

file   = "Untitled project.kml"
df_geo = st_read(file)
```

    Reading layer `Untitled project' from data source 
      `/home/rstudio/ikanx101.github.io/_posts/geo marketing/post 8/Untitled project.kml' 
      using driver `LIBKML'
    Simple feature collection with 5 features and 12 fields
    Geometry type: POINT
    Dimension:     XYZ
    Bounding box:  xmin: 106.9073 ymin: -6.196725 xmax: 106.923 ymax: -6.180981
    z_range:       zmin: 0 zmax: 5.563955
    Geodetic CRS:  WGS 84

``` r
df_geo %>% 
  mutate(long = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) |> 
  select(Name,long,lat) |> 
  as.data.frame() %>% 
  knitr::kable()
```

| Name | long | lat | geometry |
|:---|---:|---:|:---|
| No Name Places | 106.9124 | -6.187708 | POINT Z (106.9124 -6.187708… |
| Laka - Laka Mie Ayam & Bakso | 106.9230 | -6.190791 | POINT Z (106.923 -6.19079 0) |
| Bakso Rindu 5 | 106.9224 | -6.196725 | POINT Z (106.9224 -6.196725 0) |
| ” Bakso Sumo ” | 106.9135 | -6.180981 | POINT Z (106.9135 -6.180981 0) |
| Pondok Bakso Barokah Pak Sugeng | 106.9073 | -6.184579 | POINT Z (106.9073 -6.184579 0) |

Data yang kita dapatkan murni hanya `Nama POI` dan titik `longlat` saja.

## *OpenStreetMap*

### Profil Singkat

*OpenStreetMap* (OSM) adalah proyek kolaboratif daring untuk menciptakan
peta dunia yang bebas dan terbuka. Dikenal sebagai “Wikipedia untuk
peta,” OSM dibangun oleh komunitas pembuat peta yang menyumbangkan dan
memelihara data tentang jalan, jalur setapak, rel kereta api, sungai,
bangunan, dan banyak lagi di seluruh dunia. Data peta ini dibuat secara
sukarela oleh orang-orang yang menggunakan survei lapangan, perangkat
GPS, citra udara, dan sumber bebas lainnya. *OpenStreetMap* dilisensikan
di bawah Lisensi *Creative Commons Attribution-ShareAlike 2.0*, yang
berarti data peta bebas digunakan, didistribusikan, dan dimodifikasi,
asalkan atribusi yang tepat diberikan kepada kontributor *OpenStreetMap*
dan jika turunan peta didistribusikan dengan lisensi yang sama.

Salah satu karakteristik utama *OpenStreetMap* adalah sifatnya yang
terbuka dan fleksibel. Data peta dapat diakses dan diunduh oleh siapa
saja secara gratis dalam berbagai format data, memungkinkan pengguna
untuk membuat peta khusus untuk berbagai keperluan. Berbeda dengan
layanan peta komersial yang seringkali memiliki batasan dalam penggunaan
data, *OpenStreetMap* memungkinkan penggunaan yang luas dalam
pengembangan perangkat lunak, penelitian, pendidikan, dan aplikasi
komersial. Komunitas *OpenStreetMap* yang aktif terus menerus
memperbarui dan meningkatkan kualitas data peta, memastikan bahwa
informasi yang tersedia selalu relevan dan akurat. Berbagai alat dan
platform tersedia untuk berkontribusi pada *OpenStreetMap*, dari editor
*web* sederhana hingga perangkat lunak **GIS** yang lebih canggih,
sehingga siapa pun dapat terlibat dalam pemetaan.

*OpenStreetMap* memiliki dampak yang signifikan di berbagai bidang.
Dalam konteks kemanusiaan, OSM telah memainkan peran penting dalam
membantu upaya bantuan bencana, menyediakan peta yang sangat rinci dan
terbaru di daerah-daerah yang terkena dampak di mana data peta komersial
mungkin tidak tersedia atau tidak mutakhir. Dalam pengembangan, OSM
digunakan untuk perencanaan kota, manajemen sumber daya alam, dan proyek
infrastruktur. Bisnis dan organisasi juga memanfaatkan *OpenStreetMap*
untuk berbagai aplikasi, termasuk navigasi, analisis lokasi, dan
visualisasi data. Dengan sifatnya yang terbuka, komunitas yang kuat, dan
fleksibilitas penggunaan, *OpenStreetMap* terus menjadi sumber daya peta
global yang berharga dan semakin penting.

### **Categories of Amenities in OpenStreetMap:**

**1. Food and Drink:**

- **`restaurant`**: Restaurants of various cuisines and types.
- **`cafe`**: Coffee shops, cafes.
- **`bar`**: Bars, pubs.
- **`fast_food`**: Fast food restaurants.
- **`food_court`**: Areas with multiple food vendors.
- **`ice_cream`**: Ice cream parlors.
- **`pub`**: Traditional pubs.
- **`biergarten`**: Beer gardens.
- **`wine_bar`**: Wine bars.
- **`juice_bar`**: Juice bars.
- **`nightclub`**: Nightclubs, discos.

**2. Accommodation:**

- **`hotel`**: Hotels.
- **`motel`**: Motels.
- **`hostel`**: Hostels, youth hostels.
- **`guest_house`**: Guest houses.
- **`bed_and_breakfast`**: Bed and Breakfasts (B&Bs).
- **`chalet`**: Chalets.
- **`alpine_hut`**: Alpine huts, mountain huts.
- **`camp_site`**: Camp sites, campgrounds.
- **`caravan_site`**: Caravan sites, RV parks.

**3. Shops and Commerce (Often also tagged with `shop=*`):**

- **`bank`**: Banks.
- **`atm`**: Automated Teller Machines (ATMs).
- **`bureau_de_change`**: Currency exchange bureaus.
- **`vending_machine`**: Vending machines (often specified with
  `vending=*` for type of product).
- **`car_wash`**: Car washes.
- **`dry_cleaning`**: Dry cleaners.
- **`laundry`**: Laundromats, self-service laundries.
- **`marketplace`**: Marketplaces.
- **`kiosk`**: Kiosks.
- **`convenience`**: Convenience stores.
- **`supermarket`**: Supermarkets.
- **`department_store`**: Department stores.
- **`greengrocer`**: Greengrocers (fruit and vegetable shops).
- **`bakery`**: Bakeries.
- **`butcher`**: Butchers.
- **`florist`**: Florists.
- **`gift_shop`**: Gift shops.
- **`jewelry`**: Jewelry stores.
- **`newsagent`**: Newsagents.
- **`clothes`**: Clothing stores.
- **`shoes`**: Shoe stores.
- **`books`**: Bookstores.
- **`electronics`**: Electronics stores.
- **`hardware`**: Hardware stores.
- **`furniture`**: Furniture stores.
- **`garden_centre`**: Garden centers.
- **`sports`**: Sports shops.
- **`toys`**: Toy stores.
- **`car_repair`**: Car repair shops.
- **`bicycle_repair_shop`**: Bicycle repair shops.
- **`computer_repair`**: Computer repair shops.
- **`mobile_phone_shop`**: Mobile phone shops.
- **`photo_shop`**: Photo shops.
- **`stationery`**: Stationery shops.
- **`travel_agency`**: Travel agencies.

**4. Financial Services:**

- **`bank`**: Banks (already mentioned above, but significant).
- **`atm`**: ATMs (already mentioned above, but significant).
- **`bureau_de_change`**: Currency exchange (already mentioned above).

**5. Transportation:**

- **`bus_station`**: Bus stations.
- **`bus_stop`**: Bus stops.
- **`taxi`**: Taxi ranks, taxi stands.
- **`fuel`**: Fuel stations (gas stations, petrol stations).
- **`charging_station`**: Electric vehicle charging stations.
- **`car_rental`**: Car rental agencies.
- **`bicycle_rental`**: Bicycle rental agencies.
- **`ferry_terminal`**: Ferry terminals.
- **`parking`**: Parking areas (surface parking, parking garages - often
  further detailed with `parking=*` key).
- **`parking_entrance`**: Entrances to parking areas.
- **`car_sharing`**: Car sharing locations.
- **`bicycle_parking`**: Bicycle parking.
- **`airport`**: Airports (though often tagged as `aeroway=aerodrome`
  and `amenity=airport`).
- **`railway_station`**: Railway stations (train stations - often tagged
  as `railway=station` and `amenity=railway_station`).
- **`tram_stop`**: Tram stops.
- **`subway_entrance`**: Subway/Metro entrances.

**6. Healthcare:**

- **`hospital`**: Hospitals.
- **`clinic`**: Clinics.
- **`doctors`**: Doctor’s offices, general practitioners, specialists.
- **`dentist`**: Dentists.
- **`pharmacy`**: Pharmacies, chemists.
- **`veterinary`**: Veterinary clinics, vets.
- **`baby_hatch`**: Baby hatches (places for safe infant surrender).
- **`blood_donation`**: Blood donation centers.
- **`first_aid`**: First aid stations.
- **`nursing_home`**: Nursing homes, care homes.

**7. Education and Culture:**

- **`school`**: Schools (primary, secondary, etc.).
- **`kindergarten`**: Kindergartens, preschools.
- **`university`**: Universities, colleges.
- **`library`**: Libraries.
- **`museum`**: Museums.
- **`gallery`**: Art galleries.
- **`theatre`**: Theatres.
- **`cinema`**: Cinemas, movie theaters.
- **`planetarium`**: Planetariums.
- **`aquarium`**: Aquariums.
- **`zoo`**: Zoos.
- **`community_centre`**: Community centers.
- **`events_venue`**: Event venues, conference centers.
- **`music_venue`**: Music venues, concert halls.
- **`conference_centre`**: Conference centers.
- **`exhibition_centre`**: Exhibition centers.

**8. Public Services:**

- **`post_office`**: Post offices.
- **`townhall`**: Town halls, city halls.
- **`police`**: Police stations.
- **`fire_station`**: Fire stations.
- **`courthouse`**: Courthouses.
- **`prison`**: Prisons, jails.
- **`recycling`**: Recycling centers, recycling bins (often further
  specified with `recycling_type=*` and `recycling:*=*` for materials
  accepted).
- **`waste_disposal`**: Waste disposal sites, rubbish dumps.
- **`public_building`**: General public buildings (often further
  specified with `building=*` or `government=*`).

**9. Leisure and Sports:**

- **`park`**: Parks (often tagged as `leisure=park` and `amenity=park`).
- **`playground`**: Playgrounds.
- **`sports_centre`**: Sports centers, sports complexes.
- **`swimming_pool`**: Swimming pools.
- **`gymnasium`**: Gymnasiums.
- **`stadium`**: Stadiums.
- **`pitch`**: Sports pitches (football, basketball, etc. - often
  specified with `sport=*`).
- **`golf_course`**: Golf courses.
- **`miniature_golf`**: Miniature golf courses.
- **`water_park`**: Water parks.
- **`ice_rink`**: Ice rinks.
- **`marina`**: Marinas.
- **`beach_resort`**: Beach resorts.
- **`dive_centre`**: Dive centers.

**10. Religious Facilities:**

- **`place_of_worship`**: General place of worship (often further
  specified with `religion=*` and `denomination=*`).
- **`church`**: Churches.
- **`cathedral`**: Cathedrals.
- **`chapel`**: Chapels.
- **`mosque`**: Mosques.
- **`synagogue`**: Synagogues.
- **`temple`**: Temples (Buddhist, Hindu, etc.).
- **`shrine`**: Shrines.

**11. Toilets and Public Conveniences:**

- **`toilets`**: Public toilets, restrooms.
- **`drinking_water`**: Drinking water fountains, water taps.
- **`shower`**: Public showers.

**12. Other Amenities:**

- **`grave_yard`**: Graveyards, cemeteries.
- **`crematorium`**: Crematoriums.
- **`funeral_home`**: Funeral homes, mortuaries.
- **`shelter`**: Shelters (bus shelters, emergency shelters, etc. -
  often specified with `shelter_type=*`).
- **`clock`**: Public clocks.
- **`telephone`**: Public telephones, payphones.
- **`internet_cafe`**: Internet cafes, cybercafes.
- **`social_centre`**: Social centers.
- **`coworking_space`**: Coworking spaces.
- **`library`**: Libraries (also under Education, but can be seen as a
  general amenity).
- **`childcare`**: Childcare facilities.
- **`compressed_air`**: Compressed air stations (e.g., for bikes).
- **`bbq`**: Barbecue areas.
- **`wastebasket`**: Waste baskets, litter bins.
- **`mailboxes`**: Mailboxes, post boxes.
- **`feeding_place`**: Animal feeding places.
- **`bicycle_wash`**: Bicycle wash stations.
- **`lounger`**: Public loungers, deckchairs.
- **`shower`**: Public showers.
- **`water_well`**: Water wells.

### Cara Mengambil Data

Kunjungi situs <https://overpass-turbo.eu/>. Kita bisa mengambil data
dari OSM berdasarkan *query*. Cara membuat *query*-nya mudah karena kita
bisa menggunakan *wizard*.

Sebagai contoh, saya akan mencari SPBU atau *fuel* di daerah Bekasi.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%208/osm1.png" data-fig-align="center" width="750" />

Kemudian kita akan *export* ke format `.kml`.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%208/osm2.png" data-fig-align="center" width="750" />

Dari data `.kml` itu, kita bisa ekstrak informasinya sebagai berikut:

``` r
file   = "export (1).kml"
df_geo = st_read(file)
```

    Reading layer `overpass-turbo.eu export' from data source 
      `/home/rstudio/ikanx101.github.io/_posts/geo marketing/post 8/export (1).kml' 
      using driver `LIBKML'
    Simple feature collection with 61 features and 66 fields
    Geometry type: GEOMETRY
    Dimension:     XY
    Bounding box:  xmin: 106.9645 ymin: -6.279567 xmax: 107.0891 ymax: -6.17642
    Geodetic CRS:  WGS 84

``` r
df_geo %>% 
  mutate(centro = st_centroid(geometry)) %>% 
  mutate(long = st_coordinates(centro)[,1],
         lat  = st_coordinates(centro)[,2]) |> 
  select(Name,amenity,operator,opening_hours,addr_street,addr_city,long,lat) |> 
  as.data.frame() %>% 
  filter(!is.na(addr_city)) %>% 
  knitr::kable()
```

| Name | amenity | operator | opening_hours | addr_street | addr_city | long | lat | geometry |
|:---|:---|:---|:---|:---|:---|---:|---:|:---|
| Pertamina 34-17135 | fuel | PT Pertamina | NA | Jalan KH. Agus Salim | Kota Bekasi | 107.0074 | -6.235709 | POLYGON ((107.0072 -6.23571… |
| SPBU 34-17106 | fuel | PT Pertamina | 24/7 | Jalan Ir. H. Juanda | Bekasi | 107.0010 | -6.238025 | POLYGON ((107.0009 -6.23786… |
| SPBU 34-17124 | fuel | Pertamina | NA | Jalan Cut Meutia | Bekasi | 107.0007 | -6.261125 | POLYGON ((107.0004 -6.2616,… |
| SPBU 34-17119 | fuel | Pertamina | NA | Jalan H. Mulyadi Joyomartono | Bekasi | 107.0232 | -6.253157 | POLYGON ((107.0232 -6.25295… |
| Pertamina | fuel | Pertamina | 24/7 | Jalan Ahmad Yani | Bekasi | 106.9940 | -6.258159 | POLYGON ((106.9939 -6.25827… |
| Shell Ahmad Yani-1 BKS | fuel | Shell PLC | Mo-Su 06:00-22:00 | Jalan Ahmad Yani | Kota Bekasi | 106.9927 | -6.248567 | POLYGON ((106.9926 -6.24862… |
| SPBU Pertamina 31.171.01 | fuel | Pertamina | 24/7 | Jalan Ahmad Yani | Bekasi | 106.9922 | -6.250967 | POLYGON ((106.9921 -6.25114… |
| SPBU 34-17541 | fuel | Pertamina | NA | Jalan Inspeksi Kalimalang | Bekasi | 107.0620 | -6.276099 | POLYGON ((107.0616 -6.27543… |
| SPBU 34-17127 | fuel | Pertamina | 24/7 | Jalan Inspeksi Kalimalang | Bekasi | 107.0146 | -6.259038 | POLYGON ((107.0143 -6.25918… |
| SPBU 34-17114 | fuel | Pertamina | 24/7 | Jalan Cut Meutia | Bekasi | 106.9987 | -6.261935 | POLYGON ((106.999 -6.261729… |
| SPBU 34-17102 | fuel | Pertamina | NA | Jalan Siliwangi | Bekasi | 106.9952 | -6.260636 | POLYGON ((106.9951 -6.26038… |
| Pertamina | fuel | Pertamina | NA | Jalan Pekayon Raya | Bekasi | 106.9884 | -6.256914 | POLYGON ((106.9883 -6.25697… |
| Pertamina 34-17105 | fuel | NA | NA | Jalan Pekayon Raya | Kota Bekasi | 106.9728 | -6.278952 | POLYGON ((106.9727 -6.27903… |
| Pertamina 34.17145 | fuel | Pertamina | 24/7 | Jalan Siliwangi | Bekasi | 106.9937 | -6.270774 | POLYGON ((106.9939 -6.27069… |
| SPBG PGN Pondok Ungu | fuel | NA | NA | Jalan Sultan Agung | Kota Bekasi | 106.9755 | -6.200910 | POLYGON ((106.9755 -6.20079… |
| Pertamina 34-17139 | fuel | NA | NA | Jalan Perjuangan | Kota Bekasi | 107.0182 | -6.221434 | POLYGON ((107.0181 -6.22129… |
| Pertamina 34-17148 | fuel | NA | NA | Jalan Raya Ujung Harapan | Kabupaten Bekasi | 107.0067 | -6.189275 | POLYGON ((107.0066 -6.18916… |
| Pertamina 34-17117 | fuel | NA | NA | Jalan Sultan Agung | Bekasi | 106.9774 | -6.208956 | POLYGON ((106.9773 -6.20888… |
| Pertamina 31.171.05 | fuel | NA | NA | Jalan Sultan Agung | Kota Bekasi | 106.9765 | -6.201685 | POLYGON ((106.9764 -6.20158… |
| SPBU VIVO Bekasi | fuel | PT VIVO ENERGI INDONESIA | Mo-Su 07:00-22:00 | Jalan Jenderal Sudirman | Kota Bekasi | 106.9872 | -6.231345 | POLYGON ((106.9872 -6.23113… |
| Pertamina | fuel | PT Pertamina | NA | Jalan Ir. Haji Juanda | Bekasi | 106.9944 | -6.233747 | POLYGON ((106.9942 -6.23368… |
| Pertamina 34-1714000 | fuel | NA | NA | Jalan Kaliabang | Bekasi | 107.0032 | -6.203581 | POLYGON ((107.003 -6.203479… |
| Pertamina 34-17136 | fuel | NA | NA | Jalan Prima Harapan Regensi | Kota Bekasi | 107.0175 | -6.206860 | POLYGON ((107.0174 -6.20671… |
| Pertamina 34-17137 | fuel | NA | NA | Jalan Pangeran Jayakarta | Kota Bekasi | 106.9868 | -6.226928 | POLYGON ((106.9868 -6.22677… |
| Pertamina 34-17107 | fuel | NA | NA | Jalan Perjuangan | Kota Bekasi | 107.0155 | -6.221922 | POLYGON ((107.0153 -6.22166… |
| BP Grand Galaxy | fuel | NA | Mo-Su 06:00-22:00 | Jalan Pulau Ribung | Kota Bekasi | 106.9745 | -6.267371 | POLYGON ((106.9744 -6.26738… |
| SPBU VIVO Pekayon | fuel | PT VIVO ENERGI INDONESIA | Mo-Su 07:00-22:00 | Jalan Pekayon Raya | Kota Bekasi | 106.9755 | -6.276426 | POLYGON ((106.9755 -6.27626… |
| Pertamina 34-17123 | fuel | NA | NA | Jalan Harapan Indah Raya | Bekasi | 106.9775 | -6.185499 | POLYGON ((106.9778 -6.18532… |
| SPBU VIVO Margajaya | fuel | PT VIVO ENERGI INDONESIA | Mo-Su 07:00-22:00 | Jalan Ahmad Yani | Kota Bekasi | 106.9923 | -6.250150 | POLYGON ((106.9922 -6.25006… |
| Shell Cut Mutia-2 BEKASI | fuel | Shell PLC | Mo-Su 06:00-22:00 | Jalan Cut Mutia | Kota Bekasi | 107.0026 | -6.260578 | POLYGON ((107.0024 -6.26060… |
| Shell Noer Ali-2 | fuel | Shell PLC | Mo-Su 05:00-22:00 | Jalan K. H. Noer Ali | Kota Bekasi | 106.9713 | -6.249905 | POLYGON ((106.9712 -6.24984… |
| SPBU VIVO Tambun | fuel | PT VIVO ENERGI INDONESIA | Mo-Su 07:00-22:00 | Jalan Hasanuddin | Kabupaten Bekasi | 107.0745 | -6.265532 | POLYGON ((107.0745 -6.26571… |
| Shell Cut Meutia-1 BKS | fuel | Shell PLC | Mo-Su 06:00-22:00 | Jalan Siliwangi | Kota Bekasi | 106.9930 | -6.272263 | POLYGON ((106.993 -6.272365… |
| SPBU 34-17511 | fuel | Pertamina | NA | Jalan Akses Tol | Bekasi | 107.0868 | -6.279319 | POINT (107.0868 -6.279319) |
| SPBU 34-13908 | fuel | PT Pertamina | NA | NA | DKI Jakarta | 106.9673 | -6.189540 | POINT (106.9673 -6.18954) |

Kita bisa dapatkan berbagai macam data dari OSM. Masih banyak data yang
tidka saya tampilkan dari tabel di atas, seperti:

``` r
df_geo %>% glimpse()
```

    Rows: 61
    Columns: 67
    $ Name                 <chr> NA, "SPBU 34-17129", "Pertamina 34-17135", "SPBU …
    $ description          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ timestamp            <dttm> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
    $ begin                <dttm> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
    $ end                  <dttm> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
    $ altitudeMode         <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ tessellate           <int> -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -…
    $ extrude              <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
    $ visibility           <int> -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -…
    $ drawOrder            <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ icon                 <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ X_id                 <chr> "way/307278964", "way/319318385", "way/319318386"…
    $ amenity              <chr> "fuel", "fuel", "fuel", "fuel", "fuel", "fuel", "…
    $ operator             <chr> "PT Pertamina", "PT Pertamina", "PT Pertamina", "…
    $ fuel_diesel          <chr> NA, "yes", "yes", "yes", "yes", "yes", NA, "yes",…
    $ fuel_octane_80       <chr> NA, "yes", "yes", NA, "yes", NA, NA, NA, NA, NA, …
    $ fuel_octane_91       <chr> NA, "yes", "yes", NA, NA, NA, NA, NA, NA, NA, NA,…
    $ fuel_octane_92       <chr> NA, "yes", "yes", "yes", "yes", "yes", NA, "yes",…
    $ fuel_octane_95       <chr> NA, "yes", "yes", NA, NA, "yes", NA, NA, NA, "yes…
    $ fuel_octane_98       <chr> NA, "yes", "yes", NA, "yes", NA, NA, NA, NA, "yes…
    $ opening_hours        <chr> NA, "sunrise-sunset", NA, "24/7", NA, NA, "06:00-…
    $ shop                 <chr> NA, "convenience", "no", "convenience", NA, NA, N…
    $ addr_city            <chr> NA, NA, "Kota Bekasi", "Bekasi", NA, "Bekasi", NA…
    $ addr_street          <chr> NA, NA, "Jalan KH. Agus Salim", "Jalan Ir. H. Jua…
    $ brand                <chr> NA, NA, "Pertamina", NA, "Pertamina", NA, NA, NA,…
    $ brand_wikidata       <chr> NA, NA, "Q1641044", NA, "Q1641044", NA, NA, NA, N…
    $ fuel_biodiesel       <chr> NA, NA, "yes", NA, "yes", NA, NA, NA, NA, NA, NA,…
    $ addr_housenumber     <chr> NA, NA, NA, "100", NA, NA, NA, NA, NA, "1", "1", …
    $ atm                  <chr> NA, NA, NA, "yes", NA, "yes", NA, NA, "yes", NA, …
    $ fuel_octane_88       <chr> NA, NA, NA, "yes", NA, NA, NA, "yes", "yes", NA, …
    $ phone                <chr> NA, NA, NA, "+62 21 884 2821", "+62 8835 4533", N…
    $ toilets              <chr> NA, NA, NA, "yes", NA, "yes", NA, "yes", "yes", N…
    $ addr_postcode        <chr> NA, NA, NA, NA, "17113", NA, NA, NA, NA, "17141",…
    $ brand_wikipedia      <chr> NA, NA, NA, NA, "en:Pertamina", NA, NA, NA, NA, N…
    $ building             <chr> NA, NA, NA, NA, "yes", NA, NA, "yes", NA, "roof",…
    $ fuel_octane_90       <chr> NA, NA, NA, NA, "yes", "yes", NA, NA, NA, NA, NA,…
    $ self_service         <chr> NA, NA, NA, NA, "no", "no", NA, NA, NA, "no", NA,…
    $ ref                  <chr> NA, NA, NA, NA, NA, NA, NA, NA, "34-17141", NA, N…
    $ addr_district        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "Bekasi Selat…
    $ addr_province        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "Jawa Barat",…
    $ addr_subdistrict     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "Marga Jaya",…
    $ fuel_GTL_diesel      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "yes", NA, NA…
    $ layer                <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "1", NA, NA, …
    $ payment_cash         <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "yes", NA, NA…
    $ payment_credit_cards <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "yes", NA, NA…
    $ payment_debit_cards  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "yes", NA, NA…
    $ payment_mastercard   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "yes", NA, NA…
    $ payment_visa         <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "yes", NA, NA…
    $ fuel_diesel_1        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "dex", NA…
    $ fuel_lpg             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "yes", NA…
    $ compressed_air       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ fuel_cng             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ wikidata             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ wikipedia            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ roof                 <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ tenant               <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ payment_qris         <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ covered              <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ fuel_1_25            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ fuel_1_50            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ fuel_HGV_diesel      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ fuel_biogas          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ fuel_electricity     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ fuel_octane_100      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ addr_full            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ source               <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ geometry             <POLYGON [°]> POLYGON ((106.9654 -6.23383..., POLYGON (…

**Bagaimana? Mudah kan?**

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
