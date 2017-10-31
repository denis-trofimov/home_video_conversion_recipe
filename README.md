# home_video_conversion_recipe

* I use the *concatenate.sh* to concat together MP4 container files.
```
#Usage concatenate.sh source#1 {source#2 ..  source#n} last_source target
```
#All MPEG codecs (H.264, MPEG4/divx/xvid, MPEG2; MP2, MP3, AAC) are supported in
#the mpegts container format, though the commands above would require some
#alteration (the `-bsf` bitstream filters will have to be changed).

* I use the *concat_mts.sh* to concat together all mts container files in a source_dir.
```
Usage concat_mts.sh source_dir target
```
