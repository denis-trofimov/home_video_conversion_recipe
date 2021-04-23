#!/bin/bash
find *.mp4 | sed 's:\ :\\\ :g'| sed 's/^/file /' > list.txt; 
ffmpeg -f concat -i list.txt -c copy output.mp4;
rm list.txt
