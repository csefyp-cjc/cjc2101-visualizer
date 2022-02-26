# !/bin/bash
DIR=./audio/$1/*

# Make sure your have created the results directory
for FILE in $DIR
do    
  python3 extract_ftt_array.py $FILE > ./results/$(basename $FILE .mp3).txt
  sed -i '' 's/^[^(]*(//' ./results/$(basename $FILE .mp3).txt # Delete everything before the array
  sed -i '' 's/\].*/]/' ./results/$(basename $FILE .mp3).txt   # Delete everything after the array
done