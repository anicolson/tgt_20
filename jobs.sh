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

## DEMAND VOICEBANK DATASET
###########################

## One-off runs

# sbatch ./run.sh DATASET=demand_vb VER=ibm_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db NETWORK=MHANetV3 TRAIN=1 INFER=1

## New targets/loss functions

##### sbatch ./run.sh DATASET=demand_vb VER=mag_pow TRAIN=1 INFER=1
##### sbatch ./run.sh DATASET=demand_vb VER=iam TRAIN=1 INFER=1
##### sbatch ./run.sh DATASET=demand_vb VER=iam_mse TRAIN=1 INFER=1
##### sbatch ./run.sh DATASET=demand_vb VER=iam_mmsa TRAIN=1 INFER=1


# sbatch ./run.sh DATASET=deep_xi VER=mag_pow TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=iam TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=iam_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=iam_mmsa TRAIN=1 INFER=1

# sbatch ./run.sh DATASET=demand_vb VER=mag_pow NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=iam NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=iam_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=iam_mmsa NETWORK=MHANetV3 TRAIN=1 INFER=1

# sbatch ./run.sh DATASET=demand_vb VER=mag_pow NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=iam TRAIN=1 NETWORK=ChimerappBLSTM INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=iam_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=iam_mmsa NETWORK=ChimerappBLSTM TRAIN=1 INFER=1

## MMSE estimator gain as the training target

# sbatch ./run.sh DATASET=demand_vb VER=mmse-lsa_clip_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mmse-lsa_clip TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mmse-stsa_clip_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mmse-stsa_clip TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=cwf_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=cwf TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=wf_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=wf TRAIN=1 INFER=1

# sbatch ./run.sh DATASET=deep_xi VER=mmse-lsa_clip_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=mmse-lsa_clip TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=mmse-stsa_clip_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=mmse-stsa_clip TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=cwf_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=cwf TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=wf_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=deep_xi VER=wf TRAIN=1 INFER=1

# sbatch ./run.sh DATASET=demand_vb NETWORK=MHANetV3 VER=mmse-lsa_clip_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=MHANetV3 VER=mmse-lsa_clip TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=MHANetV3 VER=mmse-stsa_clip_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=MHANetV3 VER=mmse-stsa_clip TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=MHANetV3 VER=cwf_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=MHANetV3 VER=cwf TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=MHANetV3 VER=wf_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=MHANetV3 VER=wf TRAIN=1 INFER=1

# sbatch ./run.sh DATASET=demand_vb NETWORK=ChimerappBLSTM VER=mmse-lsa_clip_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=ChimerappBLSTM VER=mmse-lsa_clip TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=ChimerappBLSTM VER=mmse-stsa_clip_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=ChimerappBLSTM VER=mmse-stsa_clip TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=ChimerappBLSTM VER=cwf_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=ChimerappBLSTM VER=cwf TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=ChimerappBLSTM VER=wf_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb NETWORK=ChimerappBLSTM VER=wf TRAIN=1 INFER=1

## ResNet

# sbatch ./run.sh DATASET=demand_vb VER=irm_mse_trial_3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=irm_trial_3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=irm_mse_trial_2 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=irm_trial_2 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=ibm_mse_trial_2 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=ibm_trial_2 TRAIN=1 INFER=1

# sbatch ./run.sh DATASET=demand_vb VER=mag_bar_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_bar TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_norm_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_norm TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_std TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_norm_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_norm TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_bar_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_bar TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db_norm TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db_norm_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_norm TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_norm_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm_mse TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_std TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm_mse TRAIN=1 INFER=1

# sbatch ./run.sh DATASET=demand_vb VER=xi_bar_mse INFER=1 GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm_mse INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_std INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm_mse INFER=1  GAIN=srwf

## MHANet

sbatch ./run.sh DATASET=demand_vb VER=irm_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
sbatch ./run.sh DATASET=demand_vb VER=irm NETWORK=MHANetV3 TRAIN=1 INFER=1
sbatch ./run.sh DATASET=demand_vb VER=ibm_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
sbatch ./run.sh DATASET=demand_vb VER=ibm NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_bar_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_bar NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_norm_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_norm NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_std NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_norm_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_norm NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_bar_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_bar NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db_norm NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db_norm_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_norm NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_norm_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm_mse NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_std NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm NETWORK=MHANetV3 TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm_mse NETWORK=MHANetV3 TRAIN=1 INFER=1

# sbatch ./run.sh DATASET=demand_vb VER=xi_bar_mse NETWORK=MHANetV3 INFER=1 GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar NETWORK=MHANetV3 INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm NETWORK=MHANetV3 INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm_mse NETWORK=MHANetV3 INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_std NETWORK=MHANetV3 INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db NETWORK=MHANetV3 INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm NETWORK=MHANetV3 INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm_mse NETWORK=MHANetV3 INFER=1  GAIN=srwf


## ChimeraBLSTM

# sbatch ./run.sh DATASET=demand_vb VER=irm_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=irm NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=ibm_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=ibm NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_bar_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_bar NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_norm_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_norm NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_std NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_norm_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_norm NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_bar_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_bar NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db_norm NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db_norm_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_norm NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_norm_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_std NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm NETWORK=ChimeraBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm_mse NETWORK=ChimeraBLSTM TRAIN=1 INFER=1

## ChimerappBLSTM

sbatch ./run.sh DATASET=demand_vb VER=irm_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
sbatch ./run.sh DATASET=demand_vb VER=irm NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
sbatch ./run.sh DATASET=demand_vb VER=ibm_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
sbatch ./run.sh DATASET=demand_vb VER=ibm NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_bar_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_bar NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_norm_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_norm NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db_std NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=pow_db NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_norm_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=mag_norm NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_bar_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_bar NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db_norm NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db_norm_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_db NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_norm NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_gamma_norm_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_std NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_db NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm NETWORK=ChimerappBLSTM TRAIN=1 INFER=1
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm_mse NETWORK=ChimerappBLSTM TRAIN=1 INFER=1

# sbatch ./run.sh DATASET=demand_vb VER=xi_bar_mse NETWORK=ChimerappBLSTM INFER=1 GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_bar NETWORK=ChimerappBLSTM INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm NETWORK=ChimerappBLSTM INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_norm_mse NETWORK=ChimerappBLSTM INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db_std NETWORK=ChimerappBLSTM INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_db NETWORK=ChimerappBLSTM INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm NETWORK=ChimerappBLSTM INFER=1  GAIN=srwf
# sbatch ./run.sh DATASET=demand_vb VER=xi_norm_mse NETWORK=ChimerappBLSTM INFER=1  GAIN=srwf

## Gain function comparison
# ./run.sh DATASET=demand_vb VER=xi_gamma_bar NETWORK=MHANetV3 INFER=1 GAIN=wf
# ./run.sh DATASET=demand_vb VER=xi_gamma_bar NETWORK=MHANetV3 INFER=1 GAIN=srwf
# ./run.sh DATASET=demand_vb VER=xi_gamma_bar NETWORK=MHANetV3 INFER=1 GAIN=cwf
# ./run.sh DATASET=demand_vb VER=xi_gamma_bar NETWORK=MHANetV3 INFER=1 GAIN=mmse-stsa

## DEEP XI DATASET
##################

# sbatch ./run.sh DATASET=deep_xi VER=xi_db_std INFER=1 GAIN=srwf

exit 0
