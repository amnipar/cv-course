---
title: Tutoriaali 2
author: Matti Eskelinen
date: 14.1.2018
title-prefix: TIES411
lang: fi
css: style.css
---

Ensimmäisen tutoriaalin jälkeen olemme saaneet Docker-ympäristön käyttöön ja saamme suoritettua siinä OpenCV-kirjastoa hyödyntävää koodia. Tällä kerralla ryhdymme opettelemaan erilaisten perusoperaatioiden käyttämistä kuvien suodattamiseen ja yksinkertaiseen muokkaamiseen.

Tämä tutoriaali laajenee vielä muilla esimerkeillä ja myös kynnystysmenetelmillä.

## Python-esimerkki

Luodaan kansioon *tutorial02* tiedosto *tutorial02.py* ja kokeillaan suodatusoperaatioiden käyttämistä:

```{.python}
import cv2
import numpy

img = cv2.imread("../images/rect2.png", cv2.IMREAD_GRAYSCALE)
kernel = numpy.ones((5,5), numpy.float32) / 25
dst = cv2.filter2D(img, -1, kernel)
blur = cv2.GaussianBlur(img, (5,5), 0)
cv2.imwrite("../images/result.png", dst)
cv2.imwrite("../images/blur.png", blur)

```

## Haskell-esimerkki

Haskellilla saa tehtyä samantapaiset operaatiot kirjoittamalla seuraavan tiedostoon *tutorial02.hs*:

```{.haskell}
{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import CV.Image
import CV.Filters
import CV.Matrix as Mat

main = do
  let
    center :: (Int,Int)
    center = (1,1)
    kernel = [ 1, 0, -1,
             1, 0, -1,
             1, 0, -1 ]
    size = (3,3)
  img :: Image GrayScale D32  <- readFromFile "../images/rect1.png"
  saveImage "../images/result.png" $ 
      convolve2D (Mat.fromList size kernel) center img
  saveImage "../images/blur.png" $ gaussian (9,9) $ img
```

Haskellilla on näppärää ketjuttaa operaatioita funktionaalisesti, mutta erittäin tiukan tyyppitarkistuksen takia täytyy toisinaan tehdä yksiselitteisiä tyyppimerkintöjä, kuten yllä arvon *center* kanssa.

## Tehtäviä

Muillakin kielillä saa tehtyä vastaavat operaatiot OpenCV:n imgproc-moduulin toiminnoilla.

Kokeile erilaisia suodatus- ja kynnystysoperaatioita omilla kuvillasi. Kirjoita ylös havaintojasi. Kuinka paljon kuviasi pitää suodattaa, jotta kohinaa saadaan vähennettyä riittävästi? Saako kuvista erotettua mitään hyödyllistä kynnystämällä? Millä tavalla tulosta pitäisi jälkikäsitellä?

Dokumentteja:

* <http://docs.opencv.org/2.4.13.2/doc/tutorials/imgproc/gausian_median_blur_bilateral_filter/gausian_median_blur_bilateral_filter.html>
* <https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_imgproc/py_filtering/py_filtering.html>


Tämä on vielä kesken.
