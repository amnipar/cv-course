---
title: Luku 8 - Skaala-avaruus
author: Matti Eskelinen
date: 8.3.2018
title-prefix: TIES411
lang: fi
css: style.css
---

# Skaala-avaruus

Tässä luvussa tutustumme kuvien analysointiin useissa eri skaaloissa sekä
mielenkiintoisten kohtien etsimiseen ja kuvaamiseen pistepiirteiden avulla.

Käytännöllisiä asioita tällä kerralla:

* kuvapyramidien tutkimista,
* reunanhakua monessa skaalassa yhtä aikaa,
* Laplacen pyramidin nollakohtien hakua,
* pistepiirteiden etsimistä ja kuvaamista.

Yhdestä kuvasta löytyneiden pisteiden vastinpisteiden etsimistä toisesta kuvasta
pohditaan myöhemmin geometristen muunnosten yhteydessä.

## Skaalainvarianssi

Eräs ihmisen luonnollisen visuaalisen ympäristön keskeinen ominaisuus on
*skaala-invarianssi*, eli toisaalta se, että kohteet voivat esiintyä näkymässä
useassa eri koossa ja toisaalta se, että kohteen tunnistaminen ei riipu sen
koosta kuvassa. Tässä suhteessa näköaisti poikkeaa muista aisteista;
esimerkiksi tuntoaisti havaitsee saman kohteen aina saman kokoisena iholla, ja
kuuloaisti kuulee äänet useimmiten samalla nopeudella. Konenäössä onkin
tärkeää pyrkiä huomioimaan se, että tunnistettavat kohteet voivat esiintyä
kuvissa monen kokoisina ja sisältää vaihtelevan määrän yksityiskohtia.
Tietysti joissakin sovelluksissa kuvausolot voidaan järjestää siten, että
kohde on aina saman kokoinen.

Tyypillinen tapa varmistua konenäkömenetelmän skaala-invarianssista on käyttää
skaala-avaruutta. Se perustuu suhteellisen vahvaan matemaattiseen teoriaan,
jonka merkittävin kehittäjä on Tony Lindeberg. Siinä kuvan $I(x,y)$ esitys
skaalassa $t$ on $L(x,y;t)$, ja se saadaan konvolvoimalla kuvaa sopivalla
Gaussin ytimellä $G(x,y;t)$:

$$G(x,y;t) = \frac{1}{2 \pi t} e^{-\frac{x^2 + y^2}{2t}}.$$

Voidaan siis määritellä

$$L(x,y;t) = I(x,y) \ast G(x,y;t),$$

missä puolipiste viittaa siihen, että konvoluutio suoritetaan vain parametrien
$x$ ja $y$ suhteen kun taas $t$ pysyy vakiona. Funktion $G$ määritelmästä
tunnistamme, että tämä *skaalaparametri* $t$ vastaa Gaussin suotimen parametria
$\sigma^2$, eli varianssia.

Muistamme aiemmasta luvusta, että näytteistys voidaan määritellä konvoluutiona
Diracin $\delta$:n kanssa, ja että tämä $\delta$ voidaan määritellä
normaalijakauman eli normalisoidun Gaussin funktion raja-arvona, kun $\sigma^2$
lähestyy nollaa. Toteamme siis, että $L(x,y;0) = I(x,y)$ eli alkuperäinen
näytteistetty kuva, kuten pitääkin. Samalla toteamme, että skaalaparametrille
$t$ on luonnollinen alaraja $0$, joka riippuu siitä tarkkuudesta, jolla kuva on
näytteistetty. Uusia yksityiskohtia hienommassa skaalassa ei luonnollisesti ole
mahdollista saada esiin.

Skaala-avaruuden skaala $0$ vastaa alkuperäistä näytteistettyä kuvaa, kun taas
suuremmat skaalat vastaavat *alipäästösuodatettuja* versioita alkuperäisestä
kuvasta. Parametri $t$ voidaan tulkita siten, että ne kuvan yksityiskohdat
joiden *spatiaalinen* eli pikselikoko on pienempi kuin $\sqrt{t}$ on suodatettu
pois. Muistamme *Nyquistin taajuuden*: jos kuvasignaalia näytteistetään $2k$
pikselin välein, signaalista pitäisi poistaa muutokset, jotka tapahtuvat
nopeammin kuin $k$:n pikselin välein. Voidaan siis käyttää skaala-avaruuden
skaalaa $k^2$ ja uudelleennäytteistää kuva tältä skaalatasolta.

Mikä tahansa alipäästösuodin ei sovi skaala-avaruuden muodostamiseen; on
olemassa joukko skaala-avaruuden *aksioomia* jotka suotimen on täytettävä. Yksi
tärkeimmistä on vaatimus siitä, että suodin ei saa tuottaa uusia, ylimääräisiä
rakenteita karkeampiin skaaloihin. Emme mene näihin aksioomiin tässä tarkemmin,
mutta toteamme, että Gaussin funktio on kanoninen tapa muodostaa skaala-avaruus.
Tämä seuraa myös skaala-avaruuden tulkinnasta *lämpödiffuusion* mukaan:
kuvafunktio voidaan nähdä lämpötilajakaumana ja parametri $t$ aikana. Kun aika
kuluu, lämpö alkaa levitä ja jakautua tasaisemmin ja tasaisemmin.

Gaussin funktio on lämpödiffuusiota kuvaavan differentiaaliyhtälön
*Greenin funktio*, eli sitä voidaan ajatella tuon yhtälön impulssivasteena.
Gaussin funktio siis kuvaa sitä, mihin lämpö leviää tietystä pistemäisestä
kohteesta ajan $t$ kuluessa. Lämpöyhtälöhän kirjoitetaan näin:

$$\partial_t L = \frac{1}{2} \nabla^2 L,$$

ja reunaehtona on $L(x,y;0) = I(x,y)$. Operaattori $\nabla^2$ on gradientin
divergenssi, tai Laplacen operaattori, jota siis kuvien tapauksessa vastaa
x- ja y-suuntaisten toisen asteen osittaisderivaattojen summa. Edellisen luvun
kuvagraafien tapauksessa tätä vastaa *Laplacen matriisi*. Voidaan ajatella, että
jos pikseliarvoja vastaava kuviteltu lämpö leviää kuvagraafin kaaria pitkin
Laplacen matriisin määräämien naapuruston painokertoimien mukaan, ajanhetkellä
$t$ vallitseva lämpötilajakauma saadaan konvolvoimalla kuva Gaussin suotimen
$G(x,y;t)$ kanssa.

Skaala-avaruus on teoriassa jatkuva, mutta tyypillisesti käytetään diskreettiä
joukkoa kuvia, jotka muodostavat kuvaperheen eri skaaloissa olevia esityksiä
samasta lähtökuvasta. Kuvapyramidit ovat yleinen tekniikka skaala-avaruuden
muodostamiseen. Ne voidaan nähdä skaala-avaruuden diskreetteinä esitysmuotoina,
joissa skaala-avaruutta näytteistetään sekä tilassa että skaalassa.

Näytteistys skaalassa tulisi tehdä eksponentiaalisesti, eli vierekkäisten
skaalojen välisen suhteen tulisi kasvaa eksponentin mukaan. Yksinkertaisin ja
yleisin tapa toteuttaa tämä on käyttää $2$:n tai $\sqrt{2}$:n
kokonaislukupotensseja. Käytännössä tämä näkyy siten, että esimerkiksi
käytettäessä $2$:n potensseja kuva on seuraavassa suuremmassa skaalassa aina
puolta pienempi kuin edellisessä skaalassa. Tällöin tilan ja skaalan
näytteistystaajuuksien suhde pysyy vakiona, jolloin impulssivaste on sama
kaikilla pyramidin tasoilla. Intuitiivisesti ajateltuna tämä tarkoittaa, että
skaalat ovat keskenään vertailukelpoisia.

## Gaussin pyramidi

Gaussin pyramidi on diskreetti skaala-avaruuden esitys, jossa kuvaa vuorotellen
alipäästösuodatetaan Gaussin suotimella ja skaalataan puolta pienempään kokoon.
Tätä voidaan siis ajatella uudelleennäytteistyksenä, jossa kuvan koko putoaa
puoleen. Muistamme, että alipäästösuodatus on tässä välttämätön toimenpide
aliasoitumisen välttämiseksi.

Nimitys pyramidi tulee siitä, että jos kuvat asetetaan päällekkäin siten, että
alkuperäinen kuva on pohjalla ja pienemmät versiot sen päällä, pino kapenee
pyramidin tapaan. Jotta pinoa voitaisiin jatkaa huipulle asti, kuvan koon
pitäisi olla kakkosen potenssi. Tyypillisesti sovelluksissa tarvitaan kuitenkin
vain muutama skaala, esimerkiksi viisi. Tällöin kuvan koon tarvitsee olla
jaollinen kahdella vain neljä kertaa. Esimerkiksi jos alkuperäinen kuva on kokoa
640x480, saadaan muodostettua skaalat 320x240, 160x120, 80x60 ja 40x30 ilman
ongelmia. Joskus voi olla kuitenkin tarpeen täyttää kuvaa reunoista tai leikata
reunoilta osa pois, jotta kuva saadaan sopivan kokoiseksi ja muotoiseksi.

Gaussin pyramidi voidaan muodostaa yksinkertaisesti konvolvoimalla Gaussin
ytimellä ja valitsemalla sitten joka toinen pikseli. Toinen suosittu tapa, jonka
esitteli Burt jo vuonna 1981, on käyttää *binomisuotimia*. Nimitys tulee
siitä, että suotimen painokertoimet vastaavat *binomikertoimia*. Kuvaa
konvolvoidaan vuorotellen vaaka- ja pystysuuntaan käyttäen maskia
$\left[\begin{array}{ccc}
 \frac{1}{4} & \frac{1}{2} & \frac{1}{4}
 \end{array}\right]$.
Tyypillisesti tätä toistetaan useita kertoja; on osoitettu, että lopputulos
lähestyy Gaussin suotimen tulosta. Kolmen kierroksen jälkeen tulos on jo
riittävän lähellä useimpia sovelluksia varten. Kuvatun kaltainen binomisuodin on
nopea toteuttaa, koska voidaan käyttää *bittioperaatioita* (siirtoja oikealle)
jakolaskujen suorittamiseen tavuina tallennetuille pikselien arvoille.

Binomisuotimien yhteys Gaussin suotimen kanssa voidaan havainnollistaa
laskemalla auki, mitä diffuusioyhtälön numeerinen ratkaiseminen tekee. Tähän
palataan tutoriaalissa 7.

## Laplacen pyramidi

Laplacen pyramidin esittelivät Burt ja Adelson vuonna 1983. Se vastaa Gaussin
pyramidia, mutta on sarja *kaistapäästösuodatettuja* versioita alkuperäisestä
kuvasta, kun taas Gaussin pyramidi koostuu alipäästösuodatetuista versioista.
Laplacen pyramidi voidaan muodostaa joko *Laplacian of Gaussian* -suotimella tai
approksimoimalla tätä käyttäen *Difference of Gaussians* -operaattoria, joka on
siis kahden erisuuruista $\sigma$:a vastaavan Gaussin funktion erotus. On
todettu, että paras LoG-approksimaatio saadaan, kun Gaussin funktioiden
$\sigma$:n suhde on n. $1.6$. Diskreetin skaala-avaruuden tasojen suhde
$\sqrt{2}$ on lähellä tätä.

Laplacen pyramidi saadaan siis muodostettua helposti Gaussin pyramidista
laskemalla kahden peräkkäisen pyramidin tason erotus. Luonnollisesti on joko
käytettävä pienentämättömiä versioita kuvista, tai skaalattava pienennetyt
versiot kuvista alkuperäiseen kokoon. Voidaan käyttää myös binomisuotimilla
muodostettua pyramidia vastaavalla tavalla. Voidaan ajatella tämän erotuksen
kuvaavan sitä, mitä alipäästösuodin poistaa alemman tason kuvasta. Koska alempi
taso on myös alipäästösuodatettu, erotus vastaa kaistapäästösuodatettua kuvaa.

Laplacen pyramidilla on seuraavia hyödyllisiä ominaisuuksia. Se sisältää eri
skaaloissa laskettuja LoG-suotimen approksimaatioita, joten sitä voidaan käyttää
etsittäessä nurkkapisteiden tai muiden pistemäisten kohteiden *karakteristista
skaalaa*, eli skaalaa jossa LoG-suotimen vaste on suurin. Voidaan myös etsiä
suoraan pyramidin nollakohtia; koska pyramidin tasot ovat
kaistapäästösuodatettuja versioita alkuperäisestä kuvasta, tällä tavoin
löydetään tietyllä taajuusalueella esiintyviä reunoja.

Lopulta Laplacen pyramidia voidaan käyttää kuvan tehokkaaseen pakkaamiseen;
koska pyramidin tasot sisältävät vierekkäisten skaalojen erotuksia, alkuperäinen
kuva saadaan ottamalla karkein skaala (eli pyramidin pienin kuva), suurentamalla
se alkuperäiseen kokoon, ja lisäämällä siihen Laplacen pyramidin tasot
jotka on myös suurennettu alkuperäiseen kokoon. Tällä tavoin joudutaan
tallentamaan hieman enemmän pikseleitä kuin käytettäessä alkuperäistä kuvaa;
voidaan laskea, että pikselien määrä on $\frac{4}{3}$ alkuperäisestä. Muistamme
kuitenkin, että Laplacen suotimen jakauma on *harva*, eli suurin osa pikseleistä
on nollia tai lähellä nollaa. Laplacen pyramidin mukainen esitys siis pakkautuu
tiiviimmin kuin alkuperäinen kuva. Lisäksi pyramidi sisältää hyödyllistä tietoa
kuvan reunoista, kuten edellä mainittiin, ja siitä saadaan muodostettua koko
skaala-avaruus.

On viitteitä siitä, että ihmisen ja ilmeisesti monien muidenkin eliöiden
näköjärjestelmä muodostaa hyvin paljon Laplacen pyramidia muistuttavan
moniskaalaisen esityksen visuaalisista näkymistä. Ainakin ihmisillä tämä
ilmeisesti muodostetaan jo verkkokalvon gangliasoluissa. Muistamme, että nämä
solut laskevat Laplacen operaattoria muistuttavia vasteita aistinsolujen
näytteistämästä signaalista. Eräs tärkeä syy muodostaa tällainen moniskaalainen
esitys saattaa olla juuri kuvainformaation pakkaaminen; näköhermon kapasiteetti
on rajallinen, joten pakkaamisesta on hyötyä. Toinen tärkeä syy voi olla
energian säästäminen: esitysmuodon *harvuus* tarkoittaa sitä, että suurin osa
signaalia välittävistä neuroneista voi olla lepotilassa. Mitä harvemmin neuronit
laukeavat, sitä vähemmän energiaa kuluu.

![Kuvapyramidit](images/pyramids.png){ .centered }

## Ohjattavat pyramidit*

Pyramidi voidaan muodostaa myös *ohjattavista filttereistä*, jolloin voidaan
tutkia reunojen suuntaa. Simoncelli ja Freeman osoittivat kuinka tämä voidaan
tehdä siten, että alkuperäinen kuva saadaan palautettua pienen virheen kera.

## Moniskaalaiset graafit*

Skaala-avaruuksia voidaan hallita graafeina muodostamalla naapurilinkkien
lisäksi myös vanhempi-lapsi-linkkejä.

Tästä tulee vielä lisää.

## Integraalikuvat*

Integraalikuvilla voidaan helposti ja nopeasti muodostaa likimääräisiä
skaala-avaruuksia tutkimalla neliömäisten alueiden keskiarvoja. Tällainen
skaala-avaruus muodostaa nelipuumetsän.

Tästä tulee vielä lisää.
