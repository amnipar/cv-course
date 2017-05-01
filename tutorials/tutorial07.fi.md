---
title: Tutoriaali 7
author: Matti Eskelinen
date: 29.3.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tällä kertaa tutustutaan skaala-avaruuden käyttämiseen ja kuvien analysoimiseen useissa skaaloissa kuvapyramidien avulla.

## Gaussin pyramidi

Tyypillinen tapa muodostaa diskreetti skaala-avaruus on vuoroin alipäästösuodattaa kuvaa Gaussin ytimellä ja skaalata kuvaa puolta pienemmäksi. Tätä varten OpenCV:ssä on funktio *pyrDown*:

```{.python}
img = cv2.imread("rect2.png", cv2.IMREAD_GRAYSCALE)
g = img.copy()
gp = [g]
for i in xrange(4):
	g = cv2.pyrDown(g)
	gp.append(g)
```

Lopputuloksena taulukossa on sarja toinen toistaan pienempiä versioita samasta kuvasta.

OpenCV:n toteutus on tarkka kuvien koosta. Käytettävien kuvien dimensioiden pitäisi olla kahdella jaollisia riittävän monta kertaa pyramidin tasojen muodostamiseksi.

## Laplacen pyramidi

Erittäin hyödyllinen skaala-avaruuden muoto on Laplacen pyramidi. Se muodostetaan tyypillisesti Gaussin pyramidin avulla, lähtien liikkeelle suurimmasta skaalasta eli pienimmästä kuvasta, skaalaamalla se kaksinkertaiseksi funktiolla *pyrUp*, ja laskemalla pikseleittäinen erotus pyramidin seuraavan tason kanssa.

```{.python}
lp = [gp[4]]
for i in xrange(4, 0, -1):
	g = cv2.pyrUp(gp[i])
	l = cv2.subtract(gp[i-1], g)
	lp.append(l)
```

Lopputuloksena taulukossa on ensimmäisenä voimakkaasti alipäästösuodatettu kuva ja sen jälkeen *Difference of Gaussians* -tyyppisiä approksimaatioita Laplacen operaattorista. Jos kaikki taulukon kuvat skaalaa alkuperäisen kokoiseksi ja laskee ne pikseleittäin yhteen, pitäisi lopputuloksena olla alkuperäinen kuva tai hyvin lähelle sitä. Pyramidin tasot nimittäin pitävät sisällään alipäästösuodattimien poistamat kuvan yksityiskohdat, joten lisäämällä ne takaisin alkaen karkeimmasta kuvasta saadaan palautettua alkuperäinen kuva.

## Tehtäviä

Kokeile pyramidioperaatioita omille kuvillesi. Pohdi, olisiko sinun sovelluksessasi tarvetta analysoida kuvia skaala-avaruudessa ja millä tavalla.

Kokeile esimerkiksi reunanhakua useassa eri skaalassa ja vertaile tuloksia eri skaaloissa. Voit kokeilla myös käyttää matemaattisia operaatioita valitaksesi alkuperäisestä kuvasta vain ne reunat, jotka esiintyvät myös karkeammissa skaaloissa.

Kokeile *Determinant of Hessian* -operaatiota skaala-avaruudessa.
