#!/usr/bin/env bash #lends you some flexibility on different systems
# Usage `basename $0` source#1 {source#2 ..  source#n} last_source target

if [[ ($# < 3) || ($1 == '-h') || ($1 == '--help') || ($1 == '/help') ]]
then
    echo "Usage `basename $0` source#1 {source#2 ..  source#n} last_source target"
else
# main branch
arg=($*)
# There are ${arg[0]} .. ${arg[$#-2]} sources and one target ${arg[$#-1]}
concat=concat:
for ((i=0; i<$#-1; i++))
do
    echo ${arg[${i}]}
    if [ ${i} == 0 ]
    then
        concat="${concat}temp${i}"
    else
        concat="${concat}|temp${i}"
    fi
    # use named pipes to avoid creating intermediate files
    mkfifo temp${i}
    (ffmpeg -y -i ${arg[$i]} -codec copy -bsf:v h264_mp4toannexb -f mpegts temp${i} 2> /dev/null &)
done
concat="${concat}"
ffmpeg -v verbose -y -f mpegts -i ${concat} -vcodec copy -acodec aac -b:a 128k -af "volume=12dB" -bsf:a aac_adtstoasc ${arg[$#-1]}

# Delete pipes
for ((i=0; i<$#-1; i++))
do
    rm temp${i}
done
# end of main branch
fi
