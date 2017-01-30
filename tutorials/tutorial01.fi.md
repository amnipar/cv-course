% TIES411 Konenäkö ja kuva-analyysi
% Tuomo Rossi ja Matti Eskelinen
% Kevät 2017

# Tutoriaali 1

Ensimmäisessä tutoriaalissa asennetaan Docker Toolbox ja Git, kokeillaan Dockerin toimivuus, luodaan kurssirepo, yhdistetään se voluumiksi Docker-ympäristöön, ja ryhdytään kokeilemaan OpenCV:n käyttämistä omaan harjoitustyöhön liittyvillä kuvilla tai aluksi millä tahansa valituilla kuvilla.

## Docker Toolbox

Docker on työkalu, jolla voidaan luoda vakioituja ohjelmistoympäristöjä virtuaalikoneen sisään. Docker-säiliötä eli *containeria* (jolla viitataan vakioituun rahtikonttiin) voi ajatella hyvin kevyenä virtuaalikoneena, joka tyypillisesti suorittaa yhtä rajattua tehtävää. Windowsissa ja Macissa säiliöitä suoritetaan esimerkiksi Virtualbox-virtuaalikoneen sisällä, mutta Linuxissa käskyt periaatteessa ajetaan suoraan isäntälaitteistolla ilman välikerroksia.

Tällä kurssilla Dockerin tarkoituksena on ennen kaikkea helpottaa ohjelmointiympäristön hallintaa ja ongelmatilanteiden selvittelyä. Erityisesti Linux-käyttäjät voivat toki käyttää itse rakentamiaan ympäristöjä, mutta ongelmatilanteissa apua voi olla vaikeampi tarjota ellei ongelmaa saada toistettua Docker-ympäristössä; ohjausresurssit eivät tähän riitä.

* Lataa Docker Toolbox osoitteesta <https://www.docker.com/products/docker-toolbox>
* Seuraa asennusohjelman ohjeita; asenna myös Virtualbox ja Git (Bash-versio jos sitä kysytään)
* Kun asennus on valmis, suorita komento *Docker Quickstart Terminal*
* Kun Docker on käynnistynyt (valaan kuva tulee ruutuun) suorita seuraava komento:

```sh
$ docker run hello-world
```

Tällä tavoin voit varmistaa asennuksen onnistuneen ja Dockerin toimivan kuten pitää.

## Harjoitustyörepo

Viimeistään tässä vaiheessa pitäisi luoda yousource-repo harjoitustyölle cv-2017 -projektin alle. Jos et ole sitä vielä tehnyt, lähetä yousource-tunnuksesi luennoijalle, jotta sinut voidaan lisätä projektin kollaboraattoreihin. Kun tämä on tehty, pääset luomaan repon.

* Kirjaudu yousourceen
* Mene osoitteeseen <https://yousource.it.jyu.fi/cv-2017>
* Käytä toimintoa *Add Repository*
* Esimerkkirepo löytyy osoitteesta <https://yousource.it.jyu.fi/cv-2017/ht-esim>
* Kloonaa reposi omalle koneellesi *jonnekin käyttäjähakemiston alle*(!!)
* Esimerkiksi `C:\Users\Nimi\ht-nimi`

Repon polulla on merkitystä Dockerin kannalta Windows- ja Mac-koneilla. Käyttäjähakemiston alta repohakemiston liittäminen voluumiksi Docker-säiliön sisään pitäisi onnistua vaivattomasti. Jos hakemisto on muualla, tämä voi olla hankalaa.

## Käynnistä cv-image Dockeriin ja kokeile OpenCV:tä

Kurssin ohjelmointiympäristöä varten on luotu Docker-image, jonka osoite Docker Hubissa on <https://hub.docker.com/r/amnipar/cv/> ja Githubissa <https://github.com/amnipar/cv-dockerfile>. Saat sen käyttöön Dockerissa komennolla


```sh
$ docker pull amnipar/cv
```

ja seuraavalla komennolla pääset ajamaan komentoja säiliön sisällä siten, että harjoitustyöreposi sisältö on liitetty polkuun `/source`:

```sh
$ docker run --rm -it -v /c/Users/.../ht-repo:/source amnipar/cv
```

Huomaa, että harjoitustyörepon polku pitää kirjoittaa oikein. Tässä on käytetty Windows-koneen oletusasennuksen ymmärtämää muotoa MINGW:n Bash-konsolin sisällä.

Kun komentokonsoli aukeaa säiliön sisään (esimerkiksi `root@07f0a0281367:/source# `) voit suorittaa komentoja harjoitustyökansiosi sisällä oleville tiedostoille. Ympäristössä voi myös ohjelmoida C:llä (ja C++:lla), Javalla, Pythonilla ja Haskellilla käyttäen OpenCV-kirjastoa. Seuraavassa yksinkertaisin mahdollinen esimerkki kullakin kielellä.

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

Nyt meillä on yksinkertainen perusympäristö neljälle eri ohjelmointikielelle. Valitse niistä yksi sen mukaan, mitä osaat parhaiten. Python on hyvä vaihtoehto, koska sillä on ehkä yksinkertaisinta saada toimivaa koodia aikaan. Kurssin aikana rakennamme vähitellen yhä monipuolisempia komentorivityökaluja kokeilujen tekemiseksi harjoitustyöhön liittyvillä kuvilla.

Kirjoita harjoitustyörepoosi lyhyt selostus harjoitustyöaiheestasi; millaisia kuvia aiot tutkia ja mitä haluaisit saada niillä aikaan.

Lisää harjoitustyörepoosi muutama esimerkkikuva aiheeseesi liittyen. Lisää sinne myös yksinkertainen kooditiedosto valitsemaasi kieltä varten. Varmista, että yksinkertainen koodi toimii. Sen jälkeen tee kokeiluja *core*-moduulista löytyvillä
[matemaattisilla operaatioilla](http://docs.opencv.org/2.4.13/modules/core/doc/operations_on_arrays.html). Yritä saada jotakin näkyvää aikaan. Voit myös yrittää generoida apukuvia vakioarvoilla.

Toistaiseksi ympäristössä käytetään OpenCV:n versiota 2.4.13.2. Uudemmassa 3-versiossa on joitakin uusia ominaisuuksia, ja tarkoitus oli ottaa käyttöön versio 3.2, mutta eri ohjelmointikielien rajapinnat eivät vielä kunnolla tue kolmosversioita. Pythonista on käytössä versio 2.7. Javasta on käytössä openjdk-8.

Dokumentteja:

* <http://docs.opencv.org/2.4.13/>
*<http://docs.opencv.org/2.4.13.2/doc/tutorials/tutorials.html>
* <http://docs.opencv.org/java/2.4.11/>
* <https://opencv-python-tutroals.readthedocs.io/en/latest/>
* <http://aleator.github.io/CV/dist/doc/html/CV/index.html> (Haskell)
