#!/usr/bin/python
# -*- coding: UTF-8 -*-
"""
Bulk transcoding of video files using multiple cores and FFMPEG

Transcodes list of video files found by a maks specified as the first
command-line argument down a path in a recursive way in a folder
specified as the second command-line argument into standard XVID
compatible AVI video for old devices without the AVC decoder.

Actual transcoding is done via a subprocess call to ffmpeg. If multiple
cores are available, transcoding is parallelized via a pool of workers, each
of which transcodes one file at a time.
"""
import multiprocessing
import os
import signal
import subprocess
import sys
import fnmatch


def get_files_by_mask(folder, mask='*.cdr'):
    """Search files in a folder recursive way by a mask.

        :param folder: Root folder to start search files.
        :param mask: Filenames get filtered by `mask`.
        :return: List with recursive searched files in folder.

    """
    files_list = []
    for root, dirnames, filenames in os.walk(folder):
        for filename in fnmatch.filter(filenames, mask):
            files_list.append(os.path.join(root, filename))
    return files_list


def init_worker():
    signal.signal(signal.SIGINT, signal.SIG_IGN)


def worker(fileurl):
    # Print informational message
    print('process #{} is converting file: {}'.format(
            multiprocessing.current_process().name,fileurl))
    sys.stdout.flush()

    # Derive output filename
    (root, ext) = os.path.splitext(fileurl)
    outfile = root + ".avi"

    # If output file exists, break out
    if os.path.exists(outfile):
        return

    # Call out to ffmpeg
    subprocess.call(["ffmpeg", "-y", "-loglevel", "quiet", "-i", fileurl,
            "-vcodec", "libxvid", "-vtag", "XVID",  "-b:v", "6000k",
            "-deinterlace", "-acodec", "copy",  outfile])

if __name__ == '__main__':
    if(len(sys.argv) == 3):
        # Search files in a folder recursive way by a mask.
        files_list = get_files_by_mask(sys.argv[2], sys.argv[1])

        # Create a pool of workers (equal to number returned by cpu_count())
        pool = multiprocessing.Pool(initializer=init_worker)

        # Map conversion of files to pool of workers. Skip the program name itself.
        try:
            pool.map(worker, files_list)

        except KeyboardInterrupt:
            print("Caught KeyboardInterrupt, terminating")
            pool.terminate()
            pool.join()
    else:
        print(len(sys.argv))
        print("Usage: script.py *.MTS path")
