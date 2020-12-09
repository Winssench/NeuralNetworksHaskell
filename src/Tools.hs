{-| 
Module : Tools

Utilities to create command line tools.
-}
module Tools (build,remind,learn) where

import Prelude hiding ((<*>),init,writeFile,readFile)
import System.Environment

import System.IO.Strict -- install library with: cabal install strict-io

import Random
import Neural

n = 6000 -- timestamps

{-| 
This command is based on the Random.net function. The network 
architecture is saved in "model.dat"

Sample usage: ./build [2,2,1]
-}
build = do
 vs <- getArgs
 let ss = Prelude.read (vs!!0) :: [Int]
 let ws = net ss
 run (writeFile "model.dat" (show ws))

{-| 
This command is based on the Neural.recall function. It requires a 
"model.dat" first (see "build")

Sample usage: ./remind [1,0]
-}
remind = do
 vs <- getArgs
 mf <- run (readFile "model.dat")
 let xs = Prelude.read (vs!!0) :: [Double]
 let ws = Prelude.read mf :: [[[Double]]]
 Prelude.print (recall ws xs)

{-| 
This command is based on the Neural.train function. It requires a 
"model.dat" first (see "build")

Sample usage: ./train ./dat/xor.dat
-}
learn = do
 vs <- getArgs
 df <- run (readFile (vs!!0))
 let ds = Prelude.read df :: [([Double],[Double])]
 mf <- run (readFile "model.dat")
 let ws = Prelude.read mf :: [[[Double]]]
 let ws'= train n ds ws
 run (writeFile "model.dat" (show ws'))



