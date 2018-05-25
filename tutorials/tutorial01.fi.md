---
title: Tutoriaali 1
author: Matti Eskelinen
date: 16.1.2018
title-prefix: TIES411
lang: fi
css: style.css
---

Ensimmäisessä tutoriaalissa asennetaan Docker Toolbox ja Git, kokeillaan
Dockerin toimivuus, luodaan kurssirepo, yhdistetään se voluumiksi Docker-
ympäristöön, ja ryhdytään kokeilemaan OpenCV:n käyttämistä omaan harjoitustyöhön
liittyvillä kuvilla tai aluksi millä tahansa valituilla kuvilla.

## Docker Toolbox

Docker on työkalu, jolla voidaan luoda vakioituja ohjelmistoympäristöjä
virtuaalikoneen sisään. Docker-säiliötä eli *containeria* (jolla viitataan
vakioituun rahtikonttiin) voi ajatella hyvin kevyenä virtuaalikoneena, joka
tyypillisesti suorittaa yhtä rajattua tehtävää. Windowsissa ja Macissa säiliöitä
suoritetaan esimerkiksi Virtualbox-virtuaalikoneen sisällä, mutta Linuxissa
käskyt periaatteessa ajetaan suoraan isäntälaitteistolla ilman välikerroksia.

Tällä kurssilla Dockerin tarkoituksena on ennen kaikkea helpottaa
ohjelmointiympäristön hallintaa ja ongelmatilanteiden selvittelyä. Erityisesti
Linux-käyttäjät voivat toki käyttää itse rakentamiaan ympäristöjä, mutta
ongelmatilanteissa apua voi olla vaikeampi tarjota ellei ongelmaa saada
toistettua Docker-ympäristössä; ohjausresurssit eivät tähän riitä.

* Lataa Docker Toolbox osoitteesta <https://docs.docker.com/toolbox/overview/>
* Joissakin ympäristöissä voi käyttää Docker CE -jakelua <https://www.docker.com/community-edition>
* Seuraa asennusohjelman ohjeita; asenna myös Virtualbox ja Git (Bash-versio jos sitä kysytään) jos niitä ei jo ole asennettuna
* Kun asennus on valmis, suorita komento *Docker Quickstart Terminal*
* Kun Docker on käynnistynyt (valaan kuva tulee ruutuun) suorita seuraava komento:

```sh
$ docker run hello-world
```

Tällä tavoin voit varmistaa asennuksen onnistuneen ja Dockerin toimivan kuten
pitää.

## Anaconda

Tänä vuonna vaihtoehtoisena ohjelmointiympäristönä voi käyttää Anaconda-jakelua.
Se on Python-jakelu, joka sisältää valmiita työkaluja sekä
paketinhallintatyökalun nimeltä conda. Sillä on hyvin helppo käyttää monia
nykyaikaisia data-analyysin työkaluja ja kirjastoja, kuten NumPy, SciKit ja
TensorFlow. Siinä on myös Jupyter Notebook -ympäristö, jossa voi suorittaa
python-koodia ja visualisoida tuloksia selaimessa.

* Lataa Anaconda-jakelu osoitteesta <https://www.anaconda.com/download/>
* Seuraa asennusohjelman ohjeita
* Kun asennus on valmis, suorita komento *Anaconda Prompt*
* Avautuvassa komentoikkunassa voit asennella paketteja esimerkiksi komennolla 'conda install numpy scikit opencv'
* Suorita sitten komento *Jupyter Notebook*
* Tämä käynnistää web-palvelimen joka tarjoaa IPython Notebook -työkirjojen hallintaympäristön; voit avata .ipynb-tiedostoja tai luoda uusia valitsemalla New > Python 3.
* Avautuvassa työkirjassa voit kirjoittaa python-koodia soluihin ja suorittaa koodin painamalla shift+enter. Soluihin voi kirjoittaa myös markdown-tekstiä muuttamalla solun tyyppiä.
* Jäljempänä koodiesimerkeissä vinkkejä OpenCV:n käyttämiseen työkirjoissa.

## Harjoitustyörepo

Viimeistään tässä vaiheessa olisi hyvä luoda yousource-repo harjoitustyölle
cv-2018 -projektin alle. Jos et ole sitä vielä tehnyt, lähetä yousource-
tunnuksesi luennoijalle, jotta sinut voidaan lisätä projektin
kollaboraattoreihin. Kun tämä on tehty, pääset luomaan repon.

Harjoitustyötä ei ole pakko laittaa kurssin yousource-projektiin, mutta se on
suositeltavaa, jotta muutkin voivat halutessaan ottaa oppia tuotoksistasi. On
kuitenkin mahdollista tehdä myös yksityinen repo yousourceen tai muualle, kunhan
tuotokset toimittaa ajoittain ohjaajalle.

* Kirjaudu yousourceen
* Mene osoitteeseen <https://yousource.it.jyu.fi/cv-2018>
* Käytä toimintoa *Add Repository*
* Esimerkkirepo löytyy osoitteesta <https://yousource.it.jyu.fi/cv-2018/ht-esim>
* Kloonaa reposi omalle koneellesi *jonnekin käyttäjähakemiston alle*(!!)
* Esimerkiksi `C:\Users\Nimi\ht-nimi`

Repon polulla on merkitystä Dockerin kannalta Windows- ja Mac-koneilla.
Käyttäjähakemiston alta repohakemiston liittäminen voluumiksi Docker-säiliön
sisään pitäisi onnistua vaivattomasti. Jos hakemisto on muualla, tämä voi olla
hankalaa.

## Käynnistä cv-image Dockeriin ja kokeile OpenCV:tä

Kurssin ohjelmointiympäristöä varten on luotu Docker-image, jonka osoite Docker
Hubissa on <https://hub.docker.com/r/amnipar/cv/> ja Githubissa
<https://github.com/amnipar/cv-dockerfile>. Saat sen käyttöön Dockerissa
komennolla


```sh
$ docker pull amnipar/cv
```

ja seuraavalla komennolla pääset ajamaan komentoja säiliön sisällä siten, että
harjoitustyöreposi sisältö on liitetty polkuun `/source`:

```sh
$ docker run --rm -it -v /c/Users/.../ht-repo:/source amnipar/cv
```

Huomaa, että harjoitustyörepon polku pitää kirjoittaa oikein. Tässä on käytetty
Windows-koneen oletusasennuksen ymmärtämää muotoa MINGW:n Bash-konsolin sisällä.

Kun komentokonsoli aukeaa säiliön sisään (esimerkiksi
`root@07f0a0281367:/source# `) voit suorittaa komentoja harjoitustyökansiosi
sisällä oleville tiedostoille. Ympäristössä voi myös ohjelmoida C:llä (ja
C++:lla), Javalla, Pythonilla ja Haskellilla käyttäen OpenCV-kirjastoa.
Seuraavassa yksinkertaisin mahdollinen esimerkki kullakin kielellä.

## C-esimerkki

Luodaan kansioon *tutorial01* tiedosto *tutorial01.c*:

```{.c}
#include <opencv2/core/core_c.h>
#include <opencv2/highgui/highgui_c.h>

int main(void) {
	IplImage *img;
	img = cvLoadImage("../images/rect.png", CV_LOAD_IMAGE_GRAYSCALE);
	cvSaveImage("../images/result.png", img, 0);
	cvReleaseImage(&img);
	return 0;
}
```

ja käännetään ja suoritetaan se komentoriviltä komennoilla

```sh
$ gcc -Wall -o tutorial01 tutorial01.c -lopencv_core -lopencv_highgui
$ ./tutorial01
```

tuloksena pitäisi syntyä tiedosto *result.png* harjoitustyöhakemistoosi.

## Java-esimerkki

Luodaan kansioon *tutorial01* tiedosto *tutorial01.java*:

```{.java}
import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.highgui.Highgui;

public class tutorial01 {
	public static void main(String[] args) {
		System.setProperty("java.library.path", "/usr/lib/jni/libopencv_java2413.so");
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

		Mat img = Highgui.imread("../images/rect.png", Highgui.IMREAD_GRAYSCALE);
		Highgui.imwrite("../images/result.png", img);
	}
}
```

ja käännetään ja suoritetaan se komentoriviltä komennoilla

```sh
$ javac -cp '.:/usr/share/java/opencv.jar' tutorial01.java
$ java -cp '.:/usr/share/java/opencv.jar' tutorial01
```

Lopputuloksen pitäisi olla sama kuin C-ohjelmalla.

## Python-esimerkki

Luodaan kansioon *tutorial01* tiedosto *tutorial01.py*:

```{.python}
import cv2

img = cv2.imread("../images/rect.png", cv2.IMREAD_GRAYSCALE)
cv2.imwrite("../images/result.png", img)
```

jota ei tarvitse kääntää, vaan sen voi suorittaa komentoriviltä komennolla

```sh
root@07f0a0281367:/source# python tutorial01.py
```

ja lopputulos on edelleen sama.

Jos käytät Jupyter Notebookia Anaconda-ympäristössä ja olet asentanut opencv:n
komennolla 'conda install opencv', yllä oleva koodi toimii sellaisenaan. Polku
on suhteessa hakemistoon, johon työkirja on luotu.

Jos haluat liittää kuvan suoraan työkirjaan, lisää alkuun

```{.python}
import matplotlib.pyplot as plt
%matplotlib inline
```

Jälkimmäinen komento vaaditaan, jotta matplotlib-visualisointikirjasto voi
piirtää suoraan työkirjan näkymään eikä erilliseen ikkunaan.

Sitten saat piirrettyä kuvan komennoilla

```{.python}
plt.xticks(())
plt.yticks(())
i = plt.imshow(img, cmap="gist_gray")
```

Kaksi ensimmäistä piilottaa kaavion akselien merkinnät - pyplot on kirjasto
erilaisten diagrammien piirtämiseen, joten se piirtää oletuksena kuvan reunoihin
koordinaattiakselit. Parametrillä cmap voi säätää harmaasävykuvan väritystä.
Komento skaalaa kuvan arvot välille $[0,1]$ kuvassa esiintyvien minimi- ja
maksimiarvojen mukaan, joten jos kuvan kirkkauserot vääristyvät, voi olla syytä
normalisoida kuva itse. Värikuvien pitäisi näkyä normaalisti, kun taas
harmaasävykuville käytetään diagrammin yleistä värikarttaa, joka asetetaan cmap-
parametrilla.

## Haskell-esimerkki

Luonaan kansioon *tutorial01* tiedosto *tutorial01.hs*:

```{.haskell}
{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import CV.Image

main = do
  img :: Image GrayScale D8  <- readFromFile "../images/rect.png"
  saveImage "../images/result.png" img
```

jonka voi kääntää ja suorittaa komentoriviltä komennoilla

```sh
$ ghc --make tutorial01.hs
$ ./tutorial01
```
samalla lopputuloksella.

## Tehtäviä

Nyt meillä on yksinkertainen perusympäristö neljälle eri ohjelmointikielelle.
Valitse niistä yksi sen mukaan, mitä osaat parhaiten. Python on hyvä vaihtoehto,
koska sillä on ehkä yksinkertaisinta saada toimivaa koodia aikaan. Kurssin
aikana rakennamme vähitellen yhä monipuolisempia komentorivityökaluja kokeilujen
tekemiseksi harjoitustyöhön liittyvillä kuvilla.

Kirjoita harjoitustyörepoosi lyhyt selostus harjoitustyöaiheestasi; millaisia
kuvia aiot tutkia ja mitä haluaisit saada niillä aikaan.

Lisää harjoitustyörepoosi muutama esimerkkikuva aiheeseesi liittyen. Lisää sinne
myös yksinkertainen kooditiedosto valitsemaasi kieltä varten. Varmista, että
yksinkertainen koodi toimii. Sen jälkeen tee kokeiluja *core*-moduulista
löytyvillä [matemaattisilla operaatioilla](http://docs.opencv.org/2.4.13/modules
/core/doc/operations_on_arrays.html). Yritä saada jotakin näkyvää aikaan. Voit
myös yrittää generoida apukuvia vakioarvoilla.

Toistaiseksi ympäristössä käytetään OpenCV:n versiota 2.4.13.2. Uudemmassa
3-versiossa on joitakin uusia ominaisuuksia, ja tarkoitus oli ottaa käyttöön
versio 3.2, mutta eri ohjelmointikielien rajapinnat eivät vielä kunnolla tue
kolmosversiota. Pythonista on käytössä versio 2.7. Javasta on käytössä
openjdk-8.

Docker-imagea on tarkoitus päivittää lähiaikoina ja mahdollisuuksien mukaan
ottaa käyttöön uudempia versioita työkaluista.

Dokumentteja:

* <http://docs.opencv.org/2.4.13/>
* <http://docs.opencv.org/2.4.13.2/doc/tutorials/tutorials.html>
* <http://docs.opencv.org/java/2.4.11/>
* <https://opencv-python-tutroals.readthedocs.io/en/latest/>
* <http://aleator.github.io/CV/dist/doc/html/CV/index.html> (Haskell)
