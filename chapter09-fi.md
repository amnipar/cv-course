---
code:   TIES411
title:  Skaala-avaruus ja pistepiirteet
lang: fi-FI
---

# Skaala-avaruus ja pistepiirteet

Tässä luvussa tutustumme kuvien analysointiin useissa eri skaaloissa sekä
mielenkiintoisten kohtien etsimiseen ja kuvaamiseen pistepiirteiden avulla.

Käytännöllisiä asioita tällä kerralla:

* kuvapyramidien tutkimista,
* ehkä reunanhakua monessa skaalassa yhtä aikaa,
* laplacen pyramidin nollakohtien hakua,
* pistepiirteiden etsimistä ja kuvaamista,
* jos aikaa on, vastinpisteiden etsintää kahdesta kuvasta.

## Skaala-avaruus

Eräs ihmisen luonnollisen visuaalisen ympäristön keskeinen ominaisuus on
*skaala-invarianssi* eli toisaalta se, että kohteet voivat esiintyä näkymässä
useassa eri koossa ja toisaalta se, että kohteen tunnistaminen ei riipu sen
koosta kuvassa. Tässä suhteessa näköaisti poikkeaa muista aisteista; esimerkiksi
tuntoaisti havaitsee saman kohteen aina saman kokoisena iholla, ja kuuloaisti
kuulee äänet useimmiten samalla nopeudella. Konenäössä onkin tärkeää pyrkiä
huomioimaan se, että tunnistettavat kohteet voivat esiintyä kuvissa monen
kokoisina ja sisältää vaihtelevan määrän yksityiskohtia. Tietysti joissakin
sovelluksissa kuvausolot voidaan järjestää siten, että kohde on aina saman
kokoinen.

Tyypillinen tapa varmistua konenäkömenetelmän skaala-invarianssista on käyttää
skaala-avaruutta. Se perustuu suhteellisen vahvaan matemaattiseen teoriaan,
jonka merkittävin kehittäjä on Tony Lindeberg. Siinä kuvan $I(x,y)$ esitys
skaalassa $t$ on $L(x,y;t)$, ja se saadaan konvolvoimalla kuvaa sopivalla
Gaussin ytimellä $G(x,y;t)$:

$$G(x,y;t) = \frac{1}{2 \pi t} e^{-\frac{x^2 + y^2}{2t}}.$$

Voidaan siis määritellä

$$L(x,y;t) = G(x,y;t) \ast I(x,y),$$

missä puolipiste viittaa siihen, että konvoluutio suoritetaan vain parametrien
$x$ ja $y$ suhteen kun taas $t$ pysyy vakiona. Funktion $G$ määritelmästä
tunnistamme, että tämä *skaalaparametri* $t$ vastaa Gaussin suotimen parametria
$\sigma^2$ eli varianssia. Muistamme aiemmalta kurssilta, että näytteistys
voidaan määritellä konvoluutiona Diracin $\delta$:n kanssa, ja että tämä
$\delta$ voidaan määritellä normaalijakauman eli normalisoidun Gaussin funktion
raja-arvona, kun $\sigma^2$ lähestyy nollaa. Toteamme siis, että
$L(x,y;0) = I(x,y)$ kuten pitääkin.

Skaala-avaruuden skaala $0$ vastaa alkuperäistä näytteistettyä kuvaa, kun taas
suuremmat skaalat vastaavat *alipäästösuodatettuja* versioita alkuperäisestä
kuvasta. Parametri $t$ voidaan tulkita siten, että ne kuvan yksityiskohdat
joiden *spatiaalinen* eli pikselikoko on pienempi kuin $\sqrt{t}$ on suodatettu
pois. Muistamme *Nyquistin taajuuden*: jos kuvasignaalia näytteistetään $2k$
pikselin välein, signaalista pitäisi poistaa muutokset jotka tapahtuvat
nopeammin kuin $k$ pikselin välein. Voidaan siis käyttää skaala-avaruuden
skaalaa $k^2$ ja uudelleennäytteistää kuva tältä skaalatasolta.

Mikä tahansa alipäästösuodin ei sovi skaala-avaruuden muodostamiseen; on
olemassa joukko skaala-avaruuden *aksioomia* jotka suotimen on täytettävä.
Yksi tärkeimmistä on vaatimus siitä, että suodin ei saa tuottaa uusia,
ylimääräisiä rakenteita karkeampiin skaaloihin. Emme mene näihin aksioomiin
tässä tarkemmin, mutta toteamme että Gaussin funktio on kanoninen tapa muodostaa
skaala-avaruus. Tämä seuraa myös skaala-avaruuden tulkinnasta *lämpödiffuusion*
mukaan: kuvafunktio voidaan nähdä lämpötilajakaumana ja parametri $t$ aikana.
Kun aika kuluu, lämpö alkaa levitä ja jakautua tasaisemmin ja tasaisemmin.

Gaussin funktio on lämpödiffuusiota kuvaavan differentiaaliyhtälön
*Greenin funktio*, eli sitä voidaan ajatella tuon yhtälön impulssivasteena.
Gaussin funktio siis kuvaa sitä, mihin lämpö leviää tietystä pistemäisestä
kohteesta ajan $t$ kuluessa. Lämpöyhtälöhän kirjoitetaan näin:

$$\partial_t L = \frac{1}{2} \nabla^2 L,$$

ja reunaehtona on $L(x,y;0) = I(x,y)$. Operaattori $\nabla^2$ on gradientin
divergenssi tai Laplacen operaattori, jota siis kuvien tapauksessa vastaa
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
kaikilla pyramidin tasoilla.

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

## Laplacen pyramidi

Laplacen pyramidin esittelivät Burt ja Adelson vuonna 1983. Se vastaa Gaussin
pyramidia, mutta on sarja *kaistapäästösuodatettuja* versioita alkuperäisestä
kuvasta, kun taas Gaussin pyramidi koostuu alipäästösuodatetuista versioista.
Laplacen pyramidi voidaan muodostaa joko *Laplacian of Gaussian* -suotimella tai
approksimoimalla tätä käyttäen *Difference of Gaussians* -operaattoria, joka on
siis kahden erisuuruista $\sigma$:a vastaavan Gaussin funktion erotus. On
todettu, että paras LoG-approksimaatio saadaan, kun Gaussin funktioiden
$\sigma$:n suhde on n. $1.6$.

Laplacen pyramidi saadaan siis muodostettua helposti Gaussin pyramidista
laskemalla kahden peräkkäisen pyramidin tason erotus. Luonnollisesti on joko
käytettävä pienentämättömiä versioita kuvista, tai skaalattava pienennetyt
versiot kuvista alkuperäiseen kokoon. Voidaan käyttää myös binomisuotimilla
muodostettua pyramidia vastaavalla tavalla. Voidaan ajatella tämän erotuksen
kuvaavan sitä, mitä alipäästösuodin poistaa alemman tason kuvasta. Koska alempi
taso on myös alipäästösuodatettu, erotus vastaa kaistapäästösuodatettua kuvaa.

Laplacen pyramidilla on seuraavia hyödyllisiä ominaisuuksia. Se sisältää eri
skaaloissa laskettuja LoG-suotimen approksimaatioita, joten sitä voidaan käyttää
etsittäessä kulmapisteiden karakteristista skaalaa. Voidaan myös etsiä suoraan
pyramidin nollakohtia; koska pyramidin tasot ovat kaistapäästösuodatettuja
versioita alkuperäisestä kuvasta, tällä tavoin löydetään tietyllä
taajuusalueella esiintyviä reunoja.

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
ilmeisesti muodostetaan jo verkkokalvon gangliasoluissa. Eräs tärkeä syy tehdä
näin saattaa olla juuri kuvainformaation pakkaaminen; näköhermon kapasiteetti on
rajallinen, joten pakkaamisesta on hyötyä. Toinen tärkeä syy voi olla energian
säästäminen: esitysmuodon *harvuus* tarkoittaa sitä, että suurin osa signaalia
välittävistä neuroneista voi olla lepotilassa. Mitä harvemmin neuronit
laukeavat, sitä vähemmän energiaa kuluu.

![Kuvapyramidit](images/pyramids.png)

~~~{.haskell .jy-vision}
{-#LANGUAGE NoImplicitPrelude#-}
import CVLangUC

imageFile = "nut.png"

-- recommended values are from 3 to 6
sigmaMultiplier = 3

-- recommended to fit at least 3 sigma into the mask radius
sigmaToSize(sigma) = 2 * (ceiling $ sigmaMultiplier * sigma) + 1

sigmaToMask(sigma) = createMask2D(fgaussian2D(sigma),sigmaToSize(sigma))

sigmaToFilter(sigma) = createFilter2D(mask,center)
  where
    mask = createMask2D(fgaussian2D(sigma),size)
    size = sigmaToSize(sigma)
    center = getMaskCenter2D(size)

-- sigma of the gaussian is sqrt t, where t is 0,1,2,... and 0 is original
--sigmas = [sqrt 2, sqrt 4, sqrt 8, sqrt 16, sqrt 32]
sigmas = [1,1.6,1.6**2,1.6**3,1.6**4]
sizes = forEach(sigmas,sigmaToSize)
masks = forEach(sigmas,sigmaToMask)
filters = forEach(sigmas,sigmaToFilter)

test :: CVLang()
test = do
  img <- readGrayImage(imageFile)
  let
    (w,h) = getSize(img)
    clear = emptyGrayImage((w,h),0)
    -- get the scale versions of the original image by applying the gaussians
    scales = forEach(filters,applyFilter2D(img))
    -- get the laplacian images by subtracting gaussian pyramid levels
    laplacians = forEach(zip((img:scales),scales),imSub)
    -- find the zero crossings of the laplacians
    zeros = forEach(laplacians,drawZero)
  displayGrayImage("Pyramidit", combineImages((6,3),2,
      ([img] ++ scales ++ [clear] ++ (forEach(laplacians,unitNormalize)) ++ [clear] ++ zeros)))

drawZero image = drawPixelsGray(clear,zeros)
  where
    (w,h) = getSize(image)
    clear = emptyGrayImage((w,h),0)
    zeros = forEach(zeroCrossings(image),valueToMax)

zeroCrossings(image) = filterNeighborhood(n8,crossesZero,image)

crossesZero (_,ns) = (minimum ns) < 0 && (maximum ns) > 0

valueToMax ((x,y),_) = ((x,y),1)
~~~

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

## Pistepiirteet

Kohteiden reunoja haeskellessamme huomasimme, että kohteiden kuvailu reunakäyrän
perusteella on hankalaa. Muotopiirteet soveltuvat kuvailemaan lähinnä kohteita,
joiden koko reunakäyrä on tiedossa. On kuitenkin melkoisen vaikeaa saada
kuvasta irti yhtenäinen reuna tietylle kohteelle. Reunoja löytyy aivan liikaa,
ne muodostavat harvoin ehjän kohteen ympäri menevän ketjun, ja joka tapauksessa
hyödyllinen reunakäyrä saadaan vain tasaisen värisille kohteille. Lisäksi
kohteen pitäisi näyttää saman muotoiselta joka suunnasta.

Seuraava idea on kuvailla kohdetta kokoelmana irrallisia palasia. Ideana on se,
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
jokaisessa skaalassa erikseen. Kukin löydetty piste lokalisoidaan *skaalassa*
etsimällä se skaala, jossa *Laplacian-of-Gaussian* (LoG) maksimoituu.

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

## Affiini skaala-avaruus

Gaussisella Laplacen operaattorilla (*Laplacian of Gaussian*), Harrisin
kulmaoperaattorilla tai Hessen matriisin determinantilla löydetään kuvien
skaala-avaruuksista pisteitä, jotka ovat invariantteja siirroille, kierroille ja
skaalauksille. Nämä sopivat hyvin osapuilleen pyöreille kohteille, joita
katsotaan aina samasta suunnasta. Luonnollisissa kuvissa esiintyy kuitenkin myös
näkökulmien muutoksia ja perspektiiviprojektiosta johtuvia vääristymiä;
ympyröistä tulee ellipsejä. Usein onkin tarpeen käyttää *affiini-invariantteja*
piirteitä. Nimitys tarkoittaa pistepiirteitä, jotka ovat invariantteja
affiineille muunnoksille.

Affiinit muunnokset ovat kuvauksia, jotka voidaan esittää vektoreiden summan ja
lineaarimuunnoksen yhdistelmänä. Tietokonegrafiikan puolelta muistamme, että
tällainen muunnos voidaan esittää yhtenä matriisikertolaskuna käyttäen vektorien
laajennettua muotoa *homogeenisissa koordinaateissa* ja *projektiomatriisia*.
Tätä kutsutaan myös affiiniksi muunnosmatriisiksi. Affiinit muunnokset
säilyttävät suorat linjat, janojen osien väliset suhteet, rinnakkaiset linjat ja
painotettujen pistejoukkojen painopisteet; neliöistä tulee kierrettyjä,
siirrettyjä ja väännettyjä suunnikkaita. Perspektiivikuvaus, jota kutsutaan
myös homografiaksi, puolestaan saattaa kuvata rinnakkaisia linjoja
ei-rinnakkaisiksi. Näitä vääristymiä voidaan approksimoida paikallisesti
käyttäen affiineja muunnoksia.

Kuvien piirrepisteistä voidaan tehdä affiini-invariantteja etsimällä paikalliset
ääriarvot skaala-avaruudessa ja normalisoimalla paikallisen affiinin muodon
mukaan. Tämä voidaan tehdä laajentamalla skaala-avaruus *anisotrooppisiin*
ympäristöihin käyttäen elliptistä Gaussin funktiota. Olkoon $\mathbf{x}$
kaksiulotteinen vektori kuvan lähtöjoukossa ja $\Sigma_t$ positiivisesti
definiitti kovarianssimatriisi.

$$G(\mathbf{x};\Sigma_t) =
  \frac{1}{t \pi \sqrt{\text{det}\Sigma_t}}
  e^{-\frac{\mathbf{x}^T\Sigma_t^{-1}\mathbf{x}}{2}}$$

Normaali Gaussin ydin on *isotrooppinen* eli samanlainen kaikissa suunnissa,
toisin sanoen ympyrän muotoinen. Affiini kuvaus tekee ympyrästä ellipsin;
määrittämällä Gaussin ydin käyttäen yksikkömatriisista poikkeavaa
kovarianssimatriisia $\Sigma_t$ saadaan *anisotrooppinen* Gaussin ydin, joka on
siis ellipsin muotoinen.

Toisen momenttimatriisin ominaisarvojen perusteella voidaan arvioida pisteen
ympäristön muotoa: jos ominaisarvot ovat yhtä suuret, ympäristö on ympyrämäinen.
Jos toinen ominaisarvoista on suurempi, ympäristö on jollakin lailla vino ja
elliptinen. Normalisoimalla pisteiden ympäristö ympyrämäiseksi voidaan vertailla
kahden kuvan pisteitä keskenään ja arvioida, millainen affiini muunnos niiden
välillä voisi olla.

## Visuaalinen merkittävyys

Keskeinen käsite pistepiirteiden muodostamisessa on visuaalinen *merkittävyys*
eli *salienssi* (engl. *salience* tai *saliency*). Käsite tulee neurotieteen
puolelta, ja voitaisiin kääntää jonkin kohteen suhteellisena tärkeytenä; tässä
esityksessä käytetään muotoa *merkittävyys*. Tämä tarkoittaa sitä, millä tavoin
tietty kohde poikkeaa ympäröivistä kohteista; jos kohde on jossakin mielessä
hyvin erilainen kuin ympäröivät kohteet, se erottuu hyvin taustastaan ja on
siksi visuaalisesti merkittävä. Ihmisen huomio pyrkii kiinnittymään tällaisiin
kohteisiin.

Kohde voi olla visuaalisesti merkittävä monella eri tavalla. Liikennemerkit ovat
esimerkki kohteista, jotka on tarkoituksella tehty merkittäviksi maalaamalla ne
kirkkailla väreillä, joita ei muuten yleensä esiinny teiden varsilla. Kohde voi
poiketa ympäristöstään paitsi värin, myös pintarakenteen, muodon tai asennon
perusteella. Konenäössä merkittävyydellä viitataan yleensä jonkin suotimen
tuottamiin voimakkaisiin paikallisiin ääriarvokohtiin. Kuten muistamme, kaikki
kuvasuotimet tuottavat huipukkaita, harvoja jakaumia; suotimet saavat useimmiten
lähellä nollaa olevia arvoja, ja hyvin suuret ja pienet arvot ovat harvinaisia.
Tämän vuoksi erilaisten suotimien (useimmiten *LoG* tai *Gabor*) ääriarvot
erottuvat ympäristöstään ja ovat siis merkittäviä.

## Kadir-Brady -menetelmä*

Monissa teoreettisissa tarkasteluissa on viime aikoina käytetty paljon Kadirin
ja Bradyn kehittämää visuaalisesti merkittävien alueiden etsimiseen tarkoitettua
menetelmää. Keskeinen idea tässä menetelmässä on se, että suotimien ääriarvojen
sijaan kuva-alueen merkitystä mitataan informaatioteoriasta tutun *entropian*
avulla.

Entropian voidaan ajatella mittaavan kohteen epäjärjestystä, ennustettavuutta ja
yllättävyyttä sen jakauman perusteella. Mitä suurempi entropia, sitä enemmän
epäjärjestystä ja sitä vaikeampi kohteen saamia arvoja on ennustaa. Aiemmasta
luvusta muistamme, että jakauman $p$ entropia $H$ on $-p \log p$. Tässä symboli
$H$ on kreikkalainen kirjain *eta*. Olkoon kuva-alueen $R$ normalisoitu
histogrammi $P_D(R)$, jossa $D$ on diskreetti joukko kuvan arvoja; ne vastaavat
siis histogrammin lokeroita. Tämän alueen entropia arvojen $D$ jakauman suhteen
on siis

$$H_D(R) = -\sum_{d \in D}P_D(R) \log P_D(R).$$

Jos entropia on suuri, jakauma on monimutkainen eli vaikeasti ennustettava.
Kadir ja Brady tutkivat entropiaa useissa skaaloissa, eli käytännössä
muodostamalla suurempien ja suurempien alueiden histogrammeja pisteen ympäriltä.
Kun skaalaa kasvatetaan ja löydetään entropian huippukohta, voidaan ajatella
että on löytynyt pisteympäristö joka on jollakin lailla yllättävä ja vaikeasti
ennustettava, eli sellainen joka erottuu hyvin ympäristöstään. Nämä ovat hyviä
piirrepisteitä. Ongelmaksi muodostuu vain histogrammien muodostaminen suurista
pisteympäristöistä, mikä on hidasta.

## MSER

Eräs mielenkiintoinen tapa etsiä kuvasta selkeästi taustastaan erottuvia alueita
on MSER eli *maximally stable extremal regions*. Algoritmi on helppo ymmärtää.
Termi *extremal region* viittaa alueisiin, joissa on kirkkauden paikallinen
ääriarvokohta, eli siis ympäristöään kirkkaampi tai tummempi alue. Termi
*maximally stable* puolestaan viittaa siihen, että alueen muoto pysyy vakaana
kun kuvaa kynnystetään eri kynnysarvoilla.

MSER-alueet voidaan löytää kuvasta kynnystämällä kuvaa monta kertaa peräjälkeen
käyttäen kasvavaa kynnysarvoa ja tutkimalla, mitkä yhtenäiset kappaleet pysyvät
saman muotoisina useimpien kynnysarvon muutosten yli. Tämä saadaan toteutettua
nopeasti *lajittelemalla* pikselit suuruusjärjestykseen ja käymällä niitä läpi
alkaen pienimmistä arvoista. Tällä tavoin selvitään yhdellä pikselien
läpikäynnillä; kun listassa siirrytään aina seuraavaan pikseliarvoon, nähdään
mitkä pikselit lisättäisiin alueisiin jos kynnysarvoa kasvatettaisiin yhdellä.
Käyttämällä edellisellä luennolla esiteltyä tapaa hallinnoida erillisiä joukkoja
voidaan seurata jatkuvasti mitkä pikselijoukot ovat yhtenäisiä ja mitkä alueet
pysyvät muuttumattomina kun kynnysarvo kasvaa.

## Pisteiden kuvailu piirteiden avulla

Tähän asti olemme etsineet kuvasta vain pisteitä. Niistä saadaan pistepiirteitä
vasta sitten, kun pisteiden ympäristöä kuvaillaan jollakin matemaattisesti
vertailtavalla tavalla. Perinteinen keino oli ottaa talteen esimerkiksi Harrisin
pisteiden ympäriltä pieni pikseliympäristö harmaasävykuvana, tai
vaihtoehtoisesti harmaasävyhistogrammi. Myös itse Harrisin funktion arvo
kuvailee pistettä jollakin tavalla, samoin rakennetensorin tai Hessen matriisin
ominaisarvot. Nykyään kuitenkin tyypillisesti muodostetaan erilaisia
gradienttihistogrammeja pisteen ympäristöstä.

## SIFT

Kaksi erittäin suosittua pistepiirteiden etsintämenetelmää ovat SURF ja SIFT. Ne
ovat melko monimutkaisia algoritmeja, jotka esitellään nyt lyhyesti.

SIFT eli [scale-invariant feature transform] on eräs suosituimmista
pistepiirteiden hakumenetelmistä. Se sisältää menetelmän sekä hyvien pisteiden
löytämiseen useissa skaaloissa että pisteitä kuvailevan piirrevektorin
(engl. *descriptor*) muodostamiseen.

Algoritmin vaiheet pääpiirteissään ovat

* kuva konvolvoidaan sarjalla eri kokoisia Gaussin maskeja,
* vierekkäisten konvolvoitujen kuvien erotus lasketaan jolloin saadaan DoG,
* valitaan pisteet jotka ovat lokaaleja maksimeja sekä kuva-avaruudessa että
  skaala-avaruudessa, eli verrataan pikseliä naapureihinsa ja vastaavaan 9
  pikselin naapurustoon naapuriskaaloissa,
* interpoloidaan näiden kandidaattipisteiden sijainti pikseliä paremmalla
  tarkkuudella (käyttäen paraabelin sovitusta),
* hylätään kandidaattipisteet joilla on huono kontrasti (kynnystetään DoG:n
  mukaan),
* hylätään reunapikselit joille Hessen matriisin ominaisarvojen välinen suhde on
  liian pieni (voidaan laskea determinantin ja jäljen välisen suhteen avulla).

Jokaiselle valitulle pisteelle lasketaan pääasiallinen suunta laskemalla
gradientin magnitudi ja suunta pisteen ympäristössä ja tekemällä näistä
suuntahistogrammi. Pisteen pääasiallinen suunta on se suunta, joka esiintyy
useimmin histogrammissa. Jos on myös muita suuntia, jotka esiintyvät lähes
yhtä monta kertaa (alkuperäisessä algoritmissa 80% pääasiallisen suunnan
esiintymiskerroista), jokaiselle suunnalle luodaan oma piste, jolle lasketaan
deskriptori.

Deskriptori lasketaan pisteen dominoivan suunnan mukaisesti. Pisteen ympäriltä
muodostetaan 16x16-kokoinen ympäristö, jonka sisältä lasketaan 4x4 uutta
suuntahistogrammia, joista jokaisessa on 8 lokeroa. Lopulta siis saadaan
vektori, jossa on 4x4x8 eli 128 elementtiä. Tämä vektori normalisoidaan
yksikkövektoriksi.

Tämän selostuksen perusteella lienee selvää, että SIFT-menetelmän suurin puute
on vaadittava laskentateho. Sekä pisteiden etsiminen, piirrevektorien luominen
että piirrevektorien etsiminen ja vertaileminen ovat melko raskaita
operaatioita. Menetelmä kuitenkin toimii melko hyvin. Löwen alkuperäinen
SIFT-paperi on yksi niistä papereista, jotka kannattaa lukea jos aihe yhtään
kiinnostaa.

[scale-invariant feature transform]:
http://en.wikipedia.org/wiki/Scale-invariant_feature_transform

## SURF

SURF eli [speeded up robust features] on nopeampi kuin SIFT, ja myös erittäin
suosittu menetelmä. Sekin sisältää menetelmän sekä pisteiden löytämiseksi että
niiden kuvailemiseksi, ja SURF-piirrevektoreita käytetään toisinaan myös muilla
menetelmillä löydettyjen pisteiden kuvailemiseen.

SURF-menetelmän nopeus saavutetaan käyttämällä integraalikuvan avulla
laskettavia laatikkofilttereitä approksimoimaan kuvan ensimmäisen ja toisen
asteen derivaattoja. Algoritmin vaiheet pääpiirteissään ovat

* Hessen matriisin laskeminen useissa skaaloissa approksimoiden toisen asteen
  derivaattoja eri kokoisten laatikkofilttereiden avulla,
* matriisin determinantin lokaalien maksimien laskeminen,
* maksimipisteiden sijainnin interpolointi sekä kuvassa että skaalassa.

SURF-piirrevektorit ovat Haarin wavelet-funktioiden histogrammeja, ja myös
näiden wavelet-funktioiden laskemisessa käytetään laatikoita ja integraalikuvia.
Nämä funktiot voidaan nähdä ensimmäisen asteen derivaattojen approksimaatioina.
Myös tämä histogrammi normalisoidaan Haar-wavelettien pääasiallisen suunnan
mukaan. Jos suunnalla ei ole merkitystä, normalisointi voidaan jättää pois.
Varsinaisessa deskriptorissa käytetään myös 4x4:ää aluetta valitun pisteen
ympärillä, tarvittaessa normalisoituna pääasiallisen suunnan mukaan. Jokaisesta
pienemmästä laatikosta kerätään Haarin wavelet-funktioiden vasteet 5x5
pisteestä, ja näistä lasketaan x- ja y-suuntaisten vasteiden summa ja summan
itseisarvo. Nämä summat muodostavat varsinaisen piirrevektorin arvot, joten
yhteensä saadaan 4x4x4 eli 64 elementtiä.

Vaikka SURF on yksinkertaisempi ja nopeampi kuin SIFT, sillä saavutetaan hyvin
samankaltaisia tuloksia.

Nämä kaksi esimerkkiä osoittanevat hyvin, mitkä ovat pääasialliset periaatteet
pistepiirteiden etsinnässä ja kuvailussa. Molempiin menetelmiin on kehitelty
paljon pieniä parannuksia ja laajennuksia, joten jos niitä käytetään jossakin
sovelluksessa, on syytä tutustua kirjallisuuteen parhaan toteutustavan
valitsemiseksi.

[speeded up robust features]: http://en.wikipedia.org/wiki/SURF

## RANSAC*

Seuraavilla luennoilla ryhdymme tutustumaan kohteiden tunnistamiseen käyttäen
erilaisia hahmontunnistuksen ja koneoppimisen menetelmiä. Käytännössä kaikkien
menetelmien perusidea on muodostaa kohteista tai kokonaisista kuvista
piirrevektori ja tunnistaa samanlaiset kohteet jonkinlaisen etäisyysmitan tai
piirreavaruuden osituksen perusteella. Pistepiirteiden ongelma tässä suhteessa
on se, että kuvista ja kohteista ei synny yksittäisiä vakiomittaisia vektoreita,
vaan vaihtelevia kokoelmia pisteitä ja niitä kuvailevia piirrevektoreita.

Pistepiirteet eivät sellaisenaan sovellu käytettäviksi
hahmontunnistusmenetelmien kanssa. Tyypillinen tapa tunnistaa kohteita on
vertailla keskenään pistepiirteistä muodostettuja pistepilviä. Tässä ongelmaksi
tulee se, että tyypillisesti pistepilvet eivät täysin vastaa toisiaan. Pitäisi
voida tutkia sitä, leikkaavatko pistejoukot merkittävästi eli löytyykö joukoista
riittävän monta toisiaan vastaavaa pistettä.

Eräs suosittu menetelmä pistepilvien vertailemiseksi ja yleisesti erilaisten
hypoteesien sovittamiseksi datajoukkoon on RANSAC eli *random sample consensus*.
Siinä datan ajatellaan koostuvan malliin sopivista (*inlier*) ja malliin
sopimattomista (*outlier*) datapisteistä. Datapisteistä valitaan satunnainen
osajoukko (*random sample*), sovitetaan mallin parametrit tämän osajoukon
mukaan, ja valitaan sitten ne datajoukon pisteet jotka sopivat tuloksena
syntyneeseen malliin eli ovat 'samaa mieltä' mallista (*consensus*). Sitten
voidaan tehdä uusi kierros parametrien estimointia käyttäen konsensusjoukon
pisteitä. Tulos riippuu suuresti siitä, kuinka suuri osa alkuperäisen
satunnaisen joukon pisteistä oikeasti sopii malliin, joten hyvän tuloksen
varmistamiseksi voi olla syytä suorittaa algoritmia useita kertoja erilaisilla
satunnaisilla osajoukoilla.

Pistepilviä vertailtaessa yleisesti käytetty malli on kahden pistepilven välinen
*affiini kuvaus* tai *homografia*. RANSACia käyttäen voidaan etsiä parametrit
homografiakuvaukselle, joka kuvaa pistejoukon toiseksi pistejoukoksi.

* Valitaan satunnaiset pistejoukot molemmista kuvista.
* Tutkitaan mitkä pisteet vastaavat toisiaan eri kuvissa käyttäen sopivaa
  etäisyysmittaa, jolloin saadaan vastinpistepareja.
* Etsitään jollakin menetelmällä homografia kuvien välille näiden
  vastinpisteparien perusteella
* Valitaan seuraavaa kierrosta varten kaikki kuvien vastinpisteparit jotka
  sopivat tähän löydettyyn kuvaukseen, eli sellaiset joilla ensimmäinen piste
  kuvautuu lähelle toista pistettä käyttäen löydettyä homografiaa.
* Tarkennetaan homografiaa käyttäen uutta pistejoukkoa. Voidaan toistaa useita
  kierroksia.
* Voidaan kokeilla useilla alkuarvauksilla ja valita paras lopputulos.

Käytännössä tässä menetelmässä siis tutkitaan, löytyykö sellaiset kaksi
kuvakulmaa, joista nähtynä sama kohde voisi tuottaa tutkittavat pistepilvet.

## Tehtäviä
