export CUDA_VISIBLE_DEVICES=1

source $HOME/venv/deepspeech/bin/activate

## PATH TO TEST WAVE FILE DIRECTORY
test_set=/mnt/ssd/deep_xi_test_set/test_noisy_speech

## PATH TO HYPOTHESIS TRANSCRIPTION OUTPUT DIRECTORY
out_path=/home/aaron/mnt/aaron_root/mnt/hdd1/out/tgt_20/hyp_trans/noisy_speech
[ -d $out_path ] || mkdir -p $out_path

## PATH TO MODEL AND SCORER
MODEL=~/model/deepspeech/deepspeech-0.7.4-models.pbmm
SCORER=~/model/deepspeech/deepspeech-0.7.4-models.scorer

## INFERENCE
count=0
total=$(ls -1q $test_set/*.wav | wc -l)
for wav in `find $test_set -name '*.wav'` ; do 
deepspeech --model $MODEL --scorer $SCORER --audio $wav 2>/dev/null > $out_path/`basename $wav .wav`.txt ;  
count=$((count + 1))
printf "File %d of %d processed.\r" "$count" "$total"
done

printf 'Inference complete.              \n'
