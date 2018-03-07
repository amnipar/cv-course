---
title: Tutoriaali 6
author: Matti Eskelinen
date: 15.3.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tämän viikon aiheena on kuvien segmentointi, eli jakaminen jossakin mielessä
yhtenäisiin erillisiin alueisiin. Vaikka segmentointi on tavallaan
samankaltainen operaatio kuin reunanhaku, se on hankalampi toteuttaa siinä
mielessä, että ei ole mitään yhtä suoraviivaista operaatiota, jolla mistä
tahansa kuvasta saisi segmentit esiin. Yleensä päädytään yhdistelemään ja
jakamaan alueita jonkin säännön perusteella. OpenCV-kirjastossakaan ei ole
kynnystyksen lisäksi mitään valmista, helppokäyttöistä menetelmää. Yritämme
kuitenkin saada kokeiltua joitakin perusmenetelmiä, ja toteutettua 
yleiskäyttöisen graafipohjaisen rungon menetelmien kehittelemiseen.

Ota aluksi käyttään tarvittavat kirjastot suorittamalla alla oleva solu. Huomaa,
että ympäristössä pitää olla asennettuna kirjasto networkx. Docker-ympäristössä
tätä ei vielä ole, mutta se on tulossa.

```{.python}
import math
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

# graafien käsittelyyn, asenna pakettin komennolla conda install networkx jos sitä ei löydy
import networkx as nx

%matplotlib inline
```

Ladataan sitten tuttuun tapaan kuva ja suodatetaan siitä kohinaa pois paremman
segmentointituloksen aikaansaamiseksi. Otetaan talteen kuvan mitat.

```{.python}
img = cv.GaussianBlur(np.float32(cv.imread("../images/rect2.png",cv.IMREAD_GRAYSCALE)),(7,7),0)
rows,cols = img.shape
```

## Klusterointi

Kuvia saa 'kynnystettyä' useamman kuin yhden raja-arvon mukaan muodostamalla
pikseleistä piirrevektoreita ja käyttämällä jotakin klusterointimenetelmää
samankaltaisten piirrevektorien ryhmittelemiseen. Palauttamalla ryhmien
tunnukset pikselien arvoiksi saadaan tuloksena eräänlainen moniarvoinen
kynnystys. OpenCV-kirjastosta löytyy toteutus tunnetulle K-means
-menetelmälle:

<http://docs.opencv.org/2.4.13/modules/core/doc/clustering.html#kmeans>

Tässä menetelmässä täytyy valita klusterien määrä $k$. Menetelmä pyrkii
löytämään piirrevektorien jakaumasta Gaussisen jakauman kaltaisia tihentymiä.
Esimerkiksi yksiulotteisten piirrevektorien, kuten pikselien harmaasävyn tai
värisävyn tapauksessa, klusterit asettuvat histogrammin huippujen kohdalle.
Jos klustereita on useampia kuin huippuja, jotkin luonnolliset klusterit
jakautuvat osiin. Hyvän tuloksen saamiseksi voi olla tarpeen kokeilla useilla
$k$:n arvoilla ja vertailla syntyvien klusterien laatua.

Aluksi on muodostettava piirrevektoreista matriisi. Kukin vektori on rivinä
matriisissa. Yksiulotteisen piirrevektorin tapauksessa, esimerkiksi
käytettäessä pikselin arvoa, matriisi voidaan muodostaa esimerkiksi näin:

```{.python}
points = np.float32(np.ravel(img))
```

Kyseessä on siis $N \times 1$ -matriisi, eli vektori. Useampiulotteisilla
piirrevektoreilla toimitaan vastaavasti, lisäten matriisin sarakkeiden määrää.
Matriisin alkioiden on oltava liukulukuja k-means -menetelmää varten.

Klusterointi voidaan suorittaa seuraavasti:

```{.python}
k = 5
num_attempts = 10
term_crit = (cv.TERM_CRITERIA_EPS, 30, 0.1)
ret, labels, centers = cv.kmeans(points, k, None, criteria=term_crit, attempts=num_attempts, flags=0)
```

Tässä `k` on luonnollisesti muodostettavien klusterien määrä. Parametrilla
`num_attempts` voidaan suorittaa hakua useita kertoja peräkkäin erilaisilla
klusterien keskipisteiden alkuarvauksilla, ja lopuksi valitaan tulos, jossa
klusterit ovat mahdollisimman kompakteja dokumentaatiossa kuvatun
kompaktisuusarvon mielessä. Parametri `term_crit` määrää lopetusehdon.

Tuloksena on matriisi, joka sisältää klusterin kokonaislukutunnisteen jokaista
pikseliä kohti, sekä klusterien keskipisteiden koordinaatit. Tulos saadaan
koottua takaisin kuvaksi `reshape()`-funktiolla. Täytyy muistaa myös muuttaa
kuva takaisin liukuluvuiksi ja normalisoida.


```{.python}
labels = labels.reshape(rows, cols)
clustered = np.float32(labels) / (k-1)
```

## Yhtenäiset alueet

Kynnystys- ja klusterointimenetelmät saattavat tuottaa useita toisistaan
irrallisia segmenttejä. Kunkin irrallisen osan saa omaksi segmentikseen
käyttämällä yhtenäisten alueiden merkitsemistä (engl. *connected components
analysis*). Siinä käydään kuvaa läpi rivi riviltä *flood-fill* -tyyppisesti ja
pidetään kirjaa yhtenäisistä alueista esimerkiksi *union-find* -menetelmään
perustuvalla pistevieraiden joukkojen (*disjoint sets*) hallinnalla.

OpenCV-kirjastossa yhtenäiset alueet saa etsittyä binäärikuvasta käyttämällä
menetelmää *findContours*. Tuloksena on reunakäyriä ilmoitettuina pistelistoina.
Yksinkertaisiin alueenetsintätarkoituksiin nämä ovat hieman hankalia käsitellä.
Palaamme niihin myöhemmin muodon kuvailun yhteydessä. Tässä vaiheessa tarjotaan
kokeiltavaksi kurssin pitäjän oma toteutus menetelmästä. Se on c-kirjasto, jossa
on alustava Python-rajapinta. Tämä rajapinta on käytettävissa uusimmassa
amnipar/cv -dockerkuvassa.

```{.python}
from cvsu import run_cc
run_cc(src, dst)
```

Kuvan *src* on toistaiseksi oltava *np.uint8* -tyyppinen harmaasävykuva. Kuvan
*dst* on oltava samankokoinen, *np.uint8* -tyyppinen värikuva. Lähtökuva voi
olla binäärikuva, klusteroitu kuva (esimerkiksi labels-kuva kasattuna
matriisiksi ja muunnettuna *np.uint8* -muotoon) tai vaikka ihan tavallinen
harmaasävykuva. Lopputuloksessa on jokainen erillinen yhtenäinen alue, joka
koostuu täsmälleen samanarvoisista pikseleistä, maalattuna omalla värillään.

Menetelmän Python-rajapintaa kehitetään ainakin sellaiseen muotoon, että
kohdekuvaa ei tarvitsisi antaa vaan lopputuloksesta generoitaisiin uusi,
esimerkiksi *np.uint32* -tyyppinen kuva joka sisältäisi pikselien
kokonaislukutunnisteet. Tästä olisi sitten helppo generoida esimerkiksi
binäärimaski jokaista erillistä aluetta kohti.

Menetelmä tekee paljon muutakin kuin vain maalaa pikseleitä. Se etsii myös
alueiden rajoittavat suorakulmiot (*bounding boxes*) ja massakeskipisteet sekä
merkitsee reunapikselit. Python-rajapintaan saatetaan mahdollisuuksien mukaan
tuoda tarjolle näitäkin ominaisuuksia. Voi olla myös mahdollista tehdä siitä
koodiesimerkki omien c-algoritmien Python-rajapintojen kehittämiseen Cython-
kirjaston avulla.

Luonnollisesti rajapinnassa saattaa olla bugeja, joista otetaan mieluusti
tietoja vastaan.

## Pienin virittävä metsä

Ehkä yleiskäyttöisin ja nopein varsinainen segmentointimenetelmä perustuu
pienimpien virittävien puiden muodostaman metsän (*minimum spanning forest*,
MSF) etsintään. Tämä viittaa luonnollisesti graafeihin ja tunnettuun
graafialgoritmiin. Ideana on se, että kuva muunnetaan graafiksi, jossa pikselit
ovat solmuina, ja jokainen pikselisolmu on liitetty kaarella neljään
naapuripikseliin. Kaarien painokertoimiksi asetetaan pikselien välinen etäisyys
esimerkiksi harmaasävyn tai värisävyn suhteen.

Graafin pienintä virittävää puuta lähdetään muodostamaan perustuen erittäin
tunnettuun Kruskalin algoritmiin. Siinä kaaret lajitellaan painokertoimen
suhteen nousevaan järjestykseen, ja kaaria poistetaan virittävästä puusta jos
kaari muodostaisi silmukan puuhun. Silmukoista pidetään kirjaa *union-find*
-menetelmällä. Virittävän puun rakentaminen voidaan lopettaa kesken jonkin
kriteerin perusteella, esimerkiksi kun kaarien painokertoimet ylittävän jonkin
raja-arvon. Näin saadaan lopputuloksena 'virittävä metsä', jossa olevat puut
ovat kuvan yhtenäisiä alueita eli segmenttejä.

Menetelmä on ehkä lähimpänä yleiskäyttöistä, suoraviivaista ja nopeaa
segmentointimenetelmää. Sen käyttäminen vaatii kuitenkin säätämistä kynnysarvon
asettamisen muodossa. Toisaalta se on periaatteessa täysin yleiskäyttöinen,
segmentoinnin kriteerinä voitaisiin käyttää mitä tahansa pikseleistä
muodostettavia piirteitä, jotka voidaan esittää vektoreina ja joiden välistä
etäisyyttä voidaan mitata jonkin metriikan avulla.

Ohjelmointiympäristössä on tarjolla kurssin luennoijan kehittämä toteutus MSF-
menetelmästä. Sitä käytetään samaan tapaan kuin yhtenäisten alueiden merkintää:

```{.python}
from cvsu import run_msf
run_msf(src, dst, 0.01)
```

Tässä menetelmässä kuvan *src* on oltava *np.float32* -tyyppinen harmaasävykuva,
ja kuvan *dst* on oltava *np.float32* -tyyppinen värikuva. Tällä hetkellä
tuloskuvan pikselit maalataan harmaasävyarvoilla, myöhemmin väreillä.
Menetelmässä muodostetaan kuvasta graafi käyttäen pikseliarvojen euklidista
etäisyyttä kaarien painokertoimena, ja rakennetaan graafin pienintä virittävää
puuta kolmantena parametrina annettuun raja-arvoon asti (on syytä huomata, että
tyypillisissä liukulukukuvissa pikselien arvot ovat väliltä $0-1$.)

Tätäkin rajapintaa kehitetään vielä eteenpäin. Itse menetelmän toteutus on hyvin
joustava ja monipuolinen, siinä voitaisiin helposti tukea mielivaltaisia
n-ulotteisia piirrevektoreita pikseleille. Tämäkin menetelmä tekee paljon
muutakin kuin vain muodostaa virittävää puuta: se kokoaa samalla tilastollisia
tunnuslukuja ja momentteja siihen mennessä muodostuneista yhtenäisistä alueista,
ja siinä voitaisiin käyttää näitä tunnuslukuja lopettamiskriteerinä.

Toistaiseksi menetelmä jättää helposti reuna-alueille useita pieniä segmenttejä.
Jatkokäsittelyvaiheena voitaisiin yhdistää 'liian pienten' alueiden pikselit
lähimpään suurempaan alueeseen, mahdollisesti huomioiden reunakäyrän sileys.

Yhtenäisten alueiden ja reunakäyrien lisäksi tästä menetelmästä saataisiin ulos
myös hierarkinen graafiesitys yhtenäisistä alueista siten, että alueet olisivat
solmuina ja kaaret yhdistäisivät keskenään vierekkäisiä alueita. Solmuihin voisi
liittää tilastollisia tunnuslukuja ja muotopiirteitä. Tätä voisi käyttää
esimerkiksi tilastollisen tai loogisen päättelyn pohjana kohteiden
tunnistamisessa.

## Anisotrooppinen suodatus

Tämä ei varsinaisesti suoraan liity tämän tutoriaalin aiheeseen, mutta
luennoitsijan toteuttamiin menetelmiin sisältyy myös toteutus anisotrooppiselle
suodatukselle perustuen simuloituun diffuusioon anisotrooppisilla
diffuusioytimillä. Yksinkertaisesti sanottuna, perustuen lämmön leviämiseen
epäsymmetrisesti sen mukaan, miten paljon vaihtelua missäkin suunnassa on.

Laskentatulos muistuttaa hyvin paljon bilateraalista suodatusta, mutta se on
laskennallisesti vähemmän raskas. Se siis pehmentää tasaisia alueita mutta
jättää reunat ennalleen. Periaatteessa tarkasti säätämällä menetelmän voi saada
jopa terävöittämään reunoja, mutta sillon se muuttuu herkästi numeerisesti
epävakaaksi ja saattaa alkaa tuottaa ylimääräisiä reunoja.

Toistaiseksi menetelmän parametreista voi muuttaa vain simulointikierrosten
määrää. Periaatteessa menetelmässä siis simuloidaan numeerisesti lämpöyhtälön
ratkaisemista ajan suhteen käyttäen reunaehtona kuvan pikseliarvojen mukaisia
'lämpötiloja' ja muuttamalla pikselien välistä lämmönjohtavuutta gradientin
mukaisesti (suuri gradientti tarkoittaa pienempää lämmönjohtavuutta). Myöhemmin
lisätään muitakin säätöparametreja.

```{.python}
from cvsu import run_adiffusion
run_adiffusion(src, dst, 12)
```

Tässä menetelmässä sekä kuvan *src* että kuvan *dst* on oltava *np.float32*
-tyyppisiä harmaasävykuvia. Myöhemmin voisi olla perusteltua tukea myös double-
tyyppisiä kuvia tarkkuuden parantamiseksi. Kolmas parametri on
simulointikierrosten määrä. Mitä enemmän kierroksia, sitä enemmän yksityiskohtia
häviää, ja lopulta reunatkin alkavat kadota.

Menetelmä soveltuu hyvin esimerkiksi esikäsittelyksi klusteroinnille tai msf-
segmentoinnille. Kirjastossa on myös vastaavalla tavalla toimiva
*run_idiffusion*, joka toteuttaa normaalia isotrooppista diffuusiota. Se vastaa
siis tavallista Gaussista suodatusta. Tästä puhutaan skaala-avaruuksien
yhteydessä.

## Mean shift

Toinen yleisille piirrevektoreille soveltuva segmentointi olisi *mean shift*.
Tästä voisi rakentaa suhteellisen tehokkaan toteutuksen käyttäen *kd-tree*
-tietorakennetta. Ohjelmointiympäristöön on lisätty *scipy*-kirjasto jossa on
esimerkiksi juuri tämä tietorakenne. Siihen palataan myöhemmin luokittelun
yhteydessä. Jos aikaa jää, tähän saatetaan lisätä koodiesimerkki mean shiftin
toteuttamisesta.

## Graafileikkaukset

Periaatteessa matemaattisesti vahvin tavallisen käyttäjän ulottuvilla oleva
menetelmä ovat niinsanotut normalisoidut graafileikkaukset (*normalized cuts*).
Menetelmä on laskennallisesti raskas, mutta se on toteutettavissa
matriisilaskennan keinoin käyttäen harvojen matriisien esitysmuotoja. Kurssin
aiemmalla opetuskerralla esiteltiin menetelmästä Haskell-toteutus, joka toimi
kohtalaisesti pienille kuville. Jos aikaa ja intoa on, tähän voidaan lisätä
myöhemmin vastaava Python-esimerkki. Edellisen kurssin haskell-koodit löytyvät
reposta <https://yousource.it.jyu.fi/cvlab/hs-cvcodes>.

## Segmentointi attribuuttigraafien avulla

Luontevin tapa formuloida kuvien segmentointimenetelmiä on käyttää kuvan
graafiesitystä. Kaikki kuvatut menetelmät voi toki toteuttaa myös laskemalla
siirtymiä naapuripikseleihin taulukkoindeksien avulla, ja huolellisesti tehtynä
tämä on laskennallisesti tehokkaampaakin. Graafimuoto on kuitenkin
intuitiivisempi, koska siinä pikselin naapurusto on koodattuna tietorakenteeseen
itsestään selvällä tavalla. Lisäksi attribuuttigraafeja käyttämällä saadaan
toteutettua hyvinkin monimutkaisia operaatioita, jotka kävisivät varsin
hankaliksi hallita pelkkiä taulukkoja pyörittelemällä.

Tässä materiaalissä käytetään graafien hallintaan kirjastoa `networkx`. Se
mahdollistaa attribuuttien tallentamisen solmuille, kaarille ja koko graafille.
Attribuutteja saa myös päivitettyä helposti. Solmuina voi käyttää periaatteessa
mitä tahansa dict-tietorakenteen indeksiksi kelpaavia arvoja, mutta tehokkainta
on käyttää kokonaislukuja. Seuraavassa siis solmuja merkitään kokonaisluvuilla
$[0,N-1]$, missä $N$ on kuvan pikselien määrä. Kaaria merkitään pareilla
$(a,b)$, missä $a$ ja $b$ ovat solmuja.

Kirjaston ylläpitämästä tietorakenteesta saa tuotettua kahdenlaisia
iteraattoreita solmuille ja kaarille. `G.nodes()` on lista solmujen indeksejä,
ja `G.edges()` on lista solmupareja. Näitä voidaan myös indeksoida suoraan,
esimerkiksi `G.nodes[n]`. `G.nodes(data=True)` on lista pareja `(n,attr)`, missä
`n` on solmun indeksi ja `attr` on `dict`-tyyppinen kokoelma solmun
attribuutteja. `G.edges(data=True)` on lista kolmikoita `(a,b,attr)`, missä `a`
ja `b` ovat solmujen indeksejä ja `attr` on kokoelma kaaren attribuutteja,
vastaavasti kuin solmuilla.

Voidaan tehdä myös iteraattori vain yhdelle attribuutille, esimerkiksi
`G.edges(data='weight')`, joka on lista kolmikoita `(a,b,w)`, missä `w` on
kaaren attribuutin `weight` arvo. Tämä attribuutti on erikoistapaus sikäli, että
sen on aina oltava numero, ja sitä käytetään monissa geneerisissä
graafialgoritmeissa. Kuvissa tyypillinen `weight`-attribuutin arvo on kaaren
yhdistämien pikselien arvojen välinen etäisyys. On syytä huomata, että
tällaisilla yhden attribuutin iteraattoreilla ei voi muuttaa attribuuttien
arvoja, kun taas tavallisilla iteraattoreilla voi.

Perusmuotoisessa graafissa tallennamme kullekin solmulle attribuutin `value`,
joka on solmua vastaavan pikselin arvo graafin perustana olevassa kuvassa.
Voisimme yhtä hyvin laajentaa graafia siten, että se luotaisiin listasta
samankokoisia kuvia, esimerkiksi eri suotimien vasteita samalle kuvalle, ja
jokaisen kuvan pikseliarvo tallennettaisiin erilliseksi attribuutiksi. Toki
olisi mahdollista tehdä myös vain yksi, vektoriarvoinen attribuutti. Kun luomme
solmuiteraattorin komennolla `nodes = G.nodes(data=True)`, saamme listan tavoin
käyttäytyvän, kokonaisluvuilla indeksoitavan iteraattorin, jolla pääsemme
käsiksi solmun attribuutteihin esimerkiksi kirjoittamalla `nodes[n]['value']`.
Tässä `n` on solmun indeksi. Voimme yhtä hyvin myös iteroida kaikki solmut
esimerkiksi kirjoittamalla `for n,attr in nodes`.

Jos halutaan lisätä uusia attribuuteja tai muuttaa olemassa olevien arvoja,
tämän voi tehdä komennoilla `G.add_node(n, attr = value)` tai `G.add_edge(a, b,
attr = value)`. Jos solmu tai kaari on jo olemassa, sitä ei korvata uudella,
vaan ainoastaan mainittujen attribuuttien arvot korvataan uusilla. Voidaan
kuitenkin kirjoittaa myös suoraan `G.nodes[n]['attr'] = value` tai
`G.edges[(a,b)]['attr'] = value`.

Myös itse graafia on mahdollista indeksoida solmujen indekseillä. `G[n]` tai
`G.adj[n]` palauttaa solmun `n` koko naapuruston, eli kaikki solmuun kaarella
liittyvät solmut ja kyseisen kaaren attribuutit. Tätä kokoelmaa indeksoidaan
naapurisolmujen indekseillä, eli `G[a][b]['attr']` on solmujen `a` ja `b`
välisen kaaren attribuutin `attr` arvo, jos kyseinen kaari on olemassa; jos ei,
seurauksena on virhe.

Kun luomme kuvasta graafin, voimme valita vapaasti millä tavalla muodostamme
naapuruston. Perinteisesti on käytetty 4-naapurustoa (neljä vierekkäistä
pikseliä) tai 8-naapurustoa (kaikki kahdeksan ympäröivää pikseliä), mutta ei ole
välttämätöntä rajoittua tähän. Segmentoinnissa voi olla hyödyllistä tutkia
hieman laajempaakin naapurustoa; voidaan esimerkiksi säätää pikselien
yhdistämisen kynnysarvoa sen mukaan, miten suurta vaihtelua ympäristössä on.
Tämän saa tosin tehtyä myös laskemalla suoraan pikseliympäristön keskihajonnan
Gaussin suodinta käyttämällä, ja muodostamalla erillisen attribuutin tästä,
mutta tähän palataan hieman myöhemmin tässä materiaalissa.

Segmentoinnissa tyypillisesti yhdistetään naapuripikseleitä alueiksi, ja tähän
toimivin naapurusto on 4-naapurusto. 8-naapuruston kanssa voi tulla ongelmia
vinojen reunojen kohdalla. Jos kahden erillisen alueen välissä on vino
reunaviiva, alueet saattavat yhdistyä väärällä tavalla - jos ajatellaan *flood
fill* -tyyppistä alueiden maalaamista, 'maali' voi 'karata' vinon reunan läpi.

```{.python}
# luo perinteisen nelinaapurustoon perustuvan graafin kuvasta
def create_n4_graph(img0):
    h,w = img0.shape
    values = img0.flatten()
    G = nx.Graph()
    
    # luodaan pikseliarvon sisältävät, kokonaisluvuin indeksoidut solmut generoimalla lista
    n = [(i, {'value': values[i]}) for i in range(0,len(values))]
    # luetaan kaikki solmut kerralla listasta
    G.add_nodes_from(n)
    
    # luodaan solmuiteraattori, joka palauttaa myös solmujen attribuutit
    # iteraattoria voidaan indeksoida kokonaisluvuilla, ja se palauttaa
    # kullekin solmulle parin (indeksi,attribuutit)
    nodes = G.nodes(data=True)

    # luodaan graafi käyttäen 4-naapurustoa siten, että lisätään kaari aina vasemmalla ja ylhäällä olevaan naapuriin
    # näin kukin kaari lisätään vain kerran, mikä on tehokkaampaa
    # vieläkin tehokkaampia tapoja on, mutta tämä on ehkä selkeämpi ymmärtää...
    for y in range(0,h):
        for x in range(0,w):
            # nykyinen solmu
            n1 = y*w+x
            # vasemmalla oleva solmu
            n2 = y*w+(x-1)
            # ylhäällä oleva solmu
            n3 = (y-1)*w+x
            # kaari vasemmalle lisätään muualla paitsi ensimmäisessä sarakkeessa
            if x > 0:
                G.add_edge(n2, n1, weight = abs(nodes[n1]['value'] - nodes[n2]['value']))
            # kaari ylös lisätään muualla paitsi ensimmäisessä rivissä
            if y > 0:
                G.add_edge(n3, n1, weight = abs(nodes[n1]['value'] - nodes[n3]['value']))

    return G
```

Yhtenäisistä alueista on tehokkainta pitää kirjaa pistevieraiden joukkojen
(engl. *disjoint sets*) hallintaan tarkoitetun *union-find* -menetelmän avulla.
Lisätietoja menetelmästä [wikipediassa](https://en.wikipedia.org/wiki/Disjoint-
set_data_structure). Attribuuttigraafeissa menetelmälle on hyvin luonteva
toteutus. Lyhyesti kuvattuna, toteutus on seuraava:

1. Jokainen graafin solmu alustetaan omaksi pistevieraaksi joukokseen lisäämällä
attribuutti `'set'` jonka arvona on solmun indeksi. Lisäksi lisätään attribuutti
`'rank'`, joka kuvaa joukosta kirjaa pitävän puurakenteen syvyyttä. Luodaan tätä
varten funktio `disjoint_sets_init()`.
1. Joukko muodostuu puurakenteesta, jossa juurisolmu edustaa koko joukkoa.
Juurisolmulla attribuutin `'set'` arvo on solmun oma indeksi. Muilla kuin
juurisolmuilla arvo on jokin muu, ja operaatiolla *find* etsitään joukon
juurisolmu. Määritellään funktio `disjoint_sets_find()`, joka etsii juurisolmun
seuraamalla `'set'` attribuutin arvoja, kunnes löytyy solmu, jolle arvo on sama
kuin solmun indeksi.
1. Etsinnän nopeuttamiseksi jokaisen etsintäoperaation yhteydessä päivitetään
kunkin etsintäpolun varrella löydetyn solmun `'set'`-attribuutin arvoksi
löydetty juurisolmun indeksi. Tällä tavalla puun syvyys pysyy ykkösenä.
1. Joukkojen yhdistäminen eli *union* tarkoittaa yksinkertaisesti sitä, että
jomman kumman joukon juurisolmuksi vaihdetaan toisen joukon juurisolmu. Valinta
tehdään `'rank'`-attribuutin perusteella, jotta puun syvyys pysyy mahdollisimman
pienenä. Joka tapauksessa *find*-operaation yhteydessä puun syvyys palautuu aina
ykköseksi.

Pistevierailla joukoilla on siis kaksi pääoperaatiota: *find*, jolla
selvitetään, mihin joukkoon tietty solmu kuuluu, useimmiten jotta voitaisiin
verrata kuuluuko kaksi solmua samaan joukkoon; ja *union*, jolla kaksi joukkoa
yhdistetään. Edellä kuvatulla menettelyllä kumpikin näistä operaatioista voidaan
tehdä *vakioajassa* riippumatta joukkojen koosta. Alla on yksinkertainen
perustoteutus, joka kannattaa katsoa läpi ajatuksella. Myöhemmin laajennamme
tätä perustoteutusta.

```{.python}
# kaikille funktioille annetaan graafin lisäksi nodes-iteraattori operaatioiden nopeuttamiseksi;
# iteraattorin luominen on hidasta suurelle graafille
# lisäksi voidaan halutessa valita vain osa graafin solmuista tiettyyn operaatioon

# alusta kukin solmu omaksi joukokseen
def disjoint_sets_init(g, nodes):
    for n,_ in nodes:
        g.add_node(n, set = n, rank = 0)

# etsi joukon juurisolmu rekursiivisesti ja päivitä palatessa set-attribuutin arvo
def disjoint_sets_find(g, nodes, n):
    s = nodes[n]['set']
    if s != n:
        s = disjoint_sets_find(g, nodes, s)
        g.add_node(n, set = s)
    return s

# etsi kahden joukon juurisolmut ja yhdistä ne, jos ne eivät jo ole samat
def disjoint_sets_union(g, nodes, a, b):
    set_a = disjoint_sets_find(g, nodes, a)
    set_b = disjoint_sets_find(g, nodes, b)
    if set_a == set_b:
        return
    rank_a = nodes[set_a]['rank']
    rank_b = nodes[set_b]['rank']
    # matalampi puu asetetaan syvemmän lapseksi, jolloin rank ei kasva
    if rank_a < rank_b:
        g.add_node(set_a, set = set_b)
    elif rank_a > rank_b:
        g.add_node(set_b, set = set_a)
    else:
        g.add_node(set_a, set = set_b)
        # jos puut ovat samansyvyiset, toisen rank kasvaa yhdellä
        g.add_node(set_b, rank = rank_b+1)
```

Nyt voimme segmentoida kuvia käymällä läpi graafin kaaria ja liittämällä kaaren
yhdistämät pikselit joukoksi käyttäen *union*-operaatiota, jos jokin
määrittelemämme ehto täyttyy. Lopputuloksena on kuvan ositus joukkoihin, joiden
tunnuksena on kyseisen joukon juurisolmun indeksi. Yleensä haluamme lopuksi
merkitä pikselit jollakin käytännöllisemmällä tavalla, esimerkiksi käyttämällä
juoksevia kokonaislukutunnuksia, kuten k-means -klusteroinnin lopputuloksessa.
Saatamme myös haluta värittää samaan joukkoon kuuluvat pikselit jollakin värillä
hahmottamisen helpottamiseksi. Tehdään seuraavaksi apufunktio tätä varten. Se
lisää pikseleille attribuutit `'label'` (ja `'color'` jos niin halutaan; tähän
arvotaan satunnainen väri kutakin joukkoa kohti).

```{.python}
# merkitse pikselit juoksevilla kokonaislukutunnuksilla joukon mukaan
# ja lisäksi halutessa satunnaisilla väreillä
def label_sets(g, label, color=False, randomSeed=0):
    nodes = g.nodes(data=True)
    # käytetään joukkojen tunnuksille tietorakennetta set, jossa kukin alkio voi esiintyä vain kerran
    sets = set()
    for n,_ in nodes:
        s = disjoint_sets_find(g, nodes, n)
        sets.add(s)
    # luodaan sitten uusille juokseville tunnuksille alkuperäisen joukon tunnuksen mukaan indeksoitu luettelo
    labels = dict()
    l = 0
    for s in sets:
        labels[s] = l
        l = l+1
    # halutessa luodaan myös 
    if color == True:
        colors = dict()
        np.random.seed(randomSeed)
        for s in sets:
            colors[s] = np.random.rand(3)
    # lisätään solmuille uudet tunnukset ja mahdolliset värit
    for n,_ in nodes:
        s = disjoint_sets_find(g, nodes, n)
        g.add_node(n, label = labels[s])
        if color == True:
            g.add_node(n, color = colors[s])
    
    return labels
```

Tehdään vielä toinen apufunktio, jolla saamme luotua kuvan joko joukkojen
kokonaislukutunnuksista tai väreistä.

```{.python}
def image_from_graph(g, h, w, value, color=False, randomSeed=0):
    labels = label_sets(g, value, color, randomSeed)
    if color == True:
        nodes = g.nodes(data=True)
        b = np.array(list(map(lambda n: n[1]['color'][0], nodes))).reshape(h,w)
        g = np.array(list(map(lambda n: n[1]['color'][1], nodes))).reshape(h,w)
        r = np.array(list(map(lambda n: n[1]['color'][2], nodes))).reshape(h,w)
        return cv.merge([b,g,r])
    else:
        if len(label) > 256:
            print("Warning: more set labels than possible pixel values")
        return np.array(list(map(lambda n: n[1][value], g.nodes(data=True)))).reshape(h,w)
```

Lopulta pääsemme kokeilemaan rakentamamme koneiston toimintaa. Kokeillaan
ensiksi perinteistä yhtenäisten alueiden (engl. *connected components*)
merkitsemistä. Tätä on alun perin käytetty kynnystettyjen kuvien kanssa, kun
lopputuloksessa on useampi kuin yksi erillinen kappale. Me voimme käyttää sitä
lisäksi esimerkiksi k-means -klusteroinnilla kvantisoitujen kuvien kanssa; se ei
perusmuodossaan huomioi pikselien sijaintia, jolloin samalla tunnuksella voi
tulla merkittyä useita erillisiä alueita.

Erillisten alueiden merkitseminen on tapana tehdä käyttäen *flood fill*
-tyyppistä menettelyä: pikseleitä 'maalataan' kokonaislukutunnuksin riveittäin
ja aina arvon muuttuessa ja rivin vaihtuessa kasvatetaan lukua yhdellä. Tämä on
työlästä toteuttaa käytännössä, koska seuraavalla pikselirivillä täytyy aina
katsoa yläpuolella olevan pikselin arvoa ja merkitä nykyinen arvo ja yläpuolella
oleva arvo samanarvoisiksi erilliseen kirjanpitoon. Lopuksi täytyy käydä
maalaamassa kaikki samanarvoisiksi merkityt uudelleen samalla 'värillä'.

Pistevieraita joukkoja käytettäessä mitään erillistä kirjanpitoa ei tarvita.
Voimme vain käydä läpi kaikki graafin kaaret ja yhdistää *union*-operaatiolla
samanarvoiset pikselit (kaaren painokerroin on $0$). Luomamme tietorakenne pitää
huolen siitä, että lopulta samaan joukkoon kuuluvilla on sama juurisolmu.

```{.python}
def connected_components(g):
    nodes = g.nodes(data=True)
    edges = g.edges(data='weight')
    disjoint_sets_init(g, nodes)
    for a,b,w in edges:
        if abs(w) < 0.0000001:
            disjoint_sets_union(g, nodes, a, b)

# käytetään aiempaa klusterointitulosta lähtökuvana
lg = create_n4_graph(labels)
connected_components(lg)
# väritetään lopputulos
comps = image_from_graph(lg, rows, cols, 'seg', color=True)
```

Kuten huomaamme, vaivannäön palkkana on hyvin intuitiivinen tapa käsitellä
kuvadataa: jos vierekkäisten pikselien arvo on sama, ne kuuluvat samaan
joukkoon. Mitään muuta ei tarvita.

Aivan vastaavalla tavalla voimme segmentoida harmaasävykuvia. Niissä samaan
alueeseen kuuluvien pikselien arvo on harvemmin aivan sama, joten tarvitaan
suurempi kynnysarvo. Mutta tässä onkin ainoa käytännön ero.

Luentomonisteessa kuvailtu pienimmän virittävän puun (engl. *minimum spanning
tree*) etsintään perustuva segmentointi saattoi kuulostaa monimutkaiselta, mutta
pistevierailla joukoilla toteutettuna se on itse asiassa hyvin yksinkertainen.

1. Käydään läpi kaaria painojärjestyksessä alkaen pienimmistä. Tämä edellyttää
kaarien järjestämistä. Tehokasta toteutusta haluttaessa voitaisiin käyttää
*counting sort* -menetelmää kokonaislukuarvoisilla pikseleillä; tällöin kaarien
painoilla olisi rajallinen määrä vaihtoehtoisia arvoja (esim. 0-255) ja kunkin
arvon paikka lajitellussa taulukossa voitaisiin päätellä laskemalla, kuinka
monta kappaletta kunkin arvoisia kaaria löytyy.
1. Lisätään kaari virittävään puuhun, jos sen seurauksena puuhun ei tule
syklejä; lisääminen tapahtuu *union*-operaatiolla kaaren yhdistämille solmuille,
ja syklin voi havaita siitä, että kyseiset solmut kuuluvat jo samaan joukkoon,
eli *find*-operaatio palauttaa saman juurisolmun. Tämä tarkistus tehdään jo
*union*-operaation yhteydessä.
1. Kun kaarien painokertoimet ovat raja-arvoa pienempiä, voidaan lopettaa puun
rakentaminen kesken, jolloin saadaan joukko virittäviä puita eli virittävä metsä
(engl. *minimum spanning forest*). Nämä vastaavat kuvan yhtenäisiä segmenttejä.
1. Huomaa: jos haluaisimme aidon virittävän puun, meidän täytyisi parametroida
*union-find* -operaatiot siten, että niille voisi määrätä parametrilla jos puun
litistämistä ykkösen korkuiseksi ei haluta tehdä. Harvemmin itse puun
rakenteella kuitenkaan on segmentoinnissa merkitystä, ainoastaan tiedolla siitä,
mitkä solmut kuuluvat mihinkin puuhun.

```{.python}
# skaalataan kuva ensin välille [0-1], jotta raja-arvo on helpompi määrittää
minval,maxval,_,_ = cv.minMaxLoc(img)
ig = create_n4_graph((img - minval) / (maxval - minval))

def minimum_spanning_forest(g, threshold):
    nodes = g.nodes(data=True)
    # lajitellaan kaaret painokertoimen mukaan (kolmikon kolmas alkio)
    edges = sorted(g.edges(data='weight'), key=lambda e : e[2])
    disjoint_sets_init(g, nodes)
    for a,b,w in edges:
        if w < threshold:
            disjoint_sets_union(g,nodes,a,b)
        else:
            # koska kaaret on lajiteltu, seuraavia ei enää tarvitse tarkistaa
            break

# raja-arvolla voi olla suuri merkitys lopputulokseen
minimum_spanning_forest(ig, 0.01)

msf_segs = image_from_graph(ig, rows, cols, 'seg', color=True)
```

Lopputuloksen ilmeisin haittapuoli on se, että se jättää sinne tänne
(erityisesti reunojen läheisyyteen) hyvin pieniä irrallisia segmenttejä.
Jonkinlaista jatkokäsittelyä on siis syytä tehdä. Ilmeisin jatkokehitysidea
voisi olla pitää kirjaa alueiden koosta, ja karsia lopuksi tavalla tai toisella
pois liian pienet alueet. Koon ylläpitäminen olisi helppo tehdä lisäämällä
solmuille ylimääräinen attribuutti `'size'`, joka on aluksi $1$, ja
*union*-operaation yhteydessä yhdistetyn joukon juurisolmulle asetetaan `'size'`
attribuutin arvoksi summa yhdistyneiden joukkojen vastaavan attribuutin
arvoista.

Jotta saisimme toteutettua joukon koon seuraamisen, *union*-operaation
yhteydessä pitäisi saada päivitettyä muitakin attribuutteja kuin vain joukon
tunnusta. Silloin tietysti *init*-operaatiossa olisi hyvä alustaa nämä
attribuutit järkeviin arvoihin, ja ylipäänsä pitää huoli siitä, että tarvittavat
attribuutit ovat olemassa. Ratkaistaan asia niin, että tehdään funktioista
*init* ja *union* versiot, joille voi antaa parametrina funktion tällaisten
erikoisoperaatioiden tekemiseksi.

Ratkaisu on hyvin joustava, ja sen avulla saadaan toteutettua monia muitakin
operaatioita. Eräs kiintoisa idea voisi olla pitää kirjaa myös kunkin joukon
keskimääräisestä pikseliarvosta, ja verrata keskenään keskiarvoja eikä
yksittäisten pikselien arvoja. Tällä tavoin voitaisiin estää sellaisten alueiden
yhdistyminen, joiden sisällä on suurta vaihtelua, ja lähellä reunaa yksittäiset
pikselit saattavat olla lähellä toisiaan. Mahdollisesti voitaisiin saada parempi
tulos käyttämällä suurempaa kynnysarvoa.

```{.python}
# operaatiot ovat muuten samanlaisia, mutta niille annetaan funktio joka tuottaa solmulle lisättävät attribuutit

# alusta kukin solmu omaksi joukokseen
# parametrina annetaan funktio, joka alustaa jokaisen solmun attribuutit halutulla tavalla
def disjoint_sets_init_with(g, nodes, func):
    for n in nodes:
        g.add_node(n[0], **func(n))

# find-operaatio pysyy periaatteessa ennallaan

# etsi kahden joukon juurisolmut ja yhdistä ne, jos ne eivät jo ole samat
# parametrina annetaan funktio, joka päivittää tuloksena syntyvän solmun uudet attribuutit halutulla tavalla
def disjoint_sets_union_with(g, nodes, a, b, func):
    set_a = disjoint_sets_find(g, nodes, a)
    set_b = disjoint_sets_find(g, nodes, b)
    if set_a == set_b:
        return
    rank_a = nodes[set_a]['rank']
    rank_b = nodes[set_b]['rank']
    # matalampi puu asetetaan syvemmän lapseksi, jolloin rank ei kasva
    if rank_a < rank_b:
        g.add_node(set_a, **func(nodes, set_a, set_b))
    elif rank_a > rank_b:
        g.add_node(set_b, **func(nodes, set_b, set_a))
    else:
        g.add_node(set_a, **func(nodes, set_a, set_b))
        # jos puut ovat samansyvyiset, toisen rank kasvaa yhdellä
        g.add_node(set_b, rank = rank_b+1)

# tällä funktiolla init toimii kuten ennenkin
def init_set(n):
    return {'set': n[0], 'rank': 0}

# tällä funktiolla init lisää myös attribuutin size ja alustaa sen ykköseksi
def init_size(n):
    attrs = init_set(n)
    attrs['size'] = 1
    return attrs

# keskiarvon seuraamiseksi on pidettävä kirjaa sekä arvojen summasta että keskiarvosta
# yleiskäyttöisyyden vuoksi generoidaan funktio sen perusteella mikä attribuutti sisältää arvon
# sekä summa että keskiarvo alustetaan pikselin arvolla
# huomaa, että täytyy tehdä myös init_size, jotta size-attribuutti on käytettävissä
def init_mean(value):
    def f(n):
        attrs = init_size(n)
        v = n[1][value]
        attrs['sum'] = v
        attrs['mean'] = v
        return attrs
    return f

# tällä funktiolla union toimii kuten ennenkin
def union_set(nodes, s1, s2):
    return {'set': s2}

# tällä funktiolla union ylläpitää myös alueiden kokoa
def union_size(nodes, s1, s2):
    attrs = union_set(nodes, s1, s2)
    attrs['size'] = nodes[s1]['size'] + nodes[s2]['size']
    return attrs

# tällä funktiolla union ylläpitää alueiden kokoa ja keskiarvoa
def union_mean(nodes, s1, s2):
    attrs = union_size(nodes, s1, s2)
    attrs['sum'] = nodes[s1]['sum'] + nodes[s2]['sum']
    attrs['mean'] = attrs['sum'] / attrs['size']
    return attrs
```

Tehdään sitten paranneltu versio pienimmän virittävän metsän menetelmästä, jossa
käytetään keskiarvoja.

```{.python}
# skaalataan kuva ensin välille [0-1], jotta raja-arvo on helpompi määrittää
minval,maxval,_,_ = cv.minMaxLoc(img)
ig2 = create_n4_graph((img - minval) / (maxval - minval))

def minimum_spanning_forest_with_mean(g, threshold):
    nodes = g.nodes(data=True)
    # lajitellaan kaaret painokertoimen mukaan (kolmikon kolmas alkio)
    edges = sorted(g.edges(data='weight'), key=lambda e : e[2])
    # alustetaan keskiarvon kanssa käyttäen 'value'-attribuuttia arvona
    disjoint_sets_init_with(g, nodes, init_mean('value'))
    
    for a,b,w in edges:
        # nyt käytetäänkin vertailuun joukkojen keskiarvoja
        set_a = disjoint_sets_find(g, nodes, a)
        set_b = disjoint_sets_find(g, nodes, b)
        mean_a = nodes[set_a]['mean']
        mean_b = nodes[set_b]['mean']
        if abs(mean_a - mean_b) < threshold:
            disjoint_sets_union_with(g, nodes, set_a, set_b, union_mean)
        # nyt ei keskeytetä silmukkaa, koska keskiarvot ovat eri asia kuin kaarien painot

# raja-arvolla voi olla suuri merkitys lopputulokseen
minimum_spanning_forest_with_mean(ig2, 0.1)

msf_mean_segs = image_from_graph(ig2, rows, cols, 'seg', color=True)
```

Oletuksena käytetty raja-arvo on tässä paljon suurempi kuin aiemmin, mutta
alueet eivät ole silti yhdistyneet väärin. Huomaamme, että harmaasävyn
'liukumia' sisältävillä alueilla segmentit ovat pilkkoutuneet pienemmiksi. Tämä
johtuu siitä, että keskiarvoja vertailtaessa alueiden keskiarvot saattavat
tällaisilla alueilla poiketa merkittävästi reunapikselien arvoista, riippuen
siitä, missä järjestyksessä kaaria käsitellään. Joissakin tilanteissa tällainen
tulos voi olla suotuisa: harmaasävyjen liukumia esiintyy erityisesti silloin,
kun pyöreät pinnanmuodot aiheuttavat varjostuksia, ja tällaisissa tilanteissa
valaistus saattaa helposti häivyttää reunoja. Saattaa olla parempi antaa
segmenttien pilkkoutua, ja yrittää jälkikäteen päätellä, millä tavoin niitä on
sopivaa yhdistää.

Tätä ajatusta voi kehitellä eteenpäin myös luentomonisteessa esitetyn
*superpixels*-tyyppisen segmentoinnin suuntaan. Eräs tapa toteuttaa tällainen
idea olisi aloittaa segmentointi tasavälein tai satunnaisesti sijoitetuista
lähtöpisteistä. Näistä pisteistä ryhdytään kasvattamaan 'superpikseleitä'.
Lisätään kaikki näistä pikseleistä lähtevät kaaret listaan. Yhdistetään alueet
esimerkiksi raja-arvon mukaan. Voidaan myös merkitä kyseiset kaaret
käsitellyiksi attribuutilla. Lisätään uuteen listaan kaikki yhdistetyistä
pikseleistä lähtevät kaaret, joita ei vielä ole käsitelty. Voidaan myös
rajoittaa superpikselien laajentumista mittaamalla etäisyyttä lähtöpisteeseen
(vaatisi pikselikoordinaattien tallentamisen solmuihin attribuuttina).

Tällä tavoin saataisiin muodostettua joukko pieniä alueita, joiden voisi olettaa
olevan melko yhtenäisiä. Ne ovat myös riittävän suuria, jotta niiden alueelta
voisi kerätä järkevästi esimerkiksi tilastollisia piirteitä. Tämän jälkeen
voitaisiin yhdistellä superpikseleitä suuremmiksi alueiksi piirteitä
vertailemalla tai esimerkiksi tilastollisen päättelyn tai luokittelijan avulla.

Nyt haluaisimme vielä saada karsittua pois liian pienet alueet yhdistämällä ne
johonkin naapureista. Tätä varten meidän pitäisi saada tehtyä uusi graafi, jonka
solmut ovat löydettyjä segmenttejä. Tehdään seuraavaksi uusi apufunktio, joka
muodostaa graafin erillisten joukkojen naapuruussuhteiden perusteella: joukot
ovat naapureita, jos niihin kuuluu keskenään naapureita oleva pari pikseleitä.

```{.python}
# annetaan parametrina attribuutti, josta tulee uuden graafin solmujen arvoja
def create_disjoint_sets_neighbor_graph(g, value):
    G = nx.Graph()
    nodes = g.nodes(data=True)
    # kerätään joukkojen juurisolmut ja tehdään niistä uusi graafi
    # sets = set()
    for n in nodes:
        s = disjoint_sets_find(g, nodes, n[0])
        if not s in G:
            G.add_node(s, value = nodes[s][value])
    #print(list(sets))
    #G.add_nodes_from(list(sets))
    # käydään läpi alkuperäisen graafin kaaret
    newnodes = G.nodes(data=True)
    edges = g.edges()
    for a,b in edges:
        set_a = disjoint_sets_find(g, nodes, a)
        set_b = disjoint_sets_find(g, nodes, b)
        # lisätään uuteen graafiin kaari, jos solmut kuuluvat eri joukkoihin
        if set_a != set_b:
            G.add_edge(set_a, set_b, weight = abs(newnodes[set_a]['value'] - newnodes[set_b]['value']))
    return G
```

Nyt voimme yhdistää tiettyä raja-arvoa pienemmät joukot siihen naapurijoukkoon,
jonka keskiarvo on lähimpänä. Lopuksi saatamme haluta vielä käydä läpi kaikki
syntyneiden alueiden väliset kaaret, ja yhdistää samankaltaisia alueita hieman
korkeamman raja-arvon avulla.

```{.python}
# yhdistetään tiettyä raja-arvoa pienemmät alueet siihen naapurialueeseen, jonka keskiarvo on lähimpänä
def union_for_smaller_than(g1, g2, threshold):
    nodes = g1.nodes(data=True)
    sets = g2.nodes()
    for s in sets:
        size = nodes[s]['size']
        if size < threshold:
            v1 = nodes[s]['mean']
            min_n = None
            min_d = math.inf
            for n in g2.adj[s]:
                v = nodes[n]['mean']
                d = abs(v - v1)
                if d < min_d:
                    min_d = d
                    min_n = n
            disjoint_sets_union_with(g1, nodes, s, min_n, union_mean)

# yhdistetään alueet, joiden välisen kaaren painokerroin on raja-arvoa pienempi
def union_for_closer_than(g1, g2, threshold):
    nodes = g1.nodes(data=True)
    edges = g2.edges(data='weight')
    for a,b,w in edges:
        if w < threshold:
            disjoint_sets_union_with(g1, nodes, a, b, union_mean)
```

Kokeillaan sitten parannella aiempaa tulosta.

```{.python}
ng1 = create_disjoint_sets_neighbor_graph(ig2, 'mean')
union_for_smaller_than(ig2, ng1, 5)
ng2 = create_disjoint_sets_neighbor_graph(ig2, 'mean')
union_for_closer_than(ig2, ng2, 0.15)

msf_mean_segs = image_from_graph(ig2, rows, cols, 'seg', color=True)
```

Edellä esitettyjä ideoita muuntelemalla ja yhdistelemällä voi saada aikaan
oikeinkin hyvin toimivia segmentointimenetelmiä. On myös hyvä pitää mielessä,
että graafin ei tarvitse perustua vain yhteen kuvaan. Solmuille voi aivan hyvin
lisätä attribuutteja myös jonkin toisen kuvan perusteella. Graafin kaarille
puolestaan voi lisätä attribuutteja esimerkiksi gradientin perusteella, mikä voi
auttaa esimerkiksi päättämään mitä solmuja ei ainakaan yhdistetä.

Toisinaan voi olla tarpeen käyttää myös muita kuin 4-naapurustoa. Seuraavassa on
ideoita siihen, millä tavoin voitaisiin kohtalaisen helposti ja tehokkaasti
muodostaa mielivaltainen pikselinaapurusto. Graafit ovat käyttökelpoisia
muuhunkin kuin vain segmentointiin. Esimerkiksi esitettyä 8-naapurustoa voisi
käyttää reunojen seuraamiseen. Koodiesimerkistä voi saada hyödyllisiä vinkkejä
myös siihen, miten pythonin ja numpyn kanssa voi indeksoida vektoreita ja
matriiseja.

```{.python}
# käytetään pikselin naapuruston muodostamiseen seuraavaa siirtymälistaa
# tähän voisi halutessaan sisällyttää enemmänkin kuin kahdeksan naapuripikseliä;
# esimerkiksi ympyrän muotoisen alueen tietyn säteen sisällä
# neighborhood8 = np.array([[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,-1]], dtype=np.int32)
# puolet halutusta naapurustosta riittää, jotta vältetään kaarien lisääminen kahteen kertaan
neighborhood8 = np.array([[-1,-1],[-1,0],[-1,1],[0,-1]], dtype=np.int32)

# luodaan graafin kaaret naapuruston avulla
def add_edges_by(img0, g, neighborhood):
    h = img0.shape[0]
    w = img0.shape[1]
    nodes = g.nodes(data=True)
    for y in range(0,h):
        for x in range(0,w):
            # muodostetaan siirtymistä nykyisen pikselin naapurien indeksit
            idx = neighborhood + [y,x]
            # luodaan maski, joka osoittaa sallitut rajat ylittävät indeksit
            chk = (idx[:,0] >= 0) & (idx[:,1] >= 0) & (idx[:,0] < h) & (idx[:,1] < w)
            # poistetaan maskin avulla virheelliset indeksit
            idx = idx[chk]
            # tarvittaessa voitaisiin myös hakea kerralla kaikki indeksejä vastaavat arvot
            # val = img0[idx[:,0],idx[:,1]]
            for i in range(0,idx.shape[0]):
                n1 = y*cols+x
                n2 = idx[i,0]*cols+idx[i,1]
                # merkitään myös kaaren 'pituus', sillä on vaikutusta painotukseen
                d = math.sqrt((y - idx[i,0])**2 + (x - idx[i,1])**2)
                # voitaisiin periaatteessa lisätä myös painotusfunktio, joka painottaa
                # arvojen erotusta etäisyyden mukaan esimerkiksi gaussin funktion mukaisesti
                w = abs(nodes[n1][1]['value'] - nodes[n2][1]['value']) * d
                g.add_edge(n1, n2, weight = w, dist = d)
```

## Tehtäviä

Kokeile k-means -segmentointia kuvillesi erilaisilla keksimilläsi
piirrevektoreilla. Kokeile myös Lab-värikuvien a- ja b-kanavia sekä LCh-
värikuvien värisävykanavaa sekä pikselikoordinaattien yhdistämistä
piirrevektoriin. Muista skaalata koordinaatit sopivasti. Voit myös kokeilla
erilaisten suodinmaskien vasteita, mutta myöhemmin toivottavasti saadaan
esimerkkejä paremmin tällaiseen tarkoitukseen soveltuvista menetelmistä.

Voit myös kokeilla OpenCV-tutoriaalin esimerkkiä watershed-menetelmästä, jos
pystyt muodostamaan jonkinlaisen alkuarvauksen:

<https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_imgproc/py_watershed/py_watershed.html#watershed>

Kokeile myös yhtenäisten alueiden etsintää ja msf-segmentointia joko docker-
ympäristön kirjastolla tai tässä esitetyllä graafitoteutuksella.
