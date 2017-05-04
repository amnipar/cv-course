---
title: Tutoriaali 8
author: Matti Eskelinen
date: 4.5.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tämän viikon aiheena on pistepiirteet ja skaala-avaruuden soveltaminen pistepiirteiden etsimisessä.

## Shi-Tomasin pistepiirteet

Usein käytetty ja yksinkertainen, tosin jo vanha menetelmä pistemäisten kohteiden etsimiseksi on ja Shin ja Tomasin kehittämä menetelmä. Se on kehitetty nimenomaan kohteiden seuraamista varten, joten kriteerinä on ollut löytää pisteitä, jotka on helppo löytää uudestaan jostakin toisesta kuvasta, esimerkiksi videokuvan seuraavasta ruudusta. Tähän palataan vielä myöhemmässä luvussa.

```{.python}
blur = cv2.GaussianBlur(img, (7,7), 0)

corners = cv2.goodFeaturesToTrack(blur,25,0.01,10)
corners = np.int(corners)
cornerimg = blur.copy()

for i in corners:
    x,y = i.ravel()
    cv2.circle(cornerimg,(x,y),3,255,-1)
```
Kuvaa kannattaa suodattaa, jotta vältetään kohinan aiheuttamat ylimääräiset pisteet.

## SIFT ja SURF

Nykyaikaisempia menetelmiä pistepiirteiden etsimiseksi ovat SIFT ja SURF. SIFT on hyvin suosittu ja tuottaa hyviä tuloksia monien sovelluksien kannalta. Oma henkilökohtainen mielipiteeni on, että SURF tuottaa intuitiivisempia nurkkapisteitä, kun taas SIFT on ehkä enemmän 'möykkyjen' (*blob*) ja pistemäisten kohteiden etsimiseen suuntautuva menetelmä.

```{.python}
sift = cv2.SIFT()
surf = cv2.SURF(300)
kp1 = sift.detect(blur, None)
kp2 = surf.detect(blur, None)
siftimg = cv2.drawKeypoints(blur, kp1, flags=cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
surfimg = cv2.drawKeypoints(blur, kp2, flags=cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
```

Molemmat menetelmät toimivat samaan tapaan. OpenCV:ssä on myös valmis funktio löydettyjen pisteiden visualisoimiseen. Lippu 'rich keypoints' piirtää monipuolisemman esityksen pisteistä, jossa esitetään pisteen skaala ympyrän koon avulla ja pisteympäristön pääasiallinen 'suunta' tai mahdollisesti suunnat viivoilla. Suunta määräytyy pisteen ympäristöstä lasketun gradienttihistogrammin vallitsevien suuntien mukaan.

## Determinant of Hessian

Nurkkapisteiden etsimisen ymmärtämiseksi rakentelemme myös alusta lähtien Hessen matriisin determinanttiin perustuvan menetelmän. Skaalainvarianssin saavuttamiseksi käytetään kuvapyramidia. Affiini-invarianttiuttakin kokeillaan.

Määritellään aluksi funktio, joka laskee Hessen matriisin determinantin pikseli pikseliltä kuvana.

```{.python}
def doh(img):
    blur = cv2.GaussianBlur(img, (3,3), 0)
    Ixx = cv2.Sobel(blur, cv2.CV_32F, 2, 0)
    Iyy = cv2.Sobel(blur, cv2.CV_32F, 0, 2)
    Ixy = cv2.Sobel(blur, cv2.CV_32F, 1, 1)
    detH = Ixx * Iyy - Ixy**2
    return detH
```

Tässä hyödynnetään kuvamatematiikkaa. Derivaatat lasketaan Sobelin operaattorilla yksinkertaisuuden vuoksi.

Tämä on vielä kesken...

## Tehtäviä

Pohdi, voitko hyödyntää pistepiirteitä omassa sovelluksessasi, ja millä tavalla. Kokeile valmiita menetelmiä ja arvioi tuloksia sovelluksesi kannalta. Vaikka et tarvitsikaan pistepiirteitä sovelluksessasi, voit kokeilla menetelmiä kuvillesi ja pohtia tuloksia.
