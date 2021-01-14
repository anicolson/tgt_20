#!/bin/bash


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

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --gres=gpu:1
#SBATCH --time=4-12:00:00
#SBATCH --mem=16000MB

case `whoami` in
  nic261)
    echo Loading modules...
    module load python/3.7.2
    module load cuda/10.1.168
    module load cudnn/v7.6.4-cuda101
esac

source /scratch1/nic261/venv/DeepXi/bin/activate


chmod +x ./config.sh
. ./config.sh

if [ $DATASET == 'demand_vb' ]
then
    chmod +x ./paths_demand_vb.sh
    . ./paths_demand_vb.sh
    DEMAND_VB_VER="_demand_vb"
    VAL_FLAG=0
    MIN_SNR=0
    MAX_SNR=15
    SNR_INTER=5
    TEST_EPOCH=125
    MAX_EPOCHS=$TEST_EPOCH
fi

if [ $DATASET == 'deep_xi' ]
then
    chmod +x ./paths_deep_xi.sh
    . ./paths_deep_xi.sh
    DEMAND_VB_VER=""
    VAL_FLAG=1
    MIN_SNR=-10
    MAX_SNR=20
    SNR_INTER=1
    TEST_EPOCH=150
    MAX_EPOCHS=$TEST_EPOCH
fi

# if [ $DATASET == 'chime5' ]
# then
#     chmod +x ./paths_chime5.sh
#     . ./paths_chime5.sh
#     DEMAND_VB_VER=""
#     VAL_FLAG=1
#     MIN_SNR=-10
#     MAX_SNR=20
#     SNR_INTER=1
# fi

cd ../DeepXi

NET=""
if [ $NETWORK == "MHANetV3" ]
then
    NET="_mha"
fi
if [ $NETWORK == "ChimeraBLSTM" ]
then
    NET="_chimera"
fi
if [ $NETWORK == "ChimerappBLSTM" ]
then
    NET="_chimerapp"
fi

D_MODEL=256
N_BLOCKS=40
D_F=64
K=3
MAX_D_RATE=16
CAUSAL=1
UNIT_TYPE="ReLU->LN->W+b"
SAMPLE_SIZE=1000
F_S=16000
T_D=32
T_S=16
MBATCH_SIZE=8
MAP_PARAMS=0
LEARNING_RATE=


## Check that IRM and IBM are working correctly

if [ $VER$DEMAND_VB_VER$NET == 'ibm_mse_trial_3'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIBM'
    MAP_TYPE="None"
    gain='ibm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'ibm_trial_3'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIBM'
    MAP_TYPE="None"
    gain='ibm'
fi


if [ $VER$DEMAND_VB_VER$NET == 'irm_mse_trial_3'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIRM'
    MAP_TYPE="None"
    gain='irm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'irm_trial_3'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIRM'
    MAP_TYPE="None"
    gain='irm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'irm_mse_trial_2'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="None"
    gain='irm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'irm_trial_2'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="None"
    gain='irm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'ibm_mse_trial_2'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="None"
    gain='ibm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'ibm_trial_2'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="None"
    gain='ibm'
fi

## Directly estimate gain (use clipping between 0 and 1)

if [ $VER$DEMAND_VB_VER$NET == 'mmse-lsa_clip_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="Clip"
    MAP_PARAMS='0.0,1.0'
    gain='mmse-lsa'
fi

if [ $VER$DEMAND_VB_VER$NET == 'mmse-lsa_clip'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="Clip"
    MAP_PARAMS='0.0,1.0'
    gain='mmse-lsa'
fi

if [ $VER$DEMAND_VB_VER$NET == 'mmse-stsa_clip_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="Clip"
    MAP_PARAMS='0.0,1.0'
    gain='mmse-stsa'
fi

if [ $VER$DEMAND_VB_VER$NET == 'mmse-stsa_clip'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="Clip"
    MAP_PARAMS='0.0,1.0'
    gain='mmse-stsa'
fi

if [ $VER$DEMAND_VB_VER$NET == 'cwf_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="None"
    gain='cwf'
fi

if [ $VER$DEMAND_VB_VER$NET == 'cwf'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="None"
    gain='cwf'
fi

if [ $VER$DEMAND_VB_VER$NET == 'wf_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="None"
    gain='wf'
fi

if [ $VER$DEMAND_VB_VER$NET == 'wf'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagGain'
    MAP_TYPE="None"
    gain='wf'
fi

#----------------------------------------------------------------------

if [ $VER$DEMAND_VB_VER$NET == 'mag_pow'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Linear"
    INP_TGT_TYPE='MagMag'
    MAP_TYPE='Power'
    MAP_PARAMS='0.3'
fi

if [ $VER$DEMAND_VB_VER$NET == 'iam'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIAM'
    MAP_TYPE='None'
fi

if [ $VER$DEMAND_VB_VER$NET == 'iam_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIAM'
    MAP_TYPE='None'
fi

if [ $VER$DEMAND_VB_VER$NET == 'iam_mmsa'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MaskedMagnitudeSpectrumApproximation"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIAM'
    MAP_TYPE='None'
fi

if [ $VER$DEMAND_VB_VER$NET == 'mmse-stsa_db'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT='Linear'
    INP_TGT_TYPE='MagGain'
    MAP_TYPE='SquareDB'
    gain='mmse-stsa'
fi

if [ $VER$DEMAND_VB_VER$NET == 'mmse-lsa_db'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT='Linear'
    INP_TGT_TYPE='MagGain'
    MAP_TYPE='SquareDB'
    gain='mmse-lsa'
fi

if [ $VER$DEMAND_VB_VER$NET == 'irm_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIRM'
    MAP_TYPE="None"
    gain='irm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'irm'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIRM'
    MAP_TYPE="None"
    gain='irm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'ibm_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIBM'
    MAP_TYPE="None"
    gain='ibm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'ibm'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagIBM'
    MAP_TYPE="None"
    gain='ibm'
fi

if [ $VER$DEMAND_VB_VER$NET == 'mag_bar_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagMag'
    MAP_TYPE='SquareDBNormalCDF'
fi

if [ $VER$DEMAND_VB_VER$NET == 'mag_bar'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagMag'
    MAP_TYPE='SquareDBNormalCDF'
fi

if [ $VER$DEMAND_VB_VER$NET == 'pow_db_norm_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagMag'
    MAP_TYPE='SquareDBMinMaxScaling'
fi

if [ $VER$DEMAND_VB_VER$NET == 'pow_db_norm'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagMag'
    MAP_TYPE='SquareDBMinMaxScaling'
fi

if [ $VER$DEMAND_VB_VER$NET == 'pow_db_std'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT='Linear'
    INP_TGT_TYPE='MagMag'
    MAP_TYPE='SquareDBStandardise'
fi

if [ $VER$DEMAND_VB_VER$NET == 'pow_db'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT='Linear'
    INP_TGT_TYPE='MagMag'
    MAP_TYPE='SquareDB'
fi

if [ $VER$DEMAND_VB_VER$NET == 'mag_norm_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagMag'
    MAP_TYPE='MinMaxScaling'
fi

if [ $VER$DEMAND_VB_VER$NET == 'mag_norm'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagMag'
    MAP_TYPE='MinMaxScaling'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_gamma_bar_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXiGamma'
    MAP_TYPE='DBNormalCDF,DBLaplaceCDF'
    MAP_PARAMS='None;0.0'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_gamma_bar'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXiGamma'
    MAP_TYPE='DBNormalCDF,DBLaplaceCDF'
    MAP_PARAMS='None;0.0'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_gamma_db_norm'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXiGamma'
    MAP_TYPE='DBMinMaxScaling,DBMinMaxScaling'
	MAP_PARAMS='0.0;0.0'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_gamma_db_norm_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXiGamma'
    MAP_TYPE='DBMinMaxScaling,DBMinMaxScaling'
	MAP_PARAMS='0.0;0.0'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_gamma_db'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT='Linear'
    INP_TGT_TYPE='MagXiGamma'
    MAP_TYPE='DB,DB'
	MAP_PARAMS='0.0;0.0'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_gamma_norm'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXiGamma'
    MAP_TYPE='MinMaxScaling,MinMaxScaling'
	MAP_PARAMS='0.0;0.0'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_gamma_norm_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXiGamma'
    MAP_TYPE='MinMaxScaling,MinMaxScaling'
	MAP_PARAMS='0.0;0.0'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_bar_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE="MagXi"
    MAP_TYPE="DBNormalCDF"
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_bar'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE="MagXi"
    MAP_TYPE="DBNormalCDF"
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_db_norm'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXi'
    MAP_TYPE='DBMinMaxScaling'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_db_norm_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXi'
    MAP_TYPE='DBMinMaxScaling'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_db_std'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Linear"
    INP_TGT_TYPE='MagXi'
    MAP_TYPE='DBStandardise'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_db'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Linear"
    INP_TGT_TYPE='MagXi'
    MAP_TYPE='DB'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_norm'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="BinaryCrossentropy"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXi'
    MAP_TYPE='MinMaxScaling'
fi

if [ $VER$DEMAND_VB_VER$NET == 'xi_norm_mse'$DEMAND_VB_VER$NET ]
then
    LOSS_FNC="MeanSquaredError"
    OUTP_ACT="Sigmoid"
    INP_TGT_TYPE='MagXi'
    MAP_TYPE='MinMaxScaling'
fi

if [ $NETWORK == "MHANetV3" ]
then
  python3 main.py --ver               $VER$DEMAND_VB_VER$NET      \
                  --network           $NETWORK                    \
                  --d_model           256                         \
                  --n_blocks          5                           \
                  --n_heads           8                           \
                  --warmup_steps      40000                       \
                  --causal            1                           \
                  --max_len           2048                        \
                  --loss_fnc          $LOSS_FNC                   \
                  --outp_act          $OUTP_ACT                   \
                  --max_epochs        $MAX_EPOCHS                 \
                  --resume_epoch      $RESUME_EPOCH               \
                  --test_epoch        $TEST_EPOCH                 \
                  --mbatch_size       $MBATCH_SIZE                \
                  --inp_tgt_type      $INP_TGT_TYPE               \
                  --map_type          $MAP_TYPE                   \
                  --map_params        $MAP_PARAMS                 \
                  --sample_size       $SAMPLE_SIZE                \
                  --f_s               $F_S                        \
                  --T_d               $T_D                        \
                  --T_s               $T_S                        \
                  --min_snr           $MIN_SNR                    \
                  --max_snr           $MAX_SNR                    \
                  --snr_inter         $SNR_INTER                  \
                  --out_type          $OUT_TYPE                   \
                  --save_model        1                           \
                  --log_iter          0                           \
                  --eval_example      0                           \
                  --reset_inp_tgt     $RESET_INP_TGT              \
                  --val_flag          $VAL_FLAG                   \
                  --gain              $GAIN                       \
                  --train             $TRAIN                      \
                  --infer             $INFER                      \
                  --test              $TEST                       \
                  --gpu               $GPU                        \
                  --set_path          $SET_PATH                   \
                  --log_path          $LOG_PATH                   \
                  --data_path         $DATA_PATH                  \
                  --test_x_path       $TEST_X_PATH                \
                  --test_s_path       $TEST_S_PATH                \
                  --test_d_path       $TEST_D_PATH                \
                  --out_path          $OUT_PATH                   \
                  --model_path        $MODEL_PATH
    exit 0
fi

if [ $NETWORK == "ChimeraBLSTM" ]
then
  python3 main.py --ver               $VER$DEMAND_VB_VER$NET      \
                  --network           $NETWORK                    \
                  --loss_fnc          $LOSS_FNC                   \
                  --outp_act          $OUTP_ACT                   \
                  --max_epochs        $MAX_EPOCHS                 \
                  --resume_epoch      $RESUME_EPOCH               \
                  --test_epoch        $TEST_EPOCH                 \
                  --mbatch_size       $MBATCH_SIZE                \
                  --inp_tgt_type      $INP_TGT_TYPE               \
                  --map_type          $MAP_TYPE                   \
                  --map_params        $MAP_PARAMS                 \
                  --sample_size       $SAMPLE_SIZE                \
                  --f_s               $F_S                        \
                  --T_d               $T_D                        \
                  --T_s               $T_S                        \
                  --min_snr           $MIN_SNR                    \
                  --max_snr           $MAX_SNR                    \
                  --snr_inter         $SNR_INTER                  \
                  --out_type          $OUT_TYPE                   \
                  --save_model        1                           \
                  --log_iter          0                           \
                  --eval_example      0                           \
                  --reset_inp_tgt     $RESET_INP_TGT              \
                  --val_flag          $VAL_FLAG                   \
                  --gain              $GAIN                       \
                  --train             $TRAIN                      \
                  --infer             $INFER                      \
                  --test              $TEST                       \
                  --gpu               $GPU                        \
                  --set_path          $SET_PATH                   \
                  --log_path          $LOG_PATH                   \
                  --data_path         $DATA_PATH                  \
                  --test_x_path       $TEST_X_PATH                \
                  --test_s_path       $TEST_S_PATH                \
                  --test_d_path       $TEST_D_PATH                \
                  --out_path          $OUT_PATH                   \
                  --model_path        $MODEL_PATH
    exit 0
fi

if [ $NETWORK == "ChimerappBLSTM" ]
then
  python3 main.py --ver               $VER$DEMAND_VB_VER$NET      \
                  --network           $NETWORK                    \
                  --loss_fnc          $LOSS_FNC                   \
                  --outp_act          $OUTP_ACT                   \
                  --max_epochs        $MAX_EPOCHS                 \
                  --resume_epoch      $RESUME_EPOCH               \
                  --test_epoch        $TEST_EPOCH                 \
                  --mbatch_size       $MBATCH_SIZE                \
                  --inp_tgt_type      $INP_TGT_TYPE               \
                  --map_type          $MAP_TYPE                   \
                  --map_params        $MAP_PARAMS                 \
                  --sample_size       $SAMPLE_SIZE                \
                  --f_s               $F_S                        \
                  --T_d               $T_D                        \
                  --T_s               $T_S                        \
                  --min_snr           $MIN_SNR                    \
                  --max_snr           $MAX_SNR                    \
                  --snr_inter         $SNR_INTER                  \
                  --out_type          $OUT_TYPE                   \
                  --save_model        1                           \
                  --log_iter          0                           \
                  --eval_example      0                           \
                  --reset_inp_tgt     $RESET_INP_TGT              \
                  --val_flag          $VAL_FLAG                   \
                  --gain              $GAIN                       \
                  --train             $TRAIN                      \
                  --infer             $INFER                      \
                  --test              $TEST                       \
                  --gpu               $GPU                        \
                  --set_path          $SET_PATH                   \
                  --log_path          $LOG_PATH                   \
                  --data_path         $DATA_PATH                  \
                  --test_x_path       $TEST_X_PATH                \
                  --test_s_path       $TEST_S_PATH                \
                  --test_d_path       $TEST_D_PATH                \
                  --out_path          $OUT_PATH                   \
                  --model_path        $MODEL_PATH
    exit 0
fi

python3 main.py --ver               $VER$DEMAND_VB_VER$NET      \
                --network           'ResNetV3'                  \
                --d_model           $D_MODEL                    \
                --n_blocks          $N_BLOCKS                   \
                --d_f               $D_F                        \
                --k                 $K                          \
                --max_d_rate        $MAX_D_RATE                 \
                --causal            $CAUSAL                     \
                --unit_type         $UNIT_TYPE                  \
                --loss_fnc          $LOSS_FNC                   \
                --outp_act          $OUTP_ACT                   \
                --max_epochs        $MAX_EPOCHS                 \
                --resume_epoch      $RESUME_EPOCH               \
                --test_epoch        $TEST_EPOCH                 \
                --mbatch_size       $MBATCH_SIZE                \
                --inp_tgt_type      $INP_TGT_TYPE               \
                --map_type          $MAP_TYPE                   \
                --map_params        $MAP_PARAMS                 \
                --sample_size       $SAMPLE_SIZE                \
                --f_s               $F_S                        \
                --T_d               $T_D                        \
                --T_s               $T_S                        \
                --min_snr           $MIN_SNR                    \
                --max_snr           $MAX_SNR                    \
                --snr_inter         $SNR_INTER                  \
                --out_type          $OUT_TYPE                   \
                --save_model        1                           \
                --log_iter          0                           \
                --eval_example      0                           \
                --reset_inp_tgt     $RESET_INP_TGT              \
                --val_flag          $VAL_FLAG                   \
                --gain              $GAIN                       \
                --train             $TRAIN                      \
                --infer             $INFER                      \
                --test              $TEST                       \
                --gpu               $GPU                        \
                --set_path          $SET_PATH                   \
                --log_path          $LOG_PATH                   \
                --data_path         $DATA_PATH                  \
                --test_x_path       $TEST_X_PATH                \
                --test_s_path       $TEST_S_PATH                \
                --test_d_path       $TEST_D_PATH                \
                --out_path          $OUT_PATH                   \
                --model_path        $MODEL_PATH
exit 0
