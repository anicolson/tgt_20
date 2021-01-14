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

get_free_gpu () {
    NUM_GPU=$( nvidia-smi --query-gpu=pci.bus_id --format=csv,noheader | wc -l )
    echo "$NUM_GPU total GPU/s."
    if [ $1 -eq 1  ]
    then
        echo 'Sleeping'
        sleep 1m
    fi
    while true
    do
        for (( gpu=0; gpu<$NUM_GPU; gpu++ ))
        do
            VAR1=$( nvidia-smi -i $gpu --query-gpu=pci.bus_id --format=csv,noheader )
            VAR2=$( nvidia-smi -i $gpu --query-compute-apps=gpu_bus_id --format=csv,noheader | head -n 1)
            if [ "$VAR1" != "$VAR2" ]
            then
                return $gpu
            fi
        done
        echo 'Waiting for free GPU.'
        sleep 1m
    done
}

VER=0
TRAIN=0
INFER=0
TEST=0
OUT_TYPE='y'
GAIN='mmse-lsa'
RESET_INP_TGT=0
RESUME_EPOCH=0
DATASET=
NETWORK=

for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)
    case "$KEY" in
            VER)                 VER=${VALUE} ;;
            GPU)                 GPU=${VALUE} ;;
            TRAIN)               TRAIN=${VALUE} ;;
            INFER)               INFER=${VALUE} ;;
            TEST)                TEST=${VALUE} ;;
            OUT_TYPE)            OUT_TYPE=${VALUE} ;;
            GAIN)                GAIN=${VALUE} ;;
            RESET_INP_TGT)       RESET_INP_TGT=${VALUE} ;;
            RESUME_EPOCH)        RESUME_EPOCH=${VALUE} ;;
            DATASET)             DATASET=${VALUE} ;;
            NETWORK)             NETWORK=${VALUE} ;;
            *)
    esac
done

if [ hostname == 'n060' ]
then
	GPU=0
else
	WAIT=0
	if [ -z $GPU ]
	then
	    get_free_gpu $WAIT
	    GPU=$?
	fi
fi

echo "Using GPU $GPU."
