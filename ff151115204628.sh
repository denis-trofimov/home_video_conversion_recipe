#!/bin/sh
echo -n "\033]0; Преобразование M2U01038 (1/4)\007"
/usr/bin/ffmpeg -threads 2  -y -i "/media/disk/MP_ROOT/100PNV01/M2U01038.MPG"  -deinterlace -f avi -vcodec libxvid -vtag XVID -maxrate 1800k -b 1500k -qmin 2 -qmax 31 -bufsize 4096 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -an "/home/denis/films2/M2U01038.avi"
echo -n "\033]0; Преобразование M2U01039 (2/4)\007"
/usr/bin/ffmpeg -threads 2  -y -i "/media/disk/MP_ROOT/100PNV01/M2U01039.MPG"  -deinterlace -f avi -vcodec libxvid -vtag XVID -maxrate 1800k -b 1500k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -an "/home/denis/films2/films/M2U01039.avi"
echo -n "\033]0; Преобразование M2U01040 (3/4)\007"
/usr/bin/ffmpeg -threads 2  -y -i "/media/disk/MP_ROOT/100PNV01/M2U01040.MPG"  -deinterlace -f avi -vcodec libxvid -vtag XVID -maxrate 1800k -b 1500k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -acodec libmp3lame -ar 48000   -b:a 56k -ac 2 "/home/denis/films2/films/M2U01040.avi"
echo -n "\033]0; Преобразование M2U01037 (4/4)\007"
/usr/bin/ffmpeg -threads 2  -y -i "/media/disk/MP_ROOT/100PNV01/M2U01037.MPG"  -deinterlace -f avi -vcodec libxvid -vtag XVID -maxrate 1800k -b 1500k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -acodec libmp3lame -ar 48000   -b:a 56k -ac 2 "/home/denis/films2/films/M2U01037.avi"
read -p "Нажмите Ввод для продолжения" dumbyvar
rm "/home/denis/.winff/ff151115204628.sh"
