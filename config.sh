#!/bin/bash

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
