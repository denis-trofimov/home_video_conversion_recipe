#!/bin/sh
echo -n "\033]0; Преобразование M2U00409 (1/4)\007"
/usr/bin/ffmpeg -threads 2  -y -i "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00409.MPG"  -deinterlace -f avi -vcodec libxvid -vtag XVID -maxrate 2300k -b 2000k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -acodec copy -passlogfile "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00409.log" -pass 2  "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00409.avi"
echo -n "\033]0; Преобразование M2U00410 (2/4)\007"
/usr/bin/ffmpeg -threads 2  -y -i "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00410.MPG"  -deinterlace -f avi -vcodec libxvid -vtag XVID -maxrate 2300k -b 2000k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -acodec copy -passlogfile "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00410.log" -pass 2  "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00410.avi"
echo -n "\033]0; Преобразование M2U00411 (3/4)\007"
/usr/bin/ffmpeg -threads 2  -y -i "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00411.MPG"  -deinterlace -f avi -vcodec libxvid -vtag XVID -maxrate 2300k -b 2000k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -acodec copy -passlogfile "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00411.log" -pass 2  "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00411.avi"
echo -n "\033]0; Преобразование M2U00412 (4/4)\007"
/usr/bin/ffmpeg -threads 2  -y -i "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00412.MPG"  -deinterlace -f avi -vcodec libxvid -vtag XVID -maxrate 2300k -b 2000k -qmin 2 -qmax 31 -bufsize 4096 -mbd 2 -bf 2 -trellis 1 -flags +aic -cmp 2 -subcmp 2 -g 300 -acodec copy -passlogfile "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00412.log" -pass 2  "/home/denis/films2/20150201 Презентация Михаила Морозова/M2U00412.avi"
read -p "Нажмите Ввод для продолжения" dumbyvar
rm "/home/denis/.winff/ff150426232358.sh"
