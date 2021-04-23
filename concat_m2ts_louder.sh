#!/usr/bin/env bash
get_abs_filename() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}

if [[ ($# < 2) || ($1 == '-h') || ($1 == '--help') ]] ; then
    echo "Concatenate all *.MTS videos found in the dir given. Adjust the volume up 12dB."
    echo "Usage: `basename $0` source_dir target"
    exit 22  # EINVAL   /* Invalid argument */
fi
concat=""
i=0
for file in $1/*.m2ts ; do
    echo $(get_abs_filename $file)
    if [ $i == 0 ] ; then
        concat="concat:$(get_abs_filename $file)"
    else
        concat="${concat}|$(get_abs_filename $file)"
    fi
    i+=1
done
ffmpeg -i ${concat} -vcodec copy -acodec aac -b:a 128k -af "volume=12dB" -bsf:a aac_adtstoasc -sn -y $2
exit 0
