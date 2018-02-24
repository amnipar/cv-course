---
title: Tutoriaali 5
author: Matti Eskelinen
date: 1.3.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tällä kerralla ryhdymme kokeilemaan reunojen etsimistä kuvista. Aiheeseen
palataan vielä skaala-avaruuksien yhteydessä, ja reunakäyrien ketjutukseen ja
piirteytykseen tunnistamistarkoituksia varten tutustumme kurssin loppupuolella.

Ota aluksi käyttöön tarvittavat kirjastot.

```{.python}
import math
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
```

Reunan helpomman hahmottamisen vuoksi käytämme aluksi yksinkertaista
ympyräkuvaa. Loppupuolen nurkkien etsimisessä tuttu neliökuva on sopivampi.

```{.python}
size = (401,401)
h,w = size
dy = h/2
dx = w/2

def testMask(y,x):
    return np.sqrt((y-dy)**2 + (x-dx)**2) < dx-80

img = cv.blur(np.float32(np.fromfunction(testMask, size, dtype=np.float32)),(3,3))
```

## Gradientin muodostaminen

Perinteinen, edelleen melko yleisesti käytetty tapa gradientin laskemiseen on
Sobelin operaattoreilla konvolvoiminen:

<http://docs.opencv.org/2.4.13/modules/imgproc/doc/filtering.html#sobel>

Pythonilla sen voi tehdä näin:

```{.python}
gx = cv.Sobel(img, ddepth=cv.CV_32F, dx=1, dy=0, ksize=5)
gy = cv.Sobel(img, ddepth=cv.CV_32F, dx=0, dy=1, ksize=5)
```

## Cannyn reunanhaku

Käytetyin valmis reunanhakumenetelmä on varmaankin Cannyn reunanhaku. 

<http://docs.opencv.org/2.4.13/modules/imgproc/doc/feature_detection.html#canny>

Sen heikkous on, että se toimii vain 8-bittisillä kuvilla, ja se vaatii kahden
kynnysarvon määrittämisen. Nämä eivät ole kovin herkkiä parametreja, mutta
tietty valinta ei kuitenkaan välttämättä toimi suoraan kaikilla kuvilla. Cannyn
menetelmä käyttää Sobelin maskeja, joiden koon voi valita arvoista 3, 5, 7. Nämä
vaihtoehdot eivät välttämättä riitä kaikkiin tilanteisiin.

```{.python}
# voit kokeilla käyttää myös suodatettua kuvaa
#blur = cv.GaussianBlur(img, (9, 9), 0)
# ei tarvitse muuttaa tavuiksi, jos luet kuvan tiedostosta
edges = cv.Canny(np.uint8(255*img), 10, 100, apertureSize=5, L2gradient=True)
```

## Ensimmäisen asteen derivaatan ääriarvojen etsiminen

Cannyn menetelmä perustuu ensimmäisen asteen derivaatan ääriarvojen etsimiseen.
Tämä vaatii periaatteessa gradientin suunnan laskemisen ja naapuripikselien
arvojen vertailua gradientin suunnassa (reunan suuntaa vastaan). Lisäksi
täytyisi pitää kirjaa siitä, ovatko naapuripikselit suurempia vai pienempiä kuin
tutkittava pikseli. Tyypillisesti ei ole kuitenkaan merkitystä sillä, onko
reunalla derivaatan maksimi vai minimi, eli muuttuuko kuva vaaleammaksi vai
tummemmaksi. Tämän vuoksi yleensä käytetäänkin gradientin magnitudia, joka
saadaan laskettua samalla kuin suuntakin tuttuun tapaan muuntamalla gradientti
napakoordinaatteihin.

Lasketaan kuitenkin ensin osittaisderivaatat Sobelin sijaan käyttäen yleisiä
derivaattamaskeja.

```{.python}
kdxx,kdxy = cv.getDerivKernels(dx=1, dy=0, ksize=15, ktype=cv.CV_32F, normalize=1)
kdyx,kdyy = cv.getDerivKernels(dx=0, dy=1, ksize=15, ktype=cv.CV_32F, normalize=1)
```

Hyvänä puolena tässä lähestymistavassa on se, että derivaatan asteen ja maskin
koon voi valita vapaasti. Tuloksena ovat maskit ovat separoituvia, eli riveille
ja sarakkeille on omat maskinsa nopeampaa laskentaa varten. Kuten huomataan,
yllä muodostamme maskeista kaksiulotteisen matriisin kertomalla toisen maskin
toisen transpoosilla. Separoituvien ytimien käyttämiseen on oma funktionsa,
`cv.sepFilter2D()`.

```{.python}
sdx = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdxx, kernelY=kdxy)
sdy = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdyx, kernelY=kdyy)
```

Nyt voimme laskea gradientin magnitudin ja suunnan. On syytä huomata, että
suunta on väliltä $[0,2 \pi]$, kun taas arkustangenttia `cv.atan2()` käyttäessä
tulos olisi välillä $[-\pi, \pi]$.

```{.python}
mag, ang = cv.cartToPolar(sdx, sdy)
```

Koska naapuripikseleitä on vain neljässä eri suunnassa, kvantisoimme seuraavaksi
gradientin suunnan neljään pääsuuntaan (vaakasuora, pystysuora ja kaksi
vinosuuntaa). Lisäksi jätämme huomiotta liian pienet gradientin arvot
käyttämällä magnitudin mukaan muodostettua maskia. Käytämme suuntien tyyppinä
kokonaislukuja vertailun helpottamiseksi seuraavassa vaiheessa; yhtä hyvin
voisimme käyttää myös tavuja.

```{.python}
def quantize_angle(a):
    if a < (1 * math.pi / 8):
        return 1
    elif a < (3 * math.pi / 8):
        return 2
    elif a < (5 * math.pi / 8):
        return 3
    elif a < (7 * math.pi / 8):
        return 4
    elif a < (9 * math.pi / 8):
        return 1
    elif a < (11 * math.pi / 8):
        return 2
    elif a < (13 * math.pi / 8):
        return 3
    elif a < (15 * math.pi / 8):
        return 4
    else:
        return 1

mmag = mag > 0.05
qang = np.vectorize(quantize_angle,otypes=[np.int32])(ang)
mang = np.float32(mmag)*np.float32(qang) / 4
```

Käytetään nyt gradientin magnitudia ja kvantisoitua suuntaa päättelemään, mitkä
pikselit ovat derivaatan lokaaleja ääriarvoja. Suunta kertoo meille, mitkä
naapuripikselit on tarkistettava. Merkitsemme reunan sinne, missä molemmissa
gradientin suuntaisissa naapuripikseleissä on pienempi tai yhtäsuuri magnitudin
arvo.

```{.python}
eimg = np.zeros(img.shape,dtype=np.float32)
edges = np.argwhere(mag > 0.05)
for y,x in edges:
    if qang[y,x] == 1: # pystysuora reuna
        if (mag[y,x-1] <= mag[y,x]) and (mag[y,x+1] <= mag[y,x]):
            eimg[y,x] = 1
    if qang[y,x] == 2: # alhaalta ylös suuntautuva vino reuna
        if (mag[y-1,x-1] <= mag[y,x]) and (mag[y+1,x+1] <= mag[y,x]):
            eimg[y,x] = 1
    if qang[y,x] == 3: # vaakasuora reuna
        if (mag[y-1,x] <= mag[y,x]) and (mag[y+1,x] <= mag[y,x]):
            eimg[y,x] = 1
    if qang[y,x] == 4: # ylhäältä alas suuntautuva vino reuna
        if (mag[y-1,x+1] <= mag[y,x]) and (mag[y+1,x-1] <= mag[y,x]):
            eimg[y,x] = 1
```

Osa reunoista jää merkitsemättä varmaankin sen takia, että kyseisessä kohdassa
pikseli ei ole absoluuttisesti naapureitaan suurempi oletetussa gradientin
suunnassa. Huomaamme, että näitä kohtia on erityisesti vinoilla osuuksilla.
Tulosta voisi parantaa sillä, että tutkisi myös viereiset suunnat, jos
ensisijaisesta suunnasta ei löydy ääriarvoa.

Huomaamme myös, että parissa kohdassa reunasta on tullut kahden pikselin
levyinen. Tämän voisi yrittää välttää sillä, että ei hyväksy yhtäsuuruutta
vertailussa; float-liukuluvun tarkkuus ei välttämättä riitä tässä tapauksessa
löytämään kaikkia reunakohtia, mutta tilannetta voisi parantaa käyttämällä
double-liukulukuja pikselien arvoina ja pehmentämällä double-muotoista kuvaa
ensin pikselien arvojen levittämiseksi ennen derivaatan laskemista.

Reunassa olevia aukkoja voisi yrittää paikata myös tutkimalla reunanpätkien
päissä olevien pikselien naapureita *reunan* (ei gradientin) suunnassa.

Kaiken kaikkiaan huomaamme kuitenkin, että tulos on hyvin samankaltainen kuin
Cannyn reunanhaulla. Lisäksi tässä menetelmässä on käytetty vain yhtä
kynnysarvoa, eikä menetelmä ole kovin herkkä valitulle arvolle. Lähinnä sen
tarkoitus on karsia pois ilmiselvästi liian heikot gradientin arvot
ylimääräisten reunojen välttämiseksi.

## Toisen asteen derivaatan nollakohtien etsiminen

Kuten tiedämme, ensimmäisen asteen derivaatan ääriarvot ovat kohdissa, joissa
toisen asteen derivaatalla on nollakohta. Nollakohta on helpompi tunnistaa kuin
ääriarvo, joten kokeillaan seuraavaksi reunanhakua tällä tavoin.

Osittaisderivaattojen laskemiseen tarvittavat maskit voidaan luoda samalla
tavoin kuin ensimmäisen asteen derivaattojenkin kohdalla. Kuten muistamme,
osittaisderivaattoja on kolme: voidaan derivoida joko kaksi kertaa $x$:n tai
$y$:n suhteen, tai kerran molempien suhteen.

```{.python}
kdx2x,kdx2y = cv.getDerivKernels(dx=2, dy=0, ksize=15, ktype=cv.CV_32F, normalize=1)
kdy2x,kdy2y = cv.getDerivKernels(dx=0, dy=2, ksize=15, ktype=cv.CV_32F, normalize=1)
kdxdyx,kdxdyy = cv.getDerivKernels(dx=1, dy=1, ksize=15, ktype=cv.CV_32F, normalize=1)
```

Osittaisderivaatat laskemme samalla tavoin kuin edellä.

```{.python}
sdx2 = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdx2x, kernelY=kdx2y)
sdy2 = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdy2x, kernelY=kdy2y)
sdxdy = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdxdyx, kernelY=kdxdyy)
```

Yhdistettyä osittaisderivaattaa tarvitsemme lähinnä silloin, jos haluamme
muodostaa suunnatun suotimen. Nollakohtien laskemiseksi voimme käyttää Laplacen
operaattoria. Voimme joko laskea yhteen $x$:n ja $y$:n suuntaiset
osittaisderivaata, tai käyttää suoraan funktiota `cv.Laplacian()`, joka käyttää
samoja derivaattaytimiä kuin me olemme käyttäneet yllä.

```{.python}
log = cv.Laplacian(img, ddepth=cv.CV_32F, ksize=15)kernelY=kdxdyy)
```

Näemme kuvasta, että reunan ympärillä on selkeästi tummia pikseleitä toisella
puolella ja vaaleita toisella puolella. Välissä on nollakohta (harmaa väri
vastaa tässä arvoa $0$).

Ensimmäisen asteen derivaatan ääriarvokohtien etsiminen vaati ottamaan huomioon
gradientin suunnan. Toisen asteen derivaatan nollakohtien etsimisessä suuntaa ei
tarvitse huomioida, mutta yksinkertainen vertailu nollan kanssa ei toimi:
derivaatta ei välttämättä ole täsmälleen nolla yhdenkään pikselin kohdalla, vaan
oikea nollakohta on jossakin naapuripikselien välissä. Voimme kuitenkin
päätellä, että nollakohta on jossakin tietyn pikselin lähistöllä, jos
naapuripikseleillä on sekä nollaa suurempia että nollaa pienempiä arvoja.

```{.python}
eimg2 = np.zeros(img.shape,dtype=np.float32)
edges2 = np.argwhere(mag > 0.05)
for y,x in edges2:
    neg = (log[y-1,x-1] < 0) or (log[y-1,x] < 0) or (log[y-1,x+1] < 0) or (log[y,x-1] < 0) or (log[y,x+1] < 0) or (log[y+1,x-1] < 0) or (log[y+1,x] < 0) or (log[y+1,x+1] < 0)
    pos = (log[y-1,x-1] > 0) or (log[y-1,x] > 0) or (log[y-1,x+1] > 0) or (log[y,x-1] > 0) or (log[y,x+1] > 0) or (log[y+1,x-1] > 0) or (log[y+1,x] > 0) or (log[y+1,x+1] > 0)
    if (neg and pos):
        eimg2[y,x] = 1
```

Löydetty reunakäyrä on ehjä, mutta se on myös monin paikoin yhtä pikseliä
paksumpi. Jos haluaisimme paikallistaa reunan täsmällisen sijainnin, meidän
pitäisi arvioida derivaatan muotoa ja laskea nollan ylitys kussakin ympäristössä
pikseliä suuremmalla tarkkuudella. Tähän perustuu differentiaaligeometrinen
reunanhaku: toisen asteen derivaatan muotoa arvioidaan kolmannen asteen
derivaatan perusteella. Tämä kuitenkin menee yli tämän kurssin aihepiiristä, ja
on useimpia käytännön sovelluksia ajatellen turhan raskastakin.

## Nurkkien etsiminen

Kuten muistamme, reunoja löytyy sieltä, missä on selkeä gradientti. Nurkkia taas
löytyy sieltä, missä on kaksi voimakasta gradienttia eri suuntiin. Tutustumme
nyt Harrisin menetelmään sekä Hessen matriisiin perustuvaan menetelmään nurkkien
löytämiseksi. Käytämme tuttua neliökuvaa.

```{.python}
img = cv.GaussianBlur(cv.imread("../images/rect2.png", cv.IMREAD_GRAYSCALE), (9,9), 0)
```

Harrisin menetelmässä meidän täytyy saada laskettua ensimmäisen asteen
derivaattojen keskiarvoja kunkin pikselin ympäristössä. Luonteva tapa on käyttää
yksinkertaisesti Gaussin suodinta. Keskiarvosuodinkin olisi toki käyttökelpoinen
tässä tapauksessa.

```{.python}
sdx = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdxx, kernelY=kdxy)
sdy = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdyx, kernelY=kdyy)

dx_dx = sdx**2
dy_dy = sdy**2
dx_dy = sdx * sdy
dx_dx_g = cv.GaussianBlur(dx_dx, (9,9), 0)
dy_dy_g = cv.GaussianBlur(dy_dy, (9,9), 0)
dx_dy_g = cv.GaussianBlur(dx_dy, (9,9), 0)

# 2x2-matriisin determinantti ja jälki on helppo laskea tutuilla kaavoilla
det_a = dx_dx_g * dy_dy_g - dx_dy_g**2
trace_a = dx_dx_g + dy_dy_g

# alpha on vapaasti valittava parametri, tyypillisesti väliltä 0.06 - 0.15
alpha = 0.06
# Harris arvioi kulman vahvuutta determinantin ja jäljen erotuksen suuruuden mukaan
harris = det_a - (alpha * trace_a**2)
# Szeliski ehdottaa sen sijaan determinantin ja jäljen suhteen käyttämistä; ei tarvita ylimääräistä parametria
harmonic_mean = det_a / trace_a

# Molempien tunnuslukujen kanssa voidaan etsiä paikalliset maksimit, tässä vain kynnystetään
harris_threshold = 5
harmonic_threshold = 1.8

harris_img = harris > harris_threshold
harmonic_img = harmonic_mean > harmonic_threshold
```

Hessen matriisiin perustuvassa menetelmässä käytetään toisen asteen
derivaattoja. Determinantti ja jälki lasketaan samaan tapaan. Muistamme, että
Hessen matriisin jälki on sama kuin Laplacen operaattorin arvo.

```{.python}
img = cv.GaussianBlur(cv.imread("../images/rect2.png", cv.IMREAD_GRAYSCALE), (9,9), 0)sdx2 = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdx2x, kernelY=kdx2y)
sdy2 = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdy2x, kernelY=kdy2y)
sdxdy = cv.sepFilter2D(np.float32(img), ddepth=cv.CV_32F, kernelX=kdxdyx, kernelY=kdxdyy)

det_h = sdx2 * sdy2 - sdxdy**2
trace_h = sdx2 + sdy2
det_h_threshold = 1.5

det_h_img = np.abs(det_h)
trace_h_img = np.abs(trace_h)
det_h_thresh = det_h > det_h_threshold
```

Näemme, että Hessen matriisin determinantti saa suurehkoja arvoja myös reunalla.
Jälki puolestaan saa selkeän paikallisen ääriarvon nurkissa, kun taas reunan
läheisyydessä se saa itseisarvoltaan suurehkoja reunan suuntaisella suoralla.
Kohina vaikuttaa suhteellisen voimakkaasti, kuten toisen asteen derivaatoilta
voi odottaakin. Suuremmat ytimet voivat tuottaa parempia tuloksia. Palaamme
vielä nurkkien etsintään pistepiirteiden yhteydessä.

## Tehtäviä

Kokeile erilaisia derivaattasuotimia ja reunan- ja nurkkienhakumenetelmiä omilla
kuvillasi. Tutki, millaisia reunoja niillä löytyy; ovatko ne ehjiä vai
katkonaisia? Voisiko katkenneita reunoja yrittää korjata jatkamalla niitä
löytyneen reunan suuntaan? Kokeile myös eri kokoisia maskeja, ja yritä löytää
sellainen koko, jolla löydät ongelmasi kannalta olennaiset reunat. Pohdi myös
tulosten jatkojalostamista sovelluksesi kannalta.

Jos käytät värikuvia, kokeile myös reunanetsintää eri värikanavilla, tai
esimerkiksi värisävyn mukaan.

Jos nurkkien tai pistemäisten möykkyjen etsiminen sopii ongelmaasi, kokeile myös
näitä menetelmiä.
