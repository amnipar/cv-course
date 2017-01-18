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

Kun komentokonsoli aukeaa säiliön sisään (esimerkiksi `root@07f0a0281367:/source# `) voit suorittaa komentoja harjoitustyökansiosi sisällä oleville tiedostoille. Voit esimerkiksi luoda tiedoston *tutorial01.c*

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

ja kääntää sen komentoriviltä komennoilla

```sh
root@07f0a0281367:/source# gcc -c -o tutorial01.o tutorial01.c
root@07f0a0281367:/source# gcc -o tutorial01 tutorial01.o -lopencv_core -lopencv_highgui
root@07f0a0281367:/source# ./tutorial01
```

tuloksena pitäisi syntyä tiedosto *result.png* harjoitustyöhakemistoosi.

Docker-ympäristöön lisätään piakkoin tuki myös muille ohjelmointikielille kuin c, ainakin python, java ja haskell, mutta tämä työ on vielä keskeneräinen. Siihen asti voit tutkia OpenCV:n dokumentteja ja C-apia ja kokeilla erilaisia operaatioita kuvillesi.

Tämä tutoriaalitekstikin tulee vielä päivittymään.

* Dokumentteja esim. <http://docs.opencv.org/3.2.0/>
