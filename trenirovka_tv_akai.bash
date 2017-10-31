#!/bin/bash
# Script coverts all H263 and such movies to XVID codec AVI.
#/usr/bin/ffmpeg -threads 2  -y -i "/media/VERBATIM HD/Original/BDMV 14_03_2014-08_01_2015/20150104_01118.MTS"  -deinterlace -f avi -vcodec libxvid -vtag XVID -b 6000k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -acodec copy -r:v 25  "/home/denis/films2/20150201 Презентация Михаила Морозова/20150104_01118.avi"



for movie in *.mts *.MTS *.mkv *.mp4 *.MP4;
do
  if ! [ -f "$movie".avi ]
  then
    avconv -i "$movie" -f avi -vcodec libxvid -vtag XVID -b:v 1500k -maxrate 1800k -mbd 2 -bf 2 -filter:v yadif -threads 0 -y -r:v 25 -acodec libmp3lame -b:a 32k -ac 1 "$movie".avi
  else
    echo "Looks like "$movie" has been converted already. Skip it."
  fi;
done
