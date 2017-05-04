---
title: Liikkuva kuva ja optinen vuo
author: Matti Eskelinen, Ville Tirronen, Tuomo Rossi
date: 25.4.2017
title-prefix: TIES411
lang: fi-FI
css: style.css
---

# Liikkuva kuva ja optinen vuo {#liike}

Tähän asti olemme käsitelleet vain tilan suhteen näytteistettyjä kuvia, mutta kuvia voidaan tietysti näytteistää myös ajan suhteen. Tällä tavoin saadaan tietoa kohteiden liikkeestä, kameran liikkeestä näkymän suhteen, ja muista ajan myötä tapahtuvista muutoksista näkymässä.

Videokuvaa käsitellään yksittäisinä ajanhetkellä $t$ näytteistettyinä kuvina. Kuvan derivaattaa ajan suhteen voidaan arvioida vertailemalla ajanhetkillä $t$ ja $t+1$ näytteistettyjä kuvia. Useimmissa videotallennemuodoissa kuvia ei tallenneta yksittäin, vaan tiedostoa pakataan tallentamalla peräkkäisten kuvien välisiä muutoksia. Tallennemuodosta riippuen kuvaa pakataan tyypillisesti myös tilan suhteen eri tavoin, joten yksittäisissä kuvissa saattaa esiintyä erilaisia pakkausartefakteja. Jonkinlainen esikäsittely ja suodatus on aina tarpeen.

Joistakin videotiedostomuodoista voi saada luettua tietoa kuvassa tapahtuvasta liikkeestä. Esimerkiksi jotkin MPEG-tyyppiset tiedostomuodot tallentavat liikevektorikenttiä, joista voi olla hyötyä tallennettua videota analysoitaessa. Reaaliaikaisen kuvavirran analysoimisessa näistä ei luonnollisesti ole hyötyä, ellei kyseessä ole pakattu kuvavirta, jollaisia verkon yli lähetettävät kuvavirrat yleensä ovat.

Kuvavirran reaaliaikaisessa analysoimisessa haasteena on aikarajoite. Edellinen kuvaruutu pitää saada analysoitua valmiiksi, ennen kuin seuraava kuva tulee. Aikaa on siis tyypillisesti vain sekunnin murto-osa kuvaa kohden. Toisaalta lyhyt aikaväli kuvaruutujen välillä merkitsee sitä, että muutokset tapahtuvat hitaasti ja rajoittuvat pieneen osaan kuvaa. Reaaliaikaiset analyysijärjestelmät onkin hyvä rakentaa siten, että ne hyödyntävät edellisestä kuvaruudusta saatuja tuloksia. Tämä ei ole aina yksinkertaista, koska useimmat menetelmät on rakennettu käsittelemään kokonainen kuva alusta loppuun aloittaen joka kerta puhtaalta pöydältä.

Yksinkertainen tapa päästä alkuun on käyttää differenssimenetelmällä arvioitua kuvan aikaderivaattaa. Jos videokuvan ruutu ajanhetkellä $t$ on $I(x,y,t)$,

$$\frac{\partial{(x,y)}}{\partial{t}} = I(x,y,t) - I(x,y,t-1).$$

Usein tavoitteena on analysoida pikselikohtaisia muutoksia, käytännössä laskemalla mihin kohdassa $(x,y)$ ajanhetkellä $t-1$ ollut pikseli on siirtynyt ajanhetkellä $t$. Differenssimenetelmiä käytettäessä tämä onnistuu hyvin vain silloin, kun näkymässä tapahtuva liike on korkeintaan yhden pikselin suuruinen kuvatasossa. Tällöin on mahdollista tutkia pikselinaapurustoja peräkkäisissä kuvissa ja arvioida, mistä kohdasta kukin pikseli on siirtynyt. Voidaan toki tutkia myös suurempia, esimerkiksi 5x5-kokoisia pikselinaapurustoja, tai nostaa kuvataajuutta, mutta monissa sovelluksissa kohteiden liike on liian nopeaa tällä tavoin analysoitavaksi.

Toinen hankaluus yksittäisten pikselien liikkeen analysoimisessa on niinkutsuttu aukko-ongelma (engl. *aperture problem*): jos pikseli on tasaisella pinnalla, eli sen ympäristössä ei ole tilagradienttia, sen liikkeestä on vaikea sanoa yhtään mitään. Jos pikselin ympäristössä on selvä tilagradientti, sen liikettä voidaan arvioida, mutta ainoastaan gradientin suunnassa. Käytännössä aukko-ongelma siis tarkoittaa, että jos kuvassa olevaa tasaista reunaa katsotaan pienen aukon läpi, reunan liike on ilmeistä vain, jos se suuntautuu kohtisuoraan reunan suuntaa vastaan. Toisaalta, jos reuna liikkuu, aukon läpi katsottuna se näyttää liikkuvan täsmälleen kohtisuoraan, koska mitään muuta vertailukohtaa ei ole.

Aukko-ongelma ratkaistaan yleensä olettamalla kuvassa oleva liike sileäksi. Käytännössä tämä tarkoittaa sitä, että lähellä toisiaan olevien pikselien oletetaan liikkuvan samalla tavalla. Selkeästi paikannettavien pikselien, eli käytännössä nurkkien ja pistemäisten kohteiden, liikkeen perusteella voidaan päätellä reunoilla ja tasaisilla pinnoilla olevien pikselien liike käyttäen interpolointia tai ekstrapolointia.

## Optinen vuo

Hyvin tunnettu videokuvalle tehtävä perusoperaatio on optisen vuon (engl. *optical flow*) laskeminen. Tuloksena on vektorikenttä, joka kuvaa pikselitasossa tapahtuvan liikkeen nopeutta (engl. *velocity*). Tiheän vektorikentän (jokaisen pikselin liikettä kuvaavan) muodostaminen on laskennallisesti raskas operaatio, joten käytännön sovelluksissa liikevektorit lasketaan esimerkiksi jonkin pistepiirteitä etsivän menetelmän löytämille pistemäisille kohteille. Tämän harvan vektorikentän avulla voidaan sitten tehdä päätelmiä näkymässä olevien kohteiden liikkeistä suhteessa toisiinsa ja suhteessa kameraan, tai kameran liikkeestä suhteessa näkymään.

Horn-Schunk

Lucas-Kanade

## Kohteen seuraaminen

eli tracking
detect... detect... detect... or track?

oletetaan, että liike on koherenttia.

mean shift

kalman-suotimet ja partikkelisuotimet
