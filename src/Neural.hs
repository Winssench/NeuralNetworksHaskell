{-| 
Module : Neural

This module proposes functions to train a neural network with a dataset 
or get the output of a network (see recall).
-}
module Neural (Input,Output,Dataset,recall,train) where

import Prelude hiding ((<*>),init)
import System.Environment
import System.IO
import Random

type Input  = [Double]
type Output = [Double]
type Dataset= [(Input,Output)]

recall :: Net -> Input -> Output
recall [ws] xs = y0
 where v  = ws <**> (shift xs)
       y0 = sigmoid v
recall (ws:wss) xs = recall wss (recall [ws] xs)

softmax :: [Double] -> [Double]
softmax ys = r
      where{
             
             b = map (\(v) -> exp (v)) ys;
             a = sum b;
             --let b' = Prelude.map (\(v) -> ((fromIntegral (v) :: Double)/255.0 ) ) b
             r = map (\(v) -> v/a) b
      } 
            
      

k = 0.1 -- learning rate

update [ws] xs y = ([ws'],alpha)
 where v  = ws <**> (shift xs)
       y0 = sigmoid v
       de = y0 <-> y
       dy = sigmoid' v
       dv = repeat (shift xs)
       dw = (de <*> dy) <|> dv
       ws'= ws <--> (k <&&> dw)
       dx = map tail ws
       alpha = bigsum ((de <*> dy) <|> dx)
update (ws:wss) zs y = (ws':wss',alpha)
 where u  = ws <**> (shift zs)
       xs = sigmoid u
       (wss',alph) = update wss xs y
       dx = sigmoid' u
       du = repeat (shift zs)
       dw = (alph <*> dx) <|> du
       ws'= ws <--> (k <&&> dw)
       dz = map tail ws
       alpha = bigsum ((alph <*> dx) <|> dz)

train :: Int -> Dataset -> Net -> Net
train n ds ws = train0 n (rep ds) ws
 where rep ds = ds ++ (rep ds)
       train0 0 ds          ws = ws
       train0 n ((xs,y):ds) ws = train0 (n-1) ds ws'
        where (ws',alpha) = update ws xs y

-- OPERATORS

sig  x = 1.0/(1.0+exp (-x))
sig' x = sx*(1.0-sx)
 where sx = sig x

sigmoid  = map sig
sigmoid' = map sig'

infixr <+> -- vector + vector
xs <+> ys = zipWith (+) xs ys

bigsum = foldr1 (<+>)

infixr <*> -- hadamard
xs <*> ys = zipWith (*) xs ys

infixr <.> -- dot
xs <.> ys = sum (xs <*> ys)

infixr <**> -- matrix * vector
xs <**> ys = map (<.> ys) xs

infixr <&> -- constant * vector
k <&> xs = (repeat k) <*> xs

infixr <|> -- vector * matrix
k <|> xs = zipWith (<&>) k xs

infixr <&&> -- constant * matrix
k <&&> xs = map (k <&>) xs

infixr <-> -- vector - vector
xs <-> ys = zipWith (-) xs ys

infixr <--> -- matrix - matrix
xs <--> ys = zipWith (<->) xs ys

shift xs = -1.0:xs
