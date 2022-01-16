#!/usr/bin/env bash
get_abs_filename() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]
  then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}

if [[ ($# -lt 2) || ($1 == '-h') || ($1 == '--help') ]] ; then
    echo "Concatenate all *.MTS or *.extension videos found in the dir given. Adjust the volume up 12dB."
    echo "Usage: $(basename $0) path target [--type extension] [--rotate]"
    exit 22  # EINVAL   /* Invalid argument */
fi

path=$1
target=$2
type="MTS"
rotate=""

if [[ ($# == 4) && ($3 == "--type") ]]
then
    type=$4
fi

if [[ ($# == 5) && ($5 == "--rotate") || ($# == 3) && ($3 == "--rotate") ]]
then
    rotate='-metadata:s:v rotate="-90"'
fi

concat="concat:"
i=0
for file in $path/*.$type
do
    echo "$(get_abs_filename $file)"
    if [ ${i} == 0 ]
    then
        concat="concat:temp${i}"
    else
        concat="${concat}|temp${i}"
    fi
    
    # use named pipes to avoid creating intermediate files
    mkfifo temp${i}
    (ffmpeg -y -i "$(get_abs_filename $file)" -codec copy -bsf:v h264_mp4toannexb -f mpegts temp${i} 2> /dev/null &)
    
    ((i++))
done

echo ${concat}
ffmpeg -v verbose -y -f mpegts -i ${concat} ${rotate} -vcodec copy -acodec aac -b:a 128k -af "volume=12dB" -bsf:a aac_adtstoasc -sn -y ${target}

# Delete pipes
for ((i=0; i<$#-1; i++))
do
    rm "temp${i}"
done
exit 0
