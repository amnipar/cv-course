#!/bin/env runhaskell
import Text.Pandoc.JSON

main = toJSONFilter striph1

striph1 :: Block -> Block
striph1 (Header n _ _) | n == 1 = Para []
striph1 x = x
