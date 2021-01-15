
import Graphics.Gloss

import qualified Data.Array.Repa as R
import Data.Array.Repa
import Data.Array.Repa.IO.BMP

import System.Environment

import System.IO.Strict -- install library with: cabal install strict-io


main :: IO ()
main = do 
          --all <- readImageFromBMP "./img0.bmp" -- loads wall image
         x <- readImageFromBMP "../dat/img0.bmp"
         Prelude.putStrLn $ "Size: " Prelude.++ show ( x)