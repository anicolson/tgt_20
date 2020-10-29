import soundfile as sf
import scipy.io.wavfile as sf_backup

path = '/home/aaron/set/SE_TRAIN_V2/val_clean_speech/3185_6019-3185-0078_33340_3_-9dB.wav'

wav1, f_s = sf.read(path, dtype='int16')
f_s, wav2 = sf_backup.read(path)
print(wav1)
print(wav2)
print(len(wav1), len(wav2))
print(f_s, f_s)
