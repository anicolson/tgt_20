"""
The tgt_20 project.
Copyright (C) 2020  Aaron Nicolson

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""

import soundfile as sf
import scipy.io.wavfile as sf_backup

path = '/home/aaron/set/SE_TRAIN_V2/val_clean_speech/3185_6019-3185-0078_33340_3_-9dB.wav'

wav1, f_s = sf.read(path, dtype='int16')
f_s, wav2 = sf_backup.read(path)
print(wav1)
print(wav2)
print(len(wav1), len(wav2))
print(f_s, f_s)
