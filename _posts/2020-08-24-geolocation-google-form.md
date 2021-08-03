---
date: 2020-08-24T09:10:00-04:00
title: "Tutorial: Google Form Geolocation - Mengambil Data Geolocation Pada Survey di Google Form"
categories:
  - Blog
tags:
  - Google
  - Google Form
  - Survey
  - Geolocation
  - Market Research
  - Automation
---

[Google Form](https://docs.google.com/forms/u/0/) menjadi salah satu
*tools* yang sering digunakan oleh para *researcher* untuk membuat *form
survey* yang *reliable* dan mudah. Tanpa harus jago melakukan *coding*
sama sekali, kita bisa membuat *form survey* yang *sophisticated* dan
mampu melakukan *routing* pertanyaan berdasarkan jawaban.

Di masa sekarang ini ada satu jenis data yang mungkin masih dipandang
remeh tapi sangat *powerful* jika jika memilikinya dalam suatu *project*
survey. Apa itu? `GEOLOCATION` (data **longlat** atau lokasi). Biasanya
untuk mendapatkan data tersebut dalam suatu survey secara otomatis, kita
memerlukan *apps survey* khusus yang wajib di-*install* di *gadget*
*interviewer* atau responden.

Kalau kita tidak mampu membeli atau menggunakan *apps survey* khusus,
kita bisa melakukannya dengan cara manual. Saya pernah menuliskan
caranya di [blog saya yang
lama](https://passingthroughresearcher.wordpress.com/2015/06/22/big-data-series-how-to-handle-geolocation-data-and-how-to-use-it-in-market-research/).

Lalu apakah ada cara yang lebih mudah mendapatkan data *geolocation*
yang lebih *user friendly*?

# Mengambil Geolocation Menggunakan Google Form

Ternyata kita bisa mengambil data *geolocation* dari *gadget* yang
mengisi survey dengan mudah menggunakan bantuan *Google Script* yang
kita sematkan di *Google Form*.

Bagaimana caranya? Berikut langkah-langkahnya:

### 1\. Siapkan Google Form

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%201.png" width="80%" />

Misalkan saya hendak membuat survey *simple* yang hanya menanyakan nama
dan usia dari responden. Kita akan buat surveynya.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%202.png" width="80%" />

### 2\. Buka *Script Editor*

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%203.png" width="80%" />

### 3\. Masukkan *script* Berikut Ini

Pada bagian `Code.gs`, *simply* masukkan kode berikut ini:

``` r
# function doGet() {
# return HtmlService.createHtmlOutputFromFile('Index');
# }
# function getLoc(value) {
# var destId = FormApp.getActiveForm().getDestinationId() ;
# var ss = SpreadsheetApp.openById(destId) ;
# var respSheet = ss.getSheets()[0] ;
# var data = respSheet.getDataRange().getValues() ;
# var headers = data[0] ;
# var numColumns = headers.length ;
# var numResponses = data.length;
# var c=value[0];
# var d=value[1];
# var e=c + "," + d ;
#   if (respSheet.getRange(1,numColumns).getValue()=="GeoAddress") {
# if (respSheet.getRange(numResponses,numColumns-2).getValue()=="" && respSheet.getRange(numResponses-1,numColumns-2).getValue()!="" ){
# respSheet.getRange(numResponses,numColumns-2).setValue(Utilities.formatDate(new Date(), "GMT+7", "MM/dd/yyyy HH:mm:ss"));
# respSheet.getRange(numResponses,numColumns-1).setValue(e);
# var response = Maps.newGeocoder().reverseGeocode(value[0], value[1]);
# f= response.results[0].formatted_address;
# respSheet.getRange(numResponses,numColumns).setValue(f);
# }
#     else if (respSheet.getRange(numResponses,numColumns-2).getValue()=="" && respSheet.getRange(numResponses-1,numColumns-2).getValue()=="" ){
# respSheet.getRange(numResponses,numColumns-2).setValue(Utilities.formatDate(new Date(), "GMT+7", "MM/dd/yyyy HH:mm:ss")).setFontColor("red");
# respSheet.getRange(numResponses,numColumns-1).setValue(e).setFontColor("red");
# var response = Maps.newGeocoder().reverseGeocode(value[0], value[1]);
# f= response.results[0].formatted_address;
# respSheet.getRange(numResponses,numColumns).setValue(f).setFontColor("red");
# }
# else if (respSheet.getRange(numResponses,numColumns-2).getValue()!=""){
# for (i = 0; i < numResponses; i++) {
# if (respSheet.getRange(numResponses-i,numColumns-2).getValue()=="") {
# respSheet.getRange(numResponses-i,numColumns-2).setValue(Utilities.formatDate(new Date(), "GMT+7", "MM/dd/yyyy HH:mm:ss")).setFontColor("red");
# respSheet.getRange(numResponses-i,numColumns-1).setValue(e).setFontColor("red");
# var response = Maps.newGeocoder().reverseGeocode(value[0], value[1]);
# f= response.results[0].formatted_address;
# respSheet.getRange(numResponses-i,numColumns).setValue(f).setFontColor("red");
# break; }
# }
#   }
# }
#   else if (respSheet.getRange(1,numColumns).getValue()!="GeoAddress") {
# //create labels in first row
# respSheet.getRange(1,numColumns+1).setValue("GeoStamp");
# respSheet.getRange(1,numColumns+2).setValue("GeoCode");
# respSheet.getRange(1,numColumns+3).setValue("GeoAddress");
# //fill data for first respondent
# if (numResponses==2) {
# respSheet.getRange(numResponses,numColumns+1).setValue(Utilities.formatDate(new Date(), "GMT+7", "MM/dd/yyyy HH:mm:ss"));
# respSheet.getRange(numResponses,numColumns+2).setValue(e);
# var response = Maps.newGeocoder().reverseGeocode(value[0], value[1]);
# f= response.results[0].formatted_address;
# respSheet.getRange(numResponses,numColumns+3).setValue(f);
# }
# else if (numResponses > 2){
# respSheet.getRange(numResponses,numColumns+1).setValue(Utilities.formatDate(new Date(), "GMT+7", "MM/dd/yyyy HH:mm:ss")).setFontColor("red");
# respSheet.getRange(numResponses,numColumns+2).setValue(e).setFontColor("red");
# var response = Maps.newGeocoder().reverseGeocode(value[0], value[1]);
# f= response.results[0].formatted_address;
# respSheet.getRange(numResponses,numColumns+3).setValue(f).setFontColor("red");
# }
# }
# }
```

*Save* *project* tersebut dengan nama yang Kamu inginkan, misalkan:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%204.png" width="80%" />

Saya akan berikan nama `geocode survey`.

### 4\. Buat `Index.html`

Pilih `New` lalu buatlah `html` *file*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%205.png" width="80%" />

Berikan nama `Index.html`.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%206.png" width="80%" />

*Simply* masukkan kode berikut ini:

``` r
# <!DOCTYPE html>
# <html>
# <script>
# (function getLocation() {
# if (navigator.geolocation) {
# navigator.geolocation.getCurrentPosition(showPosition);
# }
# })()
# function showPosition(position) {
# var a= position.coords.latitude;
# var b= position.coords.longitude;
# var c=[a,b]
# getPos(c)
# function getPos(value) {
# google.script.run.getLoc(value);
# }
# }
# </script>
# <body>
# <p> GeoCode Entered </p>
# </body>
# </html>
```

*Save* lalu *deploy as web app*.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%207.png" width="80%" />

Ubah *setting* menjadi seperti ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%208.png" width="80%" />

*Allow permission* untuk *web app* ini menggunakan akun *gmail* kamu.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%209.png" width="80%" />

Lalu *copy paste* `url` yang ada kembali ke Google Form.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%2010.png" width="80%" />

Simpan `url` tersebut ke *ending message* survey.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geocode%20dari%20gform/pic%2011.png" width="80%" />

## DONE

Sekarang waktunya kita uji coba surveynya. Setelah mengisi survey, pada
bagian *ending* akan ada *url*. Pastikan responden mengklik url tersebut
lalu memberikan *permission* agar skrip yang kita buat tadi bisa
mengambil data *longlat* secara *realtime* saat itu.

### Selamat mencoba.

`if you find this article helpful, support this blog by clicking the ads.`
