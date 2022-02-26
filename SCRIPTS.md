# Python Script For Extracting FFT Array

I have created python script `extract_fft_array.py` for extracting FFT array from audio sample.

Default directory for storing audio files are under `./audio`.

Samples from [Sound samples - Philharmonia Orchestra](https://philharmonia.co.uk/resources/sound-samples/).

## Installation

To create and activate conda environment run:

```bash
conda create -n audio-processing python=3.9
# activate environment
conda activate audio-processing
```

To install required packages run:

```
pip install matplotlib librosa
```

You may need to install this as well.

```
ipython kernel install --user --name=audio-processing
```

## Usage

To extract fft to `fft.txt` run:

```
python3 extract_ftt_array.py [audio_file_name] > ./result/fft.txt
```

> If it doesn't work, try execute the command with external terminal (Not inside VScode), and make sure you are running in the environment you just created
>
> Or add this in your settings.json
>
> ```
> "terminal.integrated.env.osx": {
>        "PATH": ""
> }
> ```

Then, copy the array manually to Swift.

To batch process result run:

```

bash batch_process.sh [instrument]

```
