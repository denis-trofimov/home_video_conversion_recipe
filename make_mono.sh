#!/bin/bash
# Script coverts all H263 and such movies to XVID codec AVI.

for movie in *.mts *.MTS *.mkv *.mp4 *.MP4;
do
  if [ -f "$movie".avi ]
  then
    avconv -i "$movie".avi -i "$movie" -map 0:0 -map 1:1 -f avi -vcodec copy -acodec libmp3lame -b:a 32k -ac 1 -af "volume=12dB" "$movie".10dB.avi
  else
    echo "Looks like "$movie" has been converted already. Skip it."
  fi;
done
