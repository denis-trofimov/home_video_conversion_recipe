#!/bin/bash
#Usage `basename $0` source#1 source#n target
#
#avconv -i "concat:source#1|..|source#n" -c copy -sn "/home/denis/Видео/События 2016"/1.mts"
#
#for file in /var/*
#do
    #whatever you need with "$file"
#done

if [[ ($# < 2) || ($1 == '-h') || ($1 == '--help') || ($1 == '/help') ]]
then
    echo "Usage `basename $0` source_dir target"
else
#main branch
arg=($*)
# There are ${arg[0]} .. ${arg[$#-2]} sources and one target ${arg[$#-1]}
concat=concat:
i=0
for file in ${arg[0]}/*.MTS
do
    echo $(basename $file)
    if [ $i == 0 ]
    then
        concat="concat:$(basename $file)"
    else
        concat="${concat}|$(basename $file)"
    fi
    i+=1
done
concat="${concat}"
echo avconv -y -i \"${concat}\" -c copy -sn ${arg[1]}
avconv -i ${concat} -c copy -sn -y ${arg[1]}

#end of main branch
fi
