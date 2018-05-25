---
title: Luku 5 - Värit ja valon aistiminen
author: Matti Eskelinen
date: 18.2.2018
title-prefix: TIES411
lang: fi
css: style.css
---

# Värit ja valon aistiminen {#värit}

Tähän mennessä olemme puhuneet lähinnä harmaasävykuvista. Oikeissakin
konenäkösovelluksissa tyydytään usein jättämään väri-informaatio huomioimatta,
konvertoimaan värikuvat harmaasävykuviksi ja tulkitsemaan kohteita vain niiden
muodon ja pintarakenteen perusteella. Tämä helpottaa ongelman käsittelyä, sillä
väreihin liittyy omat haasteensa. Monissa sovelluksissa väreistä kuitenkin saa
olennaisen tärkeää lisäinformaatiota, joten on syytä oppia käsittelemään myös
värikuvia.

Tässä luvussa paneudutaan värien ja väriaistimuksen lisäksi yleisesti valon
havaitsemiseen, jonka ymmärtäminen voi olla hyödyksi myös mustavalkokuvia
tutkittaessa.

## Mitä väri on?

Mitään sellaista asiaa kuin väri, sellaisena kuin ihmiset sen ymmärtävät, ei
oikeastaan ole olemassa luonnossa. Väri on jotakin, mitä me ihmiset liitämme
ympärillä olevaan maailmaan ja siinä oleviin kohteisiin, ja jonka me koemme
yksilöllisillä tavoilla. Väri on ihmisen vaste tietystä aallonpituusjakaumasta
koostuvaan valoon, ja valo taas on vain sähkömagneettista säteilyä kaiken muun
säteilyn joukossa. Aistimus väristä syntyy ihmisen silmissä ja aivoissa, ja sen
takia väri on hyvin henkilökohtainen asia. Jokainen mieltää värit omalla
tavallaan, ja jotkut eivät edes pysty näkemään värejä samalla lailla kuin
toiset. Toiset eläimet puolestaan aistivat ja mieltävät valoa ja sen värejä
hyvin toisenlaisilla tavoilla kuin me ihmiset. Tämä kaikki tekee valosta ja
väristä kiehtovan ilmiön, jolla on oma merkityksensä kaikille ihmisille.

## Värien fysiikkaa

Valo on sähkömagneettista säteilyä, jonka aallonpituus on karkeasti välillä
280-1000 nanometriä. Kuvassa \ref{fig:visible_spectrum} on kaavakuva tästä
aallonpituusalueesta. Sen ääripäissä olevaa valoa, ultraviolettia ja
infrapunaista, ihminen ei pysty näkemään. Monokromaattiseksi valoksi sanotaan
sellaista säteilyä, joka koostuu yhdestä ainoasta aallonpituudesta. Tällaista
valoa esiintyy kuitenkin hyvin harvoin, mm. laserissa, ja luonnossa ei
käytännössä ollenkaan. Yleensä valo onkin *spektriyhdistelmä* lukuisista
aallonpituuksista, ja eri aallonpituuksien hallitsevuus valossa vaihtelee; juuri
tämä aallonpituuksien yhdistelmä ja sen koostumuksen vaihtelu synnytää erilaiset
väriaistimukset.

![Ihmisen havaitsema sähkömagneettisen spektrin osa. Lähde: Wikimedia[^spectrum].\label{fig:spectrum}](images/640px-Linear_visible_spectrum.svg.png){ .centered }

[^spectrum]: https://commons.wikimedia.org/wiki/File:Linear_visible_spectrum.svg

Väri on aistimus, joka syntyy yhdistelmänä valonlähteestä, katseltavasta
kohteesta ja aistijasta. Mitä tahansa näistä vaihdettaessa värin aistimus
muuttuu. Valonlähde, joka voi olla aurinko, hehkulamppu, loisteputki tai muu
sellainen, tuottaa valoa eli emittoi sähkömagneettista säteilyä. Eri
valonlähteiden tuottama valo on erilaista, eli niiden *spektri* sisältää
erilaisen yhdistelmän valon eri aallonpituuksia. Valo etenee
maailmankaikkeudessa ja törmää erilaisiin kohteisiin. Kohteet imevät eli
*absorboivat* osan valosta ja osa heijastuu eli *siroaa*; erilaiset pinnat
heijastavat saman valonlähteen valoa eri tavoin, ja eri valonlähteiden valo
heijastuu samasta pinnasta eri tavoin. Kohteet mielletään jonkin tietyn
värisiksi sen takia, että yleensä kappaleet muun muassa pintarakenteensa
perusteella imevät tietyt aallonpituudet ja heijastavat loput. Heijastuvien
aallonpituuksien spektriyhdistelmä määrää kappaleen värin.

Lopuksi aistimus väristä syntyy havainnoijan silmissä ja aivoissa. Eri eliöt
aistivat värejä eri tavoin ja eri aallonpituuksilla, ja jotkin eliöt eivät näe
värejä ollenkaan. Eri ihmisyksilötkin saattavat nähdä värit eri tavoin, ja
lopuksi vielä värit mielletään eri tavoin riippuen kulttuurista ja
henkilökohtaisista kokemuksista ja mieltymyksistä. Esimerkiksi tietyillä
väreillä saattaa olla tietynlaista symboliikkaa tietyn kulttuurin edustajille
perinteisten käsitysten vuoksi, tai jollekin yksittäiselle ihmiselle hänen
henkilökohtaisen historiansa takia.

Kaiken tämä pohjalta voidaan sanoa, että vaikka värien käsite pohjautuu
fysiikkaan ja fysiologiaan, se on paljon enemmän kuin pelkkä luonnonilmiö.

Tietyissä erikoissovelluksissa, kuten mikroskopiassa tai joissakin
spektrikuvannussovelluksissa, tutkitaan kohteen läpi ohjattua valoa eikä kohteen
pinnasta heijastunutta valoa. Tällöin havaintoon vaikuttavat kohteen
valonläpäisy- eli transmittanssiominaisuudet. Tällä kurssilla keskitymme
kuitenkin lähinnä heijastuneen valon tutkimiseen.

## Päävärit

Koulusta on varmasti jokaiselle tuttu päävärien käsite. Ne ovat värejä, joita
sekoittamalla saadaan muodostettua toisia värejä. Kuvaamataidon tunneilla
käytettiin punaisia, sinisiä ja keltaisia vesivärinappeja ja niistä pystyttiin
sekoittamaan kaikki värit (ehkä mustaa lukuunottamatta) vähän harjoittelemalla,
tai ainakin siltä tuntui. Joka tapauksessa, tästä saadaan tärkeä havainto siitä,
että värejä voidaan sekoittaa keskenään ja saada näin uusia värejä.

## Lisäys- ja vähennysvärit

Punaista, sinistä ja keltaista käytettiin siis koulussa *pääväreinä*. Oikeastaan
päävärejä on kuitenkin kahdenlaisia. Niinsanotut lisäysvärit tai *primaariset*
päävärit ovat punainen, sininen ja vihreä. Nimi lisäysväri johtuu siitä, että ne
tavallaan lisäävät aistimukseen jotain; kun kappaletta valaistaan punaisilla,
sinisillä ja vihreillä valoilla, ne tuovat lisää värejä kappaleen heijastamaan
valoon. Kaikkia kolmea yhdistämällä saadaan valkoista valoa.

Niinsanotut vähennysvärit taas ovat syaani, magenta ja keltainen. Niitä saadaan
yhdistämällä punaista, vihreää ja sinistä; esimerkiksi syaania saadaan
yhdistämällä sinistä ja vihreää. Niitä kutsutaan myös *sekundaarisiksi*
pääväreiksi juuri sen takia, että ne saadaan muodostettua primaarisia päävärejä
yhdistelemällä. Vähennysväreiksi niitä sanotaan siksi, että jos jokin kappale
maalataan syaanilla, magentalla ja keltaisella maalilla, ne poistavat kappaleen
heijastamasta valosta värejä. Esimerkiksi jos kappale maalataan syaanilla
maalilla, maalin sisältämä pigmentti poistaa heijastuvasta valosta keltaisen,
jolloin jos kappaletta katsotaan valkoisessa valossa, se näyttää syaanilta.
Kaikkia päävärejä yhdistettäessä poistetaan luonnollisesti kaikki väri, jolloin
vain vähän valoa heijastuu takaisin, jolloin kappale näyttää mustalta. Tämä
johtuu kontrastista kirkkaampien alueiden kanssa; mikään pigmentti ei ime
täydellisesti kaikkea siihen osuvaa valoa, joten täydellistä mustaa väriä ei ole
olemassa.

Kuten edellä olleesta kuvaamataitoesimerkistä huomattiin, pääväreinä voidaan
käyttää mitä tahansa värejä, ja kaikkia värejä, sekä lisäys- että
vähennysvärejä, yhdistämällä saadaan uusia värejä. Muistamme, että
vesivärinapeissa käytettiin usein sellaisia värejä kuin krominkeltainen,
ultramariininsininen ja karmiininpunainen varsinaisten päävärien eli syaanin,
magentan ja keltaisen sijaan. Viralliset, puhtaat päävärit ovat kuitenkin
punainen, sininen ja vihreä sekä syaani, magenta ja keltainen. Huomaamme myös,
että tässä värejä käsiteltiin erikseen valonlähteen ja pintamateriaalin
näkökulmasta. Näillä on luonnollisesti myös yhteisvaikutus: jos syaanin väristä
kappaletta valaistaan vihreällä valolla, se näyttää siniseltä. Edelleen, jos
kappaletta katsoo esimerkiksi punavihervärisokea henkilö, hänen kokemuksensa
kappaleen väristä on toisenlainen kuin värit normaalisti näkevällä henkilöllä.

## Värien fysiologiaa

Meidän ymmärtämämme värien käsite pohjautuu pitkälti ihmisen tapaan aistia
väriä. Ihmisen silmissä on kahdenlaisia valolle herkkiä soluja, joita sanotaan
sauvoiksi ja tapeiksi. Niiden tehtävät ovat erilaiset. Sauvasoluissa on valolle
herkkää proteiinia, ja ne aistivat valon kirkkautta. Sauvasoluja on
huomattavasti enemmän kuin tappeja, ja ne ovat keskittyneet verkkokalvon
reunoille; keskellä niitä ei ole ollenkaan. Sauvat vastaavat ääreisnäöstä,
liikkeen havainnoinnista ja pimeänäöstä (engl. *scotopic vision*). Vastakohta
tälle on päivänäkö (engl. *photopic vision*).

Päivänäöstä ja värinäöstä huolehtivat tappisolut, joita on kolmenlaisia. Tapit
ovat keskittyneet näkökentän keskikohtaan, reunoilla niitä on hyvin vähän. Tapit
ovat parempia havaitsemaan pieniä yksityiskohtia, ja siksi ne vastaavat tarkasta
näöstä, mutta ne eivät ole yhtä herkkiä valon kirkkauden muutoksille kuin
sauvat. Kolmenlaiset tappisolut sisältävät kolmenlaista pigmenttiä, joista
jokainen on herkkä tietyn taajuiselle valolle. Tappeja kutsutaan joskus
punaisiksi, vihreiksi ja sinisiksi tapeiksi sen takia, että nämä ovat valon
päävärit ja ihmisen ajatellaan aistivan niitä.

Kuitenkin, tappien aistimien spektrien huippukohdat eivät edes ole punaisessa,
vihreässä ja sinisessä, ja lisäksi myös kukin tapeista aistii värejä laajalla
aallonpituuskaistalla. Siksi suositellaan puhuttavan lyhyen, keskipitkän ja
pitkän aallonpituusalueen tapeista. Kuvassa \ref{fig:conesens} on esitettynä
tappisolujen aistimat aallonpituusalueet. Eri tappityyppejä ei ole saman verran,
vaan niiden suhde on kutakuinkin 40:20:1, eli lyhyen aallonpituuden tappeja on
vähiten ja pitkän eniten. Lyhyen aallonpituuden tapit ovat kuitenkin
huomattavasti herkempiä kuin pitkän aallonpituuden tapit. Kunkin tappijoukon
vaikutus värinäössä onkin yhtä suuri, huolimatta lukumäärien suuresta erosta.

![Tappisolujen herkkyysalueet. Lähde: Wikimedia[^conesens].\label{fig:conesens}](images/635px-Cones_SMJ2_E.svg.png){ .centered }

[^conesens]: <https://commons.wikimedia.org/wiki/File:Cones_SMJ2_E.svg>

Voidaan siis ajatella, että ihmisen verkkokalvo näytteistää valon värin kolmelle
kanavalle, ja väriaistimus syntyy näiden kanavien yhteisvaikutuksesta. Kanavat
menevät osittain päällekkäin, mutta niiden huippukohdat ovat eri paikoissa.
Näiden kolmen kanavan ja sauvasolujen aistiman valon intensiteetin sisältämä
tieto koodataan jollakin lailla ennen kuin se viedään aivojen käsiteltäväksi.
Vieläkään ei tiedetä varmuudella, miten aivot käsittelevät värejä, mutta
erilaisia teorioita on olemassa. Toisen teorian mukaan värit koodataan kolmeen
kanavaan siten, että punainen, vihreä ja sininen ovat kukin omana kanavanaan ja
valoisuus liitetään mukaan näihin kanaviin. Toisen teorian, niin kutsutun
vastaväriteorian mukaan olisi puna-vihreä, sini-keltainen ja musta-valkoinen
kanava. Kumpikin näistä teorioista selittää joitakin kokeellisia havaintoja
ihmisen näköaistimuksesta. Totuus lienee jonkinlainen yhdistelmä näistä kahdesta
teoriasta.

Sauvasoluja on enemmän kuin tappeja, ja sen takia ihminen on herkempi valon
kirkkauden kuin värin vaihtelulle. Tätä käytetään hyödyksi joissakin kuvan
pakkausmenetelmissä, jossa valon kirkkausaste ja värisävy tallennetaan erikseen:
Värisävyä pystytään pakkaamaan tiiviimmin, koska silmä ei huomaa yhtä herkästi
eroja värisävyssä kuin kirkkaudessa.

Kolme tappisolutyyppiä aistii siis eri aallonpituuskaistaa. Näiden solujen
aistimusten yhdistelmänä silmä pystyy erottamaan noin seitsemän miljoonaa eri
värisävyä, mutta nämä värit eivät ole jakautuneet tasaisesti näkyvän valon
spektrille. Tietyillä spektrin osilla ihmisen erottelukyky on suurempi kuin
toisaalla. Tämä epätasainen jakauma johtuu pääasiassa siitä, että aivojen tapa
koodata värejä on epälineaarinen, joten vaikka värit aistitaan lineaarisesti,
niitä käsitellään ja ne mielletään epälineaarisesti. Tämän takia tietokoneissa
käytetään 16 miljoonaa väriä: näyttölaitteissa värit ovat jakautuneet tasaisesti
koko spektrille, joten värejä tarvitaan enemmäin kuin 7 miljoonaa jotta
ihmishavainnoija ei havaitsisi hyppäyksiä värisävyjen välillä.

## Värien teoriaa

Väri ei siis ole pelkästään kappaleiden ominaisuus, vaan viime kädessä ihmisen
hermoston signaaleja. Tämän vuoksi värien teoria pohjautuu kiinteästi ihmisen
näköaistimuksen fysiologiaan ja on lähtökohdiltaan hiukan häilyvä ja
henkilökohtainen. Näiden lähtökohtaisten vaikeuksien poistamiseksi on tehty
paljon työtä.

*Commission Internationale de l'Eclairage* (CIE) eli kansainvälinen
valaistuskomissio on vuosikymmenien ajan tutkinut ja määritellyt ihmisen
värinäköä. Poistaakseen valaistuksesta ja havainnoijasta aiheutuvat vaihtelut,
CIE on määritellyt standardivalaisimet ja standardihavainnoijat, joiden avulla
värit, esimerkiksi maalien pigmentit, määritellään.

Standardivalaisimet perustuvat tietyn lämpöisen täydellisen mustan kappaleen
lähettämään säteilyyn. D50 tarkoittaa 5000 Kelvinin lämpöisen kappaleen
lähettämää valoa, joka on kellertävän valkoinen, ja D65 puolestaan 6500 Kelvinin
lämpöisen kappaleen lähettämää valoa, joka vastaavasti on sinertävän valkoinen.
Värien lämpötilalla tarkoitetaankin sen mustan kappaleen lämpötilaa, jonka
hehkun valaisemana värien voidaan ajatella syntyneen.

Standardihavainnoijia on kahdenlaisia, ja ne vastaavat ihmisen näköhavaintoa 2
asteen ja 10 asteen näkökentällä. Näistä jatkossa enemmän.

Edellä selvitettiin, kuinka väri on sähkömagneettistä säteilyä tietyllä
aallonpituusalueella. Väri voidaankin pelkistää spektrijakaumafunktioksi (engl.
*spectral power distribution*, SPD), joka kertoo säteilyn aallonpituuksien
jakauman valossa. Värien mittaamiseen voidaan käyttää erityistä laitetta,
spektrofotometriä. Se mittaa näytteen heijastaman spektrijakauman, näytteistäen
sen esimerkiksi 5, 2 tai 1 nanometrin välein. On muistettava, että jakauma
riippuu valaistusolosuhteista. Siksi näytteen valaisuun pitää käyttää jotakin
standardivalaisinta, yleensä D50 tai D65.

Kuten edellä todettiin, ihmisen värinäkö pohjautuu tappisoluihin. Tappien
toiminta voidaan pelkistää todennäköisyysfunktioksi fotonien aallonpituuden
suhteen; tietyllä tappityypillä on tietty todennäköisyys absorboida fotoni,
jolla on tietty energia ja siten aallonpituus. Väriaistimuksen kannalta fotonin
energialla ei ole merkitystä: väriaistimus syntyy sen perusteella, kuinka monta
fotonia kukin tappisolutyyppi absorboi aikayksikössä. Tämä kertoo osaltaan
siitä, kuinka abstrakti käsite värinäkö on, ja että värit eivät todellakaan ole
viime kädessä muuta kuin aivoissa syntyvä vaste tietynlaiseen säteilyyn.

Edellä väri määriteltiin spektrijakaumafunktioksi sähkömagneettisesta
säteilystä, vaikka tarkkaan ottaen väri on aivoissa syntyvä vaste kyseiseen
jakaumaan. Vaste on kuitenkin hyvin yksilöllinen asia, joten jatkossa puhumme
väristä spektrijakaumana. Standardivalaisimen valossa standardihavainnoija näkee
jakauman kuitenkin aina samalla tavalla.

Ihmisen silmässä on siis kolmenlaisia tappisoluja. Tästä juontuu niin kutsuttu
tristimulus-teoria. Sen mukaan kaikki värit voidaan esittää kolmen komponentin
eli stimuluksen avulla. Nämä kolme komponenttia vastaavat vektoria
kolmiulotteisessa avaruudessa, jota sanotaan tristimulus-avaruudeksi. Tällainen
vektori voidaan tietysti esittää hyvin monella eri tavalla, riippuen käytetyistä
kantavektoreista, ja niinpä onkin olemassa monia erilaisia viittaustapoja
(engl. *references*) tristimulus-avaruuteen. Näitä viittaustapoja kutsutaan
*värimalleiksi* tai *väriavaruuksiksi*, ja niistä kerrotaan myöhemmin lisää.

## Tristimulus-viittaukset

Edellä esitetyn pohjalta määritellään väri seuraavasti. Olkoon $VS$ (sanoista
*Visual Spectrum* eli näkäaistimuksen havaitsema spektri) ihmissilmän aistima
sähkömagneettisen spektrin osa (siis osapuilleen 380nm - 780nm). $S(\lambda)$
olkoon tällöin spektrijakaumafunktio, joka kertoo valon intensiteetin
aallonpituudella $\lambda \in VS$. Olkoot sitten $A$, $B$ ja $C$ kolme
komponenttia, joita käytetään viittaamaan tristimulus-avaruuteen. Määritellään
funktiot $a(\lambda)$, $b(\lambda)$ ja $c(\lambda)$ siten, että ne kertovat
kyseisen komponentin arvon aallonpituudella $\lambda$. Tällaisia funktioita
kutsutaan värin sovitusfunktioiksi (engl. *color matching functions*).

Nyt näiden kolmen viittauskomponentin arvot spektrillä $S$ saadaan integroimalla
kukin sovitusfunktio näkyvän spektrin yli:

$$\begin{aligned}
A &= \int\limits_{VS} a\left(\lambda\right) S\left(\lambda\right) \, d\lambda \\
B &= \int\limits_{VS} b\left(\lambda\right) S\left(\lambda\right) \, d\lambda \\
C &= \int\limits_{VS} c\left(\lambda\right) S\left(\lambda\right) \, d\lambda
\end{aligned}$$

Tristimulus-viittaus on vektori $\begin{pmatrix} A & B & C \end{pmatrix}$.
Kutsutaan tätä viittausvektoriksi. Tällainen vektori kuvaa värin tietyssä
värimallissa eli viittauksessa tristimulus-avaruuteen. Kukin kolmesta
komponentista voidaan ajatella eräänlaisena sisätulona, joka kertoo kuinka
paljon kyseistä komponenttia on havaitussa värin spektrijakaumassa. Tämä vastaa
kolmen eri tappisolutyypin absorboimien fotonien määrää. Integraalit voidaan
nähdä myös projektiona ääretönulotteisesta vektoriavaruudesta kolmiulotteiseen
avaruuteen.

## Metamerismi

Periaatteessa todellinen spektrijakauma muodostaa ääretönulotteisen
vektoriavaruuden; jakauma sisältää säteilyn intensiteetin kaikilla mahdollisilla
aallonpituuksilla, joita on ylinumeroituva määrä. Kun tämä tieto esitetään
kolmiulotteisessa tristimulus-avaruudessa, joka on siis lineaarialgebran termein
aliavaruus, tietoa luonnollisesti häviää. Tämä tarkoittaa, että yksi
viittausvektori vastaa useita todellisia spektrijakaumia.

Tätä ilmiötä kutsutaan nimellä metamerismi, ja kahta eri väriä, eli
spektrijakaumaa, joilla on sama viittausvektori, kutsutaan metameeriseksi
pariksi. Tämä ilmiö on varsin merkittävä ongelma. Käytännössä ilmiö esiintyy
esimerkiksi silloin, kun kaksi vaatekappaletta, jotka näyttävät tietyssä
valaistuksessa samanvärisiltä, näyttävätkin jossakin toisessa valaistuksessa
erivärisiltä. Tämä johtuu tietysti siitä, että valaistus vaikuttaa merkittävästi
spektrijakaumaan. Metamerismistä johtuen silmä ei erota kahden eri kappaleen
tuottamia spektrijakaumia eri väreiksi yhdessä valaistuksessa, mutta toisessa
erottaa.

Nyt voidaan siis määritellä yhtäsuuruus väreille: $C_1 \equiv C_2$, missä $C_1$
ja $C_2$ ovat edellisessä kappaleessa määritellyn kaltaisien viittausvektorien
mukaisia värejä, esim. $\begin{pmatrix} C_{11} & C_{12} & C_{13} \end{pmatrix}$.
Tämä yhtäsuuruus pätee, jos värit ovat metameerisia pareja.

### Grassmanin lait

Grassmanin lait määrittelevät joitakin värien ominaisuuksia. Ne kuuluvat
seuraavasti:

* $C_1 \equiv C_2 \Leftrightarrow C_2 \equiv C_1$ (Symmetrialaki)
* $C_1 \equiv C_2, C_2 \equiv C_3 \Leftrightarrow C_1 \equiv C_3$
  (Transitiivisuuslaki)
* $C_1 \equiv C_2 \Leftrightarrow aC_1 \equiv aC_2 \, \forall a \in \mathbb{R}$
* $C_1 \equiv C_2, C_3 \equiv C_4 \Leftrightarrow  (C_1 + C_2) \equiv 
  (C_3 + C_4)$

$C_1$, $C_2$, $C_3$ ja $C_4$ ovat vektoreita jossakin tristimulus-
vektoriavaruudessa. Nämä lait vahvistavat väriviittausvektoreille samat
vertailu- yhteenlasku- ja skalaarillakertomisominaisuudet kuin normaaleille
vektoreille. On huomattava, että lain G3 skalaari $a$ saa olla myös
negatiivinen, vaikkakaan tällaiselle operaatiolle ei ole suoranaista
vastaavuutta reaalimaailmassa.

## Perusviittaus

Viittaustapaa, joka vastaa ihmisen näköaistia, kutsutaan perusviittaukseksi
(engl. *fundamental reference*). Siinä kolme komponenttia ovat $S$, $M$ ja $L$
(sanoista Short, Medium, Long) tappisolujen aistimien aallonpituusalueiden
mukaisesti. Tässä värimallissa kunkin komponentin arvo tarkoittaa kyseisen
tappisolun absorboimaa osuutta verkkokalvolle tulevista valokvanteista eli
fotoneista.

Tappisolut absorboivat säteilyn sisältämiä fotoneita tietyllä
todennäköisyydellä, joka riippuu kyseisten tappien herkkyydestä kyseisille
aallonpituuksille. $\bar{s}(\lambda)$, $\bar{m}(\lambda)$ ja $\bar{l}(\lambda)$
olkoot herkkyysfunktioita, jotka ilmaisevat tappisolun todennäköisyyden
absorboida tietyn aallonpituuden kvantti. Näistä saadaan muodostettua värin
sovitusfunktiot $s(\lambda)$, $m(\lambda)$ ja $l(\lambda)$ lineaarisesti
kertomalla joillakin sopivilla kertoimilla $k_s$, $k_m$ ja $k_l$. Kertoimet
riippuvat muun muassa silmän optisista ominaisuuksista ja käytetyistä
mittayksiköistä; kertoimet vain skaalaavat arvot oikein. Tätä viittausta
kutsutaan myös SML-viittaukseksi. SML - menetelmällä on nykyään lähinnä
teoreettista merkitystä, ja seuraavassa esitettävä XYZ-viittaus eli XYZ-
värimalli on huomionarvoisempi.

## XYZ - värimalli

Nykyään standardiviittauksena käytetään CIE:n kehittämää XYZ-viittausta. Tämä
saadaan lineaarisella muunnoksella edellä esitetystä SML-mallista, mutta XYZ on
hyödyllisempi, koska sen käyttämillä värin sovitusfunktioilla on muutamia
hyödyllisiä ominaisuuksia. Muun muassa Y-komponentti sisältää pelkkää
luminenssi- eli kirkkausinformaatiota. Joissakin viittauksissa komponentit
saattavat saada myös negatiivisia arvoja, mutta näin ei käy XYZ:ssa. Toisaalta
XYZ-viittaus on ekvivalentti ihmisen näköaistimuksen kanssa, sillä se saadaan
lineaarisella muunnoksella SML-viittauksesta.

Ihmisen aistimus värin kirkkaudesta riippuu aallonpituudesta. Kokeellisesti on
havaittu, että vastekäyrä on melko lähellä keskipitkän aallonpituuden
vastekäyrää, eli siis periaatteessa vihreän värin vastetta. Toisinaan
käytetäänkin yksinkertaisesti vihreää värikanavaa, kun halutaan yksinkertainen
ja nopea muunnos RGB-kuvasta harmaasävykuvaksi. 

![XYZ-sovitusfunktiot. Lähde: Wikipedia[^xyzcmf].\label{fig:xyzcmf}](images/640px-CIE_1931_XYZ_Color_Matching_Functions.svg.png){ .centered }

[^xyzcmf]: http://en.wikipedia.org/wiki/File:CIE_1931_XYZ_Color_Matching_Functions.svg

XYZ-värit saadaan samanlaisella integroinnilla kuin tristimulus-viittauksien
yhteydessä kerrottiin. Värien sovitusfunktioina käytetään kuvan \ref{fig:xyzcmf}
kaltaisia funktioita, jotka ovat siis todennäköisyysjakaumafunktioita. Näitä
sovitusfunktioita kutsutaan myös CIE:n standardihavainnoijaksi. Ne vastaavat
ihmisen verkkokalvon tappisolujen vasteita 2 asteen näkökentällä. Näkökentän
laajuudella on merkitystä siksi, että tappisolujen jakauma vaihtelee
verkkokalvon eri osissa. Standardihavainnoijassa otetaan siis huomioon vain
aivan näkökentän keskellä olevat tappisolut.

On huomattava, että diagrammissa kaikki käyrät on normalisoitu siten, että
kunkin integraali näkyvän valon spektrin yli on $1$. Todellisten
vastefunktioiden skaalat ovat hyvin erilaiset, sillä eri tappisolujen
herkkyydessä on suuria eroja.

XYZ-värimallia käytetään värien mittauslaitteissa, kuten edellä mainituissa
spektrofotometreissä. Useat ammattilaisten käyttämät ohjelmistot käyttävät XYZ-
väriavaruutta.

### CIE:n xy-väridiagrammi

Jos ajatellaan valon kirkkaudesta eli luminanssista (engl. *luminance*)
riippumattomia värin ominaispiirteitä, puhutaan värikkyydestä (engl.
*chromaticity*). Tätä kuvaavat toisaalta värisävy, kuten esimerkiksi spektrin
nimetyt värisävyt (punainen, oranssi, keltainen, vihreä, sininen ja violetti),
ja toisaalta värin puhtaus tai värikylläisyys eli saturaatio (engl.
*saturation*). Näistä muodostuu se värien kirjo, eli teknisesti ilmaistuna
*gamut*, jonka ihminen pystyy havaitsemaan.

Ihmisen näkemä värien kirjo esitetään tavallisesti niinsanottuna xy-
väridiagrammina. Kukin värisävy voidaan ilmaista käyttäen
*värikkyyskoordinaatteja*, jotka tarkoittavat x- ja y-koordinaatteja tässä
väridiagrammissa. Se on CIE:n määrittämä ja vastaa edellä kuvattua CIE:n
standardihavainnoijaa. Diagrammi siis esittää standardoidun ihmishavainnoijan
näkemää värien kirjoa tappisolujen vasteen mielessä.

Muistamme, että XYZ-koordinaateissa Y-koordinaatti sisältää pelkkää
valoisuustietoa. Väridiagrammi muodostetaankin tutkimalla kolmiulotteisen XYZ-
avaruuden tasoa $X + Y + Z = 1$. Koska $X$, $Y$ ja $Z$ ovat positiivisia, tämä
taso on kolmio jota rajoittavat koordinaattiakselit ja jonka kärkipisteet ovat
akseleilla ykkösen kohdalla. Värikkyyskoordinaatit muodostuvat projektiona tähän
tasoon siten, että $x = \frac{X}{X+Y+Z}$ ja $y = \frac{Y}{X+Y+Z}$. Voidaan
määritellä myös $z = \frac{Z}{X+Y+Z}$, mutta tämä on redundantti tekijä, sillä
se saadaan esitettyä x:n ja y:n avulla: $z = 1-x-y$.

Kun näkyvän spektrin monokromaattinen, eli vain yhtä aallonpituutta sisältävä,
valo kuvitellaan funktiona aallonpituuden suhteen ja projisoidaan xy-tasoon,
muodostuu hieman hevosenkengän muotoinen käyrä. Se muodostaa kuvassa
\ref{fig:xychrom} esitetyn värikkyysdiagrammin (engl. *chromaticity diagram*)
reunakäyrän, joka siis esittää puhtaita spektrin värejä. Värin luminanssi $Y$ on
kohtisuorassa tätä xy-tasoa vasten.

![CIE:n xy-värikkyysdiagrammi. Lähde: Wikipedia[^xychrom].\label{fig:xychrom}](images/565px-CIE1931xy_blank.svg.png){ .centered }

[^xychrom]: http://en.wikipedia.org/wiki/File:CIE1931xy_blank.svg

Diagrammilla on seuraavanlaisia ominaisuuksia. Reunakäyrällä ovat puhtaat
spektrin värit ja kuvion sisällä ovat kaikki mahdolliset ihmisen näkemät
värisävyt, ottamatta huomioon kirkkauden vaikutusta, joka siis on eliminoitu
kaaviosta. Kun kuvasta poimitaan kaksi väriä, niitä yhdistävällä suoralla ovat
kaikki värit, jotka saadaan muodostettua näiden kahden värin avulla. Samaan
tapaan voidaan ottaa useampia värejä, ja näiden rajoittama monikulmio sisältää
värit, jotka saadaan yhdistelemällä näitä valittuja värejä.

Kyseessä on siis tavallaan lineaariavaruus, jossa kahdella eri värillä saadaan
viritettyä jana ja kolmella värillä, jotka eivät ole samalla suoralla, saadaan
viritettyä kolmio. Tavallaan siis 'lineaarisesti riippumattomilla' väreillä
saadaan viritettyä 'aliavaruus'. Miksei saada viritettyä suoraa ja koko
väriavaruutta, kuten lineaariavaruuksissa? Tämä johtuu siitä, että värejä ei
voida ottaa negatiivista määrää, joten väriavaruus ei täysin vastaa
lineaariavaruutta.

Kuvion keskellä kohdassa $(\frac{1}{3},\frac{1}{3})$ on niin sanottu valkoinen
eli epäkromaattinen piste. Tästä pisteestä kuvion reunaa kohti värin saturaatio
eli värikylläisyys lisääntyy. Värikylläisyys tarkoittaa sitä, kuinka hallitseva
värisävy on kyseisessä värissä. Värikylläisyyden vähentyessä harmaasävyjen osuus
lisääntyy. Värien vastavärit löytyvät piirtämällä suora valkoisen pisteen
kautta. Hevosenkengän päitä yhdistävä suora on niin sanottu violetti suora,
jolla olevat värit eivät esiinny puhtaina spektrissä, vaan jotka muodostuvat
punaisen ja violetin sekoituksina.

Tästä kuviosta päästään edellä jo mainittuun käsitteeseen *gamut*, joka
karkeasti tarkoittaa sitä värien kirjoa, joka pystytään esittämään jollakin
laitteella tai värimallilla, eli siis periaatteessa gamut on jokin osa edellä
esitetystä kaarevasta värialueesta. Erilaisilla laitteilla on erilainen gamut,
ja tämä aiheuttaa ongelmia. Tästä puhutaan lisää seuraavassa kappaleessa.
Esimerkkinä näistä ongelmista voidaan sanoa, että itse xy-väridiagrammia ei
pystytä esittämään täsmällisesti, koska näytöt ja tulostimet eivät pysty
tuottamaan oikein kaikkia kuviossa esiintyviä värejä.

Seuraavassa määritellään joitakin väreihin liittyviä termejä.

### Luminanssi

Luminanssi (engl. *luminance*) on valoisuuden yksikkö. Se tarkoittaa valovuon
suuruutta, joka tulee jostakin pinnan pisteestä, nähtynä tietystä suunnasta.
Valovuo taas johdetaan säteilyn sisältämästä kokonaistehosta tai -energiasta.
Luminanssi tarkoittaa siis pinnasta heijastuvan säteilyenergian määrää jostakin
pisteestä tarkasteltuna, ja se on fysikaalinen suure. Luminanssia merkitään
yleensä kirjaimella Y, ja sitä siis vastaa XYZ-avaruuden Y-komponentti.

### Kirkkaus

Kirkkaudella (engl. *brightness*) ymmärretään ihmisen aistimusta siitä, mikä
alue sisältää enemmän ja mikä vähemmän valoa.

### Valoisuus

Valoisuus (engl. *lightness*) tarkoittaa aistimusta alueen kirkkaudesta
suhteessa näkymässä olevaan valkoiseen viitekohteeseen.

### Luma

Luma tarkoittaa gamma-korjattua luminanssia ja sitä merkitään usein Y'.

### Kroma

Kroma (engl. *chroma*) tarkoittaa alueen värikkyyttä verrattuna valkoisen
viitekohteen kirkkauteen.

### Värikylläisyys

Värikylläisyys (engl. *saturation*) tarkoittaa alueen värikkyyttä suhteessa sen
itsensä kirkkauteen.

## Värien ongelmia

Väri on monessa suhteessa ongelmallinen käsite. Ensinnäkin väri on
henkilökohtainen asia; jokainen näkee ja mieltää värit omalla tavallaan.
Toiseksi, valaistus ja ympärillä olevat värit vaikuttavat siihen, miten
miellämme värit. Tämä selvitys keskittyy ongelmiin konenäön ja kuvankäsittelyn
näkökulmasta, ja näihin perustavanlaatuisin syy on se, että ihmissilmä ja
erilaiset laitteet näkevät ja tuottavat värejä eri lailla. Tietokoneiden näytöt
pystyvät tuottamaan tietyn väriskaalan, samoin tulostimet. Ihmissilmät ja
erilaiset kamerat havaitsevat kukin omanlaisensa väriskaalan. Kuten edellä
todettiin, tässä yhteydessä sanotaan, että näillä laitteilla on erilainen gamut.

Ongelmia syntyy siitä, että näyttöjen tuottama väriskaala on eri kuin
tulostimilla; tulostimet eivät yksinkertaisesti pysty tuottamaan joitakin
näytöllä näkyviä värejä, samoin kuin näytöt eivät pysty esittämään kaikkia
tulostimen tuottamia värejä. Samoin skannerien ja kameroiden tallentama
väriskaala on erilainen kuin mitä näytöt ja tulostimet pystyvät tuottamaan.
Yleisesti mitkään laitteet eivät pysty käsittelemään koko ihmisen näkemää värien
kirjoa, vaan vain osan siitä. Ongelmana on siis muuntaa värejä siten, että
käytettävä laite pystyy käsittelemään niitä, ja että samalla ne poikkeaisivat
todellisista, ihmisen havaitsemista väreistä mahdollisimman vähän.

Ongelmia tuottaa myös värien esitystapa: värit pitäisi pystyä kuvaamaan
tietokoneelle jollakin diskreetillä tavalla, jotta se pystyisi käsittelemään
niitä. Eri laitteet käyttävät erilaisia tapoja kuvata värejä, ja näiden
kuvaustapojen välinen muuntaminen on ongelmallista. Seuraavassa kappaleessa
käsitellään näitä asioita tarkemmin.

## Värimallit

Värimallit pyrkivät nimensä mukaisesti mallintamaan ja approksimoimaan luonnossa
esiintyviä ja ihmisen havaitsemia värejä tietokoneella. Värimallit ovat
ikäänkuin matemaattisia malleja, jotka pyrkivät kuvaamaan värejä. Malleja on
useita erilaisia. Valikoiman laajuus selittyy osittain sillä, että eri mallit
soveltuvat eri käyttötarkoituksiin. Pääosa harvinaisemmista malleista on
kuitenkin syntynyt vain siksi, että jokin taho on halunnut luoda oman
standardinsa, tai siksi, että vanhoja malleja on vähän paranneltu jossakin
suhteessa.

Värimallit perustuvat edellä kuvattuun tristimulus-teoriaan. Sen pääsisältö on
siis se, että värit on kolmiulotteinen avaruus; usein puhutaankin
väriavaruuksista. Tämän takia värit saadaan esitettyä kolmen komponentin, nk.
stimuluksen avulla. Kaikki nykyiset värimallit perustuvat enemmän tai vähemmän
tähän teoriaan. Puhutaan myös kolmesta pääväristä, vaikka kaikki kolme
komponenttia eivät tarkkaan ottaen olekaan värejä kaikissa värimalleissa.

Värimallit ovat tavallaan määritelmiä. Ne määrittelevät värit jollakin tavalla.
Määritelmiä on sekä laiteriippuvia että laiteriippumattomia. Laiteriippuvissa
määritelmissä tulos eli näytettävä väri riippuu käytettävästä laitteesta.
Laiteriippumattomat määritelmät ovat tarkkoja ja käytettävät laitteet
kalibroidaan jotta niiden antamat tulokset olisivat oikeita.

Värimalleja on varsin suurilukuinen joukko. Suuri määrä johtuu monista syistä.
Jotkin laitteet asettavat rajoituksia väritiedon koolle. Osa väriavaruuksista on
lineaarisia, eli tietty värin esityksen muutos aiheuttaa vastaavan muutoksen
värihavainnossa. Jotkin värimallit ovat helppokäyttöisiä. Jotkin ovat
laiteriippuvaisia, eli soveltuvat vain tietylle laitteelle, kun taas toiset ovat
laiteriippumattomia. Seuraavassa esitellään yleisimpiä värimalleja. Suurin osa
käytetyistä värimalleista on näiden muunnelmia.

### RGB

RGB on ehkä tunnetuin ja yleisimmin käytetty värimalli valon sekoittamiseen
perustuvissa laitteissa, kuten näytöt ja skannerit. Se perustuu valon päävärien
käyttöön, jotka, kuten edellä kerrottiin, ovat punainen, vihreä ja sininen.
Näistä väreistä tulee myös värimallin nimi (Red, Green, Blue). Erilaisia RGB-
värimalleja on itse asiassa äärettömän paljon. Tämä johtuu siitä, että kolme
pääväriä voidaan valita hyvin monella tavalla. Eri näyttöjen esittämät värit
poikkeavat toisistaan aavistuksen siitä riippuen, minkävärisiä valonlähteitä
niissä on käytetty; eri sävyiset punaiset, vihreät ja siniset tuottavat
erilaisen väriskaalan. Värisävyjen valinnasta riippuu myös näytön gamut;
käytettyjen päävärien 'virittämän' kolmion sisällä ovat kaikki värit jotka
voidaan esittää. Tyypillisesti näytöt eivät kuitenkaan pysty esittämään
kovinkaan värikylläisiä sävyjä.

Periaatteessa pääväreiksi ei tarvitse ottaa juuri punaista, vihreää ja sinistä.
Mitkä tahansa kolme värisävyä kelpaavat, tosin niiden sijainnista CIE:n
värikkyysdiagrammissa riippuu, mitä värejä niillä pystytään esittämään. Tilanne
on vähän kuin lineaariavaruuksissa. Jos kolme väriä ovat samalla suoralla
värikkyysdiagrammissa, ne 'virittävät' vain kyseisen suoran, eli jokin väreistä
pystytään esittämään kahden muun avulla. 'Lineaarisesti riippumattomat' värit,
eli sellaiset, joita ei voi esittää toistensa avulla, eivät kuitenkaan viritä
koko väriavaruutta, vaan ainoastaan 'värivektorien' kattaman kolmion, kuten
edellä todettiin. Osin tämän takia, osin vanhasta tottumuksesta pääväreiksi
valitaa jokin sopiva punaisen, vihreän ja sinisen sävy. Kolmas tärkeä syy on se,
että koska nämä ovat valon päävärit, valkoinen saadaan ottamalla kaikkia kolmea
osapuilleen saman verran. Sekoitussuhteista tulee siis käytännöllisemmät kuin
käytettäessä satunnaisia värejä. Nämä värit virittävät myös melko säännöllisen
kolmikulmion.

RGB:ssä siis komponentteina on kolme pääväriä, joiden sekoitussuhde ratkaisee
esitettävän värin. Periaatteessa tällä tavalla pitäisi saada aikaan kaikki
värit, mikä pitää paikkansa vain osittain. Kaikki värisävyt saadaan kyllä
aikaan, mutta värikylläisyys jää kauas luonnollisesta, käytettävät päävärisävyt
kun eivät ole kovin hyviä. RGB:n ongelma on myös epäkäytännöllisyys. Värisävyä
valittaessa pitää asettaa lähinnä arvaukseen perustuen kolmen värikomponentin
arvo.

RGB on laiteriippuvainen ja epälineaarinen värimalli, epäintuitiivinen käyttää,
mutta yleinen.

### CMY

CMY on sukua RGB:lle, ja on toinen nykyisistä pääasiallisesti käytetyistä
värimalleista. Se perustuu pigmenttien pääväreihin, niin sanottuihin
sekundaarisiin pääväreihin tai vähennysväreihin. Ne ovat syaani, magenta ja
keltainen. Näistä tulee myös värimallin nimi (Cyan, Magenta, Yellow). Näitä
sanotaan vähennysväreiksi sen takia, että kukin pigmentti poistaa heijastuvasta
spektristä jonkin värin. Kaikista kolmesta saadaan siis mustaa kun kaikkia
otetaan saman verran; mustassa tavallaan kaikki väri on otettu pois.

Usein musta väriaine laitetaan tulostimeen erillisessä mustekasetissa, jolloin
puhutaan CMYK-värimallista (K tulee sanasta blacK). Tämä perustuu siihen, että
kun kolmea pääväriä sekoittamalla ei tarvitse tulla puhdasta mustaa, gamut
saadaan paremmaksi; päävärisävyt voidaan valita vapaammin. Usein kolmea pääväriä
yhdistämällä saadaankin vain likaisen ruskea värisävy.

CMY-värimallia käytetään lähinnä pigmenttien sekoittamiseen perustuvissa
laitteissa, kuten tulostimissa. Tässä mallissa 'virittäviä' värejä on usein itse
asiassa kuusi. Tämä johtuu siitä, että monet tulostimet tekevät paitsi syaanin,
magentan ja keltaisen värisiä mustepisaroita, myös sinisiä, punaisia ja vihreitä
mustepisaroita. Siksi monien CMY-laitteiden gamut on kuusikulmainen.

CMY-värimallin pääasialliset heikkoudet ovat samat kuin RGB-mallissakin.
Väriskaala ja värisävyjen kylläisyys riippuvat käytettyjen pigmenttien laadusta.
CMY on myös yhtä epäkäytännöllinen ja epähavainnollinen kuin RGB. Kaikkein
merkittävin ongelma syntyy RGB- ja CMY-värimallien yhteistoiminnasta: koska
näytöt käyttävät RGB:tä ja tulostimet CMY:tä käytännön pakon sanelemana,
konversio näiden välillä on merkittävä asia. Itse konversio ei aiheuta ongelmia,
vaan se, että RGB-mallien ja CMY-mallien gamut on usein aivan erilainen,
riippuen käytetyistä päävärisävyistä. Siis, vaikka mallien välinen konversio on
lineaarinen, monia näytöllä olevia värejä on mahdoton esittää tulostimella, ja
päinvastoin.

CMY on, kuten RGB, laiteriippuvainen, epälineaarinen ja epäintuitiivinen
käyttää.

### HSB ja sen muunnelmat

RGB:ssä ja CMY:ssä värit eivät ole kovin havainnollisessa muodossa. Kolmas
suosittu värimalli, HSB muunnelmineen, helpottaa värien hahmottamista. HSB tulee
sanoista Hue, Saturation, Brightness eli värisävy, värikylläisyys ja kirkkaus.
Tämä värimalli hahmottaa värit samalla lailla kuin ihmisetkin: värillä on
ensinnäkin jokin sävy, kuten sininen, punainen tai keltainen. Toiseksi väri voi
olla pastellisävyinen tai puhdas. Tätä kuvaa värikylläisyys, joka periaatteessa
tarkoittaa harmaasävyjen osuutta värissä, tai värisävyn hallitsevuutta harmaan
suhteen. Kolmanneksi värin kirkkaus voi vaihdella. Kirkkaus tarkoittaa
periaatteessa sitä, kuinka paljon valoa väristä heijastuu. Mitä suurempi
kirkkaus, sitä valoisammalta väri näyttää.

HSB-värimallissa ja sen sukulaisissa värisävy tyypillisesti valitaan ympyrän
kehältä, ja se saa arvoja väliltä 0-359. Saturaatio ja kirkkaus ilmaistaan
prosenttilukuna 0-100. HSB-värimalli käyttää siis sylinterikoordinaatteja, eli
muunnos RGB:n ja HSB:n välillä ei ole lineaarinen.

RGB, CMY ja HSB sijaitsevat periaatteessa samassa väriavaruudessa, joka voidaan
ajatella kuutioksi. Kuution kulmissa ovat punainen, vihreä, sininen, syaani,
magenta, keltainen, valkoinen ja musta. Kirkkaus kasvaa kuution päädiagonaalia
pitkin mustasta valkoiseen ja saturaatio on kohtisuorassa tätä vasten, samoin
kuin ympyrä, jolta värisävyt valitaan.

HSB-värimallista on useita muunnelmia, jotka poikkeavat toisistaan hieman. Näitä
ovat muun muassa HLS (Hue, Lightness, Saturation), HSV (Hue, Saturation, Value)
ja HSI (Hue, Saturation, Intensity); pääasiallinen ero on siinä, miten kirkkaus
määritellään. Tähän on useita tapoja, seuraavassa tärkeimmät.

$$\begin{aligned}
\text{Brightness} &= \frac{R+G+B}{3} \\
\text{Lightness} &= \frac{\max\left\{R,G,B\right\} + \min\left\{R,G,B\right\}}{2} \\
\text{Value} &= \max\left\{R,G,B\right\} \\
\end{aligned}$$

Intensity on sama asia kuin Brightness.

Kaksi vähän samantyyppistä värimallia ovat LCH (Luminance, Chroma, Hue) ja LSH
(Luminance, Saturation, Hue) mutta ne eivät toimi aivan samalla tavalla kuin
edellä mainitut. Niitä käsitellään erikseen jäljempänä.

HSB ja sen sukulaiset ovat vain tapa viitata RGB-avaruuteen, joten ne ovat yhtä
laiteriippuvaisia ja epälineaarisia kuin RGB:kin. Niitä on kuitenkin
suhteellisen intuitiivista käyttää, sillä tämä malli vastaa paremmin ihmisen
käsitystä väreistä.

### CIE XYZ

XYZ-värimallista olikin jo puhetta. Siinä värit kuvataan kolmen kuvitteellisen
päävärin $X$, $Y$, $Z$ avulla, jotka saavat arvoja väliltä $\left[0,1\right]$.
XYZ:n etu on se, että se on täysin laitteistoriippumaton, samoin kuin kaikki
värimallit jotka on johdettu siitä. XYZ ei kuitenkaan ole lineaarinen, ja tähän
asiaan puututaan seuraavassa luvussa.

XYZ-värejä käytetään harvoin sellaisenaan. Yleensä käytetään sen sijaan
väridiagrammin värikkyyskoordinaatteja ja lisäksi luminanssikomponenttia $Y$;
puhutaan xyY-väreistä. Edellä on kerrottu kuinka x ja y lasketaan $X$:n, $Y$:n
ja $Z$:n avulla. Tämän menetelmän avulla on helppo verrata kahta väriä
keskenään, mikä tietysti on tarkoituskin. XYZ on standardivärimalli
ammattilaislaitteissa, koska se kuvaa kaikki mahdolliset värit
yksikäsitteisesti. Tavallisen ihmisen kannalta se on hiukan abstrakti, sillä
kaikkia värimallilla kuvattavia värejä ei pystytä esittämään nykyisin laittein.

Seuraavissa kappaleissa käsitellään joitakin XYZ-mallin johdannaisia.

### CIE L\*a\*b\*

Eräs värimallien ongelmista on se, että ne eivät ole 'lineaarisia'; nykyisin
puhutaan mieluummin havainnon tasaisuudesta (engl. *perceptual uniformness*)
kuin lineaarisuudesta, sillä lineaarisuuden käsite ei täysin vastaa sitä, mistä
tässä on kyse. Ongelman ydin on siis se, että muutos värin
koordinaattiesityksessä aiheuttaa eri suuruisen muutoksen värihavainnossa. CIE
yritti ratkaista tätä ongelmaa hyvin pitkään, ja valmisti kaksi ehdotusta
värimalliksi, jossa tämä ongelma on ratkaistu. Kumpikaan ratkaisuista ei ole
täysin onnistunut, vaikka ero värin ja havainnon välillä onkin huomattavasti
pienempi kuin varhemmissa värimalleissa.

L\*a\*b\*, joskus kutsuttu myös LAB:ksi tai Labiksi, on toinen näistä
ehdotetuista malleista. Käytämme yksinkertaisuuden vuoksi muotoa Lab.
Asteriskeilla merkitty muoto on historiallista perua, sillä Lab perustuu
Hunterin aiemmin esittämään samannimiseen värimalliin, joten asteriskeja
käytetään erottamaan CIE:n L-, a- ja b-komponentit Hunterin käyttämistä.

Lab on niin sanottu vastavärimalli. Se perustuu havaintoon, että jossakin
näköjärjestelmän sisällä värit koodataan vastaväreinä siten, että muodostetaan
sini-keltainen ja puna-vihreä kanava. a sisältää tiedon puna-vihreästä ja b
sini-keltaisesta; L sisältää valoisuustiedon, eli se on siis tavallaan
musta-valkoinen kanava. Se ei ole sama asia kuin XYZ:n Y-komponentti, vaikka Y
on myös melko lineaarinen. L on muodostettu siten, että se kuvaisi paremmin
valoisuuden eroja ja ihmisen vastetta valon kirkkauteen.

Lab on varsin suosittu värimalli ammattilaisten keskuudessa. Se on
laitteistoriippumaton, ja lineaarisuus tekee siitä käyttökelpoisen monissa
yhteyksissä. Sitä käytetään ICC:n (International Color Consortium)
laiteprofiileissa, ja Adoben postscriptissa se on perusvärimalli. Lab on
suora johdannainen XYZ:sta, ja tämä konversio kuvataan jäljempänä.

### CIE L\*u\*v\*

L\*u\*v\* on toinen lineaarisista värimalleista, jotka CIE kehitti, ja sitä
kutsutaan joskus myös nimellä LUV tai Luv. Sen L-komponentti on sama kuin
LABissa, mutta u\* ja v\* ovat periaattessa muunnos xy-värikkyysdiagrammin x- ja
y-koordinaateista. Muunnos on tehty siten, että mahdollisimman hyvä lineaarisuus
saavutettaisiin. L\*u\*v\*:n arvo on paitsi lineaarisuudessa, myös siinä, että
se tarjoaa samanlaisen värikkyysdiagrammin kuin xyY, mutta sitä käytetään ehkä
hiukan vähemmän kuin Labia. Värikkyysdiagrammi esitetään kuvassa

![uv-värikkyysdiagrammi. Lähde: Wikipedia[^uvdiagram].\label{fig:uvdiagram}](images/480px-CIE_1976_UCS.png){ .centered }

[^uvdiagram]: http://en.wikipedia.org/wiki/File:CIE_1976_UCS.png

Seuraava kuva havainnollistaa lineaarisuutta eli havainnon tasaisuutta. Kuvassa
\ref{fig:xyscale} on xy-värikkyysdiagrammin päällä esitetty ellipsinä alueita,
joiden sisällä väriero on tietyn raja-arvon sisällä. Ellipsit on piirretty
kymmenkertaisina todelliseen kokoon nähden vertailun helpottamiseksi. Kuvasta
näkee selvästi, että ellipsit ovat hyvin pitkänomaisia, eli värien eron
havaitseminen vaihtelee hyvin paljon eri suunnissa. uv-värikkyysdiagrammissa
vastaavat ellipsit olisivat huomattavasti ympyrämäisempiä.

![xy-avaruuden skaala. Lähde: Wikipedia[^xyscale].\label{fig:xyscale}](images/543px-CIExy1931_MacAdam.png){ .centered }

[^xyscale]: http://en.wikipedia.org/wiki/File:CIExy1931_MacAdam.png

### LCH ja LSH

Toisinaan näkee mainittavan värimallit LCH ja LSH. Kuten edellä mainittiin, ne
ovat HSB:n sukulaisia, mutta ne muodostetaan suoraan XYZ-värimallista tai sen
johdannaisista. LCH tulee sanoista *Luminance*, *Chroma*, *Hue* ja LSH sanoista
*Luminance*, *Saturation*, *Hue*. Ne toimivat samankaltaisesti kuin HSB. Ne
tarjoavat intuitiivisen lähestymistavan XYZ-, Lab- ja Luv-värimalleihin, mutta
niiden käyttö on melko marginaalista.

Hyödyllisin värimalli Lab:n tai Luv:n kanssa käytettäväksi lienee LCH, tai LCh,
LCh(ab) tai LCh(uv), kuten se toisinaan myös esitetään. Ne ovat
sylinteriprojektioita Lab- ja Luv-väreistä. Näissä malleissa L-komponentti on
täysin sama. C-komponentti on Chroma, eli suhteellinen värikylläisyys. Se
lasketaan yksinkertaisesti etäisyytenä valkoisesta pisteestä:

$$\begin{aligned}
  C_{ab} &= \sqrt{a^2 + b^2} \\
  C_{uv} &= \sqrt{u^2 + v^2}
  \end{aligned}$$

H-komponentti, $h(ab)$, $h(uv)$ tai joskus jopa $h^{\circ}(ab)$ tarkoittaa
värisävyä esitettynä kulmana väriympyrällä, ja se lasketaan käyttäen
arkustangenttia:

$$\begin{aligned}
  h(ab) &= \arctan\frac{b}{a} \\
  h(uv) &= \arctan\frac{v}{u}
  \end{aligned}$$

### YCC ja sen muunnelmat

Televisiomaailmassa käytetään monenlaisia värimalleja, joille on yhteistä se,
että ne erottavat luminanssin krominanssista, eli värikkyyden kirkkaudesta.
Yleensä vielä värikkyys pakataan tiiviimmin kuin kirkkaus; kuten edellä
mainittiin, ihminen huomaa herkemmin erot kirkkaudessa kuin värisävyssä, ja tätä
hyödynnetään TV-tekniikassa.

Tähän ryhmään kuuluvat YCC (Luminance Y, ja kaksi Chrominance-komponenttia) ja
suuret standardit YIQ, jota käytetään amerikkalaisessa NTSC-
televisiostandardissa, ja YUV, jota käytetään eurooppalaisessa PAL-standardissa.
I tulee sanasta *Inphase* ja Q sanasta *Quadrature*. Lisäksi YCbCr on
digitaalitelevision standardi, kun taas NTSC ja PAL ovat analogisia.

YIQ ja YIV ovat lineaarisia, ja kaikki ovat laiteriippuvaisia ja
epäintuitiivisia, mutta tietenkin laajalti käytössä.

## Värien hyödyntäminen konenäkösovelluksissa

Perinteisesti konenäkösovelluksissa on käytetty harmaasävykuvia ja pyritty
tunnistamaan kohteita muodoa ja reunojen avulla. Osittain kyse on ongelman
yksinkertaistamisesta, käsiteltävän datamäärän pienentämisestä ja prosessoinnin
nopeuttamisesta. Luonnollisesti värikuvia tallentavien kameroidenkin laatu on
alkanut kehittyä riittävän hyväksi vasta viime vuosikymmeninä.

Nykyään kamerat ovat jo melko hyviä, ja väri tarjoaa hyödyllistä
lisäinformaatiota monissa sovelluksissa, joten kannattaa harkita värien
hyödyntämistä. On kuitenkin syytä ymmärtää väreihin ja värien havaitsemiseen
liittyvät ongelmat.

Värien hyödyntämistä kohteiden tunnistamisessa hankaloittaa valaistuksen
vaikutus. Varjostukset ja pimeä valaistus laskevat värikylläisyyttä, mikä tekee
värisävyn yksilöimisestä vaikeampaa. Tunnistamisessa ei voida nojautua
tarkkoihin väriarvoihin, vaan on parempi käyttää värisävyjä, esimerkiksi Lab-
väreistä muodostettujen LCh(ab)-värien h-komponenttia. Valaistuksen vaikutus
värisävyyn on huomioitava, eli jos sovellusta käytetään monissa erilaisissa
ympäristöissä, on syytä kerätä dataa kaikista erilaisista ympäristöistä ja
tutkia valonlähteiden vaikutusta.

Värejä voi hyödyntää myös reunojen ja yhtenäisten alueiden tunnistamisessa.
Toisinaan kahden aivan eri värisen alueen välinen suhteellinen kirkkaus on lähes
sama, jolloin harmaasävykuvassa ei näy reunaa, mutta värisävystä muodostetussa
kuvassa näkyy. Yhtenäisiä alueita voi kuvailla värisävyn tai värihistogrammin
avulla.

Värikylläisyyttä voi käyttää kuvaamaan värisävyn epävarmuutta. Jos
värikylläisyys on suuri, värisävykin on luultavasti lähellä oikeaa. Jos
värikylläisyys on matala, värisävyssä voi olla epävarmuutta, jolloin siihen ei
ehkä kannata luottaa niin paljon. Toisaalta matala värikylläisyys voi tarkoittaa
myös sitä, että kohde on valkoinen (kun kirkkaus on korkea) tai musta (kun
kirkkaus on matala).

Lopuksi lienee syytä todeta, että kaikki tämä esitetty teoria pohjautuu viime
kädessä ihmisen värinäköön, ja värien standardisointi pyrkii poistamaan
epävarmuustekijät nimenomaan ihmishavainnoijan kannalta. Konenäköjärjestelmissä
ei kuitenkaan välttämättä ole tarpeen pitäytyä ihmisen rajoittuneessa
näkökyvyssä tai värinäössä. Nykyaikaiset kamerat pystyvät aistimaan ja
erottelemaan värejä tarvittaessa huomattavasti ihmisiä tarkemmin ja laajemmalla
spektrillä. Voidaan myös käyttää erityisiä spektrikameroita, jotka eivät tukeudu
värin näytteistämiseen spektrivastefunktioiden avulla, vaan näytteistävät
suoraan valon intensiteettiä lukuisilla kapeilla taajuuskaistoilla.
