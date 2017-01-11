% TIES411 Konenäkö ja kuva-analyysi
% Tuomo Rossi ja Matti Eskelinen
% Kevät 2017

## Kuvanmuodostus

* Kuva on kolmiulotteisen näkymän kaksiulotteinen *projektio* eli *heijastuma*
* Jatkuva kuva *näytteistetään* epäjatkuvaksi tallenteeksi
* Kuva voidaan tulkita *signaalina*

## Signaali

* Signaalit kuvaavat fysikaalisten suureiden *vaihtelua*
* Vaihtelu tapahtuu *ajan* suhteen, joskus myös *tilan* suhteen
* Vaihtelua voidaan kuvata summana eri taajuuksilla tapahtuvista säännöllisistä
  vaihteluista

![Signaali](images/frequency-components.png)

## Näytteistys

* Näytteistys on jatkuvan signaalin tallentamista diskreettinä joukkona
  näytepisteitä
* Kuvien näytteistystä tehdään sekä ajassa että tilassa
* Sopiva näytteistystaajuus riippuu signaalin muutostaajuudesta

![Signaalin näytteistys](images/sampling.png)

## Aliasoituminen

* Tarkoittaa taajuuskomponenttien *sekoittumista* liian alhaisen
  näytteistystaajuuden vuoksi
* Kuvaan syntyy taajuuksia joita siinä ei oikeasti ole
* Tapahtunut vahinko on peruuttamaton

![Aliasoitunut kuva](images/aliasing.png)

## Interpolointi

* Jatkuvan signaalin *palauttaminen* näytteistä
* Yksityiskohtien määrä riippuu näytteistystaajuudesta
* Nopeat muutokset on poistettava suodattamalla tai sitten on nostettava
  näytteistystaajuutta

![Lineaarisesti interpoloitu signaali](images/linear-interpolated.png)

## Whittaker-Shannon interpolointi

$$x(t) = \sum_{n=-\infty}^{\infty}x(nT) \cdot sinc\left(\frac{t-nT}{T}\right)$$

![$sinc(x)$](images/sinc.png)

## Tulos

![Interpoloitu sinc-funktion avulla](images/sinc-interpolated-comparison.png)

## Uudelleennäytteistys

* Joskus on tarpeen näytteistää uudelleen eri taajuudella
* Esim. kuvien pienentäminen
* Kutsutaan *uudelleennäytteistykseksi*
* Vaatii nopeiden muutosten suodattamista aliasoitumisen välttämiseksi

## Kuvien esitysmuodot

* Signaali
* Funktio
* Vektori
* Graafi

## Kuvamatematiikkaa

* Hyödynnetään kuvien vektoritulkintaa
* Alkioittaiset operaatiot toisen (samankokoisen) kuvan tai skalaarin kanssa
* Yhteenlasku, kertolasku, vähennyslasku
* Mutta myös skalaarifunktiot kuten neliöjuuri, exp, log

## Kynnystäminen

* Pakotetaan pikselit valkoisiksi tai mustiksi sen mukaan ovatko ne pienempiä
  vai suurempia kuin kynnysarvo $t$
* Kutsutaan myös *binärisöinniksi*, koska tuloksena on kaksivärinen kuva

$$T\left(t,I\right)(x,y)=\begin{cases}
                         1, &\text{ jos } I(x,y) < t\\
                         0, &\text{ muuten,}
                        \end{cases}$$
