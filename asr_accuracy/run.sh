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

EPOCH='e150'
DEMAND_VB=''
DIR_TEST='/home/aaron/mnt/aaron_root/mnt/hdd1/out/tgt_20'
# DIR_SAVE='/home/aaron/mnt/aaron_root/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb'
DIR_SAVE='/home/aaron/mnt/aaron_root/mnt/hdd1/out/tgt_20/hyp_trans/'
UNDERSCORE='_'

## VERSION CONTROL
test_set=$DIR_TEST'/xi_gamma_db_norm_mse'$DEMAND_VB'/'$EPOCH'/y/mmse-lsa'
out_path=$DIR_SAVE'/xi_gamma_db_norm_mse'$UNDERSCORE$EPOCH$UNDERSCORE'mmse-lsa'

# test_set=/home/aaron/mnt/aaron/set/DEMAND_VB/noisy_testset_wav
# out_path=$DIR_SAVE'/noisy_speech'

## CREATE HYPOTHESIS TRANSCRIPTION DIRECTORY
[ -d $out_path ] || mkdir -p $out_path

## PATH TO MODEL AND SCORER
MODEL=~/model/deepspeech/deepspeech-0.7.4-models.pbmm
SCORER=~/model/deepspeech/deepspeech-0.7.4-models.scorer

nvidia-smi
echo -n "GPU no.: "
read GPU
export CUDA_VISIBLE_DEVICES=$GPU

source $HOME/venv/deepspeech/bin/activate

## INFERENCE
count=0
total=$(ls -1q $test_set/*.wav | wc -l)
for wav in `find $test_set -name '*.wav'` ; do
deepspeech --model $MODEL --scorer $SCORER --audio $wav 2>/dev/null > $out_path/`basename $wav .wav`.txt ;
count=$((count + 1))
printf "File %d of %d processed.\r" "$count" "$total"
done

printf 'Inference complete.              \n'
