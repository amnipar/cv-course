---
title: Tutoriaali 9
author: Matti Eskelinen
date: 5.4.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tällä kertaa aiheena on kuvien geometriset muunnokset, erityisesti
perspektiiviprojektio ja homografiamuunnos.

Minkä tahansa kahden mielivaltaisen nelikulmion välille voidaan muodostaa
homografiarelaatio, joka siis kuvaa yhden nelikulmion pisteet toisen nelikulmion
pisteiksi. Tällaista relaatiota voidaan hyödyntää monella eri tavalla,
esimerkiksi kaikkien linssejä käyttävien kameroiden väistämättä tuottaman
perspektiivivääristymän oikaisemiseksi tai kahden eri kuvakulmasta otetun kuvan
vertailemiseksi.

## Perspektiiviprojektion parametrien ratkaiseminen

Esimerkkiharjoitustyössä on tavoitteena arvioida nelikulmioiden asentoa kameraan
nähden perspektiiviprojektion avulla. Tätä ajatellen pitäisi etsiä parametrit
perspektiivimuunnokselle, joka tuottaa alkuperäisestä neliöstä kuvassa näkyvän
vääristyneen neliön. Lopullisessa toteutuksessa neliön nurkkapisteet pitäisi
etsiä automaattisesti esimerkiksi pistepiirteiden avulla, mutta ensimmäisessä
kokeilussa nurkkapisteiden koordinaatit on katsottu kuvasta käsin.

```{.python}
img1 = cv2.imread("../images/rect.png", cv2.IMREAD_GRAYSCALE)
img2 = cv2.imread("../images/rect2.png", cv2.IMREAD_GRAYSCALE)

w,h = img1.shape
s = max(w,h)
maxSize = np.int(np.sqrt(2*s*s))

pt1 = np.array([
	[79,79],
	[320, 79],
	[320,320],
	[79,320]], dtype="float32")

pt2 = np.array([
	[86,95],
	[320,79],
	[297,305],
	[83,326]], dtype="float32")

M = cv2.getPerspectiveTransform(pt1, pt2)
warp = cv2.warpPerspective(img1, M, (maxSize, maxSize))
```

Koodissa etsitään projektiomatriisi M ja projisoidaan sen avulla alkuperäinen
kuva, jotta varmistutaan että tulos on oikea. Pisteitä on oltava täsmälleen
neljä. On huomattava, että nelikulmion nurkkapisteet on ilmoitettava
järjestyksessä myötäpäivään, periaatteessa alkaen vasemmasta ylänurkasta.
Luonnollisesti kahden listan pisteiden on vastattava toisiaan.

## Homografian muodostaminen

Edellä esitetyn menetelmän heikkous on se, että se toimii vain neljälle
pisteelle, ja ne pitää esittää vieläpä oikeassa järjestyksessä. Myöhemmin olisi
tarkoitus esittää myös homografian etsiminen kahden mielivaltaisen pistejoukon
välille, joka on realistisempi sovellus pistepiirteitä käytettäessä.

## Tehtäviä

Mieti, tarvitsetko perspektiiviprojektiota, homografiaa tai muuta geometrista
muunnosta harjoitustyössäsi. Kokeile kuvillasi. Mieti myös, millä tavoin
jatkokäsittelisit tuloksia. Jos aiheesi ei sovellu tähän tehtävään, voit myös
kokeilla muilla sopivilla kuvilla. Voit esimerkiksi yrittää huonetilasta otetun
kuvan 'oikaisemista' kohteiden välisten etäisyyksien arvioimista varten, jos
pystyt määrittelemään kuvasta jonkin neliön tai suorakaiteen muotoisen pinnan
nurkkapisteet.

Luonnollisesti tarvitset vertailukuvan, jossa nurkkapisteet ovat oikeilla
paikoillaan, tai ainakin vertailupisteiden koordinaatit. Neliön tapauksessa
mitkä tahansa neliön muodostavat koordinaatit periaatteessa käyvät, suorakaiteen
tapauksessa vertailukoordinaattien määräämän suorakaiteen leveyden ja korkeuden
on oltava oikeassa suhteessa. Voit esimerkiksi ottaa kuvan huoneesta, jonka
lattialla on neliön muotoinen paperi, pöytäliina tai muu vastaava esine.

