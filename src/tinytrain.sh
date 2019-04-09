#!/bin/bash -x
# tinytrain.sh
# train using a tiny database, synthesis a few samples from within
# training database.  Used to perform quick sanity checks with a few hrs training

SRC=all_speech
DATE=190406b
TST=c01_01

synth() {
  ./src/dump_data --test --c2pitch ~/Downloads/$1.sw $1.f32
  ./src/test_lpcnet $1.f32 "$2".raw
}

train() {
  ./src/dump_data --train --c2pitch -z 0 -n 1E6 ~/Downloads/$SRC.sw $SRC.f32 $SRC.pcm
  ../src/train_lpcnet.py $SRC.f32 $SRC.pcm lpcnet_$DATE
  ../src/dump_lpcnet.py lpcnet_"$DATE"_10.h5
  cp nnet_data.c src
  make test_lpcnet
}

synth c01_01 c01_01b
synth mk61_01 mk61_01b