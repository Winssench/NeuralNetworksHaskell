{-| 
Module : Tools

Utilities to create command line tools.
-}
module Tools (build,remind,learn,readImageFromBMPPrime, learnFinal,remindImage) where

import Prelude hiding ((<*>),init,writeFile,readFile)
import System.Environment

import System.IO.Strict 

import Random
import Neural


---
import Data.Array.Repa                          as R
import Data.Array.Repa.Unsafe                   as R

import Data.Array.Repa.Repr.ByteString          as R
import Data.Vector.Unboxed                      as U


import Codec.BMP
import Data.Word
---

n = 6000 -- timestamps

{-| 
This command is based on the Random.net function. The network 
architecture is saved in "model.dat"

Sample usage: ./build [2,2,1]
-}
build = do
 vs <- getArgs
 let ss = Prelude.read (Prelude.head vs) :: [Int]
 let ws = net ss
 --Prelude.putStrLn $ "here is ws' " Prelude.++ show ( ws)
 run (writeFile "model.dat" (show ws))

{-| 
This command is based on the Neural.recall function. It requires a 
"model.dat" first (see "build")

Sample usage: ./remind [1,0]
-}
remind = do
 vs <- getArgs
 mf <- run (readFile "model.dat")
 let xs = Prelude.read (Prelude.head vs) :: [Double]
 let ws = Prelude.read mf :: [[[Double]]]
 Prelude.print (recall ws xs)




remindImage = do
       m <- getMatrix
       mf <- run (readFile "model.dat")
       let ws = Prelude.read mf :: [[[Double]]]
       let xs =  Prelude.head m
       Prelude.print (recall ws xs)

{-| 
This command is based on the Neural.train function. It requires a 
"model.dat" first (see "build")

Sample usage: ./train ./dat/xor.dat
-}
learn = do
 vs <- getArgs
 df <- run (readFile (Prelude.head vs))
 let ds = Prelude.read df :: [([Double],[Double])]
 mf <- run (readFile "model.dat")
 let ws = Prelude.read mf :: [[[Double]]]
 let ws'= train n ds ws
 run (writeFile "model.dat" (show ws'))


{-| 
This command is based on the Neural.train function. It requires a 
"model.dat" first (see "build")

Sample usage: ./train ./dat/ocr.dat
-}
learnFinal = do 
       ds <- learnbmpa
       mf <- run (readFile "model.dat")
       let ws = Prelude.read mf :: [[[Double]]]
       let ws'= train n ds ws
       run (writeFile "model.dat" (show ws'))



learnbmpa :: IO  [([Double],[Double])]
learnbmpa = do
    (v0:_) <- getArgs
    df <- run (readFile v0)
    let (a, b) = Prelude.unzip (Prelude.read df :: [(String,[Double])])
    (`Prelude.zip` b) <$> Prelude.mapM readMatrixfromImage a
   
    

      
getMatrix = do
       vs <- getArgs
       Prelude.mapM readMatrixfromImage vs
        


 
readMatrixfromImage :: FilePath -> IO [Double]
readMatrixfromImage image = do 
       x <- readImageFromBMPa image -- 'x' est alors de type t
       let (Right r) = x
       let a = toUnboxed r
       let b = U.toList a
       let b' = Prelude.map (\v -> (fromIntegral v :: Double)/255.0  - 1)  b
       let c = Prelude.map abs b'
       return c

       


readImageFromBMPa
        :: FilePath
        -> IO (Either Error (Array U DIM2 Word8))

{-# NOINLINE readImageFromBMPa #-}
readImageFromBMPa filePath
 = do   ebmp    <- readBMP filePath

        case ebmp of
         Left err       -> return $ Left err
         Right bmp      
          -> do arr    <- readImageFromBMPPrime  bmp
                return  $ Right arr


readImageFromBMPPrime bmp
 = do   let (width, height) = bmpDimensions bmp

        let arr         = R.fromByteString (Z :. height :. width * 4)
                        $ unpackBMPToRGBA32 bmp

        let shapeFn _   = Z :. height :. width
 
        vecRed         <- computeP 
                        $ unsafeTraverse arr shapeFn
                               (\get (sh :. x) -> get (sh :. (x * 4)))

       
        let vecGray = toUnboxed vecRed
        
        return $ fromUnboxed (Z :. height :. width) vecGray