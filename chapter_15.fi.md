---
title: Luku 15 - Tilastolliset rakennemallit
author: Matti Eskelinen
date: 13.5.2018
title-prefix: TIES411
lang: fi
css: style.css
---

<!--# Tilastolliset rakennemallit-->

Tässä luvussa tutustumme kohteiden rakenteen kuvaamiseen tilastollisesti sekä
monimutkaisten rakenteisten kohteiden tunnistamiseen tilastollisten
rakennemallien avulla. Aiheina muun muassa *deformable templates*, *stochastic
grammars*.

Käytännöllisiä asioita tällä kerralla:

* kokeilemme yksinkertaisia rakennemalleja hankalille versioille
  yksinkertaisista muodoista,
* pohdimme rakennemallien käyttöä merkkien ja ihmisten tunnistamisessa.

Olemme tutkineet kuvia monin eri tavoin ja yrittäneet oppia ymmärtämään,
millä tavoin kuvista voi saada esiin kiinnostavia asioita. Olemme oppineet
löytämään kuvista yhtenäisiä alueita ja reunoja. Olemme myös oppineet, kuinka
yksinkertaisia jäykkiä kappaleita voi tunnistaa kuvista luokittelumenetelmien
avulla. Ymmärrämme kuitenkin, että luokittelumenetelmät eivät välttämättä toimi
kovin hyvin kohteille, joiden muoto, rakenne tai ulkonäkö vaihtelee paljon.
Samoin ymmärrämme, että voi olla hankalaa luokitella kohteita käsitteellisiin
luokkiin, kuten esimerkiksi autot, jos luokan edustajien ulkomuoto vaihtelee
suuresti.

Maailma koostuu kohteista, joilla on selkeästi määriteltävä geometrinen rakenne
tyypillisine piirteineen ja sallittuine vaihteluineen. Ihmiset ovat hyvin
taitavia hahmottamaan kohteiden oleellisen rakenteen. Jo aivan pienet lapset
osaavat piirtää esimerkiksi ihmisen tai auton käyttäen muutamia yksinkertaisia
rakenneosia tavalla, jonka useimmat toiset ihmiset heti tunnistavat. Tässä
luvussa pohdimme kohteiden rakenteen ja rakenteen vaihtelun mallintamista ja
tunnistamista tilastollisten rakennemallien avulla.

## Johdatus tilastollisiin malleihin

Kuvadatan käyttäytymistä on luontevaa mallintaa tilastollisesti. Tämä johtuu
siitä, että kuvat sisältävät huomattavia säännönmukaisuuksia ja säännöllistä
vaihtelua. Lisäksi kuvien tulkinta on huonosti määritelty ongelma (engl.
*ill-posed problem*) joten luotettavien tulosten saaminen edellyttää usein
aiemman tiedon (engl. *prior information*) hyödyntämistä ratkaisujoukon
rajaamiseksi. *Bayesilainen* tilastotiede tarjoaa teoreettisen viitekehyksen
aiemman tiedon mallintamiseen ja käyttämiseen.

Olemme jo aiemmin todenneet, että tilastollisia malleja rakennetaan
*satunnaismuuttujien* avulla, ja että satunnaismuuttujat eivät sisällä
*sattumanvaraisia* vaan *tuntemattomia*, *epävarmoja* arvoja. Olemme
mallintaneet muuttujien arvojoukkoja tilastollisesti todennäköisyysjakaumien
avulla.

Kuten aiemmin todettiin, satunnaismuuttujilla kuvattavat tapahtumat eivät
yleensä ole täysin satunnaisia. Eri tapahtumien välillä saattaa olla
riippuvuuksia, joiden seurauksena tietyt lopputulokset esiintyvät usein yhdessä.
Tästä käytetään nimitystä *tilastollinen riippuvuus* (engl. *statistical
dependence*). Jos kahden muuttujan välillä on tilastollista riippuvuutta, tätä
voidaan kuvata *ehdollisen jakauman* (engl. *conditional distribution*) avulla.
Aiemmin määrittelimme jo merkinnän $P(A \mid B)$, mikä tarkoittaa muuttujan $A$
jakaumaa ehdollistettuna muuttujan $B$ havaituille arvoille. Tämä tarkoittaa
sitä, että muuttujan $A$ arvojen *jakauma* riippuu muuttujan $B$ arvosta, eli
jotkin $A$:n arvot saattavat olla todennäköisempiä kun $B$ saa tiettyjä arvoja
ja epätodennäköisempiä kun $B$ saa joitakin toisia arvoja. Vastaavalla tavalla
voidaan merkitä muuttujien saamien arvojen suhteen. $P(A=a \mid B=b)$ tarkoittaa
muuttujan $A$ arvon $a$ ehdollista todennäköisyyttä kun muuttuja $B$ saa arvon
$b$. Toisinaan merkitään lyhyemmin $P(a \mid b)$.

Jos kahden muuttujan välillä ei ole tilastollista riippuvuutta, niiden sanotaan
olevan *tilastollisesti riippumattomia* (engl. *statistically independent*).
Tämä voidaan todentaa siitä, että ehdollinen todennäköisyys tai ehdollinen
jakauma on sama kuin kahden muuttujan normaali yhdistetty todennäköisyys tai
jakauma. Toisin sanoen, $P(A \mid B) = P(A)P(B)$. Edellisessä luvussa totesimme,
että muuttujien riippuvuussuhteita voidaan mallintaa Bayesin verkkojen avulla.

Tässä vaiheessa on muistutettava siitä, että vaikka puhutaan muuttujan
riippuvuudesta toisen muuttujan saamasta arvosta, tämä ei välttämättä tarkoita
kausaalista syy-seuraussuhdetta. Toisin sanoen, ei voida päätellä että muuttujan
$B$ arvo *aiheuttaisi muutoksen* muuttujan $A$ arvossa, vaan niiden välillä on
vain jonkinlainen *riippuvuus*. Kyseessä voi olla myös kausaalisuhde, mutta
riippuvuuden tai korrelaation perusteella tätä ei voida aukottomasti päätellä.

Todennäköisyyslaskenta ja tilastollinen mallinnus saattaa vaikuttaa mystiseltä
toiminnalta, ja tilastomenetelmien kehittäjät ja puolestapuhujat eivät ole aivan
syyttömiä tällaisen mielikuvan syntymiseen. Matemaattisen täsmällisyyden ihanne
tuottaa melko hankalasti hahmotettavia jakaumia ja malleja, joista saadaan
laskettua hallitusti tarkkoja todennäköisyyksiä. Ihminen ei ole kuitenkaan kovin
taitava arvioimaan *absoluuttisia* todennäköisyyksiä; usein tällaisen arvion
tekeminen ei ole edes mahdollista, sillä kaikki lopputulokseen vaikuttava tieto
ei ole saatavilla. Ihminen osaa kuitenkin arvioida kokemustensa perusteella
*suhteellisia* todennäköisyyksiä melko taitavasti. Tässä materiaalissa pyrimme
muodostamaan intuitiivisia käsityksiä siitä, kuinka kerättyjen havaintojen
perusteella voidaan tehdä luotettavia arvioita suhteellisista
todennäköisyyksistä. Edellisen luvun Bayesilainen luokittelu *uskottavuuden*
perusteella oli ensimmäinen askel tähän suuntaan.

Keskeinen tilastollisten menetelmien kiistakysymys liittyy jakoon
frekventistiseen (engl. *frequentist*) ja Bayesilaiseen tilastotieteeseen.
Frekventistit ovat sitä mieltä, että todennäköisyydestä voidaan puhua vain
tietyn tapahtuman *esiintymistiheytenä* eli *frekvenssinä* (engl. *frequency*)
tietyssä joukossa. Tämä on tuttua lehtien uutisoinneistakin: huolellisesti
suunniteltu tilastollinen koe vaatii kohteena olevan populaation analysointia,
ja luotettava tulos edellyttää tarkasti kontrolloitua *otantaa* tästä
populaatiosta. Kun näin tehdään, voidaan määritellä *luottamusväli* saaduille
tuloksille. Harmi vain, että tulosten järkevyys riippuu suurelta osin
esitetyistä kysymyksistä ja siitä, millä tavalla ihmiset ovat ymmärtäneet ne.

Frekventistejä kauhistuttaa Bayesilaisten tapa käyttää jakaumia ilman
populaatioiden ja otantastrategioiden huomioimista sekä tapa tehdä oletuksia
tuntemattomien suureiden todennäköisyyksistä. Tämä onkin osittain perusteltua;
Bayesilaisilla on tapana tehdä liiankin rohkeita oletuksia tavoitellessaan
matemaattisessa mielessä helposti käsiteltäviä esityksiä. Bayesilainen malli
kuitenkin tarjoaa matemaattisesti perustellun pohjan rationaaliselle uskomusten
muokkaamiselle havaintojen kautta, mihin puolestaan frekventatiivinen malli ei
taivu.

Karkeasti yleistäen voidaan esittää, että frekventistit tutkivat mallia
$P(D \mid H)$, kun taas bayesilaiset tutkivat mallia $P(H \mid D)$. Tässä $D$
tarkoittaa dataa ja $H$ maailman tilaa kuvailevaa hypoteesia. Frekventistit siis
tutkivat ja vertailevat useita erilaisia hypoteeseja suhteessa dataan; heille
maailman tila on vakio, ja data on aina puutteellista ja kohinaista. He pyrkivät
sulkemaan pois ne hypoteesit, joita data tukee vähiten. Bayesilaiset taas
tutkivat havaintodataa ja yrittävät löytää uskottavan mallin selittämään sitä.
Heille maailman tila on tuntematon, ja sen tutkimiseksi on kerättävä dataa.
Datan perusteella voidaan tutkia, kuinka todennäköisiä erilaiset vaihtoehtoiset
mallit ovat.

Erilaiset näkemykset siitä, miten tilastollista päättelyä tehdään, pohjautuvat
erilaisiin tulkintoihin todennäköisyydestä. Frekventistit edustavat tulkintaa,
jossa todennäköisyys tarkoittaa ainoastaan tapahtuman esiintymistiheyttä
suuressa joukossa toistoja. Bayesilaisten puolestaan on ainakin jossakin määrin
hyväksyttävä todennäköisyys henkilökohtaisena uskomuksena tulevan tapahtuman
toteutumismahdollisuudesta.

Ei ole tarkoituksenmukaista pyrkiä ratkaisemaan lopullisesti, mikä
todennäköisyyden tulkinta on 'oikein' tai mikä on ainoa oikea tapa tehdä
tilastollista päättelyä. Molemmilla pääsuunnilla on oma paikkansa ja oma vankka
kannattajajoukkonsa. Todennäköisyyksien kanssa tekemisissä olevien on kuitenkin
syytä ymmärtää eri lähestymistapojen erot ja perustella itselleen, miksi
valitsee tietyn tavan. Jos ajatellaan koneoppimista ja sitä, millä tavalla
tietokoneet voisivat oppia itse tekemään päätöksiä tai arvioimaan asioiden
todennäköisyyksiä, on vaikea sivuuttaa Bayesilaista tilastollista päättelyä.

Kuvitellaan tilanne, jossa tavoitteena on tehdä ohjelma ennustamaan tietyn
tapahtuman lopputulosta. Vaihtoehtoja on kaksi. Ainoa asia, joka havaitaan, on
tapahtuman lopputulos. Pienen pohdinnan jälkeen lienee helppo päätyä siihen
johtopäätökseen, että ohjelman tekemä ratkaisu perustuu uskomukseen. Aluksi ei
tiedetä mitään muuta kuin se, että vaihtoehtoisia lopputuloksia on kaksi.
Rationaalinen etukäteisuskomus ilman aiempaa kokemusta ja parempaa tietoa on,
että molemmat vaihtoehdot ovat yhtä todennäköisiä. Käytetään siis
*priorijakaumaa*, jossa molempien vaihtoehtojen todennäköisyys on $0.5$. Kun
havaitaan todellisia lopputuloksia, voidaan vähitellen päivittää
etukäteisuskomusta havaintojen perusteella. Jos lopputulokset eivät ole täysin
sattumanvaraisia vaan toinen esiintyy useammin, rationaalinen tapa toimia olisi
arvata jokaisella kerralla todennäköisempää vaihtoehtoa.

Tämä tuntuu järkevältä tavalta toimia, jos on pakko tehdä päätöksiä näinkin
epämääräisessä tilanteessa. Kun havaintoaineistoa on kertynyt riittävästi ja eri
lopputulosten frekvenssi voidaan laskea, päätöksenteko muistuttaa
frekventististä tapaa, paitsi että frekvenssejä ei ole laskettu huolella
suunnitellun ja kerätyn otannan perusteella, vaan ainoastaan tehdyistä
havainnoista. Jos käytettävissä ei ole dataa ja otantaa ei ole mahdollista
tehdä, mutta päätös on tehtävä, bayesilainen formulointi tarjoaa keinot tehdä
rationaalisia päätöksiä käytettävissä olevan tiedon perusteella ja päivittää
uskomuksia kun tietoa tulee lisää.

Käytännössä on harvinaista joutua tilanteeseen, jossa on pakko tehdä päätöksiä
lähes satunnaisista tapahtumista ilman mitään muuta tietoa kuin tapahtumien
havaitut lopputulokset. Usein saatavilla on havaintoja muistakin muuttujista
joiden vaikutusta lopputulokseen ja mahdollisia muuttujien välisiä riippuvuuksia
voidaan tutkia. Samoin voidaan tutkia tapahtuman aiempien lopputulosten
vaikutusta seuraavaan havaittavaan lopputulokseen. Näin voidaan huomioida
riippuvuudet eri tekijöiden välillä ja mahdollisesti parantaa ennustetta.

(tähän vielä lisää, ja esimerkkejä myös...)

## Suorien ja käyrien etsiminen

Reunanhakumenetelmät löytävät kuvasta pistemäisiä kohteita, joissa tapahtuu
äkillisiä muutoksia. Näitä pisteitä voidaan ketjuttaa, jolloin saadaan
reunakäyrän pätkiä. Yhtenäisiä reunakäyriä voidaan kuvata erilaisten piirteiden
avulla ja tunnistaa kohteita muodon perusteella. Totesimme kuitenkin aiemmin,
että yhtenäistä reunakäyrää ei aina saada muodostettua, ja monet kohteet
koostuvat useista erillisistä pinnoista joilla on kullakin oma reunakäyränsä.

Ihmiset ovat taitavia tunnistamaan kohteita viivapiirroksista, ja monet ihmiset
osaavat myös luonnostella kohteita tunnistettavasti piirtämällä muutamia
oleellisimpia viivoja. Tällaiset viivaluonnokset muodostuvat fragmenteista,
jotka ovat suoria ja kaarevia viivanpätkiä. Tällaisten palasten avulla voidaan
tunnistaa melko helposti suorakulmaisia ja elliptisiä kohteita, mutta niitä
voidaan myös käyttää monimutkaisempien muotomallien rakentamiseen.

Sen lisäksi, että ihmiset ovat taitavia tunnistamaan kohteita viivapiirrosten
avulla ja muodostamaan kohteista viivapiirroksia, ihmiset osaavat myös
täydentää puutteellisia viivapiirroksia. Eräs tärkeä käyttötarkoitus
reunakäyrien mallintamiselle parametrisoidussa muodossa ja kohteiden
mallintamiselle reunakäyrien kokoelmana on puuttuvien osien täydentäminen. Jotta
tämä voidaan tehdä, pitää olla jonkinlainen käsitys siitä, millaisia eri
kohteiden ääriviivat yleensä ovat: on mallinnettava kohteiden muoto, ääriviivat
ja niiden vaihtelut. Tarvitaan myös jonkinlainen käsitys siitä, millä tavalla
tietynlainen ääriviivan pätkä voisi jatkua: on esitettävä reunakäyrät
parametrisoituina osina, jotta niiden perusteella voitaisiin ekstrapoloida
reunakäyrän jatkumista paikoissa joissa on katkos.

Kuinka sitten voitaisiin etsiä kuvista suoria ja kaarevuudeltaan vakioita
pätkiä? Miten voitaisiin päätellä, minkälaiseen ja kuinka pitkään viivanpätkään
tietty pikseli kuuluu? Pikselinaapuruston perusteella voi tehdä vain arvauksia.
Tarkan vastauksen saaminen vaatisi kaikkien pikseliin yhdistyvien reunapikselien
ketjuttamista ja ketjun seuraamista ylläpitäen useita erilaisia hypoteeseja.
Kuinka näistä hypoteeseista voitaisiin valita paras? Millä tavalla viivanpätkän
parametrisointi ja parhaiden parametrien valinta voitaisiin tehdä helposti
käsiteltävässä muodossa?

### Houghin muunnos

Perinteinen tapa etsiä suoria viivoja tai esimerkiksi ympyröitä kuvista on niin
kutsuttu *Houghin muunnos* (engl. *Hough transform*). Nimessä esiintyvä sana
*muunnos* viittaa siihen, että kuvan pikseleille tehdään muunnos etsittävän
muodon *parametriavaruuteen*. Jokainen tutkittava pikseli ikään kuin *äänestää*
niitä parametreja, joiden mukainen muoto voisi kulkea kyseisen pikselin kautta.
Parametriavaruuteen äänestyksen tuloksena muodostuvat paikalliset maksimit
osoittavat ne parametrien yhdistelmät, jotka saavat kuvasta eniten tukea.

Esimerkiksi suorien viivojen etsiminen tapahtuisi siten, että jokaiselle
reunapikselille lasketaan parametrit, joiden määräämä suora kulkisi kyseisen
pikselin kautta. Pikselin kohdalta laskettua gradienttia voidaan käyttää
rajaamaan suorien joukkoa. Parametriavaruus diskretoidaan taulukoksi, ja pikseli
kasvattaa yhdellä niitä parametreja vastaavia taulukon alkioita, joiden mukainen
suora sopisi kulkemaan kyseisen pikselin kautta.

Suora voidaan periaatteessa parametrisoida kulman ja yhden pisteen avulla.
Helpointa olisi valita se piste, jossa suora leikkaa esimerkiksi y-akselin.
Tässä on kuitenkin hankaluutena se, että pystysuoria viivoja ei pystytä
esittämään. Samoin hyvin jyrkässä kulmassa kulkevat suorat leikkaisivat
y-akselin kaukana kuvatasosta. Parametriavaruudesta tulisi siis hyvin suuri, ja
lisäksi mahdolliset pystysuorat viivat pitäisi käsitellä erikseen. Yleensä onkin
tapana parametrisoida viivat origon kautta kulkevan *normaalivektorin* avulla
polaarikoordinaatteina; viivan parametrit siis osoittavat origosta
kohtisuorassa viivaa vastaan osoittavan vektorin pituuden ja kulman parina
$(r,\theta)$. Kaikki tietyn pisteen kautta kulkevat suorat viivat muodostavat
parametriavaruuteen sinikäyrän. Tietyn viivan yhtälö muuttuu siis muotoon

$$r = x \cos\theta + y \sin\theta.$$

Houghin muunnoksen toteutus on helppoa, ja sillä pystyy löytämään vaikka
yksittäisistä, irrallisista pisteistä koostuvia viivoja. Samalla tavoin voidaan
parametrisoida myös ympyröitä, ellipsejä tai vaikkapa nelikulmaisia tasoja.
Parametriavaruuksista vain tulee hyvin suuria, ja yksinkertainen perusmenetelmä
on hyvin naiivi. Menetelmässä tehdään paljon turhaa työtä, ja suurinta osaa
parametrien arvoista ei tarvita. Lisäksi, jos halutaan etsiä viivojen
päätepisteet, on vielä jälkeenpäin etsittävä ne pikselit jotka sopivat
löydettyjen parametrien mukaisiin viivoihin ja pääteltävä päätepisteet näiden
mukaan.

### Tilastollinen Houghin muunnos

Vaikka Houghin muunnoksessa on haittapuolensa, sen perusidea eli parametrien
etsintä havaintojen mukaan äänestämällä on edelleen paras tapa löytää kuvasta
muotoja. Menetelmää voidaan parantaa käyttämällä parametriavaruuden sijaan
*uskottavuusavaruutta*. On useita erilaisia tilastollisia formulointeja Houghin
muunnokselle, ja niistä ehkä yksinkertaisin perustuu parametrien arvaamiseen
useiden pisteiden perusteella ja arvausten uskottavuuden arviointiin.

Yksinkertainen esimerkki tämäntyyppisestä algoritmista:

* Ylläpidetään listaa viivahypoteeseistä, alustetaan se alussa tyhjäksi.
* Valitaan kuvan reunapikseleistä satunnaisesti kaksi kerrallaan.
* Muodostetaan suora joka kulkee näiden kahden pisteen kautta, tai
  vaihtoehtoisesti jana jonka päätepisteitä nämä kaksi pistettä ovat.
* Tutkitaan onko listassa päällekkäistä tai lähes päällekkäistä suoraa tai
  janaa; jos ei, lisätään uusi suora listaan äänimäärällä yksi. Jos on,
  lisätään kyseisen suoran äänimäärää yhdellä ja päivitetään päätepisteitä jos
  kyseessä on jana.
* Poistetaan tutkitut pikselit; vaihtoehtoisesti voidaan antaa niiden jäädä,
  jolloin samat pikselit saattavat tulla valituiksi useita kertoja ja osallistua
  useiden suorien muodostamiseen.
* Jatketaan kunnes kaikki pikselit on käyty läpi tai tietty määrä hypoteesejä on
  muodostettu; jos tutkittuja pikseleitä ei poisteta joukosta, täytyy asettaa
  hypoteesien määrälle jokin yläraja.
* Hyväksytään ne viivahypoteesit, jotka ovat saaneet riittävän määrän ääniä, tai
  sitten hyväksytään tietty määrä eniten ääniä saaneita hypoteesejä.

Tällaisessa lähestymistavassa siis parametrisoidaan viivoja kahden pisteen
avulla, mutta parhaita hypoteesejä ei etsitä parametriavaruudessa vaan
eräänlaisessa uskottavuusavaruudessa. Hypoteesit ovat sitä uskottavampia, mitä
enemmän ne saavat tukea datasta. Hypoteesejä voidaan äänestää myös painottaen
jonkin etäisyysmitan mukaan: kukin pikselipari voi äänestää useampaa eri
vaihtoehtoa siten, että lähempänä olevia painotetaan enemmän.

Samaan tapaan voidaan etsiä myös ympyröitä tai kaarevia viivanpätkiä. Nämä
voidaan määritellä kolmen pisteen avulla; valitaan satunnaisesti kolme pistettä
ja muodostetaan ympyrä tai ympyrän kaari joka kulkee kaikkien kolmen pisteen
kautta.

Tässä ideassa on edelleen ongelmana se, että ylimääräisiä hypoteeseja tulee
paljon. Jos kuvassa on useampia eri reunanpätkiä, on melko todennäköistä valita
satunnainen pistepari joka ei oikeasti kuulu samaan reunanpätkään. Tämä ongelma
poistuu sillä, että alustavat hypoteesit muodostetaan vain sellaisista
pistepareista, jotka ovat kytköksissä toisiinsa. Tätä varten reunapikselit pitää
ketjuttaa. Seuraavassa esimerkki tällaisesta algoritmista:

* Kuljetaan kunkin reunaketjun päästä päähän.
* Tehdään tietynmittaisia hyppyjä reunakäyrällä ja generoidaan hypoteesi joka
  sopii muodostuvaan pikselipariin.
* Ympyrän kaarien sovittamiseksi voidaan tehdä hyppy kahteen suuntaan ja
  sovittaa ympyrä muodostuvaan pikselikolmikkoon.
* Lasketaan reunakäyrän kunkin pikselin etäisyys muodostettuihin hypoteeseihin.
* Valitaan eniten ääniä saaneet hypoteesit.
* Kukin pikseli yhdistetään lähimpään hypoteesiin ja näin saadaan suorien ja
  kaarien päätepisteet.
* Lopuksi voidaan yrittää yhdistää pilkkoutuneita reunakäyriä etsimällä
  samansuuntaisia tai toisiaan leikkaavia suoranpätkiä tai lähes samalla ympyrän
  kaarella olevia kaarenpätkiä.

Monenlaisia muitakin menetelmiä voidaan kehittää eri tilanteisiin perustuen
näihin ideoihin.

### Vapaamuotoisten kappaleiden etsintä

Hypoteesien äänestämiseen ja uskottavuusavaruuteen perustuvia menetelmiä voidaan
laajentaa lähes minkä tahansa muotojen etsimiseen. Perusidea on sama:
generoidaan hypoteeseja jotka sopivat osaan pikseleistä, äänestetään niitä
hypoteeseja joihin kyseinen pikseli sopisi, ja valitaan sitten eniten ääniä
saaneet hypoteesit.

Ongelmaksi voi muodostua hypoteesien suuri määrä, jos generoidaan naiivilla
tavalla kaikki mahdolliset hypoteesit. Onkin syytä käyttää heuristiikkoja ja
generoida vain riittävän uskottavilta vaikuttavat hypoteesit. Edellä olevat
kaksi tekniikkaa suorien ja kaarien etsimiseksi perustuvat itse asiassa
tällaisiin heuristisiin arvauksiin. Ensimmäisessä ideana on generoida vain ne
hypoteesit, joille löytyy enemmän tukea kuin vain yksi piste: jos generoidaan
suoria pisteparin avulla tai kaari pistekolmikon avulla, lopputuloksena on
vähemmän hypoteeseja joilla kullakin on tukea vähintään kahdelta pisteeltä.
Toisessa tekniikassa ideana on generoida hypoteeseja vain sellaisista pisteistä
jotka liittyvät toisiinsa reunaketjun kautta.

Jos etsitään monimutkaisempia muotoja, kuten monikulmioita, voidaan generoida
hypoteeseja esimerkiksi suorapareista. Hypoteesi voi pitää sisällään karkean
arvion suorakulmiosta jonka sisällä monikulmion arvellaan olevan sekä kulmien
mahdolliset paikat vaihteluväleineen.

## Muovattavat mallit*

Eräs paljon käytetty tapa sovittaa kuviin muotoja ovat niinsanotut *muovattavat
mallit* (engl. *deformable templates*). Näissä kokonaisen kappaleen muoto
määritellään esimerkiksi reunakäyränä, jolle sallitaan jonkin verran vaihtelua.
Tätä *mallia* (*template*) sovitetaan kuvan päälle eri asentoihin ja yritetään
*muovata* (*deform*) sitä esimerkiksi reunoja siirtelemällä siten, että malli
sopii kuvaan.

Muovattavat mallit perustuvat olennaisesti etsintään kappaleen
*konfiguraatioavaruudessa*. Joukko parametreja määrää konfiguraation joka
etsityn kohteen on täytettävä jotta se hyväksytään. Jos mahdollisia kohteita on
useita, jokaiselle määritellään oma konfiguraatio, ja kuvasta etsitään näitä
kaikkia. Parhaiten sopiva kohde valitaan.

On ilmiselvää, että kattava haku konfiguraatioavaruudessa on liian raskas
operaatio muille paitsi yksinkertaisimmille kohteille. Näitä menetelmiä
käytetäänkin usein jonkinlaisen alkuarvauksen kanssa. Esimerkiksi
lääketieteellisissä sovelluksissa ihminen voi merkitä etsityn kohteen
summittaisen paikan ja asennon, minkä jälkeen optimoidaan parametrit lähtien
liikkeelle tästä alkuarvauksesta.

Muovattavia malleja voitaisiin yhdistää myös heuristisiin hakuihin edellisen
luvun mallin mukaan. Voitaisiin generoida hypoteeseja löydettyjen
reunafragmenttiparien tai -kolmikoiden perusteella, ja käyttää parhaita
hypoteeseja alkuarvauksina tarkan tuloksen löytämiseksi.

(tähän tulee yksinkertainen esimerkki myöhemmin)

## Tunnistaminen rakenteen perusteella*

Tähän mennessä olemme tutustuneet erilaisiin tapoihin tunnistaa kohteita niiden
ulkonäön tai karkean muodon perusteella. Monet todellisen maailman kohteet ovat
kuitenkin kolmiulotteisia, ja niiden ulkonäkö ja muoto saattaa olla hyvinkin
erilainen eri kuvakulmista nähtynä. Myös periaatteessa kaksiulotteisissa
kohteissa saattaa olla useita muotovariantteja. Luokittelumenetelmiä
käytettäessä kaikki eri variantit pitäisi mahdollisesti tunnistaa erikseen, eli
kouluttaa oma luokittelija kullekin variantille. Muovattavia malleja
käytettäessä pitäisi vastaavasti tehdä oma malli kullekin variantille. Tämä käy
hyvin pian turhan monimutkaiseksi. Olisikin hyvä löytää jokin tapa formuloida
tällaiset ulkonäön vaihtelut yhteen ja samaan malliin.

Tutkitaan seuraavaksi kirjainmerkkejä yksinkertaisena esimerkkinä kohteista,
joiden luokittelu perustuu olennaisesti rakenteeseen ja rakenneosien
keskinäiseen *konfiguraatioon*. Painettuja merkkejä saadaan toki tunnistettua
helposti myös niiden muodostamien pikselikokoelmien perusteella. Tehtävä
kuitenkin vaikeutuu olennaisesti, jos saman sovelluksen pitäisi tunnistaa
useilla eri kirjasintyyleillä kirjoitettuja merkkejä, jos merkit ovat pahasti
vääristyneitä tai sijaitsevat ylimääräisten häiritsevien kohteiden joukossa, tai
jos merkit voivat olla kursiivilla käsin kirjoitettuja. Samalla merkillä voi
olla hyvin erilainen ulkomuoto erilaisissa tilanteissa, joten ulkomuodon
perusteella laskettujen piirteiden avulla merkkejä ei välttämättä saada
tunnistettua oikein eri tilanteissa.

Kirjoitusmerkkien olennaiset erottelevat tunnuspiirteet liittyvät niiden
rakenneosien välisiin suhteisiin: tietyssä merkissä on yleensä tietynlaiset
viivat tietyissa suhteissa toisiinsa. Jokaisella merkillä voi olla useita
vaihtoehtoisia konfiguraatioita, ja kunkin konfiguraation rakenneosien
keskinäisissä suhteissa voi olla jonkin verran vaihtelua. Millä tavalla
tällaisia rakenneosien konfiguraatioita pitäisi kuvailla, ja miten kohteita
voisi tunnistaa niiden perusteella?

### Kielioppimallit*

Tietyn kirjoitusmerkin tai muun rakenteisen kohteen kuvaileva malli sisältää
kahdenlaisia elementtejä:

a) yksinkertaisempien rakenne-elementtien *yhdistelmiä*
b) *vaihtoehtoisia* elementtejä

Näitä voidaan koota *hierarkiaksi* siten, että yksinkertaisista perusosista,
kuten suorista ja kaarevista viivanpätkistä, kootaan yhä monimutkaisempia
yhdistelmiä. Tämä hierarkia voidaan kuvata JA-TAI-puun (engl. *AND-OR tree*)
avulla. JA-solmut liittävät toisiinsa alemman tason osia, jotka esiintyvät
*aina* yhdessä tietyssä osakonfiguraatiossa. TAI-solmut liittävät toisiinsa
vaihtoehtoisia konfiguraatioita kokonaiselle kohteelle tai sen osalle. Tällainen
hierarkinen puumainen rakenne voidaan kuvata *yhteydettömänä* eli
*kontekstittomana kielioppina* (engl. *Context-Free Grammar*, CFG). Koska
rakenteessa on vaihtoehtoisia osia jotka esiintyvät eri todennäköisyyksillä,
kieliopin säännöt on varustettava todennäköisyysjakaumin. Tällainen kielioppi on
nimeltään *tilastollinen yhteydetön kielioppi* (engl. *Probabilistic
Context-Free Grammar, PCFG).

Kun kuvasta etsittävä asia on kuvattu kielioppina, voidaan puhua kuvan
*jäsentämisestä* (engl. *image parsing*). Tämä pitää sisällään toisaalta kuvan
tai sen osan (esimerkiksi kuvasta löydetyn reunafragmenttien kokoelman)
*hyväksymisen* eli sen toteamisen, että kyseinen kuva voitaisiin johtaa
kyseisestä kieliopista soveltamalla sen sääntöjä peräjälkeen; ja toisaalta
kuvan *jäsennyksen* löytämisen, eli sellaisen sääntöjen jonon löytämisen jolla
kyseinen kuva voidaan johtaa.

Puurakenteisten kielioppien jäsentäminen on suhteellisen hyvin ymmärretty
ongelma. Myös tilastollisia puurakenteisia kielioppeja, eli yhteydettömiä
kielioppeja, pystytään jäsentämään käyttäen dynaamista optimointia (engl.
*Dynamic Programming*, DP). Valitettavasti puurakenteiset kieliopit ovat kuvien
tapauksessa suhteellisen rajoittuneita. Niillä pystytään kuvailemaan lähinnä
osien kokoelmia, ei osien välisiä keskinäisiä konfiguraatioita. Kun osien
väliset suhteet kuvaillaan, syntyy graafimuotoinen kielioppi, joka on
*yhteysherkkä* (engl. *context-sensitive grammar*). Tällaisten kielioppien
jäsentäminen on NP-täydellinen ongelma, koska tutkittavan konfiguraatioavaruuden
koko räjähtää eksponentiaalisesti. Kuvien jäsentämisessä onkin yleensä
käytettävä erilaisia heuristisia hakuja.

(tähän tulee enemmän asiaa ja esimerkkejä myöhemmin)

## Tehtäviä

Mietitään millaisia malleja omiin kuviin voisi soveltaa ja hahmotellaann niitä.
