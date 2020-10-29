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
