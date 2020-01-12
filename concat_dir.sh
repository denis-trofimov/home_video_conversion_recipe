#!/usr/bin/env bash
get_abs_filename() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}

if [[ ($# < 2) || ($1 == '-h') || ($1 == '--help') ]]
then
    echo "Usage: `basename $0` source_dir target"
    exit 1
fi
concat=""
i=0
for file in $1/*.*
do
    echo $(get_abs_filename $file)
    if [ $i == 0 ]
    then
        concat="concat:$(get_abs_filename $file)"
    else
        concat="${concat}|$(get_abs_filename $file)"
    fi
    i+=1
done
echo ffmpeg -i ${concat} -c copy -sn -y $2
ffmpeg -i ${concat} -c copy -sn -y $2
exit 0