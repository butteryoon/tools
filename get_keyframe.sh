#!/bin/bash
# DESC : mp4 파일에서 키 프레임 추출 
#
#
ffprobe -select_streams v -skip_frame nokey -show_frames $1 | grep '^pkt_pts_time' | sed 's/pkt_pts_time=//'

exit
