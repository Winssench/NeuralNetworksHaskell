{-| 
Module : Random

This module gives utilities to build/initialize neural network 
architectures.
-}
module Random (Net,neuron, layer, net) where

-- random numbers
xor 0 0 = 0
xor 1 0 = 1
xor 0 1 = 1
xor 1 1 = 0

b :: [Double]
b = [1,0,1,1,0,0,1,0]

toDec []     = 0
toDec (x:xs) = x+2*(toDec xs)

next xs = xs'
 where xs' = v:(init xs)
       v   = xor (last xs) (xs!!4)

{-| 
 Infinite list of random values between 0 and 1 based on 
 pseudorandom binary sequence.
-}
random = ran b
 where ran l = ((toDec l) / 255.0):(ran (next l))

neuron' us r   = (take (us+1) r,drop (us+1) r)

{-| 
 Generate a vector/list of n random values used to initialize the 
 weights of a single neuron (with n inputs).
-}
neuron :: Int -> [Double]
neuron n = fst (neuron' n random)

layer' us 1 r   = ([v],r')
 where (v,r')  = neuron' us r
layer' us n r   = (v:vs,r2)
 where (v ,r1) = neuron' us       r
       (vs,r2) = layer' us (n-1) r1

{-| 
 Generate a matrix of n*m random values used to initialize the 
 weights of a single layer of m neurons (and n outputs).
-}
layer :: Int -> Int -> [[Double]]
layer n m = fst (layer' n m random)

net' [us,ys] r = ([v],r')
 where (v,r') = layer' us ys r
net' (us:ys:cs) r = (l:ls,r2)
 where (l ,r') = layer' us ys r
       (ls,r2) = net' (ys:cs) r'

{-| 
 Neural network model as a list of layers, layers being lists of neurons 
 and neurons being lists of weights.
-}
type Net    = [[[Double]]]

{-| 
 Generate a neural network where parameter is a list of sizes for [inputs,
 hidden layer 1, ..., outputs].
-}
net :: [Int] -> Net
net m = fst (net' m random)
