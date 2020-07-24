#!/bin/bash

chmod +x ./run.sh

./run.sh VER=irm_mse TRAIN=1 INFER=1 GPU=1
./run.sh VER=ibm_mse TRAIN=1 INFER=1 GPU=1
./run.sh VER=mag_bar_mse TRAIN=1 INFER=1 GPU=1
./run.sh VER=xi_gamma_bar_mse TRAIN=1 INFER=1 GPU=1
./run.sh VER=xi_bar_mse TRAIN=1 INFER=1 GPU=1
