---
title: Tutoriaali 6
author: Matti Eskelinen
date: 15.3.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tämän viikon aiheena on kuvien segmentointi, eli jakaminen jossakin mielessä
yhtenäisiin erillisiin alueisiin. Vaikka segmentointi on tavallaan
samankaltainen operaatio kuin reunanhaku, se on hankalampi toteuttaa siinä
mielessä, että ei ole mitään yhtä suoraviivaista operaatiota, jolla mistä
tahansa kuvasta saisi segmentit esiin. OpenCV-kirjastossakaan ei ole
kynnystyksen lisäksi mitään valmista, helppokäyttöistä menetelmää. Yritämme
kuitenkin saada kokeiltua joitakin perusmenetelmiä.

## Klusterointi

Kuvia saa 'kynnystettyä' useamman kuin yhden raja-arvon mukaan muodostamalla
pikseleistä piirrevektoreita ja käyttämällä jotakin klusterointimenetelmää
samankaltaisten piirrevektorien ryhmittelemiseen. Palauttamalla ryhmien
tunnukset pikselien arvoiksi saadaan tuloksena eräänlainen moniarvoinen
kynnystys. OpenCV-kirjastosta löytyy toteutus tunnetulle K-means
-menetelmälle:

<http://docs.opencv.org/2.4.13/modules/core/doc/clustering.html#kmeans>

Tässä menetelmässä täytyy valita klusterien määrä $k$. Menetelmä pyrkii
löytämään piirrevektorien jakaumasta Gaussisen jakauman kaltaisia tihentymiä.
Esimerkiksi yksiulotteisten piirrevektorien, kuten pikselien harmaasävyn tai
värisävyn tapauksessa, klusterit asettuvat histogrammin huippujen kohdalle.
Jos klustereita on useampia kuin huippuja, jotkin luonnolliset klusterit
jakautuvat osiin. Hyvän tuloksen saamiseksi voi olla tarpeen kokeilla useilla
$k$:n arvoilla ja vertailla syntyvien klusterien laatua.

Aluksi on muodostettava piirrevektoreista matriisi. Kukin vektori on rivinä
matriisissa. Yksiulotteisen piirrevektorin tapauksessa, esimerkiksi
käytettäessä pikselin arvoa, matriisi voidaan muodostaa esimerkiksi näin:

```{.python}
import cv2
import numpy as np

(rows, cols, d) = img.shape
n = rows * cols

points = np.zeros((n,1), np.float32)

for y in range (0, rows):
  for x in range (0, cols):
    p = y * cols + x
    points[p] = np.float32(img.item(y,x))
```

Pythonista löytyy myös valmiita menetelmiä kuvamatriisien käsittelyyn,
esimerkiksi funktiolla *ravel* saa purettua matriisin vektoriksi:

```{.python}
points = np.float32(np.ravel(img))
```

tuottaa saman tuloksen kuin edellä.

Useampiulotteisilla piirrevektoreilla toimitaan vastaavasti, lisäten matriisin
sarakkeiden määrää. Matriisin alkioiden on oltava liukulukuja k-means
-menetelmää varten.

Klusterointi voidaan suorittaa seuraavasti:

```{.python}
k = 5
num_attempts = 10
term_crit = (cv2.TERM_CRITERIA_EPS, 30, 0.1)
ret, labels, centers = cv2.kmeans(points, k, term_crit, num_attempts, 0)
```

Tässä $k$ on luonnollisesti muodostettavien klusterien määrä. Parametrilla
*num_attempts* voidaan suorittaa hakua useita kertoja peräkkäin erilaisilla
klusterien keskipisteiden alkuarvauksilla, ja lopuksi valitaan tulos, jossa
klusterit ovat mahdollisimman kompakteja dokumentaatiossa kuvatun
kompaktisuusarvon mielessä. Parametri *term_crit* määrää lopetusehdon.

Tuloksena on matriisi, joka sisältää klusterin kokonaislukutunnisteen jokaista
pikseliä kohti, sekä klusterien keskipisteiden koordinaatit. Määräämällä
jokaista tunnistetta kohti jonkin mielivaltaisen värin, tulos saadaan
visualisoitua kuvana, esimerkiksi:

```{.python}
for y in range (0, rows):
  for x in range (0, cols):
    p = y * cols + x
    img.itemset((y,x,0), np.uint8(40*labels[p]))
    img.itemset((y,x,1), np.uint8(40*labels[p]))
    img.itemset((y,x,2), 255)
```

tunnistevektorin saa myös koottua takaisin kuvamatriisiksi:

```{.python}
img = np.float32(labels.reshape(rows, cols))
```

Tämä pitää luonnollisesti normalisoida sopivasti kuvaksi visualisointia varten.

## Yhtenäiset alueet

Kynnystys- ja klusterointimenetelmät saattavat tuottaa useita toisistaan
irrallisia segmenttejä. Kunkin irrallisen osan saa omaksi segmentikseen
käyttämällä yhtenäisten alueiden merkitsemistä (engl. *connected components
analysis*). Siinä käydään kuvaa läpi rivi riviltä *flood-fill* -tyyppisesti ja
pidetään kirjaa yhtenäisistä alueista esimerkiksi *union-find* -menetelmään
perustuvalla pistevieraiden joukkojen (*disjoint sets*) hallinnalla.

OpenCV-kirjastossa yhtenäiset alueet saa etsittyä binäärikuvasta käyttämällä
menetelmää *findContours*. Tuloksena on reunakäyriä ilmoitettuina pistelistoina.
Yksinkertaisiin alueenetsintätarkoituksiin nämä ovat hieman hankalia käsitellä.
Palaamme niihin myöhemmin muodon kuvailun yhteydessä. Tässä vaiheessa tarjotaan
kokeiltavaksi kurssin pitäjän oma toteutus menetelmästä. Se on c-kirjasto, jossa
on alustava Python-rajapinta. Tämä rajapinta on käytettävissa uusimmassa
amnipar/cv -dockerkuvassa.

```{.python}
from cvsu import run_cc
run_cc(src, dst)
```

Kuvan *src* on toistaiseksi oltava *np.uint8* -tyyppinen harmaasävykuva. Kuvan
*dst* on oltava samankokoinen, *np.uint8* -tyyppinen värikuva. Lähtökuva voi
olla binäärikuva, klusteroitu kuva (esimerkiksi labels-kuva kasattuna
matriisiksi ja muunnettuna *np.uint8* -muotoon) tai vaikka ihan tavallinen
harmaasävykuva. Lopputuloksessa on jokainen erillinen yhtenäinen alue, joka
koostuu täsmälleen samanarvoisista pikseleistä, maalattuna omalla värillään.

Menetelmän Python-rajapintaa kehitetään ainakin sellaiseen muotoon, että
kohdekuvaa ei tarvitsisi antaa vaan lopputuloksesta generoitaisiin uusi,
esimerkiksi *np.uint32* -tyyppinen kuva joka sisältäisi pikselien
kokonaislukutunnisteet. Tästä olisi sitten helppo generoida esimerkiksi
binäärimaski jokaista erillistä aluetta kohti.

Menetelmä tekee paljon muutakin kuin vain maalaa pikseleitä. Se etsii myös
alueiden rajoittavat suorakulmiot (*bounding boxes*) ja massakeskipisteet sekä
merkitsee reunapikselit. Python-rajapintaan saatetaan mahdollisuuksien mukaan
tuoda tarjolle näitäkin ominaisuuksia. Voi olla myös mahdollista tehdä siitä
koodiesimerkki omien c-algoritmien Python-rajapintojen kehittämiseen Cython-
kirjaston avulla.

Luonnollisesti rajapinnassa saattaa olla bugeja, joista otetaan mieluusti
tietoja vastaan.

## Pienin virittävä metsä

Ehkä yleiskäyttöisin ja nopein varsinainen segmentointimenetelmä perustuu
pienimpien virittävien puiden muodostaman metsän (*minimum spanning forest*,
MSF) etsintään. Tämä viittaa luonnollisesti graafeihin ja tunnettuun
graafialgoritmiin. Ideana on se, että kuva muunnetaan graafiksi, jossa pikselit
ovat solmuina, ja jokainen pikselisolmu on liitetty kaarella neljään
naapuripikseliin. Kaarien painokertoimiksi asetetaan pikselien välinen etäisyys
esimerkiksi harmaasävyn tai värisävyn suhteen.

Graafin pienintä virittävää puuta lähdetään muodostamaan perustuen erittäin
tunnettuun Kruskalin algoritmiin. Siinä kaaret lajitellaan painokertoimen
suhteen nousevaan järjestykseen, ja kaaria poistetaan virittävästä puusta jos
kaari muodostaisi silmukan puuhun. Silmukoista pidetään kirjaa *union-find*
-menetelmällä. Virittävän puun rakentaminen voidaan lopettaa kesken jonkin
kriteerin perusteella, esimerkiksi kun kaarien painokertoimet ylittävän jonkin
raja-arvon. Näin saadaan lopputuloksena 'virittävä metsä', jossa olevat puut
ovat kuvan yhtenäisiä alueita eli segmenttejä.

Menetelmä on ehkä lähimpänä yleiskäyttöistä, suoraviivaista ja nopeaa
segmentointimenetelmää. Sen käyttäminen vaatii kuitenkin säätämistä kynnysarvon
asettamisen muodossa. Toisaalta se on periaatteessa täysin yleiskäyttöinen,
segmentoinnin kriteerinä voitaisiin käyttää mitä tahansa pikseleistä
muodostettavia piirteitä, jotka voidaan esittää vektoreina ja joiden välistä
etäisyyttä voidaan mitata jonkin metriikan avulla.

Ohjelmointiympäristössä on tarjolla kurssin luennoijan kehittämä toteutus MSF-
menetelmästä. Sitä käytetään samaan tapaan kuin yhtenäisten alueiden merkintää:

```{.python}
from cvsu import run_msf
run_msf(src, dst, 0.01)
```

Tässä menetelmässä kuvan *src* on oltava *np.float32* -tyyppinen harmaasävykuva,
ja kuvan *dst* on oltava *np.float32* -tyyppinen värikuva. Tällä hetkellä
tuloskuvan pikselit maalataan harmaasävyarvoilla, myöhemmin väreillä.
Menetelmässä muodostetaan kuvasta graafi käyttäen pikseliarvojen euklidista
etäisyyttä kaarien painokertoimena, ja rakennetaan graafin pienintä virittävää
puuta kolmantena parametrina annettuun raja-arvoon asti (on syytä huomata, että
tyypillisissä liukulukukuvissa pikselien arvot ovat väliltä $0-1$.)

Tätäkin rajapintaa kehitetään vielä eteenpäin. Itse menetelmän toteutus on hyvin
joustava ja monipuolinen, siinä voitaisiin helposti tukea mielivaltaisia
n-ulotteisia piirrevektoreita pikseleille. Tämäkin menetelmä tekee paljon
muutakin kuin vain muodostaa virittävää puuta: se kokoaa samalla tilastollisia
tunnuslukuja ja momentteja siihen mennessä muodostuneista yhtenäisistä alueista,
ja siinä voitaisiin käyttää näitä tunnuslukuja lopettamiskriteerinä.

Toistaiseksi menetelmä jättää helposti reuna-alueille useita pieniä segmenttejä.
Jatkokäsittelyvaiheena voitaisiin yhdistää 'liian pienten' alueiden pikselit
lähimpään suurempaan alueeseen, mahdollisesti huomioiden reunakäyrän sileys.

Yhtenäisten alueiden ja reunakäyrien lisäksi tästä menetelmästä saataisiin ulos
myös hierarkinen graafiesitys yhtenäisistä alueista siten, että alueet olisivat
solmuina ja kaaret yhdistäisivät keskenään vierekkäisiä alueita. Solmuihin voisi
liittää tilastollisia tunnuslukuja ja muotopiirteitä. Tätä voisi käyttää
esimerkiksi tilastollisen tai loogisen päättelyn pohjana kohteiden
tunnistamisessa.

## Anisotrooppinen suodatus

Tämä ei varsinaisesti suoraan liity tämän tutoriaalin aiheeseen, mutta
luennoitsijan toteuttamiin menetelmiin sisältyy myös toteutus anisotrooppiselle
suodatukselle perustuen simuloituun diffuusioon anisotrooppisilla
diffuusioytimillä. Yksinkertaisesti sanottuna, perustuen lämmön leviämiseen
epäsymmetrisesti sen mukaan, miten paljon vaihtelua missäkin suunnassa on.

Laskentatulos muistuttaa hyvin paljon bilateraalista suodatusta, mutta se on
laskennallisesti vähemmän raskas. Se siis pehmentää tasaisia alueita mutta
jättää reunat ennalleen. Periaatteessa tarkasti säätämällä menetelmän voi saada
jopa terävöittämään reunoja, mutta sillon se muuttuu herkästi numeerisesti
epävakaaksi ja saattaa alkaa tuottaa ylimääräisiä reunoja.

Toistaiseksi menetelmän parametreista voi muuttaa vain simulointikierrosten
määrää. Periaatteessa menetelmässä siis simuloidaan numeerisesti lämpöyhtälön
ratkaisemista ajan suhteen käyttäen reunaehtona kuvan pikseliarvojen mukaisia
'lämpötiloja' ja muuttamalla pikselien välistä lämmönjohtavuutta gradientin
mukaisesti (suuri gradientti tarkoittaa pienempää lämmönjohtavuutta). Myöhemmin
lisätään muitakin säätöparametreja.

```{.python}
from cvsu import run_adiffusion
run_adiffusion(src, dst, 12)
```

Tässä menetelmässä sekä kuvan *src* että kuvan *dst* on oltava *np.float32*
-tyyppisiä harmaasävykuvia. Myöhemmin voisi olla perusteltua tukea myös double-
tyyppisiä kuvia tarkkuuden parantamiseksi. Kolmas parametri on
simulointikierrosten määrä. Mitä enemmän kierroksia, sitä enemmän yksityiskohtia
häviää, ja lopulta reunatkin alkavat kadota.

Menetelmä soveltuu hyvin esimerkiksi esikäsittelyksi klusteroinnille tai msf-
segmentoinnille. Kirjastossa on myös vastaavalla tavalla toimiva
*run_idiffusion*, joka toteuttaa normaalia isotrooppista diffuusiota. Se vastaa
siis tavallista Gaussista suodatusta. Tästä puhutaan skaala-avaruuksien
yhteydessä.

## Mean shift

Toinen yleisille piirrevektoreille soveltuva segmentointi olisi *mean shift*.
Tästä voisi rakentaa suhteellisen tehokkaan toteutuksen käyttäen *kd-tree*
-tietorakennetta. Ohjelmointiympäristöön on lisätty *scipy*-kirjasto jossa on
esimerkiksi juuri tämä tietorakenne. Siihen palataan myöhemmin luokittelun
yhteydessä. Jos aikaa jää, tähän saatetaan lisätä koodiesimerkki mean shiftin
toteuttamisesta.

## Graafileikkaukset

Periaatteessa matemaattisesti vahvin tavallisen käyttäjän ulottuvilla oleva
menetelmä ovat niinsanotut normalisoidut graafileikkaukset (*normalized cuts*).
Menetelmä on laskennallisesti raskas, mutta se on toteutettavissa
matriisilaskennan keinoin käyttäen harvojen matriisien esitysmuotoja. Kurssin
aiemmalla opetuskerralla esiteltiin menetelmästä Haskell-toteutus, joka toimi
kohtalaisesti pienille kuville. Jos aikaa ja intoa on, tähän voidaan lisätä
myöhemmin vastaava Python-esimerkki. Edellisen kurssin haskell-koodit löytyvät
reposta <https://yousource.it.jyu.fi/cvlab/hs-cvcodes>.

## Tehtäviä

Kokeile k-means -segmentointia kuvillesi erilaisilla keksimilläsi
piirrevektoreilla. Kokeile myös Lab-värikuvien a- ja b-kanavia sekä LCh-
värikuvien värisävykanavaa sekä pikselikoordinaattien yhdistämistä
piirrevektoriin. Voit myös kokeilla erilaisten suodinmaskien vasteita, mutta
myöhemmin toivottavasti saadaan esimerkkejä paremmin tällaiseen tarkoitukseen
soveltuvista menetelmistä.

Voit myös kokeilla OpenCV-tutoriaalin esimerkkiä watershed-menetelmästä, jos
pystyt muodostamaan jonkinlaisen alkuarvauksen:

<https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_imgproc/py_watershed/py_watershed.html#watershed>

Kokeile myös yhtenäisten alueiden etsintää ja msf-segmentointia.
