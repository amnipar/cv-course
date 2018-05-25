#!/bin/bash

pandoc -s -o ./site/chapter_01.fi.pdf ./chapter_01.fi.md
pandoc -s -o ./site/chapter_02.fi.pdf ./chapter_02.fi.md
pandoc -s -o ./site/chapter_03.fi.pdf ./chapter_03.fi.md
pandoc -s -o ./site/chapter_04.fi.pdf ./chapter_04.fi.md
pandoc -s -o ./site/chapter_05.fi.pdf ./chapter_05.fi.md
pandoc -s -o ./site/chapter_06.fi.pdf ./chapter_06.fi.md
pandoc -s -o ./site/chapter_07.fi.pdf ./chapter_07.fi.md
pandoc -s -o ./site/chapter_08.fi.pdf ./chapter_08.fi.md
pandoc -s -o ./site/chapter_09.fi.pdf ./chapter_09.fi.md
pandoc -s -o ./site/chapter_10.fi.pdf ./chapter_10.fi.md
pandoc -s -o ./site/chapter_11.fi.pdf ./chapter_11.fi.md
pandoc -s -o ./site/chapter_12.fi.pdf ./chapter_12.fi.md
pandoc -s -o ./site/chapter_13.fi.pdf ./chapter_13.fi.md
pandoc -s -o ./site/chapter_14.fi.pdf ./chapter_14.fi.md
pandoc -s -o ./site/chapter_15.fi.pdf ./chapter_15.fi.md
pandoc -s -o ./site/chapter_16.fi.pdf ./chapter_16.fi.md

#pandoc --bibliography=bibliography.bib \
#  --filter pandoc-citeproc --latex-engine=pdflatex --chapters --toc \
#  --variable lang=fi-FI -S -s -o ties411-luentomoniste.pdf title-fi.txt \
#  chapter00-fi.md chapter01-fi.md chapter02-fi.md chapter03-fi.md \
#  chapter04-fi.md chapter07-fi.md chapter08-fi.md chapter09-fi.md \
#  chapter05-fi.md chapter10-fi.md chapter11-fi.md chapter12-fi.md
