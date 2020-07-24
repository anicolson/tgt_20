#!/bin/bash

chmod +x ./run.sh

# ./run.sh VER=xi_db TRAIN=1 INFER=1 GPU=3
# ./run.sh VER=xi_db_std TRAIN=1 INFER=1 GPU=3
# ./run.sh VER=xi_bar TRAIN=1 INFER=1 GPU=3
# ./run.sh VER=xi_bar INFER=1 GAIN=srwf GPU=3
./run.sh VER=xi_gamma_db TRAIN=1 INFER=1 GPU=3
./run.sh VER=xi_gamma_bar TRAIN=1 INFER=1 GPU=3
./run.sh VER=pow_db TRAIN=1 INFER=1 GPU=3
./run.sh VER=pow_db_std TRAIN=1 INFER=1 GPU=3
./run.sh VER=mag_bar TRAIN=1 INFER=1 GPU=3
./run.sh VER=ibm TRAIN=1 INFER=1 GPU=3
./run.sh VER=irm TRAIN=1 INFER=1 GPU=3
./run.sh VER=mmse-lsa_db TRAIN=1 INFER=1 GPU=3
./run.sh VER=mmse-stsa_db TRAIN=1 INFER=1 GPU=3
