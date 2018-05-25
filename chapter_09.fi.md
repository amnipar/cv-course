---
title: Luku 9 - Pistepiirteet
author: Matti Eskelinen
date: 19.3.2018
title-prefix: TIES411
lang: fi
css: style.css
---

# Pistepiirteet

Tässä luvussa tutustumme kuvien analysointiin useissa eri skaaloissa sekä
mielenkiintoisten kohtien etsimiseen ja kuvaamiseen pistepiirteiden avulla.

Käytännöllisiä asioita tällä kerralla:

* kuvapyramidien tutkimista,
* reunanhakua monessa skaalassa yhtä aikaa,
* Laplacen pyramidin nollakohtien hakua,
* pistepiirteiden etsimistä ja kuvaamista.

Yhdestä kuvasta löytyneiden pisteiden vastinpisteiden etsimistä toisesta kuvasta
pohditaan myöhemmin geometristen muunnosten yhteydessä.

## Pistepiirteet

Kohteiden reunoja haeskellessamme huomasimme, että kohteiden kuvailu reunakäyrän
perusteella on hankalaa. Muotopiirteet soveltuvat kuvailemaan lähinnä kohteita,
joiden koko reunakäyrä on tiedossa. On kuitenkin melkoisen vaikeaa saada
kuvasta irti yhtenäinen reuna tietylle kohteelle. Reunoja löytyy aivan liikaa,
ne muodostavat harvoin ehjän kohteen ympäri menevän ketjun, ja joka tapauksessa
hyödyllinen reunakäyrä saadaan vain tasaisen värisille kohteille. Lisäksi
kohteen pitäisi näyttää saman muotoiselta joka suunnasta.

Seuraava idea on kuvailla kohdetta kokoelmana irrallisia palasia. Ajatus on se,
että vaikka koko kohde ei olisikaan kunnolla näkyvissä ja vaikka kohde olisi eri
asennossa kuin edellisellä kerralla, jos kuvasta vain löydetään riittävän monta
samanlaista kohteen palasta, kohde on luultavasti löytynyt. Koska kuvista on
helpointa paikallistaa pistemäisiä kohteita, kuten nurkkia tai pyöreähköjä
möykkymäisiä kohteita (engl. *blob*), tällaisia palasista koostuvia esityksiä
muodostetaan yleensä käyttäen *pistepiirteitä*. Muutamiin yksinkertaisiin
nurkkia löytäviin operaatioihin tutustuimmekin aiemmassa luvussa.

## Skaala-invariantit pistepiirteet

Monista kulmia tai muita pistemäisiä kohteita löytävistä menetelmistä, kuten
Harrisin menetelmä ja Hessen matriisiin perustuvat menetelmät, saadaan tehtyä
skaala-invariantteja kuvapyramidien avulla.

Harrisin menetelmä löytää pisteitä, jotka sietävät suhteellisen hyvin
valaistuksen muutoksia, siirtoja ja ja kiertoja. Se kuitenkin löytää pisteitä
vain yhdessä skaalassa: jos kohdetta skaalataan merkittävästi, löydetyt pisteet
eivät enää ole samanlaisia. Tähän ongelmaan on ratkaisuna kuvapyramidi, jossa
muodostetaan useita skaalattuja versioita samasta kuvasta, ja etsitään pisteitä
jokaisessa skaalassa erikseen.

Oleellinen vaihe skaala-invarianttien pistepiirteiden etsimisessä on löydettyjen
pisteiden *lokalisointi skaalassa*. Tämä tarkoittaa, että etsitään kullekin
pisteelle se skaala, jossa *Laplacian-of-Gaussian* (LoG) maksimoituu. Löydettyä
skaalaa kutsutaan usein pisteen *karakteristiseksi skaalaksi*, koska kyseessä on
se skaala, jossa piste erottuu taustastaan parhaiten. Luonnollisesti skaala
vaikuttaa myös pisteen 'kokoon'; pisteet visualisoidaan tyypillisesti
piirtämällä eri kokoisia ympyröitä. Ympyrän säde vastaa LoG-suotimen 'sisälle'
mahtuvan ympyrän sädettä.

Kun skaala-avaruudessa vertaillaan Gaussin funktion derivaattoihin perustuvien
suotimien arvoja (esimerkiksi juuri LoG on tällainen), on näiden suotimien vaste
normalisoitava skaalassa. Tämä johtuu siitä, että suotimien vaste vaimenee kun
$\sigma$ kasvaa; suotimia moduloiva Gaussin funktio tulee koko ajan matalammaksi
ja leveämmäksi. Tilanteen korjaamiseksi ensimmäisen asteen derivaattoihin
perustuvat suodinvasteet on kerrottava $\sigma$:lla ja toisen asteen
derivaattoihin perustuvat suodinvasteet $\sigma^2$:lla. Tällä tavoin suotimien
vaste saadaan pidettyä skaala-invarianttina ja eri skaalat vertailukelpoisina;
tämä on tärkeää esimerkiksi juuri etsittäessä LoG:n paikallisia maksimeja yli
skaalan.

## Visuaalinen merkittävyys

Keskeinen käsite pistepiirteiden muodostamisessa on visuaalinen *merkittävyys*
eli *salienssi* (engl. *salience* tai *saliency*). Käsite tulee neurotieteen
puolelta, ja voitaisiin kääntää jonkin kohteen suhteellisena tärkeytenä; tässä
esityksessä käytetään muotoa *merkittävyys*. Tämä tarkoittaa sitä, miten
selvästi tietty kohde eroaa ympäröivistä kohteista; jos kohde on jossakin
mielessä hyvin erilainen kuin ympäröivät kohteet, se erottuu hyvin taustastaan
ja on siksi visuaalisesti merkittävä. Tutkimuksissa on todettu, että ihmisen
huomio  pyrkii kiinnittymään tällaisiin kohteisiin.

Kohde voi olla visuaalisesti merkittävä monella eri tavalla. Liikennemerkit ovat
esimerkki kohteista, jotka on tarkoituksella tehty merkittäviksi maalaamalla ne
kirkkailla väreillä, joita ei muuten yleensä esiinny teiden varsilla. Kohde voi
poiketa ympäristöstään paitsi värin, myös pintarakenteen, muodon tai asennon
perusteella. Konenäössä merkittävyydellä viitataan yleensä jonkin suotimen
tuottamiin voimakkaisiin paikallisiin ääriarvokohtiin. Kuten muistamme, kaikki
kuvasuotimet tuottavat huipukkaita, harvoja jakaumia; niiden vasteet ovat
useimmiten lähellä nollaa olevia arvoja, ja hyvin paljon nollasta poikkeavat
arvot ovat harvinaisia. Tämän vuoksi erilaisten suotimien (useimmiten *LoG* tai
*Gabor*) ääriarvot erottuvat ympäristöstään ja ovat siis merkittäviä.

Skaala-invarianttien pistepiirteiden lokalisointi skaalassa tarkoittaa siis myös
pisteen visuaalisen merkittävyyden maksimointia. Visuaalisesti merkittävän
pisteen oletetaan olevan merkittävä myös kohteiden tunnistamisen kannalta.
Toisaalta pistepiirteitä käytetään usein myös kohteiden seurantaan videon
kuvaruudusta toiseen tai tunnistamiseen eri kuvakulmista. Luonnollisesti
visuaalisesti merkittävä ja taustasta selvästi erottuva kohde on helpompi
tunnistaa myös eri kuvakulmasta tai muuten hieman muuttuneesta kuvasta.

## Kadir-Brady -menetelmä

Monissa teoreettisissa tarkasteluissa on viime aikoina käytetty paljon Kadirin
ja Bradyn menetelmää pistepiirteiden etsimiseksi. Suosion tähden menetelmä
mainitaan tässä, mutta palaamme siihen tarkemmin myöhemmässä luvussa kuvien
tilastollisen analysoinnin yhteydessä, sillä menetelmän ymmärtämiseen tarvitaan
kyseisessä luvussa esiteltäviä asioita.

## MSER

Eräs mielenkiintoinen tapa etsiä kuvasta selkeästi taustastaan erottuvia alueita
on MSER eli *maximally stable extremal regions*. Algoritmi on helppo ymmärtää.
Termi *extremal region* viittaa alueisiin, joissa on kirkkauden paikallinen
ääriarvokohta, eli siis ympäristöään kirkkaampi tai tummempi alue. Termi
*maximally stable* puolestaan viittaa siihen, että alueen muoto pysyy vakaana,
kun kuvaa kynnystetään eri kynnysarvoilla.

MSER-alueet voidaan löytää kuvasta kynnystämällä kuvaa monta kertaa peräjälkeen
käyttäen kasvavaa kynnysarvoa ja tutkimalla, mitkä yhtenäiset kappaleet pysyvät
saman muotoisina useimpien kynnysarvon muutosten yli. Tämä saadaan toteutettua
nopeasti *lajittelemalla* pikselit suuruusjärjestykseen ja käymällä niitä läpi
alkaen pienimmistä arvoista. Tällä tavoin selvitään yhdellä pikselien
läpikäynnillä; kun listassa siirrytään aina seuraavaan pikseliarvoon, nähdään,
mitkä pikselit lisättäisiin alueisiin jos kynnysarvoa kasvatettaisiin yhdellä.
Käyttämällä edellisellä luennolla esiteltyä tapaa hallinnoida erillisiä joukkoja
voidaan seurata jatkuvasti, mitkä pikselijoukot ovat yhtenäisiä, ja mitkä alueet
pysyvät muuttumattomina kun kynnysarvo kasvaa.

## Pisteiden kuvailu piirteiden avulla

Tähän asti olemme vain etsineet kuvasta pistemäisiä kohteita. Löydetyistä
pisteistä saadaan pistepiirteitä vasta sitten, kun pisteiden ympäristöä
kuvaillaan jollakin matemaattisesti vertailtavalla tavalla. Perinteinen keino
oli ottaa talteen esimerkiksi Harrisin pisteiden ympäriltä pieni
pikseliympäristö harmaasävykuvana, tai vaihtoehtoisesti harmaasävyhistogrammi.
Myös itse Harrisin funktion arvo kuvailee pistettä jollakin tavalla, samoin
rakennetensorin tai Hessen matriisin ominaisarvot. Nykyään kuitenkin
tyypillisesti muodostetaan erilaisia gradienttihistogrammeja pisteen
ympäristöstä. Gradientti pysyy vakaampana valaistuksen ja näkökulman
vaihdellessa kuin harmaasävy- tai väriarvo.

## SIFT

Kaksi erittäin suosittua pistepiirteiden etsintämenetelmää ovat SURF ja SIFT. Ne
ovat melko monimutkaisia algoritmeja, ja seuraavassa käymme ne läpi
pääpiirteissään.  Useimmat näiden algoritmien toteutukset on tehty kahden kuvan
toisiaan vastaavien kohteiden etsimiseen, ja usein myös tavoitteena on ollut
saada suoritusajasta mahdollisimman nopea. Konenäkömenetelmien kehittäjän
näkökulmasta tämä tarkoittaa sitä, että valmiit toteutukset eivät välttämättä
sovi muihin tarkoituksiin, esimerkiksi kohteen tunnistamiseen muuten kuin
vertailemalla mallikuvaan tai näkymän rakenteen mallintamiseen yhden kuvan
perusteella.

Eräs esimerkki mahdollisista ongelmista on se, että valmiit SIFT- ja SURF-
toteutukset vaikkapa OpenCV:ssä eivät löydä kaikkia ihmisen mielestä tärkeitä
nurkkapisteitä. Tämä voi johtua siitä, että ne eivät erotu riittävän hyvin
taustastaan ja karsitaan pois. Toinen mahdollinen selitys voi olla se, että
toteutuksessa käytetyt skaalat ovat sellaisia, että DoG-suotimen keskus ei osu
pisteen kohdalle. Toisinaan voikin olla tarpeen toteuttaa pisteiden etsiminen
itse, ottaen huomioon oman sovelluksen vaatimukset.

SIFT eli [scale-invariant feature transform] on eräs suosituimmista
pistepiirteiden hakumenetelmistä. Se sisältää menetelmän sekä hyvien pisteiden
löytämiseen useissa skaaloissa että pisteitä kuvailevan piirrevektorin
(engl. *descriptor*) muodostamiseen.

Algoritmin vaiheet pääpiirteissään ovat

* kuva konvolvoidaan sarjalla Gaussin maskeja,
* vierekkäisten skaalojen erotus lasketaan, jolloin saadaan DoG,
* valitaan pisteet jotka ovat lokaaleja maksimeja sekä kuva-avaruudessa että
  skaala-avaruudessa, eli verrataan pikseliä naapureihinsa ja vastaavaan 9
  pikselin naapurustoon naapuriskaaloissa,
* interpoloidaan näiden kandidaattipisteiden sijainti pikseliä paremmalla
  tarkkuudella (käyttäen paraabelin sovitusta lokaalin ääriarvon löytämiseksi),
* hylätään kandidaattipisteet, joilla on huono kontrasti (kynnystetään DoG:n
  mukaan),
* hylätään reunapikselit, joille Hessen matriisin ominaisarvojen välinen suhde 
  on liian pieni (voidaan laskea determinantin ja jäljen välisen suhteen 
  avulla).

Jokaiselle valitulle pisteelle lasketaan pääasiallinen suunta (tarkoittaen sitä,
mihin oletettu 'nurkka' osoittaa) laskemalla gradientin magnitudi ja suunta
pisteen ympäristössä ja tekemällä näistä suuntahistogrammi. Pisteen
pääasiallinen suunta on se gradientin suunta, joka esiintyy useimmin
histogrammissa. Jos on myös muita suuntia, jotka esiintyvät lähes yhtä monta
kertaa (alkuperäisessä algoritmissa 80% pääasiallisen suunnan
esiintymiskerroista), jokaiselle suunnalle luodaan oma piste, jolle lasketaan
deskriptori.

Deskriptori lasketaan pisteen pääasiallisen suunnan mukaisesti. Tämä tarkoittaa
sitä, että pisteen ympäriltä näytteistetään 16x16 arvoa pääasiallisen suunnan
mukaan kierretystä ruudukosta. Näistä näytteistä muodostetaan 4x4 uutta
suuntahistogrammia, joista jokaisessa on 8 lokeroa. Lopulta siis saadaan
vektori, jossa on 4x4x8 eli 128 elementtiä. Tämä vektori normalisoidaan
yksikkövektoriksi.

Löydettyjä pistepiirteitä vertaillaan yksinkertaisesti mittaamalla vektorien
välinen etäisyys ja etsimällä lähimmät naapurit. Tyypillisessä sovelluksessa
vertailtavia pisteitä on paljon, ja etsimisessä voidaan käyttää apuna
esimerkiksi kd-puuta, joka on lähimpien naapurien etsimiseen soveltuva
tietorakenne. Etäisyysmittausten haasteena on luonnollisesti vektorien korkea
ulottuvuus (pisteiden etäisyyksien suhteelliset erot pienenevät dimension
kasvaessa), joten toisinaan tehdään myös piirrevektorien dimension pienennys
käyttäen esimerkiksi pääkomponenttianalyysiä.

Tämän selostuksen perusteella lienee selvää, että SIFT-menetelmän suurin puute
on vaadittava laskentateho. Sekä pisteiden etsiminen, piirrevektorien luominen
että piirrevektorien vertaileminen ja lähimpien naapurien etsiminen ovat melko
raskaita operaatioita. Menetelmä kuitenkin toimii melko hyvin. Löwen
alkuperäinen SIFT-paperi on yksi niistä papereista, jotka kannattaa lukea jos
aihe yhtään kiinnostaa.

[scale-invariant feature transform]:
http://en.wikipedia.org/wiki/Scale-invariant_feature_transform

## SURF

SURF eli [speeded up robust features] on nopeampi kuin SIFT, ja myös erittäin
suosittu menetelmä. Sekin sisältää menetelmän sekä pisteiden löytämiseksi että
niiden kuvailemiseksi, ja SURF-piirrevektoreita käytetään toisinaan myös muilla
menetelmillä löydettyjen pisteiden kuvailemiseen, koska ne on nopeampi laskea
kuin SIFT-piirrevektorit. Nopeammasta laskentatavasta huolimatta SURF-piirteiden
on todettu toimivan aivan yhtä hyvin, toisinaan jopa paremmin.

SURF löytää hieman erilaisia pisteitä kuin SIFT, joten menetelmiä kannattaa
vertailla ja tutkia, kumpi toimii paremmin omassa sovelluksessa. Oleellinen ero
menetelmien välillä on se, että SIFT käyttää Laplacen operaattorin ääriarvoja
ja SURF Hessen matriisin determinantin ääriarvoja.

SURF-menetelmän nopeus saavutetaan käyttämällä integraalikuvan avulla
laskettavia laatikkosuotimia approksimoimaan kuvan ensimmäisen ja toisen
asteen derivaattoja. Algoritmin vaiheet pääpiirteissään ovat

* Hessen matriisin laskeminen useissa skaaloissa approksimoiden toisen asteen
  derivaattoja eri kokoisten laatikkosuotimien avulla,
* matriisin determinantin lokaalien maksimien laskeminen,
* maksimipisteiden sijainnin interpolointi sekä tilassa että skaalassa.

SURF-piirrevektorit ovat Haarin wavelet-funktioiden (eli eräänlaisten
laatikkosuotimilla approksimoitujen ensimmäisen asteen derivaattojen)
histogrammeja, ja myös näiden wavelet-funktioiden laskemisessa käytetään
integraalikuvia. Myös tämä histogrammi normalisoidaan Haar-
wavelettien pääasiallisen suunnan mukaan. Jos suunnalla ei ole merkitystä,
normalisointi voidaan jättää pois. Varsinaisessa deskriptorissa käytetään myös
4x4:ää aluetta valitun pisteen ympärillä, tarvittaessa normalisoituna
pääasiallisen suunnan mukaan. Jokaisesta pienemmästä laatikosta kerätään Haarin
wavelet-funktioiden vasteet 5x5 pisteestä, ja näistä lasketaan x- ja
y-suuntaisten vasteiden summa ja summan itseisarvo. Nämä summat muodostavat
varsinaisen piirrevektorin arvot, joten yhteensä saadaan 4x4x4 eli 64
elementtiä.

Vaikka SURF on yksinkertaisempi ja nopeampi kuin SIFT, sillä saavutetaan hyvin
samankaltaisia tuloksia.

Nämä kaksi esimerkkiä osoittanevat hyvin, mitkä ovat pääasialliset periaatteet
pistepiirteiden etsinnässä ja kuvailussa. Molempiin menetelmiin on kehitelty
paljon pieniä parannuksia ja laajennuksia, joten jos niitä käytetään jossakin
sovelluksessa, on syytä tutustua kirjallisuuteen parhaan toteutustavan
valitsemiseksi.

[speeded up robust features]: http://en.wikipedia.org/wiki/SURF

## Tehtäviä
