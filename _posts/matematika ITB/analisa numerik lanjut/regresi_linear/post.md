Belajar Membuat Model Regresi Linear - part 1
================

Kita pasti sudah sering mendengar, melihat, bahkan membuat model regresi
linear ![y = ax +
b](https://latex.codecogs.com/png.latex?y%20%3D%20ax%20%2B%20b
"y = ax + b"). Setidaknya saya pernah menulis tiga *posts* terkait
regresi linear:

1.  Bagaimana membuat model regresi linear di **R** dan menguji
    asumsinya di [sini](https://ikanx101.com/blog/belajar-regresi/).
2.  Aplikasi regresi linear pada perhitungan *price elasticity* di
    [sini](https://ikanx101.com/blog/blog-posting-regresi/).
3.  Menentukan apa yang berpengaruh terhadap kebahagiaan di suatu negara
    berdasarkan *World Happiness Index* di
    [sini](https://ikanx101.com/blog/bahagia-survey/).

> ***Tapi belum ada sama sekali tulisan yang menjelaskan bagaimana cara
> menentukan nilai a dan b pada persamaan regresi linear tersebut.***

Nah, kali ini saya akan menjelaskan bagaimana cara kita menentukan nilai
![a](https://latex.codecogs.com/png.latex?a "a") dan
![b](https://latex.codecogs.com/png.latex?b "b") pada persamaan regresi
![y = ax +
b](https://latex.codecogs.com/png.latex?y%20%3D%20ax%20%2B%20b
"y = ax + b").

-----

Misalkan saya memiliki ![n](https://latex.codecogs.com/png.latex?n "n")
pasang data
![(x\_1,y\_1),(x\_2,y\_2),..,(x\_n,y\_n)](https://latex.codecogs.com/png.latex?%28x_1%2Cy_1%29%2C%28x_2%2Cy_2%29%2C..%2C%28x_n%2Cy_n%29
"(x_1,y_1),(x_2,y_2),..,(x_n,y_n)").
