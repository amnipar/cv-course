#/bin/bash
pandoc --bibliography=bibliography.bib \
  --filter pandoc-citeproc --latex-engine=pdflatex --chapters --toc \
  --variable lang=fi-FI -S -s -o ties411-luentomoniste.pdf title-fi.txt \
  chapter01-fi.md chapter02-fi.md chapter03-fi.md chapter04-fi.md \
  chapter05-fi.md chapter07-fi.md chapter08-fi.md \
  chapter09-fi.md chapter10-fi.md chapter11-fi.md chapter12-fi.md \
  chapter13-fi.md 
