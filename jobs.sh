
#!/bin/bash

chmod +x ./run.sh

## DEMAND VOICEBANK DATASET
###########################

<<'COMMENTS'

WON'T TRAIN:
smm
mag_norm_mse   % try on n060
xi_gamma_norm_mse
COMMENTS

# ./run.sh DATASET=demand_vb VER=xi_norm INFER=1 GAIN=srwf GPU=3

## DEEP XI DATASET
##################

<<'COMMENTS'

WON'T TRAIN:
mag_norm_mse

EXCLUDED:
xi_norm w. mmse-lsa & srwf
xi_norm_mse w. mmse-lsa & srwf
xi_gamma_norm_mse w. mmse-lsa
xi_gamma_norm w. mmse-lsa

SCORING:

STINK:
xi_gamma_db_norm_mse w. mmse-lsa   %% resumed
xi_gamma_db_norm w. mmse-lsa     %% resumed

FIST:

PINKY-JNR:

COMMENTS

# GAIN=srwf
# RESUME_EPOCH=108
# INFER=1
# TRAIN=1

./run.sh DATASET=deep_xi VER=xi_db_std INFER=1 GAIN=srwf

exit 0
