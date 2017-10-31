#!/bin/bash
# Script coverts all H263 and such movies to XVID codec AVI.
#/usr/bin/ffmpeg -threads 2  -y -i "/media/VERBATIM HD/Original/BDMV 14_03_2014-08_01_2015/20150104_01118.MTS"  -deinterlace -f avi -vcodec libxvid -vtag XVID -b 6000k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -acodec copy -r:v 25  "/home/denis/films2/20150201 Презентация Михаила Морозова/20150104_01118.avi"

if ! [ -d tv ]
then
{
 echo "No tv dir exists! Created tv dir."
 mkdir tv
}
fi

for movie in *.mts *.MTS *.mkv;
do
  if ! [ -f tv/"$movie".avi ]
  then
    avconv -i $movie -f avi -vcodec libxvid -vtag XVID -q:v 2 -deinterlace -threads 2 -y -acodec copy -r:v 25 tv/$movie.avi
  else
    echo "Looks like $movie has been converted already. Skipped it."
  fi;
done
