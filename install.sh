sudo apt install gnupg
sudo apt install ca-certificates
sudo apt install nano
sudo apt install gdebi-core
sudo apt-get install build-essential
sudo apt install libcurl4-openssl-dev libssl-dev libxml2-dev
sudo apt install --no-install-recommends software-properties-common dirmngr

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

sudo apt update
sudo apt upgrade

sudo apt install r-base-dev

