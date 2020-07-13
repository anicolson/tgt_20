#!/bin/bash
chmod +x ./config.sh
. ./config.sh

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
MIN_SNR=-10
MAX_SNR=20
SNR_INTER=1
MAX_EPOCHS=200
TEST_EPOCH="100,125,150,175,200"
MBATCH_SIZE=8

# TO DO: s_stms, s_pow, s_pow_db, s_pow_bar

if [ "$VER" == 'irm' ]
then
    python3 main.py --ver               $VER                        \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "BinaryCrossentropy"        \
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
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ "$VER" == 'ibm' ]
then
    python3 main.py --ver               $VER                        \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "BinaryCrossentropy"        \
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
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

# map_params needs fixing.
if [ "$VER" == 'xi_gamma_bar' ]
then
    python3 main.py --ver               $VER                        \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "BinaryCrossentropy"        \
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
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ "$VER" == 'xi_gamma_db' ]
then
    python3 main.py --ver               $VER                        \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquareError"           \
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
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ "$VER" == 'xi_gamma' ]
then
    python3 main.py --ver               $VER                        \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquareError"           \
                    --max_epochs        200                         \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagXiGamma'                \
                    --map_type          'Linear,Linear'             \
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
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ "$VER" == 'xi_bar' ]
then
    python3 main.py --ver               $VER                        \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "BinaryCrossentropy"        \
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
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ "$VER" == 'xi_db' ]
then
    python3 main.py --ver               $VER                        \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquareError"           \
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
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi

if [ "$VER" == 'xi' ]
then
    python3 main.py --ver               $VER                        \
                    --network           $NETWORK                    \
                    --d_model           $D_MODEL                    \
                    --n_blocks          $N_BLOCKS                   \
                    --d_f               $D_F                        \
                    --k                 $K                          \
                    --max_d_rate        $MAX_D_RATE                 \
                    --causal            $CAUSAL                     \
                    --unit_type         $UNIT_TYPE                  \
                    --loss_fnc          "MeanSquareError"           \
                    --max_epochs        200                         \
                    --resume_epoch      0                           \
                    --test_epoch        $TEST_EPOCH                 \
                    --mbatch_size       $MBATCH_SIZE                \
                    --inp_tgt_type      'MagXi'                     \
                    --map_type          'Linear'                    \
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
                    --gain              $GAIN                       \
                    --train             $TRAIN                      \
                    --infer             $INFER                      \
                    --test              $TEST                       \
                    --gpu               $GPU                        \
                    --set_path          $SET_PATH                   \
                    --data_path         $DATA_PATH                  \
                    --test_x_path       $TEST_X_PATH                \
                    --test_s_path       $TEST_S_PATH                \
                    --test_d_path       $TEST_D_PATH                \
                    --out_path          $OUT_PATH                   \
                    --model_path        $MODEL_PATH
fi
