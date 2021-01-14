#!/bin/bash

# The tgt_20 project.
# Copyright (C) 2020  Aaron Nicolson
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
*) case `whoami` in
    nic261)  echo Running on a cluster.
          LOG_PATH='/datasets/work/hb-mlaifsp-mm/work/tgt_20/log'
          SET_PATH='/datasets/work/hb-mlaifsp-mm/source/Datasets/deep_xi_dataset'
          DATA_PATH='/datasets/work/hb-mlaifsp-mm/work/Data'
          TEST_X_PATH='/datasets/work/hb-mlaifsp-mm/source/Datasets/deep_xi_dataset/test_noisy_speech'
          TEST_D_PATH='dummy'
          TEST_S_PATH='/datasets/work/hb-mlaifsp-mm/source/Datasets/deep_xi_dataset/test_clean_speech'
          OUT_PATH='/datasets/work/hb-mlaifsp-mm/work/Outputs/'$PROJ_DIR
          MODEL_PATH='/datasets/work/hb-mlaifsp-mm/work/Models/'$PROJ_DIR
        ;;
    *) echo "This workstation is not known."
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
esac
