

# Neural Networks in Haskell


Neural networks in Functional Programming (with Haskell).



## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

 Here is what we need for this project
 ```
 Visual Studio Code
 ```

```
GHC 
```
```
CABAL
```

and some Libraries

### Installing

A step by step series of examples that tell you how to get a development env running

download Visual Studio Code. visit this
```
https://code.visualstudio.com/download
```

to install Haskell plateform, go on the official website, under the Haskell Platform section
choose your System

```
https://www.haskell.org/downloads/
```

once that installed, we have to install the libraries .
before that :
```
cabal update
```

Here the order counts otherwise you wont compile the project!
to avoid bugs each library has to be installed with the versions used in this project .

vector library:
```
cabal install --lib vector-0.12.1.2
```


bmp Library:
```
cabal install --lib bmp-1.2.6.3
```

repa library:

```
cabal install --lib repa-3.4.1.4
```

strict.io library:

```
cabal install --lib strict-io-0.2.2
```



## Make the project
Neural networks in Functional Programming (with Haskell).

* Build the executables with: make

* Build the documention with: make doc

* You can clean the project with: make clean


## Usage


### Note : 3 examples XOR, AUTO_ENCODER and DIGIT_RECOGNITION Result in Binary.
All these commands to be typed in terminal
****

* Run the command make first .


*   Build a network depending on the problem:

    - XOR   ->   ./build [2,2,1]
    - AUTO_ENCODER-> ./build [3,2,3]
    - DIGIT_RECOGNITION -> ./build [256,2,2]

* Check the ouput of the network with inputs  

    - XOR ->  ./remindsimple [1,0] 
    - AUTO_ENCODER-> ->  ./remindsimple [0,0,0]
    - DIGIT_RECOGNITION -> ./remind ./img0.bmp


* Get an (input->output) dataset for training depending on the   example wanted :
    - XOR ->   dat/xor.dat
    - AUTO_ENCODER -> dat/autoencoder.dat
    - DIGIT_RECOGNITION -> dat/ocr.dat

    which leads us to the learning process:
    - XOR ->   for i in {1..20};do ./learnsimple ./dat/xor.dat;done
    - AUTO_ENCODER -> for i in {1..20};do ./learnsimple .dat/autoencoder.dat; done
    - DIGIT_RECOGNITION -> for i in {1..30}; do ./learn ./dat/ocr.dat; done
  

* ReCheck the ouput After the network learned. for more information see tutor.sh the tutorial available

## Built With


* [VSCode](https://code.visualstudio.com) - as IDE
* [Haskell](https://www.haskell.org) - for everything




## Authors
* **DR L.Thiry(HDR)** - ENSISA/IRIMAS
* **Omar CHICHAOUI** - *Software Engineering Student*-ENSISA Mulhouse France






## Acknowledgments


* Thanks to the professor  **DR L.Thiry(HDR)** and all the [ENSISA](http://www.ensisa.uha.fr/en) staff.
* Thanks to everyone who works to develop [Haskell](https://www.haskell.org) .
* Template used  Billie Thompson - 
