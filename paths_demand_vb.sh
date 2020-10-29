#!/bin/bash

PROJ_DIR='tgt_20'
NEGATIVE="-"

set -o noglob

case `hostname` in
"fist")  echo "Running on `hostname`."
    LOG_PATH='/home/aaron/mnt/aaron/Dropbox/projects/tgt_20/log'
    SET_PATH='/mnt/ssd/DEMAND_VB'
    DATA_PATH='/home/aaron/data/'$PROJ_DIR
    TEST_X_PATH='/home/aaron/mnt/aaron/set/DEMAND_VB/noisy_testset_wav'
    TEST_S_PATH='/home/aaron/mnt/aaron/set/DEMAND_VB/clean_testset_wav'
    TEST_D_PATH='dummy'
    OUT_PATH='/home/aaron/mnt/aaron_root/mnt/hdd1/out/'$PROJ_DIR
    MODEL_PATH='/home/aaron/model/'$PROJ_DIR
    ;;
"pinky-jnr")  echo "Running on `hostname`."
    LOG_PATH='/home/aaron/mnt/aaron/Dropbox/projects/tgt_20/log'
    SET_PATH='/home/aaron/set/DEMAND_VB'
    DATA_PATH='/home/aaron/mnt/fist/data/'$PROJ_DIR
    TEST_X_PATH='/home/aaron/set/DEMAND_VB/noisy_testset_wav'
    TEST_S_PATH='/home/aaron/set/DEMAND_VB/clean_testset_wav'
    TEST_D_PATH='dummy'
    OUT_PATH='/home/aaron/mnt/aaron_root/mnt/hdd1/out/'$PROJ_DIR
    MODEL_PATH='/home/aaron/mnt/fist/model/'$PROJ_DIR
    ;;
"stink")  echo "Running on `hostname`."
    LOG_PATH='/home/aaron/mnt/aaron/Dropbox/projects/tgt_20/log'
    SET_PATH='/mnt/ssd/DEMAND_VB'
    DATA_PATH='/home/aaron/mnt/fist/data/'$PROJ_DIR
    TEST_X_PATH='/home/aaron/mnt/aaron/set/DEMAND_VB/noisy_testset_wav'
    TEST_S_PATH='/home/aaron/mnt/aaron/set/DEMAND_VB/clean_testset_wav'
    TEST_D_PATH='dummy'
    OUT_PATH='/home/aaron/mnt/aaron_root/mnt/hdd1/out/'$PROJ_DIR
    MODEL_PATH='/home/aaron/mnt/fist/model/'$PROJ_DIR
    ;;
*) echo "This workstation is not known. Using default paths."
    LOG_PATH='log'
    SET_PATH='set'
    DATA_PATH='data'
    TEST_X_PATH='set/test_noisy_speech'
    TEST_S_PATH='set/test_clean_speech'
    TEST_D_PATH='set/test_noise'
    OUT_PATH='out'
    MODEL_PATH='model'
   ;;
esac
