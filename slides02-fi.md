% TIES411 Konenäkö ja kuva-analyysi
% Tuomo Rossi ja Matti Eskelinen
% Kevät 2017

## Konvoluutio

* Kuvaa järjestelmien vasteita syötteisiin
* Eräänlainen painotettu keskiarvo
* Tuottaa funktioista $f$ ja $g$ kolmannen funktion:

$$(f \ast g)(x) = \int_{-\infty}^{\infty}f(y)g(x-y)dy$$

## Diskreetti konvoluutio

* Integraali muuttuu summaksi
* Intuitiivinen ajattelutapa:
    - peilataan toinen signaali: $g(-i)$
    - siirretään käännettyä signaalia $x$ askelta: $g(x-i)$
    - kerrotaan keskenään vastinalkiot ja lasketaan tulot yhteen.

$$(f \ast g)(x) = \sum_{i}f(i) g(x-i)$$

## Suodatus

* Signaalin konvolvointia sopivalla suodinmaskilla
* Esimerkiksi keskiarvosuodin kohinanpoistoon
* Gaussinen suodin sopii *alipäästösuotimeksi*:

$$G(\sigma,x) = \frac{1}{\sqrt{2 \pi \sigma^2}} e^{-\frac{x^2}{2 \sigma^2}}$$

## Konvoluution reunakäyttäytyminen

* Konvoluution käyttäytyminen signaalin 'reunalla' on epämääräinen
* Käyttäjän on otettava jollakin lailla kantaa siihen, kuinka signaali jatkuu
  reunan yli; joitakin yleisiä tapoja ovat
    - jätetään reunimmaiset alkiot huomiotta -- signaali kutistuu
    - käytetään vakioarvoa, esimerkiksi $0$ -- aiheuttaa hyppäyksen
    - jatketaan signaalia samalla arvolla kuin reunassa tai vaimennetaan se
      vähitellen nollaan
    - kierrytään takaisin toiseen päähän -- voi olla ongelmallista

## Konvoluutio, korrelaatio ja sisätulo

* sisätulo: $(f \cdot g) = \sum_{i=1}^{n}f_i g_i$
* korrelaatio: $(f \star g)(j) = \sum_{i=1}^{n}f_i g_{i+j}$
* konvoluutio: $(f \ast g)(j) = \sum_{i=1}^{n}f_i g_{j-i}$
* $f(t) \star g(t) = f(t) \ast g(-t)$

## Konvoluution tärkeimpiä ominaisuuksia

* *Assosiatiivisuus*:  $f_1 \ast (f_2 \ast f_3) = (f_1 \ast f_2) \ast f_3$
* *Kommutatiivisuus*:  $f_1 \ast f_2 = f_2 \ast f_1$
* *Distributiivisuus*: $f_1 \ast (f_2+f_3) = f_1 \ast f_2 + f_1 \ast f_3$
* *Konvoluutio impulssifunktiolla*: $f \ast \delta = f$

## Kaksiulotteinen konvoluutio ja kuvien suodatus

$$(f \ast g)(x,y) = \sum_{i,j} f(i,j) g(x-i,y-j)$$

Esimerkiksi Gaussinen suodatusmaski:

$$G_g = \left[\begin{array}{ccccc}
  0.0007 & 0.0063 & 0.0129 & 0.0063 & 0.0007 \\
  0.0063 & 0.0543 & 0.1116 & 0.0543 & 0.0063 \\
  0.0129 & 0.1116 & 0.2292 & 0.1116 & 0.0129 \\
  0.0063 & 0.0543 & 0.1116 & 0.0543 & 0.0063 \\
  0.0007 & 0.0063 & 0.0129 & 0.0063 & 0.0007
  \end{array}\right]$$

## Kynnystyksen parantelua

* Kohde voi olla tumma tai vaalea, ja joskus on tarpeen kynnystää arvoihin
  $[-1,+1]$.
* $T_{(0,1)}\left(t,I\right)(x,y)$: kynnysarvoa pienempi saa arvon $0$
* $T_{(1,0)}\left(t,I\right)(x,y)$: kynnysarvoa pienempi saa arvon $1$
* $T_{(-1,+1)}\left(t,I\right)(x,y)$: kynnysarvoa pienempi saa arvon $-1$
* $T_{(+1,-1)}\left(t,I\right)(x,y)$: kynnysarvoa pienempi saa arvon $+1$

## Morfologiset operaatiot

* Käytetään kynnystetyn kuvan korjailuun
* Konvolvoidaan binäärisellä maskilla ja kynnystetään lopputulos

$$m(s,I,t) = T_{(0,1)}(t,I \ast s)$$

## Erilaisia morfologisia operaatioita

* *laajentaminen* (*dilation*): $\text{dilate}(s,I) = m(s,I,1)$
* *kuluttaminen* (*erosion*): $\text{erode}(s,I) = m(s,I,sum(s))$
* *avaaminen* (*opening*):
  $\text{open}(f,s) = \text{dilate}(s,\text{erode}(s,I))$
* *sulkeminen* (*closing*):
  $\text{close}(f,s) = \text{erode}(s,\text{dilate}(s,I))$

## Hit-or-miss

* Etsitään kuvasta tietyn maskin mukaisia kohteita
* Osa maskin alkioista voi olla *mielivaltaisia*
* Suoritetaan konvoluutio maskilla $T_{(-1,+1)}$-kynnystetylle kuvalle
* Kynnystetään tulos $T_{(0,1)}$-kynnystyksellä käyttäen maskin alkioiden
  itseisarvojen summaa kynnysarvona
* *Thinning* tarkoittaa *hit-or-miss*-operaation löytämien pikselien poistamista
  kohteesta

$$\text{hit-or-miss}(I,s) = m(s,I,sum(abs(s)))$$

## Skeleton

* Etsitään binääristen kohteiden keskiviiva
* Ohennetaan kuvaa toistuvasti *thinning*-operaatiolla kunnes poistettavia
  pikseleitä ei enää ole
* Lopputulosta täytyy usein korjailla, sillä luurankoon saattaa jäädä pieniä
  ylimääräisiä haarakkeita
