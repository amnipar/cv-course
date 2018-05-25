---
title: Liikkuva kuva ja optinen vuo
author: Matti Eskelinen, Ville Tirronen, Tuomo Rossi
date: 16.4.2018
title-prefix: TIES411
lang: fi-FI
css: style.css
---

# Liikkuva kuva ja optinen vuo {#liike}

Tähän asti olemme käsitelleet vain tilan suhteen näytteistettyjä kuvia, mutta
kuvia voidaan tietysti näytteistää myös ajan suhteen. Tällä tavoin saadaan
tietoa kohteiden liikkeestä, kameran liikkeestä näkymän suhteen, ja muista ajan
myötä tapahtuvista muutoksista näkymässä.

Videokuvaa käsitellään yksittäisinä ajanhetkellä $t$ näytteistettyinä kuvina.
Näistä kuvaruuduista muodostuu kuvavirta. Useimmissa videotallennemuodoissa
kuvia ei tallenneta yksittäin, vaan tiedostoa pakataan tallentamalla
peräkkäisten kuvien välisiä muutoksia. Tallennemuodosta riippuen kuvaa pakataan
tyypillisesti myös tilan suhteen eri tavoin, joten yksittäisissä kuvissa saattaa
esiintyä erilaisia pakkausartefakteja. Jonkinlainen esikäsittely ja suodatus on
aina tarpeen. Esimerkiksi, joissakin tallennemuodoissa käytetään *interlacing*
-nimistä tapaa, jossa kuvasta tallennetaan vain joka toinen rivi. Jos tällainen
videotiedosto puretaan kuvaruuduiksi perumatta *interlacing*-operaatiota,
kuvavirran kuvat sisältävät vaakasuoria raitoja.

Kuvavirran reaaliaikaisessa analysoimisessa haasteena on aikarajoite. Edellinen
kuvaruutu pitää saada analysoitua valmiiksi, ennen kuin seuraava kuva tulee.
Aikaa on siis tyypillisesti vain sekunnin murto-osa kuvaa kohden. Toisaalta
lyhyt aikaväli kuvaruutujen välillä merkitsee sitä, että yleensä muutokset ovat
pieniä ja rajoittuvat pieneen osaan kuvaa. Reaaliaikaiset analyysijärjestelmät
onkin hyvä rakentaa siten, että ne hyödyntävät edellisestä kuvaruudusta saatuja
tuloksia. Tämä ei ole aina yksinkertaista, koska useimmat menetelmät on
rakennettu käsittelemään kokonainen kuva alusta loppuun aloittaen joka kerta
puhtaalta pöydältä.

Kuvan derivaattaa ajan suhteen voidaan arvioida vertailemalla ajanhetkillä $t$
ja $t-1$ näytteistettyjä kuvia. Yksinkertainen tapa päästä alkuun on käyttää
tavanomaista differenssimenetelmällä arvioitua kuvan aikaderivaattaa. Jos
videokuvan ruutu ajanhetkellä $t$ on $I(x,y,t)$,

$$\frac{\partial{(x,y)}}{\partial{t}} = I(x,y,t) - I(x,y,t-1).$$

Tämän tyyppinen derivaatan approksimaatio ei kuitenkaan tuota sellaisia tuloksia
kuin tarvitsemme. Usein tavoitteena on analysoida kuvavirran pikselikohtaisia
muutoksia, mutta ei niinkään sitä, miten kohdassa $(x,y)$ olevan pikselin arvo
muuttuu ajanhetkien $t-1$ ja $t$ välissä, vaan mihin kohdassa $(x,y)$ ollut
pikseli on siirtynyt ajanhetkien $t-1$ ja $t$ välissä.

Differenssimenetelmiä käytettäessä jälkimmäisen kaltainen analyysi onnistuu
hyvin vain silloin, kun näkymässä tapahtuva liike on kuvatasoon projisoituna
korkeintaan yhden (tai muutaman) pikselin suuruinen. Tällöin on mahdollista
tutkia pikselinaapurustoja peräkkäisissä kuvissa ja arvioida, mistä kohdasta
kukin pikseli on siirtynyt. Voidaan toki tutkia myös suurempia, esimerkiksi
5x5-kokoisia pikselinaapurustoja, tai nostaa kuvataajuutta, mutta monissa
sovelluksissa kohteiden liike on liian nopeaa tällä tavoin analysoitavaksi.

Toinen hankaluus yksittäisten pikselien liikkeen analysoimisessa on niinkutsuttu
aukko-ongelma (engl. *aperture problem*): jos pikseli on tasaisella pinnalla,
eli sen ympäristössä tilagradientti on hyvin pieni, sen liikkeestä on vaikea
sanoa yhtään mitään. Jos pikselin ympäristössä on selvä tilagradientti, sen
liikettä voidaan arvioida, mutta ainoastaan gradientin suunnassa.

Käytännössä aukko-ongelma siis tarkoittaa, että jos kuvassa olevaa sileää
reunakäyrää katsotaan pienen aukon läpi, reunan liike on ilmeistä vain, jos se
suuntautuu kohtisuoraan reunan suuntaa vastaan. Toisaalta, jos reuna liikkuu,
aukon läpi katsottuna se näyttää aina liikkuvan täsmälleen kohtisuoraan, koska
mitään muuta vertailukohtaa ei ole ja kohtisuora liike on yksinkertaisin
selitys. Ihmisen näköaisti vaikuttaa pyrkivän tulkitsemaan liikkeen tällaisen
yksinkertaisimman selityksen mukaisesti, eli se pyrkii tekemään järkevältä
tuntuvan arvauksen saadakseen tulkittua moniselitteisen tilanteen.

Aukko-ongelma ratkaistaan yleensä olettamalla kuvassa oleva liike sileäksi.
Käytännössä tämä tarkoittaa sitä, että lähellä toisiaan olevien pikselien
oletetaan liikkuvan samalla tavalla. Selkeästi paikannettavien pikselien, eli
käytännössä nurkkien ja pistemäisten kohteiden, liikkeen perusteella voidaan
päätellä reunoilla ja tasaisilla pinnoilla olevien pikselien liike käyttäen
interpolointia tai ekstrapolointia.

## Optinen vuo

Hyvin tunnettu videokuvalle tehtävä perusoperaatio on optisen vuon (engl.
*optical flow*) laskeminen. Tuloksena on vektorikenttä, joka kuvaa
pikselitasossa tapahtuvan liikkeen nopeutta (engl. *velocity*). Tiheän
vektorikentän (jokaisen pikselin liikettä kuvaavan) muodostaminen on
laskennallisesti raskas operaatio, joten käytännön sovelluksissa liikevektorit
lasketaan esimerkiksi jonkin pistepiirteitä etsivän menetelmän löytämille
pistemäisille kohteille. Tämän harvan vektorikentän avulla voidaan sitten tehdä
päätelmiä näkymässä olevien kohteiden liikkeistä suhteessa toisiinsa ja
suhteessa kameraan, tai kameran liikkeestä suhteessa näkymään.

Joistakin videotiedostomuodoista voi saada luettua tietoa kuvassa tapahtuvasta
liikkeestä. Esimerkiksi jotkin MPEG-tyyppiset tiedostomuodot tallentavat
liikevektorikenttiä, joista voi olla hyötyä tallennettua videota analysoitaessa.
Reaaliaikaisen kuvavirran analysoimisessa näistä ei luonnollisesti ole hyötyä,
ellei kyseessä ole pakattu kuvavirta, jollaisia verkon yli lähetettävät
kuvavirrat yleensä ovat.

Horn-Schunk

Lucas-Kanade

## Liikkeen tunnistaminen

Ehkä yleisimmin käytetty liikkuvan kuvan analysointiratkaisu on liikkeen
tunnistaminen. Esimerkiksi valvontakamerajärjestelmä saattaa
tallentaa kuvia tai lyhyen videopätkän aina silloin, kun havaitsee näkökentässään
liikettä.

Karkeimmillaan liike voidaan tunnistaa vertailemalla vain peräkkäisiä kuvia ja
määrittelemällä kynnysarvo muutoksen suuruudelle (minkä suuruinen pikselin arvon
muutos rekisteröidään, riippuu kohinan määrästä kameran kuvassa) sekä
muuttuneiden pikselien määrälle. Jos riittävän monta pikseliä muuttuu riittävän
paljon, rekisteröidään liike. Tämä luonnollisesti johtaa lukuisiin vääriin
hälytyksiin esimerkiksi valaistuksen muutosten, pilvien varjojen, lintujen,
kaukana ohi ajavien autojen tai muun vastaavan takia.

Perusmenetelmää voidaan parantaa lukuisin eri tavoin. Esimerkiksi kiinteästä
kynnysarvosta pikselin arvon muutokselle päästään eroon keräämällä kameran
kuvavirrasta niinsanottua taustamallia (engl. *background model*). Tämä
tarkoittaa sitä, että kun kamera on asennettu paikalleen, aletaan tallentaa
tietoa jokaisen kamerakuvan pikselin keskiarvosta ja keskihajonnasta.
Valaistuksen vaihtelujen sietokykyä esimerkiksi ulkotiloissa voi parantaa
antamalla mallin vähitellen 'unohtaa' vanhimmat mittaukset painottamalla
uusimpia arvoja enemmän. Näin malli vähitellen 'vaeltaa' tummemmista arvoista
vaaleampiin ja takaisin.

Näkymästä voi luonnollisesti rakennella monin eri tavoin yksinkertaista
taustamallia monipuolisemman. Liikehälytys voitaisiin tehdä esimerkiksi vain
tietyssä kuvan osassa havaitulle liikkeelle, tai vaikka jopa vain tiettyyn
suuntaan etenevälle liikkeelle. Taustamalli voitaisiin myös kouluttaa muistamaan
vuorokaudenajan ja viikonpäivän mukaan vaihtelevat 'normaalit' liikekuviot ja
hälyttämään poikkeavista tapahtumista.

## Kohteen seuraaminen

Ehkä yleisin ongelma liikkuvan kuvan analysoimisessa on kohteen seuraaminen
(engl. *tracking*). Tämä tarkoittaa kuvaruudusta toiseen siirtyvää liikkuvan
kohteen identifiointia. Eli, jos havaitaan liikkuva kohde, ja seuraavassa
kuvaruudussa on sama liikkuva kohde, pyritään identifioimaan uusi havainto
samaksi kuin edellisessä kuvaruudussa. Tämä voi tapahtua käyttämällä kohteen
tunnistavaa luokittelijaa, tai yksinkertaisesti seuraamalla liikkuvan kohteen
liikerataa ja päättelemällä, mikä liikkuvista kohteista on uskottavimmin sama
kuin aiemmissa kuvaruuduissa. Tämä edellyttää jonkinlaista liikemallia.

oletetaan, että liike on koherenttia.

Toisinaan riittää kohteen paikan osoittaminen kuvassa, joskus halutaan myös
määrittää kohteen sijainti ja asento näkymän koordinaatistossa, mikä edellyttää
edellisessä luvussa kuvattuja geometrisia muunnoksia.

mean shift

kalman-suotimet ja partikkelisuotimet
