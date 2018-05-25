#!/bin/bash

pandoc --bibliography=bibliography.bib \
  --filter pandoc-citeproc --latex-engine=pdflatex --chapters --toc \
  --variable lang=fi-FI -S -s -o ties411-luentomoniste.pdf title-fi.txt \
  chapter_01.fi.md chapter_02.fi.md chapter_03.fi.md chapter_04.fi.md \
  chapter_05.fi.md chapter_06.fi.md chapter_07.fi.md chapter_08.fi.md \
  chapter_09.fi.md chapter_10.fi.md chapter_11.fi.md chapter_12.fi.md \
  chapter_13.fi.md chapter_14.fi.md chapter_15.fi.md
