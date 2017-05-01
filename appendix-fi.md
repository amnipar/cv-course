---
code:   TIES411
title:  CVLang-tutoriaali
week:   0
instructor: Ville Tirronen
---

# Appendix A: CVLang-tutoriaali

Konenäkö ja kuva-analyysi -kurssia varten on tehty interaktiivinen
webbisivu, jota voi käyttää yksinkertaisten konenäkökoodien kokeilemiseen.
Koodiesimerkkien kieli on tällä hetkellä Haskell. Haskell on moderni
funktio-ohjelmointikieli, jota kurssin pitäjät ovat hyödyntäneet omassa
tutkimuksessaan. Haskellin käytössä tällä kurssilla on kuitenkin kaksi
ongelmaa. Ensiksikin, Haskell on uusi kieli monelle mikä jo sinänsä aiheuttaa
päänvaivaa. Toiseksi, Haskell on äärimmäisen joustava ja ilmaisuvoimainen
kieli ja sen syntaksi on C-sukuisten kielten syntaksiin tottuneille
varsin vieras. Miksi sitten Haskell valittiin tälle kurssille?

Kurssisivusto pohjautuu pitkälle toisen kurssin vetäjän aiempaan
interaktiiviseen kurssivustoon kurssilla ''TIEA341 -- Johdatus
funktio-ohjelmointiin'', eli säästimme aikaa käyttämällä valmista.

## Kuinka koodia luetaan

Tässä dokumentissa käymme läpi kuinka koodiesimerkkejä luetaan.  Huomaa
lisäksi,  että webbiesimerkeissä voit klikata koodisanoja ja symboleja, jolloin
editorin alapuolelle ilmestyy selitys kyseisestä symbolista.

### Ohjelmatiedoston alku

Jokainen ohjelmatiedosto alkaa koodilla:

~~~{.haskell}
{-#LANGUAGE NoImplicitPrelude#-}
import CVLangUC
~~~

Nämä käskyt tarkoittavat, että koodiesimerkissä käytetään
kurssille tehtyä kuvankäsittelykäskyjen kokoelmaa nimeltä `CVLangUC`
ja sitä, että tavallista Haskellin peruskirjastoa ei käytetä^[1].

[1]: Haskellin tuntijoille sen verran tiedoksi, että kokeilemme, auttaisiko
ymmärrystä se, jos käytämme funktioita *uncurried*-muodossa.

### Vakiot ja lausekkeet

Alkukomentojen jälkeen koodiin kirjoitetaan esimerkissä
käytettävät vakiot. Nämä kirjoitetaan seuraavasti:

~~~{.haskell}
-- Kuinka monta kertaa suodin ajetaan?
toistokerrat :: Int
toistokerrat = 12

-- Mikä on generoidun signaalin taajuus?
taajuus :: Float
taajuus = 0.5
~~~

Hyvän tavan mukaan, jokainen vakio kommentoidaan käyttämällä Haskellin
kommenttimerkkiä `--`{.haskell}, jonka jälkeen vakiomääritelmä aloitetaan
*tyyppilausekkeella* (`toistokerrat :: Int`{.haskell}), joka kertoo vakion
tyypin.  Erilaisten lukutyyppien lisäksi Haskellissa on myös

**Merkkijonoja:**

~~~{.haskell}
viesti :: String
viesti = "Kuvassa on mutteri"
~~~

**Listoja**, jotka voivat sisältää vaihtelevan määrän
yhden tyyppisiä alkioita:

~~~{.haskell}
skaalat :: [Float]
skaalat = [1, 0.5, 0.25, 0.125]
~~~

**Pareja**, jotka voivat sisältää kaksi eri tyyppistä
alkiota.

~~~{.haskell}
parametrit :: (Float,String)
parametrit = (1,"normaali")
~~~

ja konenäkökurssin tapauksessa **kuvia**:

~~~{.haskell}
tyhjäKuva :: Image GrayScale Float
tyhjäKuva = create(50,50)

tyhjäVäriKuva :: Image RGB Float
tyhjäVäriKuva = create(50,50)
~~~

Näissä tapauksissa tyypit ovat kolmiosaisia. `Image` kertoo, että puhumme
kuvasta, `GrayScale` ja `RGB` kertovat onko kyseessä harmaasävy vai
värikuva ja lopun `Float` sitä, että haluamme harmaasävykuvien
tapauksessa esittää jokaisen kuvapisteen liukulukuna ja värikuvien
kohdalla sitä, että jokaisen kuvapisteen jokainen värikomponentti
esitetään yhdellä liukuluvulla.

### Funktiomääritelmät

Pelkillä vakioilla on vaikea tehdä mitään mielenkiintoista eli
käytämme koodiesimerkeissä myös funktiomääritelmiä. Haskellin
funktiot ovat vain muuttujasta riippuvia vakioita, eikä niitä
tule sotkea esimerkiksi Javan metodeihin tai Pythonin funktioihin,
jotka ovat olennaisesti listoja suoritettavista komennoista.

Funktio kirjoitetaan näin:

~~~{.haskell}
napakoordinaateista :: (Float,Float) -> (Float,Float)
napakoordinaateista(säde,kulma)
    = (säde * sin(kulma) , säde * cos(kulma))
~~~

Funktion tyyppi merkitään nuolella (`->`), jonka vasemmalla puolella listataan
parametrien tyypit ja jonka oikealle puolelle kirjoitetaan funktion paluuarvon
tyyppi. Esimerkin funktiota pitää siis kutsua kahdella liukuluvulla ja
se palauttaa kaksi liukulukua.

Funktion toiminta määritellään kirjoittamalla funktion nimi
(`napakoordinaateista`) ja nimeämällä sen perään funktion
argumentit (`(säde,kulma)`). Seuraavalle riville kirjoitetaan `=` merkki
ja lauseke, jossa argumentteja käytetään.

Funktioissa voi käyttää myös **lokaaleja määritelmiä**, eli edellinen
esimerkki voitaisiin kirjoittaa myös näin:

~~~{.haskell}
napakoordinaateista :: (Float,Float) -> (Float,Float)
napakoordinaateista(säde,kulma)
    = (x,y)
 where
  x = säde * sin(kulma)
  y = säde * cos(kulma)
~~~

Huomaa, että sisennykset ovat olennaisia ja niitä ei voi jättää pois.

### Tehtävälistat

Haskellin tehtävälistat ovat lähin vastine Javan metodeille tai Pythonin
funktioille. Ne muodostuvat listasta suoritettavia komentoja ja
webbiesimerkeissä niitä käytetään kuvaamaan funktion tuloksia. Tarkalleen
ottaen, webbiesimerkki etsii `test` nimisen tehtävälistan ja suorittaa
sen.  Tehtävälista kirjoitetaan näin:

~~~{.haskell}
test = do
  kuva <- readImage("nut.png")
  note "Ladattiin mutterin kuva"
  display("Se näyttää tältä",kuva)
  display("Sen voi myös kynnystää",kynnystys(0.5,kuva))
~~~

Jokainen rivi tehtävälistasta on joko muotoa `<muuttuja> <- <tehtävälista>`
tai `<tehtävälista>`. Ensimmäisessä tapauksessa nuolen oikealla puolella
oleva tehtävälista suoritetaan ja sen tulos sijoitetaan muuttujaan.
Jälkimmäisessä tapauksessa tehtävälista vain suoritetaan.

Huomaa, että samoin kuten funktioille, myös tehtävälistoille voi
antaa argumentteja. Tehtävälistat voivat sisältää myös `where`
avainsanalla määriteltyjä lokaaleja määritelmiä.

## Ohjelmointirajapinta

Seuraavaksi esitellään lyhyesti konenäkötehtävissä käytettävissä olevat
operaatiot ja vakiot.

### Web tehtävälistat

Web tehtävälistoilla ohjataan esimerkin käyttäytymistä webissä.
Seuraavat tehtävälistat ovat esimääriteltyjä:

* `readImage`: Lukee värikuvan. Esim. `mutterikuva <- readImage("nut.png")`.
* `displayImage`: Näyttää värikuvan.
   Esim. `displayImage("mutteri",mutterikuva)`.
* `readGrayImage`: Lukee harmaasävykuvan.
   Esim. `mutterikuva <- readImage("nut.png")`.
* `displayGrayImage`: Näyttää harmaasävykuvan.
   Esim. `displayImage("mutteri",mutterikuva)`.
* `note`: Näyttää merkkijonon. Esim. `note("operaatio onnistui!")`.
* `table`: Näyttää taulukon. Esim. `table("taajuudet",[1,2,3,4,5]`).

### Kuvien generointi

* `emptyGrayImage(koko,harmaa)`: Muodostaa tyhjän harmaasävykuvan, jonka koko
  ja harmaasävy väliltä $[0,1]$ voidaan antaa.
* `emptyColorImage(koko,väri)`: Muodostaa tyhjän värikuvan, jonka koko ja väri
  voidaan antaa. Väri on kolmikko `(b,g,r) :: (Float,Float,Float)`{.haskell}`
  jossa jokainen komponentti on väliltä $[0,1]$. **Huom**: OpenCV-kirjastossa
  käytetään yleensä värejä järjestyksessä *sininen, vihreä, punainen* (BGR, ei
  RGB).
* `discGrayImage(koko,säde,kohde,tausta)`: Muodostaa kuvan, jossa on
  tasavärisellä taustalla tasavärinen ympyrä. Kuvan koko ja ympyrän säde
  voidaan antaa, samoin kohteessa ja taustalla käytetty harmaasävy väliltä
  $[0,1]$.
* `torusGrayImage(koko,säde1,säde2,kohde,tausta)`: Muodostaa kuvan, jossa on
  tasavärisellä taustalla tasavärinen rengas. Kuvan koko sekä renkaan ulkosäde
  ja sisäsäde voidaan antaa, samoin kohteessa ja taustalla käytetty harmaasävy
  väliltä $[0,1]$.
* `squareGrayImage(koko,säde,kohde,tausta)`: Muodostaa kuvan, jossa on
  tasavärisellä taustalla tasavärinen neliö. Kuvan koko ja neliön säde
  (keskeltä kohtisuoraan reunalle) voidaan antaa, samoin kohteessa ja taustalla
  käytetty harmaasävy väliltä $[0,1]$.
* `diamondGrayImage(koko, säde, kohde,tausta)`: Muodostaa kuvan, jossa on
  tasavärisellä taustalla tasavärinen vinoneliö. Kuvan koko ja vinoneliön säde
  (keskeltä kulmaan) voidaan antaa, samoin kohteessa ja taustalla käytetty
  harmaasävy väliltä $[0,1]$.
* `powImage(koko)`: Muodostaa harmaasävykuvan, joka vastaa Fourier-muunnoksen
  amplitudin jakaumaa $1/f$, eli pikselin tummuus on $1/x$ kun $x$ on etäisyys
  pikseleinä lähimpään nurkkaan.
* `imageFromFunction(koko,funktio)`: Muodostaa halutun kokoisen kuvan siten,
  että jokaisen pikselin `(x,y)` arvoksi tulee funktion `funktio(x,y)` tulos.
  Funktion siis pitäisi olla tyyppiä `funktio :: (Int,Int) -> Float`{.haskell}
  tai vastaavasti `funktio :: (Int,Int) -> (Float,Float,Float)`{.haskell}

### Kuvankäsittelyfunktiot

* `getSize(kuva)`: Kertoo kuvan koon parina
  `(leveys,korkeus) :: (Int,Int)`{.haskell}
* `getPixel(x,y,kuva)`: Palauttaa kuvan kyseisen pikselin arvon
  `harmaa :: (Float)`{.haskell} tai `(b,g,r) :: (Float,Float,Float)`{.haskell}
  **Huom**: OpenCV-kirjastossa käytetään yleensä värejä järjestyksessä *sininen,
  vihreä, punainen* (BGR, ei RGB).
* `getPixels(kuva)`: Palauttaa kaikki kuvan pikselit listana pareja
  `[((x,y),arvo)] :: [((Int,Int),Float)]`{.haskell}.
* `getValues(kuva)`: Palauttaa kaikkien kuvan pikselien arvot listana
  `[Float]`{.haskell}.
* `compose(skuva,vkuva,pkuva)`: Muodostaa värikuvan kolmesta samankokoisesta
  harmaasävykuvasta.
* `convGrayToColor(kuva)`: Muuntaa harmaasävykuvan värikuvaksi.
* `convColorToGray(kuva)`: Muuntaa värikuvan harmaasävykuvaksi.
* `upscaleImage(kerroin,image)`: Suurentaa kuvaa naiivilla tavalla kopioimalla
  pikseleitä useita kertoja siten, että lopputuloksena on kuva jonka koko on
  `kerroin*koko`.
* `resizeImage(koko,kuva)`: Muuttaa kuvan kokoa säilyttämättä huomioon pituuden
  ja leveyden suhdetta.
* `resizeImageFaithful(koko,kuva)`: Muuttaa kuvan kokoa säilyttäen pituuden ja
  leveyden suhteen; lopputuloksena olevan kuvan koko ei välttämättä ole juuri
  haluttu.
* `scaleImage(kerroin,kuva)`: Muuttaa kuvan kokoa siten, että uusi koko on
  `kerroin*koko`.
* `combineImages(koko,väli,kuvalista)`: Muodostaa listasta kuvia yhdistelmäkuvan
  tai mosaiikin jossa on `koko = (sarakkeet,rivit)` verran alikuvia ja jossa
  rivien ja sarakkeiden välissä on rako jonka leveys on `väli`. Listassa saa
  olla korkeintaan `sarakkeet*rivit` verran kuvia ja niiden on oltava kaikkien
  joko harmaasävy- tai värikuvia, mutta ne voivat olla eri kokoisia.
* `forEachPixel(kuva,funktio)`: Muokkaa kuvaa kutsumalla jokaiselle pikselille
  `funktio(x,y,arvo)` ja tallentamalla tuloksen pikselin uudeksi arvoksi.
  Funktion siis pitäisi olla tyyppiä
  `funktio :: (Int,Int,Float) -> Float`{.haskell} tai vastaavasti
  `funktio :: (Int,Int,(Float,Float,Float)) -> (Float,Float,Float)`{.haskell}

### Matemaattiset operaatiot

* `imAdd(kuva1,kuva2)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen
  pikselin arvo on summa kahden syötekuvan vastaavalla kohdalla olevien
  pikselien arvoista: `kuva1 + kuva2`. Kuvien on oltava samankokoiset ja samaa
  tyyppiä.
* `imAddS(kuva,s)`: Lisää kuvan jokaisen pikselin arvoon skalaarin `s`.
* `imSub(kuva1,kuva2)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen
  pikselin arvo on erotus kahden syötekuvan vastaavalla kohdalla olevien
  pikselien arvoista: `kuva1 - kuva2`. Kuvien on oltava samankokoiset ja samaa
  tyyppiä.
* `imSubS(kuva,s)`: Vähentää kuvan jokaisen pikselin arvosta skalaarin `s`.
  **Huom**: myöhemmin lisätään funktio `imSubRS(s,kuva)` jossa skalaarista `s`
  vähennetään pikselin arvo.
* `imMul(kuva1,kuva2)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen
  pikselin arvo on tulo kahden syötekuvan vastaavalla kohdalla olevien pikselien
  arvoista: `kuva1 * kuva2`. Kuvien on oltava samankokoiset ja samaa tyyppiä.
* `imMulS(kuva,s)`: Kertoo kuvan jokaisen pikselin arvon skalaarilla `s`.
* `imDiv(kuva1,kuva2)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen
  pikselin arvo on osamäärä kahden syötekuvan vastaavalla kohdalla olevien
  pikselien arvoista: `kuva1 / kuva2`. Selviää nollalla jakamisesta kaatumatta,
  mutta oikean tuloksen saamiseksi voi olla syytä varmistaa, ettei kuvassa ole
  nollia; esimerkiksi käyttämällä jäljempänä tulevaa funktiota `imMaxS`.
* `imLog(kuva)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen pikselin
  arvo on luonnollinen logaritmi syötekuvan vastaavalla kohdalla olevan pikselin
  arvosta.
* `imSqrt(kuva)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen pikselin
  arvo on neliöjuuri syötekuvan vastaavalla kohdalla olevan pikselin arvosta.
* `imAtan2(kuva1,kuva2)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen
  pikselin arvo on `arctan (kuva1/kuva2)`. Voidaan käyttää gradientin kulman
  laskemiseen siten, että `kuva1` vastaa y-suuntaista osittaisderivaattaa (dy)
  ja `kuva2` vastaa x-suuntaista osittaisderivaattaa (dx). Toimii kuten funktio
  `atan2` yleensä, eli kulma on välillä $[-\pi,+\pi]$ siten, että kulma $0$
  osoittaa vaakasuoraan oikealle ja positiivinen suunta on *vastapäivään*.
  Selviää nollalla jakamisesta (`dx == 0`) mutta tulos voi olla parempi jos
  varmistaa että nollia ei ole - mikä on hieman hankalaa, sillä dx voi saada
  sekä positiivisia että negatiivisia arvoja.
* `imMin(kuva1,kuva2)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen
  pikselin arvo on minimi syötekuvien vastaavalla kohdalla olevien pikselien
  arvoista.
* `imMinS(s,kuva)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen
  pikselin arvo on minimi skalaarista `s` ja syötekuvan vastaavalla kohdalla
  olevan pikselin arvosta. **Huom**: skalaari ja kuva ovat eri järjestyksessä
  kuin edellä kuvatuissa funktiossa, ja tämä tullaan muuttamaan toisin päin.
* `imMax(kuva1,kuva2)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen
  pikselin arvo on maksimi syötekuvien vastaavalla kohdalla olevien pikselien
  arvoista.
* `imMaxS(s,kuva)`: Muodostaa uuden kuvan siten, että tuloskuvan jokaisen
  pikselin arvo on maksimi skalaarista `s` ja syötekuvan vastaavalla kohdalla
  olevan pikselin arvosta. Esim. `imMax(0.001,kuva)` varmistaa, että jokaisen
  pikselin arvon on vähintää $0.001$, mikä auttaa välttämään nollalla jakamisen.
  **Huom**: skalaari ja kuva ovat eri järjestyksessä kuin edellä kuvatuissa
  funktiossa, ja tämä tullaan muuttamaan toisin päin.
* `imSum(kuva)`: Laskee kuvan kaikkien pikselien arvojen summan skalaarina.
* `imMean(kuva)`: Laskee kuvan kaikkien pikselien arvojen keskiarvon skalaarina.
* `imStdDev(kuva)`: Laskee kuvan kaikkien pikselien arvojen keskihajonnan
  skalaarina.
* `imGaussian(koko,kuva)`: Konvolvoi kuvaa Gaussisella maskilla, jonka koko voi
  olla jokin vaihtoehdoista 3,5,7,9.
* `unitNormalize(kuva)`: Kun `Float`-tyyppisiä kuvia piirretään tai tallennetaan
  tiedostoon, niiden pikselien arvojen oletetaan olevan välillä $[0,1]$. Tämän
  välin ulkopuolella olevat arvot typistetään nollaan tai ykköseen. Siksi
  erilaisten matemaattisten operaatioiden jälkeen on syytä normalisoida kuva
  takaisin välille $[0,1]$. Funktio `unitNormalize` tekee tämän skaalaamalla
  arvot lineaarisesti minimi- ja maksimiarvojen väliin.
* `logNormalize(kuva)`: Kuten `unitNormalize`, mutta laskee ensin uuden kuvan
  `imLog(imAddS(kuva,1))` mistä on hyötyä, jos pikselien arvot painottuvat
  tummiin arvoihin, eli esimerkiksi jakautuvat $1/x$ mukaan kuten
  Fourier-muunnoksen amplitudin tapauksessa.
* `stretchNormalize(kuva)`: Normalisoi kuvan venyttämällä kuvan histogrammia
  siten, että arvot jakautuvat tasaisemmin koko arvovälille. Sopii tilanteisiin,
  joissa pikselien arvojen jakauma on hyvin vino.
* `dft(kuva)`: Laskee kuvan Fourier-muunnoksen käyttäen FFT-algoritmia.
  Tuloksena on kuva tyyppiä `Image Complex Float`{.haskell} jossa on kaksi
  värikanavaa vastaten Fourier-kertoimien reaali- ja imaginääriosaa.
* `idft(kuva)`: Laskee tyyppiä `Image Complex Float`{.haskell} olevan kuvan
  käänteisen Fourier-muunnoksen.
* `complexSplit(kuva)`: Purkaa tyyppiä `Image Complex Float`{.haskell} olevan
  kuvan kahdeksi harmaasävykuvaksi `(re,im) :: Image GrayScale Float`{.haskell}.
* `dftMerge(re,im)`: Kokoaa kaksi harmaasävykuvaa tyyppiä
  `Image Complex Float`{.haskell} olevaksi kompleksimuotoiseksi kuvaksi. Nimi
  pitäisi vaihtaa, `complexMerge` sopisi paremmin yhteen funktion `complexSplit`
  kanssa.
* `threshold((min,max),kynnys,kuva)`: Kynnystää kuvan siten, että kynnysarvoa
  pienemmät pikselit saavat arvon `min`, ja muut pikselit saavat arvon `max`.
  Useimmiten käytetään joko arvoja `(0,1)` tai `(1,0)` riippuen siitä, onko
  kohde tummempi vai vaaleampi kuin tausta.
* `tFromMeanDev(k,epsilon,image)`: Etsii kynnysarvon käyttäen kaavaa
  $t = \mu(I) + k\sigma(I) + \epsilon$.
* `tOtsu(histogrammi)`: Etsii kynnysarvon kuvan histogrammin perusteellä
  käyttäen Otsun menetelmää.
* `convZeroOneToMinusPlus(kuva)`: Muuntaa `(0,1)`-kynnystetyn kuvan
  `(-1,+1)`-kynnystetyksi kuvaksi tiettyjä morfologisia operaatioita varten.
* `collectPoints(t,image)`: Etsii kuvasta kaikki pikselit, joiden arvo on
  suurempi kuin `t`, ja palauttaa ne listana pisteitä muodossa
  `[((Int,Int),Float)]`{.haskell}. Sopii esimerkiksi nurkka- ja haarakohtien
  poimimiseen käsitellystä kuvasta.

### Kuvien suodatus

* `morph(maski,t,kuva)`: Suorittaa yleisen morfologisen operaation
  konvolvoimalla kuvan käyttäen annettua maskia ja kynnystämällä lopputuloksen
  käyttäen annettua kynnysarvoa.
* `dilate(maski,toistot,kuva)`: Suorittaa morfologisen laajennusoperaation
  `toistot` kertaa käyttäen annettua maskia.
* `erode(maski,toistot,kuva)`: Suorittaa morfologisen kulutusoperaation
  `toistot` kertaa käyttäen annettua maskia.
* `open(maski,toistot,kuva)`: Suorittaa morfologisen avausoperaation tekemällä
  ensin kulutusoperaation `toistot` kertaa, sitten laajennusoperaation `toistot`
  kertaa.
* `close(maski,toistot,kuva)`: Suorittaa morfologisen sulkemisoperaation
  tekemällä ensin laajennusoperaation `toistot` kertaa, sitten kulutusoperaation
  `toistot` kertaa.
* `hitormiss(maski,kuva)`: Suorittaa morfologisen
  *hit-or-miss*-operaation käyttäen annettua maskia. Kuvan tulisi olla
  kynnystetty arvoihin `(-1,+1)` ja maskin arvojen tulisi olla `-1,0,+1`.
* `thinning(maski,kuva)`: Suorittaa morfologisen ohennusoperaation poistamalla
  ne pikselit, jotka sopivat annettuun *hit-or-miss*-maskiin.
* `skeleton(kuva)`: Suorittaa morfologisen luuranko-operaation ohentamalla niin
  monta kertaa, että poistettavia pikseleitä ei enää ole. Jäljelle jää kohteiden
  keskilinjan muodostama luuranko.
* `pruneEndpoints(toistot,kuva)`: Poistaa luurangon haarojen päätepisteitä
  `toistot` kertaa. Kuluttaa lopulta koko luurangon olemattomiin, joten tulisi
  käyttää vain muutaman kerran ylimääräisten haarakkeiden poistamiseen.
* `findPoints(kuva,maskit)`: Suorittaa *hit-or-miss*-operaation annetuilla
  maskeilla ja palauttaa kuvan, jossa löydetyt pisteet ovat ykkösiä ja loput
  nollaa. `collectPoints`-funktiolla voidaan sitten hakea pisteet listaksi
  esimerkiksi piirtämistä varten.
* `findJunctions(kuva)`: Etsii luurangon haarakohdat ja palauttaa kuvan, jossa
  kyseiset pisteet ovat ykkösiä ja loput nollaa. `collectPoints`-funktiolla
  voidaan sitten hakea pisteet listaksi esimerkiksi piirtämistä varten.
* `convolve1D(maski,keskipiste,signaali)`: Konvolvoi yksiulotteista signaalia
  annetulla maskilla, sijoittaen maskin keskipisteen annettuun kohtaan.
* `createMask1D(funktio,koko)`: Luo yksiulotteisen konvoluutiomaskin
  näytteistämällä annettua funktiota maskin pisteissä. Olettaa keskipisteen
  sijaitsevan maskin keskellä.
* `getMaskCenter1D(koko)`: Palauttaa annetun kokoisen maskin keskipisteen.
* `averageMask1D(koko)`: Luo halutun kokoisen yksiulotteisen keskiarvosuotimen.
* `gaussianMask1D(koko)`: Luo halutun kokoisen yksiulotteisen Gaussisen
  suotimen.
* `convolve2D(maski,keskipiste,kuva)`: Konvolvoi kuvaa annetulla maskilla,
  sijoittaen maskin keskipisteen annettuun kohtaan.
* `createMask2D(funktio,koko)`: Luo kaksiulotteisen konvoluutiomaskin
  näytteistämällä annettua funktiota maskin pisteissä. Olettaa keskipisteen
  sijaitsevan maskin keskellä.
* `getMaskCenter2D(koko)`: Palauttaa annetun kokoisen maskin keskipisteen.
* `averageMask2D(koko)`: Luo halutun kokoisen kaksiulotteisen keskiarvosuotimen.
* `gaussianMask2D(koko)`: Luo halutun kokoisen kaksiulotteisen Gaussisen
  suotimen.
* `listToMask2D(koko,lista)`: Luo halutun kokoisen kaksiulotteisen
  konvoluutiomaskin käyttäen listassa olevia lukuja maskin alkioina. Lista
  luetaan maskiin riveittäin ja lukuja on oltava ainakin yhtä monta kuin
  maskissa on alkioita. Yksiulotteisina maskeina voidaan käyttää suoraan
  listaa `Float`-tyyppisiä lukuja.
* Myöhemmin lisätään Gaussin derivaatat ja Gaborit vielä...

### Värivakiot

CVLang-kirjasto määrittelee joitain värivakioita. Tällä hetkellä
niitä ovat:

* `black`: musta.
* `white`: valkoinen.
* `blue`: sininen.
* `green`: vihreä.
* `red`: punainen.
* `gray`: harmaa.
* `cblue(v),cgreen(v),cred(v),cgray(v)`: Funktioita, jotka muodostavat värien
  eri tummuusasteita väliltä $[0,1]$ olevan parametrin `v` mukaan.

### Piirtofunktiot graafeille

Useimmat piirtofunktiot käyttävät värikuvia. Piirtokuvat palauttavat tuloksena
syntyvän kuvan, ja kuva, jonka päälle ne piirtävät, otetaan viimeisenä
parametrina. Piirtofunktioita on siis helppo ketjuttaa siten, että syötekuvana
käytetään toisen funktion tuloskuvaa. Luonnollisesti sisin piirtofunktio
suoritetaan ensimmäisenä.

* `signalToPixel(size,margin,scale,miny,signal)`: Muuntaa signaalin (joka on
  lista pareja $(x,f(x))$) pikselikoordinaateiksi $(x,y)$ ottaen huomioon kuvan
  koon, kuvaajan ympärillä olevat marginaalit, koordinaattiakselien skaalan ja
  y-akselin minimiarvon. Tämä pitäisi muuttaa parempaan muotoon.
* `plotLines(väri,koko,pisteet,kuva)`: Piirtää kuvaan viivaketjun siten, että se
  kulkee listassa `pisteet` lueteltujen, *pikselikoordinaateissa* esitettyjen
  pisteiden kautta. Sopii esimerkiksi funktion lineaariseen interpolointiin.
* `plotSpikes(väri,viivakoko,pistekoko,y0,pisteet,kuva)`: Piirtää kuvaan joukon
  pystysuoria viivoja, jotka alkavat korkeudelta `y0` ja päättyvät pisteeseen
  korkeudella `y` joka ilmoitetaan pareissa `pisteet = [(x,y)]`. Viivan leveys
  ja pisteen koko voidaan valita.
* `plotRects(väri,koko,nelikulmiot,kuva)`: Piirtää värikuvan päälle
  nelikulmioita käyttäen annettua viivan kokoa. Koko `0` tarkoittaa umpinaista
  nelikulmiota, positiivinen koko avonaista nelikulmiota jonka reuna piirretään.
  Nelikulmiot annetaan muodossa `[((Int,Int),(Int,Int))]`{.haskell} missä
  ensimmäinen pari on nelikulmion vasen ylänurkka ja jälkimmäinen pari on
  nelikulmion leveys ja korkeus.
* `plotCircles(väri,koko,ympyrät,kuva)`: Piirtää värikuvan päälle ympyröitä
  käyttäen annettua viivan kokoa. Koko `0` tarkoittaa umpinaista ympyrää,
  positiivinen koko avonaista ympyrää jonka reuna piirretään. Ympyrät annetaan
  muodossa `[((Int,Int),Int)]`{.haskell} missä ensimmäinen pari on ympyrän
  keskipiste ja jälkimmäinen arvo on ympyrän säde.
* `plotHistogram(väri,marginaali,histogrammi,kuva)`: Piirtää värikuvan päälle
  histogrammin noudattaen annettuja marginaaleja. Histogrammi skaalataan
  automaattisesti kuvaan sopivaksi. Histogrammi annetaan muodossa
  `[(Float,Float)]`{.haskell} missä parin ensimmäinen luku vastaa arvoa
  histogrammin kyseisen lokeron *alarajalla* ja toinen luku on *todennäköisyys*
  jolla pikselin arvo sijoittuu kyseiseen lokeroon (eli luku väliltä $[0,1]$).
* `pointsToRects(säde,pisteet)`: Muodostaa listasta pisteitä listan neliöitä,
  joilla on annettu säde. Sopii `collectPoints`-funktion palauttamien pisteiden
  piirtämiseen. Lopputulos voidaan syöttää `plotRects`-funktiolle.
* `pointsToCircles(säde,pisteet)`: Muodostaa listasta pisteitä listan ympyröitä,
  joilla on annettu säde. Sopii `collectPoints`-funktion palauttamien pisteiden
  piirtämiseen. Lopputulos voidaan syöttää `plotCircles`-funktiolle.

### Satunnaisfunktiot

Toisinaan on tarpeen satunnaistaa asioita, kuten esimerkiksi korruptoida
signaaleja ja kuvia tai vaikkapa siirrellä kohteen osia hieman eri paikkoihin.
Tätä varten on apufunktioita, joilla voi generoida tasajakautuneita tai
Gaussisesti jakautuneita satunnaislukuja tai suoraan korruptoida lukuarvoja.

* `corruptSignalWithGaussian(sigma,signaali)`: Ottaa listan $(x,f(x))$-pareja ja
  palauttaa uuden listan jossa $x$:n arvot ovat ennallaan, mutta $f(x)$:n arvot
  on korruptoitu lisäämällä niihin Gaussisesti jakautuneita satunnaislukuja,
  joiden keskiarvo on $0$ ja keskihajonta on `sigma`.
* `corruptListWithGaussian(sigma,lista)`: Ottaa listan `[Float]`{.haskell} ja
  palauttaa uuden listan jossa kaikki arvot on korruptoitu lisäämällä niihin
  Gaussisesti jakautuneita satunnaislukuja, joiden keskiarvo on $0$ ja
  keskihajonta on `sigma`.
* `corruptPairsWithGaussian(sigma,parit)`: Ottaa listan pareja
  `[(Float,Float)]`{.haskell} ja palauttaa uuden listan jossa kaikkien parien
  molemmat arvot on korruptoitu lisäämällä niihin Gaussisesti jakautuneita
  satunnaislukuja, joiden keskiarvo on $0$ ja keskihajonta on `sigma`.
* `getGaussianVector(sigma,määrä)`: Palauttaa listan Gaussisesti jakautuneita
  satunnaislukuja, joiden keskiarvo on $0$ ja keskihajonta on `sigma`.
* `getGaussianVectorSeeded(seed,sigma,määrä)`: Palauttaa listan Gaussisesti
  jakautuneita satunnaislukuja, joiden keskiarvo on $0$ ja keskihajonta on
  `sigma`. Satunnaisgeneraattorin seed-arvo voidaan antaa. Sopii tilanteisiin,
  joissa tarvitaan satunnaistettuja mutta toistettavia tuloksia: samalla
  seed-arvolla tuloksena on aina sama lista satunnaislukuja.
* `getUniformVector(alaraja,yläraja,määrä)`: Palauttaa listan tasajakautuneita
  satunnaislukuja annetulta väliltä.
* `getUniformVectorSeeded(seed,alaraja,yläraja,määrä)`: Palauttaa listan
  tasajakautuneita satunnaislukuja annetulta väliltä. Satunnaisgeneraattorin
  seed-arvo voidaan antaa. Sopii tilanteisiin, joissa tarvitaan satunnaistettuja
  mutta toistettavia tuloksia: samalla seed-arvolla tuloksena on aina sama lista
  satunnaislukuja.

### Listojen käsittelyfunktiot

* `forEach`: Käy listan läpi ja palauttaa uuden siten, että jokaista
    alkiota on muutettu jollain funktiolla. Esim.

    ~~~{.haskell}
    lista = [1,2,3,4]
    tuplattuLista = forEach(lista
                           ,\alkio -> alkio*2)
    ~~~

    Huomaa, syntaksi `\<muuttuja> -> <lauseke>`. Sillä määritellään
    nimettömiä funktioita ja se on hyödyllinen esimerkiksi silloin,
    kun suoritettava operaatio on liian lyhyt ansaitakseen uuden
    nimen. Voit kuitenkin kirjoittaa edellisen myös näin:

    ~~~{.haskell}
    lista = [1,2,3,4]
    kerroKahdella(x) = x*2
    tuplattuLista = forEach(lista,kerroKahdella)
    ~~~

* `forEach2`: Sama kuin `forEach`, mutta käy kaksi listaa läpi
    rinnatusten. Esim:

    ~~~{.haskell}
    lista1 = [1,2,3,4]
    lista2 = [1,1,1,1]
    kerrottuLista = forEach2(lista1,lista2
                            ,\alkio1 alkio2 -> alkio1*alkio2)
    ~~~

* `forEach3`: Sama kuin `forEach`, mutta kolmelle listalle.

### Merkkijonojen käsittelyfunktiot

* `show`: Muuttaa arvoja merkkijonoiksi. Esim. `show([1,2,3])`

Huomaa, että merkkijonoja voi käsitellä myös listaoperaatioilla.


