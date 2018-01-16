---
title: Tutoriaali 3
author: Matti Eskelinen
date: 14.1.2018
title-prefix: TIES411
lang: fi
css: style.css
---

Tällä kertaa kokeilemme Fourier-muunnoksen laskemista kuvalle, tutkimme tuloksia ja kokeilemme erilaisten operaatioiden vaikutuksia lopputulokseen.

## Python-esimerkki

Kirjoittamalla js suorittamalla seuraavan koodin ohjelmointiympäristössä saat kokeiluta Fourier-muunnoksen laskemista. Muista muokata kuvien polkuja siten, että ne vastaavat sinun ympäristössäsi olevia kuvia.

```{.python}
import cv2
import numpy as np

img = cv2.imread("../images/rect2.png", cv2.IMREAD_GRAYSCALE)
dft = cv2.dft(np.float32(img), flags = cv2.DFT_COMPLEX_OUTPUT)
cv2.imwrite("../images/real.png", cv2.equalizeHist(np.uint8(dft[:,:,0])))
cv2.imwrite("../images/imag.png", cv2.equalizeHist(np.uint8(dft[:,:,1])))
dft_shift = np.fft.fftshift(dft)
mag = cv2.magnitude(dft_shift[:,:,0], dft_shift[:,:,1])
phase = cv2.phase(dft_shift[:,:,0], dft_shift[:,:,1])
cv2.imwrite("../images/mag.png", cv2.equalizeHist(np.uint8(20*np.log(mag))))
cv2.imwrite("../images/phase.png", cv2.equalizeHist(np.uint8(phase)))
```

## Tehtäviä

Kokeile erilaisilla kuvilla. Näkyykö tuloksessa mitään mielenkiintoista? Kokeile sitten esimerkiksi Gaussisella suotimella pehmennetyllä kuvalla. Näkyykö eroa? Voit myös kokeilla vaihtaa keskenään kahden eri kuvan vaihekomponentin ja tutkia tuloksia. Minkälainen on tulos, jos magnitudi on vakio ja vaihe satunnainen?
