---
title: Tutoriaali 3
author: Matti Eskelinen
date: 14.1.2018
title-prefix: TIES411
lang: fi
css: style.css
---

Tällä kertaa kokeilemme Fourier-muunnoksen laskemista kuvalle, tutkimme tuloksia
ja kokeilemme erilaisten operaatioiden vaikutuksia lopputulokseen. Vaikka
Fourier-muunnoksesta on vain rajallisesti käytännön hyötyä konenäössä, on
tärkeää ymmärtää miten se toimii ja mitä se tekee. Aiheeseen liittyvät
harjoitukset auttavat myös ymmärtämään kuvadatan luonnetta.

Ota aluksi käyttöön tarvittavat kirjastot.

```{.python}
import math
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
```

Ladataan kuva tutkittavaksi. Vaihda tähän jokin itse valitsemasi kuva.

```{.python}
img = cv.imread("../images/rect2.png", cv.IMREAD_GRAYSCALE)
```

Kuvan diskreetti Fourier-muunnos FFT-algoritmia käyttäen saadaan laskettua
OpenCV:ssä funktiolla dft:

```{.python}
dft = cv.dft(np.float32(img), flags = cv.DFT_COMPLEX_OUTPUT)
```

Huomatkaa, että kuvan pikselien on oltava liukulukuja. Tuloksena on
samankokoinen kuva, jonka pikselit ovat kompleksilukuja. Tutkitaan, miltä tulos
näyttää.

```{.python}
re = dft[:,:,0]
im = dft[:,:,1]

# muuta takaisin biteiksi piirtämistä varten: voit kokeilla myös normalisoida histogrammin
re_img = np.uint8(re) #cv.equalizeHist(np.uint8(real))
im_img = np.uint8(im) #cv.equalizeHist(np.uint8(imag))
```

Tässä pikselien arvot vastaavat siis Fourier-kertoimia. Jokainen numeropari
määrää tietyntaajuisen siniaallon voimakkuuden ja vaiheen. Niistä on kuitenkin
vaikea saada sellaisinaan mitään selvää. Fourier-muunnos onkin yleensä tapana
esittää polaarimuodossa, josta voimakkuus ja vaihe on suoraan nähtävissä. Tätä
ennen on tapana siirtää Fourier-muunnoksen tulosta puolikkaan kuvan verran alas
ja oikealle. Syynä on se, että normaalissa tuloksessa pienimmät taajuudet ovat
kulmissa. Hahmottamista helpottaa, jos pienimmät taajuudet ovat keskellä. Ennen
käänteismuunnosta on vain muistettava siirtää tulos takaisin oikeaan asemaan.

```{.python}
dft_shift = np.fft.fftshift(dft)
re_shift = dft_shift[:,:,0]
im_shift = dft_shift[:,:,1]

amp_shift, pha_shift = cv.cartToPolar(re_shift,im_shift)
# voidaan käyttää myös erillisiä funktioita
# amp = cv.magnitude(real_shift,imag_shift)
# pha = cv.phase(real_shift,imag_shift)

# voit kokeilla myös normalisoida histogrammin
eamp = np.uint8(np.log(amp_shift)) #cv2.equalizeHist(np.uint8(17*np.log(amp_shift)))
epha = np.uint8(pha_shift) #cv2.equalizeHist(np.uint8(pha_shift))
```

Huomaa, että ennen piirtämistä amplitudikuvasta otetaan pikseleittäin logaritmi
(toisinaan se myös kerrotaan vakiolla, erityisesti normalisoitaessa tämä voi
olla tarpeen). Syynä tähän on se, että kuvien Fourier-muunnoksessa
taajuuskomponenttien amplitudit jakautuvat potenssilakijakauman mukaan:
pienitaajuuksisten taajuuskomponenttien amplitudit ovat eksponentiaalisesti
suurempia kuin suuritaajuksisten. Ottamalla logaritmi tämä ero saadaan
tasoitettua, muuten kuva näkyy piirrettäessä väärin - joko enimmäkseen mustana
tai sitten siten, että suurimmat komponentit häviävät näkyvistä. Funktiolla
`cv.equalizeHist()` saa parannettua kontrastia vahvempien ja heikompien
komponenttien välillä.

Logaritmin edessä oleva kerroin on hihavakio, joka riippuu kuvasta.
Normalisoidussa kuvassa tulee välillä keskelle mustaa, ja valitsemalla sopivan
vakion tilanteen saa korjattua. Jos on tarpeen muokata kuvaa ja palauttaa
takaisin käänteismuunnosta varten, tämän voi luonnollisesti tehdä ottamalla
pikseleittäin eksponentti esimerkiksi funktiolla `np.exp()`.

Vaihekuva ei edelleenkään kerro meille juuri mitään; se kuvaa, millä tavoin
kutakin taajuuskomponenttia pitää 'siirtää' oikean lopputuloksen saamiseksi.
Useimmilla kuvilla tämä näyttää enemmän tai vähemmän satunnaiselta. Palaamme
myöhemmin vaiheen merkitykseen kuvissa. Amplitudikuvasta kuitenkin huomaamme,
että siinä on selvästi erottuvia raitoja. Kaikilla samalla suoralla olevilla
taajuuskomponenteilla on sama etenemissuunta; muistamme luentomonisteesta, että
Fourier-kertoimen $(u,v)$ määräämän sinitasoaallon etenemissuunta on
kohtisuoraan kulmassa $\theta$ olevaa suoraa vastaan, kun kulman $tan(\theta) =
\frac{u}{v}$. Kulma on sama, kun $\frac{u}{v} = k$ jollekin vakiolle k, eli kun
$u = kv$. Tämä määrää taajuustason suoran, jonka kulmakerron on $k$.

Voimme siis todeta, että amplitudikuvan raidat aiheutuvat kuvassa olevista
voimakkaista suorista reunoista. Raidat erottuvat selvästi, koska kuva on niin
yksinkertainen. Monimutkaisemmissa kuvissa voi esiintyä samankaltaisia raitoja,
jos kuvassa on paljon samansuuntaisia elementtejä, kuten puunrunkoja tai
vaikkapa raitapaita.

Seuraavalla koodilla voimme havainnollistaa amplitudien jakaumaa. Muistetaan,
että Fourier-kerrointa $(u,v)$ vastaava taajuus on $\sqrt(u^2 + v^2)$. Teemme
kuvan, jossa on jokaisen Fourier-muunnoksen pikselin kohdalla kyseisen kertoimen
taajuus. Sitten plottaamme pareittain taajuudet ja amplitudit.

```{.python}
amp = cv.magnitude(re, im)
w,h = img.shape
frequencies = np.zeros((w,h))
for x in range(1,w):
    for y in range(1,h):
        frequencies[y,x] = math.sqrt(x**2 + y**2)

_=plt.scatter(x=frequencies.ravel(), y=amp.ravel(), s=2) #y=np.log(amp).ravel())
```

Tästä kuvasta havaitsemme kaksi asiaa: ensinnäkin sen, että suurin osa
amplitudeista on lähellä nollaa, ja suuremmat amplitudit keskittyvät pieniin
taajuuksiin. Toiseksi huomaamme sen, että suuria amplitudeja on keskittynyt myös
kohtiin $400$ ja n. $565$. Tämä johtuu Fourier-muunnoksen periodisuudesta;
taajuus $400$ on sama kuin taajuus $1$. Kuvan koko on $400 \times 400$ pikseliä,
ja suurin tällaiseen kuvaan mahtuva taajuus on $200$, eli siniaalto mahtuu
tekemään $200$ täyttä heilahdusta. Suuremmat taajuudet aiheuttaisivat
aliasoitumista, kuten muistamme näytteistystä koskeneesta luvusta. Mikä sitten
tuo taajuus $565$ on? Luonnollisesti kulmittain etenevän aallon taajuus.
Pikselit ovat neliöitä, joten etäisyys kulmasta kulmaan on suurempi kuin
reunasta reunaan. Fourier-komponentin $(1,1)$ taajuus on $\sqrt{2}$ eli n.
$1.4$. Kuvan sisälle mahtuu yhtä monta täyttä heilahdusta kuin vaaka- tai
pystysuoraankin, mutta koska etäisyys on suurempi, taajuuskin on. Tämä on
digitaalisten kuvien tunnettu ongelma, ja aiheuttaa aliasoitumista eli
'portaikkoefektiä' vinoissa reunoissa. Tämän takia kaikista digitaalisista
kuvista pitäisi suodattaa pois nämä liian suuret, 'vinoittaiset' taajuudet, eli
suuremmat kuin kuvan koko jaettuna kahdella. Palaamme tähän asiaan hetken
kuluttua, kun kokeilemme käänteismuunnosta muokatulle kuvalle, mutta ensin
tutustumme käänteismuunnokseen hieman yksinkertaisempien esimerkkien avulla.

OpenCV:ssä Fourier-muunnos tehtiin funktiolla `cv.dft()`. Käänteismuunnosta
varten on funktio `cv.idft()`, jolla annetaan parametrina kompleksiarvoinen
kuva. Havainnollistetaan Fourier-kertoimien toimintaa ja käänteismuunnosta
luomalla syötekuvia käsin.

```{.python}
ex_amp = np.zeros((200,200), dtype=np.float32)
ex_pha = np.zeros((200,200), dtype=np.float32)

# tästä tulee keskimääräinen pikselin arvo, se voi olla mikä vain koska kuva normalisoidaan
ex_amp[0,0] = 0.5
# tämä tulee kertoimeksi sinille ja kosinille, se määrää aallon 'korkeuden'
ex_amp[0,1] = 1
# tämä on kulma, josta aalto lähtee liikkeelle
ex_pha[0,1] = math.pi
# voit lisätä vastaavasti lisää komponentteja
ex_amp[1,1] = 1
ex_pha[1,1] = 0

# tämän pitäisi periaatteessa olla sama kuin ex_amp[0,0], mutta nähtävästi idft käyttää vain puolikasta kuvaa
# näin voi tehdä, koska muunnos on symmetrinen
# ex_amp[101,101] = 0.5
# tämän pitäisi periaatteessa olla sama kuin ex_amp[0,i], mutta sitäkään idft ei käytä
# ex_amp[0,N-i] = 1
# ex_pha[0,N-i] = math.pi

ex_re, ex_im = cv.polarToCart(ex_amp, ex_pha)
ex_comp = np.stack((ex_re, ex_im),axis=2)

# käänteismuunnos; myös cv.dft toimii, jos antaa myös lipun cv.DFT_INVERSE
ex_real = cv.idft(ex_comp, flags=cv.DFT_REAL_OUTPUT)
# numpyn vastaava funktio on irfft2, mutta se odottaa saavansa vain puolet Fourier-kertoimista kompleksilukumatriisina
# kertominen 1j:llä tekee matriisista imaginaarisen, ja sitten sen voi vain laskea yhteen reaaliosan kanssa
#ex_real = np.fft.irfft2(ex_re[:,0:100] + 1j * ex_im[:,0:100])

# lopputuloksena olevan kuvan pikseliarvot vaihtelevat suuresti kertoimien määrän mukaan, joten skaalataan välille [0,1]
m1, m2, p1, p2 = cv.minMaxLoc(ex_real)
ex_norm = (ex_real - m1) / (m2 - m1)

ex_img = np.uint8(255*ex_norm)
```

Seuraavaksi voimmekin kokeilla muokata jonkin oikean kuvan Fourier-muunnosta.
Kokeillaan poistaa edellä mainitut ongelmalliset, liian suuret 'kulmittaiset'
taajuudet. Tämän saamme aikaan kertomalla kuvaa sopivalla maskilla. Tehdään
maski:

```{.python}
size = img.shape
h,w = size
dy = h/2
dx = w/2

def testMask(y,x):
    return np.sqrt((y-dy)**2 + (x-dx)**2) < dx-25

mask = cv.blur(np.float32(np.fromfunction(testMask, size, dtype=np.float32)),(25,25))
```

```{.python}
# ensin kerrotaan maskilla
amp_shift_masked = mask * amp_shift
pha_shift_masked = mask * pha_shift

# sitten muunnetaan polaarimuodosta karteesiseen muotoon
re_shift_masked, im_shift_masked = cv.polarToCart(amp_shift_masked, pha_shift_masked)
# yhdistetään reaali- ja imaginaariosa
dft_shift_masked = np.stack((re_shift_masked, im_shift_masked), axis=2)
# siirretään kertoimet takaisin oikeisiin paikkoihin
dft_masked = np.fft.ifftshift(dft_shift_masked)
# lopuksi tehdään käänteismuunnos
img_masked = cv.idft(dft_masked, flags=cv.DFT_REAL_OUTPUT)
```

Neliön reunan porraskuvio on selvästi pehmentynyt, mutta kohina ei ole vielä
hävinnyt. Operaatio siis asettaa tiettyä rajaa suuremmat taajuuskomponentit
nollaksi. Sumennus tekee siirtymästä hieman pehmeämmän. Parempi tulos kohinan
poistamiseksi saadaan käyttämällä Gaussin funktiota. Gaussin funktion Fourier-
muunnos on itsekin Gaussin funktio. Voit siis kokeilla generoida maskin, jonka
arvot lasketaan Gaussin funktiolla (varmista, että pikselien summa on 1). Kuten
muistamme, taajuustasossa konvoluutio muuttuu kertolaskuksi. Voit siis
konvolvoida Gaussin funktiolla kertomalla Fourier-muunnoksen Gaussin funktiosta
muodostuvalla maskilla samaan tapaan kuin on tehty yllä. Maskin keskellä oleva
ikkuna saa olla yllättävän pieni ilman, että kuvassa oleva kohde muuttuu
tunnistamattomaksi. Kuten muistamme, oleellisin tieto kohteen muodosta sisältyy
muutamiin vahvimpiin taajuuskomponentteihin.

Lopuksi voisimme miettiä, mitä taajuuskomponenttien amplitudi ja vaihe
oikeastaan kertovat. Intuitiivisesti lienee selvää tässä vaiheessa, että
amplitudilla skaalataan siniaaltoja korkeammaksi ja matalammaksi. Olemme myös
todenneet, että oleellisin tieto kohteen muodosta sisältyy pienimpiin
taajuuksiin. Mutta mitä vaihe tekee? Teemme nyt kokeita, joiden perusteella
voimme todeta, että nimenomaan vaihe sisältää olennaisen tiedon kuvan
sisällöstä. Tämä on loogista: koska pienimmät taajuudet ovat tärkeimpiä, ja
koska kaikissa kuvissa on nämä pienimmät taajuudet mukana kohtalaisen suurilla
amplitudeilla, erilaisia muotoja saadaan aikaan vain siirtelemällä aaltoja eri
tavoilla.

Kokeillaan nyt asettaa vuorollaan amplitudi- ja vaihekomponentit vakioarvoon.

```{.python}
amp, pha = cv.cartToPolar(re, im)
const_amp = np.stack(cv.polarToCart(np.ones(size, dtype=np.float32), pha), axis=2)
const_pha = np.stack(cv.polarToCart(amp, np.zeros(size, dtype=np.float32)), axis=2)

const_amp_img = cv.idft(const_amp, flags=cv.DFT_REAL_OUTPUT)
cm1, cm2, _, _ = cv.minMaxLoc(const_amp_img)
print((cm1, cm2))
const_amp_img = cv.equalizeHist(np.uint8(255 * ((const_amp_img - cm1) / (cm2 - cm1))))

const_pha_img = cv.idft(const_pha, flags=cv.DFT_REAL_OUTPUT)
cm1, cm2, _, _ = cv.minMaxLoc(const_pha_img)
print((cm1, cm2))
const_pha_img = cv.equalizeHist(np.uint8(255 * ((const_pha_img - cm1) / (cm2 - cm1))))
```

Yllä olevista kuvista saa jotakin selkoa amplitudin ja vaiheen merkityksestä.
Vasemmalla, koska amplitudi on kaikkialla ykkönen, kuvassa on paljon voimakasta
kohinaa. Kuitenkin, koska taajuuskomponentit ovat oikeilla paikoillaan, kohteen
rakenne on vielä näkyvissä. Oikealla, kuvassa on oikeat taajuuskomponentit
oikean vahvuisina, mutta taajuuskomponentteja ei ole siirrelty mihinkään. Sen
takia kuvassa näyttää olevan oikeanlaisia osasia, mutta ne ovat kaikki
kerääntyneet keskelle. Monimutkaisemmasta kuvasta voisi olla vaikea saada
tämänkään vertaa selvää.

## Tehtäviä

Kokeile tehdä muitakin kokeiluja. Klassinen kokeilu on ottaa kaksi samankokoista
kuvaa, ja vaihtaa niiden vaihekomponentit päikseen. Kumpaa kuvaa lopputuloksena
oleva sekoitus muistuttaa enemmän? Yllä olevasta testistä voi saada paremman
näköisen, kun amplitudikuvassa käyttää vakioarvon sijaan eksponentiaalisesti
kuvan nurkkia kohti kasvavia arvoja. Voit myös kokeilla, mitä kuvassa näkyy, jos
tällaisen amplitudikomponentin yhdistää satunnaisen tai vakioarvoisen
vaihekomponentin kanssa.

Kokeile tässä kuvattuja tekniikoita erilaisilla omilla kuvilla. Näkyykö
tuloksissa mitään mielenkiintoista? Kokeile sitten esimerkiksi Gaussisella
suotimella pehmennetyllä kuvalla. Näkyykö eroa? Keksitkö jotakin tapaa hyödyntää
tuloksia omassa harjoitustyössä tai jonkin muun ongelman ratkaisemisessa?
