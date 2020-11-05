---
date: 2020-10-28T9:30:00-04:00
title: "Text Analysis: Membuktikan Kebenaran Urban Legend Lagu The Beatles"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Text Analysis
  - Bigrams
  - Network Analysis
  - Centrality
---


Siapa sih yang tidak mengenal *band* legendaris Inggris *The Beatles*?
Mungkin cuma anak-anak *millenials* yang gak pernah mendengarnya *yah*.
*hehe.*

Ceritanya, saat SMA saya dan beberapa teman memiliki kesukaan terhadap
lagu-lagu *The Beatles*. Hingga suatu momen kami nge-*band* dan
nge-*jam* lagu-lagu tersebut. Tidak disangka ternyata ayah dari salah
satu teman saya memiliki *official books* dari *The Beatles*.

Walaupun buku tersebut berisi banyak hal mengenai *John Lennon* dan
*Paul McCartney* *cs*, saya hanya tertarik pada bagian partitur dan
*chord* lagu-lagunya. Ada satu *urban legend* yang ditulis di buku
tersebut:

> **Konon katanya, semua lirik lagu the Beatles ditulis dari sudut
> pandang orang pertama.**

Maksudnya, lirik lagunya selalu menggunakan kata `saya` atau `kami`
(dalam bahasa inggris jadi *me*, *I*, *my*, *mine*, *we*, *us* atau
*our* dan *ours*). Jadi bukan bercerita dari sudut pandang orang ketiga.

Sekian tahun berlalu hingga kini saya punya cara untuk membuktikan
kebenaran dari *urban legend* tersebut. Apakah benar semua lagu *The
Beatles* ditulis dari *1st person POV*?

-----

Berdasarkan informasi dari *Google* dan *Wikipedia*, setidaknya *The
Beatles* telah membuat setidaknya `117` buah lagu. Tapi, kalau saya cek
di beberapa situs lain seperti:
[www.lyricsfreak.com](https://www.lyricsfreak.com/), jumlahnya mencapai
`200` buah lagu.

Saya kemudian *scrape* semua judul dan lirik lagu dari *The Beatles*
dari situs tersebut. Berikut adalah *sample* datanya:

    ## # A tibble: 10 x 3
    ##       id judul               lirik                                              
    ##    <dbl> <chr>               <chr>                                              
    ##  1     1 1822                speech john this is a dorsey burnette number broth…
    ##  2     2 a day in the life   i read the news today oh boy about a lucky man who…
    ##  3     3 a hard day s night  it s been a hard day s night and i ve been working…
    ##  4     4 a little rhyme      speech rodney burke now for the final number john …
    ##  5     5 a shot of rhythm a… well if your hands start a clapping and your finge…
    ##  6     6 a taste of honey    a taste of honey tasting much sweeter than wine i …
    ##  7     7 across the universe words are flowing out like endless rain into a pap…
    ##  8     8 act naturally       they re gonna put me in the movies they re gonna m…
    ##  9     9 ain t she sweet     oh aint she sweet well see her walking down that s…
    ## 10    10 all i ve got to do  whenever i want you around yeah all i gotta do is …

-----

# Hasil Penelusuran

## Apakah semua lagu ditulis dengan *1st POV*?

Ternyata, dari `200` lagu yang ada tersebut, ada `17` lagu yang secara
eksplisit tidak menggunakan kata `saya` atau `kami`.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/data%20carpentry/the%20beatles/Journal-Beatles_files/figure-gfm/unnamed-chunk-2-1.png" width="672" />

Ternyata mayoritas lagu memang ditulis dari *1st POV*, walau ada
sebagian kecil lagu yang tidak ditulis demikian.

Apa saja lagunya?

|  id | judul                                      | lirik                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| --: | :----------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   5 | a shot of rhythm and blues                 | well if your hands start a clapping and your fingers start a popping and your feet start a moving around and if you start to swing and sway when the band starts to play a real cool way out sound and if you get to can t help it and you can t sit down you feel like you gotta move a round you get a shot of rhythm and blues with just a little rock and roll on the side just for good measure get a pair of dancing shoes well with your lover by your side don t you know you re gonna have a lot of pleasure don t you worry about a thing if you start to dance and sing and chills coming up on you and if the rhythm finally gets you and the beat gets you too well here s something for you to do get a shot of rhythm and blues with just a little rock and roll on the side just for good measure get a pair of dancing shoes well with your lover by your side don t you know you re gonna have a lot of pleasure don t you worry about a thing if you start to dance and sing and chills coming up on you and if the rhythm finally gets you and the beat gets you too well here s something for you to do get a shot of rhythm and blues get a pair of dancing shoes get a shot of rhythm and blues well with your lover by your side don t you know you re gonna have a lot of pleasure don t you worry about a thing if you start to dance and sing and chills coming up on you and if the rhythm finally gets you and the beat gets you too well here s something for you to do well here s something for you to do well here s something for you to do |
|  14 | all you need is love                       | love love love love love love love love love there s nothing you can do that can t be done nothing you can sing that can t be sung nothing you can say but you can learn how to play the game it s easy nothing you can make that can t be made no one you can save that can t be saved nothing you can do but you can learn how to be you in time it s easy all you need is love all you need is love all you need is love love love is all you need all you need is love all you need is love all you need is love love love is all you need nothing you can know that isn t known nothing you can see that isn t shown nowhere you can be that isn t where you re meant to be it s easy all you need is love all you need is love all you need is love love love is all you need all you need is love all together now all you need is love everybody all you need is love love love is all you need love is all you need yee hai oh yeah she loves you yeah yeah yeah she loves you yeah yeah yeah                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|  24 | baby you re a rich man                     | how does it feel to be one of the beautiful people now that you know who you are what do you want to be and have you travelled very far far as the eye can see how does it feel to be one of the beautiful people how often have you been there often enough to know what did you see when you were there nothing that doesn t show baby you re a rich man baby you re a rich man baby you re a rich man too you keep all your money in a big brown bag inside a zoo what a thing to do baby you re a rich man baby you re a rich man baby you re a rich man too how does it feel to be one of the beautiful people tuned to a natural e happy to be that way now that you ve found another key what are you going to play baby you re a rich man baby you re a rich man baby you re a rich man too you keep all your money in a big brown bag inside a zoo what a thing to do baby you re a rich man                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|  31 | being for the benefit of mr kite           | for the benefit of mr kite there will be a show tonight on trampoline the hendersons will all be there late of pablo fanques fair what a scene over men and horses hoops and garters lastly through a hogshead of real fire in this way mr k will challenge the world the celebrated mr k performs his feat on saturday at bishopsgate the hendersons will dance and sing as mr kite flies through the ring don t be late messrs k and h assure the public their production will be second to none and of course henry the horse dances the waltz the band begins at ten to siwhen mr k performs his tricks without a sound and mr h will demonstrate ten somersettes he ll undertake on solid ground ving been some days in preparation a splendid time is guaranteed for all and tonight mr kite is topping the bill                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|  34 | blackbird                                  | blackbird singing in the dead of night take these broken wings and learn to fly all your life you were only waiting for this moment to arise blackbird singing in the dead of night take these sunken eyes and learn to see all your life you were only waiting for this moment to be free blackbird fly blackbird fly into the light of the dark black night blackbird fly blackbird fly into the light of the dark black night blackbird singing in the dead of night take these broken wings and learn to fly all your life you were only waiting for this moment to arise you were only waiting for this moment to arise you were only waiting for this moment to arise                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|  51 | cry baby cry                               | cry baby cry make your mother sigh she s old enough to know better the king of marigold was in the kitchen cooking breakfast for the queen the queen was in the parlour playing piano for the children of the king cry baby cry make your mother sigh she s old enough to know better so cry baby cry the king was in the garden picking flowers for a friend who came to play the queen was in the playroom painting pictures for the childrens holiday cry baby cry make your mother sigh she s old enough to know better so cry baby cry the duchess of kircaldy always smiling and arriving late for tea the duke was having problems with a message at the local bird and bee cry baby cry make your mother sigh she s old enough to know better so cry baby cry at twelve o clock a meeting round the table for a seance in the dark with voices out of nowhere put on specially by the children for a lark cry baby cry make your mother sigh she s old enough to know better so cry baby cry cry cry cry baby make your mother sigh she s old enough to know better cry baby cry cry cry cry make your mother sigh she s old enough to know better so cry baby cry                                                                                                                                                                                                                                                                                                                                                                                                    |
|  58 | dig it                                     | like a rolling stone a like a rolling stone like the fbi and the cia and the bbc bb king and doris day matt busby dig it dig it dig it dig it dig it dig it dig it dig it dig it dig it dig it                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  68 | eleanor rigby                              | ah look at all the lonely people ah look at all the lonely people eleanor rigby picks up the rice in the church where a wedding has been lives in a dream waits at the window wearing the face that she keeps in a jar by the door who is it for all the lonely people where do they all come from all the lonely people where do they all belong father mckenzie writing the words of a sermon that no one will hear no one comes near look at him working darning his socks in the night when there s nobody there what does he care all the lonely people where do they all come from all the lonely people where do they all belong ah look at all the lonely people ah look at all the lonely people eleanor rigby died in the church and was buried along with her name nobody came father mckenzie wiping the dirt from his hands as he walks from the grave no one was saved all the lonely people ah look at all the lonely people where do they all come from all the lonely people ah look at all the lonely people where do they all belong                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|  74 | for no one                                 | your day breaks your mind aches you find that all the words of kindness linger on when she no longer needs you she wakes up she makes up she takes her time and doesn t feel she has to hurry she no longer needs you and in her eyes you see nothing no sign of love behind the tears cried for no one a love that should have lasted years you want her you need her and yet you don t believe her when she said her love is dead you think she needs you and in her eyes you see nothing no sign of love behind the tears cried for no one a love that should have lasted years you stay home she goes out she says that long ago she knew someone but now he s gone she doesn t need him your day breaks your mind aches there will be time when all the things she said will fil your head you won t forget her and in her eyes you see nothing no sign of love behind the tears cried for no one a love that should have lasted years                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|  84 | gnik nus                                   | here comes the sun king here comes the sun king everybody s laughing everybody s happy here comes the sun king quando paramucho mi amore defelice corazon mundo paparazzi mi amore chicka ferry parasol cuesto obrigado tanta mucho que can it carousel                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| 146 | it came upon midnight clear babys in black | it came upon a midnight clear it came upon the midnight clear that glorious song of old from angels bending near the earth to touch their harps of gold peace on the earth good will to men from heaven s all gracious king the world in solemn stillness lay to hear the angels sing still through the cloven skies they come with peaceful wings unfurled and still their heavenly music floats o er all the weary world above its sad and lowly plains they bend on hovering wing and ever o er its babel sounds the blessed angels sing yet with the woes of sin and strife the world has suffered long beneath the heavenly strain have rolled two thousand years of wrong and man at war with man hears not the tidings which they bring o hush the noise ye men of strife and hear the angels sing o ye beneath life s crushing load whose forms are bending low who toil along the climbing way with painful steps and slow look now for glad and golden hours come swiftly on the wing o rest beside the weary road and hear the angels sing for lo the days are hastening on by prophets seen of old when with the ever circling years shall come the time foretold when peace shall over all the earth its ancient splendors fling and the whole world give back the song which now the angels sing                                                                                                                                                                                                                                                                |
| 153 | junk                                       | motorcars handlebars bicycles for two broken hearted jubilee parachutes army boots sleeping bags for two nah nah nah nah jamboree buy buy motorcars handlebars bicycles for two broken hearted jubilee parachutes army boots sleeping bags for you nah nah nah jamboree buy buy the shop window why why says the sign in the yard buy buy says the sign in the shop window why why says the junk in the yard                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| 154 | just a rumour                              | speech alan freeman george is it true that you re a connoisseur of the classics george no it s just a rumour a rumour alan just a rumour george hmm alan did you enjoy singing beethoven george no been singing it for 28 years now you know alan for how long george twenty eight years alan that s incredible could you manage one more performance george um possibly alan oh go on say yes george yes thank you                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| 157 | komm gib mir deine hand                    | oh komm doch komm zu mir du nimmst mir den verstand oh komm doch komm zu mir komm gib mir deine hand komm gib mir deine hand komm gib mir deine hand oh du bist so schon schon wie ein diamant ich will mit dir gehen komm gib mir deine hand komm gib mir deine hand komm gib mir deine hand in deinen armen bin ich glucklich und froh das war noch nie bei einer anderen einmal so einmal so einmal so oh komm doch komm zu mir du nimmst mir den verstand oh komm doch komm zu mir komm gib mir deine hand komm gib mir deine hand komm gib mir deine hand in deinen armen bin ich glucklich und froh das war noch nie bei einer anderen einmal so einmal so einmal so oh du bist so schon schon wie ein diamant ich will mit dir gehen komm gib mir deine hand komm gib mir deine hand komm gib mir deine hand komm gib mir deine hand                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| 158 | lady madonna                               | lady madonna children at your feet wonder how you manage to make ends meet who finds the money when you pay the rent did you think that money was heaven sent friday night arrives without a suitcase sunday morning creep in like a nun mondays child has learned to tie his bootlace see how they run lady madonna baby at your breast wonder how you manage to feed the rest see how they run lady madonna lying on the bed listen to the music playing in your head tuesday afternoon is never ending wednesday morning papers didn t come thursday night you stockings needed mending see how they run lady madonna children at your feet wonder how you manage to make ends meet                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| 174 | lucy in the sky with diamonds              | picture yourself in a boat on a river with tangerine trees and marmalade skies somebody calls you you answer quite slowly a girl with kaleidoscope eyes cellophane flowers of yellow and green towering over your head look for the girl with the sun in her eyes and she s gone lucy in the sky with diamonds lucy in the sky with diamonds lucy in the sky with diamonds ahh follow her down to a bridge by a fountain where rocking horse people eat marshmellow pies everyone smiles as you drift past the flowers that grow so incredibly high newspaper taxis appear on the shore waiting to take you away climb in the back with your head in the clouds and you re gone lucy in the sky with diamonds lucy in the sky with diamonds lucy in the sky with diamonds ahh picture yourself on a train in a station with plasticine porters with looking glass ties suddenly someone is there at the turnstyle the girl with the kaleidoscope eyes lucy in the sky with diamonds lucy in the sky with diamonds lucy in the sky with diamonds ahh                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| 181 | mean mr mustard                            | mean mister mustard sleeps in the park shaves in the dark trying to save paper sleeps in a hole in the road saving up to buy some clothes keeps a ten bob note up his nose such a mean old man such a mean old man his sister pam works in a shop she never stops she s a go getter takes him out to look at the queen only place that he s ever been always shouts out something obscene such a dirty old man dirty old man                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

Lagu bukan 1st POV

Beberapa lagu yang familiar di telinga saya seperti `All You Need is
Love`, `Lady Madonna`, dan `Lucy in The Sky with Diamonds` ternyata
memang tidak mengandung kata eksplisit *1st POV*.

Tapi lagu ke `157` adalah versi bahasa Jerman dari lagu `I Wanna Hold
Your Hand`. Berarti bertambah lagi satu lagu yang ditulis dari *1st
POV*.

## Kata Terpenting dalam Lagu *The Beatles*

Sekarang saya akan melihat dari semua lagu *The Beatles* kata apa yang
terpenting. Kata apa yang menjadi pusat perhatian dari rangkaian lirik
*The Beatles*?

Untuk menjawabnya, saya akan gunakan *bigram analysis*, yakni melihat
pasangan kata yang muncul bersamaan.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/data%20carpentry/the%20beatles/Journal-Beatles_files/figure-gfm/unnamed-chunk-4-1.png" width="672" />

Agak rumit yah graf di atas.

Ada beberapa cara menentukan pusat dari graf.

1.  *Degree*: *For finding very connected words, popular words, words
    which can quickly connect with the wider network.*
2.  *Betweenness*: *For finding the words which influence the flow
    around a system.*

Berikut adalah hasil perhitungan dari graf di atas:

| words | degree |   between |
| :---- | -----: | --------: |
| you   |    134 | 30598.741 |
| i     |    124 | 27107.517 |
| the   |     73 | 13773.298 |
| me    |     67 | 10915.729 |
| to    |     59 | 10919.398 |
| a     |     54 |  9603.176 |
| and   |     46 |  9585.461 |
| s     |     45 | 10552.384 |
| my    |     33 |  5962.631 |
| it    |     32 |  3929.178 |
| t     |     30 |  5118.419 |
| be    |     27 |  4435.864 |
| that  |     26 |  4051.371 |
| your  |     24 |  5535.858 |
| love  |     23 |  4851.731 |

15 Kata yang menjadi pusat

Ternyata `you` menjadi kata pusat di semua lirik *The Beatles*. Hal ini
menarik bagi saya.

> Karena kalau diperhatikan, lagu seperti `All You Need is Love`. Walau
> tidak ada eksplisit kata `saya` dan `kita`, seolah-olah si penyanyi
> sedang berbicara langsung kepada orang kedua.

Maka dari itu, `you` jangan-jangan bisa dimasukkan ke dalam *1st POV*
secara implisit.

Selain itu, kata-kata *1st POV* seperti `I`, `me`, dan `my` memiliki
index *degree* dan *betweenness* yang tinggi.

## *Degree*

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/data%20carpentry/the%20beatles/Journal-Beatles_files/figure-gfm/unnamed-chunk-6-1.png" width="672" />

## *Between*

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/data%20carpentry/the%20beatles/Journal-Beatles_files/figure-gfm/unnamed-chunk-7-1.png" width="672" />

-----

# *Summary*

Jadi *urban legend* mungkin benar adanya. Walau ada sebagian lagu yang
tidak secara eksplisit menggunakan kata `saya` dan `kami` TAPI kita
tidak bisa memungkiri bahwa kata-kata *1st POV* mendominasi *central
gravity* dari lirik-lirik yang dinyanyikan *The Beatles*.
