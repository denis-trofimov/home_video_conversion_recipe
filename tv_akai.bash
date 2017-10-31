#!/bin/bash
# Script coverts all H263 and such movies to XVID codec AVI.

if ! [ -d tv ]
then
{
 echo "No tv dir exists! Created tv dir."
 mkdir tv
}
fi

for movie in *.mts *.MTS *.mkv *.mp4 *.MP4;
do
  if ! [ -f tv/"$movie".avi ]
  then
    avconv -i $movie -f avi -vcodec libxvid -vtag XVID -b:v 5500k -filter:v "yadif=deint=1" -r:v 25 -acodec libmp3lame -b:a 64k -threads 0 -y tv/"$movie".avi
  else
    echo "Looks like "$movie" has been converted already. Skip it."
  fi;
done
