---
title: Tutoriaali 4
author: Matti Eskelinen
date: 22.2.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tällä kerralla tutkitaan värikuvia ja kokeillaan monikanavaisten kuvien
hajottamista osakanaviin ja kokoamista takaisin. Opimme myös muuntamaan kuvia
väriavaruuksista toisiin.

Ota aluksi käyttöön tarvittavat kirjastot.

```{.python}
import math
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
```

## Värimuunnokset 

Kokeile värimuunnoksia valitsemallasi kielellä käyttäen OpenCV-kirjaston
funktiota `cv.cvtColor()`:

<http://docs.opencv.org/2.4.13/modules/imgproc/doc/miscellaneous_transformations.html#cvtcolor>

Hyödyllisin muunnos voi olla muunnos RGB-avaruudesta Lab-avaruuteen. Jos haluat
muuntaa värikuvia harmaasävykuviksi, paras tapa saattaa olla muuntaa Lab-
väriavaruuteen ja erottaa L-kanava.

On tärkeää huomata, että OpenCV:ssä värikuvat ovat tyypillisesti oletuksena BGR-
muodossa RGB-muodon sijaan; sininen ja punainen värikanava ovat siis vaihtaneet
paikkaa. Tätä voi kokeilla kuvalla, jossa on kirkkaan sinisiä tai punaisia
kohteita ja tallentamalla kunkin värikanavan omaksi kuvakseen

Kuvan saa luettua värillisenä ja konvertoitua Lab-kuvaksi seuraavasti. Vaihda
tähän jokin oma kuvasi tai muu itse valitsemasi värikäs kuva.

Huomaa, että kuvan piirtämistä varten on tehtävä värimuunnos BGR-RGB! OpenCV
käsittelee värikuvia oletuksena BGR-muodossa, jossa sininen ja punainen
värikanava ovat vaihtaneet paikkaa. Jos värikuva näyttää hassulta, syynä voi
olla tämä.

```{.python}
img = cv.cvtColor(cv.imread('../images/flora02053.jpg', cv.IMREAD_COLOR), cv.COLOR_BGR2RGB)
#img = cv.imread('../images/flora02053.jpg', cv.IMREAD_COLOR)
lab = cv.cvtColor(img, cv.COLOR_RGB2LAB) # BGR2LAB
```

Värikanavat saa hajotettua erillisiksi kuviksi näin:

```{.python}
l,a,b = cv2.split(lab)
```

## Muunnos napakoordinaatteihin

Värisävy on hyödyllinen tieto, kun väri-informaatiota halutaan hyödyntää
tunnistamisessa tai vaikkapa reunantunnistuksessa. Kokeile toteuttaa muunnos
Lab-väriavaruudesta LCh(ab)-väriavaruuteen. Muistamme, että tämä vastaa
muunnosta karteesisista koordinaateista napakoordinaatteihin, samaan tapaan kuin
teimme laskiessamme Fourier-kertoimien amplitudin ja vaiheen. Nyt meillä on siis
karteesiset värikkyyskoordinaatit $a$ ja $b$, joista haluamme laskea
värikylläisyyden (joka on siis etäisyys valkoisesta pisteestä eli origosta ja
vastaa Fourier-kertoimen amplitudia tai vektorin magnitudia) ja värisävyn (joka
on siis kulma väriympyrällä ja vastaa Fourier-kertoimen vaihetta). Käytetään
siis muunnokseen jälleen funktiota `cv.cartToPolar()`.

```{.python}
c,h = cv2.cartToPolar(np.float32(a),np.float32(b))
```

Värisävyä hyödynnettäessä on syytä muistaa kaksi seikkaa: ensinnäkin värisävy
saa arvoja joukosta, joka muodostaa ympyrän kehän eikä siis ole suora jolla
olisi alku ja loppu. Funktio `cv.cartToPolar()` palauttaa oletuksena kulman
radiaaneina väliltä $[0, 2 \pi]$, ja tämän välin ääripäissä olevat värit ovat
käytännössä sama väri. Värisävyjen eroa pitää siis mitata ympyrän kehää pitkin,
huomioiden lyhyin etäisyys.

Toinen muistettava seikka on, että värisävyä on vaikea määrittää, kun
värikylläisyys on matala. Jos kuva-alue on lähes valkoinen tai lähes musta,
värisävy voi olla melko satunnainen. Tämä on huomioitava vertailuissa.
Värikylläisyyden voi tulkita värisävyn 'epävarmuutena', tai sitten tehdä
värikylläisyydestä kynnystämällä maskin, jonka avulla sulkee värianalyysistä
pois ne pikselit joiden värisävy on liian epävarma.

Tutkitaan seuraavaksi, mitä LCh(ab)- ja Lab-väriavaruuden värit oikeastaan
tarkoittavat. Kuten Fourier-muunnoksen kanssa, voimme tehdä tämän generoimalla
kuvia kohdeavaruudessa ja tekemällä käänteismuunnoksen.

Tutkitaan ensin, mitä h-värikanavan värit oikeastaan ovat.

```{.python}
w = 400
h = 50
size = (h,w)

# generoidaan h-kanavan pikselien arvot x-koordinaatin mukaan välille [0, 2pi]
def specValue(y,x):
    return (x / w) * 2 * math.pi

# h-kanavaan tulee siis kaikki mahdolliset kulmat [0, 2pi]
spec_h = np.fromfunction(specValue, size, dtype=np.float32)
# c-kanava on aluksi 1, jotta saadaan kaikki a- ja b-kanavien koordinaatit yksikköympyrälle
spec_c = spec_l = np.ones(size, dtype=np.float32)
# muunnetaan polaarikoordinaateista karteesisiksi a- ja b-koordinaateiksi
spec_a, spec_b = cv.polarToCart(spec_c, spec_h, angleInDegrees=False)

# OpenCV:ssä Lab-kuvan väriarvojen skaalat ovat [0,100], [-127,127], [-127,127]
# käytetään L-kanavalla arvoa 50, jotta väristä ei tule niin kirkas että se palaa puhki näytöltä katsoessa
# yhdistetään kanavat skaalattuina oikeille arvoväleille ja muunnetaan tavalliseksi värikuvaksi
spec_img = cv.cvtColor(cv.merge([60*spec_l, 127*spec_a, 127*spec_b]), cv.COLOR_LAB2BGR)
```

Kuten huomaamme, värisävyt kiertävät sinivioletista punaviolettiin vihreän ja
keltaisen kautta, kuten oikeassakin spektrissä ja esimerkiksi sateenkaaressa.
Seuraavaksi yritämme hahmottaa, mitä a- ja b-kanavien arvot tarkoittavat.

```{.python}
w = 400
h = 400
s = 200
size = (h,w)

# generoidaan a-kanavan pikselien arvot x-koordinaatin mukaan välille [-127, 127]
def aValue(y,x):
    return ((x-s) / w) * 127

# generoidaan b-kanavan pikselien arvot y-koordinaatin mukaan välille [-127, 127]
# y-koordinaatti pitää peilata, koska kuvassa koordinaatti kasvaa ylhäältä alaspäin
def bValue(y,x):
    return (-(y-s) / w) * 127

map_a = np.fromfunction(aValue, size, dtype=np.float32)
map_b = np.fromfunction(bValue, size, dtype=np.float32)
map_l = np.ones(size, dtype=np.float32) * 60

map_img = cv.cvtColor(cv.merge([map_l, map_a, map_b]), cv.COLOR_LAB2BGR)
```

Kuten huomaamme, värisävyt kiertävät vastapäivään alkaen oikealta keskeltä
samassa järjestyksessä kuin spektrikuvassa. Värikylläisyys kasvaa kuvan keskeltä
reunoille päin. Huomaamme myös, että neliön nurkissa on värikylläisempiä sävyjä.
Luonnollisesti on myös selvää, että polaarikoordinaateiksi muunnettaessa neliön
nurkkien kohdalla etäisyys origosta on suurempi kuin reunoilla. Jos siis
värikylläisyys normalisoidaan, neliön nurkissa olevat värit leikkautuvat pois,
tai sitten vinosuunnissa muunnosta pitää skaalata eri tavalla.

## Tehtäviä

Jos kuvamateriaalisi on värikuvia, tutki miltä niiden värit näyttävät Lab-
avaruudessa tai LCh(ab)-avaruudessa. Pohdi, millä tavalla voisit hyödyntää
värejä ongelmasi ratkaisemisessa. Voit myös etsiä muita värikkäitä kuvia ja
tutkia niitä oppimismielessä, jos väri-informaatio ei ole oleellista omassa
työssäsi. Voit myös tutkia muita `cvtColor`-funktion tukemia väriavaruuksia
vastaavasti kuin on tehty tässä.
