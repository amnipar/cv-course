---
title: Tutoriaali 10
author: Matti Eskelinen
date: 4.5.2017
title-prefix: TIES411
lang: fi
css: style.css
---

Tutustutaan liikkuvan kuvan käsittelyyn ja optisen vuon (engl. *optical flow*) hyödyntämiseen.

Videokuvan käsittelyyn on omat helpot työkalunsa OpenCV:ssä. Tutoriaaliin lisätään toivoakseni myöhemmin esimerkki videon analysoinnista. Tässä vaiheessa käytetään yksittäisinä kuvina tallennettuja ruutuja, joissa aiemmista esimerkeistä tuttu neliö pyörii keskipisteensä ympäri.

Kokeillaan kahta OpenCV:stä löytyvää menetelmää optisen vuon laskemiseksi.

## Farnebäckin menetelmä

Niinsanottu tiheä optinen vuo tarkoittaa vektorikenttää, jossa jokaiselle pikselille on määritelty nopeusvektori. Se kuvaa liikkeen nopeutta kyseisen pikselin kohdalla kuvatason pinnalla. Vektorikentän laskeminen tarkasti on vaikeaa luentomonisteessa kuvatuista syistä, ja esimerkiksi perinteinen Horn-Schunkin menetelmä on hyvin hidas. Lisäongelmia koituu tulosten soveltamisesta, sillä kohteiden todellisen liikkeen arviointi kolmiulotteisessa näkymässä vaatii paljon jatkokäsittelyä.

Farnebäck on kehittänyt suhteellisen nopean ja suhteellisen tarkan menetelmän tiheän optisen vuon laskemiseksi. Se perustuu neliöllisten polynomipintojen sovittamiseen pikseliympäristöihin. Sovitettujen pintojen siirtymä saadaan laskettua tarkasti hyödyntäen polynomien kertoimia.

```{.python}
img = cv2.imread("rect1-1.png", cv2.IMREAD_COLOR) 
f1 = cv2.imread("rect1-1.png", cv2.IMREAD_GRAYSCALE)
f2 = cv2.imread("rect1-2.png", cv2.IMREAD_GRAYSCALE)

flow = cv2.calcOpticalFlowFarneback(f1, f2, 0.5, 3, 15, 7, 5, 1.1, 0)

mag, ang = cv2.cartToPolar(flow[...,0], flow[...,1])

hsv = np.zeros_like(img)
hsv[...,1] = 255
hsv[...,0] = ang*180/np.pi/2
hsv[...,2] = cv2.normalize(mag,None,0,255,cv2.NORM_MINMAX)
rgb = cv2.cvtColor(hsv,cv2.COLOR_HSV2BGR)
```

Koodissa luetaan kaksi videoruutua tiedostosta ja lasketaan vektorikenttä. Samoin kuin muutkin vektorikentät, se voidaan muuntaa polaarimuotoon. Visualisointia varten luodaan saman kokoinen värikuva kuin tutkittavat harmaasävyiset videoruudut. Vektorien kulma visualisoidaan HSV-värikuvan värisävykanavaan ja pituus kirkkauskanavaan. Lopuksi tulos muutetaan tavanomaiseksi värikuvaksi (joka siis OpenCV:ssä on BGR-muotoa).

## Lucas-Kanade pistepiirteille

Monissa sovelluksissa ei ole välttämätöntä laskea tiheää optista vuota. Koska liikesuunta saadaan muutenkin laskettua tarkasti vain pistemäisille kohteille, voi olla hyvä ajatus käyttää pistepiirteitä ja laskea liikevektori niille.

Lucas-Kanade on vanha ja tunnettu menetelmä, jossa kuvan aikaderivaatta kuvataan tiladerivaattojen (eli tutun harmaasävygradientin) funktiona. Nopeusvektoria ei saada ratkaistua tästä yhtälöstä, sillä siinä on kaksi tuntematonta kun taas yhtälöitä on vain yksi. Lucas ja Kanade ratkaisivat ongelman käyttämällä pikseliympäristöä ja saadaan muodostamalla yhtälöryhmän, joka voidaan ratkaista pienimmän neliösumman menetelmällä. Näin saadaan arvio liikevektorista, joka on melko hyvä pistemäisille kohteille.

```{.python}
lk_params = dict( winSize  = (15,15),
                  maxLevel = 2,
                  criteria = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 0.03))

p2, st, err = cv2.calcOpticalFlowPyrLK(f1, f2, p1, None, **lk_params)

good_points = p2[st==1]
```

Koodissa p1 on lista pisteitä ruudussa f1, joille liikevektori lasketaan. Palautettava lista p2 sisältää kyseisten pisteiden paikat ruudussa f2. Sijaintien erotuksesta saadaan muodostettua liikevektori. Toinen palautettava arvo st on vektori arvoja 0 tai 1, joka kuvaa sitä, löysikö menetelmä mielestään uuden sijainnin kullekin pisteelle. Koodiesimerkin viimeisellä rivillä haetaan listasta p2 ne alkiot, joita vastaava alkio listassa st on 1, eli uusi paikka on löydetty.

## Tehtäviä

Pohdi, voitko hyödyntää sovelluksessasi tietoa liikkeestä ja millä tavalla. Jos sinulla on sopivaa materiaalia, kokeile esitettyjä menetelmiä. Pohdi tuloksia sekä sitä, tarvitsetko tiheää optista vuota vai riittäisikö harvempi tulos muutamille pisteille. Millä tavalla jatkokäsittelisit tuloksia sovelluksessasi? Voit myös kokeilla esimerkkiharjoitustyön reposta löytyviä kuvia kierretyistä neliöistä, tai generoida itse kuvia kuvankäsittelyohjelmalla, jos sopivaa materiaalia ei ole.
