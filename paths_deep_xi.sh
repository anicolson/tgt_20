#!/bin/bash

PROJ_DIR='tgt_20'
NEGATIVE="-"

set -o noglob

case `hostname` in
"fist")  echo "Running on `hostname`."
    LOG_PATH='/home/aaron/mnt/aaron/mnt/Dropbox/projects/tgt_20/log'
    SET_PATH='/mnt/ssd/deep_xi_training_set'
    DATA_PATH='/home/aaron/data/'$PROJ_DIR
    TEST_X_PATH='/home/aaron/mnt/aaron/set/deep_xi_test_set/test_noisy_speech'
    TEST_S_PATH='/home/aaron/mnt/aaron/set/deep_xi_test_set/test_clean_speech'
    TEST_D_PATH='/home/aaron/mnt/aaron/set/deep_xi_test_set/test_noise'
    OUT_PATH='/home/aaron/mnt/aaron_root/mnt/hdd1/out/'$PROJ_DIR
    MODEL_PATH='/home/aaron/model/'$PROJ_DIR
    ;;
"pinky-jnr")  echo "Running on `hostname`."
    LOG_PATH='/home/aaron/mnt/aaron/mnt/Dropbox/projects/tgt_20/log'
    SET_PATH='/home/aaron/set/deep_xi_training_set'
    DATA_PATH='/home/aaron/mnt/fist/data/'$PROJ_DIR
    TEST_X_PATH='/home/aaron/mnt/aaron/set/deep_xi_test_set/test_noisy_speech'
    TEST_S_PATH='/home/aaron/mnt/aaron/set/deep_xi_test_set/test_clean_speech'
    TEST_D_PATH='/home/aaron/mnt/aaron/set/deep_xi_test_set/test_noise'
    OUT_PATH='/home/aaron/mnt/aaron_root/mnt/hdd1/out/'$PROJ_DIR
    MODEL_PATH='/home/aaron/mnt/fist/model/'$PROJ_DIR
    ;;
"stink")  echo "Running on `hostname`."
    LOG_PATH='/home/aaron/mnt/aaron/mnt/Dropbox/projects/tgt_20'
    SET_PATH='/mnt/ssd/deep_xi_training_set'
    DATA_PATH='/home/aaron/mnt/fist/data/'$PROJ_DIR
    TEST_X_PATH='/home/aaron/mnt/aaron/set/deep_xi_test_set/test_noisy_speech'
    TEST_S_PATH='/home/aaron/mnt/aaron/set/deep_xi_test_set/test_clean_speech'
    TEST_D_PATH='/home/aaron/mnt/aaron/set/deep_xi_test_set/test_noise'
    OUT_PATH='/home/aaron/mnt/aaron_root/mnt/hdd1/out/'$PROJ_DIR
    MODEL_PATH='/home/aaron/mnt/fist/model/'$PROJ_DIR
    ;;
"n060")  echo "Running on `hostname`."
    LOG_PATH='/export/home/s2842809/tgt_20_data'
    SET_PATH='/export/home/s2842809/deep_xi_dataset'
    DATA_PATH='/export/home/s2842809/tgt_20_data/data/'$PROJ_DIR
    TEST_X_PATH='/export/home/s2842809/deep_xi_dataset/test_noisy_speech'
    TEST_S_PATH='/export/home/s2842809/deep_xi_dataset/test_clean_speech'
    TEST_D_PATH='/export/home/s2842809/deep_xi_dataset/test_noise'
    OUT_PATH='/export/home/s2842809/tgt_20_data/out/'$PROJ_DIR
    MODEL_PATH='/export/home/s2842809/tgt_20_data/model/'$PROJ_DIR
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
