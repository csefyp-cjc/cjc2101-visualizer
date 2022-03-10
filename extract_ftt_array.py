import librosa
import librosa.display
import numpy as np
import sys

audio_file = sys.argv[1]
# audio_file = "audio/cello/cello_Gs5_05_mezzo-piano_arco-normal.mp3"     # Cello samples
# audio_file = "audio/flute/flute_D4_05_mezzo-forte_normal.mp3"     # Flute samples

data, sr = librosa.load(audio_file, sr=44100)

FRAME_SIZE = 2048
HOP_SIZE = 512

stft_data = librosa.stft(data, n_fft=FRAME_SIZE, hop_length=HOP_SIZE)

# Extract columns (Range of frames)
sustain_data = np.abs(stft_data)[:, int(
    stft_data.shape[1]/4): int(stft_data.shape[1]/2)]

# Take average of each rows
average_data = np.mean(sustain_data, axis=1)

with np.printoptions(threshold=np.inf):
    print(repr(average_data))

# with np.printoptions(threshold=np.inf):
#     print(repr(np.abs(stft_data)[:, int(stft_data.shape[1]/4)]))
