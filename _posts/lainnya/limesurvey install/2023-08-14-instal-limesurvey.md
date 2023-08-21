---
title: "Tutorial Instalasi LimeSurvey ke VPS Digital Ocean"
date: 2023-08-14T10:57:00-04:00
categories:
  - Blog
tags:
  - Market Research
  - Marketing
  - Market Riset
  - Survey
  - Online Survey
  - Google Form
  - Lime Survey
---


Sebagai seorang *market researcher*, terkadang saya memerlukan *online
survey tools* yang *reliable*. Ada banyak pilihan, mulai dari yang
gratis seperti *Google Form* hingga *Zoho Form*, *Survey Monkey*, dan
*Jotform*. Beberapa tahun yang lalu, salah seorang rekan kerja saya
mengenalkan suatu *online tool* bernama [**Lime
Survey**](https://community.limesurvey.org/downloads/). Seketika saya
jatuh cinta terhadap *online survey tools* yang satu ini.

> Semua fitur *pro* yang dibutuhkan *market researcher* ada di sana.

Lime Survey ini bersifat *open source*, kita cukup memerlukan *server*
saja.

Kali ini saya akan memberikan tutorial untuk meng-*install* Lime Survey
ke *virtual machine* yang saya sewa di [**Digital
Ocean**](https://cloud.digitalocean.com/).

Berikut caranya:

# Tahap I

Kita *create droplet* terlebih dahulu. Saya merekomendasikan *VM* dengan
OS Ubuntu 20 spek minimal 1 CPU, 2 GB Ram. Setelah itu, silakan buka
*terminal* dan lakukan perintah sebagai berikut:

    # update dan upgrade system Linux di VM
    sudo apt update
    sudo apt upgrade -y

# Tahap II

Kita lakukan instalasi *apache* dan *mariadb server*:

    sudo apt-get install apache2 mariadb-server -y

# Tahap III

Kita akan *install* `PHP`, pertama-tama kita install `GPG-key` dan
*repository* yang dibutuhkan.

    sudo apt-get install software-properties-common -y
    sudo add-apt-repository ppa:ondrej/php -y

Lalu kita *install* PHP. Pada tutorial ini, saya install `PHP` versi
`7.2`. Perhatikan bahwa versi PHP yang dibutuhkan harus sesuai dengan
*minimum requirement* yang dibutuhkan oleh versi Lime Survey.

    sudo apt-get update -y
    sudo apt-get install php7.2 php7.2-cli php7.2-common php7.2-mbstring php7.2-xml php7.2-mysql php7.2-gd php7.2-zip php7.2-ldap php7.2-imap unzip wget curl -y

# Tahap IV

*Start* dan *enable* *apache* lalu *mysql*.

    sudo systemctl start apache2
    sudo systemctl enable apache2
    sudo systemctl start mysql
    sudo systemctl enable mysql

# Tahap V

Konfigurasi *database* untuk Lime Survey. Kita mulai dulu *mysql* dengan
perintah sebagai berikut:

    sudo mysql_secure_installation

Selanjutnya akan ada beberapa *form* yang harus diisi. Berikut adalah
isiannya:

    Enter current password for root (enter for none):
        Set root password? [Y/n]: N
        Remove anonymous users? [Y/n]: Y
        Disallow root login remotely? [Y/n]: Y
        Remove test database and access to it? [Y/n]:  Y
        Reload privilege tables now? [Y/n]:  Y

Sekarang kita akan masuk ke *mariadb* dengan perintah sebagai berikut:

    mysql -u root -p

Sekarang kita akan masukkan perintah sebagai berikut untuk membuat
*database*. Saya akan membuat *database* dengan informasi sebagai
berikut:

1.  Nama *database*: `limesurvey_db`.
2.  Nama *user database*: `limesurvey_user`.
3.  Nama *password database*: `password`.

Berikut perintahnya:

    MariaDB [(none)]>CREATE DATABASE limesurvey_db;
    MariaDB [(none)]>GRANT ALL PRIVILEGES ON limesurvey_db.* TO 'limesurvey_user'@'localhost' IDENTIFIED BY 'password';
    MariaDB [(none)]>FLUSH PRIVILEGES;
    MariaDB [(none)]>\q

# Tahap VI

Berikutnya kita akan *download* dan *install* Lime Survey. Saya akan
mengunduh Lime Survey versi `5.6`. *Link* ini silakan di-*update* sesuai
dengan kebutuhan dari situs [**Lime
Survey**](https://community.limesurvey.org/downloads/).

Kita gunakan perintah `wget`:

    wget https://download.limesurvey.org/latest-5.x/limesurvey5.6.33+230808.zip

Karena prosesnya *cloud to cloud*, proses *download* ini sangat cepat.
Lalu kita *unzip* *downloaded file*-nya.

    unzip # nama lime suryey

# Tahap VII

Kita pindahkan *folder* Lime Survey yang telah di-*unzip* ke *folder*
*index* `html` milik *apache*.

    sudo cp -r limesurvey /var/www/html/
    sudo chown www-data:www-data -R /var/www/html/limesurvey

# Tahap VIII

Pada tahap ini, kita akan melakukan konfigurasi *apache*. Kita gunakan
`nano` sebagai *text editor*.

    sudo nano /etc/apache2/sites-available/limesurvey.conf

Silakan *copy-paste* perintah berikut:

    <VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/limesurvey/
    ServerName http:// # nama ip
    <Directory /var/www/html/limesurvey/>
    Options FollowSymLinks
    AllowOverride All
    </Directory>
    ErrorLog /var/log/apache2/lime-error_log
    CustomLog /var/log/apache2/lime-access_log common
    </VirtualHost>

Jangan lupa untuk mengganti **nama IP address** yang diberikan *Digital
Ocean* ke dalam skrip tersebut.

# Tahap IX

*Restart* *apache* dengan perintah sebagai berikut:

    sudo a2ensite limesurvey
    sudo systemctl restart apache2

------------------------------------------------------------------------

Proses dari *terminal* sudah selesai. Sekarang kita buka **IP address**
di *browser* Anda dan selesaikan proses instalasinya.

Pada suatu proses, jangan lupa untuk memasukkan detail nama *database*
dari tahap V.

Proses detail instalasinya saya videokan dan saya simpan di _link_ [_Youtube_ ini](https://youtu.be/iC_wKbU5CY0?si=E5Zi59_Vdqt1JhIF).

Semoga bermanfaat _yah_...

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
