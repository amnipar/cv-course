---
title: Tutoriaali 5
author: Matti Eskelinen
date: 1.3.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tällä kerralla ryhdymme kokeilemaan reunojen etsimistä kuvista. Aiheeseen palataan vielä skaala-avaruuksien yhteydessä, ja reunakäyrien piirteytykseen tunnistamistarkoituksiin tutustumme kurssin loppupuolella.

## Gradientin muodostaminen

Perinteinen, edelleen melko yleisesti käytetty tapa gradientin laskemiseen on Sobelin operaattoreilla konvolvoiminen:

<http://docs.opencv.org/2.4.13/modules/imgproc/doc/filtering.html#sobel>

Pythonilla sen voi tehdä näin:

```{.python}
gx = cv2.Sobel(img, cv2.CV_32F, 1, 0)
gy = cv2.Sobel(img, cv2.CV_32F, 0, 1)
mag, ang = cv2.cartToPolar(gx, gy)
```

Tuloksena on gradienttikentän esitys napakoordinaatistossa: kuvassa *mag* on gradientin magnitudi ja kuvassa *ang* gradientin suunta.

## Cannyn reunanhaku

Kapean reunakäyrän hankkimiseksi voidaan kynnystää magnitudikuva ja ohentaa morfologisilla operaatioilla yhden pikselin levyisiksi. Tehokkaampi ja erittäin yleisesti käytetty tapa on Cannyn menetelmä:

<http://docs.opencv.org/2.4.13/modules/imgproc/doc/feature_detection.html#canny>

Operaatio on helppokäyttöinen:

```{.python}
blur = cv2.GaussianBlur(img, (5, 5), 0)
edges = cv2.Canny(blur,100,200)
```

Kuvan sopiva siloittaminen on tärkeää, jotta vältetään ylimääriset reunat kohinan takia. Kahta kynnysarvoparametria voi joutua säätämään sovellus- tai jopa kuvakohtaisesti.

## Derivaattamaskit

Derivaattoja voi etsiä myös suodattamalla erilaisilla derivaattamaskeilla. Esimerkiksi toisen asteen derivaattamaskit saa luotua komennolla

```{.python}
kdx2x,kdx2y = cv2.getDerivKernels(dx=2, dy=0, ksize=7, ktype=cv2.CV_32F, normalize=1)
kdy2x,kdy2y = cv2.getDerivKernels(dx=0, dy=2, ksize=7, ktype=cv2.CV_32F, normalize=1)
```

Nämä ovat separoituvia kerneleitä, joita käytetään konvolvoimalla yksiulotteisesti ensin riveittäin, sitten sarakkeittain; operaation saa tehtyä yhdellä komennolla seuraavasti:

```{.python}
dx2 = cv2.sepFilter2D(np.float32(img), ddepth=cv2.CV_32F, kernelX=kdx2x, kernelY=kdx2y)
dy2 = cv2.sepFilter2D(np.float32(img), ddepth=cv2.CV_32F, kernelX=kdy2x, kernelY=kdy2y)
```

Toisen asteen derivaatat saa laskettua myös Sobelin operaatiolla antamalla derivaatalle korkeamman asteen parametreilla:

```{.python}
gx2 = cv2.Sobel(img, cv2.CV_32F, dx=2, dy=0)
gy2 = cv2.Sobel(img, cv2.CV_32F, dx=0, dy=2)
```

Laplacian of Gaussian -operaation tulos saadaan laskemalla yhteen kuvat, jotka saadaan suodattamalla näillä derivaattamaskeilla. Saman saa tehtyä myös suoraan komennolla

```{.python}
log = cv2.Laplacian(img, apertureSize=5)
```

Myöhemmin lisää koodiesimerkkejä nurkkien etsimisestä.

## Tehtäviä

Kokeile reunanhakuoperaatioita omilla kuvillasi, ja etsi sopivia parametreja joilla saat tärkeitä reunoja esiin kuvistasi. Pohdi myös tulosten jatkojalostamista sovelluksesi kannalta.

Kokeile Harrisin vastefunktion ja Hessen matriisin determinantin laskemista jokaiselle kuvan pikselille käyttäen suodatusta sekä kuvien matemaattisia operaatioita.
