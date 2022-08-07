#!/usr/bin/env bash
#=== Concat protocol ===#protocol

#While the demuxer works at the stream level, the concat protocol works at the
#file level. Certain files (mpg and mpeg transport streams, possibly others) can
#be concatenated. This is analogous to using cat on UNIX-like systems or copy on
#Windows.

#==== Instructions ====

#{{{
#ffmpeg -i "concat:input1.mpg|input2.mpg|input3.mpg" -c copy output.mpg
#}}}

#If you have MP4 files, these could be losslessly concatenated by first
#transcoding them to mpeg transport streams. With h.264 video and AAC audio, the
#following can be used:

#{{{
#ffmpeg -i input1.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate1.ts
#ffmpeg -i input2.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate2.ts
#ffmpeg -i "concat:intermediate1.ts|intermediate2.ts" -c copy -bsf:a aac_adtstoasc output.mp4
#}}}

#If you're using a system that supports named pipes, you can use those to avoid
#creating intermediate files - this sends stderr (which ffmpeg sends all the
#written data to) to /dev/null, to avoid cluttering up the command-line:

#{{{
#mkfifo temp1 temp2
#ffmpeg -i input1.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp1 2> /dev/null & \
#ffmpeg -i input2.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp2 2> /dev/null & \
#ffmpeg -f mpegts -i "concat:temp1|temp2" -c copy -bsf:a aac_adtstoasc output.mp4
#}}}

#All MPEG codecs (H.264, MPEG4/divx/xvid, MPEG2; MP2, MP3, AAC) are supported in
#the mpegts container format, though the commands above would require some
#alteration (the `-bsf` bitstream filters will have to be changed).

if [[ ($# < 3) || ($1 == '-h') || ($1 == '--help') || ($1 == '/help') ]]
then
    echo "Usage `basename $0` source#1 {source#2 ..  source#n} last_source target"
    exit 22  # EINVAL   /* Invalid argument */
fi

arg=($*)
# There are ${arg[0]} .. ${arg[$#-2]} sources and one target ${arg[$#-1]}
concat="concat:"
for ((i=0; i<$#-1; i++))
do
    echo "${arg[${i}]}"
    if [ ${i} == 0 ]
    then
        concat="${concat}temp${i}"
    else
        concat="${concat}|temp${i}"
    fi
    #use named pipes to avoid creating intermediate files#
    mkfifo temp${i}
    (ffmpeg -y -i "${arg[$i]}" -c copy -bsf:v h264_mp4toannexb -f mpegts temp${i} 2> /dev/null &)
done

ffmpeg -v verbose -y -f mpegts -i "${concat}" -c copy -bsf:a aac_adtstoasc -movflags faststart ${arg[$#-1]}

#Delete pipes
for ((i=0; i<$#-1; i++))
do
    rm temp${i}
done
