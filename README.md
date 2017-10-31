# home_video_conversion_recipe

* Concatenate together specified files.
--------------------------------------

I use the *concatenate.sh* to concat together MP4 container files.
```sh
concatenate.sh source#1 {source#2 ..  source#n} last_source target
#Example
./concatenate.bash 100%200410.mp4 100%200411.mp4 100%200412.mp4 100%200413.mp4 2017-10-29.m4v
```
#All MPEG codecs (H.264, MPEG4/divx/xvid, MPEG2; MP2, MP3, AAC) are supported in
#the mpegts container format, though the commands above would require some
#alteration (the `-bsf` bitstream filters will have to be changed).

* Concatenate together all files in a folder.
---------------------------------------------

I use the *concat_mts.sh* to concat together all mts container files in a source_dir.
```sh
concat_mts.sh source_dir target
```
