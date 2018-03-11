---
title: Tutoriaali 7
author: Matti Eskelinen
date: 29.3.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tällä kertaa tutustutaan skaala-avaruuden käyttämiseen ja kuvien analysoimiseen
useissa skaaloissa, muun muassa kuvapyramidien avulla.

Ota aluksi käyttöön tarvittavat kirjastot.

```{.python}
import math
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
```

Ladataan seuraavaksi jälleen käsiteltävä kuva.

```{.python}
img = np.float32(cv.imread("../images/rect2.png",cv.IMREAD_GRAYSCALE))
```

```{.python}

```

## Gaussin pyramidi

Tyypillinen tapa muodostaa diskreetti skaala-avaruus on vuoroin
alipäästösuodattaa kuvaa Gaussin ytimellä ja skaalata kuvaa puolta pienemmäksi.
Tätä varten OpenCV:ssä on funktio `cv.pyrDown()`. Se alipäästösuodattaa kuvan ja
pudottaa sitten kuvan resoluution puoleen tiputtamalla parittomat pikselit pois.

```{.python}
# rajataan kuvaa, jotta sen saa jaettua tasan riittävän monta kertaa
orig = img[0:400,0:400]

gp = [orig.copy()]
for i in range(4):
    gp.append(cv.pyrDown(gp[i]))
```

Lopputuloksena taulukossa `gp` on sarja toinen toistaan pienempiä versioita
samasta kuvasta. Tätä tulosta voitaisiin jo käyttää hyödyksi esimerkiksi
etsimällä reunoja tai nurkkia useassa eri skaalassa.

OpenCV:n toteutus on tarkka kuvien koosta. Käytettävien kuvien dimensioiden
pitäisi olla kahdella jaollisia riittävän monta kertaa pyramidin tasojen
muodostamiseksi. Muuten, skaalatessa kuvia takaisin alkuperäiseen kokoon, tulos
ei enää välttämättä olekaan saman kokoinen kuin alkuperäinen. Onkin syytä joko
skaalata alkuperäinen kuva sopivan kokoiseksi tai ottaa kuvan keskeltä sopivan
kokoinen osa.

Muistamme, että skaala-avaruuden parametri $t$ vastaa suodattavan Gaussin
funktion varianssia $\sigma^2$. OpenCV:n toteutuksessa suodatus tehdään
konvolvoimalla maskilla

$$\frac{1}{256} \begin{bmatrix} 
1 & 4 & 6 & 4 & 1  \\ 
4 & 16 & 24 & 16 & 4  \\ 
6 & 24 & 36 & 24 & 6  \\ 
4 & 16 & 24 & 16 & 4  \\ 
1 & 4 & 6 & 4 & 1 
\end{bmatrix}.$$

Tämä on luonnollisesti rakennettu mahdollisimman nopea toteutus mielessä, joten
se ei ole kaikilta osin täysin ihanteellinen. Tarkemmin tutkimalla se vastaa
osapuilleen $\sigma$:n arvoa $1.04$, eli osapuilleen skaalaa $1.08$. Pyramidin
ensimmäisen tason skaalan tulisi kuitenkin olla $1$, joten jos haluaa
teoreettisesti aavistuksen tarkemman tuloksen, pitäisi käyttää $\sigma$:n arvoa
$1$. Käytännössä tulos on kuitenkin riittävän hyvä. On kuitenkin hyvä tietää
$\sigma$:n arvo, jos halutaan verrata keskenään Laplacen pyramidin tasoja.

Koska pyramidi muodostetaan pienentämällä suodatettu kuva puoleen ja
suodattamalla sitten uudelleen samalla maskilla, tässä esimerkissä muodostuvat
skaalat ovat $0$, $1$, $2$, $4$ ja $8$.

## Laplacen pyramidi

Erittäin hyödyllinen skaala-avaruuden muoto on Laplacen pyramidi. Se
muodostetaan tyypillisesti Gaussin pyramidin avulla, lähtien liikkeelle
suurimmasta skaalasta eli pienimmästä kuvasta, skaalaamalla se kaksinkertaiseksi
funktiolla `cv.pyrUp()`, ja laskemalla pikseleittäin erotus pyramidin seuraavan
tason kanssa.

```{.python}
lp = [gp[4].copy()]
for i in range(4, 0, -1):
    lp.append(cv.subtract(gp[i-1], cv.pyrUp(gp[i])))
```

Lopputuloksena taulukossa `lp` on ensimmäisenä voimakkaasti alipäästösuodatettu kuva
ja sen jälkeen *Difference of Gaussians* -tyyppisiä approksimaatioita Laplacen
operaattorista. Jos kaikki taulukon kuvat skaalaa alkuperäisen kokoiseksi ja
laskee ne pikseleittäin yhteen, pitäisi lopputuloksena olla alkuperäinen kuva
tai hyvin lähelle sitä. Pyramidin tasot nimittäin pitävät sisällään
alipäästösuodattimien poistamat kuvan yksityiskohdat, joten lisäämällä ne
takaisin alkaen karkeimmasta kuvasta saadaan palautettua alkuperäinen kuva.

Palauttamista varten pitää suurentaa jokaista pyramidin tasoa niin monta kertaa,
että lopputulos on alkuperäisen kokoinen. Funktio `cv.pyrUp()` suodattaa
kaksinkertaiseksi suurennettua kuvaa, jotta lopputulos ei olisi kulmikas.

```{.python}
rp = lp.copy()
for i in range(0, 4):
    for j in range(i,4):
        rp[i] = cv.pyrUp(rp[i])
```

Lopputuloksena taulukossa `rp` on pyramidin tasot alkuperäisen kokoisina, joten
ne voidaan seuraavaksi laskea yhteen.

```{.python}
rimg = rp[0].copy()
for i in range(1,5):
    rimg += rp[i]

diff = np.abs(rimg - orig)
_,maxdiff,_,_ = cv.minMaxLoc(diff)
print(maxdiff)
```

Kuten näemme, lopputulos on teräväreunainen ja melko lähellä alkuperäistä.
Virhettä on hieman, ja vaikuttaisi siltä, että virheen suuruus riippuu kuvan
alkuperäisestä kirkkaudesta. Erotuskuvan maksimiarvosta näemme kuitenkin, että
virhe on suurimmillaankin mitätön; luennoijan kokeilussa maksimiarvo on 0.00006,
eli takaisin tavuiksi muutettaessa häviävän pieni.

## Tehtäviä

Kokeile pyramidioperaatioita omille kuvillesi. Pohdi, olisiko sinun
sovelluksessasi tarvetta analysoida kuvia skaala-avaruudessa ja millä tavalla.

Kokeile esimerkiksi reunanhakua useassa eri skaalassa ja vertaile tuloksia eri
skaaloissa. Voit kokeilla myös käyttää matemaattisia operaatioita valitaksesi
alkuperäisestä kuvasta vain ne reunat, jotka esiintyvät myös karkeammissa
skaaloissa.

Kokeile *Determinant of Hessian* -operaatiota skaala-avaruudessa. Yritä etsiä
paikallinen maksimiarvo myös skaala-avaruudessa valitsemalla se skaala, jossa
maksimiarvo on suurin.
