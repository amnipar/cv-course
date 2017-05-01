---
title: Tutoriaali 4
author: Matti Eskelinen
date: 22.2.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tällä kerralla tutkitaan värikuvia ja kokeillaan monikanavaisten kuvien hajottamista osakanaviin ja kokoamista takaisin. Opimme myös muuntamaan kuvia väriavaruuksista toisiin.

## Värimuunnokset

Kokeile värimuunnoksia valitsemallasi kielellä käyttäen operaatiota cvtColor:

<http://docs.opencv.org/2.4.13/modules/imgproc/doc/miscellaneous_transformations.html#cvtcolor>

Hyödyllisin muunnos voi olla muunnos RGB-avaruudesta Lab-avaruuteen. Jos haluat muuntaa värikuvia harmaasävykuviksi, paras tapa saattaa olla muuntaa Lab-väriavaruuteen ja erottaa L-kanava.

On tärkeää huomata, että OpenCV:ssä värikuvat ovat tyypillisesti oletuksena BGR-muodossa RGB-muodon sijaan; sininen ja punainen värikanava ovat siis vaihtaneet paikkaa. Tätä voi kokeilla kuvalla, jossa on kirkkaan sinisiä tai punaisia kohteita ja tallentamalla kunkin värikanavan omaksi kuvakseen

Kuvan saa luettua värillisenä ja konvertoitua Lab-kuvaksi seuraavasti:

```{.python}
img = cv2.imread('park.png', cv2.IMREAD_COLOR)
lab = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)
```

Lisäksi värikanavat saa hajotettua erillisiksi kuviksi näin:

```{.python}
l,a,b = cv2.split(lab)
```

## Muunnos napakoordinaatistoon

Värisävy on hyödyllinen tieto, kun väri-informaatiota halutaan hyödyntää tunnistamisessa tai vaikkapa reunantunnistuksessa. Kokeile toteuttaa muunnos Lab-väriavaruudesta LCh(ab)-väriavaruuteen. Tähän voi käyttää OpenCV:n matemaattisia operaatioita, mutta kirjastosta löytyy valmiina funktio *cartToPolar*, joka tekee juuri kyseisen operaation.

```{.python}
c,h = cv2.cartToPolar(np.float32(a),np.float32(b))
```

Tuloksena on kaksi kuvaa, joista ensimmäisessä on *magnitudi*, eli etäisyys origosta, ja toisessa *kulma*.

On syytä huomata, että tuloksena olevien kuvien pikselit poikkeavat normaaleista pikselien arvoista. Arvot voi normalisoida välille $[0,1]$ esimerkiksi seuraavasti:

```{.python}
c = cv2.normalize(c, alpha=0, beta=1, norm_type=cv2.NORM_MINMAX, dtype=cv2.CV_32F)
```

## Tehtäviä

Jos kuvamateriaalisi on värikuvia, tutki miltä niiden värit näyttävät Lab-avaruudessa tai LCh(ab)-avaruudessa. Voit myös etsiä muita värikkäitä kuvia ja tutkia niitä oppimismielessä, jos väri-informaatio ei ole oleellista omassa työssäsi.
