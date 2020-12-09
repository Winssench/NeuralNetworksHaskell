import Tools

import Prelude hiding (writeFile,readFile)
import System.IO.Strict

main = do
 mf <- run (readFile "model.dat")
 let ws = Prelude.read mf :: [[[Double]]]
 let ws'= tail ws
 run (writeFile "model.dat" (show ws'))



