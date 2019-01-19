#!/bin/bash
# Script coverts all H263 and such movies to XVID codec AVI.

for movie in *.mts *.MTS *.mkv *.mp4 *.MP4;
do
  if ! [ -f "$movie".avi ]
  then
    #DBLEVEL=`avconv -i "$movie" -af "volumedetect" -f null /dev/null 2>&1 | grep max_volume | awk -F': ' '{print $2}' | cut -d' ' -f1`

    avconv -threads 0 -y -i "$movie" -f avi -vcodec libxvid -vtag XVID -b:v 1500k -maxrate 1800k -mbd 2 -bf 2 -flags +mv4+aic -trellis 2 -cmp 2 -subcmp 2 -filter:v "yadif=deint=1" -r:v 25 -acodec libmp3lame -b:a 32k -ac 1 -af "volume=10dB" "$movie".avi
  else
    echo "Looks like "$movie" has been converted already. Skip it."
  fi;
done
