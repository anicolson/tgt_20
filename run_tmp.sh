#!/bin/bash

# DEMAND_VB=0
#
# if [ $DEMAND_VB ]
# then
#   chmod +x ./config_demand_vb.sh
#   . ./config_demand_vb.sh
#   DEMAND_VB_VER="_demand_vb"
#   VAL_FLAG=0
#   MIN_SNR=0
#   MAX_SNR=15
#   SNR_INTER=5
# else
chmod +x ./config.sh
. ./config.sh
DEMAND_VB_VER=""
VAL_FLAG=1
MIN_SNR=-10
MAX_SNR=20
SNR_INTER=1
# fi

cd ../DeepXi

NETWORK='ResNetV3'
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
MAX_EPOCHS=200
TEST_EPOCH="100,125,150,175,200"
MBATCH_SIZE=8

if [ $VER$DEMAND_VB_VER == 'mmse-stsa_db'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquaredError"          \
                    --outp_act          "Linear"                    \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagGain'                   \
                    --map_type          'SquareDB'                  \
                    --gain              'mmse-stsa'                 \
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
                    --eval_example      1                           \
                    --reset_inp_tgt     $RESET_INP_TGT              \
                    --val_flag          $VAL_FLAG                   \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --log_path          $LOG_PATH                   \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ $VER$DEMAND_VB_VER == 'mmse-lsa_db'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquaredError"          \
                    --outp_act          "Linear"                    \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagGain'                   \
                    --map_type          'SquareDB'                  \
                    --gain              'mmse-lsa'                  \
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
                    --eval_example      1                           \
                    --reset_inp_tgt     $RESET_INP_TGT              \
                    --val_flag          $VAL_FLAG                   \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --log_path          $LOG_PATH                   \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ $VER$DEMAND_VB_VER == 'irm'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "BinaryCrossentropy"        \
                    --outp_act          "Sigmoid"                   \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagGain'                   \
                    --gain              'irm'                       \
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
                    --eval_example      1                           \
                    --reset_inp_tgt     $RESET_INP_TGT              \
                    --val_flag          $VAL_FLAG                   \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --log_path          $LOG_PATH                   \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ $VER$DEMAND_VB_VER == 'ibm'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "BinaryCrossentropy"        \
                    --outp_act          "Sigmoid"                   \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagGain'                   \
                    --gain              'ibm'                       \
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
                    --eval_example      1                           \
                    --reset_inp_tgt     $RESET_INP_TGT              \
                    --val_flag          $VAL_FLAG                   \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --log_path          $LOG_PATH                   \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ $VER$DEMAND_VB_VER == 'mag_bar'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "BinaryCrossentropy"        \
                    --outp_act          "Sigmoid"                   \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagMag'                    \
                    --map_type          'SquareDBNormalCDF'         \
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
                    --eval_example      1                           \
                    --reset_inp_tgt     $RESET_INP_TGT              \
                    --val_flag          $VAL_FLAG                   \
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --log_path          $LOG_PATH                   \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ $VER$DEMAND_VB_VER == 'pow_db_std'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquaredError"          \
                    --outp_act          "Linear"                    \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagMag'                    \
                    --map_type          'SquareDBStandardise'       \
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
                    --eval_example      1                           \
                    --reset_inp_tgt     $RESET_INP_TGT              \
                    --val_flag          $VAL_FLAG                   \
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --log_path          $LOG_PATH                   \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ $VER$DEMAND_VB_VER == 'pow_db'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquaredError"          \
                    --outp_act          "Linear"                    \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagMag'                    \
                    --map_type          'SquareDB'                  \
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
                    --eval_example      1                           \
                    --reset_inp_tgt     $RESET_INP_TGT              \
                    --val_flag          $VAL_FLAG                   \
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --log_path          $LOG_PATH                   \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ $VER$DEMAND_VB_VER == 'xi_gamma_bar'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "BinaryCrossentropy"        \
                    --outp_act          "Sigmoid"                   \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagXiGamma'                \
                    --map_type          'DBNormalCDF,DBLaplaceCDF'  \
                    --map_params        'None;0.0'                  \
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
                    --eval_example      1                           \
                    --reset_inp_tgt     $RESET_INP_TGT              \
                    --val_flag          $VAL_FLAG                   \
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --log_path          $LOG_PATH                   \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ $VER$DEMAND_VB_VER == 'xi_gamma_db'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquaredError"          \
                    --outp_act          "Linear"                    \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagXiGamma'                \
                    --map_type          'DB,DB'                     \
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
                    --eval_example      1                           \
                    --reset_inp_tgt     $RESET_INP_TGT              \
                    --val_flag          $VAL_FLAG                   \
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --log_path          $LOG_PATH                   \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ $VER$DEMAND_VB_VER == 'xi_bar'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "BinaryCrossentropy"        \
                    --outp_act          "Sigmoid"                   \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagXi'                     \
                    --map_type          'DBNormalCDF'               \
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
                    --eval_example      1                           \
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
fi

if [ $VER$DEMAND_VB_VER == 'xi_db_std'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquaredError"          \
                    --outp_act          "Linear"                    \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagXi'                     \
                    --map_type          'DBStandardise'             \
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
                    --eval_example      1                           \
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
fi

if [ $VER$DEMAND_VB_VER == 'xi_db'$DEMAND_VB_VER ]
then
    python3 main.py --ver               $VER$DEMAND_VB_VER          \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquaredError"          \
                    --outp_act          "Linear"                    \
                    --max_epochs        $MAX_EPOCHS                 \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagXi'                     \
                    --map_type          'DB'                        \
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
                    --eval_example      1                           \
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
fi
