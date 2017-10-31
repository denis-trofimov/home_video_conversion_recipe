#!/bin/bash
# Script coverts all H263 and such movies to XVID codec AVI.
#-f avi -vcodec libxvid -vtag XVID -maxrate 1800k -b 1500k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -acodec copy

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
    avconv -i $movie -f avi -vcodec libxvid -vtag XVID -b 6000k -deinterlace -threads 0 -y -acodec copy tv/$movie.avi
  else
    echo "Looks like $movie has been converted already. Skipped it."
  fi;
done
