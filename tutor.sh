#!/bin/bash

# pre:  make
# post: make clean

clear
echo "----------------------------------------"
echo "-- Neural Net Illustration (XOR gate) --"
echo "----------------------------------------"
read
clear
echo "1) Get an input->output dataset (e.g. dat/xor.dat)"
echo ""
cat ./dat/xor.dat
read
clear
echo "2) Build a network (e.g. 2 inputs, 2 hidden neurons, 1 output)"
echo ""
echo "./build [2,2,1]"
./build [2,2,1]
read
clear
echo "3) Check output of the network (e.g. input = [1,0])"
echo ""
echo "./remind [1,0]"
./remind [1,0]
read
clear
echo "4) Train the network with dataset (1), train, train... then check again"
echo "(remember previous output: $(./remind [1,0]))"
echo ""
echo "./learn ./dat/xor.dat"
echo ""
echo "Please wait ..."
echo
for i in {1..20}
do
./learn ./dat/xor.dat
done
for i in {1..20}
do
./learn ./dat/ocr.dat
done
echo "Now ./remind [1,0] -> $(./remind [1,0])"
echo ""
echo "Checking other inputs"
echo "[0,0] -> $(./remind [0,0])"
echo "[0,1] -> $(./remind [0,1])"
echo "[1,0] -> $(./remind [1,0])"
echo "[1,1] -> $(./remind [1,1])"
read
clear
echo "5) Try other examples (e.g. dat/autoencoder.dat)"
echo ""
cat ./dat/autoencoder.dat
echo ""
echo "With:"
echo "./build [3,2,3]"
./build [3,2,3]
echo "./learn ./dat/autoencoder.dat"
echo ""
echo "Please wait ..."
for i in {1..20}
do
./learn ./dat/autoencoder.dat
done
echo ""
echo "Results:"
echo "[0,0,0] -> $(./remind [0,0,0])"
echo "[1,0,0] -> $(./remind [1,0,0])"
echo "[0,1,0] -> $(./remind [0,1,0])"
echo "[0,0,1] -> $(./remind [0,0,1])"
read
clear
echo "6) Explore hidden layer (by removing last one)"
echo "Nb. This correspond to an 'encoder'"
echo 
echo "./cut-last"
cp model.dat model.bak # backup
./cut-last
echo 
echo "Results:"
echo "[0,0,0] -> $(./remind [0,0,0])"
echo "[1,0,0] -> $(./remind [1,0,0])"
echo "[0,1,0] -> $(./remind [0,1,0])"
echo "[0,0,1] -> $(./remind [0,0,1])"
echo
cp model.bak model.dat # restore
echo "Nb. Other possibility to get the 'decoder'"
echo "./cut-first"
./cut-first
echo "[0,0] -> $(./remind [0,0])"
echo "[0,1] -> $(./remind [0,1])"
echo "[1,0] -> $(./remind [1,0])"
echo "[1,1] -> $(./remind [1,1])"
read
clear
echo "7) Do more complex examples, e.g. OCR"
echo
cat ./dat/ocr.dat
echo
echo "Zoom x1200 to see pixels (aka 0/1 values for inputs of the network..."
mtpaint dat/img1.bmp


