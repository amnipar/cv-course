% TIES411 - Konenäkö ja kuva-analyysi
% Matti Eskelinen, Ville Tirronen, Tuomo Rossi
% lang: fi-FI

# Johdanto {#johdanto}

Konenäkö (engl. *computer vision*) on nopeasti kehittyvä ja laaja tieteenala,
jolla on paljon käytännön sovelluksia. Termillä *machine vision* viitataan usein
nimenomaan teollisuuden piirissä tehtävään käytännön työhön, jossa rakennetaan
näkeviä koneita soveltaen konenäkömenetelmiä.

Lopullisena tavoitteena konenäkötutkimuksessa on ollut jo 1960-luvulta saakka
rakentaa kone, joka ymmärtäisi näkemänsä yhtä hyvin kuin ihminen.
Tutkijasukupolvi toisensa jälkeen on joutunut omakohtaisesti kokeilujen ja
yritysten seurauksena huomaamaan, että tämä on paljon vaikeampaa kuin vaikuttaa.
Ihminen havainnoi ympäristöään vaivattomasti, ja aivomme generoivat meille
yhtenäisen mallin josta lähes kaikki epävarmuustekijät on häivytetty. Kun
ryhdymme ohjelmoimaan algoritmeja joiden pitäisi tuottaa samanlainen tulos,
joudumme huomaamaan, että kuvadata on oikeasti hyvin sotkuista ja epäselvää.

Miksi ihminen sitten havainnoi niin vaivattomasti, mutta tietokoneilla on
niin vaikeaa saada samanlaisia tuloksia? Pohdimme tätä asiaa kurssin mittaan ja
lopussa esitämme joitakin ajatuksia siitä, millä tavalla tulevaisuudessa
voitaisiin pyrkiä ihmisen tasoiseen näkymien havainnointiin. Todettakoon
kuitenkin jo tässä vaiheessa, että suurin syy vaikeuksiin ei liene ihmisen
aivojen suuremmassa prosessointikapasiteetissa tai massiivisen rinnakkaisessa
toiminnassa. Ongelmat liittyvät enemmän siihen, että vielä ei kunnolla tiedetä,
kuinka visuaalista dataa kannattaisi käsitellä; lisäksi ihmisen aivot oppivat
ja tallentavat vuosien ajan kokemusperäistä tietoa maailman rakenteesta ja
toiminnasta, ja käyttävät tätä tietoa hyväkseen näkymien tulkitsemisessa ja
mallintamisessa. Tällaista *aiemman tiedon* (engl. *prior knowledge*) ja
kokemuksen hyödyntämistä ei osata vielä kunnolla toteuttaa tietokoneohjelmissa.

![Mitä kuvassa on? (Lähde: www.freeimages.co.uk)](images/sportcanoe1331.jpg)

Jos tuumitaan vaikkapa oheista kuvaa kajakista, huomataan monia asioita jotka
tuottavat vaikeuksia tietokoneelle. On vaikea päätellä missä kajakin reunat
kulkevat tai missä kajakki loppuu ja ihminen alkaa, jos käytössä ei ole
jonkinlaista mallia kajakista ja ihmisen ja kajakin vuorovaikutuksesta.
Ylipäänsä on vaikea tunnistaa kuvasta ihminen, sillä kasvoista näkyy vain pieni
osa profiilia, kypärä peittää pään ja mela peittää kädet. Teippaukset estävät
hahmottamasta kajakkia yhtenäisenä pintana, ja veden kuohut ovat kirkkaan
valkoisia joten ne tuottavat voimakkaimmat reunat kuvassa.

![Kuvien haasteita](images/rects.png)

Myös paljon yksinkertaisempiinkin kuviin liittyy haasteita. Oheinen kuva
neliöistä vihjaa, kuinka hankalaa näinkin yksinkertaisen kohteen tunnistaminen
voi olla, jos kuvassa on kohinaa, valaistuksen vaihteluita tai voimakkaita
varjoja. Lisäksi kohteet yleensä vääristyvät kuvissa näkökulman ja kohteen
muodon muuttumisen seurauksena. Usein on tarpeen mallintaa kohde ja sen
muodossa ja rakenteessa tapahtuvat muutokset tilastollisesti. Tulemme käyttämään
kurssilla tällaisia satunnaisesti generoituja kuvia yksinkertaisista muodoista,
ja kurssin lopussa osaamme toivottavasti tunnistaa erilaiset muodot kuvista.

Tällä kurssilla tutustumme kuvadataan ja erilaisiin menetelmiin joilla kuvia
voi analysoida. Pyrimme ymmärtämään kuvadatan ominaispiirteitä sekä tärkeimpien
analysointimenetelmien pääperiaatteita. Tutustumme myös erilaisiin tapoihin
mallintaa ja ratkaista konenäkötehtäviä. Lyhyellä kurssilla ei ole mahdollista
mennä yksityiskohtiin, mutta kurssin lopussa osallistujilla on toivon mukaan
riittävät tiedot, taidot ja työkalut kokeilujen tekemiseen ja lupaavien
menetelmien tutkimiseen ja jatkokehittämiseen tietyn rajatun ongelman
ratkaisemiseksi.

Kurssilla käsitellään seuraavia asioita:

1. Kuvien eri esitysmuodot, yksinkertaiset matemaattiset operaatiot
1. Kuvien tulkinta lineaarisina invariantteina systeemeinä, konvoluutio ja
   kuvien suodattaminen sen avulla
1. Kuvien taajuustason analyysi Fourier-muunnoksen avulla
1. Kuvien tilastollinen analyysi tunnuslukujen, jakaumien ja pääkomponenttien
   avulla
1. Värit ja värien spektri
1. Reunojen etsintä kuvista, reunakäyrien seuraaminen
1. Yhtenäisten alueiden etsintä, alueiden kuvaileminen
1. Kuvien analysointi eri skaaloissa, skaala-avaruus ja pistepiirteet
1. Liikkuva kuva, optinen vuo eli *optical flow*
1. Geometriset takaisinprojektiot ja kolmiulotteinen hahmottaminen
1. Hahmontunnistuksen perusteet ja yksinkertainen piirteytys
1. Koneoppimisen perusteet, mallien kouluttaminen ja validointi
1. Luokittelumenetelmät, kuten neuroverkot, tukivektorikoneet ja Bayesilaiset
   mallit
1. Tilastolliset rakenteiset mallit

Kurssi on itsenäinen kokonaisuus, ja kaikki tarvittavat esitiedot kerrataan.
Matemaattista ymmärrystä vaaditaan jonkin verran. Verkosta on vapaasti
saatavilla kaksi kirjaa, joista on hyötyä kurssin tietojen syventämisessä.
Szeliskin kirja [-@Szeliski2011] kertaa konenäön historiaa ja painottuu
käytännön algoritmeihin ja sovelluksiin. Princen kirja [-@Prince2012] painottuu
malleihin ja niiden oppimiseen.

Myös [kurssisivu](http://users.jyu.fi/~amjayee/TIES411/) sekä tämä [luentomoniste](
http://http://users.jyu.fi/~amjayee/TIES411/ties411-luentomoniste.pdf) löytyvät verkosta.
Materiaali tulee päivittymään kurssin aikana, joten vain jo pidettyjen luentojen
materiaaliin kannattaa luottaa.

## Kurssisivun koodiesimerkit

Materiaalissa viitataan kurssisivun koodiesimerkkeihin. Tämä liittyy aiemman kurssin kokeiluun tarjota web-sovellus, jossa erilaisia esimerkkialgoritmeja pystyi kokeilemaan. Tämä käytännön osuus korvataan kurssin kuluessa Docker-ympäristössä suoritettavilla tutoriaalityyppisillä ohjelmointitehtävillä, ja materiaalin tekstiä päivitetään vähitellen, mutta siellä täällä esiintyy hämääviä viittauksia kurssisivuun ja koodiesimerkkeihin, joita ei enää ole entisessä muodossaan saatavilla.
