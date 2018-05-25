---
title: Konenäkö ja kuva-analyysi
author: Matti Eskelinen
date: 25.5.2018
title-prefix: TIES411
lang: fi
css: style.css
---

Tämä on informaatioteknologian tiedekunnan syventävä kurssi, jossa perehdytään
kuvien analysointiin ja konenäkösovelluksien kautta yleisesti signaalien ja
datan analysointiin sekä hahmontunnistukseen ja koneoppimiseen. Kurssi on 
viimeksi luennoitu keväällä 2018. Materiaali on tarjolla itseopiskelua varten,
ja kurssin suorittamisesta harjoitustyöllä tai tenttimällä voi olla yhteydessä
luennoijaan tai professori Tuomo Rossiin.

## Kurssin suorittaminen

Kurssi suoritetaan joko harjoitustyöllä tai tenttimällä. Harjoitustyö on
helpompi tapa. Työn tekeminen tapahtuu seuraavasti:

* valitaan jokin itseä kiinnostava konenäköongelma tai -sovellus (mieluiten
  yksin, voi myös tehdä pareittain tai pienessä ryhmässä, mutta työmäärää
  pitää säätää sopivaksi),
* sovitaan aiheesta ja sopivasta laajuudesta kurssin luennoijan/ohjaajan kanssa,
* luodaan tai etsitään verkosta aiheeseen liittyvää kuva- tai videomateriaalia;
  valmiita datasettejä voi löytää hakusanoilla kuten 'open image dataset',
* kokeillaan luennoilla/luentomonisteessa esiteltyjä menetelmiä ja joitakin
  itse tutkittuja menetelmiä kerättyyn aineistoon käyttäen tutoriaaleissa
  kuvattuja harjoituksia lähtökohtana,
* kirjoitetaan työn edetessä tuloksia, havaintoja ja pohdintoja raporteiksi
  ja toimitetaan ne kurssin luennoijalle/ohjaajalle, mieluiten tekemällä oma
  repo kurssin [yousource-projektiin](https://yousource.it.jyu.fi/cv-2018),
* työn tavoitteena ei ole tuottaa valmista sovellusta, vaan kokeilla erilaisia
  menetelmiä ja muodostaa käsitys siitä, miten ongelman saisi ratkaistua tai
  sovelluksen toteutettua,
* tarkoituksena on tehdä jokaisen tutoriaalikerran teemaan liittyen kokeiluja
  soveltuvin osin oman aiheen kanssa; jos teema ei sovellu omaan aiheeseen,
  tehdään kokeiluja muulla materiaalilla (esimerkkimateriaali tulossa
  kullekin kerralle),
* suoritukseksi riittää 10 tutoriaalikerran tehtävien sekä yhteenvedon 
  tekeminen, koska loppupään tehtävät ja esimerkit ovat myöhässä; halutessaan
  voi korvata tutoriaaleilla 12-14 joitakin alkupään tutoriaaleista, jos jaksaa
  odottaa ohjeita ja esimerkkejä, ja jos jotkin alkupään tehtävät eivät sovellu
  omaan aiheeseen,
* lopuksi raporttiin tehdään yhteenveto, jossa valitaan aiempien kokeilujen
  perusteella sopivat esikäsittelymenetelmät ja tehdään skripti, joka suorittaa
  samat vaiheet kaikille datajoukon kuville ja tallentaa tulokset uusiksi
  kuviksi esimerkiksi eri hakemistoon; tästä on esimerkki tutoriaalissa 11,
* yhteenvedossa pohditaan skriptin tuloksena saatavia kuvia, arvioidaan tulosten
  laatua ja sopivuutta alkuperäisen ongelman ratkaisemiseen ja ideoidaan
  kuinka lopullinen ongelma voitaisiin ratkaista,
* työn suorituksen muodostavat tuotetut kooditiedostot ja tekstiraportit;
  sopiva tekstin laajuus on 1-2 sivua per tutoriaalikerta sekä 1-2 sivua
  yhteenvetoa (poislukien kuvat ja paria riviä pidemmät koodilistaukset).

Kurssin laajuus on 4 opintopistettä, joten luentojen osuus on vain vajaa
kolmasosa. Loppuosa koostuu omatoimisesta työstä harjoitustyön ja lisäopiskelun
parissa, mutta tukea ja ohjausta on toki tarjolla sähköpostitse ja 
luentojen/ohjausten yhteydessä.

## Materiaalia

* Kurssin [yousource-projekti](https://yousource.it.jyu.fi/cv-2018); repossa
  cv-2018 ylläpidetään työversioita kurssimateriaaleista.
* Alustava versio [luentomonisteesta](./ties411-luentomoniste.pdf), joka tulee
  täydentymään ja kehittymään kurssin aikana.
* Sivulle [tutoriaalit](./tutorials/) tulee käytännön
  harjoitteita ohjelmointiympäristöön ja harjoitustyöhön liittyen.

Seuraavassa taulukossa kooste kurssin aiheista ja niihin liittyvistä
materiaaleista.

| Luku | Moniste | Kalvot | Tutoriaali | Notebook |
|:---------------------|:---------|:---------|:---------------------|:---------|
| [1. Johdanto](./chapter_01.fi.html) | [pdf](./chapter_01.fi.pdf) | pdf | [html](./tutorials/tutorial01.fi.html) (päivitetty 16.1.2018) | ipynb |
| [2. Kuvanmuodostus ja näytteistys](./chapter_02.fi.html) | [pdf](./chapter_02.fi.pdf) | pdf | html | ipynb |
| [3. Suodatus ja muokkaus](./chapter_03.fi.html) | [pdf](./chapter_03.fi.pdf) | pdf | [html](./tutorials/tutorial02.fi.html) | ipynb |
| [4. Taajuusanalyysi](./chapter_04.fi.html) | [pdf](./chapter_04.fi.pdf) | pdf | [html](./tutorials/tutorial03.fi.html) (päivitetty 13.2.2018) | [ipynb](./tutorials/tutorial03.fi.ipynb) |
| [5. Värit ja valon aistiminen](./chapter_05.fi.html) | [pdf](./chapter_05.fi.pdf) | pdf | [html](./tutorials/tutorial04.fi.html) (päivitetty 19.2.2018) | [ipynb](./tutorials/tutorial04.fi.ipynb) |
| [6. Reunat ja nurkat](./chapter_06.fi.html) | [pdf](./chapter_06.fi.pdf) | pdf | [html](./tutorials/tutorial05.fi.html) (päivitetty 24.2.2018) | [ipynb](./tutorials/tutorial05.fi.ipynb) |
| [7. Segmentointi ja klusterointi](./chapter_07.fi.html) | [pdf](./chapter_07.fi.pdf) | pdf | [html](./tutorials/tutorial06.fi.html) (päivitetty 7.3.2018) | [ipynb](./tutorials/tutorial06.fi.ipynb) |
| [8. Skaala-avaruus](./chapter_08.fi.html) | [pdf](./chapter_08.fi.pdf) | pdf | [html](./tutorials/tutorial07.fi.html) (päivitetty 11.3.2018) | [ipynb](./tutorials/tutorial07.fi.ipynb) |
| [9. Pistepiirteet](./chapter_09.fi.html) | [pdf](./chapter_09.fi.pdf) | pdf | [html](./tutorials/tutorial08.fi.html) | ipynb |
| [10. Geometriset muunnokset](./chapter_10.fi.html) | [pdf](./chapter_10.fi.pdf) | pdf | [html](./tutorials/tutorial09.fi.html) | ipynb |
| [11. Videokuva ja optinen vuo](./chapter_11.fi.html) | [pdf](./chapter_11.fi.pdf) | pdf | [html](./tutorials/tutorial10.fi.html) (päivitetty 17.5.2018) | ipynb |
| [12. Tilastollinen analyysi](./chapter_12.fi.html) | [pdf](./chapter_12.fi.pdf) | pdf | [html](./tutorials/tutorial11.fi.html) (päivitetty 23.5.2018) | [ipynb](./tutorials/tutorial11.fi.ipynb) |
| [13. Hahmontunnistus](./chapter_13.fi.html) | [pdf](./chapter_13.fi.pdf) | pdf | [html](./tutorials/tutorial12.fi.html) | ipynb |
| [14. Koneoppiminen ja luokittelu](./chapter_14.fi.html) | [pdf](./chapter_14.fi.pdf) | pdf | [html](./tutorials/tutorial13.fi.html) | ipynb |
| [15. Tilastolliset rakennemallit](./chapter_15.fi.html) | [pdf](./chapter_15.fi.pdf) | pdf | [html](./tutorials/tutorial14.fi.html) | ipynb |
