#!/bin/bash

mkdir -p ./site/tutorials
cp style.css ./site/
cp style.css ./site/tutorials/

pandoc -s --template=./template.html --mathjax -o ./site/index.html ./index.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_01.fi.html ./chapter_01.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_02.fi.html ./chapter_02.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_03.fi.html ./chapter_03.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_04.fi.html ./chapter_04.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_05.fi.html ./chapter_05.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_06.fi.html ./chapter_06.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_07.fi.html ./chapter_07.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_08.fi.html ./chapter_08.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_09.fi.html ./chapter_09.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_10.fi.html ./chapter_10.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_11.fi.html ./chapter_11.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_12.fi.html ./chapter_12.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_13.fi.html ./chapter_13.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_14.fi.html ./chapter_14.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_15.fi.html ./chapter_15.fi.md
pandoc -s --template=./template.html --filter=./striph1 --mathjax -o ./site/chapter_16.fi.html ./chapter_16.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/index.html ./tutorials/index.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial01.fi.html ./tutorials/tutorial01.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial02.fi.html ./tutorials/tutorial02.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial03.fi.html ./tutorials/tutorial03.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial04.fi.html ./tutorials/tutorial04.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial05.fi.html ./tutorials/tutorial05.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial06.fi.html ./tutorials/tutorial06.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial07.fi.html ./tutorials/tutorial07.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial08.fi.html ./tutorials/tutorial08.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial09.fi.html ./tutorials/tutorial09.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial10.fi.html ./tutorials/tutorial10.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial11.fi.html ./tutorials/tutorial11.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial12.fi.html ./tutorials/tutorial12.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial13.fi.html ./tutorials/tutorial13.fi.md
pandoc -s --template=./template.html --mathjax -o ./site/tutorials/tutorial14.fi.html ./tutorials/tutorial14.fi.md
